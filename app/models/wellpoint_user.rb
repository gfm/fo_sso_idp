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
    member_eligible? && group_eligible?
  end

  def is_old_enough?
    self.brth_dt && self.brth_dt <= (Date.today - 18.years)
  end

  def member_eligible?
    today = Date.today
    (mbr_incentive_trmn_dt.nil? || mbr_incentive_trmn_dt > today) &&
    (!mbr_incentive_efctv_dt.nil? && mbr_incentive_efctv_dt <= today)
  end

  def group_eligible?
    today = Date.today
    (prchsr_org_trmntn_dt.nil? || prchsr_org_trmntn_dt > today) &&
    (!prchsr_org_efctv_dt.nil? && prchsr_org_efctv_dt <= today)
  end

end
