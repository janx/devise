require 'rails/generators/named_base'
require 'generators/devise/orm_helpers'

module Curator
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      include Devise::Generators::OrmHelpers

      def generate_model
        invoke "curator:model", [name] unless model_exists? && behavior == :invoke
      end

      def inject_field_types
        inject_into_file model_path, migration_data, after: "include Curator::Model\n" if model_exists?
      end

      def inject_devise_content
        inject_into_file model_path, model_contents, after: "include Curator::Model\n" if model_exists?
      end

      def migration_data
<<RUBY
  attr_accessor :email, :encrypted_password # Database authenticatable
  attr_accessor :reset_password_token, :reset_password_sent_at # Recoverable
  attr_accessor :remember_created_at # Rememberable
  attr_accessor :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip # Trackable
  attr_accessor :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email # Confirmable
  attr_accessor :failed_attempts, :unlock_token, :locked_at # Lockable
RUBY
      end
    end
  end
end
