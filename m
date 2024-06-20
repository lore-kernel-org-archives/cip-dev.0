Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA23C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 21:45:24 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web10.59393.1718919914444423482
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 14:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B8l7aUhb;
 spf=pass (domain: siemens.com, ip: 40.107.7.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqIxbkFuvHHV9SLyURpAeLAmpLyNN8hDcv1MUeetHtiudFEugf5lShLaZik4PfrsAWq8WkEILFZ3lRSfEm52CXqFxfOnKgvWsvt2sJ+SH7l8BnTqgnPlBIra4XYz+bhOTIo8d3y1wGC1jNfBa60EBMos01tQh5j+UPnv3iPpraQUJMr0Dkw2nzYbH6uMRZvyD6/+MZNG7WNswGMi5TYRj5XLs/bWy9KOQr0jdRz44CLv4oZFBkz0BTq9qaBvRGw5OOieOatiSleQ4z+GSPsY6nLGErmBQ20JV4FPFOeYOlZL4SvtYMf8N2IB/oRq6azRxqSrMZuBEY5ZUB29n9sbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upiRin8krMIgMdie41R7mDX0UUzsjRFGUgyxhFpN4nA=;
 b=MW/nHS6QzHs/TBbNadM6H1P/SEPrBMgUlxe+YaSKnhAV/1sJ04+2dhpQY0LBN9vTqF4jvXZbn6j4OcFM2xlAAN9vwl1hX3ZROyV28lnOQwHXephfnQiTFP1xspjPWQVEMb7phaIN+Duzcu2fIlV/LjbB1YPruze5P6U9c5DsaYpXueraPPBDTlmlHgktfahrxV6OZblxhFdAoww8JUG01/Cn2pRHdX/l88hCmIn7/WrkZJiP9yz8CY/2OQZRqg2PGOZBbsb4ULtCosGrgE9osLLSITKcyJlnbxAZqhFjAX9GFuiN3De5yy0kWfZ7RV4cj6zffdJVsavc1kQZjfRmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upiRin8krMIgMdie41R7mDX0UUzsjRFGUgyxhFpN4nA=;
 b=B8l7aUhbni57EKy7l7ZjqyNsvfuV/NyG1mppABZftkRvWH3C9/f3OL8rKwyvvFsPybvw5t5EW14dxDXV2CuDfHoh/fKnatBKVaWligaj1/rSx0WNfkYsvTJWh8PksXKSUrseLvugYq/2hp7X0CjYu33J3QO3frL9dUsx5amAdJORN9dmKI645vEmARFNThkk4nnpNoW1dphluO4dK3JReXqObObrmKUeaRHrfOYgdMkdZOAp5wioVaV94/+2XBZ7s+T+Sfmrhi9MSmErW5cyCsR0vnQE6HOqoUiGZXbQZcDe3JvHfc4XfzHkL1LnGEMH2pdF0Bxq/NNbTW1j8u5N8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34; Thu, 20 Jun
 2024 21:45:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 21:45:04 +0000
Message-ID: <977d677c-6e58-4698-8953-dd40c97042b0@siemens.com>
Date: Thu, 20 Jun 2024 23:45:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Make EFI Boot Guard watchdog
 configurable
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 4841f621-f308-44b8-c5cf-08dc91723eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3hCWVNBemtLY3BESXN6M09obmkyY3dwNHBMNlFHODNRcUFPQ2VwcDZOS2h2?=
 =?utf-8?B?VFF4b0hSemZzaXFPRUR0M3lEVkp1bnU5QzZXNHE2a3JwRTF2MW1LNVhZVDJ6?=
 =?utf-8?B?bXJuMWltSnBNQ0tONDNodGRGVTMrZ2wrZnh3Z0wrbDFsMURqUEZMNEJSZy90?=
 =?utf-8?B?RzRrSHpxRDlzQmxQN2c4RVp3WHVyMXJqNmFNelo5VTJpWHduVEppbWdwTzRT?=
 =?utf-8?B?NFVzaS9FajlXbWFnWWdPMTBFWk1FaFBtcklhTGcxenZzbm9WcDNDSEcwT3N5?=
 =?utf-8?B?WVJFZWR2eTNLUkM3Y05YRkczWjZSUXpzMjVQWlBMeFBCRGJSeXVRUHpLUHEw?=
 =?utf-8?B?dWNWeWFyLzN5WEVqQ28xTDZQUjRLL0RwSVUzTG1xVmlNaVkvcytVdFNhd05B?=
 =?utf-8?B?ay9SbXoyaGhHN2dOcU1hUTNSckZkWVdwQlc2RFpIUVRMSzBWUUdqVTVOZXB0?=
 =?utf-8?B?bS9ncjliRVEzc0tmOUpjRC9hcFo0ZlV4VjBhRzJQL2dncXlNVXdsWVhQb0Ux?=
 =?utf-8?B?M0pVTk5VOW42V3NhVzFHZ29Nc0YzeEFwdTM5WExJeWV1UlRENkhIMFhiRnBQ?=
 =?utf-8?B?blhPWUowYWxBYS9WMXhuZGdxaHlzcnNLUlQxcnlVampibndSa3VteVRIWGhC?=
 =?utf-8?B?MWw1eWhxMm8vNVFqL0lrU1l3SEdwQ0FYOWxIeEFKWkt3V1Bncnl5RlNlVHVt?=
 =?utf-8?B?VGJXTkxkTDRVV1VTdUhsQ3hoajlFTWVPUzJaN2xTMDBLeVhRUXhnaUh1cW9J?=
 =?utf-8?B?RXZ0emwrVmt3Vk0zSDltREpKRnlvQ1VqV2Z6WEhTNXg2dHJTWU9DMFpwQjBs?=
 =?utf-8?B?aHJ0WElBMHMwUGtFUXRDRm51d25tbEZFSWNUVHh1bmpUNUhJeHVsRDdyQldF?=
 =?utf-8?B?QS9aL3JmSnBjRXRsMmNBMUJXNmNUaVpqNGtLN2oveFlTOHg5dW5ZSEQrMUVI?=
 =?utf-8?B?MWlhdnBtcEJCVG5qOGFVQVdyTjkwV3lyUHZLalRBU0lVVnlNVXM2ZnMyeE01?=
 =?utf-8?B?bkxvTElKakk5M0tPeTlIeWR5bUZIZnhWNis3LzNhK0RpMDdJWEZqWXorQU0x?=
 =?utf-8?B?a05rRmZ3YUpoaHVwa2lPaVRrUkRzdHVHOVZvbjZsUkVSTmQzUFpGZ1c4dTds?=
 =?utf-8?B?N2VJaHNISW5wWDBwVlY3L2dKazNHUC9xRUVFekxVNlRvQjJlaERtYU5LM3BI?=
 =?utf-8?B?ZWljL2hjLzRZUjBIdjZCT0NSOFMxVHVsMThrQVY2NWViM1FaTHNvODM0RVJM?=
 =?utf-8?B?Lzg1Nk9kL3o0Sng4dXM0Y0J4SFJxK0VCeVA4U05NcFMyR21FaFFTaFpFOGlR?=
 =?utf-8?B?b2ZPSnFQS0FURm85a3dLT012ZU1ORkFkYnNMRjBOZzhIZ1N0UlIzbEFtQW93?=
 =?utf-8?B?NmtWNDc2dEs5V0JpSDlPQ05KdmJBUXYrNVVkd3FXZEJUZjFpMXFXdmNHUGZn?=
 =?utf-8?B?MHNoai9pSllxVG1pSzQ0OXpURXBBZHRIbGhCV2xnazRDY2VzTTM2QTZyS2Jy?=
 =?utf-8?B?WHBoOEFyRFpnVVZsSkVEM2h0V09QYmVGMGFVWG96SHNZSGVoY2dYdG5qamFi?=
 =?utf-8?B?aERmYlY4QWpscGpWZUZRcDJTSnlEMG5mYUVJQy9Hb3NyaVJUaktrQ3I4a1dR?=
 =?utf-8?B?TzFMaDRWZUE5ZytxVXhNRm1aUEZnd0l2TGtManc1N3pkTlV5UkE0U1pFRm5X?=
 =?utf-8?B?ZDVsSkdPbjRLbTRlUGNyYWRYb25iYUJsd3lLeUdMTFdJTFExVWRhQlUrZHhl?=
 =?utf-8?Q?iat2rpYQ4KDXtFFqnqxU31/pkp/K9kal/3kk2US?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2Z4OWZrUEVpeHZCN1ZISlU5QytCZjUvVEY3cnRpMlF0dGI4WkVqcmMyZXZF?=
 =?utf-8?B?L3RyaVN1d3BRQ3FXcmw0ZU9YQTI3QTE5RXRBakpYaitrUFVyOU9abkxaRDVB?=
 =?utf-8?B?OEgzWitObGhYN2huV25PZUZqTm9YMWY3dUZia2pmajhwZ0ZrTmxBTVZLUGUx?=
 =?utf-8?B?eEx4YUNQSHJIbFBvQzUzWWNkWW1HU01xV01mMGFtVVdLMzNTRmdmTkhBbUk5?=
 =?utf-8?B?aTJVNjh2OGpJMHVXTWhzTFBVS25JYklJQ1N4djhFNDlYNzNIcVJ5WCttbGxl?=
 =?utf-8?B?bVFZbWsvclZZUkVtbEFRb2xCaEFaNitwNWlOTW9HUTI3ZFAvbDVaaHo1aFAw?=
 =?utf-8?B?d0ZIMVFISlhPOElmSVZOOFBBNmJVOGs4Znd4OFJUVjQ5QXgyalhCU2tPV1VK?=
 =?utf-8?B?NmZoTjZxblg1ZlFuYUp6L3lPejdReTBtc3A4ZjR0Y0wzU3FUcStCMCt1R2Jz?=
 =?utf-8?B?TDBwN0VPWVZhTng2VkJpeGVPbE1xUU54akNaVFV6alJVVnBZR0Fad2c0QUcx?=
 =?utf-8?B?ZklzZnFmTjVXT3MreDlWMmFPYXpPMWQ4UWpHa21IT01sQ0U5QjYrV1czY1hU?=
 =?utf-8?B?c0VLZTZ6emVlSktMczBmMllZVnBZSHpCTm1KcnE5MnVXanNNSC9jajdKRXp0?=
 =?utf-8?B?UUxFSmdhdEFWZG54eW0rL0VXRUpqQnpjZjVIcE8wSmY2S3JURmZYZlRLZDIr?=
 =?utf-8?B?Tllmb0VteitzcE5WSG4vU0U3WUVaQ0UzanhIVXNMbmlzTnRmZVlWYlJVdXZU?=
 =?utf-8?B?WThGZVRuWmpXN05jRXUwcHVub21CU1ZDdGtuMk56Ukg5SlZVMjhhUnVnTEhi?=
 =?utf-8?B?ODJKYnhhUk1PUXRRUXJBQy9wNzdzVUxUVmZCb0RLaEcrOWJUL3YxQVhlOWVT?=
 =?utf-8?B?bU1CV1lzc2Y1LzhsaDlacHdYdFpGSldUZm9BMHBaZTVnN3gwLzJNR3ZIb3dK?=
 =?utf-8?B?ajBXb0gyMzJzNmtsSjhnL040cjUvVzdJVERrOUVoT1VBQ2o2TWwvVDFoOElK?=
 =?utf-8?B?Nm54OWhTQUhjOC8yNEJ6MVlBRnFzSlVzYU1DM091cVZOWEs2NUhJdGI5bloy?=
 =?utf-8?B?cjVldExZZ0RxVjJiVHFIYUlvTFdQaUFWMDdTM0ZUUHduRThWaFNPQ1lLY3I1?=
 =?utf-8?B?T25mT3g4MWxWWWFkU2wyRk9ocE9KK05TMzBjdDdvbmdqQmljTjFxRTBkNGFY?=
 =?utf-8?B?NGNUU3FRQnhkZUgxN0daUUNPUUpqRUpKYWxPT1U4eEFPWGQ4WGljdzh6TGV2?=
 =?utf-8?B?K2NjOUhIalJjUGlma1VxSG9OUlEwRGJiajlMdXFNTEhDNnZ4L3V5Yk01VkVE?=
 =?utf-8?B?OVFCNDB3T0JsQUNCeS9EZHRNbUtjTnV6c0tqaC9pbVUzTENOUUZLUStxSGI0?=
 =?utf-8?B?d1BBNkZKaUNET1o4NHhDclJwU1BaZ0ppM1ZRZVQ3UVBvbXhldHVaN3VhZWJI?=
 =?utf-8?B?T3pMMzVmU3N2bmRrQ3dWUExRM3VUYkVVTkZZaWVOQXJZQWFOR0pmMllJM0dD?=
 =?utf-8?B?VW5QeEN0cm1NZHBaN0Zpb291a2hydmJiL0lraHdUMjBnanhFcDRhVHdxUjBs?=
 =?utf-8?B?c1BaM3RCc01tS3ZjQzFGY1lTWjJwQzU1TDloMzcxRFBzSGkyREpJZUtmYVlj?=
 =?utf-8?B?ZDhJYlpwbVB1b3lWcHJ4b05haE52K1c4dFVLM0tiM2lSQ3cyc1pWd2VKbGZE?=
 =?utf-8?B?dzdkd0wvcTRrdDgwUVNYZFhOR05NcEhzOVVSZ2F2OVF3NElYNEZGTlNReWR5?=
 =?utf-8?B?WE1FZEE3WVFlZ0Ezb2YrYVIvcDhwdDdsYWxMazZncG1CSHJLOEFQUlE4bFRa?=
 =?utf-8?B?bWdVd0FDRHphVnBtQTk1enBTOW5ZS2VydEczbUs4aURIWlZUb00yUUs4U01Y?=
 =?utf-8?B?b1NRMjRJMXpEdW5tRFhRTU9aVUxCUGNMN3NMejk5bFNjemIwNWNJNFJyTkNz?=
 =?utf-8?B?bzVwSVg0eTNxczNXbXFLK2FqMnMycGxOa1JvY1QxSWZPdnM5WWtTd1hXOXk2?=
 =?utf-8?B?NnNCNXBzcHUvTU1vUkdhKzZVclcrVVcyQ3RKN044WUZza2RaWXI4eE5GM1lH?=
 =?utf-8?B?bFFFNnlRZDJUV1lZcnBvMEl0WFF6eEExK1QxSzc2cm5ZdStnL3kyTUN6a2Mw?=
 =?utf-8?B?Y2sxcEU1Ui9iU21Bb3BaeXBGUGNyVmFZOGsrOXIzdXdmaFJ0c0hxdW1Fb1hU?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4841f621-f308-44b8-c5cf-08dc91723eb8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 21:45:04.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62IlM2FpdpzCiiEZxVxQqqT2XmKhTE6t+KB24YaleHtJNd9By8PH+ltKZTf3EBVr3Eh9PdqFp/Ub96+jeN4WNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8211
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 21:45:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16306

From: Jan Kiszka <jan.kiszka@siemens.com>

In order to run the x86 image on hardware that is not (yet) supported by
EFI Boot Guard's watchdog drivers or the adjust the timeout to slow boot
media, add a Kconfig option to tune the value. This prevents having to
patch the code to achieve this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Kconfig b/Kconfig
index 9aa05d2f..96f590a0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -225,6 +225,18 @@ config KAS_INCLUDE_FULL_ENCRYPTION
 	string
 	default "kas/opt/encrypt-all.yml" if IMAGE_FULL_ENCRYPTION
 
+config WDOG_TIMEOUT
+	int "EFI Boot Guard watchdog timeout in seconds"
+	default 60
+	range 0 65535
+	depends on TARGET_QEMU_AMD64 || TARGET_X86_UEFI
+	help
+	  Timeout in seconds that EFI Boot Guard should set during boot. It
+	  needs to be large enough so that systemd can take over the watchdog,
+	  continuing to drive it via Linux.
+
+	  Set to 0 for disabling the watchdog in case hardware lacks support.
+
 endif
 
 endif
-- 
2.43.0

