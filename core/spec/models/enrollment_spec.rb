require 'spec_helper_models'

describe Gaku::Enrollment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :student }
    it { is_expected.to belong_to :enrollable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student_id }
    it { is_expected.to validate_presence_of :enrollable_id }
    it { is_expected.to validate_presence_of :enrollable_type }

    it do
      expect(subject).to validate_uniqueness_of(:student_id).scoped_to(%i[enrollable_type enrollable_id])
      # .with_message(/already enrolled/)
    end

    it('ensures inclusion') do
      expect(subject).to validate_inclusion_of(:enrollable_type)
        .in_array(%w[Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity])
    end
  end

  describe 'class_group_semesters_overlap validation' do
    pending 'add message to base if semester overlapping' do
      student  = create(:student)
      semester = create(:active_semester)

      class_group  = create(:class_group_with_active_semester, semester: semester)
      class_group2 = create(:class_group_with_active_semester, semester: semester)

      create(:class_group_enrollment, enrollable: class_group, student: student)

      enrollment = build(:class_group_enrollment, enrollable: class_group2, student: student)

      enrollment.valid?

      expect(enrollment.errors[:base]).to include 'A student cannot belong to two Class Groups with overlapping semesters'
    end
  end
end
