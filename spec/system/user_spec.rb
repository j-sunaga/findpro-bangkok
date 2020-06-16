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
end
