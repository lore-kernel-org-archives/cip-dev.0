Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A1E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 08:04:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web10.5715.1733904267673842913
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 00:04:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XHXImC9H;
 spf=pass (domain: siemens.com, ip: 40.107.22.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/z2H6GUME6qpPmkULWwOchwfRMR3R5IUTw5QPyOJN11ErQBeQRp3eUFH9+UQMJ8SJKRz/o3tot1xLpvLmDS18IjnFpNtPOWbNuwK/eCuMl6AJbUQVjTYxpmHl1Y8BTJRrz+RIi1HBJIlw6x/QNZU2pLmT9PlyIZewjOk5n3jgYstTwb5i7DfSQ+1DPh+rjLPpZRuxlueDXfB81v/wMPX4ZG/Elh9NhhAoJkBSkloWN0qPrpiZ0cxaOxzyPq4zMWjGkbE0IEZB92+P982JGApyIEfYg0ixnZhHy7E7KRTO45uvVt0Zngz5tW6vidSzhPMqkLN1DAFaQGatRawxc67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH8hSMuBO+BJMMZcbgUCA4y9FK0aJBbjeY/tF1kwEsk=;
 b=YBG1gYdK1TSTDg2io+OXiqCD0VbKN3ZWPy3SVfBhuSqDAKHvq87cotQKoNVDyfbvk9CDgczAtRzXdiZzO0gf1oRHv6XwjVAW+zKkTOboQfBIA452v9bVO2gc1Vr/tVzzE2t1bTpIQnj1QEMc0B8Q0xUruo+DM2BArEwgIY5x+CmKoeId18MHiDRB1iC1HSBYch4oWegjiDu3N//wOrU3n8FBpDosYp09wNJ3/GloG3JjFGC1LYASwTffVOGIpQdNx7c4VzArdkCu+2jIyiDn4ORfwHvRTB1pvlYVXyX8PorFRrCtL9izbSZ5PLiufVfWIEPHyxRT0knxLbD0j8z9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH8hSMuBO+BJMMZcbgUCA4y9FK0aJBbjeY/tF1kwEsk=;
 b=XHXImC9H6EopcxKJFKIU3Dkc0znmix+K7hrPP1+KCTUqTBt5aIEbjKK9fjGJtmVi+A6ZcLwNGgPdnrAEblcn9Q/r8kKhe0lKwYmkPhBny7tzHKBHD5uNsQpzeNWEJfiJwoOLxItH9pJb3oLBwMEGnXfy3x1oEVG+OSXqcweNbnDv7HlYwWeS/eK+H73MoqfAIVL7on3FpAKOYuFuo3Ft5zcD8N3JwXP+HyWVkHFIrG+j9uIGaFTjyicAON6U74lYN2XEKqm2cOCJvT4yDdZDHXTrn5D3IeX5mM1Sje2+81jsugm2+vzFIKZgqm9yUK8haLDU0pFleG/NUN7wNxkKKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:619::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Wed, 11 Dec
 2024 08:04:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 08:04:24 +0000
Message-ID: <57b01627-060b-4669-8303-a1de7b59473a@siemens.com>
Date: Wed, 11 Dec 2024 09:04:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] define RO_ROOTFS_TYPE before using
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241210154546.2670554-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241210154546.2670554-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d36a815-d4c1-4b19-0eea-08dd19ba6d25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejYwZ3luSWdqdDFlMzhFSzlYVFFlREZYOWNsbnUxK1p1MzBLaUhMQUtkWHhy?=
 =?utf-8?B?V3ZQK1BLOS9ORGZUTWRnbVNLRmxEdXlncDZqaXdrTHU3b1hqdVJOOTlQTVlW?=
 =?utf-8?B?bUJHNUdNRko0R2xuOTgzTVN6azduRzdkSTdPcHZHRjRUbjNlc09xMkFCZTNn?=
 =?utf-8?B?YU0ybkdrcDVpeWlmWFBWcDkwRGNjaEM3MHRwWWNhbFhiS29ZN0FwTW5wVlJn?=
 =?utf-8?B?TzlUYUFLbmlmN2tzaGN0UFVZcHdBcW92RUtOZnJ5N3ZkL3NkUUVFZFlDT1ov?=
 =?utf-8?B?dW9mWUExRXBvbUl5R3RnNUhnK1pDV0M3aVBzNG1ubUYwdjZwbHRrOUhBMlVE?=
 =?utf-8?B?Rlg4N1JCWGJha3U0VmFUbXBiWWsrZHdTck1DQm5PTDNkY2EvL1B0STBxVHFW?=
 =?utf-8?B?eDB4Q3lPN0ZlQUtYa09DaWdWcVJFRUZRMjQyRk5MaE1GNFBoa0N4YUxpTzAx?=
 =?utf-8?B?Tlh4UWpCQXRGZzd5ZVBSeExZYXBqeGl1QnJ6RkRNZ0krVUlzWFV1VlRmVURM?=
 =?utf-8?B?RmdpRXVobDVtLytjQkEzMFFVY3g5RVVFQldFcG4rSERZaTF4WElXRU5HMk1C?=
 =?utf-8?B?ZGZUR3BqU1ovVzNSUVl3c24vdlZ2SDB2M3ZEbllldFBEN1FEOUVvSjhsOUVo?=
 =?utf-8?B?ZVBlUk5OZTNVaHVsVXlZTEdXbVhUYVhUWnZ5QyszYlVpUUxjaDYxenB6MGl1?=
 =?utf-8?B?bUJwUzlhaTFkVlB5c2NhYWVLclFRaGtVWi9VUXhIcjBWd2xJM3JadU9XM3Jh?=
 =?utf-8?B?WWdoU0l0a3BseGl1ZnZKR2VCdk0vL2dGZU1CYjFCbEZaL1JjS3ZLempDV3Ay?=
 =?utf-8?B?SW1jTTVpbzZCYVBlOGIxTjNldko5bFlJUjNja3FWUWc3eDBJTzR1T21zc0Ir?=
 =?utf-8?B?OFRRTERZeWdNM0ptcTNuZmRRbmwwa1ZqeVF5UkU0Nmk2SnJydEcrOVlkR2RN?=
 =?utf-8?B?U01VUUd3KzRQUWg4YTlkNTF1VGQ5d2xmc21YdUxucUY1K1Z0RlNjalE1ZUlJ?=
 =?utf-8?B?RGFncGFSbEJ2TW5hT3RwM0NPcXZnM2IzNFBDU2w0OGFNOUJaYUZyakhTYWh5?=
 =?utf-8?B?bEpwV215UzY0cGQ1cGRKakw2alhKMjFyUkxINnUyV00yQ1FZYVdKeWNLVEFz?=
 =?utf-8?B?ZUxWcy9LZWVDQ3JXRTF5UHpWcWxQK0NPbmg1NEFydGkyNUZLNHN5OVR6aDRT?=
 =?utf-8?B?WHZmcWh6YlNWNGNkR0JOeVR0Y0UrU2Z5dDViRGMxV2c3OE9WV2NQTlBhc0dK?=
 =?utf-8?B?NTNlSXB2NDNEUXZKTndmNkUwT251WmQvNTFxSnM5dVhUSFlWWWZmdUpYZy9W?=
 =?utf-8?B?bUdMWVN3L2lEUnVmTWw3dUlnUnJudW5VTlZNbU4vbnNJM1NXMUUwanB5OVAv?=
 =?utf-8?B?ZHpPaTlaM3FSREVVT3JNZGRaVG9KajhFdSswUGVNamUzZFFPYzZMU1JWZk5M?=
 =?utf-8?B?dGIrQkxZZUZmQzJMOTBKdWJ5TlQwbmZaOGpNUVZuQ290ejZ0WnpqakVGVS9F?=
 =?utf-8?B?RlhPN2dKemx1MHRQYUdsV0NBYzUvRmFLK3N5cUpvZHUraVdtMVJLdTVFZ0dI?=
 =?utf-8?B?Ni9FNk90Q21GQ3RBRUhrTENhaXZqWlNFa3pLeHprTVQ5Wm1GdmFrdDBuUmZ6?=
 =?utf-8?B?RitoZi92eUI0VHNvUlE0MGVVUEdJbVl3V1lmVnFYR0RUUFdiNytvNVdrL2Mv?=
 =?utf-8?B?aTNLUTdzaGVqTXhuRElvbDc4MEdrTVBJNFJydmhJWk5GdEpkbnBzaStWYkQv?=
 =?utf-8?B?dUExOEt4MUdpRUIzN0JaRkxmQ2YzeWVuYTJFSHdaMEdrYkplZDdjcU5ob3Ev?=
 =?utf-8?B?RHNrWExCeVFrUktIamR6QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTNPMGtqSzZaZjhBbElSNUh6T0w1ZzcyakFMcURLRnZBR21qeHg2bXJUTGRH?=
 =?utf-8?B?OXhpK1FiUXhJcGcxN28rWEhtNG56NERhV2Z5K21yZHo2RjNBVCtsOGVEUjNH?=
 =?utf-8?B?VS9IWW9EMWZKZEUrQjdTaXgrY2dJNGxOUHF6QVJ5bE82T3lCQXJ2OUxmam1T?=
 =?utf-8?B?ZnliT3FJM0I4YWJydmp4SzBBQXlXbDltQ1pjYjBNUE5HWkhXckFRV1NwUjNo?=
 =?utf-8?B?dDYzL2djYmdickxFbjVzTFIwczlTU1NFekJSQ3ovYXd3Ui9sTlhtWGF2UmhX?=
 =?utf-8?B?eTh3ZS9QeUU3TnRyNjhnakxXUTd4LzVwSEsyMGdJQXRaQ2lNd0NLWmZ2Vldr?=
 =?utf-8?B?TzNhS0pRSzBBYThuUlpmb1BCSUI2Nk5QdXFDUmZ3NElSa01oRjFIOGk3YlRp?=
 =?utf-8?B?OWRydEw5SWsyTSttdkE5ckwrL0V1WFA2V3hnTE5HRUtYOURxN2hYL09hVGM0?=
 =?utf-8?B?VUN3b2x1elJIVGRTU050S2dCRzU5Z3VXZ1lxek5SNTAwbjdIZWZaeXUvM2Zy?=
 =?utf-8?B?RGVkeVhrTVJ4Vy9KWlIwN3lLbkZ3SXIzQ1hmQk9KcmZTRTNOWndtK1hGQ29C?=
 =?utf-8?B?SXF4MVptSUw3Q2ZFR2g1cVdFWUpFdWk4bFJtT0o4U3o5aE92NWJQb3UvSmh5?=
 =?utf-8?B?TjBxdmxvbGJlbjBHS2M3M3B5ZEs2VXRlajJiMHJ2NjRGR0U3K0JOOEIxTzht?=
 =?utf-8?B?aThxUmlWYTFLbkJPaUpnaHpHNm9ldE5MVUZzdndxM3BzTCtob2xzdENaZ2lj?=
 =?utf-8?B?VEF5WjRqQ3BYckxVOGFNV2FDaGtJejkvemMvV0VOcktZdTNCUnJHR0lIZ1Zm?=
 =?utf-8?B?WVlJRlRGeVdWV091NGkrenBmNmlYVUtLd3FxRXkzTXdKajdBekxTTHF0VEVz?=
 =?utf-8?B?cVJ4TnpCd2dkdEZiQzNUcnd2Uy9PaEloajVVSkx3V2JCc21UdkM3by9URU9a?=
 =?utf-8?B?MWd1SmZpUUEzRlV2UVVWNFNrSlMxQk15L0hRbHA1ekFDczVpdGIyL1dNMmQ2?=
 =?utf-8?B?M0E5dURTNmFlenQzdHhuRlRURVpHRmdBMkVoNm9hSmpLSWZyWHlzMDRYTE1a?=
 =?utf-8?B?U0RtNWtWQUp0T1NRMUtXTEt6T0NpUCtETVJ6bWI5aTN3NS94WWVMMVFkZUFC?=
 =?utf-8?B?b1VUeUlKSExjbDlLUi9xKzFkbUovOGZQSUpuTjdLa3hBOG8xRk5DaVY4Z1Zw?=
 =?utf-8?B?QmpHRTN5Z3ozYy9BRTlUU280TndmZUFxSDluY0xOVFNjWllhZHQ4OFNTRlhV?=
 =?utf-8?B?RGpscERzRUFwenhtTWw3Y3JXYzdGbWFDdDVndUJ1S2RDZ2Q2ZHNhbVR5bERY?=
 =?utf-8?B?YjVBbTBmNnlCNWJuQlNFLzAwZFJIWHUzWHdVSzB1enkwa2NGc0wvSVdFWVVL?=
 =?utf-8?B?UDVhSHhBY0tuSHJ3U3hmSzVKWDlIMTAxaWptaGg2aFpWWW1WUzhFUlNjd0I2?=
 =?utf-8?B?RS9oSDEzaWJmcUVNVFFLUHpYS213V3Z2MVhPY3JTcndXbGNlc1paVU1UbjVr?=
 =?utf-8?B?ZVVoVlJPVGpsRlhTVmxBT2x4MGh2bzdGRnhyMVlkSjdaaVlmcnRNWGlQMmtI?=
 =?utf-8?B?TzRyYkRWUTZiVDRFMW1kaTZkWW9IOWlxVGJnMWtVUm95dTVHY0d4YXJzSUEy?=
 =?utf-8?B?WkEzRGN6c1NCR3U5MTFqNDdaT3pMcTFDNHdjNFJwZkhuL0FJbldFVFF5QzdT?=
 =?utf-8?B?SUFuZ1pFcEFOZE9BK0IyM0ZTdnd1YnhJTWwrNXJnMDZJNTE5b1N6TUxJUitT?=
 =?utf-8?B?TlBTWStmK1pTU0R3ZVlkNWNydUw2enJkUU9KMDBMSUdYKzNYbXdxZTNad3Vj?=
 =?utf-8?B?aXlxWlFYL09WUm93SHFwWlZNdG1UelRQVXkzSG1PK0FabFNlTmVaTFlsVmdw?=
 =?utf-8?B?NG9qRUkySmtnTmJ0SDF1WjVERVN1UnVCMkFRaUhYUUdaaGx1RU9ub1VMck5m?=
 =?utf-8?B?Z3p0dEQ0a2t4RXBHNEZNZkVOdFVrbUxqNThmdlc5dnFhbVVncVlFUC9ISkx5?=
 =?utf-8?B?K0t3ZTIybmdMb3ZEblhDMzgrNGUxZHJSNDdJbHpaZ0cyQWlBeTZVNm9qT0pW?=
 =?utf-8?B?QzZCS1U5Q3MzRDhYNGxJTWE2eGpCREg1VENzVGNpZGxwTDNjam9NbVE2UXkr?=
 =?utf-8?Q?CSiLjL6W0IeEL920CBMr54qOn?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d36a815-d4c1-4b19-0eea-08dd19ba6d25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:04:24.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9EoVMhjK1PM/75qFNI2hwr9Y+XFGJt4FX24kPyMJZOUsEkJa9iLhjL8mUB5JgzOm+I54qQdJuXzX4aMOs24JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 08:04:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17396

On 10.12.24 16:45, Felix Moessbauer wrote:
> When including isar-cip-core in another layer and not using the cip-core
> distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
> errors.
> 
> We now provide a weak default in the verity and squashfs recipes to not
> break the parsing in downstream layers.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass | 1 +
>  classes/verity.bbclass   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 5bf021a..3243f67 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -12,6 +12,7 @@
>  
>  inherit template
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 231d172..c3b89ec 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -12,6 +12,7 @@
>  IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
>  IMAGER_INSTALL:verity += "cryptsetup"
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
>  VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
>  VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"

Please drop the default from conf/distro/cip-core-common.inc then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

