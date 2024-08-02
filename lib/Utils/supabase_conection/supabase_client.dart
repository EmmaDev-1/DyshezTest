import 'package:supabase_flutter/supabase_flutter.dart';

//CREDENCIALES SUPABASE
class SupabaseService {
  static const String supabaseUrl = 'https://atnwxkxndtmbbdqpcctb.supabase.co';
  static const String supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bnd4a3huZHRtYmJkcXBjY3RiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE5NTA2MDEsImV4cCI6MjAzNzUyNjYwMX0.FXwunhrCyxIHnwgYJDfkN6-D5ZnaY84GxZxLEWALYJA';

  static final SupabaseClient supabaseClient =
      SupabaseClient(supabaseUrl, supabaseKey);
}
