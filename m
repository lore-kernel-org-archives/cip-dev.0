Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609D2CAC5A5
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 07:04:49 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.10905.1758611080102252388
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 00:04:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=pvzWCRK/;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N74d5Z951972;
	Tue, 23 Sep 2025 02:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758611079;
	bh=wvJvW5fbcfEWalbmuh8+ZHakg7roA5pFBe2YOU28txQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=pvzWCRK/d5+91eFEoWh7a8RXxiVQy/duJTUb/o/UabTIFaxJETEHcM6WXXxqs2U4Q
	 Ha+jrUEhzcZ6vaPRfQCpTFYc0SMnznIlZ91IzH8XWcp9jfDwsAVI7zKC2WdOk0ZfH1
	 wS669QWNqCrkbdlNMssss4H3DxMqrKQpnpX9xcr0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N74doB1473290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 02:04:39 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 02:04:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 02:04:38 -0500
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N74bvw4102766;
	Tue, 23 Sep 2025 02:04:38 -0500
Message-ID: <7c34e296-e5c7-490f-931d-23e7b193f1ac@ti.com>
Date: Tue, 23 Sep 2025 12:34:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <vigneshr@ti.com>
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <a7c8ca61-26da-4714-9f6b-b91ac8e2a8d0@siemens.com>
 <678884fe-e78d-4299-a4df-192e69816cc3@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <678884fe-e78d-4299-a4df-192e69816cc3@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 07:04:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20092



On 8/18/25 21:39, Jan Kiszka wrote:
> On 18.08.25 17:17, Jan Kiszka wrote:
>> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>>> - optee-client, optee-ftpm:
>>>    - This integrate Microsoft's reference implementation of the TCG
>>>      TPM2.0 as an OPTee trusted application.
>>>      Since the OPTee secure storage on TI AM62Px SK is RPMB-based, and
>>>      the RPMB accessing is provided by linux tee-supplicant, this TA is
>>>      only discoverable when tee-supplicant is running.
>>>
>>
>> I started to refactor isar for switching to optee_ftpm. I'm collecting
>> bits right now, some are sent already (isar patches), others will follow
>> ASAP (wip branch for isar-cip-core - huge hack still as I'm enabling qemu).
>>
> 
> Here is the change to demonstrate everything in qemu.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb?ref_type=heads

Jan, I've got optee-ftpm to work on AM62P but Measured Boot is still not 
working. PCRs are not initialized.

Here's my branch based on your wip/qemu-rpmb of isar-cip-core + built 
with next of isar.
https://gitlab.com/sskartheekadivi/isar-cip-core/-/tree/wip-upstream-v3-optee-ftpm

Ref: https://github.com/OP-TEE/optee_ftpm/issues/20

> 
> It's still mostly a single, huge one. Will step-wise break it up. Next
> step should be the cross-board U-Boot update that we should do soon now
> and that should also help your patches.
> 
> Jan
> 
>> I also tested in-kernel RPMB supplicant which nicely obsoletes
>> tee-supplicant for us (StandaloneMM + fTPM), at least for kernels >=
>> 6.12 (needed anyway for stmm which was merged 6.7 or so).
>>
>>> - optee-os, optee-os-tadevkit:
>>>    - refactor optee-os recipe and add one for optee-os-tadevkit which is
>>>      required for optee-client
>>
>> We should not require optee-client anymore with in-kernel RPMB supplicant.
>>
>>>
>>> - u-boot:
>>>    - New patch to add ftpm node in the am62px device tree
>>
>> I think you already said that this is not needed. At least it is not for
>> the qemu-arm64 u-boot I'm using here.
>>
>>>    - Add rpmb-setup.cfg for setting up additional configs required for
>>>      enabling FTPM.
>>>
>>> - cip-core-image-security:
>>>    - Add newly added optee ta packages to cip-core-image-security
>>
>> Not needed for tee-supplicant anymore, but maybe there are other use
>> cases? But that should be discussed with the security WG, also regarding
>> maintenance implications for the additional component (even more if it
>> should be built from source).
>>
>> Jan
>>
> 


