class AddGroupEffectiveDatesToWellpointUsers < ActiveRecord::Migration
  def change
    add_column :wellpoint_users, :grp_incentive_efctv_dt, :date
    add_column :wellpoint_users, :grp_incentive_trmn_dt, :date
  end
end
