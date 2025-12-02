import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';
import 'package:wm_rapor/ui/common/util/perm_util.dart';
import 'package:wm_rapor/ui/views/report_item.dart';
import 'package:wm_rapor/ui/widgets/app_general_app_bar.dart';
import 'package:wm_rapor/ui/widgets/app_general_textfield.dart';
import 'package:wm_rapor/ui/widgets/app_loading.dart';
import 'package:wm_rapor/ui/widgets/info_message_widget.dart';
import 'package:wm_rapor/viewmodel/report_paging_cubit.dart';

class ReportPagingView extends StatefulWidget {
  final Permission perm;
  const ReportPagingView({super.key, required this.perm});

  @override
  State<ReportPagingView> createState() => _ReportPagingViewState();
}

class _ReportPagingViewState extends State<ReportPagingView> {
  final PagingController<int, dynamic> _pagingController = PagingController(
    firstPageKey: 0,
  );
  final TextEditingController searchDocController = TextEditingController();

  @override
  void initState() {
    context.read<ReportPagingCubit>().initPagingPage(widget.perm);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final hasPerm = PermUtil().yetkiKontrol(
        context.read<ReportPagingCubit>().perm,
        EnumYetkiTurleri.listele,
      );

      if (!hasPerm) {
        _pagingController.error = 'Listeleme yetkiniz bulunmamaktadır.';
        return;
      }
      final docList = await context.read<ReportPagingCubit>().pagingReport(
        pageKey,
      );

      final isLastPage = docList.length < HttpConstants.pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(docList);
      } else {
        final int nextPageKey = pageKey + docList.length;
        _pagingController.appendPage(docList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kcVeryLightGray,
      appBar: AppGeneralAppBar(title: widget.perm.aciklama ?? 'Raporlama'),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: Padding(
          padding: AppSpacing.listPaddingWithoutbottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child:
                        BlocBuilder<ReportPagingCubit, ReportPagingCubitState>(
                          builder: (context, state) {
                            searchDocController.text = state.searchccText ?? '';
                            return AppGeneralTextField(
                              controller: searchDocController,
                              onChanged: (value) => context
                                  .read<ReportPagingCubit>()
                                  .searchControllerChanged(value),
                              onFieldSubmitted: (p0) =>
                                  _pagingController.refresh(),
                              prefixIcon: PhosphorIcon(
                                PhosphorIcons.magnifyingGlass(
                                  PhosphorIconsStyle.bold,
                                ),
                                color: AppColors.kcBlueGray,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  if (searchDocController.text != '') {
                                    await context
                                        .read<ReportPagingCubit>()
                                        .clearSearchingList();
                                    _pagingController.refresh();
                                  }
                                },
                                icon: PhosphorIcon(
                                  PhosphorIcons.x(PhosphorIconsStyle.bold),
                                  color: AppColors.kcBlueGray,
                                  size: 18,
                                ),
                              ),
                              hintText: 'Ara',
                              textInputAction: TextInputAction.search,
                            );
                          },
                        ),
                  ),
                  // AppSpacing.horizontalSpaceSmall,
                  // Expanded(
                  //   flex: 0,
                  //   child: Container(
                  //     decoration: UiHelpers.appGeneralBoxDecoration
                  //         .copyWith(color: AppColors.kcWhite),
                  //     child: IconButton(
                  //       onPressed: () {
                  //         // _openReceiptSort(context);
                  //       },
                  //       icon: PhosphorIcon(
                  //         PhosphorIcons.arrowsDownUp(PhosphorIconsStyle.bold),
                  //         color: AppColors.kcBlueGray,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // AppSpacing.horizontalSpaceSmall,
                  // BlocBuilder<ReportCubit, ReportCubitState>(
                  //   builder: (context, state) {
                  //     return Expanded(
                  //       flex: 0,
                  //       child: Container(
                  //         decoration: UiHelpers.appGeneralBoxDecoration
                  //             .copyWith(color: AppColors.kcWhite),
                  //         child: IconButton(
                  //           onPressed: () {
                  //             openReceiptDraftFilters(context, state);
                  //           },
                  //           icon: filterIcon(context, state),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              AppSpacing.verticalSpaceSmall,
              BlocBuilder<ReportPagingCubit, ReportPagingCubitState>(
                builder: (context, state) {
                  return Text(
                    'Toplam ${state.listCount} adet listelendi',
                    style: AppTextStyles().ktsBodySmall.copyWith(
                      color: AppColors.kcBlueGray,
                    ),
                  );
                },
              ),
              AppSpacing.verticalSpaceMedium,
              Expanded(
                child: PagedListView<int, dynamic>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    firstPageProgressIndicatorBuilder: (context) =>
                        AppLoading(),
                    newPageProgressIndicatorBuilder: (context) => AppLoading(),
                    noItemsFoundIndicatorBuilder: (context) =>
                        receiptEmptyListView(),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                      child: InfoMessageWidget(
                        svgPicture: 'assets/access_denied.svg',
                        title: 'Listeleme başarısız',
                        subtitle:
                            _pagingController.error?.toString() ??
                            'Bir hata meydana geldi.',
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (context) => Center(
                      child: Text(
                        _pagingController.error?.toString() ??
                            'Bir hata meydana geldi.',
                        style: AppTextStyles().ktsBodySmall.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    itemBuilder: (context, item, index) {
                      return listItem(item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  listItem(item) {
    return ReportItem(report: item);
  }

  receiptEmptyListView() {
    return const Center(
      child: InfoMessageWidget(
        svgPicture: 'assets/file_search.svg',
        title: 'Liste boş',
        subtitle: 'Kayıtlı veri bulunmamaktadır.',
      ),
    );
  }
}
