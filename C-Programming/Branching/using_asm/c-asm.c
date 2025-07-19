
/* Switch case Example */

void sidhesh() {
  int i = 2;
  int j = 2;

  switch (i) {
  case 1: {
    j += 1;
  }

  case 2: {
    j += 2;
  } break;
  case 3: {
    j += 3;
  } break;
  default: {
    j += 100;
  }
  }

  return;
}
