desc 'Heckle and run metrics'
task :ci => [ :flog, :flay, :reek, :roodi, 'metrics:all' ]
