# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121021145714) do

  create_table "wellpoint_users", :force => true do |t|
    t.integer "cntrct_id"
    t.integer "user_id"
    t.integer "ssn"
    t.string  "address_1"
    t.string  "address_2"
    t.string  "city"
    t.string  "state"
    t.string  "zip_1"
    t.string  "zip_2"
    t.integer "bill_rel",               :limit => 2
    t.integer "emp_status",             :limit => 2
    t.date    "emp_hr_dt"
    t.integer "cfmcn_prod_id"
    t.integer "hpcc"
    t.integer "mbr_status",             :limit => 2
    t.string  "rcrd_stts_cd",           :limit => 3
    t.string  "mbr_key",                :limit => 32
    t.string  "sbscrbr_id",             :limit => 15
    t.string  "frst_nm",                :limit => 50
    t.string  "mid_init_nm",            :limit => 15
    t.string  "lst_nm",                 :limit => 50
    t.string  "mbr_sqnc_nbr",           :limit => 15
    t.string  "mbr_rltnshp_cd",         :limit => 3
    t.date    "brth_dt"
    t.string  "gndr_cd",                :limit => 3
    t.string  "email_adrs_txt",         :limit => 50
    t.string  "hc_id",                  :limit => 20
    t.integer "mcid",                   :limit => 8
    t.string  "prmry_phone_nbr",        :limit => 10
    t.string  "alt_phone_nbr",          :limit => 10
    t.string  "mbrshp_sor_cd",          :limit => 8
    t.string  "src_grp_nbr",            :limit => 10
    t.string  "src_subgrp_nbr",         :limit => 15
    t.date    "prchsr_org_efctv_dt"
    t.date    "prchsr_org_trmntn_dt"
    t.date    "rnwl_dt"
    t.date    "mbr_incentive_efctv_dt"
    t.date    "mbr_incentive_trmn_dt"
    t.string  "incntv_prdct_cd",        :limit => 20
    t.boolean "grp_cvr_fee"
  end

  create_table "wellpoint_users_new", :id => false, :force => true do |t|
    t.integer "id"
    t.integer "cntrct_id",              :limit => 8
    t.string  "hc_id"
    t.integer "mbr_sqnc_nbr"
    t.string  "rcrd_stts_cd"
    t.string  "lst_nm"
    t.string  "frst_nm"
    t.string  "mid_init_nm"
    t.string  "gndr_cd"
    t.string  "mbr_rltnshp_cd"
    t.string  "brth_dt"
    t.integer "ssn",                    :limit => 8
    t.string  "address_1"
    t.string  "address_2"
    t.string  "city"
    t.string  "state"
    t.integer "zip_1"
    t.integer "bill_rel"
    t.integer "emp_status"
    t.string  "emp_hr_dt"
    t.string  "src_grp_nmb"
    t.string  "src_subgrp_nbr"
    t.string  "mbr_incentive_efctv_dt"
    t.string  "cfmcn_prod_id"
    t.string  "hpcc"
    t.integer "incntv_prdct_cd"
    t.integer "mbrshp_sor_cd"
    t.string  "mbr_status"
    t.string  "mbr_incentive_trmn_dt"
    t.integer "grp_cvr_fee"
  end

end
