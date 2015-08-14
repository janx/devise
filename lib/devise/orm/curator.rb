require 'orm_adapter/adapters/curator'

Curator::Model::ClassMethods.send :include, Devise::Models
