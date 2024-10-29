class UserPolicy < ApplicationPolicy
  def update_user_type?
    user.tipo_de_usuario == 'a'
  end

  class Scope < Scope
    def resolve
      # Solo los administradores pueden ver la lista completa de usuarios
      if user.tipo_de_usuario == 'a'
        scope.all
      else
        scope.none
      end
    end
  end
end
