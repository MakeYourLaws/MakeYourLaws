class FecAoDocsController < ApplicationController

  def index
    @last_updated = FecAoDocs.first(order: 'submitted DESC', select: 'submitted').submitted
    # TODO: cache response based on above value

    @fec_ao_docs = FecAoDocs.all(order: "submitted DESC", limit: 20)

    respond_to do |format|
       format.rss { render layout: false }
    end
  end
end