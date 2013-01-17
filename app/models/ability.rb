class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif not user.id.nil?
      # logged in
      can [:read, :view, :new], Score

      # can edit own scores (scores where user_id == current_user.id)
      can :edit, Score, user_id: user.id
      cannot [:destroy, :edit], Score
    else
      can [:read, :view], Score
      cannot [:new, :edit, :destroy], Score
    end

  end
end
