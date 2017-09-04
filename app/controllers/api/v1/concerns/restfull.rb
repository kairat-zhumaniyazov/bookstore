module Api::V1::Concerns
  module Restfull
    extend ActiveSupport::Concern

    included do
      before_action :load_record, only: [:show, :update, :destroy]
    end

    def show
      respond_with @record
    end

    def index
      respond_with model_class.all
    end

    def create
      @record = model_class.create(permited_params)
      respond_with :api, :v1, @record
    end

    def update
      @record.update_attributes(permited_params)
      respond_with @record do |format|
        format.json { render json: serializer_model(@record), status: :ok }
      end
    end

    def destroy
      respond_with @record.destroy
    end

    private

    def serializer_model(record)
      "#{model_class}Serializer".constantize.new(record)
    end

    def model_class
      controller_name.classify.constantize
    end

    def load_record
      @record = model_class.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      respond_not_found(e)
    end
  end
end
