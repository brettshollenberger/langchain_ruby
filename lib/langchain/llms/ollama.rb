require_relative "llm_base"

module Langchain
  module LLMs
    class Ollama < LLMBase
      def initialize(model = "llama3")
        @model = model || "llama3"
        @model_name = "ollama"
        @class_name = "ChatOllama"
        super(model: @model, model_name: @model_name, class_name: @class_name)
        @llm = @klass.new(model: @model)
      end
    end
  end
end
