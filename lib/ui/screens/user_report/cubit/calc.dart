import 'package:admin_app/models/visitCount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

Future<VisitCounts> calculateVisitCountsForUser(String userId, DateTime startDate, DateTime endDate) async {
  try {
    CollectionReference visitsCollection = FirebaseFirestore.instance.collection('visitsV2');

    // Create a Firestore query to fetch the visits within the date range and for the specific user
    QuerySnapshot querySnapshot = await visitsCollection
        .where('userId', isEqualTo: userId)
        .where('dateOfVisit', isGreaterThanOrEqualTo:
    DateFormat('dd/MM/yyyy')
        .format(startDate).toString())
        .where('dateOfVisit', isLessThanOrEqualTo: DateFormat('dd/MM/yyyy')
        .format(endDate).toString())
        .get();
print(endDate );
    // Initialize counters
    int plannedVisits = 0;
    int unplannedVisits = 0;
    int completedVisits = 0;
    int uncompletedVisits = 0;
   int totalvis=0;

    // Loop through the query results and count the visits
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      bool isPlanned = docSnapshot.get('planed');
      bool isCompleted = docSnapshot.get('status');
      if (isPlanned) {
        plannedVisits++;
      } else {
        unplannedVisits++;
      }
      if (isCompleted) {
        completedVisits++;
        totalvis++;
      }
      else {
        uncompletedVisits++;
        totalvis++;
      }

    }

    print("++++++++++"+unplannedVisits.toString()+userId);


    // Return an instance of the VisitCounts class containing the counts
    return VisitCounts(
      plannedVisits: plannedVisits,
      unplannedVisits: unplannedVisits,
      completedVisits: completedVisits,
      uncompletedVisits: uncompletedVisits,
      totalVis: totalvis,

    );
  } catch (error) {
    print('Error calculating visit counts: $error');
    // Return an instance of the VisitCounts class with all counts set to zero
    return VisitCounts(
      plannedVisits: 0,
      unplannedVisits: 0,
      completedVisits: 0,
      uncompletedVisits: 0,
      totalVis: 0,
    );
  }
}
