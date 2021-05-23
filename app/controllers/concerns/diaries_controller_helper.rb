# frozen_string_literal: true

# preliminary work for index page
module DiariesControllerHelper
  def prepare_instance_variable
    idx_helper = DiariesIndexHelper.new @user
    buttons = idx_helper.index_view_input
    buttons
  end
end
