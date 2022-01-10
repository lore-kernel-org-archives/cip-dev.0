Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68DC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 19:19:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web11.36805.1641842340132956756
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 11:19:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dGiqKdy+;
 spf=pass (domain: siemens.com, ip: 40.107.22.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ1x3qjqARleoTJJD96b+IZmHMe+jQUMh4phn2K/T+Yr5mo0U02rS0SCuwyjtEFKLvUa2fCl1R08zsPe1Y3wur1jpX5XGaG/TcBfVbi6NBHni/i+wk4zSMP1cXLFM9w5974TrmGCS5CI+mz9tqR4o8DbUxSPtQ81EtgfriA8bLrQOfF3sF06WaqoaMprbNyiMtUKtxIugu6y+sF6fra1RRWBXoljh+n8KEIqw17u5cLpeIHTn6Ye+dZS/g8oZpovt8gTdYjcNkV8Ph/86KsVRRUJlIs15G2qtRcnTlYD+v/rUOCcbmhzHzbCOvbSYIH3TQDrditnAWbqTueSgqXPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULgvghfrZ0owgSGBa63h5G4atcIMYi4A6PIGJBaj8eY=;
 b=dgEc9NZAtyzMAfYSb98zKj7gN7iDoil0Eohopy6qAqrIkC22aQTxPpEKa4XMNzKBGiN8INgeeTKzzeC1kMXlKE1Vz9kvIkrF9xDHK+EkC5470ny7jAuWFGe5LjR8xjzdDBTLFroptGVWV0LncjZqhJslunpQs5bCuZjJY7yNNllAQSuv4h8ZtGEm5pJMgRdeFpQjDPyzk4IZ2OyVkMBfpanCHAScPB3+v41zwUCdxgYcJceo+7PBQZIKzynY3dVKrOnCToyeEKnkYkiM9kpDaYc6soybRF1Hy8RXfUZz3+G9N5ZaDe2zco1vVfqhWVepbprU/heBPtvfDIYPZIKBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULgvghfrZ0owgSGBa63h5G4atcIMYi4A6PIGJBaj8eY=;
 b=dGiqKdy+r3xrh5L3RDpAy/AVfKQgzbo3jKnptd6SryLuNAJ46rFAUkeSWYxuQszRy+9HYU8LkHC6FbpfpdyFrzz5L1H4IUkq7pi7tOLEMVSxsW6uyV/26/r7ZDdcX13OLJE6TwMnoHt2ZOno847GkGLpP8tTdzV3tCQXSruHT5D7DDbmE9XnzPH3zbkATtEMi4HNfflsYESwT16H6ZJLVJHproFXT1/a6DcZpRn8UHZJYuvxGeYpHE9J0NPGZvnQZ4psgWppoWXmKmjaK0LNp47JkxO2Gci/TPwUPTdra8AyEZtf4RzOCKKXrATnQR+tMupOiZA9F3XEuLFtELhVsQ==
Received: from DU2PR04CA0194.eurprd04.prod.outlook.com (2603:10a6:10:28d::19)
 by DB9PR10MB4829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 19:18:57 +0000
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::5f) by DU2PR04CA0194.outlook.office365.com
 (2603:10a6:10:28d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 19:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT013.mail.protection.outlook.com (10.152.4.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 19:18:57 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 10 Jan 2022 20:18:56 +0100
Received: from [139.22.142.192] (139.22.142.192) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 10 Jan 2022 20:18:56 +0100
Message-ID: <54372c9e-b214-c562-ff7b-eb830bf55db7@siemens.com>
Date: Mon, 10 Jan 2022 20:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/15]
 clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Nobuhiro
 Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922EF302739734E1311CBF486509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220110183329.GC3396@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220110183329.GC3396@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.192]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4e526e-3c4d-4ffb-8e23-08d9d46e0cbc
X-MS-TrafficTypeDiagnostic: DB9PR10MB4829:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4829DCE76FE9F4AD3BA7B4D795509@DB9PR10MB4829.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M09WRDJsQ2hlRWZtMUZxMW1Tb1ZlRmpNR2hCckpOY0RWTWhMNFM0Zk0yYXdK?=
 =?utf-8?B?SVAxT21tKzlBbE9UTXc2aUdYb2k3WStCc3ZNM2l3UzllM0haR3g2cWp1RENN?=
 =?utf-8?B?MXpRTmlXMWlrbFVSZzJuR0FrQVdsTjVFSWt6c1V2aE1qbVU1TWg0TERHZ0Jp?=
 =?utf-8?B?c2VHRVdWV0I1Z1BBblpOb0NWcWQvblBxd25sOXIrek5jMDhhQ09Ea1dkV0FC?=
 =?utf-8?B?djFGRytUNUg5U1ZxM2tjS0ZGVHZnSS9BcFNUVE02dEZrQWpyaHNTRmEyZll2?=
 =?utf-8?B?blZRMlRFR0VvWXJPSFoxTHExQUJRWUpQNzRtVWtyR3B5UVdUbit3OExMRnZz?=
 =?utf-8?B?ZC9OVjZpVCtIdEViZmhVcVRlOWJWQmQ5THdFbEdvVzIzeXdRdXJvRHRoVjRI?=
 =?utf-8?B?RGdyMFRJTlNBQWIrTHBrL1VPeDdIR09LT3Zjd2ZOVjRBSi9hVjlkMnAybjVF?=
 =?utf-8?B?UjFmVjZjMHBlaElNcnBDZTV2VUdXWk1Ra083SzI2TDJPeWhnUkc4aFRCSFBE?=
 =?utf-8?B?TDVCNjV2RUNFdk5WU2t6VG1wVElqUFZXWFdEVjBtVWZlaklveUNUb2VQekcx?=
 =?utf-8?B?aUEvQ3lTbTA1dDBoZFM1YVpWTjNWWXdtSFpYTzZHbysyK2RJVXhtZkxreENq?=
 =?utf-8?B?N1laaEJ4YytObzhQVmNIVU1BVnJ0QnE4ZmQweWFHTWI1UDA1QVFCbDQ3MVp2?=
 =?utf-8?B?dkpIS09HV3dmeWRRMWtKZDdXUGZPYmY1TkV0TDhVYmpidkh2K3N1d0N0MG5O?=
 =?utf-8?B?eDJVR1FNOURYeEp2OENoV1o2NmsrYTV5amVtZTlmUkM0TEpZNklMZ01KWHRw?=
 =?utf-8?B?c3VVdmhoekFNVTR2K2RvVEhrMkIwVENRMVZPVEp0bDduUUxqOVBEYkRNOWtx?=
 =?utf-8?B?cjg2R2NhMmgrRm5kYnVsbFlyYnNtbEZ6cklTUW1NTjNnUVdtMjIvRWxWVUtX?=
 =?utf-8?B?TGpLVFhIaTdwdTRicHBRQVRDRUVYUk1CTldpemNNcm43cU5uQjFzWHhEbUpK?=
 =?utf-8?B?bERTTWJ2cEErdURxN3lna01GRGhQRWNzd0E0SXRFOHNXczkwSDJweEk4UmZT?=
 =?utf-8?B?bEZ0RzlyeTN1R1RmY3d1K3BxdVIyeHEwM01Rb29sdm9yT1JaR2pndEd0S0VO?=
 =?utf-8?B?ZWhVVlc4RkpUZHYxZ2pDZHNXcnBSbi96NEhtQ2FaT25sYVRqVGN0eVFoWUFQ?=
 =?utf-8?B?ekZlT3BHM09GMktBTE5PNXlJYVh3dG41OEF3OXV6YnpFV3FnZDE0VEVBeWlp?=
 =?utf-8?B?QXhQTDJndVU3MXZnOXBCY1BiYlN0Mk9CSno4SUd3ZWNISm9tTWh0YlVLaSt0?=
 =?utf-8?Q?1bvUFAqfjFEfg=3D?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(82960400001)(2616005)(82310400004)(8936002)(956004)(36860700001)(31696002)(8676002)(316002)(86362001)(70206006)(83380400001)(356005)(44832011)(508600001)(2906002)(36756003)(4326008)(966005)(6706004)(26005)(54906003)(53546011)(81166007)(110136005)(47076005)(16526019)(31686004)(336012)(40460700001)(16576012)(5660300002)(70586007)(186003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:18:57.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9f4e526e-3c4d-4ffb-8e23-08d9d46e0cbc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4829
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 19:19:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7439

On 10.01.22 19:33, Pavel Machek wrote:
> Hi!
> 
>> Is it possible to rearrange this patch before [1] and after [2]?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-5.10.y-cip&id=dcbef66029571fbada7522b2db0790e5ff054c66
>>
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-5.10.y-cip&id=e2568c0c7de565a5688544907422ca470844df87
>>
> 
> Wow.
> 
> It means changing history. We usually try to avoid that, as it will
> cause problems for people using git head. But we did not yet do a
> release with those commits, so it is not completely out of question.
> 
> How important is that? At the very least I'll need to know that rest
> of the kernel team is okay with it.
> 
> commit e2568c0c7de565a5688544907422ca470844df87
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> Date:   Mon Dec 20 13:31:30 2021 +0000
> 
> commit dcbef66029571fbada7522b2db0790e5ff054c66
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> Date:   Thu Dec 16 12:54:46 2021 +0000
> 
>       clk: renesas: rzg2l: Fix clk status function
> 
> Best regards,
> 								Pavel

Patch application in unfortunate order is a very common issue in 
upstream: dependencies are missed, patches take different routes through 
different maintainer trees, bugs get fixed only after the patch was 
applied. In none of these cases, a maintainer did a force-push so far 
(to my best knowledge), why should CIP do that?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

