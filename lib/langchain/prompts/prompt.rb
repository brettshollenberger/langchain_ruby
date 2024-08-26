require "pycall/import"
require "forwardable"

module Langchain
  module Prompts
    class PromptTemplate
      extend Forwardable

      PyPromptTemplate = PyCall.import_module("langchain_core.prompts").PromptTemplate

      def self.from_examples(**kwargs)
        PyPromptTemplate.from_examples(**kwargs)
      end

      def self.from_file(**kwargs)
        PyPromptTemplate.from_file(**kwargs)
      end

      attr_accessor :py_prompt_template

      def_delegator :@py_prompt_template, :input_variables

      def initialize(template:, input_variables:, template_format: "f-string")
        @py_prompt_template = PyPromptTemplate.new(
          template: template,
          input_variables: input_variables,
          template_format: template_format
        )
      end

      def format(**kwargs)
        @py_prompt_template.format(**kwargs)
      end

      def format_prompt(**kwargs)
        @py_prompt_template.format_prompt(**kwargs)
      end

      def self.from_template(template:, template_format: "f-string", **kwargs)
        kwargs.symbolize_keys!

        py_template = PyPromptTemplate.from_template(template, template_format: template_format,
                                                               **kwargs.except(:input_variables))

        # Create a new Ruby wrapper instance using the generated template and input_variables
        new(
          template: py_template.template,
          input_variables: py_template.input_variables,
          template_format: py_template.template_format,
          **kwargs
        )
      end
    end
  end
end
