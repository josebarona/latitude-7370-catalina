const fs = require("fs");
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const username = __dirname.split("/")[2];
const sudoPassword = "COMEVERGA";

async function m() {
    try {
        const dest = `/Users/${username}/headphone-fix`;
        await execute(`mkdir ${dest}`);
        await execute(`cp -r ${__dirname}/ComboJack ${dest}`);
        await execute(`chmod 755 ${dest}`);
        await execute(`chown root:wheel ${dest}`);
        await execute(`spctl --add ${dest}`);
        await execute(`cp -r ${__dirname}/hda-verb ${dest}`);
        await execute(`chmod 755 ${dest}/hda-verb`);
        await execute(`chown root:wheel ${dest}/hda-verb`);
        await execute(`cp -r ${__dirname}/Headphone.icns ${dest}`);
        await execute(`chmod 644 ${dest}/Headphone.icns`);
        await execute(`cp -r ${__dirname}/l10n.json ${dest}`);
        await execute(`chmod 644 ${dest}/l10n.json`);
        await fs.promises.writeFile(`${__dirname}/com.XPS.ComboJack.plist`, comboJackPlist(`${dest}/ComboJack`));
        await execute(`cp -r ${__dirname}/com.XPS.ComboJack.plist /Library/LaunchDaemons/`);
        await execute(`chmod 644 /Library/LaunchDaemons/com.XPS.ComboJack.plist`);
        await execute(`chown root:wheel /Library/LaunchDaemons/com.XPS.ComboJack.plist`);
        await execute(`launchctl load /Library/LaunchDaemons/com.XPS.ComboJack.plist`);
        console.log("Done, plz reboot 🎧");
    }
    catch (e) {
        console.log(e);
    }
}

async function execute(command) {
    const {stdout, stderr} = await exec(`echo ${sudoPassword} | sudo -S ${command}`);
    if (stderr) throw new Error(stderr);
    else if (stdout.split("").filter(x => x.length > 1).join("") !== "") console.log(stdout);
}

function comboJackPlist(path) {
    return `
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>com.XPS.ComboJack</string>
    <key>ProgramArguments</key>
    <array>
        <string>${path}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
</dict>
</plist>
    `;
}

m();