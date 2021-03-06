namespace :pmf do
  task states: :environment do
    start_date = 6.week.ago
    end_date = 2.week.ago
    window = 7

    windows = Pmf.states_summary(start_date, end_date, window)
    windows.each do |window|
      puts window[:date]

      window[:states].each do |state, users|
        puts "  #{state} (#{users})"
      end

      puts
    end
  end

  task transitions: :environment do
    start_date = 6.week.ago
    end_date = 2.week.ago
    window = 7

    windows = Pmf.transitions(start_date, end_date, window)
    windows.each do |window|
      puts window[:date]

      window[:transitions].each do |transition, users|
        puts "  #{transition} (#{users})"
      end

      puts
    end
  end

  task warm_caches: :environment do
    # run this via cron just after midnight
    # calculate pmf windows for past year from yesterday
    end_date = Date.yesterday - 3
    start_date = end_date - 52.weeks
  
    [7,14,30,90].each do |window|
      PmfRepo.transitions(start_date, end_date, window)
      PmfRepo.states(start_date, end_date, window)
    end
  end
end
