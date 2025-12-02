import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/singleton/report_singleton.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';
import 'package:wm_rapor/ui/views/report_paging_view.dart';
import 'package:wm_rapor/ui/widgets/app_general_app_bar.dart';
import 'package:wm_rapor/ui/widgets/app_loading.dart';
import 'package:wm_rapor/viewmodel/report_menu_cubit.dart';

class ReportMenu extends StatefulWidget {
  const ReportMenu({super.key});

  @override
  State<ReportMenu> createState() => _ReportMenuState();
}

class _ReportMenuState extends State<ReportMenu> {
  @override
  void initState() {
    context.read<ReportMenuCubit>().initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Permission> items = ReportSingleton().getPermissionList;

    return Scaffold(
      appBar: AppGeneralAppBar(title: 'Rapor'),
      body: BlocBuilder<ReportMenuCubit, ReportMenuCubitState>(
        builder: (context, state) {
          if (state.initPageRequest == RequestState.loading) {
            return const Center(child: AppLoading());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: AppSpacing.allMedium,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return MenuButton(
                        btnText: item.aciklama ?? '',
                        btnSubText: '',
                        color: Colors.white,
                        processType: 0,
                        menuIconUrl: item.iconurl!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ReportPagingView(perm: item);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String btnText;
  final String btnSubText;
  final Color color;
  final int processType;
  final String menuIconUrl;
  final Function()? onTap;

  const MenuButton({
    super.key,
    required this.btnText,
    required this.btnSubText,
    required this.color,
    required this.processType,
    required this.menuIconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(UiHelpers.borderRadius),
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          padding: AppSpacing.symmetricHorizontalTiny,
          decoration: UiHelpers.appGeneralBoxDecoration.copyWith(
            color: AppColors.kcWhite,
          ),
          child: buildGridButton(),
        ),
      ),
    );
  }

  SizedBox buildGridButton() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
            child: SvgPicture.asset(
              package: 'wm_rapor',
              menuIconUrl,
              width: 45,
              height: 45,
              fit: BoxFit.fill,
            ),
          ),
          AppSpacing.verticalSpaceMedium,
          Text(
            btnText,
            textAlign: TextAlign.center,
            style: AppTextStyles().ktsBodySmall,
          ),
        ],
      ),
    );
  }
}
