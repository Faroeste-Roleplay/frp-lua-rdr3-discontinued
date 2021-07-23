// https://imgur.com/AAMq5II
// JS example :

exports('DisplayLeftNotification', (title, subTitle, iconDict, icon, duration) => {

  const struct1 = new DataView(new ArrayBuffer(48));
  struct1.setInt32(0, duration, true);
  struct1.setInt32(8, 0, true);
  struct1.setInt32(16, 0, true);
  
  const string1 = CreateVarString(10, "LITERAL_STRING", title);
  const string2 = CreateVarString(10, "LITERAL_STRING", subTitle);
  
  const struct2 = new DataView(new ArrayBuffer(72));
  struct2.setBigInt64(8, BigInt(string1), true);
  struct2.setBigInt64(16, BigInt(string2), true);
  struct2.setBigInt64(32, BigInt(GetHashKey(iconDict)), true);
  struct2.setBigInt64(40, BigInt(GetHashKey(icon)), true);

  struct2.setInt32(48, 0, true);
  struct2.setInt32(56, 1, true);
  struct2.setInt32(64, 0, true);
  
  setTimeout(function(){ 
  Citizen.invokeNative("0x26E87218390E6729", struct1, struct2, 1, 1);}, 250);
});


exports('DisplayNotification', (text, duration) => { 

    const str = Citizen.invokeNative("0xFA925AC00EB830B9", 10, "LITERAL_STRING", text, Citizen.resultAsLong());
  
    const struct1 = new DataView(new ArrayBuffer(4 * 4));
    struct1.setUint32(0, duration, true);
  
    const struct2 = new DataView(new ArrayBuffer(8 + 8));
    struct2.setBigUint64(8, BigInt(str), true);
  
    Citizen.invokeNative("0x049D5C615BD38BAD", struct1, struct2, 1);
});



exports('DisplayLocationNotification', (text, location, duration) => {
  const struct1 = new DataView(new ArrayBuffer(4 * 4));
  struct1.setInt32(0, duration, true);

  const string1 = CreateVarString(10, "LITERAL_STRING", location);
  const string2 = CreateVarString(10, "LITERAL_STRING", text);

  const struct2 = new DataView(new ArrayBuffer(24));
  struct2.setBigInt64(8, BigInt(string1), true);
  struct2.setBigInt64(16, BigInt(string2), true);

  Citizen.invokeNative("0xD05590C1AB38F068", struct1, struct2, 1, 1);
});