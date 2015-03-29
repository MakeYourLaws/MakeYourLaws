class AddSenateFilings < ActiveRecord::Migration
  def change
    # :fec_filing_hdr, :fec_filing_f1, :fec_filing_f1m, :fec_filing_f1s, :fec_filing_f2, :fec_filing_f24, :fec_filing_f3, :fec_filing_f3p, :fec_filing_f3p31, :fec_filing_f3ps, :fec_filing_f3s, :fec_filing_f3x, :fec_filing_f3l, :fec_filing_f4, :fec_filing_f5, :fec_filing_f56, :fec_filing_f57, :fec_filing_f6, :fec_filing_f65, :fec_filing_f7, :fec_filing_f76, :fec_filing_f9
    [:fec_filing_f13, :fec_filing_f132, :fec_filing_f133, :fec_filing_f91, :fec_filing_f92, :fec_filing_f93, :fec_filing_f94, :fec_filing_f99, :fec_filing_h1, :fec_filing_h2, :fec_filing_h3, :fec_filing_h4, :fec_filing_h5, :fec_filing_h6, :fec_filing_sa, :fec_filing_sb, :fec_filing_sc, :fec_filing_sc1, :fec_filing_sc2, :fec_filing_sd, :fec_filing_se, :fec_filing_sf, :fec_filing_sl, :fec_filing_text].each do |table_name|
      change_table table_name do |t|
        t.string :fec_record_type, limit: 1, default: 'C' # regular Comittee; S = Senate
        t.remove_index [:fec_record_number, :row_number] unless table_name == :fec_filing_f3p31
        t.index [:fec_record_type, :fec_record_number, :row_number], unique: true, name: 'record_index'
      end
    end
  end
end
