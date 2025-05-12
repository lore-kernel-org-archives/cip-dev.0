Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6FC3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 10:50:34 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web10.47329.1747047030660829520
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 03:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=xrJRSsBV;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: s-adivi@ti.com)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54CAoTk72556395
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747047029;
	bh=OB3OPxdysTorHXzdbyVzKpRhMLou+bwoap6XaTOw/18=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xrJRSsBVvTcdgFwS0vYz+H1qERdyGSDPae6pw/1QLKNLNfNJAPHnjcg3ESTEnde4e
	 2WgQ57tF5mjsTXHQzQzZW6V7yrOcYc4orcnyon3YcVuQFODtb1yrceE38LOH4l1TTi
	 CF9pLe26hiwcn+zF8WoioJmpY1VvjhiZJEZXlFt8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54CAoTCK001289
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 May 2025 05:50:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 May 2025 05:50:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 May 2025 05:50:28 -0500
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54CAoQrL118722;
	Mon, 12 May 2025 05:50:27 -0500
Message-ID: <edf08b49-384b-4b17-ae5a-8462e18cc52f@ti.com>
Date: Mon, 12 May 2025 16:20:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Support for TI AM62P SK in isar-cip-core: U-Boot and Kernel
 Version Plans
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Khasim, Syed Mohammed"
	<khasim@ti.com>
References: <3574c4cc-2ab7-4e97-945c-24c959891eb6@email.android.com>
 <3a67fc32-2eba-4d2f-b4ed-c7e929d52d76@siemens.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <3a67fc32-2eba-4d2f-b4ed-c7e929d52d76@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 10:50:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18895



On 5/12/2025 12:20 PM, Jan Kiszka wrote:
> On 11.05.25 19:37, Adivi, Sai Sree Kartheek wrote:
>> Dear CIP Developers,
>>
>> I am planning to add support for the TI AM62P SK platform to the isar-
>> cip-core project. However, I have a couple of questions regarding
>> version alignments for both U-Boot and the Linux Kernel:
>>
>> 1. U-Boot:
>> Currently, isar-cip-core uses U-Boot 2024.01 across all supported
>> platforms. The TI AM62P SK platform is supported only from U-Boot
>> version 2025.01 onwards.
>>
>> What is the current plan or timeline for updating isar-cip-core to U-
>> Boot 2025.01?
>>
> 
> This is demand-driven, specifically as the U-Boot recipes are only
> helpers for the demo/test images, not part of CIP's regular support.
> 
>> Alternatively, would it be acceptable to introduce U-Boot 2025.01 only
>> for TI AM62P SK while retaining 2024.01 for other platforms?
> 
> Only if really needed. Default is updating them all. U-Boot has no
> stable lines, so this is generally recommended anyway.

Jan, Thanks for the inputs. For u-boot, I'll proceed with a recipe for 
2025.01 specifically for TI AM62P SK for now. That said, I'm curious to 
hear thoughts from everyone else on updating all platforms to 2025.01, 
as a consistent version might be easier to maintain.

> 
>>
>> 2. Linux Kernel:
>> I noticed that a branch for 6.12.y-cip has been created. Since TI AM62P
>> SK support is not available in the current 6.1.y-cip kernel, we would
>> prefer to use the 6.12 baseline rather than backporting support to
>> 6.1.y-cip.
>>
>> Is there a plan/timeline for integrating the 6.12.y-cip kernel into
>> isar-cip-core?
>>
> 
> Once it has been tagged, but that should happen rather soon. We
> currently do not have any cip kernel recipe to track latest branch
> heads. Adding such an option would not be a big deal (see e.g.
> xenomai-images), but no one asked for it so far. Would you see benefits
> in having such a recipe also in the future?

IMO, having a recipe that tracks the latest branch head (eg. 6.12.y-cip) 
could be helpful especially during bring-up of newer platforms like 
AM62P before the tags are available. It might be worth considering.

- Kartheek

> 
> Jan
> 


