require "active_support/all"

module Langchain
  module Instrumentation
    require_relative "instrumentation/opentelemetry"
    require_relative "instrumentation/openinference"

    DEFAULTS = {
      phoenix: {
        endpoint: "http://127.0.0.1:6006/v1/traces",
        instrumentor: OpenInference::LangchainInstrumentor,
        trace_provider: OpenTelemetry
      }
    }

    def self.configure(config = {})
      provider = (config.dig(:provider) || :phoenix).to_sym
      config.reverse_merge!(DEFAULTS[provider])
      endpoint = config.dig(:endpoint)
      instrumentor = config.dig(:instrumentor)
      trace_provider = config.dig(:trace_provider)

      trace_provider.configure(endpoint)
      instrumentor.new.instrument
      puts "Instrumentation provider: #{provider}"
    end
  end
end
