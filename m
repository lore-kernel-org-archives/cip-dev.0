Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0497E7717B
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:48:29 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.88])
 by mx.groups.io with SMTP id smtpd.web11.33403.1733478500151141057
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:48:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PtGT+s8R;
 spf=pass (domain: siemens.com, ip: 40.107.103.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4PcNzixwehXU4H167pYfM4UAGTrxRoIcjXnyjYX4eoSqmbX/8khf2Jl43jTqOfiDRHogKmtDDcOu/UiwRCm1U959Y0ZtXbsXIisiMXl28nKqhOS4tNDK77xDISIwBTykEjPMFhOdfKTML4sqyy7MEAYu0/xSFN+fUxnWC4sBrTjEBNuSTJq2UXs+HdXui6JiOKQEh7DHvbn5lv1GwwlTPruH+ki5C2F7Q/rh7qH/AMFVXwZviOLzAOJ0HVLgqH8A+QoI1xmVAB63tsuzrEKEg3FUoGol5i2woaW4nYYiwLxx2hG6xccqXfIkE/cM7pTdan1ZVqsDLwfdBAGK5n/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBcd83FgKiU4AEhqC9W8dmuhMJEF4mXUJAfJOr63l7E=;
 b=HK2rPJCh1qoC6had2XEP16lFAFs6SXAVPZl4n734m5XZ3Tz38PpUDEDVFQ7D3qGC6CGMI9gGiyY9qoNSnSADIzG+iSOfTu05gsGC8O3jxitSCrKfo8ngY/9ZddauBtTgqqxeVh3YeY9JBdooiXdr1th1ZZYU+jlXySLoNnXDx8BLQ+lL/t1YtLYERcwdrj93UbHebR+Dsd16pfGXXbsC+ae7qJvy5OwRJ1I2TiD7chHBA6aB1PNFfSneornRwu7bp44qcy8xjVUimTX3vZTd57Gj8BLBKDNyIPmQERGOkUYDU/wcjuOgxB6db/DQ76ywnbLxhbtQXJfRGnBohQC2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBcd83FgKiU4AEhqC9W8dmuhMJEF4mXUJAfJOr63l7E=;
 b=PtGT+s8RTc7i5BCXT7/RGCVdMhM5nAS5VDqfOsubmuou3J86BiZ4uxsiWAMCknmHCHmRDuqOQnIMRWgY5tOIdIMo8ucZ0AfCXYVYzbk7B619OkYzxd4ZnfH93SoCD3/M/z7csDPWo3mq53yeD+dm8xDD3YRcJRb9i5nLzCVqxjkXJHX22qIpot9s3bdAnPy8xrGTbRA6E2U6/CpJeQH4VDpGdXoLKWCjYVFEgnXIT1vtocema1mp2E7RIJuMp1uoc4BlDCkowIG1jP6R78x7YrCgDMBNrY0flFI01ra+cgf+pIz6S4Sm90I8MVb/efCH3ax9g1XsbkPc5ChpChXDPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.10; Fri, 6 Dec
 2024 09:48:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:48:16 +0000
Message-ID: <155e2bf8-3a8f-4760-be0c-fefdd0bba180@siemens.com>
Date: Fri, 6 Dec 2024 10:48:15 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: e449d881-8721-4fac-304d-08dd15db1b87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0lyeENHZHZtc09oV2tzc1plSllJODc1Z2xzOGJRUkFCQTQxUzNPWFYyZlhK?=
 =?utf-8?B?cVJHeGRnbjVnZk04YkoyeHZwdk1FbTlDOWh2aUxkSmNVMEpWRmxQcUhKSGJE?=
 =?utf-8?B?SHhEdnZmWkkrS1JQdnYxQkxHTFVQaWw0MEF6b29xaEp5NzZvQ0N1U3h1eVBo?=
 =?utf-8?B?Wno2VG5Td1ZkOEZTd3JkUEhoQlFUM2loS0gyeTFzQnM3MDU3eDAzZ1VpS3Zp?=
 =?utf-8?B?UHFYNGdGYUR1RzZsWU5NSnpmSFRKYVFFWDRsaVdvSVN6T2QxYlR6MDM2UHNJ?=
 =?utf-8?B?UUdJWjJpQkkxemJsMnI4eFlrWXJCemNJekR3bmFzNFI1a09qZFNZalJVK09i?=
 =?utf-8?B?ak1DNldROWdFOWl3OVBEZFZBVWZDNVRVNDE2ODJZSkFZTElEV3VDd3Bxcktt?=
 =?utf-8?B?aHJlcXRBM0FZa1JwQlMxWmpQK0RJYXdaR1pMZC9DdnFVMVQwWXp0KzdTNTNl?=
 =?utf-8?B?a0VwOHNBTWZuRk5vN2FONHZ6U0tNcnZiK1MzaDdKdGh2N0g1UEIrV1NIcG5z?=
 =?utf-8?B?Q2VobncyMGhqWTlPcWF3SWhDU3pIaTNrSmpnOHlmYk5IanJsWCtPaUI3SjFJ?=
 =?utf-8?B?V2hqQXdtVlpxTXJkNmNKeXdJb3M0cHY5ZGxwY1pRaDN4Y1lJcTVOanlhNVJL?=
 =?utf-8?B?eVVzcFFBWWNtbmEzQkM1a2tjTWlHTFVRUVg5dG1pMDBXQ01QVU5Mbi9UUUJ4?=
 =?utf-8?B?RW9ibmFxVDZvT0JwTlBNQk1lSG9pRHBCTnlhcGp2TXVzRWZYVTRLTUFhSnJC?=
 =?utf-8?B?SklLSUdhN1dpWXpsODY1SWVkd25TbzJRRTZoYmFFYkpwU0llVEpUU0czN1Ri?=
 =?utf-8?B?UThuZ2M2YllnSjBibE1odXU5V3pvMVlMSjJwQ2F0cGZWcHVra0p3T1g0ZlZP?=
 =?utf-8?B?QkZlTnBhbzl4b0pnTi9BMFFhTHdlUnllZkplQ0huWGFwSEFaZDFZbFVtNXlK?=
 =?utf-8?B?MThzbCtlZFNRM3hDNHd0a2YzSEVpcVNDblRRT1RaZWVHdWFOVDhtYUZNWGtM?=
 =?utf-8?B?cmdKQ3dTS2diZmtMV0hvSTFtb3JDOVBEWVZnMzl5YkRoalZlRWlVMHRnTjA4?=
 =?utf-8?B?K0JlWnEvYm1FT3FwUXIzQWFRbEtNZ0dYRFZRakJQRUFxY2J4K1haT2xKQzRR?=
 =?utf-8?B?cXQ3cDRaSVFmTzUwQ0pBKzlnOWxvV3p0STB0cG1BUFBtTVU1Mi9vd0N3V0RQ?=
 =?utf-8?B?dkNCbGRKSjlMaWxGVTRQd2pOTmFRRUVETkdqdmhDM1dIak5qWmE2KzVoUjFw?=
 =?utf-8?B?d0FBSVlWRDNYT3pqMGYyVUdoNExPSThDZm5ja0Z2cGdEUm9CcklXSTBIK2dB?=
 =?utf-8?B?WkQrNmJSc202dHpkZDE4RkNzTUNxd0tEenlTUzBKcVFkTXpXbjEyQ1dsdlRQ?=
 =?utf-8?B?V01CS3JwWEVNY0QxVFJMeWZCLzl3UlRLSVRqUWhRMzVTZUZZVkNyc1k2OU81?=
 =?utf-8?B?Ym81bE1nT3dheWZweWkvQkJiYzBSWEkrVEdNem9sZnp0N1JJN29YaU1pWVFz?=
 =?utf-8?B?L0p3TTN4dHBVeGJYUTlQN1pHdHVXNG4vcnNUVFV3bVZTMDJoVWNLa1grVW03?=
 =?utf-8?B?RzJvK1BDUTBSNXRPTWxqdkNqcVZBZjRLemJkOFhTWjZOUnlnQUthNjh6S2c2?=
 =?utf-8?B?WEt3SWhvM0RNMGM3YmVmY1E5UjlSdE0zSmcxRlBqNnN5NnJRMXc4Ym9YSGlm?=
 =?utf-8?B?RUxZWmRBWHRORlVqMFBubENQQUc2MXgwRXdkZFN0M0ZSWDY2Z2FBTm9hK2pq?=
 =?utf-8?B?YXFjdjNXZ3V5dWVBaUZuSHQyNmhKTVdYSE1VSHZQUmdCZ1luUGgyRWVZZXBC?=
 =?utf-8?Q?qD4VQwjORgjRe0/YVDYQBN2umzZasLjkNvze8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3lsNnhKbmxhZ0J4LzI5S1U0ZWt0cm8vdnVySVhjUHllNW5iSkpTZkwxM3d4?=
 =?utf-8?B?akR5clBWUVlmNU4xaU5SYnJub3ZsdzJxcmNNaWdGZjF1L1hhMFJsUUZSdUM5?=
 =?utf-8?B?YXJwbmtwWUM4MHdpUjM1RlluUk5nbE0vU3JUOGJUWWt0ZjNKUTRWaXFBb25a?=
 =?utf-8?B?Zmw1TGcydUwvRzliLzl0eXNCTnBVQis3T0Y0M3F3MEtYZmo2SWdneVE5QThu?=
 =?utf-8?B?b2hENGxpdEpaUlM1anZUR0xJN2lKcU5yQ0JRK25adnB3ZktpaHgwaHc3SVpG?=
 =?utf-8?B?bUtBb2ovNWVKWTI4anA5ZHlUbWJVOUYwVmdibmxHN0NJQ3cyV2NNc0xsQXV4?=
 =?utf-8?B?a2hBaWgyRER2V0pZSmZuK3JlaXlYZElVTjBkcU5uenZrUmJvS1R3QzJzbzdq?=
 =?utf-8?B?ODZhdUkrSWdBdEovOGhnSjY0cWlMRnBtb1JabEUwTkQ1eXZXRVZlT2llb1d4?=
 =?utf-8?B?eGoxZHJVYkVZNTJJWVJpQ0orVzhGMExHSmZaWmluNGxTeGVmSEZuUENVdUtD?=
 =?utf-8?B?Z0FIYXByZk9nRFZhT2wyS08xOFU0TmNhcUNmUnFaZ3RqVCtTNk1WRllnRHN2?=
 =?utf-8?B?Um1nSWQrY2NhMWs2aUVzTUt1emxkSWhoY2FmQlg2YldvL3NDS1hxVXhPVjY2?=
 =?utf-8?B?ck1LY0xnSUlUSE5pRHFPRkMwNXZLbExFdUMyL09SRDE1YncrQ1E1ODZxVWhF?=
 =?utf-8?B?ZUorUVR2K3FqYjdTK3RsZ0Zwc3RiQ0plWTVLbVVyMGRxdjVOTHZNdkgxeXJr?=
 =?utf-8?B?emlsS3RkeUxkQ2k0VDRqSDUxZ2hkV0FjNzVJY0c0NnJucW5uT1crbXd3ZTlQ?=
 =?utf-8?B?OE5QTkJDMEs1ZFB4ejAyWlkxZFdFYmlSLzlaUDVlYVp5SngySTc5NENFY1Zy?=
 =?utf-8?B?ODhNbnhIRkxvR2pQS1Z1aDFtUW5Yb05ObUJ4cDd2SXVab1h3TU90ejZkWFIw?=
 =?utf-8?B?dVExdEkrU3dmejFtL1ptNXRJYVo2d3Nlcm0rcUpMUkFRdFhhQmlTa1NlV1k4?=
 =?utf-8?B?b00zclFXc04wd3ZuU3Y0L1BPaVlXdWxUOGF0a3BVdVd4d0VHVENxRGlEMjV4?=
 =?utf-8?B?S3R3aHNsUHhjZkpBTnlqVDZWYzhvK2x3Mk5MVjVpcW00UGtGNFJVUFlwL0JY?=
 =?utf-8?B?aWVQNVRGMVBBTWtIL3JibTBGbkpSQk1GczcrOHY0YWZXeE9ZVG9XWDhEQW9j?=
 =?utf-8?B?T0N5TldOL2RtaWZHY241Vk44OXloY0cwc08vVkVmbSsxbk5ONGxlRE9VT2Jm?=
 =?utf-8?B?NGRsWEJnNkFiSnM4bXdlOGVadURKWjJiT3VOTHdOd2RFSUhoZkhhQm5iMVo4?=
 =?utf-8?B?REhZS3R3YUFlUHlFZVhyY1RZRWM4WS9LRmFJQmNWY3ZHQXBWL1pOeVJQSVQz?=
 =?utf-8?B?YU5MTjg0RzFscWRLSWdCSUpRVGV5eVVqTjNoamZlbENxVTkxNFR6ejdRR05z?=
 =?utf-8?B?dVBDK2dwczZxZFdOSnVDRmZHbkQ3S2pZMGQ4YkN0V0lrRjJxem1PRm1sU0pB?=
 =?utf-8?B?c0o1LzJxa2MzaEZQQlk3ZVY0STFVNk1GVy9aOUt1RXI0bVdrbjVHbU5xTmQ3?=
 =?utf-8?B?d0NMcFhsUU0rczV3NHV5VlpUMnZ5R1ZrcE5Dd3Y4Y1JKZldWaW55OTRwT09G?=
 =?utf-8?B?cWpHSmdMVjIvYmtlcXE2TTNjYmhpNU93dXZUTlZOWGRNNGE4VlMwSW55OGZi?=
 =?utf-8?B?MTBOaWo1UElNL1pLYS9GdjNXMnZHeld0WEF4bys3U2RCTkdLWnpSZHFHdG9R?=
 =?utf-8?B?eTB0a3loZ0tZa0paKzdIOFJVcytCei9UR2dGME9mTklIUTdHbU9OZk1hWHBY?=
 =?utf-8?B?S3hDM1FIcFBlVkc2WlE1WnZWaUtyemhyZ3RIU00xS2I4QWE3SlNmd3FKeEJD?=
 =?utf-8?B?dzZ2Y1ZTOCtwQXAxTWtoSk9ZWEphTlhqWWxiNlpNMTZpNjlQdTFVakUvV09w?=
 =?utf-8?B?TG1INDNHZS90d3RxTk9wUHkzNkYvZnZ2bk1NZ3lkT3N4Z3dBS21XT2R6Um5E?=
 =?utf-8?B?MDJhZDFyM0xqUGp6WU1MOVBqbzVjRm1CVDczVVlmdFhXYnFQUVZQN0oxMlZ2?=
 =?utf-8?B?dTl0L01DMXlreTlWd3NQVktvWlJkTjdtMEhMU0E1dWhaS3MxMmsrdU50T0tT?=
 =?utf-8?Q?3zMNIwas3Y9n5xNwtBD+UONCt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e449d881-8721-4fac-304d-08dd15db1b87
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:48:16.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zSBVb0uOjWSAQZyOYU9vWAdx5tHLuwSK6stCoVPf53D5wwTBFyZDmhX2GfoePqFD9TD6mMqFApl4tJf9VWxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6724
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:48:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17362

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings two improvement for image reproducibility.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index abdf92af..1c868afc 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: a6171856de84da3deca1355da7aa9c09588e7ea2
+    commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
     layers:
       meta:
 
-- 
2.43.0

