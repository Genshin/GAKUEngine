require 'spec_helper_models'

describe Gaku::Grading::Collection::Score do

  let(:students) { [create(:student), create(:student)] }

  describe 'initialize' do
    it 'initializes with exam' do
      exam =  create(:exam, :with_portion)
      subject = described_class.new(exam, students)
      expect(subject.grade_exam).to eq [{id: students.first.id, score: 0.0}, {id: students.last.id, score: 0.0}]
    end
  end

end