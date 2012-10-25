class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :sbscrbr_id, :frst_nm, :lst_nm
end
