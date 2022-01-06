#!/bin/bash
#requires unzip, wget, basename, dotnet, md5sum

#USER SUPPLIED VARIABLES
install_directory="/path/to/steamapps/common/Horizon Zero Dawn"
steam_username="xXx_360-no-scope_killer"
steam_password="alligator1"



#Touch nothing below this comment unless you know what you are doing
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) #https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
depot_downloader_release_url="https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_2.4.5/depotdownloader-2.4.5.zip"
depot_downloader_install_dir="${script_dir}/depotdownloader"
cache_directory="${script_dir}/cache"
file_download_list="${script_dir}/filelist.txt"
files=( 
    "/HorizonZeroDawn.exe"
    "/LocalCacheDX12/HashDB.bin"
    "/LocalCacheDX12/ShaderLocationDB.bin"
    "/Packed_DX12/Patch.bin"
)

get_manifest () {
  dotnet "${depot_downloader_install_dir}/DepotDownloader.dll"\
   -app "$1" -depot "$2" -manifest "$3" -username "$steam_username" -password "$steam_password"\
   -dir "$depot_downloader_install_dir/depots/$2" -filelist "$file_download_list"
  for file_name in ${files[@]}
  do
    file_finder="${depot_downloader_install_dir}/depots/$2/${file_name}"

    if [ -f "$file_finder" ]
    then
        dir_name=`dirname "${cache_directory}${file_name}"`
        mkdir --parents $dir_name
        cp "${file_finder}" "${dir_name}"
    fi
  done
}

if [ ! -d "$cache_directory" ]
then
  depot_downloader_file=`basename $depot_downloader_release_url` 
  
  wget "$depot_downloader_release_url" -P "$script_dir"
  unzip -o "${script_dir}/${depot_downloader_file}" -d "$depot_downloader_install_dir"
  rm "${script_dir}/${depot_downloader_file}"

  get_manifest 1151640 1151641 8564283306590138028
  get_manifest 1151640 1151642 2110572734960666938
  rm -r "$depot_downloader_install_dir"
fi


for file_name in ${files[@]}
  do
    installed_file="${install_directory}${file_name}"
    cached_file="${cache_directory}${file_name}"
    md5sum_installed=($(md5sum "$installed_file"))
    md5sum_cached=($(md5sum "$cached_file"))

    if [ "$md5sum_installed" != "$md5sum_cached" ]
    then
        echo "copying commencing for ${file_name}"
        cp "${cached_file}" "$installed_file"
    else
        echo "no changes for ${file_name}"
    fi
done

echo "script? completed it m8." > $script_dir/confirmation.log
