require 'uri'

class Params
  def initialize(req, route_params)
    @params = {}
    unless req.query_string.nil?
      parse_www_encoded_form(req.query_string)
    end
    unless req.body.nil?
      parse_www_encoded_form(req.body)
    end
  end

  def [](key)
  end

  def to_s
    @params.to_json
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    query_string_array = URI.decode_www_form(www_encoded_form)

    query_string_array.each do |key, val|
      # @params.merge!(recurs_nested_keys(parse_key(key), val))
      merge_hash = recurs_nested_keys(parse_key(key), val)
      recurs_nested_hashes_merge(merge_hash, @params)
    end
  end

  def recurs_nested_hashes_merge(from_hash, to_hash)
    from_key = from_hash.keys.first
    unless to_hash.include?(from_hash.keys.first)
      to_hash.merge!( from_key => from_hash[from_key] )
      return
    end

    recurs_nested_hashes_merge(from_hash[from_key], to_hash[from_key])
  end

  def recurs_nested_keys(keys_array, value)
    return { keys_array.first => value } if keys_array.size == 1

    return { keys_array.first => recurs_nested_keys(keys_array[1..-1], value) }
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
