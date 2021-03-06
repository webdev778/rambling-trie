# frozen_string_literal: true

require 'spec_helper'

describe Rambling::Trie::Serializers::Yaml do
  it_behaves_like 'a serializer' do
    let(:serializer) { Rambling::Trie::Serializers::Yaml.new }
    let(:format) { :yml }

    let(:formatted_content) { YAML.dump content }
  end
end
