Gem::Specification.new do |s|
  s.author = 'Matthew Higgins'
  s.files = ['lib/nhs_number_validator.rb']
  s.name = 'nhs_number_validator'
  s.summary = 'A validator for UK NHS numbers'
  s.description = 'A simple ActiveRecord validator based on the NHS Number specifications for healthcare providers in the UK.'
  s.license = 'MIT'
  s.homepage = 'https://github.com/mtthwhggns/nhs_number_validator'
  s.version = '1.0.1'
  s.add_dependency "activemodel"
  s.add_development_dependency "rspec"
  s.email = 'oss@matthewhiggins.me'
end
