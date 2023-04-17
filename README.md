# Пример приложения с maven + интеграционные тесты с zonky + secman + fluent-bit

Ветка `develop` - содержит минимальный шаблон веб приложения.

### Настройка Maven:
1. Скопировать файл `.mvn/settings.xml_template` в домашнюю директорию `.m2/`
2. Переименовать скопированный `settings.xml_template` в `settings.xml` и прописать в нём свои креды (sigma_login и sigma_pass)
3. Профит! (делается один раз)

* Файл `.mvn/jvm.config` содержит настройки для корректной работы с банковскими репозиториями по ssl и распространяется только на проект, в каталоге которого располагается. При желании / проблемах можно продублировать настройки в IDEA (Build, Execution, Deployment -> Build Tools -> Maven -> Runner -> VM options ).

> Для секьюрности можно использовать встроенный [механизм шифрования в maven](https://maven.apache.org/guides/mini/guide-encryption.html#how-to-create-a-master-password) - нужно создать файл settings-security.xml с зашифрованным мастер паролем, а в settings.xml прописывать зашифрованный сигма пароль `mvn --encrypt-password <password>`