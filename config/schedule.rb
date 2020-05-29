set :output, 'log/crontab.log'
set :environment, :development
set :runner_command, 'rails runner'

every 1.day, at: '00:00 am' do
  runner 'Batch::DeadlineClear.deadline_clear'
end
