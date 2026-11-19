Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10257.1795075185372569629
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 23:59:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IQ2ys/RH;
 spf=pass (domain: siemens.com, ip: 40.107.162.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT97+WSpS4MpX/rfSW4LOxelhHmGy5vQc87638//EI7KyXjNki1D7D9Ce11fxc4S3o0w8MbCr2XXPCh7GyiOX0dXhcYQX+DXYt19hwp8+SEcSmYHboXWIomAjxEPEjh0avQJKuf7zVd1TUeLpouLeua2nXxG/8rHxW+WZHcU8wNKORupchAbSLbX2w+bC6j8e46jJqw2EvhcPZK55C12HVzkHFVuYgQgnPF1UYIZ8aJosCfq6fym8MX1X8J453DncwLahqLkcctwlxrPSIVg01r+c7nJ50jFJsYsA2PccApZkZ5aQG6WeNUndMgUBjKgorAFeoigNXCHypOFdkLZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e9kFf8X+hHzkXd8HiKi506YbfVEV5mgaGbWhAGtMUw=;
 b=E6/ez0bUgyFWRv/TwBRaY9pAiELrH6wZHOiNtLfdD2f2kStR6spd5+T0xVb4PRXLkYRo/4mc5A6SiUvh+S2pvolYpShcwKQhIoxfhQ0zSAHcPOMZK9k7dFppkvgWoGz0TmpRFCP0mfkL7eJ+IgNB8Bga5N0aPb/eEv7QZS+NzCux4ceNydWm3vJkv3zf3aFAasXhOY2v3wR2o+LTTeTRwFP05RWcOqBi9+/rxqlcjujZCog3XM9rxQTAfi2JulkYsbS2iyHBX6/wwmsBSb1JMrs62VSUCq5hDf1gaAcIN4LPyGSQOp+UfSkbMoKC0CGOPmbDliZV/xzfKSBGPgSgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e9kFf8X+hHzkXd8HiKi506YbfVEV5mgaGbWhAGtMUw=;
 b=IQ2ys/RHvZd5PUKLFC/W2jEDy0bfTSU2I2AfMBnDmc7xOk/fCCLTQm7sBrteoONVWAvudr2ah8CM7+7vNsrjv73qbgclygcusdyEN3+1GVEyKiWEcskRLZZYo9sZUR4DMioa6cYm+7Tz5EQzo5eVy4b801smprHeETfRAN09HcFaaStmmWDWvyV6e8ZSn6xHRoilGJJ3Cy89bYuj6ubTdMU2oEUsPGfNm9CCMnGV9g8NFi0pDbrJH8cgo07jCeN8t37s5Nw8ZAaX0RbQao+nZ5D+C8khWVVxmnhJhKZE2Atp98FNsaPZfVvtcrYKKb0SfV9/WEgnO5Nj6IxVPUAVaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by CPHPR10MB517000.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:380:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 07:59:41 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 07:59:40 +0000
Message-ID: <e6cb733e-e8ff-436a-be3f-10d15ce6dd02@siemens.com>
Date: Thu, 19 Nov 2026 08:59:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip116 and
 6.12.118-cip136
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|CPHPR10MB517000:EE_
X-MS-Office365-Filtering-Correlation-Id: d012e59e-fecf-4a8b-d473-08df4613107d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|260925022911599003|56012099006|260925021911599003|11063799006|260925021311599003|10067099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: HMTeGleazVY2UoKeXTYqSOwfrYtlI843Bk++fz53WcZfu+mnBwtNJr0vbSXhWHuKOsGH7EDHD6DVU9Xl0SH6XSqYRF9Z/kk2+Mj0rzWLIO+Hi6K23NBAlyy4MW7ZLxDkpAdxrYFW0RNKzxOWDIQCRYbsAECyg1IgpXG91kRdS5tYN0+8Z2xemvxZJZeHvtjfSfqS7qNAAMRQcY8l7/0/AHrMVsWXdeD4gePhshgFaRbvHY5kaAmTpV1Caga4wNa5ftAKoR7OrXwOl8mQ6mSCq925lKNbOtvkLQipD4eoaXO0M2YlrBjfognaPhilWOX9P4uoYt23JvhzHTeQ0scHIempVU1o9mNFvp6MIT8N8sFDwltUjZNoRuIMoVsbyparBwQGb8IP/QJHvhGEV5ba4/u8R8Up4J/bBwMHRP/U3DQtLUjEaKpCQ3pVgjcy0gafZNU3uqlImfrjgqCpKlJHmiDhiIFVr2z4jkeJr6shEYPB4jKtSHW6iH+nyMGRzwFBswjXu69d8EwmgpESlK63A5+AR2jDG3vqI72lrIc9ItQ62mxwCCDteWFZQHBa5U48iJTM8E3j2NKp0JlujA8ZSPc3j6n5uNy7mrXd3ozh/hNhEW1fYpJZYeTLnxj0dOzdWOinbcF/ZXehhil0nQe3pEx/ex2AoSSIXzK6yDsAp5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(260925022911599003)(56012099006)(260925021911599003)(11063799006)(260925021311599003)(10067099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFIR2haditmcXk2b3dCWnJidDJTRndkVGtyQ01YYmhXUUNVRjdDSHk5aEJv?=
 =?utf-8?B?bmo2TTF0c3BlWXBLWW1OTXhkMG1KVzJvbnVaWTRvdmZ1WjVCNnM2T0xGL2Ex?=
 =?utf-8?B?UUlBS3RBYmExemxuK3BLWkh0cHpuSUtyQVJVeTgvem5MWjAyVXRCM1RTSUtk?=
 =?utf-8?B?YTZtYWlyU05RS0QyRXppdzRrN092K0RCQ1RPZnI5eXdiWVRCRkR4bm1vb2Ew?=
 =?utf-8?B?ekxwQS85UXEzZlJtalUxM05IU3FXdGkvRW1SdzcvSE16alZ4SVpxNGlNVkkz?=
 =?utf-8?B?OXpSZUg4QkpkdSszaitmN2NJU2cvTkR0ci9TVkVraXZUTFM2c1dSQkU2V3M5?=
 =?utf-8?B?WVMwajlnSE00dVl1Myt0RHgwbnh1VndTZkFzY1B1ODk1VzFOOHFpSWV3cFIw?=
 =?utf-8?B?bHZaS245Nm9RSVpaNUJzcXhoMnJWUmlPaVRRQUlKV2orTjBBdTVXdTExRXlD?=
 =?utf-8?B?UFFPelp2NnRNeFV5WFQzNEFJUGdnUWdUOGkyeklLQWVOTVNxZGY3bEVram5u?=
 =?utf-8?B?U1hFTWQvRjI1ZU9CUUh4SmRHNkJWeU1hQUxtU0hzUUVVa3ZpSUpZb3kzeU1u?=
 =?utf-8?B?SG5EK0ViRjdNQ0Jpem4vbWVEb1JzSS9nUGJRZmk5WmhKdk9MSkVncFN2LzR2?=
 =?utf-8?B?YmdQY2puMVN2NmtwZEhIdmRYRXpNUzlTajNubVBJVDM1Vi9hUmlFejEzMmdF?=
 =?utf-8?B?YkgzLzVUL0lUUk5KUnAvcklVTHU3RFZmQ2dIM3JsOTRhTVVFekVIazRWdmtv?=
 =?utf-8?B?eEY5c3FDdFdCaU1ydVVmQlhoQnJxU01uOHNoQk9kcVdQd0p4WFpsVFJEQSt4?=
 =?utf-8?B?RnlZQlA0WjJhZFBXLzQ4R1VCekd2TUU3dEJJRUtJaHpZa1RyUlZCTnZBTHZs?=
 =?utf-8?B?NW5SdDNPK3B0TnBadW9iWGFYeXN6aThkTEFNVU0zdUN4dy9LcGdWWnRBRTl6?=
 =?utf-8?B?bjZWdXVvYXEzYkpRL3hDYytGNS9nZlBLM0VZay9JYTR1cUtSVDl2QnNBL1hv?=
 =?utf-8?B?b2ltT0h4OG45ZTgzaUcxTWFKY0JKOUdXSEdCeVFELzdXQmQrL1NIY2xobjM2?=
 =?utf-8?B?eGh6dG4ycm8ybHhvNUZKVVhLNkx0RzllNXc2NEs1OUhnb1QvelJwSnhkK0tm?=
 =?utf-8?B?QUVLeGdyM3BHbDZHakJncXR3cVRNYWVNaFI3UjROWkhGYkQvUjhLaDNaWWRj?=
 =?utf-8?B?dkgvVUV1NU5uWmMrYWtlSnZBMGMyV1N2bEpqbTYwUno5Q3pKK1lpVVg4aDZ3?=
 =?utf-8?B?Mjl0V2lBNExKcFRxZndtaFRZSjRqdFd6OTlnTG5WZExZNWs2VDBWa0M1MCt2?=
 =?utf-8?B?NmxoY0FOOHpmejlwUzYrQ3ZiSm9zekI5N2J1MjlCODFnTm1NbVdDenhMeEdP?=
 =?utf-8?B?WHNZaXhpbGloT0V2ZFVqd3BHZmwrNHl1VVlQVHhNcjNkN2xoYlhCc1A4NUl5?=
 =?utf-8?B?RHV5ZmxmZmR0dGtqL0xPN3Z5SktkNVRpclBDVmRrZzBsZ0IreklObExVU3F6?=
 =?utf-8?B?NHVmNWZTekpIMXU3T1Jsell0aUZ4Q2tCb2M0M1dyTFhlSmZrOUFLUXVaeUp3?=
 =?utf-8?B?cjFTNVE4NjdkQWxKaERieVVtQnZLR3FybGdWWCtEb0FuMDlwamNoeTRqTHZr?=
 =?utf-8?B?ZHlWZm15L2x4K0ZDZ2VwcmVKU2FaeHd0WFpwdjhPT1pPdmdDM2padTNVclFk?=
 =?utf-8?B?U0puMllvaVVDdThyWGNtQVRKTXdDMEQ2RzlqNkQ4SVVZVDgrUkpEaHBoZG5C?=
 =?utf-8?B?QUhoN0NSSEJhSy90Y3NlZUhkYUZWc1VJZS9ESWRKaHNIN0dyamFTQ0k4ekE0?=
 =?utf-8?B?RzFJSWs1cWR2TVVWZGd0RENkTHpoVTJHSXpSb1IzaUlYZDducGhCSEhWbkVo?=
 =?utf-8?B?b3hWaVFBTXB0MXBXN3hlTFFRMzJ2TjRFU1pBeUNqenhLaE1NQk0xb2d0NGxr?=
 =?utf-8?B?NzdacVNWK3RJcjNrd3c0VlAxdkE2V3ExQ3ZHbStERDRiNDhoZ2UzNnlIRE56?=
 =?utf-8?B?SHJPOHg2Rm43UFBXRVB4ek14ZW5FYkU2VGIwRklFZDA3THQ1bFpXWE9sN2V3?=
 =?utf-8?B?a3lvekNFMXAvaVhacy9yMjUwRy9ZQzdFZkEwNndzNjQ4c2lVQk56Mlh6RHhQ?=
 =?utf-8?B?MnBOek5YaHhIV29hRklXZ0NOWEpDaXptdE9TclcvdUs3dEtKb0tkV0NRbC8z?=
 =?utf-8?B?RmJQSkx3bEk0YktIeGxuTDhia0NOYyt6eTVObUdmdmI4MHFBTmJEc2ZRUTAw?=
 =?utf-8?B?R1JyYTNJMnVBelVkQWprbnZJZ25ERkdUa2JVeFBraG80ZjdhODhjL2hRZDZL?=
 =?utf-8?B?Qm5pd1lJVSszVy91RTZjNTVDS1lEZDk2THRxVVZQNVJIenpLemlSUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d012e59e-fecf-4a8b-d473-08df4613107d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:59:40.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LGcsjcad6lenhWtp3wGeaAHZCDiG6cyhlkV9/WNE2yp5cB7nYxfdm/Wr8sQXm0erM+uUo/Ds9dQ2YIMiK9e1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR10MB517000
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 07:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25008

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb            | 1 +
 ...{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} | 2 +-
 ...linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip136.bb} | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip136.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
deleted file mode 120000
index 8023eb0c..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.117-cip35.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb b/recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb
new file mode 120000
index 00000000..65758ec0
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb
@@ -0,0 +1 @@
+linux-cip_6.12.118-cip136.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip115.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip116.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip115.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip116.bb
index af1db1b2..360848eb 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip115.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip116.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6ce35824c01c6c0aefea70f1d0989c61ed76a72e8a24b3ddb713e45ca9f95d62"
+SRC_URI[sha256sum] = "832866bfcc8d9708e052e0df8f25dd656f9f3522cd8c21efe66a36b3dcf4f9cb"
diff --git a/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip_6.12.118-cip136.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
rename to recipes-kernel/linux/linux-cip_6.12.118-cip136.bb
index 3927ceff..0048ccc8 100644
--- a/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.118-cip136.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7c3d5c0938f6030ca3dd6673a11776dd433a80d9544ab3909f073962da40f840"
+SRC_URI[sha256sum] = "3eca096a1be969b24e5b19a9c7e74ca4517093489dbacc33c9386a309f9de7e8"
-- 
2.47.3


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
