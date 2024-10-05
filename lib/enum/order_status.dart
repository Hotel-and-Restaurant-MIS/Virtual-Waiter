enum OrderStatus{
  Pending,Preparing,Completed,Editing
}

OrderStatus getOrderStatusFromString(String status) {
  switch (status) {
    case 'Pending':
      return OrderStatus.Pending;
    case 'Preparing':
      return OrderStatus.Preparing;
    case 'Completed':
      return OrderStatus.Completed;
    case 'Editing':
      return OrderStatus.Editing;
    default:
      throw Exception('Invalid order status: $status');
  }
}