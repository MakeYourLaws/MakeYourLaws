class VersionsController < ApplicationController
  load_and_authorize_resource
  
# TODO: Requires authorization
  # def revert
  #   @version = Version.find(params[:id])
  #   if @version.reify
# FIXME: this is incompatible with optimistic locking.
# See https://github.com/airblade/paper_trail/issues/163
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