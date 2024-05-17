Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB58C04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:44:15 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.70])
 by mx.groups.io with SMTP id smtpd.web10.773.1715964247437947560
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 09:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SpKKEjCr;
 spf=pass (domain: siemens.com, ip: 40.107.247.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyBMXibrDwv21SmC9LYzXJ8gLhTc7Xg2r/OvZ1rt2CIY42AaOlxKRjYSNUWi2BqzC/v0zQmf1TeiF2g/P2Amzi7WVFIuHIIWcpxiV1qETWjrl02ALQL4lPRB7lJd7uMgaRrGZ+Q/fBmeYkubIOMuGnEBJ8mH1CGdqhdbOifZAGwScIXOyBWJXU36M7aS7cU71X8L73qAscKgPAO1ebygAByxIVpjWWarkgLjqX9lSsV6Uz7icregCCF/r66kJ+dw0Qye5mc2nKAD6bVCqimbr4PcjmR3pvlXAMMdDH1FW+ptM8YXwhuY43QVoZThmaGJJgWQiHCcYRsGZDsg7oCoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5k+CkHqv+3QcVjUZxe436yoWnGngaP92b8c1P2XKYY=;
 b=EXSDjXLqOq0kjWheYZc0MZ1EIN1Bm/Za/Z4Kn2Zp4qS9xRm3KiTX1u5xmMWnL/TwrYUvnezomMY3a7eru+DggdQDZugvGSZEvpKTlq0NOJb231+2AKzToeFGUGTT8lNfnX/3P6Se46OrrL0VikIZrIg0r9I4Ml+Heq4PfDmH41nGJGNSBuExMR3WJcj/Nkg1/O0eYW8kNTelqgKCBBsxHfUPLpMGEY7dgLio5iPmNuQdNADD4i2yh7I3DCAyo6ikfJx0tsHVNPUI9MlhHydS4OsQspPhzKEv/o1+k7/zn7cxAMc4W/S0Fw3YGvrkXOom4P4naDY+7LmHtPUR7yqvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5k+CkHqv+3QcVjUZxe436yoWnGngaP92b8c1P2XKYY=;
 b=SpKKEjCrWvM6Vzlqf2dnNveovAdCRB3f4tpUXBLV43/PSZPAW0u4EBh+8UFx92ccI2509lVuhAeOv7A//+aPe2Q1M+oLdzw7aV9Bh6V8xUrPKP3d6YS+sRSppbCo9WgAiQAT+FOcV4TDk0FX6DDjlMWIpbTiS0HmqaIdvi9wa42vFIpFqCIKQ5tRfjNqSC/VRnAIGrL3/FPwfF2GbW1zN8K7kPwm9XBfTJBYnOKEnKP3sg0bp48xTCXQBGrFNJC8eAEDRLUt6BIArH55UHWwZuVq9gQm0sRv0ZxPa9pyIkEdIT5EkOQUeUs78YmDEQ7a3WuiQGSB/7YoYiOJaOtZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 16:43:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:43:56 +0000
Message-ID: <cf3e4dbb-304b-48f9-af5b-ac88dd09d4f9@siemens.com>
Date: Fri, 17 May 2024 18:43:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] deploy-ovmf: Avoid blank in network varflag
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9d0cd0-d24e-45b6-a8a7-08dc76908b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTRJeXQyaHMvLzk5NzNBZDhveklwU0NYK3N6VHVHNEp0eng0TzhFSzgyZ3Ro?=
 =?utf-8?B?STlybzF2OENzVlhDZlllNFd4czNsdElIeEFPbUE5VlBVYVAxNlJSNFd4T0c4?=
 =?utf-8?B?VmIzNHUwYU5adXlsMy82RTRUTjg3LzdmWjVFR0RFdldnbzJETnVWM2UwQlFC?=
 =?utf-8?B?Z3lWZVVmelE3WitDdXhyNjBlZm1KbEVsYnpXVWxKTWoyaC9TNm5ZZlVOV3dp?=
 =?utf-8?B?M2lWdldMUzQvTEFoTkJ1cEVPRlBVam1WVEMzdTdIdjY5anJlSlRBUTFCWmts?=
 =?utf-8?B?MXgwZGkyL3B3MTFxRzUzeTBHVHRrT1hpQmFVS1dKQ0NpYzlJd0dqV214UVEw?=
 =?utf-8?B?RWVqWGF1bkdaaS9VM2NNTndJNmNJWlJmTnNFRmFKTmVYdUEySHZ3MzdyOC82?=
 =?utf-8?B?ai93b0VoU1c2R1ZYWlRhenJtaElXUkxDb3pzSGhsQVFWOGkwaHlSdDZvK3N3?=
 =?utf-8?B?Y2ZqVlFkbklhWUh2YzlGTUEyNmJ2bzJoenR4OEZQT2prM2NZOVFQK1A3Uk1W?=
 =?utf-8?B?TVdSTDhyUEFVODBpQWU0ckNkZElYYVVUaEUvNFZiUktGVVkxWXlKSUYrZDIz?=
 =?utf-8?B?YTlJL0JhOXFGUWtFc1QrbjJ3QkdYcWpzd0dZVGRzNFp2dzFCSUVucDJ4RUpF?=
 =?utf-8?B?VzdjTDZqVE00Q2JKMCs1L05mbDFTaVFXRDhPcVpVc2JGS3lYN1RhWGdYMGcz?=
 =?utf-8?B?ZmFlRWx0UzRScVdCU1ZEd0dKZGszTFJxQ3FFWjdwdXNENU1KZ0hKbEpkTUkv?=
 =?utf-8?B?a1FvMzY3bVMvTXVub3Zzb1FGZXd4V2JVUjZPL2E1akxmeUprendzSEFSVjlJ?=
 =?utf-8?B?QVQwOXk0TUhOTHo5Z3p4MDBMc1RVM2pkM3poQzMwNjZ5aHlrN3BzSTZiTWtu?=
 =?utf-8?B?MW1HeS9kdHovNThCaU5wYkNQaSsxSEQvazFoSFhGVU85MzIxSHlWNW54dlhk?=
 =?utf-8?B?d1htQkVxK0hjVDZqWkd2QkhxV0Foam5IRUE1UlVKWGsvTnUrZkc2MWwvTVZV?=
 =?utf-8?B?N3U0RkYxM1hXZjR3bEIxcTVNdmIxQXlha3Q4ZnBSYWV6ODh6YkZJS2RHczI5?=
 =?utf-8?B?RnVrMWcrTHJaUUxVRjkrT08xbzc3czZ0VHEvKy9tUFFyMytBczMweHNZb21w?=
 =?utf-8?B?ZWdlMHdRd3NKdU45bHVNd0J3eGtVbGxFUzRGQWFETGhsbkd5cmRzMlhQeUVU?=
 =?utf-8?B?bHRhb0ZxeHhPdjVQdjY0TVI3aEk4a1NSa2dBOXAyL3Y3aG1lMVVqaXJpU3Vo?=
 =?utf-8?B?eStRemMrYm9SYTZTczFLNk95MmpwSjdoSlNYL3h0RFpvbjVqbzVybjVLa0NX?=
 =?utf-8?B?M1o1d3crTVZudFBxU2JZVnVPL1NIaFp6OHlqQkN2N3I4L3NpSUdhTjhhMDdG?=
 =?utf-8?B?MUorQTQxRG9BNWw1R3E0dXJxQWRzb3lXQ3piY01WVXBuZHljV2N0UXlIQVBE?=
 =?utf-8?B?MGZqRjlOd291NnhMb09KelpvVWhHOUxlOXZEVEVUYzJya2dFc1JIeWJxUitT?=
 =?utf-8?B?Y1VESUdjdVlzOUVkdTE4VGttcUJTZFozT29ORFFZdTdycDJTcjFiMVREcUVR?=
 =?utf-8?B?cWI5eWxCUnp4T0ZYVnpNcGM4UFBKQ3VxRjNOTnRMMFU4eWh5N3RacE0yTXJZ?=
 =?utf-8?B?cE9uTERHVFdQWUhvdVF3b3VXSjdpeHJXMS9XUnNIUUo3V3NaaU0yN0ltTVlQ?=
 =?utf-8?B?R01aUk41S095TS9QMDJFYytOUXdaWjlRQk5xTXJWbUkzQUVZaHpTdlhBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFBrd3FsZVN4bVhpRmxlUGE1cHVralRaaytJYVRiT3liOHBwOEtYNms2eXl2?=
 =?utf-8?B?NzZwUU9DNUdSZ3RiRXU5WlA5MjExRXR2elg2R1FyeGRyYkUvdUw5S3dGTW9m?=
 =?utf-8?B?SU1rbG8xRDZKVlA2NnVzZHBWQmFtcnBUL2tyUFlRWXFHL2NiWk9zY0c0alpk?=
 =?utf-8?B?cldmemk4NHRLaFhtVTdteG9aa29Gck15TFBEek5TYjBaS3ladFJkZG5Ub3lT?=
 =?utf-8?B?c0JiZG9aVVBVSU9maFJqTDk0Z2pzVFlIdUNDc3VUc3JuZUM4c1Z5disrdlVh?=
 =?utf-8?B?dVJBRHZtWURjMjNzTEsvT3ZaZU1BUDBQWVBOMFQzVytCelU3d0lwbWVmYjZa?=
 =?utf-8?B?YjVyRm5KczZRNmlmaGk2TEg2TzNqajNxcUZCckplR01nakxOdzJFUHlsL3Nx?=
 =?utf-8?B?TUpMbUQxajVHZlpScDVzcjBHYWlLK2hVOXRFZjNUbmVRdkhRdzFVRlRwVVNL?=
 =?utf-8?B?M1ZYUEhJY2VjREZzeUJUdnN3eE1Lc1A1MmR6dmZMNHJlTDV6S0R0NXpoOHpw?=
 =?utf-8?B?QlRCTFk2SW96Vmo3czNFaHZwS0U2MENZMWZyYlVEM1pKQ0ovNDNhc3UyL2Ry?=
 =?utf-8?B?TUs4bGFYaG1lazMvbU1Xa2xsMUtaVDJORkk4WHB1U2t5WHZtY0M5UjlTMkVa?=
 =?utf-8?B?YXJ0SG9FNTBuTDRuWUtFOVQvTTlrbk8xWTdVdzJxVXZXS1BxTmoycTNza2hz?=
 =?utf-8?B?OUdveWxDNHJmTE9PZ0ZnK3NIUll2TWUya1hTY2k4WlFhNDRxRk5Qb21naGI3?=
 =?utf-8?B?M0JhSHdMaDB3VmgzUGsrdFdDYWxnUjBJTzhlemVsRDdkVm5CZUpHcW5hNm5x?=
 =?utf-8?B?TWcxZ1lmNHZFcDFENzNtS0hPcnZOUHVZWkVqT05BUEc3ZkoweXNZMXJmd0w0?=
 =?utf-8?B?L1VaTlk3Zk1qV1FpZ0tkUHJhN2pzN1ZWdVRvVTNadU0rc3ZxcEpMbkdxVlJH?=
 =?utf-8?B?ampKSHZYdGN3NTZEZVdTR2NEK0YwQnl6U0RxbkNHOFdMY3V5ZXdvR2hKSFZw?=
 =?utf-8?B?ditNVTViOXAvRTJDMWlvUU16eXk5T2E1a21DUXpoZHk0TFVneHNXbTZtTDMv?=
 =?utf-8?B?RnRzek43Q1g2dVYvd3J3QjNRSmRyMHZSWTRUMk5IYXpjcjRFcnpna0cvZUVz?=
 =?utf-8?B?QXZNVTgzME5JS0VYd2lUQi82SnQ2amQ2NkEyVU90MXc0VHJoa2ZMczAvQkJj?=
 =?utf-8?B?RWkwOFkzUlVEeHFnS3Z2VjdWZmRZUTNlUWRWVmZzL0Z6SlI4R0hudndjMzhh?=
 =?utf-8?B?dU0zUXc3SHlOczZpVy81M0dVVXp6bCtocTBUSS9NemtWTXlwZER2MG16M0hO?=
 =?utf-8?B?TW1LWUhjUGVLenRncmxTMHg3L1ZWeG1VV0VCenZpcGNMQ1pJMFBUcFlMWUtn?=
 =?utf-8?B?YnFIeFV4MWtiajhQLzR6aTRRZ2pIaEZ3c2JmMVhDdzRhZVdMWWpYZXUrL1c5?=
 =?utf-8?B?dHpqdHYveW9oTy9hQWNUZmVqMCtkSlowWE1WSEVTODErV05WWUJOZExOUFBn?=
 =?utf-8?B?c29Sa3VWUUJ4TVRqYk8xVHZZazlSK01mR3JxTGdGQ2FIazh5R1VHUkVSR2ox?=
 =?utf-8?B?Zlc2Tkhpd05qOU5ReXFsR2xpMWV4WW9mbEcvV3pKT05uUk1kY1JBNHpsSEFM?=
 =?utf-8?B?NUpHSHNhekpYMjRwQTNkOWZJOEE5aThSa0QreDQ1YzFwS2RPRmZmczk3dE1p?=
 =?utf-8?B?cTcyNXFRbEJDcWhSR3BwcVlrV3QzVEdVeXpObTA1akR5SUlPU2NKbVRxQ1pj?=
 =?utf-8?B?KzZvSGZTYkhIMCtkL24wUHF6N3VNVHRCRjdTWTRsamdBY0RxWnN3dlFDZDg5?=
 =?utf-8?B?NjlrdW9BZ0Z5T1BvbFhKUE9NR05LckkyVXR4U2ZrSWZoOGlzcWRDOSt1dTlh?=
 =?utf-8?B?S2Mva05oSjkyd2ZnWllMbXR3MERYZzdEU0JiSlZmMENuMTI3NTBXR0lRWXVE?=
 =?utf-8?B?T0xER0NQbW9zQkpvbmxXNmEvODZuRnVYZjZnZ3VjYmJSSnhzeHZ5T1gzVUtm?=
 =?utf-8?B?SVBrWUNqalZObzJISUdiRStBRHVvcVVuejN3S3BKUFl1TldHVjkrWjlZMm9s?=
 =?utf-8?B?ZHJDbnFKZ2FRcjJ0ck9oRUlFZXRLT1RiQ1pZbU5SRkc3NE9HdVZGVU9aSlY2?=
 =?utf-8?B?bmpxQmlZM3g3ZFpkYWN3L0Ywbzl6MUZ5UzA2NGRZb1lUSEoyRkMvRnNRK3l0?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d0cd0-d24e-45b6-a8a7-08dc76908b3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:43:56.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBJWWgyXzIKS2DjLWqnRYJ0Ly7tsBscU/CrEpByBTF6hcLi28pnFVAw/8EDnZTY0gcc7mGqwZME9JO+M9B0UQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3474
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 16:44:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15916

From: Jan Kiszka <jan.kiszka@siemens.com>

This will be disliked by upcoming bitbake/isar versions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/deploy-ovmf.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
index 3401bfbc..0a3d11ed 100644
--- a/recipes-core/images/deploy-ovmf.inc
+++ b/recipes-core/images/deploy-ovmf.inc
@@ -13,7 +13,7 @@
 
 INSTALL_deploy_ovmf_binaries += "ovmf"
 
-do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
+do_deploy_ovmf_binaries[network] = "${TASK_USE_SUDO}"
 do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
 do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
 do_deploy_ovmf_binaries() {
-- 
2.35.3

