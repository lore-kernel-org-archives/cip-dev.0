Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A738C982CF
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 11:53:59 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37742.1789646035417443598
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 04:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=shFJttX0;
 spf=pass (domain: siemens.com, ip: 52.101.70.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRQYYmIY0pLGNa7GXS1lSzQZPiZdyX0QpoZKl2KWGJ2R3BzkdWhxL0dcbzDdUFuWwsiMYwxxLPtzg0o0RRjox+1Vc/zMysosUvTuEVOG28fI7mtqmgv6TlDBmGi8zYGY+8vtXRvczmHPEOotAgCNjkybEttTttn+Pirc0m2SUYfNc2ZR19x9jSBdiS2CgxFpVVMqU54c2yRviGgVAKK6HI7oNE3zh2NF8BTV7cKMPW6lRFleyfLpl/k1crsyTrCBmmwlnfrUrjWHhfG6nFgCp8B07csNFxbkGzDU+9kwOoyT616IFYW7JKeNzZVcLVkaEmEOsfDsDA1LKiqlvDQ/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtCaluiJlrdFWOpX6Uu0A/EkySUUNUN4KtZXl1vVovs=;
 b=qzAHFHZLfGXKXR+E8bIm+wwximoN7nTdNdcucOdj2A3qDBIt/+TuCjDJGzG/4S7ZQlJPk4bJTAIZXM3isMKWln5/yp90OF7AsjhfiGGVICtnJor1iHLW+pLD5BUf0VErZpFvf4fkVDHYqi6pqpiV2djka/vXW0SxfTd1r+UH3uERW7aSGUtfy1HtFbS31EOzpbgE5lyfE9SOKLgHTHSSRUDxWrqlycl3QrnGXBICtGBSM8N33tUNq3fOlSC6KNc5tPPfa6LNzv/uo0MjStkHjA7RnT15DZs4BrVvDdsLnV2XugioB/JtiegmxSx1o2PVwn++qHH5N3BOR5zsW6DuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtCaluiJlrdFWOpX6Uu0A/EkySUUNUN4KtZXl1vVovs=;
 b=shFJttX0k4/L1UAvS0Z24D1MEejlJ4aY/Ya1TGuJO+O5Ks4D+/LlYKXCR/K4mzlVTu0RY4f8j8aTGDrgG80LPG9dxbSTK0SBnlgq5TmdOgR5Ld/r9wj7hgX0mjY/R58zmrJPY+VQIP6zM5RloHXuwej7JJJnby5WOUmhF3NvyqrzfdTnQpfoA+itIN0wZcK/aAOToaCR5Oq1dwK1A+l2ryYRxogjn/bO5JESE069TDyoPxDGryqdw+LKz+kkQ9ymsP9TUP8/RRhQAOFWkEc2JrtCd4oXSdAFCvWmAPLIDFGVJIK50d8B1fLWNw7EKo15Xi7OZJ9EDlibvQl0f2XwgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8972.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:448::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:53:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 11:53:48 +0000
Message-ID: <924a8fb4-aa9a-4840-84e5-814eb7495ee1@siemens.com>
Date: Thu, 17 Sep 2026 13:53:47 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to
 4.19.325-cip136[-rt50], 5.10.268-cip77[-rt34], 6.1.187-cip60
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cdd5b5-5028-4cf0-fceb-08df14b25588
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	47st2QZgFdgi8YE+ii9NUJufLFPzE8JAQ2hjGamWN0V+J5p/NXngBfPVVLprLShkjbmxWOvGYeNmobVoQn0dEn8nFddGorMb8FpZ3H0qS2PlndO6mUi5mAlcxues5+HgQWAK3JKvsgcsJb4jyECx0HFvOS7Q6/oJQsghYyuIz5XtpSdRJ6ROZefOWE9CtH0nMNNXA4Ph67T4sNl5tBe7Z0Cl6kXB3Mis0QkLSzV4MbsxTCtCbGIpFeAfnUr1D3syf4fxIRb1acjsTGIoVfidgDWAFiplO23ABcllYvtM3gQTWS2+dN8ApOanA67J7md6DJzbitn5br63LS/sPriFgGe0NRcV/+yhU6M3wxZbj+50HTlVJnbMbkkLnx3LRb+L0+TXUW5co+owFxtKTY6g5w2ThNT0hZMdpo9NlYcZ6w5/WisEVLSBMs6PFgOPvOsCbPS2Sqmp+iENSam38uKpZgBk5HdMg98PctUScWOxPsb0+ePTHvjnaiGj8MBAaJo9J6/mnOO+829vlKkApFaeKiqbCEKIOgKaZcxg7kjyobPzvZxcof5qI/FXU9qK+0oK/wjB6XTs1Q82dUz2vDQiW/AKDVo9fhV2DUPkjC/3SSrOcFU5AxzpKHMQgqcD9/+JEJXQYkC1CzWasmYfDTd1puac9VQTgcL1OVmQhBtnWaU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MU5KZkhEejVIRzZiRFdXYk8yMnlrWExibTlzSFNpQlRNME1OSE9WVkJsN2Ju?=
 =?utf-8?B?ZVU1ZkFHa244b1dzQUNsWW1KS25TbGNJWWdaRkdCU3E3b2phWm5BMTl2R1FR?=
 =?utf-8?B?Z3lIT2NCZzFTU1huK0RJNnZ4bE13QmZXTm9hbm5jai9qZVUyUVpZUTdaOVRM?=
 =?utf-8?B?NCtRNUNNenpkeEhPdHNwZmF1R0Q0YUtTbXJvWTNhRHdxVUtweFMrbGRrSmdy?=
 =?utf-8?B?OHNRd1JDbzJwU1QxOW15UmRaaEwyUURiekRPbkJXaHBQQnZhcDQ3TzYzN0FC?=
 =?utf-8?B?OWlmUHF1ajlKUHZReXFncVljOTEyMDF4eDJnSlN5c1VZU2d0bHpNUU1SL09L?=
 =?utf-8?B?VWc0NXRNTUV2elNDTWw0VG83L3Z1VmxjR0Z1UVpWSXF1clBrdXBUSFBmUm1I?=
 =?utf-8?B?TjFrV2hKWklUNG93b2M2aHVEcThvKzFxM0FLVmU3SEd4M3VHdWJQeGJkbHpx?=
 =?utf-8?B?N1JlNnlPWTNRbGsrWm44SWRESzR6Y1kybkxuR2UyRUtLcm9wTWFwMU9teWt2?=
 =?utf-8?B?eENSZ2NrM1NIb1FKMFFoUVRITVZ2ZlM2Y2JlRnZ6SXFGdmo2TDlML1BYbVI3?=
 =?utf-8?B?aFNlaDZpTTQ1Ukh1amU2TnJuM3hWS09UTjJhZkQrdXUzSGtqbnZXREd4T0s3?=
 =?utf-8?B?UXhsRXhGbXpzZFVDMWRjNFB2Wjh6RVQxT1pKeFhpNngvbmJ3ZFNGalZETHBM?=
 =?utf-8?B?Und5NXZNekdINEJ4QjdpWDJkcDh0di80a1JveDJvSU5tNFBwODh5dFJRK3l4?=
 =?utf-8?B?MFhldldxeGs0blIwTHRqUklFNkZTdUR6eHVDdFExclJjdllqOGpHamhyY2Jz?=
 =?utf-8?B?ck5saEJYU2t5ckZTdmJ3R1ZRd1A4NDY3U0JtRHNBd1BFU2dSVWlnbk5qSjFv?=
 =?utf-8?B?UHpEMVBPeFlrNHVMVnFGbGpmSjkrQWowcG1UdWEwYUo2RmhyTjVpNWU3NWJk?=
 =?utf-8?B?cE92emJrQit6QnZpQ0FkYlYwUzJucU9LZmJkdWNjaTBQdmlpcTJKYUVxRldH?=
 =?utf-8?B?UktmbG5TSTAwWDE1bG5rdXlYNXJBdE5aZHFHM1dHZjhVMEdheW02MHByNkti?=
 =?utf-8?B?cXNRTFdNM2lJZDdGdE0yT0NScEZNVmFsZXhEY3B6YmxzTTZHaUp6S3VmektE?=
 =?utf-8?B?NWhLVGs1cTVZTnhhbk4xdEp4YytoZXZ4TVArdjV5NllIaXY4WDZ6ekRLeGdv?=
 =?utf-8?B?T1ROSlA0aUQ1c3p5NGxqWHpUSWRuVitFUXdRWkJobFh4MWZNVG43WEluaHFh?=
 =?utf-8?B?YlFWamlQdHBNdk82VkJKNHBROW1jVnp0OXJnRGw4YmJYMnNIQ0FnZjkvOFhH?=
 =?utf-8?B?Nmpsc0ZmVU8zS0dwK3N1UVVlTzdGUm5zSjQvVDl1VFpLd0V6b1FuaTUxTWJY?=
 =?utf-8?B?amtiS2pRVnZhL1FyblVKR2J1RHJyVzY2OWROSTVsZ0h5alJ5M2ZuMnhwYkJo?=
 =?utf-8?B?Y3pLOGZSVnkwTGN3Sm91d0pzU3U0NVh5cWM1bmQvMkVYdW9JR08rUjJqQmlC?=
 =?utf-8?B?bm1hck9EVFlQbWwzL2dQVlVTMElmMmZ5blE1akpTUm5zcEF2VDZkZ0NoZEJH?=
 =?utf-8?B?Qk81dXhPNGhEaWhVZXp3dzV4aDFEUlFYbmdDRUFHMWdGSUt3YjFOcE9naWxz?=
 =?utf-8?B?TVNWY2RHLy9ucktVNnAvckhIYTZlcVdjQnk3TG5PZCtyTmNvaTFxUUp0aWxa?=
 =?utf-8?B?WlQ5K3Z1dUFmWStyRG12aEpFM2VRd3RtdXdtY1NxenZnZys1WU92d25SZHo5?=
 =?utf-8?B?MWZCb1drWEk2eGtHc3prc1V0TDZWd29ZT0JjWjZmT2ZqLzFERzQyejNNVWQr?=
 =?utf-8?B?WWdVcUl4RmxOMVY3SDBSSE1mMVpENWhXTHZ6M3o4dFcrMld0OEJtMzV6RE5S?=
 =?utf-8?B?TWs1R1V4NzkvMW5hMlRRbVpFak10a2lUUGtJRHM3alhDVHRTSERQdlRFNDBY?=
 =?utf-8?B?ckVqSXlyYVg2VEdhZnF5MnB2V1QxMldDdWVXZnVhMFlRbVZSN09hNnBhMExi?=
 =?utf-8?B?bmJGbElRbFZtWXl5M2VOeUFyT2FJMWVKdlBnV2VqNTFuNGpVdWhBdGFwZDVu?=
 =?utf-8?B?UUd1akdHdHJMK1Z0N2NKWDNWNm5RZDlGbFNDQXVKZFVsUU0yQUd4N1o3NDFR?=
 =?utf-8?B?eGhaMElxWm00SDRLTVUvUjFlTy82aUFDNHQzOUJ2aS9zR3d2RWZhMS9mWHBF?=
 =?utf-8?B?VGo2UHJtdllpdG1rTC9wSlJPbjJYUUtuM09CYjh0aTBReHVzT0xyNDJBZFNp?=
 =?utf-8?B?d1BqWXBNSG11bnNram9YV3l2R3VnZjBpNFY1MmY2Z09VNmQvek14NFpsd1Nx?=
 =?utf-8?B?WmZhSVUyS0QvWTJqVHRtWVRqN0FtRDM4Q3pJb0J2UFhxUitzSHdJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cdd5b5-5028-4cf0-fceb-08df14b25588
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:53:48.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx456C/bP4IBJtPBPJU+NaNt6UHSNPSfK4TmflWb4sg1v9njbK2HZQ04urvC//WHnKiXsTfAHqQ7sFTU+G+NhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8972
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 11:53:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24223

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip134-rt49.bb => linux-cip-rt_4.19.325-cip136-rt50.bb} | 2 +-
 ...10.260-cip75-rt33.bb => linux-cip-rt_5.10.268-cip77-rt34.bb} | 2 +-
 ...inux-cip_4.19.325-cip135.bb => linux-cip_4.19.325-cip136.bb} | 2 +-
 ...{linux-cip_5.10.263-cip76.bb => linux-cip_5.10.268-cip77.bb} | 2 +-
 .../{linux-cip_6.1.182-cip59.bb => linux-cip_6.1.187-cip60.bb}  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip134-rt49.bb => linux-cip-rt_4.19.325-cip136-rt50.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.260-cip75-rt33.bb => linux-cip-rt_5.10.268-cip77-rt34.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip135.bb => linux-cip_4.19.325-cip136.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.263-cip76.bb => linux-cip_5.10.268-cip77.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.182-cip59.bb => linux-cip_6.1.187-cip60.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
index c22fabc0..6b54d1d8 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8118ee6205bea222967d0b453b2512ba783c96fcd27b95823b0167fde7c5d2b6"
+SRC_URI[sha256sum] = "424e3e7f2f6e1282021ddf61ceed8cd71332e33fbaf42868784fe22a780fd82b"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb b/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
index f90be775..9f3cb2b5 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "26e596bc891d4c539badf604ce34cc53049711de50d3f9495984563ee5af4d45"
+SRC_URI[sha256sum] = "735246b660eae9314f9a312eedca69773996d3604399810271c0b544c30400b8"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
index 4ac075ef..9fb5905a 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6e3e5003854bd28e7f3b4880ab5f779e4e31ac7d4770f2fd1035a9b51c0d53e9"
+SRC_URI[sha256sum] = "9e753afd86e574a8e67cdadbb8cc43ee8337521cd5afaef931c4c217fb2bbeb2"
diff --git a/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb b/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
rename to recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
index a5fd834b..e7207d36 100644
--- a/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "bd235da3e82d643c4ef0bc71a6d21a11c6ad1c6e644ff625c72ba74daeeb96eb"
+SRC_URI[sha256sum] = "7151537fafb9f395ba41a8ce86b8236b0d2dab9834e9c66b1a12b442aea41ee7"
diff --git a/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb b/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
rename to recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
index 28391df4..d6120def 100644
--- a/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d69fded945b0e9e905e3301918802ffbade6d8f3342c571accfe12a066370005"
+SRC_URI[sha256sum] = "b11ba859c202d5feadd8905f93902a2df6a1434c2fff9eb8eb310b8cf969bd74"
-- 
2.47.3

