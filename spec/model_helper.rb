require 'unit_helper'

# ActiveRecord
require 'active_record'

spec = YAML.load(ERB.new(File.read('config/database.yml')).result)
ActiveRecord::Base.establish_connection(spec['test'])

require 'protected_attributes'

# ActiveRecord::Attributes
require 'lib/active_record/list_attributes'
require 'lib/active_record/search_attributes'
require 'lib/active_record/orderize'
require 'lib/active_record/filterize'

class ActiveRecord::Base
  include ActiveRecord::ListAttributes
  include ActiveRecord::SearchAttributes
  include ActiveRecord::Orderize
  include ActiveRecord::Filterize
end

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration[4.2].maintain_test_schema!

# Paperclip
require 'paperclip'

# Devise
require 'devise'
require 'devise/orm/active_record'

require 'validators'
require 'cpf_cnpj'
require 'brstring'

# I18n::Alchemy
require 'i18n_alchemy'

class ActiveRecord::Base
  include I18n::Alchemy
end

# Shoulda Matchers
require 'shoulda/matchers'
require 'shoulda-callback-matchers'

# Require support models
Dir['spec/support/models/*.rb'].each { |f| require f }
