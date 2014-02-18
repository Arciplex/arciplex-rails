class NotesController < ApplicationController
  before_filter :authenticate_user!, :load_service_request
  
  def create
    authorize! :create, Note
    
    @note = Note.new(note_attributes)
    @note.user_id = current_user.id
    @note.service_request_id = params[:service_request_id]
    
    respond_to do |format|
      if @note.save
        format.js {}
      else
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    authorize! :update, @note
    
    @note = current_user.notes.find(params[:id])
    
    respond_to do |format|
      if @note.update_attributes(note_attributes)
        format.js {}
      else
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def load_service_request
      @service_request = ServiceRequest.find(params[:service_request_id])
    end
  
    def note_attributes
      params.require(:note).permit(:id, :description)
    end
  
end