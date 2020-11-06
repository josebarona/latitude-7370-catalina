#!/bin/bash

if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/bash "$0" "$@"
fi

cd "$( dirname "${BASH_SOURCE[0]}" )"

# Clean legacy stuff
#
# sudo launchctl unload /Library/LaunchDaemons/com.XPS.ComboJack.plist 2>/dev/null
# sudo rm -rf /Library/Extensions/CodecCommander.kext
# sudo rm -f /usr/local/bin/ALCPlugFix
# sudo rm -f /Library/LaunchAgents/good.win.ALCPlugFix
# sudo rm -f /Library/LaunchDaemons/good.win.ALCPlugFix
# sudo rm -f /usr/local/sbin/hda-verb
# sudo rm -f /usr/local/share/ComboJack/Headphone.icns
# sudo rm -f /usr/local/share/ComboJack/l10n.json

# install 
#mkdir -p /usr/local/sbin
sudo cp -r /Users/josebarona/Documents/audifonos/ComboJack-master/ComboJack_Installer/ComboJack /Users/josebarona/headphone-stuff
sudo chmod 755 /Users/josebarona/headphone-stuff
sudo chown root:wheel /Users/josebarona/headphone-stuff
sudo spctl --add /Users/josebarona/headphone-stuff
sudo cp -r /Users/josebarona/Documents/audifonos/ComboJack-master/ComboJack_Installer/hda-verb /Users/josebarona/headphone-stuff
#sudo chmod 755 /usr/local/sbin/hda-verb
#sudo chown root:wheel /usr/local/sbin/hda-verb
#sudo mkdir -p /usr/local/share/ComboJack/
sudo cp -r /Users/josebarona/Documents/audifonos/ComboJack-master/ComboJack_Installer/Headphone.icns /Users/josebarona/headphone-stuff/extra
sudo chmod 644 /Users/josebarona/headphone-stuff/extra/Headphone.icns
sudo cp -r /Users/josebarona/Documents/audifonos/ComboJack-master/ComboJack_Installer/l10n.json /Users/josebarona/headphone-stuff/extra
sudo chmod 644 /Users/josebarona/headphone-stuff/extra/l10n.json
sudo cp -r /Users/josebarona/Documents/audifonos/ComboJack-master/ComboJack_Installer/com.XPS.ComboJack.plist /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/com.XPS.ComboJack.plist
sudo chown root:wheel /Library/LaunchDaemons/com.XPS.ComboJack.plist
sudo launchctl load /Library/LaunchDaemons/com.XPS.ComboJack.plist
echo
echo "Please reboot! Also, it may be a good idea to turn off \"Use"
echo "ambient noise reduction\" when using an input method other than"
echo "the internal mic (meaning line-in, headset mic). As always: YMMV."
echo
echo "You can check to see if the watcher is working in the IORegistry:"
echo "there should be a device named \"VerbStubUserClient\" attached to"
echo "\"com_XPS_SetVerb\" somewhere within the \"HDEF\" entry's hierarchy."
echo
echo "Enjoy!"
echo
exit 0
