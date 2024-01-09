# app/controllers/archivos_controller.rb
class ArchivosController < ApplicationController
  def index
    @archivos = Archivo.all
  end

  def new
    @archivo = Archivo.new
  end

  def create
    return redirect_to new_archivo_path, alert: "Por favor, carga un archivo CSV" unless params[:archivo].present?

    begin
      archivo = Archivo.new(archivo_params)

      if archivo.save
        file = params[:archivo][:archivo].tempfile
        csv_text = File.read(file, encoding: 'ISO-8859-1').gsub(/(?<!\r)\n/, "\r\n")
        nombre_archivo = params[:archivo][:archivo].original_filename

        ActiveRecord::Base.transaction do
          CSV.parse(csv_text, col_sep: ";", headers: true, encoding: 'ISO-8859-1') do |row|
            next if row.to_h.values.all?(&:blank?) # Saltar líneas en blanco

            muestreo_params = {
              numero_muestro: nombre_archivo,
              peso: row['Peso'],
              gdm: row['GDM'],
              notas_sobre_el_animal: row['Notas sobre el animal'],
              ide: row['IDE'],
              origen: row['Origen'],
              sexo: row['Sexo'],
              tropa: row['Tropa'],
              gdm_total: row['GDM total'],
              gpv: row['GPV'],
              gpv_total: row['GPV total'],
              dias: row['Dias'],
              total_de_dias: row['Total de dias'],
              destino: row['Destino'],
              fecha: row['Fecha'] ? Date.parse(row['Fecha']) : nil,
              hora: row['Hora'] ? Time.parse(row['Hora']) : nil,
              archivo_id: archivo.id
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
    @muestreos = @archivo.muestreos
  end

  def destroy
    @archivo = Archivo.find(params[:id])
    @archivo.destroy
    redirect_to archivos_path, notice: "Archivo eliminado exitosamente."
  end

  private

  def archivo_params
    params.require(:archivo).permit(:titulo, :descripcion, :notas)
  end
end
