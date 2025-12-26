import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient APP'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @hospitalCare.
  ///
  /// In en, this message translates to:
  /// **'Hospital Care'**
  String get hospitalCare;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'id'**
  String get id;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid Password'**
  String get invalidPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordDoNotMatch;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @totalAppointment.
  ///
  /// In en, this message translates to:
  /// **'Total Appointment'**
  String get totalAppointment;

  /// No description provided for @addAppointment.
  ///
  /// In en, this message translates to:
  /// **'Add Appointment'**
  String get addAppointment;

  /// No description provided for @appointmentRequest.
  ///
  /// In en, this message translates to:
  /// **'Appointment Request'**
  String get appointmentRequest;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @appointmentTime.
  ///
  /// In en, this message translates to:
  /// **'Appointment time'**
  String get appointmentTime;

  /// No description provided for @newAppointment.
  ///
  /// In en, this message translates to:
  /// **'New Appointment'**
  String get newAppointment;

  /// No description provided for @createAppointment.
  ///
  /// In en, this message translates to:
  /// **'Create Appointment'**
  String get createAppointment;

  /// No description provided for @editAppointment.
  ///
  /// In en, this message translates to:
  /// **'Edit Appointment'**
  String get editAppointment;

  /// No description provided for @appointmentCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your appointment have been created successfully'**
  String get appointmentCreatedMessage;

  /// No description provided for @appointmentUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'Your appointment have been updated successfully'**
  String get appointmentUpdateMessage;

  /// No description provided for @checkProfile.
  ///
  /// In en, this message translates to:
  /// **'Check Profile'**
  String get checkProfile;

  /// No description provided for @todaysAppointment.
  ///
  /// In en, this message translates to:
  /// **'Todays Appointment'**
  String get todaysAppointment;

  /// No description provided for @appointmentList.
  ///
  /// In en, this message translates to:
  /// **'Appointment List'**
  String get appointmentList;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @changesUpdatedSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'Change have been successful updated.'**
  String get changesUpdatedSuccessfuly;

  /// No description provided for @changesUpdatedNotSuccessfull.
  ///
  /// In en, this message translates to:
  /// **'Changes are not successfully updated.'**
  String get changesUpdatedNotSuccessfull;

  /// No description provided for @notChangable.
  ///
  /// In en, this message translates to:
  /// **'Not changeble'**
  String get notChangable;

  /// No description provided for @addPayment.
  ///
  /// In en, this message translates to:
  /// **'Add Payment'**
  String get addPayment;

  /// No description provided for @invoiceId.
  ///
  /// In en, this message translates to:
  /// **'Invoice Id'**
  String get invoiceId;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get patientName;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name'**
  String get doctorName;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @patientPhone.
  ///
  /// In en, this message translates to:
  /// **'Patient phone'**
  String get patientPhone;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentList.
  ///
  /// In en, this message translates to:
  /// **'Payment List'**
  String get paymentList;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @selectTheDate.
  ///
  /// In en, this message translates to:
  /// **'Select The Date'**
  String get selectTheDate;

  /// No description provided for @availableSlot.
  ///
  /// In en, this message translates to:
  /// **'Available Slot'**
  String get availableSlot;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @giveYourRemarks.
  ///
  /// In en, this message translates to:
  /// **'Give your remarks'**
  String get giveYourRemarks;

  /// No description provided for @appointmentStatus.
  ///
  /// In en, this message translates to:
  /// **'Appointment Status'**
  String get appointmentStatus;

  /// No description provided for @noAppointment.
  ///
  /// In en, this message translates to:
  /// **'No Appointment'**
  String get noAppointment;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input'**
  String get invalidInput;

  /// No description provided for @pleaseEnterValidInput.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Input'**
  String get pleaseEnterValidInput;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Success Message'**
  String get successMessage;

  /// No description provided for @paymentSuccessfullMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment successfull'**
  String get paymentSuccessfullMessage;

  /// No description provided for @paymentUnsuccessfull.
  ///
  /// In en, this message translates to:
  /// **'Payment not successfull'**
  String get paymentUnsuccessfull;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @depositAmount.
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount'**
  String get depositAmount;

  /// No description provided for @depositAmountValidMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter valid deposit amount'**
  String get depositAmountValidMessage;

  /// No description provided for @depositType.
  ///
  /// In en, this message translates to:
  /// **'Deposit Type'**
  String get depositType;

  /// No description provided for @depositTypeValidMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter valid deposit type'**
  String get depositTypeValidMessage;

  /// No description provided for @cardType.
  ///
  /// In en, this message translates to:
  /// **'Card Type'**
  String get cardType;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Enter valid Name'**
  String get invalidName;

  /// No description provided for @enterCardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Holder Name'**
  String get enterCardHolderName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @enterCardnumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Number'**
  String get enterCardnumber;

  /// No description provided for @invalidCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid Card Number'**
  String get invalidCardNumber;

  /// No description provided for @exipryDate.
  ///
  /// In en, this message translates to:
  /// **'Exipry Date'**
  String get exipryDate;

  /// No description provided for @enterExipryDate.
  ///
  /// In en, this message translates to:
  /// **'Enter exipry date'**
  String get enterExipryDate;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @enterCvv.
  ///
  /// In en, this message translates to:
  /// **'Enter cvv'**
  String get enterCvv;

  /// No description provided for @invalidCvv.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid cvv'**
  String get invalidCvv;

  /// No description provided for @audioOnly.
  ///
  /// In en, this message translates to:
  /// **'Audio Only'**
  String get audioOnly;

  /// No description provided for @audioMuted.
  ///
  /// In en, this message translates to:
  /// **'Audio Muted'**
  String get audioMuted;

  /// No description provided for @videoMuted.
  ///
  /// In en, this message translates to:
  /// **'Video Muted'**
  String get videoMuted;

  /// No description provided for @joinMeeting.
  ///
  /// In en, this message translates to:
  /// **'Join Meeting'**
  String get joinMeeting;

  /// No description provided for @videoAppointment.
  ///
  /// In en, this message translates to:
  /// **'Video Appointment'**
  String get videoAppointment;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @appointmentLink.
  ///
  /// In en, this message translates to:
  /// **'Appointment Link'**
  String get appointmentLink;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @appointmentWasNotDeleted.
  ///
  /// In en, this message translates to:
  /// **'Appointment Was Not Deleted'**
  String get appointmentWasNotDeleted;

  /// No description provided for @appointmentWasDeleted.
  ///
  /// In en, this message translates to:
  /// **'Appointment Was Deleted'**
  String get appointmentWasDeleted;

  /// No description provided for @anErrorHasOccurred.
  ///
  /// In en, this message translates to:
  /// **'An Error Has Occurred'**
  String get anErrorHasOccurred;

  /// No description provided for @emailExist.
  ///
  /// In en, this message translates to:
  /// **'email exist'**
  String get emailExist;

  /// No description provided for @emailIsAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Email is already registered'**
  String get emailIsAlreadyRegistered;

  /// No description provided for @couldNotAuthenticateYouPleasetryagain.
  ///
  /// In en, this message translates to:
  /// **'Could Not Authenticate You. Please try again.'**
  String get couldNotAuthenticateYouPleasetryagain;

  /// No description provided for @yourAccrountHasBeenCreatedPpleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Your accrount has been created. please log in'**
  String get yourAccrountHasBeenCreatedPpleaseLogin;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgotYourPassword;

  /// No description provided for @yourPasswordResetLinkHasBeenSentToYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Your password reset link has been sent to your email address'**
  String get yourPasswordResetLinkHasBeenSentToYourEmailAddress;

  /// No description provided for @doNotHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do Not Have An Account'**
  String get doNotHaveAnAccount;

  /// No description provided for @doYouAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do You Already Have An Account'**
  String get doYouAlreadyHaveAnAccount;

  /// No description provided for @instead.
  ///
  /// In en, this message translates to:
  /// **'instead'**
  String get instead;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @youPovidedAnInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'You provided an invalid email'**
  String get youPovidedAnInvalidEmail;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @invalidfirstName.
  ///
  /// In en, this message translates to:
  /// **'invalid first name'**
  String get invalidfirstName;

  /// No description provided for @invalidLastName.
  ///
  /// In en, this message translates to:
  /// **'Invalid Last Name'**
  String get invalidLastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'invalid phone'**
  String get invalidPhone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @invalidAddress.
  ///
  /// In en, this message translates to:
  /// **'invalid address'**
  String get invalidAddress;

  /// No description provided for @hospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospital;

  /// No description provided for @authenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication Failed'**
  String get authenticationFailed;

  /// No description provided for @theEmailIsAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The Email Is Already In Use'**
  String get theEmailIsAlreadyInUse;

  /// No description provided for @thisIsNotAValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'This Is Not A Valid Email Address'**
  String get thisIsNotAValidEmailAddress;

  /// No description provided for @passwordIsTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Password Is Too Weak'**
  String get passwordIsTooWeak;

  /// No description provided for @couldNotFindTheEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Could Not Find The Email Address'**
  String get couldNotFindTheEmailAddress;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @invalidDepartment.
  ///
  /// In en, this message translates to:
  /// **'Invalid Department'**
  String get invalidDepartment;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @allInvoices.
  ///
  /// In en, this message translates to:
  /// **'All Invoices'**
  String get allInvoices;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @totalDeposit.
  ///
  /// In en, this message translates to:
  /// **'Total Deposit'**
  String get totalDeposit;

  /// No description provided for @totalDue.
  ///
  /// In en, this message translates to:
  /// **'Total Due'**
  String get totalDue;

  /// No description provided for @prescriptionHasBeenCreated.
  ///
  /// In en, this message translates to:
  /// **'Prescription has been created.'**
  String get prescriptionHasBeenCreated;

  /// No description provided for @createPrescription.
  ///
  /// In en, this message translates to:
  /// **'Create Prescription'**
  String get createPrescription;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @searchMedicine.
  ///
  /// In en, this message translates to:
  /// **'Search Medicine'**
  String get searchMedicine;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get add;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @afterfood.
  ///
  /// In en, this message translates to:
  /// **'after food'**
  String get afterfood;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'create'**
  String get create;

  /// No description provided for @yourPresciptions.
  ///
  /// In en, this message translates to:
  /// **'Your Prescriptions'**
  String get yourPresciptions;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @prescriptionDetail.
  ///
  /// In en, this message translates to:
  /// **'Prescription Detail'**
  String get prescriptionDetail;

  /// No description provided for @prescriptionId.
  ///
  /// In en, this message translates to:
  /// **'Prescription Id'**
  String get prescriptionId;

  /// No description provided for @patientId.
  ///
  /// In en, this message translates to:
  /// **'Patient Id'**
  String get patientId;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'gender'**
  String get gender;

  /// No description provided for @rx.
  ///
  /// In en, this message translates to:
  /// **'Rx'**
  String get rx;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'signature'**
  String get signature;

  /// No description provided for @doctorlist.
  ///
  /// In en, this message translates to:
  /// **'Doctor List'**
  String get doctorlist;

  /// No description provided for @doctorsearch.
  ///
  /// In en, this message translates to:
  /// **'Doctor Search'**
  String get doctorsearch;

  /// No description provided for @takeappointment.
  ///
  /// In en, this message translates to:
  /// **'Take appointment'**
  String get takeappointment;

  /// No description provided for @doctordetail.
  ///
  /// In en, this message translates to:
  /// **'Doctor details'**
  String get doctordetail;

  /// No description provided for @noslots.
  ///
  /// In en, this message translates to:
  /// **'No Slots'**
  String get noslots;

  /// No description provided for @nodatatoshow.
  ///
  /// In en, this message translates to:
  /// **'No Data To Show'**
  String get nodatatoshow;

  /// No description provided for @chooseapatient.
  ///
  /// In en, this message translates to:
  /// **'Choose a patient'**
  String get chooseapatient;

  /// No description provided for @searchpatient.
  ///
  /// In en, this message translates to:
  /// **'Search patient'**
  String get searchpatient;

  /// No description provided for @chooseadoctor.
  ///
  /// In en, this message translates to:
  /// **'Choose a doctor'**
  String get chooseadoctor;

  /// No description provided for @searchbypatientname.
  ///
  /// In en, this message translates to:
  /// **'Search by patient name'**
  String get searchbypatientname;

  /// No description provided for @searchbydoctorname.
  ///
  /// In en, this message translates to:
  /// **'Search by doctor name'**
  String get searchbydoctorname;

  /// No description provided for @searchdepartment.
  ///
  /// In en, this message translates to:
  /// **'Search department'**
  String get searchdepartment;

  /// No description provided for @searchdoctor.
  ///
  /// In en, this message translates to:
  /// **'Search doctor'**
  String get searchdoctor;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingData;

  /// No description provided for @bookADoctor.
  ///
  /// In en, this message translates to:
  /// **'Book A Doctor'**
  String get bookADoctor;

  /// No description provided for @labReports.
  ///
  /// In en, this message translates to:
  /// **'Lab Reports'**
  String get labReports;

  /// No description provided for @labReport.
  ///
  /// In en, this message translates to:
  /// **'Lab Report'**
  String get labReport;

  /// No description provided for @labId.
  ///
  /// In en, this message translates to:
  /// **'Lab Id'**
  String get labId;

  /// No description provided for @case_history.
  ///
  /// In en, this message translates to:
  /// **'Case History'**
  String get case_history;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
