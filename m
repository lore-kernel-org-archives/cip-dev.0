Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380C6C10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 16:01:47 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.71])
 by mx.groups.io with SMTP id smtpd.web11.15695.1715097696538960262
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 09:01:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pI8eUhec;
 spf=pass (domain: siemens.com, ip: 40.107.15.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1cYX8qPcGH3OZ+XhSobtnr4u5OmFhSYEFAWhniezyw/2pC2VuYO9yZBcTNDck4NLprNP8rHyTomOTBfA3xZZl9PQgghWCsM7iFKaz61mvbOsBl4ELBNNBfc46IrkxGeOoADoUXahKCjPdXNNFxL9bKpo788pJNyUA/BI6r+OSrEJc+1D6E80rWrTfLg6y/6xV4yaRWwS7xhEcuDHsmz7L8si5QDCs4vhPWFcObUaAMi6onI9Daw35O0LQMEEcSwjHYG1xB0NMivbIjNtN3vC7x8dtfc86NinOmHkJ0X6sAVXsuEUpq9dUXB1vMsI/GIRJ68CUHWg2G9gCHiK6jKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGWxM/QCMyQKiWPk9Zbq3ZchyfAbTAaXJG8ao4V/mc4=;
 b=N0J3Xrv4dOBDn1UX2MoJXjsZmy3O6tFNZNN6ESQi0cLqYapxIS8NyklAt6vGT3qStcwctmCIzLH/iM0rGjFyQPDOp5egVQnBmWPOwf1mz5e/yKlK5slknnj6QY/lOMh+Wtfth5EG2zvXCnNHCGYEmFkeXxQpgcvZ4vAOa8Y0qhv388e7IMwLeizIBa9hWf00lA0IwDVfrWWH0LXRBqHImE8NY6SesTA/zg9We0x/OxBs/MuX+1jzqSbHqeLH5jdZejHbBT4FOK4XQfoHTYPCWm8UvSkcexs8TWiyXK67jzhXEjWq6ewpNCvPi5fkUIRhP/PBwXEEwcZ3F7HidXL4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGWxM/QCMyQKiWPk9Zbq3ZchyfAbTAaXJG8ao4V/mc4=;
 b=pI8eUhecY7liILMwl5iBlY4OkiPNV20BYf8BlYvSre9XGnSImbGv57v02Nzn8NAYkXXYXEvHiT8VIeqnpgr2EZemXj6xHBc0drKMLjVLPDWG8PF9MJYnTQRG41U/j5IRZI1kWBrvLYSotKgGvcMySN2apcaeZfkGpqjlEpRwkIj64+fIBrFEQOLdLB0cwRLzXvVKeldo9VtmxLenN4/5xMxXyIKGrB2h+YpDtG1G/b6IYY7fh/EApiHuXWdqQwlzVIGGgQdhitsp7RnzZXhYwjFKYqif5r8ELwArkZ3Ng0OSb0rtjwCq78nUdDaSh/HjSraQFuk6rh698g/krN83qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:01:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:01:30 +0000
Message-ID: <441ae6a9-cdd9-4365-a559-4ecc351b8dd1@siemens.com>
Date: Tue, 7 May 2024 18:01:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.312-cip109,
 6.1.90-cip20[-rt11]
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: c28e5976-80bc-4b80-d183-08dc6eaef5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Lzd1ZXpwYjJGNTRVU0ZGMzJmMFJIVUd0NElMcmpBMUNUcWdsMWZtelc0ZFcy?=
 =?utf-8?B?dy84WlhjckJOdENTYUM3STBZS0dWMFZGYTI5dFVldE41NEFucG1HWkN2dFpK?=
 =?utf-8?B?QzhqTmtqbmx0Q0FMWGFPdE9KeERLaXVSVEVIYjNZbkx3T21MYWZrNWhhdFk4?=
 =?utf-8?B?N3lMR0xsMkErMTd6RVVwS3hCRUVxU0tmb2dGSm4ySjExSVJzdm9WK1h5MXdw?=
 =?utf-8?B?U3M1WFJOdys4amJmb0x1R3N4Wm92Qzd2YmVralpHelRGMWFhZzFTWjZaT3Nj?=
 =?utf-8?B?Z21OK1Z5cmY4SC9HaGpWOVVUS1VPTWRmVkcwMzc5ZnM5MnhsVE9xVEp1U1BC?=
 =?utf-8?B?dHpCaENJMVdaMHpJREpuUU1DU1pxSjZVbDYrbXhCdHlZOWczdTFWcWRCeGUx?=
 =?utf-8?B?Zm80OVhZRGlEd0lMdEdCK3BLRGE5SkRGZEtucFhTV204bTRTK2ZVaCtaTTZ2?=
 =?utf-8?B?dmovR3NXUS9KY3NpSm9Sbmdhd09WRU1kTE92UXN2MU5UVDd2emN1cXhsS1ZJ?=
 =?utf-8?B?cjY3VWJZc0g5VDJiQkRuSk1CTU1LcnJNUlJSVVBFemxXVzdxU1owbXdINXd6?=
 =?utf-8?B?K2ZZNkhxZFpnSFloaFVFYitrSnhIUDVwRDZ6OGV0RFR6S09oRXVTVUZVVEty?=
 =?utf-8?B?UHl6d09SaVk2eVMxYmNOam5Pa2hxVm9wVVpZK0g1R1lZZm9PMUN3dmE3T0xB?=
 =?utf-8?B?Mys2UXA4eTh0aG9JRWVyaXcxSlcvN0pFSjl4S2FLVHFub3pXOXRKY2xkOTI3?=
 =?utf-8?B?dDVzaldVQ2NQYjN2ZmNUWUhITGxJc1NHN2V5Z3hrTUQzZDA0RU9BYXQ1dVdO?=
 =?utf-8?B?am5DcytENm9xSUdEWGx6VmFXR1pUYVN3VElDMnJFa0ZRM09DSmp3ZWlvcFBT?=
 =?utf-8?B?TUpOb3NkTUtRdWxZR2YrTnJnQ0hMNVFEekZ3YUpTeXMvVGNpeHQ2QTRVc2ps?=
 =?utf-8?B?a01TKzNwL0xNNzVJUDRLZmxsZ2t2WE1rTm5YVksxUCsyaXhVRWNRaEtaeDV0?=
 =?utf-8?B?dTZhV0l5enpwOXg2b0haSVAyS3BaTUlqeUo2SFJZOUJPNE5UWFVFRDNobEtq?=
 =?utf-8?B?dEN3QWxNVDY5NHZXb1BXT2J3YzRsZ0VMRHNoTStWaDNHdm9zUlJtWUFuZktR?=
 =?utf-8?B?MWpGTzVweGJHTG55MGVaTk5XM3FVSE9LS05xa2hJSU0vbzFGa2t4cHVaWk9R?=
 =?utf-8?B?bklhcTNOQUpsN2FGMS9QWkJzZzlTNE5qYnpEVkg3YXJBcVM0bHdDTVRCWnZ2?=
 =?utf-8?B?eVB5WVo5a2pJTGhBVzlMQXRDQk05ajFrbExjeEpLbFVFS2IrNjdiL0ZTRXhS?=
 =?utf-8?B?Q255VXFwd0tnN1lHTkxaR09JeFBicVo3azR5a09JYXdhMHZ2cXNLQWttc2pp?=
 =?utf-8?B?Q0NxdU8wOENRbEI0RHE1a2pRUmc2Q1BZa1FvZVlBVzJPOXBVVFBlVTJpci9W?=
 =?utf-8?B?VmNneURtSEppb2hDQVM2SjNXd09jNm5jZURVckp6ekhrUVJjMSs2dVN2eWsw?=
 =?utf-8?B?K1pIOXF0b1N0VEhzQ3o0c2VFdDh6VmRGVHdoMzZyTGR1NThCbE0wdkx5ckdp?=
 =?utf-8?B?Z1VHMGgxN080OFJoMXBUT3U1bW9RQno0N3hYK28rVDI1ZWowQ3N1RUxWQlVj?=
 =?utf-8?B?NkpTR1RCemF6ejZ4c3MrTnkyYUtTbUEzUG9PcVRRbFpuWEw1eEVPK0s4Ujh1?=
 =?utf-8?B?UC8xd3k3b0xaRC9KNS9Ccmc4aWZ6ZWE2WHovYjBac2pPYS83NVd6UDRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGZHYXQ0UmY3TTV2a0J3OG51SDV4OXVVUmhORUtMdGlLeTFrakhaZnBtdllZ?=
 =?utf-8?B?Q1VieE9qdEF6Nm1kVFhYR2k5UHY3QjBzekRCdWNZc1NMMHBrNlJYQVFpYmF4?=
 =?utf-8?B?UWpOS2FabFpYeEFmcVB5YTRIRzhuamE5Z0lmTkxaSjFIVVI1N0NPNm8zNFJD?=
 =?utf-8?B?MTFBOG9QWnVab1V0T2xXWWNwaS9RVklMSWp5azZlQWNONVVjQmpkSGRHWXNR?=
 =?utf-8?B?U0NPMWNUczRiZi9LUXpya1U3MHkxcHQxMmw2UXBTNW1DbHYvTHNMTnBLdnBU?=
 =?utf-8?B?VjNKa0syUlNhcmpKYVBnVGNMM1pWaFcyRUtLQTBkUHVIblVJeEJZNjVRRjkv?=
 =?utf-8?B?bmRRVElMaTdmLzA0Tmc5M09DVUd1cVhiZ2xURmdVTVN1Titta1ZNTk9MSzdH?=
 =?utf-8?B?UmVlOU9KSTZRejd6Z1BuTnN5UDN0YkJidGJvVjdBY1YzVnA2dXZ0Q3AxQmpP?=
 =?utf-8?B?UDFmTlNNWVhaVExXcmI3VjFPNmEvdTZnaHUvTXptT0wzekVpdmxySlNGOHAr?=
 =?utf-8?B?cVFlZUVIbTM4aVd3andNZ1AxNmowdDR6Z3hKcWE2NTZ2OGJxS1ZtTzA4K2l5?=
 =?utf-8?B?MFM0Yjh5bW1BOVhuVStjL3hRME9UTXJjZDYxbm5OajlVSTJNN2R3cXZlUTJP?=
 =?utf-8?B?aWJxMlRabk5YeTNXSzNkb1c4emhJTyticzIrNTZKbmt3VUpvbE9TVGllOGlw?=
 =?utf-8?B?dFhsSjN6a3g4OHEwMWszaXVma2d3cU9PUjRNTUtWQmFhVFVOR2ozRXRFUUJF?=
 =?utf-8?B?bi94c0pmbGJyL0NxVENTc0hLdU9IVm55eVNFY0I3R2VSbldRNEF4Y1Z5VWFa?=
 =?utf-8?B?eEQ4b2FCYVlndzliU0NBWkdzL2Q3OUJ0VDA3UWticncza1AzYzVRRHprZWxL?=
 =?utf-8?B?UWZLMjFMUnIydkF0SFVIR0paUGpzcnZLU1N4SnRhR0ZiZDE5Q0UyUkcyQm9S?=
 =?utf-8?B?UkJSSThEL2htRkRFcTU5UGhOOW9wTlJWbTVhdW8wbEF5WTJXVFEyV0JDSGsv?=
 =?utf-8?B?ellRekZvMnh6VmRDaWZOZEYvZ2h0NHNUNTBKNHZLWGsvWVViM3QvVDlIYTQ0?=
 =?utf-8?B?USt0eE5pTlZKRVR2MUc0TjRhZkcxT1M2disrTFFHeWRvUlc4bExFOGs5Z29a?=
 =?utf-8?B?YXZkTnV2RFlibHB6Uk03OXRhRjN0VlNNa1dkc2JlWXFKdWJWODV6VHpxczFB?=
 =?utf-8?B?TFZQWkZQblN6eGkxaWxDWlFlKytpWGZySHFhMytKY0lDTHhSUDFqbG9ONmdj?=
 =?utf-8?B?dVdrZDRnNmIxMGxsK0M1N0F4LzczeEFEUXY4R0pmaUZEVDBlOS9kdkUvQSth?=
 =?utf-8?B?UmhxcEtxdHRSVjZVNFAzZjJZK3R1SnUwMG94Q2JlcjhKSU9paU1Hcy9LWDNr?=
 =?utf-8?B?Vm9sNDl5RHFRM3gyQTJsK2crdjVKNUMvU1ZCa2c1RStlKy9RMzNUdU85a3Rq?=
 =?utf-8?B?bWRmWCtjeWZGK2FHTE5kdEMvazJYQ0poUTZEWGxlM0FwbWpiOURUQzZEOWkx?=
 =?utf-8?B?RDliNW5hc1JXUUVobmtKOW9RenFCL0VkS3JDazVzV2tPeExaaEh5SW4xYTVO?=
 =?utf-8?B?endwWDlRSCsycHVPdVBxaExxa0RWY0xwVEcrdVIxYTFURTFla3dHdFUwcXU2?=
 =?utf-8?B?WjlYRkYydjZVakp0SWtObXBCMGZkbEFlTDdzM09Ga2x0Nk1YY0s1QU5zRGp2?=
 =?utf-8?B?SGluNnRNRWZPcGg0QkZpYTg1SlVrZ0gwSlZPS1RqWUFCWlZkT3hKbDNrTm9B?=
 =?utf-8?B?UzRPZ05LN0E3eXJBRHI3REV0eTZuajVhazNqb2lsbHc4ME9aMis5S3lqYWsv?=
 =?utf-8?B?VE5qdFdJMWVyRFBMbzRoeUNVS3RKSGhHd2FUakhyWDkwVWdkdXY1eWJtK3Nm?=
 =?utf-8?B?UFVkK1h3cHM5NWd1UUdyVzczT3FTa0VlejQ3QzJDdDc3czBjUHloMFZEaTh2?=
 =?utf-8?B?WHRDQzNZQXNJVFVUbXF6M1ZsR0NONXlEeW4yUFZTVVBsVTBFaUs3WkNxZGNj?=
 =?utf-8?B?bW83dG1mQUpUeWo5NFdVWUJlb2FRdW1uSk0xSHVHSTNpSzFwU1ZFdFc5Q1hH?=
 =?utf-8?B?UGNtRWVjanBhRDlwazE4cHhlNVhrNmNTVjh6SkZJOUk3dTJNb2k0UTU3bEZC?=
 =?utf-8?B?NkNDQlBEUjJHTnQ5WDBnUDJweE5rWUs5Z1Bma3R1SVgyY2VJVHQrcFdaSThW?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28e5976-80bc-4b80-d183-08dc6eaef5c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:01:30.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xlfp5bGXq02iPvetLYQPWR6DEkC9n/V00tsYNNxUCJGMDxy1Ji3OAJm6RgLg5Jxdq1RkqeOx2fmg2i/HuWJ2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 16:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15859

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t_6.1.83-cip18-rt10.bb => linux-cip-rt_6.1.90-cip20-rt11.bb} | 2 +-
 ...inux-cip_4.19.310-cip108.bb => linux-cip_4.19.312-cip109.bb} | 2 +-
 .../{linux-cip_6.1.86-cip19.bb => linux-cip_6.1.90-cip20.bb}    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.83-cip18-rt10.bb => linux-cip-rt_6.1.90-cip20-rt11.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.310-cip108.bb => linux-cip_4.19.312-cip109.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.86-cip19.bb => linux-cip_6.1.90-cip20.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb b/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
index a2c23690..3a8f5720 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.83-cip18-rt10.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d0b66c7084dc64df2c7d0fce591467dae34a1dc5e8dad8d88b521a2f8c4b1cf2"
+SRC_URI[sha256sum] = "f26ae423970fc99cb4c4bc5f69052b39a7255212ae4790450eee935446f229b1"
diff --git a/recipes-kernel/linux/linux-cip_4.19.310-cip108.bb b/recipes-kernel/linux/linux-cip_4.19.312-cip109.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.310-cip108.bb
rename to recipes-kernel/linux/linux-cip_4.19.312-cip109.bb
index caf2064b..34cf1e0f 100644
--- a/recipes-kernel/linux/linux-cip_4.19.310-cip108.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.312-cip109.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a4a9802aa6eb03ab0d36e4d7552dee14619f233608363605f334ee9629812625"
+SRC_URI[sha256sum] = "e0883a7fc1fb6137203aacb504c65d126d256c1ca6fbde8b3103375c6264f397"
diff --git a/recipes-kernel/linux/linux-cip_6.1.86-cip19.bb b/recipes-kernel/linux/linux-cip_6.1.90-cip20.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.86-cip19.bb
rename to recipes-kernel/linux/linux-cip_6.1.90-cip20.bb
index 7e810ab8..e2af4d63 100644
--- a/recipes-kernel/linux/linux-cip_6.1.86-cip19.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.90-cip20.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a9231a6c77c638fe96d7e5426ea7d5b9d8a00872aa23e1246d2203c83acb0810"
+SRC_URI[sha256sum] = "7bea37feb3001e6c11489eccbe9a1899a1a735c149e675ccd55bdacacc565d80"
-- 
2.35.3

