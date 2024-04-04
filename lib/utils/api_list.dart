class ApiList {
  static const baseUrl = "https://sahulatshopping.com";
  static const licenseCode = "331FD3FF-C4AE-48D9-AC57-ADAC920C08DQ";
  static const login = "$baseUrl/api/auth/login";
  static const forgotPassword = "$baseUrl/api/auth/forgot-password";
  static const resendForgotOTPPhone =
      "$baseUrl/api/auth/forgot-password/otp-phone";
  static const resendForgotOTPEmail =
      "$baseUrl/api/auth/forgot-password/otp-email";
  static const verifyForgotPhone =
      "$baseUrl/api/auth/forgot-password/verify-phone";
  static const verifyForgotEmail =
      "$baseUrl/api/auth/forgot-password/verify-email";
  static const resetForgotPassword =
      "$baseUrl/api/auth/forgot-password/reset-password";
  static String? registrationValidation =
      "$baseUrl/api/auth/signup/register-validation";
  static const register = "$baseUrl/api/auth/signup/register";
  static const resendOTPPhone = "$baseUrl/api/auth/signup/otp-phone";
  static const resendOTPEmail = "$baseUrl/api/auth/signup/otp-email";
  static const verifyPhone = "$baseUrl/api/auth/signup/verify-phone";
  static const verifyEmail = "$baseUrl/api/auth/signup/verify-email";
  static const loginVerify = "$baseUrl/api/auth/signup/login-verify";
  static const logout = "$baseUrl/api/auth/logout";
  static const productCategory = "$baseUrl/api/frontend/product-category";
  static const promotion =
      "$baseUrl/api/frontend/promotion?status=5&type=5&order_type=asc";
  static const multiPromotion =
      "$baseUrl/api/frontend/promotion?status=5&type=10&order_type=asc";
  static const productSection = "$baseUrl/api/frontend/product-section";
  static const slider = "$baseUrl/api/frontend/slider";
  static const setting = "$baseUrl/api/frontend/setting";
  static const countryCode = "$baseUrl/api/frontend/country-code";
  static const language = "$baseUrl/api/frontend/language";
  static const categoryTree = "$baseUrl/api/frontend/product-category/tree";
  static const categoryWiseProduct =
      "$baseUrl/api/frontend/product/category-wise-products";
  static const aboutUs = "$baseUrl/api/frontend/page";
  static const productDetails = "$baseUrl/api/frontend/product/show/";
  static const flashSale = "$baseUrl/api/frontend/product/flash-sale-products";
  static const relatedProducts =
      "$baseUrl/api/frontend/product/related-products/";
  static const initialVariation =
      "$baseUrl/api/frontend/product/initial-variation/";
  static const childrenVariation =
      "$baseUrl/api/frontend/product/children-variation/";
  static const finalVariation =
      "$baseUrl/api/frontend/product/variation/ancestors-and-self/";
  static const address = "$baseUrl/api/frontend/address";
  static const updateAddress = "$baseUrl/api/frontend/address/";
  static const deleteAddress = "$baseUrl/api/frontend/address/";
  static const showAddress = "$baseUrl/api/frontend/address";
  static const outlet = "$baseUrl/api/frontend/outlet";
  static const coupon = "$baseUrl/api/frontend/coupon";
  static const applyCoupon = "$baseUrl/api/frontend/coupon/coupon-checking";
  static const profile = "$baseUrl/api/profile";
  static const profileUpdate = "$baseUrl/api/profile";
  static const pages = "$baseUrl/api/frontend/page";
  static const changeImage = "$baseUrl/api/profile/change-image";
  static const changePassword = "$baseUrl/api/profile/change-password";
  static const totalOrdersCount = "$baseUrl/api/frontend/overview/total-orders";
  static const totalCompleteOrdersCount =
      "$baseUrl/api/frontend/overview/total-complete-orders";
  static const totalReturnOrdersCount =
      "$baseUrl/api/frontend/overview/total-return-orders";
  static const totalWalletBalanceCount =
      "$baseUrl/api/frontend/overview/wallet-balance";
  static const orderHistory = "$baseUrl/api/frontend/order";
  static const orderDetails = "$baseUrl/api/frontend/order/show/";
  static const orderCancel = "$baseUrl/api/frontend/order/change-status/";
  static const submitReview = "$baseUrl/api/frontend/product-review";
  static const updateReview = "$baseUrl/api/frontend/product-review/";
  static const showReview = "$baseUrl/api/frontend/product-review/show/";
  static const updateImage =
      "$baseUrl/api/frontend/product-review/upload-image/";
  static const deleteImage =
      "$baseUrl/api/frontend/product-review/delete-image/";
  static const showReturnOrders = "$baseUrl/api/frontend/return-order";
  static const showReturnOrdersDetails =
      "$baseUrl/api/frontend/return-order/show/";
  static const returnRequest = "$baseUrl/api/frontend/return-order/request/";
  static const showReturnReason = "$baseUrl/api/frontend/return-reason";
  static const allProducts = "$baseUrl/api/frontend/product";
  static const wishList = "$baseUrl/api/frontend/wishlist/toggle";
  static const showWishlist = "$baseUrl/api/frontend/product/wishlist-products";
  static const brands = "$baseUrl/api/frontend/product-brand";
  static const showCartProduct = "$baseUrl/api/frontend/product/show";
  static const paymentGateway =
      "$baseUrl/api/frontend/payment-gateway?status=5";
  static const confirmOrder = "$baseUrl/api/frontend/order";
  static const areaWiseShipping = "$baseUrl/api/frontend/order-area?status=5";
  static const variations = "$baseUrl/api/frontend/product/all-variation/";
  static String mostPopular(String paginate, String page, String perPage) =>
      "$baseUrl/api/frontend/product/popular-products?paginate=$paginate&page=$page&per_page=$perPage&order_type=asc&status=5";
  static String? token = "$baseUrl/api/frontend/device-token/mobile";
  static String? refreshToken = "$baseUrl/api/refresh-token?token=";
  static String? deleteAccount = "$baseUrl/api/auth/delete-account";
}
