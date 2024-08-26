module Langchain
  module Instrumentation
    module OpenTelemetry
      module Export
        SimpleSpanProcessor = PyCall.import_module("opentelemetry.sdk.trace.export").SimpleSpanProcessor
        ConsoleSpanExporter = PyCall.import_module("opentelemetry.sdk.trace.export").ConsoleSpanExporter
        OTLPSpanExporter = PyCall.import_module("opentelemetry.exporter.otlp.proto.http.trace_exporter").OTLPSpanExporter
      end
    end
  end
end
