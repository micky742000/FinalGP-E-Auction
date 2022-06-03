import 'package:e_auction/constants/constant.dart';
import 'package:flutter/material.dart';

class TermsAndConditional extends StatelessWidget {
  const TermsAndConditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Terms & Conditions:")
      ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('*Terms & Conditions*',style: headingStyle,),
                  Text('\nREGISTRATION AS A USER',style: headingStyle3,),
                  Text("\n1. Users shall register online on the App. The User shall choose a User name and a password during Registration. User names and passwords shall be kept confidential and shall not be transferred or ceded to third parties for use\n2. Should there be changes in the Registration information after Registration, the User shall correct them without delay.\n3. E-Auction reserves the right to verify Registration information through the submission of adequate documents as well as reject incomplete or non-verifiable Registrations.",style: textStyle1,),
                  Text('\nEXCLUSION OF USERS',style: headingStyle3,),
                  Text('\nE-Auction may temporarily or permanently exclude a User or deprive it of access to a Sales offer or from making a bid on a temporary or permanent basis as well as delete the Registration, if:',style: headingStyle4,),
                  Text("\n1. E-Auction has called on the User to furnish proof of its identity and the User fails to furnish such proof within an adequate period in spite of having been warned of an impending exclusion,\n2. The User has furnished incomplete or false information during Registration and fails to complement or correct such information within an adequate period in spite of being requested to do so.",style: textStyle1,),
                  Text('\nAuction insurance',style: headingStyle3,),
                  Text("\n1. The user in E-Auction pays the insurance by purchasing coins.\n2. Coins remain with the user and are not deducted unless he displays a product or wishes to bid.\n3. Also, the user must have 25% of the value of the product with him, and that will be deducted from him in case of breaching the agreement or bidding.\n4. In the event, the bidder breaches his consent to sell the product, the user who won the auction will be compensated 12.5% of the product bidder's insurance as compensation.",style: textStyle1,),
                  Text('\nBidding on Items',style: headingStyle3,),
                  Text('\nYou must be a registered user to bid on items. By bidding, you are stating that you are ready and willing to purchase that item for your bid amount, plus any shipping charges disclosed in the listing. If you are outbid, or your bid does not meet the reserve price, you are under no obligation to buy. But in all other cases, you are entering a contract to buy the item, and to deliver payment within the time period specified. If you cannot pay please don’t bid. Your bids are final and non-retractable. We will not accept e-mail bids.',style: textStyle1,),
                  Text('\nStarting Bid',style: headingStyle3,),
                  Text('\nE-Auction will predetermine the number of Item(s) in an auction. E-Auction will set the starting bid on each item. The Starting Bid is designed to encourage bidding. If an item is incorrectly described online, E-Auction reserves the right to rectify such error and email to all active bidders the correct description.',style: textStyle1,),
                  Text('\nBidder Rights',style: headingStyle3,),
                  Text('\nAll rights granted herein are personal and exclusive to the registered bidder, and may not be assigned or transferred to another person or entity, by operation of law or otherwise. Any attempt to assign or transfer any such rights shall be void and unenforceable. No third party may rely on any benefit or right conferred herein or granted to any Bidder. If you have any questions, please contact E-Auction immediately.',style: textStyle1,),
                  Text('\nAcceptance of Terms',style: headingStyle3,),
                  Text('\nA bid placed by any person shall be conclusive proof that he or she acquainted himself or herself with the terms and conditions of sale and agreed to be bound by such terms and conditions prior to placing any bid.',style: textStyle1,),
                  Text('\nReturn Policy',style: headingStyle3,),
                  Text('\nAll online items are sold in “as is” condition.  A limited guarantee is offered with regards to the following: all hand signatures are guaranteed authentic. Weight, size, estimated value, origin, grade, quality, age, condition, rarity, and importance, are not guaranteed for any item. All sales are final unless a gross error in description has been made. Any disputes must be made within thirty (30) days of receiving the item. No returns will be accepted without a valid return authorization from E-Auction. E-Auction will not refund above and beyond the original costs.  Any additional charges incurred by the winning bidder, including appraisals, insurance, return shipping, etc. will not be covered by any refund.',style: textStyle1,),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
