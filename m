Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45013C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 17:24:23 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.112])
 by mx.groups.io with SMTP id smtpd.web10.113125.1712597053697136045
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 10:24:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j4eUCo7P;
 spf=pass (domain: siemens.com, ip: 40.107.105.112, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJPXkcPTBdh0ok7oNFoBYxyFZFtuwmJBAxUrRBK+0BooOv5Jlo3p0gIVuNSOIEP/JEpyUlngaJfpP2ROj9pWdAUmZ5lVbXw/2vViu6icme8kORL5kA6dQ6Vo6n6FkSBgcrJiFKfcC+k+l3+0wKmTTlq9D+6RR+uVxFf2ljWv3HBIL4wE4KpwGF1GhxCQtA6x+cJG7BwKtDP0kHIQEgEOvcLYRlNfWHUTjKmGpeam2+HYUq7RZvzA9q+7etFXbykjFqn7OmMkGDSy7KYljs1PPOwdzf0vZFK1HYez48b3481QMJoOxpMEbJBTbgATGDsFXCtfkd+id6X4aUeKygLbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjAMReA7G4kO5BgngpQ2HvAml3bmMAWXZ/jc5DHQrTQ=;
 b=VT6hAWZecaQ/txFzow3SRDNG/UutvnE+XHXq2na1uX/WHEKazlFJaGrotJWfjgWW4FJkIFhH/zI6dwGxmL6QE2j88xIYz89kUeEwuinJnef2SrgLTNLhgjljGJIvX1piW2hpq1maacaGSesUFVV19U7oOnP1dag26ZMhbqPRmcVATsafC9eaobEATpahYl1Xa37IRguY4966KOQz1QHIx21ICfb7U+vawfrB8yb6rZ6fLB4GhD3OVXFrw3LzwiTeUjeG1NxN+IoqG/hZWD3sAKDGqb898LvdWqSKOE/BpVGVmUdyyZha9WQCxkiByFdz3Lirew4mo4AazsoHleZo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjAMReA7G4kO5BgngpQ2HvAml3bmMAWXZ/jc5DHQrTQ=;
 b=j4eUCo7Psb+hRkMGeO/OIKlhIpUM0F2ZcpG50ylTnQIrogQ/ZtY9tecv9BYJvzEiIJD38SqvNS3oDwnMkv2v40HTFx7GZQv52wyDNbGirxTit4JPxvz7mtpAlufdTPNWsly+qDwmC8E4OpW3NPX7vWtI5oBz9Y3PsbhtwWgvjeOfaeyRQm8JyVcwZdTeN+2idT5y1ekk6zUVKgteQsvSWjmX3KyoIKgQe2Ira3jsWtqLqfGh9W5WViun0jXzAwimPk9BSwsOH5Q1XymCotwioZGBS58w0znFpMxOpNeT1FnIc5F98zdZXBmwpWbHAx8CFCOoYrEAcXkV9LDcLv6p+w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Mon, 8 Apr
 2024 17:24:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:24:10 +0000
Message-ID: <2fc12f0a-9a43-46f3-8d03-9ba1b78a4d22@siemens.com>
Date: Mon, 8 Apr 2024 19:24:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] fix(sid): copy immutable dpkg db
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240327141556.542243-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240327141556.542243-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9155:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NrhWmuAiPgprUid80M/yJwrojDV9oRMfLZhBs3OGCnrRubS1xSs7jt/K1JI2nyDs2Mo/+bIi1WPklM0WN0A5xmz1vy+Lxy+qPZZYS6zVtF6VRGK7XgQZQw52AmP3zkydXFmk8dIJA+yoD14YmHtpka135PQhKiBD6uBaruHF9yC7Z4VseqiDwj1OUAWqpWCEWh+AIFQLqPgjSm/tgK2wn0QuuefhpQ572wVZZcwbfVk/7jJ1aaoTaihObFHV06KflVlC/TxBLcCIoAoM+FfQqVZIzBigBK1P3+kua0rm1OjWQxelcTLHidrOc49qQ8VoEE8q1i1T9nn6Ath0qPR5A7R7fmFcH65KlCrdG5FFsnRJLJuDdy8PGl0kVDhAbHhjb8t5YwcLUGLZTdphyd1EnghFTsRMV7Nf0A4wKNcJJqVWVlAO32hswuRwDeOuv0cA1bXArTuKCv9LIktUmm/xPQ6hUuCvG4atsdF0JMYfx/4s5dcQhjom04WUi9AO26Ql2wFNmax733T7oStdVuIn+I5/I4OPkCuwCa8mnxPdcaL18CgfPgJdwIsAvaRYFMgyAMiOL1gAEZKPcEb+5AYfUDcGAiMkd+eb8rXmYfteKjCAp2p+LotgzRJWICleW/EbGryBYQWF352yUqt85JCwjw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2krb1RMdmpycGFxNDRkOG9ZMEdXVHFEV0JlNVJzc2hyQWNtNmJOcnlHYnBn?=
 =?utf-8?B?UXc5OGRjeHVFaWs5TU9QU1FGdGtYRmRMNWMrWElJZFNqTXl0RktnZW45aS8v?=
 =?utf-8?B?Z2YrZW8yQ3pqaUZ0Z01TQnMzeTZuK0NGMmhxeVFiYzBoSzQ3OTZLWGZlT2c3?=
 =?utf-8?B?blFWeFhLeGF4Z0wzQWNodWdVU3dOVE1LTVJxaGFwbXZoNHIvdHpvbGpkeGtR?=
 =?utf-8?B?eWhTbU1uWXp1WkNrVEJwbUlpNHNLcHdPY2tJMUlma2lmU09yd2ltZ3VNRXg5?=
 =?utf-8?B?aTg3d01FWFEwN0xxMTl5emlnNTVNb3ArV2tSM2ltbFlUdm9CcVRTWXhyQWcv?=
 =?utf-8?B?MXpRU2hFbGdBdkI2QTRTRkY0OTBtVHU1VkVVMFFaUGVReDhKUDB1aWRsNTVq?=
 =?utf-8?B?b20yT1RpU3ZTdHMwOUtJdTgwcmZwUWppaXhRbm00UjlMZ0I0YU1oYTZLamFl?=
 =?utf-8?B?L2MzNWc1TTJETHlEaGE2Tk9lbGdhUFBzSE9JOXJTMVNRZklqWDRUSzNwdVYz?=
 =?utf-8?B?M3krR2dsZGR2ZmwxQU16dkJ6NWxwMUxFL2MxUWMwQ3FvNlZzTWp4WDVuZHVL?=
 =?utf-8?B?dmNoWXVmZ0NydG80ZnhjV056VFF6RlpvbUlud09ydzRmaEp5cEJIbFo0cWtX?=
 =?utf-8?B?ZEdiMktOS0t1U1NnNWRrdG9YSzdZVDUzQjdRVmcwRkpIVE84ZkFDU2FuelJM?=
 =?utf-8?B?bmljSjZBZXlvMWt1alN1anpCdzNjaHBZZTU3KzdVYWp2MWVPTWQ5WDA1a1k1?=
 =?utf-8?B?TXVYQS9oa0hYTjR2Yk9aYWVjUlU2SGtrcTNZZ3JzRmt1Q3N5UVl5QjVSaHZZ?=
 =?utf-8?B?TEtwaW5CNmRnS1hGNW5hOGlLSHA3dUx0eUV2cnVwQ1Z4bktQU2VFVCsrRjVr?=
 =?utf-8?B?dWlQR3VIVHlRcGVUL1VON0Yxd21xWG1JVk9lY2wyS3FoV1hkekoyQ1NvNVlR?=
 =?utf-8?B?amt3NmxlNmdmRWxwUDBrQ3ZmdTdCR1V4QzhtTXF6SmhFWTRZcHJzYStBdzk0?=
 =?utf-8?B?Z3FrRmxjRWMrOHZMZE9NQjRwRnhoVXUrZTNmT0dPWVVFa3RVTzVubUl4bXph?=
 =?utf-8?B?THlsVGFBcFF2T3NTTDdlNW14NVpnYy9pSlp1cW1EM1BDeWIyeThzRTY0c055?=
 =?utf-8?B?Zlp5N3F5bmJ3eVM0akV5bGpJaTBSUFNEZFhva0w0TXJreFB3MUxQR0x0bit0?=
 =?utf-8?B?Q3pMU05PMlFuTDhkS3c0d2IzZ0RUeGVrZUVnbmFyd2d0cHZicEVwQkFPcWpP?=
 =?utf-8?B?bVpjRHhwdndIU2lLOW5zYWFlS0ZGWFVmRkdEa1NQcnAyaEVVdURoWHpWakpj?=
 =?utf-8?B?UWxLOXQ2K0tLY1A1UDJiQXRRbmgyNEdqWGdlb2YrSWJhQkI5VzlucCtTZUVK?=
 =?utf-8?B?QjZtWGVkK2R3TnlZREVPMFhUVFhYK2lLWHllUzdkd3QrZlJqSGpjT045bTlt?=
 =?utf-8?B?Ujc2bHBHOXE2ZjhYSWpIbEtvNlBBMGtiS0lWNFcyZHAwbVhwaDlPbDkxU3Vt?=
 =?utf-8?B?ejA3MEtRNEdGcXpxRjZ3T2VmTmdFYXR6NXA0Qkl6bTBhcmFHeUFFZ1liZUw3?=
 =?utf-8?B?WWtheU5OT3B4cDV1dlNOdUw4M1BqL2p5TTNBdkZwQ1NPaVREanZNbE5HanNR?=
 =?utf-8?B?bXNYdlZWVUtZS2U0MTQxeGlZMzdiQjlPYlcxWk5HRVlSbHc0b3cxdlJkUXFn?=
 =?utf-8?B?VmZZb3Z5cTYzbXptV0ozZzZpQ1NxZnJhTm5udVlCSVV1R2cvVVg3Y0NQNSsx?=
 =?utf-8?B?N25mV3FkVStwQ3NmRnFtM1pKc2N4NDRJYmdhNmJKNksrVGpMcUhPb0Rqbkpi?=
 =?utf-8?B?NjdISElDajgxNmJhQ3NoOGo4dmJyTWg2K3JNWS9tNnN5T2FyczBrWFRVMzhT?=
 =?utf-8?B?R2hQL2NtZnN0b1YvV1BQZ09Yck5CVTlnU0pZeXV0cFVPTjZsL3NRUUxnaUxy?=
 =?utf-8?B?VVd0WU5aVnliV0ZTK2NKNC9tZmRUTzNUYlRJVXk2MUgwdXk3NS9Mb3I5alRu?=
 =?utf-8?B?a0t3K3o1UkN4K0lFWXBmdE5TdFc4RGFjWkIvVDhiUHcxNEt3dGc1Nk8wSWs4?=
 =?utf-8?B?RmdzRjNxZEd3MkNUaXhzekQ2bXhTUy9OM29DN1ltUWh1cm9wQTBKZ00yMC9O?=
 =?utf-8?B?TWlhQzRYcHF4c3QxeHBOU2JDWkgyQ3AreFgwUEs4R0RTMStVM1BWdUV1N0p0?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7d7d6e-2cce-4cc5-e508-08dc57f0b3db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:24:10.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTRFKAiLpZ0kCHKzGZueio2rZD+NZ9vL8yd1RO6Y4wtiNkKsaj9YeX4+NTqICrSS4/U5qW1EPCW4ow8URyyqhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 17:24:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15505

On 27.03.24 15:15, Felix Moessbauer wrote:
> The immutable copy of the dpkg db is not supported on pre-bookworm.
> However, the logic only made it available on bookworm but not on any
> later release.
> 
> This patch fixes this by inverting the logic: We always enable it and
> just exclude buster and bullseye.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index bb8ab9a..fa56b2e 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -18,9 +18,13 @@ IMAGE_INSTALL += "home-fs"
>  IMAGE_INSTALL += "tmp-fs"
>  
>  # For pre bookworm images, empty /var is not usable
> -IMAGE_INSTALL:append:bookworm = " immutable-rootfs"
> +IMAGE_INSTALL:append = " immutable-rootfs"
> +IMAGE_INSTALL:remove:buster = " immutable-rootfs"
> +IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
>  
> -ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
> +ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
>  copy_dpkg_state() {
>      IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
>      sudo mkdir -p "$IMMUTABLE_VAR_LIB"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


