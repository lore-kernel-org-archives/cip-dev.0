Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CBBD1358C
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 06:05:58 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.45])
 by mx.groups.io with SMTP id smtpd.web11.45143.1730095555034005693
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Oct 2024 23:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ThJAy67a;
 spf=pass (domain: siemens.com, ip: 40.107.105.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OscM3EmjJKh0WryjB0r7SUnjRuRCbFLalSoUDriVfLb5223By2efpl8KT1+jaBSmLyyL2JOoCqSX0NvHPh/09mU40rKlCdGl2Q9O56zaTYqyXhenddXu4JqJWHbVw6kSAbsZN3w1ORGa4cW9SsHSsHcn4btnBoQbdZo0/ppEoSP8shubEQFmMuCm43g86lZ6HauTWv87xw3b8P04lNhfrmHUnf654s2Z/vra9LxcXws5pzr0Cbo9RT/5ZiFHmHyX9nI/UTjlIqKqTDRohLhk+XjA4l98/rbMuXbmLnH7ib5Lz/mX/znVgPJaUpHQTLukSRaz3AZRHfXBMs7Ifdm1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiXd3bbmZtRpMiHtSBA2gQcIyBgLFqOIq0LFY++QB7E=;
 b=Nu1KiiOMPMOq2snSgrEzrknIJ5kfSwVQlBV1KKKHMofUjjxR3RbjO8pyz0atXbNSzeFyRfujdOyp6kNbZUEV4uU5BsagzTup4yOGpNvbvOCc7JKbJiSGGxCM595JDyqFNYGgRJpOaVyd2OKmfeY854+7xwe7tG2mFCtmSOEQRHkyb0a5F6mT3PVrqtDaP5uZROWNp9hPFERVzAMro1NknxHR+OEl1KZ5C3PF3Z3uWQKBTTV0vBdK7NV8aj6miCkDCTPIWpimHqKClXIsB5Lm4CWxw5xthc20+VhTdH0JZ0XRv/2dCVrQS/g1oq0Ii51O7AyRTDIrNwk7TzGtR0ajLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiXd3bbmZtRpMiHtSBA2gQcIyBgLFqOIq0LFY++QB7E=;
 b=ThJAy67aSHPFOqsiHge72Z06XWiZBCkyqLLCyGcfD39wNdSPbPkb2YJb7FWQVxX98u+BluN3vJqrPxtkqhFsA3IzI594pU96s3t+7rt2Y7PZsaQpc82H5hFCYHQxulBjVQzoHT9kYGBvDE40WosdE+z8DOP7/O4CE2iCo+XLdTsnB1I7alkIkf2VTJdnjbCznRrXKrNpqDu7qckEfwFTG1oZBttGoXDfjBg6E5ylPxkhs2Kgmvi8gskBjaYL6XSTkEKOxZYgtwrhbW0XSejmSguFjWz92UVJ34w47VUPDrtU75cO2b46kDiCjmctlzWLku/fNO2aBK9uBFSxZITlyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Mon, 28 Oct
 2024 06:05:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 06:05:52 +0000
Message-ID: <b51e861f-c67c-47cc-90b9-139d60d1593e@siemens.com>
Date: Mon, 28 Oct 2024 07:05:51 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] kas: Update to release 4.5
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d617748-6a38-408e-3099-08dcf71693d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFl6WmVxV252Y3JEaUdwUkVHVWRhY1BDaW1mMG5TZ3g3K3dBWTdWLytzZTBS?=
 =?utf-8?B?SjllNU5sVWVQZFllZjVER3Fub01Yem9mWTdwVFIyUXJuanJPQzBUeHRlYm1B?=
 =?utf-8?B?eWFRejJhWEo3K00xaFJxUjRrMHFoZUdqRjdDRFpuU3EvVDR3cmdzcnVUQTcz?=
 =?utf-8?B?bVdYNGNja01lelllVnFVOVRxVTlFeGptRldndFFmUGdKdXFORWlRT3lWNW8x?=
 =?utf-8?B?a3VYQ0YvU1dxV1kvUVVjTHdjMGFPbnhkcHh0S29JTmF0b09iVG1UblJiaytB?=
 =?utf-8?B?VVU2MXhRNHVpNi8xS0c5V1I2ajJBeFdDZmNuK252TTVETVJhSjJxdHlDU1Bh?=
 =?utf-8?B?UHRWcU42ckxrZnNIbWlFMlZDMFkvaUNGcC9qYzZMNFM2L2ZLeGJ6NnVGNEJB?=
 =?utf-8?B?Wm0xMW1MeG81NUhINEFERGdrUnR5WFlmRjJ0QVl1TGJJMlh0aUN2UHcwbXBG?=
 =?utf-8?B?aGYzYkFnQ3FKOTlBODA4MjVMYUhyZEoxZGx4OFJWTUhRaEVJV05XUERqOVBt?=
 =?utf-8?B?a0RNTG1YZWx5UTMrRU92WUJOL01nTlpRc0kxOW50MHFOcjQ3eFk0a210WWlO?=
 =?utf-8?B?R0YzT0hROVl1WUVaQk8xMC9SRkN0SzlYQXZaeHZWWStTV2gwbGtGZTF1bW9o?=
 =?utf-8?B?SjlNWVRFeEhNclJldGxLNUZBd0kzWE1Ud1AzRXF2ZHNVT0dtOVkxOWRqVU81?=
 =?utf-8?B?dkk1TTVuc2VWTE5oc2RBRmNlQmhLcEdZWDVqQkE5ZHVBYTlWaUZWOHk2aGZS?=
 =?utf-8?B?NitsTFV0eDdNWHNqWXF6UTdGWkhyV2wzRlUyWEg1NGdwemh6dVFRZUIycHdI?=
 =?utf-8?B?bVB2N00za20wcm1QTzFwbnRXUFBXZlVQVzJESWNrMGozRWlJdEFldkV2Vk9P?=
 =?utf-8?B?UFI3dndySFZudXR4VjcxbG1BcFJCQVpaWTYvelhvNEpoSmhMUnJ0cTBvMmoz?=
 =?utf-8?B?ak8zWlgvZ3l4NUJHdVJSYWRyV2VxbzU1Sk0xYmp5VmV4TzB1NFg0MXhqYmRa?=
 =?utf-8?B?b0pJOS9SZEROKzZibVc3bzlQdm5oOWo0ZUplNGQvY1RTMjZ5cGhhYW1sNkpq?=
 =?utf-8?B?Sk5RdzBRMkpTVXlGNG1qa3N5d3RwU1Y4ZGxQM2V4czJrMEV0NWwwM2NWbklz?=
 =?utf-8?B?QXU0SVE0T3VnVDVETlJVSUcrTXZneHYrbDlFQWJDMDlrOEJuZU9Ld2srYitD?=
 =?utf-8?B?NGxqRnNNMzZBRHphQ3JFSmM2TjdrRHA2SzVFNmJnNFpmZk5vSjhZSm9ZcnJ5?=
 =?utf-8?B?Tyt0bDNSeE83RlY2REY3c3FuZWhvUlRzQ2VRbDBUNkI2UGpIZFhFbm95dDUy?=
 =?utf-8?B?NzkxRU1janlCdWhWRHBWYVlCTVF1Kzd3RkVoejg0VlFMam5lNk5EV0hyS1Nh?=
 =?utf-8?B?aXlvOHpKQU9IOWQyZkk4NUoreEFNY0QxS0JTY1dsaHNLcXZQOVZlK3hxSW1t?=
 =?utf-8?B?ZGwrb2NKVHV2RHluczFMSjNKS1BNcDFXVjJzbXM0bjlmakRYVldFbWZkakVi?=
 =?utf-8?B?cUl3RDIwQ0lkOFArdllUcHRLaE9ra0pnZVVsTUhra0NMZXhjbUxWUnNWNHEx?=
 =?utf-8?B?OWFMMC8xc2hpc29LTnhOeHgrc3JQbllBQkFEQjhYYzZpVkdhaGJlOFRIZmZI?=
 =?utf-8?B?MkNwVk5ySWpMNXJ6RzdOYVI3MWdCazluSERGblY2RWIrYm5HTkpqMEtDSnhT?=
 =?utf-8?Q?E1guR0QrcyHSKM8YLjUQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWo1REtLdkhsTmdxazZHeWUrc0pkbUdnV1FQa2F3aWp2eXhualM5WklwbEdw?=
 =?utf-8?B?UmFBd0xjWE1VTk5lS2NPSjdIeHNwdDA4bVRQc2JiZXN4OWYwdjU2UHByYTlR?=
 =?utf-8?B?MXFicVJKWUxFRnFwaWp6aDJqYVozUVZ3SzVPRm43TnNtNG8wMGg0d1VmOW5o?=
 =?utf-8?B?YVUrRGRqQ2VUU3ZhVHdKbVQ2K0NvTlAzdkRDK0Y1VkNRbHFGbkM0dHppZ0lH?=
 =?utf-8?B?ckM1MXd5QWZjMWhvWkw2RXhVN1ZKcTJUNVZ0NHdYZFRkVCtiY2hDODFZOTZJ?=
 =?utf-8?B?V0pvMGE3ZmtQRGcyRG5IUW9KKzZhZWkvU254eFV1R0ZIbXZJaEpmSUdCNitZ?=
 =?utf-8?B?aVErTi9seFdqai95Ni9QYy9FMG1RejlxY25MTjRjQkNwazlWbjhEeDk5ZmRJ?=
 =?utf-8?B?SkNPc2N4Mll3UnFCOXMzY3MzaFN4MU9IRkZQQ0NrMlZNZk5kenFzdHFvR2xX?=
 =?utf-8?B?UUMyZkIySmJsSUFxYmRpeVcxL3VrK0JBNjRiUndaa1h1RnNjM1lqNkFRb2ZL?=
 =?utf-8?B?ZFNkSXJpSDg5RnRmUVExVzNYNldBaXRjTDBybDBJRVora2h2bzFDMXdDdW96?=
 =?utf-8?B?dldvZFc3eEpHWGVpQXdVZG1uTkcrWXl5ajBDOXBYUlVPc3YrWGlRTFFQN0JH?=
 =?utf-8?B?YmNHYlVOLzBGQ1JjLzl1ZE84WFNubHZ2dE5QRkFRd0t2RTVlMDRCL0dKQkd0?=
 =?utf-8?B?ZzNBbHl1L2Z5Wnc2QkVacmtFUnc0TnMzaytrNmRGcVBta0RUaW42VVkrT05h?=
 =?utf-8?B?YmZ5d3hsOUltYUdEWkx2M29lbzE2TjNWdVMxWi9nbGI4VldrNGFmeGNyVDBS?=
 =?utf-8?B?NkRBTGRGaUVxZzhudnFjQjg2dlN1c3gyQURpTERLVk16WjFpSFlRUlZnaTRN?=
 =?utf-8?B?Yk1MbnFZT3Rrc1FkeC9DcEVXb2RFbVN1b3p3Yms4MWZkcDJNRms0R3dNanl6?=
 =?utf-8?B?WUI0TURQZ0RkZnJtdVdyelg4Nkw1MHN0Z3RIV3A1NVIvVXlDNkZsNCtuVnpl?=
 =?utf-8?B?Sk5KR282ZjVuL3EvUFhLbXZkaUtxOHVSKzF6Zk11c09ZaEtmM3RGSzdlTEFz?=
 =?utf-8?B?Nzd1UlFveVF0SDIraDFrZzdlM1d3NU1nSXRyc1RNUVJxS0s2c3phOUdPNFBI?=
 =?utf-8?B?SEZRUFNNMDl0MlNpOWdKblQxVW1mMFZhUWtDaWFRMStzbERSZ0NyWEFtbzRu?=
 =?utf-8?B?RG1Yc2RvSitjT2ROeGRYeWFWRHhiM240WnNEd0krWnpBNEd0bWpGekRPWVF4?=
 =?utf-8?B?YjB0SGk4b2lDMWZwVTRxbzVSeFZSRnh1LzM5eU5PLy83emhGdTlyaUxFUnl1?=
 =?utf-8?B?NmdTaGoyMG9wcHg1VGtERU9nRVhvLzV1KzU1c0w3bkVLU08zZ05pQlVydlpz?=
 =?utf-8?B?bms2a3cyUTRwSUpQWjNaV2svbE5ybG1GcTBaZDlkU2cwdnU5ZXg0SEp1RW85?=
 =?utf-8?B?d1BaeEtpZDVPNGtvM3YwTWRwYmpNdThSVTYwc0hpK3hhSzJGMjRBRzY2WXBn?=
 =?utf-8?B?dFlPdTdPVDZmQzl4YzQ5ekdrVGc5ZEdKMEs1bzFiZEQzdTcwa3FOTjFXWWJZ?=
 =?utf-8?B?cUErbEtJdUVaczYvNnRCUXVjdlRpay9VRXh5elBUcjhLL05adDE0aER1OW1D?=
 =?utf-8?B?VytkMVAvWGg0MkMvLzJmUDZZS3pvN3creWhLM2UwbzRmZUhndW1paWhmQzI5?=
 =?utf-8?B?MHJJeWJkczRzWnZhRlRWRjhKT2lWZGtnUk1HdHk4WTlNSklYRzRCSDc0L0hF?=
 =?utf-8?B?clRGZ1FSRHVuNmFRdkpGZkNWM1JYODc4bFo4MmRNYzdzb3o3ZEh3bnAvdmJ0?=
 =?utf-8?B?cFF6WE51UzhNOVg0NTRZZlRVT3R2cVRpeWE2aitMS0lscHZBdHJVMkN3RHMw?=
 =?utf-8?B?NlNndmR0eEdmQjV1ZkNuWnpMV2xEelV4MG16UktxNkhzWGt3V0lseUxnazUw?=
 =?utf-8?B?cTllcldsM3ErOW5iSlp6MFNPK3hhZVBXSmF4cDIxYnJjUkRxWEFTOGF2YXov?=
 =?utf-8?B?VHlzd3NJcEZkYnZIc0llZEl3M2E0cUhHLzlLRG0rbGdvSXhReHBIVnlIYUVS?=
 =?utf-8?B?L3B5dTk0N2kyNTdWT3NnN1Y5TmhicGtQSnVsWE5OYit3Y3Nrb2oyRnJWTGVC?=
 =?utf-8?Q?5+/v2WUlQFPAhoycRgU2+S91t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d617748-6a38-408e-3099-08dcf71693d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:05:52.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCN+sVZDcHJTLeTWUGkhRoX6Z9talMujILl2+uYV7soXf3FprqsnW8SNeB9zGfB8D73KtRql50+rATc49E4Ybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 06:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17082

From: Jan Kiszka <jan.kiszka@siemens.com>

No direct impact, just housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |  2 +-
 kas-container  | 53 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6c92927f..2c6a688b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:4.3.1
+image: ghcr.io/siemens/kas/kas-isar:4.5
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-container b/kas-container
index af938285..6b2131c3 100755
--- a/kas-container
+++ b/kas-container
@@ -2,7 +2,7 @@
 #
 # kas - setup tool for bitbake based projects
 #
-# Copyright (c) Siemens AG, 2018-2022
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -27,6 +27,11 @@
 
 set -e
 
+KAS_IMAGE_VERSION_DEFAULT="4.5"
+KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
+KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
+KAS_CONTAINER_SELF_NAME="$(basename "$0")"
+
 usage()
 {
 	SELF="${KAS_CONTAINER_SELF_NAME}"
@@ -144,11 +149,6 @@ run_clean() {
 	fi
 }
 
-KAS_IMAGE_VERSION_DEFAULT="4.3.1"
-KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
-KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
-KAS_CONTAINER_SELF_NAME="$(basename "$0")"
-
 set_container_image_var() {
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
@@ -330,15 +330,22 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
 	--skip|--target|--task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
-		shift 2
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
 		;;
 	-c|--cmd|--command)
 		KAS_BITBAKE_C_OPTION_ARGS="$2"
-		shift 2
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
 		;;
 	-E|--preserve-env)
 		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
+	--provenance)
+		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
+		;;
 	--)
 		KAS_EXTRA_BITBAKE_ARGS=$#
 		;;
@@ -347,10 +354,21 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		shift 1
 		;;
 	*)
+		ARG="$1"
+		shift 1
+		if [ "$KAS_CMD" = "for-all-repos" ]; then
+			if [ $# -gt 0 ]; then
+				KAS_REPO_CMD="$1"
+				shift 1
+			else
+				KAS_REPO_CMD="$ARG"
+				unset ARG
+			fi
+		fi
 		KAS_FILES=
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=2086
-		for FILE in $(IFS=':'; echo $1); do
+		for FILE in $(IFS=':'; echo $ARG); do
 			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
 				fatal_error "configuration file '${FILE}' not found"
 			fi
@@ -361,11 +379,6 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
 			fi
 		done
-		shift 1
-		if [ "$KAS_CMD" = "for-all-repos" ]; then
-			KAS_REPO_CMD="$1"
-			shift 1
-		fi
 		;;
 	esac
 done
@@ -401,7 +414,7 @@ if [ "${KAS_CMD}" = "menu" ]; then
 		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
 	fi
 
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILE}" | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
 		    -e 's/.*default \"\(.*\)\".*/\1/')
@@ -439,7 +452,7 @@ if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
 	            "KAS_ALLOW_ROOT=yes to override."
 fi
 
-set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
+set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT_OPT}" \
 	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
 	-v "${KAS_BUILD_DIR}":/build:rw \
 	--workdir=/repo \
@@ -505,6 +518,11 @@ if [ -f "${GITCONFIG_FILE}" ]; then
 		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
 fi
 
+if [ -f "${REGISTRY_AUTH_FILE}" ]; then
+	set -- "$@" -v "$(readlink -fv "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
+		-e REGISTRY_AUTH_FILE="/var/kas/userdata/.docker/config.json"
+fi
+
 if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
@@ -539,7 +557,7 @@ if [ -n "${KAS_REPO_REF_DIR}" ]; then
 		-e KAS_REPO_REF_DIR=/repo-ref
 fi
 
-for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK \
+for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
            GIT_CREDENTIAL_USEHTTPPATH; do
 	if [ -n "$(eval echo \$${var})" ]; then
@@ -587,4 +605,5 @@ while [ $KAS_EXTRA_BITBAKE_ARGS -gt 0 ]; do
 	KAS_EXTRA_BITBAKE_ARGS=$((KAS_EXTRA_BITBAKE_ARGS - 1))
 done
 
+# shellcheck disable=SC2086
 trace ${KAS_CONTAINER_COMMAND} run "$@"
-- 
2.43.0

