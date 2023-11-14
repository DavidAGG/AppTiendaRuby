class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    country = FetchCountryService.new(request.remote_ip).perform
    user = User.find(user_id)
    if country
      user.update(country: country)
    end
  end
end
