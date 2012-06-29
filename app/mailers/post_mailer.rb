class PostMailer < ActionMailer::Base
  default from: "info@condomotion.com"

  def new_document(post)
    @greeting = "Greetings from Condo Motion"
    @post = post

    mail(:bcc => post.site.members.all.map(&:email),
         :to => "info@condomotion.com",
         :subject => "New #{post.post_type} Post!")
  end
end
