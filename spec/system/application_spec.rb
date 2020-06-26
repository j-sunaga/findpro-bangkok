require 'rails_helper'

RSpec.describe '応募機能', type: :system do
  let!(:applicant) { create(:applicant) }
  let!(:post) { create(:post) }
  describe '一覧機能#index' do
    let!(:application) { create(:application, post: post, user: applicant) }
    context '応募ユーザ(applicant)の場合' do
      it '応募一覧画面に表示される' do
        act_as applicant do
          visit applications_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
  end
  describe '応募機能#create' do
    context '応募ユーザ(applicant)の場合' do
      it '応募後に応募一覧画面に表示される' do
        act_as applicant do
          visit post_path(post)
          click_on 'Apply'
          visit applications_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
    context '投稿ユーザ(recruiter)の場合' do
      let!(:recruiter) { create(:recruiter) }
      it '応募ボタンが投稿詳細画面に表示されない' do
        act_as recruiter do
          visit post_path(post)
          expect(page).to_not have_content 'Apply'
        end
      end
    end
    context 'postのステータスがclosedの場合' do
      let!(:post_closed) { create(:post, status: :closed) }
      it '応募ボタンが投稿詳細画面に表示されない' do
        act_as applicant do
          visit post_path(post_closed)
          expect(page).to_not have_content 'Apply'
        end
      end
    end
  end
  describe '応募解除機能#destroy' do
    context '投稿詳細画面から応募解除ボタンを押した場合' do
      it '応募一覧画面に表示されない' do
        act_as applicant do
          visit post_path(post)
          click_on 'Apply'
          click_on 'un-Apply'
          visit applications_path
          expect(page).to_not have_content post.title.to_s
        end
      end
    end
  end
end
