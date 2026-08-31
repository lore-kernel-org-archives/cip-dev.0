Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE9C61DD3
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 06:27:52 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23847.1788157668398178399
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2026 23:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CGFjE8MY;
 spf=pass (domain: siemens.com, ip: 40.107.162.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH99QNhTgcY/ux9yezGsUgCqgrXNKpmygYz7brUbB2YC17Kxk0Ov2jcrXNNRYb92NypQ9Hw66DGAcY67HeEHANTTODM5H51IZ4Qjd50Ynl12v3hD8QmcNQvj/DkK9Js9L47xGEnOjzRTaxuL+9gPfp+RCU/amFpbhnPt8EMJJQmsZKcaNijbXbybT3bkpbxdk8oeQfJqjy2B6UDnpMXRR9DaBcfkAeQvT7aRcLmmSiFVv3mdiVZAL0M28vwBLnk9wat8XqtX/H8GF0r2nISzXA4eXaVmEh5wdulzvxm5yaGXRh3vJ11jTCCYi1WD6MGEJAGEatxPL5aaoydq997Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vHD4T50GmHryRNHtO0RjopCmCjnXN6rhYorXronHqQ=;
 b=tkW92KDGIJ+Vh9vGp6LS1/zgUlkIvIffzRFnEdUOesDbI5RFdTcPfx3YpfPL1ZekeOw+FE/Fh9K43KKnfB5zbPOgTdPMsAoiE9yTGiqTMOXKLvITDTr5CSqPUBuxTaWRCVol5V2UCjPNqzZGPLxZrKd4DnfvukX1083/oSuiSHEjF31KEbmBmaxAidElrsw3vo+yt0OA0qdtso9sQCwcRyidnn9aQHvF1G+u/JEBOTniHtIS4ZI13gXhw5xuBf29rJEBkGU4vMEPdKXQJmUhlTH/mgu0dH9YmOJK+GJBgpJABKQA2rA8STKZrMeeMIL5YtkGn0Zhmlu4jNkJJq7fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vHD4T50GmHryRNHtO0RjopCmCjnXN6rhYorXronHqQ=;
 b=CGFjE8MYrI/SuwSDalc+fgKktRd1bZXuJoSLUAGWgmcGbHe6rDmSkAQ91Jo3saGp9gmvNvnEIBo/BX26ohHMWkzQks7R6dpfav94C1Wu0Q4GEVYHZgb+Wtqub3YnRNWCP9JIqniLH58MDTgdfrhi4j7V8AoKf7kKcQ96cPtxCTFO+b3PXdAFof3jYyLMitZRbI7QQ1NUeVocs1eexyfsQSp7wSrLomkgPTZkKsdCpVlPqXdarjKng0lxuS2GpUFGokZIZAYAm6508ZRDkxG2DA7EVmUX36PhUBiJ0nTbMhUPG22P5OR9VsEZkGt9YiykuwnwUGpTQEQBKBxU6pd6Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:27:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:27:42 +0000
Message-ID: <47f921a3-f4b3-4a57-a700-14a0de6be278@siemens.com>
Date: Mon, 31 Aug 2026 08:27:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] optee-os: Drop redundant CFG_EARLY_TA=y
Content-Language: en-US
Cc: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3140:EE_
X-MS-Office365-Filtering-Correlation-Id: e09aa8e5-412e-452a-67ac-08df0728f654
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|10067099003|18002099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	YWKRf/7DNCoCCT6NFDWOY0YMQZJaAXxlx4RUYkPKar9O0x09nIOaoBbKralqFLjFKY/l6dZL060op0imqFBdI9o6Jk7xOjBE4YsefVZftOoEJnlLJFDN/U2OLo+X+5Et+6FjDDSVn3Cyh2yZv7QCih+UApteyFdGyimKYndVjPgkycPm5QsAskFH6Lvp07MWdwvoUIcNi/VZi4RCYSUY0Tj3k3jKk14IOp9Lx1olkOjxZ3var5BiBb4O86F5WAlOLE3/AvLWZrtEkcp3JSO+OKv2M7uqbYSTyRwGo7xb15NElbk9h1FaT4IS0jq/yWZAh0g1qRH3e+BpHNo458qbcw55B6Pz//xSLbEnKJ0tv+ROc5b+fJs+bGkwYPbktcLRV71ARt4b5hAcKxSDIm09yX1WVDAL4hl5uGXVwZ6fWs8SOttEx0xkDzNRCxVvvDhgnLFF3BQxQxV5lZvodEm/ojLUDz27sF2AXnSV5qIz48YRoKkKz6e0LjtlQlPgPHl5C2zgkFj5Tocgph5qfp1vLPP9O93OhuNj2aZVrRoInR4Fbnd/VLfuag1Dcw6vaMsPfV60w77d7bMPaSD/ZXiWqqKX03aVlP6gztJ/q1H0s43569PpS0NGLNU89bGfFV84Q+k/0PkBb+CS+ZqQULzUQBpBdh6Uq6d50yUKHKXgJiA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(18002099003)(55112099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnB4MzlLMmxXV0k0MFlKa29WY1dpVjlUTE1XT0xaSkN3Z2hZOW5hcnJKZEF3?=
 =?utf-8?B?N0tiZU95WTc2RTBNNldzcE9Qa0FrVld1N1NTVnpIZGZXbG1DK2xTYkZSK3RJ?=
 =?utf-8?B?a1oxdGFidjBzVm8xZHR3Umk4WVdxVllBWjlmQVNtQUNDQ2FtbUZnQTVuSXcr?=
 =?utf-8?B?UkF2eExoUTBRbEVKeXBBUE1BbENhMkFscjdvTzJ0WG1FSEQzQzhNSXAvaVJK?=
 =?utf-8?B?UlhQRzRqT1ZnVFcwYkhsVnJFWmtYc0RrT2NBMzBWdjlxZFJ4NUhrcXNITXRB?=
 =?utf-8?B?NHliVG4wY0lFUUloSkhHTFBHNFRmR2NETnN3OVRmeTVxbVlBMUphM2J3UTl4?=
 =?utf-8?B?OWNRN29iRURkOUQ3TlY0NmxYeWFaMThDQzBJTGhDdzhjWllDclltRmljb25v?=
 =?utf-8?B?bjVrWmxGT1JDVmwrdG5wMkpTQmFNUnVQTDRYS3ZTb1pYRmEvUWFVRlVWNWQ5?=
 =?utf-8?B?VzJZVERVd0twM0xrWjJiUkJlMFJkS1hBKzkwVEc1VFdMbjBTOElDTkl3clR0?=
 =?utf-8?B?MGhhekNOaHZXUXJYb01sMFUzTzY0dmJ3SDY0dlRMajdmMm5oQU4rcHZkWkdB?=
 =?utf-8?B?c1BTUVVCYnJkUCtYMHJIdDRvZ2p5NjlpODlrdjgwZEVmZXhKbXVIanU5N2Y5?=
 =?utf-8?B?UEtWYk9uWFYyRnJ4OEV0WmZERGNEaVJCdU12MnhUWXJRM2U1QkhLc2h2Ync1?=
 =?utf-8?B?VWdLYU5sV2phYVU5eTNzRWkybll5bFhhaUpidm02bnNoaVZjQTRGYVNRazFm?=
 =?utf-8?B?RmlHY2xkak5VNFFYOWVQcVgzMTRJWFJ6bFVsNkxicE8vdGx2eFRLZjBZbHQ3?=
 =?utf-8?B?Wm9teHhFYVJsZ2Fkd0hJbktTV2JsclozRGVvN21LM2MrZmlMUmMvOGtUNVAz?=
 =?utf-8?B?M1pvSHR1TXNodVM0alh1TE52SWJhOVJxM2huN0ZxQ3BGUkZUNnpwYWEwVCty?=
 =?utf-8?B?ODJGYmMxT2Jzd2NTbVBzK3ZiczIydG9DZ1ZsdVpuNXlBdUNoTVNXT1h2YmJE?=
 =?utf-8?B?OFhRMzQrUlNxYkprNEtTNTg1ZWtrKzV1b2NKK2ZBbHRTd3FjTHlFNG01ajBh?=
 =?utf-8?B?RGxhVVhDR2RENXg4RHRaRjZMS1ZQVGFVNGptWFBGZzhqSklyQU1mL3pFZjR1?=
 =?utf-8?B?aGpKdkk0WjQwYklrR1oxVUN5TWRxMFZwcXZQMjJlTzQvUHdvMEJVNTRLNFZm?=
 =?utf-8?B?Z1Q2SVB3Nlg2aEtpODNXby9Pd2N0Ui91N3haUktJaDRuWjdhaEcxb2pOMTRF?=
 =?utf-8?B?YjlBN2hIZDJPMWdCSllsL3AwbFlKR1FMdzl4dy94aXNtMWp3MTNlTVpEYlhh?=
 =?utf-8?B?cnpqVHFDMlJJbWtwQkR6ck9jMVFYQ3Z3YVQ3YkVSN1gvUE1JeHFLOTZneGNx?=
 =?utf-8?B?YmFuYVhZRUkwNVFIWk1IT2tEZGQ1OElaRjRaTTVhUk9LZVVpcXlDb0VSWldY?=
 =?utf-8?B?SzB4a3NCUlhoajNOTkkzci9KUjluZUIwWDJLNGVXZE1SdUVXODA5ejRCUXFu?=
 =?utf-8?B?REJISDl5czMxVnJuQ2dEOE9uVytTbXhKOE9FRDVLVXJ2dlNoWVllVzJORHJJ?=
 =?utf-8?B?eFI5TkdRdXdJb2FsRS91cUZPL3BjRVNoNWltWGZ0OElWNjEvZTBSQWRYVXZp?=
 =?utf-8?B?K1lrdWJuQlc4Z1FGVHZUNEZFMlJyV1JiSzRST2hpSWVxaUhxck1DWDZnc2tO?=
 =?utf-8?B?WVpNSFVBY3M3dGJhOFczZ2hmcGJ3WU1pQnJ5S3J3N3QzbWt6VHJvVUpibUcy?=
 =?utf-8?B?L0tldFR4eHo2UkNKQitsVDhaek82emFwbFRCbzdoQmk0WGhsKzR6dDY2OGx2?=
 =?utf-8?B?QU56YjVpVkJkZmdXVWJBMzA1YytYMld1dDY3SVhzM3RBalZjeXNCelc3M2dp?=
 =?utf-8?B?L2lTWGxsbnBIME1mT0w1S3hVaTN2Z2lIZXhJNW1TbVdNK3I1SWhSbDd4YmZ3?=
 =?utf-8?B?dkIwVllGb25DQWNhbmVabHBRWU9UbTJUU1RCSjlEOGNXVUtBUWxEelV0ZEtZ?=
 =?utf-8?B?cDN2QzZmbll2b05nNnBpVkVkV0ZIOWZnZ2FWRFFCOS95U21jSXlwTllxMFVj?=
 =?utf-8?B?MGZFMnc4RU42aUVKd3dEU1lVOWU0MFFLV3pDTmIwNnU1ZGNJSXVmYWtvS3Qw?=
 =?utf-8?B?R0FxTWhCeHV1bjdzRmlGb082Ly9FWDJFcnpxVGxGcHJTVnJzVTR3NThMQktV?=
 =?utf-8?B?RVowMWwrcm4wb2EwbHV0TXVtOVYwRkNwQTVTa1lYVTRFTTY0V2JvZFUzUHF6?=
 =?utf-8?B?NWZVYVdMcFZ5cS9ZMVZjOHNXS1IzQmNyZHUrK3crN285T3VUcjMxS1NQSjFw?=
 =?utf-8?B?T2g5SFJKdzRHd0huNnk3RkNpOG1EM0ZlMm9aZTF1VjdRQjYzRXFEdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09aa8e5-412e-452a-67ac-08df0728f654
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:27:42.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR/BTFB2F7J3u8saB9KUkzUJy8BQmLjwV2vet7rLSP3W8p0yPfG90nzYq3sq3Th81ytmWd8Cjihe+Du4nqExcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Aug 2026 06:27:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24047

From: Jan Kiszka <jan.kiszka@siemens.com>

This is automatically set by optee-os when EARLY_TA_PATHS is none-empty.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/optee-os/optee-os-qemu.inc        | 1 -
 recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb | 1 -
 2 files changed, 2 deletions(-)

diff --git a/recipes-bsp/optee-os/optee-os-qemu.inc b/recipes-bsp/optee-os/optee-os-qemu.inc
index 3538d36a..48a51b8e 100644
--- a/recipes-bsp/optee-os/optee-os-qemu.inc
+++ b/recipes-bsp/optee-os/optee-os-qemu.inc
@@ -41,6 +41,5 @@ DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
 DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
 FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
 OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-    CFG_EARLY_TA=y \
     EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
     "
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
index 82fbd53a..1090e081 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
@@ -23,6 +23,5 @@ DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
 DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
 FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
 OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-	CFG_EARLY_TA=y \
 	EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
 	"
-- 
2.47.3

