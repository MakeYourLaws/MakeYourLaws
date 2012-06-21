class VersionsController < ApplicationController
# TODO: Requires authorization
  # def revert
  #   @version = Version.find(params[:id])
  #   if @version.reify
  #     @version.reify.save!
  #   else
  #     @version.item.destroy
  #   end
  #   link_name = params[:redo] == "true" ? "undo" : "redo"
  #   link = view_context.link_to(link_name, revert_version_path(@version.next, :redo => !params[:redo]), :method => :post)
  #   redirect_to :back, :notice => "Undid #{@version.event}. #{link}"
  # end
  
  private
  
  # def undo_link object
  #   view_context.link_to("undo", revert_version_path(object.versions.scoped.last), :method => :post)
  # end
end