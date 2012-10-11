require "spec_helper"

describe Permissions::GuestPermission do
  subject { Permissions.permission_for(nil) }
  
  it "allows topics" do
    should allow(:topics, :index)
    should allow(:topics, :show)
    should_not allow(:topics, :new)
    should_not allow(:topics, :create)
    should_not allow(:topics, :edit)
    should_not allow(:topics, :update)
    should_not allow(:topics, :destroy)
  end

  it "allows sessions" do
    should allow(:sessions, :new)
    should allow(:sessions, :create)
    should allow(:sessions, :destroy)
  end

  it "allows users" do
    should allow(:users, :new)
    should allow(:users, :create)
    should_not allow(:users, :edit)
    should_not allow(:users, :update)
  end
end
