exports('N_0xCBFB4951F2E3934C', () => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let r = Citizen.invokeNative("0xCBFB4951F2E3934C", PlayerPedId(), view);
    let out = new Int32Array(buffer);

    console.log(out);

    // return [hasMinigameOn, outAsInt, outAsFloat];
});

exports('N_0x532C5FDDB986EE5C', () => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let r = Citizen.invokeNative("0x532C5FDDB986EE5C", PlayerPedId(), 24, view);
    let out = new Int32Array(buffer);

    console.log(out);

    // return [hasMinigameOn, outAsInt, outAsFloat];
});