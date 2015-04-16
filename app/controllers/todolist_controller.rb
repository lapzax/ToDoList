class TodolistController < ApplicationController
	def index 
		@List  = Todolist.all
		if params[:status].present?
			if params[:status] == "Wait"
				@List = @List.where("status = ?","wait")
			elsif params[:status] == "Complete"
				@List = @List.where("status = ?","complete")
			end
		end
	end

	def create
		cs = Todolist.create(content: params[:content], status: "wait")
		redirect_to todolist_index_path
	end

	def new
		@List = Todolist.new
	end

	def destroy
		@List = Todolist.find(params[:id])
		@List.destroy
		redirect_to(todolist_index_path)
	end

	def edit
		@List = Todolist.find(params[:id])
	end

	def update
		@List = Todolist.find(params[:id])
		@List.update_attributes(params.require(:todolist).permit(:content))
		redirect_to(todolist_index_path)
	end

	def iscomplete
		@List = Todolist.find(params[:id])

		if @List.status == "complete"
			@List.update_attributes(status: "wait")			
		else
			@List.update_attributes(status: "complete")
		end
		redirect_to(todolist_index_path)
	end

end
