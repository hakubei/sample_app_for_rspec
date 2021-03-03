require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン前' do
    context 'タスクの新規登録ページにアクセス' do
      it '新規登録ページへのアクセスに失敗する' do
        visit new_task_path
        expect(page).to have_content('Login required')
        expect(current_path).to eq login_path
      end
    end

    context 'タスクの編集ページにアクセス' do
      it '編集ページへのアクセスに失敗する' do
        visit edit_task_path(task)
        expect(page).to have_content('Login required')
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    before do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    describe 'タスク新規登録' do
      context 'フォームの入力が正常' do
        it 'タスクの新規作成が成功する' do
          visit new_task_path
          fill_in 'Title', with: 'title_test'
          fill_in 'Content', with: 'content_test'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: DateTime.new(2021, 3, 9, 12, 30)
          click_button 'Create Task'
          expect(page).to have_content 'title_test'
          expect(page).to have_content 'content_test'
          expect(page).to have_content 'doing'
          expect(page).to have_content '2021/3/9 12:30'
          expect(current_path).to eq '/tasks/1'
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの新規登録が失敗する' do
          visit new_task_path
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'content_test'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: DateTime.new(2021, 3, 9, 12, 00)
          click_button 'Create Task'
          expect(page).to have_content "Title can't be blank"
          expect(current_path).to eq tasks_path
        end
      end
    end
  end
end
