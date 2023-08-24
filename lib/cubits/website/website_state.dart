part of 'website_cubit.dart';

class WebsiteState extends Equatable {
  final String statusText;
  final WebsiteModel websiteModel;
   WebsiteModel? websiteDetail;
  final List<WebsiteModel> websites;
  final FormStatus status;

   WebsiteState({
    required this.websiteModel,
     this.websiteDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.websites,
  });

  WebsiteState copyWith({
    String? statusText,
    WebsiteModel? websiteModel,
    WebsiteModel? websiteDetail,
    List<WebsiteModel>? websites,
    FormStatus? status,
  }) =>
      WebsiteState(
        websiteDetail: websiteDetail ?? this.websiteDetail,
        websiteModel: websiteModel ?? this.websiteModel,
        websites: websites ?? this.websites,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        websiteModel,
        websites,
        statusText,
        status,
    websiteDetail,
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
