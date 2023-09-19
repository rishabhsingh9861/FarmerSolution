
var pincode = [401305, 401209, 400019, 401258];

int start = 0;
int end = pincode.length - 1;

int mid = (start + (end - start) / 2).toInt();

bool validPincode(int pin) {
  while (start <= end) {
    if (pincode[mid] == pin) {
      return true;
    }

    if (pincode[mid] > pin) {
      start = mid + 1;
    } else {
      end = mid - 1;
    }
  }
  return false;
}
