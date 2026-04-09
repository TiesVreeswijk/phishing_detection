class AnalysisResult {
  final String verdict;
  final int confidence;
  final String summary;
  final List<String> redFlags;

  const AnalysisResult({
    required this.verdict,
    required this.confidence,
    required this.summary,
    required this.redFlags,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      verdict: json['verdict'] as String,
      confidence: json['confidence'] as int,
      summary: json['summary'] as String,
      redFlags: List<String>.from(json['red_flags'] as List<dynamic>),
    );
  }

  bool get isLegitimate => verdict == 'legitimate';
  bool get isSuspicious => verdict == 'suspicious';
  bool get isPhishing => verdict == 'phishing';
}