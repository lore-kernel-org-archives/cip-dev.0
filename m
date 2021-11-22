Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C4C433EF
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 11:27:47 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.5205.1637580466261350776
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Nov 2021 03:27:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AMBRc0Z027748
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Nov 2021 12:27:38 +0100
Received: from [167.87.32.217] ([167.87.32.217])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AMBRaWA020038;
	Mon, 22 Nov 2021 12:27:36 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add FW and
 tools required for wifi testing
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>
References: <20211122111940.12250-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eb289805-9e98-7d2d-8e6d-1786087d0ac3@siemens.com>
Date: Mon, 22 Nov 2021 12:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122111940.12250-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Nov 2021 11:27:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6963

On 22.11.21 12:19, Lad Prabhakar wrote:
> Add firmware and tools required for testing wifin on hihope-rzg2m.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> Sending an RFC as I am not sure if this is the right place to add
> this. I wanted to add the debian package depends in machine.conf
> file but didnt find any variables.

IMAGE_INSTALL_append would work there, see eg.
https://github.com/siemens/jailhouse-images/blob/master/conf/machine/rpi4.conf.

Whether we want to "hard-code" the installation wireless firmware in the
machine conf here is a different question. Maybe customizations is not
that a bad place.

> 
> Is this the right place for adding this, if not could you please point
> me to the right direction.
> 
> ** Do not merge this patch **
> 
> Cheers,
> Prabhakar
> ---
>  recipes-core/customizations/customizations.bb | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
> index 932b11c..c508fd4 100644
> --- a/recipes-core/customizations/customizations.bb
> +++ b/recipes-core/customizations/customizations.bb
> @@ -23,6 +23,9 @@ DEPENDS += "sshd-regen-keys"
>  DEBIAN_DEPENDS = " \
>      ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
>  
> +DEBIAN_DEPENDS_hihope-rzg2m += " \
> +       ,firmware-ti-connectivity, iw, wireless-regdb, wireless-tools"
> +

Let's already prepare for other targets requesting the generic wireless
tools as well: Put them into a reusable variable and then add that
variable here.

Jan

>  do_install() {
>  	install -v -d ${D}/etc/network/interfaces.d
>  	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

