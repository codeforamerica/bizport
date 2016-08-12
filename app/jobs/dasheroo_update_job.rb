class DasherooUpdateJob < ActiveJob::Base
  queue_as :default

  # ActiveJob won't take dates as arguments
  def perform(date_start: Date.today.to_s, date_end: Date.today.to_s)
    dstart = Date.parse(date_start)
    dend = Date.parse(date_end)
    accounts_count(date_start: dstart, date_end: dend)
  end

  private

  def accounts_count(date_start:, date_end:)
    url = 'https://www.dasheroo.com/external/api/subscriptions/5e394de8130c5bc3263294be0ff0d9ce'

    (date_start..date_end).each do |date|
      count = User.where(role: nil).where("date_trunc('day', users.created_at) <= ?", date).count
      puts HTTP.post(url, params: { label: "Number of Accounts", value: count, type: 'integer', date: date })
    end
  end
end
