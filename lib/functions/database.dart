//  if (credential.user!.emailVerified) {
//                             var user = FirebaseAuth.instance.currentUser;
//                             if (user != null) {
//                               try {
//                                 QuerySnapshot<Map<String, dynamic>> snapshot =
//                                     await FirebaseFirestore.instance
//                                         .collection('profile')
//                                         .get();

//                                 if (snapshot.docs.isNotEmpty) {
//                                   for (QueryDocumentSnapshot<
//                                           Map<String, dynamic>> document
//                                       in snapshot.docs) {
//                                     Map<String, dynamic> data = document.data();
//                                     bool isDonor = data['isDonor'];
//                                     controller.changeState();
//                                     print(controller.profile_show);
//                                   }
//                                 } else {
//                                   print('No documents found.');
//                                 }
//                               } catch (e) {
//                                 print('Error fetching profile data: $e');
//                               }
//                             }