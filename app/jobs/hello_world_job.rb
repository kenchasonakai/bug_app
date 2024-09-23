class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Post.create(title: Time.now.to_s, content: "Hello World", user_id: 1)
  end
end
