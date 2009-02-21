class Category < ActiveRecord::Base

  def to_param
    "#{id}-#{name}"
  end
end
