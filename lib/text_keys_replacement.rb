module TextKeysReplacement
  TOKEN_LEFT_BOUND = '{{'
  TOKEN_RIGHT_BOUND = '}}'
  TOKEN_REGEXP = /#{TOKEN_LEFT_BOUND}(.*?)#{TOKEN_RIGHT_BOUND}/

  module ClassMethods
    # Public: Replaces the text variable in the text by context
    # Params:
    #   - text: String
    #   - context: Hash
    # Example:
    #   text: '{{name}} {{lastname}} like play {{game}}.'
    #   context: {name: 'Alex', game: 'football'}
    #   TextKeysReplacement.replace(text, context) -> 'Alex like play football.'
    # Returns String.
    def replace(text, context)
      return if text.nil?
      ctx = context || {}
      text.scan(TOKEN_REGEXP).uniq.flatten.each do |token|
        text.gsub!(tokenize(token), ctx[token.to_sym] || '')
      end
      text.squeeze(' ').strip
    end

    def tokenize(token)
      TOKEN_LEFT_BOUND + token + TOKEN_RIGHT_BOUND
    end
  end

  extend ClassMethods
end
