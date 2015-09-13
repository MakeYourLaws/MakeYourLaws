xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "FEC Advisory Opinions documents"
    xml.description "All updates to FEC AOs, hosted by makeyourlaws.org"
    xml.link formatted_fec_ao_docs_url(:rss)
    xml.updated @last_updated.to_s(:rfc822)

    for fec_ao_doc in @fec_ao_docs
      xml.item do
        xml.title fec_ao_doc.full_name
        # xml.description post.content
        xml.pubDate fec_ao_doc.submitted.to_s(:rfc822)
        xml.link fec_ao_doc.url
        xml.guid fec_ao_doc.url
      end
    end
  end
end
