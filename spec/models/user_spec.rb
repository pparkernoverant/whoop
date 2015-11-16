require 'spec_helper'

describe User do
  # db relationships
  it { should have_many :reviews }

  # validation: email
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  # validation: username
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username}

  # validation: password
  it { should validate_presence_of :password }
end