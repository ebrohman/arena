desc "get battle pet data from the battle pets api"

task :refresh_pets => :environment do
  json = Oj.load(
  `curl \
    -H "X-Pets-Token: #{ENV['API_KEY']}" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    https://wunder-pet-api-staging.herokuapp.com/pets`)

  json.each do |attrs|
    BattlePet.find_or_create_by attrs
  end

  puts <<-STR
    #{BattlePet.count} battle pets are available.
  STR
end

