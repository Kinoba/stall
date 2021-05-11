Stall.configure do |config|
  # Store name used by the system when a human readable identifier for your
  # store is needed, e.g. for payment gateways
  #
  config.store_name = "My stall (Change me in config/initializers/stall.rb)"

  # Configure the admin e-mail to which order notifications will be sent
  #
  # Either set the `STALL_ADMIN_EMAIL` env var or use the below config.
  #
  # You can also set that param as a proc / lambda that will get the cart
  # as argument, allowing you to dynamically define which e-mail to send
  # notifications *to*
  #
  # config.admin_email = ENV['STALL_ADMIN_EMAIL']

  # Configure the e-mail address used to send e-mails to customers for
  # order notifications
  #
  # Either set the `STALL_SENDER_EMAIL` env var or use the below config
  #
  # You can also set that param as a proc / lambda that will get the cart
  # as argument, allowing you to dynamically define which e-mail to send
  # notifications *from*
  #
  # config.sender_email = ENV['STALL_SENDER_EMAIL']

  # Global default VAT rate, can be overrided by products
  #
  # config.vat_rate = BigDecimal('20.0')

  # Defines the default number of decimals precision used in prices
  #
  # config.prices_precision = 2

  # Override the controllers used in stall's default routing.
  #
  # This allows to extend or replace default controller behaviors by providing
  # a route-compatible controller name with the right key
  #
  # Please read the routes source to see which controllers your can override
  # with this config :
  #
  #   https://github.com/rails-stall/stall/blob/master/lib/stall/routes.rb
  #
  # Note : If you define controllers here that inherit from stall controllers,
  #        to extend their behavior, please fill the `config.default_layout`
  #        config to avoid layout issues, or define the `#set_stall_layout`
  #        in your controllers, returing the layout name to render, or set
  #        the `.layout` macro in your controller.
  #
  # config.controllers = { products: 'products' }

  # User omniauth providers that will be allowed for customers to authenticate
  # with.
  #
  # For each activated integration, you need to add the app id and secret key
  # environment variables.
  #
  #   Example :
  #
  #     For Facebook, add the FACEBOOK_APP_ID and FACEBOOK_SECRET_KEY environment
  #     variables.
  #
  # If you prefer, you can pass the app id and secret key to the
  # config.omniauth_provider options.
  #
  #   Example :
  #
  #     config.omniauth_provider :facebook, app_id: '000000', secret_key; 'xxxxxx'
  #
  # Note that Facebook and Google omniauth integrations are included by default,
  # and you can remove them as you want, but if you want to add a new provider,
  # you'll have to include the `omniauth-<provider_name>` gem in your app's
  # Gemfile to make it work.
  #
  # config.omniauth_provider :facebook
  # config.omniauth_provider :google_oauth2, display_name: 'Google', icon: 'google'

  # Configure `devise_for :user` call, if you need to customize some
  # controllers behavior.
  #
  # config.devise_for_user_config = {
  #  controllers: { omniauth_callbacks: 'stall/omniauth_callbacks' }
  # }

  # Default engine's controllers ancestor class
  #
  # config.application_controller_ancestor = '::ApplicationController'

  # Set a layout to use across all stall controllers
  #
  # The default is set to nil, which will make the controllers inherit from the
  # layout of the controller set in `config.application_controller_ancestor`
  #
  # config.default_layout = nil

  # Set a layout to use in the checkouts controllers
  #
  # The default is set to nil, which will make it inherit from the
  # `default_checkout` config behavior defined above.
  #
  # config.checkout_layout = nil

  # Defines the parent mailer for the Stall customer and admin mailers
  #
  # If commented out, ActionMailer::Base will be used
  #
  config.mailers_parent_class = 'ApplicationMailer'

  # Default currency used in the app for money objects.
  #
  # Note : If you need multi currency support in your app, you'll have to ensure
  # that you create your line items, carts and orders with the right currency
  # set.
  #
  # config.default_currency = 'EUR'

  # Define if inventory levels should be managed through variants stocks.
  #
  # It defaults to `false`, allowing customers to order any quantity of products
  # at the same time, but can be set to true, which would allow managing
  # stocks for every variants and add inventory levels handling when adding
  # to cart and on payment.
  #
  # config.manage_inventory = false

  # Default app domain use for building URLs in payment gateway forms and in
  # e-mails.
  #
  # Add the `APP_DOMAIN` environment variable, or modify the parameter below.
  #
  # Ex : 'localhost:3000', 'www.example.com'
  #
  # config.default_app_domain = ENV['APP_DOMAIN']

  # Defined the default checkout wizard used for checking carts out in the
  # shop process.
  #
  # Checkout wizards are used to customize the checkout steps.
  #
  # A default one is generated on stall's installation and can be found in your
  # app at : lib/default_checkout_wizard.rb
  #
  # Note :
  #
  #   If you do not autoload files in your app's lib folder, please require your
  #   checkout wizard with the following command here
  #
  #     require 'default_checkout_wizard'
  #
  #
  #
  # config.default_checkout_wizard = 'DefaultCheckoutWizard'

  # Default line items weight when added to cart and no weight is found on
  # the sellable
  #
  # This allows for simply setting a weight here and not in each product
  # to calculate shipping fees depending on the total cart weight
  #
  # config.default_product_weight = 0

  # When a cart total balance is negative, automatically convert the remaining
  # amount into a credit note for the cart customer
  #
  # Defaults to false, losing the remainder for the customer when paid
  #
  # config.convert_cart_remainder_to_credit_note = false

  # Allows configuring which countries are available for free shipping offers
  #
  # Accepts an array of country codes or a proc with an Address argument
  #
  # Defaults to nil, which means all countries are available
  #
  # config.shipping.free_shipping.available = nil

  # Register custom shipping methods and calculators
  #
  # If no existing shipping method / calculator cover your needs, you can
  # create one by subclassing Stall::Shipping::Calculator
  #
  # Read more at : https://github.com/rails-stall/stall/wiki/Shipping-methods
  #
  # config.shipping.register_calculator :my_calculator, 'MyCalculator'

  # Register custom payment methods and gateways
  #
  # If no existing payment method / gateway cover your needs, you can
  # create one by subclassing Stall::Payments::Gateway
  #
  # Read more at : https://github.com/rails-stall/stall/wiki/Payment-methods
  #
  # config.payment.register_gateway :my_gateway, 'MyGateway'

  # Allows hooking into checkout steps initialization in the steps controller
  # to inject dependencies to all or a specific step
  #
  # config.steps_initialization do |step|
  #   # Add the `current_user` in all steps
  #   step.inject(:current_user, current_user)
  #   # Only inject in the :some step :
  #   step.inject(:ip, request.remote_ip) if SomeCheckoutStep === step
  # end

  # Configure app services to override default Stall services and add
  # functionalities to existing ones
  #
  # config.services = {
  #   payment_notification: 'PaymentNotificationService'
  # }

  # Delay before empty carts are cleaned with the `stall:carts:clean` task
  #
  # config.empty_carts_expires_after = 1.day

  # Delay before aborted carts are cleaned with the `stall:carts:clean` task
  #
  # Aborted carts are controlled with a scope on the cart model. To change
  # the `aborted` behavior, you can override the `.aborted` scope in your model.
  #
  # config.aborted_carts_expires_after = 14.days
end
