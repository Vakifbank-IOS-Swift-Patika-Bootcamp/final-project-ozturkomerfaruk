# NeworlD Oyun Uygulaması

## İçindekiler

...

## Bitirme Projesi NeworlD uygulama ikonu

<img width="350" alt="image" src="https://user-images.githubusercontent.com/56068905/208308847-4b4ad711-59f1-4430-bd85-df2ad1145c89.png">

## Bitirme Projesi Hazırlık Dökümanı

|Sorular|Cevaplar|
|---|---|
|Projenin içeriği ne olacak?|Oyunların listeleneceği bir sayfa. Bu sayfa içerisinde filtrelemelerin de mümkün olduğu ve oyun aramasının da yapılacabileceği bir sayfa olacaktır. Oyunların detay ekranları olacak ve detay ekranından oyunlar favorilere eklenebilecektir. Favoriler içerisinde de küçük bir ayrıntı sayfası olmaktadır. Daha sonra, oyunların bir de not ekleme sayfası olacaktır. Oyunlara yönelik notlar eklenebilecek ve düzenlenip silinebilecektir.|
|Hazırlayacağın proje hangi amaca hizmet edecek?| Ben de bir oyun sever olarak, oyun sever insanların aktif bir şekilde kullanabileceği bir proje yapmayı hedeflemekteyim.|
|Projeni yaparken nereden başlayacaksın ve hangi aşamaları takip edeceksin? Bu konu senin için net mi?|Proje içerisinde kullanılacak harici kütüphanelerin kullanılmasını araştırdım. Trello üzerinde bir görev aşaması belirledim ve ona uymaya çalışacağım.|
|Projende kullanacağın yaklaşımlar neler olacak?|Projeyi tek kişi yöneteceği için, her bir adımın kontrolü bende olacaktır. Projeye tam manasıyla dahil olabilmek için bir dökümantasyon oluşturarak ilerlemeyi hedeflemekteyim. Ayrıca proje içerisinde kullanılacak kütüphanelerin, bir demo uygulamada kullanılıp, test edilip öyle projeye entegre etmek istiyorum.|
|Projeni yazarken hangi teknolojileri kullanacaksın? Bootcamp’te öğrendiğin teknolojiler dışında başka teknolojilere ihtiyacın olacak mı?|En başta Local Notification ve Localization kavramlarını daha önce kullanmadım Swift dünyasında. Ardından kendim Lottie kavramını kullanmak istiyorum. Bir de Test yaklaşımlarını daha önce hiç kullanmadım Swift dünyasında Unit Test yazmak da benim için ilk tecrübe olacak.|
|Projeyi nasıl tasarlayacaksın?|Örnek projeleri inceleyeceğim. Başta Steam olmak üzere bir çok oyun içeriği sunan örnek projelere bakarak, onlardan daha iyi neler yapabilirim, araştıracağım.|

## Proje Gereksinimler Hakkında

|Gereksinimler|Sürümler|
|---|---|
|Xcode|Version 14.2 (14C18)|
|Swift|5.7.2|
|iOS|16.1|

## Ekran Görüntüleri

|Sayfa Görüntüleri|Sayfa Hakkında|
|---|---|
|![1](https://user-images.githubusercontent.com/56068905/208310529-601e24d2-8d34-4e5a-bef3-945fcda55159.gif)|Launch Ekranı ve Onboarding Ekranı. Burada kullan|
|![2](https://user-images.githubusercontent.com/56068905/208310540-919102cd-6f4b-469d-b791-3899997c7ca2.gif)|Oyun listeleme ekranı ve listede filtreleme özelliği|
|![3](https://user-images.githubusercontent.com/56068905/208310698-084e041c-67e7-42fc-bf33-c73949bde06d.gif)|Oyun listesinde arama özelliği|
|![detay](https://user-images.githubusercontent.com/56068905/208311332-1ccebc40-0c48-4fef-8af9-d682c3cfd09c.gif)|Oyun detay ekranı|
|![favori](https://user-images.githubusercontent.com/56068905/208311337-bf9f4957-fa4a-4ed3-9227-512ab6d66520.gif)|Favoriler ekranı|
|![6](https://user-images.githubusercontent.com/56068905/208310895-19a4d902-6c50-4434-b452-39130f0157ed.gif)|Notlar listesi, not silme, not ekleme ve güncelleme sayfası|
|![7](https://user-images.githubusercontent.com/56068905/208310905-d1e6963d-5b0d-4d4c-ab61-8610871a0f7c.gif)|Local notification özelliği|
|![ezgif com-gif-maker](https://user-images.githubusercontent.com/56068905/208310951-fe5f5747-fab5-4b52-952b-b0282a64730d.gif)|Türkçe ve İngilizce Localization özelliği|

## Kullanılan Dizayn Patern Mimarisi

**Protocol Oriented MVVM**

## Kullanılan Harici Kütüphaneler

* Alamofire
* iCarousel
* MaterialActivityIndicator
* SwiftAlertView ~> 2.2.1
* lottie-ios

## Network Endpoints

|URL|Manası|
|---|---|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}|Sayfa numarası ve sayfa saysında gösterilecek oyun sayısı|
|/games/{gameID}?key=##API_KEY##|Oyun ID si ile birlikte oyun detay sayfası|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}&ordering=-released|Yayım tarihine göre en yeni oyunlar|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}&ordering=released|Yayım tarihine göre en eski oyunlar|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}&ordering=-rating|Değerlendirmeye göre en yüksek oyunlar|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}&ordering=rating|Değerlendirmeye göre en eski oyunlar|
|/games?key=##API_KEY##&page={page}&page_size={pageSize}&ordering=added|Favoriye göre listelenen oyunlar|
|/games?key=##API_KEY##&search={searchString}| Girilen oyun adına göre arama yapma|

## Trello

Ekran görüntüsünü proje bitiminde koyacağım.

Agile-Scrum metodolojisinde projeyi yönetmeye çalıştığım, Trello uygulamasında hazırladığım yol haritasını görüntülemek için [tıklayabilirsiniz](https://trello.com/invite/b/ks1phjdB/ATTI5093c6e9e92d387f878ac715a4fe56373521F70F/neworld).
