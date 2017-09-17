require 'rails_helper'

RSpec.describe Query, type: :model do
  describe 'instance checks' do
    context 'with sentence' do
      it 'should return the regular value' do
        # setup
        query = build :query, :regular
        # validating
        expect(query.sentence).to eq 'This is a sentence'
        expect(query).to be_valid
      end

      it 'should return the updated value' do
        # setup
        query = build :query, :regular
        query.sentence = 'Updated value'
        # validating
        expect(query.sentence).to eq 'Updated value'
        expect(query).to be_valid
      end

      context 'increasing rating' do
        it 'should be return nil rating value' do
          # setup
          query = build :query, :regular
          query.increase_rating
          # validating
          expect(query.sentence).to eq 'This is a sentence'
          expect(query.rating).to eq 0
          expect(query).to be_valid
        end
      end
    end

    context 'without sentence' do
      it 'should not return an error message' do
        # setup
        query = build :query, :without_sentence
        # validating
        expect(query.sentence).to eq nil
        expect(query.errors[:sentence]).to be_empty
        expect(query).to_not be_valid
      end

      context 'increasing rating' do
        it 'should be return nil rating value' do
          # setup
          query = build :query, :without_sentence
          query.increase_rating
          # validating
          expect(query.sentence).to eq nil
          expect(query.rating).to eq 0
          expect(query).to_not be_valid
        end
      end
    end

    context 'with rating' do
      it 'should return the regular value' do
        # setup
        query = build :query, :regular
        # validating
        expect(query.rating).to eq 0
        expect(query).to be_valid
      end

      it 'should return the updated value' do
        # setup
        query = build :query, :regular
        query.rating = 1
        # validating
        expect(query.rating).to eq 1
        expect(query).to be_valid
      end

      context 'increasing its value' do
        it 'should be return one' do
          # setup
          query = build :query, :regular
          query.increase_rating
          # validating
          expect(query.rating).to eq 0
          expect(query).to be_valid
        end
      end
    end

    context 'without rating' do
      it 'should not return an error message' do
        # setup
        query = build :query, :without_rating
        # validating
        expect(query.rating).to eq nil
        expect(query.errors[:rating]).to be_empty
        expect(query).to be_valid
      end

      context 'increasing its value' do
        it 'should be return one' do
          # setup
          query = build :query, :without_rating
          query.increase_rating
          # validating
          expect(query.rating).to eq nil
          expect(query).to be_valid
        end
      end
    end
  end

  describe 'database checks' do

    context 'with sentence' do
      it 'should return the regular value' do
        # setup
        query = create :query, :regular
        # validating
        expect(query.sentence).to eq 'This is a sentence'
        expect(query).to be_valid
      end

      it 'should return the updated value' do
        # setup
        query = create :query, :regular
        query.sentence = 'Updated value'
        query.save
        # validating
        expect(query.sentence).to eq 'Updated value'
        expect(query).to be_valid
      end

      context 'increasing rating value' do
        it 'should return the rating increased' do
          # setup
          query = create :query, :regular
          query.increase_rating
          # validating
          expect(query.sentence).to eq 'This is a sentence'
          expect(query.rating).to eq 2
          expect(query).to be_valid
        end
      end
    end

    context 'without sentence' do
      it 'should not be valid' do
        # setup
        query = build :query, :without_sentence
        # validating
        expect(query.save).to be false
        expect(query).to_not be_valid
      end
    end

    context 'with rating' do
      it 'should return the first value' do
        # setup
        query = create :query, :regular
        # validating
        expect(query.rating).to eq 1
        expect(query).to be_valid
      end

      it 'should return the updated value' do
        # setup
        query = create :query, :regular
        query.rating = 2
        query.save
        # validating
        expect(query.rating).to eq 2
        expect(query).to be_valid
      end

      context 'increasing value' do
        it 'should return the value increased' do
          # setup
          query = create :query, :regular
          query.increase_rating
          # validating
          expect(query.rating).to eq 2
          expect(query).to be_valid
        end
      end
    end

    context 'without rating' do
      it 'should be valid' do
        # setup
        query = build :query, :without_rating
        # validating
        expect(query.save).to be true
        expect(query).to be_valid
      end

      context 'increasing value' do
        it 'should return nil' do
          # setup
          query = build :query, :without_rating
          query.increase_rating
          # validating
          expect(query.rating).to eq nil
          expect(query).to be_valid
        end
      end
    end
  end
end
