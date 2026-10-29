# Explanation

## 1. Ən çətin hesab etdiyiniz SQL sorğusu hansı oldu?

Mənim üçün ən çətini 3.28 oldu. Burada öz departamentinin bütün kurslarını tədris edən müəllimləri tapmaq lazım idi. SQL-də "hamısı" sözünü birbaşa yazmaq olmur. Ona görə məsələni tərsinə düşündüm. Departamentin kurslarından müəllimin dərs demədiyi kursları tapdım. Əgər belə kurs qalmırsa, deməli müəllim hamısını tədris edir. Bunu NOT EXISTS və EXCEPT ilə yazdım. 3.15(a) da eyni məntiqlə həll olunur, orada Brooklyn-dakı bütün filiallarda hesabı olan müştəriləri tapdım.

## 2. Hansı sorğu üçün alt sorğu (subquery) istifadə etdiniz?

3.25-də alt sorğu istifadə etdim. Əvvəl içəridəki sorğu Philosophy departamentinin büdcəsini tapır. Sonra xaricdəki sorğu büdcəsi bundan çox olan departamentləri seçir və ORDER BY ilə əlifba sırasına düzür. 3.11(d)-də isə FROM hissəsində alt sorğu var. İçəridə hər departamentin maksimum maaşını tapdım, xaricdə MIN ilə onların ən kiçiyini götürdüm. 3.11(b), 3.31 və 3.32-də də NOT IN ilə alt sorğu işlətdim.

## 3. JOIN istifadə etdiyiniz bir nümunəni izah edin.

3.24-də üç cədvəli JOIN ilə birləşdirdim: student, advisor və instructor. Əvvəl student cədvəlini advisor ilə tələbənin ID-si üzrə birləşdirdim. Sonra advisor cədvəlini instructor ilə müəllimin ID-si üzrə birləşdirdim. Beləliklə hər tələbənin yanında onun məsləhətçisinin departamenti də göründü. Sonda WHERE ilə tələbənin departamenti Accounting, müəllimin departamenti Physics olan sətirləri saxladım.

## 4. SQL sorğularını yazarkən qarşılaşdığınız bir problemi və onun həllini izah edin.

3.31-də teaches və takes cədvəllərini birləşdirəndə əvvəl yalnız course_id ilə birləşdirdim. Nəticə səhv çıxdı, çünki eyni kursu fərqli müəllimlər fərqli bölmələrdə və illərdə tədris edir. Bir müəllimin öz bölməsində A verməsə də, başqa müəllimin verdiyi A ona yazılırdı. Problemi həll etmək üçün JOIN şərtinə course_id, sec_id, semester və year sütunlarının hamısını əlavə etdim. Bundan sonra hər qiymət düzgün müəllimə aid oldu və nəticə düzəldi.

Başqa bir problem 3.26-da oldu. Tapşırıqda "iki dəfə təkrar" yazılıb, mən əvvəl HAVING COUNT(*) >= 2 yazdım. Sonra başa düşdüm ki, iki dəfə təkrar etmək kursu üç dəfə götürmək deməkdir və şərti >= 3 etdim.
