require_relative "llm_base"

module Langchain
  module LLMs
    class OpenAI < LLMBase
      def initialize(api_key = nil)
        @api_key = api_key || ENV["OPENAI_API_KEY"]
        @model_name = "openai"
        @class_name = "ChatOpenAI"
        super(model_name: @model_name, class_name: @class_name)
        @llm = @klass.new(openai_api_key: @api_key)
      end
    end
  end
end
