module Stall
  module Checkout
    class StepForm
      include ActiveModel::Validations

      class_attribute :nested_forms

      attr_reader :object, :step

      delegate :errors, to: :object

      def initialize(object, step)
        @object = object
        @step = step
      end

      def validate
        super && validate_nested_forms
      end

      def self.nested(type, &block)
        self.nested_forms ||= {}
        nested_forms[type] = build(&block)
      end

      def self.build(&block)
        Class.new(StepForm, &block)
      end

      def method_missing(method, *args, &block)
        if object.respond_to?(method, true)
          object.send(method, *args, &block)
        else
          step._validation_method_missing(method, *args, &block) || super
        end
      end

      # Override model name instanciation to add a name, since the form classes
      # are anonymous, and ActiveModel::Name does not support unnamed classes
      def model_name
        @model_name ||= ActiveModel::Name.new(self, nil, object.class.name)
      end

      private

      # Validates all registered nested forms
      #
      # Note : We use `forms.map.all?` instead if `forms.all?` to ensure
      # all the validations are called and the iteration does not stop as soon
      # as a validation fails
      #
      def validate_nested_forms
        # If no nested forms are present in the class, just return true since
        # no validation should be tested
        return true unless self.class.nested_forms

        # Run all validations on all nested forms and ensure they're all valid
        self.class.nested_forms.map do |name, form|
          if object.respond_to?(name) && (model = object.send(name))
            Array.wrap(model).map { |m| form.new(m, step).validate }.all?
          else
            # Nested validations shouldn't be run on undefined relations
            true
          end
        end.all?
      end
    end
  end
end