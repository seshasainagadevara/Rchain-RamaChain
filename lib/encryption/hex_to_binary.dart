class HexToBinary {
  String _binary = '';
  final hex;
  HexToBinary(this.hex);
  String hex_to_bin() {
    var i = 0;
    while (i < hex.length) {
      switch (hex[i]) {
        case '0':
          _binary += '0000';
          break;
        case '1':
          _binary += '0001';
          break;
        case '2':
          _binary += '0010';
          break;
        case '3':
          _binary += '0011';
          break;
        case '4':
          _binary += '0100';
          break;
        case '5':
          _binary += '0101';
          break;
        case '6':
          _binary += '0110';
          break;
        case '7':
          _binary += '0111';
          break;
        case '8':
          _binary += '1000';
          break;
        case '9':
          _binary += '1001';
          break;
        case 'a':
          _binary += '1010';
          break;
        case 'b':
          _binary += '1011';
          break;
        case 'c':
          _binary += '1100';
          break;
        case 'd':
          _binary += '1101';
          break;
        case 'e':
          _binary += '1110';
          break;
        case 'f':
          _binary += '1111';
          break;
        default:
          _binary += 'Invalid hexa digit $hex[i]';
      }
      ++i;
    }
    return _binary;
  }
}
