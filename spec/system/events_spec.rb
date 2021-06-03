# frozen_string_literal: true

RSpec.describe 'Events', type: :system do
  let(:event) { create(:event) }
  let(:user) { create(:user) }

  it '/events/:id ページを表示' do
    visit event_path(event)

    expect(page).to have_selector 'h1', text: event.name
  end

  it '/events/new ページを表示' do
    sign_in_as(user)
    visit new_event_path

    expect(page).to have_selector 'h1', text: 'イベント作成'
  end

  it '/events/new ページでフォームに記入して登録' do
    sign_in_as(user)

    visit new_event_path
    expect(page).to have_selector 'h1', text: 'イベント作成'

    fill_in '名前', with: 'TokyoRubyKaigi'
    fill_in '場所', with: '東京'
    fill_in '内容', with: 'tokyo.rbによる地域Ruby会議'

    start_at = Time.current
    end_at = start_at + 3.hours

    start_at_field = 'event_start_at'
    select start_at.strftime('%Y'), from: "#{start_at_field}_1i" # 年
    select I18n.l(start_at, format: '%B'), from: "#{start_at_field}_2i" # 月
    select start_at.strftime('%d'), from: "#{start_at_field}_3i" # 日
    select start_at.strftime('%H'), from: "#{start_at_field}_4i" # 時
    select start_at.strftime('%M'), from: "#{start_at_field}_5i" # 分

    end_at_field = 'event_end_at'
    select end_at.strftime('%Y'), from: "#{end_at_field}_1i" # 年
    select I18n.l(end_at, format: '%B'), from: "#{end_at_field}_2i" # 月
    select end_at.strftime('%d'), from: "#{end_at_field}_3i" # 日
    select end_at.strftime('%H'), from: "#{end_at_field}_4i" # 時
    select end_at.strftime('%M'), from: "#{end_at_field}_5i" # 分

    click_on '登録する'
    expect(page).to have_selector 'div.alert', text: '作成しました'
  end

  it '/events/:id ページを表示して削除ボタンを押す' do
    sign_in_as(user)
    user_event = create(:event, owner: current_user)
    visit event_path(user_event)

    expect do
      page.accept_confirm do
        click_on 'イベントを削除する'
      end
      sleep 1
    end.to change { Event.count }.by(-1)

    expect(page).to have_selector 'div.alert', text: '削除しました'
  end
end
