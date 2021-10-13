Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57ECC433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:57 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.8306.1634132456644155882
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 19DDesPq024977
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:40:54 +0200
Received: from md2dvrtc.ad001.siemens.net ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDerfI007799;
	Wed, 13 Oct 2021 15:40:53 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] Use SWUpdate from
 salsa.debian.org
Date: Wed, 13 Oct 2021 15:40:49 +0200
Message-Id: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 13:40:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6814

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series uses the source from sala.debian.org for the build of SWUpdate.

The build is patched to contain most of the previous build option from swupdate-config.bbclass.

The recipes support Debian Buster and Debian Bullseye.

Changes V2:
 - Correct spacing and end of file
 - rename recipe swupdate-handlers to swupdate-handler-roundrobin
 - extend comment in recipe swupdate

Quirin Gylstorff (4):
  swupdate: Move handler to own recipe
  swupdate: Use dpkg-gbp build with salsa
  swupdate-handler: Use same lua version as swupdate-debian-gbp
  swupdate: remove version 2021.04+isar-git

 classes/kconfig-snippets.bbclass              | 90 -------------------
 classes/swupdate-config.bbclass               | 89 ------------------
 kas/opt/swupdate.yml                          |  1 +
 .../swupdate.handler.efibootguard.ini         |  0
 .../files/swupdate.handler.efibootguard.ini   |  0
 .../swupdate-handler-roundrobin_0.1.bb        | 33 +++++++
 ...dd-option-to-build-with-efibootguard.patch | 39 ++++++++
 .../0002-debian-rules-Add-CONFIG_MTD.patch    | 27 ++++++
 ...-debian-config-Make-signing-optional.patch | 40 +++++++++
 ...onfig-Make-image-encryption-optional.patch | 40 +++++++++
 ...ules-Add-Embedded-Lua-handler-option.patch | 30 +++++++
 ...es-Add-option-to-disable-fs-creation.patch | 47 ++++++++++
 ...ules-Add-option-to-disable-webserver.patch | 42 +++++++++
 ...Make-CONFIG_HW_COMPATIBILTY-optional.patch | 40 +++++++++
 ...ules-Add-Embedded-Lua-handler-option.patch | 30 +++++++
 ...prepare-build-for-isar-debian-buster.patch | 72 +++++++++++++++
 .../swupdate/files/debian/changelog.tmpl      |  6 --
 recipes-core/swupdate/files/debian/compat     |  1 -
 .../swupdate/files/debian/control.tmpl        | 15 ----
 recipes-core/swupdate/files/debian/copyright  | 36 --------
 recipes-core/swupdate/files/debian/rules.tmpl | 31 -------
 .../swupdate/files/debian/swupdate.examples   |  2 -
 .../swupdate/files/debian/swupdate.install    |  2 -
 .../swupdate/files/debian/swupdate.manpages   |  5 --
 .../swupdate/files/debian/swupdate.tmpfile    |  2 -
 recipes-core/swupdate/files/debian/watch      | 12 ---
 recipes-core/swupdate/files/postinst          |  2 -
 recipes-core/swupdate/files/swupdate.cfg      |  6 --
 .../swupdate/files/swupdate.service.example   | 11 ---
 .../swupdate/files/swupdate.socket.example    | 11 ---
 .../swupdate/files/swupdate.socket.tmpl       | 13 ---
 .../swupdate/files/swupdate_defconfig         | 83 -----------------
 .../swupdate_defconfig_efibootguard.snippet   |  3 -
 .../files/swupdate_defconfig_lua.snippet      |  2 -
 .../swupdate_defconfig_luahandler.snippet     |  4 -
 .../files/swupdate_defconfig_mtd.snippet      |  1 -
 .../files/swupdate_defconfig_u-boot.snippet   |  3 -
 .../files/swupdate_defconfig_ubi.snippet      |  6 --
 recipes-core/swupdate/swupdate.bb             | 61 -------------
 recipes-core/swupdate/swupdate.inc            | 53 +++++++++++
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb | 48 ++++++++++
 41 files changed, 542 insertions(+), 497 deletions(-)
 delete mode 100644 classes/kconfig-snippets.bbclass
 delete mode 100644 classes/swupdate-config.bbclass
 rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
 rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/swupdate.handler.efibootguard.ini (100%)
 create mode 100644 recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
 create mode 100644 recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch
 create mode 100644 recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
 create mode 100644 recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch
 create mode 100644 recipes-core/swupdate/files/0004-debian-config-Make-image-encryption-optional.patch
 create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
 create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable-fs-creation.patch
 create mode 100644 recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable-webserver.patch
 create mode 100644 recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
 create mode 100644 recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-handler-option.patch
 create mode 100644 recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
 delete mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/compat
 delete mode 100644 recipes-core/swupdate/files/debian/control.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/copyright
 delete mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.install
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
 delete mode 100644 recipes-core/swupdate/files/debian/watch
 delete mode 100644 recipes-core/swupdate/files/postinst
 delete mode 100644 recipes-core/swupdate/files/swupdate.cfg
 delete mode 100644 recipes-core/swupdate/files/swupdate.service.example
 delete mode 100644 recipes-core/swupdate/files/swupdate.socket.example
 delete mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
 delete mode 100644 recipes-core/swupdate/swupdate.bb
 create mode 100644 recipes-core/swupdate/swupdate.inc
 create mode 100644 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb

-- 
2.30.2


