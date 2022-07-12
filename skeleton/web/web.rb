# frozen_string_literal: true
require 'maria_call_center'

require 'grape'
require 'grape-swagger'
require 'oat-swagger'
require 'grape/route_helpers'

require 'endpoints/twilio'

require 'helpers/log'

module MariaCallCenter
  class Web < Grape::API

    TWIML_MEDIA_TYPE = 'application/xml'

    helpers Helpers::Log

    # https://github.com/ruby-grape/grape#table-of-contents

    content_type :xml,     TWIML_MEDIA_TYPE

    format         :xml
    default_format :xml

    before do
      logger.info "#{env['REQUEST_METHOD']} #{env['REQUEST_URI']}"
    end

    # mount endpoints here

    mount Endpoints::Twilio

    ###

    add_swagger_documentation(
      hide_documentation_path: true,
      models: OatSwagger::Serializer.swagger_models,
    )
  end
end
