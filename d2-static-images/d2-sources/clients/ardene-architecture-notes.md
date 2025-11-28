# Ardene Architecture Notes

## High Level Architecture (Future-State)

### App → Shopify SDK Data Points

**Question**: What data points are captured when the App communicates with Shopify using the SDK?

The diagram indicates the following data types:
- Purchase Events (Web/App)
- Profile Updates (Web/App)
- X-Store Digital Receipt*

**Unclear**: The mechanism for how X-Store Digital Receipt data is sent from the mobile app to Shopify.

### App → Braze (User/Event Data Update)

**Question**: What specific data points are transmitted in the App → Braze User/Event Data Update flow (marked as interaction #3)?

**Validation Needed**: Confirm whether the current Braze events catalog captures all required data points for this integration.

