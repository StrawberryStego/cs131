# Open Source FileBot 🗃️
This is a primitive shell-script to semi-replicate [Filebot's](https://www.filebot.net/) behavior.

## Function
Batch-rename files in the SXXEXX format, i.e., S01E05. 
<br> For unorganized filenames, e.g., FirstEpisode.mp4, the script will default to S01EXX.mp4.
<br><br>This is useful for batch renaming TV show episodes, and works with all media files.
<br><br>You'll also get confirmation prompts before FileBot does *anything* to reduce irregular errors!

## Parameters
\# Usage: tv_renamer.sh [seasonNumber (Default: 1)] [totalPathToFile (Default: current directory)]
>Filebot will generally match with a filename's existing season and episode number, e.g., S01E01 in Chernobyl.S01E01.1.23.45.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv,
but for unorganized filenames like A.mp4, it can be useful to input a seasonNumber.

## Installation
Download tv_renamer.sh. Make sure the script is executable, i.e., chmod 777 tv_renamer.sh. Run using bash.

## Examples
>`/Chernobyl (Season 1)/`
   <br>&nbsp;&nbsp;&nbsp;&nbsp;`Chernobyl.S01E01.1.23.45.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv`
   <br>&nbsp;&nbsp;&nbsp;&nbsp;`Chernobyl.S01E02.Please.Remain.Calm.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv`
   <br>&nbsp;&nbsp;&nbsp;&nbsp;`Chernobyl.S01E03.Open.Wide.O.Earth.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv`
   <br>&nbsp;&nbsp;&nbsp;&nbsp;`Chernobyl.S01E04.The.Happiness.of.All.Mankind.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv`
   <br>&nbsp;&nbsp;&nbsp;&nbsp;`Chernobyl.S01E05.Vichnaya.Pamyat.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv`

&nbsp;&nbsp;&nbsp;&nbsp;In the Chernobyl folder, `bash tv_renamer.sh`:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`./Chernobyl.S01E01.1.23.45.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv -> S01E01.mkv`
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm rename? (y/n): y
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`./Chernobyl.S01E02.Please.Remain.Calm.2160p.DTS-HD.MA.5.1.DV.HEVC.REMUX-FraMeSToR.mkv -> S01E02.mkv`
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm rename? (y/n): y
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`...`
<br>

---	

>`/SomeUnorganizedSeason3Episodes/`
<br>&nbsp;&nbsp;&nbsp;&nbsp;`A.mov`
<br>&nbsp;&nbsp;&nbsp;&nbsp;`B.mov`
<br>&nbsp;&nbsp;&nbsp;&nbsp;`C.mov`
<br>&nbsp;&nbsp;&nbsp;&nbsp;`D.mov`

&nbsp;&nbsp;&nbsp;&nbsp;In the unorganized folder, `bash tv_renamer.sh 3`:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`./A.mov -> S03E01.mov`
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm rename? (y/n): y
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`./B.mov -> S03E02.mkv`
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm rename? (y/n): y
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`...`
