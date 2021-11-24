Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C505C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 07:36:39 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.3264.1637739398016623411
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 23:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AO7aY6m013207
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Nov 2021 08:36:35 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AO7aX6e025088;
	Wed, 24 Nov 2021 08:36:34 +0100
Subject: Re: [cip-dev][cip-kernel-config][PATCH 0/2] Add options for read-only
 rootfs
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b2760c82-8bb4-5fbc-74b3-5a1d2ef78c7a@siemens.com>
Date: Wed, 24 Nov 2021 08:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 07:36:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6985

On 12.11.21 17:38, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the necessary kernel options for a read-only rootfs with
> dm-verity, secure-boot and swupdate + overlay of /etc.
> 
> Quirin Gylstorff (2):
>   x86/cip_qemu_defconfig: Add options for read-only rootfs
>   x86/siemens_ipc227e_defconfig: Add options for read-only rootfs
> 
>  4.19.y-cip/x86/cip_qemu_defconfig        | 4 ++++
>  4.19.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
>  5.10.y-cip/x86/cip_qemu_defconfig        | 4 ++++
>  5.10.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 

Ping. Are merge requests preferred for this?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

