import 'package:nearby_connections/nearby_connections.dart';

class NearbyConstants {
  NearbyConstants._();

  static const String serviceId = "com.nav.historical_guidance.offline";

  static const Strategy strategy = Strategy.P2P_CLUSTER;

  static const String databasePayload = "DATABASE";
  static const String imagePayload = "IMAGE";
  static const String audioPayload = "AUDIO";
  static const String completedPayload = "COMPLETED";
}
