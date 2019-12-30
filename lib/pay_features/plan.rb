require 'active_support/concern'

module PayFeatures
  module Plan
    extend ActiveSupport::Concern

    BIGGEST_AMOUNT = 9_999_999
    SMALLEST_AMOUNT = -9_999_999

    included do
      has_many :plan_features
      has_many :features, through: :plan_features

      belongs_to :previous_plan, class_name: PayFeatures.plan_class, optional: true
      belongs_to :next_plan, class_name: PayFeatures.plan_class, optional: true

      def amount_for(identifier)
        feature = find_feature(identifier)
        return SMALLEST_AMOUNT unless feature
        return feature.amount if feature.amount

        BIGGEST_AMOUNT
      end

      def has_feature?(identifier)
        find_feature(identifier).present?
      end

      def display_features
        display_features = []

        if previous_plan
          previous_plandisplay_features.each do |f|
            display_features << { identifier: f[:identifier], description: f[:description] }
          end
        end

        features.order(:order).each do |f|
          index = display_features.index { |df| df[:identifier] == f.identifier }
          value = { identifier: f.identifier, description: f.description }

          if index
            value.merge!({ new_feature: true })
            display_features[index] = value
          else
            if previous_plan
              value.merge!({ new_feature: true })
            end
            display_features << value
          end
        end

        display_features.flatten
      end

      private

      def previous_plan_display_features
        previous_plan.display_features
      end

      def find_feature(identifier)
        feature = features.find_by(identifier: identifier)

        if feature
          feature
        elsif !feature && previous_plan.present?
          previous_plan.features.find_by(identifier: identifier)
        else
          nil
        end
      end

    end
  end
end