import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Projenizin yollarına göre güncelleyin
import 'package:wm_rapor/viewmodel/report_detail_cubit.dart';
import 'package:wm_rapor/model/report_model.dart';
import 'package:wm_rapor/ui/common/app_constants.dart'; // enum'ların bulunduğu dosya

// Eksik enum'ları tamamlayıcı olarak buraya ekliyorum.
// Lütfen kendi app_constants.dart dosyanızı kullanın.

// Aşağıdaki Enum'ların wm_rapor/ui/common/app_constants.dart içinde tanımlı olduğunu varsayıyorum:
/*
enum enumNesneTipi {
  Combobox(1),
  ButtonEdit(3),
  LookupEdit(4),
  DateEdit(5),
  TextEdit(8);
  // ... diğerleri

  const enumNesneTipi(this.value);
  final int value;
}

enum enumKarsilastirmaTipi {
  Esittir(100),
  Esit_Degildir(101),
  Buyuktur(102),
  Kucuktur(103),
  Buyuk_Esittir(104),
  Kucuk_Esittir(105),
  Icerir(106),
  Icermez(107),
  ICinde(108), // ICinde olarak tanımlanmıştı
  Disinda(109);
  // ... diğerleri

  const enumKarsilastirmaTipi(this.value);
  final int value;
}

enum enumKaynakTipi {
  Isyeri_Listesi(10),
  Ambar_Listesi(11),
  Cari_Kart_Kodu(12),
  // ... diğerleri

  const enumKaynakTipi(this.value);
  final int value;
}
*/

class ReportFilterPage extends StatelessWidget {
  const ReportFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportDetailCubit, ReportDetailCubitState>(
      buildWhen: (previous, current) =>
          previous.currentFilters != current.currentFilters,
      builder: (context, state) {
        final filters = state.currentFilters;
        final cubit = context.read<ReportDetailCubit>();

        if (state.fetchRequest == RequestState.loading && filters.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (filters.isEmpty && state.reportModel != null) {
          return Scaffold(
            appBar: AppBar(title: Text("Filtreler")),
            body: Center(
              child: Text("Bu rapor için tanımlanmış filtre bulunmamaktadır."),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Rapor Filtreleri"),
            actions: [
              IconButton(
                icon: const Icon(Icons.cleaning_services),
                tooltip: "Temizle",
                onPressed: () => cubit.clearFilters(),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              itemCount: filters.length,
              separatorBuilder: (ctx, i) => const Divider(height: 30),
              itemBuilder: (context, index) {
                return _buildFilterRow(context, filters[index], index, cubit);
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                // Arka plan rengini tema üzerinden alabilirsiniz
                // backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Filtre uygulandı, ana cubit'i çağırarak raporu yeniden yükle
                // currentFilters, state'ten alındığı için zaten yeni değerleri içerir.
                if (state.reportModel?.id != null) {
                  cubit.fetchReport(
                    state.reportModel!.id!,
                    newFilters: filters,
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                "Filtreleri Uygula",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Her bir filtre satırını (Adı, Koşul Dropdown, Input Alanı) oluşturur.
  Widget _buildFilterRow(
    BuildContext context,
    Raporfiltreler filter,
    int index,
    ReportDetailCubit cubit,
  ) {
    // enumKarsilastirmaTipi'ni kullanarak DropdownItem listesi oluşturma
    List<DropdownMenuItem<int>> conditionItems = enumKarsilastirmaTipi.values
        .map((e) {
          return DropdownMenuItem(
            value: e.value,
            child: Text(
              e.name ?? "",
              style: const TextStyle(fontSize: 12),
            ), // enum'daki 'name' veya 'description' alanını kullanın
          );
        })
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filter.filtreadi ?? filter.alanadi ?? "Bilinmeyen Filtre",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. KOŞUL DROPDOWN (Eşittir, Büyüktür vs.)
            SizedBox(
              width: 120,
              child: DropdownButtonFormField<int>(
                isExpanded: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(),
                ),
                initialValue: filter.kosul,
                items: conditionItems,
                onChanged: (val) {
                  if (val != null) {
                    cubit.updateFilterCondition(index, val);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),

            // 2. GİRİŞ ALANI (Text, Date, Dropdown)
            Expanded(child: _buildInputWidget(context, filter, index, cubit)),
          ],
        ),
      ],
    );
  }

  /// Nesne tipine göre doğru giriş widget'ını oluşturur.
  Widget _buildInputWidget(
    BuildContext context,
    Raporfiltreler filter,
    int index,
    ReportDetailCubit cubit,
  ) {
    final nesneTipi = filter.nesnetipi;

    if (nesneTipi == enumNesneTipi.DateEdit.value) {
      final dateController = TextEditingController(text: filter.degerilk);

      return TextFormField(
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Tarih Seçiniz",
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        onTap: () async {
          // Eğer değer doluysa başlangıç tarihi olarak onu kullan
          DateTime initialDate =
              (filter.degerilk != null && filter.degerilk!.isNotEmpty)
              ? DateFormat("dd.MM.yyyy").parse(filter.degerilk!)
              : DateTime.now();

          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: const Locale('tr', 'TR'),
          );
          if (picked != null) {
            String formattedDate = DateFormat("dd.MM.yyyy").format(picked);
            // Cubit'i güncelle
            cubit.updateFilterValue(index, formattedDate);
            // TextField'ı güncelle
            dateController.text = formattedDate;
          }
        },
      );
    }
    // =============================
    // DROPDOWN / LOOKUP ALANI (LookupEdit: 4, Combobox: 1)
    // =============================
    else if (nesneTipi == enumNesneTipi.LookupEdit.value ||
        nesneTipi == enumNesneTipi.Combobox.value) {
      // NOT: Bu kısım, ReportSingleton().[listName] yapınız ile entegre edilmelidir.
      List<Map<String, dynamic>> items = _getDropdownItems(filter.kaynaktipi);

      // Seçili değer listede var mı kontrolü (Hata almamak için)
      var selectedVal = filter.degerilk;
      bool listContainsValue = items.any(
        (element) => element['NR'].toString() == selectedVal.toString(),
      );

      return DropdownButtonFormField<String>(
        initialValue: listContainsValue ? selectedVal : null,
        isExpanded: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        hint: const Text("Seçim Yapınız"),
        items: items.map((opt) {
          return DropdownMenuItem<String>(
            value: opt['NR'].toString(),
            child: Text(
              opt['NAME'].toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) cubit.updateFilterValue(index, val);
        },
      );
    }
    // =============================
    // STANDART TEXT ALANI (TextEdit: 8, SpinEdit: 6, ButtonEdit: 3)
    // =============================
    else {
      return TextFormField(
        initialValue: filter.degerilk,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Değer Giriniz",
          suffixIcon: filter.degerilk != null && filter.degerilk!.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () => cubit.updateFilterValue(index, ""),
                )
              : null,
        ),
        onChanged: (val) {
          // Değer değiştikçe cubit'i güncelle
          cubit.updateFilterValue(index, val);
        },
      );
    }
  }

  /// Lookup/Dropdown verilerini ReportSingleton'dan çeken simülasyon metod
  List<Map<String, dynamic>> _getDropdownItems(int? kaynakTipi) {
    if (kaynakTipi == enumKaynakTipi.Isyeri_Listesi.value) {
      return [
        {'NR': '10', 'NAME': 'Merkez Şube'},
        {'NR': '20', 'NAME': 'Şube 2'},
      ];
    } else if (kaynakTipi == enumKaynakTipi.Ambar_Listesi.value) {
      return [
        {'NR': '1', 'NAME': 'Ana Ambar'},
        {'NR': '2', 'NAME': 'Yedek Ambar'},
      ];
    }
    // Diğer kaynak tipleri için buraya ekleme yapın

    // Varsayılan
    return [
      {'NR': '1', 'NAME': 'Seçenek 1'},
      {'NR': '2', 'NAME': 'Seçenek 2'},
    ];
  }
}
