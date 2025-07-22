module ExternalIdentifiable
  extend ActiveSupport::Concern

  class_methods do
    def find_by_external_id(external_id)
      find_by(external_id: external_id)
    end
  end

  included do
    validates :external_id, presence: true, uniqueness: true
  end
end
