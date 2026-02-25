.POSIX:
AS:=nasm
ASFLAGS:=-f bin

%.bin: %.s
	sdk/build $<

.PHONY: osle_test
osle_test: osle fixtures/text.txt.bin test/fs.test.bin
	sdk/pack test/fs.test.bin
	sdk/pack fixtures/text.txt.bin

.PHONY: osle
osle: osle.o bin/ed.bin bin/more.bin bin/rm.bin bin/mv.bin bin/help.bin boot/mode/bm.bin
	dd if=/dev/zero of=vmkatzz.img bs=512 count=2880
	dd if=osle.o of=vmkatzz.img bs=512 count=1 conv=notrunc
	sdk/pack bin/ed.bin vmkatzz.img
	sdk/pack bin/more.bin vmkatzz.img
	sdk/pack bin/rm.bin vmkatzz.img
	sdk/pack bin/mv.bin vmkatzz.img
	sdk/pack bin/help.bin vmkatzz.img
	sdk/pack boot/mode/bm.bin vmkatzz.img

.PHONY: start
start: osle
	bochs -q -f .bochsrc

.PHONY: debug
debug: osle_test
	bochs -dbg -rc .bochsinit -f .bochsrc

.PHONY: clean
clean:
	rm -rf *.img *.o *.bin **/*.o **/*.bin
