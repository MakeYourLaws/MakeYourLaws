namespace :fec do
  desc "Update FEC Candidates and Committees"
  task :update => :environment do
    Fec::Candidate.update!
    Fec::Committee.update!
  end
end
