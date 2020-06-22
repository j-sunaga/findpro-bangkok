require 'rails_helper'

RSpec.describe '会話機能', type: :system do
  let!(:sender) { create(:applicant) }
  let!(:recipient) { create(:recruiter) }
  let!(:conversation) { create(:conversation, sender: sender, recipient: recipient) }
  describe '一覧機能#index' do
    context 'sederで会話一覧にアクセスした場合' do
      it 'recipientが表示される' do
        act_as sender do
          visit conversations_path
          expect(page).to have_content recipient.name
        end
      end
    end
    context 'recipientで会話一覧にアクセスした場合' do
      it 'senderが表示される' do
        act_as recipient do
          visit conversations_path
          expect(page).to have_content sender.name
        end
      end
    end
  end
  describe '会話開始機能#create' do
    context 'messageボタンを押した場合' do
      it '会話一覧画面に表示される' do
        act_as sender do
          visit user_path(recipient)
          click_button 'Send Message'
          visit conversations_path
          expect(page).to have_content recipient.name
        end
      end
    end
  end
end
