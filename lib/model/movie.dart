class Movie {
  final String title;
  final String imageUrl;
  final String description;
  final String releaseDate;

  Movie(
      {required this.title,
      required this.imageUrl,
      required this.description,
      required this.releaseDate});
}

List<Movie> sampleMovies() {
  return [
    Movie(
      title: 'The Shawshank Redemption',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMDAyY2FhYjctNDc5OS00MDNlLThiMGUtY2UxYWVkNGY2ZjljXkEyXkFqcGc@._V1_.jpg',
      description:
          'Two imprisoned men forge an unlikely friendship over the years, forming a bond that helps them cope with the harsh realities of prison life.',
      releaseDate: '1994',
    ),
    Movie(
      title: 'The Godfather',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg',
      description:
          'The Corleone family, a powerful crime dynasty, faces upheaval when the aging patriarch prepares to hand over control to his successor.',
      releaseDate: '1972',
    ),
    Movie(
      title: 'The Godfather: Part II',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNzc1OWY5MjktZDllMi00ZDEzLWEwMGItYjk1YmRhYjBjNTVlXkEyXkFqcGc@._V1_.jpg',
      description:
          'A continuation of the Corleone family saga, this film explores the rise and fall of Michael Corleone as he becomes the head of the family.',
      releaseDate: '1974',
    ),
    Movie(
      title: 'Schindler\'s List',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNjM1ZDQxYWUtMzQyZS00MTE1LWJmZGYtNGUyNTdlYjM3ZmVmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      description:
          'A German businessman saves the lives of hundreds of Jews during the Holocaust by employing them in his factory.',
      releaseDate: '1993',
    ),
    Movie(
      title: '12 Angry Men',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BODQwOTc5MDM2N15BMl5BanBnXkFtZTcwODQxNTEzNA@@._V1_.jpg',
      description:
          'A jury of twelve men must decide the fate of a young man accused of murder, but their deliberations are fraught with tension and prejudice.',
      releaseDate: '1957',
    ),
    Movie(
      title: 'The Dark Knight',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg',
      description:
          'When a menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman, James Gordon and Harvey Dent must work together to put an end to the madness.',
      releaseDate: '2008',
    ),
    Movie(
      title: 'The Good, the Bad and the Ugly',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMWM5ZjQxM2YtNDlmYi00ZDNhLWI4MWUtN2VkYjBlMTY1ZTkwXkEyXkFqcGc@._V1_.jpg',
      description:
          'A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.',
      releaseDate: '1966',
    ),
    Movie(
      title: 'Forrest Gump',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNDYwNzVjMTItZmU5YS00YjQ5LTljYjgtMjY2NDVmYWMyNWFmXkEyXkFqcGc@._V1_.jpg',
      description:
          'The history of the United States from the 1950s to the 70s unfolds from the perspective of an Alabama man with an IQ of 75, who yearns to be reunited with his childhood sweetheart.',
      releaseDate: '1994',
    ),
    Movie(
      title: 'Pulp Fiction',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNGE4MjQ3NjgxOV5BMl5BanBnXkFtZTcwNDc3NTIyNA@@._V1_.jpg',
      description:
          'A series of interconnected stories involving a boxer, a hitman, and a mob boss in Los Angeles.',
      releaseDate: '1994',
    ),
    Movie(
      title: 'Fight Club',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMTY2NDc3Nzk3OV5BMl5BanBnXkFtZTcwMTU0NDc3NA@@._V1_.jpg',
      description:
          'An insomniac office worker forms an underground fight club with a charismatic soap salesman.',
      releaseDate: '1999',
    ),
  ];
}
