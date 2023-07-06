# 1914 translation by H. Rackham

"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."


:::tip

This section is focused on styling through stylesheets. For more advanced customizations (DOM structure, React code...), refer to the [swizzling guide](./swizzling.md).

:::

:::info

This section is focused on styling through stylesheets. For more advanced customizations (DOM structure, React code...), refer to the [swizzling guide](./swizzling.md).

:::

:::caution

This section is focused on styling through stylesheets. For more advanced customizations (DOM structure, React code...), refer to the [swizzling guide](./swizzling.md).

:::

:::danger

This section is focused on styling through stylesheets. For more advanced customizations (DOM structure, React code...), refer to the [swizzling guide](./swizzling.md).

:::


%%%xml-java
```xml
<OpenSansBoldTextView
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="@string/label"/>
```
--split--
```kotlin
@Composable
fun Checkbox(
    checked: Boolean,
    onCheckedChange: ((Boolean) -> Unit)?,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    colors: CheckboxColors = CheckboxDefaults.colors(),
    interactionSource: MutableInteractionSource = remember { MutableInteractionSource() }
): Unit
```
%%%

:::caution

This section is focused on styling through stylesheets. For more advanced customizations (DOM structure, React code...), refer to the [swizzling guide](./swizzling.md).

:::

# 1914 translation by H. Rackham

"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"

- test bullet 1
- test bullet 2
- test bullet 3


1. test numeric list

   asdadadad

2. asdf ghjkl

   asdasdasd

3. asdas
4. sample number 4


# test HTML

<style>
.row{
    background-color: #E9ECEF;
    overflow: hidden;
}
.img_col{
    float: left;
    width: 50%;
    position: relative;
}
.txt_col{
    color: #495057;
    margin-left: 10px; 
    float: left;
}
</style>

<div class=row>
    <div class=img_col>
        <img src=".assets/1-1377908956.png">
    </div>
    <p class=txt_col>
    1. Primary10<br>
    2. 8px<br>
    3. Black30<br>
    4. Black10<br>
    5. Black20<br>
    6. 8px<br>
    7. Black10<br>
    </p>
</div>
<br>