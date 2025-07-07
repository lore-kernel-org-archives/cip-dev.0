Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA26C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:34:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.70])
 by mx.groups.io with SMTP id smtpd.web11.56504.1751880840594365591
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MvB38euy;
 spf=pass (domain: siemens.com, ip: 40.107.159.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnLQ5seU3gttR55PNvYhT/zy0rNry+o006VODy2VgFLgVssqk98Y2ZL999xdPmLdQjzF7PKN3wT7z7VO40e0EunbMaDzZ1wK7jzEA2xMX/lL9++kTg8KyZ7n4mlGrXnjTDcIckG0ESND8Y+VUsXORbgPkiPANq+jF0Ivl7LQ3sUingH91/to1Kp+Mcs9U1JuQ6zPsWxogVFzzlxv3Ikpa830eE7TFmfLrOesWcydUquFOVmC9g99n9bt+6ep24YN2huKOcBmGlRyKw2H51XwYtgCOZEo/t8ebkO3Wbar5Avnb3Vuruj8K9CH16eLvnGEimZbS6t872IaDquRxKauGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlp7vB7Si9h4EIj3wN7wXMoEDdZiSwQ3coH3SW0J03g=;
 b=aWdWU/UitYNKFJU+nHyAG6QxT4KS6a1Vi4hQVoq/Nzh8A0u9iyEZLezEYAkMIsVX35l9KFFwSIBgNgQReY+yG5N2+n91cDskmjGfELPACqZ9vrP2whVFIFIkJ//Xj38QD3ag46coB5upVcdM/WprQdCcRlm0cd/0K9ZGSKwRUBl4MBUCUwhuBGsqKutIkb0qAoMF8k70+W9g9Ouwc67eI7BM7BGgHuaA81Za8nNI+sIqpW3BDEKG4yH9DS4L9gOptp+Q6er4VoC5bXxyQgIgpVPWsuxj2hA4zvJbMt5DjJG3i1gku/P87xgL1rlYb0jraN/NqfMx+4KYNWZ+RlnmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlp7vB7Si9h4EIj3wN7wXMoEDdZiSwQ3coH3SW0J03g=;
 b=MvB38euyMUiruDOnvtitNBrMzvIyaFm1agh7dnf2K8TGaJ8VKHqKTeEsVplRaGZ+tEL1uaygCA/Kl+OUk6DG6TZN5sD+mxWQFzoHFdZkoJ9/vkxF3zjL7gtg60pL2T++n12+uSS2JoYCYO0IUqOXWR0kgrxmHaHeZCFlau7QsSHJTXJpBZF2wjR4PM6PPtB1ntOdlrIOO436oQg5z1A/GmS0sVeF0eBhPPEg/b8+0w7XEPYassSHKV3aEx0NUQHxw45DUjZq4p11NN3cPD5Z6PEeq7UgPSlHvbaVVXI9Z9CE63Z6MkCf2rAwOJxx6IwbxKTc8pP0VpADxE6lngYMyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 09:33:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:33:56 +0000
Message-ID: <61e5629f-a3b7-47c5-a020-df5f260819ad@siemens.com>
Date: Mon, 7 Jul 2025 11:33:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v9 0/8] initramfs-crypt-hook patch
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <cover.1751879779.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1751879779.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3c66c8-6443-44bc-1cec-08ddbd396479
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGJKMGJROE14ODJsQSs0SXprVDBKM3p6L0tWY3poMitESWNMYzZuVFMvNFFv?=
 =?utf-8?B?OEhTL2d6d3JJakJINmUwcjhDTklXK3hhZU51M2ZYRHFXU1MyejVxYXk1UXEr?=
 =?utf-8?B?anUrUExaenZSMGtNdjFiNkNxS3ptNXRWdW5MK2c4UklPcWM0MVpnQTRRNlZH?=
 =?utf-8?B?azg0NEtJcmhnY0lhMCtHZm92blRta3NUUEx2Z091bzQrSzd4T2VUekt5dFRy?=
 =?utf-8?B?K0gyNmVsS3gwS0lmZnRMaVJUQVZzWTlQU0tVS2w1NEhjeC9QeExkdDJBaXJE?=
 =?utf-8?B?NTlhaVcxUDZyamdNejRranZPNzRWL2J2dEpFV25Mam16MUJndGR6YmtkeC9P?=
 =?utf-8?B?clRkVnJPV0tUQzU5ZFhRS0dZRWpGeDZnT01RZ0JuTkdSUFBkVjZJVkNvQUhC?=
 =?utf-8?B?c2dqRGNaUE92cWxyeWV2RHNWLy8vYkdBaTFEbHBta0EraytsbE9MdHo2TXMz?=
 =?utf-8?B?M2JqRml4NFI5V2FSNHNKNFp2SW43MEdxc1dDUmo4bWlSR0g2aWphY3F3TlM2?=
 =?utf-8?B?NU5sREFQbE9PaGxqc3h5OTRLV20xM1N2N0hkRUpaUXI1c1dZUkFyZlYvcnR6?=
 =?utf-8?B?SDdpcm5HaWFYTndvbzdTb2pmT013bUQzSXFCK0J4T1RrWGJGbm5SNGNqanVI?=
 =?utf-8?B?eGpXZzBnMEJmd1BmMFBNVzJ0dXMzZTUvQTh2Qko2ZkhINCtZOVhEN1VxSjAx?=
 =?utf-8?B?eXZsQlc5am5Ja3hEN0xLTmFOMWZTTDlTZE04YUVhSVZobFUwOTdFSm93cFRC?=
 =?utf-8?B?Q2lFTnppR3V5RjAyY0FPV3pUeUF4b242MGVEQmFtTFpKbnJjdnJxcWlFVTFq?=
 =?utf-8?B?ckRteFRwMUd2WHN1MC9CVVBzNGpGa05UK2ZOMHdwRlhjcmVTSXYrMzVVL1dO?=
 =?utf-8?B?ZTNBcjFubWlUd0o5RXQ5L2YyeitnUGRzak5QOWwxY0ZBWUR2bXZwckFGSk4r?=
 =?utf-8?B?SlpFN2c2QmtMYVhnZ2V4NnRBWkhRYWV5Lzk1ZmNCZWtqTjVDM2VwcFZ5TS90?=
 =?utf-8?B?cmVGRWxyamlGNDNxR1BLdkU2UkUzT05BbUYydDk5VERSZVc2cXBrc0lleFpz?=
 =?utf-8?B?b2EraTZ4TUh6RmtlUkFxQ3UveWljWUxPaU85SmxETHNuWkJPMExsY1pROFFT?=
 =?utf-8?B?MGIzVDUvbHlYUi9pYU1UU3RXeXVSTUpuODhwRU9QUHhNZEI5V3JHYzBzY3JD?=
 =?utf-8?B?QmpVSXkyclhxYUg0TjRtUkN4Zk9JT0lnbGpnWnVrWnpyYWRUZjB5NWZxa3Nl?=
 =?utf-8?B?ODE0WVJ5N2x4U1NpeUhsRm1CTS8xUlNCSVp4OGVSdWdFSXh0RWwwS2wxYkp3?=
 =?utf-8?B?NlM1aW5UQmFMeXV6czgxUVl1dnFJSGVYVHdrOE1DWDl5aWVnSXJveko3ZXBO?=
 =?utf-8?B?dUVxZm5jS0UwNldUSC9LZFpuR2g3ZHJiUkpqVGVRNWs3dnVkaGJCUXZPY3Y4?=
 =?utf-8?B?Mlo3aDM5OUpRaXN4VE9XdldMOERPeWN0RzFvRHk0eE51N1dIMHREek9Ec3hq?=
 =?utf-8?B?dytOS05LZEhZZ0I3YmpDSTZiWTBwNGVld3NheGxzM0VkTGhmdlZjZWdZZUtp?=
 =?utf-8?B?Z1VsRTB4MVh6SkpnVS9ON21vcmpYTnZ2VnJqNklZSTczM1ZiWkhoYXM1OEFn?=
 =?utf-8?B?NmgyeTNVU2FSakNuNW1ZSzkwNmV4cnpmWW4yZkNYT2J4eFYvYTdaNis5aGll?=
 =?utf-8?B?OVZrMVFpV0NNdXh0bjd1WGxram5zSEh2bnV3UldpTmlJNldieFUySnFGeVJU?=
 =?utf-8?B?V0M4TzRRM3pZbmpkVTYwL2REZG1idmMrN0lBcms0ckFNM3pXd2dsSHlGbTBs?=
 =?utf-8?B?M29zTWJYYjZPZHdtaWFmZ0ZrRC9sMHB1YWxzT0FNcjVnbi80dnRYbXFEZ2o5?=
 =?utf-8?B?VGNhdWZubThXVUcrVHYxK2xKclc1KzZISHNWU3VBMHB0c1hPRnIrYktsbFNl?=
 =?utf-8?Q?DaIKvFs9hV8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1E5c2lnVU8xRmJtQWQ3cWVoT2tiR3o0Smw3Sm5QT1RiYnVQcWpzTmZwYlFI?=
 =?utf-8?B?R00zQkgrRlMyOGVKMnRZNFY3UHFWWG11VWZYYXdWMyttYmI4anJjRTltR1Jh?=
 =?utf-8?B?aEZ1dzdoVG4zTGNrODZhRUlDaDZUbDdjUjV1dE9DOWhiYlcraUdvaVdPeDNo?=
 =?utf-8?B?b2tJd0ZJcmQ4RnF3THlydzFQR2VyYUJLWHFJSzNiVTFXT1F3MkttQmhlei9T?=
 =?utf-8?B?QTBaUmtBN0toK0FJczdkWE5XQ0JEZkxiRnVuNDAwR2dqSEN0ckhFL3VaMzdK?=
 =?utf-8?B?MHV0eEtTaU9TZ2NBOXFuVWZraW9jZThmQlZNUnVXM3czSDB3UnN4bFU4M3NV?=
 =?utf-8?B?Mys2MkpHWVk5TTc3YmE2UDJpV3ZLSTh3UEJscG1rL3hWbUVVY2pCeVh2Zk82?=
 =?utf-8?B?N0hDZGhzRlQ5YTdXUlNHa3Y3UEIzVVI0MDRBd3gxU3kwWjNXUjZlYUFXRHAx?=
 =?utf-8?B?Q21PTVl1WlJVUVF3bHZHYzF5ak5wYmFYQW9yK1dka0F6WjJBREJVbExsVjAx?=
 =?utf-8?B?VlJ0R3huU0VMalhpUUg1ZXp1TWZBa3dYaG5CTTFNWWRSbW1OTDNqSEtYQXJt?=
 =?utf-8?B?MHU2bzZNRjVFWUNlSXIxWHRQVWhTUWpIekVQVDdnWU5JT0dLUkdmYldIc2J0?=
 =?utf-8?B?WFVWbSs0bm1GUlByNE9aWXd0Y0wrRTdnOTh5cFFjUEZsNmlSbmtodEtNcEVi?=
 =?utf-8?B?aWZ3cmNSUHM5SnhSeHhjY0hxdnQwTlVkak1ocWlpMGxJdWYxUFl2WFdmWmZi?=
 =?utf-8?B?eHlxTmJYMGx6VC9Kb0dlSVAzUXpxcDNmS2RXRHhCSTF2aUtwUTRlVWEyNVh4?=
 =?utf-8?B?MlN6Umx4cDJ2N29Dc1ZjTm0zM3B6UmY2TmczVE92Y1EwY3l1Tkw5VG9HTGUy?=
 =?utf-8?B?T2cwTllMVG15aGtJVTRWeTNURWNPYXlqdE56NzkyOVA0OGFUaFZ5MW5WaWFj?=
 =?utf-8?B?VUYwMzYrZ1JmL2k4bVorYVplOHN2OEdWOFlvWGVvaXc4WHVJbXhmR1NlSHBp?=
 =?utf-8?B?MkNtVVZPazRGSlFUZ29hc1hzWWg3QmNySWR5THVlM3lMUk01NGFFV2tEcFYr?=
 =?utf-8?B?SjFFVEJFY2ZqYzU2aDVHTjlHd1R5M2Z1VmRPdk9QWGJucVpXTDJJNnZFYkU3?=
 =?utf-8?B?OGhhQmpxVHdUTHZTT1prcFcwdjhETkNNT1VmVTZzSXIwb1ZCNmN2ajN6WC83?=
 =?utf-8?B?c200M0ViTDc5dVQ1d0Z1cnRySHJaNmQyYlBBa3dURW90RXE1OFFDYnFrcEYv?=
 =?utf-8?B?MEpFS0IyYXhpMnp1QXd0VGFBR2RkT3Ntb0s3cjIxR2N5bzdmUEtVRDlFZzdh?=
 =?utf-8?B?ZVFacXVESlRwbEdHaUlCZm5JRjVPbmM4MzhxSWxtL0pTL3dUSU90Z0JJb2FT?=
 =?utf-8?B?VlN0bDF2Q3N2UWg2b3dXdFozaW9lUlI5eTlBTTRJN0dacnFSZWNhejBxcTBL?=
 =?utf-8?B?ak1WWEMrdmd3dW1hUTN1U2JXcmZyRFE5bWpab0FWYW5rN0pDSjM0TEVrbllr?=
 =?utf-8?B?ZjRhWUlDR0ZEQkRDZUpoTm11bjRRUnAxMm9mWGwwaitRQm9oc3FoLzdIZGYx?=
 =?utf-8?B?bUNtcGlGZytNQzQwK0ZQanJqUkkwNVEwN2Erbm5jQVI2U09ZV0g1TDNlazI3?=
 =?utf-8?B?d2x3Qzh4Tm5UR1RXRkdoR2VhVi91am5uQW9ZK0c2VTBDaHJTV1FKNjRkejdo?=
 =?utf-8?B?TFVUak1nMnpWcnNBdmVaYmIyb3pnSDJ6bWprSGNrby8rcFMzZXVBMUhBOFVZ?=
 =?utf-8?B?MnFjNkRKZ3YxTExwS1B1UHh4b09ON3FUd1EzcndHY0tlOFlDM2dMWUJIejdX?=
 =?utf-8?B?bVdncExGWStYRDhUYy8yNHF6aUViZWlxVW4xK1RwZzhJdFFGUUJkOUFYTHBx?=
 =?utf-8?B?NldwZkw3c1grYVIrWTF2TURiNFBodExOOHVhNlpHbm5lUklIS2tkb3NhT2lh?=
 =?utf-8?B?ZXp1czJSTUFFSE02SnozN3c1eVVqNlpmN1BBdnNQTVVYaW83YWtkeW05WTlJ?=
 =?utf-8?B?NjZScWxEMncyZGtDLzJQMDBzWEVWRDBUZEFVcTFEMWdwUi9rd1FsZFg1OHUr?=
 =?utf-8?B?U0s5dVIvQ1ZPSUFNT0c5NEM0RXpPZVlFSHJZcUxzS0N1NkxQSTdGZytjQkMx?=
 =?utf-8?B?ZDZzOGh6aHVhRUJSQXJPOU1LZ0pNQ3prOXh0NGFNN2ZTTHk3ZE1OUDhDaUNa?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3c66c8-6443-44bc-1cec-08ddbd396479
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:33:56.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/aAG9NFDsJvCMQd78NOAsKN6b5/YqWzXqOWFpFH0L7uVHBwbLkADiKKXzo8ZOX0uT9BwgJdNVY+B1VHPK2F3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:34:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19380

On 07.07.25 11:16, Jan Kiszka wrote:
> As Claudius left denx, I took over this series and addressed remaining
> issues.
> 
> Changes in v9:
> - stub-out initial key persistence on buster (tpm2-tools 3.x)
> - replace open-coded random key with pwgen
> - Link to v9: https://lore.kernel.org/cip-dev/20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de/
> 
> Changes in v8:
> - Rebased on next
> - Added documentation about the power fail scenarios and the LUKS header
>   example.
> - Link to v7: https://lore.kernel.org/r/20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de
> 
> Changes in v7:
> - readded tpm2_createpolicy for clevis
> - Link to v6: https://lore.kernel.org/r/20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de
> 
> Changes in v6:
> - luks formatting of format-if-empty will now be redone when if it is a
>   luks partition without a TPM2 token, this makes it a bit more
>   power-fail save
> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de
> 
> Changes in v5:
> - Switch to use TPM2 protected password instead of static initial
>   password for encryption
> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de
> 
> Changes in v4:
>  - improve documentation and commit messages
>  - reorder commits, to put re-encryption recovery up front
>  - extract static temporary encryption key patch into its own
>  - switch from lsblk to blkid
> 
> Changes in v3:
>  - Rebase on current next
>  - Extended 'noencrypt' documentation
>  - support clevis tokens for re-encryption recovery
> 
> Changes in v2:
>  - Added more descriptive commit message
>  - Added more descriptive documentation about noencrypt option
>  - Fixed typos in documentation
>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
>  - added re-encryption recovery patch
> 
> Claudius Heine (4):
>   initramfs-crypt-hook: store initial encryption key in TPM2
>   initramfs-crypt-hook: add re-encryption recovery
>   initramfs-crypt-hook: implement 'noencrypt' option
>   initramfs-crypt-hook: add 'format-if-empty' feature
> 
> Jan Kiszka (4):
>   initramfs-crypt-hook: Use pwgen instead of openssl for initial
>     passphrase
>   initramfs-crypt-hook: Drop redundant copy-execs for
>     systemd-cryptenroll
>   initramfs-crypt-hook: Only use resource-managed TPM instances
>   initramfs-crypt-hook: Factor out tpm2_functions script
> 
>  doc/README.tpm2.encryption.md                 |  57 ++++++++--
>  .../initramfs-crypt-hook/files/hook           |   3 +-
>  .../files/local-top-complete                  | 103 +++++++++++++-----
>  .../initramfs-crypt-hook/files/tpm2_functions |  66 +++++++++++
>  .../files/tpm2_functions.buster               |  24 ++++
>  ...ook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  22 ++--
>  6 files changed, 229 insertions(+), 46 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} (85%)
> 

BTW, I'm happy to hear opinions if this should better wait until after
1.8. The core has been around and looks sane, but I had to add some more
bits for backward compatibility. And... you know...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

