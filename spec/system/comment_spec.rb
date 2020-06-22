require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let!(:applicant) { create(:applicant) }
  let!(:post) { create(:post) }
  describe '一覧機能#index' do
    let!(:comment) { create(:comment, user: applicant, post: post) }
    context '投稿詳細画面にアクセスした場合' do
      it 'コメントが表示される' do
        act_as applicant do
          visit post_path(post)
          expect(page).to have_content comment.content.to_s
        end
      end
    end
  end
  describe 'コメント投稿機能#create' do
    context 'フォームから投稿した場合' do
      it 'コメント一覧画面に表示される' do
        act_as applicant do
          visit post_path(post)
          fill_in 'comment[content]', with: 'Example_Comment'
          click_button 'Create Comment'
          expect(page).to have_content 'Example_Comment'
        end
      end
    end
  end
  describe 'コメント削除機能#destroy' do
    let!(:comment) { create(:comment, user: applicant, post: post) }
    context 'コメント投稿者でない場合' do
      it '削除ボタンが表示されない' do
        act_as post.recruiter do
          visit post_path(post)
          expect(page).to_not have_content 'delete'
        end
      end
    end
    context 'コメント投稿者がdeleteをした場合' do
      it '一覧画面に表示されない' do
        act_as applicant do
          visit post_path(post)
          click_on 'delete'
          page.accept_confirm 'really delete?'
          visit post_path(post)
          expect(page).to_not have_content comment.content.to_s
        end
      end
    end
  end
end
