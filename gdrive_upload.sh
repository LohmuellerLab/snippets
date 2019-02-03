#This script is an example of how to use gdrive command line tools to upload
#files to Google Drive, for instance, to back up a set of project files

# @author: Bernard

#download gdrive CLI
#pick the right file from https://github.com/prasmussen/gdrive
#the example is with a 64-bit linux binary
#or for mac os you can use Homebrew, "$ brew install gdrive"

wget -o logfile -q https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download && \
  mv uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA gdrive && chmod +x ./gdrive

#do this for authentication. don't forget to pick your institutional (unlimited) account
#go to link and copy and paste verification code
./gdrive list

#make new folder for transfer in your default directory. i think you have to manually 
#transfer files to team drive directories, but that should be instantaneous
foldername="testFolder"
folderid=$(./gdrive mkdir ${foldername} | awk '{print $2}')

#you can also look up the folder id by going to the folder in your web browser
#it will be in the format
echo "This is the URL of the folder you just created"
echo "https://drive.google.com/drive/u/1/folders/${folderid}"

#download to stdout with test README file from NCBI,
#pipe that over to gdrive upload
#this shouldn't directly use hard drive space unless somehow the swap space gets utilized
#since it's a direct pipe to the upload
wget -qO - "ftp://ftp.ncbi.nlm.nih.gov/README.ftp" | \
  ./gdrive upload /dev/stdin -p ${folderid} --name "README.ftp"
