# Rule of 72 UI Helpers

UIKit subclasses and extensions.


## ActionSheetWithIcon

Create a `UIAlertAction` with an icon that can be added to a `UIAlertController` action sheet.

The icon can be provided as a UIImage or as a named image from SFSymbols. 

### Usage — Swift

```swift
let alert = UIAlertController(title: "FILE OPERATIONS", message: nil, preferredStyle: .actionSheet)
alert.addAction(
    UIAlertAction(title: "Save file", icon: myImage, style: .default) { action in
    ⋮
    }
)
alert.addAction(
    UIAlertAction(title: "Delete file", systemImageName: "trash", style: .destructive) { action in
    ⋮
    }
)
```

## AutoFadeLabel

A subclass of `UILabel` that automatically fades its message away.

### Usage — Swift

```swift
import AutoFadeLabel
class MyViewController: UIViewController {
    let fadingLabel = AutoFadeLabel()
    fadingLabel.duration = 4.0
⋮
    fadingLabel.text = "Hello world"
}
```

### Usage — Storyboard

- Add a `UILabel` to your Storyboard.
- Set the custom class to `AutoFadeLabel`.
- Set the module to AutoFadeLabel.
- In the property inspector, set the `duration` property to the number of seconds the animation should take.
- Add an `@IBOutlet` of type `AutoFadeLabel` (not `UILabel`) to your view controller and attach it to the label.

```swift
import AutoFadeLabel
class MyViewController: UIViewController {
    @IBOutlet weak var fadingLabel: AutoFadeLabel!
⋮
    fadingLabel.text = "Hello world"
}
```

```xml
<label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" text="Hello world" textAlignment="center" lineBreakMode="middleTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="XXX-XX-XXX" userLabel="Copied name" customClass="AutoFadeLabel" customModule="AutoFadeLabel">
    <rect key="frame" x="100.0" y="100.0" width="100.0" height="20.5"/>
    <fontDescription key="fontDescription" type="system" pointSize="17"/>
    <nil key="textColor"/>
    <nil key="highlightedColor"/>
    <userDefinedRuntimeAttributes>
        <userDefinedRuntimeAttribute type="number" keyPath="duration">
            <real key="value" value="4.0"/>
        </userDefinedRuntimeAttribute>
    </userDefinedRuntimeAttributes>
</label>
```

## IntrinsicSizeTableView

A subclass of `UITableView` that calculates its height for the `.intrinsicContentSize` property.

This helps the table view participate in certain Auto Layout scenarios, particularly involving content hugging and compression resistance.

### Usage — Swift

Use `IntrinsicSizeTableView` just as you would an ordinary `UITableView`.

### Usage — Storyboard

- Add a `UITableView` to your Storyboard.
- Set the custom class to `IntrinsicSizeTableView`.
- Set the module to IntrinsicSizeTableView.
- Add an `@IBOutlet` of type `IntrinsicSizeTableView` (not `UITableView`) to your view controller and attach it to the table view.

```swift
import IntrinsicSizeTableView
class MyViewController: UIViewController {
    @IBOutlet weak var tableView: IntrinsicSizeTableView!
⋮
}
```

## RatioImageView

A subclass of `UIImageView` that preserves the natural aspect ratio of its image when participating in a `UIStackView`.

### Usage — Swift

```swift
let imageView = RatioImageView(image: logoImage)
imageView.contentMode = .scaleAspectFit

let stackView = UIStackView()
stack.addArrangedSubview(imageView)
```

### Usage — Storyboard

- Add a `UIImageView` to your Storyboard.
- Set the custom class to `RatioImageView`.
- Set the module to RatioImageView.
- Recommended: in the property inspector, set the Content Mode to Scale Aspect Fit.
- Assign the correct image from your project’s assets.
- Add an `@IBOutlet` of type `RatioImageView` (not `UIImageView`) to your view controller and attach it to the image view.

```swift
import RatioImageView
class MyViewController: UIViewController {
    @IBOutlet weak var imageView: RatioImageView!
⋮
}
```

```xml
<stackView opaque="NO" contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="XXX-YY-ZZZ" userLabel="Logo Stack View">
    <rect key="frame" x="0.0" y="0.0" width="500" height="100.0"/>
    <subviews>
    ⋮
        <imageView clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleAspectFit" horizontalHuggingPriority="251" verticalHuggingPriority="251" horizontalCompressionResistancePriority="250" verticalCompressionResistancePriority="250" image="Logo" translatesAutoresizingMaskIntoConstraints="NO" id="AAA-AA-AAA" customClass="RatioImageView" customModule="RatioImageView">
            <rect key="frame" x="0.0" y="0.0" width="260" height="100.0"/>
            <edgeInsets key="layoutMargins" top="0.0" left="0.0" bottom="0.0" right="0.0"/>
        </imageView>
    ⋮
    </subviews>
</stackView>
```

## TextCollector

A modal (presented) view controller that prompts the user for one or more text fields.

Each field has a validator. The OK button is disabled unless all validators pass.

### Usage — Swift

```swift
func promptForLink(sender: UIView) {
    let title = "SAVE LINK"
    let message = "Enter the text and URL of the link."

    let textCollector = TextCollector()

    textCollector.addField(
        originalText: self.previouslySavedText,
        placeholderText: "Text …",
        validator: { text in
            !text.isEmpty
        }
    )

    textCollector.addField(
        originalText: self.previouslySavedURL,
        placeholderText: "https:// ",
        validator: { candidate in
            guard candidate.starts(with: "https://") else { return false }
            guard let url = URL(string: candidate) else { return false }
            return UIApplication.shared.canOpenURL(url)
        }
    )

    textCollector.show(title: title, message: message, hostingViewController: self, sourceView: sender) { result in
        switch result {
            case .canceled:
                return

            case .ok (let results):
                guard results.count == 2,
                      let text = results[0],
                      let url = results[1]
                else {
                    return
                }

                self.savedURL = url
                self.savedText = text
        }
    }
}
```

## TintedOffSwitch

A subclass of `UISwitch` that lets you set a tint color for the switch when it is Off. 

### Usage — Swift

```swift
let switch = TintedOffSwitch()
switch.offTintColor = UIColor.systemRed
```

### Usage — Storyboard

- Add a `UISwitch` to your Storyboard.
- Set the custom class to `TintedOffSwitch`.
- Set the module to TintedOffSwitch.
- In the property inspector, choose a color for the Off Tint Color.
- Add an `@IBOutlet` of type `TintedOffSwitch` (not `UISwitch`) to your view controller and attach it to the switch.
- Add an `@IBAction` handler for `valueChanged`. Declare the `sender` to be `TintedOffSwitch`, not `UISwitch`.

```xml
<switch opaque="NO" contentMode="scaleToFill" horizontalHuggingPriority="750" verticalHuggingPriority="750" contentHorizontalAlignment="center" contentVerticalAlignment="center" translatesAutoresizingMaskIntoConstraints="NO" id="xxx-yy-zzz" userLabel="Switch" customClass="TintedOffSwitch" customModule="TintedOffSwitch">
    <rect key="frame" x="100.0" y="100.0" width="51" height="31"/>
    <userDefinedRuntimeAttributes>
        <userDefinedRuntimeAttribute type="color" keyPath="offTintColor">
            <color key="value" systemColor="systemRedColor"/>
        </userDefinedRuntimeAttribute>
    </userDefinedRuntimeAttributes>
    <connections>
        <action selector="switchFlipped:" destination="AAA-BB-CCC" eventType="valueChanged" id="999-99-999"/>
    </connections>
</switch>
```
