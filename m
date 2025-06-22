Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DDC7115A
	for <webhook@archiver.kernel.org>; Sun, 22 Jun 2025 18:50:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.71])
 by mx.groups.io with SMTP id smtpd.web10.2761.1750618228815857901
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Jun 2025 11:50:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K0TiwF67;
 spf=pass (domain: siemens.com, ip: 52.101.65.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY9EbsJgnrZ4mIHQLI0hfc6Sq/Tox2yXHQ3R2VfF0zzu9QEcG97y3EV3hcllc083HxQSvgn/Pg+7rLNGE9CEl8coDCRQIpdq4N4VZP0cf43UZxIwX8I61tgCoOWNpntP07wMSqefIVwW1K3IXXn/egl4QifnO/u9yGxGvuGISdgb+k4Z0V0AL6WzuBDMGVnzIa6Aor3AlRB39CtlHM/uCM4LHnVTNwqE5IqNK3RzOJU3D+xA6/q4Hr7QdPRjrvsvOtZdpV8wyfH4+pv3oTjzBi4NYnpIthFxO5h0YTYMZQVXlK9vWiu8hgR9DxnrNSL5C1hTnwgk0C3KQ6AxmsZb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvrbw9yd+2+n13DoZsrTNaZrzTZwaEXZUleG3lYwQSE=;
 b=PbyPkX4WGnXle9yESySkEb2Q1l6BsWds2BD/Nc6VohxUhtLyOyQ3mnjQv9rm05aw1kHFEZPxJUIT/Wx/RGstsGyS0UzDlbx2hEOd/AC68OttjbE44h5LCOxDKHAQAm3HfYr3ec6F6Of1da5HjFpzgo5jnrlwNjgxa6aZs/Wos1A1c7qiabdZCGHN+JnH9A6AeXr/OJLjGfoubtSm/kIoOkPnNih/sqdlOrkPnzhWtthDuICOYxZD03e6PZEd63d5rmvYBa+2FRHPL6oCRmE5lHbwbMITnLaomcceCQ7QllrcAQv7TlTh39fMQREeopCPhA1oJWhsyau77Ev+yFf6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvrbw9yd+2+n13DoZsrTNaZrzTZwaEXZUleG3lYwQSE=;
 b=K0TiwF67fLUrgISK3bg8qAZznKZdKUoXH9OzlAOwZixW6etb9IvAgZeBYbkhrMffPD+kWC0Ax9YOG4njMiYuQNo20Izm8kHSXAU6zaFMjmqo0hrjK/gZBvhhNFLNStsDSrD09s+OpcPYHgWXQOSEcRVnK3zS3ghI+vzrY1FnmpoC+z46aBniGjmg8oG6Y/lzVNnmsLEErJQtohAJDO5Uy6R4A+pLChkcasLMhpXTHiF+ZIPqnnd6BH23ifZomRnz8sbexFgu/cWHDT+kPgtmNZoDT0rxN/O6rJ0MaCVwFNKUwtEWtNSMO+SCz64fL1GgKfIHUv1rQ+9BuGCFfMFEpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sun, 22 Jun
 2025 18:50:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.025; Sun, 22 Jun 2025
 18:50:22 +0000
Message-ID: <4a1c45e1-0550-463a-a3f1-9a105b9336a9@siemens.com>
Date: Sun, 22 Jun 2025 20:50:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] doc: Update image file names
Content-Language: en-US
Cc: Nikola Trifunovic <nikola@trifunovic.at>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f5ee67-767d-44e0-126e-08ddb1bda424
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1V0M0x3MVkyWVNkK0VlK0ZTSW4vUFhwZEl4cFFZRmROL05MNmNWWW80SHRy?=
 =?utf-8?B?WWlkYTUxcTUxNUVUZXc5dU1yYXI3cks5d1YwYXlLODdld2RHenZZMnMvRS9x?=
 =?utf-8?B?R1oyWTBWTkl4SmM4Q3hpMTRjRFVsamQ4RU5ORVNIYisveU5CbUE4dUVtZ1N1?=
 =?utf-8?B?MkhjZEtNdWZYUzVEcHZuS2NUOG9XL3cyRjJwMmJ3L1ZabWxIaVY5aVlkMlBM?=
 =?utf-8?B?NnZyejE4UnFQUEUrbE9IZDRnNE42UzNXNWtPSlZmVGpYaGU2cUlmNUhCcFJ0?=
 =?utf-8?B?N3V4blZTRUhIQWJabHRJcWxWNkl2ZkVFOVQzN2RPQXJWNlpnYUU5YmRJME50?=
 =?utf-8?B?QUxmbkNRN2xRMy9qaVozVW5EcjRmTVpXbFUyOUlZSEVlVVM0NVdnNTFDMklu?=
 =?utf-8?B?SmRaWkdjRTdDOFRLOUtsQ29ZcXF6ZkdPS202aDh6dVYxd1pld2JTcTZrdFlj?=
 =?utf-8?B?WWwxd1BVV0pidDNpbHdTWEVkYUZrUU1hS2xYbFEyTkcvMmdacE9yM0RIWW1r?=
 =?utf-8?B?djdreWwwRDV0Z3VldUg5ci9jSk1iTGtNSUxFVjNqendjbC9PTjFYVnVNNStW?=
 =?utf-8?B?cmZpdkxXRklkVnQrem9xbkw4cDI3MldBT01kZDc0NkpoV2lUK0huYXdIS29P?=
 =?utf-8?B?Sjc2UEt2ZjZpazNZVUt2K0R4S05LbUk3WXFXTVB6U05mWXZoamc1VWFxYkp5?=
 =?utf-8?B?Z2xOdVBjNnZHRk56M1VwazdWNVNLSStnRjFHZytQNXRyaE1xSWlWcGkxL1lN?=
 =?utf-8?B?d1lzWWJPSFMzSVJvV1NKRS92WU1wODVnQUE5M0NaZXZrK3FPdDdvUWp3T0c4?=
 =?utf-8?B?K1lsRXBDdXJDQm9ZY0hvaGk1OWFZdWgxL1JjYktrbGo4M09aRGxiSWVtenNt?=
 =?utf-8?B?cTYzT2tDWmJZZ01LOVFmZTRza3BYRTZwcDdpNVoyc0xRWkpqQy9CVlArQ1Nw?=
 =?utf-8?B?c205Ky9scnRsczdJdmJMc01Bc0wwMjFVSzZPSVhwMW03clZ5Z0hvU3lIb0pq?=
 =?utf-8?B?ZVd6aGNtYUJpUmhUQVlJd3ZBV3Rxd2gxU3ZxK0R5c2RLeGpZVjlDZ2pNNVhH?=
 =?utf-8?B?WXpSUG5lSU9uZncrQ211Qm9TeWdDSndtMExRZlh2TW5VZnAvVkxacW1aSS9s?=
 =?utf-8?B?UCtleXZlZjZpQ2FvNnlMd0NsVzMxY3lpK3BaWFpvUmZpTkJwMUp3RjNLcWRI?=
 =?utf-8?B?QlJNOG0xUkpCaFlMaE9RT0FEdTUyMDd0bXRwNW1xOUFsZW04YjJNT3NtV212?=
 =?utf-8?B?YVRzS3JxWkZyeVQxT1hicGczOVVUYUlDNS9GUjg1aVpINmRTMHg0c0J6STk1?=
 =?utf-8?B?UU5Pek1Vc253MUZXc1JzNEZJcitnb2dMRW1oY3RCYnR6WkdaUTAwWFJwUXFl?=
 =?utf-8?B?SjVwSnAvUSs5RFFDVlpjUSsxNUphVHY2U0F5MVliVTBOS1JDWHBsSlVTWkNp?=
 =?utf-8?B?U1FKNmFhUk8xM1podTZaT2pCVitKNC9MTVYySWo1VDlSSXlGSDVFbTM0azYy?=
 =?utf-8?B?L2g3OVhuVUdkdDBST3p6ay9CeTVjajh4L0NCUmpoemZKNmZDWjErZHVxTEtR?=
 =?utf-8?B?WWpUTlIwbkY2S1pOdkZNMlluTUpmZ004TEsrdS9xQ202bU5TYk9zclV0WSsw?=
 =?utf-8?B?UVNXOURSQkJ3SUxrc1ZCMjVLRFZOcllhR0sybzMva0NuZExZZnl0Ry80K2c3?=
 =?utf-8?B?YjlkSURDQTcvSFlpZDFkRlNvcVg2VllCeEsyQXcrdWdJbm9aOHJoWXBWbW5h?=
 =?utf-8?B?cTBvay9tS3l0c1dqWk1tdjNNeWlZc0ZlcE9FLzN2Ui9ZQTA0c1E4M1gyYm9l?=
 =?utf-8?B?Vm42eEg0Tld4bjRneXNtbUh3VG5Lc3YrYUZCTE5ESlBZOXlOSHV2ZUxEdnFj?=
 =?utf-8?B?YVd0cVJneEEzZjgvODhvaGViMGdnVXVDaWtRRmxVRDdicTN3YUJpc3JPU1Vx?=
 =?utf-8?Q?/8Bs1Z/PLkw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWNMUU80NlcxdlVhMzU3OVhiSUN4ZFBGT0FxandYVkNYaWtnSkZLcjhhQ0hl?=
 =?utf-8?B?emNLOEJ3aG5kQS9nbnI2YWJQY2ZUK2pJcVlRNWlHT0VnYUFrb0lBMGZVd1ZJ?=
 =?utf-8?B?djZrRTBHVFo2MExXNTZ4TkR2NWFTUE4rWGNwa2p3VTJGUU41Q2NuU3VrZUpE?=
 =?utf-8?B?Vi9oVFJhRkpjWUlDR0pCeENNeDZ5WENRc0hybGtoRGJnVkFKZzhCTHRUNFN0?=
 =?utf-8?B?eWRzdjFId3V2WE8zcDNXdGk0Y2hKNUdNdi9tL3Q1YUtnQWxPakdGZU9EWW5m?=
 =?utf-8?B?ZW13WU5yZ254UzVudzY5aS9QT3UwdkpwN3BhaUVWMzR1UmlIU3cyTGlTcTNz?=
 =?utf-8?B?Y2Q3VkEvTnNCT0hVUUM0UkNxMGtmL2VhbkVYbHBuQy9CWWQ5QjR2anNsMkRX?=
 =?utf-8?B?a1M2R1FRcXg0NnpGUDlENmh0V20wbW0wdlZqVE8wWHRhYUl1ZGhzTG9zMTVC?=
 =?utf-8?B?YThBTmJTNGlKWXU5eVozRlpZYW95dzlwYzl5dVlQSTFoZG5sM0VXWndJeDd3?=
 =?utf-8?B?WXFtNnp2dGZycDljMEV6RzllSW8ya0dBdll2UlJXUHQrc0ZuQmU1NzRUK2Fw?=
 =?utf-8?B?dHJVWWZvN0F2WEZ3dGdWcDFMd0NjdmZVOThIVExOMVkvc0Q5U3pXV1I2NWIx?=
 =?utf-8?B?ZmJuUkNYNmtWcjF3Vm90RzJybCtESGxqM3ExVDI4Z1p1YW1FVlRKSlV3eG96?=
 =?utf-8?B?WDJvT2NmajRkd2dOY0lQZXRNd1dyeGkzK2Jua213VG0wSEdUMWtmR09wckhk?=
 =?utf-8?B?L3pZQ0xZdWlKcmNydE1IbmpvZUtQVWxMQlRaUDdOc005MmxDQmwxSFpOc1Ux?=
 =?utf-8?B?ai9jajhrRFJndVpiRnZjdDBIaVJ6WVp2bmxFRjB4L0NyRXhJK2lFd0NrcjVL?=
 =?utf-8?B?YjBySGRVWkdPbE9RYkdEWVlyVFVMRVBPNHgya1BieFNCdk1vNHVsVGJpaFhi?=
 =?utf-8?B?aS81aXZJdkpBaTlFM3cyQTY0NE1GTlM1LzRoZjdUdGJRU1hwU05HMFZmY05p?=
 =?utf-8?B?NENZaTREZnNDSVI3RU1rcDRLeGV3bDFBb2FFL2t2SFZxN3BNMzVkZDg4ZHAw?=
 =?utf-8?B?TkFsQkhta1czeVg1clBVemR1QjIzb29KZUZhQUlBRmtGdHVvNTYxZkY2SWJw?=
 =?utf-8?B?NnJZN1dvS0tRRkd1SXNTbXlPYU1SY1M0Y3JROXVqTHJLNEhPc1hyM3l5NmI5?=
 =?utf-8?B?ZGFxVjd5U1JvVU90QjlrMSt4L21uQW5aYzFLbVhCOUpBU2lVbmxoVXJvV2ln?=
 =?utf-8?B?V1Z2SEtJZWxLY1dRQXZWUXN2K21vOW1yZkh0U0FFTUFMNVRyNzhtZUFYdWNy?=
 =?utf-8?B?ZEwxL3V3aW9kUEVmTk5VckEySWNzUHRCMkt1TmxrcGFvUGhkcDFqcnRlME9l?=
 =?utf-8?B?cEpMaDlxL25hTWRDd0RJQTlIeWFScng2bmlIemM2OWNtTDFQc1dVSEZRNlg4?=
 =?utf-8?B?TXFId1hNT0ZHa015NUYzSjhuUkJmZWR3SmR6cVRlemJLUUFmKzNka1VkZ3Q2?=
 =?utf-8?B?cjFFY0RmTXhqeUF6YUdtTzVJMUFiZTJxUXQwT1I0WjBwY0NFWEREOEpEQk81?=
 =?utf-8?B?cWhNbklaNG55dWpXdnNCYUpzUWxsM2VwV3ZmY3JrWjgxTStkVEtpbnZPODk5?=
 =?utf-8?B?b3k5YXRXR2lzUlhNTHFTejc2Qkk2RDBScG41dmhINWpoYWNzdlR0M3FWZFpI?=
 =?utf-8?B?eEZrdDZXY0ZrRFdjSXRvZGhJQnQxbTdwS1huNXdSWkFuaGJvdnFwVWI4RTlV?=
 =?utf-8?B?MURJZWxKZmtkR1F3bDcxTG5pVjVxZk41SGR1YmxGeVZFaWI4VFE5K0I0dEov?=
 =?utf-8?B?VjFMejhtRGlyZW5ZVmZFWVRwN0VVcWpjSC9qMk9JQktXTERRalNRd2QyK2Iw?=
 =?utf-8?B?Y1NDa0hJazEyMmZsTVJkdzdHZElMZm1waXduWmx5V0lXRFhOZlBQcjdDZmxv?=
 =?utf-8?B?Zi9jbFBnSmIrdkpJbWZBNDdLY2VkSUgzRHVCQUg5RFBZT1orL3J3YmxMczhD?=
 =?utf-8?B?S0Y4YXMyTENQNmljWENpTUczWFFWR20rZHg4S2pRSlJMMisyaE0xMEJOK3Vh?=
 =?utf-8?B?RmRFUjU0VzF0M3BrbUNwVkhFTjcwNGdUc2JLOUpRSm45bS93VjNSL2JhUVFZ?=
 =?utf-8?Q?lTwD33gr0CEnjpHKMsPIEfGck?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5ee67-767d-44e0-126e-08ddb1bda424
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 18:50:22.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1P5zj/zeZKfeJKpJr83SU8K1j5tYR8y/cIV5KcwuvmqLK/A/VWYBN6HpbsxKy8iXySXxLnd/JpbNLkOTfFqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7864
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 22 Jun 2025 18:50:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19157

From: Jan Kiszka <jan.kiszka@siemens.com>

Already many years ago, that .img suffix was removed by isar. Finally
update our documentation.

Reported-by: Nikola Trifunovic <nikola@trifunovic.at>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md            | 4 ++--
 doc/README_iwg20m.md | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 4ded924a..b2eb9d0e 100644
--- a/README.md
+++ b/README.md
@@ -45,12 +45,12 @@ Physical targets will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
 card, run
 
-    dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img \
+    dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic \
        of=/dev/<medium-device> bs=1M status=progress
 
 or via bmap-tools
 
-    bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img /dev/<medium-device>
+    bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic /dev/<medium-device>
 
 
 ## Community Resources
diff --git a/doc/README_iwg20m.md b/doc/README_iwg20m.md
index 317d240e..2dfc0827 100644
--- a/doc/README_iwg20m.md
+++ b/doc/README_iwg20m.md
@@ -18,7 +18,7 @@ After the build is finished, insert a micro SDCard and flash the image with `bma
 
 ```
 $ sudo apt install bmap-tools
-$ sudo bmaptool copy --bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img /dev/sdX
+$ sudo bmaptool copy --bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic /dev/sdX
 ```
 
 [Note] If you cannot use `bmaptool` then use `dd` instead.
-- 
2.43.0

