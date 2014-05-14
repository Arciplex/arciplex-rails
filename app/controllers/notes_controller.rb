class NotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    authorize! :create, Note

    @noteable = find_noteable
    @note = @noteable.build_note(note_attributes)
    @note.user_id = current_user.id

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

    @noteable = find_noteable
    @note = @noteable.note

    respond_to do |format|
      if @note.update_attributes(note_attributes)
        format.js {}
      else
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def find_noteable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

    def note_attributes
      params.require(:note).permit(:id, :description)
    end

end
