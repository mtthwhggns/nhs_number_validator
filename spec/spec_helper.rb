require 'rubygems'
require 'rspec'
require 'active_model'

require 'nhs_number_validator'

class PatientModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end
