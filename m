Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE0C5320E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:16:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.53])
 by mx.groups.io with SMTP id smtpd.web10.208852.1724069782454458345
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rZkB3fnB;
 spf=pass (domain: siemens.com, ip: 40.107.104.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csSeUGMyif7TbpTAEIZ+03eKEv7tJwRFsVreYoqVEktSTEXdWmw9J3RAglgOWSlEIinIRcLae8vQGsb3UmmgXZ/KO3El95J+HDe2Gp6l/R0M71O/6LyCxtmU8bPBrudUISuco0nvvpGhsOP80t4OVaBDnMDtIxrKCxg/tIGzCkTJxib5zA/XXR5u5JOD1MjdbaropHxtf/HoWP3v5m78jaVcqkzvmFL25Lr5nefO4BrHrmnFJSQGv+PYRcOsBd11BiuYCBfrB7mgrg3mSYLckSL6kOjeyAZazQOAUHHN+ojCyekJFl5no3zMcD49cOFtXoJQPm/Wc7VJfPzvPk9H4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMmt9g8tV/pAm2OvhmRzh8On+IbGjNj9tnSxShOvEP0=;
 b=JeWRLD4u/k6alkaH1iF5Lto6jlG+uRcU3HXx5/uZK3ByhxXHPMYjLj9LR21mC3Z7C8uKdT9J6IPXFjai9hB3A2iqg+Ek/5YnMsZ/BfJEuzMtTbg32K0HlD5Yn4y7j4FJa0oDmZgaMvP5SBGMrXSSIpF3YeHM3osMzbu+BchlPtG4GI7remhw/ukBWhV0eM7jcrYUcuMJ0t51+0wVUcuMtWB06JDRv+8Bln5MQJ8h/YZQdrAkftkvfgtcz3UaWXBjNiXJSpHkdG5l1X7Uo9jhJVEpBqBs6U+6ngnMoN1rfFDImRZ9lYEwFkfm5M7xQWbkglVdt1q2fSb+Ofazp3m0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMmt9g8tV/pAm2OvhmRzh8On+IbGjNj9tnSxShOvEP0=;
 b=rZkB3fnB9JChP53/O1phJ/r6u4jGhEqApSUtZU7SW9OIeBdR4IK4dehlJsD4ajul4RBd5mFxfat9yoUNrLQRqwqRyfXNiqGZPCPCMIxZfov8DYmgCrtv2gi7fZ8LqzbVqtnoCmUeE2toBCRJYnMDSLGZn4JUyww9lLDw0gbBjbhcZ7qEB41Xw1gdiuntT6KUp3EbXWLBinZ2BWp8h3b+yqyB4MSmgqfFO96LjL8NJZc5PKbVIDRi/9G+6NALtVvX3JlAa+h75jjbeUqGHzuj9r3ObYQgIOqehe+ket/fdMk/16VsSkKnhLNSn7ukuKga1fhn0SxpJYwJ8D4Sn/tRQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:16:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:16:19 +0000
Message-ID: <8dc1de98-857c-4aac-9f68-db58dfde3c85@siemens.com>
Date: Mon, 19 Aug 2024 14:16:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] fix: Check return code value of
 e2fsck
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, Sai.Sathujoda@toshiba-tsip.com,
 florian.bezdeka@siemens.com
References: <20240819121045.1533891-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240819121045.1533891-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: b43c409e-61fb-4c4d-5f2d-08dcc048bb62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NjduVlc5bkVLWEdWQW9oSDQxcWRxQjV1VFVRL3NBVWhmK1lWU0VsbG1JbGhr?=
 =?utf-8?B?Yy9aMzdPeXNBaVBvb0kwZkpEeVAzRHdsS3FTSXpVMFFDdDhQeUVLSGpCQnRw?=
 =?utf-8?B?R0cwUEhaQUtsU3c3NmhmdzNId0pKckNlbXk5RUdDdW90THZ5Q0hxVWw1ZkV4?=
 =?utf-8?B?RmROYkhGU3hmTGg4eHJ5Rk5JSFJ0eC9Tbml0YlFRM1FyUHJyL3RXcnZQOFcw?=
 =?utf-8?B?TmJOYi9rK1gvK3RHZjMzZXJxRWMvYXNSeWZmVlVjQUVZaHdEdWlhTWM5L0FQ?=
 =?utf-8?B?MWFlN2o2NnI0bHU2NVlnbjRXK3lSTERuTHFVSHVRN3FYWDFHbFdETFhnaTlk?=
 =?utf-8?B?azg0d0taYnVzcFBoV04xYkY4dUYvd1luRFhKOGlpTEFkSmdaRnY2NGIreGxl?=
 =?utf-8?B?SmZpWS9qTnRFR051eXJSQVJoV2lBOFBTN01PRndtZ3hCcUtzSldyYnVKZ0ZP?=
 =?utf-8?B?ckFHWnFtVktDcmh0L1pRTnFqNkRLM1JwQmlUNUJIQmsvMmNSN051R0h3SEl0?=
 =?utf-8?B?aU9jWjF6S2RNeXlQZWRydXFkOVc4RFFvdjI4UTVQVTQ4aVluU1d2aFhRUnNO?=
 =?utf-8?B?UHNlRlNhR2N3bjN6OXpwbm5BMHh4YmREUnBpbjUycWxKL0tlU2JTRlZSVFE5?=
 =?utf-8?B?U0w4WHAyWmt6bk9NZzJ2dXBVbW9iL2VBdFg1dWhpc2NYYllYRTVpZHJ1NTFJ?=
 =?utf-8?B?TVh2eFdiZm9OSUc1enc5bmp1ak9UaDQ5b0lJVWo0K1hFTW9Nald3NEtCTVZv?=
 =?utf-8?B?UlB3em1rbDNJVUUwc0EwV2x6UmFOK2JsNkNSbXV5YWlRNXhkdG9qNm5pdHFX?=
 =?utf-8?B?aE1EZ2VSTy9la0tyQm9MUG1zNEh2VWFuTUZVWGpCTEtQbUYzQlpvSmZKVGor?=
 =?utf-8?B?alR5RER0QWlTS1FqZkhuQ3UxY3hkNVRuVWJxVm5vYXRRZS81dUFGWDBoak5H?=
 =?utf-8?B?ME1PUFlqMXlVa29QUkdvSmhCa3hnZzhkN2JiSE02NDFOVmcyckgxMjJqcmJW?=
 =?utf-8?B?cDJFZUFWd3JBQUk5ZTVXZ0lYRGRNbk00Q2tETG5yeVN0MjVzSGlERVVBcTI5?=
 =?utf-8?B?WkFjb0prR29hNVBiaGgzMmJRUDRzYnVsa3BSL3pDd2NTc0VYUzVGOHg3VkNi?=
 =?utf-8?B?RVM1ZC93TzJ0TmRvQjR3MDNGcmJCUzdZN0R2WmZXMG5qY0JPWS94Vk8zcUtx?=
 =?utf-8?B?VENNVHd1SnBobWV4dHhSRkJWRDZ5eGcwQ09mcWNheHFCSG9FNFI5aEFEaEdZ?=
 =?utf-8?B?QUxvUUFKbjljSm5JQU1zdlRkVW41MlVaRndLNjJ3cGZXbndrSnF5bmtLR0lU?=
 =?utf-8?B?cEYwTmxJU0JlYXV4bUlvZmw3RFVHZ2FHeWJHOGd1UkI3UkM4aHVLNERtSVV6?=
 =?utf-8?B?dzByMGNxVGpFK093OTlQeG1mM01Ka3lYM2ZvbTNLcFZsamwzR0lZMEVkM0Mv?=
 =?utf-8?B?R1dRc1VlZEViZEtjTk5qMnQvanUyeERqWVdQRXVQRUJ6UTQycFhYaGt5NER3?=
 =?utf-8?B?VUJnSDdrYkQ2a1MwMEVwcjV0SnJZZmp2bGY1MXZTK0ZaNXRXM0krVVRiVTkx?=
 =?utf-8?B?QmRRTC9ZeC93dHFVSVVaUGxkQ2pWT21kMjUycWxVTWt1QkRod2hYRnZveC9p?=
 =?utf-8?B?SkREbW1hSXdTTE5seWNZVFpxMEpkTWpuTjlsTkVsemhOeTdNWVNPTm1lR1pw?=
 =?utf-8?B?UFZRNlhXRHpOVytBK084d1RSM2syVmo3WlNJajdTWXVabVJjS0tGeUNqdkVC?=
 =?utf-8?Q?4K9jAt5nC8KxUeMGhc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlVJZnZ1STMvY3VQSUpDMGYxNzkyeDVyaGNBNEVjb0FsR1NGTHBDNkphLzNj?=
 =?utf-8?B?bHFicGN3enA1eWcySmh4SG96ZzlCdkk0YmRpcTgrV3FHKy9LUUNaV2xKNGpi?=
 =?utf-8?B?UzlLVnZDR1BPNGk4YTlpM2RlVmFCdllXcWFGdFE1NHpIN2x3NTRId1FmTm5x?=
 =?utf-8?B?ZXMyU3lETk9TZWZZaVZSdk1TcDVQdjBncHUvaTk0WUh5ZVhpa2lPVHFPUmV2?=
 =?utf-8?B?OE9UR1R6MWUwRG5LZmx0eVNHekhxZ3JNSm1JUDZWTmxKTDhJSzJjd3FIRkNk?=
 =?utf-8?B?aCtIZ2pFWG41RytZYlZXVjVYc2dyWXpOa1doY0FlZ0JPVXN5ZU16WVMyRkxJ?=
 =?utf-8?B?ZFpDTmZwaFAxb3VsbXIramVGbXNIRUgrTFg3ZVk5Sk4yajFOQVhmbW1IcmlR?=
 =?utf-8?B?bnRKZ3BlQmo1R09IajExY05hRDJRR3E2WWFCVllYL092L0FLbThKN2RRbWRn?=
 =?utf-8?B?Vk15UDB6RTYvT2orZHQrdFpxUzB4ZWhRZU1tdHVaMis3djdXVWhnRjZ0K3N5?=
 =?utf-8?B?aDNjamZTS3V0YWRxZDVmYzlSL2J5YVFmMWMreXRJV1pQVnI4eGFJUmx0NTcz?=
 =?utf-8?B?VDlXY0NoUWZWVEZOSk03ZTVxbjBtcDdmZVJ5SFpsY3lrYnVYZ2R4NHE1MmVq?=
 =?utf-8?B?dzlGUHRUU3hmckJwQXdCYVJINWRuTHIrYytJd2NQcVJxMDVZSDVNV1M3S2Ja?=
 =?utf-8?B?ZTlJeFhwTmZ6TFhFSjhoMXpzQnRyOEhiSTQrVWRQT053b3pRNStkWWhyWVU0?=
 =?utf-8?B?Q0FGc2ROSkNWVWM2bHFPWnF6ZFFSVjdZbEpCT05NOWt5eEJ6SVRKTm9RV2Qw?=
 =?utf-8?B?K0h3a29GenZDaTRySU43NUJ1MEZxK3gwQU9WRFFEbmZEUmIvSlZBNFF0eXNT?=
 =?utf-8?B?TTIwYUlPTXJzMnNXeFlTTGxLNm5GTmhaUkt4SWtFSUJXdUZCNzFnVHJvVFpy?=
 =?utf-8?B?MkQyaFNYVGFPZUYzWmlBV21JdW5ZZkIzS0M1ZGptdHcvaFlEYVZtVmVrd2RX?=
 =?utf-8?B?NHlwNkdtSXI5SytXQkxLc2VQRjlPTDN0UnJBVytieStVc3RTaVJoYnBjVTl2?=
 =?utf-8?B?QzdGZzZSa3FQampzNDFodlZtUGh6aFo2Q2lyMXdCNGMyd0hkdFJGZC8wRTZO?=
 =?utf-8?B?Q2ZmOFBiMm5HcGF5NGhsdnpBTTNoa2lzYlNqdmhtS2lNRlVlOEFDTjhXM1dX?=
 =?utf-8?B?VHRLWW44SXpnQjNkNy9wd01xY2FrSzdFa3JVcm1RWWxFR3IrcjBUQ3RUN2xG?=
 =?utf-8?B?NVJBcFdQR0c4QXlzaytGVVRtclA2WmlnUjQ0QS9QSXZrZGc3RUJjS0YvVmts?=
 =?utf-8?B?UWZMV21BOUNVNzkxcmVWR2JjTStLSEc1blJVUCtCZ2ppTTZyTlAwdUxzU1Zl?=
 =?utf-8?B?enBpa0dJL3R6Q0ROVitYTTVJRnJTSHpTbE8rWHVVaEtCeWR4d3ZGTVRVMUho?=
 =?utf-8?B?QzNndWZ6WElpTUtYVkJJU0JuSXc3OUJ2RXVhdjUzUUpINWlHek1LbEdLU05Z?=
 =?utf-8?B?cmlkTFQ3RjdSV2M1ck02T3RyR1RNN1RGWjUzMFZuY000aHJBZURHaDVvSStr?=
 =?utf-8?B?K3dEQnhjQUZNTzVVdURFR0lKTzduaXVOeWNYMC8wZExLWW93OFJGU1ZHQThU?=
 =?utf-8?B?ZmMwV0k1SjFHVC9NU0tiWHlxeWxlUFhQWXBkM0hXQXVJa1BqRytGbDFqcFg1?=
 =?utf-8?B?S09HbXRzRFlyR2NsNlJNYTdQaGEzSWRFMFJ2WkJWT3lWU05VUGYxWDJPbEs5?=
 =?utf-8?B?TE5TZkFSbGtnNHE3aUprWUNCN2hJd2s4ZmVWdG9uQnJBOXVGdStTT3dPbWda?=
 =?utf-8?B?aXRuOXR2VUdqQlZRVEVCdlRkQ2YvSm1CYjRNeGhsZ1EzVDVWcThGUDkwb294?=
 =?utf-8?B?S2FhZmloTHNLUEY2UG85b29nZjVUY0hBWXRCc1FGQUJ1WDY4OEZRVDAyZzJO?=
 =?utf-8?B?eGhWUGJHR0pXSmtSZHpPZ3F5aXB2ekR2T29YSld1UVlCeG5LZUc4cnJjeWJ3?=
 =?utf-8?B?NjhXWHpsVXo5RVZXOWcrWlQ3WnZuUktoeE0yMnAzWnRMc1cwVG1vcFFuMmdk?=
 =?utf-8?B?Z3FJSC95WStPaEp3ZVNVeUFlZVVCeHVxRFpHNmwwUDBxaU50c1ZkYzBMNnZ0?=
 =?utf-8?Q?ZIJfc9/FjatMr3nAxjLv92qsd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c409e-61fb-4c4d-5f2d-08dcc048bb62
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:16:19.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixOeB8U7HTQbaMbQRosTLmGMqai/jXmgvo/lG76uWiPjXm2+QfaFeCZecrKE90HtuJ/7x5HlSG1joaeimD9OCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:16:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16800

On 19.08.24 14:09, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the overlay script in case of a recoverable file system error.
> In that case we execute the erronously the recouvery script and mke2fs
> ask if the filesystem should be overwritten.
> 
> The issue was introduced with:
> 
> 8644fb1 initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> This fixes the issue but we need to address the problem in case of a
> return code of 2 which requires a reboot of the system. Should we:
> 1. panic
> 2. silently reboot
> 3. execute the user defined recovery action (add the return value as a
>   additional argument)
> 4. do nothing
> In my testing i used 4.

Why does e2fsck require a reboot in some cases?

> 
> Also should we force mke2fs?

I would say so. Who knows in which state that target partition was left.

> 
>  .../initramfs-overlay-hook/files/overlay.script.tmpl   | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index c655a4f..02df53d 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -40,7 +40,15 @@ partition_fstype=$(get_fstype "${ovl_partition_device}")
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>  	case $partition_fstype in
>  	ext*)
> -		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
> +		e2fsck -p -f "$ovl_partition_device"
> +		fsck_ret="$?"
> +		# e2fsck returns 1 in case ofrepairing the file system or a 2 in case
> +		# a reboot is required.
> +		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
> +		if [ "$fsck_ret" -gt "1" ]; then
> +			# TODO should we force are reboot or customer action
> +			panic "fsck requires a reboot"
> +		elif [ "$fsck_ret" -gt "2" ]  && [ -x "$ovl_recovery_script" ]; then
>  			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
>  		fi
>  		;;

Please typo check everything.

Does this fix
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/113?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


