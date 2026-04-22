Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C9F94CDB
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 07:00:30 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73302.1776841229058307770
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 00:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AbRWODCq;
 spf=pass (domain: siemens.com, ip: 52.101.66.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxiCk8iNU0CwbKgYbBeRNJSMuegpTd04L+vvAmK+JubfZouAfR7Dfgva3l1l0jrmCqNHiJFD/J+E39TJIXhQbrKJmfTkkSqfvPHlpv/GUq7NWegKCZlxmRu9zC8yKdwhRynzj+ltAhnVod0QGLbC+Gp0VlndIydr6ecfPOQyvN3iZO7UFEA3Gk6KNFdb5xW67cYX4iK9RYZGaYcJT56BYCDSCRIVhgcObfUYAlxWq3thCVTjNMSoBA3TByAccUEZE/0WyFd3Q54joBtcRfjlpxMas9BGLX3OkAf3u425v0jXmrjHqLKcZU1oQdETHJqQYbf99Mplq5CxgYnm+Jr6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1aNWcbfsR2Y+OkiGGEaWhfAVWJaLfg8bqICBLHk1Pc=;
 b=UYvLOoiY7wTTfpIJy0y93Z9cM090+XjxDi3MVsBgEX1iYz0PZ68Ov75bX+XOVngqsLfamaSrwU79GF4NZCyspPrWBFoBu77IBQw59K8KIxdcmNuPA77dQuWfToAEpuXpNatI8EwZE7Wkp3TAldCASIe5LL0l3GpiRZPM2iPFQNkUlNBhcy3Gb9R1a05NvV5lWyiUSDoMPmi5eejQnGCktZ9w7CZq+r1d2Mq7mC5vphSvrRMIBrsVPftLI2h6J7AmkWrBQAmLeKmg6bthCiqviH1HDiCDEptFsWhNk+xJfXrnFERN4H0FjZYDvqahQkB0z43g4kFMMlPwCJTqI5lRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1aNWcbfsR2Y+OkiGGEaWhfAVWJaLfg8bqICBLHk1Pc=;
 b=AbRWODCqktxzzXq4vmAY5T+hkNIN8a2l9Zzza8ehwY9Zkp7i/dp+qG52UzNmwrmmru0UkRhflz48og7ZtGbYUPAk/5NZFDHELK+p1EUA1BWs1EBMI2rt6fabmbhaKzKjAtiSiy0k3pW153/gDLfr8A398h8zPLgjySLV/+gmtZsK+erImc5siL31z2J/7JfwgYl0Z6VY5LDaQgq5Rh+bgRqRhhoWIuG29C3jrpH9VVx6jW+HMg0JPj3NYZUZoaVQPiWOoOcOHeX+/S7DPvDhocbExwLTdU5WlZPb5dJwm3GhDvhWaC4qagqDo/8QJ1tHUZwyFU7kvrd/teOkd1ZcVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 07:00:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 07:00:23 +0000
Message-ID: <592bd680-8f40-4933-9bba-0142386ff0af@siemens.com>
Date: Wed, 22 Apr 2026 09:00:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] tpm2_functions: verify PCR bank output
 instead of relying on quiet mode
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
References: <20260421121344.3747040-1-sari.sercan@siemens.com>
 <a610ab8a-dfb5-471f-b7e6-57638fff52e0@siemens.com>
 <1534696.1776840328665594382@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1534696.1776840328665594382@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cee66f-d49e-4eef-1500-08dea03cd285
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	UVWyLbTDYhff2KpndXsWKP5uuxxvgicEcyKxYmMdoA7l7zmi90omd+PNbnYs2RAOprp4QNOk/ZgP2BYgDcesibS60lajASRdWGOUEy3nO9A+KiDvoOZq9ZY4feb6R7bZZPQuGDKfmIj9SWjcE5F5J7Pt3qH+GpiFvmtmDjeMuxohI5HdE+r3bwGMT98JxBeP5XCQKhIw+12eFVEgpvgUpULIKfrMSyTLNtYWuMU6g/ai703wMdj65z3Pmbv+JDi3ql74ege8yFKKIEyqEUhZZEp9+4Wjf0npRx+veeKjG2Dq1fxSqGIld2tJFBSadPVjGxMgm3WePftr7bwUQfYiN6t7Mnx3pHvFBjDWBF2Ne6NV0VdW0L+Y0t1GIOZF7HgpxnyBnaE1LthNG0CXc9szUB0hbi1AOwOZe/J08UhYfEHFIkQH4YJ4y7SQAlHkb+a9pLjO/VecqQ35dX6NT1scTJABQmwluH5wr3Xsa0G6IOswl/GSteknv9pOS7l7Rlqx41xIXnqT6+9pO8EPvwLYQPPyZkJiz4RzdnAYO66Nwh9R7sessdK/jNvc9S1iCDrnb/qoJxoPuEURgstGXD0pnOPMsnQBbxVIdcFGStxpq/Yu5azTioclO2KhF0AdP1pUDQ0rovclntFKGmM2rXqqjhwOKRR3oUTimYEU0qzdXuIvxOFTkOmpOSIK6k/cztQMiqUpo4Jx4xioET8OtYO7Hbhgo0vaZG+Dx07WYoW6mck=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elBqaGt2V3RONzFUUVQ4T1NyaWU3VjEvOXluVXdGNmxDK2c1RFZpYStRRXhV?=
 =?utf-8?B?YnhBSWdtMktWQTNremk3YnJUYzRmVzJDUDgveFVCZ3lybGg1dFMwMmV6Ukty?=
 =?utf-8?B?UjAybWUwbWFPY053QWxaUEFFcmQ1bEFzbWYzNkpYU3dFcFRyYUg4dDFJUTM2?=
 =?utf-8?B?QStEU2xjWk5aNVJJbCsyTGtRUzBLL0JwSi9LbXVIcEhoWVVPOEFuNkVNejVF?=
 =?utf-8?B?OHAzVDc3V3N1Z3FubWdyYVo5NXlCMy9HT3BJMjdhUlBORDVTTXZJWGdrSUFF?=
 =?utf-8?B?WmZ6a1A3U1lEZ2VYdSt6Z3ZqUGYvdi92Rk5lci9GOG40Vmk5SnNGRkhndW5m?=
 =?utf-8?B?NUpPNi9uNldEdmRzZ0VLREJWSXZ4M1BwNXdzKzFyY0IwcEg1Vko3KytoSG5X?=
 =?utf-8?B?Q3FTd2p4L0c4dTVCdDJza01JTVRwVHMrMHc5d0UyY0dQY0E2b09kUkR5L1BN?=
 =?utf-8?B?VGxMTlhuTTBsSEsrOGtFVFN6M1l3TS82TVVIYkVoS2NsZ0xqQmpqejBGSzBC?=
 =?utf-8?B?Q2QzaFVDTjZxc0lGbnYwKzBFWFB5MzAwQnpreDFxcVRGdXI0Zmt0NGYvNnBl?=
 =?utf-8?B?dHhGM3ZHb2lsUHp5WDdYWFZvNVB4Zno0Vzd1ZUl5ZmpZbVMxVmdHSUJ3OXNL?=
 =?utf-8?B?bVBjcHY3R0J0T1RZb0VIUGdZSUdxVFR1TllVbUtMTVM3bk1TcnFFYmd0bG5P?=
 =?utf-8?B?aDBxbThxSC9DVWpvaXIzWk9VdnQ0RlR1ZGpCNWRmL2dKR0FUY2NBaTdjdisr?=
 =?utf-8?B?U2x5YXIwY2M4QnRQOFRCQjF1aUU4cGtYUDN2ZHJWaWd2K2UzeEpaaXZjWUd3?=
 =?utf-8?B?LzdTL2pxV3dsNUdLSnZzZ3llZVoxeXJLNmwxRnluV2NjZ1dCRWEwZU5EY2lx?=
 =?utf-8?B?SlFKS2cvYmNzMTNWTUFRMlo1WDhEcVI5ZG9BNkdJVTFQdWNQQjF1YjRWK2FV?=
 =?utf-8?B?VGJJQ2lDanI0TDdyeWZqZlc4eVRFdjZYQ0piSkZSYlAvaERnckdkaHdZR09p?=
 =?utf-8?B?NVlONi9XWVZ3V2taeERHQW5PVEh1VEVTVk9Mc0pOdkJUN1Z0NEhERXBXTnla?=
 =?utf-8?B?QTRIUkZpNDg4c01OTVcrbzArcTVTRlRJazJYWktwellIaEZxNnZnRWpUcWU1?=
 =?utf-8?B?YlFoUkZVYWEzbk5pTnZBaEhIdGFOSSswWmxNRXo4RzJMcFVKdFFOQWFja0NO?=
 =?utf-8?B?T2txNkZndEZ4OW82TlFqZzZjdFVVYU0rZHZrcGROZ0QvMEJxWHlnQ0hLcDdz?=
 =?utf-8?B?TDI1TEFIWmVPdXNVaXcwbmFDUzlTR0I1MXU0amF1dko0Z0lGMVdBdTNodEZS?=
 =?utf-8?B?L2pvejlyekJsV0NTbW8zbXhIMFNmcUN3eU5uRUhWMkFLK09BeFhyZ3UvTVJU?=
 =?utf-8?B?YTZXcTNJTDN4am5MdzFVV3pmTStxYUd1cG5mRWpsejA0WmVIdHg3NVlkRzJT?=
 =?utf-8?B?YXJmVjVxeW5JOW4wLzBSN0gzY3oxU2NsRzkxN1pCQXd6TDMzajNlSEhEb3lv?=
 =?utf-8?B?a01YVFRPa1hLYUxYQzNwaW85WW5IdDlVN1d2bUFXZWRUR1RlMEdWMk0yNlNJ?=
 =?utf-8?B?S1pjUkZLN0RYQVduZ2hCTkh3VHppRS93SEhPTFVhZjdUejFUaXd3Qmt5QWds?=
 =?utf-8?B?ZXVvMUZTUURGUDc5WSt2dmdnakZES0Z1VTNONXpnMzB1V2FteFpDTmZLWkFY?=
 =?utf-8?B?cVVkdzdZZXI4UEMveG9KL1ExYlRzU2ZxL2VUQ3QvZnh6T0FJem53WHNXQUYy?=
 =?utf-8?B?K3ZpZk9KZ3IzQU1ETlExODBTT0FqNEtYTmpiSVVKNUVRcy8wMUVhTXdxSE9v?=
 =?utf-8?B?bEh0dnJEaG5adkNUczRQUnd1dnpwc0tqVUJ2Nk5wQlFKdnVxOWV2M3ZmM2Vy?=
 =?utf-8?B?ZGVDdUVwdWlraUdaY1pWT21jT2pqSlBtZ2sxcHRGSFdJRlRyc1cwQ2g2MURH?=
 =?utf-8?B?MHFTcm9pczBVckJ5SWZhamxacUJyQklsZW1hRThFUGZsdW11aUluaVpVcDlF?=
 =?utf-8?B?aWZoakw3bVJXdXZZdDFDYTV6MGVwNlZPUXZKU3hSUG12YjdBb1FJenNaV21N?=
 =?utf-8?B?V09RdTAyakYvYXpWMTZoQ0U5Q243cFJ0MC9lWktIamVBbEZEa2dSby9kTTRt?=
 =?utf-8?B?VnNkYVFOK2ErYmZFN2prVUF6Mm1QYU5GNDZnMG5tWUZTTHF2NEliMjNSNlht?=
 =?utf-8?B?RWl0Tm1pK1lSS1BzRUxNZ2pGQzdPNFJJOHVhRjFaanJUWUdWVDJoM2lsaVFv?=
 =?utf-8?B?dWFNaUZsWEUzTCtKcm0zMFM2dlBETmJYS2x4RU9tV1R5eXdXZitQREF5a1ZG?=
 =?utf-8?B?WnYzcUVHcWNETnkxSktTeTFDZ3RDMlJrQ2FXUTQ5ZjNoeDJwcSsyQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cee66f-d49e-4eef-1500-08dea03cd285
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:00:22.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXhgNDmyxQpupo/9zVGOtUn+p4E/Y5QnJqAoEf2Su6CrVrwzqYsJ4jn54dlSiwrYQD5wrPRyhWs67iiBMLBErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 07:00:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22782

On 22.04.26 08:45, Sercan Sari wrote:
> On Tue, Apr 21, 2026 at 04:27 PM, Jan Kiszka wrote:
> 
>     On 21.04.26 14:13, Sercan Sari wrote:
> 
>         tpm2_pcrread --quiet can return 0 when the configured PCR bank
>         is not usable on the device. This causes tpm2_check_device()
>         to incorrectly select the TPM device, encryption failures
>         when encryption is optional.
> 
>         remove --quiet and verify actual PCR data is present in the output
>         via grep. If the bank is not available, the device is correctly
>         skipped and optional encryption exits gracefully.
> 
>         Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>         ---
>         recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 3 ++-
>         1 file changed, 2 insertions(+), 1 deletion(-)
> 
>         diff --git a/recipes-initramfs/initramfs-crypt-hook/files/
>         tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/
>         tpm2_functions
>         index 54d43f3..1c6bbff 100644
>         --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>         +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>         @@ -11,7 +11,8 @@
>         # SPDX-License-Identifier: MIT
> 
>         tpm2_check_device() {
>         - tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet
>         2>/dev/null &&
>         + tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
>         + | grep -qv "$pcr_bank_hash_type" &&
>         tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/
>         dev/null
>         }
> 
>     Hmm, nasty. Is this unexpected behaviour of the tpm-tools limited to
>     specific versions of it? Did you report an issue upstream about this?
> 
>     Jan
> 
> This seems like a design choice. tpm2_pcrread reads and returns the
> TPM's response.
> It does not consider the functionality of the bank depending on its
> digest. It'd be more of a feature request but seems worth to give a shot.

Got it. Too bad. But even if we get the feature upstream, we need this
for the current versions.

Thanks, merged.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

