Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC9C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:29:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.21])
 by mx.groups.io with SMTP id smtpd.web10.87477.1740400176248441729
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 04:29:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JDnL5JBH;
 spf=pass (domain: siemens.com, ip: 52.101.70.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGRk1GIPMPZrsKzFHAo3Y3Gi8wbuBMePsaS90gqlcmjD3v32GHVv/un+uotlJvEllZ7zeYx/j32g48qsoltYo1Zj2r/NfMto+6VZCFNWdKsaIgxrCT3ZWNQV8lrgv6BJIKcKlcPtdpdvYLsHSuMu6Rm3WkXTH+F9NOSVPThhFKaK7U+sKO9zDeguQDPLiTRJOc52m/5pnqD6G421GhTKsLgxZsdeG1BcjTHmI4p4S2fLuE5Cy90HcPF6XJ1ygUAzC+hBCBa+f5x2LPjvjESbkicVBQZ2wagzawY1Pb6x/CNzwPHJQEOjxY61VFprgZpZap29sNVezki7UXdMT06biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI1Qog8zUprlyD42anhj9EC08VqBvDgJ7lozOH7PfOM=;
 b=AeDwXu5fB6h6dTC8Si1UyMl9jHxUqeohRhYJ4Ck8yT2BDbyh+8XOpefr3gzMcSSVPX3NjDY8HTRypnmtgMWMWYJ89xko/uY7dNubkn+yqUX1EnJ+KHdCSXb+mXpSgwQcmro4/n5ZnRrEESVZm4rMVl5tLdsFa17fw2SD/HEspPWTzjF7mSENCWOIzlgZq5iUg3g8tLVyVMpCF7troEfbnCjSQtCNnOdotyhg6K/lpbXUXN21L4yQwmWOWTQQ3KyXxOFRymjHwc6E5AOmiJLDu9BN4vQ+VHewstv3Wkr4xXlpfSw93pmm7y6z8XEL9DWeBto0UaD89eWO6OVZ4+MrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI1Qog8zUprlyD42anhj9EC08VqBvDgJ7lozOH7PfOM=;
 b=JDnL5JBHakQ3QgUHmSQhORmrN7pn5kOqrZ33XM8Cvb/dO+Ptx9smPTz/RvxvlaJl1XcUo7do3ceOS5DS96//VtGcmAbr3R4m0kMNz5J7QmShLd6gaTKN3cEnK6OAVdps9tSE/eoeu50hu6FctEWOs1DQAI7W3vk9dkroFIvs+mLRZALNCCvkDiHRhNHm7uwm8PL62gJYtBuZj0UGfOmzyMGnc6Jt62mUIztmk4THbB6vLZMDx3cLCw+inSMq5Ggxy8UGPfCsrfPO0TXTrUigmXJsxRrdQE+knmLc0203Mmw1uTbw+V0Bgas3BIiwdqCcJJXt1iLU8wL2da7jfEBf8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB8388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:29:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:29:33 +0000
Message-ID: <c4af6328-d4b6-4bfa-ba32-0d66b2abb1e6@siemens.com>
Date: Mon, 24 Feb 2025 13:29:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <20250217100024.42995-4-alexander.heinisch@siemens.com>
 <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7a1e4c-448e-46ec-cbf5-08dd54cee4a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzBWaUFXbmU2RTcyYnRKcXBQTFN6cE1NRUgvY25LK0E2d1g5ZXgwaU1yQm04?=
 =?utf-8?B?MlFjeTdtYjhiY1JWNGhKM1pRWEtjaFVFWk0vUHgrZ0FwNTlqRUZCTnJJRWJS?=
 =?utf-8?B?QjlGTmdJaDBFdHRUODV2N0k1TkhKV2k4cUdmZFNBbTdzcXJEUVBuTHR5a1lo?=
 =?utf-8?B?eHQrTU5OK2plUElnaUVDTGVzRjNqWDQvVVRzWnllTklrQ1FHeWlhUXNsTW1W?=
 =?utf-8?B?cUVBaTVXUFpqWlllSXdQbjZmMW50a1ptcFdJeFJSMlBPODhTTUE4ZzZxWUdQ?=
 =?utf-8?B?dmJOWHZGZWtmMHZjOXpzMUVyeE5xdFBYSXNGUUVBM3hYNnh0NGpvdmRmckh3?=
 =?utf-8?B?Tm85a2pUaHc2VHMrUHBoYXNtNzJHMEJudnFPeGd2MGpDYi93dWJyWHpKK3pB?=
 =?utf-8?B?akt4Y0VBdHlqaUdiOEpaQ0t5R01WcVhrS0QvWkRVRlVOTjMzbUswbEp1aWFH?=
 =?utf-8?B?dlBFTHRzbDU0RXFHb3FtM2xua2RvUDFocGxzL05FdVdRQ3o0UjM0cE4xbFFp?=
 =?utf-8?B?TXgraVFXYVhhR0ZsTDh0cENOYXZ2TXVGbTduc01iekovNkpmNE9ZR29rcTRM?=
 =?utf-8?B?SVo4Z2ZLRjR0UlpkRjR4SUtlV09kbHNKRk1xbjV0bXNteTBuN3NvM2Eza21z?=
 =?utf-8?B?TDVXbVl1MG80RHhDMlNGaktOQUNKS2hxSFRUNzM5TnZLcHM2VTJ0VDR1cDVa?=
 =?utf-8?B?R0U3STF6M0NtVnN3a2hhdHlRYzZjNVA4OFQ2SU1odll2QS9LUFFQcmQvZklq?=
 =?utf-8?B?R2NmdmFMUHZ0ZnI2aWhSaHZmcytaUDJzdjV4QTlOR2Nqdkl4SHpYc1lHNHJp?=
 =?utf-8?B?c2FHeEEwZmJuYjhvQ1Z1WDNsbmFzM3Nua0NLWmZQYVB3S2l2Rm80SW1vcnA0?=
 =?utf-8?B?OHVzbFlsak9wZVordldJeTkyYlRJenlaclU4K0I0QSswRlFqTEJZczhlME85?=
 =?utf-8?B?dzFrblEvY2pNUFhlcWdsanNiUWp1ZVAyckYyWS9TQ0dGUDhqbExWL1U0MStu?=
 =?utf-8?B?eGZMZGNqamFoRFhqZXRmSGtVR3NEc3FJWC9vM2hNNmJMVDJFTVBXbjdOQ3pk?=
 =?utf-8?B?NjQvL0hpRUJVOGVWcEJOc1FZbDk4bTdxbXNWYlN5cUVFY3d4S0I2aU1SMy9J?=
 =?utf-8?B?YndNcjk4dWZ1MWU2VXJIaXdsdHlCVG85blF2eVBLdHRxc2F2Z3VMS25rQzVZ?=
 =?utf-8?B?dmZvTjJIdk5jVjg4VFhXV1ZJVkkzL01BYWFzb3A0OExNN2dZekc1anlMcjA2?=
 =?utf-8?B?RHovaTBiVnM1WHlXNjB4Q3IrQlNmRVNjSXlxc09PLy9xZkhiVldOZjJBdFlj?=
 =?utf-8?B?T2t3bkR5TGZGUlFYdFJ2VkdDU0duendZbk9VcXVVcXpzOXp3Q1dTbGN4eVFj?=
 =?utf-8?B?T0F0SWR1cDllSXVtbFJIbElSZTJMelFUdklZQlhCSThESmlVdUNrMENCRXhU?=
 =?utf-8?B?cUJsZWJ1TjR6UUtkVFpzc0lzWFBuV1lSaGlEcFB2S0ZjV1ZZaWp4Q1B3T2Zv?=
 =?utf-8?B?SkRuNDhFNW9vTG9qYkJrZXpGM2tTQVp6eVBaMEtqMG43N3ZDNnQwR1p6SXVC?=
 =?utf-8?B?ZE11UE9RYlgvSW5iRnRVeGFTemp4Rm4xYWtpSU1lRWlyLzNnZUJIZTRZUTZr?=
 =?utf-8?B?UDVadFVUUWpjbkhTclJQOTJSMmlra3A0UFNpa2RMRDJieVBTc1loYVg4N0Vu?=
 =?utf-8?B?ck4zZTUxWnQ1TS9FT3JPNUZCaVBRWHBNNWZVSDJKUm5zUHB4MlF4Vk5qM2Ns?=
 =?utf-8?B?bnJhTXI1R3RaZVZmUlZqK0ppeHlDbDJRdytsaWFEMm1Rc1FqVFphMWpMUy9q?=
 =?utf-8?B?WFdEWjIrWlZmVmdXRkh3YlovK3JPVHVscGtKMjJCSDdBcmJNVWdMVmg2T1Zq?=
 =?utf-8?Q?oZJq+J80WBr3h?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0hMMENBVHE4eEIwNm1ZWTZMbUx2TjkzSDRyWStFOUJ4NjlRZGViR0EvWWNL?=
 =?utf-8?B?YUZLakwrbXRmVW9SUTB6SWJOS2dwY0hrcVl1ZjlxUEM0aGFIdEJOeGhibWtR?=
 =?utf-8?B?Ny9LVGFiNlk5N2hWNmlJMnpKeFBFZndxL2xxUDhXM0VjMHpDUDZNUDdrT21m?=
 =?utf-8?B?ZEx6M05GK3VPdzY3Q3hydTZuZndOVmN2azJIUjgwSTJvQVZoSXFLR2E3ZVBU?=
 =?utf-8?B?Z2M1WXJsME1xdnpPaXNESDNHbUpVLzc3VVZPcm10L3RBb0tHeDlXWko5ZXJv?=
 =?utf-8?B?blNvVTlKc2dEdUxWbGJuRVlyeWEzQTZDZG5ZTjhCZ0NoQSsxSkUwMDl0bkx3?=
 =?utf-8?B?R0pSNTVPcDRYYmZJcXphR1p4SWlCaER5bDcwdjJCbzJOVGc1L2hxT0c5RVo4?=
 =?utf-8?B?UllGSDZTbmdDV21NSGhSaTMwRjRNZVQ4ZGpQL3VlVVE2SkRHMFJ4NnByVVFU?=
 =?utf-8?B?NU1manZIUUZVSUhCWllsdHd2ZWF3R1lBYzcrZTJhZ1U0VkhNNS9ZY0poQUZ3?=
 =?utf-8?B?VGFhdUVDUW05ZVFmME9ENkRrTmhpdTZIajZKbit6dDBzZEE0YzNuMmJNc3Z5?=
 =?utf-8?B?bEcvWlU3WUVhU1Y2Qlp6d2FURHFRM00yZ2lJdlBObzFNamsrMkV1Qy9yd3hQ?=
 =?utf-8?B?OVBrU1IyNEdmWHN3NXltemRrVkRvTVFBTWJwSkVyRFlRNlh3K1o1NFA0K3ZE?=
 =?utf-8?B?VFU3T3MwbWJpZXhKTTAzem81QzRMSmd5SmU5cXpoRmFZUHlQbkhPelU2UU13?=
 =?utf-8?B?dm9nZSt6bW1DMklrUzRqZmdXU2JvK1lzK0YwaHFZVkVxb0tBeEt0eVdoT0lq?=
 =?utf-8?B?KzY2SUJyWlJyQUVMajdYdmNhYnFhZXpEN3dKZ0xnTlRiM3E1SUJuYmpHVlVH?=
 =?utf-8?B?a1ZVemxPRTlvUUx3ZVpWeGY5VVlWYlhvSjFuRGZyRGd1SFFGUy9idmU4bVNE?=
 =?utf-8?B?NmdqdSsrcDljSjd5Q2hJMGNtUXRHVSs2cnd0aGV6WnJCclczL1lpRXM0dHg4?=
 =?utf-8?B?dUVYV0E2c3BZZzhmUUZNZ29NN2dOQ1owb0ZlYlVXK21kTmtuMUtvdi9hZTJO?=
 =?utf-8?B?SElxNVVjMDVBWWdIcHlmRzA5bElaZENtVXp3SUF1RXBvR01kNzVrQVBJNERY?=
 =?utf-8?B?eWIxbXNFenpDaUdWZGVDdXJBYnZBMTN0VSt4cWk0UmtnOE9NMzR6eUJuVmVs?=
 =?utf-8?B?LzU0N09NYzljM3BSZjdMMS9rOE10QlpWSDlnc29iMmVFNE9DNUhCY2JXbThx?=
 =?utf-8?B?MDdoN3ozanliZStnVGZsY3o2bVlIdWd6WE1CR3orOU9iZkpwdDQ2SlVnKzhL?=
 =?utf-8?B?amZlYzNtbFFDb1JSajJKaSt0T1ZxRUlsMENxaDFYenBGK2dsb0dPZGRWaTFH?=
 =?utf-8?B?aTJCZUdQV0dYVUhJMGVoODlCdHRuVG5FeFltUitQam5rb0ZkRWRHRWVhM1la?=
 =?utf-8?B?M3Y4SGlZTkljaUVLMEZlYU5wWG4vTGlOVGY2QlhqZndsMDluZS9NdFVWRDhn?=
 =?utf-8?B?bzZzYVRLdE1EL1puMWhQQkJZSkxIbEpHejVlYWFNNGlmMEwxYkR6VHg4T05T?=
 =?utf-8?B?M1dWY25qWHpRQXRnR3VhSUdZMVBTUmFsQkF6WVp2aVFBQzBiaVhicklpVklD?=
 =?utf-8?B?RzlPVnhvbWQybXVXaHUzbjNUd0lKN3B5MkkxbnhRR3RLQmhjU3BRa0hWbjUv?=
 =?utf-8?B?ZDJwdEdLdFFOWlB2bmlqRzI3N09UUm9ST1JnaXluUy9Ga3ZIT3VvYjI4aVNW?=
 =?utf-8?B?ZjA0OXBDWXlJWXhQSkVXZEFVVEJ0d1FLSkgyRll6bkhYK2xGaXdZVUdmcUt3?=
 =?utf-8?B?b2w0c2VVcjh0eDRVWkRaQi9zV1ZteXdndE9DKzRsemcxTWxWbmtoL1FhQkxF?=
 =?utf-8?B?TU9MUGhWbFZoWG5NZ1FPS0RQajJ3WURTYiswVmNBNEhQMUVOSmU1aTNDV0ZS?=
 =?utf-8?B?eGxuSUprZVpaVElCMG1QbWo5M3FzSTRBZXlUcS82WjhrMHdBQS9qU0ZHU0hC?=
 =?utf-8?B?K0d2NzAwMFdjVXhmbkZIMXlDdUc4amRFZStFSVdQRG1LNmFucnFKb01OWUVI?=
 =?utf-8?B?TmFLNUNLbkp4UzdOT3N6YXpPRlRPcitQTWlrZXQxUGxoOVdDN1k1WFVMSitR?=
 =?utf-8?B?cHF2VUIvbjdoNDlqcXdKUFBKWXNFanNsdTBYRzV4UjZpczdINmowcVpmNEp6?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7a1e4c-448e-46ec-cbf5-08dd54cee4a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:29:33.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP+aSPELtWZX55dDL04AqsFJ0LC45PL0W0FMBn0A96RQdRDNQiYPP0acko4anlirsDlswZnOHHHTNNRFsUAfcbru+lR10cYsviF4oU59NJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8388
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 12:29:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17892



On 2/20/25 14:00, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 2/17/25 11:00, alexander.heinisch@siemens.com wrote:
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>> In addition to the overlays for e.g. /etc we now support persistent
>>> overlays for rootfs as well.
>>> To enable this behaviour you can either set INITRAMFS_OVERLAY_PATHS = "/"
>>> or extend your existing config INITRAMFS_OVERLAY_PATHS = "/ /etc"
>>>
>>
>> I would like to avoid that anti pattern of creating an overlay over the complete rootfs. What are the debug case you need a full overlay?
>>
> To be very clear: This is not meant for debugging in the field! Never, ever.
> 
> The intention of having a root-overlay for us was to have an easy way
> to develop and extend recipes based on our existing images. That means,
> we wanted to have the possibility to install packages with apt, or copy
> additional binaries, services, configs on the device without having to
> rebuild our image all the time, still maintaining to have a working environment
> as close as possible to the production image.
> That enables us to develop features in a debian native environment, still being
> close to the features present in the final target image.
> After being confident, the steps done and changes reflected on the overlay can
> be transferred fairly easy to a recipe and end up in a production image (image without the overlay).

Ok, this still does not explain why
Overlaying `/usr` should be enough for these use cases ?

Also this kind of testing  ensures that you will not find issues 
realated to read only rootfs in your packages during development.

Quirin
> 
> BR Alexander
>   
>> Quirin
>>
>>> This helps when developing or debugging an existing image, while still
>>> maintaining being as close to the prod image as possible.
>>> That way all image features like swupdate / verity / aso. remain
>>> intact with the sole exeception of having the possibility to work on a
>>> rw rootfs.
>>> Bare in mind while this comes in handy for debugging or developing new
>>> features, such feature has to be used with care. e.g. when updating
>>> the rootfs, overwritten files from the overlay could potentially cause
>>> unexpected results!
>>>
>>> Compared to typical overlays we have to move the storage device used
>>> for persistence off the previous rootfs. Otherwise, the recursion in
>>> the overlay setup would cause panics when finally switching root.
>>> In addition to that we move all mountpoints setup prior to overlaying
>>> to the new overlayed root.
>>>
>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>> ---
>>>    .../files/local-bottom.tmpl                   | 92 +++++++++++++++++--
>>>    .../initramfs-overlay-hook_0.3.bb             |  2 +-
>>>    2 files changed, 83 insertions(+), 11 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> index 71cc63c..a17e4a4 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> @@ -6,14 +6,19 @@
>>>    # Authors:
>>>    #  Jan Kiszka <jan.kiszka@siemens.com>
>>>    #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
>>>    #
>>>    
>>>    ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>>    ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>>>    
>>> -root_mount_storage=${rootmnt}${ovl_storage_path}
>>> +root_mount_storage=${ovl_storage_path}
>>>    storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>>>    
>>> +# Setup mountpoint for persistent storage # Either, it already got
>>> +setup by a previous initramfs script, # then we have to move it from
>>> +$rootmnt to $storage_mount_point or it has not # been setup yet, then
>>> +check it and mount it under $storage_mount_point
>>>    if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>>    	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>>>    	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>>> @@ -21,6 +26,8 @@ if ! mountpoint -q
>>> "${rootmnt}${storage_mount_point}"; then
>>>    
>>>    	partition_fstype=$(get_fstype "${ovl_partition_device}")
>>>    
>>> +	# FS checks should be moved to a separate hook / or at least initramfs lib
>>> +	# so generic functionality can be reused here!
>>>    	case $partition_fstype in
>>>    	ext*)
>>>    		fsck_ret=0
>>> @@ -33,32 +40,97 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>>    		fi
>>>    		;;
>>>    	esac
>>> +
>>> +	# Mount overlay device to initramfs - will be moved to rootfs at the end
>>> +	[ "$debug" = "y" ] && echo "Mount overlay device to initramfs - will be moved to rootfs at the end"
>>>    	if ! mount -t ${partition_fstype} \
>>>    		 -o ${ovl_mount_option} \
>>>    		 ${ovl_partition_device} \
>>> -		 ${rootmnt}${storage_mount_point}; then
>>> +		 ${storage_mount_point}; then
>>>    		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
>>>    	fi
>>> +else
>>> +	# If the storage device is already mounted on the final rootfs
>>> +	# move it to the initramfs. Otherwise, we cannot move back the
>>> +	# storage mount to the resulting rootfs in the end.
>>> +
>>> +	[ "$debug" = "y" ] && echo "Move ${rootmnt}${storage_mount_point} to ${storage_mount_point}"
>>> +	mount -n -o move ${rootmnt}${storage_mount_point}
>>> +${storage_mount_point}
>>>    fi
>>>    
>>> +[ "$debug" = "y" ] && echo "Iterate overlay mount spec..."
>>> +
>>>    for ovl_lower_dir in ${ovl_lower_dirs}; do
>>> -	# remove the first '/' and replace all '/' with '_'
>>> -	# on variable $ovl_lower_dir
>>> -	work_dir_name=$(awk -v var=$ovl_lower_dir \
>>> -		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
>>> +	root_moved=false
>>> +
>>> +	if [ $ovl_lower_dir != "/" ]; then
>>> +		log_begin_msg "Mounting overlay $ovl_lower_dir"
>>> +
>>> +		# remove the first '/' and replace all '/' with '_'
>>> +		# on variable $ovl_lower_dir
>>> +		work_dir_name=$(awk -v var=$ovl_lower_dir \
>>> +			'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
>>> +
>>> +		lower_dir=${rootmnt}${ovl_lower_dir}
>>> +		upper_dir=${root_mount_storage}${ovl_lower_dir}
>>> +		work_dir=${root_mount_storage}/.${work_dir_name}-atomic
>>> +		mount_dir=${lower_dir}
>>> +	else
>>> +		log_begin_msg "Mounting root overlay"
>>> +
>>> +		# When overlaying root we need to move the mountpoint
>>> +		# from ${rootmnt} to a dedicated mountpoint inside
>>> +		# the storage dir to prevent a "recursion" within
>>> +		# ${lowerdir} and the final mountpoint of the overlay: ${rootmnt}
>>> +		# While this is not a limitation of overlay itself
>>> +		# such "recursion" leaves the mountpoint for lower-dir (the ro-rootfs)
>>> +		# outside the tree of new root which panics when switching root
>>> +
>>> +		# create lower dir to move ro-rootfs to
>>> +		lower_dir=${root_mount_storage}/lower-root
>>> +		mkdir -p ${lower_dir}
>>> +
>>> +		# make the readonly root available
>>> +		mount -n -o move ${rootmnt} ${lower_dir}
>>> +		root_moved=true
>>>    
>>> -	lower_dir=${rootmnt}${ovl_lower_dir}
>>> -	upper_dir=${root_mount_storage}${ovl_lower_dir}
>>> -	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
>>> +		upper_dir=${root_mount_storage}/root
>>> +		work_dir=${root_mount_storage}/.root-atomic
>>> +
>>> +		mount_dir=${rootmnt}
>>> +	fi
>>>    
>>>    	mkdir -p ${upper_dir}
>>>    	mkdir -p ${work_dir}
>>>    
>>> +	[ "$debug" = "y" ] && echo "Setup overlay L:${lower_dir} + U:${upper_dir} -> ${mount_dir}"
>>>    	if ! mount -t overlay \
>>>    		   -o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
>>> -		   overlay ${lower_dir}; then
>>> +		   overlay ${mount_dir}; then
>>>    		panic "Can't mount overlay for '$ovl_lower_dir' !"
>>>    	fi
>>> +
>>> +	if ${root_moved}; then
>>> +		# Loop over all mountpoints already setup before we established the root overlay
>>> +		# and move them to the resulting overlayed rootfs
>>> +		[ "$debug" = "y" ] && echo "Move all mountpoints already setup before we established the root overlay..."
>>> +		cat /proc/mounts | grep "${root_mount_storage}/lower-root/" | awk '{print $2}' | \
>>> +			while read -r old_mountpoint
>>> +			do
>>> +				new_mountpoint="${rootmnt}/${old_mountpoint#${root_mount_storage}/lower-root/}"
>>> +
>>> +				[ "$debug" = "y" ] && echo "Move ${old_mountpoint} to ${new_mountpoint}"
>>> +				mount -n -o move ${old_mountpoint} ${new_mountpoint}
>>> +			done
>>> +	fi
>>> +
>>> +	log_end_msg
>>>    done
>>>    
>>> +# Finally, move the overlay workdir from initramfs to the final
>>> +rootfs [ "$debug" = "y" ] && echo "Move ${storage_mount_point} to ${rootmnt}${storage_mount_point}"
>>> +mount -n -o move ${storage_mount_point}
>>> +${rootmnt}${storage_mount_point}
>>> +
>>> +log_success_msg "Overlays setup successfully"
>>> +
>>>    exit 0
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.
>>> bb
>>> b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.
>>> bb
>>> index ec7f85b..af610e5 100644
>>> ---
>>> a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.
>>> bb
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_
>>> +++ 0.3.bb
>>> @@ -45,7 +45,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>>    DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>>>    
>>>    HOOK_ADD_MODULES = "overlay"
>>> -HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
>>> +HOOK_COPY_EXECS = "mkdir mountpoint awk e2fsck mke2fs grep"
>>>    
>>>    SCRIPT_PREREQ="crypt"
>>>    
> 


