require 'spec_helper'

describe Business do
  # db relationships
  it { should have_many :reviews }

  # validation: name
  it { should validate_presence_of :name }
end