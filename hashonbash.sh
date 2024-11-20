#!/bin/bash

# Şifre doğrulama fonksiyonu
validate_password() {
    local password=$1

    # Şifre doğrulama kuralları
    if [[ ${#password} -lt 8 ]]; then
        echo "Hata: Şifre en az 8 karakter olmalıdır."
        return 1
    fi
    if ! [[ "$password" =~ [A-Z] ]]; then
        echo "Hata: Şifre en az bir büyük harf içermelidir."
        return 1
    fi
    if ! [[ "$password" =~ [a-z] ]]; then
        echo "Hata: Şifre en az bir küçük harf içermelidir."
        return 1
    fi
    if ! [[ "$password" =~ [0-9] ]]; then
        echo "Hata: Şifre en az bir rakam içermelidir."
        return 1
    fi
    if ! [[ "$password" =~ [@#%^&*()_+=\[\]{}<>|\\:;"',./?~] ]]; then
        echo "Hata: Şifre en az bir özel karakter içermelidir."
        return 1
    fi
    return 0
}

# Hashleme fonksiyonu
hash_password() {
    local password=$1
    local algorithm=$2
    case $algorithm in
        1) echo -n "$password" | md5sum | awk '{print $1}' ;;
        2) echo -n "$password" | sha256sum | awk '{print $1}' ;;
        3) echo -n "$password" | sha512sum | awk '{print $1}' ;;
        *) echo "Hata: Geçersiz algoritma seçimi." ;;
    esac
}

# Kullanıcıya giriş menüsü göster
echo "Hoş Geldiniz! Lütfen bir işlem seçin:"
echo "1) Şifre Hashleme"
echo "2) Hash Doğrulama"
echo "3) Çıkış"
read -p "Seçiminiz (1/2/3): " main_choice

case $main_choice in
1)
    echo "Hashleme algoritmasını seçin:"
    echo "1) MD5"
    echo "2) SHA-256"
    echo "3) SHA-512"
    read -p "Seçiminiz (1/2/3): " algorithm_choice

    while true; do
        read -sp "Şifreyi girin: " password
        echo
        if validate_password "$password"; then
            hash=$(hash_password "$password" "$algorithm_choice")
            echo "Seçilen algoritmaya göre hashlenmiş şifre: $hash"

            # Kaydetme seçeneği
            read -p "Hash sonucu bir dosyaya kaydedilsin mi? (E/H): " save_choice
            if [[ $save_choice =~ ^[Ee]$ ]]; then
                read -p "Dosya adı girin: " file_name
                echo "$hash" > "$file_name"
                echo "Hash sonucu $file_name dosyasına kaydedildi."
            fi
            break
        fi
    done
    ;;
2)
    # Hash doğrulama
    read -sp "Doğrulamak istediğiniz şifreyi girin: " password
    echo
    read -p "Hash algoritması seçin (1-MD5, 2-SHA-256, 3-SHA-512): " algorithm_choice
    read -p "Karşılaştırmak istediğiniz hash'i girin: " input_hash

    generated_hash=$(hash_password "$password" "$algorithm_choice")
    if [[ "$input_hash" == "$generated_hash" ]]; then
        echo "Doğrulama başarılı: Hashler eşleşiyor."
    else
        echo "Doğrulama başarısız: Hashler eşleşmiyor."
    fi
    ;;
3)
    echo "Çıkış yapılıyor..."
    exit 0
    ;;
*)
    echo "Geçersiz seçim. Çıkılıyor..."
    exit 1
    ;;
esac
