require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:applicant) { create(:applicant) }
  let!(:recruiter) { create(:recruiter) }

  describe 'ユーザ登録機能' do
    context '応募者(applicant)が必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'applicant_0'
        fill_in 'user[email]', with: 'applicant_0@example.com'
        fill_in 'user[content]', with: 'applicant_0_content'
        select 'applicant', from: 'user[applicant_or_recruiter]'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button 'Sign-up'
        expect(page).to have_content 'applicant_0'
        expect(page).to have_content '[applicant]'
      end
    end
    context '募集者(recruiter)が必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'recruiter_0'
        fill_in 'user[email]', with: 'recruiter_0@example.com'
        fill_in 'user[content]', with: 'recruiter_0_content'
        select 'recruiter', from: 'user[applicant_or_recruiter]'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button 'Sign-up'
        expect(page).to have_content 'recruiter_0'
        expect(page).to have_content '[recruiter]'
      end
    end
  end
  describe 'セッション機能' do
    context '登録済みの応募者情報でログインができる' do
      it 'applicantでログインできる' do
        act_as applicant do
        end
      end
      it 'recruiterでログインできる' do
        act_as recruiter do
        end
      end
    end
  end
  describe '応募者一覧機能#professional' do
    context '投稿者でログインした場合' do
      it '応募者一覧が表示される' do
        act_as recruiter do
          visit professional_users_path
          expect(page).to have_content applicant.name
        end
      end
    end
    context '複数の応募者を作成した場合' do
      let!(:new_applicant) { create(:applicant) }
      it '応募者の登録日が新しい順に並んでいる' do
        act_as recruiter do
          visit professional_users_path
          user_list = all('.user_name')
          expect(user_list[0]).to have_content new_applicant.name
          expect(user_list[1]).to have_content applicant.name
        end
      end
    end
  end
  describe '応募者検索機能#professional' do
    context '検索をした場合' do
      let!(:applicants) { create_list(:applicant, 2) }
      let!(:category_user1) { create(:category_user, user: applicants[0]) }
      let!(:category_user2) { create(:category_user, user: applicants[1]) }
      it '名前で検索できる' do
        act_as recruiter do
          visit professional_users_path
          fill_in 'q[name_or_content_cont]', with: applicants[0].name
          click_button 'Search'
          expect(page).to have_content applicants[0].name
          expect(page).to_not have_content applicants[1].name
        end
      end
      it 'カテゴリで検索できる' do
        act_as recruiter do
          visit professional_users_path
          select applicants[0].categories.first.name.to_s, from: 'category'
          click_button 'Search'
          expect(page).to have_content applicants[0].name
          expect(page).to_not have_content applicants[1].name
        end
      end
      it '名前とカテゴリで検索できる' do
        act_as recruiter do
          visit professional_users_path
          fill_in 'q[name_or_content_cont]', with: applicants[0].name
          select applicants[0].categories.first.name.to_s, from: 'category'
          click_button 'Search'
          expect(page).to have_content applicants[0].name
          expect(page).to_not have_content applicants[1].name
        end
      end
    end
  end
end
