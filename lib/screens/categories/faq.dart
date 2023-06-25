import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class faq extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question:
          '1. How do I access the online learning platform and other digital resources provided by the institute?',
      answer:
          'To access the online learning platform and other digital resources provided by the institute, you will receive your own user credentials (username and password). These credentials will allow you to log in to the platform and access the resources. If you have any questions or need assistance, please reach out to the institute\'s support team.',
    ),
    FAQItem(
      question:
          '2. How can I apply for financial aid or scholarships to help with my tuition fees?',
      answer:
          'To apply for financial aid or scholarships at SLIATE, including the Mahapola Scholarship for students from low-income backgrounds or non-government employee parents, you can obtain the scholarship application form from the institute\'s scholarship office or website. Complete the form and submit it with the required documents as specified. The scholarship office will review your application and determine your eligibility. For more details, contact the scholarship office or visit the SLIATE website.',
    ),
    FAQItem(
      question:
          '3. Is there a library on ATI, and how can I borrow books or access digital resources?',
      answer:
          'Yes, ATI has a library where you can borrow books and access resources. SLIATE provides an online Learning Management System (LMS) for academic notes. To borrow books, present your student ID at the library\'s circulation desk. For digital resources, log in to the LMS using your credentials. Library staff and IT support are available to assist you.',
    ),
    FAQItem(
      question:
          '4. How do I access the online learning platform and other digital resources provided by the institute?',
      answer:
          'To access the online learning platform and other digital resources provided by the institute, you will receive your own user credentials (username and password). These credentials will allow you to log in to the platform and access the resources. If you have any questions or need assistance, please reach out to the institute\'s support team.',
    ),
    FAQItem(
      question:
          '5. How can I apply for financial aid or scholarships to help with my tuition fees?',
      answer:
          'To apply for financial aid or scholarships at SLIATE, including the Mahapola Scholarship for students from low-income backgrounds or non-government employee parents, you can obtain the scholarship application form from the institute\'s scholarship office or website. Complete the form and submit it with the required documents as specified. The scholarship office will review your application and determine your eligibility. For more details, contact the scholarship office or visit the SLIATE website.',
    ),
    FAQItem(
      question:
          '6. Is there a library on ATI, and how can I borrow books or access digital resources?',
      answer:
          'Yes, ATI has a library where you can borrow books and access resources. SLIATE provides an online Learning Management System (LMS) for academic notes. To borrow books, present your student ID at the library\'s circulation desk. For digital resources, log in to the LMS using your credentials. Library staff and IT support are available to assist you.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_clr,
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Text(
                  'Frequently Asked Questions (FAQ)',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: faqItems.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    title: Text(
                      faqItems[index].question,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          textAlign: TextAlign.justify,
                          faqItems[index].answer,
                          style: TextStyle(fontSize: 14.0, color: text_clr),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
