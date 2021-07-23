exports('js_native', (x1, y1, z1, x2, y2, z2) => {

    const arrayBuffer = new ArrayBuffer(32);
    const dataView = new DataView(arrayBuffer);

    dataView.setFloat32(0, 127, true);

    Citizen.invokeNative("0x8974647ED222EA5F", x1, y1, z1, x2, y2, z2, 0, dataView, Citizen.returnResultAnyway());
    const arrayOut = new Float32Array(arrayBuffer);

    // console.log(arrayOut);
    // console.log(arrayOut[0]);
    // console.log(arrayOut[2]);
    // console.log(arrayOut[4]);

    // return new Vector3(arrayOut[0], arrayOut[2], arrayOut[4]);
    return [arrayOut[0], arrayOut[2], arrayOut[4]];
});