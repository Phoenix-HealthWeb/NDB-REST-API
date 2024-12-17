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

# Practitioner [ ]
```sh
mix phx.gen.html Practitioners Practitioner practitioners email:string:unique forename:string surname:string gender_id:references:genders role_id:references:practitioner_roles date_of_birth:date qualification:string
```
```sh
mix phx.gen.json Practitioners Practitioner practitioners email:string:unique forename:string surname:string gender_id:references:genders role_id:references:practitioner_roles date_of_birth:date qualification:string --web api --no-context --no-schema
```
