class UserManagerController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin # Asegura que solo los usuarios de tipo "a" tengan acceso
  before_action :set_user, only: [:show, :update_user_type ,:destroy]

  def index
    @users = policy_scope(User)
    authorize User
  end

  def show
    authorize @user
  end

  def update_user_type
    authorize @user
    if @user.update(tipo_de_usuario: params[:user][:tipo_de_usuario])
      redirect_to user_manager_index_path, notice: 'Tipo de usuario actualizado con éxito.'
    else
      redirect_to user_manager_index_path, alert: 'Error al actualizar el tipo de usuario.'
    end
  end

  private

  # Asegura que el usuario actual sea un administrador
  def authorize_admin
    unless current_user.tipo_de_usuario == 'a'
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta sección.'
    end
  end

  # Encuentra el usuario especificado por ID
  def set_user
    @user = User.find(params[:id])
  end
end
