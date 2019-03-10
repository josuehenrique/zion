namespace :db do
  def run_annotate_after_migration
    if Rails.env == 'development'
      system('annotate --show-indexes --exclude tests,fixtures,factories,serializers --show-foreign-keys')
    end
  end

  Rake::Task['db:migrate'].enhance do
    run_annotate_after_migration
  end
end
