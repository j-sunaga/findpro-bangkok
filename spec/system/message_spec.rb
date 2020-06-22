require 'rails_helper'

RSpec.describe 'メッセージ機能', type: :system do
  let!(:sender) { create(:applicant) }
  let!(:recipient) { create(:recruiter) }
  let!(:conversation) { create(:conversation, sender: sender, recipient: recipient) }
  describe '一覧機能#index' do
    let!(:message) { create(:message, conversation: conversation, user: sender) }
    context '画面にアクセスした場合' do
      it 'メッセージが表示される' do
        act_as sender do
          visit conversation_messages_path(conversation)
          expect(page).to have_content message.body
        end
      end
    end
  end
  describe '投稿機能#create' do
    context '投稿した場合' do
      it 'メッセージ一覧画面に表示される' do
        act_as sender do
          visit conversation_messages_path(conversation)
          fill_in 'message[body]', with: 'Example_Message'
          click_button 'Send Message'
          expect(page).to have_content 'Example_Message'
        end
      end
      it '受信者のメッセージ一覧画面に表示される' do
        act_as sender do
          visit conversation_messages_path(conversation)
          fill_in 'message[body]', with: 'Example_Message'
          click_button 'Send Message'
          expect(page).to have_content 'Example_Message'
        end
        act_as recipient do
          visit conversation_messages_path(conversation)
          expect(page).to have_content 'Example_Message'
        end
      end
    end
  end
end
