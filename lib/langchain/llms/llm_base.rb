require "pycall"
require "forwardable"

module Langchain
  module LLMs
    class LLMBase
      extend Forwardable

      def initialize(model: nil, api_key: nil, model_name: nil, class_name: nil)
        @model = model
        @api_key = api_key
        @model_name = model_name
        @class_name = class_name
        @klass = load_llm_class
      end

      def_delegators :@llm, :invoke, :generate, :predict, :predict_messages, :get_num_tokens

      def call(prompt)
        invoke(prompt)
      end

      def stream(prompt, &block)
        @llm.stream(prompt, &block)
      end

      def generate_with_params(prompt, temperature: 0.7, top_p: 0.9)
        @llm.generate(prompt, temperature: temperature, top_p: top_p)
      end

      private

      def load_llm_class
        PyCall.import_module("langchain.chat_models.#{@model_name}").send(@class_name)
      end
    end
  end
end
