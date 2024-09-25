# Elektrisko velosipēdu rezervācijas sistēma

Šī web sistēma ļauj veidot uzņēmuma elektrisko velosipēdu lietošanas grafiku darbiniekiem, piesaistot elektriskos velosipēdus darbiniekiem uz noteiktu laiku.

## Tehnoloģijas

- Ruby 3.3.0
- Ruby on Rails 7.1.4
- PostgreSQL
- Minitest un Capybara testēšanai
- TailwindCSS stiliem
- ShadcnUI komponentiem

## Uzstādīšana

1. Klonējiet repozitoriju:
   ```
   git clone https://gitlab.com/your-username/elektrisko-velosipedu-rezervacijas-sistema.git
   cd elektrisko-velosipedu-rezervacijas-sistema
   ```

2. Instalējiet nepieciešamās gem pakotnes:
   ```
   bundle install
   ```

3. Izveidojiet datubāzi un izpildiet migrācijas:
   ```
   rails db:create db:migrate
   ```

4. (Pēc izvēles) Ielādējiet testa datus:
   ```
   rails db:seed
   ```

5. Kompilējiet TailwindCSS aktīvus:
   ```
   rails tailwindcss:build
   ```

6. Palaidiet serveri:
   ```
   rails server
   ```

Tagad jūs varat piekļūt sistēmai, atverot pārlūkprogrammā adresi `http://localhost:3000`.

## Lietošana

Sistēmā ir divas galvenās formas:

1. Saraksts ar darbiniekiem un elektriskajiem velosipēdiem, kas parāda, kurš darbinieks lieto velosipēdu un kad.
2. Darbinieku un velosipēdu sasaistes forma, kas ļauj izveidot jaunas rezervācijas.

Lai izveidotu jaunu rezervāciju:
1. Dodieties uz "Jaunas rezervācijas" sadaļu.
2. Izvēlieties darbinieku un velosipēdu.
3. Norādiet rezervācijas sākuma un beigu laiku.
4. Saglabājiet rezervāciju.

## Testi

Šis projekts izmanto Rails noklusējuma testēšanas ietvaru Minitest kopā ar Capybara sistēmas testēšanai.

Lai palaistu visus testus, izmantojiet komandu:

```
rails test
```

## Autors

Ralfs Normunds Pavārs - ralfs.pavars@gmail.com
