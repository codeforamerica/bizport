class ReportsController < ApplicationController
  def user_count
    render(json: {
      users: { type: 'integer', value: User.where(role: nil).count, label: 'Number of Users', order: 0 }
    })
  end
end
