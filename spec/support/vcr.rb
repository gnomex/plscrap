require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end
