# ark linux

ini bukan sebuah distro baru, tidak ada visi muluk-muluk, dan tidak ada branding agresif.
**ark linux** literaly hanyalah **arch linux vanila** yang dikemas ke dalam arsitektur *immutable container* (oci/bootc). itu saja bedanya.

jika anda menyukai arch linux polos, namun menginginkan fitur *smart atomic updates* layaknya fedora silverblue tanpa takut sistem *break*, maka ark linux adalah wadah yang tepat. tidak ada *bloatware*, tidak ada tema *custom*, hanya arch linux yang kebal terhadap kerusakan pembaruan.

## fitur utama
- **100% arch linux murni**: menggunakan `docker.io/archlinux:latest` langsung sebagai *base image* tanpa campur tangan repositori pihak ketiga.
- **immutable & atomic**: sistem file *read-only* dengan pembaruan *delta*. jika *update* rusak, anda cukup me-*rollback* melalui menu grub.
- **smart updater**: aplikasi updater bawaan ringan berbasis rust & gtk4 (`alga`) yang mendeteksi status os.
- **nvidia ready**: otomatis menyediakan varian yang sudah dipasangi *proprietary nvidia drivers*.

## instalasi
anda tidak perlu melakukan instalasi arch linux secara manual melalui terminal.
1. unduh iso installer terbaru di kolom **releases**.
2. *flash* ke usb dan *boot* di pc anda.
3. anda akan langsung dihadapkan dengan gui installer rust yang akan memasang *ark linux* secara *seamless* dalam hitungan menit.

## arsitektur pemeliharaan (zero-maintenance)
karena ark linux bukanlah distro terpisah, pembaruan ditarik langsung dari *mirror* arch linux melalui github actions setiap hari minggu. *base image* akan otomatis di-*build* dan di-*push* ke github container registry.
sistem pc anda hanya perlu menarik perbedaan lapisannya (delta), melakukan pembaruan di latar belakang tanpa mengganggu alur kerja, lalu berlaku pada *reboot* selanjutnya.
