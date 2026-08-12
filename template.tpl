___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Facebook Conversions API by TrackingHippo.io",
  "description": "Sends server-side events to the Facebook (Meta) Conversions API. Automatically maps GA4 and Data Client event data to Meta's server event, user_data, custom_data and app_data objects, hashes personal data with SHA-256, resolves and restores _fbp/_fbc, supports multiple datasets, event_id deduplication, consent gating and TrackingHippo.io container module enrichment.",
  "containerContexts": [
    "SERVER"
  ],
  "categories": [
    "ADVERTISING",
    "MARKETING"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "groupConnection",
    "displayName": "Facebook Connection",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "pixelId",
        "displayName": "Dataset (Pixel) ID",
        "simpleValueType": true,
        "help": "The Meta dataset ID, also called Pixel ID. Found in Events Manager under \u003cstrong\u003eData sources\u003c/strong\u003e.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "enableMultiPixel",
            "paramValue": false,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "accessToken",
        "displayName": "Conversions API Access Token",
        "simpleValueType": true,
        "help": "Generated in Events Manager under \u003cstrong\u003eSettings \u003e Conversions API \u003e Generate access token\u003c/strong\u003e. Store it in an environment variable or a lookup table variable rather than pasting it into every tag.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "enableMultiPixel",
            "paramValue": false,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "enableMultiPixel",
        "checkboxText": "Send to multiple datasets",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Send the same event to several Meta datasets. Each dataset needs its own access token."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "pixelTable",
        "displayName": "Datasets",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Dataset (Pixel) ID",
            "name": "pixelId",
            "type": "TEXT",
            "isUnique": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Access Token",
            "name": "accessToken",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "enableMultiPixel",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "newRowButtonText": "Add dataset"
      },
      {
        "type": "TEXT",
        "name": "testEventCode",
        "displayName": "Test event code",
        "simpleValueType": true,
        "help": "Only for the \u003cstrong\u003eTest events\u003c/strong\u003e tab in Events Manager. Remove it before going live — events sent with a test code are not used for optimisation or attribution."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupEvent",
    "displayName": "Event",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "eventNameSource",
        "displayName": "Event name",
        "selectItems": [
          {
            "value": "inherit",
            "displayValue": "Inherit from the incoming event"
          },
          {
            "value": "standard",
            "displayValue": "Standard event"
          },
          {
            "value": "custom",
            "displayValue": "Custom event name"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "inherit",
        "help": "\u003cstrong\u003eInherit\u003c/strong\u003e maps common GA4 event names to their Meta equivalent (for example \u003ccode\u003epurchase\u003c/code\u003e → \u003ccode\u003ePurchase\u003c/code\u003e). Names without a mapping are forwarded unchanged as a custom event."
      },
      {
        "type": "SELECT",
        "name": "standardEventName",
        "displayName": "Standard event",
        "selectItems": [
          {
            "value": "PageView",
            "displayValue": "PageView"
          },
          {
            "value": "ViewContent",
            "displayValue": "ViewContent"
          },
          {
            "value": "Search",
            "displayValue": "Search"
          },
          {
            "value": "AddToCart",
            "displayValue": "AddToCart"
          },
          {
            "value": "AddToWishlist",
            "displayValue": "AddToWishlist"
          },
          {
            "value": "InitiateCheckout",
            "displayValue": "InitiateCheckout"
          },
          {
            "value": "AddPaymentInfo",
            "displayValue": "AddPaymentInfo"
          },
          {
            "value": "Purchase",
            "displayValue": "Purchase"
          },
          {
            "value": "Lead",
            "displayValue": "Lead"
          },
          {
            "value": "CompleteRegistration",
            "displayValue": "CompleteRegistration"
          },
          {
            "value": "Contact",
            "displayValue": "Contact"
          },
          {
            "value": "CustomizeProduct",
            "displayValue": "CustomizeProduct"
          },
          {
            "value": "Donate",
            "displayValue": "Donate"
          },
          {
            "value": "FindLocation",
            "displayValue": "FindLocation"
          },
          {
            "value": "Schedule",
            "displayValue": "Schedule"
          },
          {
            "value": "StartTrial",
            "displayValue": "StartTrial"
          },
          {
            "value": "SubmitApplication",
            "displayValue": "SubmitApplication"
          },
          {
            "value": "Subscribe",
            "displayValue": "Subscribe"
          },
          {
            "value": "AppendValue",
            "displayValue": "AppendValue (value append)"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "PageView",
        "macrosInSelect": true,
        "enablingConditions": [
          {
            "paramName": "eventNameSource",
            "paramValue": "standard",
            "type": "EQUALS"
          }
        ],
        "help": "\u003cstrong\u003eAppendValue\u003c/strong\u003e adds value to an event that was already sent. It requires the \u003cstrong\u003eOriginal event data\u003c/strong\u003e section below."
      },
      {
        "type": "TEXT",
        "name": "customEventName",
        "displayName": "Custom event name",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "eventNameSource",
            "paramValue": "custom",
            "type": "EQUALS"
          }
        ],
        "help": "A fixed name or a variable. Custom event names are reported in Events Manager as custom conversions."
      },
      {
        "type": "CHECKBOX",
        "name": "mapViewItemListToViewContent",
        "checkboxText": "Map view_item_list to ViewContent",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "eventNameSource",
            "paramValue": "inherit",
            "type": "EQUALS"
          }
        ],
        "help": "Off by default because a list impression is a weaker signal than a product detail view."
      },
      {
        "type": "SELECT",
        "name": "actionSource",
        "displayName": "Action source",
        "selectItems": [
          {
            "value": "website",
            "displayValue": "Website"
          },
          {
            "value": "app",
            "displayValue": "App"
          },
          {
            "value": "email",
            "displayValue": "Email"
          },
          {
            "value": "phone_call",
            "displayValue": "Phone call"
          },
          {
            "value": "chat",
            "displayValue": "Chat"
          },
          {
            "value": "physical_store",
            "displayValue": "Physical store"
          },
          {
            "value": "system_generated",
            "displayValue": "System generated"
          },
          {
            "value": "business_messaging",
            "displayValue": "Business messaging"
          },
          {
            "value": "other",
            "displayValue": "Other"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "website",
        "macrosInSelect": true,
        "help": "Where the conversion happened. Required by the Conversions API."
      },
      {
        "type": "SELECT",
        "name": "messagingChannel",
        "displayName": "Messaging channel",
        "selectItems": [
          {
            "value": "whatsapp",
            "displayValue": "WhatsApp"
          },
          {
            "value": "messenger",
            "displayValue": "Messenger"
          },
          {
            "value": "instagram",
            "displayValue": "Instagram"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "whatsapp",
        "macrosInSelect": true,
        "enablingConditions": [
          {
            "paramName": "actionSource",
            "paramValue": "business_messaging",
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupServerEventData",
    "displayName": "Server event data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "autoMapServerEventData",
        "checkboxText": "Automatically map server event data",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Fills \u003ccode\u003eevent_time\u003c/code\u003e, \u003ccode\u003eevent_id\u003c/code\u003e, \u003ccode\u003eevent_source_url\u003c/code\u003e, \u003ccode\u003ereferrer_url\u003c/code\u003e, \u003ccode\u003eopt_out\u003c/code\u003e and the data processing options from the incoming event, plus any \u003ccode\u003ex-fb-sed-*\u003c/code\u003e event data key."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "serverEventDataList",
        "displayName": "Overrides",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "type": "SELECT",
            "isUnique": true,
            "selectItems": [
              {
                "value": "event_time",
                "displayValue": "event_time"
              },
              {
                "value": "event_id",
                "displayValue": "event_id"
              },
              {
                "value": "event_source_url",
                "displayValue": "event_source_url"
              },
              {
                "value": "referrer_url",
                "displayValue": "referrer_url"
              },
              {
                "value": "opt_out",
                "displayValue": "opt_out"
              },
              {
                "value": "action_source",
                "displayValue": "action_source"
              },
              {
                "value": "data_processing_options",
                "displayValue": "data_processing_options"
              },
              {
                "value": "data_processing_options_country",
                "displayValue": "data_processing_options_country"
              },
              {
                "value": "data_processing_options_state",
                "displayValue": "data_processing_options_state"
              },
              {
                "value": "customer_segmentation",
                "displayValue": "customer_segmentation"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "Values entered here win over the automatic mapping. \u003ccode\u003edata_processing_options\u003c/code\u003e accepts a comma separated list, for example \u003ccode\u003eLDU\u003c/code\u003e.",
        "newRowButtonText": "Add property"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupUserData",
    "displayName": "User data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "autoMapUserData",
        "checkboxText": "Automatically map user data",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Reads the \u003ccode\u003euser_data\u003c/code\u003e object of the incoming event (the GA4 user-provided data format), the client IP and user agent, the \u003ccode\u003e_fbp\u003c/code\u003e and \u003ccode\u003e_fbc\u003c/code\u003e cookies, and any \u003ccode\u003ex-fb-ud-*\u003c/code\u003e event data key."
      },
      {
        "type": "CHECKBOX",
        "name": "hashUserData",
        "checkboxText": "Hash personal data with SHA-256",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Normalises and hashes the fields Meta requires to be hashed. Values that are already a SHA-256 hash are passed through untouched. Turn this off only when every value you supply is hashed already."
      },
      {
        "type": "CHECKBOX",
        "name": "enableEventEnhancement",
        "checkboxText": "Remember user data for later events",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Stores the identifying fields of this event in an \u003ccode\u003eHttpOnly\u003c/code\u003e first-party cookie and fills them back in on later events that arrive without them — so a Purchase still carries the email a visitor typed three pages earlier. Only values that are already a SHA-256 hash are stored, so the cookie can never hold readable personal data, and it is never readable from JavaScript. Values on the current event always win over remembered ones."
      },
      {
        "type": "TEXT",
        "name": "eventEnhancementDays",
        "displayName": "Remember for how many days",
        "simpleValueType": true,
        "defaultValue": "30",
        "enablingConditions": [
          {
            "paramName": "enableEventEnhancement",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Refreshed on every event. Keep it short — this cookie holds hashed identifiers, so it deserves a tighter lifetime than a plain browser ID."
      },
      {
        "type": "CHECKBOX",
        "name": "useClientIdAsExternalId",
        "checkboxText": "Fall back to client_id for external_id",
        "simpleValueType": true,
        "help": "Used only when no \u003ccode\u003eexternal_id\u003c/code\u003e and no \u003ccode\u003euser_id\u003c/code\u003e are available. Improves match quality for anonymous visitors, but the identifier is per browser rather than per person."
      },
      {
        "type": "SELECT",
        "name": "userDataObject",
        "displayName": "User data object variable",
        "selectItems": [],
        "simpleValueType": true,
        "macrosInSelect": true,
        "help": "A variable resolving to an object of user data properties. It is merged on top of the automatic mapping and below the table underneath."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "userDataList",
        "displayName": "User data properties",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "type": "SELECT",
            "isUnique": true,
            "selectItems": [
              {
                "value": "em",
                "displayValue": "em (email)"
              },
              {
                "value": "ph",
                "displayValue": "ph (phone)"
              },
              {
                "value": "fn",
                "displayValue": "fn (first name)"
              },
              {
                "value": "ln",
                "displayValue": "ln (last name)"
              },
              {
                "value": "db",
                "displayValue": "db (date of birth, YYYYMMDD)"
              },
              {
                "value": "ge",
                "displayValue": "ge (gender, f or m)"
              },
              {
                "value": "ct",
                "displayValue": "ct (city)"
              },
              {
                "value": "st",
                "displayValue": "st (state or region)"
              },
              {
                "value": "zp",
                "displayValue": "zp (postal code)"
              },
              {
                "value": "country",
                "displayValue": "country (2 letter code)"
              },
              {
                "value": "external_id",
                "displayValue": "external_id"
              },
              {
                "value": "client_ip_address",
                "displayValue": "client_ip_address"
              },
              {
                "value": "client_user_agent",
                "displayValue": "client_user_agent"
              },
              {
                "value": "fbc",
                "displayValue": "fbc"
              },
              {
                "value": "fbp",
                "displayValue": "fbp"
              },
              {
                "value": "subscription_id",
                "displayValue": "subscription_id"
              },
              {
                "value": "fb_login_id",
                "displayValue": "fb_login_id"
              },
              {
                "value": "lead_id",
                "displayValue": "lead_id"
              },
              {
                "value": "anon_id",
                "displayValue": "anon_id"
              },
              {
                "value": "madid",
                "displayValue": "madid"
              },
              {
                "value": "page_id",
                "displayValue": "page_id"
              },
              {
                "value": "page_scoped_user_id",
                "displayValue": "page_scoped_user_id"
              },
              {
                "value": "ctwa_clid",
                "displayValue": "ctwa_clid"
              },
              {
                "value": "ig_account_id",
                "displayValue": "ig_account_id"
              },
              {
                "value": "ig_sid",
                "displayValue": "ig_sid"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add user data property"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupCustomData",
    "displayName": "Custom data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "autoMapCustomData",
        "checkboxText": "Automatically map custom data",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Maps \u003ccode\u003evalue\u003c/code\u003e, \u003ccode\u003ecurrency\u003c/code\u003e, \u003ccode\u003etransaction_id\u003c/code\u003e, \u003ccode\u003esearch_term\u003c/code\u003e and the GA4 \u003ccode\u003eitems\u003c/code\u003e array to \u003ccode\u003econtents\u003c/code\u003e, \u003ccode\u003econtent_ids\u003c/code\u003e and \u003ccode\u003enum_items\u003c/code\u003e, plus any \u003ccode\u003ex-fb-cd-*\u003c/code\u003e event data key."
      },
      {
        "type": "TEXT",
        "name": "itemIdKey",
        "displayName": "Item ID key",
        "simpleValueType": true,
        "defaultValue": "item_id",
        "help": "Which property of an item holds the ID that matches your Meta catalogue. Change it to for example \u003ccode\u003eitem_variant_id\u003c/code\u003e when your catalogue is keyed on variants.",
        "enablingConditions": [
          {
            "paramName": "autoMapCustomData",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "contentType",
        "displayName": "Content type",
        "selectItems": [
          {
            "value": "product",
            "displayValue": "product"
          },
          {
            "value": "product_group",
            "displayValue": "product_group"
          },
          {
            "value": "destination",
            "displayValue": "destination"
          },
          {
            "value": "flight",
            "displayValue": "flight"
          },
          {
            "value": "hotel",
            "displayValue": "hotel"
          },
          {
            "value": "vehicle",
            "displayValue": "vehicle"
          },
          {
            "value": "home_listing",
            "displayValue": "home_listing"
          },
          {
            "value": "none",
            "displayValue": "Do not set"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "product",
        "macrosInSelect": true,
        "enablingConditions": [
          {
            "paramName": "autoMapCustomData",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Only applied when the event carries items and no content type was supplied elsewhere."
      },
      {
        "type": "SELECT",
        "name": "customDataObject",
        "displayName": "Custom data object variable",
        "selectItems": [],
        "simpleValueType": true,
        "macrosInSelect": true,
        "help": "A variable resolving to an object of custom data properties."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "customDataList",
        "displayName": "Custom data properties",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "type": "TEXT",
            "isUnique": true,
            "valueHint": "value, currency, content_name, ..."
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "Any property Meta accepts inside \u003ccode\u003ecustom_data\u003c/code\u003e. Values entered here win over the object variable and the automatic mapping.",
        "newRowButtonText": "Add custom data property"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupAppData",
    "displayName": "App data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "autoMapAppData",
        "checkboxText": "Automatically map app data",
        "simpleValueType": true,
        "help": "Reads an \u003ccode\u003eapp_data\u003c/code\u003e object from the incoming event and any \u003ccode\u003ex-fb-ad-*\u003c/code\u003e event data key. Only relevant when the action source is \u003cstrong\u003eApp\u003c/strong\u003e."
      },
      {
        "type": "SELECT",
        "name": "appDataObject",
        "displayName": "App data object variable",
        "selectItems": [],
        "simpleValueType": true,
        "macrosInSelect": true
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "appDataList",
        "displayName": "App data properties",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "type": "SELECT",
            "isUnique": true,
            "selectItems": [
              {
                "value": "advertiser_tracking_enabled",
                "displayValue": "advertiser_tracking_enabled"
              },
              {
                "value": "application_tracking_enabled",
                "displayValue": "application_tracking_enabled"
              },
              {
                "value": "extinfo",
                "displayValue": "extinfo"
              },
              {
                "value": "campaign_ids",
                "displayValue": "campaign_ids"
              },
              {
                "value": "install_referrer",
                "displayValue": "install_referrer"
              },
              {
                "value": "installer_package",
                "displayValue": "installer_package"
              },
              {
                "value": "url_schemes",
                "displayValue": "url_schemes"
              },
              {
                "value": "windows_attribution_id",
                "displayValue": "windows_attribution_id"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add app data property"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupOriginalEventData",
    "displayName": "Original event data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "LABEL",
        "name": "originalEventDataLabel",
        "displayName": "Identifies the event that a value is being appended to. Required for AppendValue, ignored for every other event."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "originalEventDataList",
        "displayName": "Original event properties",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "type": "SELECT",
            "isUnique": true,
            "selectItems": [
              {
                "value": "event_name",
                "displayValue": "event_name"
              },
              {
                "value": "event_time",
                "displayValue": "event_time"
              },
              {
                "value": "event_id",
                "displayValue": "event_id"
              },
              {
                "value": "order_id",
                "displayValue": "order_id"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add original event property"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupTrackingHippo",
    "displayName": "TrackingHippo enrichment",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "LABEL",
        "name": "trackingHippoLabel",
        "displayName": "Enriches user data from the request headers added by TrackingHippo.io container modules. Enable the matching module on your container first — without it the headers are absent and nothing is added."
      },
      {
        "type": "CHECKBOX",
        "name": "enableThEnrichment",
        "checkboxText": "Use TrackingHippo container modules",
        "simpleValueType": true,
        "defaultValue": false
      },
      {
        "type": "CHECKBOX",
        "name": "thUseUserId",
        "checkboxText": "User ID module → external_id",
        "simpleValueType": true,
        "defaultValue": true,
        "enablingConditions": [
          {
            "paramName": "enableThEnrichment",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Reads the \u003ccode\u003eX-User-Id\u003c/code\u003e header set by the \u003cstrong\u003eUser ID\u003c/strong\u003e module. That identifier is pseudonymous and derived from the visitor\u0027s connection, so it identifies a browsing context rather than a person — send your own \u003ccode\u003euser_id\u003c/code\u003e as well whenever you have one."
      },
      {
        "type": "CHECKBOX",
        "name": "thUseGeo",
        "checkboxText": "GEO Headers module → city, state, postal code, country",
        "simpleValueType": true,
        "defaultValue": true,
        "enablingConditions": [
          {
            "paramName": "enableThEnrichment",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Reads \u003ccode\u003eX-Geo-City\u003c/code\u003e, \u003ccode\u003eX-Geo-Region\u003c/code\u003e, \u003ccode\u003eX-Geo-Postal-Code\u003c/code\u003e and \u003ccode\u003eX-Geo-Country\u003c/code\u003e. The values are normalised and hashed like any other address field. The GEO Headers module is not generally available yet, so these headers are empty until it launches."
      },
      {
        "type": "CHECKBOX",
        "name": "thOverwrite",
        "checkboxText": "Let module values overwrite existing user data",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "enableThEnrichment",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Off by default: geo data derived from an IP address is a fallback, not a replacement for an address the visitor actually gave you."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupCookies",
    "displayName": "Cookies and identifiers",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "generateFbp",
        "checkboxText": "Generate _fbp when it is missing",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Creates a browser ID server side and writes it back as a first-party cookie, so visitors whose browser blocked the Meta Pixel still get a stable identifier."
      },
      {
        "type": "CHECKBOX",
        "name": "generateFbc",
        "checkboxText": "Generate _fbc from the fbclid parameter",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Builds the click ID from \u003ccode\u003efbclid\u003c/code\u003e in the page URL when the \u003ccode\u003e_fbc\u003c/code\u003e cookie has not been set yet, and stores it as a first-party cookie."
      },
      {
        "type": "CHECKBOX",
        "name": "useHttpOnlyCookie",
        "checkboxText": "Set cookies as HttpOnly",
        "simpleValueType": true,
        "help": "Hides the cookies from JavaScript, which also hides them from the browser Meta Pixel. Only enable this when all Meta tracking runs server side."
      },
      {
        "type": "TEXT",
        "name": "cookieMaxAgeDays",
        "displayName": "Cookie lifetime in days",
        "simpleValueType": true,
        "defaultValue": "90",
        "help": "Meta\u0027s own pixel uses 90 days."
      },
      {
        "type": "CHECKBOX",
        "name": "overrideCookieDomain",
        "checkboxText": "Override the cookie domain",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "By default the cookie is written on the registrable domain of the page (\u003ccode\u003eauto\u003c/code\u003e)."
      },
      {
        "type": "TEXT",
        "name": "cookieDomain",
        "displayName": "Cookie domain",
        "simpleValueType": true,
        "defaultValue": "auto",
        "enablingConditions": [
          {
            "paramName": "overrideCookieDomain",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupConsent",
    "displayName": "Consent",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "adStorageConsent",
        "displayName": "Ad storage consent",
        "radioItems": [
          {
            "value": "notSet",
            "displayValue": "Always send the event"
          },
          {
            "value": "required",
            "displayValue": "Only send when ad_storage consent is granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "notSet",
        "help": "\u003cstrong\u003eAlways send\u003c/strong\u003e is right when consent is already enforced by the trigger or by the client. \u003cstrong\u003eOnly send when granted\u003c/strong\u003e reads \u003ccode\u003econsent_state.ad_storage\u003c/code\u003e from the incoming event, falling back to the Google Consent Mode \u003ccode\u003ex-ga-gcs\u003c/code\u003e signal; when neither is present the event is sent."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupAdvanced",
    "displayName": "Advanced",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "apiVersion",
        "displayName": "Graph API version",
        "simpleValueType": true,
        "defaultValue": "v26.0",
        "help": "The Graph API version used in the endpoint URL. Leave it as is unless Meta asks you to move to a newer version."
      },
      {
        "type": "CHECKBOX",
        "name": "useAppSecretProof",
        "checkboxText": "Send an app secret proof",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Required when the app behind your access token has \u003cstrong\u003eRequire app secret\u003c/strong\u003e enabled."
      },
      {
        "type": "TEXT",
        "name": "appSecretProof",
        "displayName": "App secret proof",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "useAppSecretProof",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "The HMAC-SHA256 of your access token, keyed with your app secret, in hexadecimal. Compute it once outside the container and store it in a variable — the sandbox cannot keep an app secret safely."
      },
      {
        "type": "CHECKBOX",
        "name": "useOptimisticScenario",
        "checkboxText": "Do not wait for Meta\u0027s response",
        "simpleValueType": true,
        "help": "Reports success as soon as the request is sent. It shortens the response time of the container, at the cost of never seeing a failed request in the tag status."
      },
      {
        "type": "TEXT",
        "name": "requestTimeout",
        "displayName": "Request timeout in milliseconds",
        "simpleValueType": true,
        "defaultValue": "5000"
      },
      {
        "type": "RADIO",
        "name": "logType",
        "displayName": "Logging",
        "radioItems": [
          {
            "value": "debug",
            "displayValue": "Log in preview and debug mode only"
          },
          {
            "value": "always",
            "displayValue": "Always log"
          },
          {
            "value": "no",
            "displayValue": "Never log"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "debug"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const computeEffectiveTldPlusOne = require('computeEffectiveTldPlusOne');
const getAllEventData = require('getAllEventData');
const getContainerVersion = require('getContainerVersion');
const getCookieValues = require('getCookieValues');
const getRequestHeader = require('getRequestHeader');
const getTimestampMillis = require('getTimestampMillis');
const getType = require('getType');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const makeInteger = require('makeInteger');
const makeNumber = require('makeNumber');
const makeString = require('makeString');
const Object = require('Object');
const parseUrl = require('parseUrl');
const Promise = require('Promise');
const generateRandom = require('generateRandom');
const sendHttpRequest = require('sendHttpRequest');
const setCookie = require('setCookie');
const sha256Sync = require('sha256Sync');

const GRAPH_ENDPOINT = 'https://graph.facebook.com/';
const DEFAULT_API_VERSION = 'v26.0';
const DEFAULT_TIMEOUT = 5000;
const SECONDS_PER_DAY = 86400;
const HEX_CHARS = '0123456789abcdef';
const DIGITS = '0123456789';
const LETTERS = 'abcdefghijklmnopqrstuvwxyz';
// Removed from names and addresses before hashing. Letters are never filtered by
// an allow list, because Meta normalises accented characters as UTF-8 rather than
// stripping them and a stripped character produces a hash that can never match.
const PUNCTUATION = ' \t\r\n!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~';

// Event data key prefixes that route a value straight into one of Meta's objects.
const PREFIX_SERVER_EVENT = 'x-fb-sed-';
const PREFIX_USER_DATA = 'x-fb-ud-';
const PREFIX_CUSTOM_DATA = 'x-fb-cd-';
const PREFIX_APP_DATA = 'x-fb-ad-';

// GA4 (and Data Client) event names that have a Meta standard event equivalent.
const EVENT_NAME_MAP = {
  page_view: 'PageView',
  view_item: 'ViewContent',
  view_content: 'ViewContent',
  search: 'Search',
  view_search_results: 'Search',
  add_to_cart: 'AddToCart',
  add_to_wishlist: 'AddToWishlist',
  begin_checkout: 'InitiateCheckout',
  add_payment_info: 'AddPaymentInfo',
  add_shipping_info: 'AddPaymentInfo',
  purchase: 'Purchase',
  generate_lead: 'Lead',
  sign_up: 'CompleteRegistration',
  contact: 'Contact',
  customize_product: 'CustomizeProduct',
  donate: 'Donate',
  find_location: 'FindLocation',
  schedule: 'Schedule',
  start_trial: 'StartTrial',
  submit_application: 'SubmitApplication',
  subscribe: 'Subscribe'
};

// Cookie carrying the remembered identity fields between events. It is always
// HttpOnly and only ever holds SHA-256 hashes.
const EEC_COOKIE = '_th_eec';

// Durable identity fields worth carrying across events. Deliberately excludes the
// per-request context (IP, user agent) and the identifiers that already have their
// own cookie (fbp, fbc), which must reflect the current request rather than an old one.
const ENHANCEABLE_FIELDS = [
  'em', 'ph', 'fn', 'ln', 'db', 'ge', 'ct', 'st', 'zp', 'country', 'external_id'
];

// user_data fields Meta expects in the clear. Everything else in user_data is hashed.
const UNHASHED_USER_DATA = {
  client_ip_address: true,
  client_user_agent: true,
  fbc: true,
  fbp: true,
  subscription_id: true,
  fb_login_id: true,
  lead_id: true,
  anon_id: true,
  madid: true,
  page_id: true,
  page_scoped_user_id: true,
  ctwa_clid: true,
  ig_account_id: true,
  ig_sid: true
};

const eventData = getAllEventData();
const containerVersion = getContainerVersion();
const isDebug = !!containerVersion &&
    (!!containerVersion.debugMode || !!containerVersion.previewMode);

const log = (message) => {
  if (data.logType === 'always' || (data.logType !== 'no' && isDebug)) {
    logToConsole('Facebook Conversions API (TrackingHippo): ' + message);
  }
};

/* ------------------------------------------------------------------ helpers */

const isEmpty = (value) => {
  const type = getType(value);
  if (type === 'undefined' || type === 'null') return true;
  if (type === 'string') return value === '';
  if (type === 'array') return value.length === 0;
  return false;
};

const setIfPresent = (target, key, value) => {
  if (!isEmpty(value)) target[key] = value;
};

const firstDefined = (values) => {
  for (let i = 0; i < values.length; i++) {
    if (!isEmpty(values[i])) return values[i];
  }
  return undefined;
};

const hasKeys = (obj) => getType(obj) === 'object' && Object.keys(obj).length > 0;

// The sandbox has no regular expression replace, so characters are filtered by hand.
const keepChars = (value, allowed) => {
  const chars = makeString(value).split('');
  let out = '';
  for (let i = 0; i < chars.length; i++) {
    if (allowed.indexOf(chars[i]) !== -1) out += chars[i];
  }
  return out;
};

const removeChars = (value, disallowed) => {
  const chars = makeString(value).split('');
  let out = '';
  for (let i = 0; i < chars.length; i++) {
    if (disallowed.indexOf(chars[i]) === -1) out += chars[i];
  }
  return out;
};

const isSha256 = (value) => {
  if (getType(value) !== 'string' || value.length !== 64) return false;
  return keepChars(value.toLowerCase(), HEX_CHARS).length === 64;
};

const tableToObject = (table, keyColumn, valueColumn) => {
  const out = {};
  if (getType(table) !== 'array') return out;
  for (let i = 0; i < table.length; i++) {
    const row = table[i];
    if (getType(row) !== 'object') continue;
    const key = row[keyColumn];
    if (isEmpty(key)) continue;
    setIfPresent(out, makeString(key), row[valueColumn]);
  }
  return out;
};

const mergeInto = (target, source) => {
  if (getType(source) !== 'object') return target;
  const keys = Object.keys(source);
  for (let i = 0; i < keys.length; i++) {
    setIfPresent(target, keys[i], source[keys[i]]);
  }
  return target;
};

// Collects event data keys such as x-fb-cd-content_name into a flat object.
const collectPrefixed = (prefix) => {
  const out = {};
  const keys = Object.keys(eventData);
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    if (key.indexOf(prefix) === 0 && key.length > prefix.length) {
      setIfPresent(out, key.split(prefix).join(''), eventData[key]);
    }
  }
  return out;
};

/* --------------------------------------------------------------- normalising */

const normaliseUserDataValue = (key, value) => {
  const raw = makeString(value).trim();
  if (raw === '') return '';

  if (key === 'em') return raw.toLowerCase();
  if (key === 'ph') return keepChars(raw, DIGITS);
  if (key === 'db') return keepChars(raw, DIGITS);
  if (key === 'ge') {
    const gender = raw.toLowerCase().split('')[0];
    return gender === 'f' || gender === 'm' ? gender : '';
  }
  if (key === 'fn' || key === 'ln' || key === 'ct' || key === 'st') {
    return removeChars(raw.toLowerCase(), PUNCTUATION);
  }
  if (key === 'zp') {
    // Meta matches on the first block only, so anything after a dash is dropped.
    return removeChars(raw.toLowerCase().split('-')[0], PUNCTUATION);
  }
  if (key === 'country') {
    return keepChars(raw.toLowerCase(), LETTERS);
  }
  return raw;
};

const hashUserDataValue = (key, value) => {
  if (UNHASHED_USER_DATA[key]) return makeString(value).trim();
  if (isSha256(value)) return makeString(value).toLowerCase();
  if (!data.hashUserData) return makeString(value).trim();

  const normalised = normaliseUserDataValue(key, value);
  if (normalised === '') return '';
  return sha256Sync(normalised, { outputEncoding: 'hex' });
};

/* --------------------------------------------------------------- page and ip */

const pageLocation = firstDefined([
  eventData.page_location,
  eventData.page_url,
  getRequestHeader('referer')
]);

const parsedPageLocation = isEmpty(pageLocation) ? undefined : parseUrl(pageLocation);

const getQueryParam = (name) => {
  if (!parsedPageLocation || getType(parsedPageLocation.searchParams) !== 'object') {
    return undefined;
  }
  return parsedPageLocation.searchParams[name];
};

/* ------------------------------------------------------------------- cookies */

const cookieMaxAgeSeconds = () => {
  const days = makeNumber(data.cookieMaxAgeDays);
  if (getType(days) !== 'number' || days !== days || days <= 0) {
    return 90 * SECONDS_PER_DAY;
  }
  return days * SECONDS_PER_DAY;
};

const resolveCookieDomain = () => {
  if (!data.overrideCookieDomain) return 'auto';
  const domain = makeString(data.cookieDomain || 'auto').trim();
  if (domain === '' || domain === 'auto') return 'auto';
  return domain;
};

const writeCookie = (name, value) => {
  setCookie(name, value, {
    domain: resolveCookieDomain(),
    path: '/',
    'max-age': cookieMaxAgeSeconds(),
    secure: true,
    httpOnly: !!data.useHttpOnlyCookie,
    sameSite: 'Lax'
  });
};

const readCookie = (name) => {
  const values = getCookieValues(name);
  return getType(values) === 'array' && values.length > 0 ? values[0] : undefined;
};

// The subdomain index Meta expects: 0 for a bare domain, 1 for the registrable
// domain, 2 for one level below it. Cookies are written on the registrable
// domain unless the user overrides it, which makes 1 the correct default.
const subdomainIndex = () => {
  const domain = resolveCookieDomain();
  if (domain === 'auto') return 1;
  const parts = keepChars(domain, LETTERS + DIGITS + '.-').split('.');
  return parts.length > 2 ? parts.length - 1 : 1;
};

const resolveFbp = () => {
  const existing = firstDefined([
    readCookie('_fbp'),
    eventData['x-fb-ck-fbp'],
    eventData._fbp
  ]);
  if (!isEmpty(existing)) return makeString(existing);
  if (!data.generateFbp) return undefined;

  const generated = 'fb.' + subdomainIndex() + '.' + getTimestampMillis() + '.' +
      generateRandom(1000000000, 2147483647);
  writeCookie('_fbp', generated);
  log('generated a new _fbp value');
  return generated;
};

const resolveFbc = () => {
  const existing = firstDefined([
    readCookie('_fbc'),
    eventData['x-fb-ck-fbc'],
    eventData._fbc
  ]);
  const fbclid = firstDefined([getQueryParam('fbclid'), eventData.fbclid]);

  // A fresh click always wins: the stored value belongs to an older click.
  if (!isEmpty(fbclid) && data.generateFbc) {
    const clickId = makeString(fbclid);
    if (!isEmpty(existing) && makeString(existing).indexOf(clickId) !== -1) {
      return makeString(existing);
    }
    const generated = 'fb.' + subdomainIndex() + '.' + getTimestampMillis() + '.' + clickId;
    writeCookie('_fbc', generated);
    log('generated a new _fbc value from fbclid');
    return generated;
  }

  return isEmpty(existing) ? undefined : makeString(existing);
};

/* ----------------------------------------------------------------- user data */

const addressFromEventData = () => {
  const userData = eventData.user_data;
  if (getType(userData) !== 'object') return {};
  const address = userData.address;
  if (getType(address) === 'array') return getType(address[0]) === 'object' ? address[0] : {};
  if (getType(address) === 'object') return address;
  return {};
};

const autoMappedUserData = () => {
  const out = {};
  if (!data.autoMapUserData) return out;

  const userData = getType(eventData.user_data) === 'object' ? eventData.user_data : {};
  const address = addressFromEventData();

  setIfPresent(out, 'em', firstDefined([
    userData.sha256_email_address, userData.email_address, userData.email, userData.em
  ]));
  setIfPresent(out, 'ph', firstDefined([
    userData.sha256_phone_number, userData.phone_number, userData.phone, userData.ph
  ]));
  setIfPresent(out, 'fn', firstDefined([
    address.sha256_first_name, address.first_name, userData.first_name, userData.fn
  ]));
  setIfPresent(out, 'ln', firstDefined([
    address.sha256_last_name, address.last_name, userData.last_name, userData.ln
  ]));
  setIfPresent(out, 'ct', firstDefined([address.city, userData.city, userData.ct]));
  setIfPresent(out, 'st', firstDefined([
    address.region, address.state, userData.region, userData.st
  ]));
  setIfPresent(out, 'zp', firstDefined([
    address.postal_code, userData.postal_code, userData.zp
  ]));
  setIfPresent(out, 'country', firstDefined([
    address.country, userData.country
  ]));
  setIfPresent(out, 'db', firstDefined([userData.date_of_birth, userData.db]));
  setIfPresent(out, 'ge', firstDefined([userData.gender, userData.ge]));

  const externalIdCandidates = [userData.external_id, eventData.user_id];
  if (data.useClientIdAsExternalId) externalIdCandidates.push(eventData.client_id);
  setIfPresent(out, 'external_id', firstDefined(externalIdCandidates));

  setIfPresent(out, 'client_ip_address', firstDefined([
    eventData.ip_override, eventData.client_ip_address
  ]));
  setIfPresent(out, 'client_user_agent', firstDefined([
    eventData.user_agent, eventData.client_user_agent
  ]));

  mergeInto(out, collectPrefixed(PREFIX_USER_DATA));
  return out;
};

const trackingHippoUserData = (current) => {
  const out = {};
  if (!data.enableThEnrichment) return out;

  const put = (key, value) => {
    if (isEmpty(value)) return;
    if (!data.thOverwrite && !isEmpty(current[key])) return;
    out[key] = value;
  };

  if (data.thUseUserId) {
    put('external_id', getRequestHeader('x-user-id'));
  }
  if (data.thUseGeo) {
    put('ct', getRequestHeader('x-geo-city'));
    put('st', getRequestHeader('x-geo-region'));
    put('zp', getRequestHeader('x-geo-postal-code'));
    put('country', getRequestHeader('x-geo-country'));
  }

  if (hasKeys(out)) {
    log('enriched user data from TrackingHippo module headers: ' +
        Object.keys(out).join(', '));
  }
  return out;
};

/* --------------------------------------------------------- event enhancement */

const enhancementMaxAgeSeconds = () => {
  const days = makeNumber(data.eventEnhancementDays);
  if (getType(days) !== 'number' || days !== days || days <= 0) {
    return 30 * SECONDS_PER_DAY;
  }
  return days * SECONDS_PER_DAY;
};

const readEnhancementCookie = () => {
  const raw = readCookie(EEC_COOKIE);
  if (isEmpty(raw)) return {};
  const parsed = JSON.parse(makeString(raw));
  return getType(parsed) === 'object' ? parsed : {};
};

const writeEnhancementCookie = (userData) => {
  const cache = {};
  for (let i = 0; i < ENHANCEABLE_FIELDS.length; i++) {
    const key = ENHANCEABLE_FIELDS[i];
    const value = userData[key];
    // Only hashes are ever persisted. If hashing is switched off, or a field holds
    // several values, nothing is written rather than putting readable data in a cookie.
    if (getType(value) === 'string' && isSha256(value)) cache[key] = value;
  }
  if (!hasKeys(cache)) return;

  setCookie(EEC_COOKIE, JSON.stringify(cache), {
    domain: resolveCookieDomain(),
    path: '/',
    'max-age': enhancementMaxAgeSeconds(),
    secure: true,
    httpOnly: true,
    sameSite: 'Lax'
  });
};

const applyEventEnhancement = (userData) => {
  if (!data.enableEventEnhancement) return userData;

  const cached = readEnhancementCookie();
  const restored = [];
  for (let i = 0; i < ENHANCEABLE_FIELDS.length; i++) {
    const key = ENHANCEABLE_FIELDS[i];
    const value = cached[key];
    // The cookie is only trusted to contain hashes, whatever else may be in it.
    if (!isSha256(value)) continue;
    if (!isEmpty(userData[key])) continue;
    userData[key] = makeString(value).toLowerCase();
    restored.push(key);
  }
  if (restored.length > 0) {
    log('restored user data from an earlier event: ' + restored.join(', '));
  }

  // Written back afterwards so newly learned fields are remembered and the
  // lifetime slides forward on every event.
  writeEnhancementCookie(userData);
  return userData;
};

const buildUserData = () => {
  const merged = autoMappedUserData();

  // The click and browser identifiers are governed by their own settings rather
  // than by the automap toggle, so that reading and restoring the Meta cookies
  // keeps working for a tag that maps everything else by hand.
  setIfPresent(merged, 'fbp', resolveFbp());
  setIfPresent(merged, 'fbc', resolveFbc());

  mergeInto(merged, trackingHippoUserData(merged));
  mergeInto(merged, data.userDataObject);
  mergeInto(merged, tableToObject(data.userDataList, 'name', 'value'));

  const out = {};
  const keys = Object.keys(merged);
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    const value = merged[key];

    // Meta accepts several values per field, hashed one by one.
    if (getType(value) === 'array') {
      const hashedList = [];
      for (let j = 0; j < value.length; j++) {
        const hashedItem = hashUserDataValue(key, value[j]);
        if (!isEmpty(hashedItem)) hashedList.push(hashedItem);
      }
      setIfPresent(out, key, hashedList);
      continue;
    }

    setIfPresent(out, key, hashUserDataValue(key, value));
  }
  return applyEventEnhancement(out);
};

/* --------------------------------------------------------------- custom data */

const buildContents = () => {
  const items = eventData.items;
  if (getType(items) !== 'array' || items.length === 0) return [];

  const idKey = makeString(data.itemIdKey || 'item_id');
  const contents = [];
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    if (getType(item) !== 'object') continue;

    const content = {};
    setIfPresent(content, 'id', makeString(firstDefined([
      item[idKey], item.item_id, item.id, item.item_sku
    ]) || ''));
    if (isEmpty(content.id)) continue;

    if (!isEmpty(item.quantity)) content.quantity = makeInteger(item.quantity);
    if (!isEmpty(item.price)) content.item_price = makeNumber(item.price);
    setIfPresent(content, 'title', item.item_name || item.name);
    setIfPresent(content, 'category', item.item_category);
    setIfPresent(content, 'brand', item.item_brand);
    contents.push(content);
  }
  return contents;
};

const autoMappedCustomData = () => {
  const out = {};
  if (!data.autoMapCustomData) return out;

  setIfPresent(out, 'currency', eventData.currency);
  if (!isEmpty(eventData.value)) out.value = makeNumber(eventData.value);
  setIfPresent(out, 'order_id', firstDefined([
    eventData.transaction_id, eventData.order_id
  ]));
  setIfPresent(out, 'search_string', firstDefined([
    eventData.search_term, eventData.search_string
  ]));
  setIfPresent(out, 'content_name', firstDefined([
    eventData.content_name, eventData.page_title
  ]));
  setIfPresent(out, 'content_category', eventData.content_category);
  if (!isEmpty(eventData.predicted_ltv)) {
    out.predicted_ltv = makeNumber(eventData.predicted_ltv);
  }

  const contents = buildContents();
  if (contents.length > 0) {
    out.contents = contents;
    const ids = [];
    let numItems = 0;
    for (let i = 0; i < contents.length; i++) {
      ids.push(contents[i].id);
      numItems += getType(contents[i].quantity) === 'number' ? contents[i].quantity : 1;
    }
    out.content_ids = ids;
    out.num_items = numItems;
    if (!isEmpty(data.contentType) && data.contentType !== 'none') {
      out.content_type = data.contentType;
    }
    if (isEmpty(out.content_name) && !isEmpty(contents[0].title)) {
      out.content_name = contents[0].title;
    }
    if (isEmpty(out.content_category) && !isEmpty(contents[0].category)) {
      out.content_category = contents[0].category;
    }
  }

  mergeInto(out, collectPrefixed(PREFIX_CUSTOM_DATA));
  return out;
};

const buildCustomData = () => {
  const out = autoMappedCustomData();
  mergeInto(out, data.customDataObject);
  mergeInto(out, tableToObject(data.customDataList, 'name', 'value'));

  // The table hands over strings; Meta rejects a string where it wants a number.
  if (!isEmpty(out.value)) out.value = makeNumber(out.value);
  if (!isEmpty(out.num_items)) out.num_items = makeInteger(out.num_items);
  if (!isEmpty(out.predicted_ltv)) out.predicted_ltv = makeNumber(out.predicted_ltv);

  return out;
};

/* ------------------------------------------------------------------ app data */

const buildAppData = () => {
  const out = {};
  if (data.autoMapAppData) {
    mergeInto(out, eventData.app_data);
    mergeInto(out, collectPrefixed(PREFIX_APP_DATA));
  }
  mergeInto(out, data.appDataObject);
  mergeInto(out, tableToObject(data.appDataList, 'name', 'value'));
  return out;
};

/* ---------------------------------------------------------------- event name */

const resolveEventName = () => {
  if (data.eventNameSource === 'standard') return makeString(data.standardEventName);
  if (data.eventNameSource === 'custom') return makeString(data.customEventName);

  const incoming = makeString(eventData.event_name || '');
  if (incoming === 'view_item_list') {
    return data.mapViewItemListToViewContent ? 'ViewContent' : incoming;
  }
  return EVENT_NAME_MAP[incoming] || incoming;
};

/* --------------------------------------------------------------- event time */

const resolveEventTime = () => {
  const candidate = firstDefined([eventData.event_time, eventData.timestamp]);
  if (!isEmpty(candidate)) {
    const numeric = makeNumber(candidate);
    if (getType(numeric) === 'number' && numeric === numeric && numeric > 0) {
      // Accept both seconds and milliseconds; Meta wants seconds.
      return numeric > 99999999999 ? makeInteger(numeric / 1000) : makeInteger(numeric);
    }
  }
  return makeInteger(getTimestampMillis() / 1000);
};

/* -------------------------------------------------------------- server event */

const applyDataProcessingOptions = (event) => {
  const options = event.data_processing_options;
  if (isEmpty(options)) return;
  if (getType(options) === 'array') return;
  const parts = makeString(options).split(',');
  const cleaned = [];
  for (let i = 0; i < parts.length; i++) {
    const part = parts[i].trim();
    if (part !== '') cleaned.push(part);
  }
  event.data_processing_options = cleaned;
};

const buildServerEvent = () => {
  const event = {};

  event.event_name = resolveEventName();
  event.action_source = makeString(data.actionSource || 'website');

  if (data.autoMapServerEventData) {
    event.event_time = resolveEventTime();
    setIfPresent(event, 'event_id', firstDefined([
      eventData.event_id, eventData['x-ga-event_id']
    ]));
    setIfPresent(event, 'event_source_url', pageLocation);
    setIfPresent(event, 'referrer_url', eventData.page_referrer);
    if (getType(eventData.opt_out) === 'boolean') event.opt_out = eventData.opt_out;
    setIfPresent(event, 'data_processing_options', eventData.data_processing_options);
    setIfPresent(event, 'data_processing_options_country',
        eventData.data_processing_options_country);
    setIfPresent(event, 'data_processing_options_state',
        eventData.data_processing_options_state);
    mergeInto(event, collectPrefixed(PREFIX_SERVER_EVENT));
  } else {
    event.event_time = resolveEventTime();
  }

  mergeInto(event, tableToObject(data.serverEventDataList, 'name', 'value'));

  if (event.action_source === 'business_messaging' && !isEmpty(data.messagingChannel)) {
    event.messaging_channel = makeString(data.messagingChannel);
  }

  event.event_time = makeInteger(event.event_time);
  if (getType(event.opt_out) === 'string') {
    event.opt_out = event.opt_out === 'true';
  }
  applyDataProcessingOptions(event);

  const userData = buildUserData();
  if (hasKeys(userData)) event.user_data = userData;

  const customData = buildCustomData();
  if (hasKeys(customData)) event.custom_data = customData;

  const appData = buildAppData();
  if (hasKeys(appData)) event.app_data = appData;

  const originalEventData = tableToObject(data.originalEventDataList, 'name', 'value');
  if (hasKeys(originalEventData)) {
    if (!isEmpty(originalEventData.event_time)) {
      originalEventData.event_time = makeInteger(originalEventData.event_time);
    }
    event.original_event_data = originalEventData;
  }

  return event;
};

/* --------------------------------------------------------------------- consent */

const isConsentGranted = () => {
  if (data.adStorageConsent !== 'required') return true;

  const consentState = eventData.consent_state;
  if (getType(consentState) === 'object' && !isEmpty(consentState.ad_storage)) {
    return makeString(consentState.ad_storage).toLowerCase() === 'granted';
  }

  // Google Consent Mode packs the state into x-ga-gcs as G1<ad_storage><analytics_storage>.
  const gcs = eventData['x-ga-gcs'];
  if (!isEmpty(gcs)) {
    const chars = makeString(gcs).split('');
    return chars.length > 2 && chars[2] === '1';
  }

  return true;
};

/* ---------------------------------------------------------------- datasets */

const resolveDatasets = () => {
  if (data.enableMultiPixel) {
    const rows = getType(data.pixelTable) === 'array' ? data.pixelTable : [];
    const datasets = [];
    for (let i = 0; i < rows.length; i++) {
      const row = rows[i];
      if (getType(row) !== 'object') continue;
      if (isEmpty(row.pixelId) || isEmpty(row.accessToken)) continue;
      datasets.push({
        pixelId: makeString(row.pixelId).trim(),
        accessToken: makeString(row.accessToken).trim()
      });
    }
    return datasets;
  }

  if (isEmpty(data.pixelId) || isEmpty(data.accessToken)) return [];
  return [{
    pixelId: makeString(data.pixelId).trim(),
    accessToken: makeString(data.accessToken).trim()
  }];
};

/* -------------------------------------------------------------------- sending */

const requestTimeout = () => {
  const timeout = makeInteger(data.requestTimeout);
  return getType(timeout) === 'number' && timeout > 0 ? timeout : DEFAULT_TIMEOUT;
};

const buildUrl = (pixelId) => {
  const version = makeString(data.apiVersion || DEFAULT_API_VERSION).trim();
  let url = GRAPH_ENDPOINT + version + '/' + pixelId + '/events';
  if (data.useAppSecretProof && !isEmpty(data.appSecretProof)) {
    url += '?appsecret_proof=' + makeString(data.appSecretProof).trim();
  }
  return url;
};

const sendToDataset = (dataset, event) => {
  const body = {
    data: [event],
    access_token: dataset.accessToken
  };
  if (!isEmpty(data.testEventCode)) {
    body.test_event_code = makeString(data.testEventCode).trim();
  }

  const url = buildUrl(dataset.pixelId);
  const options = {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    timeout: requestTimeout()
  };

  log('sending ' + event.event_name + ' to dataset ' + dataset.pixelId);

  return sendHttpRequest(url, options, JSON.stringify(body)).then((response) => {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      log('dataset ' + dataset.pixelId + ' accepted the event');
      return true;
    }
    log('dataset ' + dataset.pixelId + ' rejected the event with status ' +
        response.statusCode + ': ' + makeString(response.body));
    return false;
  });
};

/* ----------------------------------------------------------------------- run */

if (!isConsentGranted()) {
  log('ad_storage consent is not granted, the event was not sent');
  return data.gtmOnSuccess();
}

const datasets = resolveDatasets();
if (datasets.length === 0) {
  log('no dataset ID and access token pair is configured');
  return data.gtmOnFailure();
}

const serverEvent = buildServerEvent();
if (isEmpty(serverEvent.event_name)) {
  log('the event has no name, nothing was sent');
  return data.gtmOnFailure();
}

const requests = [];
for (let i = 0; i < datasets.length; i++) {
  requests.push(sendToDataset(datasets[i], serverEvent));
}

if (data.useOptimisticScenario) {
  return data.gtmOnSuccess();
}

Promise.all(requests).then((results) => {
  for (let i = 0; i < results.length; i++) {
    if (!results[i]) return data.gtmOnFailure();
  }
  data.gtmOnSuccess();
}).catch(() => {
  log('the request to the Conversions API failed');
  data.gtmOnFailure();
});


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://graph.facebook.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_fbp"
              },
              {
                "type": 1,
                "string": "_fbc"
              },
              {
                "type": 1,
                "string": "_th_eec"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbp"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbc"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_th_eec"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-user-id"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-geo-city"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-geo-region"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-geo-postal-code"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-geo-country"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Sends a Purchase event built from GA4 event data
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'inherit',
      actionSource: 'website',
      autoMapServerEventData: true,
      autoMapUserData: true,
      hashUserData: true,
      autoMapCustomData: true,
      itemIdKey: 'item_id',
      contentType: 'product',
      apiVersion: 'v26.0',
      logType: 'no'
    };

    let requestUrl, requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestUrl = url;
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(requestUrl).isEqualTo('https://graph.facebook.com/v26.0/1234567890/events');
    assertThat(requestBody.access_token).isEqualTo('token-abc');

    const event = requestBody.data[0];
    assertThat(event.event_name).isEqualTo('Purchase');
    assertThat(event.action_source).isEqualTo('website');
    assertThat(event.event_source_url).isEqualTo('https://shop.example.com/thanks');
    assertThat(event.custom_data.value).isEqualTo(49.9);
    assertThat(event.custom_data.currency).isEqualTo('EUR');
    assertThat(event.custom_data.order_id).isEqualTo('T-1');
    assertThat(event.custom_data.content_ids).isEqualTo(['SKU-1']);
    assertThat(event.custom_data.num_items).isEqualTo(2);
    assertThat(event.custom_data.content_type).isEqualTo('product');
    assertApi('gtmOnSuccess').wasCalled();
- name: Hashes email and phone but leaves the IP and user agent in the clear
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'inherit',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: true,
      logType: 'no'
    };

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    const userData = requestBody.data[0].user_data;
    assertThat(userData.em.length).isEqualTo(64);
    assertThat(userData.em).isEqualTo(
        sha256Sync('jane@example.com', {outputEncoding: 'hex'}));
    assertThat(userData.ph).isEqualTo(
        sha256Sync('31612345678', {outputEncoding: 'hex'}));
    assertThat(userData.client_ip_address).isEqualTo('203.0.113.9');
    assertThat(userData.client_user_agent).isEqualTo('Mozilla/5.0');
- name: Does not hash a value that is already a SHA-256 hash
  code: |-
    const alreadyHashed = sha256Sync('jane@example.com', {outputEncoding: 'hex'});
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'Lead',
      actionSource: 'website',
      hashUserData: true,
      userDataList: [{name: 'em', value: alreadyHashed}],
      logType: 'no'
    };

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(requestBody.data[0].user_data.em).isEqualTo(alreadyHashed);
    assertThat(requestBody.data[0].event_name).isEqualTo('Lead');
- name: Sends one request per dataset when multiple datasets are configured
  code: |-
    const mockData = {
      enableMultiPixel: true,
      pixelTable: [
        {pixelId: '111', accessToken: 'token-1'},
        {pixelId: '222', accessToken: 'token-2'}
      ],
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      apiVersion: 'v26.0',
      logType: 'no'
    };

    const urls = [];
    mock('sendHttpRequest', (url) => {
      urls.push(url);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(urls.length).isEqualTo(2);
    assertThat(urls[0]).isEqualTo('https://graph.facebook.com/v26.0/111/events');
    assertThat(urls[1]).isEqualTo('https://graph.facebook.com/v26.0/222/events');
- name: Does not send anything when ad_storage consent is denied
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      adStorageConsent: 'required',
      logType: 'no'
    };

    mock('getAllEventData', () => {
      return {
        event_name: 'page_view',
        consent_state: {ad_storage: 'denied'}
      };
    });
    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertApi('sendHttpRequest').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: Custom event names and table overrides win over the automatic mapping
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'custom',
      customEventName: 'ConfiguratorSaved',
      actionSource: 'website',
      autoMapServerEventData: true,
      autoMapCustomData: true,
      serverEventDataList: [{name: 'event_id', value: 'evt-override'}],
      customDataList: [{name: 'value', value: '12.5'}],
      logType: 'no'
    };

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    const event = requestBody.data[0];
    assertThat(event.event_name).isEqualTo('ConfiguratorSaved');
    assertThat(event.event_id).isEqualTo('evt-override');
    assertThat(event.custom_data.value).isEqualTo(12.5);
- name: Enriches user data from TrackingHippo module headers without overwriting
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: true,
      enableThEnrichment: true,
      thUseUserId: true,
      thUseGeo: true,
      thOverwrite: false,
      logType: 'no'
    };

    mock('getAllEventData', () => {
      return {
        event_name: 'page_view',
        user_data: {address: {city: 'Amsterdam'}}
      };
    });
    mock('getRequestHeader', (name) => {
      if (name === 'x-user-id') return 'th-user-42';
      if (name === 'x-geo-city') return 'Rotterdam';
      if (name === 'x-geo-country') return 'NL';
      return undefined;
    });

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    const userData = requestBody.data[0].user_data;
    assertThat(userData.external_id).isEqualTo(
        sha256Sync('th-user-42', {outputEncoding: 'hex'}));
    assertThat(userData.ct).isEqualTo(sha256Sync('amsterdam', {outputEncoding: 'hex'}));
    assertThat(userData.country).isEqualTo(sha256Sync('nl', {outputEncoding: 'hex'}));
- name: Restores remembered user data on an event that carries none
  code: |-
    const hashedEmail = sha256Sync('jane@example.com', {outputEncoding: 'hex'});
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: true,
      enableEventEnhancement: true,
      eventEnhancementDays: '30',
      logType: 'no'
    };

    mock('getAllEventData', () => {
      return {event_name: 'page_view'};
    });
    mock('getCookieValues', (name) => {
      if (name === '_th_eec') return [JSON.stringify({em: hashedEmail})];
      return [];
    });

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(requestBody.data[0].user_data.em).isEqualTo(hashedEmail);
- name: User data on the current event wins over remembered data
  code: |-
    const staleEmail = sha256Sync('someone.else@example.com', {outputEncoding: 'hex'});
    const freshEmail = sha256Sync('jane@example.com', {outputEncoding: 'hex'});
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'inherit',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: true,
      enableEventEnhancement: true,
      logType: 'no'
    };

    mock('getCookieValues', (name) => {
      if (name === '_th_eec') return [JSON.stringify({em: staleEmail})];
      return [];
    });

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(requestBody.data[0].user_data.em).isEqualTo(freshEmail);
- name: Remembers durable identity fields but never the request context
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'inherit',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: true,
      enableEventEnhancement: true,
      generateFbp: true,
      logType: 'no'
    };

    let stored;
    mock('setCookie', (name, value) => {
      if (name === '_th_eec') stored = JSON.parse(value);
    });
    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertThat(stored.em).isEqualTo(sha256Sync('jane@example.com', {outputEncoding: 'hex'}));
    assertThat(stored.ph).isEqualTo(sha256Sync('31612345678', {outputEncoding: 'hex'}));
    assertThat(stored.client_ip_address).isUndefined();
    assertThat(stored.client_user_agent).isUndefined();
    assertThat(stored.fbp).isUndefined();
- name: Never writes readable personal data into the enhancement cookie
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'inherit',
      actionSource: 'website',
      autoMapUserData: true,
      hashUserData: false,
      enableEventEnhancement: true,
      logType: 'no'
    };

    const written = [];
    mock('setCookie', (name) => {
      written.push(name);
    });
    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    for (let i = 0; i < written.length; i++) {
      assertThat(written[i]).isNotEqualTo('_th_eec');
    }
- name: Generates _fbc from fbclid and _fbp when the cookies are missing
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      autoMapUserData: true,
      generateFbp: true,
      generateFbc: true,
      cookieMaxAgeDays: '90',
      logType: 'no'
    };

    mock('getAllEventData', () => {
      return {
        event_name: 'page_view',
        page_location: 'https://shop.example.com/?fbclid=CLICK123'
      };
    });
    mock('getCookieValues', () => []);
    mock('getTimestampMillis', () => 1700000000000);
    mock('generateRandom', () => 1234567890);

    let requestBody;
    mock('sendHttpRequest', (url, options, body) => {
      requestBody = JSON.parse(body);
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    const userData = requestBody.data[0].user_data;
    assertThat(userData.fbc).isEqualTo('fb.1.1700000000000.CLICK123');
    assertThat(userData.fbp).isEqualTo('fb.1.1700000000000.1234567890');
    assertApi('setCookie').wasCalled();
- name: Reports failure when Meta rejects the event
  code: |-
    const mockData = {
      pixelId: '1234567890',
      accessToken: 'token-abc',
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      logType: 'no'
    };

    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({statusCode: 400, body: '{"error":{}}'}));
    });

    runCode(mockData);

    assertApi('gtmOnFailure').wasCalled();
- name: Fails when no dataset is configured
  code: |-
    const mockData = {
      eventNameSource: 'standard',
      standardEventName: 'PageView',
      actionSource: 'website',
      logType: 'no'
    };

    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({statusCode: 200, body: '{}'}));
    });

    runCode(mockData);

    assertApi('sendHttpRequest').wasNotCalled();
    assertApi('gtmOnFailure').wasCalled();
setup: |-
  const JSON = require('JSON');
  const Promise = require('Promise');
  const sha256Sync = require('sha256Sync');

  mock('getAllEventData', () => {
    return {
      event_name: 'purchase',
      client_id: 'client-1',
      user_id: 'user-1',
      ip_override: '203.0.113.9',
      user_agent: 'Mozilla/5.0',
      page_location: 'https://shop.example.com/thanks',
      page_referrer: 'https://shop.example.com/checkout',
      currency: 'EUR',
      value: 49.9,
      transaction_id: 'T-1',
      user_data: {
        email_address: 'Jane@Example.com ',
        phone_number: '+31 6 1234 5678'
      },
      items: [
        {item_id: 'SKU-1', item_name: 'Hippo mug', price: 24.95, quantity: 2}
      ]
    };
  });

  mock('getCookieValues', () => []);
  mock('getRequestHeader', () => undefined);


___NOTES___

Created on 11/08/2026 by TrackingHippo.io

This tag sends events to the Meta Conversions API from a Google Tag Manager server
container. It never contacts any host other than graph.facebook.com.

Personal data is normalised and hashed with SHA-256 inside the container before it
leaves the server; values that already arrive hashed are passed through untouched.


