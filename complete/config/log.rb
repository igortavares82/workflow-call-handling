require 'logging'

LOG_LAYOUT =
  case ENV['RACK_ENV']
  when 'test', 'development'
    Logging.layouts.pattern(pattern: ' [%l] %m\n')
  else
    # https://talkdesk.atlassian.net/wiki/display/TET/Logging+policy
    Logging.layouts.pattern(
      utc_offset: 'UTC',
      date_method: 'iso8601(3)',
      pattern:
        "%d #{ENV['DYNO']} #{ENV['APP_NAME']} " +
        %w(
          [platform_tid=\"%X{platform_tid}\"
          request_id=\"%X{request_id}\"
          section=\"%c\"
          thread_id=\"%t\"
          client_ip=\"%X{client_ip}\"
          account_id=\"%X{account_id}\"
          aname=\"%X{account_name}\"
          level=\"%l\"]
          %m\n
        ).join(' '),
      )
  end

Logging.logger.root.appenders = Logging.appenders.stdout(layout: LOG_LAYOUT)

Logging.logger.root.level =
  case ENV['LOG_LEVEL']
  when 'debug'
    :debug
  when 'warn'
    :warn
  when 'info'
    :info
  else
    ENV['RACK_ENV'] == 'test' ? :warn : :info
  end
