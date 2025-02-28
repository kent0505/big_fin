enum Navbar { home, analytics, assistant, utilities, settings }

enum Period { monthly, weekly, daily }

String getPeriodTitle(Period period) {
  if (period == Period.daily) {
    return "Daily";
  } else if (period == Period.weekly) {
    return "Weekly";
  } else {
    return "Monthly";
  }
}
