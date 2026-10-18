# Linux basics: system setup and monitoring lab

[O‘zbekcha](#ozbekcha) · [Русский](#русский) · [English](#english)

> Public portfolio edition. This is a separate, sanitized description of a Kali Linux lab. The real VM, its network details, keys, mail address, credentials, logs, and system inventory are **not** published here. Files under `examples/` are commented templates, not a live server configuration. The `src/` scripts require an explicit lab-only opt-in before they can change a system.

## O‘zbekcha

**Maqsad.** Kali Linux virtual mashinasida tizim haqida ma’lumot yig‘ish, foydalanuvchi huquqlarini boshqarish, kunlik log hisobotini yuborish va SSH hamda firewall’ni sozlash.

**Bajarilgan ishlar.** Bash skripti o‘rnatilgan paketlar, jarayonlar, ochiq portlar, OS va yadro versiyasini `info` fayliga yig‘ib, `OS_RESULT.tar` arxivini yaratadi. Ikkinchi skript laboratoriya foydalanuvchilari va guruhlarini, ularning uy kataloglariga kirish huquqini, Apache xizmatini va topshiriqdagi sudo qoidasini sozlaydi. Logwatch, cron va Postfix oldingi kun loglarini har kuni 00:00 da yuqori tafsilot bilan yuboradi. SSH kalit bilan kirishga o‘tkazilgan; tashqaridan 80/tcp bloklangan.

**Tekshiruv.** Alohida Kali VM’da skriptlar, foydalanuvchi huquqlari, Apache, SSH, firewall va SMTP orqali sinov hisobotining qabul qilinishi tekshirildi. Xatlar ishlashi uchun VM belgilangan vaqtda yoqilgan bo‘lishi kerak.

**Maxfiylik.** Haqiqiy IP, SSH kirish ma’lumotlari, kalitlar, pochta manzili va parol, loglar hamda tizim arxivi bu ochiq repozitoriyda yo‘q. `examples/` ichida ular izohlar va `example.invalid` namunaviy qiymatlari bilan almashtirilgan. Laboratoriyadagi `/var` uchun keng huquq va parolsiz sudo haqiqiy serverda qo‘llanmasligi kerak.

## Русский

**Цель.** Настроить виртуальную машину Kali Linux: собрать сведения о системе, разграничить права пользователей, отправлять ежедневный отчёт по журналам и защитить SSH и сетевой доступ.

**Что сделано.** Bash-скрипт собирает пакеты, процессы, открытые порты, версии ОС и ядра в `info` и создаёт архив `OS_RESULT.tar`. Второй скрипт создаёт учебные группы и пользователей, настраивает доступ к домашним каталогам, Apache и правило sudo из задания. Logwatch, cron и Postfix отправляют подробный отчёт за предыдущий день в 00:00. SSH использует ключи; входящий 80/tcp снаружи блокируется.

**Проверка.** На отдельной Kali VM проверены скрипты, права пользователей, Apache, SSH, правило firewall и приём тестового письма SMTP-сервером. Для ежедневной отправки VM должна работать в назначенное время.

**Конфиденциальность.** Реальные IP-адреса, данные входа по SSH, ключи, почта и пароль, журналы и архив инвентаризации в публичный репозиторий не включены. В `examples/` вместо них только комментарии и значения `example.invalid`. Широкие права на `/var` и sudo без пароля относятся только к учебной VM.

## English

**Goal.** Configure a Kali Linux VM for system inventory, user access control, daily log reporting, and SSH/network protection.

**Implementation.** A Bash script records installed packages, processes, listening ports, and OS/kernel versions in `info`, then creates `OS_RESULT.tar`. A second script configures lab users and groups, shared home-directory access, Apache, and the assignment’s sudo rule. Logwatch, cron, and Postfix send a high-detail report for the previous day at 00:00. SSH uses key authentication, and inbound external TCP/80 is blocked.

**Verification.** Scripts, access rules, Apache, SSH, firewall, and SMTP acceptance of a test report were checked on a separate Kali VM. The VM must be running at the scheduled time for daily mail to be sent.

**Privacy.** This public repository contains no real IP addresses, SSH login details, keys, email address or password, logs, or system inventory archive. `examples/` uses comments and `example.invalid` placeholders. World-writable `/var` and passwordless sudo are lab-only settings and are not appropriate for production.

## Repository contents

- `src/get_all_info.sh` — lab-only system inventory script.
- `src/setup_linux.sh` — lab-only account and service configuration script.
- `examples/` — sanitized SSH, Postfix, cron, and firewall examples. They do not contain live access data.

The original course repository and VM are separate from this portfolio repository. No original Git history was copied here.
