class Permission < ActiveRecord::Base
  has_and_belongs_to_many :role

  def self.generate_all
    Permission.transaction do
      Ability::Configs.each do |model, configs|
        configs[:actions].each do |action|
          desc = "#{action.to_s.capitalize} #{model}"
          Permission.create!(
            subject_class: model,
            action: action,
            name: desc,
            description: desc
          )
        end
      end
    end
  end
end
