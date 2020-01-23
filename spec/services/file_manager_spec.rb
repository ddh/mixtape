require 'spec_helper'

describe Services::FileManager, type: :aruba do

  describe '.read_from_file' do
    let(:provided_file) { 'provided.json' }
    let(:default_file) { 'mixtape.json' }

    before(:each) { write_file(provided_file, 'foobar') }
    before(:each) { write_file(default_file, 'foobar') }
    context 'when file provided' do
      it 'reads from provided file' do
      end
    end

    context 'when file not provided' do
      it 'reads from default file' do
      end
    end
  end

  describe '.write_to_file' do
  end

end