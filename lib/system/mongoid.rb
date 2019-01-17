module System
  module Mongoid
      # Order engine used to order mongoid data
      # It is encapsulated in segment module, because we store here all the
      # things that are related to filtering/ordering data
      #
      # Since it returns the resource/scope that was provided, modified
      # accordingly to sorting rules, this class can be used in defined
      # scopes and it will work with scope chainings
    class Orderable
      # @param resource [Mongoid::Criteria] Mongoid class or a subset
      #   of it (based on Mongoid::Criteria)
      # @param rules [Hash] hash with rules for ordering
      # @return [Mongoid::Criteria] mongoid criteria scope
      # @example
      #   System::Mongoid::Orderable.new(current_app.users, params[:q])
      def initialize(resource, rules = {})
        @rules = rules
        @resource = resource
      end

      # Applies given sort order if there is one.
      # If not, it will do nothing
      # @example Ordered example scope
      #   scope :order, -> order { System::Mongoid::Orderable.new(self, order).apply }
      def apply
        order unless @rules.blank?
        @resource.criteria
      end

      private

      # Sets given order based on order rules (if there are any)
      # or it will do nothing if no valid order rules provided
      def order
        order = "#{@rules[:s]}".split(' ')
        @resource = order.blank? ? @resource : @resource.order_by(order)
      end
    end
  end
end
