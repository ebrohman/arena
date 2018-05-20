class ContestsController < ApplicationController
  def create
    cmd = Command::CreateContest.new
    cmd.call(contest_params)
    render json: cmd.to_json, status: cmd.status
  end

  def contest_params
    params
      .permit(:challenger_id, :opponent_id, :strategy)
  end
end
