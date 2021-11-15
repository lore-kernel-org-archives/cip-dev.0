Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9161C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:44:22 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.671.1637001861228736448
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:44:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AFIiJwW022084
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:44:19 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIiIms031996;
	Mon, 15 Nov 2021 19:44:18 +0100
Subject: Re: [isar-cip-core][PATCH 08/11] Remove root password
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        cip-dev@lists.cip-project.org
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
 <20211115161724.19516-9-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9eaf7dcc-8cdc-ea9b-af7e-cc33eec2879d@siemens.com>
Date: Mon, 15 Nov 2021 19:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161724.19516-9-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:44:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6919

On 15.11.21 17:17, Alice Ferrazzi wrote:
> KernelCI require the image to login automatically without
> root password for testing.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  recipes-core/kernelci-customizations/files/postinst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
> index 33faaeb..68ef9d3 100644
> --- a/recipes-core/kernelci-customizations/files/postinst
> +++ b/recipes-core/kernelci-customizations/files/postinst
> @@ -14,8 +14,16 @@
>  
>  echo "CIP Core Demo & Test Image" > /etc/issue
>  
> +# permit root login without password
>  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
>  echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
> +passwd root -d

This should also be achievable via

USER_root[flags] = "allow-empty-password"

Could be set in the kernel-ci image recipe. Maybe nicer than the back
and forth.

> +
> +# serial getty service for autologin
> +mkdir -p /etc/systemd/system/serial-getty@.service.d/
> +echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
> +echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
> +echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
>  

Actually topic-wise beyond what $subject suggests.

Jan

>  HOSTNAME=demo
>  echo "$HOSTNAME" > /etc/hostname
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

