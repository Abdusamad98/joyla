part of 'website_fetch_cubit.dart';

class WebsiteFetchState extends Equatable {
  final String statusText;
  final WebsiteModel? websiteDetail;
  final List<WebsiteModel> websites;
  final FormStatus status;

  const WebsiteFetchState({
    this.websiteDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.websites,
  });

  WebsiteFetchState copyWith({
    String? statusText,
    WebsiteModel? websiteDetail,
    List<WebsiteModel>? websites,
    FormStatus? status,
  }) =>
      WebsiteFetchState(
        websiteDetail: websiteDetail ?? this.websiteDetail,
        websites: websites ?? this.websites,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        websites,
        statusText,
        status,
        websiteDetail,
      ];
}
