class WellpointUser < ActiveRecord::Base
  
  attr_protected

  def name
    fn = self.frst_nm.capitalize rescue ""
    ln = self.lst_nm.capitalize rescue ""

    "#{fn} #{ln}"
  end
end
