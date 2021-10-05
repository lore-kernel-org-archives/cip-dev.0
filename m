Return-Path: <SRS0=UbB2=OZ=lists.cip-project.org=bounce+64572+6786+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221EAC433FE
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 14:13:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9714A61352
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9714A61352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PEhhYY4521723xxujLaLxG97; Tue, 05 Oct 2021 07:13:50 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.984.1633443229704685303
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 07:13:50 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 195EDkbT023567
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 5 Oct 2021 16:13:47 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.1.239])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 195EDkBn022271;
	Tue, 5 Oct 2021 16:13:46 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/4] Use SWUpdate from salsa.debian.org
Date: Tue,  5 Oct 2021 16:13:42 +0200
Message-ID: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JMZyJqbti6gMxn1abpTgKEYDx4520388AA=
Content-Type: multipart/mixed; boundary="i1iR0EhO6M0LkiOPQHXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633443230;
 bh=JFkvf8Bl7HyF9IqrLKSChgmlRtDbIlPnonAemlEYwX4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Rn7IIs6U1Rvbywl9GjlfLvyJtIFmX5uN1c4ZAJ+aKo0+oxCdQ836HUqo4QtVVmvD8qA
 c920Yvt3txaVmTiMv6H3sTwf4khCYQtFrar/WlJwz5V8TER450ApSLF9eqbry71+PDNjH
 IiKxaV+qiQGbbT1ybdlV2c6hQ847NtYeEMU=
Message-ID: <20211005141342.TBU8pOPsaBpE2Trzrwq9SkkIDHVdPXkaJ-w0HreE5Ck@z>

--i1iR0EhO6M0LkiOPQHXa
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series uses the source from sala.debian.org for the build of SWUpdate.

The build is patched to contain most of the previous build option from swupdate-config.bbclass.

The recipes support Debian Buster and Debian Bullseye.

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
 .../swupdate-handlers_0.1.bb                  | 36 ++++++++
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
 recipes-core/swupdate/swupdate.inc            | 54 +++++++++++
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb | 47 ++++++++++
 41 files changed, 545 insertions(+), 497 deletions(-)
 delete mode 100644 classes/kconfig-snippets.bbclass
 delete mode 100644 classes/swupdate-config.bbclass
 rename recipes-core/{swupdate => swupdate-handlers}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
 rename recipes-core/{swupdate => swupdate-handlers}/files/swupdate.handler.efibootguard.ini (100%)
 create mode 100644 recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
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


--i1iR0EhO6M0LkiOPQHXa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6786): https://lists.cip-project.org/g/cip-dev/message/=
6786
Mute This Topic: https://lists.cip-project.org/mt/86094385/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--i1iR0EhO6M0LkiOPQHXa--
