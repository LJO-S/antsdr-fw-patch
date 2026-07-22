# Setup for a fresh clone of MY repo chain (LJO-S/antsdr-fw-patch).
#
# Do NOT run MicroPhase's patch.sh here: hdl and plutosdr-fw arrive already
# patched and committed (branch e200-custom in my repos). Only the unforked
# submodules pinned to Analog Devices (linux, buildroot, u-boot-xlnx) still
# need their MicroPhase patches applied on top of the pinned commits.
#
# Usage: ./setup.sh [target]   (default target: e200)

target=${1:-e200}

cp ./patch/${target}/*linux.patch     ./plutosdr-fw/linux
cp ./patch/${target}/*buildroot.patch ./plutosdr-fw/buildroot
cp ./patch/${target}/*uboot.patch     ./plutosdr-fw/u-boot-xlnx

for d in linux buildroot u-boot-xlnx; do
	cd ./plutosdr-fw/$d
	echo "Patching $d ..."
	git apply --stat *.patch
	git apply --check *.patch && git apply *.patch
	rm -f *.patch
	cd ../..
done

echo "setup finish"
