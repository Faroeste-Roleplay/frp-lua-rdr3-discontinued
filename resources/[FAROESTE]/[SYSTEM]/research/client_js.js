exports('DataViewNativeGetEventData', (eventGroup, index, argStructSize) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", eventGroup, index, view, argStructSize, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    // console.log(out);
    return out;
});

exports('DataViewNativeGetScenarioPointsCloseToCoords', (x, y, z, radius, size) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    letCitizen.invokeNative("0x345EC3B7EBDE1CB5", x, y, z, radius, view, size, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    // console.log(out);
    // console.log(JSON.stringify(out));
    return out;
});

exports('NativeCreateComposite', (compositeHash, x, y, z, onGround) => {
    let buffer = new ArrayBuffer(4 * 8);
    let view = new DataView(buffer);

    console.log(compositeHash)
    console.log(x, y, z, onGround);

    let composite = Citizen.invokeNative("0x5B4BBE80AD5972DC", compositeHash, x, y, z, 0.0, onGround ? 0 : 2, view, -1);

    let out = new Int32Array(buffer);

    console.log(composite);

    return composite;
});

exports('NativeGetCompositeEntities', (composite) => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let size = Citizen.invokeNative("0x96C6ED22FB742C3E", composite, view);
    let out = new Int32Array(buffer);

    return [size, out];
});

exports('GET_TASK_FISHING_DATA', (ped) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let hasMinigameOn = Citizen.invokeNative("0xF3735ACD11ACD500", PlayerPedId(), view);
    let outAsInt = new Int32Array(buffer);
    let outAsFloat = new Float32Array(buffer);

    // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 36 34 35
    // 0 - 1 - 2 - 3 - 4 -  5 -  6  -  7  -  8  -  9  - 10  - 11  - 12  - 13  - 14  - 15  - 16  -  17

    return [hasMinigameOn, outAsInt, outAsFloat];
});

exports('SET_TASK_FISHING_DATA', (struct) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    for (i = 0; i <= 27; i++) {
        let k = `f_${i}`;
        v = struct[k];

        switch (i) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 8:
            case 9:
            case 13:
            case 14:
            case 15:
            case 17:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
                v = Float32ToInt32(v);
                break;
        }

        view.setUint32(i * 8, v, true);
    }

    let r = Citizen.invokeNative("0xF3735ACD11ACD501", PlayerPedId(), view);
});

function Int32ToFloat32(num) {
    arr = new ArrayBuffer(4); // an Int32 takes 4 bytes
    view = new DataView(arr);
    view.setUint32(0, num, false); // byteOffset = 0; litteEndian = false
    // console.log(view.getFloat32(0));
    return view.getFloat32(0);
}


function Float32ToInt32(num) {
    arr = new ArrayBuffer(16); // an Float32 takes 4 bytes
    view = new DataView(arr);
    view.setFloat32(0, num, false); // byteOffset = 0; litteEndian = false
    // console.log(view.getInt32(0));
    return view.getInt32(0);
}


RegisterCommand('mw', (source, args) => {
    const r = Citizen.invokeNative("0xBF8276E51761F9DA");
    console.log(r);
});

var matchmaking_buffer;
var matchmaking_struct;

RegisterCommand('97test', (source, args) => {

    let buffernh = new ArrayBuffer(256)
    let viewnh = new DataView(buffernh);
    let rr = Citizen.invokeNative("0x388EB2B86C73B6B3", PlayerId(), viewnh);
    let outnh = new Int32Array(buffernh);

    const nh = outnh[0];

    console.log(nh);

    // console.log(nh);

    // console.log(NetworkGetLocalHandle(viewnh));
    // console.log(new Int32Array(buffernh));


    // Global_1572887->f_342.

    // view.setInt32(4 * 0, 0, true);
    // view.setInt32(4 * 1, 0, true);
    // view.setInt32(4 * 2, 0, true);
    // view.setInt32(4 * 3, 2, true);
    // view.setInt32(4 * 4, 3, true);
    // view.setInt32(4 * 5, 18, true); // 0 | 129
    // view.setInt32(4 * 6, 0, true);
    // view.setInt32(4 * 7, 4, true);
    // view.setInt32(4 * 8, 2, true);
    // view.setInt32(4 * 9, 2, true);
    // view.setInt32(4 * 10, 1, true); // flag
    // view.setInt32(4 * 11, 0, true); // f_11 part 2?
    // view.setInt32(4 * 12, 3, true);
    // view.setInt32(4 * 13, nh, true); // LOCAL HANDLE / 1101725955
    // view.setInt32(4 * 14, 0, true);
    // view.setInt32(4 * 15, 0, true);
    // view.setInt32(4 * 16, 0, true);
    // view.setInt32(4 * 17, 0, true);
    // view.setInt32(4 * 18, 0, true);
    // view.setInt32(4 * 19, 0, true);
    // view.setInt32(4 * 20, 101, true); // 100 101 102 103
    // view.setInt32(4 * 21, 1, true);
    // view.setInt32(4 * 22, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 23, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 24, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 25, 0, true);
    // view.setInt32(4 * 26, 0, true);

    // let r = Citizen.invokeNative("0x2989E131FDE37E97", 18, 0, 101, view);

    // NetworkSessionLeave();


    if (matchmaking_struct == undefined || matchmaking_struct == null) {

        matchmaking_buffer = new ArrayBuffer(256);
        matchmaking_struct = new DataView(matchmaking_buffer);
        /*
        matchmaking_struct.setInt32(4 * 0, 56001437, true);
        matchmaking_struct.setInt32(4 * 1, 8, true);
        matchmaking_struct.setInt32(4 * 2, -56899746, true);
        matchmaking_struct.setInt32(4 * 3, -1, true);
        */
        matchmaking_struct.setInt32(4 * 0, 0, true);
        matchmaking_struct.setInt32(4 * 1, 0, true); // Session type flag
        matchmaking_struct.setInt32(4 * 2, 0, true); // Matchmaking id?
        matchmaking_struct.setInt32(4 * 3, 0, true); // Your response id? [0: Clear?, 2: Enter?, 5: f_26 has to be set to 2]
        matchmaking_struct.setInt32(4 * 4, 4, true); // Matchmaking type? [1, 2, 3, 4, 5]
        matchmaking_struct.setInt32(4 * 5, 18, true); // [ =| 16, =| 8, =| 4]
        matchmaking_struct.setInt32(4 * 6, 0, true);
        matchmaking_struct.setInt32(4 * 7, 4, true); // Status  [7: Accepted]
        matchmaking_struct.setInt32(4 * 8, 2, true);
        matchmaking_struct.setInt32(4 * 9, 2, true);
        matchmaking_struct.setInt32(4 * 10, 1, true); // flag
        matchmaking_struct.setInt32(4 * 11, 0, true); // f_11 part 2?
        matchmaking_struct.setInt32(4 * 12, 3, true);
        matchmaking_struct.setInt32(4 * 13, nh, true); // Player Network Handle / 1101725955
        matchmaking_struct.setInt32(4 * 14, 0, true);
        matchmaking_struct.setInt32(4 * 15, 0, true);
        matchmaking_struct.setInt32(4 * 16, 0, true);
        matchmaking_struct.setInt32(4 * 17, 0, true);
        matchmaking_struct.setInt32(4 * 18, 0, true);
        matchmaking_struct.setInt32(4 * 19, 0, true);
        matchmaking_struct.setInt32(4 * 20, 101, true); // 100 101 102 103
        matchmaking_struct.setInt32(4 * 21, 1, true);
        matchmaking_struct.setInt32(4 * 22, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 23, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 24, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 25, 0, true); // BOOl
        matchmaking_struct.setInt32(4 * 26, 0, true); // Recreate-matchmaking type? [2: No retry?]
        matchmaking_struct.setInt32(4 * 27, 1, true); // [-1, 1]
        matchmaking_struct.setInt32(4 * 28, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 29, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 30, -1, true); // -1 / GetGameTimer()
    }

    // NetworkSessionLeave();

    let r = Citizen.invokeNative("0x2989E131FDE37E97", 17, 0, 109, matchmaking_struct);
    // let r = Citizen.invokeNative("0x04019AE4956D4393", 0, 0, matchmaking_struct);

    let out = new Int32Array(matchmaking_buffer);

    console.log(r);
    console.log(out);
    console.log(" ");

    const IsValid = Citizen.invokeNative("0x2F54B146D3EDCE4D", matchmaking_struct); // IS_VALID
    console.log(IsValid);

    if (IsValid === 1) {
        const status = Citizen.invokeNative("0x0DD051B1BF4B8BD6", matchmaking_struct); // GET_STATUS
        console.log(status);
    }

    const unk = Citizen.invokeNative("0xCCF878D50F8AB10D", matchmaking_struct);
    console.log(unk);

    const isFinished = Citizen.invokeNative("0x8FB7C254CFCBF78E", matchmaking_struct);
    console.log(isFinished); // IS_FINISHED?

    // Citizen.invokeNative("0xE72E5C1289BD1F40", matchmaking_struct); // DELETE
});

/*
	case 0:
			iVar0 = 0;
			break;
		case joaat("NEW_GAME"):
			iVar0 = 1;
			break;
		case joaat("SHIFT_F"):
			iVar0 = 2;
			break;
		case joaat("DEMO"):
			iVar0 = 4;
			break;
		case joaat("INTRO_NOT_DONE"):
			iVar0 = 8;
			break;
		case joaat("PRIVATE"):
			iVar0 = 16;
			break;
		case joaat("FRIENDLY"):
			iVar0 = 32;
			break;
		case joaat("HARDCORE"):
			iVar0 = 64;
			break;
		case joaat("NEAR_POSSE"):
			iVar0 = 128;
			break;
		case joaat("RANDOM_POSSE"):
			iVar0 = 256;
			break;
		case joaat("OPEN_POSSE"):
			iVar0 = 512;
			break;
		case joaat("FOLLOW_INVITE"):
			iVar0 = 1024;
			break;
		case joaat("RANDOM_REGION"):
			iVar0 = 2048;
			break;
		case joaat("LAST_REGION"):
			iVar0 = 4096;
			break;
		case joaat("LAST_LOCATION"):
			iVar0 = 8192;
			break;
		case joaat("CAMP"):
			iVar0 = 16384;
			break;
		case joaat("HANDHELD"):
			iVar0 = 32768;
			break;
		case joaat("LAST_MISSION"):
			iVar0 = 65536;
			break;
		case joaat("RANDOM_POKER"):
			iVar0 = 131072;
			break;
		case joaat("BG_CUSTOM_1"):
			iVar0 = 262144;
			break;
		case joaat("BG_CUSTOM_2"):
			iVar0 = 524288;
			break;
		case joaat("BG_CUSTOM_3"):
			iVar0 = 1048576;
			break;
		case joaat("TRADE_1"):
			iVar0 = 2097152;
			break;
		case joaat("TRADE_2"):
			iVar0 = 4194304;
			break;
		case joaat("TRADE_3"):
			iVar0 = 8388608;
			break;
		case joaat("TRADE_4"):
			iVar0 = 16777216;
			break;
		case joaat("TRADE_5"):
			iVar0 = 33554432;
			break;
		case joaat("TRADE_6"):
			iVar0 = 67108864;
			break;
		case joaat("TRADE_7"):
			iVar0 = 134217728;
			break;
		case joaat("CCHAR"):
			iVar0 = 268435456;
			break;
		case joaat("COUPON"):
			iVar0 = 536870912;
			break;
		case joaat("HUB"):
			iVar0 = 1073741824; // Float: 2f 
            break;
*/


var mm_buffer = new ArrayBuffer(4 * 31);
var mm_view = new DataView(mm_buffer);
var mm_out = new Int32Array(mm_buffer);

function N_0x04019AE4956D4393() {

    let buffernh = new ArrayBuffer(256)
    let viewnh = new DataView(buffernh);
    let rr = Citizen.invokeNative("0x388EB2B86C73B6B3", PlayerId(), viewnh);
    let outnh = new Int32Array(buffernh);

    const localNetworkHandle = outnh[0];

    console.log(localNetworkHandle, GetGameTimer());

    mm_buffer = new ArrayBuffer(4 * 31);
    mm_view = new DataView(mm_buffer);

    mm_view.setInt32(4 * 0, 0, true); // accId
    mm_view.setInt32(4 * 1, 0, true); // platId
    mm_view.setInt32(4 * 2, 0, true); // Session id / index
    mm_view.setInt32(4 * 3, 4, true); // Your response id? [0: Clear?, 2: Enter?, 5: f_26 has to be set to 2]
    mm_view.setInt32(4 * 4, 2, true); // Matchmaking type? [1, 2, 3, 4, 5]
    mm_view.setInt32(4 * 5, 0, true); // [ =| 16, =| 8, =| 4]
    mm_view.setInt32(4 * 6, 0, true);
    mm_view.setInt32(4 * 7, 8, true);
    mm_view.setInt32(4 * 8, 2, true);
    mm_view.setInt32(4 * 9, 2, true);
    mm_view.setInt32(4 * 10, 1, true); // flag
    mm_view.setInt32(4 * 11, 0, true); // f_10 part 2?
    mm_view.setInt32(4 * 12, 3, true);
    mm_view.setInt32(4 * 13, localNetworkHandle, true); // Player Network Handle / 1101725955
    mm_view.setInt32(4 * 14, 0, true);
    mm_view.setInt32(4 * 15, 0, true);
    mm_view.setInt32(4 * 16, 0, true);
    mm_view.setInt32(4 * 17, 0, true);
    mm_view.setInt32(4 * 18, 0, true);
    mm_view.setInt32(4 * 19, 0, true);
    mm_view.setInt32(4 * 20, 101, true); // 100 101 102 103
    mm_view.setInt32(4 * 21, 1, true);
    mm_view.setInt32(4 * 22, GetGameTimer(), true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 23, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 24, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 25, 0, true); // BOOl
    mm_view.setInt32(4 * 26, 0, true); // Recreate-matchmaking type? [2: No retry?]
    mm_view.setInt32(4 * 27, -1, true); // [-1, 1]
    mm_view.setInt32(4 * 28, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 29, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 30, -1, true); // -1 / GetGameTimer()

    // NetworkSessionLeave();

    // let r = Citizen.invokeNative("0x2989E131FDE37E97", 0, 0, 101, mm_view);
    let r = Citizen.invokeNative("0x04019AE4956D4393", 0, 0, mm_view);

    mm_out = new Int32Array(mm_buffer);

    console.log(r, mm_out);
}

// IS_VALID
exports('N_0x2F54B146D3EDCE4D', (array) => {
    const vb = luaArrayToViewAndBuffer(array);
    const buffer = vb[0];
    const view = vb[1];

    const r = Citizen.invokeNative("0x2F54B146D3EDCE4D", view);

    console.log("IsValid?", view[2], r);
});

// GET_STATUS
function N_0x0DD051B1BF4B8BD6() {
    const matchmakingid = mm_out[2];

    const r = Citizen.invokeNative("0x0DD051B1BF4B8BD6", mm_view);

    console.log('Status?', matchmakingid, r);
};

// ?
exports('N_0x8FB7C254CFCBF78E', (array) => {
    const vb = luaArrayToViewAndBuffer(array);
    const buffer = vb[0];
    const view = vb[1];
});

// DELETE
function N_0xE72E5C1289BD1F40() {
    // const vb = luaArrayToViewAndBuffer(array);
    // const buffer = vb[0];
    // const view = vb[1];

    const matchmakingid = mm_out[2];

    const r = Citizen.invokeNative("0xE72E5C1289BD1F40", mm_view);

    console.log('Delete?', matchmakingid, r);
};

// function luaArrayToBufferAndView(array) {

//     let buffer = new ArrayBuffer(256);
//     let view = new DataView(buffer);

//     for (i = 0; i <= 30; i++) {
//         let k = `f_${i}`;
//         v = struct[k];

//         view.setInt32(i * 4, v, true);
//     }

//     return [buffer, view];
// }

// RegisterCommand('mcreate', (source, args) => {
//     N_0x04019AE4956D4393();
// });

// RegisterCommand('mset', (source, args) => {
//     mm_view.setInt32(4 * parseInt(args[0]), parseInt(args[1]), true);

//     let r = Citizen.invokeNative("0x2989E131FDE37E97", 0, 0, 101, mm_view);
//     mm_out = new Int32Array(mm_buffer);
// });

// RegisterCommand('mdel', (source, args) => {
//     N_0xE72E5C1289BD1F40();
// });

// RegisterCommand('mstatus', (source, args) => {
//     N_0x0DD051B1BF4B8BD6();
// });

// setTick(() => {
//     if (mm_view != undefined) {

//         let i = 0;
//         mm_out.forEach((element, index, array) => {
//             // if (index == 0 || index % 2 == 0) {
//             DrawTxt(`f_${i}`, 0.65, 0.05 + (i * 0.03), 0.4, 0.55, true, 255, 255, 255, 255, false);
//             DrawTxt("" + element, 0.75, 0.05 + (i * 0.03), 0.4, 0.55, true, 255, 255, 255, 255, false);
//             i++;
//             // }
//         });
//     }
// });

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre) {
    str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)
    SetTextCentre(centre)
    SetTextDropshadow(1, 0, 0, 0, 255)
    Citizen.invokeNative(0xADA9255D, 2)
    DisplayText(str, x, y)
}

// RegisterCommand('iteminfo', (source, args) => {
//     let buffer = new ArrayBuffer(512);
//     let view = new DataView(buffer);
//     // dataView.setInt32(0, 3);
//     // dataView.setInt32(3, );

//     let itemHash = GetHashKey("WEAPON_PISTOL_VOLCANIC");
//     // itemHash = 856287005;
//     let r = Citizen.invokeNative("0xFE90ABBCBFDC13B2", itemHash, view, Citizen.returnResultAnyway());
//     let out = new Int32Array(buffer);

//     console.log(out[4] == GetHashKey("WEAPON"))
//     console.log(out[8] == GetWeapontypeModel("WEAPON_PISTOL_VOLCANIC"));
//     console.log(out[2] == GetHashKey("SLOTID_HORSE_SADDLE"));

//     console.log(r, out);
// });


/*
? INVENTORY::_0x
* Return item amount stuff?
* _0xE787F05DFC977BDE -- deff
* _0xC97E0D2302382211
* _0x033EE4B89F3AC545

* Return itm slot id?
* _0x6452B1D357D81742

* Return whether the item accepts this slot id?
* _0x780C5B9AE2819807
*/

RegisterCommand('invinfo', (source, args) => {
    let buffer = new ArrayBuffer(512);
    let a2 = new DataView(buffer);
    // a2.setInt32(8 * 0, 2147483648, true);
    // a2.setInt32(8 * 1, 0, true);
    // a2.setInt32(8 * 2, 0, true);
    // a2.setInt32(8 * 3, 0, true);
    // a2.setInt32(8 * 4, 1728382685, true);
    // a2.setInt32(8 * 5, 0, true);
    // a2.setInt32(8 * 6, 4150375216, true);
    // a2.setInt32(8 * 7, 0, true);
    // a2.setInt32(8 * 8, 3554810750, true);
    // a2.setInt32(8 * 9, 636, true);
    // a2.setInt32(8 * 10, 0, true);
    // a2.setInt32(8 * 11, 0, true);

    let buffer2 = new ArrayBuffer(512);
    let a5 = new DataView(buffer2);
    // a3.setBigInt64(8 * 0, BigInt(2147483648), true);
    // a3.setInt32(8 * 1, 0, true);
    // a3.setInt32(8 * 2, 0, true);
    // a3.setInt32(8 * 3, 0, true);
    // a3.setBigInt64(8 * 4, BigInt(1901291885), true);
    // a3.setInt32(8 * 5, 0, true);
    // a3.setBigInt64(8 * 6, BigInt(4150375216), true);
    // a3.setInt32(8 * 7, 0, true);
    // a3.setBigInt64(8 * 8, BigInt(1034665895), true);
    // a3.setInt32(8 * 9, 0, true);
    // a3.setInt32(8 * 10, 0, true);
    // a3.setInt32(8 * 11, 0, true);

    // 1999506840

    // 0x886DFD3E185C8A89
    // BOOL _INVENTORY_HAS_ITEM_AT_SLOTID(int inventory, Any* out1, Hash itemId, Hash slotId, Any out2)
    // slotId: -1591664384 (ALL?)
    // out2->f_4: something

    // * 0xCB5D11F9508A928D
    // * INVENTORY_ADD_ITEM?

    let r = Citizen.invokeNative("0x886DFD3E185C8A89", 1, a2, GetHashKey("CHARACTER"), -1591664384, a5, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    console.log(r, out);

    let out2 = new Int32Array(buffer2);
    console.log(out2);

    a5.setInt32(8 * 4, 1084182731, true);
    a5.setInt32(8 * 9, -1591664384, true);

    out2 = new Int32Array(buffer2);
    console.log(out2);

    console.log("a");

    let b3 = new ArrayBuffer(512);
    let a3 = new DataView(b3);

    let r2 = Citizen.invokeNative("0xCB5D11F9508A928D", 1, buffer2, a2, GetHashKey("UPGRADE_OFFHAND_HOLSTER"), 971340545, 1, 752097756)

    console.log(r2);

    // let b = Citizen.invokeNative("0xC04F47D488EF9EBA", 1, 1999521480, a5, 0);
    // console.log(b);

    // Citizen.invokeNative("0x5D6182F3BCE1333B", 0, -142743235); // CLEARS THE INV?
});

RegisterCommand('additem', (source, args) => {

    let b1 = new ArrayBuffer(8 * 12);
    let a2 = new DataView(b1);
    // a2.setInt32(8 * 0, 2147483648, true);
    // a2.setInt32(8 * 4, 1238285454, true);
    // a2.setInt32(8 * 6, 2438572127, true);

    let b2 = new ArrayBuffer(8 * 12);
    let a3 = new DataView(b2);
    // a3.setInt32(8 * 0, 2147483648, true);
    // a3.setInt32(8 * 4, 1901291885, true);
    // a3.setInt32(8 * 6, 4150375216, true);
    // a3.setInt32(8 * 8, 4264807152, true);
    // a3.setInt32(8 * 10, 2147483648, true);
    // works top
    // a3.setInt32(8 * 0, 2147483648, true);
    // a3.setInt32(8 * 4, 1901291885, true);
    // a3.setInt32(8 * 6, 4150375226, true);
    // a3.setInt32(8 * 8, 4264807152, true);

    // console.log(Citizen.invokeNative("0x13D234A2A3F66E63", 2842629)); // -2140203376
    // Citizen.invokeNative("0xD2CB0FB0FDCB473D", PlayerId(), 2842629);
    // Citizen.invokeNative("0xE6D4E435B56D5BD0", PlayerId(), 2842629);

    // works * // let r = Citizen.invokeNative("0xCB5D11F9508A928D", 1, a2, a3, -518019409, 1084182731, 1, 752097756);
    let r = Citizen.invokeNative("0xCB5D11F9508A928D", 1, a2, a3, GetHashKey("KIT_HANDHELD_CATALOG"), 1084182731, 1, 752097756);

    /*
        -1921080134 | Comida
    */

    console.log(r);

    console.log(new Int32Array(b1));
    console.log(new Int32Array(b2));

    const amount = Citizen.invokeNative("0xE787F05DFC977BDE", 1, GetHashKey("CONSUMABLE_HORSE_REVIVER"), 0);
    console.log(amount);
});

function Fits() {
    const r = [
        "8001C32B",
        "DBF320A3",
        "A1212100",
        "2623F0B3",
        "D7E2D44A",
        "D6228958",
        "409F50CB",
        "DE3A037B",
        "2B27C4A6",
        "F21FFEF5",
        "6A386D80",
        "DFA9692D",
        "D785E9B0",
        "7D32E005",
        "D3E21B7E",
        "7E676791",
        "670506DD",
        "6C2CC31C",
        "D94BEB69",
        "6059AB76",
        "9026D920",
        "4E1386EA",
        "82693DA5",
        "C906F5F6",
        "DEA71BFA",
        "B6C85179",
        "D07C7F8D",
        "5BAB754",
        "DE8AEF55",
        "3159B66B",
        "811B5215",
        "E16E1B88",
        "26629388",
        "681022AA",
        "9FA1824F",
        "347B0DF4",
        "6D3AB5A7",
        "7A48AE7",
        "2E4E23B5",
        "B8E2E904",
        "CEDEF013",
        "D1A948D7",
        "BCB96720",
        "5853106",
        "143F038",
        "68E9888C",
        "18177E87",
        "C9983A3A",
        "F2F95330",
        "D4B60D4C",
        "9431BBBC",
        "21D08904",
        "BE0C5805",
        "54D8B6CC",
        "CE548CF5",
        "A1E84C59",
        "87D6E095",
    ]

    // let b1 = new ArrayBuffer(8 * 12);
    // let a2 = new DataView(b1);

    // let b2 = new ArrayBuffer(8 * 12);
    // let a3 = new DataView(b2);
    // a3.setInt32(8 * 0, 2147483648, true);
    // a3.setInt32(8 * 4, 1901291885, true);
    // a3.setInt32(8 * 6, 4150375216, true);
    // a3.setInt32(8 * 8, 4264807152, true);
    // a3.setInt32(8 * 10, 2147483648, true);

    let item = GetHashKey("KIT_HANDHELD_CATALOG")
    // item = 142640135;

    r.forEach(function(element, index) {

        let a = hexToInt(element);

        const yes = Citizen.invokeNative("0x780C5B9AE2819807", item, a);

        // console.log(yes);

        // if (yes != false) {
        //     console.log(a);
        // }

        // if (a == -234132662){
        //     console.log(a);
        // }

        // let r = Citizen.invokeNative("0xCB5D11F9508A928D", 2, a2, a3, item, a, 1, 752097756);
        // console.log(r, a);
    });

    // const rv = Citizen.invokeNative("0x6452B1D357D81742", GetHashKey("UPGRADE_OFFHAND_HOLSTER"),1384535894);
    // console.log(rv);
}

Fits();

function hexToInt(hex) {
    if (hex.length % 2 != 0) {
        hex = "0" + hex;
    }
    var num = parseInt(hex, 16);
    var maxVal = Math.pow(2, hex.length / 2 * 8);
    if (num > maxVal / 2 - 1) {
        num = num - maxVal
    }
    return num;
}

// levels3.rpf/levels/rdr3/scenario/herbs_*.ymt

// Hey, i keep having crashes when trying to use 0xF3735ACD11ACD501, probably because i am messing something up with DataView, thought you could maybe give me a hand?