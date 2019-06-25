# typed: false
RailsAdmin.config do |config|
  config.main_app_name = ["DemoApp"]
  config.parent_controller = 'CmsMainController'

  # == Authlogic ==
  config.authenticate_with do
    require_admin
  end
  config.current_user_method(&:current_admin)

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :userclass eval vs define method
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index do                       # mandatory
      only Ability::INDEX_MODELS
    end
    new
    export
    bulk_delete
    show
    edit
    delete
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Admin' do
    configure :set_password do
      label 'Set Password'
      help 'Set password'
    end

    configure :last_request_at do
      strftime_format do
        '%Y/%m/%d %H:%M:%S'
      end
    end
    configure :current_login_at do
      strftime_format do
        '%Y/%m/%d %H:%M:%S'
      end
    end
    configure :last_login_at do
      strftime_format do
        '%Y/%m/%d %H:%M:%S'
      end
    end

    list do
      include_fields :login,
        :email,
        :role,
        :is_super
    end

    show do
      include_fields :login,
        :email,
        :role,
        :is_super,
        :login_count,
        :failed_login_count,
        :last_request_at,
        :current_login_at,
        :last_login_at,
        :current_login_ip,
        :last_login_ip
    end

    edit do
      include_fields :login,
        :email,
        :set_password,
        :role

      configure :role do
        visible do
          bindings[:view]._current_user.is_super
        end
      end
    end
  end

  config.model 'Role' do
    exclude_fields :admins

    list do
      field :created_at do
        strftime_format do
          '%Y/%m/%d %H:%M:%S'
        end
      end

      field :updated_at do
        strftime_format do
          '%Y/%m/%d %H:%M:%S'
        end
      end
    end
  end
end
