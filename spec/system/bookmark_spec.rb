require 'rails_helper'

RSpec.describe 'ブックマーク機能', type: :system do
  let!(:applicant) { create(:applicant) }
  let!(:post) { create(:post) }
  describe 'ブックマーク一覧機能#index' do
    let!(:bookmark) { create(:bookmark, post: post, user: applicant) }
    context '応募ユーザ(applicant)の場合' do
      it 'ブックマーク一覧画面に表示される' do
        act_as applicant do
          visit bookmarks_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
  end
  describe 'ブックマーク登録機能#create' do
    context '応募ユーザ(applicant)の場合' do
      it 'ブックマーク一覧画面に表示される' do
        act_as applicant do
          visit post_path(post)
          click_on 'bookmark'
          visit bookmarks_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
    context '投稿ユーザ(recruiter)の場合' do
      let!(:recruiter) { create(:recruiter) }
      it 'ブックマークボタンが投稿詳細画面に表示されない' do
        act_as recruiter do
          visit post_path(post)
          expect(page).to_not have_content 'bookmark'
        end
      end
    end
    context 'postのステータスがclosedの場合' do
      let!(:post_closed) { create(:post, status: :closed) }
      it 'ブックマークボタンが投稿詳細画面に表示されない' do
        act_as applicant do
          visit post_path(post_closed)
          expect(page).to_not have_content 'bookmark'
        end
      end
    end
  end
  describe 'ブックマーク解除機能#destroy' do
    context '投稿詳細画面からブックマーク解除ボタンを押した場合' do
      it 'ブックマーク一覧画面に表示されない' do
        act_as applicant do
          visit post_path(post)
          click_on 'bookmark'
          click_on 'unbookmark'
          visit bookmarks_path
          expect(page).to_not have_content post.title.to_s
        end
      end
    end
    context 'ブックマーク一覧画面からブックマーク解除ボタンを押した場合' do
      it 'ブックマーク一覧画面に表示されない' do
        act_as applicant do
          visit post_path(post)
          click_on 'bookmark'
          visit bookmarks_path
          click_on 'unbookmark'
          expect(page).to_not have_content post.title.to_s
        end
      end
    end
  end
end
