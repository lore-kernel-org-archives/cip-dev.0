Return-Path: <SRS0=nAnk=BI=lists.cip-project.org=bounce+64572+5051+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2520C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 17:07:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826402075D
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YAaUeSD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826402075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5051+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LdRAYY4521723xVhqCKQui5Z; Wed, 29 Jul 2020 10:07:54 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.863.1596042473182161665
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 10:07:53 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06TH7pGL021504
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2020 19:07:51 +0200
X-Received: from [167.87.13.2] ([167.87.13.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06TH7puR002916;
	Wed, 29 Jul 2020 19:07:51 +0200
Subject: Re: [cip-dev] [isar-cip-core PATCH v2 0/5] A/B Rootfs update with software update
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <0d1c9047-4991-8dd7-165a-13245085195a@siemens.com>
Date: Wed, 29 Jul 2020 19:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qjY0bLfclucXSvdm5vJ712Imx4520388AA=
Content-Type: multipart/mixed; boundary="jZto6ah5DdcOtHF2XEJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596042474;
 bh=M0vq4+drcRhwgE9x9GTvEmVe/6psEDxjcA8llmYoDfI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YAaUeSD3ez/UjSL7XY/Xc3DlutxRh6up4AFLJon3zxERNAXys7OnxBGKxpWHM7C5Pcc
 tqhsXRrBZygVT9c3EAWm8uQuP4SDgRyQQGzITdAPcKZ6uXkOdKVbAU8Pfuxe5qjH09hx5
 rF3WSuK+amOEmFpLCNQd4II2E30mB7B2SIc=

--jZto6ah5DdcOtHF2XEJ3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 29.06.20 11:56, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset adds efibootguard, swupdate to allow A/B updates in
> cip-core. The update mechanism is currently only implemented for x86_64.
> 
> Changes V2:
>   - update efibootguard to v0.7
>   - add swdescription and kas option to build qemu-amd64 test image
>   - swupdate set to upstream mirror and no longer use gitsm
> 
> Quirin Gylstorff (5):
>    recipes-bsp: Add efibootguard
>    patches: add libubootenv
>    recipes-core: add swupdate
>    wic: Add wks files for A/B Partition update
>    swupdate: create swu file from wic image
> 
>   classes/extract-partition.bbclass             |  26 +
>   classes/kconfig-snippets.bbclass              |  90 ++++
>   classes/swupdate-config.bbclass               |  76 +++
>   classes/swupdate-img.bbclass                  |  75 +++
>   classes/wic-swu-img.bbclass                   |  20 +
>   .../0001-u-boot-add-libubootenv.patch         | 169 +++++++
>   kas-cip.yml                                   |   4 +
>   kas/opt/ebg-swu.yml                           |  26 +
>   kas/opt/qemu-swupdate.yml                     |  19 +
>   .../efibootguard/efibootguard_0.7-git+isar.bb |  46 ++
>   recipes-bsp/efibootguard/files/debian/compat  |   1 +
>   .../efibootguard/files/debian/control.tmpl    |  20 +
>   .../files/debian/efibootguard-dev.install     |   3 +
>   .../files/debian/efibootguard.install         |   2 +
>   recipes-bsp/efibootguard/files/debian/rules   |  21 +
>   recipes-core/images/cip-core-image.bb         |  10 +
>   recipes-core/images/files/sw-description.tmpl |  29 ++
>   .../swupdate/files/debian/changelog.tmpl      |   6 +
>   recipes-core/swupdate/files/debian/compat     |   1 +
>   .../swupdate/files/debian/control.tmpl        |  15 +
>   recipes-core/swupdate/files/debian/copyright  |  36 ++
>   recipes-core/swupdate/files/debian/rules.tmpl |  30 ++
>   .../swupdate/files/debian/swupdate.examples   |   2 +
>   .../swupdate/files/debian/swupdate.install    |   2 +
>   .../swupdate/files/debian/swupdate.manpages   |   5 +
>   .../swupdate/files/debian/swupdate.tmpfile    |   2 +
>   recipes-core/swupdate/files/debian/watch      |  12 +
>   recipes-core/swupdate/files/postinst          |   2 +
>   recipes-core/swupdate/files/swupdate.cfg      |   6 +
>   .../swupdate/files/swupdate.service.example   |  11 +
>   .../swupdate/files/swupdate.socket.example    |  11 +
>   .../swupdate/files/swupdate.socket.tmpl       |  13 +
>   .../swupdate/files/swupdate_defconfig         |  83 ++++
>   .../swupdate_defconfig_efibootguard.snippet   |   3 +
>   .../files/swupdate_defconfig_lua.snippet      |   2 +
>   .../swupdate_defconfig_luahandler.snippet     |   4 +
>   .../files/swupdate_defconfig_mtd.snippet      |   1 +
>   .../files/swupdate_defconfig_u-boot.snippet   |   3 +
>   .../files/swupdate_defconfig_ubi.snippet      |   6 +
>   .../swupdate/files/swupdate_handlers.lua      | 453 ++++++++++++++++++
>   recipes-core/swupdate/swupdate.bb             |  54 +++
>   .../wic/plugins/source/efibootguard-boot.py   | 162 +++++++
>   .../wic/plugins/source/efibootguard-efi.py    | 102 ++++
>   wic/ebg-sysparts.inc                          |   8 +
>   wic/qemu-amd64-efibootguard.wks               |   5 +
>   wic/simatic-ipc227e-efibootguard.wks          |   5 +
>   wic/swupdate-partition.inc                    |   4 +
>   47 files changed, 1686 insertions(+)
>   create mode 100644 classes/extract-partition.bbclass
>   create mode 100644 classes/kconfig-snippets.bbclass
>   create mode 100644 classes/swupdate-config.bbclass
>   create mode 100644 classes/swupdate-img.bbclass
>   create mode 100644 classes/wic-swu-img.bbclass
>   create mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch
>   create mode 100644 kas/opt/ebg-swu.yml
>   create mode 100644 kas/opt/qemu-swupdate.yml
>   create mode 100644 recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
>   create mode 100644 recipes-bsp/efibootguard/files/debian/compat
>   create mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
>   create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
>   create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
>   create mode 100755 recipes-bsp/efibootguard/files/debian/rules
>   create mode 100644 recipes-core/images/files/sw-description.tmpl
>   create mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
>   create mode 100644 recipes-core/swupdate/files/debian/compat
>   create mode 100644 recipes-core/swupdate/files/debian/control.tmpl
>   create mode 100644 recipes-core/swupdate/files/debian/copyright
>   create mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
>   create mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
>   create mode 100644 recipes-core/swupdate/files/debian/swupdate.install
>   create mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
>   create mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
>   create mode 100644 recipes-core/swupdate/files/debian/watch
>   create mode 100644 recipes-core/swupdate/files/postinst
>   create mode 100644 recipes-core/swupdate/files/swupdate.cfg
>   create mode 100644 recipes-core/swupdate/files/swupdate.service.example
>   create mode 100644 recipes-core/swupdate/files/swupdate.socket.example
>   create mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
>   create mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua
>   create mode 100644 recipes-core/swupdate/swupdate.bb
>   create mode 100644 scripts/lib/wic/plugins/source/efibootguard-boot.py
>   create mode 100644 scripts/lib/wic/plugins/source/efibootguard-efi.py
>   create mode 100644 wic/ebg-sysparts.inc
>   create mode 100644 wic/qemu-amd64-efibootguard.wks
>   create mode 100644 wic/simatic-ipc227e-efibootguard.wks
>   create mode 100644 wic/swupdate-partition.inc
> 

Thanks, applied to next. The secure boot series is on hold due to 
conflict. When you update it, please also make sure that at least one 
target covering as much as possible of your code is built via CI.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--jZto6ah5DdcOtHF2XEJ3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5051): https://lists.cip-project.org/g/cip-dev/message=
/5051
Mute This Topic: https://lists.cip-project.org/mt/75188184/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--jZto6ah5DdcOtHF2XEJ3--
