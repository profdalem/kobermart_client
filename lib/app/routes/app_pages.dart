import 'package:get/get.dart';

import '../modules/balancetransfer/bindings/balancetransfer_binding.dart';
import '../modules/balancetransfer/views/balancetransfer_view.dart';
import '../modules/buynow/bindings/buynow_binding.dart';
import '../modules/buynow/views/buynow_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/cashback_history/bindings/cashback_history_binding.dart';
import '../modules/cashback_history/views/cashback_history_view.dart';
import '../modules/digitalproducts/bindings/digitalproducts_binding.dart';
import '../modules/digitalproducts/views/digitalproducts_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inputnumber/bindings/inputnumber_binding.dart';
import '../modules/inputnumber/views/inputnumber_view.dart';
import '../modules/investment/bindings/investment_binding.dart';
import '../modules/investment/views/investment_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/memberhistory/bindings/memberhistory_binding.dart';
import '../modules/memberhistory/views/memberhistory_view.dart';
import '../modules/memberprofile/bindings/memberprofile_binding.dart';
import '../modules/memberprofile/views/memberprofile_view.dart';
import '../modules/members/bindings/members_binding.dart';
import '../modules/members/views/members_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/newtoken/bindings/newtoken_binding.dart';
import '../modules/newtoken/views/newtoken_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/ppob/bindings/ppob_binding.dart';
import '../modules/ppob/views/ppob_view.dart';
import '../modules/ppob_pln_postpaid/bindings/ppob_pln_postpaid_binding.dart';
import '../modules/ppob_pln_postpaid/views/ppob_pln_postpaid_view.dart';
import '../modules/ppob_pln_prepaid/bindings/ppob_pln_prepaid_binding.dart';
import '../modules/ppob_pln_prepaid/views/ppob_pln_prepaid_view.dart';
import '../modules/ppob_pulsadata/bindings/ppob_pulsadata_binding.dart';
import '../modules/ppob_pulsadata/views/ppob_pulsadata_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/qrcode/bindings/qrcode_binding.dart';
import '../modules/qrcode/views/qrcode_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/selectmethod/bindings/selectmethod_binding.dart';
import '../modules/selectmethod/views/selectmethod_view.dart';
import '../modules/shop/bindings/shop_binding.dart';
import '../modules/shop/views/shop_view.dart';
import '../modules/tokendetail/bindings/tokendetail_binding.dart';
import '../modules/tokendetail/views/tokendetail_view.dart';
import '../modules/tokeninput/bindings/tokeninput_binding.dart';
import '../modules/tokeninput/views/tokeninput_view.dart';
import '../modules/tokenlist/bindings/tokenlist_binding.dart';
import '../modules/tokenlist/views/tokenlist_view.dart';
import '../modules/topup/bindings/topup_binding.dart';
import '../modules/topup/views/topup_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/transfernominal/bindings/transfernominal_binding.dart';
import '../modules/transfernominal/views/transfernominal_view.dart';
import '../modules/trashbank/bindings/trashbank_binding.dart';
import '../modules/trashbank/views/trashbank_view.dart';
import '../modules/trxdetail_cashback/bindings/trxdetail_cashback_binding.dart';
import '../modules/trxdetail_cashback/views/trxdetail_cashback_view.dart';
import '../modules/trxdetail_postpaid/bindings/trxdetail_postpaid_binding.dart';
import '../modules/trxdetail_postpaid/views/trxdetail_postpaid_view.dart';
import '../modules/trxdetail_prepaid/bindings/trxdetail_prepaid_binding.dart';
import '../modules/trxdetail_prepaid/views/trxdetail_prepaid_view.dart';
import '../modules/trxdetail_shop/bindings/trxdetail_shop_binding.dart';
import '../modules/trxdetail_shop/views/trxdetail_shop_view.dart';
import '../modules/trxdetail_token/bindings/trxdetail_token_binding.dart';
import '../modules/trxdetail_token/views/trxdetail_token_view.dart';
import '../modules/trxdetail_topup/bindings/trxdetail_topup_binding.dart';
import '../modules/trxdetail_topup/views/trxdetail_topup_view.dart';
import '../modules/trxdetail_transfer/bindings/trxdetail_transfer_binding.dart';
import '../modules/trxdetail_transfer/views/trxdetail_transfer_view.dart';
import '../modules/trxdetail_withdrawal/bindings/trxdetail_withdrawal_binding.dart';
import '../modules/trxdetail_withdrawal/views/trxdetail_withdrawal_view.dart';
import '../modules/withdrawal/bindings/withdrawal_binding.dart';
import '../modules/withdrawal/views/withdrawal_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SHOP,
      page: () => const ShopView(),
      binding: ShopBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.MEMBERS,
      page: () => MembersView(),
      binding: MembersBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.QRCODE,
      page: () => const QrcodeView(),
      binding: QrcodeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.TOPUP,
      page: () => const TopupView(),
      binding: TopupBinding(),
    ),
    GetPage(
      name: _Paths.TOKENINPUT,
      page: () => const TokeninputView(),
      binding: TokeninputBinding(),
    ),
    GetPage(
      name: _Paths.NEWTOKEN,
      page: () => NewtokenView(),
      binding: NewtokenBinding(),
    ),
    GetPage(
      name: _Paths.TOKENLIST,
      page: () => const TokenlistView(),
      binding: TokenlistBinding(),
    ),
    GetPage(
      name: _Paths.MEMBERHISTORY,
      page: () => MemberhistoryView(),
      binding: MemberhistoryBinding(),
    ),
    GetPage(
      name: _Paths.TOKENDETAIL,
      page: () => TokendetailView(),
      binding: TokendetailBinding(),
    ),
    GetPage(
      name: _Paths.MEMBERPROFILE,
      page: () => MemberprofileView(),
      binding: MemberprofileBinding(),
    ),
    GetPage(
      name: _Paths.BALANCETRANSFER,
      page: () => BalancetransferView(),
      binding: BalancetransferBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFERNOMINAL,
      page: () => const TransfernominalView(),
      binding: TransfernominalBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWAL,
      page: () => WithdrawalView(),
      binding: WithdrawalBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.BUYNOW,
      page: () => const BuynowView(),
      binding: BuynowBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_SHOP,
      page: () => const TrxdetailShopView(),
      binding: TrxdetailShopBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_WITHDRAWAL,
      page: () => const TrxdetailWithdrawalView(),
      binding: TrxdetailWithdrawalBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_TOPUP,
      page: () => const TrxdetailTopupView(),
      binding: TrxdetailTopupBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_TRANSFER,
      page: () => const TrxdetailTransferView(),
      binding: TrxdetailTransferBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_CASHBACK,
      page: () => const TrxdetailCashbackView(),
      binding: TrxdetailCashbackBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_TOKEN,
      page: () => const TrxdetailTokenView(),
      binding: TrxdetailTokenBinding(),
    ),
    GetPage(
      name: _Paths.TRASHBANK,
      page: () => const TrashbankView(),
      binding: TrashbankBinding(),
    ),
    GetPage(
      name: _Paths.INVESTMENT,
      page: () => const InvestmentView(),
      binding: InvestmentBinding(),
    ),
    GetPage(
      name: _Paths.PPOB,
      page: () => PpobView(),
      binding: PpobBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_PREPAID,
      page: () => TrxdetailPrepaidView(),
      binding: TrxdetailPrepaidBinding(),
    ),
    GetPage(
      name: _Paths.TRXDETAIL_POSTPAID,
      page: () => TrxdetailPostpaidView(),
      binding: TrxdetailPostpaidBinding(),
    ),
    GetPage(
      name: _Paths.CASHBACK_HISTORY,
      page: () => const CashbackHistoryView(),
      binding: CashbackHistoryBinding(),
    ),
    GetPage(
      name: _Paths.INPUTNUMBER,
      page: () => InputnumberView(),
      binding: InputnumberBinding(),
    ),
    GetPage(
      name: _Paths.SELECTMETHOD,
      page: () => SelectmethodView(),
      binding: SelectmethodBinding(),
    ),
    GetPage(
      name: _Paths.DIGITALPRODUCTS,
      page: () => const DigitalproductsView(),
      binding: DigitalproductsBinding(),
    ),
    GetPage(
      name: _Paths.PPOB_PULSADATA,
      page: () => const PpobPulsadataView(),
      binding: PpobPulsadataBinding(),
    ),
    GetPage(
      name: _Paths.PPOB_PLN_PREPAID,
      page: () => const PpobPlnPrepaidView(),
      binding: PpobPlnPrepaidBinding(),
    ),
    GetPage(
      name: _Paths.PPOB_PLN_POSTPAID,
      page: () => const PpobPlnPostpaidView(),
      binding: PpobPlnPostpaidBinding(),
    ),
  ];
}
