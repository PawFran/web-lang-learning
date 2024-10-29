CREATE TABLE latin_conjugations (
    name TEXT PRIMARY KEY NOT NULL
);
ALTER TABLE latin_conjugations ADD CONSTRAINT latin_conjugations_name_key UNIQUE(name);
CREATE TABLE latin_declensions (
    name TEXT PRIMARY KEY NOT NULL
);
ALTER TABLE latin_declensions ADD CONSTRAINT latin_declensions_name_key UNIQUE(name);
CREATE TABLE languages (
    name TEXT PRIMARY KEY NOT NULL
);
ALTER TABLE languages ADD CONSTRAINT languages_name_key UNIQUE(name);
CREATE TABLE parts_of_speech (
    name TEXT PRIMARY KEY NOT NULL
);
ALTER TABLE parts_of_speech ADD CONSTRAINT parts_of_speech_name_key UNIQUE(name);
CREATE TABLE words (
    lang TEXT NOT NULL,
    word_id INT NOT NULL,
    part_of_speech TEXT NOT NULL,
    PRIMARY KEY(lang, word_id, part_of_speech),
    FOREIGN KEY (part_of_speech) REFERENCES parts_of_speech (name) 
);
CREATE TABLE latin_verbs (
    id INT DEFAULT null PRIMARY KEY,
    base_word TEXT NOT NULL,
    base_word_acc TEXT NOT NULL,
    infinite TEXT NOT NULL,
    infinite_acc TEXT NOT NULL,
    perfect TEXT NOT NULL,
    perfect_acc TEXT NOT NULL,
    supine TEXT DEFAULT null,
    supine_acc TEXT DEFAULT null,
    additional_info TEXT DEFAULT null,
    conjugation TEXT NOT NULL,
    UNIQUE(base_word_acc, infinite_acc, perfect_acc, supine_acc),
    FOREIGN KEY (conjugation) REFERENCES latin_conjugations (name) 
);
CREATE TABLE latin_translations (
    id INT DEFAULT null PRIMARY KEY,
    text TEXT NOT NULL,
    example TEXT DEFAULT null,
    associated_case TEXT DEFAULT null
);
ALTER TABLE latin_translations ADD CONSTRAINT latin_translations_text_key UNIQUE(text);
CREATE TABLE genres (
    name TEXT PRIMARY KEY NOT NULL
);
ALTER TABLE genres ADD CONSTRAINT genres_name_key UNIQUE(name);
CREATE TABLE latin_nouns (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL,
    gen TEXT NOT NULL,
    gen_acc TEXT NOT NULL,
    declension TEXT NOT NULL,
    genre TEXT NOT NULL,
    only_pl BOOLEAN NOT NULL,
    FOREIGN KEY (genre) REFERENCES genres (name) ,
    FOREIGN KEY (declension) REFERENCES latin_declensions (name) ,
    UNIQUE(base_acc, gen_acc)
);
CREATE TABLE latin_words_translations_mapping (
    word_id INT DEFAULT null,
    translation_id INT DEFAULT null,
    part_of_speech TEXT DEFAULT null,
    PRIMARY KEY(word_id, translation_id, part_of_speech),
    FOREIGN KEY (part_of_speech) REFERENCES parts_of_speech (name) 
);
CREATE TABLE latin_adverbs (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL
);
ALTER TABLE latin_adverbs ADD CONSTRAINT latin_adverbs_base_acc_key UNIQUE(base_acc);
CREATE TABLE latin_prepositions (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL
);
ALTER TABLE latin_prepositions ADD CONSTRAINT latin_prepositions_base_acc_key UNIQUE(base_acc);
CREATE TABLE latin_conjunctions (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL
);
ALTER TABLE latin_conjunctions ADD CONSTRAINT latin_conjunctions_base_acc_key UNIQUE(base_acc);
CREATE TABLE latin_pronouns (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL
);
ALTER TABLE latin_pronouns ADD CONSTRAINT latin_pronouns_base_acc_key UNIQUE(base_acc);
CREATE TABLE latin_adjectives (
    id INT DEFAULT null PRIMARY KEY,
    base TEXT NOT NULL,
    base_acc TEXT NOT NULL
);
ALTER TABLE latin_adjectives ADD CONSTRAINT latin_adjectives_base_acc_key UNIQUE(base_acc);
CREATE TABLE translation_results (
    id INT DEFAULT null PRIMARY KEY,
    user_name TEXT NOT NULL,
    session_id INT NOT NULL,
    lang TEXT NOT NULL,
    word_pl TEXT NOT NULL,
    correct_translation TEXT NOT NULL,
    user_answer TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    answer_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    FOREIGN KEY (lang) REFERENCES languages (name) 
);
ALTER TABLE translation_results ADD CONSTRAINT translation_results_session_id_key UNIQUE(session_id);
