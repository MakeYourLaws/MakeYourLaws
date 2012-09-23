require 'net/http'

# Modified from: http://joshuawood.net/validating-url-in-ruby-on-rails-3/
# Thanks Ilya! http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
# Original credits: http://blog.inquirylabs.com/2006/04/13/simple-uri-validation/
# HTTP Codes: http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc/classes/Net/HTTPResponse.html

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    # alternate format: /(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix 
    configuration = { :nonresponse_message => "is invalid or not responding", :bad_format_message => "does not appear to be a valid URI", :nil_message => "is not present", :format => URI::regexp(%w(http https)), :allow_nil => false }
    configuration.update(options)
    
    if value.nil? 
      object.errors.add(attribute, configuration[:nil_message]) and false unless configuration[:allow_nil]
    elsif value =~ configuration[:format]
      begin # check header response
        case Net::HTTP.get_response(URI.parse(value))
          when Net::HTTPSuccess then true
          when Net::HTTPRedirection then true # accept redirects too
          else object.errors.add(attribute, configuration[:nonresponse_message]) and false
        end
      rescue # Recover on DNS failures..
        object.errors.add(attribute, configuration[:nonresponse_message]) and false
      end
    else
      object.errors.add(attribute, configuration[:bad_format_message]) and false
    end
  end
end