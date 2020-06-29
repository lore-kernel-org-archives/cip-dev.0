Return-Path: <SRS0=O7aM=AK=lists.cip-project.org=bounce+64572+4858+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0198FC433E1
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D6723D37
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gPefpI7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D6723D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4858+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ghK0YY4521723xnwBUGhPw5m; Mon, 29 Jun 2020 05:54:05 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.17924.1593435243031914011
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 05:54:03 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 05TCs1U0023549
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 14:54:01 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.4.33])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05TCs0cd027155;
	Mon, 29 Jun 2020 14:54:00 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 0/6] secureboot with efibootguard
Date: Mon, 29 Jun 2020 14:53:54 +0200
Message-Id: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uPEaHXVQkccnwfsmX8D5P7e0x4520388AA=
Content-Type: multipart/mixed; boundary="lYnnr7DORjd6T1jA0oWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593435245;
 bh=er3qy6veM0898zFIOK8PAetZc71jVduPHm7dwfHy1LE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gPefpI7zhEOamX/e7WFZgqttqGdSn6El0Kqc6WveSUhVcaHauRjQErae+JzBKI/AN6W
 pec2LfDXNSQ/XQsnGV5rf4WuDu2BRW+0XUB3d1SyxGnsJuDWxGff8UIaStNFi9847r4Ic
 MxQ5ksSaGrB2qPnBG/GuUT3WkZ0UPyvYXsg=

--lYnnr7DORjd6T1jA0oWa
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

Changes V2:

- rebase to [1] 
- removed luahandler patch as it now part of [1]
- add handling for sw-description

[1]: a/b rootfsupdate with software update

Quirin Gylstorff (6):
  kernel: add fat for qemu-amd64
  isar-patch: Add initramfs-config patch
  secure-boot: select boot partition in initramfs
  secure-boot: Add secure boot with unified kernel image
  secure-boot: Add Debian snakeoil keys for ease-of-use
  doc: Add README for secureboot

 classes/image_uuid.bbclass                    |  29 +++
 conf/distro/debian-buster-backports.list      |   1 +
 conf/distro/preferences.ovmf-snakeoil.conf    |   3 +
 doc/README.secureboot.md                      | 188 ++++++++++++++++
 ...-support-Generate-a-custom-initramfs.patch | 207 ++++++++++++++++++
 kas-cip.yml                                   |   3 +
 kas/opt/ebg-secure-boot-base.yml              |  17 ++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  27 +++
 kas/opt/ebg-swu.yml                           |   2 +-
 recipes-core/images/cip-core-image.bb         |   2 +-
 recipes-core/images/files/sw-description.tmpl |   6 +-
 .../ebg-secure-boot-secrets_0.1.bb            |  51 +++++
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
 .../initramfs-abrootfs-secureboot_0.1.bb      |  38 ++++
 ...enerate-sb-db-from-existing-certificate.sh |  16 ++
 scripts/generate_secure_boot_keys.sh          |  51 +++++
 .../wic/plugins/source/efibootguard-boot.py   |  87 +++++++-
 .../wic/plugins/source/efibootguard-efi.py    |  40 +++-
 scripts/start-efishell.sh                     |  12 +
 start-qemu.sh                                 |  54 ++++-
 wic/ebg-signed-bootloader.inc                 |   2 +
 wic/qemu-amd64-efibootguard.wks               |   6 +-
 34 files changed, 1119 insertions(+), 30 deletions(-)
 create mode 100644 classes/image_uuid.bbclass
 create mode 100644 conf/distro/debian-buster-backports.list
 create mode 100644 conf/distro/preferences.ovmf-snakeoil.conf
 create mode 100644 doc/README.secureboot.md
 create mode 100644 isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
 create mode 100644 kas/opt/ebg-secure-boot-base.yml
 create mode 100644 kas/opt/ebg-secure-boot-snakeoil.yml
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
 create mode 100644 recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
 create mode 100755 scripts/generate-sb-db-from-existing-certificate.sh
 create mode 100755 scripts/generate_secure_boot_keys.sh
 create mode 100755 scripts/start-efishell.sh
 create mode 100644 wic/ebg-signed-bootloader.inc

-- 
2.20.1


--lYnnr7DORjd6T1jA0oWa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4858): https://lists.cip-project.org/g/cip-dev/message=
/4858
Mute This Topic: https://lists.cip-project.org/mt/75190452/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lYnnr7DORjd6T1jA0oWa--
