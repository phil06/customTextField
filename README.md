# customTextField
textfield framework

```swift
import CustomTextField

var txt1: CustomTextField!
```

## input 영역 설정
```swift
txt1.setTextFieldLayout(inset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5), maxInput: 10, useAccessoryView: .Default, font: UIFont.systemFont(ofSize: 10))
txt1.setFontColor(color: UIColor.yellow)
txt1.setPlaceholder(txt: "뭔가 입력하세여")
```

  accessoryView.Default
  이미지 넣기..
  accessoryView.NextPrevious
  이미지 넣기...
  
  done, next, prev 노티피케이션 정보 입력하기...
  
  ## 왼쪽 아이콘 설정
  ```swift
  txt1.setIconLayout(img: UIImage(named: "icon")!, inset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5))
  ```
  
  ## 오른쪽 아이콘 설정
  ```swift
  txt1.setAdditionalIcon(img: UIImage(named: "icon")!, trailingInset: 16)
  ```
  
  ## 키보드 타입
  ```swift
  txt1.setKeyboardType(type: UIKeyboardType.numberPad)
  ```
  
  ## border
  ```swift
  txt1.setTextFieldLine(edge: [.top, .bottom], color: UIColor.white, thickness: 1)
  ```
  
  ## pickerView 사용
  ```swift
  var pickerList:[String] = []
  pickerList.append("가가가가가")
  pickerList.append("니니니니니")
  pickerList.append("다다다다다")
  
  txt1.usePickerView(listTitle: pickerList)
  ```
  
  ### 선택된 pickerView 아이템 가져오기
  ```swift
  let idx = txt1.inputPickerView.selectedRow(inComponent: 0)
  ```
  
