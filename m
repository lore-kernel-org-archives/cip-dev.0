Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B85BD637A3
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 17:32:53 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web10.17706.1731519170498604332
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 09:32:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iF2nz45c;
 spf=pass (domain: siemens.com, ip: 40.107.20.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEyRf4cnfilnIGL0Sl7mfSe0N6obqO9M7UaRSwcAjIgKTY9AQChI56ETcZq7P+yJt94eghXhSLfw+5jg9dwNli31yVyEdJ18N/vI4WKvfd2GLQ5NW+uY0QAL7GXgsjPbnOCss/FUOiQaDN0hp+9ad+MZ3P6cE95s1dhIomtAucZYXLCwwZDGKhvfir7gDs+Z5GPvzH69vv9R3knjRhDe/ebHB5rruJwYnznMl+jDvf/Mz2omxY0R0q4IgkdMLA2HBYI2MTzLsuWsgsMUm+dqSLkZXl/h8Okq/tIPimfUYmKqm+pG9GkVeKXKxvLH+vMMg9k84/FJ6iLNfJNiEB2ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zftvFEn+/bTfzuD6IEr8Vw/SS51An7Ec4jL/a9bITtM=;
 b=UE7rTtakMMw76CN2VQilMP3kZLFah/t8O/CQQyTEhX52NiU/3YbugGeq3Mwk7/ue2o6i/xLjySiH3xv8olOPWMnrcKLVxhcrvPHSMSObnwix1pr44CcloK7k4r8MTQ5wF355P43Aq8KjYLbvoUMLYKOyMqZgOUu75LUostWPDX+PpVy1CFEeSOKqy8iguTNOvWl99NkTWMurkxfvv8uKOP+nrk4JBh04Wc53qM4Ua0YMF+h/koov+WjZt8ymFFCXbhQs1EUE7p9uS3cEO0BRKFDSVcXLQ/XbDGJXY5zVPD3fs6O/UF2j13iZZAhXuCiI/Kg7s0jI+hda3HtTkc48EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zftvFEn+/bTfzuD6IEr8Vw/SS51An7Ec4jL/a9bITtM=;
 b=iF2nz45cWIDjD2PiwA6EpUx8M02q8+r2mWIhRcne4/mpWLr5pXEnxk5fFgo1h3y4ob9yEgBraYrzw7rFZAgEE3EResfTl3XjbeTwvn55sNNTxZegjLOeY8gyRYRaZk7UxNVpngFRtNNagl2WoQZvBKAjNfTjbWv92uB1pWTGSFQk8s38lc3GjW8LCJ+G3aNk6LhdaXh+90/QeJJAHOeWghHiUmrsTAu5jFMMVb87eA2R9BwIhbzYoz741i15qdI0M2xhloQX7f6W4u7fBq3gGqhdmJVRavWd8usmtbQWe9YyIwdUbhsRCztz6IMV1lRYmYA1JjD/klP1vL9Cnq9d5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Wed, 13 Nov
 2024 17:32:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 17:32:47 +0000
Message-ID: <d7439eb6-1bdd-417b-9497-66ce904cfed8@siemens.com>
Date: Wed, 13 Nov 2024 18:32:43 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: a62f765a-7d3d-4954-0b83-08dd0409307d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OFNZbDJTR240R2tzN3Juem9LVXk2WXBmZ3NmR0w4SjRZWld1MVFid09uK0dI?=
 =?utf-8?B?UGRRMnh2ZUtuVDc5bDZOQlVMbnI0cnRHVjV3bkFCampGYzg1OHBSajRZM3ZB?=
 =?utf-8?B?Wm40dlYyeWltRHJIaG9COW1XV0RvQnIzWHM1U0NvcnpDeWtVSVd2ODhvM0tB?=
 =?utf-8?B?RUJkMU5tU0dKczJ4d21iZUoxK2ltY3VvdXBuVTkrTm1DZ1hORW9vUzdJdTFL?=
 =?utf-8?B?S1lLL3VnbkJzQ3Nla01ESjhXbHhlYjVUZWFwNHpCc04zUHpMOE1LS2toLy9l?=
 =?utf-8?B?Wk5JdDZlQmtCVFBxU1k2NEV5Z2xiczNJUm4xU29yMmhWMFQrMlBCUitsVXNN?=
 =?utf-8?B?L2ppNjloRFNQclpwdDB2VTQwMGt4OUFQWmx3WnNXYy9sSk9XS3FnbloxMURR?=
 =?utf-8?B?MmVvWFp2Z1pJd3p0NktlZWcxN2NlUmJMNE1pNzBnMXdwbGQ1RHZnTjBMN0Rn?=
 =?utf-8?B?d3hTN0YzdzNpblMwekwvVlZkVGs2WGM1Q3BVQlgySUpScHRJVkJFeEFleEcx?=
 =?utf-8?B?VTVYVGFJVzlkaG5LRzdiaUl4U3hKbXNHR1grdXZPZkh2Vm9Zc0ZMSmNvRVJo?=
 =?utf-8?B?Y2FFWDdCSnNyZjlQOWR2RDBUUWx4SDVUTmZtbk52cXo5a3lRVXp1aWVGaUtQ?=
 =?utf-8?B?Z1pOajVrbDRMc1loUHN3MUhRdlYyczU2Z1NJSWtLeFlYVXQ0aDJLcjcwZXRE?=
 =?utf-8?B?bEdFWVFsNFl4M3crZXdYTytnT1Z5N2R5ZmpQeUp1aVRqWnlHckhNUTBES09r?=
 =?utf-8?B?eHhsbnNodHBJV2MzU0J1b3hkdlYvZTJaWElDRE9vTnoyOXduNmFMbTYwUzJa?=
 =?utf-8?B?QUtWQXZCWjRsdzNhYmg5ZnR3T3ZhRnZDVmRVK1FNMC9rUWFHZUxGK01JY1E4?=
 =?utf-8?B?am44TTlYL1JlMmxva0lmaHhQZkYzUC80aitMNWNJOE5jSXVqZXFrWW1uRmxN?=
 =?utf-8?B?d1JGd25pUkE5NmpmNGVaVW13c3I1MzJSNDFEN3ZzM0x4U1lndVI4MjJybUZJ?=
 =?utf-8?B?cTEyaWU2Z2RrUERMSTloL0VQRGRxWlFDdEtBaERMemhac2p4ZmdZWEs1Y3BP?=
 =?utf-8?B?aEdyM0RRSHlxVjNJazV0cFRmdWJCSlpQTzhEWGltMWZHamJHWnBYcTk4SnVX?=
 =?utf-8?B?a2haN0Q2WUdpK1pxVFl4NzhnbXZja0NST25ZcFYrQmVuVS80QW5MQitqMjhE?=
 =?utf-8?B?UkhKa1NhM2tnOXJlRHM2TUcwMnZpR1BIYnl3eXBWeFlMeDhuajRRRW0yWWp1?=
 =?utf-8?B?djJWZDkrdVViTFN3VlR2R1ROb29xMEw0WFhWUmZ4VkRmZzA5NGlGVkZGckRK?=
 =?utf-8?B?T3NiUCswTTZWV2svaTVMeEZmanRsRGJ4eGZUSE5DSjU0TGNnRHlFdW02OXpy?=
 =?utf-8?B?S1JTOFh4SjRVeXRGY3RkTXlvNDhCM2FydDNzckFaKzNUUHdIc0hhR205YmFj?=
 =?utf-8?B?RVoxQjR2a1pJUkZBWFh1TTZJSklWdHFRSmFqNVBmVVpHQkFYaVU0ME5rdGxP?=
 =?utf-8?B?OHl3SXhPMW5xQytPSVc2ZWJEQ3NsQWxMNWZiRzhnTTVaRGhqZFRoelUrOTVv?=
 =?utf-8?B?V3pNRmthem83cTNmN2pXZXBJUm4xSjdQRDFXUnhDN1ZxTmhLQmo4YlNkT1Jk?=
 =?utf-8?B?ZHRoVnZsUFJuN1M5ZjRhcnRlbVlHLzJVeXl0NE15Q0VoSUZPNTVXMWZUL3cz?=
 =?utf-8?Q?m+ZjIIqCQj7EFSIqKB2J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VitHcitXOFRPU2lZT0tXeVNUemJSbFRqclZtY1IzSnB3QU9HaUVDM09adDdr?=
 =?utf-8?B?LzJnMzJxd2k3eEhWVytwbkpKbU96R2ZKODdwWGtIa2gwWGlvZUlPN3FFR0JW?=
 =?utf-8?B?Z21HSTVSQmJaR0NWZkwyalBnTVI3bnVndzVIdWIrRlhheDlMQzRuMWc1dFg1?=
 =?utf-8?B?MW1hajkwN2x5cmgrMVlQcVcyK2txVVRSUVlVK1dvTExNeDh1alpNa1FaelN6?=
 =?utf-8?B?NHdtUm43RmJ5ZitWT0JlQ3JINmVlV0F6ZDhtcHRweVFIRHBQV2dNUkltcjJL?=
 =?utf-8?B?MW1FM3JLQ0tNK3JKc1FJK0k1UW1TUEwvNDlHSHBRVlRzcFNUYW5pUk9POHhQ?=
 =?utf-8?B?SVVIVHI5WHFjTTgwNk0xNHpGMm91Zit2QkZ2YnFFS3gxRFJGTU0zVnN4dDRS?=
 =?utf-8?B?dkRkeExWRFdXc1poL1VnN2pTUnRwRUYrZTkwSDV2WXA4QWxjVzVlZ0VlMnRx?=
 =?utf-8?B?cGZ1U1hjb3ZpVTkvNUNZYkFRQ0hnaitqK3BRQ3YzcVFOQ0RxcUpESUJsNXFi?=
 =?utf-8?B?cENUSzU5ZE4xQmlrbVQ5aGtFdk4zNXhHdnpuMFoxT1JHWFlVYUtaQkhPVWx6?=
 =?utf-8?B?S0tzK0pQMGptTHVxSHR4S0QrSlNqYmlPcFdyVEROTUp1dkZLOCtPNWpHKzNw?=
 =?utf-8?B?dzZYaHlnckRIb0JrenRqdFBRczNVd081bys3R1I1bTZkYy9TYS9BSVlvbEJC?=
 =?utf-8?B?bVJxTUt6dnZzNXlRYWs1dm9mRjJqY0FWOXIxVGdRa3h2cG1VZHpZQlpsTXZV?=
 =?utf-8?B?WlV5SEoyVEFZbnhMMDdDdjNoelNHOGdvWmJVWFBRalgrUWE2Nm1KOThsbzRI?=
 =?utf-8?B?OG5FWXhnTXVCbGFYUkVqSGs5T2VCcGdoNnRySlVVdjM5cUt1bGl6U0E5N1Qy?=
 =?utf-8?B?d29rc1lwMnlWM2pwdVZVU1dQNHp6VExWQThKYXJwbUF0MCtGRG4yMXBwV0Fj?=
 =?utf-8?B?d1FlUVpVWE42b0FYQVJGY2wrZndVVngvUk11WndBNVUrck1xQm5TTTJ2bTBF?=
 =?utf-8?B?c1gwT3ArZm8ybXBaZEtYdzM4WWVIL05rcVBuTm5LOGxNdXlZd3pDVkVMMVIw?=
 =?utf-8?B?OVljMmg0TjIyb0M3ZXVWaVZSY2owWVRQZGtCNjRqdUNSYXdLSnZXM0FQQ1hT?=
 =?utf-8?B?L2p6VDdJZGE5enZrMWd3SUx5NzlQWkd5SEoxNEJERFJuMnhQQ3RLQlB1RGp2?=
 =?utf-8?B?c3J2dUE3KzlwS2U5aXdUaTg2OUpNZk9BS3J0N1JRUWFRZVJvdjBWWFdRVDhU?=
 =?utf-8?B?NDYzTDFvVWdDYzhkbEdhK3pyaUhjeUJJY3RGYyt0c0lDV3ZFSDdRa2xiVDRt?=
 =?utf-8?B?K0tPNGV6bVQ1Qmd6d3hPTmxqUGtncTQzZjczRGtYYWRPWW55OUpWZ1ZxR0pH?=
 =?utf-8?B?UUZVQW0vMlFCYXk1cDFmeTYyaEV5VFB0eDdZSW51K1ZhK0RQcTlIVXFYVjcr?=
 =?utf-8?B?OTlmN09KNkZ0THBiakZqQVAvM3BNKzI3VkdXZmN6UWc5cERwRWoyR0dQcWhJ?=
 =?utf-8?B?emV5elJET20zNVZiSkFOSlBKRC9neC9FeHZpbzU1Zk9hMll0UzlTK2JRSjVl?=
 =?utf-8?B?anY3RXJGNUxYOGgwQjNCcHpqZHBLU2VlejhqNHhNOEJrd2tSYnM0Um5wOTRN?=
 =?utf-8?B?RmMyc0U0ZDB4RnppMnBxU2xEU28yTGpISWVaYVhrYjVBK0pNV3pTT2J3ZGVI?=
 =?utf-8?B?NDFPZHYxODlYYit3TUMweFVPVlk0MzVQb25lWDBoYUlzcmpITGVzZTVMeWUx?=
 =?utf-8?B?WldiL3k0cndvOWxPQTdzeHFrVEJnVGNKWWVPVGVwY0xUaStlVmc2MllnWmsy?=
 =?utf-8?B?UGxFaGFPcWVTaHF2WGpQSVBqVVRKUmpUcUFKRmtSRGFnOS80MlNCTHpNemgv?=
 =?utf-8?B?OWtJQmFVcGxZaWFCcFJvbllZSk1LQ090bGh0c1VvaGJaZ0htMVBrT0ZjSWcv?=
 =?utf-8?B?UjRJcEhmS3VJUEZUZ1pNcjJ2Q0wyQTZYbFRSVzRHQzJhdm5IRWVsdWVBVDRO?=
 =?utf-8?B?U21ZMjdneXF4amN3eHVHMHdMRzFJSXBSRTJNd2crUHlHK1B5QUZlaGs4WlBm?=
 =?utf-8?B?SUdveFFTaGQyK25RRGpObVNKVUNKUnpsb1NWSzhsakNGUG5la2pmRDFXNUpB?=
 =?utf-8?B?bUEvdzVRekhVZUYrS3VjYmFaUXFldXR6SmdlVHU0NG8wYXB6OUVRUVdzZnNa?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f765a-7d3d-4954-0b83-08dd0409307d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:32:47.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGlGlAV0RCdg0t3nLLOjnxM6sChoXdknSckdbgnRfoPqogrn9unnkU+Fi8LU2cXq2MQ68lMOgFVp05k80gSraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5620
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 17:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17248

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings a workaround for building against snapshot.d.o more reliably
again.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index fcdb10c4..6c83a0d3 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 57f6b70d91711075fbeb07dd2bdf5c9e5b3c6ee6
+    commit: b92e9076e27bf22b8296dd3440bf25ebf348e2c6
     layers:
       meta:
 
-- 
2.43.0

