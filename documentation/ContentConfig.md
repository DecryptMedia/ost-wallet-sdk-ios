# OstWalletUI Content Config
App developers can configure the text shown on various views displayed by OstWalletUI.

To configure the content, the sdk needs to be provided with [`Dictionary`](https://developer.apple.com/documentation/swift/dictionary).

The default configuration can be found [here](../OstWalletSdk/UI/Config/OstContentConfig.json).

## Dictionary Data Structure
Here is the small sample `json` representation of the configuration.
```js
{
  "activate_user": {
    "create_pin": {
      "title_label": {
        "text": "Activate Your Wallet"
      }
    }
  }
}
```

In the above example:
* The first-level key `activate_user` corresponds to `Activate User` workflow.
* The second-level key `create_pin` corresponds to `Create Pin` view.
* The third-level key `title_label` corresponds to label that displays the title of the view.
* The fourth-level key `text` is corresponds to diplay text to the title label.

## Supported Workflows
OstWalletUI supports 8 workflows

| Configuration Keys   | Workflows                   |
| -------------------- |:---------------------------:|
| activate_user        | Activate User               |
| add_session          | Add Session                 |
| initiate_recovery    | Initialize Recovery         |
| abort_recovery       | Abort Device Recovery       |
| revoke_device        | Revoke Device               |
| biometric_preference | Update Biometric Preference |
| reset_pin            | Reset a User's PIN          |
| view_mnemonics       | Get Mnemonic Phrase         |

## Supported Views
### Activate User Workflow Views

| Configuration Keys   | Views                                                       |
| -------------------- | ----------------------------------------------------------- |
| create_pin           | Create Pin View where user sets the pin for first time      |
| confirm_pin          | Confirm Pin View where user confirms the pin again          |

### Add Session Views

| Configuration Keys   | Views                                                      |
| -------------------- | ---------------------------------------------------------- |
| get_pin              | Get Pin View where user provides pin for authentication    |

### Initialize Recovery Views

| Configuration Keys   | Views                                                       |
| -------------------- | ----------------------------------------------------------- |
| device_list          | Displays list of authorized devices for user to choose from |
| get_pin              | Get Pin View where user provides pin for authentication     |


### Abort Device Recovery Views

| Configuration Keys   | Views                                                      |
| -------------------- | ---------------------------------------------------------- |
| get_pin              | Get Pin View where user provides pin for authentication    |

### Revoke Device Views

| Configuration Keys   | Views                                                       |
| -------------------- | ----------------------------------------------------------- |
| device_list          | Displays list of authorized devices for user to choose from |
| get_pin              | Get Pin View where user provides pin for authentication     |

### Update Biometric Preferences Views

| Configuration Keys   | Views                                                      |
| -------------------- | ---------------------------------------------------------- |
| get_pin              | Get Pin View where user provides pin for authentication    |

### Reset a User's PIN Views

| Configuration Keys   | Views                                                      |
| -------------------- | ---------------------------------------------------------- |
| get_pin              | Get Pin View where user provides current pin               |
| set_new_pin          | View where user sets the new pin                           |
| confirm_new_pin      | Confirm Pin View where user confirms the new pin again     |

### Get Mnemonic Phrase Views

| Configuration Keys   | Views                                                      |
| -------------------- | ---------------------------------------------------------- |
| get_pin              | Get Pin View where user provides pin for authentication    |
| show_mnemonics       | Displays 12 word mnemonics of device                       |


## Supported UI Components in PIN Input Views
Here, we refer follwing views as 'Pin Input' views:
* create_pin
* confirm_pin
* get_pin
* set_new_pin
* confirm_new_pin

The following UI components are supported by Pin Input views.

| Configuration Keys        | Component Type | 
| ------------------------- |:--------------:|
| title_label               | label          |
| lead_label                | label          |
| info_label                | label          |
| terms_and_condition_label | label          |

Here is PIN Input View looks like:

![copy-framework-file](images/PinViewLabelTypes.png)

### Adding links to `terms_and_condition_label`
`terms_and_condition_label` is a special label that supports inline links using `placeholder` within the text.

Below is a sample configuration to achive the same:
```js
{
  "activate_user": {
    "create_pin": {
      "terms_and_condition_label": {
        "text": "Please refer our {{t_and_c}} and {{privacy_policy}}"
      },
      "placeholders": {
        "t_and_c": {
          "url": "https://ost.com/terms",
          "text": "Terms and Conditions",
          "color": "#0076FF"
        },
        "privacy_policy": {
          "url": "https://ost.com/privacy",
          "text": "Privacy Policy",
          "color": "#0076FF"
        }
      }
    }
  }
}
```
#### NOTE
```
As of now, `placeholder` is only applicable to `terms_and_condition_label` 
and is NOT supported by other labels.
```


## Supported UI Components in Device List Views (device_list)

The following UI components are supported by Device List Views.

| Configuration Keys        | Component Type | 
| ------------------------- |:--------------:|
| title_label               | label          |
| info_label                | label          |
| action_button             | button text    |

Here is Device List View looks like:

![copy-framework-file](images/DeviceListLabelTypes.png)

## Supported UI Components in Show Mnemonics Views(show_mnemonics)

The following UI components are supported by Show Mnemonics Views.

| Configuration Keys        | Component Type | 
| ------------------------- |:--------------:|
| title_label               | label          |
| info_label                | label          |
| bottom_label              | label          |

![copy-framework-file](images/ViewMnemonicsLabelTypes.png)
