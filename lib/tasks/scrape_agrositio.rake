# lib/tasks/scrape_agrositio.rake
namespace :scrape do
  desc 'Scrape and save precios from Agrositio'

  task agrositio: :environment do
    Precio.delete_all
    url = 'https://www.agrositio.com.ar/'
    uri = URI.parse(url)
    html = uri.open.read
    doc = Nokogiri::HTML(html)

    # Locate the table with the specified class
    table = doc.at('table.table.bg-white')

    # Extract information from each row and save it to the database
    table.css('tbody tr').each do |row|
      cells = row.css('td')

      # Check if the cell exists before calling text
      categoria = cells[0]&.text&.strip
      max_precio = cells[1]&.text&.strip
      prom_precio = cells[2]&.text&.strip
      min_precio = cells[3]&.text&.strip
      cantidad_cab = cells[4]&.text&.strip

      # Delete old records before saving new ones


      # Save the data to the database
      Precio.create!(
        categoria: categoria,
        max_precio: max_precio,
        prom_precio: prom_precio,
        min_precio: min_precio,
        cantidad_cab: cantidad_cab
      )
    end

    puts 'Scraping and saving precios from Agrositio completed.'
  end
end
