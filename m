Return-Path: <SRS0=8+fp=BD=lists.cip-project.org=bounce+64572+4997+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FAC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0EF206F0
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Y1DWdOWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0EF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4997+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3kOQYY4521723xYjZJklCO3f; Fri, 24 Jul 2020 07:52:30 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.7790.1595602348750123472
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 07:52:29 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06OEqQeS005632
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 16:52:26 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06OEqPif031602;
	Fri, 24 Jul 2020 16:52:25 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 0/5] A/B Rootfs update with software update
Date: Fri, 24 Jul 2020 16:52:20 +0200
Message-Id: <20200724145225.7895-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xKhQtEzLOp2usM3R0sa2OdLRx4520388AA=
Content-Type: multipart/mixed; boundary="VChGqMv3SX9wTpsRrpT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602350;
 bh=0N0gATeJmsdXBxSr/v88ZRzJRjX4dOTU5LK6ToGJ/v0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Y1DWdOWVUQUxSzf7G8J8YF6ToFOkvDIqxJDC38Jf+ysoLLeV379raj2HbvqBSkvwEE8
 qFqNNidj+nuGSyNFll2D9OcvhMpVEYj0ROo7+DPYXFHojqj1Wo6Se+MfFKB9QJtGRBIEL
 AeTMIfbXDB0VlD3nWKZoa73aIEKP9ag3HT4=

--VChGqMv3SX9wTpsRrpT6
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds efibootguard, swupdate to allow A/B updates in
cip-core. The update mechanism is currently only implemented for x86_64.

Changes V2:
 - update efibootguard to v0.7
 - add swdescription and kas option to build qemu-amd64 test image
 - swupdate set to upstream mirror and no longer use gitsm

Changes V3:

 - change image type for ebg-swu to generate a swu image during build
 - remove qemu-swupdate as it is no longer needed
 - add swdescription file for updating without secureboot


Quirin Gylstorff (5):
  recipes-bsp: Add efibootguard
  patches: add libubootenv
  recipes-core: add swupdate
  wic: Add wks files for A/B Partition update
  swupdate: create swu file from wic image

 classes/extract-partition.bbclass             |  26 +
 classes/kconfig-snippets.bbclass              |  90 ++++
 classes/swupdate-config.bbclass               |  76 +++
 classes/swupdate-img.bbclass                  |  75 +++
 classes/wic-swu-img.bbclass                   |  20 +
 .../0001-u-boot-add-libubootenv.patch         | 169 +++++++
 kas-cip.yml                                   |   4 +
 kas/opt/ebg-swu.yml                           |  26 +
 .../efibootguard/efibootguard_0.7-git+isar.bb |  46 ++
 recipes-bsp/efibootguard/files/debian/compat  |   1 +
 .../efibootguard/files/debian/control.tmpl    |  20 +
 .../files/debian/efibootguard-dev.install     |   3 +
 .../files/debian/efibootguard.install         |   2 +
 recipes-bsp/efibootguard/files/debian/rules   |  21 +
 recipes-core/images/cip-core-image.bb         |  10 +
 recipes-core/images/files/sw-description.tmpl |  37 ++
 .../swupdate/files/debian/changelog.tmpl      |   6 +
 recipes-core/swupdate/files/debian/compat     |   1 +
 .../swupdate/files/debian/control.tmpl        |  15 +
 recipes-core/swupdate/files/debian/copyright  |  36 ++
 recipes-core/swupdate/files/debian/rules.tmpl |  30 ++
 .../swupdate/files/debian/swupdate.examples   |   2 +
 .../swupdate/files/debian/swupdate.install    |   2 +
 .../swupdate/files/debian/swupdate.manpages   |   5 +
 .../swupdate/files/debian/swupdate.tmpfile    |   2 +
 recipes-core/swupdate/files/debian/watch      |  12 +
 recipes-core/swupdate/files/postinst          |   2 +
 recipes-core/swupdate/files/swupdate.cfg      |   6 +
 .../swupdate/files/swupdate.service.example   |  11 +
 .../swupdate/files/swupdate.socket.example    |  11 +
 .../swupdate/files/swupdate.socket.tmpl       |  13 +
 .../swupdate/files/swupdate_defconfig         |  83 ++++
 .../swupdate_defconfig_efibootguard.snippet   |   3 +
 .../files/swupdate_defconfig_lua.snippet      |   2 +
 .../swupdate_defconfig_luahandler.snippet     |   4 +
 .../files/swupdate_defconfig_mtd.snippet      |   1 +
 .../files/swupdate_defconfig_u-boot.snippet   |   3 +
 .../files/swupdate_defconfig_ubi.snippet      |   6 +
 .../swupdate/files/swupdate_handlers.lua      | 453 ++++++++++++++++++
 recipes-core/swupdate/swupdate.bb             |  54 +++
 .../wic/plugins/source/efibootguard-boot.py   | 162 +++++++
 .../wic/plugins/source/efibootguard-efi.py    | 102 ++++
 wic/ebg-sysparts.inc                          |   8 +
 wic/qemu-amd64-efibootguard.wks               |   5 +
 wic/simatic-ipc227e-efibootguard.wks          |   5 +
 wic/swupdate-partition.inc                    |   4 +
 46 files changed, 1675 insertions(+)
 create mode 100644 classes/extract-partition.bbclass
 create mode 100644 classes/kconfig-snippets.bbclass
 create mode 100644 classes/swupdate-config.bbclass
 create mode 100644 classes/swupdate-img.bbclass
 create mode 100644 classes/wic-swu-img.bbclass
 create mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch
 create mode 100644 kas/opt/ebg-swu.yml
 create mode 100644 recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
 create mode 100644 recipes-bsp/efibootguard/files/debian/compat
 create mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 create mode 100755 recipes-bsp/efibootguard/files/debian/rules
 create mode 100644 recipes-core/images/files/sw-description.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/compat
 create mode 100644 recipes-core/swupdate/files/debian/control.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/copyright
 create mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.install
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
 create mode 100644 recipes-core/swupdate/files/debian/watch
 create mode 100644 recipes-core/swupdate/files/postinst
 create mode 100644 recipes-core/swupdate/files/swupdate.cfg
 create mode 100644 recipes-core/swupdate/files/swupdate.service.example
 create mode 100644 recipes-core/swupdate/files/swupdate.socket.example
 create mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua
 create mode 100644 recipes-core/swupdate/swupdate.bb
 create mode 100644 scripts/lib/wic/plugins/source/efibootguard-boot.py
 create mode 100644 scripts/lib/wic/plugins/source/efibootguard-efi.py
 create mode 100644 wic/ebg-sysparts.inc
 create mode 100644 wic/qemu-amd64-efibootguard.wks
 create mode 100644 wic/simatic-ipc227e-efibootguard.wks
 create mode 100644 wic/swupdate-partition.inc

-- 
2.20.1


--VChGqMv3SX9wTpsRrpT6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4997): https://lists.cip-project.org/g/cip-dev/message=
/4997
Mute This Topic: https://lists.cip-project.org/mt/75767664/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VChGqMv3SX9wTpsRrpT6--
