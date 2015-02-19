require 'rails_helper'
require "cancan/matchers"

include Devise::TestHelpers

RSpec.describe Ability, :type => :model do

  let(:user){ nil }
  let(:admin){ FactoryGirl.create(:admin) }
  let(:category){ FactoryGirl.create(:category) }
  let(:location){ FactoryGirl.create(:location) }
  let(:event){ FactoryGirl.create(:event) }
  
  subject(:ability){ Ability.new(user) }

  context "when role is user" do
    let(:user){ FactoryGirl.create(:user) }

    it{ should have_abilities([:create, :read], User) }
    it{ should have_abilities(:update, user) }
    it{ should not_have_abilities(:destroy, user) }
    it{ should have_abilities(:read, category) }
    it{ should have_abilities(:read, location) }
    it{ should have_abilities(:read, event) }
    it{ should not_have_abilities([:manage, :create, :update, :destroy], Category) }
    it{ should not_have_abilities([:manage, :create, :update, :destroy], Location) }
    it{ should not_have_abilities([:manage, :create, :update, :destroy], Event) }
  end

  context "when role is admin" do
    let(:user){ FactoryGirl.create(:admin) }

    it{ should have_abilities([:create, :update, :read], User) }
    it{ should not_have_abilities(:destroy, user) }
    it{ should not_have_abilities([:create, :update, :destroy], admin) }
    it{ should not_have_abilities(:manage, category) }
    it{ should have_abilities(:manage, location) }
    it{ should have_abilities(:manage, event) }
  end

  context "when role is super_admin" do
    let(:user){ FactoryGirl.create(:super_admin) }

    it{ should have_abilities(:manage, User) }
    it{ should have_abilities(:manage, Category) }
    it{ should have_abilities(:manage, Location) }
    it{ should have_abilities(:manage, Event) }
    it{ should not_have_abilities(:destroy, user) }
  end
 
end