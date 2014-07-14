class CreateCoinbase < ActiveRecord::Migration
  def change

    # To get currently authenticated coinbase_user (for all the user-tied items):
    # COINBASE.get('/account_changes').current_user
    # COINBASE.transactions.current_user

    create_table :currencies do |t|
      t.string :name
      t.string :abbreviation, limit: 3
      t.index :abbreviation
    end

    columns = [:name, :abbreviation]
    values = [["Afghan Afghani (AFN)","AFN"],["Albanian Lek (ALL)","ALL"],["Algerian Dinar (DZD)","DZD"],["Angolan Kwanza (AOA)","AOA"],["Argentine Peso (ARS)","ARS"],["Armenian Dram (AMD)","AMD"],["Aruban Florin (AWG)","AWG"],["Australian Dollar (AUD)","AUD"],["Azerbaijani Manat (AZN)","AZN"],["Bahamian Dollar (BSD)","BSD"],["Bahraini Dinar (BHD)","BHD"],["Bangladeshi Taka (BDT)","BDT"],["Barbadian Dollar (BBD)","BBD"],["Belarusian Ruble (BYR)","BYR"],["Belize Dollar (BZD)","BZD"],["Bermudian Dollar (BMD)","BMD"],["Bhutanese Ngultrum (BTN)","BTN"],["Bolivian Boliviano (BOB)","BOB"],["Bosnia and Herzegovina Convertible Mark (BAM)","BAM"],["Botswana Pula (BWP)","BWP"],["Brazilian Real (BRL)","BRL"],["British Pound (GBP)","GBP"],["Brunei Dollar (BND)","BND"],["Bulgarian Lev (BGN)","BGN"],["Burundian Franc (BIF)","BIF"],["Cambodian Riel (KHR)","KHR"],["Canadian Dollar (CAD)","CAD"],["Cape Verdean Escudo (CVE)","CVE"],["Cayman Islands Dollar (KYD)","KYD"],["Central African Cfa Franc (XAF)","XAF"],["Cfp Franc (XPF)","XPF"],["Chilean Peso (CLP)","CLP"],["Chinese Renminbi Yuan (CNY)","CNY"],["Colombian Peso (COP)","COP"],["Comorian Franc (KMF)","KMF"],["Congolese Franc (CDF)","CDF"],["Costa Rican Col\u00f3n (CRC)","CRC"],["Croatian Kuna (HRK)","HRK"],["Cuban Peso (CUP)","CUP"],["Czech Koruna (CZK)","CZK"],["Danish Krone (DKK)","DKK"],["Djiboutian Franc (DJF)","DJF"],["Dominican Peso (DOP)","DOP"],["East Caribbean Dollar (XCD)","XCD"],["Egyptian Pound (EGP)","EGP"],["Eritrean Nakfa (ERN)","ERN"],["Estonian Kroon (EEK)","EEK"],["Ethiopian Birr (ETB)","ETB"],["Euro (EUR)","EUR"],["Falkland Pound (FKP)","FKP"],["Fijian Dollar (FJD)","FJD"],["Gambian Dalasi (GMD)","GMD"],["Georgian Lari (GEL)","GEL"],["Ghanaian Cedi (GHS)","GHS"],["Ghanaian Cedi (GHS)","GHS"],["Gibraltar Pound (GIP)","GIP"],["Guatemalan Quetzal (GTQ)","GTQ"],["Guinean Franc (GNF)","GNF"],["Guyanese Dollar (GYD)","GYD"],["Haitian Gourde (HTG)","HTG"],["Honduran Lempira (HNL)","HNL"],["Hong Kong Dollar (HKD)","HKD"],["Hungarian Forint (HUF)","HUF"],["Icelandic Kr\u00f3na (ISK)","ISK"],["Indian Rupee (INR)","INR"],["Indonesian Rupiah (IDR)","IDR"],["Iranian Rial (IRR)","IRR"],["Iraqi Dinar (IQD)","IQD"],["Israeli New Sheqel (ILS)","ILS"],["Jamaican Dollar (JMD)","JMD"],["Japanese Yen (JPY)","JPY"],["Japanese Yen (JPY)","JPY"],["Jordanian Dinar (JOD)","JOD"],["Kazakhstani Tenge (KZT)","KZT"],["Kenyan Shilling (KES)","KES"],["Kuwaiti Dinar (KWD)","KWD"],["Kyrgyzstani Som (KGS)","KGS"],["Lao Kip (LAK)","LAK"],["Latvian Lats (LVL)","LVL"],["Lebanese Pound (LBP)","LBP"],["Lesotho Loti (LSL)","LSL"],["Liberian Dollar (LRD)","LRD"],["Libyan Dinar (LYD)","LYD"],["Lithuanian Litas (LTL)","LTL"],["Macanese Pataca (MOP)","MOP"],["Macedonian Denar (MKD)","MKD"],["Malagasy Ariary (MGA)","MGA"],["Malawian Kwacha (MWK)","MWK"],["Malaysian Ringgit (MYR)","MYR"],["Maldivian Rufiyaa (MVR)","MVR"],["Mauritanian Ouguiya (MRO)","MRO"],["Mauritian Rupee (MUR)","MUR"],["Mexican Peso (MXN)","MXN"],["Moldovan Leu (MDL)","MDL"],["Mongolian T\u00f6gr\u00f6g (MNT)","MNT"],["Moroccan Dirham (MAD)","MAD"],["Mozambican Metical (MZN)","MZN"],["Myanmar Kyat (MMK)","MMK"],["Namibian Dollar (NAD)","NAD"],["Nepalese Rupee (NPR)","NPR"],["Netherlands Antillean Gulden (ANG)","ANG"],["New Taiwan Dollar (TWD)","TWD"],["New Zealand Dollar (NZD)","NZD"],["Nicaraguan C\u00f3rdoba (NIO)","NIO"],["Nigerian Naira (NGN)","NGN"],["North Korean Won (KPW)","KPW"],["Norwegian Krone (NOK)","NOK"],["Omani Rial (OMR)","OMR"],["Pakistani Rupee (PKR)","PKR"],["Panamanian Balboa (PAB)","PAB"],["Papua New Guinean Kina (PGK)","PGK"],["Paraguayan Guaran\u00ed (PYG)","PYG"],["Peruvian Nuevo Sol (PEN)","PEN"],["Philippine Peso (PHP)","PHP"],["Polish Z\u0142oty (PLN)","PLN"],["Qatari Riyal (QAR)","QAR"],["Romanian Leu (RON)","RON"],["Russian Ruble (RUB)","RUB"],["Rwandan Franc (RWF)","RWF"],["Saint Helenian Pound (SHP)","SHP"],["Salvadoran Col\u00f3n (SVC)","SVC"],["Samoan Tala (WST)","WST"],["Saudi Riyal (SAR)","SAR"],["Serbian Dinar (RSD)","RSD"],["Seychellois Rupee (SCR)","SCR"],["Sierra Leonean Leone (SLL)","SLL"],["Singapore Dollar (SGD)","SGD"],["Solomon Islands Dollar (SBD)","SBD"],["Somali Shilling (SOS)","SOS"],["South African Rand (ZAR)","ZAR"],["South Korean Won (KRW)","KRW"],["Sri Lankan Rupee (LKR)","LKR"],["Sudanese Pound (SDG)","SDG"],["Surinamese Dollar (SRD)","SRD"],["Swazi Lilangeni (SZL)","SZL"],["Swedish Krona (SEK)","SEK"],["Swiss Franc (CHF)","CHF"],["Syrian Pound (SYP)","SYP"],["S\u00e3o Tom\u00e9 and Pr\u00edncipe Dobra (STD)","STD"],["Tajikistani Somoni (TJS)","TJS"],["Tanzanian Shilling (TZS)","TZS"],["Thai Baht (THB)","THB"],["Tongan Pa\u02bbanga (TOP)","TOP"],["Trinidad and Tobago Dollar (TTD)","TTD"],["Tunisian Dinar (TND)","TND"],["Turkish Lira (TRY)","TRY"],["Turkmenistani Manat (TMM)","TMM"],["Turkmenistani Manat (TMM)","TMM"],["Ugandan Shilling (UGX)","UGX"],["Ukrainian Hryvnia (UAH)","UAH"],["United Arab Emirates Dirham (AED)","AED"],["United States Dollar (USD)","USD"],["Uruguayan Peso (UYU)","UYU"],["Uzbekistani Som (UZS)","UZS"],["Vanuatu Vatu (VUV)","VUV"],["Venezuelan Bol\u00edvar (VEF)","VEF"],["Vietnamese \u0110\u1ed3ng (VND)","VND"],["West African Cfa Franc (XOF)","XOF"],["Yemeni Rial (YER)","YER"],["Zambian Kwacha (ZMK)","ZMK"],["Zimbabwean Dollar (ZWL)","ZWL"]]
    Currency.import columns, values

    # COINBASE.accounts(:all_accounts => true)
    create_table :coinbase_accounts do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.string :name
      # returned as ['balance']['amount'] ['balance']['currency']
      t.decimal :balance_amount, precision: 13, scale: 8, null: false # in satoshi?
      t.string :balance_currency, limit: 3, null: false
      # returned as ['native_balance']['amount'] ['native_balance']['currency']
      t.decimal :balance_native_amount, precision: 13, scale: 8, null: false # in USD
      t.string :balance_native_currency, limit: 3, null: false
      t.boolean :primary, null: false
      t.boolean :active, null: false

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_id, unique: true
      t.index :name
      t.index :balance_btc
      t.index [:currency, :balance_native]
    end

    create_table :coinbase_addresses do |t|
      t.string :coinbase_user_id, null: false
      t.string :address, null: false
      t.string :callback_url
      t.string :label
      t.timestamps

      t.index :coinbase_user_id
      t.index :address, unique: true
      t.index :callback_url
    end

    # GET /oauth/applications
    create_table :coinbase_applications do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.string :name, null: false
      t.string :redirect_uri, null: false
      t.integer :num_users, null: false
      t.string :client_id
      t.string :client_secret

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_id, unique: true
      t.index :name, unique: true
    }
    end

    # COINBASE.create_button name, price, description=nil, custom=nil, options={}
    create_table :coinbase_buttons do |t|
      t.string :coinbase_user_id, null: false

      t.string :code, null: false # button code given by Coinbase

      t.string :name, null: false # Name of item shown to user for this request
      t.string :description # Longer description of item / transaction
      t.decimal :price, precision: 13, scale: 8, null: false
      t.string :currency, limit: 3, default: 'USD', null: false
      t.string :custom # eg order, user, etc ID numbers for us

      # for options hash
      t.string :account_id # default is API's primary account
      t.string :type, limit: 15, default: 'donation' # buy_now, donation, subscription
      # Required if type = subscription. never, daily, weekly, every_two_weeks, monthly, quarterly, yearly
      t.string :repeat, limit: 20
      # buy_now_large, buy_now_small, donation_large, donation_small, subscription_large, subscription_small, custom_large, custom_small, none
      t.string :style, limit: 20, default: 'donation_small'
      t.string :text # Default: "Pay with Bitcoin", "Donate Bitcoins", "Subscribe with Bitcoin"
      t.boolean :custom_secure, default: true
      t.string :callback_url # custom callback URL; defaults to using IPN URL set in account
      t.string :success_url # ditto
      t.string :cancel_url # ditto
      t.string :info_url # ditto
      t.boolean :auto_redirect, default: true
      t.boolean :variable_price, default: false
      t.boolean :choose_price, default: false
      t.boolean :include_address, default: false # we collect this ourselves
      t.boolean :include_email, default: false
      t.decimal :price1, :price2, :price3, :price4, :price5 # suggested prices

      t.timestamps

      t.index :coinbase_user_id
      t.index :code, unique: true
      t.index :custom
      t.index [:currency, :price]
      t.index :created_at
      t.index :updated_at
    end

    # Request for a buy or sell
    create_table :coinbase_buys_sells do |t|
      t.string :coinbase_user_id, null: false

      t.boolean :buy, null: false # buy xor sell

      t.decimal :amt, precision: 13, scale: 8, null: false # in BTC
      t.boolean :agree_btc_amount_varies
      t.string :account_id # coinbase_account.coinbase_id
      t.string :payment_method_id # from coinbase payment methods

      t.timestamps

      t.index :coinbase_user_id
      t.index :created_at
      t.index :updated_at
    end

    create_table :coinbase_contacts do |t|
      t.string :coinbase_user_id, null: false
      t.string :email, null: false

      t.index :coinbase_user_id
      t.index :email, unique: true
    end

    create_table :coinbase_exchange_rates do |t|
      t.string :from, limit: 3, null: false
      t.string :to, limit: 3, null: false
      t.decimal :rate, precision: 13, scale: 8, null: false
      t.created_at

      t.index [:from, :to, :created_at], unique: true
    end

    # undocumented; returned by GET /users call
    create_table :coinbase_merchants do |t|
      t.string :coinbase_user_id, null: false

      t.string :company_name
      t.string :logo_medium
      t.string :logo_small
      t.string :logo_url

      t.index :coinbase_user_id
      t.index :company_name
    end


    # COINBASE.create_order_for_button button.button['code']
    # Creates the one-time linked address. Must be done for every button.
    create_table :coinbase_orders do |t|
      t.string :coinbase_user_id, null: false

      t.references :coinbase_button

      t.boolean :errors # returned as array of strings
      t.string :coinbase_id, null: false # returned as ['order']['id']
      t.string :status, limit: 15, null: false # new, completed, canceled
      t.decimal :total_btc_amount, precision: 13, scale: 8, null: false # in satoshi?
      t.string :total_btc_currency, limit: 3, null: false
      t.decimal :total_native_amount, precision: 13, scale: 8, null: false # returned in cents
      t.string :total_native_currency, limit: 3, null: false
      t.string :custom
      t.string :receive_address, null: false
      t.string :button_code, null: false # returned as ['order']['button']['id']

      # under ['transaction']['id'] etc. Only exists after BTC received.
      t.string :transaction_id
      t.string :transaction_hash
      t.integer :transaction_confirmations

      # undocumented but part of return
      t.string :event

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_button_id
      t.index :coinbase_id, unique: true
      t.index :button_code
      t.index :total_btc
      t.index [:status, :currency, :total_native]
      t.index :receive_address
      t.index :created_at
      t.index :updated_at
    end

    create_table :coinbase_payment_methods do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.string :name
      t.boolean :can_buy
      t.boolean :can_sell
      t.boolean :default_buy
      t.boolean :default_sell

      t.index :coinbase_user_id
      t.index :name
      t.index :coinbase_id, unique: true
    end

    # also used for subscribers API call
    create_table :coinbase_recurring_payments do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.string :type, null: false # send, request
      t.string :status, null: false # new, active, paused, completed, canceled
      t.string :to # email, can be blank
      t.string :from # ditto
      t.string :start_type # now, ...?
      t.integer :times # -1 = forever
      t.integer :times_run # if times_run == times, payment stops
      t.string :repeat # daily, monthly, ...
      t.datetime :last_run
      t.datetime :next_run
      t.string :notes
      t.string :description
      t.decimal :amount, precision: 13, scale: 8, null: false
      t.string :currency, limit: 3, null: false
      t.string :custom
      t.string :button_id # coinbase_buttons.code
                          # returned in subscribers as recurring_payment['button']['id']

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_id, unique: true
      t.index [:to, :type, :status, :created_at]
      t.index [:from, :type, :status, :created_at]
    end

    create_table :coinbase_reports do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.string :type, null: false # transaction, ...
      t.string :status
      t.string :email
      t.string :repeat # never, ...
      t.string :time_range # past_30, ...
      t.string :callback_url
      t.string :file_url
      t.integer :times
      t.integer :times_run
      t.datetime :last_run
      t.datetime :next_run

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_id, null: false
      t.index [:type, :status, :last_run]
    end

    create_table :coinbase_subscribers do |t|

    end

    # Has no GET API
    # create_table :coinbase_tokens do |t|
    # end

    create_table :coinbase_transactions do |t|
      t.string :coinbase_user_id, null: false
      t.string :coinbase_id, null: false
      t.decimal :amount, precision: 13, scale: 8, null: false
      t.string :currency, limit: 3, null: false
      t.boolean :request, null: false
      t.string :status, limit: 15, null: false # pending, complete
      t.string :sender_id # :coinbase_user.coinbase_id
      t.string :recipient_id

      # Undocumented but returned
      t.string :idem, :hsh

      t.timestamps

      t.index :coinbase_user_id
      t.index :coinbase_id, unique: true
      t.index [:sender_id, :status]
      t.index [:recipient_id, :status]
      t.index :created_at
      t.index :updated_at
    end

    # Buy or sell by the API user
    create_table :coinbase_transfers do |t|
      t.string :coinbase_user_id, null: false
      t.string :type, limit: 10 # Buy, Sell
      t.string :code
      t.decimal :coinbase_fee_amount, precision: 13, scale: 8, null: false
      t.string :coinbase_fee_currency, limit: 3, null: false
      t.decimal :bank_fee_amount, precision: 13, scale: 8, null: false
      t.string :bank_fee_currency, limit: 3, null: false
      t.datetime :payout_date
      t.string :transaction_id
      t.string :status # Pending, Complete, Canceled, Reversed

      t.decimal :amount, precision: 13, scale: 8, null: false
      t.string :currency, limit: 3, null: false

      t.decimal :total_amount, precision: 13, scale: 8, null: false
      t.string :total_currency, limit: 3, null: false

      t.string :description

      t.timestamps

      t.index :coinbase_user_id
      t.index :code, unique: true
      t.index :transaction_id # coinbase_transactions.coinbase_id
      t.index :created_at
      t.index :updated_at
    end

    create_table :coinbase_users do |t|
      t.string :coinbase_id, null: false
      t.string :name
      t.string :email
      t.string :time_zone # eg "Pacific Time (US & Canada)" or "UTC"
      t.string :native_currency, limit: 3

      t.decimal :balance_amount, precision: 13, scale: 8
      t.string :balance_currency, limit: 3

      t.integer :buy_level
      t.integer :sell_level

      t.decimal :buy_limit_amount, precision: 13, scale: 8
      t.string :buy_limit_currency, limit: 3
      t.decimal :sell_limit_amount, precision: 13, scale: 8
      t.string :sell_limit_currency, limit: 3

      t.references :coinbase_merchant # our ID, since CB doesn't return one

      t.timestamps

      t.index :coinbase_id, unique: true
      t.index :coinbase_merchant_id
      t.index :name
      t.index :email
    end

  end

end
