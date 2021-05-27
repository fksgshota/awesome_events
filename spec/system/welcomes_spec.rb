RSpec.describe 'Welcomes', type: :system do
  it '/ページを表示' do
    visit root_path

    expect(page).to have_selector 'h1', text: 'イベント一覧'
  end
end
