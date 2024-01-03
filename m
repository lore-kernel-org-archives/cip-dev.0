Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDFC3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 19:06:46 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.50])
 by mx.groups.io with SMTP id smtpd.web10.25916.1704308799504238703
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 11:06:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i0OXA2dk;
 spf=pass (domain: siemens.com, ip: 40.107.241.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIivJVbu+QkHf1JLeTjtrjFj9gg+dcJZuSYV8z8jWCJQEhvebnr3nX8sU3h9AKWVHTmvehmySsFPsP5e/czja5BzTH7bZIYwhy7yXutFiJuHohIIW30SIhmQZWZ6rx35j/b+djYTcwL4TY6rUh2rfKD+Ux4lngqQQsqmvvMQnI9P3G6183svmm0x43lVNx5fr6C+pnXMwiUSPkODWSQwI1wR0mlJndg3Tj12q1aM4VVrjHhVQEYOD6NdXTf4LdLShyYiev8UOBQxfrzYIZPa+b0iZF+Ahs4SMc3sYx4h+GoX5yB4ZTVDwVzuFcm3oXw8MzkdwJhkv7J1suq/3RJ4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p14N0OZbgo3SUjZ5RD2cwtr5oDwCFONHddEhqnM5zjU=;
 b=afgPDshV0am5XYDLFFr68Pq/tQaqXUFMTzImCCBkY3hYepFEx+IqkA8Wr2JPnXEZJmwW8ci8qxu+H4WLZpZ9BAn0NxdzsqRscXvbABYwWkjm0KnQcXI5MeIl71mQ1fw9zsBqvqDMJztk6I1NU2/yvIop7q76Y4l4RjfWRogmGgHL0/Lni5FX7EyliWb6j/waUjpEsWo5i6ABnDHo1qnFLxDurh5L/F87wgjiHsIIgO2+82eBYfqUH/DTsPhtioTCr03xkRahq/14Cuhl0NesfTaZL5vomUysW1wESx2YwSiHtKJQX1lpStBJPplhyDeMErrzko+9Zeq5DXSblMT4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p14N0OZbgo3SUjZ5RD2cwtr5oDwCFONHddEhqnM5zjU=;
 b=i0OXA2dk6Ozdf8mLlVXlhz1aHVQCqE+p9JO/utdeVwEJ36ugK5GBkBqfK2DIKAcMyUucUFD7MYcgqMypsMzPzBP6Pfa0pmIsAaiWP2DAXHWcaR/h0bCbgIOUUjxjnZ8D9GiqF5BBRxKnPN6gz44dRHo7SUToe1PVqg8Fqs/hjzbbypl/7H14cOw1oMYvqpg3pA2zQP9xmiw1D3BUk5eoTH3juZpQueujF4axsL56DCt80e1Y/kO76zMi1vBo28+MR6ihcjtUgY6dgUAqFYIFK2GNpkWHvsKwP4lP7PlWXY7nkrBXD/ELO/hxNDlT021JkM+G37WuLbtKu2Tzpazo3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:536::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:06:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:06:35 +0000
Message-ID: <2e111618-1de2-4728-8031-e77c4a2c4ec3@siemens.com>
Date: Wed, 3 Jan 2024 20:06:33 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to latest releases
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaf649d-1788-4c8e-32f6-08dc0c8f1b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b04ae1OIOALOGN3Czaeasd80cjYs68rnC8Qy/BWTHKuI43uRXb4fUtIyD6K7rLFTvz6halXAMopvUp6Be6XTAUu5GSo539W012YW7tzKny9S1OJ2Fz/wZQ6iq1nHKPCmSUnGI17hOMY218szlPDpRDERfex4AX8i765twjJAIGlBLGuKyq5YFF0yeUcDVA40rrQbJQ3ZSpRecs9oMXpsCxOOkFBXqGmmjfZmsL/9WNbFj0gymb0VrSWVrWyxjWrW56V+VViY1t4HeltUrQ0FL0OK4Opi8Q6zE9kqv6RU/sSU5s6BJayG1vU9RHQVpJKYzqF/14zBilz9fm1MI/HIn4O0M+nw94kZm8IbXknE+cZTxHz/jUf26WchkXddcUo+wIoi/aXTiPZKrGCOvVs2+pE/atDBycnpeuQc+ZabHNliIkecUMmF/v8hQeGaY07JQO9ESMw80tc2OS8iaoI8mKqGc1zBMDYKDJYhe3wnGRlNgHByrSQKsKlp7lnODYpq6S4t5Jzcyo5PJQvgcBqJuLKI3L8iVMdx+GEr2SP00gyOUynnIu/RLGh7lLtx/Je+m9T7HLz6KYEUGig6l2Og38hjXDPNtIkj1eCwYVBlMIJL8u8wEx99Mo1WDIMP1TP8DVpGlHwWzTFF5+5Eu/zfcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(38100700002)(2616005)(83380400001)(82960400001)(8936002)(8676002)(15650500001)(316002)(41300700001)(5660300002)(2906002)(44832011)(478600001)(6916009)(66556008)(6486002)(6506007)(6512007)(66946007)(66476007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDQ5bTBxOE9hU1lYU2dvNThWWkIzLzN6bjFmbld4bjNXWWZ6TEpUWmM3azlZ?=
 =?utf-8?B?cDFEZTRXd0VBSWVkc2xuNWcvYStWOHZIRkl2cTlOMUhZaXJYVHJjbWNQazBW?=
 =?utf-8?B?YmY2SlpPdHRPWEM1L0VDcFd5VVVrRUh3elpnbWlNRXI0SERUOEpkNWpGR1hh?=
 =?utf-8?B?VThpQTlXd2xkNklGSHZ1MmRXeXlCLzFlcG1Wa2JjL0JERnFvUERhQnpvOXVU?=
 =?utf-8?B?YlR2UWhPclBPdVk0ZGlpN2NKcC9kVkoySXdEQ2NiUExGZWZtR0VUcWFaVm02?=
 =?utf-8?B?QUhvYkgzTloyU0o0SHZwckVjVXY0VnNuZWhVM1Rla3l2eUlYWS9NVWYrUUYy?=
 =?utf-8?B?ZnFqWDA0UFdKWU1hM1hPa2NFUFFCY3pzQ3NacjdpRlF5cnBpSi90REVjSEtn?=
 =?utf-8?B?ZDJrL1d6Mm1oUDFRczRVcHlNMUxIOHpvNU0rem9zWXJNcmpxbXBkU2RFQ3Uw?=
 =?utf-8?B?cHlHQlp5dnI0Q2p2dUV2WVFaRlVKaE5uRlIxSGhVYm00MlB2TThGb29Zdm43?=
 =?utf-8?B?MUhSWjQ2VmNvS3gvWmpRaWlZVXFuY01RUWRIb0I4L25pRUJLWG96b0hxdnFl?=
 =?utf-8?B?WThaVzBUY3RaSngrMFl5UGRxbkoxQ1V3QlV1Q2Fza1huZFBGRHY3L1l1QzNv?=
 =?utf-8?B?cWptaXRrUHVlbWlIdzJzVHZNTDdEa2VoZnM4RmV6SVZmOXJzbVA3VDdKMURu?=
 =?utf-8?B?OSt1bDI3Z2g0eXVaUkZOMkNad3h3czMxUFlhcCtjWVhtTkxObWI2RHJDT2tr?=
 =?utf-8?B?K3RIaGw4V0ViR0FqSWNlOU05eTFFSy9BSVlhTWxGTXdhSjlsaGZVVVAwZ0M4?=
 =?utf-8?B?Y2QwRUdoeEtCR1FUdytPSlVHbC94R09ia2dFNk00NHJJcGZONVViczhYNXUx?=
 =?utf-8?B?RXRtcktqTmIrRVNjUTlIYTY2Y2dWOVRsa2xaZlZqY0k2QU4vckU3Z1p6UWdr?=
 =?utf-8?B?dmFsRDdybFZyWENhcm45VzJzNmo3QnhXQUdjRHdZRCt4OXl6RThpcXd0eWd2?=
 =?utf-8?B?ZHpIbms1aExyeDNhVkVxM1E3L0R1d2NzckNSV0hwNFJxVTVrd3BNc1NpREhF?=
 =?utf-8?B?SVlkVUVIWFNrYnc2ck1pWVBoa1pwK085UzRyVUNqUlplZXNhbHA5QTQ5U09a?=
 =?utf-8?B?UFRRekJnSWlsMnF6WkdhSGJOWDBuaHVPbmo5NjNUT3Bsbksvejhydk5xc2dM?=
 =?utf-8?B?M3VuZ0ovRmE5bDNvT1VtRXc1K2JpZXNYeW5md0d0S2tMYXBSZEwrcXR6MndH?=
 =?utf-8?B?Y1lPTDJIclJDVG1KUy96dTVTM0s2WitoNExWRVBwcVV6bnVOcnoxYkhNVXJY?=
 =?utf-8?B?Rk03ei9OTy8xVmRLb29IMVgrL3ZhUzVVdG5WNTNkVkluOEpLQzd0RnJ0NlNl?=
 =?utf-8?B?OUI2eHlhVm5MOTdneUlXSm9KUU5rbHEyR0plcisrUjV3bjVUZmxHRzVyYXdF?=
 =?utf-8?B?Wmc4TmgvTWR4ZmVpSWUwbXYydUxibU1ZaWZacEtPQ1dxYmNOM1lLZDdKcHdm?=
 =?utf-8?B?TCs2R0ZMdlcxY1R3L21RYm1vTC9OekFpU0kxUzYvUm9MRG5DVm9xdFJCRXFz?=
 =?utf-8?B?OG9IRGNiNzJ4TDdzNm1Va1QydDVxcTNPQ09PMk1YZ1FQVWtaTUF5aHIyOUhz?=
 =?utf-8?B?ekY2RDRmSUxFdmlTbDdLWndPWEhqRDVvSWhFZTNWcExWQnRtVk9mbDZ2WUl1?=
 =?utf-8?B?TVJ0c1dFVlpVcnBWaEJyT2tHY3B3SjlnRGVNWUVaZ0tyRHR5TjlUK2hIZ2VY?=
 =?utf-8?B?bWIycUJMZWhBMFFOMUlVZE8yVy9tMk0rOXUyYUVWd3lnL0Z1N0UxMVRuKzVW?=
 =?utf-8?B?SmhndGh3bzZveHBDSFFSUVRCQlpMU2FJSnZzUk5CbFU1OC9DTmNxa2NXOFN6?=
 =?utf-8?B?dHU5ZVE4dml0WWhFaDNVeFNyTW01eCszU0l2S2o2WEN2aHZ0ZVNQenRZRjlY?=
 =?utf-8?B?Um9IanVVVGRHbHYrRzdSZm0vdVhzNVU4RGNwZmlONDBnb0xwZlBmTHZIOElL?=
 =?utf-8?B?dXpEOHd3QmlvZnpxRU1vUWdFMGFHdlY4eHJPVWM1dDduV3FUck1SWUpoOXBP?=
 =?utf-8?B?R0J4eDNEL2E5eUVjUXF0WWdrTUpSUnFGYXoxVFFubGFsT3diYmJsQzJ1QVhV?=
 =?utf-8?B?di9oK2dKQVNsSTQyWXQxUUlwU2cvR0U1VUlMcDRUMkRjUXBUanJwd3c2em5L?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaf649d-1788-4c8e-32f6-08dc0c8f1b3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:06:35.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+UNjkTqWAyYkywE+Qc9CSnACLFykKUUGwe0zd+avvcHPC/JosKS2RjBvsfHqj4eDWVRzNpQ7ZpOm9BC1emshA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 19:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14251

From: Jan Kiszka <jan.kiszka@siemens.com>

Generated by the new update script.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....295-cip103-rt33.bb => linux-cip-rt_4.19.299-cip105-rt34.bb} | 2 +-
 ...4.4.302-cip80-rt46.bb => linux-cip-rt_4.4.302-cip83-rt47.bb} | 2 +-
 ...nux-cip_6.1.66-cip11.bb => linux-cip-rt_6.1.67-cip12-rt7.bb} | 2 +-
 ...inux-cip_4.19.297-cip104.bb => linux-cip_4.19.299-cip105.bb} | 2 +-
 .../{linux-cip_4.4.302-cip81.bb => linux-cip_4.4.302-cip83.bb}  | 2 +-
 ...{linux-cip_5.10.201-cip41.bb => linux-cip_5.10.205-cip42.bb} | 2 +-
 ...nux-cip-rt_6.1.66-cip11-rt6.bb => linux-cip_6.1.67-cip12.bb} | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.295-cip103-rt33.bb => linux-cip-rt_4.19.299-cip105-rt34.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip80-rt46.bb => linux-cip-rt_4.4.302-cip83-rt47.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.66-cip11.bb => linux-cip-rt_6.1.67-cip12-rt7.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.297-cip104.bb => linux-cip_4.19.299-cip105.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip81.bb => linux-cip_4.4.302-cip83.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.201-cip41.bb => linux-cip_5.10.205-cip42.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.66-cip11-rt6.bb => linux-cip_6.1.67-cip12.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb b/recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb
index 407bbcb6..b5924013 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "96ee568d51fc662ead73d0851fb0fcec043317d11c3f00835fdb09c7740e3131"
+SRC_URI[sha256sum] = "cbbaf945457a045fa5adafcc9206ffab26139d5ea9f21fb2f57f33923aaa24e1"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb
index 678a8027..6bc62752 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "2195422a0d154d8191e6c974a9946b3c91187dde891c52ae971e39ccacf9556e"
+SRC_URI[sha256sum] = "cb1bdb0aafea82824d084cf3790267369d0b4bbfabed142594f15370f0538aef"
diff --git a/recipes-kernel/linux/linux-cip_6.1.66-cip11.bb b/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.66-cip11.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
index 7989e6d8..2e54a3d2 100644
--- a/recipes-kernel/linux/linux-cip_6.1.66-cip11.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "6ad2551a89b955c6c78145295675418f384136fe6e6e6ad07373af6209261af1"
+SRC_URI[sha256sum] = "5b2affdeca3822cdad6fb8a236cdad07ca14f15d6e3e9b263dc1916667586751"
diff --git a/recipes-kernel/linux/linux-cip_4.19.297-cip104.bb b/recipes-kernel/linux/linux-cip_4.19.299-cip105.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.297-cip104.bb
rename to recipes-kernel/linux/linux-cip_4.19.299-cip105.bb
index fafffe21..cf22c131 100644
--- a/recipes-kernel/linux/linux-cip_4.19.297-cip104.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.299-cip105.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "264b20398fcd0f65ea27f16a7625314de1ec790904626a4cdc2dc44dbdeb973a"
+SRC_URI[sha256sum] = "60e1d7426821c47a84ee4de53e9be3d23e09cd493390fa29b3d2f38e5d0639dd"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip81.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip83.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip81.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip83.bb
index cf538e99..051eaa19 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip81.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip83.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "bf7dd204035e2924f877c879683605e00d31ec2f38a0ef03d764d05263404c34"
+SRC_URI[sha256sum] = "6cc43814b53964dd5d18a0d5e33da014773c54313ce25c57d8504a1e24fb96c3"
diff --git a/recipes-kernel/linux/linux-cip_5.10.201-cip41.bb b/recipes-kernel/linux/linux-cip_5.10.205-cip42.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.201-cip41.bb
rename to recipes-kernel/linux/linux-cip_5.10.205-cip42.bb
index 0868ee58..707be1fe 100644
--- a/recipes-kernel/linux/linux-cip_5.10.201-cip41.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.205-cip42.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "40e976196aa52c07a9bd39e9d7d320919aac8978a518de83680223aa04f0d11f"
+SRC_URI[sha256sum] = "b4734a7a22a30f3c20f9437c366bde0dd584bebe836d1ef622d4c1d7205e6f54"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb b/recipes-kernel/linux/linux-cip_6.1.67-cip12.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb
rename to recipes-kernel/linux/linux-cip_6.1.67-cip12.bb
index f9a43458..daaa7703 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.67-cip12.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "83c8303cafe867cbebe770e542bdcacc6d60bb6fae93de665a8cf13742349722"
+SRC_URI[sha256sum] = "5d72be655a9c31ae298ae79184750d5c76f82bacf568a3b8dfea2aa717c496de"
-- 
2.35.3

