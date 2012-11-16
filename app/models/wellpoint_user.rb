class WellpointUser < ActiveRecord::Base
  
  attr_protected

  def name
    "#{self.frst_nm} #{self.lst_nm}" 
  end
end
