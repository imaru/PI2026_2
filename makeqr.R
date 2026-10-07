library(qrcode)

prac<-qr_code('https://imaru.github.io/PI2026_2/practice.html', ecl='H')
png('prac.png', width=300, height=300)
plot(prac)
dev.off()

i1<-qr_code('https://imaru.github.io/PI2026_2/identity1.html', ecl='H')
png('i1.png', width=300, height=300)
plot(i1)
dev.off()

i2<-qr_code('https://imaru.github.io/PI2026_2/identity2.html', ecl='H')
png('i2.png', width=300, height=300)
plot(i2)
dev.off()

pos<-qr_code('https://imaru.github.io/PI2026_2/position.html', ecl='H')
png('pos.png', width=300, height=300)
plot(pos)
dev.off()
