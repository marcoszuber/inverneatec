# app/controllers/pages_controller.rb

require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @precios = Precio.all
    @archivos = Archivo.all.reverse[0..2]
  end

  def power

  end



end
