Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ADDC433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 07:15:16 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.54])
 by mx.groups.io with SMTP id smtpd.web10.7834.1664867712588753283
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 00:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vd96P3gG;
 spf=pass (domain: siemens.com, ip: 40.107.15.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0/8UsLCPnJ5zNdiDrQMpAljNt/B5JllYzXtqsQZEwJ6tytl2SZzpaCMyj8r3izygnkno5p4wbjE+R8iyQFBIPKLEM13U2+EaagHB5NqIOggqCOuVrSf5Jf63KYuzzWsvfD0MCvaDHutRxA9M8JQOOe3qH9JY2lYdQkfClb8g/OUnxolGRZsAid+J4sLYGlC1iHA2TtscGExDcpP0qNAcP1gmtJX1ZjbMZWtPqUpICP1bDhJcPzLY6V2LfC3gXMm1a5K01GabmkxuAkZ9IgGwz7+OWV2tgmM/B1MjP+yhqVgCS6Uzs4XhL/uhQzyfdHwIhwctGutNKs3+Q1AA/bhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hyB+CHYnZ0AgqUA2xN5gJTngWk/uevrP7fAw//NCaQ=;
 b=hnOqNoQc7EIPq3IdxKWMLmMTvSOqCLtfvRmXPQxMyriDTU8V8e8kQAHLO+dMB5oYAiDNghoaHg5ezbtkits9RGiXIiW8j0oXMoQKnqJqeRmfeqR5NyZTPVRSTR/1Hc2XzAApVFxyJQPMCM5t5vpEfdYvgrDKafvmIHxYebH4EPvo6WB+E6c2/DJd6u+mROp7aCTQGhCXn4MLbl6nKekjxSl9osDw8fBYeo67x7ZNwO9hbhpR65NbOdEwOK/j6myRMcjIgyo9cDO6Sb+0ZTq0S1BJ2hhDw4YspioELAM9wRqKLdNCc/GH/S56PvNwt3We9pBGsRds+0AhKV3BBsaieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hyB+CHYnZ0AgqUA2xN5gJTngWk/uevrP7fAw//NCaQ=;
 b=vd96P3gGUi8UGZJx6oPYQmD6bc81Yu0daEp7X2L8PN8Sa3XLcJ6/isZr3kXHTqv0o5Ov07fxOYqTyonqX15h5IuSbAXes6vwNvM1w95Z+14i7UNDJCtoQQ2G9FF2zYxZBlRm2yUyA46+7Wvmp602fEFrr7Hs+k+Ljv1Ueuzn/Owia/AqGj6hESGzS/CFFVuNt1nchpBR2qpk1vLRIh6w5HeJMoJ917Kl60WSqYRF+acd3eR7c2thez7uhjWbmDzb6b59S82EeyO9pxjnTvi9CrYB4ZiCJHpCmSjNG10laeTkQzgvBWwP5HS/4fWam+1Pco7jyun4QVslIC5pOUrBVA==
Received: from GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::26) by
 AS4PR10MB6304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Tue, 4 Oct 2022 07:15:07 +0000
Received: from HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::7b) by GV3P280CA0120.outlook.office365.com
 (2603:10a6:150:8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Tue, 4 Oct 2022 07:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT052.mail.protection.outlook.com (10.152.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 07:15:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 09:15:06 +0200
Received: from [167.87.50.151] (167.87.50.151) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 09:15:05 +0200
Message-ID: <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
Date: Tue, 4 Oct 2022 09:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.50.151]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--26.608700-8.000000
X-TMASE-MatchedRID: aGuL5piyGFo5QaOxwNGfvo9bHfxDWoibfHiU4sgyENKSJLHHb2KALSIL
	dc+InEErhnD8O3TjwmaqvdBo59cuvYJ7FIx7rr75HJfBKeADu1Jekvfhupum40+zv2ByYSDQ+If
	riO3cV8RemWwoCXDj9U12MsUfZOu5m0gaTU0ieiL0Iu1L7a9dfybZZYAQu9H5nVTWWiNp+v/aCn
	4DqCiXNi2D3rEYFrWrbcIAC4/H04lZGVkkvtEl3bsmzCPdqRjh7fg45MYQVOJTNl9jB9u8gA73P
	4/aDCIFgS5EXD2qbc3h06w0q6p9rOrc8uu0MOs1ivMeQJxgaK6qJxP8CL5wCc87s4OnYGuCF4r8
	H5YrEqxdzCApzeAWWdwGCAa2ozWqxphflU1kRp0mr/ijxbVcUmIo6q3zeo5wwMXpzPaqjikhhX7
	+Q+JYQrRNETN/KlSa1YQOMzSVa7QcgEDIA4Ioxk3UF8McibY8lFVIONmcEd1fnPgojgNfwNhQO8
	CvZj/Xtwi3bXRtaAhgbfZku6SlU3qKlbNWS67whtfOGOSyK2lNfs8n85Te8oMbH85DUZXy/W9MY
	GK5mu3UZxEAlFPo8/cUt5lc1lLgkU6UkIr/V+1nME/Jsn/m+g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.608700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 134DE7A6E3B0365806D61FE53B606C592533379655094723B3B782107CFBE9932000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT052:EE_|AS4PR10MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: e76446eb-3b66-4987-0d1b-08daa5d82a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y+Cg1+Q8bwy4ruvA9DMnIrNSyRirmDSLRtxIRWbyK7/HyLnDVcOhJ0Y6DGImsV+doehGd8PysxVbXEdaUrcBKNLb/cQBn2Dq8PxNz9q97CT5dpYy2kXQsHWgM25MT1NjYb9mIl4VbNcP3T6iDExlnLSkyj3Xxu0Mk8Qpr90ika66ZUkRxiYZytJ5u3wenrPkZqDToFXLoqhYpA4eq6pQQwNQeG86gR611BjxyWp2rDf0Y7y1Audd5aaqcz/1b1YAcFee79ugXH876W6H8GpKi3WrNcZMYyvfxGE1h7c8/XiK6HzUQ3Hpe0HqVA+yIws9l7ruLI0n0ME/GePPZskv1TPnhBxc+tSE0hBnCDAvgB7xYHWrRTiCI3aj9Qqfl8+eoMI6q0ALON2fnNR6pu4v5MBOyIQTcYVnf/xHdgLBamXPdEpV0ZF/mq4tVWKykKNocjzb07gHNtqvT0XjOF3W5U2yyVk1IfAHi25AyKZjxD+Q9T2+V1MO6v8xW2UDYee0mCb0+pAWclxDktN1p4N0wgzD+BtCW2wJ+yzqlnI2m1a1tcBqgXHdfbzPL/j0iSf5TP/xRES+NK3nB2XKMFcCnt+NEqE914JreLzVdqOrZINLqF/74H4X1JBxB/EqEtbrVfj9ZXJOwv8SF/oi6sTaYToWCIHMPpwd9/W/bf4zT9cKHu1Fyhvcj2eaU7GsHR2ZfdgcEv1mEuAxOVoE0iAx52+rlYKMJ5PBGIbBMY8dLqVXC59bU3U8CubHALvNfQQvD4nKEKlktTnXdjN5/qvXqjoifkckAPGSjFIua23Q2u4nrFaCXr8Opk0J1YxdCxOji3hoNkiCHhcYXDiRgv9axKU4jxAlcsJWAS9lA6Wbq8u4fbjAyqbuJA+of39L4+gZIU2zgxGnTEM21bT5smw8wg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(316002)(16576012)(66899015)(6706004)(110136005)(478600001)(82960400001)(5660300002)(26005)(53546011)(36756003)(31696002)(70206006)(956004)(70586007)(8676002)(186003)(336012)(4326008)(16526019)(2906002)(82740400003)(2616005)(44832011)(36860700001)(82310400005)(47076005)(40480700001)(966005)(7596003)(356005)(86362001)(40460700003)(7636003)(8936002)(83380400001)(41300700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:15:06.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e76446eb-3b66-4987-0d1b-08daa5d82a59
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6304
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 07:15:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9619

On 03.10.22 22:12, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 03 October 2022 19:36
>>
>> Hi Chris,
>>
>> after getting qemu-riscv64 ready (patches will come tomorrow), I also
> 
> Huzzah
> 
>> had a quick look at the RZ/Five eval board you shared with us. But that
>> raised a couple of questions, maybe you can help:
> 
> I can try :)
> 
>>
>>  - Why is the default U-Boot hard-wired to a very special boot mode? I'm
>>    missing standard distro boot - which would include UEFI as well.
> 
> Good question.
> @Prabhakar Mahadev Lad or @Hung Tran, could you help answer this?
> 
>>
>>  - Where is the U-Boot tree (upstream support is apparently missing)?
>>    I'm still trying to understand the instructions how to replace it in
>>    QSPI, but first I need a fixable source tree.
> 
> The Yocto BSP is here: https://github.com/renesas-rz/meta-rzg2/tree/dunfell/rzfive
> The U-Boot recipe points to https://github.com/renesas-rz/renesas-u-boot-cip/tree/v2021.12/rzf-smarc
> 
> You're obviously welcome to fork/fixup as you like.
> 

How is the upstreaming status here? For UEFI, a U-Boot from this year is
needed.

>>
>>  - Where is the kernel tree (also no upstream support yet)?
> 
> Kernel tree used by the current BSP is here: https://github.com/renesas-rz/rz_linux-cip/tree/rzfive-5.10-cip1
> 
> Upstreaming is still in progress.
> We're having some fun sharing things between arm64 and riscv, but we're getting there.
> I'm hoping we'll have something bootable in v6.2. 
> 

I see - over 700 patches for 5.10-cip...

>>
>>  - Can I reconfigure the carrier board to automatically power-on after a
>>    power cycle? Without that, it would be impossible to add the board to
>>    a remote lab.
> 
> Yea it's a bit of a pain.
> Two changes are actually needed to get these smarc platforms into a remote lab.
> 1) Change the power wiring so that everything powers on as soon as the AC connector is powered
> 2) Power the USB serial connection from the USB so it's always on
> 
> Let me know if you want the instructions for making these mods to the board.
> Note that we'll provide pre-modified boards for the CIP labs when the time comes.

Ah, ok. Thanks!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


