Return-Path: <SRS0=n8U2=PB=lists.cip-project.org=bounce+64572+6821+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C43C433FE
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:20:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CC7610C8
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79CC7610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nYmbYY4521723x7JIZDCzgyJ; Wed, 13 Oct 2021 07:20:14 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.8738.1634134812808645518
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 07:20:13 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DEKA2s016794
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 16:20:10 +0200
X-Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DEK9eP009480;
	Wed, 13 Oct 2021 16:20:09 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/4] Use SWUpdate from salsa.debian.org
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <aa0147d5-8c15-3909-7394-0a4a118b2dce@siemens.com>
Date: Wed, 13 Oct 2021 16:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dZbzFRwYkje2k3JFtWch1zHqx4520388AA=
Content-Type: multipart/mixed; boundary="M2LA6z6L9tjrJ2VaeXbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634134814;
 bh=xXIhacOZRWIcRfc+e3CDMkKBkkTm/r/FGSgz2eIMJVY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rp+Zs5ba2kMweBrkZ5iAdqFyXJd22XQ1oc+ZTywPOZ8Reb/f6rSpalAQWcgs6B2y0WB
 jRXUcDAodCJAbAIsCszU6jLStirEniNEBAgNJPm3gQsS/2RtsbnTx1fSEjQJLy7VtasRi
 u0SGKbwVxZ/luNV1Pa4ZV/FrH/Af2+MpNDY=
Message-ID: <20211013142009.xHR5FskZP9aAV7Xend6AJgvneylBFefikpTxCtnFMrY@z>

--M2LA6z6L9tjrJ2VaeXbR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.10.21 15:40, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch series uses the source from sala.debian.org for the build of SWUpdate.
> 
> The build is patched to contain most of the previous build option from swupdate-config.bbclass.
> 
> The recipes support Debian Buster and Debian Bullseye.
> 
> Changes V2:
>  - Correct spacing and end of file
>  - rename recipe swupdate-handlers to swupdate-handler-roundrobin
>  - extend comment in recipe swupdate
> 
> Quirin Gylstorff (4):
>   swupdate: Move handler to own recipe
>   swupdate: Use dpkg-gbp build with salsa
>   swupdate-handler: Use same lua version as swupdate-debian-gbp
>   swupdate: remove version 2021.04+isar-git
> 
>  classes/kconfig-snippets.bbclass              | 90 -------------------
>  classes/swupdate-config.bbclass               | 89 ------------------
>  kas/opt/swupdate.yml                          |  1 +
>  .../swupdate.handler.efibootguard.ini         |  0
>  .../files/swupdate.handler.efibootguard.ini   |  0
>  .../swupdate-handler-roundrobin_0.1.bb        | 33 +++++++
>  ...dd-option-to-build-with-efibootguard.patch | 39 ++++++++
>  .../0002-debian-rules-Add-CONFIG_MTD.patch    | 27 ++++++
>  ...-debian-config-Make-signing-optional.patch | 40 +++++++++
>  ...onfig-Make-image-encryption-optional.patch | 40 +++++++++
>  ...ules-Add-Embedded-Lua-handler-option.patch | 30 +++++++
>  ...es-Add-option-to-disable-fs-creation.patch | 47 ++++++++++
>  ...ules-Add-option-to-disable-webserver.patch | 42 +++++++++
>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch | 40 +++++++++
>  ...ules-Add-Embedded-Lua-handler-option.patch | 30 +++++++
>  ...prepare-build-for-isar-debian-buster.patch | 72 +++++++++++++++
>  .../swupdate/files/debian/changelog.tmpl      |  6 --
>  recipes-core/swupdate/files/debian/compat     |  1 -
>  .../swupdate/files/debian/control.tmpl        | 15 ----
>  recipes-core/swupdate/files/debian/copyright  | 36 --------
>  recipes-core/swupdate/files/debian/rules.tmpl | 31 -------
>  .../swupdate/files/debian/swupdate.examples   |  2 -
>  .../swupdate/files/debian/swupdate.install    |  2 -
>  .../swupdate/files/debian/swupdate.manpages   |  5 --
>  .../swupdate/files/debian/swupdate.tmpfile    |  2 -
>  recipes-core/swupdate/files/debian/watch      | 12 ---
>  recipes-core/swupdate/files/postinst          |  2 -
>  recipes-core/swupdate/files/swupdate.cfg      |  6 --
>  .../swupdate/files/swupdate.service.example   | 11 ---
>  .../swupdate/files/swupdate.socket.example    | 11 ---
>  .../swupdate/files/swupdate.socket.tmpl       | 13 ---
>  .../swupdate/files/swupdate_defconfig         | 83 -----------------
>  .../swupdate_defconfig_efibootguard.snippet   |  3 -
>  .../files/swupdate_defconfig_lua.snippet      |  2 -
>  .../swupdate_defconfig_luahandler.snippet     |  4 -
>  .../files/swupdate_defconfig_mtd.snippet      |  1 -
>  .../files/swupdate_defconfig_u-boot.snippet   |  3 -
>  .../files/swupdate_defconfig_ubi.snippet      |  6 --
>  recipes-core/swupdate/swupdate.bb             | 61 -------------
>  recipes-core/swupdate/swupdate.inc            | 53 +++++++++++
>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb | 48 ++++++++++
>  41 files changed, 542 insertions(+), 497 deletions(-)
>  delete mode 100644 classes/kconfig-snippets.bbclass
>  delete mode 100644 classes/swupdate-config.bbclass
>  rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
>  rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/swupdate.handler.efibootguard.ini (100%)
>  create mode 100644 recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>  create mode 100644 recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch
>  create mode 100644 recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>  create mode 100644 recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0004-debian-config-Make-image-encryption-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
>  create mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable-fs-creation.patch
>  create mode 100644 recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable-webserver.patch
>  create mode 100644 recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>  create mode 100644 recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-handler-option.patch
>  create mode 100644 recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
>  delete mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
>  delete mode 100644 recipes-core/swupdate/files/debian/compat
>  delete mode 100644 recipes-core/swupdate/files/debian/control.tmpl
>  delete mode 100644 recipes-core/swupdate/files/debian/copyright
>  delete mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
>  delete mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
>  delete mode 100644 recipes-core/swupdate/files/debian/swupdate.install
>  delete mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
>  delete mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
>  delete mode 100644 recipes-core/swupdate/files/debian/watch
>  delete mode 100644 recipes-core/swupdate/files/postinst
>  delete mode 100644 recipes-core/swupdate/files/swupdate.cfg
>  delete mode 100644 recipes-core/swupdate/files/swupdate.service.example
>  delete mode 100644 recipes-core/swupdate/files/swupdate.socket.example
>  delete mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
>  delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
>  delete mode 100644 recipes-core/swupdate/swupdate.bb
>  create mode 100644 recipes-core/swupdate/swupdate.inc
>  create mode 100644 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--M2LA6z6L9tjrJ2VaeXbR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6821): https://lists.cip-project.org/g/cip-dev/message/=
6821
Mute This Topic: https://lists.cip-project.org/mt/86287950/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--M2LA6z6L9tjrJ2VaeXbR--
