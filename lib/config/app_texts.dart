class AppTexts {
  static final Map<String, Map<String, String>> _texts = {
    'no': {
      'appTitle': 'Yatzy Scorecard',
      'appSubtitle': 'En enkel digital poengblokk',

      'startYatzy': 'Start Yatzy',
      'startMaxiYatzy': 'Start Maxi Yatzy',
      'continueGame': 'Fortsett spill',
      'statistics': 'Statistikk',
      'settings': 'Innstillinger',

      'newYatzyGame': 'Nytt Yatzy-spill',
      'newMaxiGame': 'Nytt Maxi Yatzy-spill',

      'addPlayer': 'Legg til spiller',
      'startGame': 'Start spill',
      'creating': 'Oppretter...',

      'score': 'Poeng',
      'save': 'Lagre',
      'cancel': 'Avbryt',

      'game': 'Spill',
      'activePlayer': 'Aktiv spiller',

      'upperSection': 'Øvre del',
      'lowerSection': 'Nedre del',
      'extraThrows': 'Ekstra kast',

      'upperTotal': 'Sum øvre del',
      'lowerTotal': 'Sum nedre del',
      'bonus': 'Bonus',
      'total': 'Total',

      'results': 'Resultat',
      'winner': 'Vinner',
      'playAgain': 'Spill igjen',
      'backToMenu': 'Tilbake til meny',

      'savedGames': 'Fortsett spill',
      'noSavedGames': 'Ingen lagrede spill',

      'deleteGame': 'Slett spill',
      'deleteGameConfirm': 'Er du sikker på at du vil slette dette spillet?',
      'delete': 'Slett',

      'finished': 'Ferdig',
      'inProgress': 'Pågår',

      'players': 'spillere',
      'player': 'spiller',

      'statisticsEmpty': 'Ingen statistikk tilgjengelig enda.',
      'gamesPlayed': 'Antall spill',
      'bestScore': 'Beste score',
      'average': 'Gjennomsnitt',

      'perPlayer': 'Per spiller',
      'wins': 'Seiere',

      'language': 'Språk',

      'aboutApp': 'Om appen',
      'versionText': 'Versjon 1.0',
      'aboutDescription':
          'En enkel digital poengblokk for Yatzy og Maxi Yatzy.',

      'norwegian': 'Norsk',
      'english': 'English',

      'rules': 'Regler',
      'yatzyRules': 'Yatzy-regler',
      'maxiYatzyRules': 'Maxi Yatzy-regler',
      'showRules': 'Vis regler',
      'ruleInfoTitle': 'Regel',
    },

    'en': {
      'appTitle': 'Yatzy Scorecard',
      'appSubtitle': 'A simple digital scorecard',

      'startYatzy': 'Start Yatzy',
      'startMaxiYatzy': 'Start Maxi Yatzy',
      'continueGame': 'Continue Game',
      'statistics': 'Statistics',
      'settings': 'Settings',

      'newYatzyGame': 'New Yatzy Game',
      'newMaxiGame': 'New Maxi Yatzy Game',

      'addPlayer': 'Add Player',
      'startGame': 'Start Game',
      'creating': 'Creating...',

      'score': 'Score',
      'save': 'Save',
      'cancel': 'Cancel',

      'game': 'Game',
      'activePlayer': 'Active player',

      'upperSection': 'Upper section',
      'lowerSection': 'Lower section',
      'extraThrows': 'Extra throws',

      'upperTotal': 'Upper total',
      'lowerTotal': 'Lower total',
      'bonus': 'Bonus',
      'total': 'Total',

      'results': 'Results',
      'winner': 'Winner',
      'playAgain': 'Play Again',
      'backToMenu': 'Back to Menu',

      'savedGames': 'Continue Game',
      'noSavedGames': 'No saved games',

      'deleteGame': 'Delete game',
      'deleteGameConfirm': 'Are you sure you want to delete this game?',
      'delete': 'Delete',

      'finished': 'Finished',
      'inProgress': 'In progress',

      'players': 'players',
      'player': 'player',

      'statisticsEmpty': 'No statistics available yet.',
      'gamesPlayed': 'Games played',
      'bestScore': 'Best score',
      'average': 'Average',

      'perPlayer': 'Per player',
      'wins': 'Wins',

      'language': 'Language',

      'aboutApp': 'About the app',
      'versionText': 'Version 1.0',
      'aboutDescription':
          'A simple digital scorecard for Yatzy and Maxi Yatzy.',

      'norwegian': 'Norwegian',
      'english': 'English',

      'rules': 'Rules',
      'yatzyRules': 'Yatzy rules',
      'maxiYatzyRules': 'Maxi Yatzy rules',
      'showRules': 'Show rules',
      'ruleInfoTitle': 'Rule',
    },
  };

  static String t(String languageCode, String key) {
    return _texts[languageCode]?[key] ?? _texts['no']![key] ?? key;
  }
}