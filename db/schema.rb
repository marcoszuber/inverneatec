# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_04_183822) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "archivos", force: :cascade do |t|
    t.string "titulo"
    t.text "descripcion"
    t.text "notas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contratos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "campo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "acepto_terminos"
    t.datetime "fecha_de_aceptacion"
    t.date "fecha"
    t.string "capitalizador"
    t.string "capitalista"
    t.date "vigencia_inicio"
    t.date "vigencia_fin"
    t.boolean "prorroga"
    t.text "obligaciones_capitalizador"
    t.text "obligaciones_capitalista"
    t.float "mortandad_tolerada"
    t.float "mortandad_excedida"
    t.boolean "encierre"
    t.string "frecuencia_pesaje"
    t.float "porcentaje_pesaje"
    t.float "desbaste"
    t.text "gdpv"
    t.text "porcentaje_capitalizador"
    t.string "forma_cancelacion"
    t.string "titulo"
    t.string "provincia"
    t.string "localidad"
    t.string "coordenadas"
    t.text "referencias_geograficas"
    t.float "superficie_total"
    t.float "superficie_apta_uso"
    t.text "descripcion_establecimiento"
    t.index ["user_id"], name: "index_contratos_on_user_id"
  end

  create_table "documentacions", force: :cascade do |t|
    t.string "titulo"
    t.text "comentarios"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_documentacions_on_user_id"
  end

  create_table "muestreos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "peso"
    t.string "gdm"
    t.text "notas_sobre_el_animal"
    t.string "ide"
    t.string "origen"
    t.string "sexo"
    t.string "tropa"
    t.decimal "gdm_total"
    t.decimal "gpv"
    t.decimal "gpv_total"
    t.integer "dias"
    t.integer "total_de_dias"
    t.string "destino"
    t.date "fecha"
    t.time "hora"
    t.string "numero_muestro"
    t.integer "archivo_id"
    t.index ["archivo_id"], name: "index_muestreos_on_archivo_id"
  end

  create_table "precios", force: :cascade do |t|
    t.string "categoria"
    t.string "max_precio"
    t.string "prom_precio"
    t.string "min_precio"
    t.string "cantidad_cab"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.string "apellido"
    t.string "dni"
    t.string "tipo_de_usuario", default: ""
    t.string "telefono"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contratos", "users"
  add_foreign_key "documentacions", "users"
  add_foreign_key "muestreos", "archivos"
end
