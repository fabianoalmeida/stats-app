class QueryRatingWorker
  include Sidekiq::Worker

  def perform(sentence)
    queries = Query.where(sentence: sentence)
    return queries.first.increase_rating if ! queries.empty?
    Query.create sentence: sentence
  end
end
