Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D61C369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:30:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web11.42542.1745825386957728870
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:29:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=voaa88Fu;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMXbOMIFvOJeoEP3v6JGJEHTFpy11cTlym7KASf4tJ1sRL1hZLSqWp8OAaoqJIsy/KnbaqDlPIrLgNx0xKKdBv5iljejc6SKNAy6NynEf5Z8pMcbmJ0z3SakEkrvYit7/2esEFpXgUeJR0jWt4+wlWb4xE7kjnJHh0fNw23hbF61/5P3lO3GKi7Bq3zBu+7i2DUhiu9WS87qo+oPb1DcfNUGZNxkaE2wLUhyVQtyNJNuK/BtuL2YXWgtoEWsguEGIV+y+Hhvm/+F6PQ6cox69DyGy2R5Njj44Nk8kXEwGN2lq3fGPwwHmoKljMwjOKaLKN1PtN1sQ6HvyUMUXzAzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce/pwraatrFNlBdLY5z24uN5JXEud7pSfW2AIxsz2kI=;
 b=gcLLg5kAj44PWNyVBxtxi8IfQt1rIlU6atVLcQRKTWtv4KezxuirYDBXMQq+4PGYGtmAJ8FwaFJWGTnx2ZZLKIGJ3K8mCrLNlgHCk48+j1sjbdHAEJ5QBEM9uUcKMVjy2Qkbo02SDc+uIU9A5sbYD1sC22CLTuW2t9xNcLClXlUTfU/KOjXhacGBAafZiw1CEKiHjzui/z1KTR/VkDIX2Jo2kszF3ttdyN+PpHEpuif3XDtcq8W/weF89ukShCL8D/N56Ynns/ieZPLrg+pAp5lqeQKTqo2Ar9PHj60dDa1IeYnK3trzkG4flEwm2h1RPjRbLukc0JGcyluaYrod3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce/pwraatrFNlBdLY5z24uN5JXEud7pSfW2AIxsz2kI=;
 b=voaa88Fuc5108la/qQY3lbQHkwphJX5qVo1xqgo9oNnxWAAoarnvgG+PqTiDNmRH36CYMvqCUz/KWC4Aw3ApFJKwaFI1zCYMZ10qPOmqcli8ySpitw6PD3s/Xz/fJlNZb6a8g/qdoVz6lT3QA+TQgTS7qRByixqeTMapBdpzYSUWl+XOycXIFn1teYKS9iRWwAmb1hnQCQogR6wVn/TLqPo+cY8nWwgK4tR4n1LiHUyifW2LQTybTuCBS4giz7sgDZH0F8cM1zHiMrZ7lt1Nr9r+HQFqZ288ocOG4aFvycyXDD7wkpgJVtVJhL7islOzpXRREhoUO3EjWrQMYquDKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 07:29:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:29:42 +0000
Message-ID: <c093cdd7-05be-4844-bd57-01317ebe21a2@siemens.com>
Date: Mon, 28 Apr 2025 09:29:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Ajust misleading comment
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4022b1ee-a676-41eb-4a95-08dd86267170
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c3M3eWZ0VTNHbVZLUUJVS3NxL0NrbmJFdW9wa2FqWkJBTXRQYVRrMW1hYVFw?=
 =?utf-8?B?Q0hsbG5pZG9wS01pVEZRVHRaR05GdDQ1ZHF5UFc1YkhwajhqUUpqNysrZ2NN?=
 =?utf-8?B?d1NXZUR0eVNxZkhXQ2JleHI3ckM4dElucnZrQ1Zudm94Szg2QnVRdFFESmx0?=
 =?utf-8?B?NmFRMFRES1pnUUdzS3UycmpFaFhCQWIwcTdnYzVDTlEyWkpOMWZXSmVDTVlX?=
 =?utf-8?B?L1VvT2dITldMZXVJb1BBWDl6QUkvR2o2amdoZ1dZemlIUFNUTnM4YUZCNG9r?=
 =?utf-8?B?b2xsU1BDMmdxQ2FEK000RUpUNGsrQTB2eHR5cUtHdmwwRTMrVUlLdVp5S3Rs?=
 =?utf-8?B?K0dXbzBmdjVYdEFiVzh4NUdlNWVzaWZYWVBDR2ZORGRVMTY4SHRUNnR2azBR?=
 =?utf-8?B?OFhZU3ZybmZ2NndFbi84dGxlZmx2VFNSdUZFWUY3SDMyVDZIMEhsNFJwdDZB?=
 =?utf-8?B?MldaOUxKZ1J0KzVFZlphRmJuQ0FScnIzeVQ1Z0dBdk9wVUJ4RWs2Mm1lQ2tD?=
 =?utf-8?B?Y045RTNMcFhKU3dNNnEzb3FmcEYrUUtRVDRaUFRqZG9KSjViV2h5TC83dHA4?=
 =?utf-8?B?NkxxckxJRGxqaTBBK2ZDbUduSkJtd2M4aEZ6Vm90aFEwSTVDRU9CNnRYVVhp?=
 =?utf-8?B?SXVzY3lQRnpqUFkxaGRlbjVtNFplUmcveExSWEhPTzRaSHM0bTV4Ymg2MXFk?=
 =?utf-8?B?U2tDWEo4bDZQSExMc0hNQ1RiRTFTeVJHR1RvL0R2Uk4vem9yYnRuWlhFTytt?=
 =?utf-8?B?eEZ2YmR6T2VhVFZiYkNyd0VqVGxkVm5KTlQyWTh5OSt5T2tRMkovYkJUQytm?=
 =?utf-8?B?UXg0QUxWa015VU0vZXJadnpnY2ErMjJ3aXVhUHVReG5WM2ExRDB2Qk1SYkNP?=
 =?utf-8?B?L3VtZlhUTVFOUWU4SldlR0c0ZWdGUFFWd0k5bXorVnZlZzhVTThLRnNsNllO?=
 =?utf-8?B?OEZKVEpYU3lyTkhsdHNvaFdUMTdxVVNUOTRQamhjcHZiSGR0Q2dYajRXU21Q?=
 =?utf-8?B?VFRPT1pYM2tTdjZjOFppSmNobnozb2FucHV2YllPTlFTSWozbnBzT2tadUpp?=
 =?utf-8?B?WjdDVnRNbDNJajRNRWpjeUswTE5TbmtOR0Z0aWlEQ0xoNFdvdkpqTGYrNGs3?=
 =?utf-8?B?OGt2MWhKcXpMUHVEc3J0dnF5S1dXZWM3d1dkQWNkaVNjMmlYZ24wa2IzR1JB?=
 =?utf-8?B?UzFraFRDKy9zNTg5dFZtTlRlMldhTk16QzZFZmNWMFhZQlNqRkpwZGNvdnJa?=
 =?utf-8?B?V0puS1RBSkg4cW10eG41QzMrVlFNR1padDhTVGErVW94N2NNMThLRTRnSitL?=
 =?utf-8?B?SVZjL2hOdUxBcVJLdGZ3Q2NTV2FmazdVTlVBZjRHZlNxdlpBaU5DNlp0cTRS?=
 =?utf-8?B?Ky9KUzhTeis4UU95UEU5eVcyYjQwSHlCRXdsSisra0NaSnRCSTVJYXBLc0l1?=
 =?utf-8?B?amhUakhtNlZGNXRuRDNMR0RNVmJFUXpLZWdrWnJ1MDUwN2M2TWZONmtvQU4y?=
 =?utf-8?B?dUE0TXoyeXMybEkrcVVPemNLTlA0R2N0dVVBZzQ3Nm84K2tJSW52NlFxTjlH?=
 =?utf-8?B?QzEzWlJOUzd3RUtVcUJuc0tFampxaU5nSzBwT3ZVOExjSlA2WGFiOHdaSXox?=
 =?utf-8?B?OTM0Q3pYejByZmVZMmtIRFh4R2RxUFZTVEwzSnJjUDFQRmJZL0R4OEdPVGRM?=
 =?utf-8?B?TEJSVUk5UEp1MlQ3eHMzRXhhOVdkbUxkcmxTdG01Q3FyYVcyVUJEclQ2blo2?=
 =?utf-8?B?Qk10ZU1YTGZKSmlKWU1iK2tkTU55M2pSbkhOaWZ5ZXBlNTZvVXlyYmFaQWZX?=
 =?utf-8?B?UUE4NFBDei9VVWFEbm52bzFndzYrUGdTR2gvUmZCRTRqZFpSd0s0YjZreEF2?=
 =?utf-8?B?S0R0MFl2b2ZFMURQcVJWeWZjdWh1MVRpK25Rd2dFRElJMnV3aXdHemJzeDFS?=
 =?utf-8?Q?1+vJ23hfxVg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zk1JRlNOeTQvK21UcXFxRlZPZW1yU04xcGpOM0V4dXNNbWkwdmtyZmhRdUZF?=
 =?utf-8?B?Y2gzSWEvdXJPSW9LQkFXTUt5dW5KbnZLY0ZTUXNWUGZxVHdPaDFrdUo4MjhP?=
 =?utf-8?B?MXUzK2tlM0F5aHZwUUU5QU1zQThTSUJZT1pVWUNJVU55TlBoMUl4alY1c3lq?=
 =?utf-8?B?Q1IzdmgyR3pOVWhuSEY1K0d6WVRmZm5sLzBkSFQyNU1VNW1wSFZUVXV2SlJm?=
 =?utf-8?B?ZGhlU2xaRytqV1dDZHdLdUxGN0NGMHBtQmhHeHBMTDlqckptZ0ZzU3o1eFZ5?=
 =?utf-8?B?WEE1U2xtdlBCYVdsRGM5MnhjNGRKNXlvaGZSUmg1V0xFT3B1dnRjdFlzblJl?=
 =?utf-8?B?QzRQRUFUbWVaK1Y0Qy80dWpuSmRvNGRUdFVtcXBiei9IZ1hiUDBlSW02V2xH?=
 =?utf-8?B?UDF3ZnBFT2hxYzNrSndGakdlamJ2TnYxUGtZTWtMMnJiNGVNbmswTytDMkhO?=
 =?utf-8?B?aXloMDNrMkxqUTVJRUs2OVB2ekZZNlErTUJhYW83eGhpQWNzc0VuYWVSTjlF?=
 =?utf-8?B?NjZneHRPM0Q0SnIyWVU4UXY4S2Y5QWJkdmFPeWxDYmdxN3Z1ZUpTTzdLOWFa?=
 =?utf-8?B?MUlGZEZQVkMwQUdMcjhWbnFOWDhTQUR1aEs0MWhXalEwbkVRUjUvWHdsb1lO?=
 =?utf-8?B?MmgzSStvM2pPeWV1Zkx1WG9hY29EUkEybkZNSVBISVFVWU9XM2FROU81cmpH?=
 =?utf-8?B?RHBkQUszL1UzT3AyZmpxNXRaUmdDbEVnendycjRQSG02bSs5SGU2c242ODVD?=
 =?utf-8?B?cE00Mzh4czB0Umw4Q05waHN5ak52SXJtcWZ1Vy94N1VHbE03NUd0TzRLK2pn?=
 =?utf-8?B?ZXhCQ2ZsWTBoQi9udzFzd3hJbzcvQnBpUzVKRlJqOTFobFVQZnNGOG9qL2dh?=
 =?utf-8?B?UnpCV0lrVWlYTlA5Z2NNSUljZHc1R0p3V0t2ektpcUtIb2UxNzJEL24vd2l2?=
 =?utf-8?B?TE9EcEg2UkJrT3JYYjRQcWlHZWZxZnp3Q254WUh2OFozNXQycmxmM0s5aTJj?=
 =?utf-8?B?eHkvU05VQWtxVWlWc1BCZTJ1c2ZxQlUxMXpqSE1UUUVTY21ldHREbG9UY3Z0?=
 =?utf-8?B?SVF5YW1oQ1ArYzJUUThvbDhFZFp0V2JPbW5kU3QyZFlwWm8ra1lpZ2JkWUZB?=
 =?utf-8?B?b1FOaFBwbVlVazZnSGdkdVBGeDlDVmxsUWlTS0JiWmRTejNXdXRGTmNaa0ZF?=
 =?utf-8?B?SDNHa0Q2NzNVZDk0c3htRWt6amVic05Kekx5aGlqaGV4bjNkcW9sQlRVK2cv?=
 =?utf-8?B?OU5Ua3ZJdWIrc0NkTWs0dlFZSytwN3dTSFFoNlhxcmY2b3RoM0ZZR3pYaFlz?=
 =?utf-8?B?ZHBEd1FDOHBmQU9BNUtjNjJRc2IzRk9nc0V1S2U3T2pieERSSlpiRm1ZWTha?=
 =?utf-8?B?ZGhnMU9JR0NHdCtSQnV5ZlhVelFYYzJuczhSVnRsUUw1T1laK29HNkh1NElp?=
 =?utf-8?B?NTdheFVMa3ZHZzhra0dvVWgrZEhjYUNueFhHYWxtbHRTT3FZL3N6b3hJbnF3?=
 =?utf-8?B?bzErcGR6bDdzWGtJTVUxK0RDNEtHa2lmNmdNQ2M4d0NESmlPRHhzTm9UYmZ3?=
 =?utf-8?B?Zk1rQ0ZSZUJzelFYNEcyWDhCZ0U5NWNTbWJLcVdiRkxNQmpCRitGR1VZaEIx?=
 =?utf-8?B?alNJcTFwSzlNampuNDJhRWZRYkRrNjJDaDU3Q2F6TzVwTWJOcjFzUy9Ra05V?=
 =?utf-8?B?ZVI4V1VxY25tbEkvQzV0eElzdEcweFJQM2l4NTN1emNPQnFoczVvUnNvVHRo?=
 =?utf-8?B?M3JQSG9RTW15emtHWVBQenA3ckxqellIMnpHalhKRGI1ck13dExDM3pwR2FI?=
 =?utf-8?B?QUtmNWhyS0xSWUROKys2THZ3MVVOVWRGS2FYRzdaWm9NL0I5ZHZEZ0prR1RR?=
 =?utf-8?B?MGUwd3dXSExXb2p5QmtSTmlwSndwWTZxT0lKTDZqeEZDL3hVR3pha25PS2Ry?=
 =?utf-8?B?ZUJiRFBNL2RKREFaSlgrQTd6UEpXQnZCQmZyZ3lUMktpN1NoNE1LVm52Wm1v?=
 =?utf-8?B?Zk00V1k5Yllsc3pSRHVHdDQwSGdWZnQ1NFV3Q01QdWhzQmxOekl3Unh3Z0NT?=
 =?utf-8?B?RmttSDVNb1pPNkZLYmFVWjludjZWWmoycGxDWW9kRVpiTldRcmh5UW44UHJB?=
 =?utf-8?Q?Dk2LOj6uhWz7QQTK53j1Fei8U?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4022b1ee-a676-41eb-4a95-08dd86267170
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:29:42.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxBs0soz2gPYGrEuajcTN/jj/mkCayhCpySU40FkDotEHwMTln/XjRx0IMuh3gMwM8BOT/XRUm530XO0ySiXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6921
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:30:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18687

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-bottom-complete            | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index 80553d1c..064e41ca 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -11,7 +11,7 @@
 
 prereqs()
 {
-	# Make sure that this script is run last in local-top
+	# Make sure that this script is run last in local-bottom
 	# but before overlay
 	# This script mounts all encrypted partition, which are
 	# not mounted previously
-- 
2.43.0

