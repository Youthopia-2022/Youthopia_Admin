import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youthopia_admin/services/events.dart';
import 'package:youthopia_admin/services/participant.dart';

final supabase = Supabase.instance.client;

class Supa{

  Event toEvent(Map<String, dynamic> result) {
    final String eventPosterUrl = Supabase.instance.client.storage
        .from('event-posters')
        .getPublicUrl(result['event_id']);
    int len = result['event_startTime'].length;
    int hr = int.parse(result['event_startTime']
        .substring(0, result['event_startTime'].length - 2));

    hr = (result['event_startTime'].indexOf('a') == -1) ? hr + 12 : hr;

    DateTime date = DateTime.utc(
        int.parse(result['event_date'].substring(7)),
        int.parse(result['event_date'].substring(3, 5)),
        int.parse(result['event_date'].substring(0, 2)));
    return Event(
        result['event_id'],
        result['event_name'],
        result['event_venue'],
        TimeOfDay(hour: hr, minute: 00),
        date,
        result['event_fees_dit'],
        result['event_fees_outsiders'],
        result['event_description'],
        result['event_isTeam'],
        result['event_min_members'],
        result['event_max_members'],
        '$eventPosterUrl.webp');
  }

  Future<void> getEventData() async {

    try {
      final technical = await Supabase.instance.client
          .from('events')
          .select()
          .eq('event_category', 'Technical');
      Event.techEvents = technical.map((e) => toEvent(e)).toList();
      final cultural = await Supabase.instance.client
          .from('events')
          .select()
          .eq('event_category', 'Cultural');
      Event.culturalEvents = cultural.map((e) => toEvent(e)).toList();

      final informal = await Supabase.instance.client
          .from('events')
          .select()
          .eq('event_category', 'Informal');
      Event.informalEvents = informal.map((e) => toEvent(e)).toList();

      final debate = await Supabase.instance.client
          .from('events')
          .select()
          .eq('event_category', 'Literary');
      Event.debateEvents = debate.map((e) => toEvent(e)).toList();

      final arts = await Supabase.instance.client
          .from('events')
          .select()
          .eq('event_category', 'Fine arts');
      Event.artsEvents = arts.map((e) => toEvent(e)).toList();
    } on PostgrestException catch (error) {
      debugPrint(error.toString());
    }
    debugPrint(Event.techEvents!.length.toString());
    debugPrint(Event.culturalEvents!.length.toString());
    debugPrint(Event.informalEvents!.length.toString());
    debugPrint(Event.debateEvents!.length.toString());
    debugPrint(Event.artsEvents!.length.toString());
  }

  static Future<List> getParticipants(String eventId) async {

    final data = await supabase
        .from('events')
        .select('registered_participant')
        .match({'event_id': eventId});
    debugPrint(data[0]['registered_participant'].toString());
    return data[0]['registered_participant'];
  }

  Future<List> getParticipantList(String eventId) async{
    final List orderIdList = await getParticipants(eventId);
    final List participants = [];
    for (int i = 0; i < orderIdList!.length; i++) {
      debugPrint(orderIdList![i]);
      final data = await supabase
          .from('registrations')
          .select()
          .eq('order_id', orderIdList[i]);

      Participant part = toParticipant(data[0], orderIdList[i]);
      participants.add(part);
      debugPrint(data.toString());
    }
    return participants;
  }

  Participant toParticipant(result, String OrderId) {

    bool isDit = (result['participant_identity'].length == 10) ? true : false;

    String image = (!isDit)? supabase.storage
        .from('participant-identity-proof')
        .getPublicUrl(OrderId) : "";

    debugPrint(result['team_name'].toString());
    return Participant(
        result['participant_name'],
        result['participant_phone'],
        result['participant_identity'],
        result['participant_email'],
        result['team_name'].toString(),
        result['team_members_name'].toString(),
        isDit,
        image
    );
  }
}