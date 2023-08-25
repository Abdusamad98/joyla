part of 'website_add_cubit.dart';

class WebsiteAddState extends Equatable {
  final String statusText;
  final WebsiteModel websiteModel;
  final FormStatus status;

  const WebsiteAddState({
    required this.websiteModel,
    this.statusText = "",
    this.status = FormStatus.pure,
  });

  WebsiteAddState copyWith({
    String? statusText,
    WebsiteModel? websiteModel,
    FormStatus? status,
  }) =>
      WebsiteAddState(
        websiteModel: websiteModel ?? this.websiteModel,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        websiteModel,
        statusText,
        status,
      ];

  bool canAddWebsite() {
    if (websiteModel.image.isEmpty) return false;
    if (websiteModel.name.isEmpty) return false;
    if (websiteModel.link.isEmpty) return false;
    if (websiteModel.author.isEmpty) return false;
    if (websiteModel.contact.isEmpty) return false;
    if (websiteModel.hashtag.isEmpty) return false;
    return true;
  }
}
