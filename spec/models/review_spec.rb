require 'spec_helper'

describe Review do
  # db relationships
  it { should belong_to :user }
  it { should belong_to :business }

  # validation: rating
  it { should validate_presence_of :rating }
  it { should validate_presence_of :business_id }
  it { should validate_presence_of :user_id }
end