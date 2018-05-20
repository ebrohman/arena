class ContestsController < ApplicationController
  def create
    cmd = Command::CreateContest.new
    contest_id = cmd.call(contest_params)

    return render(json: cmd.errors.to_json, status: 400) unless contest_id

    Job::EnqueueBattle.perform_async(contest_id)
    render json: cmd.to_json, status: cmd.status
  end

  def contest_params
    params
      .permit(:challenger_id, :opponent_id, :strategy)
  end
end
