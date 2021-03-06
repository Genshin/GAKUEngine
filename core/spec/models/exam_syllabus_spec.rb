require 'spec_helper_models'

describe Gaku::ExamSyllabus, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :exam }
    it { is_expected.to belong_to :syllabus }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :exam_id }
    it { is_expected.to validate_presence_of :syllabus_id }
    it { is_expected.to validate_uniqueness_of(:syllabus_id).scoped_to(:exam_id).with_message(/Exam already added!/) }
  end
end
