exports('GET_TASK_FISHING_DATA', (ped) => {

    let buffer = new ArrayBuffer(8 * 28);
    let view = new DataView(buffer);

    let hasMinigameOn = Citizen.invokeNative("0xF3735ACD11ACD500", PlayerPedId(), view);

    view.setFloat32(8 * 1, Int32ToFloat32(view.getInt32(8 * 1)));

    let outAsInt = new Int32Array(buffer);
    let outAsFloat = new Float32Array(buffer);

    // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 36 34 35
    // 0 - 1 - 2 - 3 - 4 -  5 -  6  -  7  -  8  -  9  - 10  - 11  - 12  - 13  - 14  - 15  - 16  -  17

    return [hasMinigameOn, outAsInt, outAsFloat];
});

exports('SET_TASK_FISHING_DATA', (struct) => {

    let buffer = new ArrayBuffer(8 * 28);
    let view = new DataView(buffer);

    for (i = 0; i <= 21; i++) {
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
                2
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

exports('VERTICAL_PROBE', (x, y, z, unkbool) => {

    const buffer = new ArrayBuffer(8);
    const view = new DataView(buffer);

    // TEST_VERTICAL_PROBE_AGAINST_ALL_WATER
    const r = Citizen.invokeNative("0x2B3451FA1E3142E2", x, y, z, unkbool, view);

    const out = new Float32Array(buffer);

    return [r, out[0]];
});