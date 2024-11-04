class DocumentacionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Ajusta la lógica según quién debería ver las documentaciones
      if user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o'
        scope.all
      else
        scope.where(user: user) # Solo el usuario dueño de la documentación la puede ver
      end
    end
  end

  def index?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o'
  end

  def show?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o' || record.user == user
  end

  def create?
    true # Ajusta según las necesidades de tu aplicación
  end

  def update?
    record.user == user || user.tipo_de_usuario == 'a'
  end

  def destroy?
    record.user == user || user.tipo_de_usuario == 'a'
  end
end
