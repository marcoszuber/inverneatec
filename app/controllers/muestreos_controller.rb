# app/controllers/muestreos_controller.rb
class MuestreosController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def import
    return redirect_to muestreos_path, notice: "Por favor, carga un archivo CSV" unless params[:file].present?

    file = params[:file].tempfile
    csv_text = File.read(file, encoding: 'ISO-8859-1').gsub(/(?<!\r)\n/, "\r\n")
    nombre_archivo = params[:file].original_filename
    begin
      CSV.parse(csv_text, col_sep: ";", headers: true, encoding: 'ISO-8859-1') do |row|
        next if row.to_h.values.all?(&:blank?) # Saltar líneas en blanco

        muestreo_params = {
          numero_muestro: row['Número de Muestro'],
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
          dias: row['Días'],
          total_de_dias: row['Total de días'],
          destino: row['Destino'],
          fecha: row['Fecha'] ? Date.strptime(row['Fecha'], '%d/%m/%y') : nil,
          hora: row['Hora'] ? Time.parse(row['Hora']) : nil,
          archivo_id: archivo.id,
        }

        Muestreo.create!(muestreo_params.compact)
      end

      redirect_to muestreos_path, notice: "Muestreos importados exitosamente."
    rescue CSV::MalformedCSVError => e
      redirect_to muestreos_path, alert: "El archivo CSV está malformado: #{e.message}"
    rescue StandardError => e
      redirect_to muestreos_path, alert: "Error al importar Muestreo: #{e.message}"
    end
  end

  def index
    @muestreos = Muestreo.all
    @muestreo = policy_scope(Muestreo)
  end
end
