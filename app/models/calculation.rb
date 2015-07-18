class Calculation < ActiveRecord::Base
  def working_years_50plus
    if age - 50 < 0
      0
    else
      age - 50
    end
  end

  def working_years_50min
    working_years - working_years_50plus
  end

  def working_years_10plus
    if working_years_50min - 10 < 0
      0
    else
      working_years_50min - 10
    end
  end

  def working_years_10min
    working_years_50min - working_years_10plus
  end

  def months_ww
    if working_years_total < 3
      3
    else
      working_years_total
    end
  end

  def months_ww_3plus
    months_ww - 3
  end

  def age_factor
    if 1 + (age-18) * BigDecimal('0.025') > 2
      2
    else
      1 + (age-18) * BigDecimal('0.025')
    end
  end

  def search_time
    SEARCH_DEFAULT * EDUCATION_LEVEL_FACT[education_level] * PROFESSION_FACTOR[profession] * age_factor
  end

  COMPENSATION_10MIN = 3
  COMPENSATION_10PLUS = 2
  WW_FACTOR = BigDecimal('0.75')
  WW_FACTOR_3PLUS = BigDecimal('0.7')
  SEARCH_DEFAULT = 6
  EDUCATION_LEVEL_FACT = {'VMBO' => BigDecimal('2'), 'MBO' => BigDecimal('1.5'), 'HBO' => BigDecimal('1'), 'WO' => BigDecimal('1.25') }
#aa['mbo']
  PROFESSION_FACTOR = {'Agrarisch' => BigDecimal('1.5'),
                      'Commercieel' => BigDecimal('1'),
                      'Creatieve en taalkundige beroepen' => BigDecimal('2'),
                      'Dienstverlenend' => BigDecimal('1.25'),
                      'Economisch, administratief' => BigDecimal('1.5'),
                      'ICT' => BigDecimal('0.5'),
                      'Management' => BigDecimal('0.5'),
                      'Openbaar bestuur, veiligheid en juridisch' => BigDecimal('1.25'),
                      'Pedagogisch' => BigDecimal('1.25'),
                      'Technisch' => BigDecimal('0.5'),
                      'Transport en logistiek' => BigDecimal('1.25'),
                      'Zorg en welzijn' => BigDecimal('1')}

   def compensation_value
    if (working_years_50plus * gross_salary) + (working_years_10plus * gross_salary / COMPENSATION_10PLUS ) + (working_years_10min * gross_salary / COMPENSATION_10MIN) > 75000
       75000
     else
       (working_years_50plus * gross_salary) + (working_years_10plus * gross_salary / COMPENSATION_10PLUS ) + (working_years_10min * gross_salary / COMPENSATION_10MIN)
     end
   end

   def ww_value
    (WW_FACTOR * gross_salary * (months_ww - months_ww_3plus)) + (WW_FACTOR_3PLUS * gross_salary * months_ww_3plus)
   end

   def total_value
     compensation_value + ww_value
   end

   def possible_earnings_value
     gross_salary * search_time
   end

   def difference
     total_value - possible_earnings_value
   end

end
