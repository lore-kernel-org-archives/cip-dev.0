Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C2C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 10:40:02 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13788.1787567995623084545
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 03:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q1nIVyuH;
 spf=pass (domain: siemens.com, ip: 52.101.72.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU4PEWhhEDd0wm08hvktwq516dWwyEZ8QoVmrWjpFY7QejdBF6M1C3Qb7a56eXxhDczrPNUgYkrHpDZ8w8NSkY9evI+3/7nXbNZ02SI3vSlawAtfqqxP14zXUnRLFmwihhXBPgakXdM8jYzgnGdH3inrnA9kMKcz/nXbV33ArfDuCidtVMtpDkFIzWJHgCG8GFrl5/Xq7VB8CoJWJoYfh3jURwydigZbKvcrJzOLVchecRHVcvzRNGS4Fsr96isxWpuQykm1DzrvSmotzMRQoZc1x778k4rGvHL5oJo5psim/cU7wFS1l7oUVGg0Gv6CmHu+T580tJQfJvQMXhF68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XctF3hn9dwBqi8QQI1D9fxVH3zd+/SV/1jmib44WV7w=;
 b=uRUps11yu+eX7raVtS61JDuB5oLUD1o6WfFkCkRmiUPaJEk6y5LUMc8ouCyPiM70KX393uQioQ1nCLwu8mkEKGH8YPqxOXyejZMO1d5mP9dqYAdPKi1oqUOlHiJQCvZvewifMaUdbLrifXTRVR9zxUfZqkpNSzFOxKMH8FtBdelIXPEUmy0G2q2ksIIPrRxvI7iAbNakQtcZarGH5dnic/gK2mrVBi6Poj2NhPvroznrdidlWyllTa05KJnb6LigM1+8cUAx64QsL4sJK+RktDjkgRxXUSksXMIBjpm27rs2pXiRcN+StjvzmhEfuwYTtVG1JXy1FQjQ75dMTUrEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XctF3hn9dwBqi8QQI1D9fxVH3zd+/SV/1jmib44WV7w=;
 b=Q1nIVyuHTsHZeOAy4NNrXkM2uZQmMWtI3ZQzYPjnHqqe5r+8DISvmT9HSKoQn4cxBagLmf3UX+YaH8xwhI7anSPUqYumqVQ4cnh9Kk3XYbzN7MsMkKlxE7L+oDaII1okcd6X/pT5QrTmGibWtiPNSDVLhZprIFUcsCFCGtXw55y9k3f1vb6kmVEzlAWC+JZ7LxCryrcowE/u7m0zhEIKgVqjw2YgS2lVzXCyGwsi/97rzztVskAgItZD84WRFy/Fh3uU8iIuoLbtUPy4zv0TUBEKGa2FeejQigPJZxEXRYO6EvU/xjy+otw+i7QQSPqSTyZkdUE35wnTQAbgSaWaWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:39:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:39:50 +0000
Message-ID: <4bf4add4-249f-4987-a148-2428e65dc1b8@siemens.com>
Date: Mon, 24 Aug 2026 12:39:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip114,
 6.1.182-cip59-rt31, and 6.12.104-cip30
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf193ab-1943-4a05-a850-08df01cc0683
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	ZOHVQbdV2P4CeJLEZ+SjhuW4ZzIqhraPWOH58n7yLywwjKFrSAFCetH3M1vPnkdWzfecReaCv1FCeQyy00ZnV27cOqMD1acj7eK5WsFRDA+gNDwbC5ckilE80NEHX042aMUJwxJC26/WibJT2hxaDZpfE1soUr1rp24MP6fsmS9G+0Oos2royXzI5JRLsFGaxxCzJVz9DVf9JLUKj5mNBZS0fx+M61KycUAu7vWYm5tW34hekdW6DFQKJKy7JztzdxJhJSIjDZHX4U+bnAEd0newSDTlq63ip3L4meAny/b36Fb0GY55duxGPDmdkpHDfJOsp7payk2qCxwMBO9apiBEmsIflc6RQRVax6y/UdYSLGZd3RbPDwQl1/dCwIs6n8V63abZPh9Qdj8gxamvOCydWJPOearTU2dXE7c4GIoz2ky7aU5iFG1TMAQ47h4mmKgCwEvEPG2o72yXtKtBlAsqdOv5bRHaOCp3C4qSqU8Ztk6cTR0USoy4E1WNlzC751lkWiZ9z4hZ7dYqBJuZjpXo9DUIgvE6T6P1sANj45pRSpS8nSnomwIQEnmUc1oXBcvTQPClHcSYufNgmQ11/SA8oFsuBa2H22aCHNjlivINjRA888iVXcqPizIV8ZdyEwC+yMFTMoY6DbX2CnXik8NHiPiAXV9Q14eBXC3eMp8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0gvZmpWaXNNRjhHMUI1bzZJY0FFS3pVT05WYmZSb1EvM29JSFhCYWdqODNJ?=
 =?utf-8?B?WS90NHRKQ1FCZ2Q0d2FDSHgwTVNvS3BxaWlXTzBqclZXU01ybzA2eXpDS2pQ?=
 =?utf-8?B?OXV6UzZkWjRSYjJKOHgyREl3a1plT1ZvSE5vYURQc1dxZnFaODJLUTZjRmRt?=
 =?utf-8?B?cW9wTVNkUEhYVU5GWnNzek5yRkovVWdMZmJETk1yNy9qYlg3cXU0MjNMaEpX?=
 =?utf-8?B?SW5LKzE4d000ZFlnRWtOeGVZeUdCY29YcFJxdldEODBGNGEyZExVaFl2dkhx?=
 =?utf-8?B?OTRzSktranlyd0o5VVFKeGNFM2xRV1hpeHMwS0drRVkrWWlsbGsyZFJNTUNl?=
 =?utf-8?B?bkZsV1psSmVZRjAycWFZNSttWnNUZGhjU2VxSncyamtPT0JkeVFua0FkUTk4?=
 =?utf-8?B?KzUxKzZBYktrY0pjd3VjWnlFb2lDODdwVjdSWkdldGF0cEdYT3NNcmNyVFg5?=
 =?utf-8?B?ZEFCR1FoTmxyRzlPL2tHOXdzcmJBaURKSWwxdjBsYmFqMVBiblNTZHlvM1VT?=
 =?utf-8?B?c3lNMjhwMXZZVlhhREZuc0tlTUZqV0xMeHhyVEQ0Q2M0UVRUUHNwOFQwRUw4?=
 =?utf-8?B?NmpiYkZOcjM4aTgzdlZpY1JrMGdpMDk0MnNHdjRZcVlqdmxGZXBxdyt5LzFj?=
 =?utf-8?B?QjRlWDloL0wwL2hvQlp1ZCtobWt6VmQ1MFV4dUdaOUtGRlVYQVR6d0NJM2RD?=
 =?utf-8?B?VnJsVzlUTzJVejNCYVFGdmJnSGhqaXFCaGthS2padWZkUDcraVhLaHBCb3B1?=
 =?utf-8?B?S3lBWThqeWZEUmNPSEdmQ1hqakFRWEEzQ1l1QjhGc2dGZlhnVTVMRW9YTlRU?=
 =?utf-8?B?ZmlFQ05xMVBHRkRXTGh4RzQyaXp2SmJyVzdLUGloOGR4SCt5WHM5elZUOHE4?=
 =?utf-8?B?WWpyeWl0ZFRzTHdVb1FLay8xVmFXOGhsY3d1QkUxKzRpeExWS2RaRDd2dHJM?=
 =?utf-8?B?am5nY1F2SW0xS3lpOG5EQWFsMDU5M3ZWZ1l2UDF2T3hIdk5RU3A4REZtbklY?=
 =?utf-8?B?UURiVlhxeDVmZVZGckFTTUtjb0M0eEptelBNRjA3UEptK0UwNzZ6RUU2YzNV?=
 =?utf-8?B?S0hRTEhyQmVJc25yZ3pPVFVHazQyUVptclRBbUcyL2p5cGQyQWx1OVBlVENP?=
 =?utf-8?B?WWppano2aE1LWDQxQkVuNTNFSGZzTitIbm9FaGkzVTBnbUwxME5kQVphWHBP?=
 =?utf-8?B?NlQ2clZvaFlyb25QYXFTSjk2NzVnUnJybU4yQS9yMkdETGE4OHQrOVZVVTA3?=
 =?utf-8?B?aHgwbGsvK1Rpa28rMjJ1NjFoSWNJdkFyYkp0Z3lnUTlic2hQbUYydkwvNFNw?=
 =?utf-8?B?a0RYRTFqWlEzbEFDR0JWU0lKSHNmY1p3dVJHMWtmNDdwS3JOa3ZNK0FrQkl3?=
 =?utf-8?B?VkpOU0dmRjNaZ05od2dCeFhWTHg2dkQ2c2hiRDRwZ01rMjFsOS9lcXVaVERU?=
 =?utf-8?B?Rlp0ckZBUm5pRUdoSzBvOXBkZGVMRWxBbEh0Tm1QRlQ4L1JaaDlkSGRSd09n?=
 =?utf-8?B?S05vQ05MM3RTTVBOTTRwZEdINm00OEM4dGl6ZysrZ25pUDJJdTRrd2JnL2hR?=
 =?utf-8?B?eStZditLY1p6azVsMnJ3dTVtT0JlZ01CbnNtMWw2UVpMU1UzUUZNM09YTm1L?=
 =?utf-8?B?WllkaXFWNUYvQk9CSUtKYzFWUFBEWStlOHdDeUZDbHdFSUlhb0lScXRKMTRX?=
 =?utf-8?B?dmxMMGpyenFuc3Z2U0Q1WmlvMFpNNzhhdTJDOGNsRlNNdE5ZcnJYeDJucXM1?=
 =?utf-8?B?eGl6dmVLNHBPRWplUU9mNGtpOE5mQ2F0Q0lLZkpvV2pSdzRrVDAxVmlwWE45?=
 =?utf-8?B?ZnoyNkRYZHR0RFdHbW5Zd1NQV1dmRVZtSVdZK1YvVUZhenhuQXFPOU9CbTFS?=
 =?utf-8?B?N01RcDI0U2szRUxZeXR1QzZxNUEyelY0TnJnMWx1cnBzK3BrZVNOYWtzalFq?=
 =?utf-8?B?RjdMTUpQQnlieG10YkFOMFh5b1lJQUY4RGdKeWxIM2FMaTRQUXhHN3BoTVY4?=
 =?utf-8?B?VUlzUlBQbDFjcVdEeUh1RlFxekJiNWFhL3JNL1hXNk5oRE1jTyswUkNFaVdQ?=
 =?utf-8?B?MFdtZmdZTFoveXkxTkNIRTNtd2hJTVNoY3JKMVpoT1h2UzlzR1FUSkxHY21a?=
 =?utf-8?B?anVWOHVCTDRVb0pBS3ZLSzh1TzgxR0xSZTFiUHByQUI3ZHU0bS9yV0syN3hu?=
 =?utf-8?B?LytSMCtZMHM4MjNYVHErLzM0RndCczBkb1YrWDVsYVBxdmFhWDhCZVp1U0gr?=
 =?utf-8?B?NDF5WFpFUFZ6SFUvQ216OXJXQUdKeEVtaTFjR0NjMHN6SG5ickZ6ODFUbXl4?=
 =?utf-8?B?WDFJdG9PdzI5dU1ZbEUycWpCaFRjYXZ2SUY2Y0c5V2o3ejdiaVhMUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf193ab-1943-4a05-a850-08df01cc0683
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:39:50.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxLEsiNOiirGpF6bJ81pR/YXd6xPi0HMXyDeLKJIDfYXJp81bYHYDc6bXLr5nn17Wm+4CMzU3lLt7JI0yhHSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 10:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23994

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.175-cip57-rt30.bb => linux-cip-rt_6.1.182-cip59-rt31.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb             | 1 +
 ...{linux-cip_4.4.302-cip113.bb => linux-cip_4.4.302-cip114.bb} | 2 +-
 ...{linux-cip_6.12.101-cip29.bb => linux-cip_6.12.104-cip30.bb} | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.175-cip57-rt30.bb => linux-cip-rt_6.1.182-cip59-rt31.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip113.bb => linux-cip_4.4.302-cip114.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.101-cip29.bb => linux-cip_6.12.104-cip30.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb b/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
index 37d5a329..52fbe641 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a75064376eb4ec4c816ae11381ced89e0a8073bf90c30391cdbbceffd8f254cf"
+SRC_URI[sha256sum] = "d66e63c93ec04fb51c32cedc97b1ad73998d58055bf3fa021e3d7bb1a2789ac1"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb b/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
deleted file mode 120000
index 82a1b15f..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.101-cip29.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb b/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
new file mode 120000
index 00000000..e767cba9
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
@@ -0,0 +1 @@
+linux-cip_6.12.104-cip30.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip113.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip114.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip113.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip114.bb
index c0dd7350..e92ec4fb 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip113.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip114.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "10f0ab5f95bb3351118b5b5fb2cf494e7d80a3e9d7d9157f36712c6acd434783"
+SRC_URI[sha256sum] = "23060eba286be4c8723547d589d9c1a0d54627689a8b12b7a05151c4885b3cbf"
diff --git a/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb b/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
rename to recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
index 29268b0f..8b7671fa 100644
--- a/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b4f48eb4a0212bb308ac9e01f090c19ca3798281548d8778c4c9df80c18b7bed"
+SRC_URI[sha256sum] = "d4fbae6f58c86c1a1da3c23e013eab54caf57aa11efb323b98150298cddcbb18"
-- 
2.47.3

