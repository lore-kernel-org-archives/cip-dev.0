Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F10C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 13:55:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.52894.1742219719425248883
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 06:55:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NZtjNL7e;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZKHLDYtMz1SO+da90ath18qgFhGict9k0sCJUaHMyP2JdVN719KzAvP1ag3/oSE2fOfbw478JB2KNKmyzgMzSb9XPDEobmhui1gBIDdPRMglih9mKzOjPSe0uQufm6IUwWIh/qX2zHitKc5aXBvPT2uqgj4BfvhhmxnkK20vSAkwkxj5NtOZmG0FxNr3I3VEhPOX51K7B5Ii1djnPsKwQX6f9nFyB1Uffk1ROKaBfQlbuyxV58NluTTe8Ap1MfB3POylJQIYUkMr1m8bTV2XOTBeSSifkP4Hv47R2CyMdEcnTWwpk7T7ZXiapjZCphBPCh55d1DL5zrofVdA8Aijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yymvZhpGPP1p0cNJM/D2PC/tN/RWDP4jHvUFso12Oqw=;
 b=MtS/KlFYIj/xEGX6awfRtLHQEeHBCGtcm7te+sO8PH+r5ONQ+XuC8kXStQWr62A1vmr09FXzdgJwPa/RzTD/M7akeM/2rPyxN86nsIBRJJLNKzvfmuKTiqI1etdnBMaEq5URO6gywZORqtwkr3HQOF60Ul3WK+0w+e1fRsPxCcHRbUVmKZgGHMCsTyXaWS27x4GCEZ7gU+ewuC2cF7RXcaQusUDX7lPA9ATWYmRghQQefrVtA+9CQBmsyixMSSBrujnUFqVgbiKt9fbDPdTX6jwHPWg6xnNQD9qnPOkO7fz/ijW2WWmKMDoWfFfv+MADGDh5BlbDm2AAxZAer6jjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yymvZhpGPP1p0cNJM/D2PC/tN/RWDP4jHvUFso12Oqw=;
 b=NZtjNL7ejLsXXhpwSYpfdj8eeEFIqPDkbriFH5XViBdc3jHRa4ishQiKLZwGHCDl3pX7StnUSb/XsK3P6mwKBKwj6OV55KDU27taDriH4Qv+StIMa8XkBuTQwoQa4YRmzVOzspasMMzvs6x4AZyd3IIFVblo/ctrIs2nxyHb0E6r7UIcnkrjNj2u+f1YNIxaMu7c2tDF2P26xoamIPfQDxWSxuLHq9Q6AehzUTttKQyLK/pIMMaJu+ZKp/UXkB/36NUPsQ3VVvkBaZYD8VeW0Y1s1WbKabwe3I2U2Mn19YCAD5jBafDUkTBqWsuh8RmfABI1eoxPR06+cFF+2HojhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9191.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:55:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:55:16 +0000
Message-ID: <b0d9eded-a489-4941-b890-09e7788aaccf@siemens.com>
Date: Mon, 17 Mar 2025 14:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] Add documentation to provide
 project specific signing methods
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org,
 gokhan.cetin@siemens.com
References: <20250317112102.609922-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250317112102.609922-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: b627b93b-3819-4173-f62c-08dd655b58ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y1JudWlKWlVBOHNjdDUxQTFFZUdKTWpYZFdpOS80NkQydERVOHNVWXZWQTZ0?=
 =?utf-8?B?Z0lIemJac3hySlhUSG00bmloaE93eVg0N3JyWXZJY3ZybjRMUnk2RjI4aWEx?=
 =?utf-8?B?bDdlRlY4WlB3V2VvM0JpaG9IWnRZM2NXUWlSY0RMeklpY0YvRFF0LzhhOU1o?=
 =?utf-8?B?Z3IzUEQ2WWFOYlBwZG1raHg2b3ptb1BxWWJlUkRZaU5LdE54QUtyaUVWYnBw?=
 =?utf-8?B?VzZ3dml4RUZQV3RaeUZmK0tJSXQ0NGtKUlJaRzVxbDJhMFltU3l1ZFdBams4?=
 =?utf-8?B?eUdVaFgvUUYraUpGLzkyMndjeG5DRUJ6Wml2OXpjbk02eDBRY2d3MVdaZWlV?=
 =?utf-8?B?NWxVV2JUeDlnWjh5Sm5GYlJHdVgxMnBNSzUxd1dsc1ptM3NBbXN2U2Z4TWda?=
 =?utf-8?B?Vzd6NFpoNVV5RlZlMXZwUU9HeDF5NFByUE01ZWZZZjNqSEcxbTZ5bU1YL045?=
 =?utf-8?B?d0xKckdra0hub2hXb1pnRXNNU1I1aGNzMU5VZzV5TGdSRmJyY2xsZEVZUXpN?=
 =?utf-8?B?eUNLVGYwVVJpc2svMmxLQlo1emFOZ2JuaFdRRm1XQW9ibGtNdU5aZ2RWN2pH?=
 =?utf-8?B?U3FVaGFLZ3c1dWUvS01wUDdPeG9lb29PZWFUQ1pLL045MVpkVGhwK1JsdU9x?=
 =?utf-8?B?MEYvcUxKS2RSTEFWamdNay82T3BuMlpoV25zQ0N4Zkc2V3JyOXM3NkZ4WEJk?=
 =?utf-8?B?SlR0Vkp2cnBtTThRSHU5TFA5bVZZdnV3NUI4VUo1TkRWOUk2VXY5UzNIcFM1?=
 =?utf-8?B?OHAyc29Wend4Zk1BVm13MVFIUytvNk9qUmJxMFZsRXlDZ2VJSE5XU2xUM2FU?=
 =?utf-8?B?VFV2T3R6UmlWNVVkamQ3amV1dFdRUlF5U29wY2QwYytxZnNMK1lEWnl0Tk1Q?=
 =?utf-8?B?U0lINitwck5yenMyK1RQY2RtWTlwSm1JSW1zQ1d0RVFrNDhCVk5USzNFeldq?=
 =?utf-8?B?ancxb2o3U1Y1dXgvT3RYZ0VnWS9JMVlxbzBiOE1wVFUxWWM4TnJZdmZVSmNU?=
 =?utf-8?B?QjNOem1DRmR5N0ZvSEVsUmI2MDlsbzZuZ0lzRGlxdE1aQnNnK0tuOE0zOVZu?=
 =?utf-8?B?MzhRVDlYcmpwZnI0UlhaTlRYZDZRZVJYMHhRbTJDSjhHeHpIdnhJL2pIbVVX?=
 =?utf-8?B?M2tGOG9lWE1DaS9uc2dsOEVNWXV1dEJWUjVWZ1VUYTVQbXFDYVM5a3JyaXM5?=
 =?utf-8?B?SDMzamtYeUNaZzN0eTBmeXp6OU1yZ1ljVzRJMjVXdksrTENIVHdEMlVsUTQ2?=
 =?utf-8?B?RGowTnlaS2NTNmpQYnVpZlM5dStCQjgrNk4wZTdxTFBlRFVmRlBjOEZDODdN?=
 =?utf-8?B?VkYzY091UHJjTGpCMVBsS1diVFNzUXNndm4wZHh4aXRZZUlGb0ZRWTRsVmho?=
 =?utf-8?B?TUU5YU5tRzdaK0Y1UC9kdVZXNVlicDVwK01xVm5oZVJxQkhEOERjUHhVOCtJ?=
 =?utf-8?B?NUsyLzNOUWdXbFdYamFkYkZyS0tPekwyYjR2dGFRTW1CSC9RQzE2eEw1OTNN?=
 =?utf-8?B?aGN1clJrS2o1K0NzM1VKeDh1NjFGaTF4L2djSjZKWTdHSXpueWtFNUJoZmxu?=
 =?utf-8?B?QjRZd003UDdmOVZYMjdYKzE4cHJjNkF3c085cEc2OUZuV3RwLzRlWGxCNTZn?=
 =?utf-8?B?Y3JNYjhtNUxsUmRRekE5b3puZFc1M3lUMUREbWpveVR1UHh3SEVlM28rWW12?=
 =?utf-8?B?aE5JNENmRExSczRNcGpLTEU5TTA4YlpRb2hVNjhpakZJZ2podjBzVlJqNkV6?=
 =?utf-8?B?ckl4bWZITjVzWWtUdFRxSVNUVFhrRnlGdCtTc0phVGExVFBxREFsVVdJYTZj?=
 =?utf-8?B?V3lnTHJYTVB4ZU1GaG1qMUp1T2hDblFxNzJ1b01mSW1PZ0YrY2kxRHRSQXFR?=
 =?utf-8?Q?PkCFiWWi+3zmt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWhhZXhWRkZVSG9vOXBBaHFiZHNoS3VNMzQyamQ4Y2RIV3FxNEw1eDlkaTc2?=
 =?utf-8?B?TVNYa2RUK1l2VHJ5MFN4d0xMc2J6MXZQTGhKbjhVeHNZc2Z4d1dTMEZJM2RX?=
 =?utf-8?B?ZGlJVlZmRFBLcjBRWG51aFQreXdlNjk4ZWtxTjRRR3dFL3dSUFh0bTZuNGRL?=
 =?utf-8?B?SVJEV2ZackdvYXhQb21sQnVFazZkYS9xK09mNmgxdnJ1WDQxNHJFYW5WdVhl?=
 =?utf-8?B?U29LaFNhSThWWDRtdkNwaDJMYktyQTlkN3NUNE1PWTVxdEpWK21ZMVpFS1RM?=
 =?utf-8?B?ZUJVODlSZGVGTDJ1MDZ2aDEvWVU5cGN6eTZrZC9VTEdGSS85TXFCdXVISXp1?=
 =?utf-8?B?ekppejBlVktLYWJhK2ZXUHZrdjEyTm5QV2ZYWXZqQVpZZ095dGRyRktOVzlk?=
 =?utf-8?B?VmtwVmRxaS9oR0hBMTB4dDZvRVdTcDB5Q1lPNm5qNE9hUmRGV0FWdUZDRjhZ?=
 =?utf-8?B?THp3SkdWOTBkYXdvdjlMNjdjTW1meUtzWkVDeEJyOWc2VXpjNGRweGhCRlhB?=
 =?utf-8?B?TjBZYUFkQkdXVWlrM0xGRUpQVkprRzFJV09lMDgwazF1dnpUSm82UUl6Ujdh?=
 =?utf-8?B?QmRRdWpmak1EaUZmdk9tdTN0WlVUM0trTndSTC9XQWR1cFpWd016TjU4cFpr?=
 =?utf-8?B?VW5RZXA4OUc2Y1YrYTRSK0lJbmNzRU5MY3Z3Z2xaOFhlajNFR0JwZTFSZkJq?=
 =?utf-8?B?cm1nYld3Q3BuTVJKcXg5TmJIQ0dVakcvbjY3dmRNQnNaVzd4aDNMUlJ4YUQz?=
 =?utf-8?B?Mnl5QzBYUFlyYzVzQmlFWDJNSmVZdXNRTVVnanF2bmYycWY0RlV0enFveXV2?=
 =?utf-8?B?M3J3eDhlakg4dTBxa0Z3eERGRnI1ME12NldFaSszakZvWmxwVkVlZ3pzQy9Z?=
 =?utf-8?B?QUdxRnM0cS9iS1BXWlg5OHJ3S2lRQndQWDMwUXpUYys1VTJva3ZlRTlzcFNJ?=
 =?utf-8?B?MzlKWTVaMnM2MEZyUzdZQVo4WU4xMWtNMjVTMHRvVTRIN3JTUVluUFhUWk42?=
 =?utf-8?B?bWZJMlUxUzZhTjBDSHZZaDAvZ25SYXYxU1FXMkRnTG1XOU9hdnF3TUYrTkYx?=
 =?utf-8?B?QmNra011RFQ2cWpHWU1tWnpJNUYyMDJxaHhCWG9abjVZWDA4NU8yRVpwZFN3?=
 =?utf-8?B?U1V6Q01xWFlYSW83WHlBcEludElySXc3R2FEZHd6bmE1ZElkSjc4MDRiMTI4?=
 =?utf-8?B?QUpCcG9lZ0lmeUJqU0hRY3JGSkR5MmgvVFNISFdrOXA1Mm1QY0hBTFZXMktw?=
 =?utf-8?B?Mm53RFYzRG5aazVjZEw5WXdKVERaWlVaV1RNRy9Ka2tJaGtkSVIwd0ZwSjJH?=
 =?utf-8?B?b3lKNFdNelZnYjhDaXVCbzRTQTFxU21hVjJOV0RyaXZpck45WmxmNktpbEFX?=
 =?utf-8?B?K0ticSttbmZ3dnRnazNZNGQ4VnJPTFRzRHRGd1V3N1dUWHJHOEh6eFkyeHpF?=
 =?utf-8?B?R1lTczdId3RRclJWZ0xraWt5MTlSSlBpd1ZXSUtHOHFpYnpuZE1IYytVRDV5?=
 =?utf-8?B?bG5ONElnU0IyZkgvZlEyUVlMUmVOc282OVF3TWlMaytFSG9POHVTQ1FONnBG?=
 =?utf-8?B?OVRwU216NzNLMkJJWVRGZGZIcHdzL1pqcVZtZ0Q2TnI5MjVicnFVN1pySkR3?=
 =?utf-8?B?Wjdob3llZHlRVzdxZnd2ZGkrOTNZYUV0NDhncXV6ZXcxbm5xVEVUNEMyaHhG?=
 =?utf-8?B?ampxK2Vwd0s5SXVIdGxaM3VJWVJ4b25LeVU5WWw0VjRWdGlWcENKeDBzeWE2?=
 =?utf-8?B?RWFZb1o1aW1mdUs5YW1pQ0xxbnJmNjZNUXZmYk8vdUVQM1FqbDV3YWJWaXhV?=
 =?utf-8?B?KzdpellhMlVMK2s2VHJvTzl1TTYwK3pHbUR1RG10MWJEY3J4UWYyWHlaYmhX?=
 =?utf-8?B?aFFzMnMvSlYycW5GbWFWQUxsT0xhaEExSXdhV3JxTE0rYVhndWs0Z3FITjJ6?=
 =?utf-8?B?UG1LcmZySWo4aUdSUnVOb3pHZUE5ckcyRG5QQklYeEF6OFRlK2VQeXBwMXZK?=
 =?utf-8?B?YVJlWUU4emc4OXZXYmplM1JCd2RobE9uYzZ1akdrYnY3NE1UOXZqVU9QQUkx?=
 =?utf-8?B?WXdaa2ZCdHJySGJRanFJSnVKZlUvaDA0K2ZBM0tNcW1QbllxUDJVbTdxSDJQ?=
 =?utf-8?B?ZHMrQjZWNjJPVnJmNU1PK3VFOUcwYjUzQUpSMUhkTXF4Qnh6VE5qNlBhY29O?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b627b93b-3819-4173-f62c-08dd655b58ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:55:16.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NgKWzjYXQ6hnbNETHIBwpuvyvj0GqjdyKM40my9wSsaqc0n7XkdyI08cT/+bOtV5+4b8YIttBllRotZe2+bAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9191
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 13:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18231

On 17.03.25 12:14, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This documents the preferred way to replace the signing scripts
> provided by cip-core with project specific variants.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> As we had the discussion how to unify our signing scripts this document
> provides a overview of the current state of artifact signing in
> isar-cip-core.
> 
> It is currently a separate document to have all the information for easy
> access in one place. I am open to split it up and add the specific parts
> to doc/README.secureboot.md and doc/README.swupdate.md.
> 
> If I missed something please let me know
> 
> Quirin
> 
>  doc/README.certificates.md | 93 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 doc/README.certificates.md
> 
> diff --git a/doc/README.certificates.md b/doc/README.certificates.md
> new file mode 100644
> index 0000000..7283cf7
> --- /dev/null
> +++ b/doc/README.certificates.md
> @@ -0,0 +1,93 @@
> +# Certificate handling in isar-cip-core

This is not only about certs, I would say. It primarily  covers the
signing procedures where certs do play a role as well, but so do keys or
signers with organizationally and/or hardware-based protected keys.

> +
> +This document describes how to replace the certificates or certificate handlers
> +in isar-cip-core.
> +
> +In isar-cip-core provides the infrastructure to sign:
> + - efi binaries
> +   - efibootguard binary
> +   - unified kernel image
> + - update binary for SWUPDATE
> +
> +isar-cip-core uses the Debian snakeoil keys as to provide an example and during
> +testing.
> +
> +
> +## Signing an update binary(*.swu)
> +
> +An swu contains an signed sw-description file with the name sw-description.sig. This file is
> +created during the swu image build process by calling a script call `/usr/bin/sign-swu`.
> +The script is called by class classes/swupdate.bbclass. The script has the following
> +call signature:
> +
> +```
> +sign-swu <unsigned efi binary> <signed efi binary>

copy&paste: it's swu, not efi.

> +```
> +
> +The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb`.
> +
> +To validate a signed *.swu the image needs to contain the public part of the certificate which
> +is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
> +
> +## Signing an EFI binary
> +
> +EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
> +The script is called by the wic plugins scripts/lib/wic/plugins/source/efibootguard-boot.py
> +and scripts/lib/wic/plugins/source/efibootguard-efi.py. The script has the following
> +call signature:
> +```
> +sign_secure_image <unsigned efi binary> <signed efi binary>

Maybe time to rename to reflect that this taking only efi binaries:
"sign_efi"? Or is there anything generic in this signing so that we call
it after the signature format?

> +```
> +
> +# Replace signing scripts
> +
> +The preferred way to add your own signer is to use
> +the overload the necessary recipes with `PREFERRED_PROVIDER`.
> +
> +## SWUPDATE update binaries (*.swu)
> +
> +To use a project specific signing script, e.g. when using a HSM,
> +add the following lines to the build configuration (kas file or in the
> +conf directory).
> +
> +```
> +PREFERRED_PROVIDER_swupdate-signer = "<swu signing package>"
> +```
> +
> +The project specific public certifcate can be replaced by

certificate

> +setting:
> +```
> +PREFERRED_PROVIDER_swupdate-certificates = "<swu certificate>"
> +```
> +
> +### Content of the swu signing package
> +
> +The efi siging package needs to provide an script at the

signing

> +location  `/usr/bin/sign-swu` with the call signature:
> +
> +```
> +sign-swu <unsigned file name> <signature file name>
> +```
> +
> +## efi binaries
> +
> +To use a project specific own signing script, e.g. when using a HSM,
> +add the following lines to the build configuration (kas file or in the
> +conf directory).
> +
> +```
> +PREFERRED_PROVIDER_ebg-secure-boot-signer = "<efi signing package>"
> +```
> +
> +Alternativly the an own file name can be used by modifing the signwith parameter

modifying

> +of the boot partitions and bootloader partition as described in [README.secureboot.md](./doc/README.secureboot.md#wic)
> +
> +### Content of the efi signing package
> +
> +The efi siging package needs to provide an script at the

signing - spell checker??

> +location  `/usr/bin/sign_secure_image.sh` with the call signature:
> +
> +```
> +sign_secure_image <unsigned efi binary> <signed efi binary>
> +```
> +

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

