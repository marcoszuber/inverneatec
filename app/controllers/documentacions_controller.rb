class DocumentacionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_documentacion, only: [:show, :edit, :update, :destroy]

  def index
    @documentacions = policy_scope(Documentacion)
  end

  def show
    @documentacion = Documentacion.find(params[:id])
  end

  def new
    @documentacion = current_user.documentacions.build
    authorize @documentacion # Llama a authorize para autorizar la acción
  end

  def create
    @documentacion = current_user.documentacions.build(documentacion_params)
    authorize @documentacion

    # Adjuntar archivo con Active Storage
    if params[:documentacion][:archivo].present?
      @documentacion.archivo.attach(params[:documentacion][:archivo])
    end

    if @documentacion.save
      redirect_to documentacions_path, notice: 'Documentación creada exitosamente.'
    else
      render :new
    end
  end


  def destroy
    @documentacion.destroy
    redirect_to documentacions_path, notice: 'Documentación eliminada exitosamente.'
  end



  private

  def set_documentacion
    @documentacion = Documentacion.find(params[:id])
    authorize @documentacion
  end


  def documentacion_params
    params.require(:documentacion).permit(:titulo, :comentarios, :archivo)
  end
end
