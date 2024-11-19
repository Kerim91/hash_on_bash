#!/bin/bash

# Şifre doğrulama fonksiyonu
validate_password() {
    local password=$1
    
    # Şifre uzunluğu kontrolü
    if [ ${#password} -lt 12 ]; then
        echo "Şifre en az 12 karakter olmalıdır."
        return 1
    fi

    # Büyük harf kontrolü
    if ! [[ "$password" =~ [A-Z] ]]; then
        echo "Şifre en az bir büyük harf içermelidir."
        return 1
    fi

    # Küçük harf kontrolü
    if ! [[ "$password" =~ [a-z] ]]; then
        echo "Şifre en az bir küçük harf içermelidir."
        return 1
    fi

    # Rakam kontrolü
    if ! [[ "$password" =~ [0-9] ]]; then
        echo "Şifre en az bir rakam içermelidir."
        return 1
    fi

    # Sembol kontrolü
    if ! echo "$password" | grep -q "[@#%\^&\*\(\)_\+\=\!\~\`\$\^\&\*\(\)_\-\{\}\[\]\|\\:;\"\'<>,\./?]"; then
        echo "Şifre en az bir sembol içermelidir."
        return 1
    fi

    echo "Şifre geçerli."
    return 0
}

# Hashleme fonksiyonu
hash_password() {
    local password=$1
    local algorithm=$2

    case $algorithm in
        1)
            echo -n "$password" | md5sum | awk '{print $1}'
            ;;
        2)
            echo -n "$password" | sha256sum | awk '{print $1}'
            ;;
        3)
            echo -n "$password" | sha512sum | awk '{print $1}'
            ;;
        *)
            echo "Geçersiz seçenek."
            ;;
    esac
}

# Kullanıcıdan hash algoritmasını seçmesini iste
echo "Hashleme algoritmasını seçin:"
echo "1) MD5"
echo "2) SHA-256"
echo "3) SHA-512"
read -p "Seçiminiz (1/2/3): " algorithm_choice

# Şifreyi doğrulamak için döngü
while true; do
    # Kullanıcıdan şifreyi al
    echo "Şifreyi girin:"
    read password

    # Şifreyi doğrula
    if validate_password "$password"; then
        echo "Seçilen algoritmaya göre hashlenmiş şifre:"
        hash_password "$password" "$algorithm_choice"
        break  # Doğru şifre girildi, döngüden çık
    fi

    echo "Lütfen tekrar deneyin."
done
