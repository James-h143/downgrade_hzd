# downgrade_hzd

script designed to downgrade Horizon Zero Dawn from 1.11 (current at the time of writing) to 1.10

I expect this script to be deprecated pretty quickly

## How to install

  * clone this repository to a location of your choosing (or alternatively download `downgrade_hzd.sh` and place it in a directory of your choosing on its own)
  * Ensure you have these programs available on your linux distribution: unzip, wget, basename, dotnet, md5sum (the only one you are likely not to have is dotnet; you can install it with `snap install dotnet-sdk --classic --channel=latest/edge`)
  * change the `USER SUPPLIED VARIABLES` section in `downgrade_hzd.sh` you **MUST** supply all three values for this script to work
  * change the launch options to something along the lines of `/path/to/downgrade_hzd/downgrade_hzd.sh > /dev/null && %command%`

## First time run

the first time you run this script you are probably going to want to run it in the terminal so you can see what it is doing. on the first run it fetches the manifests using depotdownloader, this can take a few minutes so having the feedback while that's happening will reassure you that the script is still running. once this is done it caches the files it needs for the downgrade. on subsequent runs it will check if steam has updated the game files again and if so it performs another downgrade using the cached files, thus running a lot faster.
