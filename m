Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA16C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 16:29:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.42])
 by mx.groups.io with SMTP id smtpd.web10.25898.1713544174203942167
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 09:29:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IbLh6EuH;
 spf=pass (domain: siemens.com, ip: 40.107.7.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EILsDxahgadZ+8rS7OVDto3LUN6K9Uuqb+8fFPgszp2V75Qu+7nnY/hXExk2KsedLHPXYshEmuOH5pR9S4mURLVfU+TRQ2xoHFfJV4aNpYN7DkDyaJg/mGiUi18Fuv/CWaKm+RwQdsJZs9vCbx+CkCZU0K+DdA/ugHO8QmJaddWuWfjabb7j1PEOVZPVnIJgovbB88NS3x4s1s9bN2jYRFVuK3uu0bXaIthuLUYQnGC/8YSerW20b03CU9DZNTl6d5rz+1CtQsFkP+G/AsJJXwh8zwSmunQbW1gkkWKOToQt6SqnZQeu22dpWIxYUIsHzRdm3xCTPG7vS/eevQbdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BIAhNqvIS3dEiuhtjn/yA1wEknAdEW4YI9l7Vbz0FE=;
 b=aQiNhIjyD3h/Qsa5DCRZcdxvCj+I5OitVn6AjNgvDx6ZRYZj+gfa6oznl/IySu2kACO2u/HgA6kmxG3/aiMAfgaTtlTKNj737ADAxPw8aXQ5mPm1/psmoqTY3N//K1NabuEz6WMiJFLb46Z3dht4oNvH6G/LRmfJFsnGJIxcweiSAYLSkKMndRYUOfAG9N50MO0tJBCcfLIc1a0sQAMtkvz3F27iTPq99O32wZR83L1EPD3UU+DntVi7fbutdMcYtVWjJ50YLiaGhjYFYRD0sofqui32oUEh3Rb1TjbRjTsn/GdpNJiOgsZrOWJthfwh0pWKODW7YB3Br3HkfrNsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BIAhNqvIS3dEiuhtjn/yA1wEknAdEW4YI9l7Vbz0FE=;
 b=IbLh6EuHvBQwJ1KZEtecXPUtwYGQ1FhpkbrY9oyRZh/ziAknIfAKLyzigX83sO/GftnmcIvJNiDJQgPIGdNyJHYjWRIzGP3XtY7zMh8yKGa7znnJuYGrLpjkJrGWBNT0NrWvB3y5qbauJC0jiRGxQfhbTYRtWJL+SgwNCkxDXhyWixRa3Ouah5BEv/o1TThwcDEeTCXV9cGZNiF5goHDsUARV9wPXJGmaRD2w5aTgQgqEj8wB9GGmua4aayTtPJE1TXjOKBwpYBXEiCFAh8rApYCG6pdcDtVL7FsyvwwawkSn1CW085/kLyryPr3Q/0dhl4mxlv+cdhNvoN3zWgW3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:29:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:29:31 +0000
Message-ID: <96333853-27ce-4134-a99a-911e84157185@siemens.com>
Date: Fri, 19 Apr 2024 09:29:26 -0700
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip86,
 5.10.214-cip46-rt19
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: fe16b5ff-2db4-4443-5eb1-08dc608de3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QzJMVEdvL1VxQ0hXSSsza3NyUnVlaHZZaEJnR1loTm50enRKZWxiQ0hhM2Zo?=
 =?utf-8?B?dnhLMGFqUWZVL0xBUHZIeXlrY09pYVRpd3RsTFN6SUlDTlc0MDE5Y2h3R3k5?=
 =?utf-8?B?YmF0QktIRU9QN0MrYStoNU9DcmFGUDVmYmtZNWUrQ1BsUFA1SmpiL3JNVG1I?=
 =?utf-8?B?VHVTMjc2VEtsdmZYMHhFNzRWbEhmS2w3Q3BpUzNlQXJrR3NoVHQ1RVFDcWlL?=
 =?utf-8?B?Y2lZVG43NzhQd3N2bnZJR25TRFBmbEhnM1FLRTRoWjlZNHNDSmhMM2pVVWZm?=
 =?utf-8?B?cU1PN0JBczlGaWN4MW0vcThod3poZ0kzZ09BQ3FxY1NHOThWb0oyQy9sVjFL?=
 =?utf-8?B?cGJQM2hkYzZDZmttYVc1c0lTeWtNdERwTzZIY0ptR0h6OFFnU3B0UmFZLzNi?=
 =?utf-8?B?MzZIUk00OUg3ODAveXdsUjBDbld6NXJCa0E3cmNTNkpwaldMc0hSUzNWSjNV?=
 =?utf-8?B?c1JoVnFTcHNaYTAxOS9xUVIvZHNuOThIOHBoSFBwTHRDRVhwUGJuU1VIbDZz?=
 =?utf-8?B?djlDemFsYkVkMGJDcENjaXhNU1hMSDBFSGNoeWlLdzZYbEV1YXUrVVFndWxC?=
 =?utf-8?B?bkVTdFo2MFFMR0FHYzZvbWd1V1E0dWpJVTV5TG9PZ0xrSVVPYVJKS0lkWFk4?=
 =?utf-8?B?amFQRm1tMU8xa0JMV2NSRXdXdG1lOVVzQUtkdXhEK0NxcG00YXdBRzVPWG1M?=
 =?utf-8?B?cXV1QjRodTNhM1cwcVpXVzNEU1FqejFDOVE0UXFrYmo0YkdtUkRQWVV0c2sw?=
 =?utf-8?B?bGl5Zzh5Z3g2dG5YTHMydGlCbTZWWkRCY1NxTW4zY3pDVVRLUHo2T1NwVXQx?=
 =?utf-8?B?R3RXOUFBcmVvSWZSMGFldEMwRUk0eTh5OU92MEhCaUo5STdHUUlwMGphNEtI?=
 =?utf-8?B?aWJGazk5eFY4TmtLNTc2b3BqZW05L3lwbWVJQlpjemxTZFIyV3ZGOENQMGY3?=
 =?utf-8?B?VTllbXdvZGZvUVVTclloOUNaYUVhQVpLWXJjeWFOYVljdXZmSWovankvbzB1?=
 =?utf-8?B?Q21LMjVjZUU1Q0JCVndWTGwzM0t6TUtqMExRRzU2ZVJabWQzazV4emVQeHEv?=
 =?utf-8?B?VFlua0FBYlphcGhvdFRlYVk5YzNpV0I3cytTL2g5VW9uU1pkK2pzS2Y2R0R6?=
 =?utf-8?B?S3EyQ3NQM2JETFNTVksra0RWQ2F0enZjREdVOU85cUFuL2R6Y29KOFp3d211?=
 =?utf-8?B?Ylowdlp4Z2FRbjJNaEtpYXhmU2t3ZWQ5VUpXVTFLOFRQd09JdFVjKzZSdWY4?=
 =?utf-8?B?UWRNQ1VtMmk5bElwUTArV3prQTNMN1lhVElLZlRtSnBLdXpaVkxqc2pBUEJS?=
 =?utf-8?B?MTRVUkV3RWhVeXdSckVHWktmNWx2MjV0SWlOaGZsMTdNcjZGTS9pUkJVL2tF?=
 =?utf-8?B?UnhtM2dqQ0QwL0psdzFmMW5tMHIwaTJnelE1cG10RTZocENqWUU0SEpkNXYw?=
 =?utf-8?B?RkpZSmtMNU1tWTNPdEhrT1MxTnNDNnU1aHBVNzlaazBBK1ZNSzM0N1BXNjNQ?=
 =?utf-8?B?QzNjY0JkQXBGdDRrNkJUNnFFamdDYzV5OUJzajNXRlJkdTJ0RVpNS3A3eWZU?=
 =?utf-8?B?K3JERmdlNmluZytJSEQwNHh0dHpzOXhXU2phRExqblFEenF2bzBJN05VZEli?=
 =?utf-8?B?TVlUYjk0QnFSdVNzcEl2ZktXZDlYTTNLSjlWUDUrYkFsbEkvL1BZOW9hS24w?=
 =?utf-8?B?b0Ztb1R6RFZKZXJ4NHpNMlo5S09oNzBaLzVmRWpMR0RBeWNaSU1HNTBBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVJLREhBWVU2T1lpOWFBVXRjZnRpK0hyVUUyeXhoUE1RNiszWmJZYndGditt?=
 =?utf-8?B?dGZkZHVEcUR2NDJyNWN2elNWZ3cwenIxd0RCL1R1ZjNwdE5DRFFveFZTeExq?=
 =?utf-8?B?WWtlbzBBTkR0M2ZtK0dWdzN6ZWd3enVkVVFGbDZSRzQzOWZlYS9iVDN3ZEtm?=
 =?utf-8?B?YVZ0ZjlidmJQS0hpQkpJSkVDS09yaHJCVFNDblpObzhycTdOazhZanY2OXBX?=
 =?utf-8?B?ajllYzFNbkVsT3lha3pZM0drRnp6dnJqZFhTLzRGN2l4VGdXSmtQbUdMemJv?=
 =?utf-8?B?V1dSUUtVcFIvNzZXMEZmV2FYRFJXOG9HZnU5VmJ6ZTBMTG9wTlFXTEZnN3JQ?=
 =?utf-8?B?bWtCamEzRG5NVjJrYlJBcHlaVWNSUlhYbExSaUJmT3d3R01jUFVvRklFYXV0?=
 =?utf-8?B?V2c4YlVPOWk0RWV4a09uVzlOcnZIZkVRZ3ltbFhKYkFzUXFjTnovWUd4WWhD?=
 =?utf-8?B?V3BzNjVKRFBwZ3J6YnBVZG5YTzJUampUbVZWN3A1SXFuckNPS3hSbndJRUMx?=
 =?utf-8?B?QjNDcGJ1Y0diSlFoWWNaS2ZLaEhkS0hiMHpJZmphcGlnczZlaDE3Q2xqOVZE?=
 =?utf-8?B?OFB5MGxhdlVLRmxOSGVJbEw2b1RBajlDVlNla3VTaThyc0FEa0pyTTBDQjRW?=
 =?utf-8?B?TlhKKzRSQ2ZrSFZ2VitZSTRpYk9USjhLSEw1T2ZnKzJoSG9pTzRhWW9Mb0xP?=
 =?utf-8?B?eFUzMVFtZGVHWmU2UUJ2S2hndG96d2I4a1RaZlVoSXdWYktoY3J0KzVsRGha?=
 =?utf-8?B?U3lNREIzdTFlTzNXbGJFRTc0UFZxbzVCM0YzTk5rRXB3Nit6V0Zwa0QxRGlo?=
 =?utf-8?B?dlpCOU9sQWxaWVRjZ0ZDaHNkT2dJR1E0dlczNXNXTlhZc2ZiMHVXZytPNm1v?=
 =?utf-8?B?RTdRQlhoWW4ydTRCMUxabHZtcGczUlNvY1JncWp0Z04wY0tUTFBxakJHOEFF?=
 =?utf-8?B?b0xZTzFySzZORGlwL1VJWlJhVUlrQ1BXL1VKVlNFOTA3NDFTbDhzRFo3MlNi?=
 =?utf-8?B?Qzc3cCt5RDZqZFJGSXpFYnA2K0dIRUlKVzFsd1ppSTE4OUpYb0VyOFNLYnR6?=
 =?utf-8?B?cEY2b1pwYWJOM1JUVEVoUzZqb2hrWmwwNVJoL3lDYVRBMWgrZXFGK3FkdUJQ?=
 =?utf-8?B?VFh5dEIvcjQ4dTA4c25wd2laUWg0ckw4eXBrN3lQa0RCRXlTRkdyQjNMZjVp?=
 =?utf-8?B?Q2MxMlp2bHVVdUFvc3pmVVkvREtnUWJ5blJuQ04ycVl2eXMrcVM0UkN1K0Iy?=
 =?utf-8?B?ejVZMEZYaFVreHUvRlZ1WTZCR2xSSnZxNmY5NnpndUZxU3cxUGN4WWZaMjYz?=
 =?utf-8?B?cFdoaEF2ZHFscWFsMlpsZGpyTk9HSmxHZTVvcTBOZXcyR2FQTllESDQ1TUli?=
 =?utf-8?B?N3pRWndSTFJQUkRzUUppZFVaS2Frb3lMODl0ZnFGT1lWM3pjeWNGZnYxdWU5?=
 =?utf-8?B?dTZsUHBmWkJlVloxVUFSd09pYldKbzBJSzFmSlBxZ0NvQ2dmYVZiQzFpb3JW?=
 =?utf-8?B?K1ZHU3lKOUFoYXdkZ3V5UXFXOFBVbkRkTFdrdWlqMW1tNEpqQ1h0dGs3dlJT?=
 =?utf-8?B?SHZ4Q1FPbVlMSUdURGRlcnN5OVNyMXVPdWtxSkswSk9vYS9saXVJaGhiOFNP?=
 =?utf-8?B?N3A3Y0tWWEJPNDF5REdLOUxoT003RUVDeTR0UncrRTA2RmpEenMxbHFRNHlC?=
 =?utf-8?B?Qzk2eUsrWnJXYVIvV0tVMmdWOVlMekREa1p6RUQ2THM1bXV2aGdBdU9pMnpP?=
 =?utf-8?B?K0djZG0xVnZmMVlXNEI1blJ5L3E3VzFhUlhNazZFY0h5bTJpelYxV3QzMVdQ?=
 =?utf-8?B?S1Z0MGxXSDZXTFlGaE9jdlJMTExGQVNVMUVJNDMwa2FLNm1lQVhHVEJhMmpJ?=
 =?utf-8?B?MG9jN2FhQ3p1RHl0V3B0NlFTK3hwWXFHc25vRTAvYnNhT3lHUkwwdDFPY1FQ?=
 =?utf-8?B?N1FjQlZ6c3MvTktKMjVsN0RjbU1TVzR5dmdBMlpxNXprTm0wRlBva2R0TnUr?=
 =?utf-8?B?Q3llR1dmWG5wbVdkdTM0MG9YcXY1d2M1VnNiaUowYjg3SXRaVDlhTnJ2Zk9W?=
 =?utf-8?B?UjJrMHY1S2ZBdDBGM3ZvNUZlckpoQXVXUjBBTGJkeXc4bTZYd3BoVERhNjh1?=
 =?utf-8?B?QUNqMU4xRjM5VkVpcGdrUW5yYWZpMFFqWlpVUHNVbWNuTlY3M0QyRVpBQkNH?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe16b5ff-2db4-4443-5eb1-08dc608de3d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:29:31.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etv9CM/0WOdJ3csXE1rcmAfM/T9upCaBJidnc+hk5ThjTdBtIiIXUZAc9N7LSUI5w2ccAaN4Zre6zHusBccMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 16:29:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15704

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.209-cip44-rt18.bb => linux-cip-rt_5.10.214-cip46-rt19.bb} | 2 +-
 .../{linux-cip_4.4.302-cip85.bb => linux-cip_4.4.302-cip86.bb}  | 2 +-
 .../{linux-cip_6.1.83-cip18.bb => linux-cip_6.1.86-cip19.bb}    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.209-cip44-rt18.bb => linux-cip-rt_5.10.214-cip46-rt19.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip85.bb => linux-cip_4.4.302-cip86.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.83-cip18.bb => linux-cip_6.1.86-cip19.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb b/recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb
index 247330aa..c1e29d61 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "37649406c37734e895ef7876a432a79994a4a7fe51fc4edf4ac8d34d5d0c13f7"
+SRC_URI[sha256sum] = "2126bec23051ca89a33dee6a2521d0cf07404d5ae7a56b48a4e4421655601175"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip86.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip86.bb
index b71ef9fd..e03e973d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip86.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "ea131a2e907c5cbc05fb756d00a007b1473160e4d250d7332dd050f549c09408"
+SRC_URI[sha256sum] = "dd6ddb938c103c71a56b87a82cd80df2486a0bc9b5a318bbc3937c88f40c0e82"
diff --git a/recipes-kernel/linux/linux-cip_6.1.83-cip18.bb b/recipes-kernel/linux/linux-cip_6.1.86-cip19.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.83-cip18.bb
rename to recipes-kernel/linux/linux-cip_6.1.86-cip19.bb
index 24533f35..7e810ab8 100644
--- a/recipes-kernel/linux/linux-cip_6.1.83-cip18.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.86-cip19.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "10473fafb808267cf37830054ed3593060696b7007bb78811b5c7a7a2fbdde56"
+SRC_URI[sha256sum] = "a9231a6c77c638fe96d7e5426ea7d5b9d8a00872aa23e1246d2203c83acb0810"
-- 
2.35.3


-- 
Siemens AG, Technology
Linux Expert Center

