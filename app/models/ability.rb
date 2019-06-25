# typed: true
class Ability
  include CanCan::Ability

  Configs = {
    'Admin' => {
      :actions => [] #[:read, :create, :update, :destroy]
    },
    'Role' => {
      :actions => [] #[:read, :create, :update, :destroy]
    },
    'User' => {
      :actions => [:read, :create, :update, :destroy]
    }
    # Sample
    # ,
    # 'User' => {
    #   :actions => [:read, :update, :destroy, :export],
    #   :associations => %w(
    #     AsukabuBetConfirmation
    #     Bet
    #     BoardThread
    #     Comment
    #     CommentBad
    #     CommentGood
    #     FavoriteUser
    #     RankingScore
    #     StockAnswer
    #     StockAnswerNice
    #     StockHold
    #     StockQuestion
    #     StockWant
    #     UsersThreadBookmark
    #     UserVoiceBad
    #     UserVoiceGood
    #     Voice
    #   ),
    #   :association_actions => [:show]
    # }
  }

  INDEX_MODELS = Configs.keys

  def initialize(admin)
    # Required permissions to make RailsAdmin work
    can [:index, :access, :dashboard], :all
    cannot :read, :all
    can :read, Permission
    can :update, Admin

    # Super admin permissions
    if admin.is_super
      can :manage, [Admin, Role]
      cannot :export, [Admin, Role]
    end

    # Customize actions
    admin.permissions.each do |perm|
      can(perm.action.to_sym, perm.subject_class.constantize)
    end

    Configs.each do |klass, configs|
      next unless configs[:associations]
      asso_actions = configs[:association_actions] || configs[:actions]
      asso_actions.each do |action|
        next unless can?(action.to_sym, klass.constantize)
        configs[:associations].each do |asso_model|
          can(action.to_sym, asso_model.constantize)
        end
      end
    end

    # Exception
    # cannot :update, EmailRequest, status: EmailRequest::STATUS[:successful]
    # cannot [:create], [Comment]

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
