class ContratosController < ApplicationController
  before_action :set_contrato, only: [:show, :edit, :update, :destroy]
  before_action :authorize_contrato, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.tipo_de_usuario == 'a' || current_user.tipo_de_usuario == 'o'
      @contratos = policy_scope(Contrato)
    elsif current_user.tipo_de_usuario == 'c'
      @contratos = policy_scope(Contrato).where(user: current_user)
    else
      # Usuario sin permisos
      Rails.logger.debug "Usuario sin permisos válidos"
      @contratos = policy_scope(Contrato).none # Aplica policy_scope aquí también
      flash[:alert] = "No tienes permisos para ver los contratos actualmente. Comunícate con un administrador."
    end
  end

  def show
    @user = User.find(params[:user_id])
    @contrato = @user.contratos.find(params[:id])
    authorize @contrato
  end

  def new
    @user = User.find(params[:user_id])
    @contrato = Contrato.new
    @users = User.all
    authorize @contrato
  end


  def create
    @contrato = Contrato.new(contrato_params)
    authorize @contrato

    # Convertir los arrays de `gdpv` y `porcentaje_capitalizador` a formato JSON
    @contrato.gdpv = contrato_params[:gdpv].to_json if contrato_params[:gdpv].is_a?(Array)
    @contrato.porcentaje_capitalizador = contrato_params[:porcentaje_capitalizador].to_json if contrato_params[:porcentaje_capitalizador].is_a?(Array)

    if @contrato.save
      redirect_to user_contratos_path(@contrato.user), notice: 'Contrato creado exitosamente.'
    else
      render :new
    end
  end

  def edit
    authorize @contrato
  end

  def update
    authorize @contrato
    if @contrato.update(contrato_params)
      redirect_to user_contratos_path(@contrato.user), notice: 'Contrato creado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    authorize @contrato
    @contrato.destroy
    redirect_to user_contratos_path(@contrato.user)
  end


  private

  def set_contrato
    @contrato = Contrato.find(params[:id])
  end

  def authorize_contrato
    authorize @contrato
  end

  def contrato_params
    params.require(:contrato).permit(
      :user_id, :campo, :acepto_terminos, :fecha_de_aceptacion, :fecha, :capitalizador,
      {capitalista: []}, :vigencia_inicio, :vigencia_fin, :prorroga,
      :obligaciones_capitalizador, :obligaciones_capitalista, :mortandad_tolerada,
      :mortandad_excedida, :encierre, :frecuencia_pesaje, :porcentaje_pesaje,
      :desbaste, { gdpv: [] }, { porcentaje_capitalizador: [] }, :forma_cancelacion
    )
  end


end
