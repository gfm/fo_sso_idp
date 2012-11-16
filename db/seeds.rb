require "csv"

eligibility_updates = []
csv_data = File.open(Rails.root.join("wp_user_mock_data.csv"))
CSV.foreach(csv_data,  :col_sep => "|",  :quote_char => '"',  :headers =>  :first_row,  :return_headers => false) do |row|
  values = {}
  [ 
    :id, 
    :cntrct_id, 
    :hc_id, 
    :mbr_sqnc_nbr, 
    :rcrd_stts_cd, 
    :lst_nm, 
    :frst_nm, 
    :mid_init_nm, 
    :gndr_cd, 
    :mbr_rltnshp_cd, 
    :brth_dt, 
    :ssn, 
    :address_1, 
    :address_2, 
    :city, 
    :state, 
    :zip_1, 
    :zip_1, 
    :bill_rel, 
    :emp_status, 
    :emp_hr_dt, 
    :src_grp_nbr, 
    :src_subgrp_nbr, 
    :mbr_incentive_efctv_dt, 
    :cfmcn_prod_id, 
    :hpcc, 
    :incntv_prdct_cd, 
    :mbrshp_sor_cd, 
    :mbr_status, 
    :mbr_incentive_trmn_dt, 
    :grp_cvr_fee
  ].each_with_index do |prop, index|
    values[prop] = row[index]
  end
  eligibility_updates << values
end

WellpointUser.delete_all
#WellpointUser.connection.execute('ALTER TABLE wellpoint_users AUTO_INCREMENT = 1')
eligibility_updates.each do |eligibility_update|
  WellpointUser.create(eligibility_update)
end