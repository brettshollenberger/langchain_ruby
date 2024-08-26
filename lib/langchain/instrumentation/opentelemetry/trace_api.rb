module Langchain
  module Instrumentation
    module OpenTelemetry
      TraceAPI = PyCall.import_module("opentelemetry.trace")
    end
  end
end
