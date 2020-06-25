Return-Path: <SRS0=7gbV=AG=lists.cip-project.org=bounce+64572+4824+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EE6C433E2
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257B92065F
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s55/73FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B92065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4824+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id H5dcYY4521723xSH98RtCFeh; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.11422.1593094219811091747
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:20 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAH8N021243
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:17 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXT000356;
	Thu, 25 Jun 2020 16:10:16 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 0/7] secureboot with efibootguard
Date: Thu, 25 Jun 2020 16:10:08 +0200
Message-Id: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Bs2zcguc9PmPHVVVBhnNJcrpx4520388AA=
Content-Type: multipart/mixed; boundary="XmYDxufpjbqKusto4r0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=nuHwY22UuAUwNn7B5E28ylIqT71ynnBwGLdaS7hRE0k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s55/73FPCQUZk2M/CEMaFtNBMXHANIJcP5QuNAD2T8Gts8dA/eo6UA8lziEPstVo2E3
 5txNx4AC5973g49qHjN9yg2Ejik1ectbYkNc5zi4ZOPF5UYYN5wA3kfQJUBtpDVzkUKJq
 lY/SE6L3kOQUw8AX+6xiQTN9YLlHxhTQL6A=

--XmYDxufpjbqKusto4r0g
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds secureboot with efibootguard to cip-core.

The image build signs the efibootguard bootloader (bootx64.efi) and generates
a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICATION/).
A unified kernel image packs the kernel, initramfs and the kernel command-line
in one binary object. As the kernel command-line is immutable after the build
process, the previous selection of the root file system with a command-line parameter is no longer
possible. Therefore the selection of the root file-system occurs now in the initramfs.

The image uses an A/B partition layout to update the root file system. The sample implementation to
select the root file system generates a uuid and stores the id in /etc/os-release and in the initramfs.
During boot the initramfs compares its own uuid with the uuid stored in /etc/os-release of each rootfs.
If a match is found the rootfs is used for the boot.


Quirin Gylstorff (7):
  kernel: add fat for qemu-amd64
  isar-patch: Add initramfs-config patch
  secure-boot: select boot partition in initramfs
  secure-boot: Add secure boot with unified kernel image
  secure-boot: Add Debian snakeoil keys for ease-of-use
  swupdate: Add luahandler for secureboot
  doc: Add README for secureboot

 classes/image_uuid.bbclass                    |  29 +++
 conf/distro/debian-buster-backports.list      |   1 +
 conf/distro/preferences.ovmf-snakeoil.conf    |   3 +
 doc/README.secureboot.md                      | 188 ++++++++++++++++
 ...-support-Generate-a-custom-initramfs.patch | 208 ++++++++++++++++++
 kas/cip.yml                                   |   3 +
 kas/opt/ebg-secure-boot-base.yml              |  30 +++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  31 +++
 kas/opt/qemu-wic.yml                          |  14 ++
 recipes-core/images/cip-core-image.bb         |   2 +-
 .../swupdate/files/swupdate_handlers.lua      |   8 +-
 .../ebg-secure-boot-secrets_0.1.bb            |  52 +++++
 .../ebg-secure-boot-secrets/files/README.md   |   1 +
 .../files/control.tmpl                        |  12 +
 .../files/sign_secure_image.sh.tmpl           |  22 ++
 .../ebg-secure-boot-snakeoil_0.1.bb           |  35 +++
 .../files/control.tmpl                        |  12 +
 .../files/sign_secure_image.sh                |  36 +++
 .../ovmf-binaries/files/control.tmpl          |  11 +
 .../ovmf-binaries/ovmf-binaries_0.1.bb        |  30 +++
 .../linux/files/qemu-amd64_defconfig          |   6 +
 .../files/initramfs.image_uuid.hook           |  33 +++
 .../files/initramfs.lsblk.hook                |  29 +++
 .../initramfs-config/files/postinst.ext       |   3 +
 .../files/secure-boot-debian-local-patch      |  77 +++++++
 .../initramfs-config_0.1-cip.bb               |  38 ++++
 ...enerate-sb-db-from-existing-certificate.sh |  16 ++
 scripts/generate_secure_boot_keys.sh          |  51 +++++
 .../wic/plugins/source/efibootguard-boot.py   |  87 +++++++-
 .../wic/plugins/source/efibootguard-efi.py    |  40 +++-
 scripts/start-efishell.sh                     |  12 +
 start-qemu.sh                                 |  54 ++++-
 wic/ebg-signed-bootloader.inc                 |   2 +
 wic/qemu-amd64-efibootguard.wks               |  11 +-
 34 files changed, 1157 insertions(+), 30 deletions(-)
 create mode 100644 classes/image_uuid.bbclass
 create mode 100644 conf/distro/debian-buster-backports.list
 create mode 100644 conf/distro/preferences.ovmf-snakeoil.conf
 create mode 100644 doc/README.secureboot.md
 create mode 100644 isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch
 create mode 100644 kas/opt/ebg-secure-boot-base.yml
 create mode 100644 kas/opt/ebg-secure-boot-snakeoil.yml
 create mode 100644 kas/opt/qemu-wic.yml
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/README.md
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
 create mode 100644 recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
 create mode 100644 recipes-support/initramfs-config/files/initramfs.image_uuid.hook
 create mode 100644 recipes-support/initramfs-config/files/initramfs.lsblk.hook
 create mode 100644 recipes-support/initramfs-config/files/postinst.ext
 create mode 100644 recipes-support/initramfs-config/files/secure-boot-debian-local-patch
 create mode 100644 recipes-support/initramfs-config/initramfs-config_0.1-cip.bb
 create mode 100755 scripts/generate-sb-db-from-existing-certificate.sh
 create mode 100755 scripts/generate_secure_boot_keys.sh
 create mode 100755 scripts/start-efishell.sh
 create mode 100644 wic/ebg-signed-bootloader.inc

-- 
2.20.1


--XmYDxufpjbqKusto4r0g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4824): https://lists.cip-project.org/g/cip-dev/message=
/4824
Mute This Topic: https://lists.cip-project.org/mt/75103450/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XmYDxufpjbqKusto4r0g--
