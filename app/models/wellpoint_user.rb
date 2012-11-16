class WellpointUser < ActiveRecord::Base
  
  attr_protected

  def name
    fn = self.frst_nm.capitalize rescue ""
    ln = self.lst_nm.capitalize rescue ""

    "#{fn} #{ln}"
  end

  def is_fully_eligible?
    is_eligible? && is_old_enough?
  end

  def is_eligible?
    (self.mbr_incentive_trmn_dt.nil? || self.mbr_incentive_trmn_dt > Date.today) &&
    (self.mbr_incentive_efctv_dt && self.mbr_incentive_efctv_dt <= Date.today)
  end

  def is_old_enough?
    self.brth_dt && self.brth_dt <= (Date.today - 18.years)
  end

end
