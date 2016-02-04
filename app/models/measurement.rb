class Measurement < ActiveRecord::Base

  def self.create_by_date_and_percent(date, percent)
    measurement = Measurement.new
    measurement.date = date
    measurement.percent = percent
    measurement.save!
    measurement
  end

  def top
    return 80 if summer?
    ((percent * -0.34375) + 70).to_i
  end

  def url
    if summer?
      'assets/summer.jpeg'
    else
      'assets/winter.jpg'
    end
  end

  def summer?
    (6..9).include? date.month
  end

end
