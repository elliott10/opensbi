# 编译并烧写opensbi for fu740

### opensbi for fu740
opensbi 源码
参考：
https://github.com/sifive/meta-sifive/tree/2022.04/recipes-bsp/opensbi/opensbi_git.bb

```
git clone https://github.com/elliott10/opensbi.git -b sifive_unmatched_fu740
```
### 编译opensbi
```
cd opensbi
make CROSS_COMPILE=riscv64-linux-musl- PLATFORM=generic FW_PIC=n
```
生成opensbi镜像: `build/platform/generic/firmware/fw_dynamic.bin`

### u-boot for fu740
u-boot 源码
参考：
https://github.com/sifive/meta-sifive/tree/2022.04/recipes-bsp/u-boot/u-boot_2022.04.bb
```
git clone https://github.com/elliott10/u-boot.git  -b sifive_unmatched

cd u-boot
export OPENSBI=$PWD/../opensbi/build/platform/generic/firmware/fw_dynamic.bin

make CROSS_COMPILE=riscv64-linux-musl- O=build sifive_unmatched_defconfig
make CROSS_COMPILE=riscv64-linux-musl- CC=riscv64-linux-musl-gcc O=build all -j8 
```
编译出的包含`opensbi`与`u-boot`的镜像文件`build/u-boot.itb`， 需要写入SD Card的分区2 `mmcblk0p2`, Sector = 512 bytes, Start=2082

### 烧写
SD卡可以直接在fu740的Linux系统中写分区，也可以拔出SD卡用读卡器来写分区；
```
dd if=u-boot.itb of=/dev/mmcblk0p2 oflag=direct
```
写完SD卡后，重启fu740
