# LangchainRuby

Langchain Ruby differs from LangchainRb in the following ways:

1. Langchain Ruby is at feature parity with Langchain (Python) and Langchain.js
2. Langchain Ruby wraps the Python library, allowing you to use the complete ecosystem, including observability options like Arize Phoenix, as well as LangGraph, and <what else?>
3. LangchainRb is a port to the Ruby language, offering better stack tracing, but because Langchain is massive and constantly evolving, it will likely always be more feature limited.

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

Langchain::Ollama.new("qwen2").invoke("Hello world")
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
