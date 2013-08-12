class NotesController < ApplicationController
  def create
    @note = Note.new(params[:note])

    flash[:notices] ||= []
    if @note.save
      note = Note.where(params[:note]).first
      flash[:notices] << "Note #{ note.id } created"
    else
      flash[:notices] << "Invalid input, please try again"
    end

    redirect_to track_url(@note.track_id)
  end

  def destroy
    note = Note.find(params[:id])

    flash[:notices] ||= []
    flash[:notices] << "Note #{ note.id } destroyed"
    redirect_to track_url(note.track_id)

    note.destroy
  end
end
