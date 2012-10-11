require 'spec_helper'

describe "Topic request" do
  it "lists topics as guest" do
    create(:topic, name: "Hello")
    create(:topic, name: "World")
    visit topics_path
    page.should have_content("Hello")
    page.should have_content("World")
  end

  it "creates topic as member" do
    log_in admin: false
    visit topics_path
    click_on "New Topic"
    fill_in "Name", with: "Foobar"
    click_on "Create Topic"
    page.should have_content("Created topic")
    page.should have_content("Foobar")
  end

  it "updates topic as admin" do
    create(:topic, name: "Old Name")
    log_in admin: true
    visit topics_path
    page.should have_content("Old Name")
    click_on "Edit"
    fill_in "Name", with: "New Name"
    click_on "Update Topic"
    page.should have_content("Updated topic")
    page.should have_content("New Name")
    page.should_not have_content("Old Name")
  end
  
  it "destroys topic as admin" do
    create(:topic, name: "Oops")
    log_in admin: true
    visit topics_path
    page.should have_content("Oops")
    click_on "Destroy"
    page.should have_content("Destroyed topic")
    page.should_not have_content("Oops")
  end
  
  it "cannot edit topic as guest" do
    topic = create(:topic)
    visit edit_topic_path(topic)
    page.should have_content("Not authorized")
  end
  
  it "edits own topic as member" do
    log_in admin: false
    topic = create(:topic, user: current_user)
    visit edit_topic_path(topic)
    page.should_not have_content("Not authorized")
  end
  
  it "cannot create sticky topic as member" do
    user = create(:user, admin: false, password: "secret")
    post sessions_path, email: user.email, password: "secret"
    post topics_path, topic: {name: "Sticky Topic?", sticky: "1"}
    topic = Topic.last
    topic.name.should eq("Sticky Topic?")
    topic.should_not be_sticky
  end
end
