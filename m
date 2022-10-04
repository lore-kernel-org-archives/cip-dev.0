Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94234C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 18:28:19 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.45])
 by mx.groups.io with SMTP id smtpd.web12.14448.1664908090014954766
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 11:28:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sw3rU5n1;
 spf=pass (domain: siemens.com, ip: 40.107.6.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZql3yiufVYDLOAfS5DGoSIb9FaFHCxBGg0UHmuHZsapSMW2b+TeYKNZnAYBcAv2xgVB5AwRZWNx3ayGvI65YXFqqNeJJhzWgIi96nwIlIJxWpHE5/cDtl3rrrJPTpho2PfkMmalaJWbEc9ggJsByqDqr1T9xhgse6qty2UZXN1Kj/1815CBpeyWhf+Pv1NYIbRVbIxPVXDYUnRafdnN0tMBNYHXDwah1DsrE10IFO/6J8BHPDUnx09QSpzeHhJVszGr26rZ8cotp/YJ30cG+bJQjzPOtHYGivH14SH1DN7ifP7jHFGkXrFFlrYvOC7RkuZnWparLQcyl3gVIEKCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Vx/u2LVZJmsERPiYzKrX6AeljvkpoHVkQ7hmUI3gY=;
 b=B9QqpY40SxOvwc9RGy4294c5GgS73PZqo+HEW7q8Y0W/QV5h31+G7cgAoOmpHedKKIBq3UBsBS2KuqGZTmWRQDSY8AncFsexf9GrFGdjCTbARaLMow5bqGEM6rNP6bmCcrztCgNNypyi/Ea3H9TTrqxiqqRom10Rh2KyjK7uABzWYtQes3ube5/GChwbFpmCSCr57KfkRdIOXPJ0woaG5g5q62koSyjrI9Sq2LfQf85YvvRJZHOc0BQMGTBaXNNkgpaGDllnJcJ9FPUgtXzILIKoJK14zfuOyl4/JxCE0YE/tYHs1c0MMMQl8titJ3p3MfNpiR4gwAmk8VurafGJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Vx/u2LVZJmsERPiYzKrX6AeljvkpoHVkQ7hmUI3gY=;
 b=sw3rU5n1NLtPsZapfUioCitYWXO+5Uc88UEztGSWsx+nRXhWQkkiz3RudGzkRPNQsqgZ5DUtvv3eIvIs9zB1m/SVtaB4dg2EJIYDIEzlVygKKN2QZKycG8VZaEXRm8qEYchVYMPrHJLYvSe0xDuJzKLg3EOJ9XvyeSX1mlBrcqtdMkmwWiT0a9a08BVrWOzkBNJvw8Icqp0W1LicsiUwlbXhJrz99eMYbb7AX7RRWAzttv4WgBsQwiseXAvo4OD7A/uT4eyj/GD25lIQHhkRQALA+hP32FErsrqzQgEumHr0BQjaN84UlYfFtV2Te/qyZB174nk4dcfMN7qrr6ZLXw==
Received: from FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::17)
 by DB4PR10MB6239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 18:28:07 +0000
Received: from VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:48:cafe::61) by FR0P281CA0053.outlook.office365.com
 (2603:10a6:d10:48::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Tue, 4 Oct 2022 18:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT102.mail.protection.outlook.com (10.152.3.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 18:28:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 20:28:05 +0200
Received: from [167.87.17.190] (167.87.17.190) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 20:28:05 +0200
Message-ID: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
Date: Tue, 4 Oct 2022 20:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
In-Reply-To: <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.190]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.797200-8.000000
X-TMASE-MatchedRID: 0sa3XW9m2I05QaOxwNGfvo9bHfxDWoibfHiU4sgyENKSJLHHb2KALSIL
	dc+InEErhnD8O3TjwmaqvdBo59cuvYJ7FIx7rr75HJfBKeADu1Jekvfhupum40+zv2ByYSDQ+If
	riO3cV8RemWwoCXDj9U12MsUfZOu5m0gaTU0ieiL0Iu1L7a9dfybZZYAQu9H5nVTWWiNp+v/aCn
	4DqCiXNi2D3rEYFrWrbcIAC4/H04lZGVkkvtEl3bsmzCPdqRjh7fg45MYQVOJTNl9jB9u8gA73P
	4/aDCIFgS5EXD2qbc3h06w0q6p9rOrc8uu0MOs1zbPoUo0CxxCdJYZJuTnwNmj110VUgQaLZZUe
	n1+EmbmUAUfla+IhaLKXWmEvaG3ECxvAgaTHFy+Rk6XtYogiau9c69BWUTGwwLhRRmviVIX6APa
	9i04WGCq2rl3dzGQ1TaxwcKK3s96QjaaYuRrq+vWtHsKkvMpnt76rEpMX/+3h1i+zxbATxA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.797200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D79E1A05E295A4EED1262CBE1C16258EA19172106526675734ECA0D34940A0F92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT102:EE_|DB4PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e91176b-642c-40c4-8ca7-08daa6362eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8PNkEgsZtpsZWDfEToN2qC1Qry0jwn1PXn2NcDnuxfYACgYjAQdy/RZ/ByM0JXsHz3dakuTY/egko7f8g34YTd96t06GREwLO2kMcIMnGlo7xFxK2V2Z8QwTl/FpmIRteXu4m7FX2JFkn1SPL7ktM3pbs6ye21h4gW/iGcVzNsnkqpzq49NaxuIs/+tm5JfNeq3zNAfgggLoLDOiio1hsR7+b45MJD5vO04ym5jNTqswnEjCqawXhLf1YXL0e4iEyPs8fjDowaHkFbWdIBkt74AUSI+75QEXrq7uwe95ugGDTtStaf12GNFxJ9vc9R/yS2DNkn0Yf8QeMPmBj5MQ9csDkUOB3HFT1fjMETJeEDIV38ueyrvksNEuLJHdeA4v/951v/NW00jzs70FP+UGiH4npnKwwhyDMUmaxFiS1gztxjXx6Zbzf3sCMFhNIzvPJCXc83fPkHsXtl1ME8kM24qIH0hVYCDJjQnhiCfl3J8JWuc8+QGlWtOC/CNbkrtiEwXCIubdVz7XXVFP0wTz29yvBobIlAy23pUdMtPec8ycwGc2MmfqGKrCIfjoaD2Q95f13alrx7uDknPv81fm7A0+Y3x+DCosUmrzNGIdvFLz60pYLC1YqVeI7ZPLJxCCCM1zql6mgySVeqtIiDNXiAkA0gADWZysxSquvL4FwtnorHtfOtOyeeqEnAu62t868mNYlonmGWtFzxBuT/+ICo58EIOqScuRM4wdOUv8THjW+FLF/q7CUvcMyEUtXfLFrGS8OLEzYJq6tC7J7h4kmi9DwH7F4TtPwki+eRyN56XKc70p2SurpEoZtsRTkc1fnkZ0KBNQN5oE1k4dhi7oM+1xkDquukD2WDFrk5KS/HiOB9RvdmWr+YdSU++XUqqgGNfNXbpmwrULtu+vliDRQafayIjfMQXnKZx/+KywvHWjtP/w1wgspYc3HYDgBX4T
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(47076005)(956004)(82960400001)(2616005)(336012)(356005)(82740400003)(16526019)(44832011)(2906002)(82310400005)(36860700001)(41300700001)(40480700001)(478600001)(70586007)(5660300002)(8936002)(40460700003)(53546011)(966005)(8676002)(26005)(316002)(4326008)(70206006)(186003)(16576012)(110136005)(36756003)(31686004)(66899015)(6706004)(31696002)(86362001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 18:28:06.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3e91176b-642c-40c4-8ca7-08daa6362eae
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 18:28:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9637

On 04.10.22 09:15, Jan Kiszka wrote:
> On 03.10.22 22:12, Chris Paterson wrote:
>> Hello Jan,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 03 October 2022 19:36
>>>
>>> Hi Chris,
>>>
>>> after getting qemu-riscv64 ready (patches will come tomorrow), I also
>>
>> Huzzah
>>
>>> had a quick look at the RZ/Five eval board you shared with us. But that
>>> raised a couple of questions, maybe you can help:
>>
>> I can try :)
>>
>>>
>>>  - Why is the default U-Boot hard-wired to a very special boot mode? I'm
>>>    missing standard distro boot - which would include UEFI as well.
>>
>> Good question.
>> @Prabhakar Mahadev Lad or @Hung Tran, could you help answer this?
>>
>>>
>>>  - Where is the U-Boot tree (upstream support is apparently missing)?
>>>    I'm still trying to understand the instructions how to replace it in
>>>    QSPI, but first I need a fixable source tree.
>>
>> The Yocto BSP is here: https://github.com/renesas-rz/meta-rzg2/tree/dunfell/rzfive
>> The U-Boot recipe points to https://github.com/renesas-rz/renesas-u-boot-cip/tree/v2021.12/rzf-smarc
>>
>> You're obviously welcome to fork/fixup as you like.
>>
> 
> How is the upstreaming status here? For UEFI, a U-Boot from this year is
> needed.
> 
>>>
>>>  - Where is the kernel tree (also no upstream support yet)?
>>
>> Kernel tree used by the current BSP is here: https://github.com/renesas-rz/rz_linux-cip/tree/rzfive-5.10-cip1
>>
>> Upstreaming is still in progress.
>> We're having some fun sharing things between arm64 and riscv, but we're getting there.
>> I'm hoping we'll have something bootable in v6.2. 
>>
> 
> I see - over 700 patches for 5.10-cip...
> 

...and it's based on an outdated CIP baseline. We are specifically
missing "riscv: fix build with binutils 2.38", compared to latest CIP
kernels. Those happily build with the Debian toolchain.

Fixing up locally for now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


