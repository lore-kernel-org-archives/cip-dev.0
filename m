Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929C3C531C7
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 10:49:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20805.1784803782876255964
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2026 03:49:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XcVNaxhi;
 spf=pass (domain: siemens.com, ip: 40.107.130.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqNk0o2s4K6pqa64w3EVQ8Pa7AGdQWv8n+Ad9ZDwv2NN4IgRGv7eUdfv4gYNi6PdE6lNy98FgJ6pXW0AGUIBeBIE6ONfhr2NkzKrV+oAWXey7GTP08OPkC3BBlj67NIyH8kA2uG/ZbxOkTkRwBPnZrJZVXhhQxhW7dfpAB7DvrZh/jHXKrmNhFl3IyzGVZoYSODL/IoezVIa6R7P6aG+Dw64DhNGvPHUcPjUgJIJAXfgPwCyLQu8vBatpjMQPn3zwanJeZtuT99xipyGMzNy2m1JswX1D1We2TfhO4CwDpE8HLB3xja6DmBpfljjRt41zsTSwBFV2OLb/O6pL9BCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzAzYD165ROxHxFfVkdXQwe7Gc6FrJIIG7joV6WD/xU=;
 b=Jsz4daD/CRjOf6rXXxlvIsRSEPl0pdvXcd/kHj/Ca3/HJp87qV4fN9jEAloaDK4DQ1jfgMtnS+hVEzLK1jrOVj8hrdC9IkerLiulVbBBQnNrLKVr5pqFfAMc7PmXWALBHdzomdEpzEI5H5rH/1biHCiagdxUjvEvavbAXFbX2CEbEz62itAhm1HuLNbu2Ra3/DrWBEG+SNCmtUu+I0uHGRN3fc7aME4puFPeiapx5ivNNzjlEdz1nP/bdVIcPggGYHAigFICIE8/RGGwltpCTrCIGNz3nxTlgqljW1y8WdFVFsR7kXDB5lXVgXwx7MaIxmLLoKP6iWe87eWyZ2TTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzAzYD165ROxHxFfVkdXQwe7Gc6FrJIIG7joV6WD/xU=;
 b=XcVNaxhi+CdJ5qpPguOQXs4GTDNMbi0MnJkKnx4uD/JN49ovhg5tRPfSZTok5icEuCTE3bx3FznydTC/gqVa4zoVpUIw4+x+MZQHN0aOC9pQuT6XAjcT1CxNPrFcPxnnD2Kq8F6tDRe4rwHypSe7naVj5yap287KcxOQJkG7IB/K8tJhtFMBoRJpAlMyOGUjw1ZvnWXdgEgq2/6qCIPFIfX+LYjeRpQ+a/3mYp4kNCK2GUxkEaXmj+QiRFbLtu/rhRzRRkYaUGH5x045QZgrkkCizcOBOE4QfOYWMNYeeCR33FOZF0/t5Pk6z4Czm/55z7NzDAjZgL0U+z39Z/k+oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:49:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:49:38 +0000
Message-ID: <89f55103-e351-4697-97c2-a1ebedf1513c@siemens.com>
Date: Thu, 23 Jul 2026 12:49:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip113,
 4.19.325-cip134-rt49, 6.1.177-cip58
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f5e7d-4911-43c0-eb4c-08dee8a817a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	RrkxK0liEed4q9ulKLlPRwwvFynEsTO2udvnz0xanlrb+tK571qPF9lFjNlEI+AXNLNgvbJopHZF6ZWoEu95r+6DgsWvGrkczoZJpjKH+TUBDqO+CEgMYALLzHZZWlK8EGx3kGeVVJ1EL6WSvocKNOovbD1H0XcPQpseSAaW+9SiMbkddbQ9hcuoEraxBIOXGfIq2Ec1iiraOnhFRzTxEfFResf43scf3kCqz+2ybO6EVeYVjG7SDNRlIP1ah7Tf4tklJbQoVys4cB4tYhszCzZBIhHUYuHF8RmmssG4PyjU5iwu5AF3TB1ijQSpeOphoCBw3ulRLyuVfMbChzZ4nAwK+S93iF443xxfXs59BcjCqQnGvzZv9rHiSBuv2b29lF+GqqIRr4KAaNWpI8RwaD4VG9Emqbcm47fexWhZarVkYTJPYabAW7ot3LAFvK6gXX5ZGEJDtB/4AXacvsNW7Y1wQQLX/IxFnDVOBD3AVU/7JwdguuxCaGO3evFGloQOfHwkS5xATcssSV8A69eYNYp+u7m8HsmanzEc0JCP2sBhzVjJhCxQFhWNT57gRmGsIv+gs3rT7KcBNIHg9dVFdNDxCwpEu63pJrcmCTRhJYKkMZ0sc0UC2cWKo7RHxVh5vOKyk6u017DcnFa3ItJgvK9QyGGDs19umhSWJXcyW7Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDNhK2xBNUgrMUh6WXowRThZcHlCaGtWK0lqbDcxYldtV0Vvam1lR0FzcVJl?=
 =?utf-8?B?WktxbHpmeTRPa094YmJTM2NKdVpLSTc4V2lPQjNTTlAyT1lEWmU1Qmd4OGE5?=
 =?utf-8?B?aFB0cFFjcmt5czk5UXJIdmxiUTExWC95MzNMTk9DTHBmSE5abjhpWDNrVkpl?=
 =?utf-8?B?OFUxNWFrR2kwUXAvSnNPekpPTmR4b1JNdzRndGtxc3pxQkx3ZkRKSFQvRm1Q?=
 =?utf-8?B?RHlSdEhLcW9JZXdvcHFOajNMU3pBUGZvWjRaMzFZS2pjMnZrNkJsWFkzRlp2?=
 =?utf-8?B?OG02MkovUXZZUkJPdE1sRDNJK1l4TmlhRkFEbGxpYm9TcStIajZJdjl1N24x?=
 =?utf-8?B?YXlNaXUvMzl3QVRwZE1oTUtMbW92TG1rLzJ3YlF0YldiWm9DZVJZKzNTTndD?=
 =?utf-8?B?SG1qRXh3dk55SFFYUms1NEpiV3d2ZkcxazJua2hXL0c0U0hoZ2JnaGhCOTg5?=
 =?utf-8?B?K0FFbUZDVVNFVjY1WVJpcU5panRBUDRwbU1oWWtHVlZVb3RtQ1JWZ2ZLN1pv?=
 =?utf-8?B?Umk4elFSd3E5UzIzT1hzRFpValJVVmZxbEhPZENlQllEaHJvRnRLK1FJcXhi?=
 =?utf-8?B?ei9zMTZWWURDNU1YeTdyVHVnMDNaVSsxKzF4UTljRm13eTJxZDE3SEc4N2cw?=
 =?utf-8?B?NWcwSFZENDVEQnh2MTIyL1gyb0FXYzVsTGMzajdRdWRyK01scmUrdUF2RVY5?=
 =?utf-8?B?SWlkdGdOWlZudW5iZUUydkYwbktvbUpKakNxaHU4bC9pc1VQdG9DVHdPenBC?=
 =?utf-8?B?UnRLeVlyWHQ1WTJ0VkJzQUhha1Vxd2RQajZFUGRxTnZ4TE1Xd1lvTk9UQjJ4?=
 =?utf-8?B?ckhoWHIvNVhrSWFHUFVPa1BBL1Z6b0JYSUk2RlBZdU9aT2VCeGdlcjlTOVdj?=
 =?utf-8?B?ekQwcVF3SDBZRS9UdnI5dXdxSU5mN0NQWEdEWnVGTktXZC9kRUdHOHdPekFL?=
 =?utf-8?B?c1pXOHhqbHZrL084Y2hjUTMzd01RUEdBUzJ1MzVxNHRXYllITGZkMnYvZVF4?=
 =?utf-8?B?SWVYaGhPR3k1T3Q0dWpGY2tDMzd5djI0VjZMNWlWaE9aZUlMQmJzOTJRNk9N?=
 =?utf-8?B?Q0Y5UkhhSkJpZEdhU1diNnR5NlFQdmlESnJnRy9kbGlKMDY2ZVJqTVRCaGFB?=
 =?utf-8?B?NWQ2eHZSTzNBZEd5YmVCUmdOcmdJNU5LK0wyWUpRT1RVVURnWUxQWGs2WWNX?=
 =?utf-8?B?aEwxZHNTbUwvczFHVGRReXM2aU91em54NzFPK3NrVHlNcDlRa3I1NzRndTAz?=
 =?utf-8?B?S2tjclhnZlBCd3ZmVjdKcUE0RFIzaGNQZ0ZiRlVVbGhFNGVsalRqKzRZNkRp?=
 =?utf-8?B?TXVqTjNCYW1WcVFiYTJ3bHM2RThRbEVVTFVrcVhWemJVcUpJS3lvZ1NlL2J3?=
 =?utf-8?B?a05heDlhNWFqOGRSWlpkQklkTTE1YlZpcE9nSkl5MDFmQnFXRHFxWWR1VXE0?=
 =?utf-8?B?aDg0TGlxNThJMHIyejZKdExnejU4VjVHMno5ZXgvWWhCaE9CaDdLNWRIRzh0?=
 =?utf-8?B?RlV1bVpoU3RZcUJhY2VlaHFWcmFQS3E3YVR2NE9YVXpXNEtSQ0p6YlhzN3U1?=
 =?utf-8?B?R2xldUZvZC9QeWYxUTgwS2pzRGtDWUE0dTBEMVFqRHNhdSt0b2poemN1anlN?=
 =?utf-8?B?Z1NFYzlvKzQwS1RVRmkzbzRkbkJCb0pjK0RiR0xyRlcvRXFRclRXQU9mc2xn?=
 =?utf-8?B?M1pOL2prNmhWdlN0TDllKzM1Nk8xOUUyTEtCbHRnU1h0S0l3czhIZW4xVE53?=
 =?utf-8?B?ZGsxdzdCcGwxa0JPY1E1dWtGRjdWOVAvcGJLaEhhOERxT3p6T29MdSt4NXgx?=
 =?utf-8?B?MGo5Zlk0OUt3YW54VWxGUU56bjdPZjVHYmU2aXdFOWYxanVmNjJuUW90RnZQ?=
 =?utf-8?B?bVJxZWh1MDdZUDlmaU9DcFZMNXhJSlo2UTA3VFgzWkVhR2ZVWGZFSDFXQkF5?=
 =?utf-8?B?MSt1dDZId2NTN2Nvc3lTQVlNQ1Vmd3RkeVQreGEwcUdKWllJWWxNeXBhaTF0?=
 =?utf-8?B?djU3QkN3UnlQOGZjblJNeFNvellkZ2VjVW1oM21RS0RPOXpWSkdWR0VXT3Ex?=
 =?utf-8?B?VkkzMnRvU3Q0d2M5L2ZnNko1WU5nQzlKQUJUZ1RQOEVoY3dyQWpEU2hOVTVZ?=
 =?utf-8?B?K0ZiNThxNTNkWDMwV3dVdWxUdVNhVnFUN01zM05tYmhRWGlzZERZTDEzeWhN?=
 =?utf-8?B?TC9uL0xpV0VVNGtLTHZxcU1BZGhiNjFMdW1YY2JTSHEvM0J6NjhsL2hoUDlM?=
 =?utf-8?B?Y3ZxQXVaQVdjTWFrRWI1SWk1Wm9zczJnazZBNjV0MFM0dFREMkRkSHZtVmNo?=
 =?utf-8?B?N0JoZUltWDJSNXFIU0tlemxRcE1mbjhqM1pmTGlUSlJVMk5EVm9jZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f5e7d-4911-43c0-eb4c-08dee8a817a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:49:38.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1HbLI2XuzUOt0UvUe1dhYwCE99nZlI4g9Jmy90PJ5TYOaicbHAfuD10K9Zi/6v5cpqKrzWKBD8bJ51IicQW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 10:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23728

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip132-rt48.bb => linux-cip-rt_4.19.325-cip134-rt49.bb} | 2 +-
 ...{linux-cip_4.4.302-cip112.bb => linux-cip_4.4.302-cip113.bb} | 2 +-
 .../{linux-cip_6.1.175-cip57.bb => linux-cip_6.1.177-cip58.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip132-rt48.bb => linux-cip-rt_4.19.325-cip134-rt49.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip112.bb => linux-cip_4.4.302-cip113.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.175-cip57.bb => linux-cip_6.1.177-cip58.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
index 59489cfa..c22fabc0 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "65230ec52117a1896b2ec285cfca7ecc0cdf09441613e23cd7dea590d92e0859"
+SRC_URI[sha256sum] = "8118ee6205bea222967d0b453b2512ba783c96fcd27b95823b0167fde7c5d2b6"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip112.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip113.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip112.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip113.bb
index 82c6785c..c0dd7350 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip112.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip113.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6ab9517bb87496d1cac7b1ae5633eba01ab840b115454b4c71def3ee1a890077"
+SRC_URI[sha256sum] = "10f0ab5f95bb3351118b5b5fb2cf494e7d80a3e9d7d9157f36712c6acd434783"
diff --git a/recipes-kernel/linux/linux-cip_6.1.175-cip57.bb b/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.175-cip57.bb
rename to recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
index 5169f9c1..3e1da8f5 100644
--- a/recipes-kernel/linux/linux-cip_6.1.175-cip57.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "4c3e2161e11ebd8f1caf5d62a648472e15896d056e2793b4033168f450eca8de"
+SRC_URI[sha256sum] = "6b22d939962adfe33a036016ea93089e4982d931c711109b1b1268ec2a59e03a"
-- 
2.47.3

