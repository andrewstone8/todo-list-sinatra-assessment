class Task < ActiveRecord::Base

  belongs_to :list

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:manufacturer].empty?
  end

end