import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Pizza({
    required this.id,
    required this.name,
    required this.image
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Pizza> pizzas = [
    Pizza(
      id: '0', 
      name: 'Margarita', 
      image: Image.asset('images/margarita.png')
      ),
    Pizza(
      id: '1', 
      name: 'Pecado Carnal', 
      image: Image.asset('images/pecado.png'))
  ];
}