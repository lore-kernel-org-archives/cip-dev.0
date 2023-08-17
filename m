Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC21C2FC04
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 05:22:07 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.73])
 by mx.groups.io with SMTP id smtpd.web10.180578.1692249720489668004
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 22:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CGs/GVRY;
 spf=pass (domain: siemens.com, ip: 40.107.105.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlnYJzmwLRiOZ8o1KKE+jYa48zgvGY6DcuMJALIucs927ngoGnjMvB5tMBsEcINS9T0PPVAWrk6+CKZjUQJDzzsgzT32GDo7UXHp92RlIKoOTYx1Kzzte/+PGh0RHWQNVsJ89VSDLaldHRc8ft7vB4GEuIaJxHC2qasQYCT4Ydy1Yjbj3XE+TVvUHLx9BCiW7cp5q629lgGDLH+OpPPnfIMrGeWcoqxyU5iryT8gja4zrQQM43gkMNuZKbR5zEzkc++Q5TUb7lzYeyhNNOwuhsm8XaJiYTTbm4cSowqfAO5k2a4pV4aY0KvzgKpb+S9RCd+rRqSSCvmM/ey+Q6C0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4qRxa0poBnJ6wPk4ukX+X6P18fi4okerxUjPlKV7bU=;
 b=dhxLtndMFsemqMDT3nsBk9Y/rVmqfCyxrmc9pTx8uP3gWxvfYJiHPkrWOVJgI6wziABeYUJ8sm/luG2flyPpKx5d15f50+jTkr3RpZR27jFqbFVA1CpDv63uZj81a+G6VjF/P55RIObs52nAPGZSFzY3GVMy7OFX7Ur5TP8qI5CSsWTcMWXGe5rV6v99q3v8NcdMPKFZuXPwzXgAWzbnAizuEJan2yEsqVaDuM8G6FXsjzTEo41WebXCdnlRhKbaoIm7aEkYQl4LseLP/GbXEyBQZwHwY2SvkyR4FRh9XjLPAQfDDQ0f7HwLSqcAuRZyk1YkBG9Yjd5Oarc0ZC95/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4qRxa0poBnJ6wPk4ukX+X6P18fi4okerxUjPlKV7bU=;
 b=CGs/GVRYpKvuFd6iDMExnRrubx/mlTnAC0+VBvQ3f0sB4kAp4CWXnf14SRg/PXnH2NDbC6DQlc2qLRyaiev89kXguaphQz563/wPMMQHuRW7lhMuLf8LmXlp80R25Ue/ceSUyRNINLRxABrqFA+TQa7YpM0/tvIkPlzVH2Uob3ze0x84zBvyBAz5TULXaTnWox0feOd3fDOrCMcWXILKVcsDsOYmqBFpIW7TnrCgJsvx7/Ak14ko3drhq+Fia4c1qRIuPkWvtALrTzF6Pw7fe4BGpKTaQ3dhuKPzAxNybTdvYtujaeFucX5G0+jxmn5jHsccrTWGStzdK0KZuX5ETg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 05:21:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 05:21:57 +0000
Message-ID: <c21463af-0f9c-40e2-aeaa-e496a178bca6@siemens.com>
Date: Thu, 17 Aug 2023 07:21:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to latest releases
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dbc1e0-8812-4c92-df8c-08db9ee1e04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zX/iZWVuEGMLqcGJS3pBTC45xsCuDw510P2+23o0TgXQnBH5qfxF6lh1vMsUkVW4R9RaexuXTKLYtAXcAQ9k+TF6zEfNkmScAN9R74gFJSP2zbB/SzHuQbi4tpe4uoyxHW66kpDUQruK6a/gdvA6QKT9RAYsQgkxsUHSpf4Rt0B8zL31lKIMGnFIdNYl1MAJmikZU7zbD7dsWhht3VI7V6Ik+OG8RM1RRF/2tITXsND5WTRI5egEmsap+RGSykewTBX30eAUYOO0SJTB9DqaDcwv1wIXvBq8UeQgyzkhn2L7PrQCluf9FkvmSP8ssbOPgWvRMrAKnSBYBwuhn6AO9/jdf8zoXvbEE1IrBXxOx9SvmRdnyn5elT/XkstXlOBMztlYd8l1Dawkp2AtlL9OWcwxQMM+bJ9ROSzaX5Hi+zP/BZrGVmYotbjlCwZonc9+1whopab9LURKA5B8rVRMuAvJu3oCJ8x2aGUlXIoSfZdO9qFacTDC7ckGBSrcy45NcEbDc+AtSoAbnvnwv3H6WPTxF3b6el2Dsl/RmOuQi3+xH7PzTYOwW3IYP6CiRn9o7M+8U4X6zpr/qx1nj0IVkMuvPOu8Q8W1y/Zql9EJTUXVI4IjyTNVGzMdJlMj2mBpNChTCH2XatocJ1eWDL1C3w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66556008)(66476007)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(8936002)(8676002)(82960400001)(26005)(2906002)(83380400001)(478600001)(86362001)(6512007)(31696002)(6506007)(36756003)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlNQaFVZN0EyeW1LcSt1YmF3clluNWJiaWlHNTg1cFpEOW9yYmQzOFB5NkNl?=
 =?utf-8?B?ckZWR0J1RkM3em1DQ3R3N044ekhPYzFzeEFWWUNyYVBOeGlZZjdVK21YVUNk?=
 =?utf-8?B?dEU1T21hWGg2VnUxT1FMdWthOFFSUUVaeG15SWZqZzhDYm1PU3JOQkI2U21s?=
 =?utf-8?B?Y0tWODg4WWpTKzN5dnQyVWNGcjNiQkVaOERJd0xEMVdKYjlPZmEySUJFcGlQ?=
 =?utf-8?B?dlNJVXJrdEtiUzU5aEE2NTB3ZWh6RStMUThmRWtrdUc4VC85Y0hVMy9vR3Rv?=
 =?utf-8?B?VFNwblVJMjJuU3hxbzlIUUpiL2xoejM3UklvZ0c2d2RXQitRRVFLVDJSUkQ2?=
 =?utf-8?B?QXdiSHYzdlVxMXhhWUxiWS9sNkhPdmNKUWltdGxodXZ6WERzVTBObyt1cVBx?=
 =?utf-8?B?VDNkOUpyR3BrdnRBVmx5djhVNnltdGYxQnFGVi9yNHV4cHZ2QzFESVpPMEMz?=
 =?utf-8?B?NEFRaU9CVFZEQ0kzNTQvd2NNTndBc1lHeEtMc2Z4NnBhc00yb0ExTU12M2dG?=
 =?utf-8?B?S0RxYzduYXNBQXpZckx0cWtJclhrN1NNK0ZQNzlMQlgyZG9POVZKak5iZDhI?=
 =?utf-8?B?bXhKZzZ4bjhQMXRJVEtNL0plZjhNd1JOdDBTU255OU1RY25kY0lTNjBmWGZk?=
 =?utf-8?B?cXAwS0JzeWdUQWUxbE4yemEzcU1WRzA5dHpNZWZEUjhpSU5LTmhwU1RBazlT?=
 =?utf-8?B?ZGxPYWlrUGZUS1FXOUdPTGExUCs4Vmt5UjVDR0piTndvcU9Na2pHZTNDMUFa?=
 =?utf-8?B?c1cvVENZRnFacmJtbk40QURxai9kUXBzVWkrVHMrMGMvWHh4RFNkWnE1NFNB?=
 =?utf-8?B?cnl0UWRtMUFzbmIvTEhYalVlTmlPN0xZRlhaSEg2L0QyYTNvdHArMUlkbzlW?=
 =?utf-8?B?aFAvN2J0L0cvdWZSWjJVQzdQcUZ2VSs0dDlPRG1CZTdkR01IYzBIOElIT29C?=
 =?utf-8?B?L2M1OTNTSlR2djlSaXJoWXZDVGVSaW1WcFc0MlhoUDdxS2Y3Zk1sSDJwbzNj?=
 =?utf-8?B?dC9tZ3MwVVJRRll1SE5Ud0ZiTWVnUk82MzlkejFTMXNiYTlWL3Jpa2pWcnNT?=
 =?utf-8?B?TjU5SWxSWmEyVldYckNzR0RzQUg2YWFQSFNhSHFycTlrNi9zU2t2c3VJbEk5?=
 =?utf-8?B?MW5oTnJjWTM3YnZzTXR3eFhIbTh3R2JxNXVaSXpHdU56Q2JmRWZWOHFoS0hx?=
 =?utf-8?B?RXJTQzRweWM0RE1ya0c1ZUtSSDFOZnpHVlU3UUsxYnhJeTZDajQ1dmF2bGhV?=
 =?utf-8?B?c2xvSXhmbXVvWWxLbHBVWElMOXllMWU1SkJQYmpGcnZnVlVlMkZZWUxUZ3Av?=
 =?utf-8?B?YTJrVmFUWGZHNlMwclBKRDhCZ3IvOXVZcnRlRm1QeWhiVGkyaTNKRFVHNkt2?=
 =?utf-8?B?TS9RWUtSYzFkL2lKVVljaTQzQ1h1QXJYWkdPbzdRSTJUbllJNHpFS0V4bVNW?=
 =?utf-8?B?cEExNloxSEpuai9vQnZwcFlpVU04KzU4Z21wOC9xaXlIaGFDNTM1eWdOMkdN?=
 =?utf-8?B?M3pkZGxYNnpKdzFvUldlYkpQNDNybzVqOG81aHdjc3lXWUFEVHkzK0dxem1Z?=
 =?utf-8?B?ZzhJOGhxcnhoOUVKMlRoclM3dHpZeGZJZWpHZnorR05pc0RLdFF0RWNyVWdG?=
 =?utf-8?B?MDI2NE1HTk01ekUrN1NsNDdzVnRYM3pleGZ0a0xJSDJKcEtkTWN0a3Vzb3Fm?=
 =?utf-8?B?dVRQYzdNemR6WGJ6UG9TWVV0VFlCRnBpbE96blF0aDZBTnpxd0xDQTc3NzlS?=
 =?utf-8?B?a3Eva0RjZjhGU3FwZzFkUEhBaDNLamJiK2NHM25rZ1ZNR21xUElsUzdKTnlC?=
 =?utf-8?B?VTVtNTNRMXBjMHB6Qy9YQk1iQVhidlNYQktpZUhySlVBUUtsWFVTMjJCUHlM?=
 =?utf-8?B?VlJvZWhINWJ2S3JPV2JZSFUwYSsweVpxeXNKSFJmUk9mWEN3cmNSbXlwMjRC?=
 =?utf-8?B?MVpnVVhRdlBpT003OGQ0ZGlUUm1BT3l6R2dWczhPRGZKRjhpcnI0d2wxSWhX?=
 =?utf-8?B?cEd4ektkMEpWSUI1aUxzcW85WFhFRlBtRkhOa25sVzFvNUVDeHNxNVZTMXFl?=
 =?utf-8?B?bnZiQ21yaUw1Q20wRE5veDVkalRlbko0ODNOVFQrdmJhUVdzL1hhWnpCbUZO?=
 =?utf-8?B?NGVLaE5NRElocEJRN3JMSjhqZ1kzTWFpMzBQVnI2ZURrc21SSjF3MEQyY2Vn?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dbc1e0-8812-4c92-df8c-08db9ee1e04f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 05:21:57.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wexnVOe/KrZqOYO1vHCDUHdfPRJu3aZO13hVkkgpN5p3JPUzrE8q49cXAkkKBleSJ3Y/pTatu5QB1/CEOa4i8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 05:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12747

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...9.284-cip99-rt31.bb => linux-cip-rt_4.19.288-cip101-rt32.bb} | 2 +-
 ...4.4.302-cip76-rt44.bb => linux-cip-rt_4.4.302-cip78-rt45.bb} | 0
 .../{linux-cip_4.4.302-cip77.bb => linux-cip_4.4.302-cip78.bb}  | 2 +-
 .../{linux-cip_6.1.42-cip2.bb => linux-cip_6.1.45-cip3.bb}      | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.284-cip99-rt31.bb => linux-cip-rt_4.19.288-cip101-rt32.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip76-rt44.bb => linux-cip-rt_4.4.302-cip78-rt45.bb} (100%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip77.bb => linux-cip_4.4.302-cip78.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_6.1.42-cip2.bb => linux-cip_6.1.45-cip3.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
index 6a1ccea3..19c269b5 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "a4984846d2a239cfe9ab8546dd3a692d8fcf6da60228b54b51a8abc5b0ce2fed"
+SRC_URI[sha256sum] = "e147634e8d2730f6b0ea0e192f50bc3e30205d0076c6f83adbef9e5eccafaf3a"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
similarity index 100%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
index 0b87de57..bfe13e40 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "88686014daf17f1b2c64b24c36e1064b7dc1616a8a1ba4b3651362fb3b1aaa85"
+SRC_URI[sha256sum] = "9adec24bdedcedbd4bc975b592ad043d84abd74c03bd038b12b5c60c00871ff6"
diff --git a/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb b/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
rename to recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
index 0b6ffaab..8124f1d7 100644
--- a/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "70d05a84e8194a94dccbdce952a983466a404498fe59fb61fd3de1463322bb5a"
+SRC_URI[sha256sum] = "bef9588c018ef583303b288baa4eec3b0fc8a723058d52da7fd2fa27d6e619d2"
-- 
2.35.3

