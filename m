Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14CC433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:46:33 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.701.1637001991663304856
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:46:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AFIkTDW001345
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:46:29 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIkSQI001369;
	Mon, 15 Nov 2021 19:46:28 +0100
Subject: Re: [PATCH] cip-core-image-security: remove unnecessary dependency
 package names
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f222455d-19e3-d047-a4b8-afa5ad6f7700@siemens.com>
Date: Mon, 15 Nov 2021 19:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:46:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6920

On 15.11.21 17:15, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> It is not necessary to mention dependency package names when parent
> package is present, the dependency packages will automatically
> install by isar framework.
> 
> so removing the dependency packages which are not necessary.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 61ddc39..6c41b00 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -17,12 +17,12 @@ IMAGE_INSTALL += "security-customizations"
>  
>  # Debian packages that provide security features
>  IMAGE_PREINSTALL += " \
> -	openssl libssl1.1 \
> +	openssl \
>  	fail2ban \
>  	openssh-server openssh-sftp-server openssh-client \
>  	syslog-ng-core syslog-ng-mod-journal \
> -	aide aide-common \
> -	libnftables0 nftables \
> +	aide \
> +	nftables \
>  	libpam-pkcs11 \
>  	chrony \
>  	tpm2-tools \
> @@ -30,7 +30,7 @@ IMAGE_PREINSTALL += " \
>  	libtss2-esys0 libtss2-udev \
>  	libpam-cracklib \
>  	acl \
> -	libauparse0 audispd-plugins auditd \
> +	audispd-plugins auditd \
>  	uuid-runtime \
>  	sudo \
>  "
> 

Was the list possibly intended to list all packages explicitly that are
security related? If not or that was incomplete anyway, this is fine.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

