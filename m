Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 13:25:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.88545.1740403510764948030
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 05:25:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NVAW6deX;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7Tf/3ruzwGf5j1r2A+PlPThim7sQvO5PndzgTosCdSxQ44p8KVorutVlDnGhgi8pfMr0btqRWsiOgNOVEkwlBjPpiOxeq3IQUahiwTRyS0oM+4YzLZp5MY0Atg5dQSCW9YEKUidu+TeF+AMQgVqSMh9OeA4DR7qh5E/+rOqMVHePa07LVH91Hs+pu4bOCg3rVAHRBxrO5R20qY7DlJeyvD1Fd8gmwqEljtLGwPaRe6LSw6YPKE+GrzjAjBi516pWRtixlI7RUevBUtvg+m1M0oSEYUxy8pAbRy0s13v/hUiw8q3KLVSdXjFMizdKgYCSgeH3GlkED6qCaznmdk62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjoBiAyegHU412pth2ITD39NwxYANvRcPoXxawRhuBY=;
 b=bHZkcxpw3hCiQtZXJC46EtxF9MqhLAQo3Vm0FVyFblANmneazKW9THIzImdZRVU52OmZrrfMWKG1SQmG0IUsf7vy/EW2tF0EH2obzXeF4Xjww8uBqULklDpudtafjYY5MWRnKVfoBZMWATAp97iW7N9GYk08A2vpdDqNDIoTeugT8UwPU59K2gsodw4EwuyVqCLHeKv6FZhtZWq+eRpaYNrh5ws4uvLiNnQ+eCmvWLbjjACzPxIMqnM+aEPlUuEEXOiMHEodQNh1KoCZz2Z+nAIJqZksD21ZPMEoOJSfYj8YGdAsvAKoKpdOj7SK7pzYvj83zMRgaDJKEERojgqjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjoBiAyegHU412pth2ITD39NwxYANvRcPoXxawRhuBY=;
 b=NVAW6deXhmoP6QoA2q3Y/UPx3hm0o6YMyl6inld9rjXJm4YArxIHTjnuSVfyUnOVw/vGNJjmojRu2WCvPtj6to+KA2hjfiW0mmi0EJQczMXnM41BhcemtaSRjAOPRhROF0RwXiQn088T1VvXYBabIvAldJWj5hyOVdYd/sccKBKqYGl988v2k4hD+UFUWeAM0paPsCw1gIXqj2mvrE9RaLJiuTHZ5hzbFC9UuWrBWRNegyq572Z2jrpyVZoiKwG57VAbe3tADxwIPnxDrG1Iq42CykMiWmt+jXpRbM3uBshHBicNRGaO4TpGhuYG+ot6lUZLqFy1GJMeZdRqZzouWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7597.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:25:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:25:06 +0000
Message-ID: <3807cd22-d5d5-4cac-88ab-09643573c527@siemens.com>
Date: Mon, 24 Feb 2025 14:25:06 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Revert "Removed "ro" option from
 read-only-rootfs's fstab."
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Heinisch, Alexander (T CED SES-AT)" <alexander.heinisch@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb77b8c-6507-4a74-1ec1-08dd54d6a797
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SzdnWTRHZ0JYQnNUeTBrT0V6akR6S0tJNkpyYXBraEFCSnhGY2ZEcUFDZTl5?=
 =?utf-8?B?Y0o3clpTNDJWVXZ2OVBNcjgrK09aaFVteWRGZzZLOXVucHhFMUxCUDlpMHFj?=
 =?utf-8?B?VEUyRk51cytWV1NVdGRWTTFLQlZHR1BaNCs5VWsrRDlHNkVTV3VDQ1lZR05Q?=
 =?utf-8?B?dWNaRVRhZXFJYjdKakl0aVAxQllKbDB4eVhzZjB4RWNSd3hJWWJuWnBlYkhD?=
 =?utf-8?B?VFV4K1FDcVAxa0FRdDdHeGJndFBYdUdPOHlzK2t3T3BNVHcvM21IazJPWUVW?=
 =?utf-8?B?bWVRMGdVSkJPdHE5bit4V05ESERCUzVXeEM5bXZBMCtGUGJkeWlCZkF1bk96?=
 =?utf-8?B?dC9ySSsyWFROWTQ1ZVQwTWl1b2tNRmw3YzRkNzRTRnRZdHQ4VTREQUxJbXdy?=
 =?utf-8?B?MGlQcWtGcER4Rk9vWEVTYWY2bFc0SFovOXJ6UG92cXhSVVQ5WnRrOEZnOThX?=
 =?utf-8?B?U3lRNnFyQ1RyRTJFbU04TWRTNGphNWpXRjkrZDVCWG1aaGZpUUQrT21jaGEr?=
 =?utf-8?B?ZHJTTm9aNU5YN3ExU0pnbnhxbFJPTUR2d1VNNzhISTk0aEdEeG5FVGN1dFU1?=
 =?utf-8?B?VEZpSm4wbGdobTZNQUdGS0RJSVlKalFxcGlHQ0dGd1FhUkxaUUk1Mm9HaXUw?=
 =?utf-8?B?MmpRbTU2czF4bzgzajlseUkrYUJMSy9rdDRBYXlzUzViQ0hHMVVLa0d4Y1kx?=
 =?utf-8?B?RUZUVFlQSkRKOUYyVGRFYTJJbG9sU09iNWlvMnQzc2dRVnVWWUh4bWQ0bUtr?=
 =?utf-8?B?WTJ1Tjh0eUMzc1hrekJPaFN5cW5KaWcxcHIwZ0ZxRWZueWlubmVoVVpSSk9n?=
 =?utf-8?B?ZkpJajB6MmE1alZhUGFscyswbHZETnpJT05SRW91UVcvOGV3K3NHUWRxbjk5?=
 =?utf-8?B?bkc0MTlWWDVQUERiUkg3eGk5YUl0citBYTVnY3hVTEFocENkVFBqS1dFQnJa?=
 =?utf-8?B?VXVZSExzNXlkaG1yVmdkTVBwL2RjTmV5RUJsekxzMkl3aFFkR2F0SlE0eFh6?=
 =?utf-8?B?dTFKU1ZBR2JFRU9tR1ZMZ28wMXB6Qy9OVVVzSnkxN1hMa2FkK2swek1YSVE4?=
 =?utf-8?B?YzV3eXpaVjlMSFJ1UFRjU0hPOWxGWlZwMnV4ekF4TlpSVmZLWFBNS0RKS1dC?=
 =?utf-8?B?VlVFTlBNL0ZhQUhMN0dhVDhHL1RyWnlFWWpiVk02aDdqcGk2aUt2WFcwZThV?=
 =?utf-8?B?MkdLZXdxdm9tVFA0VXJnMitSTU43Mm5TVi9VK0tzalVBL3B6b254WThHbFJB?=
 =?utf-8?B?c2NvRC9iYzRvUUpwWEcvbW0vL21teWV6SVhPOFVEK0gvZVFyNFV6TnZtNEkr?=
 =?utf-8?B?UVdLb3l3SDhoNjVlV1RMSXN1VGp3eURPSHBEbmVoVUMvYmlrTTRQRTVCdktO?=
 =?utf-8?B?VVBJa2Nma2RoeDc3MUZmTjhNOGl2NFlOc3NOTU1DVmk5b1I4dm9lRWlLUnlo?=
 =?utf-8?B?Q1F1bDFQaUJ5MHd1NStKbWRSMGJuV1RqSEZFSmtxZDREZ3h6ZUttWkI0bXQy?=
 =?utf-8?B?OGZFWlZnR05zaWVvV1FCZi8wUWVsY0VyK3hQdFhyTHoveFM5ZmFTUUk1cEp4?=
 =?utf-8?B?NmFzcG8rZFIyT2k5czdKVkpqRXhSbHZUa2RQRXNPQW1sWXdzelRqKzdkOGVX?=
 =?utf-8?B?QW5xKzhiQ0h2Y2tsMVdXeENOZ3pKVk4vM29Jcjd2QU5kNkZ5QklEU25LbzI1?=
 =?utf-8?B?NlIyMC9rUWk0cDhJb3g0c2JBcWtob0pTQTNweWx5L2NWOXlDVXJnSDE3RVJI?=
 =?utf-8?B?TE5jRktSM1ZDRDg5ZStzSTNMejlWcGozR0FFdU1XN3RZaUpvWUQ1YjFUU25j?=
 =?utf-8?B?NVZDSllVT1dzNWJQV3B5TFQvaEFoRDNwMStJa2czRlBkTk9xaFZXWFkyQVFx?=
 =?utf-8?Q?5jaTQnJbE0Fcj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2tKeTJoZmp2S1UyeFFSM3RJVjU0bDNZNUtnb1NETkthNm1PU2tUeStzd3pj?=
 =?utf-8?B?RTB3c2h3emxIWFI3MkE0U0piMUwzTWM0ZXlPWG9QV2FVLzhXcFU0cEhZeGFY?=
 =?utf-8?B?KzJrK3l5bm83T2QwbEJLSVBGQUZLbHlhMlFETHNvWG5VQys4b0JCSERkd05B?=
 =?utf-8?B?OVpKT0ZEOWNjZGhyVkVFMFlxZG5zWmV5SlBsTnpaRTNTWnBXY0xEN203SWFO?=
 =?utf-8?B?NkhmVGEyMVVzTlltUXhhTXlwRFBqaUZweXdCZTkrR1pRdVZ3RXRTNEk3Tnk1?=
 =?utf-8?B?V0RBQWRDZGJFOXc1SHduTVh0dUUySUtqRWcvdUNGRS93QlBscy9ybjNubnZI?=
 =?utf-8?B?Nm8zZC9YM1RkNzdaRG04Rk9Qcm5yS0xNQ2thOTRvM1RySnBpYzB1RTRmR1R2?=
 =?utf-8?B?c0gxMHJIQi9tYWs4UjNjQURaWDlkZjU2YlZPT1VCaExCazNLaFkzdzZDdmxJ?=
 =?utf-8?B?SXovd1BvQUVmdm5pS2pDT2YzZkY0VWw5NHZ3Vnc4aEJ2Q2JRaXYwS0gxczc0?=
 =?utf-8?B?MjZCWVR6ZDk1STZxcENiSE9HcnpMVmwzdjMvbjVXdXBYcFZ3RzhTNktrQlNM?=
 =?utf-8?B?UVQxZ2h2cWRpUkxoTnBvOTZLSzkzMDZ0WUtwdGRuS3hRejhZNFdaVUM3QmFa?=
 =?utf-8?B?a2Q2OXd5WTExQWRQQ2NkbXI1MlBTZjd5SzRKK3ZJc1lsam5aV0JEbWVvb2k5?=
 =?utf-8?B?WkROaHJROEVoTXprVzU2d2lNbzYwWGxkYUJGbXJuUG55YmxFQzBkSG9UNU5i?=
 =?utf-8?B?dmwwQzNZazZyYmVJWno4VTdHNm9JWlRPSCs4VWtwQ2NabWx1NFczbmZQRHFN?=
 =?utf-8?B?azVZQ1RVdVVHK2YxK085MmlieDRRRDFGSS8xQS9lRm44QlF0K0NCditPOGlY?=
 =?utf-8?B?ZWJtNFRxT1U1VVo3OUcwc2tvM1VJejJueE5lTEFNT2JhVjZ5UmM4UW1rRXhk?=
 =?utf-8?B?YkxQOE4xUGhkeGRRekhMdE0zTE1qT0tiTWczN0JuclIrNW5zUFlYc2t4MkJj?=
 =?utf-8?B?cUEvblFxblpGa1ptZWg5anlqZS9DN0tBcXVTSDg4MzEwSmV6aERIOU1GUHJC?=
 =?utf-8?B?NXg0Mml4a1k5Z1huMCtlUkNDSHRDUDhZL1NybFF0RitOYnl4enl6UmhoWlBZ?=
 =?utf-8?B?b2lKUHpnN3FQaTBhWDlueXp2OUc2QUx6Q3VFTklId01KTTBDWlI4Qzh1aUFR?=
 =?utf-8?B?N2hhMHBzb0QrVTVSeWlZRS9zWnp1MGM5UG56UGt1OWRrWFllQU8xeGdWcTd6?=
 =?utf-8?B?ejdnZzU5NWZVclFaTmxRcDZoY2ZNb2tSM1dsWit3M05PZWdrdHRxcHBvcHh2?=
 =?utf-8?B?VzhGNUpIZ0dHWk9qK2JHMGpsZzhjWW42bFNEUlZZN29LZ1RWTDViT3kyaHJB?=
 =?utf-8?B?bThSa1E4S2pId2tSNDdwVW9nUERZclMyMHRpVFJFcVFQRXRuUjUvZXZrbGph?=
 =?utf-8?B?ZW9hRGRtYnVicE82OTc0NGN3MjZpOEh4Tk10RXpwcjdkNmp4TkpWTmhUVXNP?=
 =?utf-8?B?TlFtWlltR1FLaUkzQW9zVFJERSsreC8xSXpsd05wL0MvYXVNYjl5YjA0UFRH?=
 =?utf-8?B?ZVhjMFNpNjFuTFYzODdTYWRReXBQcHRLV2xEUFQ0UXRWWk5TaStLQWJISklU?=
 =?utf-8?B?Wk0vTVVhaEdORGQ0MHZKS3ZxbDg5WmQrU1g2ZkMvYXdrbUFXYXdUZzNmZVd5?=
 =?utf-8?B?bENjV3dHb3BZbE83TXlVdzdvUnpwYVk2ZHRSenNaWk1Db1FJbVRYdVBVNzZ4?=
 =?utf-8?B?dHlkZzNEVHFXdndpWU9IRUJkakM4ZGZGcFlCbE5uYkpOTTJ1RmUxRTM0V0pY?=
 =?utf-8?B?WStxbVN4TlFJQnZzZkcrTE83Sld0WFdZZEhJWUpvbXRlYWEvQ0ViOXNYdzB4?=
 =?utf-8?B?OStxaVRwakZrSGtEUWZlcmx6WkVJQVlUcGh2cjluSjc0NHNQVCtWcUdRSkxM?=
 =?utf-8?B?WVd0eGIxclhndmM5MnpRUDg1bmwrbkExU3JjU1p2elRzR25lUlVDa2crS2NB?=
 =?utf-8?B?RzU1eUlLbWRPZjdtakZwSmNKTTJSbWsxSDFsR0tOT3ZMbWtnTnhwdCt2UG9E?=
 =?utf-8?B?aTNqSDhhUDViUWZuTEpld1lsdHltb1hPd1BGUUo0OFo2ODFBM3V4dXVBcW5X?=
 =?utf-8?B?LytmMXpkdUh3Z2VXM3hyOUFPcGoxRWpBV2MySE9oM09VMHJkSHZJek5FUnBU?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb77b8c-6507-4a74-1ec1-08dd54d6a797
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:25:06.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG2MbdvT+fPUtSP7PNk2GKMItg2g/+JclfILjlhqffSwdBzllj1sPUs3GOL3dSz1Lm5QJSYBlw+haXCJuBTHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7597
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 13:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17899

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts commit a36d28e946e6edb7fb27883e6ecb398001269f92.

It turned out that systemd-remount-fs dislikes it when "defaults" or
even spelled-out "defaults" without rw suggests it should mount /
writable. Result is a failing service and degraded boot.

If some future use case actually needs rw due to adding some overlay for
root again, that will have to address the issue differently.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/read-only-rootfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 83ddc336..35a3ab3d 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
-/dev/root	/		auto		defaults			0	0
+/dev/root	/		auto		defaults,ro			0	0
 LABEL=var	/var		auto		defaults			0	0
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
-- 
2.43.0

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

