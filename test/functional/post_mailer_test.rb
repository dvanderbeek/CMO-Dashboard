require 'test_helper'

class PostMailerTest < ActionMailer::TestCase
  test "new_document" do
    mail = PostMailer.new_document
    assert_equal "New document", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
