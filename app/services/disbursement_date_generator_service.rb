class DisbursementDateGeneratorService
  PUBLIC_HOLIDAYS = [
    Date.parse("2025-03-31"),
    Date.parse("2025-04-01")
  ]

  BUSINESS_DAYS = %w[monday tuesday wednesday thursday friday]

  def call(date = Date.today)
    @date = date
    format_date(find_next_working_day)
  rescue => e
    "Error occurred: #{e.message}"
  end

  private

  def find_next_working_day
    next_working_date = @date + 1

    while !working_day?(next_working_date)
      next_working_date += 1
    end

    next_working_date
  end

  def working_day?(date)
    BUSINESS_DAYS.include?(date.strftime("%A").downcase) && !PUBLIC_HOLIDAYS.include?(date)
  end

  def format_date(date)
    day = date.day
    ordinal = ordinal_suffix(day)
    date.strftime("%B #{day}#{ordinal}, %Y")
  end

  def ordinal_suffix(day)
    return "th" if (11..13).include?(day % 100)

    case day % 10
    when 1 then "st"
    when 2 then "nd"
    when 3 then "rd"
    else "th"
    end
  end
end
