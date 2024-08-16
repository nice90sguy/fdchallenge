LIST employer = (silverman=100), food_bank=50, own_project=0, bella_org=0

=== function employer_name
{employer:
- silverman:
    ~ return "Silverman Brothers"
- food_bank:
    ~ return "Al's Food for All"
- bella_org:
    ~ return BELLA_FULL_NAME + " Inc."
- own_project:
    ~ return "yourself"
}

=== function daily_contract_rate
~ return LIST_VALUE(employer) * 10

=== function hourly_contract_rate

~ return LIST_VALUE(employer)
