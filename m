Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8CC83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 08:48:39 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.57068.1753951717563777507
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 01:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=ITrV8nDy;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V8mbwK3405514;
	Thu, 31 Jul 2025 03:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753951717;
	bh=ENqAUN4einBy5cO+RlNfo6fdBF7kP8LPS6dh/8PUCkY=;
	h=Date:Subject:To:References:CC:From:In-Reply-To;
	b=ITrV8nDyryxQvROi9Ur1C6Hb1QeTxtlBRWr7kOGttquI5qb/lshFbrE9HzCO/dSlA
	 bmpC70Eke3bPjk8cGOVpkHVRtEFJoUiRUylGg+eUCT0XKhUVKYm1c9aS3HnL5Kx0yM
	 Z9ps3mzHSUrWANczVexsmaegs0wPTtb7V6FL8aLo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V8mbb64099584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 03:48:37 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:48:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:48:36 -0500
Received: from [172.24.31.85] (lt2k2yfk3.dhcp.ti.com [172.24.31.85])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V8mYSQ2638187;
	Thu, 31 Jul 2025 03:48:35 -0500
Message-ID: <b8b1f90f-9e63-48e3-9588-6f53bd2fb02c@ti.com>
Date: Thu, 31 Jul 2025 14:18:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip] arm64: dts: k3-am62p: Add Microsoft
 fTPM node
To: Jan Kiszka <jan.kiszka@web.de>, <cip-dev@lists.cip-project.org>
References: <20250722094913.1696068-1-s-adivi@ti.com>
 <ccda8942-6fe4-4e95-9e35-7ad0f9482cfc@web.de>
Content-Language: en-US
CC: <vigneshr@ti.com>
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <ccda8942-6fe4-4e95-9e35-7ad0f9482cfc@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 08:48:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19638

Hi Jan,

On 7/23/2025 3:22 AM, Jan Kiszka wrote:
> On 22.07.25 11:49, Sai Sree Kartheek Adivi wrote:
>> Add a node for Microsoft firmware-based TPM.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62p.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
>> index 75a15c368c11b..91b9ec44fa437 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
>> @@ -29,6 +29,11 @@ psci: psci {
>>   			compatible = "arm,psci-1.0";
>>   			method = "smc";
>>   		};
>> +
>> +		tpm@0 {
>> +			compatible = "microsoft,ftpm";
>> +			status = "okay";
>> +		};
>>   	};
>>   
>>   	a53_timer0: timer-cl0-cpu0 {
> 
> Is this a backport from upstream? Then please reference the related
> commit. If not, push it upstream first, then to the CIP kernel.

On further review, this DT node is not needed.
The driver matches based on the UUID and doesn't require an explicit dt 
entry.

Ignore this patch.

> 
> Jan
> 


