Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADAD5E398
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 14:50:26 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24477.1765896625013632636
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 06:50:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UGM/SXVf;
 spf=pass (domain: siemens.com, ip: 40.107.130.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0FYgYTwYtpnmKvhc22OEkzoCiq7pdlPrVE6lbKP/TeluYg2fKg9pldbcb4yRcELiDkVoB1uptfkBhAbhmg7v8c16Br8ajFmuYEbUSWTX6wYpN/0vG75zEyZU/Y0OIg1FWHxxtdZ3Wk1rqsxTJmAwzIi1uhGl3Wh8MK9LEvkVUHMow0k8qNSiyzR+s1qJm1CIMGM/RwrKPgL/GT9NHtZOo6fJjCKgjCz4PaM9dOUjB/S20RurKbGJ7sgDkdIOXjLQEQQKwwtnhYCsgfXouWAIqm6ghZHHnJ2Hf0lR2Ew8ldnhy2Y8kg4/q0UL4gHFp3eLWfp2XC/3SUjO/rPYxRVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri4c9XfsJg+a+Y3h9SiKmMGDoHOdqDg7evEKVPIfSUA=;
 b=XHzig0A7JPqhSBV/P+LWSqgnwE146uOeWSZRg8XrX9Ovckq6658gqTAp07HeUluljb6asIf5EB6EwLlPiUvC2n9WfOqFZQsWjuTkh1uF7ND2XioizLK9WVjdV+Kred96xL0JFIC0sVCvLMszo7BtCIeX6FCRZiLeB3+gK56kFopgysBW8rPePAtUnuRIxu7H+Zgqyd4J6KAWszMnvdbSn0fBRo85pnejeyaTgcOjZPz3eFL53ddmDX1UzbGNQk/VdBXnUZ6OaZYq7Aidd1sTrK6fQM4+McBOevgoeBYmD6F0FFmBGkk2Tzo8Lqc0W7pIOOcvboL+SohwAHpCoODbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri4c9XfsJg+a+Y3h9SiKmMGDoHOdqDg7evEKVPIfSUA=;
 b=UGM/SXVfgYlZf4Vk700UqjmJCNIKLxt/poTdbb00IEFZHsO7AEXBxqgWmiry8ZaVMIhHt/dFlMoR90XQXccob2Eo1iGza9uS2Aq9+EG+fGHyvRBDVvjCLT4oMj+cfNh3OHplPjillFj6+hmj/FxBqGcynYftNKumFjk7NMV1Eq5jC3ubSNnUB4CKyG2ltWfjgZGXK3Pxeweisf5WcQEOICBh30ewX1y6/5ArkwBiaTJEyRSJB8lQVC6++WCW8jpufXPhKmvJmvnGRETbWj0yfd0I8lANA3WarU1j1LUv9iZAjcO3+xjcKcP+99lyegat+YB+MAnKDkaOc3+Vi9Njgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:50:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:50:21 +0000
Message-ID: <14ade212-6f16-453c-9bb2-5acf95443217@siemens.com>
Date: Tue, 16 Dec 2025 15:50:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcbf7d5-81ae-4d22-f530-08de3cb26f85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QUJnQlpsSmVLMXcyaGtLcG9hc1FRMFp1Y3BEaDdvU1VUWVYzbUhGT2xVMVpp?=
 =?utf-8?B?MnVqUmxoY2xmazNtcVdDNllzaUZKZWtmSVpxMEtTazY2TEErUW5iVjdIRmhk?=
 =?utf-8?B?eTVXV1NpcjcxZDEwaWRDS3BqY0ViSXRVWFdJNWlYcys0UjNaT3dWQ1UwZ1N2?=
 =?utf-8?B?b09KNUVSdzFrbURaU0FBNVMvQ1c1WTRRdnNMKzJxNEJEQkYvL1NhWStKbWZJ?=
 =?utf-8?B?UDZmVTJaVitYZmRWeWJpTVRLN3Vtd3NEc1AwMHFlemR2Z2l4UDExNHRMZmt2?=
 =?utf-8?B?QjFlNG5FNU40MnVQUllOcjROd3VIVzV3b0VUUWJMZkxMdElJKzZuTVBDcTk3?=
 =?utf-8?B?dGlZVlNPemZSYWVUTVBiQjdUbDBtWnh1dmhlWU1DQXNPVXVDSVZWQUFEQnJO?=
 =?utf-8?B?OFdFNDZnYS9mM3ZKVjNrVXJJSFlnOXl1RUFIa0t5RVhpbW9uRUIxdHJ5OHBq?=
 =?utf-8?B?WFlMWXlRWExIRmZCdmcrMTZUMG9meG5LREg5NlZYS0xXRTlRWTF2TFJIL0Vx?=
 =?utf-8?B?bWlxRlRFSEpsM20za2xNLzJUSm1iY3BGNmNaNGNJaWRTZzNpYm1jcXQ2YVFv?=
 =?utf-8?B?Y3B0T0syWDZKWW9PZ21qckZyaExQNGJoQUpmUEkvcUdZSm1ZSHMxcVVqMll1?=
 =?utf-8?B?WTk1cXU0VjY3SjBpazNSdzdLa2ptb3hyVlAyRTR0NUM0MlcvV3RtR3loWVZO?=
 =?utf-8?B?dzZEMkpTRkJEOGljamNTa2NOa0xVcU84QXV6SE5sQkZPSkFJYjlDVEZZbkhD?=
 =?utf-8?B?Ull4LzF2SjdtWGxDNlhGa3VzOHNZdE1IYkt4ZW5ZSzdMRWpyRWc4dWN5aDFG?=
 =?utf-8?B?TmE0cUZ0WjhvK0dtcThaWlJGeWRYbkNkV1J2N3NLUkhacUVDeUhERG5TaXFR?=
 =?utf-8?B?VXBROGl6aUNKM0JTSmFYM2ROUFhTMlVyVUVXVE0zeUM4U0JlM3VOV1ZNRGFS?=
 =?utf-8?B?RzQ3bmNLbHA0MkhTVytSTGJlN2hpZG5QdU4wMGN0Ym9hSGFZN3pzWVJZN2Ny?=
 =?utf-8?B?RzhFWXZub24xQk5QWHA4eWVSU1RieHNTYUxPakV5RXJnNnhGdWVOQmxHNXhw?=
 =?utf-8?B?ZjBieE1uZ0pyeFcvWHdmSjRCUkJJQWM3dWpoUnkwQzk5RkVBOXcrSTQ2WGFu?=
 =?utf-8?B?NU9mb3EyY2QvMW9oVEpVU0RGT2c2NTlhT3hNTjVRMEduTTVmZmxSbGxBT3JL?=
 =?utf-8?B?M1JsMmJ3azZHVldTUGJ3OExsc0pCTGRtOGJONnpPaEtDWVQ1ZEt2dWJuOGJa?=
 =?utf-8?B?QlQzS3JHWjNkNTVTbkdtekJJVGlseFVjenJNNTZpczlsaWFNbUd5cVZ4SUEz?=
 =?utf-8?B?bUVycTFRNldkdHZhQWVVSUZSNm9FeVcvbEpIa1I4VmR5eU5ycWFoajBvVVN3?=
 =?utf-8?B?d3ZkL3VLMlc2aDdFbDdQVUMyblpNaDN3VWZTRFBmNDMzWExTcnJEWmZVSm5s?=
 =?utf-8?B?RHZVbTN6NFFUNkFXaVJVMzY0NUxpS2I2T3N5QTN2a1Z2d0hjdk5kbUpWcFR3?=
 =?utf-8?B?RmczbWZDc09TWFNoM2w2dGdLR0RhQXJCOVlWeGEydWphcWxWOFVuZVhTMzV3?=
 =?utf-8?B?OHdsL2Q0ODU0cVdkTHVuaWwvRlRUYy93ZTVRQ2pmNm5CZ3p4WVRXMU5Tb1BV?=
 =?utf-8?B?eUl6NGdYYVdQV2ZjYjBaK3huQmdlQWZSMWNPUklDOFl3SW1Jcys5UUwxYUJO?=
 =?utf-8?B?MW5rWWhWdXNDczY2TWJ0RGVobzN1cEMrb1o5aThqTW9xMC9zRHVUZ1BteUpN?=
 =?utf-8?B?UEdBNzNoSzVGMkQ1Sm1ES1dBMHBFRVEyL3hldy9FSXNXeXEvTDBTSktkaGRn?=
 =?utf-8?B?NC9zVnFyUEROd2wxRnZ2cjlodkk0cmNuaFdPSnBhYUJCbGh5VTIycEpiTmYr?=
 =?utf-8?B?dUFvT0dZaEFSWS9lRlJVVVBnU1dvZzBRL2NIZmdsVGxaTEN6NjhvRFJkd3Rh?=
 =?utf-8?Q?JgfoWk99buwdFuIud/HKdgghOXgk5tx3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVozazUzMzRid3plV1MwZmJSenRjU3JVeTVoam5BTGZ0UFV6U3ltZElBT2FS?=
 =?utf-8?B?N2MwcC9JeGdDSXJ4TUJkL2cyK3lRZWtibzJ4cHVjSWlXY3VlbFFTTXcxbGFX?=
 =?utf-8?B?TFRBS1hUM2dzc2N3Q0dVMHlRSEJ1bW5JclRaOXVJT015S2orTUNmblBpZy9K?=
 =?utf-8?B?M0pTeUtKNFI3Nmc2RVN6aWtIMmNtYVdmbFQ5V1U3blcxZ05wT0VyS0lvb1A5?=
 =?utf-8?B?VkNEb0tIK0NINk9JWjdsOEdPeHBhY1dqd1IyWE14M0I0NVpUYWt6T0NYUDZZ?=
 =?utf-8?B?RnNRYlBpMW1Pd3RKNnRRdHZmTmpodkdLdy9qcVJpZVFPa0IwUk5yRnUxZTcx?=
 =?utf-8?B?b3NBa2txN0NhNTRjZlVTZ29XdUVUOXZoTUM2K0ZBaVU2clpYb3BYSTNRYkRZ?=
 =?utf-8?B?SW1GZ3lURVdhOW1IRmZUaXBGcVVEa3BSbnFZY0JkVG1UeTREWS9sWVFIRUR2?=
 =?utf-8?B?UEIwaFJ3Y2VQdUtJQ3MyTzN3UDlHb0VKU0Z2T2RRZTB5VUliWEpRWW50bjJp?=
 =?utf-8?B?UjQ4Y2JrNlB6LzBmZUk0U3JPTXZpTHJKdGlWWDZjMTRuY3lJSzUyQnUrRlJi?=
 =?utf-8?B?eXVxekFnb01WMGZoc2ZZbFZ2VWY3SzF5QjNQa3h0SWxSL2NYQmNMVnFaWkxW?=
 =?utf-8?B?Ny85NTNOYkFPdE1FL3ZOaDhUN3lzN3lobndyRlZWcEI1R0Y5U1ZPRVBxMUk2?=
 =?utf-8?B?MmI5cU9ET2lnbE9JcTkrWXpnYSs2bWxxMk83VmNYeDlYZzBHVXJiL1VGcSs1?=
 =?utf-8?B?U21yOHFrRTdxV1QwcG85L0gvR2pvcWd0dGhDdW02ajBwczJwS0JCSVFmYmhp?=
 =?utf-8?B?bXRTNjBzNENZQnliT3JTZGxZLzNwYjdHQ3hnaVRJdENkNEgzazhHNWEwc2h3?=
 =?utf-8?B?WXVkcGJEQ1NGYldHMFpVbnJSL2FMVmZJWFFDMHhhSDI4T1lYbkg0TS9tL1FG?=
 =?utf-8?B?Tm1mS2wrdHFCVHo1NERvWjdPaXFNejZPb2o3MjBIbm5aWllsODVEN0xTTlhO?=
 =?utf-8?B?VERiM1IxSThkbW5oMXptVXU4bDZla3ZWaFNTR2VqTUJFSGVCeXE4VkQ0U3ZO?=
 =?utf-8?B?N2FmN1NxUW5qU051eHl5Z3VIV1c2TXVkQUZIZE1Ld0IyYUFVWHorY3VZV2Uw?=
 =?utf-8?B?R0VwTlphVmNXZy9wUGM1VVpjTUNaUHB2TGFMa1o2WVVKbnZYMk82VkRLREtk?=
 =?utf-8?B?dzFwS0JNMTRKWGJmYld5ZUZMZjljYU43Ky8yY2pMTDlLa0g4Q1ZNdDZzSE1N?=
 =?utf-8?B?TjhPRzIydnBDWk1iemREVXhlRTZBR0dFREJOdFRBazlnZEY2cW40OTZ3YkVq?=
 =?utf-8?B?WGJHZC9MbnF4R09Oeld2Ni9pMks4OHRjK0NNb1JYWFVRNUJMelJTSURJNXNo?=
 =?utf-8?B?OW0xc1RMbDZ6UE5pMVEyd3FhVmpsaUxoYktVamZSKy9QSEdSdU1OOTh2REdO?=
 =?utf-8?B?Y2J5dmF4SXhmOXBoR21QNkRUd3BLSDJLdXRkeXk3RHNHV0QrMTlQKzBRVkN1?=
 =?utf-8?B?VFFpZDExSlFiOVFJc3JNQ2RWeWNwaVVHbGlqTysrbXlSU243aVk5bXRnSHRB?=
 =?utf-8?B?M1Y2amRsK0lQc1V3bHY0eXI0QUZMeHh4aUw2V0l3cCtpbGxnRFlydjRLRnRz?=
 =?utf-8?B?Vzc4SWp6YXo2bWZ1NXdrdER2MTFvODdLOU1yalVLeHZLYWQ3MmVEK28wWFh1?=
 =?utf-8?B?aDJPNWZROXRSdXo0cGdNbDZ6SGpkTzMzeW5IZzRVNzM2MEdTT2ZCSWhhNlFZ?=
 =?utf-8?B?cGNDM1RXMFRKVWpkRDRtcFVUanFKRXN6MVI4YWdLUVhVOUlXMit0aGVvMWVt?=
 =?utf-8?B?c1dtZ3A1aWk0K2NBS2Z1YTYyaHhoOWZrdi9Ib1U1UUIvbjB1RG9ESlF4c1hO?=
 =?utf-8?B?bDgycFR3dDd1NndIU3JXRHBpT0FlVndNMXJTNGloL01VaDd4ekxyZUFsdGQ4?=
 =?utf-8?B?NTRpTXBnSUJHZW1OYkpldFlCV0dFK01pRHRZdEkrS3VyeWVpQTdtY2xBK1Jh?=
 =?utf-8?B?d2dSVGhFWTA3T0pUaVBwVnRjaG5wNmh1UXVsb2VmV1Zhb0VPdWhLbllIOUhx?=
 =?utf-8?B?NFVvaGQ4OUlWUndLL2FYME9nbW5ON3h0T3BhOXpzL04xT3MyR3JEQ0tQeHBz?=
 =?utf-8?B?OWd5clZtSUppMWdIMFZqOGtLVjZhcGFXYXQzRTROeHMva3NnYWZpS1BUeDNZ?=
 =?utf-8?B?Ym4wSnRDMzAzbXNERWpaQk1EanJQQkdCakhwZVVMSWFsTzZkMTd6YSt2NEFL?=
 =?utf-8?B?V0RmSjZsVy8yT3B1QVoxcCsxNHlRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcbf7d5-81ae-4d22-f530-08de3cb26f85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:50:21.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlVWGH1yftAekVICn3zqR3qs694rpvUxfm/3rrQHBqhL5zGj2atSS6os0Je8Vrm7DMmdcGzdNgnVFNpu9XID/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 14:50:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21088

From: Jan Kiszka <jan.kiszka@siemens.com>

No major changes, but we can drop our local patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Missed rc1, should still be part of the release.

 ...custom-built-image-name-to-standard-.patch | 134 ------------------
 kas-cip.yml                                   |   6 +-
 2 files changed, 1 insertion(+), 139 deletions(-)
 delete mode 100644 isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch

diff --git a/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch b/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
deleted file mode 100644
index 58618a5c..00000000
--- a/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
+++ /dev/null
@@ -1,134 +0,0 @@
-From e52be3bd18187191418ea8b2fdd407e1265b462a Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Fri, 12 Dec 2025 17:10:49 +0100
-Subject: [PATCH 1/2] initramfs: Align custom built image name to standard one
-
-As now both standard initramfs as well as custom ones define their
-deployment name via INITRD_DEPLOY_FILE, they also need to use the same
-naming pattern, or things are falling apart, e.g. in downstream layers
-that actually use INITRAMFS_IMAGE_NAME as image name source.
-
-Update the testsuite as well, even in places where the image name is
-self-defined, just to avoid confusion.
-
-Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
-Fixes: 8dbffe075b15 ("RECIPE-API-CHANGELOG: Fix entry for IMAGE_INITRD")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- RECIPE-API-CHANGELOG.md                              | 10 +++++++++-
- meta-isar/recipes-initramfs/images/isar-dracut.bb    |  2 +-
- meta-isar/recipes-initramfs/images/isar-initramfs.bb |  2 +-
- meta/classes-recipe/image.bbclass                    |  2 +-
- meta/classes-recipe/initramfs.bbclass                |  2 +-
- testsuite/citest.py                                  |  6 +++---
- 6 files changed, 16 insertions(+), 8 deletions(-)
-
-diff --git a/RECIPE-API-CHANGELOG.md b/RECIPE-API-CHANGELOG.md
-index 6d7c56b9..caeeb6e3 100644
---- a/RECIPE-API-CHANGELOG.md
-+++ b/RECIPE-API-CHANGELOG.md
-@@ -843,7 +843,7 @@ ROOTFS_FEATURE += "no-generate-initrd"
- 
- INITRD_IMAGE could be set to the full name of an initrd image to be found in
- DEPLOY_DIR_IMAGE. Downstream layers had to assume how Isar names its image
--artifacts (presently adding a ${DISTRO}-${IMAGE}.initrd.img suffix to initrd
-+artifacts (presently adding a ${DISTRO}-${IMAGE}-initrd.img suffix to initrd
- images) and insert the build of their initramfs recipe into the image build
- pipeline.
- 
-@@ -919,3 +919,11 @@ The following includes were considered internal and are no longer available:
- The other original includes still exist and inherit the corresponding new
- class. However, they issue a warning to perform the recommended conversion
- because these transitional includes will eventually be dropped.
-+
-+### Align custom initramfs deployment name to standard initramfs
-+
-+While `INITRAMFS_IMAGE_NAME` ended on `.initrd.img`, standard initramfs where
-+deployed as `-initrd.img`. This caused confusion and is now even breaking at
-+several points as `INITRD_DEPLOY_FILE` is supposed to be used as canonical
-+source of the filename. Therefore, switch `INITRAMFS_IMAGE_NAME` to the
-+`-initrd.img` suffix as well.
-diff --git a/meta-isar/recipes-initramfs/images/isar-dracut.bb b/meta-isar/recipes-initramfs/images/isar-dracut.bb
-index aa55e360..cafffc47 100644
---- a/meta-isar/recipes-initramfs/images/isar-dracut.bb
-+++ b/meta-isar/recipes-initramfs/images/isar-dracut.bb
-@@ -1,6 +1,6 @@
- # Example of a custom initramfs image recipe.  The image will be deployed to
- #
--#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}.initrd.img
-+#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}-initrd.img
- #
- # This software is a part of ISAR.
- 
-diff --git a/meta-isar/recipes-initramfs/images/isar-initramfs.bb b/meta-isar/recipes-initramfs/images/isar-initramfs.bb
-index d2a946f7..3d7aa203 100644
---- a/meta-isar/recipes-initramfs/images/isar-initramfs.bb
-+++ b/meta-isar/recipes-initramfs/images/isar-initramfs.bb
-@@ -1,6 +1,6 @@
- # Example of a custom initramfs image recipe.  The image will be deployed to
- #
--#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}.initrd.img
-+#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}-initrd.img
- #
- # This software is a part of ISAR.
- 
-diff --git a/meta/classes-recipe/image.bbclass b/meta/classes-recipe/image.bbclass
-index 34e40465..e605bc80 100644
---- a/meta/classes-recipe/image.bbclass
-+++ b/meta/classes-recipe/image.bbclass
-@@ -21,7 +21,7 @@ IMAGE_INSTALL += "${KERNEL_IMAGE_PKG}"
- # Name of the image including distro&machine names
- IMAGE_FULLNAME = "${PN}-${DISTRO}-${MACHINE}"
- 
--# Deprecated; this would be set to e.g. "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
-+# Deprecated; this would be set to e.g. "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}-initrd.img"
- INITRD_IMAGE ?= ""
- 
- # IMAGE_INITRD should be used instead (variables consumed by this image class should
-diff --git a/meta/classes-recipe/initramfs.bbclass b/meta/classes-recipe/initramfs.bbclass
-index cd32899d..04a18d0c 100644
---- a/meta/classes-recipe/initramfs.bbclass
-+++ b/meta/classes-recipe/initramfs.bbclass
-@@ -9,7 +9,7 @@ STAMPCLEAN = "${STAMPS_DIR}/${DISTRO}-${DISTRO_ARCH}/${PN}-${MACHINE}/*-*"
- INITRAMFS_INSTALL ?= ""
- INITRAMFS_PREINSTALL ?= ""
- INITRAMFS_ROOTFS ?= "${WORKDIR}/rootfs"
--INITRAMFS_IMAGE_NAME = "${INITRAMFS_FULLNAME}.initrd.img"
-+INITRAMFS_IMAGE_NAME = "${INITRAMFS_FULLNAME}-initrd.img"
- INITRAMFS_GENERATOR_PKG ??= "initramfs-tools"
- INITRD_DEPLOY_FILE = "${INITRAMFS_IMAGE_NAME}"
- 
-diff --git a/testsuite/citest.py b/testsuite/citest.py
-index 27cc9ff6..76a3df69 100755
---- a/testsuite/citest.py
-+++ b/testsuite/citest.py
-@@ -332,7 +332,7 @@ class InitRdBaseTest(CIBaseTest):
-                                           lines='',
-                                           bb_should_fail=False):
-         mc = f'mc:{machine}-{distro.removeprefix("debian-")}'
--        initrd_image = f'{initrd}-{distro}-{machine}.initrd.img'
-+        initrd_image = f'{initrd}-{distro}-{machine}-initrd.img'
-         initrd_path = os.path.join(self.deploy_dir_image(machine), initrd_image)
- 
-         # cleansstate if the initrd image was already built/deployed to verify
-@@ -387,7 +387,7 @@ class InitRdTest(InitRdBaseTest):
-         machine = 'qemuamd64'
- 
-         lines = [
--            f"INITRD_IMAGE = '{initrd}-{distro}-{machine}.initrd.img'",
-+            f"INITRD_IMAGE = '{initrd}-{distro}-{machine}-initrd.img'",
-             f"do_image[depends] += '{initrd}:do_build'"
-         ]
- 
-@@ -413,7 +413,7 @@ class InitRdTest(InitRdBaseTest):
-         # by specifying an invalid recipe name: bitbake should fail.
-         lines = [
-             "IMAGE_INITRD = 'not-a-valid-initrd-recipe'",
--            f"INITRD_IMAGE = '{initrd}-debian-bookworm-qemuamd64.initrd.img'"
-+            f"INITRD_IMAGE = '{initrd}-debian-bookworm-qemuamd64-initrd.img'"
-         ]
-         self.build_image_with_dependent_initrd('isar-image-ci', initrd, lines=lines,
-                                                bb_should_fail=True)
--- 
-2.51.0
-
diff --git a/kas-cip.yml b/kas-cip.yml
index c3bde909..aa9f3b4d 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 0174bd2260f1dec2b40deffa89f8028fca7b1557
+    commit: d364cfa643d1d61d768b5235b9783ca083a564ab
     layers:
       meta:
-    patches:
-      p1:
-        repo: cip-core
-        path: isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.51.0

