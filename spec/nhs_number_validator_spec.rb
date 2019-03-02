require 'spec_helper'

class TestPatient < PatientModel
  validates :nhs_number, nhs_number: true
end

class TestPatientAllowedBlank < PatientModel
  validates :nhs_number, nhs_number: { allow_blank: true }
end

class TestPatientNotAllowedBlank < PatientModel
  validates :nhs_number, nhs_number: { allow_blank: false }
end

class TestPatientWithMessage < PatientModel
  validates :nhs_number, nhs_number: { message: 'is the problem' }
end

describe NhsNumberValidator do
  describe 'validation' do
    context 'given the valid NHS numbers' do
      %w(9434765919 9434765870 9434765919 4012032135).each do |n|
        it "#{n} should result in a valid record" do
          expect(TestPatient.new(nhs_number: n.to_s)).to be_valid
        end
        it "#{n} should pass the class test" do
          expect(NhsNumberValidator.valid?(n.to_s)).to be_truthy
        end
      end
    end
    context 'given the invalid NHS numbers' do
      %w(9434765918 9434765875 9434765916 4012032132 1111111111 9999999999).each do |n|
        it "#{n} should result in an invalid record" do
          expect(TestPatient.new(nhs_number: n.to_s)).not_to be_valid
        end
        it "#{n} should not pass the class test" do
          expect(NhsNumberValidator.valid?(n.to_s)).not_to be_truthy
        end
      end
    end
  end

  describe 'error messages' do
    context 'when the message is not defined' do
      subject { TestPatient.new(nhs_number: '9434765918') }
      before { subject.valid? }

      it 'should add the default message' do
        expect(subject.errors[:nhs_number]).to include 'is invalid'
      end
    end

    context 'when the message is defined' do
      subject { TestPatientWithMessage.new(nhs_number: '9434765918') }
      before { subject.valid? }

      it 'should add the defined message' do
        expect(subject.errors[:nhs_number]).to include 'is the problem'
      end
    end
  end

  describe 'nil NHS number' do
    it 'should not be valid when :allow_blank is not set' do
      expect(TestPatient.new(nhs_number: nil)).not_to be_valid
    end
    it 'should be valid when :allow_blank is set to true' do
      expect(TestPatientAllowedBlank.new(nhs_number: nil)).to be_valid
    end
    it 'should not be valid when :allow_blank is set to false' do
      expect(TestPatientNotAllowedBlank.new(nhs_number: nil)).not_to be_valid
    end
  end
end
