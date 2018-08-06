namespace :cms do
  namespace :permission do
    desc "Generate all app permissions"
    task gen: [:environment] do
      Permission.generate_all
    end

    desc "Clear all app permissions. Note: all relations to roles also be clear"
    task clear: [:environment] do
      Permission.delete_all
      Permission.connection.execute "DELETE FROM permissions_roles;"
    end

    desc "Clear and re-generate all app permissions"
    task regen: [:environment, :clear, :gen] do
      puts "All permissions have been cleared and re-generate"
    end
  end

  namespace :admin do
    desc "promote an admin to be super admin"
    task :promote, [:email] => [:environment] do |t, args|
      app_name = RailsAdmin::Config.main_app_name.join(' ').split(' ').first.downcase
      default_email = "super_admin@#{app_name}.com"
      default_pass = "super_admin_#{app_name}"

      args.with_defaults(email: default_email)
      email = args[:email]

      if email.nil? || email.empty?
        puts "Must input email like: rake admin:promote[abc@xyz.com]"
        next
      end

      admin = Admin.where(email: email).first

      if email == default_email
        pass = default_pass
      else
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        pass = (0...10).map { o[rand(o.length)] }.join
      end
      
      if admin
        admin.is_super = true
        admin.set_password = pass
      else
        puts "There is no admin with email: #{email}. Creating new one..."
        account = email.split('@').first
        login = account
        count = 1
        while Admin.where(:login => login).exists?
          login = account + "_#{count}"
          count += 1
        end
        admin = Admin.new(
          login: login,
          email: email,
          is_super: true
        )
        admin.set_password = pass
      end
      role = Role.where(name: 'Content Manager').first
      admin.role = role
      admin.save!
      puts "Promoted Super Admin: \n" \
        "- Login: #{admin.login}\n" \
        "- Email: #{admin.email}\n" \
        "- Pass: #{pass}\n" \
        "You should login and change password for super admin!"
    end
  end

  desc "Create role 'Content Manager' which include all permissions"
    task create_super_role: [:environment] do
      role = Role.where(name: 'Content Manager').first_or_initialize
      role.permissions = Permission.all
      role.save
      puts 'The role "Content Manager" has been created with all permissions'
    end
  
  desc 'Init CMS'
  task init: ['permission:regen', 'create_super_role', 'admin:promote'] do
    app_name = RailsAdmin::Config.main_app_name.join(' ')
    puts "Initializing #{app_name}... DONE!!!"
  end

  desc 'Generate locale template'
  task gen_locale: :environment do
    Dir.glob(Rails.root.join('app/models/*.*')).each { |x| require x }
    puts ActiveRecord::Base.descendants.count
    data = { 'attributes' => {} }
    common_attrs = {}
    ActiveRecord::Base.descendants.each do |model|
      next if model.table_name.blank?
      model_name = model.to_s.underscore
      data[model_name] = model_name
      obj = model.new
      attrs = obj.attribute_names + model.
        reflect_on_all_associations.map(&:name).map(&:to_s)
      attrs.each do |att|
        next if att == 'id'
        att = att.gsub(/_id$/, '')
        data['attributes'][model_name] ||= { '<<' => '*common_attrs' }
        data['attributes'][model_name][att] = att
        common_attrs[att] ||= 0
        common_attrs[att] += 1
      end

      commons = []
      common_attrs.each do |att, count|
        next if count < 3
        commons << att
        data['attributes']['common_attrs'] ||= {}
        data['attributes']['common_attrs'][att] = att
      end

      data['attributes'].each do |mname, attrh|
        next if mname == 'common_attrs'
        commons.each { |att| attrh.delete(att) }
      end
    end
    puts data.to_yaml
  end

  desc 'Remove empty pictures'
  task remove_empty_pictures: :environment do
    count = 0
    Picture.all.each do |pic|
      if pic.image.file.nil? || !pic.image.file.exists?
        pic.destroy
        count += 1
      end
    end
    puts "Have destroy #{count} empty pictures"
  end
end
