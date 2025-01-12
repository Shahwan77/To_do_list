import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/firestor.dart';
import 'package:flutter_to_do_list/main.dart';
import 'package:flutter_to_do_list/model/notes_model.dart';
import 'package:flutter_to_do_list/screen/edit_screen.dart';

class Task_Widget extends StatefulWidget {
  Note _note;
  Task_Widget(this._note, {super.key});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}


class _Task_WidgetState extends State<Task_Widget> {

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Firestore_Datasource().delet_note(widget._note.id) ;
              Navigator.pop(context); // Close the dialog
              setState(() {}); // Refresh the UI
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDon;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Container(
        width: double.infinity,
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              // image
              imageee(),
              SizedBox(width: 25.w),
              // title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget._note.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                            color: isDone ? Colors.grey : Colors.black, // Optional: Change color
                          ),
                        ),
                        Row(
                          children: [
                            // Checkbox
                            Checkbox(
                              activeColor: custom_green,
                              value: isDone,
                              onChanged: (value) {
                                setState(() {
                                  isDone = !isDone;
                                });
                                Firestore_Datasource().isdone(widget._note.id, isDone);
                              },
                            ),
                            // Delete button (Visible only when the checkbox is ticked)
                            if (isDone)
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _confirmDelete(); // Show confirmation dialog
                                },
                              ),
                          ],
                        ),
                      ],
                    ),

                    Text(
                      widget._note.subtitle,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400),
                    ),
                    Spacer(),
                    edit_time()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget edit_time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 87.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: custom_green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              child: Row(
                children: [
                  Image.asset('images/icon_time.png'),
                  SizedBox(width: 10.w),
                  Text(
                    widget._note.time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20.w),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Edit_Screen(widget._note),
              ));
            },
            child: Container(
              width: 84.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: Color(0xffE2F6F1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 4.h
                  ,
                ),
                child: Row(
                  children: [
                    Image.asset('images/icon_edit.png'),
                    SizedBox(width: 10.w),
                    Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageee() {
    return Container(
      height: 120.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/${widget._note.image}.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
