require 'rails_helper'

RSpec.describe 'Events', type: :request do
  it '自分が作ったイベントは削除できる' do
    event_owner = create(:user)
    event = create(:event, owner: event_owner)

    sign_in_as event_owner

    expect do
      delete event_url(event)
    end.to change { Event.count }.by(-1)
  end

  it '他の人が作ったイベントは削除できない' do
    event_owner = create(:user)
    event = create(:event, owner: event_owner)
    sign_in_user = create(:user)

    sign_in_as sign_in_user

    expect do
      expect do
        delete event_path(event)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end.to change { Event.count }.by(0)
  end
end
