class ContratoPolicy
  attr_reader :user, :contrato

  def initialize(user, contrato)
    @user = user
    @contrato = contrato
  end

  # Todos los usuarios pueden ver la lista de contratos
  def index?
    true
  end

  def new?
    create?
  end

  # Solo el usuario que creó el contrato o un aistrador puede verlo
  def show?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o' || contrato.user == user
  end

  # Solo los aistradores o usuarios con permiso especial pueden crear contratos
  def create?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o'
  end

  # Solo el creador del contrato o un aistrador puede editarlo
  def update?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o' || contrato.user == user
  end

  # Solo el creador del contrato o un aistrador puede eliminarlo
  def destroy?
    user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o' || contrato.user == user
  end

  def download?
    # Lógica de autorización
    # Ejemplo: permitir solo a usuarios administradores o el dueño del contrato
    user.tipo_de_usuario == 'a' || record.user_id == user.id || user.tipo_de_usuario == 'o'
  end

  # Scope para filtrar los contratos visibles para el usuario
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.tipo_de_usuario == 'a' || user.tipo_de_usuario == 'o'
        scope.all
      else
        scope.where(user: user)
      end
    end

    private

    attr_reader :user, :scope
  end
end
