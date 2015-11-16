require 'spec_helper'
require 'models/concerns/searchable_spec'

shared_examples_for University::Questions::Searchable do
  it_behaves_like University::Searchable

  let(:questions) { 10.times.map { |record| create :question } }

  before :each do
    University::Question.autoimport = true

    University::Question.probe.index.reload do
      questions
    end
  end

  describe '.search' do
    it 'searches questions by fulltext query' do
      questions = []

      questions << create(:question, title: 'One')
      questions << create(:question, tag_list: 'one, two')
      questions << create(:question, text: 'One Two Three')

      results = University::Question.search_by(q: 'Three')

      expect(results.size).to eql(1)
      expect(results.first).to eql(questions.last)

      results = University::Question.search_by(q: 'one')

      expect(results.size).to eql(3)
      expect(results.sort).to eql(questions.sort)
    end
  end
end
