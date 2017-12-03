# consortium-identity
This is draft version of contracts that extends uport indentity management system by allowing users to register in special
`ChairmanRegistry` contract that is source of truth for **chairman => company** mapping. To get registered as chairman user
must get validated by `Oracle` that is contract that allows special predefined group of addresses to vote for registration
given user as a chairman of certain company.
