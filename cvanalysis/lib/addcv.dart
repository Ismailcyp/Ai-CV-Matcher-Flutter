import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'jopspage.dart';
import 'custom_chat.dart';
import 'main.dart';

class AddCvPage extends StatefulWidget {
  const AddCvPage({Key? key}) : super(key: key);

  @override
  State<AddCvPage> createState() => _AddCvPageState();
}

class _AddCvPageState extends State<AddCvPage> {

  String? _fileName;
  String? _extractedText;
  bool _isProcessing = false;


Future<void> _analyzeCVWithGemini(String cvText) async {
  setState(() {
    _isProcessing = true;
  });

  try {
    const String apiKey = 'AIzaSyBhtT2F-G1wDYnwsqjWxo3EZkia-o2TtD8'; 



    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );

    final prompt = '''
    You are a backend job matching API. Compare the provided CV text against our available jobs: [Artificial Intelligence, Flutter, Data Analyst, Cybersecurity Analyst,Backend Engineer,Python,Penetration Tester,DevOps Engineer,UI/UX Designer,Android Developer,iOS Developer,Technical Writer,Full Stack Developer,Mobile App Tester,AI Research Scientist,Computer Vision Engineer"]. 
    Calculate a compatibility percentage for the top 5 matches. 
    You must return ONLY a valid, raw JSON array of objects with the keys 'job_title', 'match_percentage', and 'reason'.
    
    Here is the CV Text:
    $cvText 
    ''';
    
    final response = await model.generateContent([Content.text(prompt)]);
    final String aiText = response.text ?? "[]";


    
    final List<dynamic> matches = jsonDecode(aiText);

    if (mounted) {
      setState(() => _isProcessing = false);
      Navigator.push(
        context,
        createCustomRoute(
           JobsPage(aiMatches: matches),
        ),
      );
    }

  } catch (e) {
    debugPrint("❌ Error: $e");
    if (mounted) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }
}


  Future<void> _pickAndProcessCV() async {

    setState(() {
      _isProcessing = true;
    });

    try {

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {

        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;

        final List<int> bytes = await File(filePath).readAsBytes();

        final PdfDocument document = PdfDocument(inputBytes: bytes);

        String extractedText = PdfTextExtractor(document).extractText();

        document.dispose();

        setState(() {
          _fileName = fileName;
          _extractedText = extractedText;
          _isProcessing = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("CV processed successfully!"),
            ),
          );
        }

      } else {

        setState(() {
          _isProcessing = false;
        });

      }

    } catch (e) {

      setState(() {
        _isProcessing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to read PDF: $e"),
          ),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI CV Matcher',
          style: TextStyle(
              fontSize: 27,
              color: Color.fromARGB(255, 7, 88, 154)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade50,
              ),
              child: Column(
                
                children: [
      
                  Icon(
                    _fileName == null
                        ? Icons.picture_as_pdf
                        : Icons.check_circle,
                    size: 50,
                    color: _fileName == null
                        ? Colors.red.shade400
                        : Colors.green.shade400,
                  ),
      
                  const SizedBox(height: 16),
      
                  if (_isProcessing)
                    const CircularProgressIndicator()
                  else
                    Text(
                      _fileName ?? "No CV uploaded yet",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
      
                  const SizedBox(height: 16),
      
                  OutlinedButton.icon(
                    onPressed:
                          _isProcessing ? null : _pickAndProcessCV,
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                        _fileName == null
                            ? "Select PDF"
                            : "Change PDF"),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 24),
      

            ElevatedButton(
              onPressed: (_extractedText == null || _isProcessing)
                  ? null
                  : () => _analyzeCVWithGemini(_extractedText!),    
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width:20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Find My Fit',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
      
            const SizedBox(height: 16),
      

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  createCustomRoute(
                      
                          const JobsPage()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Skip for now, view all jobs',
                style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline),
              ),
            ),
      
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, 
            backgroundColor: Colors.transparent,
            builder: (context) => Padding(

              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65, // Takes up 65% of screen
                child: const CustomChatBox(),
              ),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 145, 4, 4),
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
    );
  }
}
