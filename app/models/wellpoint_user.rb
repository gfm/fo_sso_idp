class WellpointUser < ActiveRecord::Base
  
  # attr_accessible :id, :frst_nm, :lst_nm

  def name
    "#{self.frst_nm} #{self.lst_nm}" 
  end
end
