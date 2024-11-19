Şifre Doğrulama ve Hashleme Scripti

Bu Bash scripti, kullanıcıdan güçlü bir şifre talep eder, şifrenin geçerliliğini kontrol eder ve ardından kullanıcı tarafından seçilen bir hashleme algoritmasına göre şifreyi hashler. Script, özellikle güvenli ve güçlü şifreler oluşturmayı teşvik etmek ve hashleme algoritmalarını öğrenmek isteyenler için tasarlanmıştır.

Özellikler

Şifre Doğrulama: Script, şifrenin belirli kriterleri karşılayıp karşılamadığını kontrol eder:
En az 12 karakter uzunluğunda
En az bir büyük harf
En az bir küçük harf
En az bir rakam
En az bir sembol (örneğin: @, #, %, &, vb.)

Hashleme Seçenekleri: Kullanıcı, şifreyi aşağıdaki hashleme algoritmalarından biriyle hashleyebilir:

MD5
SHA-256
SHA-512
Kullanıcı Dostu Arayüz: Kullanıcı, doğru şifreyi girene kadar script, şifreyi tekrar girmesini ister.
Kullanım

1. Script'i Çalıştırın
Terminalde script'inizin bulunduğu dizine gidin ve aşağıdaki komutu çalıştırın:

bash
Kodu kopyala
./hashonbash.sh

2. Hashleme Algoritmasını Seçin
Script, size üç hashleme algoritması sunacaktır. Seçiminizi yapın:

1: MD5
2: SHA-256
3: SHA-512
3. Şifreyi Girin
Script, sizden bir şifre girmenizi isteyecek. Geçerli bir şifre girene kadar döngü devam edecektir.

4. Hashlenmiş Şifreyi Görüntüleyin
Geçerli bir şifre girdiğinizde, seçtiğiniz hashleme algoritmasına göre hashlenmiş şifreyi göreceksiniz.

Gereksinimler
Bash kabuğu
md5sum, sha256sum ve sha512sum komutlarının yüklü olması (çoğu Linux dağıtımında varsayılan olarak gelir)
