Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA87C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 12:00:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.15])
 by mx.groups.io with SMTP id smtpd.web10.46352.1745841608418458354
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 05:00:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XtU3Rw0x;
 spf=pass (domain: siemens.com, ip: 52.101.65.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6U3cP6Uu8yueA+WN3QpVmOaOeerxxxasP7FTW9/xaR0Byfjbzz0lfol8xkiq7qL3nYDhZ75ynWu6+hcF1fyhshBU5b73HmeVGwg5yJERqApbSnEyfiNPE77+rcgMGU8naLJH/Roa9xfU9fRl72U5wc1f7ewzRIV/LjIr91ea9ZlsA1hBHqcRwVSJ4PBl2kNyK43lbbt9fSciMHBx8hEM9f5vhTk4bafj/qBaQeOwLre5qP2Qa2plyMbClwe0fj+dazn4ODeM2oOWnI/LiWxWeRAVDyxJhF4ONFeEdttje1g7AvXLqn0a+xN76mJijVoO5Lq5e4AH4Znoc1j2xV9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvPE6fcrlCu9vqSSeUXWpT1F1jaw9cwiQE+qWxBwrEQ=;
 b=aoM2JoKp9HxO7LuU/EiBZUd/rhAaNEcZ+4fjnh8siSq65z322ylj0ULcwBoxklWvoOvz48MFsf7r+JArItybyrOMP5zZA2LAmDxy7Qnn6rv1uM2rdT9VPVAhE9o0GYUUiwVptIAAV8gSQo7dE2cI4AbSzxLsqbkY5a72iIzQkEGPm+SHi4Fz5kbAfTQBonejLKV1/hstqmhHQJmha80N6LrVmsU3N57tQ8X5gJmoQlO2eVC48qm5M5o90coXI3mbwbbE0UtbDYErcZOc99SXD/bxj3T1NcRy1K4z8a0FC92X4BV7tTofDqkwSolOZknYvo545FMcuM/mm6FhZd6nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvPE6fcrlCu9vqSSeUXWpT1F1jaw9cwiQE+qWxBwrEQ=;
 b=XtU3Rw0xHwrGlelvgdyTbDS77rXEv5s8TzX+x1iAbJOnIO7iEcHtsalG9zybHkvVz7izdRwPUYdZ6dtUw9j5QprUUrnhdcFY3MI5hBagrZd4lJtLLjkfcpzBs+MrQmsOSa/uPr5of8HDrNNke9xZD2/l32aOn2DHisYklu6OOkKGebagHMLG03WZeEqiCNa2cFLsqZnyguSg0kp7f0ebP+z1fq2h+0Og1ADxKv7K0+nx2yO8qJG3iLVCm3AS8yPg4tRzGFnrMur+EfQ4FFo0PNDX73gVnorkr3B0qJVACGec5jE42rGkAYjdRB4JnaFR3gTUy+5AbpDk/IyfPOlSLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:306::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 12:00:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:00:05 +0000
Message-ID: <dcbe3ee5-7b4d-465a-9742-9660ce673aec@siemens.com>
Date: Mon, 28 Apr 2025 14:00:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Allow to set the binary name
 of the unfied-kernel-image
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250428114201.3210740-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250428114201.3210740-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: e96508c0-583f-4db8-17eb-08dd864c36dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nkh1eC9RdkhPMU5lM1plRzFMVHpXa09jb0hMbmRHTkJKMTFKaUNzNFplTmlj?=
 =?utf-8?B?VFVpaUxqS0E4bWgzblBGZHFxVlVadkcxL2dWeDZ4a3MxUC9XM2Exd2hUTGps?=
 =?utf-8?B?K2ZKeENKcGIwWXhSNE01QkZXUURSTzgwVTBiaEtnREpabGE1NFFxZnlOK3Yz?=
 =?utf-8?B?bVRMQVVZTytlbWdHeVBmampCMHFTTXl4T3pYOTUxK0NNVG1zMlFPVWlueEk3?=
 =?utf-8?B?bFJzZllnQmFXdHJhKzU0NjZjVXZRcVpBd29LNUgvVU5BM01EMklBZUV6NjlF?=
 =?utf-8?B?TlRIRlVoWEJWUzdHdGg3b2JoWmIvR0pjTG9lVUduQnpGMEQyTklFRTFUaUtj?=
 =?utf-8?B?YTdmcVBZM2RhN1RYVDBoZlgzd2JHWEx1cFd0ZHhwRFRoMkpTWEZPZFl6TmVM?=
 =?utf-8?B?ZkJtY0lDZU5najNZaklpSGMrQ05LV1g5YklZb0wzVExxcnB2RlBCVnFoaGhT?=
 =?utf-8?B?aURLQU94UTMySlMzazFBRzVEZHNDamdFZk5DYnBwTGVkY0dPSk9aMVlYQ2JL?=
 =?utf-8?B?M09JRmZzWFhKVWZqS2pWUVZKbVFLS3VWVUN5MmdDS2dQRGpPUkd5Nm01SzRF?=
 =?utf-8?B?ZGdhM2dMRmZtNWlCYUl1Yk9rVmdaM0ZTc3J5VC9aZENhNFMyb1NpNWxBMFRD?=
 =?utf-8?B?VHRvZGcxaUVyWmhJaURKdW03a3RJbFdSSW1CemxTTzJJRXFpTDc0VXY4QVgr?=
 =?utf-8?B?bDMvL29ZVW5QVndSdy9HUjJVU2NLRExvcVlvMTR3cnNTN2NRUjdwM1pPMklk?=
 =?utf-8?B?dHdUOUlGanNPMGNqVWh2cXZrd01ENkZnVEFFL1lpOWlBTGpLQ1VvR0NxOFhH?=
 =?utf-8?B?dkVPcVc1MkJnR0QvQ3VNVUtGVDNVMU5oVDBFYlJDNVlMYTBlaFIzS01Gbno5?=
 =?utf-8?B?T0Vhd29pRWpOTWJicnV6RE9oNEMrZWpQbWZQNktmSmxJclQ3Nk9ENWRPUGZ1?=
 =?utf-8?B?TjVXaWV4NW5rR3JSMmhpaDJjTVNyT0IxNXEyWTh5SEtTOGVWdHVKZFdYWTA4?=
 =?utf-8?B?bzJiQzlKb25JWmduRGhCS3VlS1pOdlZIeHZ5YmxBcmczTXliSnA5aUw4d3pL?=
 =?utf-8?B?S3hndDNRbGxJanRLS2pyREpnQ3k2Q2V0QWd2YW04NFJTRkt6K1BiY1hIbVdC?=
 =?utf-8?B?T0dVTnkyU1FTVU5wUWRFWWtURmIyakRsM3IvcjA0WUlSRlpoN1p5cGR4ME0v?=
 =?utf-8?B?ZUtLMkQ4aVVFdXNROUliK1VMNEdnTHdwOEtPMVpuRVg0VnN0ZXhSQ01pWGxI?=
 =?utf-8?B?L25PZFE2djNpWHVtN1JOL3FManZpbEdkWjJrejV3STZtZkt2Qzl0eTFZN2RX?=
 =?utf-8?B?RGVLSjdZVE5rUndRNmZYTzhOMHRlaFBHZ1pYNXV5SDloT2VXNnBtS0d1N2tw?=
 =?utf-8?B?c0NkSlUzcjdGLzQweS9NeGVRaEVUWERMLzNFNFVreUY4dTZYSUhzVCtuTEZX?=
 =?utf-8?B?OS9JOTdFQlU3cGc4dkgzTnlHM1BFMDdvcFVuVE5pTjViNTA1NTl4bll6Q2ZS?=
 =?utf-8?B?Y2xxSHYxRjd6N1V6dmw3REJnK2ZnMUJwS2l5ZytvdzhWRzIxUHhSTDJ4Q3U5?=
 =?utf-8?B?amFLVjdqOVBHY28yK2d2aGNmNjBvRlZ5cldsSitMWHBaSWlBWXF1NWZTYnNG?=
 =?utf-8?B?SlFzSFArcVdGUndhOFh3bU1yMjV3bnVaZkZrQWt3ckZyMXpmTGxRTlJLdm1F?=
 =?utf-8?B?R2FxOVpCQW1wSkt3SWc4enoxdTlXOUFpOURJT3krd2ZMMnRZcW1yelpKQ0hW?=
 =?utf-8?B?TUhIYjdFMytEMi8rQVA1ekNmS0VZWDlLZXhvbURRMFF4RWNiR3RQVmkveEJu?=
 =?utf-8?B?SU5kbXErcEw4Uk1XRDR6aXhCdFZDTWcrNkdrSlU3K1R0NitSemgzMXhiM3li?=
 =?utf-8?B?Z2NWakMralk2UU1MZ2ZRNFdUd3lRUDhIRmxCeGRoQkZqQ2VRQ3RQWnFKS2R5?=
 =?utf-8?Q?q2NBeFQbplw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVB1dTBCeWgxMkFITS8rdzRFaWFyQWFRU1JNanBkRU5UaHdPRUZkM2E1TzEy?=
 =?utf-8?B?QnJnNjBXR2p6R1I1a3ZQaUtIV0xKejN0ZDRvcCsxRDRDb0E0NENJSWVDMDQ1?=
 =?utf-8?B?ZEc1VXBSbGZ4UUZycmgvdDI4WTVsZEFiRzNRM2JSRkVzY1hkWkV6d3BiRWRT?=
 =?utf-8?B?eGFFN2sxdFFmNHp6ZkhIcytXQ2FvY0k1WU9kNzVvMEI3VVhON3lqUWtHUVVU?=
 =?utf-8?B?NWg1MmI2RTNtSEdoejVva2ozbXAycUlwck9JSzJVZG10VHdZZ2srU1FGcGoy?=
 =?utf-8?B?UkxHS2NmaDdXZGpNVGgzc1MrcEFpRWNVZjRDNGVac3ZpOWhSb2F3WHNLM2sw?=
 =?utf-8?B?djJxL3Y3M1RUdDNHYjBxNW9RTzhpQ05LL1Z1ZEZaMUpIT29NTXUzWGtiRWNq?=
 =?utf-8?B?NDF2RTQxN2ZoUk1IS3pORnE1bmV6czdTWERMMS9SN3pjZ0hiVkNmT3ZnWWE5?=
 =?utf-8?B?ajV3TklhVlpSM0cwa2RZN1lLRVBXMTJqdnBSRHVGaThiY0x3NEcvZGFYV1JR?=
 =?utf-8?B?b2xkMVM0TjB1U1B5d05mWmMxekUvTExOUGVzRUx2M2pNWVd5RUs4RG13QlBJ?=
 =?utf-8?B?T1pzTUNzeUlSRkZhUFRsVjhTZjV1Z1l6Zk5mR0pDUXhZUGpuenJlKzQrS05L?=
 =?utf-8?B?QWgzSkc1bUZqUjB3WUpzOG1ITGhBMkF5bDZxNVQvQlN4bk5xb3dkR1YrYnhJ?=
 =?utf-8?B?NlF3dGVGRTdsaGJ5VDQ3ejNtcytFVksxVnJxSnlYYTJ5N0Q1aU5YWm5YTCt0?=
 =?utf-8?B?MUc2NlJiUkc1ZFI1ek1UTnJ4c2ZHQ0JoVHI4VXVaZDlTS3JFRjlPelI1WGpB?=
 =?utf-8?B?QXpya3kwdk1LUEIzd2k1ZTYwNmhzb203SUVXTDNhWCtWSVVCcldtaTVOU0cz?=
 =?utf-8?B?Zkd0dU55ZFlyQmlwQTlKeUhWdDdiSWNoTWg4ek85U1dXUm9zNEkrN2FSU1pp?=
 =?utf-8?B?ZldxandjOXVJOFBhNEJrOTl3UEZwME1mS0tCSXltSDUyZ1FDYytNRjJtWnVx?=
 =?utf-8?B?SFE1TGlTbVIvUGFEUnZYaWljSVc1Wi9mTUtCRHo1Q2hTOXRiaVRHNFVLY0hI?=
 =?utf-8?B?OE15eGdJMWM0U3BuckpiYjZFOGVudXdFUXE2WUpkVEVtSmJMVjdKb2NWbkpF?=
 =?utf-8?B?ekZndnJ5N0xHSHExMC9STEppa2hUNFMrVjFkZytoVG55V2p6bEFYanRMS2E2?=
 =?utf-8?B?UWJkc0N0QWR4LzJ6NmVrUUQ4NE9QdlZtWXdFZlNnZmk4OFZWQ3VtcDJ1TUdn?=
 =?utf-8?B?Qm5sQzN2ZkdrQzRZNEI2bkdMOHdRUEFsL2NvTENIck16eXpEQVM3aGt2bS94?=
 =?utf-8?B?ei9vSkJ4YkFTaXVGMW0rd0hkbjRZY3l0RGRlRER1bGtRdVNEczMxamlnb0VW?=
 =?utf-8?B?UWlnQzVHNWJNNjcrVVVueERqUGx4bWZYNml1VEc1VmxQenNWVGtkMDlHVFQ4?=
 =?utf-8?B?VllOYXB2bWtwSjJablUzdHBabHhZUitXaVIwWkVua1FkaFZudjA4K1dVWllB?=
 =?utf-8?B?c2ZRYlFXUmRxdTBPcGU1WlVsRFBlSTdVNWcyYXhTMnRTRDZYcnFkd2lqTmNH?=
 =?utf-8?B?cmFudFlDY2lNamtkcXdDMFNxS2NNa1N6elErMkdLbGRvOEx1M2xMY0lERWhv?=
 =?utf-8?B?cUs1cDU2NzJ2UEgrVUZBcFdUMXEzVGhDekF0cVFpNlJhdXJFaEZHQkJDbWpz?=
 =?utf-8?B?THEySXdobW96MkZ0eUZva1YxdFNXeXAvNlNCeW1NZ0F5bmhKNGZQWW9lcDVL?=
 =?utf-8?B?Ty94TTBKbzQzS05ndEhNdnhSV2FjT2h0ZDJTOUFFNXVQRDJ0dzlJSEI0YkJq?=
 =?utf-8?B?aFBkZWtnbkwzWU96NkZXU3d6S2FGUVlyTmhGMjI0L1RrNUlpb2loSTNqQVUw?=
 =?utf-8?B?UHRiQkVjYTdFS3dINDYzbzVEUmpZN2F3STJCK2ROeDl0WmQ5WXp6VUNlY0Yz?=
 =?utf-8?B?M3V1UDNLTFRxYmh5WmxXc05NS01nSG9jM2VEVUNCNXErK0ZjcC8wYTB2Ym9C?=
 =?utf-8?B?Z3NHc2dUVVlJUHIxSjlmNGpqeCsxR3RvUmo3eUdMN2dwc1ZEK1ZwUlBuY2dR?=
 =?utf-8?B?cjBCcnhFZmNFcnh6cUtJd0N0OGt2Z1NVQlVPWGs3SnJTa3NURnNQQnY3Nm05?=
 =?utf-8?B?eGV5a21wZHY2NXJJQ1k1dDEwUS9ESjhtUWVtcmtpTnlQR0lUTEl5bm14andF?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96508c0-583f-4db8-17eb-08dd864c36dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:00:05.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev2SD3dk4msokoETT6HAH3zKO/ueI6/rZS6E31WXa/HIsK8tyXovii8EGLZaWAHUsdo3G7P4BVSDX4Q+wVji/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 12:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18699

On 28.04.25 13:41, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows in case of a unified kernel(UKI) image based installer
> to differ between the installer UKI and the target UKI.
> 
> It also allows the build of multiple images for the same target
> architecture or update file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 8b1097f..310d2cb 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>              .format(rootfs_path=rootfs_path,
>                      libpath=libarch,
>                      efiarch=efiarch)
> -        uefi_kernel_name = "linux.efi"
> +        uefi_kernel_name = get_bitbake_var('UNIFIED_KERNEL_IMAGE_NAME') or 'linux.efi'

Is variable name anything we should sync with other plugins or OE?

Jan

>          uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
>              .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
>          kernel = "{deploy_dir}/{kernel_image}"\

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

