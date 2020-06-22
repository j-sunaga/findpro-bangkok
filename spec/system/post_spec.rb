require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:applicant) { create(:applicant) }
  let!(:recruiter) { create(:recruiter) }
  let!(:post) { create(:post, recruiter: recruiter) }

  describe '投稿一覧機能#index' do
    context '投稿を作成した場合' do
      it '作成済みの投稿が表示される' do
        act_as applicant do
          visit posts_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
    context '複数の投稿を作成した場合' do
      let!(:new_post) { create(:post, title: 'new_post', deadline: DateTime.now) }
      let!(:closed_post) { create(:post, title: 'closed_post', status: 'closed') }
      it '投稿が募集期限の近い順に並んでいる' do
        act_as applicant do
          visit posts_path
          post_list = all('.post_title')
          expect(post_list[0]).to have_content 'new_post'
          expect(post_list[1]).to have_content post.title.to_s
        end
      end
      it 'ステータスがオープンの順に並んでいる' do
        act_as applicant do
          visit posts_path
          post_list = all('.post_title')
          expect(post_list[0]).to have_content new_post.title.to_s
          expect(post_list[1]).to have_content post.title.to_s
          expect(post_list[2]).to have_content closed_post.title.to_s
        end
      end
    end
    context '検索をした場合' do
      let!(:posts) { create_list(:post, 2) }
      it 'タイトルで検索できる' do
        act_as applicant do
          visit posts_path
          fill_in 'q[title_or_detail_cont]', with: posts[0].title.to_s
          click_button 'Search'
          expect(page).to have_content posts[0].title.to_s
          expect(page).to_not have_content posts[1].title.to_s
        end
      end
      it 'カテゴリで検索できる' do
        act_as applicant do
          visit posts_path
          select posts[0].categories.first.name.to_s, from: 'category'
          click_button 'Search'
          expect(page).to have_content posts[0].title.to_s
          expect(page).to_not have_content posts[1].title.to_s
        end
      end
      it 'タイトル名とカテゴリで検索できる' do
        act_as applicant do
          visit posts_path
          fill_in 'q[title_or_detail_cont]', with: posts[0].title.to_s
          select posts[0].categories.first.name.to_s, from: 'category'
          click_button 'Search'
          expect(page).to have_content posts[0].title.to_s
          expect(page).to_not have_content posts[1].title.to_s
        end
      end
    end
  end
  describe '投稿機能#create' do
    context '必要項目を入力した場合' do
      it 'データが保存される' do
        act_as recruiter do
          visit new_post_path
          fill_in 'post[title]', with: 'Example_Post'
          fill_in 'post[detail]', with: 'Example_Detail'
          fill_in 'post[deadline]',	with: DateTime.now.strftime('20%y-%m-%d')
          click_button 'Submit'
          expect(page).to have_content 'Example_Detail'
        end
      end
    end
  end
  describe '自身の投稿一覧#myposts' do
    context '投稿ユーザ(recruiter)かつ投稿者の場合' do
      it '投稿データが表示される' do
        act_as recruiter do
          visit myposts_posts_path
          expect(page).to have_content post.title.to_s
        end
      end
    end
    context '投稿ユーザ(recruiter)だが異なるユーザの場合' do
      let!(:recruiter2) { create(:recruiter) }
      it '投稿データが表示されない' do
        act_as recruiter2 do
          visit myposts_posts_path
          expect(page).to_not have_content post.title.to_s
        end
      end
    end
  end
  describe '担当者選択機能#select_user' do
    context '投稿ユーザ(recruiter)がAssignボタンを押した時' do
      let!(:application) { create(:application, post: post, user: applicant) }
      it '応募ユーザリストにAssignedが表示される' do
        act_as recruiter do
          visit application_users_post_path(post)
          click_on 'Assign'
          expect(page).to have_content 'Assigned'
        end
      end
      it '投稿詳細に選ばれたユーザ名が表示される' do
        act_as recruiter do
          visit application_users_post_path(post)
          click_on 'Assign'
          visit post_path(post)
          expect(page).to have_content applicant.name.to_s
        end
      end
      it '投稿がclosedになる' do
        act_as recruiter do
          visit application_users_post_path(post)
          click_on 'Assign'
          visit post_path(post)
          expect(page).to have_content 'closed'
        end
      end
      it '選ばれたユーザのselected postに表示される' do
        act_as recruiter do
          visit application_users_post_path(post)
          click_on 'Assign'
          expect(page).to have_content 'Assigned'
        end
        act_as applicant do
          visit selected_posts_user_path(applicant)
          expect(page).to have_content post.title.to_s
        end
      end
    end
  end
  describe '投稿編集機能#edit/update' do
    context '投稿ユーザ(recruiter)の場合' do
      it 'データが更新される' do
        act_as recruiter do
          visit myposts_posts_path
          click_on 'edit'
          fill_in 'post[detail]', with: 'Example_Detail_Update'
          click_button 'Submit'
          expect(page).to have_content 'Example_Detail_Update'
        end
      end
    end
  end
  describe '投稿削除機能#destroy' do
    context '投稿ユーザ(recruiter)が削除した場合' do
      it 'データが表示されない' do
        act_as recruiter do
          visit myposts_posts_path
          click_on 'delete'
          page.accept_confirm 'really delete?'
          visit myposts_posts_path
          expect(page).to_not have_content post.title.to_s
        end
      end
    end
  end
end
