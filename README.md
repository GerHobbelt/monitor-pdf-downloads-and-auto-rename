# What this is for

FireFox, Waterfox et al do not auto-rename downloaded files to unique names, the way Chrome & Edge do. FireFox & colleagues hence produce a filename collision when you happen to download a same-named file (maybe even a duplicate :shudder: !) from the internet. 

Meanwhile Chrome & Edge don't care, observe that the download target filename already exists in your `Downloads` directory and simply adds a unique number to the new filename currently being downloaded: **this is my preferred behaviour**.


# This script solves my problem

My preferred browser behaviour for *any download* is to keep out of the way and be non-obstructive. FireFox / WaterFox / etc. *are obnoxious* in this regard as they throw alertboxes in my face about same-named files possibly already present in my `Downloads` directory as those were obtained elsewhere during the same session / day. I want Chrome/Edge auto-unique file naming behaviour from *everybody*! 

This is my preferred behaviour as now I don't have to bother with **surprising** alert boxes about a same-named file already present in my downloads dir -- when I'm looking for PDFs and other material, *I do not care if I end up with a few maybe-duplicates, for I have [quick & powerful tooling to deal with those afterwards](https://malich.ru/duplicate_searcher#download), plus I don't want to be bothered with filenaming technicalities obstructing my workflow, just because several people on the 'net decided to name their download `download.pdf`, for example.*




# What does it do?

The PowerShell script monitors the directory it resides in and monitors any new PDF files appearing. **When any new files are discovered, these are automatically renamed to a "*guaranteed unique name*" by appending a (content-hash + time)-based and easily identifiable suffix to the filename.** For example: `thesis.pdf` becomes something like `thesis-HH00987654321ABCDEF-T20250504121347.pdf`.

When you place this PowerShell script in your `Downloads` directory and run it (it will run forever, until aborted by Ctrl+C keyboard shortcut), it will thus monitor the `Downloads` directory for you and help produce downloaded-file-naming behaviour similar to that of Chrome & Edge: every download will shortly end up with a unique name.

This is my preferred behaviour as now I don't have to bother with **surprising** alert boxes about a same-named file already present in my downloads dir -- when I'm looking for PDFs and other material, *I do not care if I end up with a few duplicates, for I have quick & powerful tooling to deal with those afterwards, plus I don't want to be bothered with filenaming technicalities obstructing my workflow, just because several people on the 'net decided to name their download `download.pdf`, for example.*


# Installation and use

Place the `ps1` PowerShell script in your `Downloads` directory and run it from a PowerShell terminal.

It will run forever, until aborted by Ctrl+C keyboard shortcut.

The script will thus continuously monitor the `Downloads` directory for you and help produce downloaded-file-naming behaviour similar to that of Chrome & Edge: every download will shortly end up with a unique name.

Care has been taken to ensure the CPU is loaded very minimally: the `Downloads` directory is quickly scanned once every second.

