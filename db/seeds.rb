# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create(name: "Active User", email: "nate.gardner+wpactive@synctree.com", password: "123456", sbscrbr_id: 1111, frst_nm: "Active", lst_nm: "User")
User.create(name: "Inactive User", email: "nate.gardner+wpinactive@synctree.com", password: "123456", sbscrbr_id: 2222, frst_nm: "Inactive", lst_nm: "User")