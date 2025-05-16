Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC37C3ABC9
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 09:31:34 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.69])
 by mx.groups.io with SMTP id smtpd.web10.9356.1747387892960691260
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 May 2025 02:31:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gsg1Jpcp;
 spf=pass (domain: siemens.com, ip: 40.107.249.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh8mBTNE9b6W8ssGGFlUm07LmfsdhYIKXiUWNxVT7c5M8TrFjBu9hLdur0ikJLZBtzO8GHKrlokiMsznFwJu/JIt1og9yrU5mpZWnE+3Knk5axwnbX071uDV9BuNPG43STxz0RV61NAUpNnjRZPh8kHgfyZg1NdNSuDFm7janTB0iqvulk/SvczI6xWrsnRPCWFL7uRbaf7+34y2YnC5UFD2Shn+gorzhcviykOZWDA1NuukTlFw/dovR7ewMBCElSVovGVKfyVBlcyqpAGa5gcpwgsfKe+zqlpUO6PxqRUe9W7M/VDXH7pPGrqHA+Vc5AIXAUzjL2VrZRGZEM5/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr2en6PoBonT+U5ZNeLNL6g/dcc3DbAspfUlkEi2wSs=;
 b=hoaimwrYv/g7vsRlE/6bMXuTytp4eL3C8zoWyv9rWXryePkqu6kYdHnX/0bPsk2y3FQz0W/etb7GUMwQHUJYQSAxtA9nbthWFs6pIbQ26WZXe4TAA1Uh1T/NasU5ZVYWmDEneqK/F15pX68jfi3L0QAszFDKy0sUpjOHEdUZxksWiQ7hrUuSRH4Eo89vkah92VPPEDbNMyEisHJySi0Soy1y3j89H/awSb6K+sWtIkjdnWKGoUvW1MpGx4XEyrMDhXC9dirdIdWdECRjxwRfQ2YViE85MtoIHvDkpQwWTz92+/C6wPiB7u1XvwS8wzmRUDKC+MLKy9NcK34uAs8OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr2en6PoBonT+U5ZNeLNL6g/dcc3DbAspfUlkEi2wSs=;
 b=Gsg1JpcpD4UwoYZ+Zjxm0Y5QfMdQOCNCmsMLzyZxRr+At3mRXB5sL1ieW+YrDCZbLwBYl0VmSSksidlfBQxZiBFyFs/n2aZFkESXPA38rmRDK4pauI8sqzau4QuVUjs1mmqErfg4SLbWTZUHN+9COrE/Yc65Q9Z/2KC/zRqJ6YvNGQMuOAIUc0IlbcwBaC6p728Yv45+yx8IiSHM3+2NniASETny6qUbipeErk+qQPbQq3Hyr16DghllVIf8aE+ARphOmyqomS4bYv9sOOwYWxjFAkCmpiCm4DtklUedtrkFh4X+W+OuVkZBBjriZ7Wuy6ac6ojDfi1m+JyPdv7f/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 09:31:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:31:29 +0000
Message-ID: <38ff6d8b-4257-4077-b61f-e2c10dfbc37b@siemens.com>
Date: Fri, 16 May 2025 11:31:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update to latest isar
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 313a3162-91d0-446f-9882-08dd945c6feb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFQ5bFBnUDBncGxMeEMrbDNVc1lCTjBhNWdndGsxcTFQOUl0WXd4VmlTSkRI?=
 =?utf-8?B?VGh4eE4yRVNwMEdxaDZvNVc5VkpCVHNDcFpQV1VYdTBWNXFHRkFqTzlxaWd6?=
 =?utf-8?B?S0tHV0dLbFc1Rnh0T2pKQVN2R1lCSG9IdlBJYW1kRWNhNzJLZUx1dkRtYVlR?=
 =?utf-8?B?d2I5MEpLbVJVSVhVczhsU1RLNE1qdWNJWW04cUdwQzNRVWtFTzZpam14WTBD?=
 =?utf-8?B?eVJHWGpTNldWcFA1ZzBJMUZVemJkSWRrSFZaY25TbUtiRTBHWFZ1UmZjeWov?=
 =?utf-8?B?NjVPdVduUnp6VVJKd0ovWm1vVjB5VXk5NEtHRUEya015TlVrZngxRWJ3YXBl?=
 =?utf-8?B?UGtmeDRVV0ZndFhrdzBNV09RS0ROL0E5cEF5bXZWcmZoOFBjNGNqbCtFZTA3?=
 =?utf-8?B?cWowRXZPaWR5ZTh2alZpTzcwb2NqbDNJdHUwSi82RFRFOW44THk1aUlORzRu?=
 =?utf-8?B?MDFIc0ZUbk9OMkZDY0dVanQzRTAxSTVDT3dQRFZ5NUY2UFM0TWxFTVJsbFUz?=
 =?utf-8?B?SndnMVk1YmxoZXhmNXRoMWxwSlJXWHNJVER6SnVUMDl5dUhFRU5uOWtmT2Rw?=
 =?utf-8?B?SkM1MG82alA2bndTcW9OaW03eWxWVUN4T1JyWVl6MERhSjVlUHJhcFV1Zyti?=
 =?utf-8?B?ZE41b1RIa2JPVWpyaEtDUU1KdEtrcWJ5YUFtQVNmUkprdXdJNzNLemNHUGNl?=
 =?utf-8?B?VzB6K21rZFZiN0FkZnl1Zm82bG1uRGR0L1RrUmp4d0FnOHB0b0xiczRpbFBx?=
 =?utf-8?B?SjU4VUl5WEV1M1dmV1dFMXJ1aElpVWZnQXlzc2k2TXN3VExFWUY0YzNtWnlu?=
 =?utf-8?B?ZWoyYjU5YmFFVy93NUpwT29hZGpkVGNZaFpWMHJHWENUZXpzSEwxMWpxaVQ4?=
 =?utf-8?B?VTdqSGtERktZWFVvT3JjbXVDYkdLTEtZMjloSnlveVJCZ3pvSTQ3MGJzSDhl?=
 =?utf-8?B?ZzloZTdxL2pvZ0NUZ2RzRTFCK0tkWlF4WENmcThYWUI5N3BPYk1HRWd0eXRG?=
 =?utf-8?B?THA2d1l2UlVRdURnQ1dCbU9Mdjc2dmxsZDkwWXZLcHJvWUQ1clpuNyt3SEtv?=
 =?utf-8?B?VDVCSVc1ZTVzaFlaTjR3NDRXa3lCYnFOT0RIMkM2dDRBSU9NV1hVSVgxR21G?=
 =?utf-8?B?dklzS3ZCVUlPUzBBTHdBQ3lPa0tReHM3S2UvZFY5REVkK1FYb21NMFhsWGsv?=
 =?utf-8?B?SG9CUjl5dEdOYm9DQVdlOVhHZHl4TkpxSzdMYUhGRFBlV1owQzNPeUlzTmhM?=
 =?utf-8?B?V1ZyWnhrZWpyU2tFK1NURjFiT3VXVE8vcE1OVXhSSDM5RDRuRUVoNlV4N3Js?=
 =?utf-8?B?akR4WTFIMXNRWnhpNjBEZm5vWjA0Q1JuZWJubWJxRktjQ1ZsNk5HL04vNWpk?=
 =?utf-8?B?VmZIbFhSRSsxWkFGeWtaaWVrQmRGUndiLys4S0laTHUxZ1F4RGx6c0x2ZGp2?=
 =?utf-8?B?MERtOElLYlhJejBYVXRGSHl6VVc3ZUxubU8wNHpGUkV2R2NKZFBvK01pMWdm?=
 =?utf-8?B?MzFKd0g0MU8rSjNOOFc3eDFOMGZ4TEU1QXVkN1hQRk03YVprSWo0RkJnWFFv?=
 =?utf-8?B?R3c3blJuakR4VE0zTC9PVVBBL3ZaT29RZ2JFMkR4cGRDS1pQQWxKY1dyZFpY?=
 =?utf-8?B?Z2d3NTBjNnlhaVZITlhsM3lCVkNxdDVweE5aYndrVWNOS3VXN0FCTnJHK1Mv?=
 =?utf-8?B?OHVsWlp4Z2pFeHdaempnUzMxL2NBWFgzWTNwQ0VvVUJ3ZjUzTmV1d0gyQWVs?=
 =?utf-8?B?VG5XL1M0d2tsdCtOb0xqM0hXcGZYVnl5ZnR6TU5sVlZENVV0Y3ArN3NxYXJi?=
 =?utf-8?Q?OmKtSLKkfzUh/f/AbSGXyN8hycIw7GczPqkPI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDYwSkYzNWpQd09JRTExOTRNdXlXbVpILy9zK0p4VDlVN0d4L2YwTVZZNU54?=
 =?utf-8?B?aU1jSEFKSDJudENNSGx2SEpjOG1aZHZ5UTFFbmdndkorS0tQRURadlFOcnpk?=
 =?utf-8?B?M2VOeDNNKzQ0K3V5MnYwZ0F3T0kxWXVBTTVQZHNCTDIrVGpOMndjaWl3cEZG?=
 =?utf-8?B?UHJnZzd3WTltYUJVeWluYkRvbkx1Z01ZUkNiK3RBRlhZR1U3bHgxSDBsSHV0?=
 =?utf-8?B?SmxtRHFYRXFqeitDblA2TXV2Q3RsL2JUU2RSRDA1aGlBUGs4d2l6NVozdEsy?=
 =?utf-8?B?S210RWErZUNnS0I1S2xyMldPZUV6OVZsRzMrcEUvcDN5ZWNoT0hSMWpBQ3Ux?=
 =?utf-8?B?T3hrbVg3enVGK0sxL1lPTlJ2MWZmSVNybzhqWmE4aXFTZGl5bUh0bWs2NVlq?=
 =?utf-8?B?NDYva3UrZFZiNXNaL1NmbG9jYU82WXJRa3pWcnJ3TWdjZW5SeEdtaDNZN3NR?=
 =?utf-8?B?bzFUK0Y4ekJsZnJDUmhyRW53bVc4WnRZOFhBQ0dmVlRuOHBqa1U0MFpXbW5o?=
 =?utf-8?B?L1prbkdtTzJXeEtvK1hDME8vOFRtT3lTZmtZaXRFajVwTnA1YTdtNVJoNGdT?=
 =?utf-8?B?TEtHTnk4cU9qOXFybkZySlV0VFJLcDg3dEJOUlpRQ0lrNHdYZGlReHV6R0Nt?=
 =?utf-8?B?emJYcVFMNlF1NFdsOFN6cTJyTWhPUkhvVy93bUFad1FrcUNjaXlTR3JoV3dM?=
 =?utf-8?B?MENMcnF3c2RoMEhyeHQvaTlmV21lWDdjRWJEZFZYZWtrQ1hyMHlCbWJINUxG?=
 =?utf-8?B?VmFCbUFKeVpXL1ZKZ2trQlhpZVZsajluVURzZmM4V1NmVE1HYVY4TVhDMHlT?=
 =?utf-8?B?V0MyMFA4VVd1aVRKdUpQeW1oZENvRmhPRjZEYU5lK3VFNEdIT05BS0dDSDVv?=
 =?utf-8?B?NUhxaFB5RUxBNS9lTFpCMWFSMWFxeEFUbHQzV0pIL3RGU1RTODBJRmlsc3RO?=
 =?utf-8?B?NEx6UjVkemErRVZ5a2Vic3ZINnQ1aTQ4OHFGZ3VLVFdDRmpxUXNuZGEzUjVZ?=
 =?utf-8?B?WlJtazJ4ZGlWMEVpM28yMlhJNWtjUmpUU2prd1E1NGVJRG5Nd3VJbWRZcUhU?=
 =?utf-8?B?SjROTFdIZ1E3ODRWUE1YRkpCTkpMSTNxWmJRUEJOako2UmtrKzZFK0JkaDlP?=
 =?utf-8?B?eXFsY0lGMmJpR3dZLzRvSnY4NzhDd2QvRmNKOGl5UUJIU3lGd0dhaHhONEtG?=
 =?utf-8?B?eFJyVlh2a2Y1Y2RHWSthWnlWWFllaEJzeStzQUtDNy8yTU9tQzA1b04wTHpR?=
 =?utf-8?B?Y0xDeGU1dDUra0RjSVVpdnZYME5HU01EUHIyL01aNmFJMWp2VS9hSkVEME5V?=
 =?utf-8?B?ZWN1djZBNGgxR0M0SWhHaVBBOUZJRGgzSi9ZeW5FakRXTERmbjZQeER1NHZE?=
 =?utf-8?B?NUUvSk05N0ZzWmtpYnNLMXhIT0RPT2ZkMUx1N1R4Nzg3cjJRdlhXbGdRcDI1?=
 =?utf-8?B?NlZTRXZOYVpCQnNFZ2RQSUxxZE4wWnNkYzdGOWFjTzY0Q2dRd3hsNmRvQUxs?=
 =?utf-8?B?STlsRVRvQ3d4VDdsZnJDMzVOQnJqL3JsVGZ1SENsNHliZzhTOFNkVE5EUERa?=
 =?utf-8?B?c2dKd3lsWkFmWjMyUHRUMTJMMzJvTkhTa3FlY0RSYWRrcGllT0J1Y3pZNjdY?=
 =?utf-8?B?MFVYYzNPTHYzRGNzeDBEbDhIOHU3L010NitvMlB0aHFKSnd2ZFYycTZRYk9H?=
 =?utf-8?B?TEJnQUQ1WUJmZ0pmU2krK3hBZGU4T2M4aEZLTldGdUh0V3ZUd0RSTTl6Q3B1?=
 =?utf-8?B?ajlzQ0RVTElzbjFidjBLODlrL0pqRVo0Nk02cmF0NFJnVEtEY1M1N2t0ZEpW?=
 =?utf-8?B?VGRwNHd3MFpPMExCK0xUM0dlNXFnN2FWdmh6Z2lSY2JtS2I3c2s4ZGRVY2R1?=
 =?utf-8?B?RmdTSkVqNENHOWlFMG1tZkZ1V3U1WGo5c0FQeGFPckxYeUJHSTEwZkF4cE1X?=
 =?utf-8?B?d2txSTRSM0cvcXNWUW1mZ1FadXJRNlhaWTBOV2ZISE1CaVl3RE9MOWlmSW5V?=
 =?utf-8?B?alR2K0dWd1dmdG1EVFVDN3JWOXBGMVpiOHBFQ0J1ejN2UDhFK3l3b2tVUWZ6?=
 =?utf-8?B?bGtKM0g1OEE4YnB4K2VFaW10QmRiMXBJQUZUeGthVHJ5dkQ0Sk9Qc0FhTSs1?=
 =?utf-8?B?ZkZSOWM0U0JYT3IyaUFCL2t1bDVWMDJ2cXQ0VnFKNHk2bmtsZmVqd2paY2Ew?=
 =?utf-8?Q?PApE7oLCPmoDbf9mmw1nyGTUpMDH8bvLC8kt2YWYV7WC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a3162-91d0-446f-9882-08dd945c6feb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:31:29.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeVbOPfLzIWvNbJ+6yxCfBDQ/HBgsS8ifiyfHHAPDYDUEH7om/QxEdweGNt/z3/159wmybcVqRiUEtjJiJjpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 May 2025 09:31:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18920

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings a bit of build-time optimization for initramfs. No changes needed
to recipes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index cffc4f16..47c02ec3 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: d46adc844a74ba55c4b9521b7d7da9b5a47b489e
+    commit: 938dab363006529f0b5296dfbc09ef306fc8c3d7
     layers:
       meta:
 
-- 
2.43.0

