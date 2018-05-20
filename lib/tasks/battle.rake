desc "get battle pets run a random battle"

task battle: [:environment, :refresh_pets] do
  challenger_id, opponent_id = BattlePet.take(2).pluck(:id)

  cmd = Command::CreateContest.new

  cmd.call(opponent_id: opponent_id, challenger_id: challenger_id)

  puts "contest id = #{cmd.contest_id}"

  puts "Enqueuing job..."

  Job::EnqueueBattle.perform_async(cmd.contest_id)

  puts "Finding contest..."
  puts "Getting results..."

  contest = Contest.find(cmd.contest_id)
  contest.validate_opposition!

  loop do
    break if contest.winner_id
    sleep 0.5
    contest.reload
  end

  puts "Finding the winner..."

  winner = BattlePet.find(contest.winner_id)

  puts <<~STR
    The winner between #{contest.opponent.name} and #{contest.challenger.name} is #{winner.name}!
  STR
end
