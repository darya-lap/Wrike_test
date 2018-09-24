class ATM{  
  Map getCash(cash, bills_param) {
    if (cash <= 0) {
      return throw new ArgumentError('The requested cash must be more than 0');
    }
    if ((bills_param == null) || (bills_param.length == 0)) {
      return throw new ArgumentError('Incorrect bills parameter');
    }

    int cash_rest = cash;
    var bills = List.from(bills_param);

    bills.sort((a, b) => a.compareTo(b));
    var number_of_bills = Map<int, int>();

    for (var i in bills) {
      number_of_bills[i] = 0;
    }

    var best_param = {'map_of_bills': number_of_bills, 'number_of_diff_bills': 0};

    for (int i = bills.length - 1; i >= 0; i--) {
      if ((best_param['number_of_diff_bills'] == bills.length) ||
          ((i + 1) <= best_param['number_of_diff_bills'])) {
        break;
      }
      if (cash_rest >= bills[i]) {
        var cur_param = {'map_of_bills': number_of_bills, 'number_of_diff_bills': 1};
        number_of_bills[bills[i]]++;
        var param_list = getBestMapOfBills(bills, i,
            cash_rest - bills[i], best_param, cur_param);
        number_of_bills[bills[i]]--;
        if (param_list['number_of_diff_bills'] > best_param['number_of_diff_bills']) {
          best_param['map_of_bills'] = param_list['map_of_bills'];
          best_param['number_of_diff_bills'] = param_list['number_of_diff_bills'];
        }
      }
    }
    if (number_of_bills == best_param['map_of_bills']) {
      return throw new ArgumentError('The requested cash can not be issued by available bills');
    }
    return best_param['map_of_bills'];
  }

  Map getBestMapOfBills(bills, index, cash, best_param, cur_param_prev) {
    var cur_param = new Map.from(cur_param_prev);
    var cur_map = new Map.from(cur_param_prev['map_of_bills']);
    cur_param['map_of_bills'] = cur_map;

    if (best_param['number_of_diff_bills'] >= (cur_param['number_of_diff_bills'] + index)) {
      return best_param;
    }

    var cur_denom = bills[index];

    if (cash >= cur_denom) {
      for (int i = index; i >= 0; i--) {
        if (i != index) cur_param['number_of_diff_bills']++;
        cur_map[bills[i]]++;
        var new_param = getBestMapOfBills(
            bills, i, cash - bills[i], best_param, cur_param);

        if (new_param['number_of_diff_bills'] > best_param['number_of_diff_bills']) {
          best_param = new_param;
        }
        cur_map[bills[i]]--;
        if (i != index) cur_param['number_of_diff_bills']--;
      }
    } else {
      if (cash > 0) {
        for (int i = index - 1; i >= 0; i--) {
          if (cash >= bills[i]) {
            cur_param['number_of_diff_bills']++;
            cur_map[bills[i]]++;
            var new_param = getBestMapOfBills(
                bills, i, cash - bills[i], best_param, cur_param);
            if (new_param['number_of_diff_bills'] > best_param['number_of_diff_bills']) {
              best_param = new_param;
            }
            cur_map[bills[i]]--;
            cur_param['number_of_diff_bills']--;
          }
        }
      } else
        best_param = cur_param;
    }
    return best_param;
  }
}