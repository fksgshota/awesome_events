# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @event_search_form = EventSearchForm.new(event_search_form_params)
    @events = @event_search_form.searchend
  end

  private

  def event_search_form_params
    params.fetch(:event_search_form, {}).permit(:keyword, :start_at).merge(page: params[:page])
  end
end
