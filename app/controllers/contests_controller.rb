class ContestsController < ApplicationController
  def create
    cmd = Command::CreateContest.new
    cmd.call(contest_params)

    return render(json: cmd.errors.to_json, status: cmd.status) if cmd.errors.present?

    Job::EnqueueBattle.perform_async(cmd.contest_id)
    render json: cmd.to_json, status: cmd.status
  rescue Job::EnqueueBattle::BattleError => e
    render json: e.message, status: 400
  end

  def show
    cmd = Command::ShowContest.new
    result = cmd.call(params[:id])

    render json: cmd.to_json, status: cmd.status
  end

  private

  def contest_params
    params
      .permit(:challenger_id, :opponent_id, :strategy)
  end
end
