# Heil Erika
## MATLAB and Arduino code to process music (like Erika) and to present the power of each beat into Voltmeter

If you have a voltmeter, with indicator being able to move from horizontal to vertical, when you stick the Fürher's hand to the indicator and the body next to it, you will find it salutes with the music, which is very funny (just for entertaining, nothing politically)

It will look like this:

![video_20241208_174623_1_cropped](https://github.com/user-attachments/assets/e32d4a41-3784-4f49-80ac-90544679424c)

----
The MATLAB code is used to process the music. It calculates the power of each beat of the song, and mapping it to unsigned 8-bit integer. The smallest power is mapped to 0 and the largest is 255. Then MATLAB transfers those digits to Arduino through Serial Port. 

Arduino code simply receives these digits and use it as Analogue Output parameters, with 0 being 0V and 255 being 5V

----
All you need is to have an Arduino and a voltmeter. Connect the arduino to your computer, choose a music and set the beats per minute (BPM) of the music, then connect the Arduino analogue output to voltmeter, you will have that meter heil to you.
