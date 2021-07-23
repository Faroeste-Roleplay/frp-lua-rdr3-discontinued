RegisterNetEvent("FRP:COWMILKING:PreStart")
onNet('FRP:COWMILKING:PreStart', (arg1, arg2) => {

    console.log('yeeaeeksakda');

    RequestAnimDict("MINI_GAMES@STORY@MAR5@MILK_COW")
    RequestAnimDict("MINI_GAMES@STORY@MAR5@MILK_COW@BUCKET")
    RequestClipSet("CLIPSET@MINI_GAMES@STORY@MAR5@MILK_COW");
    RequestModel(GetHashKey("S_BUCKETMILK01X"));

    Citizen.invokeNative("0x2B6529C54D29037A", "script_mar5_milkcow_john");
    Citizen.invokeNative("0x2B6529C54D29037A", "script_mar5_milkcow_cow");
    Citizen.invokeNative("0x2B6529C54D29037A", "script_mar5_milkcow_bucket");

    const var1 = GetHashKey("CLIPSET@MINI_GAMES@STORY@MAR5@MILK_COW");
    const var2 = GetHashKey("DEFAULT")
    const var3 = CreateVarString("Milking");

    const dataView = new DataView(new ArrayBuffer(4 * 76));
    dataView.setBigUint64(4 * 0, BigInt(var1), true);
    dataView.setBigUint64(4 * 2, BigInt(var2), true);
    dataView.setInt32(4 * 12, -1082130432, true);
    dataView.setInt32(4 * 18, -1082130432, true);
    dataView.setBigUint64(4 * 60, BigInt(var3), true);

    // Citizen.invokeNative("0xA63FCAD3A6FEC6D2", PlayerId(), 1);

    const playerPed = PlayerPedId();
    const playerPosition = GetEntityCoords(playerPed);

    const x = playerPosition[0];
    const y = playerPosition[1];
    const z = playerPosition[2];

    const startHeading = 0.0;

    // const obj = CreateObject(GetHashKey("S_BUCKETMILK01X"), x + 1.0, y, z, true, true, false, false, false);

    // TaskMoveNetworkByNameWithInitParams(obj, "script_mar5_milkcow_bucket", dataView, 0.0, 0, "MINI_GAMES@STORY@MAR5@MILK_COW@BUCKET", 128)

    Citizen.invokeNative("0x7B6A04F98BBAFB2C", playerPed, "script_mar5_milkcow_john", dataView, x, y, z, 0.001, 0.001, startHeading, 2, 0.0, 0, 0, 128, 0);

    // SetPedCanLegIk(playerPed, false);
    // SetPedLegIkMode(playerPed, 0);

    // Citizen.invokeNative("0x2208438012482A1A", playerPed, true, false);

    // SetTaskMoveNetworkSignalBool(playerPed, "LeftTrigger", 1.0);

    // fillet();
});

function fillet() {

    Citizen.invokeNative("0x2B6529C54D29037A", "Script_FiveFingerFillet");

    const dataView = new DataView(new ArrayBuffer(4 * 76));
    dataView.setInt32(0, 458617849, true);
    dataView.setInt32(4, 0, true);
    dataView.setInt32(8, -455129387, true);
    dataView.setInt32(12, 0, true);
    dataView.setInt32(16, 0, true);
    dataView.setInt32(20, 0, true);
    dataView.setInt32(24, 0, true);
    dataView.setInt32(28, 0, true);
    dataView.setInt32(32, 0, true);
    dataView.setInt32(36, 0, true);
    dataView.setInt32(40, 0, true);
    dataView.setInt32(44, -1082130432, true);
    dataView.setInt32(48, 407, true);
    dataView.setInt32(52, 0, true);
    dataView.setInt32(56, 0, true);
    dataView.setInt32(60, 0, true);
    dataView.setInt32(64, 0, true);
    dataView.setInt32(68, -1082130432, true);
    dataView.setInt32(72, 407, true);

    const startHeading = 0.0

    console.log('yellow');

    Citizen.invokeNative(
        "0x7B6A04F98BBAFB2C",
        PlayerPedId(), "Script_FiveFingerFillet", dataView,
        GetEntityCoords(PlayerPedId()),
        0.001, 0.001, startHeading,
        2, 0.001, 0, 0, 4224, 0
    );
}

// CFX.registerCommand("poker", () => {
//     const var1 = Text.createVarString("NoCardsIdleRequest");
//     const var2 = Text.createVarString("CurrentClip");
//     const var3 = Text.createVarString("CurrentPhase");

//     const dataView = new DataView(new ArrayBuffer(4 * 68));
//     dataView.setInt32(4 * 0, -1196886585, true);
//     dataView.setInt32(4 * 1, 519, true);
//     dataView.setInt32(4 * 2, -455129387, true);
//     dataView.setInt32(4 * 3, 519, true);
//     dataView.setInt32(4 * 12, -1082130432, true);
//     dataView.setInt32(4 * 18, -1082130432, true);
//     dataView.setBigUint64(4 * 58, BigInt(var1 as unknown as number), true); // NoCardsIdleRequest
//     dataView.setBigUint64(4 * 64, BigInt(var2 as unknown as number), true);
//     dataView.setBigUint64(4 * 66, BigInt(var3 as unknown as number), true);

//     const { x, y, z } = Player.position;

//     Citizen.invokeNative(
//         "0x7B6A04F98BBAFB2C",
//         Player.ped.handle, this.scriptName, dataView,
//         x, y, z,
//         0.001, 0.001, 0.0,
//         2, 0.5, 0, 0, 128, 0
//     );
// });