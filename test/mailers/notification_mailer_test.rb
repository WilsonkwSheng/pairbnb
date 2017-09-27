require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  tests NotificationMailer

  test "notification_email" do

    expected = new_mail
    expected.from    = 'wilson0809@gmail.com'
    expected.to      = 'somelist@postbox.tut'
    expected.subject = "New Notification"
    expected.date    = Time.now

    actual = nil
    assert_nothing_raised { actual = NotificationMailer.notification_mailer(@recipient) }
    assert_not_nil actual

    expected.message_id = '<123@456>'
    actual.message_id = '<123@456>'

    assert_equal expected.encoded, actual.encoded

   end
end
