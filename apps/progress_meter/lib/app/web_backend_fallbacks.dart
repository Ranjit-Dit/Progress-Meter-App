import '../features/ai_coach/domain/coach_models.dart';
import '../features/ai_coach/domain/coach_repository.dart';
import '../features/assessment/domain/ai_judgment.dart';
import '../features/benchmark_research/domain/benchmark_analytics.dart';
import '../features/benchmark_research/domain/benchmark_models.dart';
import '../features/benchmark_research/domain/benchmark_repository.dart';
import '../features/progress/domain/progress_types.dart';
import '../features/testing_lab/domain/lab_models.dart';
import '../features/testing_lab/domain/lab_repository.dart';

const _webMessage =
    'AI requests from this web build need a configured HTTPS gateway. Use Connection settings, or run the native app for its local backend.';

class WebCoachRepository implements CoachRepository {
  @override
  Future<CoachReply> ask({
    required String question,
    required CoachContext context,
    List<CoachTurn> conversation = const [],
  }) =>
      Future.error(const CoachException('web_backend_unavailable', _webMessage));

  @override
  Future<CoachHealth> health() async =>
      const CoachHealth(configured: false, mode: 'web');

  @override
  void close() {}
}

class WebLabRepository implements LabRepository {
  @override
  Future<LabSession> generate({
    required String requestId,
    required String topic,
    required String learningNotes,
    required ProgressTrack track,
    required LabLevel level,
    int questionCount = defaultLabQuestionCount,
  }) =>
      Future.error(const LabException('web_backend_unavailable', _webMessage));

  @override
  Future<LabResult> grade(
    LabSession session,
    Map<String, String> answers,
  ) =>
      Future.error(const LabException('web_backend_unavailable', _webMessage));

  @override
  Future<CoachHealth> health() async =>
      const CoachHealth(configured: false, mode: 'web');

  @override
  void close() {}
}

class WebBenchmarkResearchRepository implements BenchmarkResearchRepository {
  @override
  Future<ResearchPlan> research({
    required String requestId,
    required BenchmarkKind kind,
    required String query,
    required String context,
    required String postText,
    required ProgressTrack track,
  }) =>
      Future.error(
        const BenchmarkException('web_backend_unavailable', _webMessage),
      );

  @override
  Future<BenchmarkReview> review(
    BenchmarkProgressSnapshot snapshot, {
    required String requestId,
  }) =>
      Future.error(
        const BenchmarkException('web_backend_unavailable', _webMessage),
      );

  @override
  Future<CoachHealth> health() async =>
      const CoachHealth(configured: false, mode: 'web');

  @override
  void close() {}
}

class WebJudgmentRepository implements AiJudgmentRepository {
  @override
  Future<AiProgressJudgment> review(
    AiEvidenceSnapshot snapshot, {
    required String requestId,
  }) =>
      Future.error(const AiJudgmentException(_webMessage));

  @override
  void close() {}
}
