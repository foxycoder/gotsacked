json.array!(@calculations) do |calculation|
  json.extract! calculation, :id, :age, :working_years, :working_years_total, :gross_salary, :education_level, :email_address
  json.url calculation_url(calculation, format: :json)
end
