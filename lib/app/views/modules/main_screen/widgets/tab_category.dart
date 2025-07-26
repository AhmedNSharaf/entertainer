import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class TopCategoryList extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"icon": "https://img.icons8.com/color/48/faq.png", "label": "FAQ"},
    {
      "icon": "https://img.icons8.com/color/48/summer.png",
      "label": "Summer Escapes",
    },
    {
      "icon": "https://img.icons8.com/color/48/pizza.png",
      "label": "All You Can Eat",
    },
    {"icon": "https://img.icons8.com/color/48/pizza.png", "label": "Glow Up"},
    {"icon": "https://img.icons8.com/color/48/sale.png", "label": "New Offers"},
  ];

  final Map<String, List<Map<String, String>>> stories = {
    "FAQ": [
      {
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&auto=format&fit=crop",
        "text": "FAQ Story 1",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?w=400&auto=format&fit=crop",
        "text": "FAQ Story 2",
      },
    ],
    "Summer Escapes": [
      {
        "image":
            "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?w=400&auto=format&fit=crop",
        "text": "Summer Escape 1",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&auto=format&fit=crop",
        "text": "Summer Escape 2",
      },
    ],
    "All You Can Eat": [
      {
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&auto=format&fit=crop",
        "text": "Eat Story 1",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&auto=format&fit=crop",
        "text": "Eat Story 2",
      },
    ],
    "Glow Up": [
      {
        "image":
            "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=400&auto=format&fit=crop",
        "text": "Glow Up Story 1",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&auto=format&fit=crop",
        "text": "Glow Up Story 2",
      },
    ],
    "New Offers": [
      {
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&auto=format&fit=crop",
        "text": "New Offer 1",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=400&auto=format&fit=crop",
        "text": "New Offer 2",
      },
    ],
  };

  TopCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final label = items[index]["label"]!;
          return GestureDetector(
            onTap: () {
              final categories = items.map((e) => e["label"]!).toList();
              final allStories =
                  categories.map((cat) => stories[cat] ?? []).toList();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (_) => CategoryStoriesScreen(
                        categories: categories,
                        allStories: allStories,
                        initialCategoryIndex: index,
                      ),
                ),
              );
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange[100],
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue[50],
                    backgroundImage: NetworkImage(items[index]["icon"]!),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryStoriesScreen extends StatefulWidget {
  final List<String> categories;
  final List<List<Map<String, String>>> allStories;
  final int initialCategoryIndex;

  const CategoryStoriesScreen({
    super.key,
    required this.categories,
    required this.allStories,
    required this.initialCategoryIndex,
  });

  @override
  State<CategoryStoriesScreen> createState() => _CategoryStoriesScreenState();
}

class _CategoryStoriesScreenState extends State<CategoryStoriesScreen> {
  late int currentCategoryIndex;
  late StoryController _storyController;
  late PageController _pageController;

  List<Map<String, String>> get currentStories =>
      widget.allStories[currentCategoryIndex];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialCategoryIndex);
    currentCategoryIndex = widget.initialCategoryIndex;
    _storyController = StoryController();
  }

  void _showShareSheet(String storyText, String storyUrl) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.grey[900],
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Story',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ShareIconButton(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    color: Color(0xFF1877F3),
                    onTap: () async {
                      final facebookUrl = Uri.encodeFull(
                        "https://www.facebook.com/sharer/sharer.php?u=$storyUrl",
                      );
                      if (await canLaunchUrl(Uri.parse(facebookUrl))) {
                        await launchUrl(
                          Uri.parse(facebookUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 32),
                  _ShareIconButton(
                    icon: FontAwesomeIcons.whatsapp,
                    label: 'WhatsApp',
                    color: Color(0xFF25D366),
                    onTap: () async {
                      final whatsappUrl = Uri.encodeFull(
                        "https://wa.me/?text=$storyUrl",
                      );
                      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                        await launchUrl(
                          Uri.parse(whatsappUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.white),
                title: const Text(
                  'Share via...',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Share.share(storyUrl),
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.white),
                title: const Text(
                  'Copy link',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: storyUrl));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _storyController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.categories.length,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                currentCategoryIndex = index;
                _storyController.play(); // لا تعمل dispose
                setState(() {});
              },
              itemBuilder: (context, index) {
                final stories = widget.allStories[index];
                return Container(
                  key: ValueKey(index),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.1416),
                    child: StoryView(
                      storyItems:
                          stories
                              .map(
                                (story) => StoryItem.pageImage(
                                  url: story['image']!,
                                  controller: _storyController,
                                  caption: null,
                                  imageFit: BoxFit.cover,
                                ),
                              )
                              .toList(),

                      controller: _storyController,
                      onComplete: () {
                        if (currentCategoryIndex <
                            widget.categories.length - 1) {
                          currentCategoryIndex++;
                          _pageController.animateToPage(
                            currentCategoryIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          _storyController.play();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      onVerticalSwipeComplete: (direction) {
                        if (direction == Direction.down) {
                          Navigator.of(context).pop();
                        }
                      },
                      inline: false,
                      repeat: false,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          final story = currentStories.first;
                          _showShareSheet(
                            story['text'] ?? '',
                            story['image'] ?? '',
                          );
                        },
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        widget.categories[currentCategoryIndex],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                      const SizedBox(width: 8),

                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Icon(
                            Icons.category,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 24,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
