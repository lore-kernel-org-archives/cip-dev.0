Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAEFD0E6E4
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 10:25:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.46])
 by mx.groups.io with SMTP id smtpd.web11.42807.1729506311952473203
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 03:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vO6aGcKU;
 spf=pass (domain: siemens.com, ip: 40.107.20.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWBVmykc3Ido/hXWM8afyekHO6cbUaeGvnlzrOrN6BPwuD0jLA4DIrFEHyu7C7/hG93iyOfgQ/ItP+oxFp//bxTNxVZzW4EefUF2VMuvWYn76b/xNZ16rhjUe1OSE9G2hywBUzf+nIY2fIl8BB+vsuASW4kc5jl66chV194pDqLscBdP//QJGD7Rsp5gtiTBPlyMJNngzTVCzfsxG3AcVrnqBO+oOwRRybSBSLr4bndQgK5GkcM2ZELxLVFOBqA6s/IktOuBcG2PW7HMi4NZPCO3N8ewVYIrNhj9PNP6GujnrWYib1uvNeCrnHwQx/yma/sz+l6Scx8RxsfC/EycSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7SM0pm7ae40+HTfOVNLZwg3NE4SLdl4IVlk1crtUYQ=;
 b=ID0xVZhUdM7WmjLOcbIf5K5SXIwUGfYX4ClOwDDuJhLAdUUL9IbQe+jZvuTC4cGCGDx+fZhInQDmc259Gf0DvAecX+zfNtrx5IJvCO1UPsyw4Hudhl0cgZflIyZyQXlFOE7+1UCIE/D+xmHVLDaO7m1cECx6A2QAP63qk+LmzfMPbXuEAlhh7SFGoJIfbuuiD6swunRq65F9GHtACLkolaUDY9X+aiKfI/9EbRUL99Hyc6lSPWpIDFXzYcLiLVGaPFiSKhy32xi0YbOkQaHEQPxNsAlct9KsJesRjIuirKX5Ad/2ZNec6WRLYbNBcmQpyPoS+xTOMLuGrkjW+McHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7SM0pm7ae40+HTfOVNLZwg3NE4SLdl4IVlk1crtUYQ=;
 b=vO6aGcKUifKeQAOn7m0JLVdkVptxXy2TjuObFy7BymQQr7BtcxSmd7DVtk4j3Zniu/Bbn5hmOyhEgvW8vkn+hpnkptPBJ83yIkrVTC6GIHTSZTTifys+6GAV4rXbX1QM7lFBt2qSN1g11Eh1FUoWqRxCicV+1iqGdWkVeuSc11eCUDuZbnCsk8lFk2SnMwdo+DiITDHRicPJ2cpXFORPuKDdNgJnGE21rMcGWlI4RfRRJmhrliM0184m0ufwabGxUK5+UiDHEO7uVLQIto3kk6mkmlO4AJknmwQEfhl3/08h43dBrdk7srw1axoQVxOZwZ3diAfAiaPB0HQiGNIZZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 10:25:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 10:25:08 +0000
Message-ID: <1fb9c7f6-81eb-4f3a-941f-ccbe97112816@siemens.com>
Date: Mon, 21 Oct 2024 12:25:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: cip-core: Something fishy with qemu devices?
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
References: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
 <TYYSPRMB0010816199991F38C90CA81FB7432@TYYSPRMB0010.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYSPRMB0010816199991F38C90CA81FB7432@TYYSPRMB0010.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4152701d-96c9-467c-d4e7-08dcf1baa33b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C2GXliiHRYzrjri0bhI1J/tB6Wt0I+92pfn9jdY+Gt/zEe7B6fZulvuBGQOq?=
 =?us-ascii?Q?38PrgzmxxliwG3gbmLx2kQHsVCPhfY31ZQyYBfR7uY2W3H4HyrZRxn5TttUL?=
 =?us-ascii?Q?qJo2jQ1lCa5LFZMXAjnudTfCScNHTTrTut1G+juPqVQJjL4B2vtgbeuYgZxj?=
 =?us-ascii?Q?AuQrejtl4c2JGuCYraf1cKs65ZPD9WNBWCNdIxqlAHOEBacTUROffwqsTu/P?=
 =?us-ascii?Q?ZMjj4DUlS6StCDP3DWrb3f48TrKPDbdMvcVD6OaLHh7kvkvuPmA8Psco+T03?=
 =?us-ascii?Q?QX/kcLOaeoroolVq0CJ04fObRa5vnAWJPwOZBfNCMkOt6Cx7imjYMEtUMbcN?=
 =?us-ascii?Q?VyfV2jMhVUVtPeKTiv1ToqwMs0L38BrRd0r5bE5PVxrJxwCEK2Mr5yMl1VMl?=
 =?us-ascii?Q?Cq+TEvObtLLW9R/nfRDWzpNMXCjNsTKmVbNKN4xVpdKjhzoWa0JlWH5tA/g0?=
 =?us-ascii?Q?Dpjf9MZ2vDd+Rj9Nbm2JSIA9RV0GRLzr9ihXCPVFOh+tF+/qxfNfo0U+yB/R?=
 =?us-ascii?Q?t2uEo0KkECnc9jAvnLA9TXAejEMcZVPTz04eWrwg/1G8cV0zDf5IgTUye4k+?=
 =?us-ascii?Q?wazY8HHaLrdv3PTDsIplyYdM63COqLKmmcVpxnRkN/u9o3pd1K4rDEL/qNoe?=
 =?us-ascii?Q?/hHSOj7vDLLV2N9RY02NjgzX1JIh9ykl3Bd2Qpf6mVyMVEzv21eM1EpYueTF?=
 =?us-ascii?Q?c2tSljNqBIHQV2GZFO165AX+uumvZjBfLDBcxyc1xMllu0ie9D+4H1fK2j36?=
 =?us-ascii?Q?J5OG64orxm85gXQAsqADJqDMHok/WnhH6XFVhmBSUDWThsKJ5B1CZpN3JnhW?=
 =?us-ascii?Q?iz8282Gt2cy1Fh4NKRjg8a6Zw8StBE+uuRmGDFT1zzjJeqcASg+gTePtzt5g?=
 =?us-ascii?Q?10NgL1sZYMmKpg40ExA6IAM9/UA6lc8L7476pS4SfoFmVuCcweu2JTdCG4hw?=
 =?us-ascii?Q?F9yUG6OYzT+mg0QqpvYdnzhDHPlyW9HCtPMbwKn/OguXXCsiTB0XBBpZIe3b?=
 =?us-ascii?Q?+OginZUjZ4jgNpsJ1N1ktoHNLyAD55OtrPqgBbDTkDIQUN1o4BFwBVB/dBcz?=
 =?us-ascii?Q?61Vcvg9kDfZsL2Yd5c7uS/tDSLn6Q3MjxwAfU7+VFzeT9ucvp94HpB2RJYZY?=
 =?us-ascii?Q?7LRsMeTmek+fSFjupqqiFX3peYu87j/UQFyB8IxuFvawCA4+xMZ/W89SLYAj?=
 =?us-ascii?Q?NhGZGqVChmmIETcE7AcSnCTPh8SW5iQoNsWjD+K2yQ2T96KdUhRjcm4E8tYw?=
 =?us-ascii?Q?k7l49yUuGUX7i8vSRmq7XV3Rt5X80ulFsEh3nyGwuFIOFFnNZDHwFzUAJWWu?=
 =?us-ascii?Q?MS657DSUMpX5HssChoOidCqq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IPkOZmuvkq6zCYr6qMn51n6ptABhUR/CvucU5PUWygw0ZSYcwkPHOivrLHNb?=
 =?us-ascii?Q?Cp+5y0FfBFf31Leg+E0afWsmqDh0JkGFk7oWEnm2QU2DHPo6sALZh3Zh1i3P?=
 =?us-ascii?Q?mDFkQ4bplp6rqwgABw60yU12uPwBzSqXVwatXlQ9jNd+W5465E3nrHvMjmsv?=
 =?us-ascii?Q?WFOrUQzISqEcAbDZchVj4rWM4C3j8tCqi1EWXoS4/umFlr5i5ci3wyhth5cY?=
 =?us-ascii?Q?NB30drrQlkj+JTQrVI5+PlmEnbIDcIgkanE0k6cvU3k/76HRr0Kg0OGCdsN5?=
 =?us-ascii?Q?I/Dm2GUl3jy2VXrN0Dy//sEkDnTyUEtMmvVGVKjlduevavRQUBGZ5hnLWYYV?=
 =?us-ascii?Q?1+VnyTGeq7Qun4ddoVA8fqETXRyQGNoiKVgsAFMPQOz+yxE5RLRBG2I0cPcw?=
 =?us-ascii?Q?kdnvA5WUpsgDqkhBz8B8ZAsXd0GzOfi0ZbRG9/EpQYD88jcFxSEBX/GQ5sTL?=
 =?us-ascii?Q?tHhRZwSTI/i5gw7IMGX3Q3NRV1SFdgamTocjyJNMay5N64CwAPvpI2VNTa00?=
 =?us-ascii?Q?yzpBOpy5h1w1zbCxgrC2ShKjny9p4Ki5GhHqxOwcgkTu2EbOGXspllPFCbd/?=
 =?us-ascii?Q?gpblzNFk07E+4Ktr90Idzk5ehpKeOxIhk/C2697m79zNeUpy53Qv4JTS3yGv?=
 =?us-ascii?Q?2FiW47u6+VJHKu29NDoyIIea9n9KZtHOZgIUI/fHUJO4GUx00LMFln2A5K8h?=
 =?us-ascii?Q?s1TXP8la/OoBsYxEPt8Ua8L7oik5qh2e1uLNM87iKoWHAMhgAbCxXv4svFyJ?=
 =?us-ascii?Q?1IsgDEegawqIdX8Ie93cri6skPUs++k4VmBpQr3+vcmAHbi5S6tBl2Cs3tsE?=
 =?us-ascii?Q?Aoq2dqJQ+CyqL1DwjnsD8MvAta3DOciwEGixcEOqzLFK/SjLr7ROFDsfmE/K?=
 =?us-ascii?Q?Vg4hXvKi9OarkR5r3IASDk6aLiO0B9obk2Bxe/TH4yKFVUCwYWdPcRr3Vjkg?=
 =?us-ascii?Q?jkB10SNDz0vJRrMCw2QEXILoE5/BMKxfymbc1KV48gGLE51HW4EsR2U2ek2c?=
 =?us-ascii?Q?jdZgIuwo3IoOuWRwD0AYo4on2oHu5NTSaf08prpZwZNv0U7mQZb2ZOcaPO42?=
 =?us-ascii?Q?6/6+7bqCIlNlofUS4UVvtiGRQvbYq3NzO90qyJOY+sQe0SYTfsTImf3GJ82C?=
 =?us-ascii?Q?m+I7v7jWtasZY699P8KqVIwq7ZOQ3ZzuIN1niaP5QJT/pQqC6V/Qgr1ylfHn?=
 =?us-ascii?Q?pseP1YAbPWpEppnINYAWMVNQ7yvek6YtPPAQ2GDvegv+x/qV6dUy7z75yW0p?=
 =?us-ascii?Q?xQYq1AfqACsGkr9kokCGK7yhhhkExxvaT6lxl9q5crXoRieBE3Lit2xJQB8R?=
 =?us-ascii?Q?fap7X1QBzm3W8/EvtKqsGSXHvADpuoIMKpQO24XQZvDzBIGhS2cXUDJUHVHa?=
 =?us-ascii?Q?Ikcofw38/eeNJrID5bX2rpzGvCKwHaJxGRdBCj4olCH3fdwwf8tNy1WcB4rK?=
 =?us-ascii?Q?Pv5CFK0GnRcrQVzcXxMzUQZmnN6raCRUi1V9TRSLC6u+O6JOAy1lHCLTRH9E?=
 =?us-ascii?Q?llxJCsnRjpsXl4dTHkfqcv2O/N3CD4orGlsPIGgcXdJ2r4cU77D0QSPrUuOl?=
 =?us-ascii?Q?q4pYReY2WfLx2FW8W43wmYxhuNPUEHJ05MqUOreNDutD6sFOnyaqAgxTbzp7?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4152701d-96c9-467c-d4e7-08dcf1baa33b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:25:08.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4txTMWcuNC+uj2vHGfFrb74Bo54hYuZMPk+wcpiXT+eqM2oR5oWzDicFi8yrMWbSiTrju2j834j/Vos4YGZDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7468
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 10:25:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17057

On 21.10.24 09:31, Chris Paterson wrote:
> Hi Jan,
>=20
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 19 October 2024 08:45
>>
>> Hi all,
>>
>> I had countless errors with qemu targets while trying to test the latest
>> cip-core image, see e.g.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129814767
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129786943
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129777118
>>
>> After hitting retry often enough, this pipeline now seems to pass.
>>
>> Any ideas what is going on there?
>=20
> I've been seeing some constant very high CPU usage on our LAVA server of =
late, and I'm still trying to work out what is driving it.

Hmm, hope it was not hacked and is doing illegal things now.

> You may have noticed that the web gui is very unresponsive.
> My guess what you're seeing is a reflection of this - the server isn=E2=
=80=99t responding to your api requests in a suitable timeframe.
>=20
> I've asked the admin to install some more tools so I can try and debug th=
e issue more (I only have minimal access).
> I'm also looking into using a newer EC2 instance type to get better perfo=
rmance.
>=20

Thanks,
Jan

--=20
Siemens AG, Technology
Linux Expert Center

