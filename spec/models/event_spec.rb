require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#created_by?' do
    context 'owner_idと引数の#idが同じ場合' do
      it do
        event = create(:event)
        user = double('user', id: event.owner_id)

        expect(event.created_by?(user)).to be true
      end
    end

    context 'owner_idと引数の#idが異なる場合' do
      it do
        event = create(:event)
        another_user = create(:user)
        expect(event.created_by?(another_user)).to be false
      end
    end

    context 'owner_idと引数がnilな場合' do
      it do
        event = create(:event)
        expect(event.created_by?(nil)).to be false
      end
    end
  end

  it 'start_at_should_be_before_end_at validation OK' do
    start_at = rand(1..30).days.from_now
    end_at = start_at + rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_empty(event.errors[:start_at])
  end

  it 'start_at_should_be_before_end_at validation error' do
    start_at = rand(1..30).days.from_now
    end_at = start_at - rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_not_empty(event.errors[:start_at])
  end
end
