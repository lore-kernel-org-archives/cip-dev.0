Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13545.1795090950614445486
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 04:22:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u8ikLGUE;
 spf=pass (domain: siemens.com, ip: 52.101.69.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeEdvQv/scM2Ce72WG0z2pOWfhohykN7ZQgS0F2dRhQshdll73EC3N9b9LcumLiVyTdU2xs1lSAlEA7wrQ2TxV9C5UxDIO3rCw2bl7ZGailll6Yvwl+/fqGQvetRnJq+OysslLJklcnUgABF53R/EamudnbFbkmnrnwuLnu5yCvQdqRMLCTXL8IPuYAsTSsyepqQePfxwjAs/ksD3rZ8Uu6ZkOl0WWjpWPfkxkJcKJYHUO4MkoYWDy4qPpBlzb/O+YFfuGkcj1XDlCEhpKudwXEOiyKC3TSRAbN+9va7NHMio7QvORLqIOdd7xiNDrztXZJp9ooKSZgb6Rg+lx11iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2mtrBeD2cXPQfNWkgn7JUy64YHlTzGdtxnIACN/4HI=;
 b=pa8DMH8RoN0d0N5Pn4dsu/xmQhH5tkgjZFW3Cnq6uLfuoYVv23zHfnDUQwPV93u1sw5l9MXiLerd8hjRPNR17qA1LXkiCY8GyHa0WR9yWa+l4zyvrLo+twiYXn4V4l11PEsYwhQHe/WMUA4nA+VE6sMw7C8r/svwDqrWp+PAt10HUqWmzgx4IsBgLC5BCa4CF8qB/SeQ3IMSD2buJJPl+mKaZIgp/NYZFzcfO/feu8E9Ujek8ZvH3Mi1CL/ZfaOHfpoxAsPhMjgImENIlgwv8aZpqFGoa+M5FzJqHak3Bk1Qjn7VfbMzSuW3l44NeiZYzxF1OIq4vbJB8mhFu9mCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2mtrBeD2cXPQfNWkgn7JUy64YHlTzGdtxnIACN/4HI=;
 b=u8ikLGUEtsb+NRXjpcSu7qximrjQhpNa9vEWV0f5TKHqTrukbHibAgnaAMmkJqWjO5Me9MLGx2XoaZ2Hyeb46V7hC3gmopmWQNBrbRrJi476hENt87xS52VDr8hiM1+0vRNhRAPaatsm3E3dQZiRmyoemtjCw0sB+kshsce7EiwLt6vXPg+Ks8mwzWooSLSRtbvUyfORUjKpxSl/BafYgPWHJnxBT5P//Gv9uQoqsJ2ywFLleYc/tzc8D23AjsGbe39yY7JG7n+Ea03jUkwtELzcyG3c3gL6TyfC7TyMfuFIfKBfEQDvqnJGFePHQ0wDaoqJvJu2YvuZj5JMiMuUCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MMZPR10MB759619.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:190:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Thu, 19 Nov
 2026 12:22:26 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 12:22:26 +0000
Message-ID: <cccfdf6b-5bfd-409a-9213-e1eb6c98e72b@siemens.com>
Date: Thu, 19 Nov 2026 13:22:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 4.4.302-cip116 and
 6.12.118-cip36
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MMZPR10MB759619:EE_
X-MS-Office365-Filtering-Correlation-Id: cf072b68-0dde-428e-3d4e-08df4637c5e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261021123027099003|261102123227099003|261009223027099003|261021121427099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: kM4nQPZt9kF8OEXkCqtjAVgFtmRx31+j97hBVMiMGDDFdBrZUx1tfai1XnrMKSy3DQH1ieDKbvl5mP1+tfjwfHlK1w7K3hRXpIMvFfYm68TrjBFNUdD5R8N4Kwd0CWOX+Drz+89vN+6/0m92sTChUhYjaQQRKiU6B/WewbT6R841Kkfp6Igj+b/r9r+hHi+ixKiSfPzn2Jwzv/yIRpkSR6l7tGWzBiaB5iTjIuWkIxqD9Qd5l7juFya8xMcY5RdEe6PMKcIxa/YMk7mbj34PdJMj69E17fqsPEow5XmM+9vpDpctmUDlJexJNBKlWfY8SjhtI9T4XpUfiOGRFK/XC9VGHSQZkDZoOI9trAz94C9+v5h229cEwZKvJ6/+pCrzaivqT6FCwE4mTMi+sQUQ7hqXUJhPpJb2rjzpQEXXB152ChphUB0CEX9By7smp/1CNr7tvGO8dD9OC3AqPEviVC8+n460XDKsps7PN0AjZBTYnaq37h5lOPLWyvLFVU6J2hI94YDkgbGhvDlzUqHshVrkQ9cr32XuimM9P5JuSumj+zPQDJ8gwH7SCxy7cpPYRkHSH6g6X5Asd7OrBSmVO1HbRalgNF0lBJHd14hUe/TIKKy38NilvqyRKhmXb6qk44joNjQo0q1tJEE8/arQPd/S9wjc4JJQZx/BP0Ai7G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3E2dEt1SDFmTUUreVBoU1RCU3BWbjBPQmkzMHd6cDljSG8yMWExNzNvTFJR?=
 =?utf-8?B?WnVMeVNJaE1qT0w5NGNvRDgybFNuM3JaZHZQamJGN3R3c1pxUWx4UWRwMDQ2?=
 =?utf-8?B?UHlXVitWY0YxVkN5K3JRaWxQeTBtVHcxSG9ZRVh3ZXNsZkg1QTlUa0dnZUcz?=
 =?utf-8?B?MC9SWXJIMG1zTFBqQnRYa2hPMVpqVVNyd3hxMXU5UjUzOEpSMGJhR1gyc1RM?=
 =?utf-8?B?TVE0QVVJN0REOWRaZFlMem1GUGFuOXNFT0EwaE40c2VUbEVwRk0yWWcva0FG?=
 =?utf-8?B?VVFxamw2eS9BSlZVRTV1MUI4RHhVNlNyMnFpSEcyQ1YvbmZGS2JzdFg3c1N6?=
 =?utf-8?B?Nkl2WGpYUW5jLzVFZk9ZYWQrWWtLNm5UaVVwbDBvc2Y4UllQZHJ2OWJIclFL?=
 =?utf-8?B?V2x2K2ptT1k0ckVRN1pPYUxwQ1lWSjJXZmxtNVE2MXdXS0pQM2FKbGs2N2Zr?=
 =?utf-8?B?TmtoZWZMRlNMa0VtQTF3OTU2dFNXTlo1THp1MGRKMElCSWRjdWllZm4vODhr?=
 =?utf-8?B?bk9XOGh5ZEtrbTAvSEE2TDltd3pLK2tEdHFFUi9FYWtXZVlJb3QwSXBiUWZy?=
 =?utf-8?B?UlA5ZGp2N1ZHRkFvY291T3ZzSjNreU9aRUVaZ2trMW5UMHBSQmlaUE0xYmll?=
 =?utf-8?B?WExMTGNSY2ZLMXRMcGdGL1EwTnV1TldTOHl3a1pIbVRuWC9XVjU4WUo5c1NS?=
 =?utf-8?B?YW9UWnVuNFFNS0htaVJBOXgrSm1sZmVldWtWdmpBVXVmTGZrOGZ1dUVKZkRP?=
 =?utf-8?B?Sm9LWEtYTTM2SXRtMUVLT2ZiY0NjSFo2bFp6OGVMaFMzc0JONnFxMThsMm1k?=
 =?utf-8?B?WGJQVWRNQzd6ZjZkVGVpOWhKaFM5TXBwdCtBNU80VVYzMGJMdUs5SUJPV2li?=
 =?utf-8?B?RHg4V0FocTMvckUvUWhVS2xzQTdZRUtiTENTMStIbEdUc3UzZmZDUHN6Ulhv?=
 =?utf-8?B?ZWNIcURYVnZ3d24rOTV4WjM2TEt2dno5aEV2R2FWaWhYT0p4U1BnRmUrVG5l?=
 =?utf-8?B?RVIzSnZMcEZGOGljdEVBeURPbDdrS3dCeUREQUpya3AvNWRTWVJTVVExWGFs?=
 =?utf-8?B?cW1VYXdMUXl6L3FYVUY0cXJ4QThkUG9ZMFFKRTF5RGdvVUlHdk15SHhJVUZj?=
 =?utf-8?B?K1BRMk40TkdRUUJPV3dzMmNkNko3Y0ROaHdjc0ZGQzZ4K0NPa3JqWktFR3M1?=
 =?utf-8?B?cVhWYXd3K3U0aUNnUGx0V1l5bytWUlgvRk16d3Y1WVZBWDJUQzVFbnhNWTg5?=
 =?utf-8?B?TE4xZFcvTWk0bTg3eUVmcndReE5OM0duaFB2Wk93MEF6ZTI2WGt2Sk9ZaHlM?=
 =?utf-8?B?QWtrSGNVZnpaaWxLUFNuNldZQ3NjLzEybUJRVWxndkZ0ekozZWUyVit1Qk5G?=
 =?utf-8?B?NVFpUkhOcUt0eVRNWEdyVlNRZ2RWVEJNWTB5Y3lLSkUxeW1HTWZPZHRqR1FI?=
 =?utf-8?B?bVIzdFJlcGdPY3NVR0NjWXJkajZwVytFRTZ4T2h5ZUNaMkFDUmsvQk1HOUZP?=
 =?utf-8?B?UlZMOUlkbW45S0pDeUY2cnRPRFVOR01PaWIrMFdqZG8ra3M3YnZmV3NyV1lm?=
 =?utf-8?B?NFB5RnQzZnNSMTFuaDlULzM5L3V5NUV1WC9YZmNoVG53Z0h5aHY4WXVuNEg0?=
 =?utf-8?B?dUtYWi9RR3pTWmtlRjFQbmlIcEhGL3RoVzYxR0hDVjVWK2Jxbi9QVFJyUmhI?=
 =?utf-8?B?Tjd5RUtTQWF5Vi9DQW04SCtzd29aQW1sZDUydXlYM3NBQkdlZVl2REN0WmRz?=
 =?utf-8?B?OTZudHZrWVpMenhIeUZ3S24yWmpEakZpbDFPZFBSdmNwNkYyQTh5OVpKak1F?=
 =?utf-8?B?SlZhTXB2eVdMY3kvVVAvOEpNdFV4UktTVGFDUDlUR3hGU2Nyd2pnM1labmJU?=
 =?utf-8?B?M3ZZN1o3OXBBcnpvN3FBWTR4LzhTYTBMZE1HZm53dGxUa0JjeUhjdmU0cmtH?=
 =?utf-8?B?cmVCSVBLMFYzaG1RZytkUGRzUVBHTjJybnIvd282ZTE5ZmdjQ1pjUE8zQmVu?=
 =?utf-8?B?d1g1ZGxEdEtlazhkY1YwTVN1RS91VE9NUngwbXFtcXoxbm1BQTh1WjJ0bHIz?=
 =?utf-8?B?UDFzTkVtNEtWN2Z0K21DN1pUMnI4UUpMbGlQRUJwWnFvcW1JTUF6NG1PWk9u?=
 =?utf-8?B?UFhURjdqZk5tTG94UFplUnpXYWc4Q1JVNm42d0hOTytTS2JIRWRnaXNuWHlW?=
 =?utf-8?B?N2ZEaUNZYVpmOVFRYXN2dC81bnJ3K1dudzZmbTE2dDZ2ZlkzUWdkYmJZVThQ?=
 =?utf-8?B?ZG9zd1ZHYmpEOWJtK1k0Y0U1aFp6c2MraVBwcmRzOFB4Snc5WE90b0RPeG5y?=
 =?utf-8?B?Rm9zWHVYMG0xdGNtSDYxajVibmQzOUswYU5kd2NRUUdkUGFPSG5RZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf072b68-0dde-428e-3d4e-08df4637c5e7
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:22:26.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyN1giX/Uk0qeTzEa8imo5hbvE02oTPhgSkWzFQ8A8WQxtiSgZ8MgoFRBs0lGZI+BGRetXNtpz93xKZ/vpzzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR10MB759619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 12:22:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25015

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use correct 6.12 tag

 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.118-cip36.bb             | 1 +
 ...{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} | 2 +-
 ...{linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip36.bb} | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.118-cip36.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip36.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
deleted file mode 120000
index 8023eb0c..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.117-cip35.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.118-cip36.bb b/recipes-kernel/linux/linux-cip-rt_6.12.118-cip36.bb
new file mode 120000
index 00000000..fd2ee356
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.118-cip36.bb
@@ -0,0 +1 @@
+linux-cip_6.12.118-cip36.bb
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
diff --git a/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip_6.12.118-cip36.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
rename to recipes-kernel/linux/linux-cip_6.12.118-cip36.bb
index 3927ceff..fe927ac6 100644
--- a/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.118-cip36.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7c3d5c0938f6030ca3dd6673a11776dd433a80d9544ab3909f073962da40f840"
+SRC_URI[sha256sum] = "44f217dad9f40bf17cbcda7e5ef62940ce05f35347e036a65b90a8094c76f4bc"
-- 
2.47.3
