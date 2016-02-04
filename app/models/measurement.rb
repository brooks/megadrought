class Measurement < ActiveRecord::Base

  def self.create_by_date_and_percent(date, percent)
    measurement = Measurement.new
    measurement.date = date
    measurement.percent = percent
    measurement.save!
    measurement
  end

  def top
    ((percent * -0.1875) + 45).to_i
  end

end
