import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, List<String>> options;
  final Map<String, Set<String>> initialSelected;
  final void Function(Map<String, Set<String>> selections) onApply;
  const FilterBottomSheet({
    super.key,
    required this.options,
    required this.initialSelected,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, Set<String>> selected;
  late Map<String, String> searchText;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.options.keys.length,
      vsync: this,
    );
    selected = Map.fromEntries(
      widget.options.keys.map(
        (k) => MapEntry(k, {...?widget.initialSelected[k]}),
      ),
    );
    searchText = {for (var k in widget.options.keys) k: ''};
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabKeys = widget.options.keys.toList();
    return AnimatedPadding(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      padding: MediaQuery.of(context).viewInsets,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.98,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 24,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'إغلاق',
                  ),
                ],
              ),
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                indicator: BoxDecoration(color: Colors.transparent),
                tabs: List.generate(tabKeys.length, (i) {
                  final isSelected = _tabController.index == i;
                  return AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, child) {
                      final selected = _tabController.index == i;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selected
                                  ? Colors.blue.withOpacity(0.08)
                                  : Colors.white,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          tabKeys[i],
                          style: TextStyle(
                            color:
                                selected ? Colors.blueAccent : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  );
                }),
                onTap: (idx) {
                  setState(() {}); // لإعادة بناء الأنيميشن
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children:
                      tabKeys.map((tab) {
                        final options = widget.options[tab]!;
                        final filtered =
                            options
                                .where((o) => o.contains(searchText[tab]!))
                                .toList();
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'بحث...',
                                  prefixIcon: const Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged:
                                    (val) =>
                                        setState(() => searchText[tab] = val),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children:
                                    filtered.map((option) {
                                      final checked =
                                          selected[tab]?.contains(option) ??
                                          false;
                                      return AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              checked
                                                  ? Colors.blue[50]
                                                  : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color:
                                                checked
                                                    ? Colors.blueAccent
                                                    : Colors.grey[300]!,
                                            width: checked ? 2.2 : 1.2,
                                          ),
                                          boxShadow:
                                              checked
                                                  ? [
                                                    BoxShadow(
                                                      color: Colors.blue
                                                          .withOpacity(0.08),
                                                      blurRadius: 10,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ]
                                                  : [],
                                        ),
                                        child: CheckboxListTile(
                                          value: checked,
                                          onChanged: (val) {
                                            setState(() {
                                              if (val == true) {
                                                selected[tab]?.add(option);
                                              } else {
                                                selected[tab]?.remove(option);
                                              }
                                            });
                                          },
                                          title: Text(
                                            option,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          activeColor: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 2,
                                              ),
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          checkColor: Colors.white,
                                          side: BorderSide(
                                            color:
                                                checked
                                                    ? Colors.blueAccent
                                                    : Colors.grey[400]!,
                                            width: 2,
                                          ),
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                        ),
                        onPressed: () {
                          widget.onApply(selected);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'تطبيق',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
