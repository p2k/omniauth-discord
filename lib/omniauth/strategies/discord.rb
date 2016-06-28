require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Discord < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'identify'

      option :name, 'discord'

      option :client_options, {
        :site => 'https://discordapp.com/api',
        :authorize_url => 'oauth2/authorize',
        :token_url => 'oauth2/token'
      }

      uid { raw_info['id'] }

      info do
        {
          :name => "#{raw_info['username']}\##{raw_info['discriminator']}",
          :username => raw_info['username'],
          :discriminator => raw_info['discriminator'],
          :email => raw_info['email'] || "#{raw_info['username']}-#{raw_info['discriminator']}@discord.user",
          :guilds => raw_info['guilds'],
          :connections => raw_info['connections']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        if @raw_info.nil?
          scopes = (options[:scope] || DEFAULT_SCOPE).split(' ')
          if scopes.include?('identify')
            @raw_info = access_token.get('users/@me').parsed
          else
            @raw_info = {}
          end
          @raw_info['guilds'] = access_token.get('users/@me/guilds').parsed if scopes.include?('guilds')
          @raw_info['connections'] = access_token.get('users/@me/connections').parsed if scopes.include?('connections')
        end
        @raw_info
      end

      def callback_url
        # Discord does not support query parameters
        full_host + script_name + callback_path
      end

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |k|
            params[k] = request.params[k.to_s] unless [nil, ''].include?(request.params[k.to_s])
          end
          params[:redirect_uri] = options[:redirect_uri] unless options[:redirect_uri].nil?
          params[:scope] ||= DEFAULT_SCOPE
        end
      end
    end
  end
end
