Paperclip::Attachment.default_options[:path] = "spec/test_files/:class/:id_partition/:style.:extension"

RSpec.configure do |config|
  require 'paperclip/matchers'
  config.include Paperclip::Shoulda::Matchers
  config.after(:suite) { FileUtils.rm_rf(Dir["spec/test_files/"]) }
  include Paperclip::Glue
end
