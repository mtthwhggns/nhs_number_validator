Quickly and simply add validation of NHS numbers to a Rails ActiveRecord model, or anywhere in Ruby using a simple-to-use class.

[![Build Status](https://travis-ci.org/mtthwhggns/nhs_number_validator.svg)](https://travis-ci.org/mtthwhggns/nhs_number_validator)[![Gem Version](https://badge.fury.io/rb/nhs_number_validator.svg)](http://badge.fury.io/rb/nhs_number_validator)

## Usage

Install the Gem by adding the following line to your `Gemfile`

    gem 'nhs_number_validator'

Then run `bundle install` to install the Gem.

Now, in your model, which might be something like `app/models/patient.rb`, add the line;

    validates :nhs_number, nhs_number: true

The first `:nhs_number` in this example is the name of your database column, the second tells Rails to validate it against this validator.

The format of these columns should be a 10-character string, where all characters are numerical. Values will validate if an integer is given, but otherwise, no alternatives will be accepted.

By default, nil and blank values will be rejected. If you want to accept nil and blank values, please use `accept_blank: true`, as follows;

    validates :nhs_number, nhs_number: true, accept_blank: true

## Calling the Class

If you ever need to use this outside of a model, you can pass the string (or an integer) directly to;

    NhsNumberValidator.valid?("4010232137")
    # => true
    NhsNumberValidator.valid?("4010232132")
    # => false
    NhsNumberValidator.valid?("watermelon")
    # => false

## Background

The actual process of validating an NHS number is beyond a simple format check, and involves calculating a check digit using a Modulus 11 algorithm. This has apparently been shown to dramatically reduce typing errors. For more information, please see [Wikipedia](http://en.wikipedia.org/wiki/NHS_number) and for a more detailed description of the algorithm, see [the NHS Data Dictionary](http://www.datadictionary.nhs.uk/data_dictionary/attributes/n/nhs/nhs_number_de.asp?shownav=1).
