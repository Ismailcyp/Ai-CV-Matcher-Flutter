import 'package:flutter/material.dart';
import 'custom_chat.dart';
class JobsPage extends StatefulWidget {
  final List<dynamic>? aiMatches; 

  const JobsPage({super.key, this.aiMatches});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  
  final List<Map<String, dynamic>> _jobsList = [
    {"id": "1", "title": "Artificial Intelligence Intern", "company": "Hex Softwares", "location": "Remote", "type": "Internship", "match": "0", "reason": ""},
    {"id": "2", "title": "Junior Flutter Developer", "company": "TechNova Solutions", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "3", "title": "Data Analyst Intern", "company": "DataMinds Corp", "location": "Hybrid", "type": "Internship", "match": "0", "reason": ""},
    {"id": "4", "title": "Cybersecurity Analyst", "company": "SecureNet", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "5", "title": "Senior Scala Backend Engineer", "company": "DataFlow Systems", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "6", "title": "Frontend Web Developer (React.js)", "company": "Pixel Web", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "7", "title": "Python Data Scientist", "company": "AI Innovations", "location": "Remote", "type": "Contract", "match": "0", "reason": ""},
    {"id": "8", "title": "Django Backend Developer", "company": "WebTech Org", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "9", "title": "Penetration Tester", "company": "CyberShield", "location": "Remote", "type": "Contract", "match": "0", "reason": ""},
    {"id": "10", "title": "Machine Learning Engineer", "company": "DeepMind Egypt", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "11", "title": "UI/UX Designer", "company": "Creative Agency", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "12", "title": "DevOps Engineer", "company": "CloudOps Solutions", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "13", "title": "iOS Developer (Swift)", "company": "Appify", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "14", "title": "Android Developer (Kotlin)", "company": "Appify", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "15", "title": "Game Developer (Unity)", "company": "PlayStudio", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "16", "title": "Cloud Architect (AWS)", "company": "Amazon AWS", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "17", "title": "Database Administrator", "company": "DataSafe", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "18", "title": "IT Support Specialist", "company": "TechHelp", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "19", "title": "Product Manager", "company": "InnovateX", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "20", "title": "Scrum Master", "company": "AgileSoft", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "21", "title": "QA Automation Engineer", "company": "TestPro", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "22", "title": "Blockchain Developer", "company": "CryptoHub", "location": "Remote", "type": "Contract", "match": "0", "reason": ""},
    {"id": "23", "title": "Network Engineer", "company": "ConnectTel", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "24", "title": "Technical Writer", "company": "DocuTech", "location": "Remote", "type": "Part-Time", "match": "0", "reason": ""},
    {"id": "25", "title": "Full Stack Developer (MERN)", "company": "Webify", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "26", "title": "System Analyst", "company": "CorpTech", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "27", "title": "Information Security Officer", "company": "BankMisr", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "28", "title": "Site Reliability Engineer", "company": "Uptime", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "29", "title": "Big Data Engineer", "company": "DataLake", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "30", "title": "Mobile App Tester", "company": "QualityApps", "location": "Remote", "type": "Part-Time", "match": "0", "reason": ""},
    {"id": "31", "title": "AI Research Scientist", "company": "FutureTech", "location": "Remote", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "32", "title": "SEO Specialist", "company": "MarketingPro", "location": "Cairo, Egypt", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "33", "title": "ERP Consultant", "company": "EnterpriseSolutions", "location": "On-Site", "type": "Full-Time", "match": "0", "reason": ""},
    {"id": "34", "title": "Computer Vision Engineer", "company": "AutoDrive", "location": "Hybrid", "type": "Full-Time", "match": "0", "reason": ""},
  ];
  
  @override
  void initState() {
    super.initState();
    _applyAiMatches();
  }

  void _applyAiMatches() {
    if (widget.aiMatches == null || widget.aiMatches!.isEmpty) return;

    setState(() {
      for (var localJob in _jobsList) {
        String localTitle = localJob['title'].toString().toLowerCase();

        var geminiMatch = widget.aiMatches!.cast<Map<String, dynamic>>().firstWhere(
          (aiData) {
            String aiTitle = aiData['job_title'].toString().toLowerCase();
            return localTitle.contains(aiTitle) || aiTitle.contains(localTitle);
          },
          orElse: () => {}, 
        );

        if (geminiMatch.isNotEmpty) {
          localJob['match'] = geminiMatch['match_percentage'].toString();
          localJob['reason'] = geminiMatch['reason'] ?? "You have the right skills for this role!";
        }
      }

      // Sort descending by match percentage
      _jobsList.sort((a, b) {
        int matchA = int.tryParse(a['match'].toString().replaceAll('%', '')) ?? 0;
        int matchB = int.tryParse(b['match'].toString().replaceAll('%', '')) ?? 0;
        return matchB.compareTo(matchA); 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.aiMatches != null ? "Your Top Matches" : "All Opportunities",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 77, 6, 6), 
              Color.fromARGB(255, 17, 20, 29), 
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: _jobsList.length,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final job = _jobsList[index];
                
                int matchScore = int.tryParse(job["match"].toString().replaceAll('%', '')) ?? 0;
                bool isHighlyMatched = widget.aiMatches != null && matchScore >= 80;

                return _buildJobContainer(job, isHighlyMatched, matchScore);
              },
            ),
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, 
            backgroundColor: Colors.transparent,
            builder: (context) => Padding(
              // pushes the chat box UP when the keyboard opens
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

  Widget _buildJobContainer(Map<String, dynamic> job, bool isHighlighted, int matchScore) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted ? Colors.greenAccent : const Color.fromARGB(60, 255, 255, 255), 
          width: isHighlighted ? 2.0 : 1.0,
        ),
      ),
      
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent), 
        child: ExpansionTile(
          iconColor: const Color.fromARGB(255, 18, 180, 123),
          collapsedIconColor: Colors.white70,
          tilePadding: const EdgeInsets.all(20.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  
                  if (matchScore > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isHighlighted ? Colors.greenAccent.withOpacity(0.2) : Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Match $matchScore%",
                        style: TextStyle(
                          color: isHighlighted ? Colors.greenAccent : Colors.white70, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 12
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              
              Text(
                job["company"]!,
                style: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 16), 
              ),
              
              const SizedBox(height: 15),
              
              
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white60, size: 16),
                  const SizedBox(width: 5),
                  Text(job["location"]!, style: const TextStyle(color: Colors.white60)),
                  const SizedBox(width: 20),
                  const Icon(Icons.work, color: Colors.white60, size: 16),
                  const SizedBox(width: 5),
                  Text(job["type"]!, style: const TextStyle(color: Colors.white60)),
                ],
              ),
            ],
          ),
          
      children: [
            // 1. The AI Reason (Shows if it exists)
            if (job['reason'] != null && job['reason'].toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.new_releases_outlined, color: Color.fromARGB(255, 26, 255, 0), size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          job['reason']!,
                          style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            // "Apply Now" Button
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: SizedBox(
                width: double.infinity, 
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Application successfully sent for ${job['title']}! (Applied With Your CV !) "),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isHighlighted 
                        ? Colors.greenAccent 
                        : Colors.blueAccent, // Color changes based on if it's a top match!
                    foregroundColor: Colors.black, 
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Apply Now",
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}