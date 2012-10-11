require "spec_helper"

describe Permissions::MemberPermission do
  let(:user) { create(:user, admin: false) }
  let(:user_topic) { build(:topic, user: user) }
  let(:other_topic) { build(:topic) }
  subject { Permissions.permission_for(user) }
  
  it "allows topics" do
    should allow(:topics, :index)
    should allow(:topics, :show)
    should allow(:topics, :new)
    should allow(:topics, :create)
    should_not allow(:topics, :edit)
    should_not allow(:topics, :update)
    should_not allow(:topics, :edit, other_topic)
    should_not allow(:topics, :update, other_topic)
    should allow(:topics, :edit, user_topic)
    should allow(:topics, :update, user_topic)
    should_not allow(:topics, :destroy)
    should allow_param(:topic, :name)
    should_not allow_param(:topic, :sticky)
  end
  
  it "allows sessions" do
    should allow(:sessions, :new)
    should allow(:sessions, :create)
    should allow(:sessions, :destroy)
  end

  it "allows users" do
    should allow(:users, :new)
    should allow(:users, :create)
    should allow(:users, :edit)
    should allow(:users, :update)
  end
end
