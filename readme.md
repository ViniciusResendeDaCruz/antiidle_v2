# Anti Idle

This is a small utility that prevents your Windows PC from going idle, turning off the display, or entering sleep mode.

![Main Window](https://github.com/user-attachments/assets/770f8d3e-e04e-411a-8a23-f5dc64bd3a17)

## New Features

### Mouse Move Settings

We've introduced a new configuration option for the **Move mouse** feature, allowing you to customize how the mouse movement prevents the system from going idle. You can now adjust the following settings:

- **Mouse Move Interval (ms)**: Set the interval, in milliseconds, at which the mouse moves. This determines how frequently the mouse movement occurs.
- **Mouse Move Amount (pixels)**: Specify the number of pixels the mouse moves each time. This controls how far the mouse cursor moves on the screen.

These settings provide greater flexibility and control, enabling you to fine-tune the mouse movement to suit your specific needs.

![Mouse Settings Window](https://github.com/user-attachments/assets/89efa9e6-4edb-44f6-80e5-f71da5517fc0)

To access the Mouse Move Settings:

1. Click on the **File** menu in the main window.
2. Select **Mouse Settings** from the dropdown menu.
3. Adjust the **Mouse Move Interval** and **Mouse Move Amount** as desired.
4. Click **Save** to apply the changes or **Cancel** to discard them.

## Usage

Anti Idle can be run as an [AutoHotkey](https://www.autohotkey.com/) script or by using the standalone executable in the Releases section.

There are three methods of preventing the system from going idle. You can choose any or all of them, depending on your needs:

- **Keep display active**: Signals to Windows that the Anti Idle app requires the display to remain on. This method should work in most cases without additional configuration.
- **Move mouse**: Moves the mouse cursor up and down by a specified number of pixels at periodic intervals. This simulates user activity to prevent the system from detecting idle status.
- **Press modifier keys**: Simulates pressing the Shift and Ctrl keys at periodic intervals. This is particularly useful in certain games or applications that detect AFK (away from keyboard) players.

### Steps to Use Anti Idle:

1. **Run the Application**: Launch the Anti Idle script using AutoHotkey or run the compiled executable.
2. **Select Options**: In the main window, check the boxes for the methods you want to use:
   - **Keep display active**
   - **Move mouse** (configure settings if needed)
   - **Press modifier keys**
3. **Configure Mouse Move Settings** (optional):
   - Go to **File > Mouse Settings**.
   - Adjust the **Mouse Move Interval** and **Mouse Move Amount**.
   - Click **Save** to apply the settings.
4. **Start Anti Idle**: Click the **Start** button to activate the selected methods.

## Credits

This project is a fork of the original [Anti Idle](https://github.com/mihaifm/antiidle) by [mihaifm](https://github.com/mihaifm). We extend our gratitude to the original creator for his excellent work and contribution to the community.

---

Enjoy keeping your PC active without interruptions!
