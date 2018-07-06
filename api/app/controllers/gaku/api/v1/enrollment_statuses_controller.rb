module Gaku
  module Api
    module V1
      class EnrollmentStatusesController < BaseController
        # load_and_authorize_resource
        skip_before_action :authenticate_request

        def index
          @enrollment_statuses = Gaku::EnrollmentStatus.all
          collection_respond_to @enrollment_statuses, root: :enrollment_statuses
        end

      end
    end
  end
end
