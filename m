From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Sun, 23 Dec 2018 16:27:04 +0100
Subject: [cip-dev] Beaglebone Black thud kas-bbb-thud.yml script
Message-ID: <CAEss1E+QmWkgb5Qb_Cn+jBdVq_PkJVmDim7ho5+pVzR4LAbwjg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello to all,

I produced thud KAS script to do some dirty and quick bbb YOCTO rootfs
and kernel (4.19.7) production.

For this purpose I have enhanced Beaglebone Black sumo KAS script to
thud, to serve to the purpose.

If anybody needs it, please, find it attached (with meta-socketcan layer
addendum, which is my proprietary layer invention due to some work done
for automotive industry).

If you do not need meta-socketcan layer included as extras, just remove
these lines from the script:


*  meta-socketcan:    url:
"https://github.com/ZoranStojsavljevic/meta-socketcan.git
<https://github.com/ZoranStojsavljevic/meta-socketcan.git>"    refspec:
064d2fdf5b69e5c038aba225884c183b8e00f30b*

Please, also do note that the script takes default variables, if they are
not
explicitly specified.

Thank you,
Zoran
_______
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181223/89c7b9cb/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kas-bbb-thud.yml
Type: application/x-yaml
Size: 1708 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181223/89c7b9cb/attachment.bin>
