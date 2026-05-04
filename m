Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2638ACD3427
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 18:03:16 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21169.1777917788121808660
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 11:03:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p33uHarv;
 spf=pass (domain: siemens.com, ip: 40.107.130.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n46KPyQQPB4mqQxAI+6CTrlpGeqdJq4wMmWUBGXnU3jYktCYvdZZGvtA1pb3sQ/Tyi6meVPxwJ/enSiQDhO3addPI+YbIl1kWeAQnqVZqBY+DD3EFUOL+vikmLxf1l3vnabfXJ51OtCFADtgds2Vw7ICPcouKZbN1KCgK9ik0NvWm9H5vMMRhRZ3qGAtaoyNWc1AnUujYLHIOZa55ef3VKq1OpgyLmvxY3JwWKcNT9ruEndR6NWauaxEzrkNLULZMi8dNoa24rAWWAeSHhgBtCjpbQrhKFwVtSTdLbiaZhQqGaYmwJA474vardtbVSf3k2I2V1zuOngIo+kvjtUPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/jve1wk3eE8M20vJEBeQqFW5ZjS7Sl83roFlt2/2fA=;
 b=NbczSXIzaSvBRyacPOlU8+A8KA5yZrGaayp1u6ORLxmu6kPwb/EK7ZDKXqTPrXAOUvcdAqX4pO1ieeR0UTojSy6Pwri/D3AXq6wIlgM2VlrjBoG1hd3p7tq9CsC1kuLpIHkjyl9T2HLlU3Zyi8o0C8pj6IHsd3/+MhuvQVUEPkSCs9Srou1MfyM77jc5qzKcf+eFRzC3vwdK2KQSIP5N8DZYH1YE6ieQNEphvDOEG4YR3cL/Ckh9SO29Tzpu4dBnYyGFD1/IkZAc/Ada4z/R8BtfiHWPGjQMuV+rr+TIt8S/sTydSWqlVsFdIgOW7JY1wfHD5HLHSXtxLybVKzwv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/jve1wk3eE8M20vJEBeQqFW5ZjS7Sl83roFlt2/2fA=;
 b=p33uHarvIZ1bvHDTNd9wxPWQs2kmpAUeudNGU+Pg+eQrBkNd90+0eYuBUu/AY0ttWAtre9gbMICqa/Zk60tPyHWmg2lTNloJv6zgZmuW5x7u+vsFjl6/2eJC2X+SUE7pUbb/yrXCxgBpchWLXxr/jb+d7KsU/fD6VovQOeXqizwP37aiXtPrRWcoUDX5YMtLYklvHGB+xfkAkl/jixF4cXf1gNP63qxalH2uY41mBj8AqZNjfk5DlCThorntmJ3FE/6l3VqR4JHoWbUsDP+KxSP65VQkWxDbFXeliI65LQLK2JqHXehF4o1xLqxeqFhPzI9FchHFAYT44LDPB5IrZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:03:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:03:03 +0000
Message-ID: <50ac15d1-1a05-4111-a2ab-789264357320@siemens.com>
Date: Mon, 4 May 2026 20:03:02 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: cip-core jobs passing in lava but not in gitlab
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fd2306-05b5-4093-7e1e-08deaa076312
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	gazQ5Nv4mGO8gmXpmfceWeOzT+U/zmJRD6RC6mXSyRvdqloY/8vOubaSGQMe0aBLl1IYPI+cpvjuuPh5fuvmJkJG4G17tlEIfvWR+AniiY2MkzGQ/v06ZYm42Kitkcp/6LPS1hBbdS4UBDxQX+Im+3WTczvuEofMurmjzQAFkYUKUOTFiZ/iXkhmwXqKBlsglZal5t6mY13MrvZawcJmn8HVKnA5edC77QWdhKXCedoMFJH0ea+78wRWn0N+LVKPTLum/NqrkAc9QZl5mFWV7nwqxm9B2XiE5m0nLDJr+3mOJpLuTI/dIdyMxuSj1w71ZZ6ut6j+cbmBad4mVar+d6u47y855fa7XYeOk4ddu7BIZ0QwExpQBq8PRHbk/KzMS2kWcawHJCubf4fKUo5lzGvqGJVtw/GhJyHZ4gZfPH8oNT0U79s4bGhaMmz1OI3suhhq1gbK2J9PTYGWNKcKIJzgoBMFzGPsNNfiLD8tavtac/S2BEj6XpH9UBfAS/qYNQ97M9vd6hsbuWwhOk4xQO6QeZ+B/5GtAIegU3XWol42wRcHH33Ubs19r0hYc+uiHjxV603vcelZlV0Ptj6GBm/GF2gyp4t5H4G0jLwa1ZsznQW9fCTQCPl3IDwEuTlTZp16ON4BrC9M+s4cvXwwjA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnBxSmorVm1JWUUvWDF0NzZIWjh6R2RmcThIQVNxVGdjcEtSdjQ1d0J0YzRh?=
 =?utf-8?B?bnJkZnhSVFdsZ2JwY21kVTMyNS84bWtMdC9IcXVwTEwzd1NreDNJMUtCUGIx?=
 =?utf-8?B?cWNkbGo0UXdUZjdGVFpwQ0JZYmtoNWJvd3NHQ0lVeHNtUmdGODEycE44bjlE?=
 =?utf-8?B?NkpQK1o2NXlNUTU1VWw0VHdXVllaREFrTDhmMU1ERXdEcFQrU293VE9vcDlL?=
 =?utf-8?B?a1VkaE5LT3cySHRhajJiZVpJbWZOQzZWeHk4ZldLdUpoRGV1c0YyQzg1S0ll?=
 =?utf-8?B?Y2cwUklNdFNEWFpvV09DTkppRE5WeXhxak5zSFVqeGFla2FlRG1Uai9Na2xI?=
 =?utf-8?B?RGxyN2NkS25yY3NJVlh6UWVjYm5SUWVDUHNTUnQ1cGxPOUJId1BuOE9YZDRn?=
 =?utf-8?B?NXlBMDdNRHVOQ0dEWDM4UklGcjFVbjJVcVViYzBHOGMxMDd3K1gxZFVPNllV?=
 =?utf-8?B?UzE5bDZSK3hZb2ZPZWZ0YVQ0WSt4S2RmSE85dmZ0UEN4ZnN6V0pWVVRIaGxD?=
 =?utf-8?B?U0hNVkpVQWNkTk12UUJKQlk2YjBlc1ozcDE4RG40ZTE3elJMZVlHRy92cE9n?=
 =?utf-8?B?ZEI5dDBoTWxsbTdSNXN5M29Obkx3RktzTWNFSDQ5THF0cUFUR3FCMTdNdWwv?=
 =?utf-8?B?WTdEa2lPaU9LakdUWEc4WSt0dk1CZGJvUElYNktiRmVSc3BWdmFSOEEwN2JW?=
 =?utf-8?B?dyt0YjNlYVEzNFV5ZlF2a3AwVU5pUVdFdW5ON093UVNsYmtFR2V6a1dtbTd6?=
 =?utf-8?B?cjBUUjFoL1FOLzRwWTNRbHNIRTQvTmJpWDhrR2dId0V4RDZOQkREV012TFFy?=
 =?utf-8?B?QWFybFF4OHovNjdJdXFPb05RZnl1Q2xvS2hIWk45UmNlcitNc0pibDNlUVBt?=
 =?utf-8?B?TVhQU0FKLzYwL1B5UDdIalM3eFBMTjFQZDcrSVRTdmtZS2FXSTZ4bFBWUkxN?=
 =?utf-8?B?QXJNZ3ZIcDhyT2hOWGlidE9QSktySWtZMWVlYkNmTkl3R3NJUE15ZEplK3BX?=
 =?utf-8?B?MkIwRmp6a3RZMnpmSWZkQ2F4bzA0OUlvS2ZjcWlXblRYdjFPcTFPVll2Nlgr?=
 =?utf-8?B?cVJSMFMzVkl0K1liTVNab1IyZVZ0bU1MSjRVaXFUaWd6TGpjbGY0dEp2T3lG?=
 =?utf-8?B?RnA4d0xkS2UxWDV6QXZ6N2lDaDJ2cGtlWVJBNVN0WktEUXc2ZDd1OHU5UkpG?=
 =?utf-8?B?WEVyRitsNnJBTDBwc0orVHBYUFg3Wkpxdit1anFOL3pUYU9wNUYzajB5TGtW?=
 =?utf-8?B?bVdCSklnOEpWNGJpZTBZSU5KbmZ2Ti9oNk41bHE1eENDaEpWTWVGSnNHbWJL?=
 =?utf-8?B?Q29Dai8wUXJJZVh4RnlMM0dCajhpOUxkbnFYaHlBc3NiOG44eXhrQ1Q5dTJt?=
 =?utf-8?B?Z1RoWDNuYU1NQSswNDlxZ1JIKzFOOEZoR1FZUXphVDVsN1JoTEh0M1pvZ2xO?=
 =?utf-8?B?UlpzQmx1MkhTSGNKN1FsS0NlUTZSWG9KbytwSmk3UVl1ZnRHbjU1b3JxZDlv?=
 =?utf-8?B?NGE2TU1HMXcvUkFNVkljRWlmQ1o2ZGR6RzIwT3hxWDlYcEpDNUN2eHBsZ21E?=
 =?utf-8?B?SXBYdDhmUUJqeExuSEtyeVZoZ1pDdFhGSEo0UkRLRi9WcFFIZnkrdTNPRkNB?=
 =?utf-8?B?YnJPK3UxNXpEWWoyUnJhRDVxYXNnSTY5dHVYNlZra29HRndjUXBNdDVVY0c0?=
 =?utf-8?B?MEFZa1JDNVdoTEhtRmZ1V0xNU05HNzlXOSt0S2c3WG9HbzhzV2E3bW5KWXAy?=
 =?utf-8?B?bFNaYVVDdWRvWktzanEyOXE3NURCOEdZU3g0Y09BVzBFWnFZTzVCQUp2WUM2?=
 =?utf-8?B?aXNmYTg0bm9QL3R6NHhSSzliMGpTVkdQTlQwamNWOEVnd0pBMXNpMnBHdlVI?=
 =?utf-8?B?STYwZFJiRzB3ai9PQlZNV3NDQ2FLNlJBcTV3VklZYmc1T25XS1Q5ZDRWcVVF?=
 =?utf-8?B?K2hNdmhnZ3VYWWF2ekQzZkVMbFBsTnRaVmtiZ1lrZ0ZZaWRVNXNoMUR2QnZu?=
 =?utf-8?B?QmVZVElEUEptZjkvOUFnU1RuZUxlbzB5eHNVbGhkY0pRcjZCL1RIYVJhUHZE?=
 =?utf-8?B?WjJhV21VVFFHbUk1Y29zM1pFdm9aYmNpbS9WUFVjdVQybjlOanN6NnVPY1g2?=
 =?utf-8?B?YjRLbHRCSmpDMVNkUmUyQTdmYWJNYndGNFcyQlVMb0NyZ1BXU2ZGbGR1dkNk?=
 =?utf-8?B?UmxPYXlFZnlwb1ExZjBOcE9UdWEzZkZQMlNidzVMVndlODlTemJKRnNWZlhM?=
 =?utf-8?B?SEY4WS9wcEdERkhTT3lsWGpLTkVyNzMrOTlOdVZSWTJPQ2lEL1FKbnk0bDc5?=
 =?utf-8?B?MVJnNmxMRm9MK3RPQUZJU2JEbXdkOGZUaVE4aW1FS1BKMi9tY0VkQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd2306-05b5-4093-7e1e-08deaa076312
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:03:03.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AVnEtag37rJ/T6hzidMM1C2qlyBjw1GD7BbfKGwLIxT8t06vMyAxoAKbhpbgjEn8+kXKI5itM8DqtHx/05SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 18:03:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22863

Hi all,

currently several isar-cip-core jobs on QEMU targets do not pass
although they ran successfully in LAVA, e.g.:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14205628583
https://lava.ciplatform.org/scheduler/job/1437475

Seems as if lava-cli gets struck right after kicking off those jobs. I
already retried some multiple times, but this didn't help.
Interestingly, others are passing, also on retry. I'm still looking for
the pattern.

Any ideas?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


