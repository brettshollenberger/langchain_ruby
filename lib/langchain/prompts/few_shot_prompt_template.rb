require "pycall/import"
require "forwardable"

module Langchain
  module Prompts
    class FewShotPromptTemplate
      extend Forwardable

      PyFewShotPromptTemplate = PyCall.import_module("langchain_core.prompts.few_shot").FewShotPromptTemplate

      attr_accessor :py_prompt_template

      def initialize(**kwargs)
        if kwargs.key?(:example_prompt) && kwargs[:example_prompt].respond_to?(:py_prompt_template)
          kwargs[:example_prompt] = kwargs[:example_prompt].py_prompt_template
        end

        @py_prompt_template = PyFewShotPromptTemplate.new(**kwargs.with_indifferent_access.without("input_variables"))
        @py_prompt_template.input_variables = kwargs["input_variables"]
      end

      def format(**kwargs)
        @py_prompt_template.format(**kwargs)
      end

      def save(**kwargs)
        @py_prompt_template.save(**kwargs)
      end
    end
  end
end
