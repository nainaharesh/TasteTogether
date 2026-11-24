// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/search_filters_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/chip_row.dart';

/// Filters bottom sheet. Explore ka filter button poora sheet kholta hai,
/// Search ka "Best match" sirf Sort wala hissa (sortOnly: true).
/// Apply dabane par naye SearchFilters wapas milte hain.
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, required this.initial, this.sortOnly = false});

  final SearchFilters initial;
  final bool sortOnly;

  static Future<SearchFilters?> show(
    SearchFilters initial, {
    bool sortOnly = false,
  }) {
    return Get.bottomSheet<SearchFilters>(
      FilterSheet(initial: initial, sortOnly: sortOnly),
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
    );
  }

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  static const _ratings = [0.0, 4.0, 4.5, 4.8];
  static const _ratingLabels = ['Any', '4.0+', '4.5+', '4.8+'];
  static const _distances = [0.0, 1.0, 2.0, 5.0];
  static const _distanceLabels = ['Any', '1 km', '2 km', '5 km'];

  late SearchFilters draft = widget.initial;

  Widget _section(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(999.r),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.sortOnly ? 'Sort by' : 'Filters',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(
                    () => draft = widget.sortOnly
                        ? draft.copyWith(sort: 0)
                        : const SearchFilters(),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            _section(
              'Sort by',
              ChipRow(
                padding: EdgeInsets.zero,
                labels: SearchFilters.sortOptions,
                selectedIndex: draft.sort,
                onSelected: (i) =>
                    setState(() => draft = draft.copyWith(sort: i)),
              ),
            ),
            if (!widget.sortOnly) ...[
              _section(
                'Minimum rating',
                ChipRow(
                  padding: EdgeInsets.zero,
                  labels: _ratingLabels,
                  selectedIndex: _ratings.indexOf(draft.minRating),
                  onSelected: (i) => setState(
                    () => draft = draft.copyWith(minRating: _ratings[i]),
                  ),
                ),
              ),
              _section(
                'Distance',
                ChipRow(
                  padding: EdgeInsets.zero,
                  labels: _distanceLabels,
                  selectedIndex: _distances.indexOf(draft.maxDistanceKm),
                  onSelected: (i) => setState(
                    () => draft = draft.copyWith(maxDistanceKm: _distances[i]),
                  ),
                ),
              ),
            ],
            FilledButton(
              onPressed: () => Get.back(result: draft),
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
