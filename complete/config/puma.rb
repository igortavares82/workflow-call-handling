require 'multi_json'

# Don't include stack trace in exceptions
leak_stack_on_error = false

# Concurrency options

# default is 0, which is equivalent to 1, which in turn means that it uses only 1 puma process
# https://github.com/puma/puma/blob/f22dc6172235a57c56c28e3074c76ce421170b1c/examples/config.rb#L103

processes = Integer(ENV['PUMA_PROCESSES'] || 0)
workers processes

# defaults is 0, 16
# https://github.com/puma/puma/blob/f22dc6172235a57c56c28e3074c76ce421170b1c/examples/config.rb#L67

# for the moment we are only allowing to set a specific number of threads. With an interval, puma server was
# leaking memory. So the min will be equal to the max, and we will only provide one env to set it.
process_min_threads = Integer(ENV['PUMA_PROCESS_THREADS'] || 16)
process_max_threads = Integer(ENV['PUMA_PROCESS_THREADS'] || 16)
threads process_min_threads, process_max_threads

# If we use web concurrency (workers > 1), we may take advantage of the Copy on Write feature in MRI Ruby 2.0
process_preload = Integer(ENV['PUMA_PROCESS_PRELOAD'] || 1)
preload_app! if processes > 1 && process_preload.positive?

# Handler for uncaught exceptions
lowlevel_error_handler do |e|
  error = {error: 'Internal server error'}

  if ENV['RACK_ENV'] != 'production'
    error = error.merge(
      message: e.message,
      eclass: e.class,
      backtrace: e.backtrace,
    )
  end

  [
    500,
    {'Content-Type' => 'application/hal+json'},
    [MultiJson.dump(error, pretty: true)],
  ]
end

puts 'Loaded puma configuration.'
