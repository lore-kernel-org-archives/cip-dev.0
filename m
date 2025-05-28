Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB1C3ABB2
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 09:00:56 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 by mx.groups.io with SMTP id smtpd.web11.11405.1748422844728237615
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 May 2025 02:00:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=NZ9on5Qn;
 spf=pass (domain: ti.com, ip: 198.47.23.235, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54S90hHe2052179;
	Wed, 28 May 2025 04:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748422843;
	bh=qscrWgqCKTm6zxq+9KfABqF2HQkeddrtUbSZ1975TA0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=NZ9on5QnEPr4K72OxTleHPLnMECLGGebnq8ThuFCfszqrJdYY9lzNUouU/jP73CMN
	 PiaryZaRyeYXe3kuFAMljkDoOgQtnFrSlDLD9y1Fbq349NPNOulxHg7lQ9fNCymrDr
	 FyF5IZoc2XoX0q9dJyxvNvA1l95FUFBz8sB3brpg=
Received: from DFLE20.ent.ti.com (dfle20.ent.ti.com [10.64.6.57])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54S90hZp3317462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 May 2025 04:00:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.10; Wed, 28 May
 2025 04:00:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 04:00:43 -0500
Received: from [172.24.30.41] (lt2k2yfk3.dhcp.ti.com [172.24.30.41])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54S90gf6069729;
	Wed, 28 May 2025 04:00:42 -0500
Message-ID: <dfdc5118-7a52-4511-bad0-abd334030127@ti.com>
Date: Wed, 28 May 2025 14:30:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/5] linux-cip: Add support for building
 branch heads, cleanups
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <cover.1748011667.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 09:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18952



On 5/23/2025 8:17 PM, Jan Kiszka wrote:
> Changes in v2:
>   - fix update-linux-cip.sh script
>   - shellcheck cleanups for the latter
>   - 4.19.325-cip120-rt42 kernel recipe update
> 
> This turned out to be trickier than I thought, but now it seems to work
> fine. Please check.
Hey Jan, thanks for the patches. I'll check it out today.

- Kartheek

> 
> Jan
> 
> Jan Kiszka (5):
>    linux-cip: Prepare for building from git branches
>    linux-cip: Add support for building head of development branches
>    Expose kernel branch head recipes via kas option and Kconfig
>    scripts/update-linux-cip.sh: Address shellcheck findings
>    linux-cip: Update to 4.19.325-cip120-rt42
> 
>   Kconfig                                       | 11 ++++++
>   kas/opt/kernel-head.yml                       | 18 ++++++++++
>   recipes-kernel/linux/linux-cip-common.inc     |  9 +----
>   recipes-kernel/linux/linux-cip-head.inc       | 34 +++++++++++++++++++
>   ...x-cip-common.inc => linux-cip-release.inc} | 11 ++----
>   .../linux/linux-cip-rt_4.19-cip-head.bb       |  1 +
>   ...b => linux-cip-rt_4.19.325-cip120-rt42.bb} |  4 +--
>   .../linux/linux-cip-rt_4.4-cip-head.bb        |  1 +
>   .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb  |  2 +-
>   .../linux/linux-cip-rt_5.10-cip-head.bb       |  1 +
>   .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb |  2 +-
>   .../linux/linux-cip-rt_6.1-cip-head.bb        |  1 +
>   .../linux/linux-cip-rt_6.1.134-cip41-rt22.bb  |  2 +-
>   .../linux/linux-cip-rt_6.12-cip-head.bb       |  1 +
>   .../linux/linux-cip_4.19-cip-head.bb          |  1 +
>   .../linux/linux-cip_4.19.325-cip120.bb        |  2 +-
>   .../linux/linux-cip_4.4-cip-head.bb           |  1 +
>   .../linux/linux-cip_4.4.302-cip99.bb          |  2 +-
>   .../linux/linux-cip_5.10-cip-head.bb          |  1 +
>   .../linux/linux-cip_5.10.237-cip60.bb         |  2 +-
>   .../linux/linux-cip_6.1-cip-head.bb           |  1 +
>   .../linux/linux-cip_6.1.137-cip42.bb          |  2 +-
>   .../linux/linux-cip_6.12-cip-head.bb          |  1 +
>   .../linux/linux-cip_6.12.29-cip1.bb           |  2 +-
>   scripts/update-linux-cip.sh                   | 26 +++++++-------
>   25 files changed, 99 insertions(+), 40 deletions(-)
>   create mode 100644 kas/opt/kernel-head.yml
>   create mode 100644 recipes-kernel/linux/linux-cip-head.inc
>   copy recipes-kernel/linux/{linux-cip-common.inc => linux-cip-release.inc} (50%)
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
>   rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip118-rt41.bb => linux-cip-rt_4.19.325-cip120-rt42.bb} (57%)
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_4.19-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_4.4-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_5.10-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_6.1-cip-head.bb
>   create mode 120000 recipes-kernel/linux/linux-cip_6.12-cip-head.bb
> 


