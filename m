Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A685D5CCB1
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 13:56:34 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.83])
 by mx.groups.io with SMTP id smtpd.web10.15486.1730296588409867545
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 06:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LGqVQ0e2;
 spf=pass (domain: siemens.com, ip: 40.107.241.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+5HFrTj/0/tnGlsJjHtMihipOUZPNbDtU0HnyJc8ZtIq/nUQHMnHnaUQPvEwUvJ9Vp7E6ExUBwbVRmX849/2vmFNbO7lNrYz4V2PQaWvwZJgqFqFI5v91PJsw2esHt8uy5kYSCFA8cQtwO+qrzoydjJ1PVZ0d1crMGzfoYsULMxwtJEl2Wa5c7DyNr/kkGqnskLXFqzQ4MmQ9uhAK5zJcZtAqRuJHHA/5CO6m7Pma7ErP8ypkTJpac2wTn1MSgtqz+bKD2JB551IaBVw4ANO8tsCSkEPnOi3dELj/TaeTsw7uK/oT9g3w1tAWFba32WxW7NQOgRzSfRoBH34uULNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxD7X2mbr9hPSCQPXjr7SRmRQqM7GDirqR89PuszYxs=;
 b=r5o91DJwhhS4Dta3GZBV3SROTqR8xpSPJ7AydYxm15IVFxcTZrUa4vz0NRxg7OjOQILOp0g2BwUrQGfJrQanPYCx4F+K7kMxjrAjX0nPM0uFZUFJHu8m3EwBJ1lj+RDFDVbRccSV9QGwNfRkqoBZa/vuPq+vqBqIBSSwjzc9NIxTT3vTon0+pe01BvS8LSkroHywtBXg88TCJ1LK+4BJCZ8NifnGmLfSSqp7CDZjNltOBqPKpHFtI1aEDPoMwt/1QfDp8K9hPdmJKW1JwJedmcSokCVYlJDF3A5cmD4x1WYJ3L76R1kZyoQt4U+24l7scASChx28K9OPJXhtJFFwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxD7X2mbr9hPSCQPXjr7SRmRQqM7GDirqR89PuszYxs=;
 b=LGqVQ0e2tsBx+c3IIsvaHhqCj6mgQC88heVuapinyu1S3Tjki/P9sNVzMlm/yuYgPWUnRc5qLuMucTtOVbzGf+ZEOokzJ9gSOhqm3ihbnnvcAOwB/odKWLX7jgyU7/QaYFwZvDvliZ7L5lQ7QT0poIvHV/KWB3/hmL1mM8SMr9wXrktt/q6eGkSKFc4ewzl/vbCA1GBMXzFN+CfZobFkulY436rOiuS0dALEIUnhFsAE+cRU5HqB/5PHPlZFkz2C0UQEwpP+M1TL2Q2DLmfdR2AZWQV6N49B2TArzrh3NB6AQ86eknmo2c3yOx6ZmEshAvcKqECJET0RT/9hC4z/zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:507::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 13:56:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 13:56:25 +0000
Message-ID: <81187e79-ff31-43b1-a556-824db4a41a7c@siemens.com>
Date: Wed, 30 Oct 2024 14:56:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 5/6] linux-cip: Update cip-kernel-config
 revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
References: <cover.1730289107.git.jan.kiszka@siemens.com>
 <90a003078be88c2b963a7ace4ad7841639c8effd.1730289107.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <90a003078be88c2b963a7ace4ad7841639c8effd.1730289107.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8652628e-f711-4488-086e-08dcf8eaa4ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmUva2cvUFo1L2d6clY0Y3p3YzI3RDJPZnQzYzdHSTBjbjExVVRVN3B4OSsz?=
 =?utf-8?B?YU84QUlSQ2gwdHkrOXNML2FtcnZZU3U1VWw0a0JBdUNtT1htMkRuOHo2ekVW?=
 =?utf-8?B?R0RxTHBQdFQ4ejl5ODBkQ3hZMzBzSnBGMG5HWVIrZDhhNlZaSlRabE9BYTlO?=
 =?utf-8?B?dTBkQ01KdTg2eFlMMXJNTjBLbEtTMExESHZCZ0EzbEE4RDk5R011NzZRQTJi?=
 =?utf-8?B?azhqQ3lTOUR5UGZ1MUNldGZpRVVSYWNTSk1SNHliV2pWdXR3UzY2Q2VDZXdy?=
 =?utf-8?B?RC9kNFlvWWpGaXpaTEcwQjZKMjNMUnBRQ2VRZjRSSzk2YWNMOHRmNUxlQkZM?=
 =?utf-8?B?STBqTHF5S1RLSzR2dTBKb3VNOEEwcGV1MGYzWUYyaktOTlFMMFJwT2Z0Wkor?=
 =?utf-8?B?QmdrU0lPcXNrZjhLN25KclEveStNY2thczlVcXF2MGNWOEt1REFGcGhqMWls?=
 =?utf-8?B?NTFCSjhuRWFVT3FpdCsxSmJvTUx1NVU3Q1lUQkNuMFZEeHIxNHFQRFhTaTdv?=
 =?utf-8?B?Nnc4NExFQlVsN0RnMGZJc1ZVeFdMMlJQSFdZdGFjK0pWZEZ6ZVlMTjUxa3RN?=
 =?utf-8?B?TWFVcEQxMDB4U0MzVmtkWXVqZ3ZZdEREM25ETVo3SGo5Y05rMjZ4aFJPbUt5?=
 =?utf-8?B?aC9uSENaRGlhSWhpSjNRTnExOHhseVQxNnRHUTJ3ZTRCT0w4T0xBYVFJSGt3?=
 =?utf-8?B?Y0FEaDJ1SDFlL0hoalF2ZGY3dWxqWDlOZU5FYXF4aDg5UzNLS25PTkNTM1N0?=
 =?utf-8?B?NzVzc25uakhydkR6cGFLOXNocStGSTJxRVRCcEpoUFRRN1ZQNjEwMlpaSzdG?=
 =?utf-8?B?dHg3QUQ5L2VFa1RZZTExb1BCa2lkano0bjdISkhaV1dxeHNKb3doTG8zYW1X?=
 =?utf-8?B?TGw1MW5LVWtJeGNSM0puWkRHazhhQlNXb2k4ZnNxMEhNZ2IwenF0YWJBU3Zm?=
 =?utf-8?B?VFlOR1hoeStjMDB2QlMwTlZBWU5TNFhIdDVwYStndVpFSS9EaTZoMEQ1QTBk?=
 =?utf-8?B?bTMxZ0ZzSVNSbktzb0xqWTNjZVhGY2p6Q1BjWkI1eGJYc2dXRmVQclE2U1Jv?=
 =?utf-8?B?Ky93OVE2VXNWZDkrL1pCNC9CRjROd3ZxOW1JNVdkWXFEeVYvcDVMM20xcEtX?=
 =?utf-8?B?aCtxeStHUEhHSlpELy9odnFwZ2gzYlZKRzFHdE1VSWk4bnBVV3ZiYlo3Wklq?=
 =?utf-8?B?a2FjNENBRU55WEE3T1g5cTNIUnZwckhSaW1VZExwempzZ3VBNmdSSUU3bUxt?=
 =?utf-8?B?OFhSWisyRklOREdJd3ZFU3NQdTNkcUlRWHFwbGZsalFKQUhtanF0U1dnaUk5?=
 =?utf-8?B?V1FDclFwblVJTjlBZGs1MzRuaFpxQzNPVEt2c0pEL0ozRVJKZXpNWllVb2JT?=
 =?utf-8?B?ejdBSjdsODNHWWNpN3VVY2pFZEJaWkJSU3ZDTXpCVTVYLzZPQTZCTTB3aFRl?=
 =?utf-8?B?OUFmNEwyOG1YK1dMV3Z4ZVRBS3U1WGJJSVc1cU90TTRRcGxqbkt5a2orUWJS?=
 =?utf-8?B?cWVpVkE5cVRKVHlBZ1FTRzk3cFBZTmY5ZW5OZGxrNnhsaHF0bk5ieEx0eVhX?=
 =?utf-8?B?RnZBeXVtM3Frc3hNNFVRRlB0RGoxMkgvVUhYQUFneHMwOTBxSm95RFh6UHdm?=
 =?utf-8?B?UlhHNU81WXJXWDg4YmVZbVBuSTY4eWw3cjhucGJhZDVFRWhUZUpYekd5WGxr?=
 =?utf-8?B?Q2hDNHMvU1EvUWpsdmUvQTZiSmVQZUloZS9mVEY1eUU4bGszNys5bHQwM2FI?=
 =?utf-8?Q?62U8IqIjC5HnVHA8hK35LwvjnzUkBX+4gACEpO9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1dpQUxzbFkzTGFiWENFYTcyUHNsRU5VTEx6MjhsQnkyTjNBZW9NZmFDUEsx?=
 =?utf-8?B?ODhucEpmTm50VytrYmM1Sk9hOG1vQTg3TEhKZWdGdzZpb3N4M2piQWxvbWpB?=
 =?utf-8?B?L2ZIYWJqbkdmNzFaNFVCQVpBa3lVVjdPRzZibDBzdWZtSnFaTFlEYjJ6RHBO?=
 =?utf-8?B?TjA0S0dnNjJwa3FjUmZ1dDF1ZzdFRHZNSEwvNk9xK1lqSWtjdUJZQXRvRmlJ?=
 =?utf-8?B?RkdnNzBqT2ZFNktaQU9OQW5waHJrVlkzR2xEeVNhakJoMzgyMDVyTXhtbi9F?=
 =?utf-8?B?azFWVUZ4ZlJFT1Z1N2hBa25jeUptZEdiTzNrQVc5UTJ0VWpxbERVNzc1ZWZ3?=
 =?utf-8?B?Y25oUHRJUHVTczZCVm5kUG5BVFRwN1o2TDVNdFFFeHpmZzhOcU1DN0hJV0dV?=
 =?utf-8?B?TFhIZlBBbjBzNi9xQSt1VWhzUEpLb0pvbU5oK281RmtSdEFVKzhRbjhQSVky?=
 =?utf-8?B?OHhwMEgrc1hPSXRXSzdlTzZxN1ZDS0dBL2tGYk1mU2h1cmYrTXU4bWRsNnZW?=
 =?utf-8?B?ckM5WHlRcDV0Y01ITjI4Ti9zZSs5dWtidk1haWRVc3VuNkxPNm9SUnQ0S1Zs?=
 =?utf-8?B?TWR5YzdqZVpkRitwVzQrT1pFUTJIU1R6S0trcmllbXR6YWMwU0k1VnczYVY5?=
 =?utf-8?B?dWxWWldYMXZIdEVqWXBKdGRCa0RHcDZZL2FQZWY1M3htVFVFVUdDUlczZnh1?=
 =?utf-8?B?UmdFSmE2WTdNaTRKYmR2VElUT0xFajhzQWZNY2Y1dHZYQWl1T3hkLzJSOWFh?=
 =?utf-8?B?dlJ2SXMvZ3ZidzR6cThoamVENjVaVkhYYzJHbkU4bUJRb3RrZmpJQmZPZG95?=
 =?utf-8?B?UFJYS1Q3OCtXaUtvNzkwUjVESUl1MW5jdVdjL1kwNUtyRTNPSzRGNGJJSU55?=
 =?utf-8?B?UjNFMUhWSnMxNXFubVBrNXh4UWlUZzNnWjUxa1JPUnd5Q1h1a3pEZ3ZMREtP?=
 =?utf-8?B?NmdUcjQwS2dVNzJpOTIvRTJVTkpTeGtlSERZMFV1SEdna1RrYnpSZjZVdTFI?=
 =?utf-8?B?b1JvMXJSVmw2YkVLUzB2RE5vNk5kM1cxREVCa2lLMys1anlmaHRFODZlWDhC?=
 =?utf-8?B?V053RjR0Rk1Ra0ZNWEtTdC9XQU9RSi9NMEJBOXA1TEkzTE5FR2ZQM1hxMk9P?=
 =?utf-8?B?YzdRMHEyMThFZHgzbGFtQWZFeWRMdmpkOFU1M3g1d1B2TlhSSmhmOWE2VWhB?=
 =?utf-8?B?NTFVS3ZUZ1l1QXZpb3dTTEU1dDFIa3hsMDg5YjB1clM5SGVRc3JTdzNZbE9D?=
 =?utf-8?B?NjZodFNabm9GbnV0YjJZZndqSFN3Y3BBSWZ5L240UEMyeFRYNDJuOHRpRWtY?=
 =?utf-8?B?VVRUY1ozWUhIcUNuT09seG1CSkI3MjR1RFpyT2gycXF5NTBBSWRPcGFRK2Jp?=
 =?utf-8?B?eGMyVjJudVVrWlZtTXBtTVVRaVdiUzNPZFVTdmsxeWFGbmdUVjlkYjhEc0FB?=
 =?utf-8?B?RUFRRDhGQlU2N01TMGNBNldkZlgxTk1QWlJVZEdVczRwUmdYUXdPN3IyNkFp?=
 =?utf-8?B?US9UY0N3a3dNVnh3bklnWExQaTdlek45ckFEMmNOR2M0N3J3NE5sT3BwT3Nj?=
 =?utf-8?B?S24yM29RNnVxSmNVNmkvRFc3R1Jkb04yZGt1NWRiVEpXcTc0ZE9waGhPTE82?=
 =?utf-8?B?UlhWK1dkNFhwQ3hrTmRzNWU4cnppKy9RVENEWCtMd3BwOWJYZ2Zjb09kYnYr?=
 =?utf-8?B?VWlLdUpSTmFpM2JmTkFwWGkwWmNocGRONE94eHFRZ3hxaVZ1YVF6dUZWTS83?=
 =?utf-8?B?bi9vOEdFMjBMVW52dzZFVVdsV0dKNVQxbTN4NzhaVnBZelVnTUh0NktyTFhm?=
 =?utf-8?B?ajJEWkhnNFRrQUJGZlhVbm84MWVLTkw5NmJnTHhvNXBIQXR1bmI4dVFsUERw?=
 =?utf-8?B?aDhnUE5ZS2JSQlVjdlA5S3VyWVJWYnowdXBWaUJEenduQ2JNOFBLeGFyNFEw?=
 =?utf-8?B?cFFBRzlUdHRFRUtoNjRBYVZhRFZMK2NCbXQrbm0yRnFYNmpidFZJK3pmdmhx?=
 =?utf-8?B?MFNFejdiNkpwZm0xM1NZbC9RZTJmNFJPUENMamUwR0dsZHNJT0I1a3dDUmtL?=
 =?utf-8?B?aVl0MkFBcmZwdjRSa2NWVWUzQlhHQXp4YkNJY2YwdHJFZDFoZFlQL3JkL3lZ?=
 =?utf-8?Q?w0ZzizAMtrVkldmsVtp5OUy+t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8652628e-f711-4488-086e-08dcf8eaa4ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:56:25.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIiLi38MYrGnkgJ5aHXZOKNfVxTgumHCdtWQBlZeYdytKL0UGLmNGOIz8jG9Yx+eHd6UY3bSMCK8tCzN/0rsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 13:56:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17123

On 30.10.24 12:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This brings support for EROFS and PID namespaces for 6.1 and also fixes
> Ethernet configuration on BeagleBone Black.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 9c1ab946..4e1cacc2 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,6 +14,6 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "f6b7018cb6845f34f8a03c126bf4f823ce10d637"
> +SRCREV_cip-kernel-config ?= "c3c5f08d24dc05f7dd20d29d6337e00aad190093"
>  
>  do_fetch[vardeps] += "SRCREV_cip-kernel-config"

Ok, this will need a v2 once [1] is merged. Or [2] is resolved so that 
it can be merged.

Jan

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/106
[2] https://lore.kernel.org/cip-dev/cd17b322-28c8-46c7-9876-22cd3f32033d@siemens.com/

-- 
Siemens AG, Technology
Linux Expert Center

