require 'httparty'


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Carregamento da classe antes da execução dos testes
  config.before(:all) do
    class HttParty
      include HTTParty
      # URL padrão da API da Marvel
      base_uri 'https://gateway.marvel.com'
    end
  end
end
