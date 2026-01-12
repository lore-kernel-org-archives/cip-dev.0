Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863DCC9EC8E
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:22:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32726.1768224127242668641
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 05:22:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ShzbjI4r;
 spf=pass (domain: siemens.com, ip: 52.101.72.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aviA5oLsTjwq4nV7WjYkO0BQtgkkiuDmnqvxJwGNFeT7mcSQ1aUqZhICWb47oH0z4JBctlGiFGFf3ZWej+3DRZkAeiKhNiDVBnzYCr4ae7X1dJyzoQ0rT0lUV2UiYLjWwUZFgQcfGd4sT1NBtBT8MPYVxBfKeLBCUVZ8Ga40aVVgjsdtDDvQKPydpaVdYfXJpMeoal6M6XArQWYICcYr0m1oWzoFXYpMECw3okfJAiS2M4v6C4x9ZbZ3s9x5BweWgEkp9RPyDmaabWxXrfvLCFTqY/+YNpxBSBvR9wBOrevKMwfVNtuJLQoMbz7/xf0j6Q6Tgfey40W/I2bdzYDlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeMytEXhYPxZl9D5Gf5NDch4j/2iuTFAvwWrsWMiz8U=;
 b=T5YSvu214AInB/p1lYVJFd2C2SevxZTKENLlw/+rYhkbQ2BkFBycWJqPPFOfcysqJ54ro7nlPkFsTSfKVcFoq37spl+1O1BN6Z/VXC7CJZnx0q6a3vp+FaisZZN4WMCm7EoKm0A5dFeewxCk4HPGxlfy2mFcbbRqLQKe4gNZe62bUdCDxYrZd2eHm8oB0khBm27ieI5fCJb0hyf1x8sQG+zVrymX+d/jke+gd+7A5rZ6u47n7s+PsJxYG+3VXuRguoaTHHzecz0VDJugDecuXhUI+3BkjAm1g0yRroU3+5LNMizhVQLhsceO4c4cYDriWBJqfs7H5/nk3zGaJbXQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeMytEXhYPxZl9D5Gf5NDch4j/2iuTFAvwWrsWMiz8U=;
 b=ShzbjI4rBGIBSwTSx6ODHXBKXorFs2VrqOEfk2osv5o6x9f810d0FJkVr9YQZMN1h9LtAzOdYHB06vj6M72EIYjuqtPmTbMemQNLiiEESn2YNKQs4eNAfKIe2muDfvPPA41RvtED1WqYVvRwEYd/BpxXYZJgYCZWAjeQui1NheHychD0Qtjxcd1qCIH4/WB0ezADQEA0VRPnkh7RVWR4NOqDxPciq1lw4kVYvYjd6ecgLPjhGPkat5LKUYv+r0ZGEHrIhiTRrNYtj+tLFCaYpZDli9qFSlH+lycQCnLONG1cdeMm8O+BVfahdZhXsckAZ6Wm3AlGRNFepOeQAw/pqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:22:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:22:02 +0000
Message-ID: <036d9b45-4225-4ea8-825b-e40780c1affe@siemens.com>
Date: Mon, 12 Jan 2026 14:22:01 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ltp: Fix build with latest Debian
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7f7d31-85d8-468a-3463-08de51dd92cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEFGZ3dDSnBYTVNXcUpCcEsxQ1phOGUyaENzenl5dkhhcjB3OFdPNU1XVEVN?=
 =?utf-8?B?ZDJBUG5KdTRkd3RQNWhDZmpHVXVpRVB2Zk5XS3RxeXR2cTlGME0xSTlQM3lC?=
 =?utf-8?B?WXB3RFNSVytxemxQbEZVWEFGMndsQng3b1kwTndXYUtWamNyaFFwd2dMVVBZ?=
 =?utf-8?B?QVJsRG0wLzZoT25IN3NPdDVEdStjQXV2T1pYb0RRT09NVDkvU2tOc1daTVlq?=
 =?utf-8?B?UXNTNnluN0orRjNRNnVnNDBGaTB0eG5sU3dYMHBzV0xyU3NJd1ZOWUFXbGUr?=
 =?utf-8?B?LzNYbFZaSWhaYUg4YWFJa1pTcGRWZndPY2twZUpxSzdSNUd5cDF5V01XRU1B?=
 =?utf-8?B?WXFjcnlFYjlBRTVDNVpvdHY1bUV0Wk1zVngxQ3NyUUN2TXBpQWg1alV5R3h1?=
 =?utf-8?B?TGo5T2c3QlN3cFVmS3c2TmdvclVKOTV2NGtmbkQvUWdPTkovZzZlbWY4MGdY?=
 =?utf-8?B?ck5JWTVZdFIzMHJuclV6N2hkbTMzR1VINitQMTVLUXhHb0FjcHlRMGdSQzU0?=
 =?utf-8?B?bjJoQVdxL1ZwSmFDV0hnbDRONld3RG41Z0VGYXBxSXBMUzlmZjRpQjN2KzJO?=
 =?utf-8?B?bENlQTR5OWxPTHZaWXhvbzVLWnNzcVVsT2tseEJLQmpMaWNqY1NRWXU5MjNO?=
 =?utf-8?B?N1kzdkt3Rk91bS9Uc2c1c0o3OUFJbE5YQmlzaXhEQ1RMM01pMzM3RklxNitD?=
 =?utf-8?B?T3A3Rm5WMUtEdjd0YWN6NFE0SDlBVEx2enREaHMzNkN3M0RONzJrQ0MzWjI4?=
 =?utf-8?B?YnV4cEFTRWRhci9UNThnYjd0R3dENXlYOTY5ZVVKK2Y0K0VyRnpROHlWZDBD?=
 =?utf-8?B?cjhqRFUwekd2SHphRFFFaGg4ckM5cE0rVFZZOWMyeFFvblFUWDhLWVdhYk9H?=
 =?utf-8?B?Y3U0STh2Y3FpN1M4SjFoSmtpcHJ1NFZGMitSbWdTdkxWeEwyZDZmQWczZUdt?=
 =?utf-8?B?MzJNZ0ZGdzk0UzR6N1p5VUh6aCtWYmhsODNDZ2h4YUNKZjhsN1JQUnJLbmZl?=
 =?utf-8?B?ZGVRNVRvcENiVzFLUElqRkl5M0d6anRvNC9wNklGenNJZEpReFlCV2J1aCt6?=
 =?utf-8?B?SnlmOVUvN1pseDE0WkJTK0VtK1pSODNOY0tYM2Vwems0aVNsYjVaMzJKY24x?=
 =?utf-8?B?RnhqWG1TVnRRRmZyNmJsKzdYdWR5Wlk4VnIvRWJ2MURvaHIvcStqR0FFLzFK?=
 =?utf-8?B?QmF3N2RISXRXRGlGSE9ySXd0VWx4d0hVRTJmWHNJSUZCL2VHNS9PMnMvNXFz?=
 =?utf-8?B?R0JTVkY5TXpUWjU2ZnpaWlpTc3dEbHJ2NVdxYjN0Nzk5Qm1NajZ3S3dsQXlQ?=
 =?utf-8?B?d1Y5ODNBNzdsY1p2RytyWXhIWW9OZ2lJU1NERkFZeEtVcWU2ODRZNEdmVExt?=
 =?utf-8?B?NFM0alo4dXNRdHRhNFlOdjJaWjgySXlEdTJEUnkxeGNzS25yREpzTUVxbkxv?=
 =?utf-8?B?emloNU1IRlI1VzdLNU0ycnMvUXJDeHdqZE11dzdWSWRQMHBhMWRCcDlvQlIx?=
 =?utf-8?B?M0tQSkI0bzIwSXIwWVhpRG43WHRMN3drSGZ5SFRwd3FOaDgvZDBHb014a3RH?=
 =?utf-8?B?QUx6aG5yNC9maHFvNncrbFBFQmhta1UvNEJUTGhEMjc2MmllUTBiSWtrQWt4?=
 =?utf-8?B?bEhrVWVRVjgzakFFSUJzczBvYUd5bGNJQVRVUDMrWnFZenFZZ0NFSDN2cmNV?=
 =?utf-8?B?TWFIaExROG5jNUhKZDJwNDlKUVJlMFFvbjg5QnNiMVVHYStmaG8xTDVGaWpT?=
 =?utf-8?B?ZFUxTHNJRytZbjg2a1ZZdDdTLy9yNnB6WVdYV1pWTUdDY3ZLbzBGaHY2RWtL?=
 =?utf-8?B?V1pFTjRCa0ZYVXluNyt2TDUwVE03cHFhQUlFQWkxcTRDUTh4S1BqYjRrS2VB?=
 =?utf-8?B?blpwYm5EU21yL1o2UWFOSHRYbS93SXdZWkFkckZvRW5sR2hUaUZ5c25mT2ln?=
 =?utf-8?B?VkdrZGc2bzBjMmpYTXpzUjBqYUpyMnc2NytjeHo1eTdmcDlHTGVmcG9uOGRj?=
 =?utf-8?B?MGdydE1SVXJRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3E2UHhLNnI0VHlnTkhjbFF2OE5VVDBBT0NTLzZjMDBzaDZHTTFKcFlDdE8v?=
 =?utf-8?B?V010cWZ6QVRTUGgwSHh5Rjl6Q21uUmk3NU5jczc1cjNoTXY2aG42eGJnNCtU?=
 =?utf-8?B?TVVVb3J3anpEdkRFejJ3VUJkdW9BNEZjQ2ZuN2hTK1RhOWVxZi9ubEVwSjZX?=
 =?utf-8?B?RERqTXQ1RGlPcFB0QjhmK09jZEw4Slp5MGdRT0I4a0hGRkYwaG43bTlzRmJs?=
 =?utf-8?B?Q0FabERpRlRYL2paRnVLRVdZeDd2SWhnVGIwMytoUk1vRlU0WkhtblhwUjkx?=
 =?utf-8?B?RGd4NWJIWjlqUXhSVS95TE5HbUV4QjVxcGJSdGJzVjljSlFrNldGbWtPOC9p?=
 =?utf-8?B?L08rMC9uV3BXaE1WZmp2TllDNXJCUlpKdzZ5VFFvQlIyZTlmM2NldVU1N2VR?=
 =?utf-8?B?U2tMaVkrMmdtUndNKzM5WURBOTJIeFBBVWt1Z0w5TE51V3VHM3c5UG1nRGZz?=
 =?utf-8?B?SmRwdWd3dHFzY1lwd0tXVjRnbDJTUVVTNndsQnRBaXhFbzFmQjNlQkNRYUpB?=
 =?utf-8?B?clpMckh3aEplYks5VHh5TDE5MEpzNy94K3Noc3E3M29uMUhjNHBTaDlkVHZZ?=
 =?utf-8?B?Y3pNQ0pwelBIa3JGTFNwMXV5L1hRSDlFT1lxOFg1clU1MnZHbjhOMWpaZUli?=
 =?utf-8?B?KzJmQnp6UExnaE1xekNWQ20zNUFEenFaaGt3bytSNVUxcEZDZVF6SUhvMDBB?=
 =?utf-8?B?eTZpRTFLblFEVU5xMlQ2N0xHMmh6TGI5ZVR2REx5VVNKbHphV21YM1pUUm5p?=
 =?utf-8?B?am5RZzJYKzltSGpoRHowdmlLRC8xS1h6MEtickdGR2VKNHV0Wjg4bXpVVi81?=
 =?utf-8?B?dVEvQ1gwZ0pXcVk1UFZXb25hVDZaYTdmTERpanpVMldhVW9iOStQcnYycy9U?=
 =?utf-8?B?YVZlOW1nWlRqbDRDbzg3RDNqVUd5Rnp2dkdLMjk1ZHFVUS9kbEg0MVFGY1FZ?=
 =?utf-8?B?LzZYL0tURVMwWlJmbERGN0VrcG9JekJ5MnFvMkR1VExzYnJ3bnkvODJuL3o1?=
 =?utf-8?B?clFtYUZzZU5Eb1MvUDFnbGx2aHVjZlgybndEUVJYQUpSZkxRMTNMOEhYbWZ5?=
 =?utf-8?B?OHBuNjF6YXR6MlJhZUE5VEFTT1ZmTFNPNEZlQmtSMmo4YytHdzNEdExvczND?=
 =?utf-8?B?RW5xV1lDTklZcXZRcFRYa1o4RkRiRFRhYUs3aGxGVmRONy9tdGFWUWlzN1JI?=
 =?utf-8?B?QTlmRjZLdndJNEVvNUUrR01ETlIrMis5aVpVOTArQUwvQnhybmFhcXlPUS9M?=
 =?utf-8?B?RkdyL25hTHRLdU44TExKbWlHTnNMY0ZpY2UrRWlMODAzSlFxL2tITXhPd2Rj?=
 =?utf-8?B?VHl2SnpCam5TTWJtRHAxbjM2WndaNThVSnNTZWxWT3pLK2lJajVRQ0Q2NTFp?=
 =?utf-8?B?MGIzWU1WN2k5SFRPc2ZnaUd1NVc5cjdZdHdpVEU5d29EUiswSktvOS9reEZ3?=
 =?utf-8?B?bWZvaVNDd1B4R3ZlMVArMzh2TWlvSm5KNUo1TktVK2FWTjg3ZGZ4aThEZm9C?=
 =?utf-8?B?SXlwU25FWFc2VEdxL01yNEVYbitNbFl6RFhpVjNjUCtISGlSNUt6SFZTQ0x2?=
 =?utf-8?B?RWVCOXV4K2pEMWhocDVyZjF5bnFWSjdIemRicXFpbm15dWJlbEVKWWFBcGx0?=
 =?utf-8?B?TXB2S3pZdFdkdGF2Zis5VTIxUHk5QlZZWjBVek9OOXVSdnZhQUF4MmNRNkZp?=
 =?utf-8?B?SGVjTHlxRzNPUHJJUXlxM29TU3JPdngxa3QwakV1WFpKTTNvYmZzSk9oUXhp?=
 =?utf-8?B?YW0zcnc0MmtKVUpjelVDU3RYa2xQSmtaTVZCRlA5MmxSckxXSjhocFBHU0xv?=
 =?utf-8?B?VHV5TGkwRHdZZEEzZzdtZkpIN2JYaENvaUVDaGtBUDZWaDlCZWQ4Q2g1RDk4?=
 =?utf-8?B?ODFaZ0c4cjJGT0hjdUFpYjZMV1FUNHgyOStnWnVvZ215NW9Ub1I1a2w1RllN?=
 =?utf-8?B?bTFwb09NeitaREhXM0o2dGVPbVJ2dThsVm41L0h4cE5jSXQrTE13VEFNMXd0?=
 =?utf-8?B?aGlCSHdHSDFnSVUyYWs1eVg0ZWFNaExRV0ZCN2ZNV2RMY1B2TWhmUEw0M3Zn?=
 =?utf-8?B?dGtCc1g1UyszelhaeDd6dUxXRlVvc0NrZ2x1U0ltRDFHcmh5QXp5aFdJSDM5?=
 =?utf-8?B?by9xQTVFRllXaDY0L0hOSVNuejFXaHR5UUIvNTA5OG1VamlqK2dEbDlNeFpl?=
 =?utf-8?B?TE9LUWVCbG9nbGg3NjRZQi9VVUFzT1k0Q3VScklWWGxqa0tHMTlicjRuZk5u?=
 =?utf-8?B?dVpKeU14WHlwVllrK0lrcnI1dkpPTEttdTF0Qk91eStwUUxJbmFSUXYyUktq?=
 =?utf-8?B?UUw2ZkJRRFgrb3pSaVFycThpTllLbFFnVDg2NmlWYnBFSmZsQm1nZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f7d31-85d8-468a-3463-08de51dd92cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:22:02.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAlothzHrsq4BIS3kt+gZ+jd7tJVv77revSCPVxPGFAxT0LfG7FHCAa6yeZEzGkJW/0eD0JhDbdNECVlr7Yunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jan 2026 13:22:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21530

From: Jan Kiszka <jan.kiszka@siemens.com>

Something broke the build of ltp-full recently, likely some update of a
Debian build dependency. Backport a patch from the upcoming release to
our 20250930 to address this.

Close #147
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...date-struct-mnt_id_req-support-for-k.patch | 195 ++++++++++++++++++
 recipes-core/ltp/ltp-full_20250930.bb         |   2 +
 2 files changed, 197 insertions(+)
 create mode 100644 recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch

diff --git a/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch b/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
new file mode 100644
index 00000000..aecfe548
--- /dev/null
+++ b/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
@@ -0,0 +1,195 @@
+From 2d066ead3d6ef504c82551b12306e751d23ddb45 Mon Sep 17 00:00:00 2001
+From: Wei Gao <wegao@suse.com>
+Date: Sun, 14 Dec 2025 02:15:20 +0000
+Subject: [PATCH] listmount04.c: Update struct mnt_id_req support for kernel >=
+ 6.18
+
+Kernel change from v6.18-rc7
+78f0e33cd6c93 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
+causes the test failure with following error message:
+listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
+
+The fix require following changes:
+
+* struct mnt_id_req got new member mnt_ns_fd in v6.18-rc7.  That is
+fixed in a fallback defintion in lapi/. If the fallback is used is now
+done via typedef (that requires also update in statmount.h).
+
+* New kernels (>= 6.18) have also different errno. This is fixed by
+runtime check.
+
+Link: https://lore.kernel.org/ltp/20251214021541.3256-1-wegao@suse.com/
+Reviewed-by: Petr Vorel <pvorel@suse.cz>
+Reviewed-by: Li Wang <liwang@redhat.com>
+Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
+Signed-off-by: Wei Gao <wegao@suse.com>
+[ pvorel: Shorten TCONF, rewrite commit message ]
+Signed-off-by: Petr Vorel <pvorel@suse.cz>
+---
+ configure.ac                                  |  2 +-
+ include/lapi/mount.h                          | 10 +++--
+ .../kernel/syscalls/listmount/listmount.h     |  2 +-
+ .../kernel/syscalls/listmount/listmount04.c   | 37 +++++++++++++++++--
+ .../kernel/syscalls/statmount/statmount.h     |  2 +-
+ 5 files changed, 44 insertions(+), 9 deletions(-)
+
+diff --git a/configure.ac b/configure.ac
+index 0480f46ca..a0ebbb34d 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -262,7 +262,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
+ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
+ 
+ # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
+-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
++AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
+ AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
+ AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
+ #include <linux/mount.h>])
+diff --git a/include/lapi/mount.h b/include/lapi/mount.h
+index 0f7bb5e43..3b296fc9c 100644
+--- a/include/lapi/mount.h
++++ b/include/lapi/mount.h
+@@ -45,14 +45,18 @@
+ # define MS_NOSYMFOLLOW 256
+ #endif
+ 
+-#ifndef HAVE_STRUCT_MNT_ID_REQ
+-struct mnt_id_req {
++struct mnt_id_req_fallback {
+ 	uint32_t size;
+-	uint32_t spare;
++	uint32_t mnt_ns_fd;
+ 	uint64_t mnt_id;
+ 	uint64_t param;
+ 	uint64_t mnt_ns_id;
+ };
++
++#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
++typedef struct mnt_id_req_fallback mnt_id_req;
++#else
++typedef struct mnt_id_req mnt_id_req;
+ #endif
+ 
+ #ifndef HAVE_STRUCT_STATMOUNT
+diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
+index aad927f71..e7ef375d7 100644
+--- a/testcases/kernel/syscalls/listmount/listmount.h
++++ b/testcases/kernel/syscalls/listmount/listmount.h
+@@ -15,7 +15,7 @@
+ static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
+ 			 uint64_t list[], size_t num, unsigned int flags)
+ {
+-	struct mnt_id_req req = {
++	mnt_id_req req = {
+ 		.size = MNT_ID_REQ_SIZE_VER0,
+ 		.mnt_id = mnt_id,
+ 		.param = last_mnt_id,
+diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
+index a6921a249..2b8b49101 100644
+--- a/testcases/kernel/syscalls/listmount/listmount04.c
++++ b/testcases/kernel/syscalls/listmount/listmount04.c
+@@ -14,14 +14,18 @@
+ 
+ #define _GNU_SOURCE
+ 
++#include "config.h"
+ #include "tst_test.h"
+ #include "lapi/mount.h"
+ #include "lapi/syscalls.h"
+ 
+ #define MNT_SIZE 32
++#define BEFORE_6_18 1
++#define AFTER_6_18 2
+ 
+-static struct mnt_id_req *request;
++static mnt_id_req *request;
+ static uint64_t mnt_ids[MNT_SIZE];
++static int kver;
+ 
+ static struct tcase {
+ 	int req_usage;
+@@ -34,6 +38,7 @@ static struct tcase {
+ 	uint64_t flags;
+ 	int exp_errno;
+ 	char *msg;
++	int kver;
+ } tcases[] = {
+ 	{
+ 		.req_usage = 0,
+@@ -79,6 +84,18 @@ static struct tcase {
+ 		.nr_mnt_ids = MNT_SIZE,
+ 		.exp_errno = EINVAL,
+ 		.msg = "invalid mnt_id_req.spare",
++		.kver = BEFORE_6_18,
++	},
++	{
++		.req_usage = 1,
++		.size = MNT_ID_REQ_SIZE_VER0,
++		.spare = -1,
++		.mnt_id = LSMT_ROOT,
++		.mnt_ids = mnt_ids,
++		.nr_mnt_ids = MNT_SIZE,
++		.exp_errno = EBADF,
++		.msg = "invalid mnt_id_req.mnt_ns_fd",
++		.kver = AFTER_6_18,
+ 	},
+ 	{
+ 		.req_usage = 1,
+@@ -113,7 +130,12 @@ static struct tcase {
+ static void run(unsigned int n)
+ {
+ 	struct tcase *tc = &tcases[n];
+-	struct mnt_id_req *req = NULL;
++	mnt_id_req *req = NULL;
++
++	if (tc->kver && tc->kver != kver) {
++		tst_res(TCONF, "Test not suitable for current kernel version");
++		return;
++	}
+ 
+ 	memset(mnt_ids, 0, sizeof(mnt_ids));
+ 
+@@ -122,7 +144,7 @@ static void run(unsigned int n)
+ 		req->mnt_id = tc->mnt_id;
+ 		req->param = tc->param;
+ 		req->size = tc->size;
+-		req->spare = tc->spare;
++		req->mnt_ns_fd = tc->spare;
+ 	}
+ 
+ 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
+@@ -130,8 +152,17 @@ static void run(unsigned int n)
+ 		"%s", tc->msg);
+ }
+ 
++static void setup(void)
++{
++	if (tst_kvercmp(6, 18, 0) >= 0)
++		kver = AFTER_6_18;
++	else
++		kver = BEFORE_6_18;
++}
++
+ static struct tst_test test = {
+ 	.test = run,
++	.setup = setup,
+ 	.tcnt = ARRAY_SIZE(tcases),
+ 	.min_kver = "6.11",
+ 	.bufs = (struct tst_buffers []) {
+diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
+index d21d7f8da..4217a82d8 100644
+--- a/testcases/kernel/syscalls/statmount/statmount.h
++++ b/testcases/kernel/syscalls/statmount/statmount.h
+@@ -16,7 +16,7 @@
+ static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
+ 		     size_t bufsize, unsigned int flags)
+ {
+-	struct mnt_id_req req = {
++	mnt_id_req req = {
+ 		.size = MNT_ID_REQ_SIZE_VER0,
+ 		.mnt_id = mnt_id,
+ 		.param = mask,
+-- 
+2.51.0
+
diff --git a/recipes-core/ltp/ltp-full_20250930.bb b/recipes-core/ltp/ltp-full_20250930.bb
index d57e875e..42a96328 100644
--- a/recipes-core/ltp/ltp-full_20250930.bb
+++ b/recipes-core/ltp/ltp-full_20250930.bb
@@ -11,4 +11,6 @@
 
 require recipes-core/ltp/ltp.inc
 
+SRC_URI += "file://0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch"
+
 SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
-- 
2.51.0

