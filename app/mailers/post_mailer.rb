class PostMailer < ActionMailer::Base

  def post_created(admin_user, post)

    @admin_user = admin_user
    @post = post

    mail( to: admin_user.email,
          from: "suman@instarter.com",
          subject: "New Post Submitted",
        )
  end
end
