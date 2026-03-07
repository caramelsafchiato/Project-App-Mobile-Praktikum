mixin DapatMengajar {
  void mengajar() {
    print("Sedang memberikan materi di kelas...");
  }
}

mixin MemilikiJabatan {
  String? jabatan;
  void tampilkanJabatan() {
    print("Jabatan: ${jabatan ?? 'Staf'}");
  }
}

mixin DapatRiset {
  void melakukanRiset() {
    print("Sedang melakukan penelitian di laboratorium...");
  }
}