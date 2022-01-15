# This is required for development
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :output, "log/cron.log"

every 1.day, at: '0:00 am' do
  runner "OmnivaService.get"
end
