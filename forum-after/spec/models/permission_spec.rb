require "spec_helper"

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

RSpec::Matchers.define :allow_param do |*args|
  match do |permission|
    permission.allow_param?(*args).should be_true
  end
end

describe Permission do
  describe "as guest" do
    subject { Permission.new(nil) }
    
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
  
  describe "as admin" do
    subject { Permission.new(build(:user, admin: true)) }
    
    it "allows anything" do
      should allow(:anything, :here)
      should allow_param(:anything, :here)
    end
  end
  
  describe "as member" do
    let(:user) { create(:user, admin: false) }
    let(:user_topic) { build(:topic, user: user) }
    let(:other_topic) { build(:topic) }
    subject { Permission.new(user) }
    
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
end
