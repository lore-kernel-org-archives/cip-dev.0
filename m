Return-Path: <SRS0=zdyr=O2=lists.cip-project.org=bounce+64572+6796+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E2DC433F5
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:59:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430E4610E6
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 17:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 430E4610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2GKrYY4521723xMgAVkdwCka; Wed, 06 Oct 2021 10:59:21 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.505.1633543160737364076
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 10:59:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 196HxInS030901
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 6 Oct 2021 19:59:18 +0200
X-Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196HxIWD016204;
	Wed, 6 Oct 2021 19:59:18 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/4] swupdate: Move handler to own recipe
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
 <20211005141346.2682677-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <cf2458cf-1cdc-a70d-87d2-3a3359d006f7@siemens.com>
Date: Wed, 6 Oct 2021 19:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005141346.2682677-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MVY94rlCIFLef97T0emclP83x4520388AA=
Content-Type: multipart/mixed; boundary="3kXt8UoKAxyTWYZiJfQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633543161;
 bh=kBvoFnCB8ePR//2ejKtTZh+L9ehxi4Ghv9L6IWpEZP8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gQzK7nTRVGBV4wCltzDIlKMEVeOiRJMa/7ihmfwFAuP2+63zsFXUPlTFOH/Ggcf4Hma
 KMWkI9/1HtpUeomWRy+79mZmTn2RsNztIoJJNLxejtxFy0KUhmdxf93sOwbSXezJNx25D
 w+JMFDTjK34+MpW+cSsxwy/fBys4KrZjljM=

--3kXt8UoKAxyTWYZiJfQ8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 05.10.21 16:13, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Split the SWUpdate lua handler into a seperate recipe in
> preparation for using the Debian provided SWUpdate package.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass               |  8 ----
>  kas/opt/swupdate.yml                          |  1 +
>  .../swupdate.handler.efibootguard.ini         |  0
>  .../files/swupdate.handler.efibootguard.ini   |  0
>  .../swupdate-handlers_0.1.bb                  | 37 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.bb             | 13 -------
>  6 files changed, 38 insertions(+), 21 deletions(-)
>  rename recipes-core/{swupdate => swupdate-handlers}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
>  rename recipes-core/{swupdate => swupdate-handlers}/files/swupdate.handler.efibootguard.ini (100%)
>  create mode 100644 recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
> 
> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
> index e4879c7..1d57ce1 100644
> --- a/classes/swupdate-config.bbclass
> +++ b/classes/swupdate-config.bbclass
> @@ -17,14 +17,6 @@ BUILD_DEB_DEPENDS = " \
>      zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
>      python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev, pkg-config"
>  
> -SRC_URI += " ${@ 'git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1' \
> -    if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
> -    }"
> -SRCREV_swupdate-handler-roundrobin ?= "6f561f136fdbe51d2e9066b934dfcb06b94c6624"
> -
> -SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
> -SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
> -
>  KFEATURE_lua = ""
>  KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
>  KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index bd0f6e4..af839f0 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -17,6 +17,7 @@ header:
>  local_conf_header:
>    swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
> +    IMAGE_INSTALL_append = " swupdate-handlers"
>  
>    wic-swu: |
>      IMAGE_TYPE = "wic-swu-img"
> diff --git a/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handlers/files/secureboot/swupdate.handler.efibootguard.ini
> similarity index 100%
> rename from recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
> rename to recipes-core/swupdate-handlers/files/secureboot/swupdate.handler.efibootguard.ini
> diff --git a/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handlers/files/swupdate.handler.efibootguard.ini
> similarity index 100%
> rename from recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
> rename to recipes-core/swupdate-handlers/files/swupdate.handler.efibootguard.ini
> diff --git a/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb b/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
> new file mode 100644
> index 0000000..b6cb30d
> --- /dev/null
> +++ b/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb

Why handlers? Can the recipe handle multiple handlers? As far as I read
the recipe, it can't.

> @@ -0,0 +1,37 @@
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
> +inherit dpkg-raw
> +
> +DEPENDS = "swupdate"
> +DEBIAN_DEPENDS = "swupdate"
> +
> +SRC_URI += " ${@ 'git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1' \
> +    if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
> +    }"
> +SRCREV_swupdate-handler-roundrobin ?= "6f561f136fdbe51d2e9066b934dfcb06b94c6624"
> +
> +SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
> +SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
> +
> +

One linefeed too much.

> +SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
> +SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
> +
> +do_install[cleandirs] = "${D}/etc \
> +                         ${D}/usr/share/lua/5.3"
> +do_install() {
> +    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
> +        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
> +    fi
> +    if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
> +       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
> +    fi

I wonder if we shouldn't make this recipe "swupdate-handler-roundrobin",
maybe add generic PROVIDES = "swupdate-handler" and remove the
configurability. Or is there really that much to reuse for a different
handler? That could still be moved into a swupdate-handler.inc then. Are
we aware of any alternative handler in some (likely internal) layer that
could act as check for reusability?

> +}
> \ No newline at end of file
    ^^^^^^^^^^^^^^^^^^^^^^^^^

> diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
> index 8bef9ab..a29a797 100644
> --- a/recipes-core/swupdate/swupdate.bb
> +++ b/recipes-core/swupdate/swupdate.bb
> @@ -29,8 +29,6 @@ DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
>  inherit dpkg
>  inherit swupdate-config
>  
> -SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
> -SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
>  KFEATURES += "luahandler"
>  
>  S = "${WORKDIR}/git"
> @@ -47,15 +45,4 @@ do_prepare_build() {
>      if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore; then
>          echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
>      fi
> -    # luahandler
> -    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
> -        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}/swupdate_handlers.lua
> -    fi
> -    if [ -e ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ]; then
> -       install -m 0644 ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ${S}/swupdate.handler.ini
> -       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
> -    elif [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
> -       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${S}/swupdate.handler.ini
> -       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
> -    fi
>  }
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--3kXt8UoKAxyTWYZiJfQ8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6796): https://lists.cip-project.org/g/cip-dev/message/=
6796
Mute This Topic: https://lists.cip-project.org/mt/86094386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3kXt8UoKAxyTWYZiJfQ8--
