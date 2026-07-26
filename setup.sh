# Setup for a fresh clone of MY repo chain (LJO-S/antsdr-fw-patch).
#
# Do NOT run MicroPhase's patch.sh here: hdl, linux, u-boot-xlnx, plutosdr-fw arrive already
# patched and committed (branch e200-custom in my repos). Only the unforked
# submodules pinned to Analog Devices (buildroot) still
# need their MicroPhase patches applied on top of the pinned commits.
#
# Usage: ./setup.sh [target]   (default target: e200)

target=${1:-e200}

cp ./patch/${target}/*buildroot.patch ./plutosdr-fw/buildroot

for d in buildroot; do
	cd ./plutosdr-fw/$d
	echo "Patching $d ..."
	git apply --stat *.patch
	git apply --check *.patch && git apply *.patch
	rm -f *.patch
	cd ../..
done

echo "setup finish"
