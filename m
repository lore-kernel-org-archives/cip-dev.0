Return-Path: <SRS0=babO=PB=lists.cip-project.org=bounce+64572+6818+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C44C433F5
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:47:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0BC60F11
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A0BC60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EzJZYY4521723xVyo63LyhGt; Wed, 13 Oct 2021 06:47:47 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.8428.1634132866639932191
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:47:47 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DDliIb008909
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:47:44 +0200
X-Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDlha6016864;
	Wed, 13 Oct 2021 15:47:43 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to own recipe
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
 <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
Date: Wed, 13 Oct 2021 15:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7pZKzsd2hQht1n2ArzHVub9Ix4520388AA=
Content-Type: multipart/mixed; boundary="XHoDwAkdDaJzsKrkZDIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634132867;
 bh=fnZ5ut6nYvhU67Bl2xG7WHP6QF+/TQ6PcACwKItS/0w=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OTLVaKwnwv0fiHS+rLxLaWZIqpXwc956xUMDWaDE42F3g8qB36eIFh0rquWRd1dm8Zr
 /8HG+mV0h1Uv8FDPo1pv6826kD4GglaerqS9z5D2pRlFcIk5VsACThAX74dB6Pi61F7Ol
 63eHJYglOp6fuTx/eQ1kV35kw0CpafHxFaA=
Message-ID: <20211013134743.uQavtyd9fHla8Jv-TkMXA0F6AK6frHr8SUIjFSxfXc4@z>

--XHoDwAkdDaJzsKrkZDIw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.10.21 15:40, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Split the SWUpdate lua handler into a seperate recipe in
> preparation for using the Debian provided SWUpdate package.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass               |  8 -----
>  kas/opt/swupdate.yml                          |  1 +
>  .../swupdate.handler.efibootguard.ini         |  0
>  .../files/swupdate.handler.efibootguard.ini   |  0
>  .../swupdate-handler-roundrobin_0.1.bb        | 32 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.bb             | 13 --------
>  6 files changed, 33 insertions(+), 21 deletions(-)
>  rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
>  rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/swupdate.handler.efibootguard.ini (100%)
>  create mode 100644 recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
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
> index bd0f6e4..974eacb 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -17,6 +17,7 @@ header:
>  local_conf_header:
>    swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
> +    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>  
>    wic-swu: |
>      IMAGE_TYPE = "wic-swu-img"
> diff --git a/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
> similarity index 100%
> rename from recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
> rename to recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
> diff --git a/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
> similarity index 100%
> rename from recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
> rename to recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> new file mode 100644
> index 0000000..b9ccec2
> --- /dev/null
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -0,0 +1,32 @@
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
> +PROVIDES = "swupdate-handlers"

Plural or singular? Can a generic swupdate-handler package container
multiple handlers? Or will it only ever provide a single handler? In the
latter case, make this "swupdate-handler" as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--XHoDwAkdDaJzsKrkZDIw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6818): https://lists.cip-project.org/g/cip-dev/message/=
6818
Mute This Topic: https://lists.cip-project.org/mt/86287949/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XHoDwAkdDaJzsKrkZDIw--
