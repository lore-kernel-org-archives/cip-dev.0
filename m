Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC1C433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 18:08:06 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.2.1633543684682545135
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 11:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 196I80JP012911
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 6 Oct 2021 20:08:01 +0200
Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196I7xAn022790;
	Wed, 6 Oct 2021 20:08:00 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] swupdate: Use dpkg-gbp build
 with salsa
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
 <20211005141346.2682677-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3a63bf38-97f0-5418-198b-e5654e2dc216@siemens.com>
Date: Wed, 6 Oct 2021 20:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005141346.2682677-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id
 196I80JP012911
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 18:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6797

On 05.10.21 16:13, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This reduce the maintaince effort for SWUpdate in Debian 11(Bullseye)
> and later.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-bullseye.conf            |  1 +
>  conf/distro/cip-core-buster.conf              |  1 +
>  ...dd-option-to-build-with-efibootguard.patch | 39 ++++++++++
>  .../0002-debian-rules-Add-CONFIG_MTD.patch    | 27 +++++++
>  ...-debian-config-Make-signing-optional.patch | 40 +++++++++++
>  ...onfig-Make-image-encryption-optional.patch | 40 +++++++++++
>  ...ules-Add-Embedded-Lua-handler-option.patch | 30 ++++++++
>  ...es-Add-option-to-disable-fs-creation.patch | 47 ++++++++++++
>  ...ules-Add-option-to-disable-webserver.patch | 42 +++++++++++
>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch | 40 +++++++++++
>  ...ules-Add-Embedded-Lua-handler-option.patch | 30 ++++++++
>  ...prepare-build-for-isar-debian-buster.patch | 72 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.inc            | 54 ++++++++++++++
>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb | 47 ++++++++++++
>  14 files changed, 510 insertions(+)
>  create mode 100644 recipes-core/swupdate/files/0001-debian-Add-option-=
to-build-with-efibootguard.patch
>  create mode 100644 recipes-core/swupdate/files/0002-debian-rules-Add-C=
ONFIG_MTD.patch
>  create mode 100644 recipes-core/swupdate/files/0003-debian-config-Make=
-signing-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0004-debian-config-Make=
-image-encryption-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-E=
mbedded-Lua-handler-option.patch
>  create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-o=
ption-to-disable-fs-creation.patch
>  create mode 100644 recipes-core/swupdate/files/0006-debian-rules-Add-o=
ption-to-disable-webserver.patch
>  create mode 100644 recipes-core/swupdate/files/0007-debian-Make-CONFIG=
_HW_COMPATIBILTY-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0008-debian-rules-Add-E=
mbedded-Lua-handler-option.patch
>  create mode 100644 recipes-core/swupdate/files/0009-debian-prepare-bui=
ld-for-isar-debian-buster.patch
>  create mode 100644 recipes-core/swupdate/swupdate.inc
>  create mode 100644 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp=
.bb
>=20
> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-=
bullseye.conf
> index 38014b4..9357b6c 100644
> --- a/conf/distro/cip-core-bullseye.conf
> +++ b/conf/distro/cip-core-bullseye.conf
> @@ -14,3 +14,4 @@ require cip-core-common.inc
> =20
>  PREFERRED_VERSION_linux-cip ?=3D "4.19.%"
>  PREFERRED_VERSION_linux-cip-rt ?=3D "4.19.%"
> +PREFERRED_VERSION_swupdate ?=3D "2021.04-1+debian-gbp"
> diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-bu=
ster.conf
> index c5cb39c..61fcb41 100644
> --- a/conf/distro/cip-core-buster.conf
> +++ b/conf/distro/cip-core-buster.conf
> @@ -14,3 +14,4 @@ require cip-core-common.inc
> =20
>  PREFERRED_VERSION_linux-cip ?=3D "4.19.%"
>  PREFERRED_VERSION_linux-cip-rt ?=3D "4.19.%"
> +PREFERRED_VERSION_swupdate ?=3D "2021.4-git+isar"
> diff --git a/recipes-core/swupdate/files/0001-debian-Add-option-to-buil=
d-with-efibootguard.patch b/recipes-core/swupdate/files/0001-debian-Add-o=
ption-to-build-with-efibootguard.patch
> new file mode 100644
> index 0000000..00f9a5f
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-=
efibootguard.patch
> @@ -0,0 +1,39 @@
> +From fe3f090e3764e1e2625d509a56bd521bab507ce7 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 15 Sep 2021 12:36:09 +0200
> +Subject: [PATCH 1/9] debian: Add option to build with efibootguard
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/control | 1 +
> + debian/rules   | 2 ++
> + 2 files changed, 3 insertions(+)
> +
> +diff --git a/debian/control b/debian/control
> +index 9e43eab..6031537 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -28,6 +28,7 @@ Build-Depends: debhelper-compat (=3D 13),
> +                libwebsockets-dev (>=3D 3.2.0) <!pkg.swupdate.bpo>,
> +                liburiparser-dev <!pkg.swupdate.bpo>,
> +                libubootenv-dev <pkg.swupdate.uboot>,
> ++               efibootguard-dev <pkg.swupdate.efibootguard>,
> +                libcmocka-dev,
> +                pkg-config,
> +                gawk,
> +diff --git a/debian/rules b/debian/rules
> +index 4b55be2..c076839 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -33,6 +33,8 @@ ifneq (,$(filter pkg.swupdate.uboot,$(DEB_BUILD_PROF=
ILES)))
> + else ifneq (,$(filter pkg.swupdate.grub,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_BOOTLOADER_GRUB=3Dy                   >> configs/debian_=
defconfig
> + 	echo CONFIG_GRUBENV_PATH=3D\"/boot/grub/grubenv\" >> configs/debian_=
defconfig
> ++else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)=
))
> ++	echo CONFIG_BOOTLOADER_EBG=3Dy                    >> configs/debian_=
defconfig
> + else
> + 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_=
defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_M=
TD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.p=
atch
> new file mode 100644
> index 0000000..0921aef
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patc=
h
> @@ -0,0 +1,27 @@
> +From 43365f98d70d83dac42913ff907a8a9dd25a4333 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 11:29:57 +0200
> +Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
> +
> +if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 1 +
> + 1 file changed, 1 insertion(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index c076839..292133b 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -20,6 +20,7 @@ endif
> + override_dh_auto_configure:
> + 	cp debian/configs/defconfig  configs/debian_defconfig
> + ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_MTD=3Dy                  >> configs/debian_defconfig
> + 	echo CONFIG_SWUFORWARDER_HANDLER=3Dy >> configs/debian_defconfig
> + 	echo CONFIG_CFI=3Dy                  >> configs/debian_defconfig
> + 	echo CONFIG_CFIHAMMING1=3Dy          >> configs/debian_defconfig
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0003-debian-config-Make-signin=
g-optional.patch b/recipes-core/swupdate/files/0003-debian-config-Make-si=
gning-optional.patch
> new file mode 100644
> index 0000000..347b316
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0003-debian-config-Make-signing-optio=
nal.patch
> @@ -0,0 +1,40 @@
> +From 37f9afeeac5483f677b5be41b3d31e6557fcc146 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 15:27:51 +0200
> +Subject: [PATCH 3/9] debian/config: Make signing optional
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/configs/defconfig | 1 -
> + debian/rules             | 3 +++
> + 2 files changed, 3 insertions(+), 1 deletion(-)
> +
> +diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> +index b38aa62..f959e44 100644
> +--- a/debian/configs/defconfig
> ++++ b/debian/configs/defconfig
> +@@ -2,7 +2,6 @@ CONFIG_SYSTEMD=3Dy
> + CONFIG_HW_COMPATIBILITY=3Dy
> + CONFIG_DOWNLOAD=3Dy
> + CONFIG_DOWNLOAD_SSL=3Dy
> +-CONFIG_SIGNED_IMAGES=3Dy
> + CONFIG_SIGALG_CMS=3Dy
> + CONFIG_ENCRYPTED_IMAGES=3Dy
> + CONFIG_SURICATTA=3Dy
> +diff --git a/debian/rules b/debian/rules
> +index 292133b..4793c84 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DE=
B_BUILD_PROFILES)))
> + else
> + 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_=
defconfig
> + endif
> ++ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
> ++endif
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0004-debian-config-Make-image-=
encryption-optional.patch b/recipes-core/swupdate/files/0004-debian-confi=
g-Make-image-encryption-optional.patch
> new file mode 100644
> index 0000000..45990f8
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0004-debian-config-Make-image-encrypt=
ion-optional.patch
> @@ -0,0 +1,40 @@
> +From b0cfcc9980c6daf6383c6dc51fdbe90e1c7625d5 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 15:28:21 +0200
> +Subject: [PATCH 4/9] debian/config: Make image encryption optional
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/configs/defconfig | 1 -
> + debian/rules             | 3 +++
> + 2 files changed, 3 insertions(+), 1 deletion(-)
> +
> +diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> +index f959e44..8e1a810 100644
> +--- a/debian/configs/defconfig
> ++++ b/debian/configs/defconfig
> +@@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=3Dy
> + CONFIG_DOWNLOAD=3Dy
> + CONFIG_DOWNLOAD_SSL=3Dy
> + CONFIG_SIGALG_CMS=3Dy
> +-CONFIG_ENCRYPTED_IMAGES=3Dy
> + CONFIG_SURICATTA=3Dy
> + CONFIG_SURICATTA_SSL=3Dy
> + CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
> +diff --git a/debian/rules b/debian/rules
> +index 4793c84..6d32d50 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -42,6 +42,9 @@ endif
> + ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
> + endif
> ++ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_ENCRYPTED_IMAGES=3Dy >> configs/debian_defconfig
> ++endif
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded=
-Lua-handler-option.patch b/recipes-core/swupdate/files/0005-debian-rules=
-Add-Embedded-Lua-handler-option.patch
> new file mode 100644
> index 0000000..84665cd
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-ha=
ndler-option.patch
> @@ -0,0 +1,30 @@
> +From 0200687ad67d6e5a0e9bbdf2e8c86e3f8e717c5e Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 11:32:41 +0200
> +Subject: [PATCH 5/6] debian/rules: Add Embedded Lua handler option
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 5 +++++
> + 1 file changed, 5 insertions(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index 69fd790..9ace348 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -52,7 +52,12 @@ ifneq (,$(LUA_VERSION))
> + 	echo CONFIG_LUAPKG=3D\"lua$(LUA_VERSION)\" >> configs/debian_defconf=
ig
> + 	echo CONFIG_LUASCRIPTHANDLER=3Dy           >> configs/debian_defconf=
ig
> + 	echo CONFIG_HANDLER_IN_LUA=3Dy             >> configs/debian_defconf=
ig
> ++ifneq (,$(filter pkg.swupdate.embeddedlua,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_EMBEDDED_LUA_HANDLER=3Dy                              >>=
 configs/debian_defconfig
> ++	echo CONFIG_EMBEDDED_LUA_HANDLER_SOURCE=3D\"/usr/share/lua/$(LUA_VER=
SION)/swupdate_handlers.lua\" >> configs/debian_defconfig
> + endif
> ++endif
> ++
> + 	echo CONFIG_EXTRA_CFLAGS=3D\"$(CFLAGS) $(CPPFLAGS)\" >> configs/debi=
an_defconfig
> + 	echo CONFIG_EXTRA_LDFLAGS=3D\"$(LDFLAGS)\"           >> configs/debi=
an_defconfig
> + 	echo CONFIG_EXTRA_LDLIBS=3D\"$(LDLIBS)\"             >> configs/debi=
an_defconfig
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-option-t=
o-disable-fs-creation.patch b/recipes-core/swupdate/files/0005-debian-rul=
es-Add-option-to-disable-fs-creation.patch
> new file mode 100644
> index 0000000..1121923
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disab=
le-fs-creation.patch
> @@ -0,0 +1,47 @@
> +From 22a96e95676123c6ce8800b9d911402704dce9e2 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Mon, 4 Oct 2021 17:15:56 +0200
> +Subject: [PATCH 5/9] debian/rules: Add option to disable fs creation
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/configs/defconfig | 4 ----
> + debian/rules             | 7 +++++++
> + 2 files changed, 7 insertions(+), 4 deletions(-)
> +
> +diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> +index 8e1a810..d011deb 100644
> +--- a/debian/configs/defconfig
> ++++ b/debian/configs/defconfig
> +@@ -9,10 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
> + CONFIG_WEBSERVER=3Dy
> + CONFIG_MONGOOSESSL=3Dy
> + CONFIG_ZSTD=3Dy
> +-CONFIG_DISKPART=3Dy
> +-CONFIG_DISKFORMAT=3Dy
> +-CONFIG_FAT_FILESYSTEM=3Dy
> +-CONFIG_EXT_FILESYSTEM=3Dy
> + CONFIG_UNIQUEUUID=3Dy
> + CONFIG_RAW=3Dy
> + CONFIG_RDIFFHANDLER=3Dy
> +diff --git a/debian/rules b/debian/rules
> +index 6d32d50..9349c22 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -45,6 +45,13 @@ endif
> + ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_ENCRYPTED_IMAGES=3Dy >> configs/debian_defconfig
> + endif
> ++ifeq (,$(filter pkg.swupdate.nocreatefs,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_DISKPART=3Dy       >> configs/debian_defconfig
> ++	echo CONFIG_DISKFORMAT=3Dy     >> configs/debian_defconfig
> ++	echo CONFIG_FAT_FILESYSTEM=3Dy >> configs/debian_defconfig
> ++	echo CONFIG_EXT_FILESYSTEM=3Dy >> configs/debian_defconfig
> ++endif
> ++
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-option-t=
o-disable-webserver.patch b/recipes-core/swupdate/files/0006-debian-rules=
-Add-option-to-disable-webserver.patch
> new file mode 100644
> index 0000000..23a456d
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disab=
le-webserver.patch
> @@ -0,0 +1,42 @@
> +From 9caabe416aca7ca2bf1cd2d8be89cfc89cedf6cd Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Mon, 4 Oct 2021 17:27:11 +0200
> +Subject: [PATCH 6/9] debian/rules: Add option to disable webserver
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/configs/defconfig | 2 --
> + debian/rules             | 4 ++++
> + 2 files changed, 4 insertions(+), 2 deletions(-)
> +
> +diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> +index d011deb..337fcce 100644
> +--- a/debian/configs/defconfig
> ++++ b/debian/configs/defconfig
> +@@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=3Dy
> + CONFIG_SURICATTA=3Dy
> + CONFIG_SURICATTA_SSL=3Dy
> + CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
> +-CONFIG_WEBSERVER=3Dy
> +-CONFIG_MONGOOSESSL=3Dy
> + CONFIG_ZSTD=3Dy
> + CONFIG_UNIQUEUUID=3Dy
> + CONFIG_RAW=3Dy
> +diff --git a/debian/rules b/debian/rules
> +index 9349c22..4574b18 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(D=
EB_BUILD_PROFILES)))
> + else
> + 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_=
defconfig
> + endif
> ++ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_WEBSERVER=3Dy   >> configs/debian_defconfig
> ++	echo CONFIG_MONGOOSESSL=3Dy >> configs/debian_defconfig
> ++endif
> + ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COM=
PATIBILTY-optional.patch b/recipes-core/swupdate/files/0007-debian-Make-C=
ONFIG_HW_COMPATIBILTY-optional.patch
> new file mode 100644
> index 0000000..c2d37a9
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBIL=
TY-optional.patch
> @@ -0,0 +1,40 @@
> +From 538e54a36b24eb6caf49d7dca91598fa9fc86713 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Tue, 5 Oct 2021 10:56:25 +0200
> +Subject: [PATCH 7/9] debian: Make CONFIG_HW_COMPATIBILTY optional
> +
> +Add option for qemu.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/configs/defconfig | 1 -
> + debian/rules             | 3 +++
> + 2 files changed, 3 insertions(+), 1 deletion(-)
> +
> +diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> +index 337fcce..6fc1137 100644
> +--- a/debian/configs/defconfig
> ++++ b/debian/configs/defconfig
> +@@ -1,5 +1,4 @@
> + CONFIG_SYSTEMD=3Dy
> +-CONFIG_HW_COMPATIBILITY=3Dy
> + CONFIG_DOWNLOAD=3Dy
> + CONFIG_DOWNLOAD_SSL=3Dy
> + CONFIG_SIGALG_CMS=3Dy
> +diff --git a/debian/rules b/debian/rules
> +index 4574b18..9a4b0d4 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DE=
B_BUILD_PROFILES)))
> + else
> + 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_=
defconfig
> + endif
> ++ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_HW_COMPATIBILITY=3Dy                   >> configs/debian=
_defconfig
> ++endif
> + ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_WEBSERVER=3Dy   >> configs/debian_defconfig
> + 	echo CONFIG_MONGOOSESSL=3Dy >> configs/debian_defconfig
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded=
-Lua-handler-option.patch b/recipes-core/swupdate/files/0008-debian-rules=
-Add-Embedded-Lua-handler-option.patch
> new file mode 100644
> index 0000000..44a83c4
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-ha=
ndler-option.patch
> @@ -0,0 +1,30 @@
> +From c2f07b552c6d83562fed5452bc778ae0e5e19cd4 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 11:32:41 +0200
> +Subject: [PATCH 8/9] debian/rules: Add Embedded Lua handler option
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 5 +++++
> + 1 file changed, 5 insertions(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index 9a4b0d4..a1f73fd 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -66,7 +66,12 @@ ifneq (,$(LUA_VERSION))
> + 	echo CONFIG_LUAPKG=3D\"lua$(LUA_VERSION)\" >> configs/debian_defconf=
ig
> + 	echo CONFIG_LUASCRIPTHANDLER=3Dy           >> configs/debian_defconf=
ig
> + 	echo CONFIG_HANDLER_IN_LUA=3Dy             >> configs/debian_defconf=
ig
> ++ifneq (,$(filter pkg.swupdate.embeddedlua,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_EMBEDDED_LUA_HANDLER=3Dy                              >>=
 configs/debian_defconfig
> ++	echo CONFIG_EMBEDDED_LUA_HANDLER_SOURCE=3D\"/usr/share/lua/$(LUA_VER=
SION)/swupdate_handlers.lua\" >> configs/debian_defconfig
> + endif
> ++endif
> ++
> + 	echo CONFIG_EXTRA_CFLAGS=3D\"$(CFLAGS) $(CPPFLAGS)\" >> configs/debi=
an_defconfig
> + 	echo CONFIG_EXTRA_LDFLAGS=3D\"$(LDFLAGS)\"           >> configs/debi=
an_defconfig
> + 	echo CONFIG_EXTRA_LDLIBS=3D\"$(LDLIBS)\"             >> configs/debi=
an_defconfig
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/files/0009-debian-prepare-build-for-=
isar-debian-buster.patch b/recipes-core/swupdate/files/0009-debian-prepar=
e-build-for-isar-debian-buster.patch
> new file mode 100644
> index 0000000..8462951
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-de=
bian-buster.patch
> @@ -0,0 +1,72 @@
> +From 16dd48c2282aba91f8fc1f458f7b0c06504cac19 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 29 Sep 2021 16:17:03 +0200
> +Subject: [PATCH 9/9] debian: prepare build for isar debian buster
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/compat  |  1 +
> + debian/control | 10 +++++-----
> + debian/rules   |  4 +++-
> + 3 files changed, 9 insertions(+), 6 deletions(-)
> + create mode 100644 debian/compat
> +
> +diff --git a/debian/compat b/debian/compat
> +new file mode 100644
> +index 0000000..f599e28
> +--- /dev/null
> ++++ b/debian/compat
> +@@ -0,0 +1 @@
> ++10
> +diff --git a/debian/control b/debian/control
> +index 6031537..710cb2d 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -4,7 +4,7 @@ Priority: optional
> + Maintainer: Stefano Babic <sbabic@denx.de>
> + Uploaders: SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) <szlin@debian.org>,
> +            Nobuhiro Iwamatsu <iwamatsu@debian.org>
> +-Build-Depends: debhelper-compat (=3D 13),
> ++Build-Depends: debhelper,
> +                dh-lua:native <!nolua>,
> +                liblua5.2-dev <!nolua>,
> +                libfdisk-dev,
> +@@ -23,10 +23,10 @@ Build-Depends: debhelper-compat (=3D 13),
> +                libzstd-dev,
> +                libp11-kit-dev <pkg.swupdate.p11>,
> +                libwolfssl-dev <pkg.swupdate.p11>,
> +-               libmtd-dev <!pkg.swupdate.bpo>,
> +-               libubi-dev <!pkg.swupdate.bpo>,
> +-               libwebsockets-dev (>=3D 3.2.0) <!pkg.swupdate.bpo>,
> +-               liburiparser-dev <!pkg.swupdate.bpo>,
> ++               libmtd-dev <pkg.swupdate.mtd> <pkg.swupdate.ubi>,
> ++               libubi-dev <pkg.swupdate.ubi>,
> ++               libwebsockets-dev,
> ++               liburiparser-dev,
> +                libubootenv-dev <pkg.swupdate.uboot>,
> +                efibootguard-dev <pkg.swupdate.efibootguard>,
> +                libcmocka-dev,
> +diff --git a/debian/rules b/debian/rules
> +index a1f73fd..a2ae1ac 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -19,13 +19,15 @@ endif
> +=20
> + override_dh_auto_configure:
> + 	cp debian/configs/defconfig  configs/debian_defconfig
> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> ++ifneq (,$(filter pkg.swupdate.mtd,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_MTD=3Dy                  >> configs/debian_defconfig
> ++ifneq (,$(filter pkg.swupdate.ubi,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_SWUFORWARDER_HANDLER=3Dy >> configs/debian_defconfig
> + 	echo CONFIG_CFI=3Dy                  >> configs/debian_defconfig
> + 	echo CONFIG_CFIHAMMING1=3Dy          >> configs/debian_defconfig
> + 	echo CONFIG_UBIVOL=3Dy               >> configs/debian_defconfig
> + 	echo CONFIG_SSBLSWITCH=3Dy           >> configs/debian_defconfig
> ++endif
> + else
> + 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
> + endif
> +--=20
> +2.30.2
> +
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate=
/swupdate.inc
> new file mode 100644
> index 0000000..a7fd662
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -0,0 +1,54 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +DESCRIPTION =3D "swupdate utility for software updates"
> +HOMEPAGE=3D "https://github.com/sbabic/swupdate"
> +LICENSE =3D "GPL-2.0"
> +LIC_FILES_CHKSUM =3D "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;m=
d5=3D751419260aa954499f7abaabaa882bbe"
> +
> +

Extra linefeed.

> +def get_bootloader_build_profile(d):
> +    bootloader =3D d.getVar("SWUPDATE_BOOTLOADER", True) or ""

expand=3DTrue is the default for for getVar, so you can drop the True.

> +    if bootloader =3D=3D "efibootguard":
> +        return "pkg.swupdate.efibootguard"
> +    if bootloader =3D=3D "u-boot":
> +        return "pkg.swupdate.uboot"
> +    return ""
> +
> +SWUPDATE_BUILD_PROFILES +=3D "${@get_bootloader_build_profile(d)}"
> +
> +def get_bootloader_dependencies(d):
> +    bootloader =3D d.getVar("SWUPDATE_BOOTLOADER", True) or ""
> +    if bootloader =3D=3D "efibootguard":
> +        return "efibootguard-dev"
> +    if bootloader =3D=3D "u-boot":
> +        if d.getVar("U_BOOT_CONFIG_PACKAGE", True) =3D=3D "1":
> +            return "libubootenv u-boot-{}-config".format(d.getVar("MAC=
HINE", TRUE))
> +        else:
> +            return "libubootenv"
> +    return ""
> +
> +DEPENDS +=3D "${@get_bootloader_dependencies(d)}"
> +DEPENDS +=3D "${@bb.utils.contains('SWUPDATE_BUILD_PROFILES', 'mtd', '=
mtd-utils', '', d)}"
> +
> +do_install_builddeps_prepend() {
> +    export DEB_BUILD_PROFILES=3D"${SWUPDATE_BUILD_PROFILES}"
> +}
> +
> +dpkg_runbuild_prepend() {
> +    export DEB_BUILD_PROFILES=3D"${SWUPDATE_BUILD_PROFILES}"
> +}
> +
> +python do_check_bootloader () {
> +    bootloader =3D d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
> +    if not bootloader in ["efibootguard", "u-boot"]:
> +        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible val=
ue: " + bootloader)
> +}
> +addtask check_bootloader before do_fetch
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/r=
ecipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> new file mode 100644
> index 0000000..3b8da36
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -0,0 +1,47 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-gbp
> +
> +include swupdate.inc
> +
> +SRC_URI =3D "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhtt=
ps;branch=3Ddebian/master"
> +SRCREV =3D"debian/2021.04-1"
> +
> +# add options to DEB_BUILD_PROFILES
> +SRC_URI +=3D "file://0001-debian-Add-option-to-build-with-efibootguard=
.patch \
> +file://0002-debian-rules-Add-CONFIG_MTD.patch \
> +file://0003-debian-config-Make-signing-optional.patch \
> +file://0004-debian-config-Make-image-encryption-optional.patch \
> +file://0005-debian-rules-Add-option-to-disable-fs-creation.patch \
> +file://0006-debian-rules-Add-option-to-disable-webserver.patch \
> +file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
> +file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"

Missing indentions of the continued lines.

> +
> +# deactivate signing and encryption for simple a/b rootfs update
> +SWUPDATE_BUILD_PROFILES +=3D "pkg.swupdate.nosigning pkg.swupdate.noen=
cryption"
> +
> +# If the luahandler shall be embedded into the swupdate binary
> +# include the following lines.
> +# DEPENDS +=3D "swupdate-handlers"
> +# GBP_DEPENDS +=3D "swupdate-handlers"
> +# SWUPDATE_BUILD_PROFILES +=3D "pkg.swupdate.embeddedlua"
> +
> +# modify for debian buster build
> +SRC_URI_append_cip-core-buster =3D " file://0009-debian-prepare-build-=
for-isar-debian-buster.patch"
> +
> +# disable documentation due to missing packages in debian buster
> +# disable create filesystem due to missing symbols in debian buster
> +# disable webserver due to missing symbols in debian buster
> +SWUPDATE_BUILD_PROFILES_append_cip-core-buster =3D " nodoc \
> +                                                   pkg.swupdate.nocrea=
tefs \
> +                                                   pkg.swupdate.nowebs=
erver "
> +# set compression to xz

Rather than writing what it does, it might make more sense to document
the reason.

> +GBP_EXTRA_OPTIONS +=3D "--git-compression=3Dxz"
>=20

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

