# OstWalletUI Theme Config
App developers can configure the UI Components available in OstWalletUI.

To configure the content, the sdk needs to be provided with [`Dictionary`](https://developer.apple.com/documentation/swift/dictionary)

The default configuration can be found [here](../OstWalletSdk/UI/Config/OstThemeConfig.json).

To support custom font for application, please refer [apple documentation](https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app)


## Dictionary Data Structure
Here is the small sample `json` representation of the configuration.
```js
{
  "h1": {
    "size": 20
  }
}
```

In the above example:

* The first-level key `h1` corresponds to H1 Component.
* The second-level key `size` is corresponds to size of H1 label.

> **important**
> 1. Application navigation bar logo image should be added in `assets` folder for iOS/android.
> 2. Value for `nav_bar_logo_image -> asset_name` should be updated with *asset_name* else OST placehoder image will be applied.
> 3. Incase of missing properties, default values will be applied to respective components.

## Supported Components

### Label

Here, we refer follwing components as 'Label':
* H1
* H2
* H3
* H4
* C1
* C2

The following UI components properties supported by label:

| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| size                 | number             |
| font                 | string             |
| color                | hex value(String)  |
| alignment            | string             |
| system_font_weight   | string             |


Supported Values for *alignment* are:
* left
* right
* center

Supported Values for *system_font_weight* are:
* bold
* regular
* medium
* semi_bold

### Button

Here, we refer follwing components as 'Button':
* B1
* B2
* B3
* B4

The following UI components properties supported by button:

| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| size                 | number             |
| font                 | string             |
| color                | hex value(String)  |
| background_color     | hex value(String)  |
| system_font_weight   | string             |

### EditText

The following UI component properties supported by EditText:

| Configuration Keys   | Type               |
| -------------------- | :----------------: |
| size                 | number             |
| color                | hex value(String)  |
| background_color     | hex value(String)  |
| system_font_weight   | string             |
| placeholder          | JSON Object        |

The following are the placeholder properties

| Configuration Keys   | Type               |
| -------------------- | :----------------: |
| size                 | number             |
| color                | hex value(String)  |
| system_font_weight   | string             |

 ### Navigation Bar
 
 The following UI components properties supported by navigation bar:
 
| Configurable component | Value to Modify                 | 
| ---------------------- | :-----------------------------: |
| bar logo               | nav_bar_logo_image.asset_name   |
| bar tint color         | navigation_bar.tint_color       |
| close icon tint color  | icons.close.tint_color          |
| close icon tint color  | icons.back.tint_color           |

 ### Pin Input(pin_input)
 
 The following UI components properties supported by pin component:
 
| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| empty_color          | hex value(String)  |
| filled_color         | hex value(String)  |
 
 ### Cell Separator
 
 The following UI components properties supported by cell separator:
 
| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| color                | hex value(String)  |

 ### Link
 
 The following UI components properties supported by link:
 
| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| size                 | number             |
| color                | hex value(String)  |
| system_font_weight   | string             |
| alignment            | string             |

 ### status

The following UI components properties supported by status:

| Configuration Keys   | Type               | 
| -------------------- | :----------------: |
| size                 | number             |
| color                | hex value(String)  |
| system_font_weight   | string             |
| alignment            | string             |

## UI Components 

![copy-framework-file](images/NavBar.png)

![copy-framework-file](images/PinView.png)

![copy-framework-file](images/Card.png)

![copy-framework-file](images/TextField.png)
