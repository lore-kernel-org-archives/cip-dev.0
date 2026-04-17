Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24657F8E4B6
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 07:31:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39312.1776411057978435688
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Apr 2026 00:30:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KXNMt01v;
 spf=pass (domain: siemens.com, ip: 52.101.84.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JltOzF+VWeSicGB/pcunf1daFZAPl5Nr4ZeFir0QC1iTfJ3iFeuhxPfo+ytnfYo9IV57A0+aN0JqrumSfh3FrV8Wtc/THA1vjVuccb8CqJZ9VSlEr1NEZgz1o+urb9PKNMoPV0iqbI9ZuYmCANptz4UbqWuhXfQXgUYQngCZrB/ypxKA23/mk61eG/belzNxzL8ZdFQYK6Q1dvOptn8yXX0TeP9grOccCTXa9VqYeEF9DAZnTh5OqVTlH37TzdMGVbATYHk/Upu2rhmyMMx0tZaatASPi6mRhrJbmK8P90iNOPsjxCXyYCqJLPSUSjMXxTq0GczrGEW7cUo3lq2rjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ7AphWo0CBst7KP/ZP+Zz/wAK02XL91sVOu5wnDY+Q=;
 b=ZFucSKxtNcfJkzYdEq1qXbqLwaq/821Gz6BBLid7+mZoJwGqa7CduI22mVMJ6OhBzsSovmgPeJ2n6xlEC3XGAP32p38fU9mkNni0KglD/7TSPaxHz2w6ZOjMM7c8UXmqcu1Dhb8ZminEBZDw9ypIm5L4VXJlIldJAO4jHG57BX8wJWtx1pPBTM86ijNig/7PM0PvGJ7/TvgE+wNtI2sycM4dfFll12vI6kPQDlL3/cApla2CLKX+XiXNYFrY3jtzgVym4BKqIPmjz14JCSWfA5kUgw2cbpFVgOqBKnwl6EHwXQKnhCOPWg4Dy262Kgo/DNndaqctrwMPypQ48w8r+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ7AphWo0CBst7KP/ZP+Zz/wAK02XL91sVOu5wnDY+Q=;
 b=KXNMt01v1tzolWLy527M8ZglTK0TmSeeJi1mSH0cOd3mm2TzuxjJmlMe4pzQe4lXGKqjfzRZSxZvSstwJ5Z31wMqC8v+72uWjbyhmyNMaGud4bKbkm/ThaojyxFbUvhd2qXI+gSs+qqjuhX3cKD4xwEcURslB6mJMBvGrWJ4/ilpgZEYYOOnNzovBp/hA6l3jufyCpahphue9KL+LSYrVkAPWIvSLi9V7YiGywRa0Cyw6Uy6Bumi09+BOqNBsDWjVObmaXT+At1+4wNhlhkcZjUEsBYTU4Sold4i3HSBI1/smTcJhbx6OB1Ie6/qPAPZE4YqtprjuTCrwV7rrjHYFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:30:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:30:54 +0000
Message-ID: <95cbfc86-fe62-4429-8b16-c97d8f31e357@siemens.com>
Date: Fri, 17 Apr 2026 09:30:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Update to v0.22
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa9be15-6035-4c73-e1b6-08de9c534233
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	N2t+8iemqs/kzm28C4cb6U56VEcdFCjG3O4EksHClCpfl/FlHCX3llnW+2F+YpjtU+bqcbzlz3zUGPOQlo0Tg7Bn2mczT3PmcL2JI1gjidDQf65PuRGroxqKRWAL7R2Hywt3v3fGr+VHqIZ/USPdzJI6gUZaE60lgg5Ao4bq0Rxtl/LgSc/a53NuYvEY4j8btleKnvVTT9OHDyDMmq2BDI/A2N5YWMSc9n20y0DQQJ4/eqdbbqPan9LmCPjzn0zYv5LPf6T0cDITuRYx3I5CCpxpcG3iw9pu93a/H0npAI8ku9ZTDXnloAocyQz1OshMXFdmxDU3SiIXNTMRM1YZQDOOzMckN+h19xPxKkDRu/9A5SHZ4c07jWXfL3A1dHM3FJHUFwdLZf3shd9/hQLytkvHjjXYMGV/Z3iNcbIQM8/m24+6QikXf2dp7hCzO0giJlwy60okqb8evEHuYHedKavciqN4MVqK7RHmPYdtWFAcUsaXOx4FQUUNmOmZk2QODCIuciNuwr0BcnPqF9n2vVPamoLr4NDTiJYwTQejl/Lf6Tw8dsu9G8RQX3G5zf0ED4oqmuSYr/lVGhWvrWSPTFzljaP0je/F8neYRpEasr8ac5xqKLqC/o9atz8Y+N5wKhBHWIt1ZqJoyqkU15lDj/B0MN6hqu/o76mXGyyoa9HDeeUhiGLrmfouw8zSQj3W3zEtyjTe+EptALtx/xdeWKNjAjUeMg/DLnX7V4UsnYs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkVCNVZsN1loK3k5cDhodC9UcUIzeE5kaWJqYVBhbUVmOEhMZ1RhWFZvZzNS?=
 =?utf-8?B?aHNHLzh1eXdENGNBcnpxSlJ6OFN0QVJKVVB3a0hiNTk2VTdqUENjbXlLYmVD?=
 =?utf-8?B?T25pbFFkd0J4VzJpT1FPQ1hscXhaRmtRYWpBY3dBZWdYRythbEEvZEhHNE9z?=
 =?utf-8?B?Y3poekZFc21zZW5KQVZRVnlZNzFHMDU2RmZqckd0MStLazZFbkVNd2xlSDc4?=
 =?utf-8?B?SUNLOVlHaUt4dnVJdXF4ZWJ2THQxNVdVRmtCakZ4WlR4cSszZjExcW1tbmdT?=
 =?utf-8?B?Nkt5THRERFZzUVZHbFFJaFFSSVpxZy9KVm52TWRNMkVRN2VneFQ4RUl1WUI4?=
 =?utf-8?B?dS9VQzRHcmN4RmVBSVZ2NjJFSjRZZjR2THBjODRkNEhmM1ppeDNLUkR4Smo2?=
 =?utf-8?B?ZTk5bWowb29TOFExOHdRTi9icG15SUVmK3Rsa2JobG5tNlRxSGkyVTFVZE05?=
 =?utf-8?B?TUZuVnNtSzZuOUlQdXYvSEZWWncyUSs4QUtDZ3lNSVVOQlZvQkdUZDY5L3g2?=
 =?utf-8?B?QndQeThnVHFXV0w1SzdtOXlNNlJjdjljSlRlSDNjMTlGaUpKNUNnRDM2VEVR?=
 =?utf-8?B?TTl6YlJMOUZjMDdQZS9VQU9JR1c1ZFlJNnhCMFZOY3ZpSkFIU1hRanVqT2xQ?=
 =?utf-8?B?cm95VktBTEY1dHJJbWF2Um9VY21KUE02cUxMMG1XcEpzUkZvTXZzY2oxUVB3?=
 =?utf-8?B?U2FCNmtCQlFaTThQQkQ1Y2tVUTZlbVFlVmlod3R1a0RsdEpsRGtYZmdzTkNs?=
 =?utf-8?B?MDN6bWZzOTllYytDQlFOQVl4b0h1UWtQa3FRWmFmUGI4YTYrc2U1OHIrM2tR?=
 =?utf-8?B?akFtZEh5ZDBpanhNaC9waVN2TTJUcGRmZjZzbllBQlMzYlBBZ2FUY0ZxNndl?=
 =?utf-8?B?QWFsdHlRQWdwZE5iRzR2UjNvTmJ1dDNlVldmUmRKbWdOU1dmemo1Y2E5QmRF?=
 =?utf-8?B?ekY4elkxVTVKMFFPVnc5TCtrOVplRUdaNDJmbzJTQ2wySTAwZDlPYUdXZGNT?=
 =?utf-8?B?RXNxWWN6dnV6WW1OZ1BNSTF5LzdOUXgxVlhwZEZXZmdMc2xieHliMVRLMnlE?=
 =?utf-8?B?RkhTQndZbFBnekFqdHkvbTY2ZytSb2IyRFFHQ3A4a2ovQ2lOeUFtSVhxSFFu?=
 =?utf-8?B?L0g3ekFYWXJyeFpBWG82c1lHa0xTNG1zUHRtU3JlQzhFNEZzN1g1VzNOU0Vh?=
 =?utf-8?B?UE9ySU5kTzhuM3hVbmQ2bmlqWU5WTm5Oa2pFSm5kc3hyRU1ERkFWZk1HTXRX?=
 =?utf-8?B?VE9IWERBaTdUUWFTajVDdTM0MUMxaDgvVHpTRFQrWTJab3lCa3pSekNURzBm?=
 =?utf-8?B?UVVZV0xJc2lMVkZ4NUdCRWM4aFFlc2VqTTdGMy8zaUlkUk9ILzBFelJndU1v?=
 =?utf-8?B?SldLSmZMSmsvZ0VSUklPRHVuZmN4MHFQWXNONW11NFN1RnYxKzM4SWdnT1BI?=
 =?utf-8?B?ay9KaDhqR1R1MFN3c2IycG9mVlFzZDYxOWJYSG5wMDRzNkdYaGsraTh3ZHlX?=
 =?utf-8?B?NU5hN2JxcFBJVlZDNkpuaDhDT3dGc2NEaFBFbnZZL1Fqc00xYUJZeUhNWnpv?=
 =?utf-8?B?MFNuMU9aL2EvQ3dEU3RRaWthRG9ndEZwQ3RhTVdVZFIybkRZOWxWVkNXWG5u?=
 =?utf-8?B?cFRtUE1QZVRPaE1SbFhjTk43Z2tkN1lXcmZIK0NKMEl2ZlBEeGVzZkl1Z2JS?=
 =?utf-8?B?OExWKy8zWkd3THdsOVh0ZjFBZXRrRldrY1c4Sks3cmhRVHhGOWtaRFJSZHQ3?=
 =?utf-8?B?eXVsaEtXOHdnaHFPOUpKUmdTVktRbk01SytGYWZHNy80Qk9JQWZDYkd4dkVl?=
 =?utf-8?B?a1FISzl5OVZTRXo1amRJc0tReDZKRjdQQWxEeUxpcGtTUkNBVnlFVllLWEhk?=
 =?utf-8?B?VW9IODBGWjUxWXB5ZXJVbDJwczZTSFlnUldMb0RuTzBKNTQxQXBoWU9aZ2RR?=
 =?utf-8?B?OTNwWDI0U1BtYktQT1RWM1BJbHY1UHE2QVVhYXhPcmhVYW4vRm90a05IMy9p?=
 =?utf-8?B?TnRocDF1b2pPWXlicXdBb0wzcW1SbXZISnlUUmtiWWljVHVxZ2lVUFdaNSty?=
 =?utf-8?B?dTB4M2J5bVlwNTBmM3NYa3dodDEzUjR1Mm05YnhKdGYvL0NDczBma2xZUXhT?=
 =?utf-8?B?eS9kYTVZSlQvWDQ4ZTE0Ykt6STZDQUNwVGJNRlp4VHREcEFwYTVqZnNUWGFr?=
 =?utf-8?B?VEFucTNJTjZYcUVMUU5nVWZsMm5oSVRKRjd4dmZtRG9VcnhGWmxHUHNhRmdl?=
 =?utf-8?B?L2ZHaHROanVGM1pGMHFLQXUvN0RJY3huTjJHcG45QUpCRzNoUy9BNHNpZStu?=
 =?utf-8?B?L1MxVFJOOHduVjRHOEE4SDFMdXFVSVJMdGgzbjFicnN6YWFCWTArdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa9be15-6035-4c73-e1b6-08de9c534233
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:30:54.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGPGojmY9nsW31t5h5cpyt8fFOEz/egsMKsX0y98P/KglMT44t0Vb3l3oP+iOV+dERN+PMSkwiCbBDJ4nKOnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Apr 2026 07:31:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22758

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...fibootguard_0.21-1+cip.bb => efibootguard_0.22-1+cip.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.21-1+cip.bb => efibootguard_0.22-1+cip.bb} (88%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.22-1+cip.bb
similarity index 88%
rename from recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.22-1+cip.bb
index b847b611..570f42f8 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.22-1+cip.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2025
+# Copyright (c) Siemens AG, 2020-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -24,8 +24,8 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     file://debian-patches/0002-Revert-d-Enable-unit-tests-post-trixie.patch \
     "
-SRC_URI[tarball.sha256sum] = "f252e87b6acc74df34a0d894f2b5188fe797c2a2b7a14a231b9f224ad9b9de20"
-SRCREV_debian = "86f686fab1a5a55c445718d4bd6a32106f2b8800"
+SRC_URI[tarball.sha256sum] = "6c68c541311dcc8c2be0042f7887acc2a24d2ac68a88d426380fdbda9f476ae8"
+SRCREV_debian = "5d27085b1fcacce130deecc5347792437acbeda6"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard efibootguard-tools"
 
-- 
2.47.3

