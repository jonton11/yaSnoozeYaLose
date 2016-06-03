json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :name, :description, :start_date, :team_id
  json.url challenge_url(challenge, format: :json)
end
