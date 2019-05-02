# vendor = Vendor.where(name: "Henry Schein Inc.").first

# if vendor.present?
#     Product.all.each do |product|
#         if product.vendor_code = 'HS'
#             VendorsProduct.create(vendor_id: vendor.id, product_id: product.id)
#         end
#     end
# end


# user = User.where(email: 'alisha@bpdg.com').first_or_create do |user|
#     user.first_name = 'Alisha'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Alisha'
#   user.save!

#   user = User.where(email: 'amanda@bpdg.com').first_or_create do |user|
#     user.first_name = 'Amanda'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Amanda'
#   user.save!

#   user = User.where(email: 'maroua@bpdg.com').first_or_create do |user|
#     user.first_name = 'Maroua'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Maroua'
#   user.save!

#   user = User.where(email: 'renee@bpdg.com').first_or_create do |user|
#     user.first_name = 'Renee'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Renee'
#   user.save!

#   user = User.where(email: 'tamesis@bpdg.com').first_or_create do |user|
#     user.first_name = 'Tamesis'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Tamesis'
#   user.save!

#   user = User.where(email: 'jonas@bpdg.com').first_or_create do |user|
#     user.first_name = 'Jonas'
#     user.password = 'password'
#   end
  
#   user.first_name = 'Jonas'
#   user.save!

# OfficeTimeLog.create(name: 'Lynn')
# OfficeTimeLog.create(name: 'Cambridge')
# OfficeTimeLog.create(name: 'Arlington')
# OfficeTimeLog.create(name: 'Other (Off-Site)')

# UserTimeLog.all.each do |log|
#     if log.duration.nil?
#         log.duration = (log.time_out - log.time_in).to_i
#         log.save
#     end
# end

# *******************************************************

# DefaultWork.destroy_all
# DefaultWork.create!(description: "Programming")
# DefaultWork.create!(description: "Design")
# DefaultWork.create!(description: "Deployment")
# DefaultWork.create!(description: "Maintenance")

# DefaultTemplate.destroy_all
# DefaultTemplate.create!(:template_type=> "Quote", :message => "Estimate Request<br/><br/>Hello<br/><br/>We’d like to receive a quotation on the following items below with the listed specs. Attached are the mock ups and print ready files below.<br/><br/>Please get back to us before in a few days.<br/><br/>Thanks,<br/>Regency Management<br/><br/>")
# DefaultTemplate.create!(:template_type=> "Order", :message => "Estimate Request<br/><br/>Hello<br/><br/>We’d like to receive a quotation on the following items below with the listed specs. Attached are the mock ups and print ready files below.<br/><br/>Please get back to us before in a few days.<br/><br/>Thanks,<br/>Regency Management<br/><br/>")


# ProductType.destroy_all
# ProductType.create!([
#   {name: 'Discount'},
#   {name: 'Group'},
#   {name: 'Inventory Assembly'},
#   {name: 'Inventory Part'},
#   {name: 'Non Inventory Part'},
#   {name: 'Other Charge'},
#   {name: 'Sales Tax Item'},
#   {name: 'Service'}
# ])

# ProductAccount.destroy_all
# ProductAccount.create!([
#   {name: 'Bad Debt'},
#   {name: 'Loans & Exchanges'},
#   {name: 'Professional Fees'},
#   {name: 'Purchase'},
#   {name: 'Shareholder Distribution'},
#   {name: 'Taxes Payable'}
# ])

# ProductCog.destroy_all
# ProductCog.create!([
#   {name: 'Purchase'},
#   {name: 'Sales'},
#   {name: 'Cost of Goods Sold'}
# ])

# ProductAssetAccount.destroy_all
# ProductAssetAccount.create!([
#   {name: 'Inventory Asset'},
#   {name: 'Purchase'}
# ])

# Category.create!([
#   {name: 'Sample Category 1'},
#   {name: 'Sample Category 2'},
#   {name: 'Sample Category 3'},
#   {name: 'Sample Category 4'},
#   {name: 'Sample Category 5'}
#                ])

# Brand.create!([
#   {name: 'Sample Brand 1'},
#   {name: 'Sample Brand 2'},
#   {name: 'Sample Brand 3'},
#   {name: 'Sample Brand 4'},
#   {name: 'Sample Brand 5'}
#             ])

# Group.create!([
#   {name: 'Sample Brand 1', description: 'Sample Description Brand 1'},
#   {name: 'Sample Brand 2', description: 'Sample Description Brand 2'},
#   {name: 'Sample Brand 3', description: 'Sample Description Brand 3'},
#   {name: 'Sample Brand 4', description: 'Sample Description Brand 4'},
#   {name: 'Sample Brand 5', description: 'Sample Description Brand 5'},
# ])


# User.create!([
#     {email: "robert@simbyone.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#     {email: "simbyone2@gmail.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#     {email: "simbyone3@gmail.com",password: 'password', password_confirmation: 'password', first_name: "Test", last_name: "Test"},
#     {email: "sales@simbyone.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#     {email: "ntorres@highgatecapinv.com",password: 'password', password_confirmation: 'password', first_name: "Nidza ", last_name: "Torres"},
#     {email: "krichards@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Kristine", last_name: "Richards"},
#     {email: "joelwie@yahoo.com",password: 'password', password_confirmation: 'password', first_name: "Joel", last_name: "Wieder"},
#     {email: "joelwieder@icloud.com",password: 'password', password_confirmation: 'password', first_name: "Joel", last_name: "Gratt"},
#     {email: "denise.valdez@sbe.com",password: 'password', password_confirmation: 'password', first_name: "Denise", last_name: "Valdez"},
#     {email: "joelw@themgggroup.com",password: 'password', password_confirmation: 'password', first_name: "JOEL", last_name: "WIEDER"},
#     {email: "anash@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Ashley", last_name: "Nash"},
#     {email: "bfenwick@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Brian", last_name: "Fenwick"},
#     {email: "jojogabertan@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Jojo", last_name: "Gabertan"},
# ])


# =begin
# User.destroy_all
# Message.destroy_all
# UsersBrand.destroy_all
# UsersGroup.destroy_all
# Address.destroy_all
# Brand.destroy_all
# Category.destroy_all
# Customer.destroy_all
# Group.destroy_all
# Inventory.destroy_all
# Order.destroy_all
# OrderBranch.destroy_all
# OrderEntry.destroy_all
# OrderUser.destroy_all
# Product.destroy_all
# StyleAttribute.destroy_all
# OrderStatus.destroy_all
# =end

# OrderStatus.create(name: 'Quote Request')
# OrderStatus.create(name: 'Sales')
# OrderStatus.create(name: 'Design')
# OrderStatus.create(name: 'Processing')
# OrderStatus.create(name: 'Shipping')

# OrderEntry.where(product_id: 809).destroy_all
# OrderStatus.create(name: "Archive")


# Brand.destroy_all
# Customer.destroy_all
# Vendor.destroy_all

# Vendor.destroy_all
# VendorCategory.destroy_all
# VendorsProduct.destroy_all
# Audit.destroy_all

# Category.create!([
#     {name: 'Sample Category 1'},
#     {name: 'Sample Category 2'},
#     {name: 'Sample Category 3'},
#     {name: 'Sample Category 4'},
#     {name: 'Sample Category 5'}
#                  ])

# Brand.create!([
#     {name: 'Sample Brand 1'},
#     {name: 'Sample Brand 2'},
#     {name: 'Sample Brand 3'},
#     {name: 'Sample Brand 4'},
#     {name: 'Sample Brand 5'}
#               ])

# Group.create!([
#     {name: 'Sample Brand 1', description: 'Sample Description Brand 1'},
#     {name: 'Sample Brand 2', description: 'Sample Description Brand 2'},
#     {name: 'Sample Brand 3', description: 'Sample Description Brand 3'},
#     {name: 'Sample Brand 4', description: 'Sample Description Brand 4'},
#     {name: 'Sample Brand 5', description: 'Sample Description Brand 5'},
#               ])

# if !User.all.present?
#   User.create!([
#       {email: "robert@simbyone.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#       {email: "simbyone2@gmail.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#       {email: "simbyone3@gmail.com",password: 'password', password_confirmation: 'password', first_name: "Test", last_name: "Test"},
#       {email: "sales@simbyone.com",password: 'password', password_confirmation: 'password', first_name: "Popa", last_name: "Robert"},
#       {email: "ntorres@highgatecapinv.com",password: 'password', password_confirmation: 'password', first_name: "Nidza ", last_name: "Torres"},
#       {email: "krichards@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Kristine", last_name: "Richards"},
#       {email: "joelwie@yahoo.com",password: 'password', password_confirmation: 'password', first_name: "Joel", last_name: "Wieder"},
#       {email: "joelwieder@icloud.com",password: 'password', password_confirmation: 'password', first_name: "Joel", last_name: "Gratt"},
#       {email: "denise.valdez@sbe.com",password: 'password', password_confirmation: 'password', first_name: "Denise", last_name: "Valdez"},
#       {email: "joelw@themgggroup.com",password: 'password', password_confirmation: 'password', first_name: "JOEL", last_name: "WIEDER"},
#       {email: "anash@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Ashley", last_name: "Nash"},
#       {email: "bfenwick@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Brian", last_name: "Fenwick"},
#       {email: "jojogabertan@tworoadshotels.com",password: 'password', password_confirmation: 'password', first_name: "Jojo", last_name: "Gabertan"}
#   ])
# end

# if !Address.all.present?
#   Address.create!([
#                       {street: "32 west 39th street", street_2: "12th floor", city: "Manhattan", state: "new york", zip: "10018", country: "249", phone: "2147417416", email: nil},
#       {street: "524 Broadway", street_2: "", city: "new york", state: "NY", zip: "10012", country: "249", phone: "9175417338", email: nil},
#       {street: "14 prag ", street_2: "", city: "monroe ", state: "ny", zip: "10950", country: "249", phone: "845-782-0017", email: nil},
#       {street: "14 PRAG", street_2: "", city: "MONROE", state: "NY", zip: "10950", country: "249", phone: "", email: nil},
#       {street: "101 ROSS ST", street_2: "", city: "BROOKLYN", state: "NY", zip: "11211", country: "249", phone: "", email: nil},
#       {street: "45 Perlaman dr", street_2: "", city: "Monsey", state: "NY", zip: "10950", country: "249", phone: "2222222222", email: nil},
#       {street: "45 Broadway ave", street_2: "", city: "brooklyn", state: "ny", zip: "11211", country: "249", phone: "", email: nil},
#       {street: "16-80 Madison Street", street_2: "Apt 402", city: "Ridgewood", state: "NY", zip: "11385", country: "249", phone: "3108552066", email: nil},
#       {street: "430 Sutcliffe Pl", street_2: "", city: "Walnut Creek", state: "CA", zip: "94598", country: "249", phone: "9258179106", email: nil},
#       {street: "1109 Griffith Pl", street_2: "", city: "Santa Ana", state: "CA", zip: "92707", country: "249", phone: "714-321-5087", email: nil},
#       {street: "sadgadsgadg", street_2: "dsagasdg", city: "asdgadg", state: "il", zip: "60044", country: "249", phone: "874ds545454", email: nil},
#       {street: "870 7th Avenue, second floor", street_2: "Executive Assistant", city: "New York", state: "NY", zip: "10019", country: "249", phone: "", email: nil},
#       {street: "545 E. John Carpenter Freeway, Suite 1400", street_2: "Executive Assistant", city: "Irving", state: "TX", zip: "75062", country: "249", phone: "", email: nil},
#       {street: "14Prag", street_2: "Att Joel", city: "Monroe", state: "NY", zip: "10950", country: "15", phone: "3472287810", email: nil},
#       {street: "530 Bush Street", street_2: "Suite #500", city: "San Francisco", state: "California", zip: "94108", country: "249", phone: "", email: nil},
#       {street: "10333 East Dry Creek Road", street_2: "Suite 450", city: "Englewood", state: "Colorado", zip: "80112", country: "249", phone: "", email: nil},
#       {street: "530 Bush Street", street_2: "Suite 501", city: "San Francisco", state: "CA", zip: "94111", country: "249", phone: "843.303.3548", email: nil},
#       {street: "432 Huntington Road", street_2: "", city: "Union", state: "New Jersey", zip: "07083", country: "249", phone: "646.206.7511", email: nil},
#       {street: "432 Huntington Road", street_2: "", city: "Union", state: "New Jersey", zip: "07083", country: "249", phone: "646.206.7511", email: nil},
#       {street: "Two Roads Hotels", street_2: "524 Broadway", city: "New York", state: "NY", zip: "10012", country: "249", phone: "9173127422", email: nil},
#       {street: "1236 Charleston Road", street_2: "", city: "Cherry Hill", state: "New Jersey", zip: "08034", country: "249", phone: "9144629341", email: nil}
#   ])
# end
# if !Product.all.present?
#   Product.create!([
#                       {name: "Sample Pen", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "109.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Sample Pen 2", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "20.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10 SF", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "269.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Letterhead SF", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "50.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Letterhead", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "65.99", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "79.99", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope 9x12 SF", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "142.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Generic", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Leisure Brochure", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card SF", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "104.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card CO", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "104.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope 9x12 CO", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "142.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Letterhead CO", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "50.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10 CO", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "269.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Pencil", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "345.6", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Pen", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "530.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Luggage Tags", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "100.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card RFID Safelok", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "390.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card Magstripe", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "180.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card Holder", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "140.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Press Kit Folders", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "247.5", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Shoe Shine Bag", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "49.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Memo Pad", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "164.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Umbrella Golf", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "19.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Shopping Bag Black", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "149.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Shopping Bag White", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "149.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "DND", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Pet In Room Sign", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Attendant In Room Sign", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "219.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope 10x13", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "299.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card A2", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "112.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Note Card A2", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "60.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card A6", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "140.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Laundry Bag", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "120.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Newspaper Bag", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "38.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Tray Removal Tent Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Note Card A6", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "80.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Coaster", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "140.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "429.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Letterhead", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "522.5", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Umbrella Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "371.6", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Maintenance Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "220.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Weather Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "475.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "No Smoking Sign", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "DND Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Bathrobe Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "199.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Umbrella Black", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "276.84", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Brochure Meeting", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Brochure Meeting", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Brochure Meeting", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Brochure Leisure", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "269.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Brochure Leisure", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.9", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope 9x12", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "142.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "104.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Generic", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "129.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized - Copy", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope Note Card", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "104.75", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized - Copy - Copy", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized - Copy - Copy", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized - Copy - Copy", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Notecard Personalized - Copy - Copy", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "239.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Banquet Pad", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "449.5", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card RFID Ving", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "640.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Engineer In Room Sign", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "219.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card Buildings", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "425.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card Bridge", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "425.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Key Card Cab", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "425.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Luggage Tags", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "145.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope #10", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "319.6", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Letterhead", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "219.6", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Mailing Label", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "139.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Monogram Sticker", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "57.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Note Card – Folded (A6)", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "212.5", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil},
#       {name: "Envelope- Note Card A6 (for folded cards)", approval_status: nil, online_date: nil, offline_date: nil, unit: nil, description: nil, base_product: nil, category: nil, price: "1.0", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, variant_type: nil, style: nil, variants: nil, force_in_stock: nil}
#   ])
# end
# if !Vendor.all.present?
#   Vendor.create!([
#                      {name: "PCA Delta"},
#       {name: "4over"},
#       {name: "Vendor 3"},
#       {name: "Evergreen Mfg."},
#       {name: "Expert Printing (G&P Printing)"},
#       {name: "Double U Paper"}
#   ])
# end
#   Order.create!([
#       {brand_id: Brand.first.id}
#   ])

