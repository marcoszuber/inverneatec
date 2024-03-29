# app/controllers/archivos_controller.rb
class ArchivosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    #inverti la lista de archivos para que se muestre el ultimo primero
    @archivos = Archivo.all.reverse
    @archivo = policy_scope(Archivo)
  end

  def new
    @archivo = Archivo.new
    authorize @archivo
  end

  def create
    return redirect_to new_archivo_path, alert: "Por favor, carga un archivo CSV" unless params[:archivo].present?

    begin
      archivo = Archivo.new(archivo_params)
      authorize archivo

      if archivo.save
        file = params[:archivo][:archivo].tempfile
        csv_text = File.read(file, encoding: 'ISO-8859-1').gsub(/(?<!\r)\n/, "\r\n")
        nombre_archivo = params[:archivo][:archivo].original_filename

        ActiveRecord::Base.transaction do
          CSV.parse(csv_text, col_sep: ";", headers: true, encoding: 'ISO-8859-1') do |row|
            next if row.to_h.values.all?(&:blank?) # Saltar líneas en blanco
            peso = row['Peso'].to_f
            gpv_total = row['GPV total'].to_f

            # Verifica si el denominador no es cero antes de realizar la operación
            denominador = peso - gpv_total
            gdm_total = denominador.zero? ? nil :  (denominador/peso).round(4)*100


            muestreo_params = {
              numero_muestro: row['Número de Muestro'],
              peso: row['Peso'],
              gdm: row['GDM'],
              notas_sobre_el_animal: row['Notas sobre el animal'],
              ide: row['IDE'],
              origen: row['Origen'],
              sexo: row['Sexo'],
              tropa: row['Tropa'],
              gdm_total: gdm_total,
              gpv: row['GPV'],
              gpv_total: row['GPV total'],
              dias: row['Dias'],
              total_de_dias: row['Total de días'],
              destino: row['Destino'],
              fecha: row['Fecha'] ? Date.strptime(row['Fecha'], '%d/%m/%y') : nil,
              hora: row['Hora'] ? Time.parse(row['Hora']) : nil,
              archivo_id: archivo.id,
            }

            Muestreo.create!(muestreo_params.compact)
          end
        end

        redirect_to muestreos_path, notice: "Muestreos importados exitosamente."
      else
        redirect_to new_archivo_path, alert: "Error al crear Archivo: #{archivo.errors.full_messages.join(', ')}"
      end
    rescue CSV::MalformedCSVError => e
      redirect_to new_archivo_path, alert: "El archivo CSV está malformado: #{e.message}"
    rescue StandardError => e
      redirect_to new_archivo_path, alert: "Error al importar Muestreo: #{e.message}"
    end
  end


  def show
    @archivo = Archivo.find(params[:id])
    #Agrega una columna a @archivo con el porcentaje de GPV Total/peso incial

    #crea un promedio del gdm total


    @muestreos = @archivo.muestreos
    gdm_numeros = @archivo.muestreos.pluck(:gdm).map { |gdm| gdm.to_s.gsub(',', '.').to_f }
    #quiero que en datos_grafico me muestre el peso y la cantidad de muestreos que hay en ese rango de peso de 10 en 10 kg
    @datos_grafico = @archivo.muestreos.group(Arel.sql("FLOOR(peso / 10) * 10")).order(Arel.sql("FLOOR(peso / 10) * 10")).count
    @promedio_peso = @archivo.muestreos.average(:peso)
    @promedio_gdm = gdm_numeros.empty? ? 0 : gdm_numeros.compact.sum / gdm_numeros.compact.size
    @promedio_gpv = @archivo.muestreos.average(:gdm_total).nil? ? 100 : @archivo.muestreos.average(:gdm_total).round(2)
    authorize @archivo
  end

  def destroy
    @archivo = Archivo.find(params[:id])
    @archivo.destroy
    redirect_to archivos_path, notice: "Archivo eliminado exitosamente."
    authorize @archivo
  end

  private

  def archivo_params
    params.require(:archivo).permit(:titulo, :descripcion, :notas)
  end
end
