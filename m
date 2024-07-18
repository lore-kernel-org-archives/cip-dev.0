Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B1C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 16:05:22 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.77])
 by mx.groups.io with SMTP id smtpd.web11.18839.1721318719931047223
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 09:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gAjponP8;
 spf=pass (domain: siemens.com, ip: 40.107.241.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtswXg9v6oj5Kf6WrCsLLUNKHvX25TD6AXnd7X7Bg2U4aWn4irRLzb6Lps0c5WAtiev+wyVPweCsHk6jNd5ve0tOT8Idepo5arN6rjljDtdWCz38thYLHB0htYO8gLkp9DKhpjzhiqlL25j4Oi3VjX9BRCjaydMc269Pta/SczR/f9agFgULixCeAjvXMZkObbMgouE5hxSg08uaR/UID3WjG+FgOOcIlOVzIBKIcoySfdN94xe5TS7XW6WBU/t+oLk0q6gM27a5hpM/2ukJYgc0WcJ/3crvswraW08xY0RanrUO9v1UTcrjbf0AVml+lvpJ9W79ljVIv0f5ptGOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri6Z8x+KVVVJ7j7QafImZYfMHw6HcDPZIVYevYGU6Yo=;
 b=cy5V2Pbhk73eIXWxPAxLJCmItRS0nAYM/fkYqMehj2rJZoNZX9xit8OIP5OD+zu9X1V0QcxtrsWqmVwOrxcCJXXk4S3VlEqJT8wVlY5L7h4d21edrfi+yT2nTyyicqNQ87kgcJquejp5/mkVHtdIov5zvcB6L1/hrQm2zmDV4CAqFJQMCAwvXIuRj/wvjMFNglAGGMvCLmCOOjZRPbuV7jU7ZqP91OCEzXZW35Ecdb3N7Shak1V7WiVnApHqofEQrihMEBVagFdFY23hYLXhY62xGTzBD0GRNVSdBAqV4kyOe+B+LMJLetg5oelkyA2O4y8NVlTLr3Hu0cOmH6n/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri6Z8x+KVVVJ7j7QafImZYfMHw6HcDPZIVYevYGU6Yo=;
 b=gAjponP8kRn0Wz0shxVswfRxNelBymSsiXK6LtK8QBjPVp4mn96c1FAezQACD1dgQhRevDVJzX5KCUGf7Z+xdV6abmDvkGNQG4pRcElqUZc62DCxjZrKWoR47GPM1lcaQeAYUsSe2oiT7UFSMMcZmhsh+LRKcbEU2n2uy7bG6h+FEpT/xJi6edRCOSP2mjty6ToMNJ7xKiz8ARl60qljFkvWcZx4BLrC6PeW/9fSpewwb/eJ2W2G3JYZ4kX/+jCX8CaFxPUD14dVk9ZVfocIt+XstzggT9i9j86dFNIlMAx67udrzzx0UyUiRvf2Q7dEhvkj/ysGay84qLBYr9dXBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 16:05:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 16:05:15 +0000
Message-ID: <4ec5461c-ff4c-43f5-b868-576cbb295bc9@siemens.com>
Date: Thu, 18 Jul 2024 18:05:13 +0200
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Subject: isar-cip-core upload to kernelci fails
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: d526e1b9-0aa5-4b9c-91eb-08dca7436957
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VldBazFrb1FuQWcrbEV4YnJxVkRlZFhaK2ZTblpzSFJwazhFTUIzejNtNWcz?=
 =?utf-8?B?TzdpZk53ZVRUdXZYV3NUM3dxWEdWZC9ueWwreEdGcnkyZVZFTkxqT01DVlpV?=
 =?utf-8?B?OFdwN0tPVlRJK0U5S2I5R2NacFFRY3hYR3lvbHJzL1FDU3k5VHFXRTJZbnhL?=
 =?utf-8?B?QTFYdDZPOWZ5c2x6clZCaHdsU3gvbnVvR1h3Tm1ESmpxbnVTUzJnaHBEclVB?=
 =?utf-8?B?NWsybnZQcXROdTlsVXJiTWgvM2xNQ2tlOWRwZm1Bam8rVkpTSHdqL3Bwa1hU?=
 =?utf-8?B?SzhuT3c5V1VFNFJJWERTdjN0K21OSVdPdWttVnFMVTRnTXJPcDlPd1RTR292?=
 =?utf-8?B?YndJU3BLdW1uUEpCYVVLQlNCV3ZQVkI5eHFybDNjRjFTUUJjOWNGSzVmVVZ6?=
 =?utf-8?B?ZUl1dEZSYjdLdzF1M0dZQWZ6YkZvcldRVkh3Y2JaNFlGd2dPYy9MbWh2WGlY?=
 =?utf-8?B?ZFRqd3FKdURvWTJFT0pyQVdZRndma0JvcGdUbGh2cTZDK2pCMDFhMVpQdTVB?=
 =?utf-8?B?L3ZZbU5iZHd3eXk5SThSZzJJakNoTU9hRzRnV0tqMENla1UzMjdEZXdxSmlo?=
 =?utf-8?B?cSthckJTOFJmTEtVU0l1ZThGeHROVkozOHlvc2RMTVVuWFlHNHdTUnZHL1JB?=
 =?utf-8?B?dW9reW16SXF3dDBlOW04cVJsOWo1NzgzT2lXZ0hpSEhCZkQ4R2lQZ2lvYXVF?=
 =?utf-8?B?THRpdlBCZE5ud3M0VCtHSktXWTJ6TVg0Tm8zN2xBVkdTMDdhRFV5NGJHWmsz?=
 =?utf-8?B?YzVoR0pVSEtVMWFod1lGYzZhTGxyeUtDTDh1b2FVcXN0NFFacjhWQWFVd1k0?=
 =?utf-8?B?eHlYNjdvL0UzclRlNGo2SFZ1N1ZoeEdMbUNocXlRTEJzazh6bkNXSVF6OUlY?=
 =?utf-8?B?MzVSOEtvUFRZdHlHTkcyU2V6R2gvNVVRM3JERkxiQ2hBbUZZNFZwUUlUMU5w?=
 =?utf-8?B?WllwdmZ5QS96WmlJT2dPSWNRK1cwa2ltQzlBRCtweDBJRC9jY1NSaEhqT2Zw?=
 =?utf-8?B?bHZXNW9SQjhjVGFYQkhqakpjN2twVGpWNE9JU1hqNG9EbmFHaDR6MGFXc2NQ?=
 =?utf-8?B?NkVyM3lJM0k4ZG5zSENWbmhja3dCSjJOY3IxUmRyMk0xbnY5YSsvN05kdDBr?=
 =?utf-8?B?N0VHOTVMZDg1TUZlNHgvWFVibStxejFIU1BTSU10ZW41K0p0UlM5cDhnYzNQ?=
 =?utf-8?B?cHcrTFNmWlowTHZaS2NpaU9LOHd5cVhwZ0UrcTZ4ejFJUkkrek5MYVYrS2px?=
 =?utf-8?B?KzVjNmVZcUFveWh5TmtPUU85THNwRFpQRjEwS1RQWTNhM2ZrUlJVUW9uWURG?=
 =?utf-8?B?bUtGcGhtVFNzSE45SGhzTTdQdzhEblFUdUQ5c2R0OTdnZkNRTy9PRWlhdUth?=
 =?utf-8?B?ZU9kZ3dOMGwvSnpVRnVQKzBVOFdBQTl3NXYyUkFYY0xSNGRRaEk0WUl0M3pz?=
 =?utf-8?B?aDAxeUdZWDhUamJLelZJeUd6UE5iRmFEQ0VhVDR3VGZjQmlVb0FtMWZxdEpm?=
 =?utf-8?B?L1hCelVqMFlOelpXVnRjeXN6ZVNQV0VrTlBVWTRyTExUSFJSL0FWYU1od2c3?=
 =?utf-8?B?N3Bna0JiSVVnRm8wZUN0WExlMnJ5ZVI3Z0JWUG1UL1pFWU9DY29CUGVzMHRt?=
 =?utf-8?B?KzUrbFYwL2V3eVVSazhNLzZWTHZQVStHUFphNHliU1hzeEIrc0pNZThMaC9N?=
 =?utf-8?B?MGxOV0w1WUFrckNDS2kyVGJwTnczUjM4Skx1aXVHajBpM1hHM2ZHV0ZLZ01O?=
 =?utf-8?Q?EMXOP0jCV15KqTNTZU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWxCN1l4T1lHM2Z1b0JHclhqd01UaEhSa2VwN3ZHMzM0aGI2VFduNXNuVUNC?=
 =?utf-8?B?Tk5xUXZYUnoyQlk4ak5WeWx2Vk5YZXBhUm5kbFBkSEJSMkJ1RnhKZjNzcmIy?=
 =?utf-8?B?UjFndzhwS0xkdm9MWkdNUUpPajZxUnc5L1VuTE15SkRRbGZwa0lFNmc3Nzkr?=
 =?utf-8?B?MU9vMExjV2M4RjBwWk5mVGhjeXhuVG9DYzZJTEpnQ3BoWE9uaGI1Z25JLzBn?=
 =?utf-8?B?WjBQcHdkNG5uVlBobmNROS9NMjlacjBQRnVKTlA5M2hncGFtaEV1MC9YdGlN?=
 =?utf-8?B?c1p5c21EbmVKa09CZjJSbE1YdGttcGdTT3RqZWVOQm1rQlBxVkhXaXhYMHJY?=
 =?utf-8?B?UDdlWTk4T0ZtMDY3TldkYnBOcWRoRkluaWQ1eWEwRFVWUGVDMDJlVkh2MmxW?=
 =?utf-8?B?WnovMWM5WlVMUHhIcEdPckxVa2lqaWh4WXdmcjJuNnd3UHdCS0xWSFdMNzVK?=
 =?utf-8?B?QkRlOUNIUVJyVWFJcWhRM1hBYUV0YzFLalJVY0Jjcjg1SEdqbFVmb1cvNXIx?=
 =?utf-8?B?RnU5MlUvUGdYMjhtMW4vR3JmUmZRWDBjRy9yZGJMVlgyT0JjK2lPcGJZZ3NB?=
 =?utf-8?B?TGYwWDRjbGtRa1hucm93cXFuTUVJMUNUUUtwUi9wa3Y2a2dWdktPQS9rSEhV?=
 =?utf-8?B?RnZFazdCN21URGJNV0V4ZE9zUUx5LzR4c0dkeStKRHYxUDhRNG1UVkVRUDZw?=
 =?utf-8?B?MmpUaHJWQ1VRZ3FMT3VtUHZVNTAwNGZKVHpQUEhLckVLSThLZjNDRmpJZ0sr?=
 =?utf-8?B?NmFtTEFUUjg3ZGRob1JaalhvSHNhQU4zV0I4UXcwVTdLMlM0ZGs5QUJmOEUz?=
 =?utf-8?B?Q2VyMW9IdmFKaldoZDhpUjFWdzBOS00ya0lYTCszU2pSM3dhSEd1WFFrU1dm?=
 =?utf-8?B?V2RVOUtVNUxmOFgxbjBVTXlERGpOVkx1UU0rK05UL3dDWUNETjl6MmhvOVFN?=
 =?utf-8?B?R21vS01yYnhSaWhtb1JUTk5PL0VQd2sxaVdpREErbU9DcDNpV0E1UFVOelVC?=
 =?utf-8?B?MmVBNmVVaE1ZeGlWc1BZNXpqTmxKU29Pbk85aGJ1VnhpNWk5QXdjalpveExq?=
 =?utf-8?B?c3kxa0ZrZmI4WmQ3cEFNVHpsN0szUTZhNEQvYUViVTl2NUtQWC85dDM3MFpm?=
 =?utf-8?B?RkdyQm9VOFZQQlNSWks0bmZJd1FBQUZJK2tYRTRRYjF4RzFjVDFSNFIyalF4?=
 =?utf-8?B?QjBrUHhWZTZUcTU4UlFKdC9GWHNlNWhZaWQ0VEhLaDhjUzdpM1RtMkpxcXNH?=
 =?utf-8?B?c003TGllVGRNc0ZienFweTM5Q3BDS2ZrU2tLeU1ZWjdmM1V5NmJVYzhvQmJD?=
 =?utf-8?B?QVhLMDhXNEFiMzRMdnpjejUrTzQrb0R0L05zYU5PNGszdGhmTGVyNDFYTlBo?=
 =?utf-8?B?eDBZOStqUWxnYVBRdHRMUGE3VUxUOUxQQWZ3NXVnaWh5Smd2N2J4YlZ4NWdH?=
 =?utf-8?B?VnF5TThHZjRwODRtcjZnd21jSVF2YU9XaWlSUXBQSDE4cUdlZlhENUZFNVdP?=
 =?utf-8?B?Z3BRVGt4aGZ6UXRycTFmbWRHcGdYdnNnRHN4bjluc2Y1ZUd1bDNzNFJ4UVdn?=
 =?utf-8?B?SkdPenVJL051Z0V6UStVSUE2NWtpelNaVDl5UTFSRkxCS0NicjR0NmpkalhR?=
 =?utf-8?B?bGxvZ0lUdHMzUWNxVEJQTk5nZCs4Ymo5V0NtODgxWXpNdWtKYzMwZVI2ellR?=
 =?utf-8?B?NnFwTTg4VklING5EbzJqY20zQnZkWEVzU053Z2l1c1dBeGR6NzU4bFZKMDlE?=
 =?utf-8?B?cjhpRlR4N1Fjd2NURDJKbFlTcVZyL09wREVUeEkvLzVOY0FuWGZLY0s0bHJ4?=
 =?utf-8?B?cmkrZFgzd09ySWd1R1ppdXlIcWFyNnJDKzdhWExUWEdadG9kaWlpR3pRYlZV?=
 =?utf-8?B?N1NmY0xJeVJKUVZsM29XczZjdGQyZ01Lc2lsUHJaQXRsLzNtcExJeEQ0R0Vp?=
 =?utf-8?B?Qldmb3lYWXF6dlNpTjZaQ0VycWRJR0hjd0cwaVZrRm5acjRpWEUxYzZiMUtm?=
 =?utf-8?B?L3RyU2ZpalVVUjhKTjVGSG0yNllqTEJnTEdRV3hBTDdJUy9DQXE0RWRZMU5v?=
 =?utf-8?B?dVc3OVlTZnJYMi9SQXYyUFkyQU9jOGFTYi93aXc4SzlPU1lvU1dtTjZjcVVs?=
 =?utf-8?B?T05oWGJoeWJ6SEtqV1p3SVdHblhNZUIxeGhnVC9aQTdadllPZHc2S2N1Zlgz?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d526e1b9-0aa5-4b9c-91eb-08dca7436957
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 16:05:15.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjHxpFcY1dXN6GPiHmxV9xGYoMYdbxr48rDMqq0Eb6aPPmxm+SQk/uyp8f+ygsQRnBOfTgFWMCGGrUcdKtho2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 16:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16591

Hi all,

who can help with understanding / resolving this issue?

requests.exceptions.HTTPError: 500 Server Error: Unable to create destination directory 'images/rootfs/cip/20240718/qemu-amd64/' for url: https://api.kernelci.org/upload
(https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7375436445)

All kernelci images fail to deploy right now, see
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1378950683

Thanks in advance,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

