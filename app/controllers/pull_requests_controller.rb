class PullRequestsController < ApplicationController
  def create
    pull_request = PullRequest.create!(pull_request_params)
    render json: { location: pull_request_url(pull_request) }, status: 201
  end

  def show
    @pull_request = find_pull_request.decorate
  end

  private

  def find_pull_request
    PullRequest.where(permalink: permalink_param).first!
  end

  def pull_request_params
    params.require(:pull_request).permit(:raw_diff)
  end

  def permalink_param
    params[:id] || params[:permalink]
  end
end
