require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Height, type: :model do
  let(:user) { create :user }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:value) }

    it { should validate_numericality_of(:value).only_integer }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(20) }
    it { should validate_numericality_of(:value).is_less_than_or_equal_to(250) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(user.heights_sorted('value', 'desc').to_sql).to eq user.heights.order('value desc').to_sql
      expect(user.heights_sorted('x', 'x').to_sql).to eq user.heights.order('date asc').to_sql
    end
  end

  describe '.value_by_date' do
    context 'with heights' do
      before(:all) do
        @user = create(:user)
        @height_10ya = create(:height, date: 10.years.ago, value: 100, user: @user)
        @height_20ya = create(:height, date: 20.years.ago, value: 200, user: @user)
        @heights_for_range = @user.heights_sorted('date', 'desc').pluck(:date, :value)
      end

      it 'returns the value of an earlier date' do
        expect(Height.value_by_date(5.years.ago, @heights_for_range)).to eq @height_10ya.value
        expect(Height.value_by_date(15.years.ago, @heights_for_range)).to eq @height_20ya.value
      end

      it 'returns the value of the last record' do
        expect(Height.value_by_date(25.years.ago, @heights_for_range)).to eq @height_20ya.value
      end
    end

    context 'without heights' do
      it 'returns zero' do
        expect(Height.value_by_date(5.years.ago, [])).to eq 0
      end
    end
  end
end
