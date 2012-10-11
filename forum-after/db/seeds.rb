t = Topic.create! name: "Looking Forward to Rails 4.0", sticky: false
t.posts.create! content: "Rails 4.0 will be great!"
t.posts.create! content: "Yes, I can't wait"

t = Topic.create! name: "Anyone tried strong_parameters?", sticky: false
t.posts.create! content: "This plugin looks useful"
t.posts.create! content: "It will be in Rails 4.0 likely"
t.posts.create! content: "That's good to know!"

t = Topic.create! name: "Authorization can be tricky", sticky: false
t.posts.create! content: "How do we test so many branching possibilties?"
t.posts.create! content: "Move it into a model!"

t = Topic.create! name: "Frequently Asked Questions", sticky: true
t.posts.create! content: "This is a sticky topic"

User.create! email: "foo@example.com", password: "secret"
