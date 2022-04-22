Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC9CC54EFD
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:01 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web08.7700.1650630149385234696
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 05:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=MuMZHRfM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-202204221222267be3bdfa15a5491a96-oo92pm@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202204221222267be3bdfa15a5491a96
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Apr 2022 14:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Yq1nkcBw/NbX/j8zHrTAYyHvADVo0XXIAgO6lCZn3Pc=;
 b=MuMZHRfMuCGKGC06uWI15X9CAOCgFBJs2P//jQqYO3UZmoUTyPbTGWgU0xihQ//NqOlq4e
 py1N1oBpPX7auzjl3w6WV3IUZzmx9LgMd87UNtK5pGIqiqa30c2SVDcxtvpbg+mpBDn2hGgK
 BC7cdnbLKV4AH//nqGydvdfmANKC0=;
Message-ID: <f2eb1b22-0110-274e-9599-62d22b9ec133@siemens.com>
Date: Fri, 22 Apr 2022 14:22:25 +0200
MIME-Version: 1.0
Subject: Re: [isar-cip-core][PATCH v2 4/6] customizations: Relocate /root
 under /home
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>
References: <cover.1650613658.git.jan.kiszka@siemens.com>
 <c378b09452d1507e0f7c5de1c3d6543f2027b06e.1650613658.git.jan.kiszka@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: 
 <c378b09452d1507e0f7c5de1c3d6543f2027b06e.1650613658.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8184



On 4/22/22 09:47, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is needed for read-only rootfs setups. We could also update the
> account settings, but establishing a link comes with less surprises.
> 

What happens if the /home mount fails? Does the system fall back to / ?

This should be the behavior according to [1].

[1]: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s14.html

Quirin


> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   recipes-core/customizations/files/postinst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
> index 9b553da..6ca309a 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -17,3 +17,7 @@ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
>   HOSTNAME=demo
>   echo "$HOSTNAME" > /etc/hostname
>   echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> +
> +# needed for read-only rootfs with writable /home
> +mv /root /home/
> +ln -s /home/root /root


