module Fech
  class DefaultTranslations
    def names
      composites = [
        {:row => :sa,     :version => /^[6-8]/,   :field => [:contributor, :donor_candidate]},
        {:row => :sb,     :version => /^[6-8]/,   :field => [:payee, :beneficiary_candidate]},
        {:row => :sc,     :version => /^[6-8]/,   :field => [:lender, :lender_candidate]},
        {:row => :sc1,    :version => /^[6-8]/,   :field => [:treasurer, :authorized]},
        {:row => :sc2,    :version => /^[6-8]/,   :field => :guarantor},
        {:row => :sd,     :version => /^[6-8]/,   :field => :creditor},
        {:row => :se,     :version => /^[6-8]/,   :field => [:payee, :candidate]},
        {:row => :sf,     :version => /^[6-8]/,   :field => [:payee, :payee_candidate]},
        {:row => :f3p,    :version => /^[6-8]/,   :field => :treasurer},
        {:row => :f3p31,  :version => /^[6-8]/,   :field => :contributor},
      ]
      # SPLIT composite names into component parts for these rows
      components = [
        {:row => :sa,     :version => /^3|(5.0)/, :field => :contributor},
        {:row => :sa,     :version => /^[3-5]/,   :field => :donor_candidate},
        {:row => :sb,     :version => /^3|(5.0)/, :field => :payee},
        {:row => :sb,     :version => /^[3-5]/,   :field => :beneficiary_candidate},
        {:row => :sc,     :version => /^[3-5]/,   :field => [:lender, :lender_candidate]},
        {:row => :sc1,    :version => /^[3-5]/,   :field => [:treasurer, :authorized]},
        {:row => :sc2,    :version => /^[3-5]/,   :field => :guarantor},
        {:row => :sd,     :version => /^[3-5]/,   :field => :creditor},
        # FIXME: https://github.com/NYTimes/Fech/pull/71 - has typo here as 'cadidate' (no n)
        {:row => :se,     :version => /^[3-5]/,   :field => [:payee, :candidate]},
        {:row => :sf,     :version => /^[3-5]/,   :field => [:payee, :payee_candidate]},
        {:row => :f3p,    :version => /^[3-5]/,   :field => :treasurer},
        {:row => :f3p31,  :version => /^[3-5]/,   :field => :contributor},
      ]

      composites.each { |c| combine_components_into_name(c) }
      components.each { |c| split_name_into_components(c) }
    end
  end
end
