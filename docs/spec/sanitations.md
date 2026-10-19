_Author_:  @DimuthuMadushan \
_Created_: 2026/10/19 \
_Updated_: 2026/10/19 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from PocketSmith. 
The OpenAPI specification is obtained from at [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/pocketsmith/pocketsmith/2.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change `CreateCategoryRequest refund_behaviour` to nullable
- **Original**: The `refund_behaviour` field in `CreateCategoryRequest` was `not nullable`.
- **Updated**: The `refund_behaviour` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

2. Change `UpdateCategoryRequest refund_behaviour` to nullable
- **Original**: The `refund_behaviour` field in `UpdateCategoryRequest` was `not nullable`.
- **Updated**: The `refund_behaviour` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

3. Rewrite generic `Success` response descriptions that carry a body
- **Original**: 46 responses with a body were described only as `Success`.
- **Updated**: Each now names what is returned (for example `The retrieved user accounts`), derived from the operation. `Success` is kept on no-content responses.
- **Reason**: `Success` is uninformative for a typed response and ends up as the return doc comment in the generated client.
- **Note**: Applied to the aligned spec by `tooling/sanitize_spec.py`, not to the original; it must be re-applied after a re-align.

4. Describe the `assignTransactionAttachment` 201 response
- **Original**: The `201` response of `POST /transactions/{id}/attachments` was described only as `Success`.
- **Updated**: The description reads `The attachment assigned to the transaction`.
- **Reason**: `Success` is uninformative for a typed response. This change was made in the original spec `docs/spec/openapi.json`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
