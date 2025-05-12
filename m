Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F5C3ABC3
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 06:22:40 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web10.43760.1747030950933046282
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 23:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=p7J/b15w;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54C6MUeG1908806
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 01:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747030950;
	bh=EzE++iGpQAlUkyAKLgpDDhXkFULxLbc1av/qA+aXYE4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=p7J/b15w0IPgPaLemck9DsOaO1En+2ENgcfbYGOoUIo9SB2D8Rrz+Ul6XzbiAMBZv
	 U3xVQc5sAYti7PVp6TlIIQPJMVu6a6wzYgmXIOBCqGBM3CT+7e3vQg6pVDN0KEP+ST
	 +63HPeXSi7j+lhme38Wq/PsA4t0CDOhiVhlSvWJA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54C6MUUO084152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 May 2025 01:22:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 May 2025 01:22:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 May 2025 01:22:29 -0500
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54C6MRAX065409;
	Mon, 12 May 2025 01:22:28 -0500
Message-ID: <8bff5b71-eaca-4d5c-a36f-d5c9be948d84@ti.com>
Date: Mon, 12 May 2025 11:52:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Support for TI AM62P SK in isar-cip-core: U-Boot and
 Kernel Version Plans
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Khasim, Syed Mohammed"
	<khasim@ti.com>, <jan.kiszka@siemens.com>
References: <183E89A11723007A.2891@lists.cip-project.org>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <183E89A11723007A.2891@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18891

++ Jan

On 5/11/2025 11:07 PM, Sai Sree Kartheek Adivi via lists.cip-project.org 
wrote:
> Dear CIP Developers,
> 
> I am planning to add support for the TI AM62P SK platform to the isar- 
> cip-core project. However, I have a couple of questions regarding 
> version alignments for both U-Boot and the Linux Kernel:
> 
> 1. U-Boot:
> Currently, isar-cip-core uses U-Boot 2024.01 across all supported 
> platforms. The TI AM62P SK platform is supported only from U-Boot 
> version 2025.01 onwards.
> 
> What is the current plan or timeline for updating isar-cip-core to U- 
> Boot 2025.01?
> 
> Alternatively, would it be acceptable to introduce U-Boot 2025.01 only 
> for TI AM62P SK while retaining 2024.01 for other platforms?
> 
> 2. Linux Kernel:
> I noticed that a branch for 6.12.y-cip has been created. Since TI AM62P 
> SK support is not available in the current 6.1.y-cip kernel, we would 
> prefer to use the 6.12 baseline rather than backporting support to 
> 6.1.y-cip.
> 
> Is there a plan/timeline for integrating the 6.12.y-cip kernel into 
> isar-cip-core?
> 
> 
> Your insights on these points will help guide next steps for this 
> platform addition. Thank you for your time and expertise.
> 
> Best regards,
> Sai Sree Kartheek Adivi,
> Texas Instruments
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18887): https://lists.cip-project.org/g/cip-dev/message/18887
> Mute This Topic: https://lists.cip-project.org/mt/113057730/6838297
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [s-adivi@ti.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


