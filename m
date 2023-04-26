Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59842C7618E
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 07:49:07 +0000 (UTC)
Subject: Re: [PATCH] recipes-python/shtab: Update shelltab to latest one
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: US (139.181.36.34)
X-Originating-Platform: Windows Chrome 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 26 Apr 2023 00:48:59 -0700
References: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
In-Reply-To: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
Message-ID: <17864.1682495339576723993@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="2uiQXj376dK5uMLvb6wv"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 07:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11350

--2uiQXj376dK5uMLvb6wv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 05:36 PM, Jan Kiszka wrote:

>=20
> On 24.04.23 13:55, Srinuvasan Arjunan wrote:
>=20
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>=20
>> Update shelltab to latest one.
>=20
> ...latest one of Debian bookworm, right?

yes jan

>=20
>=20
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>> recipes-bsp/efibootguard/efibootguard_0.13.bb | 2 +-
>> ...001-Lower-requirements-on-setuptools.patch | 28 ------------
>> ...ix-cross-build-issue-for-bullseye-im.patch | 33 ++++++++++++++
>> ...002-Lower-requirements-on-setuptools.patch | 36 ++++++++++++++++
>> ...003-Lower-requirements-on-setuptools.patch | 43 +++++++++++++++++++
>> recipes-python/shtab/files/rules | 21 ---------
>> recipes-python/shtab/python3-shtab_1.4.2.bb | 36 ----------------
>> recipes-python/shtab/python3-shtab_1.5.5-3.bb | 31 +++++++++++++
>> 8 files changed, 144 insertions(+), 86 deletions(-)
>> delete mode 100644
>> recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
>> create mode 100644
>> recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for=
-bullseye-im.patch
>>=20
>> create mode 100644
>> recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>> create mode 100644
>> recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
>> delete mode 100755 recipes-python/shtab/files/rules
>> delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
>> create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb
>>=20
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb
>> b/recipes-bsp/efibootguard/efibootguard_0.13.bb
>> index dd76198..313716a 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
>> @@ -29,7 +29,7 @@ PROVIDES =3D "${PN}"
>> PROVIDES +=3D "${PN}-dev"
>>=20
>> DEPENDS =3D "python3-shtab"
>> -BUILD_DEB_DEPENDS =3D
>> "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-=
shtab,zlib1g-dev"
>>=20
>> +BUILD_DEB_DEPENDS =3D
>> "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-=
shtab:native,zlib1g-dev"
>>=20
>> BUILD_DEB_DEPENDS:append:amd64 =3D ",libc6-dev-i386"
>> BUILD_DEB_DEPENDS:append:i386 =3D ",libc6-dev-i386"
>>=20
>> diff --git
>> a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
>> b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
>> deleted file mode 100644
>> index dccc2dd..0000000
>> ---
>> a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
>> -From: Jan Kiszka <jan.kiszka@siemens.com>
>> -Date: Mon, 14 Mar 2022 08:17:00 +0100
>> -Subject: [PATCH] Lower requirements on setuptools
>> -
>> -Allows to build against Debian buster.
>> -
>> -Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ----
>> - setup.cfg | 2 +-
>> - 1 file changed, 1 insertion(+), 1 deletion(-)
>> -
>> -diff --git a/setup.cfg b/setup.cfg
>> -index 55eecd4..186aad6 100644
>> ---- a/setup.cfg
>> -+++ b/setup.cfg
>> -@@ -66,7 +66,7 @@ classifiers=3D
>> - Topic :: Terminals
>> - Topic :: Utilities
>> - [options]
>> --setup_requires=3Dsetuptools>=3D42; setuptools_scm[toml]>=3D3.4
>> -+setup_requires=3Dsetuptools>=3D40; setuptools_scm>=3D3.2
>> - install_requires=3D
>> - argparse; python_version < "2.7" or ("3.0" <=3D python_version and
>> python_version < "3.2")
>> - python_requires=3D >=3D2.7, !=3D3.0.*, !=3D3.1.*
>> ---
>> -2.34.1
>> -
>> diff --git
>> a/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-f=
or-bullseye-im.patch
>> b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-f=
or-bullseye-im.patch
>>=20
>> new file mode 100644
>> index 0000000..9fb17de
>> --- /dev/null
>> +++
>> b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-f=
or-bullseye-im.patch
>>=20
>> @@ -0,0 +1,33 @@
>> +From 661472b5fb651a140cd9852fef4b797b8535fedf Mon Sep 17 00:00:00 2001
>> +From: Srinuvasan A <srinuvasan.a@siemens.com>
>> +Date: Mon, 16 Jan 2023 13:55:23 +0530
>> +Subject: [PATCH] debian/control: Fix cross build issue for bullseye
>> images
>> +
>> +Fix cross build issues for bullseye images.
>> +
>=20
> And this one was also submitted to Debian upstream?

yes will send this changes to debian upstream

>=20
>=20
>> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> +---
>> + debian/control | 8 +++++---
>> + 1 file changed, 5 insertions(+), 3 deletions(-)
>> +
>> +diff --git a/debian/control b/debian/control
>> +index b30beb1..a63e366 100644
>> +--- a/debian/control
>> ++++ b/debian/control
>> +@@ -6,9 +6,11 @@ Uploaders: Felix Moessbauer
>> <felix.moessbauer@siemens.com>
>> + Build-Depends: debhelper-compat (=3D 13),
>> + dh-python,
>> + python3-setuptools (>=3D42),
>> +- python3-setuptools-scm (>=3D3.4),
>> +- python3-all (>=3D3.2),
>> +- python3-wheel,
>> ++ python3-setuptools-scm:native (>=3D3.4),
>> ++ libpython3-all-dev (>=3D3.2),
>> ++ python3-all-dev:any (>=3D3.2),
>> ++ python3-wheel:native,
>> ++ python3-toml:native,
>> + python3-pytest <!nocheck>,
>> + python3-pytest-cov <!nocheck>,
>> + python3-pytest-timeout <!nocheck>,
>> +--
>> +2.34.1
>> diff --git
>> a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>> b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>> new file mode 100644
>> index 0000000..1db4fa8
>> --- /dev/null
>> +++
>> b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>> @@ -0,0 +1,36 @@
>> +From 1d2e28a3da03815d16e0fb6dc11428509f4ed366 Mon Sep 17 00:00:00 2001
>> +From: Srinuvasan A <srinuvasan.a@siemens.com>
>> +Date: Tue, 17 Jan 2023 18:54:33 +0530
>> +Subject: [PATCH] Lower requirements on setuptools
>> +
>> +Allows to build against Debian buster and fix cross build issues.
>> +
>> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> +---
>> + debian/control | 10 +++++-----
>> + 1 file changed, 5 insertions(+), 5 deletions(-)
>> +
>> +diff --git a/debian/control b/debian/control
>> +index b30beb1..380b934 100644
>> +--- a/debian/control
>> ++++ b/debian/control
>> +@@ -3,12 +3,12 @@ Section: python
>> + Priority: optional
>> + Maintainer: Debian Python Team <team+python@tracker.debian.org>
>> + Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +-Build-Depends: debhelper-compat (=3D 13),
>> ++Build-Depends: debhelper-compat (=3D 12),
>> + dh-python,
>> +- python3-setuptools (>=3D42),
>> +- python3-setuptools-scm (>=3D3.4),
>> +- python3-all (>=3D3.2),
>> +- python3-wheel,
>> ++ python3-setuptools (>=3D40),
>> ++ python3-setuptools-scm:native (>=3D3.2),
>> ++ libpython3-all-dev (>=3D3.2),
>> ++ python3-all-dev:any (>=3D3.2),
>> + python3-pytest <!nocheck>,
>> + python3-pytest-cov <!nocheck>,
>> + python3-pytest-timeout <!nocheck>,
>> +--
>> +2.34.1
>> diff --git
>> a/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
>> b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
>> new file mode 100644
>> index 0000000..9687222
>> --- /dev/null
>> +++
>> b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
>> @@ -0,0 +1,43 @@
>> +From a4d6204b7fe5af89f7edfb9a6d8e58455ee73e46 Mon Sep 17 00:00:00 2001
>> +From: Srinuvasan A <srinuvasan.a@siemens.com>
>> +Date: Tue, 17 Jan 2023 19:06:50 +0530
>> +Subject: [PATCH] Lower requirements on setuptools
>> +
>> +Allows to build against Debian buster.
>=20
> Why do you drop the original patch, just to reintroduce it here again?

now we used debianized repo not the previous one, and setup.cfg file also c=
hanged, hence we need to rework the patch with debian/patch folder for appl=
ying patch for debianized repo.

>=20
>=20
>=20
>> +
>> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> +---
>> + .../0001-Lower-requirements-on-setuptools.diff | 13 +++++++++++++
>> + debian/patches/series | 1 +
>> + 2 files changed, 14 insertions(+)
>> + create mode 100644
>> debian/patches/0001-Lower-requirements-on-setuptools.diff
>> + create mode 100644 debian/patches/series
>> +
>> +diff --git a/debian/patches/0001-Lower-requirements-on-setuptools.diff
>> b/debian/patches/0001-Lower-requirements-on-setuptools.diff
>> +new file mode 100644
>> +index 0000000..257c054
>> +--- /dev/null
>> ++++ b/debian/patches/0001-Lower-requirements-on-setuptools.diff
>> +@@ -0,0 +1,13 @@
>> ++diff --git a/setup.cfg b/setup.cfg
>> ++index 77976c4..8857d32 100644
>> ++--- a/setup.cfg
>> +++++ b/setup.cfg
>> ++@@ -65,7 +65,7 @@ classifiers =3D
>> ++ Topic :: Utilities
>> ++
>> ++ [options]
>> ++-setup_requires =3D setuptools>=3D42; wheel; setuptools_scm[toml]>=3D3=
.4
>> +++setup_requires =3D setuptools>=3D40; setuptools_scm>=3D3.2
>> ++ install_requires =3D
>> ++ argparse; "3.0" <=3D python_version and python_version < "3.2"
>> ++ python_requires =3D >=3D3.2
>> +diff --git a/debian/patches/series b/debian/patches/series
>> +new file mode 100644
>> +index 0000000..804951a
>> +--- /dev/null
>> ++++ b/debian/patches/series
>> +@@ -0,0 +1 @@
>> ++0001-Lower-requirements-on-setuptools.diff
>> +--
>> +2.34.1
>> diff --git a/recipes-python/shtab/files/rules
>> b/recipes-python/shtab/files/rules
>> deleted file mode 100755
>> index 2dd07b2..0000000
>> --- a/recipes-python/shtab/files/rules
>> +++ /dev/null
>> @@ -1,21 +0,0 @@
>> -#!/usr/bin/make -f
>> -#
>> -# Copyright (c) Siemens AG, 2022
>> -#
>> -# Authors:
>> -# Felix Moessbauer <felix.moessbauer@siemens.com>
>> -#
>> -# This file is subject to the terms and conditions of the MIT License.
>> -# See COPYING.MIT file in the top-level directory.
>> -#
>> -
>> -export DH_VERBOSE=3D1
>> -export PYBUILD_VERBOSE=3D1
>> -export PYBUILD_NAME=3Dshtab
>> -
>> -ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
>> -export PYBUILD_DISABLE=3Dtest
>> -endif
>> -
>> -%:
>> - dh $@ --with python3 --buildsystem=3Dpybuild
>> diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb
>> b/recipes-python/shtab/python3-shtab_1.4.2.bb
>> deleted file mode 100644
>> index d03e694..0000000
>> --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
>> +++ /dev/null
>> @@ -1,36 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2022
>> -#
>> -# Authors:
>> -# Jan Kiszka <jan.kiszka@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -
>> -inherit dpkg
>> -
>> -SRC_URI =3D " \
>> - https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;dow=
nloadfilename=3D
>> ${PN}-${PV}.tar.gz \
>> - file://0001-Lower-requirements-on-setuptools.patch \
>> - file://rules \
>> - "
>> -SRC_URI[sha256sum] =3D
>> "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
>> -
>> -S =3D "${WORKDIR}/shtab-${PV}"
>> -
>> -DEBIAN_BUILD_DEPENDS =3D " \
>> - dh-python, \
>> - libpython3-all-dev, \
>> - python3-all-dev:any, \
>> - python3-setuptools, \
>> - python3-setuptools-scm:native, \
>> - "
>> -
>> -DEB_BUILD_PROFILES =3D "nocheck"
>> -
>> -do_prepare_build[cleandirs] +=3D "${S}/debian"
>> -do_prepare_build() {
>> - deb_debianize
>> -}
>> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> new file mode 100644
>> index 0000000..9d2b1f2
>> --- /dev/null
>> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> @@ -0,0 +1,31 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2022-2023
>> +#
>> +# Authors:
>> +# Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-gbp
>> +
>> +SRC_URI +=3D " \
>> +
>> git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=3D=
https;branch=3Dmain
>> \
>> + "
>> +# modify for debian bullseye build
>> +SRC_URI:append:bullseye =3D "
>> file://0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch"
>> +
>> +# modify for debian buster build
>> +SRC_URI:append:buster =3D " \
>> + file://0002-Lower-requirements-on-setuptools.patch \
>> + file://0003-Lower-requirements-on-setuptools.patch"
>> +
>> +SRCREV =3D"5650535ae4a1d34a21b55dc61e3e891d87a9712f"
>> +
>> +# We don't have pristine-tar in this tree hence use this option
>> +GBP_EXTRA_OPTIONS =3D "--git-no-pristine-tar"
>> +
>> +DEB_BUILD_PROFILES =3D "nocheck"
>> +DEB_BUILD_OPTIONS =3D "nocheck"
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

--2uiQXj376dK5uMLvb6wv
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 05:36 PM, Jan Kiszka wrote:<br />
<blockquote>On 24.04.23 13:55, Srinuvasan Arjunan wrote:<br />
<blockquote>From: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br /><br />=
Update shelltab to latest one.</blockquote>
...latest one of Debian bookworm, right?</blockquote>
&nbsp; &nbsp; &nbsp; &nbsp;yes jan<br />
<blockquote>
<blockquote>Signed-off-by: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br=
 />---<br />recipes-bsp/efibootguard/efibootguard_0.13.bb | 2 +-<br />...00=
1-Lower-requirements-on-setuptools.patch | 28 ------------<br />...ix-cross=
-build-issue-for-bullseye-im.patch | 33 ++++++++++++++<br />...002-Lower-re=
quirements-on-setuptools.patch | 36 ++++++++++++++++<br />...003-Lower-requ=
irements-on-setuptools.patch | 43 +++++++++++++++++++<br />recipes-python/s=
htab/files/rules | 21 ---------<br />recipes-python/shtab/python3-shtab_1.4=
.2.bb | 36 ----------------<br />recipes-python/shtab/python3-shtab_1.5.5-3=
.bb | 31 +++++++++++++<br />8 files changed, 144 insertions(+), 86 deletion=
s(-)<br />delete mode 100644 recipes-python/shtab/files/0001-Lower-requirem=
ents-on-setuptools.patch<br />create mode 100644 recipes-python/shtab/files=
/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch<br />creat=
e mode 100644 recipes-python/shtab/files/0002-Lower-requirements-on-setupto=
ols.patch<br />create mode 100644 recipes-python/shtab/files/0003-Lower-req=
uirements-on-setuptools.patch<br />delete mode 100755 recipes-python/shtab/=
files/rules<br />delete mode 100644 recipes-python/shtab/python3-shtab_1.4.=
2.bb<br />create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb<=
br /><br />diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/rec=
ipes-bsp/efibootguard/efibootguard_0.13.bb<br />index dd76198..313716a 1006=
44<br />--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb<br />+++ b/reci=
pes-bsp/efibootguard/efibootguard_0.13.bb<br />@@ -29,7 +29,7 @@ PROVIDES =
=3D "${PN}"<br />PROVIDES +=3D "${PN}-dev"<br /><br />DEPENDS =3D "python3-=
shtab"<br />-BUILD_DEB_DEPENDS =3D "debhelper,autoconf-archive,check,gnu-ef=
i,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"<br />+BUILD_DEB_DEPENDS =
=3D "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3=
-shtab:native,zlib1g-dev"<br />BUILD_DEB_DEPENDS:append:amd64 =3D ",libc6-d=
ev-i386"<br />BUILD_DEB_DEPENDS:append:i386 =3D ",libc6-dev-i386"<br /><br =
/>diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setupt=
ools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptoo=
ls.patch<br />deleted file mode 100644<br />index dccc2dd..0000000<br />---=
 a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch<b=
r />+++ /dev/null<br />@@ -1,28 +0,0 @@<br />-From d347695c4b173c94c4d8a678=
a67947de3ee5f186 Mon Sep 17 00:00:00 2001<br />-From: Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br />-Date: Mon, 14 Mar 2022 08:17:00 +0100<br />-Subj=
ect: [PATCH] Lower requirements on setuptools<br />-<br />-Allows to build =
against Debian buster.<br />-<br />-Signed-off-by: Jan Kiszka &lt;jan.kiszk=
a@siemens.com&gt;<br />----<br />- setup.cfg | 2 +-<br />- 1 file changed, =
1 insertion(+), 1 deletion(-)<br />-<br />-diff --git a/setup.cfg b/setup.c=
fg<br />-index 55eecd4..186aad6 100644<br />---- a/setup.cfg<br />-+++ b/se=
tup.cfg<br />-@@ -66,7 +66,7 @@ classifiers=3D<br />- Topic :: Terminals<br=
 />- Topic :: Utilities<br />- [options]<br />--setup_requires=3Dsetuptools=
&gt;=3D42; setuptools_scm[toml]&gt;=3D3.4<br />-+setup_requires=3Dsetuptool=
s&gt;=3D40; setuptools_scm&gt;=3D3.2<br />- install_requires=3D<br />- argp=
arse; python_version &lt; "2.7" or ("3.0" &lt;=3D python_version and python=
_version &lt; "3.2")<br />- python_requires=3D &gt;=3D2.7, !=3D3.0.*, !=3D3=
.1.*<br />--- <br />-2.34.1<br />-<br />diff --git a/recipes-python/shtab/f=
iles/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch b/reci=
pes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullse=
ye-im.patch<br />new file mode 100644<br />index 0000000..9fb17de<br />--- =
/dev/null<br />+++ b/recipes-python/shtab/files/0001-debian-control-Fix-cro=
ss-build-issue-for-bullseye-im.patch<br />@@ -0,0 +1,33 @@<br />+From 66147=
2b5fb651a140cd9852fef4b797b8535fedf Mon Sep 17 00:00:00 2001<br />+From: Sr=
inuvasan A &lt;srinuvasan.a@siemens.com&gt;<br />+Date: Mon, 16 Jan 2023 13=
:55:23 +0530<br />+Subject: [PATCH] debian/control: Fix cross build issue f=
or bullseye images<br />+<br />+Fix cross build issues for bullseye images.=
<br />+</blockquote>
And this one was also submitted to Debian upstream?</blockquote>
&nbsp; &nbsp; &nbsp; &nbsp;yes will send this changes to debian upstream<br=
 />
<blockquote>
<blockquote>+Signed-off-by: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<b=
r />+---<br />+ debian/control | 8 +++++---<br />+ 1 file changed, 5 insert=
ions(+), 3 deletions(-)<br />+<br />+diff --git a/debian/control b/debian/c=
ontrol<br />+index b30beb1..a63e366 100644<br />+--- a/debian/control<br />=
++++ b/debian/control<br />+@@ -6,9 +6,11 @@ Uploaders: Felix Moessbauer &l=
t;felix.moessbauer@siemens.com&gt;<br />+ Build-Depends: debhelper-compat (=
=3D 13),<br />+ dh-python,<br />+ python3-setuptools (&gt;=3D42),<br />+- p=
ython3-setuptools-scm (&gt;=3D3.4),<br />+- python3-all (&gt;=3D3.2),<br />=
+- python3-wheel,<br />++ python3-setuptools-scm:native (&gt;=3D3.4),<br />=
++ libpython3-all-dev (&gt;=3D3.2),<br />++ python3-all-dev:any (&gt;=3D3.2=
),<br />++ python3-wheel:native,<br />++ python3-toml:native,<br />+ python=
3-pytest &lt;!nocheck&gt;,<br />+ python3-pytest-cov &lt;!nocheck&gt;,<br /=
>+ python3-pytest-timeout &lt;!nocheck&gt;,<br />+-- <br />+2.34.1<br />dif=
f --git a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.=
patch b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.pa=
tch<br />new file mode 100644<br />index 0000000..1db4fa8<br />--- /dev/nul=
l<br />+++ b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptoo=
ls.patch<br />@@ -0,0 +1,36 @@<br />+From 1d2e28a3da03815d16e0fb6dc11428509=
f4ed366 Mon Sep 17 00:00:00 2001<br />+From: Srinuvasan A &lt;srinuvasan.a@=
siemens.com&gt;<br />+Date: Tue, 17 Jan 2023 18:54:33 +0530<br />+Subject: =
[PATCH] Lower requirements on setuptools<br />+<br />+Allows to build again=
st Debian buster and fix cross build issues.<br />+<br />+Signed-off-by: Sr=
inuvasan A &lt;srinuvasan.a@siemens.com&gt;<br />+---<br />+ debian/control=
 | 10 +++++-----<br />+ 1 file changed, 5 insertions(+), 5 deletions(-)<br =
/>+<br />+diff --git a/debian/control b/debian/control<br />+index b30beb1.=
.380b934 100644<br />+--- a/debian/control<br />++++ b/debian/control<br />=
+@@ -3,12 +3,12 @@ Section: python<br />+ Priority: optional<br />+ Maintai=
ner: Debian Python Team &lt;team+python@tracker.debian.org&gt;<br />+ Uploa=
ders: Felix Moessbauer &lt;felix.moessbauer@siemens.com&gt;<br />+-Build-De=
pends: debhelper-compat (=3D 13),<br />++Build-Depends: debhelper-compat (=
=3D 12),<br />+ dh-python,<br />+- python3-setuptools (&gt;=3D42),<br />+- =
python3-setuptools-scm (&gt;=3D3.4),<br />+- python3-all (&gt;=3D3.2),<br /=
>+- python3-wheel,<br />++ python3-setuptools (&gt;=3D40),<br />++ python3-=
setuptools-scm:native (&gt;=3D3.2),<br />++ libpython3-all-dev (&gt;=3D3.2)=
,<br />++ python3-all-dev:any (&gt;=3D3.2),<br />+ python3-pytest &lt;!noch=
eck&gt;,<br />+ python3-pytest-cov &lt;!nocheck&gt;,<br />+ python3-pytest-=
timeout &lt;!nocheck&gt;,<br />+-- <br />+2.34.1<br />diff --git a/recipes-=
python/shtab/files/0003-Lower-requirements-on-setuptools.patch b/recipes-py=
thon/shtab/files/0003-Lower-requirements-on-setuptools.patch<br />new file =
mode 100644<br />index 0000000..9687222<br />--- /dev/null<br />+++ b/recip=
es-python/shtab/files/0003-Lower-requirements-on-setuptools.patch<br />@@ -=
0,0 +1,43 @@<br />+From a4d6204b7fe5af89f7edfb9a6d8e58455ee73e46 Mon Sep 17=
 00:00:00 2001<br />+From: Srinuvasan A &lt;srinuvasan.a@siemens.com&gt;<br=
 />+Date: Tue, 17 Jan 2023 19:06:50 +0530<br />+Subject: [PATCH] Lower requ=
irements on setuptools<br />+<br />+Allows to build against Debian buster.<=
/blockquote>
Why do you drop the original patch, just to reintroduce it here again?</blo=
ckquote>
&nbsp; &nbsp; &nbsp; now we used debianized repo not the previous one, and =
setup.cfg file also changed, hence we need to rework the patch with debian/=
patch folder for applying patch for debianized repo.<br />
<blockquote><br />
<blockquote>+<br />+Signed-off-by: Srinuvasan A &lt;srinuvasan.a@siemens.co=
m&gt;<br />+---<br />+ .../0001-Lower-requirements-on-setuptools.diff | 13 =
+++++++++++++<br />+ debian/patches/series | 1 +<br />+ 2 files changed, 14=
 insertions(+)<br />+ create mode 100644 debian/patches/0001-Lower-requirem=
ents-on-setuptools.diff<br />+ create mode 100644 debian/patches/series<br =
/>+<br />+diff --git a/debian/patches/0001-Lower-requirements-on-setuptools=
.diff b/debian/patches/0001-Lower-requirements-on-setuptools.diff<br />+new=
 file mode 100644<br />+index 0000000..257c054<br />+--- /dev/null<br />+++=
+ b/debian/patches/0001-Lower-requirements-on-setuptools.diff<br />+@@ -0,0=
 +1,13 @@<br />++diff --git a/setup.cfg b/setup.cfg<br />++index 77976c4..8=
857d32 100644<br />++--- a/setup.cfg<br />+++++ b/setup.cfg<br />++@@ -65,7=
 +65,7 @@ classifiers =3D<br />++ Topic :: Utilities<br />++ <br />++ [opti=
ons]<br />++-setup_requires =3D setuptools&gt;=3D42; wheel; setuptools_scm[=
toml]&gt;=3D3.4<br />+++setup_requires =3D setuptools&gt;=3D40; setuptools_=
scm&gt;=3D3.2<br />++ install_requires =3D <br />++ argparse; "3.0" &lt;=3D=
 python_version and python_version &lt; "3.2"<br />++ python_requires =3D &=
gt;=3D3.2<br />+diff --git a/debian/patches/series b/debian/patches/series<=
br />+new file mode 100644<br />+index 0000000..804951a<br />+--- /dev/null=
<br />++++ b/debian/patches/series<br />+@@ -0,0 +1 @@<br />++0001-Lower-re=
quirements-on-setuptools.diff<br />+-- <br />+2.34.1<br />diff --git a/reci=
pes-python/shtab/files/rules b/recipes-python/shtab/files/rules<br />delete=
d file mode 100755<br />index 2dd07b2..0000000<br />--- a/recipes-python/sh=
tab/files/rules<br />+++ /dev/null<br />@@ -1,21 +0,0 @@<br />-#!/usr/bin/m=
ake -f<br />-#<br />-# Copyright (c) Siemens AG, 2022<br />-#<br />-# Autho=
rs:<br />-# Felix Moessbauer &lt;felix.moessbauer@siemens.com&gt;<br />-#<b=
r />-# This file is subject to the terms and conditions of the MIT License.=
<br />-# See COPYING.MIT file in the top-level directory.<br />-#<br />-<br=
 />-export DH_VERBOSE=3D1<br />-export PYBUILD_VERBOSE=3D1<br />-export PYB=
UILD_NAME=3Dshtab<br />-<br />-ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES=
)),)<br />-export PYBUILD_DISABLE=3Dtest<br />-endif<br />-<br />-%:<br />-=
 dh $@ --with python3 --buildsystem=3Dpybuild<br />diff --git a/recipes-pyt=
hon/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2=
.bb<br />deleted file mode 100644<br />index d03e694..0000000<br />--- a/re=
cipes-python/shtab/python3-shtab_1.4.2.bb<br />+++ /dev/null<br />@@ -1,36 =
+0,0 @@<br />-#<br />-# CIP Core, generic profile<br />-#<br />-# Copyright=
 (c) Siemens AG, 2022<br />-#<br />-# Authors:<br />-# Jan Kiszka &lt;jan.k=
iszka@siemens.com&gt;<br />-#<br />-# SPDX-License-Identifier: MIT<br />-#<=
br />-<br />-inherit dpkg<br />-<br />-SRC_URI =3D " \<br />- <a href=3D"ht=
tps://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfi=
lename=3D" target=3D"_blank" rel=3D"noopener">https://github.com/iterative/=
shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=3D</a>${PN}-${PV}.ta=
r.gz \<br />- file://0001-Lower-requirements-on-setuptools.patch \<br />- f=
ile://rules \<br />- "<br />-SRC_URI[sha256sum] =3D "5e6ef745c223ef1a01a2db=
491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"<br />-<br />-S =3D "${WORKDIR}/=
shtab-${PV}"<br />-<br />-DEBIAN_BUILD_DEPENDS =3D " \<br />- dh-python, \<=
br />- libpython3-all-dev, \<br />- python3-all-dev:any, \<br />- python3-s=
etuptools, \<br />- python3-setuptools-scm:native, \<br />- "<br />-<br />-=
DEB_BUILD_PROFILES =3D "nocheck"<br />-<br />-do_prepare_build[cleandirs] +=
=3D "${S}/debian"<br />-do_prepare_build() {<br />- deb_debianize<br />-}<b=
r />diff --git a/recipes-python/shtab/python3-shtab_1.5.5-3.bb b/recipes-py=
thon/shtab/python3-shtab_1.5.5-3.bb<br />new file mode 100644<br />index 00=
00000..9d2b1f2<br />--- /dev/null<br />+++ b/recipes-python/shtab/python3-s=
htab_1.5.5-3.bb<br />@@ -0,0 +1,31 @@<br />+#<br />+# CIP Core, generic pro=
file<br />+#<br />+# Copyright (c) Siemens AG, 2022-2023<br />+#<br />+# Au=
thors:<br />+# Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br />+#<br />+# SP=
DX-License-Identifier: MIT<br />+#<br />+<br />+inherit dpkg-gbp<br />+<br =
/>+SRC_URI +=3D " \<br />+ git://salsa.debian.org/python-team/packages/pyth=
on-shtab.git;protocol=3Dhttps;branch=3Dmain \<br />+ "<br />+# modify for d=
ebian bullseye build<br />+SRC_URI:append:bullseye =3D " file://0001-debian=
-control-Fix-cross-build-issue-for-bullseye-im.patch"<br />+<br />+# modify=
 for debian buster build<br />+SRC_URI:append:buster =3D " \<br />+ file://=
0002-Lower-requirements-on-setuptools.patch \<br />+ file://0003-Lower-requ=
irements-on-setuptools.patch"<br />+<br />+SRCREV =3D"5650535ae4a1d34a21b55=
dc61e3e891d87a9712f"<br />+<br />+# We don't have pristine-tar in this tree=
 hence use this option<br />+GBP_EXTRA_OPTIONS =3D "--git-no-pristine-tar"<=
br />+<br />+DEB_BUILD_PROFILES =3D "nocheck"<br />+DEB_BUILD_OPTIONS =3D "=
nocheck"</blockquote>
Jan<br /><br />-- <br />Siemens AG, Technology<br />Competence Center Embed=
ded Linux</blockquote>

--2uiQXj376dK5uMLvb6wv--

