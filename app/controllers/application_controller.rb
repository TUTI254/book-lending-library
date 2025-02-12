class ApplicationController < ActionController::Base
  allow_unauthenticated_access only: %i[index show]
end
