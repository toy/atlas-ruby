module Atlas
  # Base class for representing resources.
  class Resource
    attr_accessor :tag, :url_builder

    def initialize(tag, hash = {})
      @tag = tag
      @url_builder = UrlBuilder.new tag

      hash.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end

    def update_with_response(response, except_keys = [])
      # remove keys that shouldn't be included
      except_keys.each { |k| response.delete(k) }

      response.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end

    def to_hash
      attrs = instance_variables.collect do |v|
        %w(@tag @url_builder).include?(v.to_s) ? next : v.to_s.sub(/^@/, '')
      end.compact!

      Hash[attrs.select { |v| respond_to? v }.map { |v| [v.to_sym, send(v)] }]
    end

    def inspect
      objects = to_hash.map { |k, v| "#{k}=#{v.inspect}" }.join(' ')
      "#<#{self.class.name}:#{object_id} #{objects}>"
    end
  end
end
