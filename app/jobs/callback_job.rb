require "net/http"
require "ostruct"

class CallbackJob < ApplicationJob
  queue_as :default

  def perform(url, attempt = 1)
    response = send_callback(url)

    if response.is_a?(Net::HTTPSuccess)
      Rails.logger.info "Callback succeeded on attempt #{attempt}. No further retries."
    elsif attempt < 2
      Rails.logger.warn "Callback failed (#{response.code}). Retrying in 1 hour..."
      self.class.set(wait: 5.seconds).perform_later(url, attempt + 1)
    else
      Rails.logger.error "Callback failed after 2 attempts. No more retries."
    end
  end

  private

  def send_callback(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    response
  rescue StandardError => e
    Rails.logger.error "HTTP request failed: #{e.message}"
    OpenStruct.new(success?: false, status: 500)
  end
end
