select
    USER_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    EMAIL, 
    PHONE_NUMBER, 
    CREATED_AT::TIMESTAMPTZ AS CREATED_AT_UTC, 
    UPDATED_AT::TIMESTAMPTZ AS UPDATED_AT_UTC, 
    ADDRESS_ID
from {{ source('postgres', 'users') }}