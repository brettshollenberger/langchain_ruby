module Langchain
  module Instrumentation
    module OpenTelemetry
      TracerProvider = PyCall.import_module("opentelemetry.sdk.trace").TracerProvider
    end
  end
end
