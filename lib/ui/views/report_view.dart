import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_rapor/model/report_data_model.dart';
import 'package:wm_rapor/model/report_model.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';
import 'package:wm_rapor/ui/views/report_filter_view.dart';
import 'package:wm_rapor/ui/views/report_paging_view.dart';
import 'package:wm_rapor/ui/widgets/app_general_app_bar.dart';
import 'package:wm_rapor/ui/widgets/data_table.dart';
import 'package:wm_rapor/viewmodel/data_table_cubit.dart';
import 'package:wm_rapor/viewmodel/report_detail_cubit.dart'; // yolu örnek

class ReportScreen extends StatefulWidget {
  final int reportId;

  const ReportScreen({super.key, required this.reportId});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    context.read<ReportDetailCubit>().fetchReport(widget.reportId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppGeneralAppBar(
        title: 'Rapor Detayı',
        actionButton: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilterPage,
          ),
        ],
      ),
      body: BlocBuilder<ReportDetailCubit, ReportDetailCubitState>(
        builder: (context, state) {
          // 1) Loading
          if (state.fetchRequest == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final reportData = state.reportData;
          if (reportData == null) {
            return const Center(child: Text('Gösterilecek veri bulunamadı'));
          }

          return BlocProvider(
            create: (_) => DataTableCubit(),
            child: Column(
              children: [
                Expanded(
                  child: DataTableReport(
                    headerButtonsVisibility: (true, true, true),
                    reportName: "Fatura Raporu",
                    reportData: reportData,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openFilterPage() {
    // ReportDetailCubit'e erişim
    final cubit = context.read<ReportDetailCubit>();

    // Eğer rapor modeli veya filtre listesi yoksa filtre sayfasını açma.
    if (cubit.state.reportModel?.raporfiltreler == null ||
        cubit.state.reportModel!.raporfiltreler!.isEmpty) {
      // Bu durumda kullanıcıya bir uyarı gösterebilirsiniz.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bu rapor için filtre tanımlanmamıştır.")),
      );
      return;
    }

    // Filtre sayfasına git. Artık dönen bir sonuç (result) beklemiyoruz,
    // çünkü filtreler ReportDetailCubit içinde anlık olarak güncelleniyor
    // ve "Uygula" butonu cubit.fetchReport'u tetikliyor.
    Navigator.push(
      context,
      MaterialPageRoute(
        // ReportFilterPage'in constructor'ına filtre listesi göndermeye gerek kalmadı,
        // çünkü sayfa Cubit'i dinleyerek filtre listesini state'ten alacak.
        builder: (context) => const ReportFilterPage(),
      ),
    );

    // Filtre sayfasından geri dönüldüğünde ekstra bir işlem yapmaya gerek yoktur.
    // Eğer filtreler değiştiyse, ReportFilterPage'deki "Uygula" butonu raporu zaten yenilemiştir.
  }
}
