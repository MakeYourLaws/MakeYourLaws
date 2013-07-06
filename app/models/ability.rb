class Ability
  include CanCan::Ability

  def initialize user
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    # actions: :read, :create, :update, :destroy; :manage
    # resource: :all or class name
    # final: conditions hash
    
    can :read, [User, Fec::Candidate, Fec::Committee, Initiative]
    can :create, [Paypal::Transaction]#, Paypal::Preapproval]
    can :create, [Stripe::Charge]#, Paypal::Preapproval]
    
    # user ||= User.new # guest user (not logged in)
    if user
      if user.id == 1 # admin? 
        can :manage, :all
      else
        can :manage, [Initiative, Committee]
        can :manage, User, :id => user.id
        can :manage, [Paypal::Transaction, Cart], #Paypal::Preapproval], 
          :user_id => user.id
        can :manage, [Stripe::Charge, Cart],
          :user_id => user.id
      end
    end
  end
end
