import 'package:flutter/material.dart';

const apiUrl = String.fromEnvironment('baseUrl', defaultValue: 'https://10.0.2.2:7260/api');
// const apiUrl = String.fromEnvironment('baseUrl', defaultValue: 'https://localhost:7260/api');

const stripePublishKey = String.fromEnvironment('stripePublishKey',
    defaultValue:
        'pk_test_51OMAmTKCHXOdig4eYW9MsOU1wQnnXjNLpe4dAMaRjKjVEQ4cXcPhPJgGQrzPd0II0lyqGCGUZZVkEaF1mgBVVJdS00znFR39AN');
const stripeSecretKey = String.fromEnvironment('stripeSecretKey',
    defaultValue:
        'sk_test_51OMAmTKCHXOdig4eg7XK6r2imdsmRjbumTakSbIFqJhWr3r5W0xw8bX8VCZDarJxh3vfEPSnIIBdEkWlxGwekXbG00JwagiOFp');

Color get primary => Color(0XFF12B422);
Color get teal => Colors.teal;
Color get white => Colors.white;
Color get black => Colors.black;
