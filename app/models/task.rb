class Task < ActiveRecord::Base

  belongs_to :list

  def self.valid_params?(params)
    return !params[:content].empty?
  end

end