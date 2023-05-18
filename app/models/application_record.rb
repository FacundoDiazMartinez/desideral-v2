class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def destroy(method: :soft)
    if method == :soft && respond_to?(:available)
      ActiveRecord::Base.transaction do
        update_attribute(:available, false)
        run_callbacks(:destroy)
        freeze
        self
      end
    else
      destroy
    end
  end
end
