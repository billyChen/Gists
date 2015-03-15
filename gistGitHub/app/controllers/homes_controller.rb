class HomesController < ApplicationController
  def index
  end

	def list
		@list = Gist.all
	end

	def delete
		begin
			Gist.find(params[:id]).destroy
		rescue => err
			@error = err
		end
	end
end
