exports('js_joaat', (text) => {
    var hash = 0;
    for (i = 0; i < text.length; i++) {
        var byteAt = text.charCodeAt(i);
        hash += byteAt;
        hash += hash << 10;
        hash ^= hash >> 6;
    }

    hash += hash << 3;
    hash ^= hash >> 11;
    hash += hash << 15;

    return hash;
});

