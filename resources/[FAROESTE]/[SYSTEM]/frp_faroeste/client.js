/*exports('js_get_ped_component_at_index', () => {

  const arrayBuffer = new ArrayBuffer(256 * 4);
  const dataView = new DataView(arrayBuffer);

  dataView.setUint32(0, 127, true);

  const arrayBuffer2 = new ArrayBuffer(256 * 4);
  const dataView2 = new DataView(arrayBuffer2);

  dataView2.setUint32(0, 127, true);

  const r = Citizen.invokeNative("0x77BA37622E22023B", PlayerPedId(), 1, false, dataView, dataView2, Citizen.returnResultAnyway());
  const arrayOut = new Int32Array(arrayBuffer);
  const arrayOut2 = new Int32Array(arrayBuffer2);

  console.log(arrayOut);
  console.log(arrayOut2);

  console.log(r);

  // console.log(arrayOut[0]);
  // console.log(arrayOut[2]);
  // console.log(arrayOut[4]);

  // return new Vector3(arrayOut[0], arrayOut[2], arrayOut[4]);
  // return [arrayOut[0], arrayOut[2], arrayOut[4]];
}); */

