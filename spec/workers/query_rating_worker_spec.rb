require 'rails_helper'
RSpec.describe QueryRatingWorker, type: :worker do
  describe QueryRatingWorker, '#perform_async' do
    it 'should return one job' do
      expect {
        QueryRatingWorker.perform_async('Test')
      }.to change(QueryRatingWorker.jobs, :size).by(1)
    end

    it 'should return two jobs' do
      expect {
        QueryRatingWorker.perform_async('Test')
        QueryRatingWorker.perform_async('One')
      }.to change(QueryRatingWorker.jobs, :size).by(2)
    end
  end

  describe QueryRatingWorker, '#jobs.clear' do
    it 'should return no jobs' do
      expect {
        QueryRatingWorker.perform_async('Test')
        QueryRatingWorker.perform_async('One')
        QueryRatingWorker.jobs.clear
      }.to change(QueryRatingWorker.jobs, :size).by(0)
    end
  end
end
