module Deactivateable
  module Controller
    extend ActiveSupport::Concern

    included do
    end

    # TODO add config option here
    def model_name
      a = class_name.split('')
      a[0..-2].join
    end

    def class_name
      self.class.to_s.demodulize.gsub('Controller', '')
    end

    def activate
      instance_variable_set "@#{class_name}", model_name.constantize.find(params["#{model_name.downcase}_id".to_sym])

      if (instance_variable_get("@#{class_name}")).activate!
        redirect_to :back
      else
        render :show
      end
    end

    def deactivate
      instance_variable_set "@#{class_name}", model_name.constantize.find(params["#{model_name.downcase}_id".to_sym])
      if (instance_variable_get("@#{class_name}")).deactivate!
        redirect_to :back
      else
        render :show
      end
    end
  end
end
