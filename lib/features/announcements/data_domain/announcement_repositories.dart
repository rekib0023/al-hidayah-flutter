import 'package:al_hidayah/features/announcements/data_domain/announcement_service.dart';
import 'package:al_hidayah/models/notices.dart';

class AnnouncementRepository {
  final AnnouncementService _apiService = AnnouncementService();

  Future<NoticeList> getNotices({
    String limit = "",
    String offset = "",
    String title = "",
    String showAll = "true",
  }) async {
    try {
      return await _apiService.getNotices(
        limit,
        offset,
        title,
        showAll,
      );
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<Notice> createNotices(String title, String description) async {
    try {
      return await _apiService.createNotices(title, description);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
