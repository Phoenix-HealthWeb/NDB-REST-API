defmodule NdbRestApi.Repo.Migrations.Add10Hospitals do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO hospitals (name, address, region, notes, inserted_at, updated_at)
    VALUES
      ('Ospedale Maggiore Policlinico', 'Via Francesco Sforza, 35, Milano', 'Lombardia', 'Struttura di alta specializzazione', NOW(), NOW()),
      ('Ospedale Niguarda', 'Piazza Ospedale Maggiore, 3, Milano', 'Lombardia', 'Eccellenza per emergenze-urgenze', NOW(), NOW()),
      ('Policlinico Gemelli', 'Largo Agostino Gemelli, 8, Roma', 'Lazio', 'Istituto di ricerca e cura', NOW(), NOW()),
      ('Ospedale Sant Andrea', 'Via di Grottarossa, 1035, Roma', 'Lazio', 'Struttura universitaria', NOW(), NOW()),
      ('Ospedale Santa Maria Nuova', 'Piazza Santa Maria Nuova, 1, Firenze', 'Toscana', 'Fondato nel 1288', NOW(), NOW()),
      ('Ospedale Careggi', 'Viale Pieraccini, 17, Firenze', 'Toscana', 'Azienda ospedaliero-universitaria', NOW(), NOW()),
      ('Ospedale San Martino', 'Largo Rosanna Benzi, 10, Genova', 'Liguria', 'Tra i più grandi d Europa', NOW(), NOW()),
      ('Ospedale Papa Giovanni XXIII', 'Piazza OMS, 1, Bergamo', 'Lombardia', 'Struttura all avanguardia', NOW(), NOW()),
      ('Ospedale Cardarelli', 'Via Antonio Cardarelli, 9, Napoli', 'Campania', 'Tra i più grandi del Sud Italia', NOW(), NOW()),
      ('Policlinico di Bari', 'Piazza Giulio Cesare, 11, Bari', 'Puglia', 'Struttura di formazione e ricerca', NOW(), NOW());
    """)
  end
end
