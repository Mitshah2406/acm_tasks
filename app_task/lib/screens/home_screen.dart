import 'package:app_task/constants/app_constants.dart';
import 'package:app_task/models/Movie.dart';
import 'package:app_task/providers/movie_provider.dart';
import 'package:app_task/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(movieProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Top Movies",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 280,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: 5,
              //       itemBuilder: (ctx, index) =>
              //        Card(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(24),
              //             ),
              //             color: Colors.white,
              //             elevation: 0,
              //             clipBehavior: Clip.hardEdge,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(16)),
              //                   clipBehavior: Clip.hardEdge,
              //                   child: Image.asset(
              //                     "assets/images/jawan.jpeg",
              //                     width: 350,
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 12,
              //                 ),
              //                 const Text(
              //                   "   Jawan",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 22),
              //                   textAlign: TextAlign.start,
              //                 ),
              //                 Text(
              //                   "     Action",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.normal,
              //                       fontSize: 14,
              //                       color: Colors.black45.withOpacity(0.5)),
              //                   textAlign: TextAlign.start,
              //                 )
              //               ],
              //             ),
              //           )),
              // ),
              child: data.when(
                data: (movies) {
                  // List myData = movies.map((e) => e).toList();
                  List<Movie> myData = movies
                      .where((element) =>
                          movies.indexOf(element) != 2 &&
                          movies.indexOf(element) != 1)
                      .toList();

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: myData.map((data) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  MovieDetailsScreen(movie: data)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          color: Colors.white,
                          elevation: 0,
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  "${AppConstants.imageUrl}${data.posterPath}",
                                  width: 320,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "   ${data.title}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  "     Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.black45.withOpacity(0.5)),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  // textWidthBasis: TextWidthBasis.parent,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                error: (error, stackTrace) => Text(
                  error.toString(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            // Row(
            //   children: [
            //     Text(
            //       "Top Shows",
            //       textAlign: TextAlign.left,
            //       style: Theme.of(context)
            //           .textTheme
            //           .titleLarge!
            //           .copyWith(fontWeight: FontWeight.bold),
            //     ),
            //     const Icon(Icons.arrow_forward_ios),
            //   ],
            // ),
            // const SizedBox(
            //   height: 24,
            // ),
            // SizedBox(
            //   height: 350,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 5,
            //       itemBuilder: (ctx, index) => Padding(
            //             padding: const EdgeInsets.only(right: 12),
            //             child: Card(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(24),
            //               ),
            //               color: Colors.white,
            //               elevation: 0,
            //               clipBehavior: Clip.hardEdge,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(16)),
            //                     clipBehavior: Clip.hardEdge,
            //                     child: Image.asset(
            //                       "assets/images/jawan.jpeg",
            //                       width: 180,
            //                       height: 270,
            //                       fit: BoxFit.fill,
            //                     ),
            //                   ),
            //                   const SizedBox(
            //                     height: 12,
            //                   ),
            //                   const Text(
            //                     "   Jawan",
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold, fontSize: 22),
            //                     textAlign: TextAlign.start,
            //                   ),
            //                   Text(
            //                     "     Action",
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.normal,
            //                         fontSize: 14,
            //                         color: Colors.black45.withOpacity(0.5)),
            //                     textAlign: TextAlign.start,
            //                   )
            //                 ],
            //               ),
            //             ),
            //           )),
            // ),
          ],
        ),
      ),
    );
  }
}
