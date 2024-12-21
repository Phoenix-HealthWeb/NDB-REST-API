# PractitionerRoles [x]
```sh
mix phx.gen.html PractitionerRoles PractitionerRole practitioner_roles name:string
```
```sh
mix phx.gen.json PractitionerRoles PractitionerRole practitioner_roles name:string --web api --no-context --no-schema
```

# Hospital [x]
```sh
mix phx.gen.html Hospitals Hospital hospitals name:string address:string region:string notes:string api_key:string
```
```sh
mix phx.gen.json  Hospitals Hospital hospitals name:string address:string region:string notes:string api_key:string --web api --no-context --no-schema
```

# Practitioner [x]
```sh
mix phx.gen.html Practitioners Practitioner practitioners email:string:unique forename:string surname:string gender_id:references:genders role_id:references:practitioner_roles date_of_birth:date qualification:string
```
```sh
mix phx.gen.json Practitioners Practitioner practitioners email:string:unique forename:string surname:string gender_id:references:genders role_id:references:practitioner_roles date_of_birth:date qualification:string --web api --no-context --no-schema
```

# Hospitals Practitioners many to many [x]

## Create the migration
```sh
mix ecto.gen.migration create_hospitals_practitioners
```
And then customize the migration file: `<date>_create_hospitals_practitioners.exs`

Then run the migrations:
```sh
mix ecto.migrate
```
## Update schemas
And then update the schemas. In `hospital.ex` you have to add:
```elixir
many_to_many :practitioners, NdbRestApi.Practitioners.Practitioner, join_through: "hospitals_practitioners"
```
While in `practitioner.ex` you have to add:
```elixir
many_to_many :hospitals, NdbRestApi.Hospitals.Hospital, join_through: "hospitals_practitioners"
```
## Update controllers
In `hospital_controller.ex` every time you run `Hospitals.list_hospitals()` you have to preload the practitioners:
1. add the alias: `alias NdbRestApi.Repo`
2. update the list hospital by adding `|> Repo.preload(:practitioners)`

Do a similar thing also for `practitioner_controller.ex`

## NEW METHOD
```sh
mix phx.gen.schema HospitalsPractitioners hospitals_practitioners
```