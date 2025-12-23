import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List bookList = [
    [
      "The Wager",
      "https://m.media-amazon.com/images/I/81iR3k0Wg6L._SL1500_.jpg",
    ],
    [
      "Atomic habits",
      "https://m.media-amazon.com/images/I/91bYsX41DVL._SL1500_.jpg",
    ],
    ["Dog Man", "https://m.media-amazon.com/images/I/81XqX-wnkIL._SL1500_.jpg"],
    ["Outlive", "https://m.media-amazon.com/images/I/71gpe7LeGSL._SL1500_.jpg"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(209, 215, 238, 1),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Hi, Isha Savaliya",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          card1(const Color(0xFFd5fffd)),
                          card1(const Color(0xFFdce6ff)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Continue Reading",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "See More",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                    SizedBox(
                      height: 186,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bookList.length,
                        itemBuilder: (context, index) =>
                            card2(bookList[index][0], bookList[index][1]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Book of the Day",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf3f2f3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://m.media-amazon.com/images/I/81FummIc2eL._SL1500_.jpg",
                                width: 150,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "It Starts with us",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Colleen Hoover",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "\$40  \$60",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "This Week",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "See More",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                    Row(
                      children: [
                        card3(
                          "https://m.media-amazon.com/images/I/81Fw7hPAROL._SL1500_.jpg",
                          "Hello Beautiful",
                        ),
                        card3(
                          "https://m.media-amazon.com/images/I/818B6S6B-bL._SL1500_.jpg",
                          "Daisy Jones",
                        ),
                      ],
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

  card1(Color backColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Get Ramadan Offer 2023",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 5),
          const Text(
            "25% on All Islamic Books",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: const Size.fromWidth(130),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text(
              "Read More",
              style: TextStyle(
                color: Colors.white, // Make sure the text color is contrasting
              ),
            ),
          ),
        ],
      ),
    );
  }

  card2(String bookName, String imgPath) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 10, 10),
      width: 90,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imgPath, width: 90),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 71,
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: const Row(
                  children: [
                    Icon(Icons.bolt, size: 16),
                    Text(
                      "Stream",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(bookName, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  card3(String imgPath, String bookName) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: (MediaQuery.of(context).size.width - 35) * 0.5,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgPath,
              width: (MediaQuery.of(context).size.width - 35) * 0.22,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFfed6c6),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                child: const Text(
                  "New Arrival",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 35) * 0.24,
                child: Text(bookName, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
