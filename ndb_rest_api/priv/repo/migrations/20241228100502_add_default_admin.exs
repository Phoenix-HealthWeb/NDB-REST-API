defmodule NdbRestApi.Repo.Migrations.AddDefaultAdmin do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO admins (email, hashed_password, confirmed_at, inserted_at, updated_at)
    VALUES (
      'admin@gmail.com',
      '$2b$12$NBsPx83PJyO8g73/sBM1d.R57HcZT4aXB8z7GCeqvpRa5gC61Gh5e', -- hashed password for 'qwertyuiopas'
      NOW(),
      NOW(),
      NOW()
    )
    """)
  end
end
