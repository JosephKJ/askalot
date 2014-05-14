require 'spec_helper'

shared_examples_for Searchable do
  let(:model)    { described_class }
  let(:factory)  { model.name.underscore.to_sym }
  let(:records) { 10.times.map { |record| create factory } }

  before :each do
    model.probe.index.create

    records

    model.probe.index.flush

    sleep 2
  end

  after :each do
    model.probe.index.delete
  end

  describe '.search' do
    it 'paginates records' do
      results = model.search(page: 0, per_page: 5)

      expect(results.size).to eql(5)
    end
  end

  describe 'after save' do
    it 'updates record' do
      # TODO make more abstract for any attribute, not just Question
      record = create factory

      record.send(:"#{attribute}=", 'Blabla')

      record.save!

      result = model.search_by(q: 'bla*').first

      expect(result.text).to eql('Blabla')
    end
  end
end
