Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7CCA9ED5
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 05:20:37 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7227.1791782433054029400
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Oct 2026 22:20:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Eka7Nf17;
 spf=pass (domain: siemens.com, ip: 40.107.159.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj4j/hzh7iesK0UdKzJ0qXogghnVVsd7SBotxJrhoGPYIV1ITwf99RHWzhtNDvEYmh6hbbNwpRQGrY1xfllHOi1yDyu87MCHd7rW5xV8Fi1KfjRBXiY5uluTtJbHbimPQXVapacTfJ7q+9cyL1r0dDOBkkLlPodGht/7oF3XcWfhG9l5liVq9Mye25dzoIuXTeGre/6Q7rP4fZp7azMoZhK8rwiPYWG9PWzgcngoJdJFTJ7Mjq+asRJ/3q/LpunhS8gwKvwpU6e7jCdu7nBqdl2MYFSAiMa6MAz4qdi05rJY4EgCaFQJERpNruUwaezIvPfvF71x5j36Z5nzxyj8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwuD/9ve5m09AHp2O8bhqYqpDT8sRIwvPfIfHOihLyo=;
 b=ZpmscAtlFAWAFBshg3KCeXOXaY1MLxjPfHlbfCP+1gn2ZIHMYf7X2dmH+aIZjqwfgdAFaow80uE2Fb7ErADXajjcDnsNit+nlqv+JgiFz7SiTVzDUXlVda5a/aO8FUW6+3/2L7dzw/iSvzqmKNsiWzg/vyLD1t6l8nC2a0dkVTPzQVZyOelJXUCv0EyKi/5rAmWNKUyV0CImY9GtyGVNsnr4Vqnb+e8+9UQr3+XK08986eYgba6MxjrmWaFjk4vR8allQRZo5JdqbA9O9geKnWhNcnE68Q9TGSmxb8out4jOvCrrjsAgfWJimniL6ivXvuNLV+Q1ZsHAaHiK6/rZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwuD/9ve5m09AHp2O8bhqYqpDT8sRIwvPfIfHOihLyo=;
 b=Eka7Nf17A/L1npeoEUGelsTWvaniLM3zqVTE5GXpr3FXBgUJSoeqn0RUARrOIV799EWSWfKu76twtNiD2Ga+zhMZRLPOICSRoSftWEFcDgx7JWVyxeDNxQiY+j00XPL/sL4f3uvOp+S5BBYGLrbgzvQ1eBM6LLIU/fL7CmGAWzUmFHiRgqwtYPYT9JbUz76cGBiE/36hH7L9lDduUqZk1IGqY7xS5WAe/hMytbHX8smTk33sqeyKxaNi7tReAXkzBa2KHCkTqYz3FLllAeyn48mVZM+zkYw5m+YaSVPFJtPvHRmKThehfS70TZZjW4WmIpsxtyYerf2Mz1uYcCSMlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU4PR10MB9431.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:5f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 05:20:29 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 05:20:29 +0000
Message-ID: <9d5dad10-8092-4542-b7ea-45c7c30a238a@siemens.com>
Date: Mon, 12 Oct 2026 07:20:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip115[-rt63]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU4PR10MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8586690f-8aab-4e88-a673-08df2820879a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|260925022911599003|260925021311599003|260925021911599003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	vu+4EPnvYXraVkr/8HkAPlxQDIKhtzpMs34k8xz36OQcOw88dZSrICA51m1knX04lsWBckh3hmBhn9VaOYnpgTtIMVE3dYVQEMJ1DLgSDtNFys9qdasq2s3pD0CmSe30Utr3EBT/vxwDfvV1zGTpq8fJotNHC87Q4nvJWq553yTDVaN9RGK1DaT3ns/qHJKvD7rs9y57uoVlG1iPCpeO3asWT97K1uY1rQVRCJ5GVeso7HE6+VNJ3mhe7m3NUsNfIpt08rPsj09ymYi3OkaIc8Cs6vz9Fj5JtX8wGAFDq57ldHl5u4ytckr2MIXAY/37ZaaupwvWHpM6TH0EVAH8eNxNUyGlqFY3PG7r9JHggJDazXvpkZdQWFghsUkmQZH6k+AXxEwAFb9JDAomtSgGrBEaF2FRI/mHrmyqxpvSPOK+77quM/tJoTf3HVv6BvMvI5cnhXGCTbPGF92tOplW5BUa5RSuKIk+R2mO6r1W0jMnEDXbxIAeFMOxP81n8S8a8609OOU1OddnMa/e7VvFJ4IOEZvrB4UUNbwPRjDQQ6ppuzxYQEKtZkCrgGUrHYr2Dnyi6Pt+YJeW+2Iu727P7TDbBo79HAiYdh+Ew5LvZ3SgA8AEc1U5Lh/d0o5BzmP8Tn3FhGIbveb4xBin2wEX2MxPtvnzNqHscl/z0ExYb24=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkxhY1hoemNhdUUxT1FzRzNNS1RiWkRpRVgvTDU3SDA2T2tHQUJEUWthQUZ0?=
 =?utf-8?B?cTdWcWdWVmxOVnJjcG4zL0tEbytLT2cvNTF1VitHeFViSk9Mb05hSXViT3hZ?=
 =?utf-8?B?T2x0SVN4SDdHRmFZRTIvQTFqZ1JIMU1MaW9qMmdzZytWZFh1cW1ZR0k4YmM2?=
 =?utf-8?B?UDVuc1kySkNtUThienlMT2ZkNEVKZXM5QjlzYzRiZTlmcDFzaHNXdTRydE1n?=
 =?utf-8?B?M2tnNnlzb1BaenV6TVJSSVlHQ0R4bk4weUpGSVByQ2ErcDdUbzJpTjc3ajYr?=
 =?utf-8?B?MkJoWVVjVDJJNnJEMGY2d0lLbnJLOHFkQTZwT2hsTnFGTjlTVnhTb1grRXlY?=
 =?utf-8?B?RkEwK3k4NVRESGVVVVZ2VkExZGVjUVdGcW92VWtRTy9TWFA3RE9lZnJ2aVJx?=
 =?utf-8?B?U2lESGplZC9jYTIvR2UwN0h4NnVodWhlcFVzeFg2a3M4UTg1RnEwN1pjVXdI?=
 =?utf-8?B?UjZzVGlrWWNpZ0M5R0FqZ2YyeTNER2lJZGdORTdtUjZyUTFUR2J5MXNPdytD?=
 =?utf-8?B?NnRyS1ZVQ3hIYlg5ZTV3dWYxcDdxVFNxS1dreXp1Q0NmQjRFN0RtbG5NdGJt?=
 =?utf-8?B?WUpSUmdhdnU1NlZadXAxVXV0VFVOa01vb3VrVTU4Vit3V2NOb2w5UEROdXky?=
 =?utf-8?B?MWhGMFhLSThOc0l1d2k2UnFQWGovWlVOOFJHOVpGemJuSzU5a2VuZUJUcHY2?=
 =?utf-8?B?WTUvSmhNSHZRdkM2WWIrdUE2OWpjMzdoUmtVQnN6enVMQk1NTU0vWVp4MkRR?=
 =?utf-8?B?Nkh0M3NQK0NURThRQS9yWXNZTTFmSGhFNkhTZmgwaHBobENVM3V1RlAwMUZI?=
 =?utf-8?B?b1NRQ0trRXo1VDNIT1dlbDR0VlZOK2VYUm5jSEdyUy91cS9FajQ4LytycUF6?=
 =?utf-8?B?R2RVY2ZlZWg5NEZzUW1wWmIwNlJEN1I3SWF0cHdhMWtqYnBBK0pjYUtTOEcz?=
 =?utf-8?B?QzFaSVR2cmNNWEprNFhUU1hsNVByWVpLaXhnZkJtS1NjSWp0K0ZYS1pvcWpX?=
 =?utf-8?B?U1MxbVlQSUx3YzU0c3orSS9qVTRIdUVXVmluT2ZkWnJnRFMyZ1pLa2lsMSs0?=
 =?utf-8?B?QUgyczhCMUN3Wmw2bzhYWFg1NXJPNU9aMlB3eVJGOThmenJyaXlQQzFtVEFG?=
 =?utf-8?B?RE5zN0JWSVZFMzdLbldZTk90dzQrbzhGU3E4ZVF1Q2dUTi9vdXM3U3JSMFdN?=
 =?utf-8?B?T1JOdmgvRTBWUkN3cjhPMGo2VGVRMVhDcU10TjNiaDBMcVNiTEJGeHV6NW40?=
 =?utf-8?B?MDkyc0tsanZLSG5IVCtPN1NackpBMERUUWdlTG4wOWpOZW9mQ1JnWXhJeCtv?=
 =?utf-8?B?RHpFSWtiVTFZeXo2RGIvc1ZOeGxTSTU3aE9nMEpFSWNHclRCODhSNU9GKzdp?=
 =?utf-8?B?eWpNRHo0N2E2VDkwSWZDd3N3L0tyYlVmQ3RZNEFuYzdwS1VmeUhnMjNLcDQ3?=
 =?utf-8?B?TjN0cTkwUW10dmRjZmwyc2lkWWtvWWJYWSs0T2E5RTB6ZERQZG53Z3llZWdL?=
 =?utf-8?B?YklXSUpKQmJMRDRBbGNvUzlSTFh3K3crUEo2WXFraUUrdE5PamwvM1U5WU81?=
 =?utf-8?B?ZmRPMUdNT2xvY1B0Sm5GQVNRS1ZuRUVCSTI2b0FUbDA2Y29OQnNQUExwbEhq?=
 =?utf-8?B?ZHNPY1pyNldpNU1ocnJWcHpQbHdDRnI3ZGNjeHhBdjlhS1Vic2FkdmVNalpY?=
 =?utf-8?B?cEFqamxobEdYUlAreTlSSnpkRFA3NGNJTFRMVzhJaDByeDVGbGJQRW4xNFJC?=
 =?utf-8?B?dko1eXZwcmxxY2xBVVlSeWRwNG9HUStEZDFRV0FzVlVLekJFOVBHenYyU2RQ?=
 =?utf-8?B?V3Vqa1plcWJtVm1RU0JJekdUanJBRExPb09DaEhmOWdUN2ZwUVdLNGFkQVhL?=
 =?utf-8?B?cjAxbmEvNS9uN2hlaEYzTzFhd3F0L3E5ZXhVbEpDU1AzZy9ZVVFpQU5lZ0o4?=
 =?utf-8?B?UGJ3NnphTVVsR3lnMUh3dlQ1Q3UyLy9EeWlNTXROeHRjUzFrYVJ5NHhhZStq?=
 =?utf-8?B?ZUdseGtRb2ZJSHhPeTU3UkYwaTJxaUNnRUUrV0x3SkVCM2lTZ3h2TlZiWjBJ?=
 =?utf-8?B?UjZMRXorTFpOcGtHT3hQQ05uQ2grZXQrK0FrUUZBQ002Rmo4Vk93REh5WjhW?=
 =?utf-8?B?bmhYZzRIY1MvK1dvNjltcFpCcEU5RUFMR0pBbzRSS1NIVjZPUkVkcVNjOVpQ?=
 =?utf-8?B?VU5tSzNNU3FpMXdSNTZmanlYNXc4U1B5VHQ1ckh0cXBBR2Znck1oeE9JZmJM?=
 =?utf-8?B?enYvM2NxVEdkTi9obDBuTGZlTTF0QmZQKy9mcEVDYktXSTNKWWpQQVkwWTE4?=
 =?utf-8?B?aGhTL3FZazRDU204YWdLMWR4Y1NIMjRPU3k2disyR1NGcFFBU2t0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8586690f-8aab-4e88-a673-08df2820879a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 05:20:28.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ0bitGpIaEohQ99rJg8QNwKKd9Jr5vQlROLTAwyrDj3gepL+tuQZLK3/h3zNcAZWWvT1PpybJwFnscEhXJfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Oct 2026 05:20:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24443

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip113-rt62.bb => linux-cip-rt_4.4.302-cip115-rt63.bb} | 2 +-
 ...{linux-cip_4.4.302-cip114.bb => linux-cip_4.4.302-cip115.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip113-rt62.bb => linux-cip-rt_4.4.302-cip115-rt63.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip114.bb => linux-cip_4.4.302-cip115.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip115-rt63.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip115-rt63.bb
index 039d5d0d..a0e522a2 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip115-rt63.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1e3e83a7dd31b9043849089e982f95a1158de530c31cb74b32c6362989fe0453"
+SRC_URI[sha256sum] = "328115571941b7d55b8e893618d5c3ba021385b9276eeaa1dba6658f5a3cb58b"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip114.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip115.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip114.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip115.bb
index e92ec4fb..af1db1b2 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip114.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip115.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "23060eba286be4c8723547d589d9c1a0d54627689a8b12b7a05151c4885b3cbf"
+SRC_URI[sha256sum] = "6ce35824c01c6c0aefea70f1d0989c61ed76a72e8a24b3ddb713e45ca9f95d62"
-- 
2.47.3

