class ExpandSupportOpposeCode < ActiveRecord::Migration
  def change
    [:fec_filing_f57, :fec_filing_f76, :fec_filing_se].each do |table_name|
      change_table table_name do |t|
        t.change :support_oppose_code, :string, limit: 3
      end
    end
  end
end
