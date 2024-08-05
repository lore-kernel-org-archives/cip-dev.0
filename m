Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6561C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 14:24:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.82])
 by mx.groups.io with SMTP id smtpd.web10.9194.1722867850437886669
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 07:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sOii0uKm;
 spf=pass (domain: siemens.com, ip: 40.107.20.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEbgc6hiqegw850o2MKxr/n0L1zGWmXVURPzUEBryEL3NEcxPR42tPUG7NyYYL4+GkxFKvRnBCmzWhc30kRmttJuhG3OcwnKgD2SK/3AtegmaWqmKLKJhoqhI8pHrbDpqz+y/KcwM3VrzoyiSWxlnFreHCYTketao/GhS7TU8T6E163dAM0/BA6upOv2n6+sMzgeZefGu3ml1ou5U/XTY+ItNyoad7t+zKdHJow/3D+4EpcGB/Y/8xYBjsHFLbtExLap/+TvdYhxD6W0OIdU0mi1du6i0AP4bddNHQnjNfao5eVz8YuCnPEGa0X2i6+EGGnOHjkJ1Va2/ZpCHqqjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzuzYrCrGhf9VC6XaRfEbeqvVjZWhDqXtg4DgzD1CH8=;
 b=s1EtqiM/1cNgYYX2IUXvUVaYrYCMmG0nR1jIzMdmG5tQh/ETSIjQMmxqvmoV4EmUfdzSYCRUzxssdd+MHn7LN4bYVuXxM6pQqEtNwVXw460cUWVZEU4Hc1EnG/ngDWOezCIk/UD/mV1I6YjxAhOQWcfuUZByOcg7CDDXTSKeSVweRVbQP/bojo1JFGQNabFnVINB7VPIW3ZV38KeasIa/OWFA34LHS6ZRMZrD5FWlGg3VXA10jZ1YWp7gangRcgqt2S2xQP2sFZcZXglmnzYBaoWMHNucKBI0RBcbaGe8164Ydh5zR1UtMIElT6Y1aTK68MTBsi+bL/+sh8zFgnWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzuzYrCrGhf9VC6XaRfEbeqvVjZWhDqXtg4DgzD1CH8=;
 b=sOii0uKms+09B9+hqmLFXmCimdZINmVMRYpC8O4NDQUqNPnN14WB5NDw99Vk5rmMexUItvtcy8WN7RjsostnHLzEBQLlMjfyP3JmpiBokpOlD8kME9aNPYmTe0GIndwEeEClmaP+PJxVCUEhnkmjA+Kt7B1QOgmSJrhsul+ixI4I6wmu/3Xn3pbDTVWGW3IvIS1VBfupRc8aoHiGwVTJ2Lyg/v4+TByeJiSnPOABGWoCDg6BZwBDGiZSz6ZbLfHa0X2fUPUcYq/41tUhOTS2ddCYugsG73Ngm/5ATdYf2JSeJpjxm2xoMIYiD6BhHhjw9oQ4DFxxUvDIhTXe8lYAQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:24:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 14:24:07 +0000
Message-ID: <b3a26322-57b0-4ea5-86bd-2da1c772cedd@siemens.com>
Date: Mon, 5 Aug 2024 16:24:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] fix(PREEMPT_RT): disable
 CONFIG_RT_GROUP_SCHED
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240805091722.6871-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240805091722.6871-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: 423d1f5e-d22c-43f3-e1d1-08dcb55a4409
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bk1WQmZoSzdORWhWb2taeTAzSHBKenVuVWEzZEFNNmdOSm5pWjZ3ZlE3R1RX?=
 =?utf-8?B?S0huUjJ5Y3A4MmMrZDRUc0tzZmRtcTJYNU1WWkFhQWNLZ3hsNjJzODRkdDVj?=
 =?utf-8?B?dGcreUNzQWdLbGxzM1lJQitIWUYwNjB2Ynh0eHQvRXMvbElZQlBoZlRHb3J1?=
 =?utf-8?B?dDdZYTUvZVhjUUVBSStPd1dESkU1YmQ1VW1kaEFDUWVNVmdxK1pSUWk3UTNi?=
 =?utf-8?B?YS80NXplbjRhZ1RYZFM1NXNCd3JxcGlJUjk0aFFubXNUUEgwaFgzK25LZUpa?=
 =?utf-8?B?VVZnY3hOK1Yxc0k3SW9qa292MUkxeTJCR2s0VjFXdlV2UXVHZ09nT0RQNmxp?=
 =?utf-8?B?TFlDR1k1YmltM0liNFVVd1Y3U3hnMmQwOWNpemE1eUJmeFpPelN4cFVCd1gr?=
 =?utf-8?B?T2VTYSs3VGJidi9CMHJGaHdmWEp2eEFZb2ZGR28vR3dWN2t2ZXBqTjFLMG5i?=
 =?utf-8?B?TnUrMmg2cy9JZGxkSUROWStIRmhSelVoZ1ZPWnBmc2tQRThQK2pjZWo2NEVK?=
 =?utf-8?B?bFBnaFVTZlVMQ01OekxJSm5uK00zNHVDSFZqenRHMHU2M3dReDJvYnJXRVJu?=
 =?utf-8?B?OTI2K2FicmsxMlNoZ2haTzhoeTM2RFFkSnJVcko2VVMzNEZ1bm9Wa3FuVWg1?=
 =?utf-8?B?TEN5SGZibmw0U08vUW1PZHc0UnlWcEpoNGtOWFpWK1lkZ3NwU2k3dDFDalJp?=
 =?utf-8?B?THcrWkJhLzhqV1p2RGdNSlF1U2pVMUpwbUZ4ejdYYWtsRHF3RUlrK1JKQURX?=
 =?utf-8?B?dDA0ZUNvU0VYaFBrSXVuWXcrcndJVXpyNEx5NHhsR2VHYXJubVlpTEZHRHBx?=
 =?utf-8?B?YmZEUkYyaEQzcEs5eTZrWXN1Uk5peVAxbWpFOHhLME5wajhZcFR5RVJGakx0?=
 =?utf-8?B?akRRQUFFdEM0N0lIQlNuNmMxWGk1ZFYydEhzS1RGVUNFa2tWWnlHU3h5cWRk?=
 =?utf-8?B?YWY4eThWU2c0ejd4NzQyWXJabi9sNHEyN3E0ZnluVUdrdVl5RUFkUlJweE4x?=
 =?utf-8?B?K05NWWpjaUNIRWFpRWx3TTkxUnBKOVZKOHR1cVhxK2drOXdEcDIwZS9UL1RV?=
 =?utf-8?B?MXFJcVlxYll2N2VyanZKeGM3SUpzY3BIODBaWGgyREJTeFY1MEcxTnhvbzdB?=
 =?utf-8?B?VVQ1Y2VxNnhJR0IxYXc2a1Mwcis3OFVPbm5qUVBWNUdhUHRkSE9GNlBmZDdP?=
 =?utf-8?B?Ry9QZWZUUzFGazRFcGc5TmRFRlBiR0ZwVStSY3FzTFR1N0Q3VGtMblROclFr?=
 =?utf-8?B?dWxFbVNod2szc08yOVg2clNiVkZFemNHUXdSaHFQQUVmMnlhQXVoZ3A1ZXJK?=
 =?utf-8?B?NTMyMVpRL0JnMXZvbHVrUENJcmQrMnRXYUY0dHJsQUdxdmFmSS9JYjdHNFI2?=
 =?utf-8?B?L2FiQ0hiVkdYditScHNPdjRRMjUvbGkxSGpvc1VRc2ZlM2twSUFiR0szb3I0?=
 =?utf-8?B?SThpY0tTemlSZ043bkpQK3lXUjhkUjR0K0xaN2kwNmNUcjFKQ1RVUm56TDRE?=
 =?utf-8?B?S0NZR0IzaVQ5UzlYZzlDMmZPUHBHNGVSRFgrUzlJcW95QklpQmNvaE53N0Fo?=
 =?utf-8?B?TDJNNzRiMnlRMk03WVorOEVQOUhnUjZxUy9BNndLS1QwZ0d6ZVN4aVZOWnhS?=
 =?utf-8?B?WFJmSWN4UHVDa2VrNEg0WTdKMEovR2RTVkxibTJleHBkMXQ0NU1Rb2J1QjYz?=
 =?utf-8?B?YnpqRHAyUkFPck1sTXYwbWszRDBpYnhZZmllQjVVb2t1b294ZGpjb0FhM1h6?=
 =?utf-8?B?ejNETmp5bUszMENrN0ExSU9aU3hBWThCV3UxVzZVS0NVUEtscHZTOWl0T0o1?=
 =?utf-8?B?WUQvYjlJb2RhL2l1ZUhrQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJkcTQ0S3VLT1VPMWNraENROU4wWFRqMlFqOE4vL0l6bUNSVkFtZXA2RS8x?=
 =?utf-8?B?VjFYUEJ0M0FSL0EwQ1cyZWkxZEJWMjAya2J2cGEyTm1ib3lnUHd1NHFPcXNZ?=
 =?utf-8?B?NE9ub2krdE1hdnFoY0Q2ckhPczZwZHBhV3dqUy9LbERmaC9POVFqdUlsODZu?=
 =?utf-8?B?MlpDTm1DekZnSXhOWDZ5MHY1RUE3Zm1xTjQzcFhJUTBwODBXWXNwREY1UE9B?=
 =?utf-8?B?MkFWL3lpSk1KbUgxdEpRdWZDbjIzbnRmMEVtL2Zpa3h1WHhMc055REtGUlNh?=
 =?utf-8?B?ZVVLMlhpWFpVQm96dmE1VGVGZXFTVm1qdGJnTVNXUDNRamE0K0MyekZVWHpO?=
 =?utf-8?B?NjUvdHJlSEVTVVQxenZpTllDditCQndNREVCRnd3eWc1bkw4ck9FakJxMm9w?=
 =?utf-8?B?TWNML0V2Rll2YUxDc3hJTUJxSVRUNklHbi8wZU4rWkk4d3V6cmFtWkhBNnZj?=
 =?utf-8?B?Y1EvcXU5M2FOQjEwS0JqQ1l6VkNQbkhLRWZMRVljbDVCaU1wdTkvWWV0TXNC?=
 =?utf-8?B?OU5TTVBSOG9uSWNFNE5wV2RULzYwSDFxd1YwcjdTVnJtSDU4K2cwVmpyanpE?=
 =?utf-8?B?MWJUSWZPTkZQbVpkT29uVng4ZXhpVDRtVUR2ZGU4Wi9kQmtQaUxVWUNQYk5K?=
 =?utf-8?B?M2QvVUVIUWNtRnpBQmgza3NCeFN5VHNnZmx5d3BoMGFJMjUwQTh1NGlwK2hE?=
 =?utf-8?B?L0JzeHp1b2tYWm9kOTA5MEtQeHMwbHNHWEdmTWRCSmpBQ0dWUksrMEx3NlFu?=
 =?utf-8?B?b0xTaGZvSzdoTGNRRUtsc0h4dTBaZ0tSL3NUY0ZUVytFZWpqa2VXVEFmeGMy?=
 =?utf-8?B?NGp1Sm0vWUFjL3VFYjRoVE1wb0VRNGt1elY1L2RZb3l5K3cxREg1ZDBDcmFw?=
 =?utf-8?B?czBXRUFhd2dqYWY2TjQvRklYUElSOXI4QzhvVFlGZDFRNnRSWjB4U0lDWFMv?=
 =?utf-8?B?Q3lQRElvN3BNN3Y4Ym4vNi8xNFo5NkxYS2RQRndYUTN1VzhBdG9yK2NCRDZs?=
 =?utf-8?B?THgxMDgxanJHOU9rTDQvcUozU0E1a3h6M2pUYzd1QkdyU3hXMjFwWFd2Q29G?=
 =?utf-8?B?WTRZWlJIellsOGw4c1hsR1hva0JpMDFDT1pYcHNvaTczSFFNd2VyWWZKNUJr?=
 =?utf-8?B?Tmd3a1gvaFBTK3V4U2FTWnBzU2ZKVlk3WGRQN0xFazk2TmxuYVo1VGxqWDh1?=
 =?utf-8?B?emdhZk5WdWJZV1kzemp4dnp0WUZzQ0V0OTNMMVRYcUFnTGI3cWRnbXE4NCto?=
 =?utf-8?B?bFNlbUVvU2tHSmZPWENnd3NQY3NqdE45eG9RM1ZTcmlYSmR6bnN3Qkx3cSsy?=
 =?utf-8?B?ZldrTnNRazJuOHkxQjRNbExDWlMxUnRBbWoyTXB5NmhqQTgrcEZhR3hUU2ZI?=
 =?utf-8?B?RWlKajk2TjIyWDlmdUVuTGJPU0g4SXcrWldOOSt4Zm9YVk5qVVpjSm1TZ0Ev?=
 =?utf-8?B?YjdOSTJycW1ZVkJBc2FvSCt3WGZ2ZFArZVdldW1hVS9kRDBBZU1sU2xGamdQ?=
 =?utf-8?B?VVp0Wk1JanVXM3pFUFJGOEg2TldRUE5LcUcybmkxNnBBK0NOa2x5ckxodDFU?=
 =?utf-8?B?M2NzcmZyZlB1U1ZjQjNITkt2QUdaUjRtU3dPdXVEcFFDenJBTUZjdE51a2Vt?=
 =?utf-8?B?dHBVOHVMVTNWYnkyY3F1UmNMUzQ2em1Gc0g2Ri9GcHlYZTRxZDNua3o1bklT?=
 =?utf-8?B?N1ozdzFtVmFXU1FIYmF6bEZpRk1qNGluOEo5M2hvKzk0ZnpQUVg2azRXRkgz?=
 =?utf-8?B?TG8vdmlwemdvN1d5MU40TFN6bEE4MDhCMWFBdXNoY3hPV2lRQ0lKUTQ1UTY0?=
 =?utf-8?B?ek0wdUxkcnJYc3IrOWJYYWVPTjhWKzJyNHRCa0d2aXZhWG5NcGtqMVo3ZTA3?=
 =?utf-8?B?QnlWT2M1bTYxVTNrVzFMeE5KQm5kd0hyTGJXWU1DbE5UL3N1VUNiNGpXcmE5?=
 =?utf-8?B?WjdIVU5nbXEvaUl1OGFXT0NaU2g2NWFUZks0ZFoyRC9JSDR3QmtPYVV0Y0ZG?=
 =?utf-8?B?ZDhTWk5qWDEvN0Z1Mk9ZaTBLY1Y5QWJqSGliMnN0OVVjRi91SDZGaWFzMitL?=
 =?utf-8?B?M1hwQ0FvVDhLTmZzWGFEMWFjb2dyWXovTWk5VnA0SlQybHhtVWtDRk9IVHRx?=
 =?utf-8?B?MC8yYzMrVXFUZExiMFJSMFVIVEZMRjVZUmh0THdPWm14Q3NoYnB6ZTFQOEJE?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423d1f5e-d22c-43f3-e1d1-08dcb55a4409
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:24:07.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkvF9IyNz54Bxsa1rq5plrDsTQi+REq8N+CjlKC29U+nfXqb/dky/ebkv3kY7/5FhjgeEs+F6NxnAbY8qlsTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 14:24:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16717

On 05.08.24 11:17, Felix Moessbauer wrote:
> This feature is simply broken on RT kernels that use cgroup2, as the
> cpu controller features rt_period_us and rt_runtime_us are not
> exposed, which are needed to configure things in a way that allows to
> run tasks under RT/DL scheduling policies. It further seems to be
> incompatible with the nohz_full option.
> 
> This patch just disables the feature, similar to upstream Debian.
> 

Makes sense. Didn't trigger yet with the standard RT test images built
from isar-cip-core directly, but out config should think beyond.

> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> I'm wondering a bit how that was not discovered earlier in our RT tests.
> Maybe Quirin can have a look if the cyclictest also shows errors that
> the scheduling policy cannot be set. But maybe it simply did not show up
> there, as the setup was to simplistic and did not enable the cgroup2 cpu
> controller.

The latter is what I assume as well. I tested it with a qemu-x86
bookworm 6.1-rt setup, and cyclictest happily worked.

> 
> Note: This was discovered while tracing down kernel bugs around
> timer slack on RT/DL tasks.
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
>  recipes-kernel/linux/files/preempt-rt.cfg | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
> index 4afe1bf..ea37556 100644
> --- a/recipes-kernel/linux/files/preempt-rt.cfg
> +++ b/recipes-kernel/linux/files/preempt-rt.cfg
> @@ -1,6 +1,7 @@
>  # >= 5.10
>  CONFIG_EXPERT=y
>  CONFIG_PREEMPT_RT=y
> +CONFIG_RT_GROUP_SCHED=n
>  # <= 4.19
>  CONFIG_PREEMPT_RT_FULL=y
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


