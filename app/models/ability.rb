class Ability
  include CanCan::Ability

  def initialize user
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    # actions: :read, :create, :update, :destroy; :manage
    # resource: :all or class name
    # final: conditions hash

    # can :read, User
    can :create, [Payments::Paypal::Transaction] # , Paypal::Preapproval]
    can :create, [Payments::Stripe::Charge] # , Paypal::Preapproval]

    # user ||= User.new # guest user (not logged in)
    if user
      can :manage, User, id: user.id
      can :manage, :all if user.is_admin?
      if user.is_alpha?
        can :read, [Fec::Candidate, Fec::Committee, Initiative]
        can :create, Profile
        can :read, Profile
        can :manage, [Initiative, Committee]
        # can :manage, [Payments::Paypal::Transaction], # Paypal::Preapproval],
        #     user_id: user.id
        can :manage, [Payments::Stripe::Charge],
            user_id: user.id
        can :manage, [Cart, CartItem],
            user_id: user.id
      end
    end
  end
end
