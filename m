Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15696D609D1
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 16:23:37 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27029.1765902210513403098
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 08:23:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TSq/D8YT;
 spf=pass (domain: siemens.com, ip: 52.101.70.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5WkfI9pBX/EVpzFnoz6D24w4uwysGd3Rfb6qINBUscKi6ocuIYJcsrdy8qyOWS7wYNs80lwxFUVyQPVKb//MeIFsG50kgTYZSGC8d1W+L4PLgddrvSMjp6654J4fhtgCyvZsqgzo+zPg7myePOgYjn/lhfYOYrmRdu6U7eGLEiENgcO26yGg8ebCf1B7FxErHddbYceFTEeD2plg+YT5jYUtCjPrHpb2Jieyb9pVAFki0QDZ1zBQsaGax35C+8vcRfPMb2EJq/Lvv5e7B+qBeo5sox1vQIn4ngKfQOvPIbGfOjtsRMjyY/k2JxMB8G2UYrZr/vN5HqpXljFLP6jZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsxskptO6zg24VaX5dLxTU18AYLpDrilS5RZMUMFR8Y=;
 b=Xkj9MF+7GHUgkJlZ0NEEunOEMyFXFZhTRzjg1mtt0wsdVtuwd2ITnPM2cJpxpl8Hm3SFmUE1azENSe95B0Cl8c9RGZZHBNtAqNqZFkGE/P5Z7SjAgH8Y/L7JayZSmdG7H5j/+6BWpX/GnjHX27u6I5R6dWF1gcJgE+9hcS6SH5OcyL/x0WOc3kI+/9RPnDesTOjkauq6QJ7/EGp7G5niCGmIAehndDQct0A+CdzPmbTDBa5Cdln8cB+tsab10n+sEFxH/MWML8bi0yQQlvxA57A1Xwe8Zsvhu/akbuTP1foS5qBcnUfKUwsfMKpzBsME5eHNTfdEEeDcuBhmGNPO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsxskptO6zg24VaX5dLxTU18AYLpDrilS5RZMUMFR8Y=;
 b=TSq/D8YTVyz7ws4nerUNgTsLGomlbQW62El30clFvcD4+TC352GaySbjqvxSExGSxCOAqrnWIYoBkRq4Wxv1p7F69UKQMkMuORiUeRSWC0Kwx3AbfxsCGz+73jNJA3geU/azhB87GYg22teTYXS2FNrqPtE42nfOGnFm7U+hgU7rHklcac+5cwZF4UH00fO363D1CsezTXBkn8ufazvrh3zZJ9lP24AdTTo8tOyEa6ZV4DBkbDJ54XXQcH0jLjvyOJr95jgTpjVrxu3kYi/hM7zclDxOl7RlDdXD+JCUkDuXJg5yOn8DzspfJIIet7t7OcNBDXH9XbbKank5+JTzKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:23:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:23:26 +0000
Message-ID: <dacd1c9a-059e-4abf-bbb2-63741b840eac@siemens.com>
Date: Tue, 16 Dec 2025 17:23:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] kas: Update to 5.1
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b4e224-39aa-4195-f309-08de3cbf704e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVJ0ZytwdDhFOC9XSmY4cXcxOEtiNlRSWVRQK09yVzA3MzRqY0I3RWxiODJS?=
 =?utf-8?B?R3ZhTWlJUWJGVk1YR0dFWkwvSzNxOE9CMjFCMmlyaEd2WVVyT1FKMThzKzVH?=
 =?utf-8?B?eUcwUkt2Z0t4K1lJTlN6dFhUVEhLK1BlemZxKytBMzB2VytuVXczOE9PTzdx?=
 =?utf-8?B?NWJJZVRkcDBPNUNPcDNTRWFOSUttYUx0RVljNnZpenZBMGJGZnFiakxRampL?=
 =?utf-8?B?NXRmQjFBNDdZRzNCbEl1M2c1VUlFUkxnWGdvemZRNjFDeXVnRklDUVp5M3JD?=
 =?utf-8?B?ZzV1QWFNMitSSE9vSERQOFhCUW1tbUR3QTlpNVBmZnU5b3RqbnB6VjIwekd5?=
 =?utf-8?B?TXN4ZEk4ODhxemsxK09YVzVKS3lvMEpWbU9vTHBGUW9hU1JuZFJQYTVCdVY4?=
 =?utf-8?B?NEQ5OCtoZGl2ZW5RYmxudHpVd0sxUm9YTmhFdWtDeDRrbHlNS01mVlZ6dXlY?=
 =?utf-8?B?T3ByZUg5NWg5YjIvTlBRdnd5WDFHT0UwbXNhYzdjcDBLQ0RudkxnR1h1ekJJ?=
 =?utf-8?B?blI4T3F2ektzRWh5RFpkSUQwOWdGbHh2UmYyM3lJK04wcjdEZHR2bTkxOUh4?=
 =?utf-8?B?ZnlVeW0vMlpaK0FZS1BJUlpHeE1qb1UrSi9TLzRiNzg0cWRnUThBYWdDV3c0?=
 =?utf-8?B?aDd2Rk0rWTVlVW1uektITExMMGlPWHA3VEsyR2cvOENDN28yZVpkekxlNjFY?=
 =?utf-8?B?TGJ5TDFuUjRWZHlqY0VMWXl3SUk2R3c5SGJnbkw3NmZNWlhSNEN0NjZwemNU?=
 =?utf-8?B?N1V2dFdHejl5dWROaVJGZVdpSVYzRisxZXNSZDl6eXZOVjJGb3JMUFlBdHdQ?=
 =?utf-8?B?ODhEN0pRa3hVc1I3SHhXRGtLVzE0OG44SC9RdjZZcXB2Mlo5diszNWJPVm85?=
 =?utf-8?B?NEdwK0dwOFpKaEVCVWpnWTg1MWFJQUh2OW9vcDFRRU1ic3pQbXdSRzdJbXda?=
 =?utf-8?B?MC9qRzdoOElBbnNDRldGWlNBd09VU1dnQ1ZxTml3MFlidFFzNWZuODB0VUV6?=
 =?utf-8?B?dmZ1d0t4cWFPc2xZbVBVTnVNQy9EdWZ4T3NuQVhNL01TckNtWWRMSnhRZjNP?=
 =?utf-8?B?dWtPOHJ2RTdDTlpoN05XTVE0c0dCNURCVHdoU2VOaWRQZCt6MWlnY013MzVX?=
 =?utf-8?B?R252a1RlckU0My9OamE3alpYNEtIOHRnUVdVNGdhZmhKK2FrTEJkOCsvMm9u?=
 =?utf-8?B?Mm1ZMHBwT21VNWpNdEFmRUUyWG1uZkxpNllBdGxZTXhyeGYxd0I3WWV5NTRI?=
 =?utf-8?B?UG5mS2g4TFlYalRIVENENVlneHA2Ym11bTI4TklqK3dYTDdFaGc4RUlSVjQ4?=
 =?utf-8?B?TXJ4ZzNnNzZGd294elR1cFkxYjNWVTJidVBnYkJOZU1NMHRZQWN1b2hBSFpz?=
 =?utf-8?B?dkNoSVNKSmxkWFRyc1UvQjM1SElLTlMwbktCS0s4R3FISlBURmVLb2tyajFG?=
 =?utf-8?B?QjhBZmxCWFMxNVFaWG9uNWZ0dExvVXZrTE0vS2dwcWROMlJ1Mk5ZcEVEYzFJ?=
 =?utf-8?B?SjhpbDBRUmFJZ3N4U2RJQ2R0dG1yU3JjVUljUFhCQ0VFODdGbUY2T2hFRTR2?=
 =?utf-8?B?R3AyM1IvaW4rMXlaQkhpMzExeFhFcUZoYzBDYkh1TXFFQjRwaEdISC9ZUDIw?=
 =?utf-8?B?QmxITzJRUGxEUlFPcXJMY09FU0NKdnYxeFJoSTU3V3VzblFabVVhbGFBb1E1?=
 =?utf-8?B?T1ErQ1Budkhzb082UHN5Y0o5YUZnK0d3TnhEaldPajZyWDNnUllwa3ovVVMx?=
 =?utf-8?B?RzJmTXJiMjBYQUdJVlJmQjcxKy9xdVZsSkxaK1EwdU5DOGFxMEpkeVlrYWlL?=
 =?utf-8?B?N1czYnRPRFMxY2s4SFQ3M3lQMzRPK25majF2eE42TUN0ZytHZTQ1WlFKMlJG?=
 =?utf-8?B?NDdrTy8vaDkybXoxaFZtSVdKTW4vNFVVVFpTUVFXbXZoL3c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUozUjJuYTZvOXlmYmR0UEZ3bjl5RHNRdms0Nk9ua0hHeVFNNkRGYWtOTE9i?=
 =?utf-8?B?cDVzWEs1K09acE9pb1JNRlk4c3N2QUZ3amZtRjhFbG5EZ1Q5T2NWZmwvcnVx?=
 =?utf-8?B?Ty9VVGt2ZEhsNFQ0ZmhiK2VRaVBhQnZtU0ZGRUo4cHNkM0VFcGhrK3l6b3Fs?=
 =?utf-8?B?MFQ0eW5qWGpPQ1MrOHQxTVM0LzZwZkRzNytRMFcxSXArTnNVN2Z2ZGpNaXYx?=
 =?utf-8?B?WVE4T0llVkp2ak5jazYzTExGcnNMblkrN0hlY3JPb0ovS1RLWFF3RTY5YnFz?=
 =?utf-8?B?VkNPRzBpU2E3UzFFckpHdzdERThBekNtSXByNlFQTStDMit5Vk5rMk9KVWdZ?=
 =?utf-8?B?TE1FMjg2MGdTNmVBQng2UGxkME16YTUyUHdXSVlSaGdVejFzVDV4WlZGSHIy?=
 =?utf-8?B?RGpSdEJTclJTOFY4dEREQXNRVCsrdys2OFpjUDZLYXE2MkxacStXMWZOQXJR?=
 =?utf-8?B?cEowQTFLWkl0V0hLcGFZODFOL1NvTGxHbDRwMU5aWitGRTFaZnJ3cENhVXlm?=
 =?utf-8?B?eGo5eVMxT2lDcjVDMmRaNk5od3pQUnNYVFZIRUpRaVQ0Slc3cW53M1dMRWFm?=
 =?utf-8?B?SEpxcEVmN1NSWXY0MGRUb3dKOFY3QW1hQXVicmozdXBxd0xTc25JUXJJMEt2?=
 =?utf-8?B?ZytaTEZ2VVI4cWI0b3d4Z3lKZVR4eHI5ZXU1bk10VWJCQTdaZ2lpblcva3FJ?=
 =?utf-8?B?eHg4U1owZ1hqNnVPOFRWS290Y3QxdnNtOEtWSGFNcDhYMEYwQks0aVVhejBU?=
 =?utf-8?B?c2lGc1NNUFE1cG5qcUhIVmVoWjhtL1pvK01VWWlUUXp4ZURhNTlRczFIaStT?=
 =?utf-8?B?eUE5SXhzb3NDWkNtcFIza3pUbFdsczlyOXNKajhmbEo3WW9PMXBqTU9yZjZ3?=
 =?utf-8?B?ZnBMWGVRTldLNHNXRU9NbitTV2NvOGhTdE9DRFpDTlQyU1Zsby9mdk0welF1?=
 =?utf-8?B?blAraTJCc1JxT1N0Y0xyNEUxYndWNjd3R0FoRkNQUlpzRVVJdXRGT08ycXN6?=
 =?utf-8?B?RkVzeGhTVjM3ZFlzVUtKMkZrZzd4SFhIQnJWdTRyUXlvanhqOTBHa1ZVYUhj?=
 =?utf-8?B?WmptTTRXR2FVSDlKbFQ1dktiUC81MWozSVZxWUt2QkxRU2V5c2VwYksxK1VM?=
 =?utf-8?B?MDg4UjRnY1hMRFN1dk0ranhlQkcyai9yUnNrbk5ldkRHdVA3cVNYQTBOanlJ?=
 =?utf-8?B?RnF4S2o3aHZOU0JEUHJuWEREQW51QlZvZCtkSy9OWjVCeFk2d3BTK0E0RVk2?=
 =?utf-8?B?U2VSbUVuTlF0cjZGQU5jN2lIeWhRa2Vqc2hjbVU1ZjlodWlrMmQxN09oZnhw?=
 =?utf-8?B?Um1SOGJORGM4MTdYbm5qK2x4OE1pUE1UM2NvWnBQRW9nRERBY1paT2hSNWo0?=
 =?utf-8?B?ak5sNUg2OUxBUHBwSXhrSWlkQVVucEtRQkZ2TFFFODNpN3c2SUh3Y29MejFD?=
 =?utf-8?B?aXNHemJ3STlOSURZWGRpMjROa3BUdURndEg3L05LQURTUm5ieDJIaUdraitU?=
 =?utf-8?B?WFhCd2xKWDB3emxLMFpoeFQ3bVJCUStLUFgrYWZQVXkxYzdrQy9zWSt3cEh6?=
 =?utf-8?B?NXl2SklBbk54UHFneWxhVFdJSXcvUzZsbnFUZnVIVXFqcU93OHk5N0Q3NXdz?=
 =?utf-8?B?anZ2bG0zL3VvcWdLSjBwKy9XbXFhMmswTXl5ZjVVbUE1QmU3aW1Ycmdpd2pl?=
 =?utf-8?B?VTdoelMrL09naHlCWEI0QzFCU3NPSkNXR0lNNCtQK1oxamZ1dXNTZ0ZwRzVY?=
 =?utf-8?B?dlM2MktNYVM1N1VlZGk5MHdHKytYVzZSNlZCajFIN2ZGeHBaUFRNYTN6dGoz?=
 =?utf-8?B?VmN4VDBBQ29weUNkY0xDbXBjWElTMGlJclhibkY0bDN5bm9LTEdqbXRQYzNu?=
 =?utf-8?B?VEtVb2NERWN6dmFERmcvd2RodjlSeTdlamNLd1lSc29mTmFsK1M2ZGpRYVIr?=
 =?utf-8?B?WHpEMkk4OVpJcDIvcTBTVTIzNElxdlFMQ3lzNjNXTWRZTUl1L1A1WFQwb3Ez?=
 =?utf-8?B?bmV6eC91SGN3ZXdYNGF1d0xvVnQ1VW1xMms4R1NCSUdHMG56MGUrTzd5SXFr?=
 =?utf-8?B?c2dEQzBrNER4aVNJa1Q1M0VTSTJldEFLZkxxWURDcG5zbGtmYk9rZFpsZ3ow?=
 =?utf-8?B?OG9FTEVmWlBiZjVnRmtEMXRtNFQ3a1I3VjNtcG9jRmxGUkVnZHRGeUNscjJ3?=
 =?utf-8?B?a2FVaXhjOWVUR25UZU1nc1NYTXV1Z2hhS2xwdnhGeWczRVNKcEp2dDkvdkJT?=
 =?utf-8?B?VGU3ZFZucUlubys5UGVQRWg3eGVBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b4e224-39aa-4195-f309-08de3cbf704e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:23:25.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NSpBRdxT2tPRyhx4+mI3gm5d6jBZ4wef0rjeVicmgLQ/dlYD9HBfeMJVWMnv2Ymmhj5R6PlkQIpM1z7MmIPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6007
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 16:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21089

From: Jan Kiszka <jan.kiszka@siemens.com>

Just housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Forgotten for -rc1 - I thought we updated already.

 .gitlab-ci.yml | 2 +-
 kas-container  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3a202536..db8d642e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -33,7 +33,7 @@ stages:
   - cve-check
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.0-debian-bookworm
+  image: ghcr.io/siemens/kas/kas-isar:5.1-debian-bookworm
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
diff --git a/kas-container b/kas-container
index 8e67071e..b46682e4 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="5.0"
+KAS_CONTAINER_SCRIPT_VERSION="5.1"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_DISTRO_DEFAULT="debian-bookworm"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
-- 
2.51.0

