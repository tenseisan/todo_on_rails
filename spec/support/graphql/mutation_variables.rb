module GraphQL
  module MutationVariables
    def mutation_variables(type, attrs = {})
      attrs = attributes_for(type)

      # Merge the arguments
      attrs.reverse_merge!(attrs)

      # Camelize for GraphQL compatibility and return
      camelize_hash_keys(attrs).to_json
    end

    def camelize_hash_keys(hash)
      raise unless hash.is_a?(Hash)

      hash.transform_keys { |key| key.to_s.camelize(:lower) }
    end
  end
end