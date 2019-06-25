# This is an autogenerated file for routes helper methods

# typed: strong
class ActionController::Base
  extend T::Sig

  # Sigs for route /admin_session/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_session_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_session_url(*args, **kwargs); end

  # Sigs for route /admin_session/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_session_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_session_url(*args, **kwargs); end

  # Sigs for route /admin_session(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_session_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_session_url(*args, **kwargs); end

  # Sigs for route /login(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def login_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def login_url(*args, **kwargs); end

  # Sigs for route /logout(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def logout_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def logout_url(*args, **kwargs); end

  # Sigs for route /admin
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_admin_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_admin_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/blobs/:signed_id/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_token(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/direct_uploads(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_url(*args, **kwargs); end


  # Section Routes for RailsAdmin::Engine
  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboard_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboard_url(*args, **kwargs); end

  # Sigs for route /:model_name(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def index_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def index_url(*args, **kwargs); end

  # Sigs for route /:model_name/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_url(*args, **kwargs); end

  # Sigs for route /:model_name/export(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_url(*args, **kwargs); end

  # Sigs for route /:model_name/bulk_delete(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def bulk_delete_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def bulk_delete_url(*args, **kwargs); end

  # Sigs for route /:model_name/bulk_action(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def bulk_action_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def bulk_action_url(*args, **kwargs); end

  # Sigs for route /:model_name/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def show_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def show_url(*args, **kwargs); end

  # Sigs for route /:model_name/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_url(*args, **kwargs); end

  # Sigs for route /:model_name/:id/delete(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def delete_path(*args, **kwargs); end
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def delete_url(*args, **kwargs); end

end
