PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO schema_migrations VALUES('20220428082658');
INSERT INTO schema_migrations VALUES('20220428083248');
INSERT INTO schema_migrations VALUES('20220428092114');
INSERT INTO schema_migrations VALUES('20220503070214');
INSERT INTO schema_migrations VALUES('20220503070259');
INSERT INTO schema_migrations VALUES('20220503091736');
INSERT INTO schema_migrations VALUES('20220504081244');
INSERT INTO schema_migrations VALUES('20220504092013');
INSERT INTO schema_migrations VALUES('20220504114704');
INSERT INTO schema_migrations VALUES('20220505075814');
INSERT INTO schema_migrations VALUES('20220505083612');
INSERT INTO schema_migrations VALUES('20220505084418');
INSERT INTO schema_migrations VALUES('20220505084655');
INSERT INTO schema_migrations VALUES('20220505085329');
INSERT INTO schema_migrations VALUES('20220509111115');
INSERT INTO schema_migrations VALUES('20220516111613');
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO ar_internal_metadata VALUES('environment','test','2022-06-09 11:03:13.785243','2022-06-09 11:03:13.785243');
CREATE TABLE IF NOT EXISTS "peliculas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar, "fecha_estreno" date, "sinopsis" text, "poster" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "tipo" varchar);
CREATE TABLE IF NOT EXISTS "usuarios" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar, "email" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "password_digest" varchar, "foto" varchar, "admin" boolean DEFAULT 0);
CREATE TABLE IF NOT EXISTS "generos" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "plataformas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar, "foto" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "friendships" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "usuario_id" integer, "amigo_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_a4695a5ddd"
FOREIGN KEY ("usuario_id")
  REFERENCES "usuarios" ("id")
);
CREATE TABLE IF NOT EXISTS "lists" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre_lista" varchar, "usuario_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "genero_peliculas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "pelicula_id" integer, "genero_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "list_peliculas" ("id" integer NOT NULL PRIMARY KEY, "pelicula_id" integer DEFAULT NULL, "list_id" integer DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "plataforma_peliculas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "plataforma_id" integer, "pelicula_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "personas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar, "departamento" varchar, "biografía" text, "fecha_nac" date, "fecha_fall" date, "nacionalidad" varchar, "foto" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "persona_peliculas" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "pelicula_id" integer, "persona_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar NOT NULL, "created_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" integer NOT NULL, "blob_id" integer NOT NULL, "created_at" datetime NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" integer NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
DELETE FROM sqlite_sequence;
CREATE INDEX "index_friendships_on_usuario_id" ON "friendships" ("usuario_id");
CREATE INDEX "index_friendships_on_amigo_id" ON "friendships" ("amigo_id");
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key");
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id");
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id");
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest");
COMMIT;
