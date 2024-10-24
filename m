Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8893FCE8E93
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 16:36:32 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.51])
 by mx.groups.io with SMTP id smtpd.web10.970.1729787791426829018
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 09:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DNYmTqK3;
 spf=pass (domain: siemens.com, ip: 40.107.241.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpH7GqkyzOlEbmVygRzsq7AVfAqFfoEpGGNbfjk8rz9ixt6Z6RmdVeKCBXxEfMGoVhUNvWDQKUvmWr/JKFRYWdr2UogTu+hhdB/hF+HBGAeL5k+oOC2kaqj85489slqv6k3GQflZcY1wGVQxvRygma5a71FUa/2Jg55duCmKgeXqYDNK7wQ2BY2gEgZm69eols9p2BOO7TGz7jyV/3mZCaOTMtmfUbTlAmikeGlObyIfjFlP0w04HE8UkYgz+ASgor6A60UjSQ0EdJOSn+IM+RAGKmBk4OSzycUnY7vMYLGBqZyeo9jYs79L3e/z1d+QQKRPZXlRlMOHXmAHvy8yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP8zsz24x0CiZtEoNmm0vu9xCexmaSb3R20oV6cAmwI=;
 b=PpimnqtsXH+nJtDeHc7hUBWFAschXGjf07IqTtUo0PkLqzUrTQ7s5sguVFaawEuqECOpP7vPIJoKbyLc6iH3WWGXl3EZqbjRDyLbKyYSrTUC4oLxWbks5jiKQqJmRkoIAuJj70+l5oqdR6PBUzHX8oJ3F01TViB8JLN17HT9cudugHSaD/dLBuXnGE4JATh/xEwzCcODF85eAElh/KN/T7dfKWYqObS71YPhl8C+EZ50PaSEpIsdAdoJAXmbLC7zuKcWytyqfyUaq7nJ9L6SgUXTxCJC7RJ243uhRGgGVi89zVrLow167Wm02yt7qfFenXK+ximRCEl1GdgF/V0E2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP8zsz24x0CiZtEoNmm0vu9xCexmaSb3R20oV6cAmwI=;
 b=DNYmTqK3E5uK/nWJnWjhHnYoxWlhpBozrvKVcF8/A0mTVal55IlQfsWZXS7IKVx5W0WewK//HRaKdqP8XvfkM1wU42h9HtZfyzbKv1Bfn3+ikV04iZDCCBEHcakfUxZf0mTK2QwrZuwxzG1u6H1+RrEBIG/qJrCmCN3NDJvn2KjdJs2ldDVFifbh7ry6X+bpruGkOSJgMiYBjA2Nq/pPEsYG5+cq1XeZol7rzWdpXMydTNiE00awRlOGr2bSn8aPyr65up3W4HOjce8LlA2G/VplfW9/cHZYbOtScdjrlzGCSP4uPGCIByiupLEgSdjP26WG+lhhVt67rBjOUBJJ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 16:36:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:36:27 +0000
Message-ID: <ed0a42f6-2b00-4bc0-b04c-5a7e5ffcbe98@siemens.com>
Date: Thu, 24 Oct 2024 18:36:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] efibootguard-boot.py: Add
 option to build without initrd
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241024154313.2597583-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241024154313.2597583-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ab0081-6af2-4edd-0805-08dcf44a01f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NE9VK2NEZVNDblhsYjJtUlZCYXkxS3JnVmd2eEF0b05hRG5pZ0IreUdsK0lY?=
 =?utf-8?B?QVFtUzFWM1dFbHZNTHhMUUJVS2R1MDJUV01pY3ZIN2RydGE0cEtic2VyNlh0?=
 =?utf-8?B?dEtlb0NkTGIyNzVxa0o5NDFIN243dGVYRU5GUTh5L0xLMnROd3IxZ0tvNkM3?=
 =?utf-8?B?ODU3UmtVdWFDOU9sNjBVNmZKYlh5dllEVXg2Q1pHR2hDdTFuaVZSQ2ZCSDY5?=
 =?utf-8?B?WUkvSitEak4xNlIvMi9KdTRRb0diYW1nYnM4TUI5MUFJZUNDeGdZQ1FGVXVX?=
 =?utf-8?B?ZWZvcGV1NktVR3Q0N2doTXhJaUliM29KTlo2UkszeFRoUk15bmxHTnBTZVd4?=
 =?utf-8?B?M3RZVXJRVXE1azhSSjhEVXIyQy9nTjZnN2o2b2Nnd3hpbWM0RkFVVFpoN005?=
 =?utf-8?B?NlJuT0p0YlAwMlZCQzU3NVJZZ1YzVkZjK0hpcm9iQWtUWHV6eHl4d2U2QzFZ?=
 =?utf-8?B?cTU2U0RIMlJXeHdSZGwzWWt6UjVWUURMMkVrVjM2eHIzMEJ5S1dXbjRFRE1T?=
 =?utf-8?B?S1VLRjFuaXg1UXVKRVVvWFZyT3huV0tucHA3MGo5dzFLZTlvVCthbEh1d0RK?=
 =?utf-8?B?RHdTYi9Ydk9KOFBXTkFyU1drdjMyQytFeGFWT2QxYXh6bWZFZC9JSk1OeDVv?=
 =?utf-8?B?WVhocmZGOEJkVzVpazZ2MGhDaVlPSUZXSkZOb2xSVkgzSThYWGZpeXBhU2li?=
 =?utf-8?B?Q2tGVkxUdmZ1dlc2T0k2UWxPaHRLbTB2d2tDclh2ZWszSW56V21HN1ZRTStO?=
 =?utf-8?B?d3RxUmwyUlZUdTNzTFU0K1FweERoY1I0em8yQjFDTnZPS1hQdHNwSlNiNFFJ?=
 =?utf-8?B?Q2RKOWN3SjdQUTBhR2pPQzE0UGZXYlkwMnBsZFdXTElkZ1BhWXRFelJ3UG8w?=
 =?utf-8?B?bnpkbHFaTDFGQUpFeE1RT0JqZGJEbUVZYXFNR3U2RUJYRlNvdFJpVVV5ZWZR?=
 =?utf-8?B?WkY0MTFScVdaa3dzSW5xMWhhU3pmeXNzNEVlZGV6cW1pcnRrQVdjK1pnUmN4?=
 =?utf-8?B?bGNPeUhJYS9WSWdFOGI3eG5tUnQ5UjdPQ1JpNldEWXNFMHQrcDdWV2xyQ1JS?=
 =?utf-8?B?RGNHQ3JkdTNmcXd6VVhFbHlRdEYrZnFuWnZ2eFZja1J2V3gvdi9UekQ2endw?=
 =?utf-8?B?Um1xM2gxSDM4c29qUzE2L1NGVFlrcU04YWZpbmJiR21zbytYQUtWM0NtZ3Z4?=
 =?utf-8?B?eDBvZDNUSGdtYUFqQ3lvSm5MbWljVUpPUk5rUVprbTlldXNOckZrLy9RVmdZ?=
 =?utf-8?B?MlJ3RFBpdlVlcVhVK0IyS0tkYjJrUG1jc0FIcGdSaFhkK0ZVWEVNL0pvTTZJ?=
 =?utf-8?B?YjFBc25oYUtwRHgzc1kvRk9jeEFCOG91cHQ0T2RjdVpwSHBNS1h2NGt4TkdZ?=
 =?utf-8?B?R0ZsRURuSVBpZHpQTnZyWDAvYWJwNlBiaTREenRzdTRYVTR3amd3WG9pNHZ6?=
 =?utf-8?B?TXpSM241WHczMmhXQmVnUkhHTGxRTlVzanpXU0FnYjYwdVhrYWlqb0J4V0dW?=
 =?utf-8?B?RjhXbFRibCtkQnIweC9ldUZwVkVSMUZoR2d0cjRhUWxRampFUDRFYWNoRmJQ?=
 =?utf-8?B?QzVROGV3MytWUWtJWmd4MUpkOWtGMi9qZEtJUmtGUlJKZDd6ZG9sTXYwZEk2?=
 =?utf-8?B?aldrbE5YcTF4M0hZaTVnZnI3WWZGbFRKbGF2T3JlNWtSRXUvNG1MOFdCNEc1?=
 =?utf-8?Q?3goJx2Wwi7D3e6HwSUHK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUhaSTRSY2p3dmZNVnFqdkQvUnplTGxyNGJEYy9CVSt0Z2dna002QlVld0Q5?=
 =?utf-8?B?UmpiQ281ZmRQMjlyQWhiREc1MFRmODBqTmNjanJyZmhRZG5PR2J1Q2RZUXda?=
 =?utf-8?B?MFdMZWZENnUxRmQ3UkNzbWttT1ppOXhMQmFwVjJNTkwxYlZjUytpbkhzcGFZ?=
 =?utf-8?B?eEJLVEN4N2NNZVNOTU52ZjVjYXB1ZUp0Q1N1Q0syMzJFT2VwNGtVenhsZlVI?=
 =?utf-8?B?QjVLQm9FSGZDTys5SFZsUlRMTEVhMzR2VzNHN1FrRXJuUUllOFpYSk1ZYTNK?=
 =?utf-8?B?S1ZLRUlQU2tReGg3OEdWMzJwRGpYZFM3SEFFSlR2VDBxN0tWUVg1U2s5K1o5?=
 =?utf-8?B?T0p6YmVDMTFxREhyQjI3VVlzaTFLdzExY2tRNnlRNHZBK1FMVkY1RkMxNVB3?=
 =?utf-8?B?ZWxxM3k5RmZXYTNubEoxQzQ0a0gwOFpUNFkzV05lYUlYU0d2MDUwY09GSnFq?=
 =?utf-8?B?aGswb0w4b1J3OEhBTHE0REc1ZUR1OFFqMGpsK1NDcGo1TzNadUJlL2xPcGNU?=
 =?utf-8?B?NzF4MGVkNWtSYlBrR0ZtS3IzNHZWTzk4QXhlZ2d5cEpHK2dRejd1QUNZR3F5?=
 =?utf-8?B?YTFad1NqYnphVTdtM2M5MkJSbUczckYyL2VLSFRadlRrYmI4b0RBT2xtZStr?=
 =?utf-8?B?aGlVYUxaeFV6eE41TkxJbU9FeHVFc3hyWlVSZ0Z5Z08wQTY5djZWMWhOVlo3?=
 =?utf-8?B?SzFvejczU1BQaUxDbm5mejgzNHRpNG9JNDdKeEtUSmhQL2M0M0YyUXFTODZo?=
 =?utf-8?B?ZkRGSm03MmdpaGN0RjBJeEZQRXF5cE1FeGVFSlIzUHMyVE1RNmV4Y3luMHlL?=
 =?utf-8?B?b1VHaEg5Y2hmRGFhaGp3L3FLTVhtVk5pMnVvU0JaY0tPVC9WZnpkN0svd2Va?=
 =?utf-8?B?a2tEcDJyNTRkaFBrN0JHekFsZjBmUnpoS01WWHhxdzdQU1JOOG4yTnR2OXc0?=
 =?utf-8?B?c0orRjVJVnhGUWJobDNmUTJ6ajd5bW03U0grNG11ZEp6eCtlTTYzSHFlNmgw?=
 =?utf-8?B?QktaSzlid0hmMEdTRGg3Tk81bGVsS3VoTXBIL3RmYWpkU3p2bE9NazB1eFE4?=
 =?utf-8?B?c25aazEzTi9Md0luV3JqeWJWS1F3YVR6MVdmS3VKOHdFM2xmeTlsNGsvbml2?=
 =?utf-8?B?OFJKWkRhOVRqbGVxbllva2t2bERaTjJtTmNnamJTYTc0MWF2YUtVL1Vud2x0?=
 =?utf-8?B?WVdITlA3c21WQ2lMd1JMVWJnUDZVUXZXT3hZUDgxTFVRSTVjTWVXZjlmZ3lv?=
 =?utf-8?B?SlNhTVVJR3V0bTNkdEQyR0x4QzhYQXJKeDF4YThCTThBamZDQVFsb3p3dHU2?=
 =?utf-8?B?NTlnRDBPb25zTnRQRWhsRXNHdXpYay9jay9veFd2cDV5SVAreHBhYmhNcGZL?=
 =?utf-8?B?OWUxZ0xFRit3TWxXd1VYSXNSMnRWRmpaam5oM0Y4dXFjVC9KT1RaeUpLUXl1?=
 =?utf-8?B?aTJWeksrUTgrQVZuSkdqbzBGazBYTzAvSmtKbDI4M3dLT2V0VGY4ZzdJbjND?=
 =?utf-8?B?RTZaNGFML3JicFVkU1BLWmdBMHFuWS9vbitFdkczUFdhWmplWjhyaWlJMU1n?=
 =?utf-8?B?OGxnNnlRNTJETFNCUjk4OXo2blZHRGJtaTMrWi93QTlVa1BXRUNzM1lrVTBp?=
 =?utf-8?B?UURDdDJVcGZvbS93c21OZDlqaXp3Q1JwNFhUSGpFdkFoVXh3SERnc1liVUlk?=
 =?utf-8?B?YytqS2hITjhZVFJRZXFuc3hhS1NoaWVSdzE5MmhzaE5nQkVpOThKK2MyM2Nm?=
 =?utf-8?B?cytQUzd4L1R4clhBWDQ0RlViY1RKZ1pQK213V3FPcTBFL01YTjhhZmZSOXNs?=
 =?utf-8?B?TVlxSk9wb09uWFlBYVAvTUtpSzZ6dFNwTVZJK213enE1VTRPdTJnUWUxbXRJ?=
 =?utf-8?B?ZTZYTEtXZzZTY25Yb2hHMWVRU3d4QWN2VERQeVN1bGJ3K1BFaTBMOUlIUlZo?=
 =?utf-8?B?aU5WUlhJNUNrYk1KSmE2NGNuQXV3bVRtS01JRWthNVVUVTRnYUFSaEFtanBQ?=
 =?utf-8?B?NzVuWldlbUh6QkVrYWZnVzBMSGpnWHFhNDFzeFJkZDk5a0dvelhkcE91dVRj?=
 =?utf-8?B?L2JmL2tack4weWVWR0w1dC8xYU9jWGNFeU1YSTRicC82N2RNT2VnRjhBL0g4?=
 =?utf-8?B?Q0FsbUpxSFNpTDJWQkl3MldMbmNUOHFGRTNCa0xPek9XQjRyMFNJOW5ySk9C?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ab0081-6af2-4edd-0805-08dcf44a01f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:36:27.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpwHf5clSD2I5U9lSLE0KbvZI6kCS6+IwpA94wJfuc6ClGEjSwfLWnTrpMJ0uhQEIoH1BxutpwJB/1n07/Lcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7602
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 16:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17080

On 24.10.24 17:42, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Some devices have no initrd, due to space or other constrains.
> If the option `no_initrd=y` is set the boot partition
> or unified kernel image[1] will not contain the optional initrd.
> 
> [1]: https://github.com/uapi-group/specifications/blob/main/specs/unified_kernel_image.md#uki-components
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - fix typo in commit message
>  - check value of no_initrd instead of not None.
>  - do not evaluate bitbake variable INITRD_DEPLOY_FILE if no_initrd is
>    set to 'y'
>  .../wic/plugins/source/efibootguard-boot.py   | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..8b1097f 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -60,10 +60,14 @@ class EfibootguardBootPlugin(SourcePlugin):
>              kernel_image = "vmlinuz"
>          boot_image = kernel_image
>  
> -        initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
> -        if not initrd_image:
> -            msger.warning("INITRD_DEPLOY_FILE not set\n")
> -            initrd_image = "initrd.img"
> +        no_initrd = source_params.get("no_initrd") or 'n'
> +        if no_initrd == 'y':
> +            initrd_image = None
> +        else:
> +            initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
> +            if not initrd_image:
> +                msger.warning("INITRD_DEPLOY_FILE not set\n")
> +                initrd_image = "initrd.img"
>          bootloader = creator.ks.bootloader
>  
>          dtb_files = (get_bitbake_var("DTB_FILES") or '').split()
> @@ -179,15 +183,16 @@ class EfibootguardBootPlugin(SourcePlugin):
>              .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
>          kernel = "{deploy_dir}/{kernel_image}"\
>              .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
> -        initrd = "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
>          cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
> -            -c "{cmdline}" -i {initrd}'.format(
> +            -c "{cmdline}"'.format(
>                  cmdline=cmdline,
>                  kernel=kernel,
> -                initrd=initrd,
>                  efistub=efistub,
>                  uefi_kernel_file=uefi_kernel_file)
> +        if initrd_image:
> +            initrd = "{deploy_dir}/{initrd_image}"\
> +                .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
> +            cmd += ' -i {initrd}'.format(initrd=initrd)
>          if dtb_files:
>              for dtb in dtb_files:
>                  cmd += ' -d {deploy_dir}/{dtb_file}'.format(

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

