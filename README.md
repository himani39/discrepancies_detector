This is a service that compares the Ad Campaigns stored in database with a remote Ad Service and returns the discripancies(if any).

### Assumptions:
- The service has permissions to access the campaigns database and this database is postgres.
- There are no duplicates in the campaigns database. Hence there is only one record for every Ad.