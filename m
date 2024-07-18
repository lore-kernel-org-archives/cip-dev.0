Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD1C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:38:11 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.15224.1721309885255660182
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 06:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KH8WmBFY;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfJgh1rMSOHFaq50d2OJvQTYQQbG8+2FmKu6H64nAYdqPYXlBWQxTaFkXePRbMZL3krws1eVqeq836w5bhxF0yeaZ74Ez/tQCdQv/Cl99dIBldg4OXfX1LksGKHpMlH7IDM735SADBPdeVmGDN2+fdkFGvvFZn2EicPrYUEuUCp1XFcwLIWQtrJUBsVCoX3GGWbLhWPk60/Y7BJ1rzrw+wppdVfMuOL3zSzsmG7BbIFdMNmmhb0Uaw0eAcncR9V68gYBuEmY4wXFX79QH+mj5yMLeEbDQHvdhoYtMJyMxJx2kIJIQgs6eYvslJX6TWxliiUS+O0fWNw+1CJooM9DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqAtzdgicC9oJvh9By+pEk/ZE0/6RaIczc4ivdY9u8g=;
 b=qLC4kCT2P7jIkclYzYI+y3hs9Gpj8elvDf8hKNshPae4Ehf2PcWnixMp5QFqV4BX9i+hZAWqdg9REl/YDTmmSv7fSvXjCZBdX3EbaGQdjVx6fzkyQCmiCa8z5x+wUzVj64F0U0lKXgt4Ln1Iy55sOT2BmBMH/xB1zPBY+DhUou8Gs7SZi58sgY9W0dwe4oz69KYDW52wcscqs/N1rIcPE0gR8ZHWT1tS0ov0J4iLmaQu6dLAx9PnPVRE43zoOKdEAe/nDlqbdK2WevjpSNYTUcarihgm0NWU6ntUx1di4AITxs3AEwA6htJfO4JZLnDw7bQ0v1sdi+reukWbjw/L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqAtzdgicC9oJvh9By+pEk/ZE0/6RaIczc4ivdY9u8g=;
 b=KH8WmBFY1ZxTKYxUqOuCKqsO0txxAqxIyndMFKHzutmmggGONPqRjpwXrrY9tJcWFsb2G6GoeI40Gu+kZTMBQiSj5/QDo1O+nAje9kIr/qO6DGatkAC2OVaWRykMpeIv0ZXGZ5L45gnMyxHshr4vLxGnbsFa1rDDN89a8PwJ02Bv9xtdKHtlPKEQPCnB+fNfuK2Uyfv0ZEX2qbcmlsfsDDKYUH8ZveETpFuCNslE1mTjCNhOfDNnDlk+wisobolHl8TAZXRy8v1G9O+zOJoy8OL5UEenWcJ3rBSOYObt0c3UrFT6n8zQMp1T3cSR9qJU3+AhhEPmMdYzwMJoa+sG8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 13:38:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 13:38:02 +0000
Message-ID: <bfb573b3-e1b8-47ff-99ed-33d9efbbd9fb@siemens.com>
Date: Thu, 18 Jul 2024 15:37:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip89-rt50
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:610:4d::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: a54710c0-ecb9-4cb7-6529-08dca72ed84d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M25NNDFxSDhxejlPeDNMUjVPeGloQlhZUllMeXltRlBJdzhWWk1jN0lCVWpC?=
 =?utf-8?B?V3g3OGlVYmFndG5JeDUvWTk3SGFneWs5WWx2THJlYWJna1h2MHFjc3FyTjRl?=
 =?utf-8?B?aEhqVWpUTEcvM1Nkb3VtK0NURzlRM1ROV1U1cDA3a05uU0FXODFIZ0w2S1Yx?=
 =?utf-8?B?cE9JL2FKWC94b3FPTzdlYlp0U0p0V3c5TVR1SHhxRlRNeStmMTZlL3krWmho?=
 =?utf-8?B?VUc4bmRQUndaMFhwamJUTXl3ZXBCcjZ0dk1hOUZmQ2FNY0h4MlFoc2JrRWlU?=
 =?utf-8?B?UExNWWIvc0FqNnlyUmZCYkxmdnJUTXVvbXc5bVN5Y0EyMVNqOFRPUXVUYzNF?=
 =?utf-8?B?Y2w2YmpXSXFmSWcxUzBwZW5EUFc4cUdxNU0wWGFMQnBOeWYrZkg0WGlEaEFa?=
 =?utf-8?B?TXF6REZKSXVqTFFmMWJoeGs2N0hVcUdkelpCU1IxTWxIRmxObVBGaXlXenpr?=
 =?utf-8?B?NmF5bzBDcE1HTUZSY3VFY0U0TzllSGxNb0RrVTQxcGlQVFdneUFmeEsxZy9S?=
 =?utf-8?B?azd6RTFISW1wV2lxbkZMN2JiOWhpMzZhei9oVlpTZXBFektFTlBPSTJIZTZ1?=
 =?utf-8?B?L29pOWRrYUl2Mmt1TXdrZi9DUUdXWnNnMmxyb3J4bTQ2MHpYcGp5WUkwT3cy?=
 =?utf-8?B?R1hwTmcxWFkwNWxPRDdTZG5lbHZKQmQraEp6NGUvM1F1dWRYeE1ha3FsSWd3?=
 =?utf-8?B?emo4VXAxQng2MlFFU1YxTmpXSnpqckR3THQxMWE1WWdVSVhDSkRHcHNWejl6?=
 =?utf-8?B?N01jV3NLWnIwSGtiMGxBZEFJZWZxMEJFelB1QW9WdjJSY21ubnl0UXZGOFJV?=
 =?utf-8?B?b3BFWTcvV04rZkR6UktJem9TMkpmRmkya25FSGx4OENHUTNqY0JkcFR4MmMr?=
 =?utf-8?B?dGJ3WERSVWhsZlc5U1RGangwNGx1d1hFSW93Y2dMV2E1MHV5SjdHRmtTMUV6?=
 =?utf-8?B?UVpEcDQxOGhxaldiM1JRWWY4SlJZUGkzNGhyY25YcDdoZ2pGblErbEc1Tmg0?=
 =?utf-8?B?NkYxNkRLWVV1VmlJR3BhSmU2cEorTVYzaXByVnZsOUdEcmhLZ3RoTU5KelJC?=
 =?utf-8?B?ZVJKMlMyOXNWVUM2TXorbmorV09GWG5hbkxqbW1zdndJZGoydWRzdjlLMk9r?=
 =?utf-8?B?VjFHT0d3enliZGJMRG9GcVlYTU5HdGtEV09OekZnY0NJeHdOc3NpRGxvdHho?=
 =?utf-8?B?VUJOdmNVZC90YVNqSFl5b1pvc1J0NXM4ZUtRQ212ZTRJVTBtcVNoNitMZXBa?=
 =?utf-8?B?RTlXUExweklDNk1vbFJZNGdZYlIrTFl5b0pKREM1Q1lHem84a2MwTXZZQURh?=
 =?utf-8?B?Y1pqaGVyamFtODBZcFdBTE5zUVBsSEF2QUtSWWJjTmk3ZVlVc3UvS2RUanZQ?=
 =?utf-8?B?ZEZ0RUs5ZlV3SkREZ0RrR2cydnk3TlpnS1BXU2RqYlhJRVE0enJoQ2Z1UDht?=
 =?utf-8?B?TU1IU2lPVGdUaEdTbnlXR3ovRFI4NHRJZkxnRVNlTFgwR2ZGYVEyZG14dU1r?=
 =?utf-8?B?bm9HQ0JTcEpQOGxEbnlHdXRrRUx4RjNOdGR3Nk9kWGNLaGZLY1A0WWtEMzQ3?=
 =?utf-8?B?UjNIMDdRZkExZ3k0L2FHbVBWcnpEZ254Mi94U0dHdnJvRWhyeng2SUQyZUdI?=
 =?utf-8?B?MDFRdk42a0lsYmhHblNDeWVsS1pCNndOUHRFa3ZRai8rZUxhR2dqZGpVQndX?=
 =?utf-8?B?cnJtNDU0QnAzd2ZoSHIvdmZHam9vb0J1QWFpVkNwUXBrMEFyNW4yS0hOQmJq?=
 =?utf-8?B?OXhSMUp0aEF6ZTBRL0JXQUtaNWVIVnh1N3hnL0NNaU9KQndRb0k0MGRPSERW?=
 =?utf-8?B?VWQ2MWozL1hLb2pOTExSZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDVzQ0xGTWR3cm5MVFdhNVdEcFEwa2Ivb0tBalVHdWh3RXdjcmZEVW8weStC?=
 =?utf-8?B?cjNDL2VtSDdEL3MraVlsV1NZQ1JNblR5dklmdHFjREtsUkNvd3haZ001bWlQ?=
 =?utf-8?B?R3ZBcm1PTDJ4STNHQlgyMHVUeGpPb2xNNTc1NW45dmdTdnpWdjFxcHQ2Ym5D?=
 =?utf-8?B?MVU2SlJaZW5hTkhDZjNMSEM3bHMxN0pVVGNMblgxL0NLZ1FCK3YrMXRMelVi?=
 =?utf-8?B?WTY1c3ZlemU3ZHVNWlA2cnMxdnFTOU11T0hMQ1ZlY3p2elpsbklMbTlzcjBH?=
 =?utf-8?B?MFB0OFdoY2tCUEZYVGpoRjZ5ajZjWmM0SFo1aTdvd3A2VFpTTFJ1QmNLdHh0?=
 =?utf-8?B?em83RmFEVHV1TmIwSmRzV2VtSXIrbVRDY0tZenVNRTV1ZEJ6YmEwVmtWYkll?=
 =?utf-8?B?a0N2QVdITDBwbHgwcnFMTE13Zkt1VWJKRUkwcDd2TDhtb3YzVnFRUVBWV2VT?=
 =?utf-8?B?bTJTVEs4Z2ZhcE5RS3JFS1BhQitnSERxQmVQd28rSXgyLyttRU4wMHlDUGw2?=
 =?utf-8?B?eCt6K08rb2pjc0E1WWFKMUd1V2pXSllYaUN3a0JzMlkxV00rRmdvUU1ib3Qz?=
 =?utf-8?B?a0VqUlBtOE9nRGh1WnJyUG1jajNWcThBV3pOYWIvdDYybVE3RW02ZnpKOHUx?=
 =?utf-8?B?cWZYM1ZlYmdEU2xWVG9xYkZHWDR4VGpEMHk4MGN1eVNZTENPQkxRRUJOd2pV?=
 =?utf-8?B?a0oyLzQzNWJaK2twZ1V3TDhwWGR1YlBMdFVsa2ZSSEVWTnNnM3J6U0MvOTQw?=
 =?utf-8?B?VWtjaHRxOHpueDF1OWNwMGl1MWh6ZTdndE9vb2p0N1hpSHdxTlZlb25DNFZC?=
 =?utf-8?B?bkhQUmtmUURGNGVmUU9KQ2pwSHRGeFpZL1Z2Nm00bzd4em1sYzRkc0drZ2Mr?=
 =?utf-8?B?cUN4NXY0S3hqOUJJb29rMzkvQWwweGZNYTNFbHR0WFM3Sm45K1FsL3N0aGE5?=
 =?utf-8?B?aSt1WGtKQWk1c1k0bXBPM2RTMFlSZFRXMysyR21pNmRlQnhuWjhwT2Y2eXB5?=
 =?utf-8?B?aGI2K3oxN1E3UE9ROEJoWEdJaGR0d0ptTVgvendFVTMwZ241S2krSytIbTE0?=
 =?utf-8?B?eldwOFkwN3N3NWg5STExRFdmQVpRNFRXUHVlWnpDOE1kMWU4YStCL3RhRHNX?=
 =?utf-8?B?ZjBVMVRuaDdyR2xSRnVUeGFzaExINTVheHI2UVJ0ek4zYnpyK1poRzBrVUVE?=
 =?utf-8?B?eWwxZ2l1RnhZODliQWx0SG1Td09kaU1hS2FkeWpkcUJVaHlGL0szbFhvSm83?=
 =?utf-8?B?cU15NW0yaklpVFgrcUxwT2ZHVHpmQWc2TXpaVU9nbTRiQmN4Nk9Qa2Zhc0hu?=
 =?utf-8?B?eUtLc2F5Sm1lTkN6cmM2ZW8wS1oyMzQxM0ZrV3VUYmFwcndTcDNQNGxPOXJ0?=
 =?utf-8?B?RnRaUHdHaFJ5M01XWFRoQVIxRWFGZGJXYXhFQWlaS0JCYXpMV2crcFlZVWMr?=
 =?utf-8?B?Q3k1WU9Kd2FjNE10c2xFelpNQ2d2amY5c2czcDQxWWlaNU1weGxhbHlQZ2FF?=
 =?utf-8?B?RGFQcmsvL05lRndqSTV1V2ZLY3FIQkdVNW1Xa2RJV1VjVFZzYklCVGpwbkZn?=
 =?utf-8?B?YTdKMjE5bVVybERoVEY2d2R1azNIZnlNS0xrWGdUdUNOM1V6TXJ5NldaRU1D?=
 =?utf-8?B?bGoyazl4MWZxeUhmNTRUUk5HQTgvY1dWOVVCdWIrK0RIcFpIOVVHWDFQSXJK?=
 =?utf-8?B?NURjVlhWZ2RKQTZDZWN1UUJLV3hSMm5rdWpDSjB0ano1Y2tXQ2lKSmRUangz?=
 =?utf-8?B?SkV3bUlydlZ3ODBFNFFNdWV5Z2c4bXlVN1kyYXp3NzFsU0ZKOHdkMVRKMXEv?=
 =?utf-8?B?c2p1K0h3US9ZYVFsZWRxS0Z3OW9aRGZJS0I4Mjh2anE2MmhGRjBuSnYzUURY?=
 =?utf-8?B?QkF0S0Z2VC9Zall5WmlBak1laWRuR0ZOcDc2aE1tWUhWaXZYZVIzVjRCUUhY?=
 =?utf-8?B?OU9ySWZZTkhSUmtBOEJHUWpQTENLR2puKzVpcksvK1Z4K0RUVyt2ZnlLUnZP?=
 =?utf-8?B?MUQyOCt3eThsVTBrd3FwaWk4d3lUZE1XQ0hCcjZsMkJCMzRqeWlUM2xjQmJ5?=
 =?utf-8?B?RjdOQy92ZlkwbEJOVWVtL1A4eExmS2pTY1FyWkl1SVdIaTB3NVFtalNLL2xv?=
 =?utf-8?B?ZWZaRC9tc3ZzN1RBL2RQRDJZYVdmQmU1WXpPUEVjajBWemU1elIvL3ZVWUdo?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54710c0-ecb9-4cb7-6529-08dca72ed84d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 13:38:02.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNss0V59YSf0j7SOIi2RTKS12OwcPqu1SeppxoQdtZFses8m3J7b6LnTaL/85yDg4Z4Kt7k63LoOd/sypqr6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 13:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16590

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip87-rt49.bb => linux-cip-rt_4.4.302-cip89-rt50.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip87-rt49.bb => linux-cip-rt_4.4.302-cip89-rt50.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb
index d3a8708f..8b0df6a7 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "13309301a5d85f829f4b1736d9ab3137fb191da1dd7e1c80630764cb7be59c21"
+SRC_URI[sha256sum] = "ee387b5e7b71cceeb8a53af17d45b58c2334b451400d3a7f12ecec9be06c1cf4"
-- 
2.43.0

