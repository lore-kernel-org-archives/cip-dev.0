Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248ACE8D6C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 17:53:46 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4424.1763142822282553206
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 09:53:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yg1PGI89;
 spf=pass (domain: siemens.com, ip: 40.107.162.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOJeigKw3G67ZCxE2QsTESEFyC46+bsZV9VyKPHy/dueMZBBB2eMIkpU8QJ0i0yiuYtswBhvPA2aIPj8Zu37TbeUb0sM/Iw5byD3us/hpcVfEOCHFqSthKemp8QZvn9tvR1nB1eIPMvY0QpHFN+1lObu1QKZ2ITfLlUSE1hgoDZyTpymuV1lrIYFeaIE86WFN9Uds31F0zE/gPiMmmANSTOfxQFhYT5uZ+DghQt0VUkkt60OkDYKUgEDQusD/UuyXOceK/3mKcjST7VRqY+WtXJGmpHTwwYiQeJxQ9aav6E1/xldljPebF/G+QAXk7ejwmd3OjIpm+Bb/9umawBkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxTkgpKspoIhephJBw8U64g3sV6DdU3T+C26/XGMX0w=;
 b=A32CLGE5fn8Bk7psJa0GHT5RTkyxllYpzYyB+kr9ETRlWojCPgqZSRkvfcbsAaEC65p5j6Cjax/rDYhk9OHOoGfsTTdtNUh4zku5Ir46gVER6GtmsUAEe7flE5dArvuCFG9bZWS7tQ1CItMB03/Rfv6uNzZvBs5qDjIjYFAaczuP6Y8v9E8oZ/IO/GMRp+j6FoJIy102AsgeMUQ6kF1HNsLyLOrfMuO1EKqWD5yObfaSCjtrY9TTH2Upu9UcgTU3ehcIjIcR1l0a/KD26CoCVpbHk+NS2pAP2zZ6kxNnxk30IUsQMS0SS25KP0XI+6PJAXb+qjrtvwBsV49RyBG7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxTkgpKspoIhephJBw8U64g3sV6DdU3T+C26/XGMX0w=;
 b=Yg1PGI89w2TpTEQKf8ntxrwuExnizMEciu+fsDWyqtuGM8C9ZUeRVbZlmQN6rd/tT+cKgnO/1dbKvBCDETCHnhioYCRZQz5G4JUGyZl7O0gkMEHNoFNlSR962ujREWgclEe+aq4T7ffCdYpRpNjfEPfEIuQZpgpU2bCFCVDeBzaY00l4s6ClIQkG4j4p8YR9oDrXtp7LInyL1SlALz2Pl8pQp1m00XB1wbhBuMvgT6d3D1WcsuHyoNOCFCGusodwiAyYGc4NBn4PPw58rst9DYMkGVecgV3yHOSZ3cX4rm1Ij+aS0jE5vmapgUNhphCKJRTcd8kGLYDssm8a/eGFlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:53:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:53:38 +0000
Message-ID: <3b176146-e1ce-4f9f-aee7-a7e5ce8c2321@siemens.com>
Date: Fri, 14 Nov 2025 18:53:37 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Add TI AM62Px SK
Content-Language: en-US
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 642c5766-00cc-4a79-f96d-08de23a6bd9a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SCtqSEVUTk8xcHRvWTFmc1ZQYWFqb09uVjhQdGwyMVlVTklQNk9ua3ZnUXkv?=
 =?utf-8?B?WW0wZDVHc0tnVWU0NjN2WS9BRmUxRFN5MHIrVGtLM0RjeWlPaDR3QUxsTGVj?=
 =?utf-8?B?b25tT1p1blloWG05YVduN0FrdFdTSnNFbitKNUh0amtLbjlwS2paaHJFaTF2?=
 =?utf-8?B?ei9zS3ZZQldVTUFBZzdoNW9LMVk1dXFGR3dHYXpuL2djbVFNL0hKYmJpcDZq?=
 =?utf-8?B?Q0lhdzdIazJVU2w2VC9hVHBOZmdDcGRVV3RrQ0R5Y2JYbE02ZE5IbUxVZUNN?=
 =?utf-8?B?YzdNOWRpYnhBcEdxc0tjR1hmMVE4QWR5bDRRZ3pSNFhFRnRFVGYzWFF2bmxX?=
 =?utf-8?B?NVNsWVpzMGtoQmhiWHk2YWFRZG5PUXhQUUxIckdMWFI2eGR5L25SaksrMzVt?=
 =?utf-8?B?QWpWOG5ycmZucUFteTlGT2I0RUZuUitrNVlCRkZlNk1OR05SMCtpN2VZdUxx?=
 =?utf-8?B?Nk9qYkp2ZTBNMEFRNGRQUHJOdHR4U0w1V2FoMHRVdjV2MlJMUnVkSTNIUitU?=
 =?utf-8?B?UTFxcVJiVWQ1cWt6ZVZocXBZWGx3OUhHNzRTL2NBYU56cHVzL1U2eXUxblN5?=
 =?utf-8?B?MHYrQldwWjR3ODVzbjhrdDd1NmpLWGY1ZHV4TDA3Qko4NDV5ZC9Qb1BCMHIv?=
 =?utf-8?B?Sk9PeTlpMy92QUZUTk1KL2V1cE9XK1NCOVNJRjJwTzZWU1VCemtTYjBWSU52?=
 =?utf-8?B?cThCYjh5U1I3ZkRGUDd3L1N1UHoydFpNem11WmZ1YTVSTi9jTk80Y1FPYkZx?=
 =?utf-8?B?ZFJIVEhSeDJ3NjdIYUhjK0h2Mys0R2ExUDZkUWRzWFRGNksvalJ3NElsaU00?=
 =?utf-8?B?cWtVMlNPbW50cVRzSEZQV3l6QjNWcS9PRE9XMjU4d3NsTDBoOFZ0Zk5UdnUw?=
 =?utf-8?B?YURTWUIwS3MyNExwZU00YjQvTUlXMUpvMHdiUHlKRDF0MlZNbEswWkFILzhW?=
 =?utf-8?B?UTkrRGsxTVh5S1pyRm95RVRKVVVKRStieFFQbWNpSFMvU3FhLzhabEluRVNX?=
 =?utf-8?B?ZHZZS2ZVNXBYNThsM3RmZS9la05TUUQ2RzlHMkJ0TWpBcTlYd3RkaW03NlBv?=
 =?utf-8?B?ay93c0F6aVJQQktqTkhRM0o3ZisvQmhYQjVLY2xjV0dweDloaXZpTUZEdjlh?=
 =?utf-8?B?clBhWkc2SXdVSCtEWmZXNmRPRzFyZEdOSHVOV1VaU1I3ZXFJSUJaTGZzZHZK?=
 =?utf-8?B?dFZxWnRnNm52MTI2cm10Y2JHT0h1QWJVL1kwL2twRjVKbm10WWxxUmlMTXpp?=
 =?utf-8?B?ODRqcHhzNXVUNXhpZkZ3bjAxR1lhSmFrcWNrN0NaRU9rOWswZURPalg2dUI1?=
 =?utf-8?B?NTJFYzFzSmVxM3VGdGNleHdnNkVBVVdEeHp4aXRvZ3pMQUEreWUwTlRyN3Y3?=
 =?utf-8?B?Y0J2M1VHalB3a3lOUVJlRnA2T0dLWjRZbnRVK01jMFFjdFFJbzNrTjBsd21M?=
 =?utf-8?B?Y1V4UnJBT0NvRnN1Z3EvamR5SzFONTlZc1FNd3FDS0Mwbk9HQStOMU12Mjg0?=
 =?utf-8?B?MWlZYytHdXIrMWhQWi9qVVlGYmczN2pOa1YyOGJOb01PSTdxSFhaRXEzSHVj?=
 =?utf-8?B?dXB0MzFkSnpSMHQwdVlzN3liZzk1M21VV2tHSVFTaTNYSk1GS0RBdDRPWmpW?=
 =?utf-8?B?UEwzaWt1bVF4SzkrdzJqT0pQZURFakU3UDBuZWxrMkhVT3Z3NS82ZHcySVFB?=
 =?utf-8?B?SVQxSTZhb0F1Smo0MVFFajRtbG9kaDE0MVErZ0FBSTVRbEo2aDN4QVNQRHFn?=
 =?utf-8?B?ZXVObzNEcFdFeVZoUkwwZXI4U2pyM2ZvYk9sckpRT3NlelZGNnhXc3pxTGM1?=
 =?utf-8?B?NFVnT1crUld0aVBadXhtR2pyTWVnTXZnQ1NPa001WjU4M3UyS1dONHBzVk9n?=
 =?utf-8?B?SUppYVE2LzU2bEFxWUN0Q2lVbWRvTXltTXlUcFdTMFBvQ1B5VGhRUkE4QzdT?=
 =?utf-8?Q?EgpAxPUqx+NtvZT0TIF0aZwDNX6E9G7V?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3lhMm1lWHYzUnAwbHJFR1MvZkNrWTlXVTQ0UTF4REVmWWN6VUlSSkdGc0hz?=
 =?utf-8?B?NHdqSkZnQ05ZNWhMR3lkQXRyQ0xiUmpzT2JwVnlXK1J6eEl3czMvY21sQUl2?=
 =?utf-8?B?ckRGNlRnUTV4SXAyNmRrN2VTdlRjS3ZhVVg2bDJrZHdZZXNxdkVxZ2JpcnZV?=
 =?utf-8?B?VTUvUERyYmlYUk1Vdkx5T1lZYUVZeTF3a3hSL2FHdmVwZjladm9HSWlDSENu?=
 =?utf-8?B?VHpnNk04WjhPN09JOE1obnRhdUFLa1gxdlUwbEJFVXFaM1laYmFXbkdsWUJU?=
 =?utf-8?B?d0VRU3Y0ZEZILytmenE5WVByZzIyZXpVUFZlbGgyVGJVMzRuakJZT2RBRHRU?=
 =?utf-8?B?Zkk1aUc0Z3RzTUZQYnE0Um1GS2xmSXR3NFlTVkJ1UVRGQXRjeFBRWExXRW93?=
 =?utf-8?B?SDVIT1NaYnNjbThoSEJzbUlBSytIczNNcW03UUVJR05BeVQwL3VxbnpYNHFL?=
 =?utf-8?B?aG1YSFJwQ3dUdlJhbVVDNkdETjVmWXMyQlZOZUdiSUs4blgvS3JNK1IwZVJ2?=
 =?utf-8?B?ZmdNZFcrUU1uRUMwdlA4UCtYWitQY3c3SW1tUkE2ajY1bitCR3NSQ1RxMmgx?=
 =?utf-8?B?NjI0RlVnUERDVHRMMXpzZ2RjN1RqL3dudGJjRlFYQUtUT0txNXJZOGIyekli?=
 =?utf-8?B?OEU1Ui9JT3R4d0NoZExYNEJkZ1FaazRlblhYSmtWUDkvS0pwQXR5djMzaFJj?=
 =?utf-8?B?aUZXVENXOHJGRis2d2FZVkYza1pGK3RCY1g2bGtpaDVYZENqVzhoeXUyZDV3?=
 =?utf-8?B?ZVJ5RFdQUHBLdHpydlhWOUk3MFhMVDQzcWYzR2tneVBNVGlvelM4cWhwN2Ro?=
 =?utf-8?B?RFEyWC9BNHcwUXc0cEYvaG5QNUlUdE5rNG9tSFRPZ21oOUJxZFRCL0VUVUFZ?=
 =?utf-8?B?WkpvSmdVaXNlWk9PUDl3RFZMbDhtUlM2M1hvbjZ0WmFLZ0JMUGRwUHY4WjQx?=
 =?utf-8?B?VlJtOGNZaUh2aDJSVjM2MXczeDFhMU5WM0UwWHlJd0xoRWhEazRIckZuRTRF?=
 =?utf-8?B?QWRXdnVmWmVZdWFvUitMTUtZVmRlMEhrdTV0SkY4UktGcUJsTEVuSFcxZEd6?=
 =?utf-8?B?dzlyS0NmcUZmQnFHSUh2SWgwZmVXSUJlWnVnVG5STzBkNWExdGdDMUh0M0wy?=
 =?utf-8?B?SDJmUkVCcGRNdElWSDhmWS9ucnBMT1FNSDdGMTBXVlF6TWFQL1NNNEhhQTYx?=
 =?utf-8?B?L3VnUG5wL2dMeHBnWnlIZUdKTWpWeXFVRE9XSkV3UThMaENObEkrZUFTaThE?=
 =?utf-8?B?ZTdSSUl2dytidWpQbm9idWd2OWdjMldZTlBwZitUWkVmeklKeHhSTkNrRDhU?=
 =?utf-8?B?UlJrcVFaWG4xL0lMZm1BUU91cXcrK3dLd0M4eTdkNk5HenpDMjVGQ3U1WU5S?=
 =?utf-8?B?ZEs3NzZ3S3BvK2pLYmNRbFRrV2Z1c3g5RHNneXh5cDZtcXRBZkxnSFRaOHk0?=
 =?utf-8?B?QzJEMGdhN3VtU1RYeHVhR0lmWE1WMjlYNy83cHhNSzFlWkMrT3lMRE5PSDd5?=
 =?utf-8?B?b2I1MVZkSU43bDM3N3hNTHpIdnV2MGt2TnVtUkFNK0dLbFZLYUhDanNEUDJ6?=
 =?utf-8?B?K241ZmtDZ0FtSkJGdmMwaWt0UGU0WGZYT0ZkQ0FYU0daZHRMMTNEUDBMeWJK?=
 =?utf-8?B?cmV3REJodytKNHA1Q09IRVhwWnJiVTkzR0NjcmFhOUV5RWxybUpia25GZEZC?=
 =?utf-8?B?ZWhGY3p5aTA4TWdIaVhoRnlzVm4wOHdGKzZSVTlPRTBkN3dpNnhrd2pqRWlW?=
 =?utf-8?B?YUFUZVBVV1ZqbXNoNmltVWVFRDR3OWdWcDhORFNaYllBa3NpSW5QbG5QSFlD?=
 =?utf-8?B?b3pOV2huN1Y3VTNERndTcXVNM243Y095RFFqeXJiNERlYUU0YmI1R1poSnAv?=
 =?utf-8?B?Wno5ckNrRVRJWVJzTThhTlNyUHNPK3VOaisyN0tHNGRpaSs1MjlUL1czZng0?=
 =?utf-8?B?RnQ2M1JmNFZXY1BMZVBOSUxNSVFZS1doZHRrNkdHU0IzdWsxa1IrYWcvN3FS?=
 =?utf-8?B?ZzJpU2FsTG9ZcTBPQ2hSV2g4b1QwdUdDMG1UYWpGMmFyL2RnNENZQlFFdCsz?=
 =?utf-8?B?ZGpucHMzUENmbEF6VGtCMHY1L3VLVXE3NWllSVZXRU5HdSsrOXIzM1ZKaGlp?=
 =?utf-8?B?UHZWVHozTnVOdzB3ZS9iK3Y1ZGtEN2JhMEx1eFNMSTBKY0Z6RzNUWDduak5I?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c5766-00cc-4a79-f96d-08de23a6bd9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:53:38.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gze/unGg+tFJlBs3p24FRXXTXs44yzcdUTKjZQz7TqTRuDLcWnFDWN1JOaLIoWh/OuEh3z107gKSmZTPiwNvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 17:53:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20567

From: Jan Kiszka <jan.kiszka@siemens.com>

Test the full-featured build by selecting ebg-secure-boot-snakeoil.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Too lazy to build locally, so let's already enable CI :)

 .gitlab-ci.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c5bf613b..66b705da 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -262,6 +262,17 @@ build:x86-uefi-secure-boot:
     build_swu_v2: enable
     separate_home_partition: enable
 
+build:ti-am62px-sk-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: ti-am62px-sk
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    targz: disable
+    deploy: disable
+    encrypt: enable
+
 build:qemu-amd64-swupdate:
   extends:
     - .build_base
-- 
2.51.0

