Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D2EB64DA
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 19:53:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.75])
 by mx.groups.io with SMTP id smtpd.web10.21265.1687463622241491524
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 12:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s3orFmcZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcwafzv0kXDwrb9OlpKmfY4ksh2RqbNaQJED5PEA41LdNr+jTOW3DTNiiFPYmg/6mOZ1Sye98Gnxdp/KBakndtS2wWbswkTO0ihAoW7DWwpp/19oCAlHH8VpWhF1yd3DTf6HPhyMdZ3KBKUuW/QDdAsPZIAfLIukWZccWJPCoDwjieQ3kFVCHOCmyc8yPUux6PNO3CkQFHw1L78dQcJQlIYFz1mvf9/G5bNrmWG99ChUh5UZFmjnrtFEWNEgLM22Jdgacy/gfd0N8PWre2gzqsOduxeRcIMu4YAHC0btM03nxGzroL/e9XzOehRYqLncCQZQCxTsr47ZgyjVUyZF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZGxay4UpOdpEn35PZVm1fQX+KoDT2Pu5CaoxID79QY=;
 b=JjAVtGaJxbSQhXpYyeAf4Y+mQCeQWHmKaYmFjpVtzb6+gHfpEZYSIqkBo+3lMgHSgeFsBcNAYOoKuR4+colU788LF2iwXUlYE8UPneAh0OFX9DqXknmUi8ZvTuyro+RucLkRnFgemIoRGBSVchivcX2AYoyDLBl+2h9dFs3EJf+5l34QY1hx6Y58033eJEBJwfJMnyhFurbQDA/8s2L/M6MAbEQfEg3zeFAPv7O4Ep7D22NynFK8xWyPYwEh0OeqjnMFikHUM5IejJ5Y2wBWTwl1pYhzDe4kmQPBPe18rYfjr+0l6I7o74SOPm1u/MxZOeflidO1rdHIeSEECM8szg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZGxay4UpOdpEn35PZVm1fQX+KoDT2Pu5CaoxID79QY=;
 b=s3orFmcZVayOzmJe3PYjzAtHv3hYRVFhodCuHZJoS1rAmLExTRo6zSULReWYmL0bAvGL/EjCM2ILP8h+572HIPMH/NvQ10pzD/LDHG4tSLrqrl7TpFwDWb1GmMBdxHKtaBuPgkYy4yz2E5yIpnhlEjtaws2ypmY+7aDl3iDlEHCXzdbOcmtFuCIiOJAYjQyu4+rLbHWOU+vAdLJeOOCv1+MaeAbPYdjyeZcGfWkU265ph/nuCwdXEkKlvKp+EEki2QyK0y+CmrzCu572Pi1Lr+dTJVoziDEolW9tso0jfff1pIiyaDWm1DV+NkQZefXZii8phGe8WCxTO7kK1fgQGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 19:53:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 19:53:38 +0000
Message-ID: <448dcbd7-e782-631a-85d3-333260f22411@siemens.com>
Date: Thu, 22 Jun 2023 21:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Add missing lib for
 bookworm
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b85b53-e29b-463c-7dbb-08db735a5f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ufAbUzOtvr9igk7D3kRE3MxefaQVei+nbNd3Eampzie3PkuafXyuYwvS5fWGhCH2sQ/UV9Xhz48O4ph/F5OvxthkIDx6UECm5RM8oiFH3B3b2/bGSoeTm2ESlmxcyDW7G/a/UhINx0w1QilSG/CFf7hHqxygDEiPoz2uw3tI769FGxB6K2RUfxB8RZCfBgfcobXO6y2nPToTeCGgEZIbSm7azuaFqgTT5ZZ0eoH5dwm+mAbZLztf667dIG6P5O8TFnAOzZQIFgdNAZArANDLc4UqSY3xrVuBVmwxhKv4SU3zbotjYi4arxXPjjlRzyEUlFP4+cjyjb3rJF767X0/yP1l5wx7m3Y9DITUHtTgjnFoAacGKGBqKEgP7uH+1J2kac9s4FZTybBOaNjLSIyDSQ7/UAkFJSSAcGXQ6A1CAg6hkFoXpZ6RsxvOQgbrWvYxEa0niMDTdH/esEY7sR2UfQbkUTWPVR3fxX7xdQq/c7lXA+dkvlIWvjGi9AUFbltn30QyDQK0zb5w2rqkazylL+OU6xVYzI8UV14xkGLd1Bw45dTT3HtOVHrz+CzlU1niP9xndfX5bfz/IyG69rf5SQb0vWoEleqm9WC5FdsmGZQ9GeiG4+F7oLM5Kq78GEfSThR5VRQyFAQavDf1Ag7iYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(66946007)(66556008)(66476007)(4326008)(6916009)(2616005)(186003)(31696002)(38100700002)(86362001)(82960400001)(26005)(6512007)(6506007)(83380400001)(6486002)(478600001)(107886003)(36756003)(31686004)(5660300002)(41300700001)(44832011)(8676002)(8936002)(4744005)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0ZVTTZyMS9QbUJ3cWVZTWVRbzA0MWR5TWl3Zmh5WU9EN1pVcm9JUmVmT3JN?=
 =?utf-8?B?RnVWVDUzRjNhUXZwY281WGVCR1JxVnp5VHEyTDJwSmlPTUoxa1Nrc0UwYXgy?=
 =?utf-8?B?SjNEaXgxZWJ4KzQzSjB3VmJoZHlDQWdMdDhXSVE4WU90LzlJZU90bTRkbUl2?=
 =?utf-8?B?Ync0TDUxU0FwckNySkx6S0VHSnNjU0s3VVZ6Slc5RUw0RFZ6TEVnakhxdDJV?=
 =?utf-8?B?aEdFVERVNjlEamgxSVhsblU1ajJReG0yQ09QVXV6aGdQRnVsUnRra0JETjBo?=
 =?utf-8?B?N0ZVZ1J0cmpqKzd4L2dXeXlzd0U2b3hJQUluc3o5dWZiQWN1aHZEc0JzMmhm?=
 =?utf-8?B?bGNTREtIaHNISzJwa2V3YjNZNXU1S2pMRDE2L3hyOENJVGhDSExQNm1iRDA1?=
 =?utf-8?B?RkJOTUJnZkloWmtSUlJ3eHJ6Y3hiNG9lTmE5NEpuRkdkMUVJTEZiYVRBb2hB?=
 =?utf-8?B?cHBDejErV1hLdFBPWWkrKy9DTGJVNStxR2VZM3hDV1p2M1BocDA3cENjV3pG?=
 =?utf-8?B?Q2hQNUx5cGhYamR0R3NwS0pwTlNrSVJaaVNESTAxdzJJYmUyZnRxMEpDNXFK?=
 =?utf-8?B?VWpLZ1NTVmRLZUU5T1d4Ti9OL2tZVUdKNHpIVGlCVVlWS014NVVoNEpkVHNy?=
 =?utf-8?B?ZDM0R0FIOGRScTdJeG5DNzN5dEo0clMxL1hJSXVuUGpSWjBlbFRyRkE3bUhj?=
 =?utf-8?B?YUlWTXVsTlZoQWVtc3M0bE1GdnNLcldOS1BUNTBCaUF0UDJqanZmc2tLVmM2?=
 =?utf-8?B?WTJhUTkvZnV4a1BXRkUyOUV5SUttMnBDeVBrOC9lVEdrSUh3ZUJwaVdGV1Rs?=
 =?utf-8?B?Um95OEd2R3F6WWNla1hWd2tXalE4ZkMydGVxUXBtRW9vYURSbEhrSmlXYlJM?=
 =?utf-8?B?S0tDMDFYeHZXRVpGYkZ4Y0p4NU02cnJBb240R3JYeXZSSHI3dngxVXpySW1y?=
 =?utf-8?B?cUpReFk3VnVuUGU1dW1SaEM0eGg3Q0Y2aHE4OFJlMVVmY1BxRWF2b0orbVgv?=
 =?utf-8?B?WU01ZklGMHE3MVR5QmM4V3EzYXNXSklaalowMmxnSStCcEgyU25jK2pXNTBo?=
 =?utf-8?B?ZWdSQzNOZHBMMTdKZGE0MUZjaVN6U3NJUDRNcCt6eUkxZ3NwZk14MnFVTE1l?=
 =?utf-8?B?aFJkaW1WOHB0SUR2alpkbmZTMElnS3c1L1FMMUJtUS9ZbnVCc3RNV0MzSEpB?=
 =?utf-8?B?bklkQllWaC8xblJyUFlqaWdmTGFDQVNCUW5FRldncDBJOE9BOWp0UCt1bTFy?=
 =?utf-8?B?b0VDRXJiZUp2dzN6d2ZHR25wWTRDK1pNdWhrTW5Edm5oMGs1NjlKWVBSNTlL?=
 =?utf-8?B?ckg2UFB5LzJmNm5DWk8xaExVZSttNE5Kbk03SlNtS0RvWVlzc2xoMW0xWGZU?=
 =?utf-8?B?TUhoWGVvSk9vRE55Mm5iK0pHT0VadEg0Y001eTA2bXdXZ3Q4MUxjVVF5bzlZ?=
 =?utf-8?B?dXQvVW5odEZ5a2xQdXJyTVNOZGY5UXBVTmd3d1NEVkhIOHBabnNyeVN1cGJK?=
 =?utf-8?B?L0hCaUY3aWNjNEFhems1YVZ6L1VSN2M3cXd3RzUvM3dqR2U5Q0x4QlQ1TnZ5?=
 =?utf-8?B?c3dlQnVEejcxWTNnWGxtUE1JN3ZQMW1qa1V5MjFjOHFvZnU4VjE3OHF5MmpS?=
 =?utf-8?B?Y0V2UFF5aW4rNllaSkNoalF0anpVdXlCbU14eE9VclpaanFCc1A0MURIY0F1?=
 =?utf-8?B?b3lBUHNmZitxbHFuejlCVDZ6OWVYenptdGplYUhiUXM4ai9jSW1BZW9tcWZQ?=
 =?utf-8?B?WjZFRzBRWUJvMThHNVV6Z1V3eFcxYTlvbURpdzlEaUlFL2tLZGVYeVZpdFc2?=
 =?utf-8?B?aG5peXorTjVXY0dCYk9jM2p0eGt5c09qNFRPZWk5cHkyT1ZQR2E2dGNGNDY2?=
 =?utf-8?B?TWV2ZnBieG9wU3FoRVBmendjVGE4L1dQbmRRR0p3R3krelJ4WW93bmF2SzJr?=
 =?utf-8?B?aUdka0tJUHY2YkhZM09ZM0puQTFRVUJuSUIzcnRReVJyUlo0T2lzRmxkWk5q?=
 =?utf-8?B?MFBqUVlFV05kWjVKV0pKbWtDUFIreWgyU3poSE9KczA0WEVwSFFwQ3grRDRO?=
 =?utf-8?B?L1lCVXBuTUJOTm01VUhsSG1wUVJobkRMb2ZGUno4clQyRzJCTitwRHpIT0RZ?=
 =?utf-8?B?YkpCQXFJMzlPeXVXWmY2Mm5CK0s3anliTlpiSkJndFFyRkFyaU1teCt3SVdV?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b85b53-e29b-463c-7dbb-08db735a5f45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 19:53:38.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwL/u7CjsKHOjV6DDEeNcRTIDcoF6RV8RHQe1II6V+kEytTqlUjiD8oT3bwR/CATypkhfOUydsTU6qtpg4aFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 19:53:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12133

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes

libgcc_s.so.1 must be installed for pthread_exit to work

when using the hook with bookworm.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index e3a296fe..fa37b57a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -47,7 +47,7 @@ if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
 
-for _LIBRARY in /usr/lib/*/libtss2*; do
+for _LIBRARY in /usr/lib/*/libtss2* /usr/lib/*/libgcc_s.so.1; do
     copy_exec "$_LIBRARY"
 done
 
-- 
2.35.3


-- 
Siemens AG, Technology
Competence Center Embedded Linux

