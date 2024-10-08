# LangchainRuby

Langchain Ruby differs from LangchainRb in the following ways:

| Feature/Aspect                                                    | Langchain Ruby | LangchainRb |
| ----------------------------------------------------------------- | -------------- | ----------- |
| **Feature Parity with Langchain Python and Javascript libraries** | ✅             | ❌          |
| **Wraps Python Library**                                          | ✅             | ❌          |
| **Access to Complete Langchain Ecosystem**                        | ✅             | ❌          |
| **Support for Observability (e.g., Arize Phoenix)**               | ✅             | ❌          |
| **Support for LangGraph**                                         | ✅             | ❌          |
| **Better Stack Tracing in Ruby**                                  | ❌             | ✅          |
| **Feature Limited Compared to Langchain**                         | ❌             | ✅          |

# Setup Arize Phoenix

Arize will provide open source tracing similar to LangSmith. In many environments you can simply run:

```
docker run -p 6006:6006 -i -t arizephoenix/phoenix
```

But on Apple Silicon you need to re-build the image first:

```
git clone https://github.com/Arize-ai/phoenix.git
cd phoenix
```

Edit the Dockerfile to select the base image `gcr.io/distroless/python3-debian12:nonroot-arm64`

```
docker build -t arizephoenix/phoenix .
```

# Call LLM With Instrumentation:

```ruby
Langchain::Instrumentation.configure(
    provider: :phoenix,
    endpoint: "http://127.0.0.1:6006/v1/traces"
)

Langchain::LLMs::Ollama.new("qwen2").invoke("Hello world")
```

# Using Prompts:

```ruby
require_relative "lib/langchain"

example_prompt = Langchain::Prompts::PromptTemplate.from_template(
  template: "Input: {input}\nOutput: {output}",
  input_variables: %w[input output]
)

few_shot = Langchain::Prompts::FewShotPromptTemplate.new(
  examples: [
    { "input" => "What is the capital of France?", "output" => "Paris" },
    { "input" => "What is 2 + 2?", "output" => "4" }
  ],
  example_prompt: example_prompt,
  prefix: "Here are some examples:",
  suffix: "Please answer the question based on the examples provided above: {input}",
  input_variables: example_prompt.input_variables,
  example_separator: "\n\n"
)

prompt = few_shot.format(input: "What is the capital of the USA?")

Langchain::Instrumentation.configure(
  provider: :phoenix,
  endpoint: "http://127.0.0.1:6006/v1/traces"
)

Langchain::LLMs::Ollama.new("qwen2").invoke(prompt)
```

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/langchain_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/langchain_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/langchain_ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LangchainRuby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/langchain_ruby/blob/main/CODE_OF_CONDUCT.md).
