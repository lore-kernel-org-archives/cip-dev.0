Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D2C433F5
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 06:20:00 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.2672.1637734799478057723
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 22:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AO6JmK6002555
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Nov 2021 07:19:49 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AO6Jkan025079;
	Wed, 24 Nov 2021 07:19:47 +0100
Subject: Re: [cip-dev][isar-cip-core][RESEND PATCH 0/2] Add support to test
 WiFi on RZ/G2M
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>
References: <20211123182302.8976-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e64827e-0778-c74c-73e9-207e21a35b37@siemens.com>
Date: Wed, 24 Nov 2021 07:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123182302.8976-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 06:20:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6984

On 23.11.21 19:23, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds support to install required tools and firmware
> for testing WiFi on HiHope RZ/G2M platform.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   customizations: Add support to include tools and Firmware required for
>     WiFi testing
>   conf: hihope-rzg2m: Enable tools and firmware for testing WiFi
> 
>  conf/machine/hihope-rzg2m.conf                | 3 +++
>  recipes-core/customizations/customizations.bb | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

