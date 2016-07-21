class StaticController < ApplicationController
  def home
  end

  def survey
  end

  def contact
    @subscription = Subscription.new
  end

  # START A BUSINESS STEPS
  def business_plan
  end

  def finance_your_business
  end

  def find_a_location
  end

  def register_your_business
  end

  def permits_and_licenses
  end

  def building_and_inspections
  end

  def open_your_business
  end
end
