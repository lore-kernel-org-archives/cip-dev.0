Return-Path: <SRS0=2YWL=B7=lists.cip-project.org=bounce+64572+5225+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CAFC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:18:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180E020FC3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qd6lHYPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180E020FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5225+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IvFrYY4521723xcrfW5VI9pd; Fri, 21 Aug 2020 08:18:40 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.136067.1598023119123671482
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 08:18:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07LFIbL1014477
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 17:18:37 +0200
X-Received: from [139.22.122.86] ([139.22.122.86])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07LFIVDd027592;
	Fri, 21 Aug 2020 17:18:31 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/6] secureboot with efibootguard
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5636e8fc-839d-de07-1c17-30fce9efd905@siemens.com>
Date: Fri, 21 Aug 2020 17:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XU9Luk7CxjqexEXC8Fn5klQbx4520388AA=
Content-Type: multipart/mixed; boundary="GQ4sbcc7q1fkmGyzHPG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598023120;
 bh=VaZuofkV7RhGyDsx047q4Sp/OiiCGDWJnuw3UrrfB94=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qd6lHYPRsXTrLzXgne2NB54b58vKauDWIfIZhA3K/o4dfjkwnFfJC2qvn5+SrSxKUqB
 wCpme0qtdMgKaPSrvIF2xqZVH20hL5Ur9RS5skf8RtoLbSYTCGHHzAX4B07EjbeHt4mWZ
 hcEXlG6bvibFJCKA6nt2YpWS0D57xzGnD5w=

--GQ4sbcc7q1fkmGyzHPG6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.08.20 11:55, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset adds secureboot with efibootguard to cip-core.
> 
> The image build signs the efibootguard bootloader (bootx64.efi) and generates
> a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICATION/).
> A unified kernel image packs the kernel, initramfs and the kernel command-line
> in one binary object. As the kernel command-line is immutable after the build
> process, the previous selection of the root file system with a command-line parameter is no longer
> possible. Therefore the selection of the root file-system occurs now in the initramfs.
> 
> The image uses an A/B partition layout to update the root file system. The sample implementation to
> select the root file system generates a uuid and stores the id in /etc/os-release and in the initramfs.
> During boot the initramfs compares its own uuid with the uuid stored in /etc/os-release of each rootfs.
> If a match is found the rootfs is used for the boot.
> 
> Changes V2:
> 
>  - rebase to [1]
>  - removed luahandler patch as it now part of [1]
>  - add handling for sw-description
> 
> Changes V3:
> 
>  - rewrite the image id creation to ensure a new uuid is generated if a new package is
>   added or another change of the rootfs
>  - add readme section how to execute/test the software update mechnism
>  - adapt to version v3 of [1]
>  - update the patch
>  - add wks file for efibootguard and swupdate
> 
> [1]: a/b rootfsupdate with software update
> 
> Changes V4:
> 
>  - rebase onto next 619edb509bd287277749580cbc842e57d5044756
>  - fix indent of ./start-qemu.sh
>  - whitespace fixes
>  - update libubootenv patch to v2
>  - update revision of cip-kernel-config to ca24d965adf77730caf1cd32bdfcffd69e369502
>    to boot secureboot with qemu
>  - swupdate swdescription for non-secure-boot images
> 
> Quirin Gylstorff (6):
>   linux-cip: Update revision of kernel config
>   isar-patch: Add initramfs-config patch
>   secure-boot: select boot partition in initramfs
>   secure-boot: Add secure boot with unified kernel image
>   secure-boot: Add Debian snakeoil keys for ease-of-use
>   doc: Add README for secureboot
> 
>  classes/image_uuid.bbclass                    |  33 +++
>  conf/distro/debian-buster-backports.list      |   1 +
>  conf/distro/preferences.ovmf-snakeoil.conf    |   3 +
>  doc/README.secureboot.md                      | 229 ++++++++++++++++++
>  .../0001-u-boot-add-libubootenv.patch         | 161 ++++++------
>  ...-support-Generate-a-custom-initramfs.patch | 207 ++++++++++++++++
>  kas-cip.yml                                   |   3 +
>  kas/opt/ebg-secure-boot-base.yml              |  18 ++
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  28 +++
>  kas/opt/ebg-swu.yml                           |   4 +-
>  recipes-core/images/cip-core-image.bb         |  12 +-
>  .../files/secure-boot/sw-description.tmpl     |  29 +++
>  recipes-core/images/files/sw-description.tmpl |  19 +-
>  recipes-core/images/secureboot.inc            |  21 ++
>  recipes-core/images/swupdate.inc              |  21 ++
>  .../ebg-secure-boot-secrets_0.1.bb            |  51 ++++
>  .../ebg-secure-boot-secrets/files/README.md   |   1 +
>  .../files/control.tmpl                        |  12 +
>  .../files/sign_secure_image.sh.tmpl           |  22 ++
>  .../ebg-secure-boot-snakeoil_0.1.bb           |  34 +++
>  .../files/control.tmpl                        |  12 +
>  .../files/sign_secure_image.sh                |  36 +++
>  .../ovmf-binaries/files/control.tmpl          |  11 +
>  .../ovmf-binaries/ovmf-binaries_0.1.bb        |  30 +++
>  recipes-kernel/linux/linux-cip-common.inc     |   2 +-
>  .../files/initramfs.image_uuid.hook           |  33 +++
>  .../files/initramfs.lsblk.hook                |  29 +++
>  .../initramfs-config/files/postinst.ext       |   3 +
>  .../files/secure-boot-debian-local-patch      |  79 ++++++
>  .../initramfs-abrootfs-secureboot_0.1.bb      |  38 +++
>  ...enerate-sb-db-from-existing-certificate.sh |  16 ++
>  scripts/generate_secure_boot_keys.sh          |  51 ++++
>  .../wic/plugins/source/efibootguard-boot.py   |  87 ++++++-
>  .../wic/plugins/source/efibootguard-efi.py    |  40 ++-
>  scripts/start-efishell.sh                     |  12 +
>  start-qemu.sh                                 |  59 +++--
>  wic/ebg-signed-bootloader.inc                 |   2 +
>  wic/qemu-amd64-efibootguard-secureboot.wks    |   9 +
>  wic/qemu-amd64-efibootguard.wks               |   1 -
>  39 files changed, 1330 insertions(+), 129 deletions(-)
>  create mode 100644 classes/image_uuid.bbclass
>  create mode 100644 conf/distro/debian-buster-backports.list
>  create mode 100644 conf/distro/preferences.ovmf-snakeoil.conf
>  create mode 100644 doc/README.secureboot.md
>  create mode 100644 isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
>  create mode 100644 kas/opt/ebg-secure-boot-base.yml
>  create mode 100644 kas/opt/ebg-secure-boot-snakeoil.yml
>  create mode 100644 recipes-core/images/files/secure-boot/sw-description.tmpl
>  create mode 100644 recipes-core/images/secureboot.inc
>  create mode 100644 recipes-core/images/swupdate.inc
>  create mode 100644 recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
>  create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/README.md
>  create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
>  create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
>  create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
>  create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
>  create mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
>  create mode 100644 recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
>  create mode 100644 recipes-support/initramfs-config/files/initramfs.image_uuid.hook
>  create mode 100644 recipes-support/initramfs-config/files/initramfs.lsblk.hook
>  create mode 100644 recipes-support/initramfs-config/files/postinst.ext
>  create mode 100644 recipes-support/initramfs-config/files/secure-boot-debian-local-patch
>  create mode 100644 recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
>  create mode 100755 scripts/generate-sb-db-from-existing-certificate.sh
>  create mode 100755 scripts/generate_secure_boot_keys.sh
>  create mode 100755 scripts/start-efishell.sh
>  create mode 100644 wic/ebg-signed-bootloader.inc
>  create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
> 

I've taken this to next, but this also needs a hook-up with the CI system.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--GQ4sbcc7q1fkmGyzHPG6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5225): https://lists.cip-project.org/g/cip-dev/message=
/5225
Mute This Topic: https://lists.cip-project.org/mt/76326081/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GQ4sbcc7q1fkmGyzHPG6--
