Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637FAC4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 16:55:04 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.89])
 by mx.groups.io with SMTP id smtpd.web11.19401.1713372893860166540
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Apr 2024 09:54:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xhFuFDTU;
 spf=pass (domain: siemens.com, ip: 40.107.249.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHIhq6Qfy6hGsqQs7Bvh7U3PK1Tmb/qTdWSan0S09eyyukQfPGCFDMqGUMFY8Os7E0qxeE6ooMEkJ2XERt98w1kGwqJWINufZrJnc6XZ/ziOMoc2YB7nDT60hJhUQW5XddJWNMnMTAKuH5ryJKWJwfcIoyqRtfylUZbADJPWm55HcKFwM3ajmIIUZ59BuaWHCGQdVow1fg47vQkIz7ZOwUQZvyi/bZqiXr8J6dUTpsebqvgxUr5GwVI0+mLwEhn/CptYo5RhD0OsXJmo5dUz3613U/AAfQziwmCMHp0P5NEuYUD96cyheEFj+EdQh4Ixx723Ue6U0q5F2RYTJp7B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fwVCdskc0AexeZePXzTS2kcKUIGHuMUd08kkTyArkg=;
 b=c1X8b7Sgv5N7+wwNcEmX733cDiK97dlNY2zEeD27eOT9h4ptg09TJ0qWmj3q2SB2lw0myvQIM36lopgDn29TPqyklXAVtuUUm+e72K8+nHWXvAHbc3k3BbmvIucanAfqUwsKI7coUPM+mjpxZbFmnDKxMX2qeqdekURpbm6THISky0Fwb6E0Zy+asuwadAvSOCVdnGDOJVv3yF2XBQsNt++iTiXkZea2XqzX/Te5Wtvu7aL4wqqha8zoI9bAvJrdFglKtJ9OK5TjJvdK1t0/esAim4va/AzPBoMiETlGHzYlzSXhkjvKIKYTvQ6g4z6GloE/FoqAJQr+W86Yd6612g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fwVCdskc0AexeZePXzTS2kcKUIGHuMUd08kkTyArkg=;
 b=xhFuFDTUdXz86KlvASd/2ghEG7KdV2bvInm8dIuJ9AnYI2KGuaBEt6711SzpYYx/L8EC5jA6Fuak7tL6pCkAJowSxrrJ0elxzBOTF4k5E0lqyQTeU0SnUeDgrebK0IbicJRmBWrr1tPPrBIvhfxfUjVPeWdqaihu0XDUrZL7XYg+56FTvf9yhe30tAnco21urQt67M/wNoBvmxfye58oBZMtfJe4nAcPeYdkY8g+KMNWt0SJ/8U0iIcp4TrIGxA2j+d3CJn2ZkF9UG04D0/c2xsVchx9G97VFym5gkDuAuHEy8mtSZF8ztvUm/9/sHYTfa47ipG2IRmuUl54K85jsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:54:51 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a7b8:97c6:1619:4f9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a7b8:97c6:1619:4f9%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:54:50 +0000
Message-ID: <73bb628d-3542-4f8d-8445-1380e6fcbd3d@siemens.com>
Date: Wed, 17 Apr 2024 09:54:48 -0700
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Switch to snapshot.d.o for ovmf from
 buster-backports
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f76798c-c037-4079-2e15-08dc5eff18c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NzvNjPjf72I9Ve8kyys5icJEI/mVD23kdoD2PfKvep8w3y54QMZrA2TFuBMpzM+DaNa8sH1DS9nKQq+RWXRZ5wyr2ZrlZvIlZGaUFgqq3ULXxixB2DCC67g5Vzobn2YLVMmJ7kEgrCsXT2DFRhCU4NuJHQEM6F4vkN4Ho3pHfq6Pqdf3M5FGkRQrbY28nCAH2Y8O8EpTLdB+uT5rz2jwL23ceJ700qeX3dSWBm8w0WSLAAEx0tpBTnfBaQ7g3s0JT3tXz78SDRAzjnq2zSXcJfUkePK6Wihg47530lddg0xL7xeQ2T94I5ULm3MtLZHH1aFuHtCDOUwFh3QPHhafYzKNxf1FY7Nt5DOT1Qn9uIwQPhWEAGLLAz6mfJoTMWyi6L73uQbrZrccDY+dt6be6nD8dr2NXaw8v17+d+pMsPUM886MHq5SVP3xnxD7aTc7g6O8mVW3SGGi6WNMjU3IEwMMlyzUgJUzX264Z9LPm+Lawh7wdowfSoFzOWXSGL/VUWqAM7lXxjjTXi8fIIhTIQRDFtoFD6vxnXLqXJ4eCvB64mrbJuqPdc0H9VLxpZedfVimqxou4XsrZqgAVGOFGtyS9tBEb21IE911w50njTNX+SOBuAAhDlAKqIDVF8S1w6mywVU8w6WKG90HWo7Vks2ILD0fl8CRAv3XCMd2o/s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVRtLzJhSmM1S2JTbnFJcithRDNqWWl6bU9rcHF0RUVwbEhZWXpibjAwNExU?=
 =?utf-8?B?QVdGS0ozaGNrVDhlK2RVYTg4am5GMmVacXhQZU9JcTdtc1pFMk8rajFycUtU?=
 =?utf-8?B?V3VaMkoxV1hVb0JsWkNYWllDYlRHKy9yYUlsZVhNUW5KZ245Y1NRdzFXQUlF?=
 =?utf-8?B?bE1mSHNVaDVzWVh4cHdSYjJHZU9kK3ZNUmxTQUoxVHA2S0dGcEtlcXVndFVT?=
 =?utf-8?B?LzhsQWh6clZTSFRvVXoreTZYYXkzYyt4VlBlZWlVdFc4dGlCL2FLVVAvTS9R?=
 =?utf-8?B?SXBuTXQxaHJsQUlIa05sbnEzdzdoaHl0TEM1bFdIUnUvMVQ1TmwvSmRKM2c1?=
 =?utf-8?B?WDBWOWpsdGVIU3REUE9TSFRFRk1wbGRuekJuNUJIbjNWUVhSNjZZcTVqdEpI?=
 =?utf-8?B?MFAzQVZqWXlEWXl2QlJXK1A3czc2em9xMWVPMllBcDBxVmloSk1YSmYrZU5C?=
 =?utf-8?B?aFJXQlVQQ2pnTDdQaldnaDFXaE0xbW5qMGV0T3BBM0VtNTNwSXBQZHBhNHQ2?=
 =?utf-8?B?bCtrN2UwdVlNcFR1SnJtdFl2dmlDOU44WThnMXVBZlJMVE1vYkJJVUR2b3ZT?=
 =?utf-8?B?dDNTMUQ5SlBvSVJJaVl0UzY0YmVJNkpZREIyT1Z0eXJ3S0twQ1A0Ky93ZnNE?=
 =?utf-8?B?S1lTSnlqaWdUMW9VMWl1Y1dJZStkbHFxTmRSSG9lK3V6dlFzUm0wUE1qRGFp?=
 =?utf-8?B?c3dndlJNOFRLeHVJMjFXYXY5L2tEa3hpL3pDK04zdFYxd091L3l3Y1MxbXBs?=
 =?utf-8?B?UjVmMmFvcVJEbmNySnJOSHhhUEY3MHJCbmI3NUMzZnExODFGNGRueSsvNVJL?=
 =?utf-8?B?YlQ2THgzOXNDS2RVWGlUYXl3Tnk0c3dVTVhNSzZKbGd5Y09jTmlIeFFjUjA2?=
 =?utf-8?B?OVA5V3NSNWIxcjNvS0t4eEVhTDZJYlRqQXN1NzRoRHArd1d0eURCRTU2WWF0?=
 =?utf-8?B?YWlVc1k3YmcyUGJFbFBNUzM5bCtnY3VyVWJyaFZLK3J6c0prS1F5WksyWEdO?=
 =?utf-8?B?alB3Wk01OS9ScFN3WHR3Sk05V1NmYVNSZVpTMEcwSUFTV0dQNDVHNUNvb2VH?=
 =?utf-8?B?YmkwSjA4OEZ2czc5MmJ6bDZlU2M4MmxMZXFSTmswT2JEVGlJUTIxWDNCMlZH?=
 =?utf-8?B?UTJ3Nlh4bEcyUHZZQi9VY1FrTVlic2dsVUswVFg0ZVlPT0k2RGpCK09pODlk?=
 =?utf-8?B?Tndxd29kMTF0Q21qenFCUmJzRWtXNGJhdU42VlJOVzJDMjJiVEFxZnY4Nm1I?=
 =?utf-8?B?a1RySmFMbnBzN3AwZDJVa3hScG1iVXFFYWFnRlIxU3Y5TSt0eWQ0SmNrSC9O?=
 =?utf-8?B?aFFoRWxPTmNOc3kxR041TFNxd1NlVTF0SUhtREpLQWxmT283Y0kzbElrQUZL?=
 =?utf-8?B?N1JobXZJUkVYVFVkQWFFSXZITy80anRWYlhBWit0Zy8vK1FvN1h6UHc1RnRX?=
 =?utf-8?B?NHNaU2J4OHZPOWxvdGJRQit1MlNDS1A4d2VBVW13aFA2ay9vYmtTY2Y5YkZp?=
 =?utf-8?B?aWt1QW9rWEFJSUVPNm5xVjBrYVlQVlZXYVhBSlNmQzNmRE1URWpMcUJHZzR1?=
 =?utf-8?B?V1pwVENlWXpCbVpRdndsWFIyTXY2MDR6YnNDSnBmc2lramFwV1NmMjlOeHdO?=
 =?utf-8?B?MUo5WGJ2eGk2UXFFUkZlZXhWNngrS0Ruc2Z0Tnk2SHdFbDJPMWVkZzI0dHFY?=
 =?utf-8?B?TmtoWkVOTzNoUlkvK21DNGFhakE1aFVPRzFBN3kyMklZbXVzbkN4TmtURVRM?=
 =?utf-8?B?ejZoZ1BHdnZ2L1RDNTN4cDRxRVVyQ2FzVjhvNTlKeHBXNWd0M1o4MzE4Rksv?=
 =?utf-8?B?Vm15MERLbHdrZ25od0dDWU13SHdBam1qQjR2TFlRL3d3V1lNQ3h4Vzc0OGd6?=
 =?utf-8?B?RmlubW9qSEh3YU5vNDhmbklzaGs1K3kyb0x5SnZYZG1zeHZ3eUNrVWhQRTNQ?=
 =?utf-8?B?eVdBcFJsblkraGlRSWJUYURxbUgvZ2hPWDVzeGJaWVFadkZHY3AzcVMxd3Bt?=
 =?utf-8?B?ODdtUzMyd2RobWxaZlBRZmx5Qng0dS9tZ1pkN1czNzY2Y085a0U3dDJuSmRF?=
 =?utf-8?B?bVhGTnFSMFdHM1lrRWpIdlFnbmgyVlo0MmdqcnNVdzF5SFkvUjRxTmFmTXZp?=
 =?utf-8?Q?0pn5klcySipqrOEMUvcVMDn/J?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f76798c-c037-4079-2e15-08dc5eff18c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:54:50.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+Ad8fDIborUH91nO8QNt1grZPlpthxOPIyx1W1T5WhQoujP+Q2PPiJVeDanhMqb0wD8nS+ADhxt0CFkTPFUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3174
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Apr 2024 16:55:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15573

From: Jan Kiszka <jan.kiszka@siemens.com>

Buster it moving to LTS, and backports is getting shut down. This breaks
the build of buster-based swupdate images. Fortunately, we only need
ovmf from backports for the sake of testing, not for production. So it
is fine to freeze its version via snapshot.debian.org.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/debian-buster-backports.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
index e3331567..0691140c 100644
--- a/conf/distro/debian-buster-backports.list
+++ b/conf/distro/debian-buster-backports.list
@@ -1 +1 @@
-deb http://deb.debian.org/debian buster-backports main contrib non-free
+deb [check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240411T000000Z buster-backports main contrib non-free
-- 
2.35.3

