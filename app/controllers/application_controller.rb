class ApplicationController < ActionController::Base
  before_action :verify_omniva_json

  private

  def verify_omniva_json
    return unless (REDIS.get "omniva").nil?

    Rails.logger.info "No registry on redis, fetching now"

    OmnivaService.call
  end
end
