class AddEligibilityColumnsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string  :rcrd_stts_cd,          limit: 3
      t.string  :mbr_key,               limit: 32
      t.string  :sbscrbr_id,            limit: 15
      t.string  :frst_nm,               limit: 50
      t.string  :mid_init_nm,           limit: 15
      t.string  :lst_nm,                limit: 50
      t.string  :mbr_sqnc_nbr,          limit: 15
      t.string  :mbr_rltnshp_cd,        limit: 3
      t.date    :brth_dt
      t.string  :gndr_cd,               limit: 3
      t.string  :email_adrs_txt,        limit: 50
      t.string  :hc_id,                 limit: 20
      t.integer :mcid,                  limit: 8
      t.string  :prmry_phone_nbr,       limit: 10
      t.string  :alt_phone_nbr,         limit: 10
      t.string  :mbrshp_sor_cd,         limit: 8
      t.string  :src_grp_nbr,           limit: 10
      t.string  :src_subgrp_nbr,        limit: 15
      t.date    :prchsr_org_efctv_dt
      t.date    :prchsr_org_trmntn_dt
      t.date    :rnwl_dt
      t.date    :mbr_incentive_efctv_dt
      t.date    :mbr_incentive_trmn_dt
      t.string  :incntv_prdct_cd,       limit: 20
      t.boolean :grp_cvr_fee
    end
  end
end
