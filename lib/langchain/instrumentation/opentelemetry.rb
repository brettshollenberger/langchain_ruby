require "pycall/import"

module Langchain
  module Instrumentation
    module OpenTelemetry
      require_relative "opentelemetry/export"
      require_relative "opentelemetry/trace_api"
      require_relative "opentelemetry/tracer_provider"

      def self.configure(endpoint)
        provider = Langchain::Instrumentation::OpenTelemetry::TracerProvider.new
        api = Langchain::Instrumentation::OpenTelemetry::TraceAPI.set_tracer_provider(provider)
        provider.add_span_processor(
          Langchain::Instrumentation::OpenTelemetry::Export::SimpleSpanProcessor.new(
            Langchain::Instrumentation::OpenTelemetry::Export::OTLPSpanExporter.new(endpoint)
          )
        )

        provider.add_span_processor(
          OpenTelemetry::Export::SimpleSpanProcessor.new(
            OpenTelemetry::Export::ConsoleSpanExporter.new
          )
        )
      end
    end
  end
end
