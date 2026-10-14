class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :departments

  private
    # Departamentos com as categorias filhas, usados no menu do layout.
    def departments
      @departments ||= Category.departments.includes(:children).to_a
    end
end
