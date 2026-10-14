class DepartmentsController < ApplicationController
  allow_unauthenticated_access

  def show
    @department = Category.departments.includes(children: :children).find_by!(slug: params[:department_slug])
  end
end
