# Facebook Conversions API Tag (Server-Side GTM Template)

A Google Tag Manager **server container** tag template that sends events to the Facebook (Meta) Conversions API. It maps GA4 and Data Client event data onto Meta's server event schema, hashes personal data with SHA-256 before it leaves your container, resolves and restores the `_fbp` and `_fbc` cookies, and can enrich user data from the request headers added by [TrackingHippo.io](https://trackinghippo.io) container modules.

> This is the server-side counterpart to [gtm-facebook-pixel-tag](https://github.com/trackinghippo-io/gtm-facebook-pixel-tag), our web container Facebook Pixel template. Use both together with a shared `event_id` to deduplicate browser and server events.

## Overview

The tag takes the event that arrived in your server container, builds a Conversions API payload from it, and POSTs it to `https://graph.facebook.com/{version}/{dataset-id}/events`. It contacts no other host.

## Features

- **Event name mapping**: inherit the incoming event name (GA4 names such as `purchase` and `view_item` are translated to `Purchase` and `ViewContent`), pick a Meta standard event, or supply a custom name. Unmapped names are forwarded unchanged as custom events.
- **Multiple datasets**: send one event to several Meta datasets, each with its own access token.
- **Automatic mapping** of the server event, `user_data`, `custom_data` and `app_data` objects from the incoming event, with a table of manual overrides for every object.
- **SHA-256 hashing**: personal fields are normalised the way Meta expects (lowercased, punctuation removed, phone numbers reduced to digits) and hashed inside the container. Values that already arrive hashed are detected and passed through untouched.
- **Event enhancement**: remembers the identifying fields of one event in an `HttpOnly` first-party cookie and fills them back in on later events that arrive without them. Only SHA-256 hashes are ever stored.
- **`_fbp` and `_fbc` handling**: reads both cookies, generates `_fbp` when it is missing, builds `_fbc` from the `fbclid` URL parameter, and writes them back as first-party cookies with a configurable lifetime, domain and `HttpOnly` flag.
- **GA4 items → Meta contents**: builds `contents`, `content_ids`, `num_items` and `content_type` from the `items` array, with a configurable item ID key so you can match a catalogue keyed on variants.
- **Deduplication**: `event_id` is picked up automatically from the incoming event so browser and server events collapse into one.
- **Consent gating**: optionally require `ad_storage`, read from `consent_state` or from the Google Consent Mode `x-ga-gcs` signal.
- **Original event data**: supply `event_name`, `event_time`, `event_id` and `order_id` of an earlier event for `AppendValue`.
- **TrackingHippo enrichment**: opt in to fill `external_id` and the address fields from the headers added by our **User ID** and **GEO Headers** container modules.
- **Test events**: `test_event_code` for the Test events tab in Events Manager.
- **App secret proof**, **Graph API version override**, **request timeout**, **optimistic sending** and **logging control** under Advanced.

## Installation

1. Download `template.tpl` from this repository.
2. In your **server** GTM container, go to **Templates**.
3. Click **New** in the **Tag Templates** section.
4. Open the three-dot menu in the top right and select **Import**.
5. Select the downloaded `template.tpl` and save the template.

## Usage

### 1. Get your credentials

In [Events Manager](https://business.facebook.com/events_manager), open your dataset and go to **Settings**:

- The **dataset ID** (also called Pixel ID) is at the top of the page.
- Under **Conversions API**, use **Generate access token**.

Store the access token in a variable rather than pasting it into every tag.

### 2. Create the tag

1. In your server container go to **Tags** → **New**.
2. Choose **Facebook Conversions API by TrackingHippo.io**.
3. Fill in the dataset ID and access token.
4. Leave **Event name** on *Inherit from the incoming event* if your web container sends GA4 events; the mapping below is applied automatically.
5. Add a trigger — usually a Custom trigger on the client that receives your events.

### 3. Verify

Put a value in **Test event code** and watch the **Test events** tab in Events Manager. Remove the code before going live: events sent with a test code are not used for optimisation or attribution.

## Event name mapping

Used when **Event name** is set to *Inherit from the incoming event*:

| Incoming event | Meta event |
| --- | --- |
| `page_view` | `PageView` |
| `view_item`, `view_content` | `ViewContent` |
| `search`, `view_search_results` | `Search` |
| `add_to_cart` | `AddToCart` |
| `add_to_wishlist` | `AddToWishlist` |
| `begin_checkout` | `InitiateCheckout` |
| `add_payment_info`, `add_shipping_info` | `AddPaymentInfo` |
| `purchase` | `Purchase` |
| `generate_lead` | `Lead` |
| `sign_up` | `CompleteRegistration` |
| `contact` | `Contact` |
| `customize_product` | `CustomizeProduct` |
| `donate` | `Donate` |
| `find_location` | `FindLocation` |
| `schedule` | `Schedule` |
| `start_trial` | `StartTrial` |
| `submit_application` | `SubmitApplication` |
| `subscribe` | `Subscribe` |

`view_item_list` maps to `ViewContent` only when you tick **Map view_item_list to ViewContent** — a list impression is a weaker signal than a product detail view. Any other event name is forwarded unchanged as a custom event.

## What gets mapped automatically

### Server event data

| Meta field | Source |
| --- | --- |
| `event_time` | `event_time` or `timestamp` from the event (seconds or milliseconds), otherwise the current time |
| `event_id` | `event_id` |
| `event_source_url` | `page_location`, otherwise the `referer` request header |
| `referrer_url` | `page_referrer` |
| `opt_out` | `opt_out` |
| `data_processing_options*` | the matching event data fields |

### User data

| Meta field | Source |
| --- | --- |
| `em` | `user_data.email_address`, `email`, or `sha256_email_address` |
| `ph` | `user_data.phone_number` or `sha256_phone_number` |
| `fn`, `ln` | `user_data.address.first_name` / `last_name` (or their `sha256_` variants) |
| `ct`, `st`, `zp`, `country` | `user_data.address.city`, `region`, `postal_code`, `country` |
| `db`, `ge` | `user_data.date_of_birth`, `user_data.gender` |
| `external_id` | `user_data.external_id`, then `user_id`, then `client_id` if you enable the fallback |
| `client_ip_address` | `ip_override` |
| `client_user_agent` | `user_agent` |
| `fbp`, `fbc` | the `_fbp` and `_fbc` cookies, generated when missing |

### Custom data

| Meta field | Source |
| --- | --- |
| `value`, `currency` | `value`, `currency` |
| `order_id` | `transaction_id` |
| `search_string` | `search_term` |
| `contents`, `content_ids`, `num_items` | the `items` array |
| `content_name`, `content_category` | `content_name` / `page_title` and the first item's name and category |

Precedence for every object is: automatic mapping → object variable → property table. The table always wins.

## Passing extra fields from the data layer

Any event data key with one of these prefixes is written straight into the matching Meta object, with the prefix stripped. This is the simplest way to send a field the template does not map on its own, for example from a Data Client:

| Prefix | Target |
| --- | --- |
| `x-fb-sed-` | server event |
| `x-fb-ud-` | `user_data` |
| `x-fb-cd-` | `custom_data` |
| `x-fb-ad-` | `app_data` |

For example, `x-fb-cd-delivery_category: "home_delivery"` becomes `custom_data.delivery_category`. Values landing in `user_data` are normalised and hashed like any other user data field.

## Event enhancement

A visitor typically hands over an email address once — in a form, at login, at checkout — while the events that matter most for optimisation happen later. **Remember user data for later events** (in the *User data* section) closes that gap: after each event the tag stores the identifying fields it resolved in a first-party cookie, and on a later event that arrives without them it fills them back in.

| | |
| --- | --- |
| Cookie | `_th_eec`, always `HttpOnly` and `Secure`, `SameSite=Lax` |
| Remembers | `em`, `ph`, `fn`, `ln`, `db`, `ge`, `ct`, `st`, `zp`, `country`, `external_id` |
| Never remembers | `client_ip_address`, `client_user_agent`, `fbp`, `fbc` — these must describe the current request, not an old one |
| Lifetime | Configurable, 30 days by default, refreshed on every event |

Two properties make this safe to switch on:

- **Only hashes are stored.** A value is written to the cookie only when it is already a SHA-256 hash, so the cookie can never contain a readable email address or phone number. If you turn hashing off, nothing is remembered at all.
- **The current event always wins.** Remembered values only fill fields that are empty, so a second visitor on a shared device never inherits the first one's identity from a form submission.

The cookie is `HttpOnly`, so it is invisible to JavaScript in the browser and can only be read by your server container. Consent is evaluated first: when you gate the tag on `ad_storage` and consent is not granted, the tag returns before any user data is built, so nothing is stored.

## Deduplication with the browser pixel

Send the same `event_id` from the browser and from the server, and Meta keeps one of the two. Our [Unique Event ID variable](https://github.com/trackinghippo-io/gtm-unique-event-id-variable) generates a value that is stable per data layer event, which is exactly what deduplication needs:

1. In your web container, set the **Event ID** field of the Facebook Pixel tag to the Unique Event ID variable and push the same value into the data layer.
2. Make sure the value reaches the server container as `event_id`.
3. Leave **Automatically map server event data** on — the tag picks it up.

## TrackingHippo enrichment

Enable **Use TrackingHippo container modules** to fill user data from the request headers our container modules add. Each mapping needs the matching module switched on for your container in the [console](https://trackinghippo.io); without it the header is absent and nothing is added.

| Module | Header | Meta field |
| --- | --- | --- |
| User ID | `X-User-Id` | `external_id` |
| GEO Headers | `X-Geo-City` | `ct` |
| GEO Headers | `X-Geo-Region` | `st` |
| GEO Headers | `X-Geo-Postal-Code` | `zp` |
| GEO Headers | `X-Geo-Country` | `country` |

By default these values only fill fields that are still empty. Geo data derived from an IP address is a fallback, not a replacement for an address the visitor actually gave you — tick **Let module values overwrite existing user data** only if you want the opposite.

Two things to know before you rely on this:

- **GEO Headers is not generally available yet.** It is unlisted in the console until the GeoIP data plane is live, so the `X-Geo-*` headers are empty and the four address mappings add nothing. The **User ID** module is available today.
- **`external_id` from the User ID module is pseudonymous, not a customer ID.** It is derived from the visitor's IP address, user agent and TLS fingerprint with a per-container secret, so it identifies a browsing context rather than a person, and it changes when those inputs change or when you regenerate the container's salt. It raises match quality for anonymous traffic; it is not a substitute for sending your own `user_id` when you have one.

If you also run the **Anonymizer** module, the client IP reaching your container is masked or removed, so `client_ip_address` is weakened or absent by design. Meta still matches on `fbp`, `fbc`, the user agent and any hashed identifiers you send.

## Cookies

The tag reads `_fbp` and `_fbc` from the request and writes them back on the registrable domain of the page with a 90 day lifetime, `Secure` and `SameSite=Lax`.

- **Generate `_fbp`** gives visitors whose browser blocked the Meta Pixel a stable browser ID.
- **Generate `_fbc`** builds the click ID from `fbclid` in the page URL. A fresh click replaces a stored older one.
- **HttpOnly** hides the cookies from JavaScript, which also hides them from the browser Meta Pixel. Only enable it when all Meta tracking runs server side.

## App secret proof

Needed only when the Meta app behind your access token has **Require app secret** enabled. The proof is the HMAC-SHA256 of your access token, keyed with your app secret, in hexadecimal:

```bash
echo -n "YOUR_ACCESS_TOKEN" | openssl dgst -sha256 -hmac "YOUR_APP_SECRET"
```

Compute it once outside the container and store the result in a variable. The template deliberately does not accept a raw app secret, because a server container cannot keep one safely.

## Permissions

| Permission | Used for |
| --- | --- |
| `read_event_data` | reading the incoming event |
| `send_http` | POSTing to `https://graph.facebook.com/*` only |
| `get_cookies` | reading `_fbp`, `_fbc` and `_th_eec` |
| `set_cookies` | writing `_fbp`, `_fbc` and `_th_eec` |
| `read_request` | the `referer` header and the TrackingHippo module headers |
| `logging` | diagnostics, off in production unless you turn it on |

## Development

The template ships with unit tests in the `___TESTS___` section. Open the template in GTM and use **Run tests** in the three-dot menu.

## License

Apache License 2.0 — see [LICENSE](LICENSE).
