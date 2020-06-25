Return-Path: <SRS0=uIvC=AG=lists.cip-project.org=bounce+64572+4816+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BA6C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:21:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD28820781
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TcQxESAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD28820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4816+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A5wLYY4521723xAD8G1NKEm0; Thu, 25 Jun 2020 06:21:15 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.10322.1593091273982781690
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 06:21:14 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05PDLC6V005634
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 15:21:12 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PDLB2F002493;
	Thu, 25 Jun 2020 15:21:11 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 0/4] A/B Rootfs update with software update
Date: Thu, 25 Jun 2020 15:21:07 +0200
Message-Id: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KnkUGYNaZP8SKXLqSrsVJPu0x4520388AA=
Content-Type: multipart/mixed; boundary="9GtaiRq58iOzA8gwvN5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593091275;
 bh=1udH0qJtiVl3v6V2jKQHLGuF5Ng+YYidm/I+fwKAFo8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TcQxESAwbt9+VSj+4miLOz5ZhAbQStqukmbWNhBEOzVxPtdseUeCja56XF+/jLl0rhz
 38h89xn6UwWmCd6uQvUmUJpstLWRDo7S0yJ9ijs9bURZFn8YeHnG4pQvdwuJwkn/TqCnn
 OcMxUcHgzRfGSsMzg/ZVb3S52EixqF0pPPs=

--9GtaiRq58iOzA8gwvN5O
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds efibootguard, swupdate to allow A/B updates in
cip-core. The update mechanism is currently only implemented for x86_64.


Quirin Gylstorff (4):
  recipes-bsp: Add efibootguard
  patches: add libubootenv
  recipes-core: add swupdate
  wic: Add wks files for A/B Partition update

 classes/kconfig-snippets.bbclass              |  90 ++++
 classes/swupdate-config.bbclass               |  76 +++
 classes/swupdate-img.bbclass                  |  75 +++
 .../0001-u-boot-add-libubootenv.patch         | 169 +++++++
 kas/cip.yml                                   |   4 +
 kas/opt/ebg-swu.yml                           |  26 +
 .../efibootguard/efibootguard_0.6-git+isar.bb |  46 ++
 recipes-bsp/efibootguard/files/debian/compat  |   1 +
 .../efibootguard/files/debian/control.tmpl    |  20 +
 .../files/debian/efibootguard-dev.install     |   3 +
 .../files/debian/efibootguard.install         |   2 +
 recipes-bsp/efibootguard/files/debian/rules   |  21 +
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
 .../swupdate/files/swupdate_handlers.lua      | 449 ++++++++++++++++++
 recipes-core/swupdate/swupdate.bb             |  54 +++
 .../wic/plugins/source/efibootguard-boot.py   | 162 +++++++
 .../wic/plugins/source/efibootguard-efi.py    | 102 ++++
 wic/ebg-sysparts.inc                          |   8 +
 wic/qemu-amd64-efibootguard.wks               |   5 +
 wic/simatic-ipc227e-efibootguard.wks          |   5 +
 wic/swupdate-partition.inc                    |   4 +
 42 files changed, 1578 insertions(+)
 create mode 100644 classes/kconfig-snippets.bbclass
 create mode 100644 classes/swupdate-config.bbclass
 create mode 100644 classes/swupdate-img.bbclass
 create mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch
 create mode 100644 kas/opt/ebg-swu.yml
 create mode 100644 recipes-bsp/efibootguard/efibootguard_0.6-git+isar.bb
 create mode 100644 recipes-bsp/efibootguard/files/debian/compat
 create mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 create mode 100755 recipes-bsp/efibootguard/files/debian/rules
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


--9GtaiRq58iOzA8gwvN5O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4816): https://lists.cip-project.org/g/cip-dev/message=
/4816
Mute This Topic: https://lists.cip-project.org/mt/75102472/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9GtaiRq58iOzA8gwvN5O--
