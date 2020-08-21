# frozen_string_literal: true

require 'spec_helper'

describe Rambling::Trie::Configuration::Properties do
  let(:properties) { Rambling::Trie::Configuration::Properties.new }

  describe '.new' do
    it 'configures the serializers' do
      serializers = properties.serializers

      unless RUBY_ENGINE == 'opal'
        expect(serializers.formats).to match_array %i(marshal yaml yml zip)        
        expect(serializers.providers.to_a).to match_array [
          [:marshal, Rambling::Trie::Serializers::Marshal],
          [:yaml, Rambling::Trie::Serializers::Yaml],
          [:yml, Rambling::Trie::Serializers::Yaml],
          [:zip, Rambling::Trie::Serializers::Zip],
        ]
      end
    end

    it 'configures the readers' do
      readers = properties.readers

      expect(readers.formats).to match_array %i(txt)
      expect(readers.providers.to_a).to match_array [
        [:txt, Rambling::Trie::Readers::PlainText],
      ]
    end

    it 'configures the compressor' do
      compressor = properties.compressor
      expect(compressor).to be_instance_of Rambling::Trie::Compressor
    end

    it 'configures the root_builder' do
      root = properties.root_builder.call
      expect(root).to be_instance_of Rambling::Trie::Nodes::Raw
    end
  end

  describe '#reset' do
    before do
      properties.serializers.add :test, 'test'
      properties.readers.add :test, 'test'
    end

    it 'resets the serializers and readers to initial values' do
      expect(properties.serializers.formats).to include :test
      expect(properties.readers.formats).to include :test

      properties.reset

      expect(properties.serializers.formats).not_to include :test
      expect(properties.readers.formats).not_to include :test
    end
  end
end
