require 'net/http'
require 'uri'
require 'json'

$sms4_send_host = URI.parse('https://sms4.dev/send')

class SMS4
  def self.is_valid_input(to, message, token)
    if (to.nil?) or (not to.instance_of? String and not to.instance_of? Array) or to.empty?
      puts 'SMS4 Error: Recepients string is invalid. Please refer to our documentation at https://sms4.dev to see correct options.'
      return false
    end

    if (message.nil?) or (not message.instance_of? String) or message.empty?
      puts 'SMS4 Error: Message string is invalid. Please refer to our documentation at https://sms4.dev to see correct options.'
      return false
    end

    if (token.nil?) or (not token.instance_of? String) or token.empty?
      puts 'SMS4 token is not defined. To fix this you have to either:','1) Set environment variable SMS4_TOKEN','or','2) Pass the token as the 3rd argument to the send function.'
      return false
    end

    return true
  end

  def self.send(to, message, token=nil)
    sms4_token = nil
    if not token.nil?
      sms4_token = token
    elsif not ENV['SMS4_TOKEN'].nil?
      sms4_token = ENV['SMS4_TOKEN']
    end

    if self.is_valid_input(to, message, sms4_token)
      formatted_recepients = to
      if to.instance_of? Array
        formatted_recepients = to.join(',')
      end

      header = { 'Content-Type': 'application/json' }
      data = { to: formatted_recepients, message: message, token: sms4_token }

      http = Net::HTTP.new($sms4_send_host.host, $sms4_send_host.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new($sms4_send_host.request_uri, header)
      request.body = data.to_json

      response = http.request(request)

      return response.body
    end
  end
end
