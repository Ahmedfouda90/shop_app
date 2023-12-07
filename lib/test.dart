// Import necessary files

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(CategoriesService(Dio())),
      child: YourWidgetContent(),
    );
  }
}*/

class YourWidgetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return CircularProgressIndicator();
        } else if (state is CategoriesLoaded) {
          //           return YourCategoriesWidget(categoriesData: state.categoriesData);
          return YourCategoriesWidget(categoriesData: state.categoriesData);
        } else if (state is CategoriesError) {
          return Text("Error: ${state.errorMessage}");
        } else {
          return Container(); // Initial state
        }
      },
    );
  }
}

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final Map<String, dynamic> categoriesData;

  CategoriesLoaded(this.categoriesData);

  @override
  List<Object> get props => [categoriesData];
}

class CategoriesError extends CategoriesState {
  final String errorMessage;

  CategoriesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesService _categoriesService;

  CategoriesCubit(this._categoriesService) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final categoriesData = await _categoriesService.getCategories();
      emit(CategoriesLoaded(categoriesData));
    } catch (error) {
      emit(CategoriesError(error.toString()));
    }
  }
}

class CategoriesService {
  final Dio _dio;

  CategoriesService(this._dio);

  Future<Map<String, dynamic>> getCategories() async {
    try {
      final response =
          await _dio.get('https://student.valuxapps.com/api/categories');
      return response.data;
    } catch (error) {
      throw Exception("Failed to load categories: $error");
    }
  }
}

class YourCategoriesWidget extends StatelessWidget {
  final Map<String, dynamic> categoriesData;

  const YourCategoriesWidget({Key? key, required this.categoriesData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = categoriesData['data']['data'] as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryItem(
                id: category['id'],
                name: category['name'],
                imageUrl: category['image'],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
