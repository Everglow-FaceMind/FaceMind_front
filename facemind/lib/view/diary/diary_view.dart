import 'package:facemind/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiaryView extends StatefulWidget {
  // 페이지에 표시할 날짜 정보
  final DateTime date;

  const DiaryView({
    super.key,
    required this.date,
  });
  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = widget.date;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.whiteColor,
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                '내 일기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              //구분선
              height: 10.0,
              color: Colors.grey[300],
              thickness: 1,
            ),
            SizedBox(height: 10),

            //날짜 표시
            _displayDate,

            // 일기 내용 여기에
          ],
        ),
      ),
    );
  }

  Widget get _displayDate {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.date.year}',
          style: Theme.of(context).textTheme.labelMedium?.apply(
                color: GlobalColors.mainColor,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  date = date.subtract(const Duration(days: 1));
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
            SizedBox(
              width: 200,
              child: Center(
                child: Text(
                  '${widget.date.month}월 ${widget.date.day}일, ${DateFormat('E', 'ko_KR').format(widget.date)}요일',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  date = date.add(const Duration(days: 1));
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
