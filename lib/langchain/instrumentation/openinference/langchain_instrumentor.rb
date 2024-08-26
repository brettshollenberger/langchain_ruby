module Langchain
  module Instrumentation
    module OpenInference
      LangchainInstrumentor = PyCall.import_module("openinference.instrumentation.langchain").LangChainInstrumentor
    end
  end
end
