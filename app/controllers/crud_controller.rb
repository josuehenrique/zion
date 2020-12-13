class CrudController < ApplicationController
  inherit_resources
  before_action :authorize_resource!

  respond_to :js, :json

  has_scope :page, default: 1, only: [:index, :modal], unless: :disable_pagination?
  has_scope :per_page, default: 10, only: [:index, :modal], unless: :disable_pagination?

  before_action :check_resource_is_active, only: [:update, :edit]

  def index(options={}, &block)
    params[:page] = 'all' if params[:select_id].present? || formats.include?(:xls)
    params[:search] ||= {}
    build_resource

    respond_to do |format|
      format.html { super }
      format.js { super }
      format.all { super }
    end
  end

  def create
    create! do |success, failure|
      success.html { redirect_to resource_path(search: params[:search]) }
      failure.html { render :new }
    end
  end

  def update
    update! do |success, failure|
    success.html { redirect_to resource_path(search: params[:search]) }
    failure.html {
      flash[:alert] = resource.errors.full_messages
      render :edit
    }
    end
  end

  def destroy
    destroy! do |_, failure|
      failure.html { redirect_to collection_path }
    end
  end

  def activate
    activate!
  end

  def inactivate
    inactivate!
  end

  protected

  def smart_resource_path
    path = nil
    if respond_to? :show
      path = resource_path rescue nil
    end
    path ||= smart_collection_path
  end

  helper_method :smart_resource_path

  def smart_collection_path
    path = nil
    if respond_to? :index
      path ||= collection_path(search: params[:search], page: params[:page]) rescue nil
    end
    if respond_to? :parent
      path ||= parent_path(search: params[:search], page: params[:page]) rescue nil
    end
    path ||= root_path rescue nil
  end

  helper_method :smart_collection_path

  # Build resource using I18n::Alchemy
  def build_resource
    get_resource_ivar || set_resource_ivar(effectively_build_resource)
  end

  # Effectively build resource using I18n::Alchemy
  def effectively_build_resource
    end_of_association_chain.send(method_for_build).tap do |object|
      object.localized.assign_attributes(*resource_params)
    end
  end

  # Update resource using I18n::Alchemy
  def update_resource(object, attributes)
    object.localized.update_attributes(*attributes)
  end

  # Get collection using ordered scope
  def collection
    if params[:search].present?
      get_collection_ivar || set_collection_ivar(searcher)
    else
      return [] if params[:term].blank? && resource_class.force_search?

      get_collection_ivar || set_collection_ivar(collection_records)
    end
  end

  def collection_records
    if resource_class.respond_to?(:active_filter)
      apply_scopes end_of_association_chain.active_filter(params[:active] || true)
    else
      apply_scopes end_of_association_chain
    end
  end

  def searcher
    apply_scopes resource_class.searcher_class.search(
      resource_class,
      search_params.merge(
        page: params[:page],
        records: collection_records
      )
    )
  end

  def search_params
    params[:search]
  end

  def disable_pagination?
    params[:page] == 'all'
  end

  def can_not_edit
    redirect_to(collection_path, alert: (t 'activerecord.errors.messages.can_not_edit'))
  end

  def can_not_delete
    redirect_to(collection_path, alert: (t 'activerecord.errors.messages.can_not_delete'))
  end


  protected

  def inactivate!(redirect_params = {}, &block)
    if resource.respond_to?(:active)
      resource.active = false
    else
      resource.active = false
    end

    if resource.save
      block.call if block_given?
      redirect_to collection_path(redirect_params), notice: t('messages.inactivated')
    else
      redirect_to collection_path(redirect_params), alert: resource.errors.messages[:base]
    end
  end

  def activate!(redirect_params = {}, &block)
    if resource.respond_to?(:active)
      resource.active = true
    else
      resource.active = true
    end

    if resource.save
      block.call if block_given?
      redirect_to collection_path(redirect_params), notice: t('messages.activated')
    else
      redirect_to collection_path(redirect_params), alert: t('messages.cant_be_activated')
    end
  end

  def check_resource_is_active
    if resource_class.respond_to?(:active_filter) && !resource.active?
      redirect_to collection_path,
                  alert: t('messages.inactive_resource_should_not_be_modified',
                           resource_name: resource_class.model_name.human,
                           resource: resource.to_s)
    end
  end
end
