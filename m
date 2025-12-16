Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C680D5C0DD
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:29:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17519.1765873755366152162
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I9hBckfc;
 spf=pass (domain: siemens.com, ip: 52.101.65.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+iS7UOxXOvhrT2VsGg0IbUPff+CdZV/ogSCXyMb00FW/KEqgbejsEKce1jFNe4BvlzvjCrP1aaRwFdJEEcDJMm9nQh4Y41uja+eBsaE4FhGUpBFQxwsN4h3k5feoMHkFOrItHvyPa+PZtcJLRjVn6KMEktlrJPcjbjZ5kWmjhFCgQKsdahyaz+8iatESnHEl5s06rGodnGGrI1uYN7/OPybn//8Av0AcdYzw72PhiPVOwRjD5BDpRa6W7lUT0dLrT5LZcVxQ7TxXMjhWkQA5BJ37YBOG4o6cUOofj0LLs/VZgHMUlAPj49a/Fu22w2Kmm0GOYs0xD1qryssZ4Sywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBEt3tGo61VXngmEsK7K9/siYT0GHGtxxaP41oYLau8=;
 b=mgPVSPCxARnYaB0xxNvvskHetFf/bjh9tdSi4caNWTTXXW5Gn7D/6q1VCZ4WF0I2GBnIXpzzM+v4cInwQHmv0yFLgp84h1Efa2aDxZ4wGY9H8xjoP8vM93qzsjds9dihwv7zWZb/lo4Ecu5EJ/VfOAqOZ9kEE4pn80/78872HKmV+k7eWiBnIsOX2xQxVzT2k4Avg/WEXB0PSdtZ/EHYtWcwQx6YW8f72hN77uHkkV1SVmdbL6jYZaTReIDeT21QIIFJzuW/V7/Y1no/McCDsm8M1xXD+2nZPN8qOTH5Qw+1ug3+hHVgtOFxExTE2nzl/BE6inXkAmuGxhnjYjEkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBEt3tGo61VXngmEsK7K9/siYT0GHGtxxaP41oYLau8=;
 b=I9hBckfcVgx2YkqL9u+o1+MjExtoamXe1chSJWtW+Jghht8+33C7N7ApjtE1p9PfR8vAcxKU+vg3CC7RvoahOn8Yxz5YSOLpCE3QIJesHUGxXuqXv+f2HXTjXBmj5j9A81p8kRwogkAcrIC/9cSNJnnZjnWtGAtMRlYNG1bJneMQfIdWuNXy64xLRxRtbDQF+cxFLBZssH+wXrYsAJDPvSGK2+PKpITw0lOKsvNZsiT5cMYZy11NnULT2bj4b8OexJPULFPWyOfFsRDq+92fEQOSNs/iaEekR26EyAkg8G9RJb34svGUCuHwmvHmnfPW65RFw2Wsmq4orzhyy+xHmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:29:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:29:11 +0000
Message-ID: <d4aace53-d48e-4ee6-84ac-7083ccb580d2@siemens.com>
Date: Tue, 16 Dec 2025 09:29:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] fix: ensure separate root
 home dir is recreated after factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
 <20251216082559.327416-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251216082559.327416-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: cb580145-00d0-480c-045f-08de3c7d306e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXhLOUxYNWJ3bjhRc0N6ZHpvVzI1djhHaGFDYnZGblZhM0Z3M25BY0dqSGly?=
 =?utf-8?B?L3gvSitBTThVRXd1ME5WZFpCREdHT0pXMVVxQ3YvWE9iUldmbXVSMk4ydmk3?=
 =?utf-8?B?cTdIa2tYQkw0WFJhcXFscE1RZlFsSUZUYmh4QnZ0Mzhvbm5RR3ZYWnAzd1Nn?=
 =?utf-8?B?d2FTci96QTZMQUVYNWEwMVM2NGNtLzVsMG5MSWIxSlhZdm5HSWhIcHVTM1k1?=
 =?utf-8?B?R0tpamVvUmZpcFk1OEJsaHcremtBQjdta0NJT2hxLzZTVkk5TmU0ZHpqZmpU?=
 =?utf-8?B?TW56STJEVnhPdVIzVkpENThWei9nMEVpSlBYVzN5YWlROWdNYStRcGlTOUxq?=
 =?utf-8?B?eW5XbUxoQ3VpbXZTZHo5QXJnbWNBZGQyem03TTFZUzhqRVorZThIbXZrQ3c4?=
 =?utf-8?B?N2hPZmZ5THY3eklIaStWbHlVS3MrekdaWllrQVlmNFY4bWwyd3RLZUF4ZVl2?=
 =?utf-8?B?ZGRBSXVSeFloZGx4WW1DeDJETkVWNFBDdFNFRVdoc3lpYmRBWEpVc0RmNGJu?=
 =?utf-8?B?Z2tiaFB5KzIrbjFyREE4aVAxVXVDbW1vWE1rOWdNa2FrNHhZbXJaaVZ0MEky?=
 =?utf-8?B?bFkxck9JRjk4RVpqTU9OdXR5QVlwcFZPVzE1VDdRWTIrVU51TTBzSWUrcU5Y?=
 =?utf-8?B?TnZwcGxpVkxVY01JQWM2Y0hvNGZQd0hoL1hndWFzM3hKcW9sMDM0eXVoVHl2?=
 =?utf-8?B?K2hteldkQWtYaSs3WVNwbHdEZHRzQ29uVURLYWVuRXBGWEJBUFRCNjJCRkd6?=
 =?utf-8?B?dHo4L3NBVm5rUWx2QjhLb2twSU9NQ2tkVEhndndvYzdRb1JPblhFUG5Nbk9N?=
 =?utf-8?B?UGZVTXFYZjdKcFk0S1dNNGFWbS9EUTBTSjUwTkh6c3VKT0lENDY0cU9xaWRV?=
 =?utf-8?B?aGNvdmhUTUY2WW5WY0JxZlQ3RHZ6aFphbnM3UWJSSXh3ait1akVPL044c1FZ?=
 =?utf-8?B?UHRJUmZvSmtSeHU2R2hkd0ZpTVZTQ3dBYXl5OEkwOTc3elR3K1JrWUdwRFZq?=
 =?utf-8?B?REZiNk82bnNrWjlPLytFbFZLM29hQkNIL0pPd2YyUTQ1U2FWQlJHZ1laU3F0?=
 =?utf-8?B?UGdWM1hJRzJkKytuem1DR3BoSS83aHRVOER5My91QTlReEwwQ3dUcjlCMTQx?=
 =?utf-8?B?bEJ1dmkydHBBdlFydWd2UnNrdDZiaHRkZzZ1MVpZU0RjN1V5bE0xdmJPdk5o?=
 =?utf-8?B?TXZXd2VuWkFzWlRMT095VnNVWnB1b1JaWENPZmVRVHRvQnJ4TG1pU0pBM1Y0?=
 =?utf-8?B?QlY5R21CYTY3Q1RSdk4wNW9FYWJHY1BwV1VVbXF4djhueUptcVo2WFRvQTVz?=
 =?utf-8?B?cUhwOXN0L3U2TkZVcG83MExJKzFmblQ0ZkRka2ErWlRUbFFidWxQdkRQOXdR?=
 =?utf-8?B?bGdFVWVRZks1TGV1KzUzbWZ6SGk0RkNTRzZOSVREVDJEOWdvV0NHWjRUSVF2?=
 =?utf-8?B?b0x5dkxBdHV1NU5xRk5pdk1Db1VORFNPVFBUcmpVZFI4ZDgzSVFac3d1ZzY2?=
 =?utf-8?B?S3ZsVEVDR0kvY09nM3pKcWZoZVJsaklvcWhldW5Ebyt3TytDVFNRKzkvNGtw?=
 =?utf-8?B?RWU4L0JoUVpmcjdPVk9HVVpoYXM2OFNWQWpVelVhQy9mb0xPTkR1MjBZcHdQ?=
 =?utf-8?B?c3FhYTRSMXRyNEtQT1NQbnFFOStsVDNLTHUrcFpsS3BiOElnMEQ4OEpEeDgv?=
 =?utf-8?B?Rmt1anpFL2FvaTVtQlNRRE4wa2pGUTZhUkU3M0RMenhQOWJlZ1lzSlQyUWJM?=
 =?utf-8?B?eDNLbFNwSTFEWTFCV1FRNGFydWFGWG5iVWJFUWRTOW5SdzZrZTBpR1hBZzJa?=
 =?utf-8?B?RjQybHVyMU5KZndLSWYzV3I5aHVaZDl2SHlqTDAySGpVRGRlNjFTbXIycXN4?=
 =?utf-8?B?U01TNE1jRzluMXZSb3ZweEZtK040QWJTWkhlMTB3UjBEVEYxa2haNVBsbnBz?=
 =?utf-8?Q?rmSFwNL5a8Bm4Ana6y/5MRXLhkYU95IG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUZaQ1BjNkNscTRXMlJoNytuekVQYjUvKzZvZThMbjc1VnhPWVVYcjhKVDZY?=
 =?utf-8?B?bjhSNkNnNThpOXQxRkQ3YVpRNzVHQ3NraGpDRHkwSml6Vktudm93NVJWMTFH?=
 =?utf-8?B?MlVqbW5SbU5oSW0vZmtIRHZ5QkprcktENUN3WjdRR2dLcy9RUEVHRXM1M2Uy?=
 =?utf-8?B?RVdidENVenh2eEVEZ0RUTkVCQTVJMGI0dVNnM1hCSVNkYUFoZ1RhWC9KZ0NW?=
 =?utf-8?B?aXY2RVlxbWtQZmxZdFVRTzY1dkRmTUUwVDlLR3pzWmx1NkJJYlV5bkxOV2FP?=
 =?utf-8?B?eFZDVitDOTBmSmVTa2lWaThnQm9lN2RhbERjNlRIWHNGOFBRN2VCWktmSmNn?=
 =?utf-8?B?dkRlUm10OFZQSEZtYmRZOUFQVEZsQVpGblNVdkxreGl0Ykp2SWh5SU41MUto?=
 =?utf-8?B?WTd5K1VSdWRNQUM3UC9zMEJTV1kwZlBEV0ZjZG5USVJlMGlJWDJyRnV1aWRm?=
 =?utf-8?B?SXFyRXFzeHBSNWFyWSsxRWtzTFFGaXJoM1ZHa2RPZXFla0VrYVJ6bFNKVWZB?=
 =?utf-8?B?NkltZFdrNTA2WnA5aTlqcEh3YVdIYmFkQ01LTW5QdEFRQkZ3Z0h2WlRBWFlG?=
 =?utf-8?B?OENUd2V2d1p4aC9UeHZVK0FzcmZqVDB4eHpNamliaktYMjdvaEtjQjhQK0cv?=
 =?utf-8?B?ZVdMRFpOaitXb1pUcThmMnozZnJxYmtSc2ZXeTg3RnFpbWNub2Z5Wmh4WVg3?=
 =?utf-8?B?djZzLzJuRlJIT0IxM21rZ1cyQnNXTW5lNldGUVVaU3dJYWpBT0x0ekt4TVJq?=
 =?utf-8?B?Q281eHdydWt0T1NsRWJ3Y29VUUhMeDJkRjBZMUxnYzF2WHg1YytrcDBBZlRD?=
 =?utf-8?B?bG01RE9QYlR4bWpxdmVhb0xValo1S2wwS0dxdExKc3FWUTRQTGVFclFXN2Nj?=
 =?utf-8?B?WjNteCtNWjRkWmRSQ3NpMnozVk1GMFM4c2ZScitQdVFzTzB6eTVvaGx5MW9r?=
 =?utf-8?B?UE1pT1hZb21uY3RIVXY5VzZEUzJBd3BZNjYvUzNZZzRkN1MwOXJ3bEpOTzhP?=
 =?utf-8?B?WE1mYTAvVmdBQzI0aVRlTDBBR1hkM0JCQTg5UWdpbmNxenppbzNoZEQwK1Ni?=
 =?utf-8?B?bEQ5NkVqVG1RamVTL0dPVkJBUDNKVml5YVhaMXltUjJvMmZweEpTUTlYZFR1?=
 =?utf-8?B?MVk2Q0ZlclJxWm8reWtyU1NxZEZxdlNLZGFSVWFyMHIxeXdzeC9xdTQyQ1hN?=
 =?utf-8?B?THRrSTdJZE5IZnVLNmV5aXA1MllYTnZtN2R4WWx6RCtGMEdWTXdPczRiTUNl?=
 =?utf-8?B?N1kxSEpkVUhXNElnYmErdGt3ZUREcGNRSG9rOHJVK0t5M0taM010cWU2a2JJ?=
 =?utf-8?B?WDhmL0x6b0JvVVI5OWI0ZitJbUQ3NmVsSnZLTkRJdUFYZFNNOHhGMXVIdllZ?=
 =?utf-8?B?UGMxYVpySkpLL0Ixd2hrVy8xZ0xGalFXM0lUcy9XMjlpcExCY3dFSkN6L1BI?=
 =?utf-8?B?OW1acEtPSXZTQzZ1RlFESmR2VkdPN04ya3F0MTNrdGJ6V2pka3VaMmQ3czF2?=
 =?utf-8?B?Ung5ZlpoOTY3WEYxc1JnSHBlZEt1T2JIUC83RGRkRkE3ZlhjOW16b1JPU3Q4?=
 =?utf-8?B?NmZzVkVPL1QwRzdlZVV6UVJtQTZ2aDVYdkMxalZJbmFPYTdNcy9SbW41ZE1z?=
 =?utf-8?B?Z3IwNk1QdkNzTHRRdU5HQlR4WktWVndGeERuZ3lWd3VheWd4elUzUkFzdXpX?=
 =?utf-8?B?OVpzVitHOTI2dENlN3lTQWQreFEwUVFsbGllR2IyU3RZZFNMTlJDbDlsMURL?=
 =?utf-8?B?eHl5eVNjbUtYa1ZCT2Rwc1VzaG9sSGpiMmtJMnFZaTJOLzVXNDFoSmNrbFlX?=
 =?utf-8?B?QmZ0U2g3c2JGcHRBMnFMNCtUMzBEdEdnSFMyTjZWT0lqT2RYdXltbTNEV3hJ?=
 =?utf-8?B?ODg5dHNvRFdlR3VpcHFDYnozdkZ5RU03OUdwOFBVRWk4UTlrN09OcUxnTUVn?=
 =?utf-8?B?Qmt3Q044RC9CTTl0Q0hOU2pqYVZVWTZxa3VzQUlqOGRkazY5WjQ4RVRCQldU?=
 =?utf-8?B?eEwvckxpc3d6MFI2M1RMay9hSEtGU0kyQVR4c2h0cEJlSlBMOUNKYzBFY05q?=
 =?utf-8?B?a0RqZmZKRXlQelZwcEgyc2N4T0NoUktvaW52b0lTR2dkQU8zQlA2VERvSHBU?=
 =?utf-8?B?aGxuSFNXNkVOTEl4bEpRUE9kWkMwOTYrMVc0VjlxMUo3VGU3LzBJNlBab1Fu?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb580145-00d0-480c-045f-08de3c7d306e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:29:11.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0AztveJgioamVF9NTgJX/YqItGoJjIiAFY0aQQNoLm5otLpmOgVrxPGk0deO3X4ACMRlCrg3/8BA81TcrOEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5637
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:29:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21078

On 16.12.25 09:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the option `separate-home-part` is used the home partition is deleted
> during a factory-reset. To ensure that the root home directory is
> available recreate the directory via tmpfiles.
> 
> Additional user directories need to be addressed the same.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../change-root-homedir_0.1.bb                | 15 -----------
>  .../change-root-homedir_0.2.bb                | 27 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 15 deletions(-)
>  delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> deleted file mode 100644
> index 79c7e67..0000000
> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021-2023
> -#
> -# Authors:
> -#  Henning Schild <henning.schild@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -
> -inherit dpkg-raw
> -
> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> -
> -SRC_URI = "file://postinst"
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> new file mode 100644
> index 0000000..3cd415c
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021-2023

2025 - updated.

> +#
> +# Authors:
> +#  Henning Schild <henning.schild@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> +
> +SRC_URI = "file://postinst"
> +
> +do_prepare_build:append:separate-home-part() {
> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
> +    fi
> +}
> +
> +do_prepare_build:append() {
> +    if [ -f ${WORKDIR}/${BPN}.tmpfiles ]; then
> +        cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/

I'm folding this line into the block above on merge.

> +    fi
> +}

Thanks, whole series applied with these changes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

