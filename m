Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156CBC433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 17:43:04 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.270.1633542182844230983
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 10:43:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 196HgvkC026733
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 6 Oct 2021 19:42:57 +0200
Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196HguY4005133;
	Wed, 6 Oct 2021 19:42:56 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH] scripts/wic/efibootguard-boot:
 Add missing whitespace
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5414133c-9749-820a-876e-f0b3175f7e2e@siemens.com>
Date: Wed, 6 Oct 2021 19:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 17:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6794

On 27.09.21 10:38, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The generated Kernel commandline was incorrect concatenated.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index b85cfca..882729a 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -99,7 +99,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  exit(1)
>              root_dev = root_dev.replace(":", "=")
>  
> -            cmdline += " root=%s rw" % root_dev
> +            cmdline += " root=%s rw " % root_dev
>              boot_files.append(kernel_image)
>              boot_files.append(initrd_image)
>              cmdline += "initrd=%s" % initrd_image if initrd_image else ""
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

