Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F61C87FC9
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:13:27 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.16])
 by mx.groups.io with SMTP id smtpd.web10.80796.1753708401261523805
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:13:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XmMKi6Z6;
 spf=pass (domain: siemens.com, ip: 40.107.159.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2pnn2RspfICvDa37DsU2h6mrObh96O5c1H09N8yJobsvraUeZF72nD0St4YvQU2uN9FQxfZHbiKJNnsZgZJfUk0v8+sg8/TlDxuskwLjfXvyF3i2wOBm1zpluZyEJjaIn/w5FXQT+IkW4bVSwgTZ5Rh1jn8kWPyYx5pGUAEXnYhfRsJpJNfj2qRSe6bSxV9HK0pbuhgIC6Q6C+fwaobMgLv9X6UI0w2T271kMM8+AFBUtSq/vZNMrw5CvvEJUSzhjC51RIRaiiqMJoBOJSYRrAd/lSTA6Ux6vt2JwLMH4awLfWBdLc7aMa/CbYOl6JC6AV3076enBP0h+vMOTJ+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3OVCHMCLJrkEgs9clsQALXGGN/nOuOI09BfAOMulZo=;
 b=Ft6LtjOzcVnPHkGTMWOboZhqCcZf47To/Cq2L/87ri3g6NpR5TXKDopKUGwWHGCDtv1WdQe0XJwKkbN4YftAm0jubWef7C7MR5EtFlszY4A3HD9xhKRWVBmzq+h4SetLpOMjT/KELTvock+KqZeT6zw9Ksh1rKfRM9oAqa58njMxFvd4UY4hkN3DBlfmB/OhHTYhxkGhiwk+X7Akoq/MKS806g7sV1+pzvBNwxEwPHo0wyDn5DIjNC0UxYQpONuXi2CGzpzch9hwDdYvFfCViw2zBmitfPBPYlFZoFUhCoTxLb+AMIOLYNKEHO6MRLD4TH8uZ3Ow2DdMaPowerk+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3OVCHMCLJrkEgs9clsQALXGGN/nOuOI09BfAOMulZo=;
 b=XmMKi6Z6HrD9MW19pJKOuo4SUAoZXM2Dw6MnxjjRG3NdXhgsPNls5lEfd3RUdSEGodiFdpioHcVKpNbEtpAMuCm4JSUW2aXu0MrheN1aht/m9NypOFqLDojzlHCqjqVcr0Ie+vsRvpiqqimPxOoO5mA1JkfmL4Bx3F7/erebvNsNd/8rU2SAkR/Mm+QD1dZOt9QCMIBmfxvQiYXeRUMTuc1mBG7heTseYL7YN6fSc3+8BICEjdQbFYhGvMLQuKRKxErt2vUy58f2XxN7/89YstWEGTvj8VKXzwa0gb1SNhojlhzkHgIYOGO42N+rUzlgIgEs1G1Zfgx6v+k/dWMiCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:13:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:13:17 +0000
Message-ID: <eeb71d99-ddac-49aa-b353-1d54baf558fb@siemens.com>
Date: Mon, 28 Jul 2025 15:13:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] Pull bullseye-backports from archive.d.o
Content-Language: en-US
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c06ed6e-4a21-4f69-3653-08ddcdd88468
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cnN4empqWDBkLzVLL2dvVkdqa1NMZUdPQmRUTGdpWlUvbDdxMEJKMUdaa0RK?=
 =?utf-8?B?enA1MWJnU3RRUUJEcHZ2b1JzOWY5VU8yK0lyblIzRStubXRrYW1CVlE1Vzla?=
 =?utf-8?B?d016WURBMTZKY2o3dm9LQStCNmE3SXUxUG5nSzR6dER0RHNzem9aV1hQN3RL?=
 =?utf-8?B?S3I0Rk9DQWZTbmQ5QzA3cHczYzJ1Znl4ZlhQWThDZU5aWldsR05qRTh0SVp2?=
 =?utf-8?B?OTlUUnA1WHl4T0JOSDlqcTNKcnMxdVJ6UUcwdTBiektQV0szeHIzV20xVzdh?=
 =?utf-8?B?eFk1R3JiWWJCM0hFeEpDVTZWRkRNWmJwUWJWc0JURlRwZG50WjF3dmh0My9w?=
 =?utf-8?B?MmwzYmtDd2pSZmw4anlMaDNZalRZdVBadlIxM0t0Ym5KQzE3MitWTTljMkdj?=
 =?utf-8?B?VFdOZDlHeEhpN3lZNXNRTzU5cWVFdVdSR1lRbWpQbVNUTmVWT2w4R1l0c3RF?=
 =?utf-8?B?a2tYcHVnblF5U2hHU2lzcGFvMzVadWw0SHhCTUZiVFpkcm9ZWjZZOGNNN2Mv?=
 =?utf-8?B?eUNjd1grVlV3QUdpRFhSMDdzbUxNMGUvZElxQ3pWeGNrc0t6cWFTZlVtTGhE?=
 =?utf-8?B?RThyVU5MUjZiamRyU3ljUVh1aVVsRG1MQW9kdEw5VDVnQ2lpNDZuMVZGeWVZ?=
 =?utf-8?B?VkZvWEg4a1dRRjYxMjFrR0NzVnhVcEEyTDVXTHJpTkJ4VWUxN0w3UlhrcHQr?=
 =?utf-8?B?V28yWTcra1N6Y2oyWWFKMmp5cVdsQWFTckZlUUhxa2FQNWs4a1JsTE1sM1dV?=
 =?utf-8?B?MFRJUVZzMlRhWHZaMytRUTZvTERGamxiRmdRc05tMVExNTJYalhZSDJKbWhF?=
 =?utf-8?B?YWxyekp5d2dhVU1RQ0M3Vi90SWlXYUwzdTVVRnZoN0pGMk01VnhpdUxsQUQ5?=
 =?utf-8?B?dUpINFhuMHQzdGszOGdNTEJ4TUdpSitmTDBHSkFwdjkrbHd0cjAvVHBHQ3VQ?=
 =?utf-8?B?Tk1mZVAzbEF4K1VVODB3dGlHZ0VoaGlOTnozaFA4N0VEWE1ZTVZnSWI5ZXBI?=
 =?utf-8?B?aDF2Wi83cHQ2MGFLNUVlbXhVcnk3ZlBOZEM0UGxyVmV5UXIxbEpKdjVZMG9j?=
 =?utf-8?B?OC9Rd0M3S25YUjdDRE5LK2w0clpSUEYvdTdFQ0NDN3FaSVc3dDZrTVZrOTZC?=
 =?utf-8?B?SWxQYnJWWU9nRHNQMFczSk1KdU5lSVVQRTc5MEJkK0JYU2lmQWtjYVJ0bHhv?=
 =?utf-8?B?QjJEUmQ2c3JiTWZYQUFZRy9HSVZHa29ONVJLQXI5ZmM1cURqaGNpdENLZjRI?=
 =?utf-8?B?S0U3QUJvTDRndXFVYUtHUEtJVEFIdWE4YXpCQzlQbDZOMzFoMlJFZ3Q2a3h3?=
 =?utf-8?B?UG1CSGkyUWU0dlBER3ZVNzM5NWM5ZnNxWHd3VHJRUktUTlhNSUoyakYxZlpX?=
 =?utf-8?B?Mk03T1RIVitkWlFOWHJhNmFFUGZZclZkTjk1UVVGN1JreHF0OGN4VHUxckFQ?=
 =?utf-8?B?NEJodm5RVWIrN2hOWXgwV2IzQXE5L01nRDJjSEh5YUV6ZExCdUFjSThvazdW?=
 =?utf-8?B?NmJRVmJqK3FGU3FoU1R3WUNYMXp1dXprejl2NGttZWxTSTJPSGl4bjIyWHhn?=
 =?utf-8?B?QW9IYmJOME1VcU1TU2ZrbE5jaUhNYnR1K3ZKT3RWa3QrZ2J3MkVKalBoVjdk?=
 =?utf-8?B?UHdvRWZNVXFQZ1Z5VUw2VGpweXAwYjhhd2NJa1lEUC90aDBKNnpLd3RVQ3du?=
 =?utf-8?B?MzRiQnN3czdpalBYUjVJdk03K1FzTVc5bE9OVVpEeWpobFU2M1IxMnYwUnFt?=
 =?utf-8?B?L2hSUVVZYmtLOW5BTERGN2hBOE1peUpJaU1xZXk1V1FqN2RxQnNaN2NOY0V5?=
 =?utf-8?Q?2LqiJ2O8Trf1bclZ+S7bwopRtwSlE3J79cLhI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFk0RmwyMXR4aGd6TldOamVDbXRJampDR29wbUNhdEZrS2p6SjJuTEM3bkZ6?=
 =?utf-8?B?aXdPeTNUVWtOR1F2d3lRUm92dW5uL01aWjI5dnM2bFdDQXhHK2xaTHkxWXJY?=
 =?utf-8?B?OFRPVVpCelAxSFRRZ1BZQXpBVTlsRlJhdURzRFd1TGNsYTdlck9mTUR3SHFU?=
 =?utf-8?B?bmtjM2NWdGNjSlRiTUVZVXdZblcrSU55TFRxT2RLWTdVVUlaZmZmTFdDcjd6?=
 =?utf-8?B?OEQ5Y01tOVhrSXYxWEFBa2xURHg3RVd2S1ZoZDZZZUhEUnhNeTNtVnNOTVVh?=
 =?utf-8?B?cXk3dzFUV2RpTXptSjZSdVd4ck1PakhUdXQzblBoeUxaM05rQ1hYbzlUUDl5?=
 =?utf-8?B?ZG5Iazh3RTFjdjVKeXNHTHpXOTVVcXJhRWk5RG53dW5qSnRwangwc0N2OHU5?=
 =?utf-8?B?cmdYK1F2TVVPL3MzQnhyQzZ4RmJydWtzcnhRMkVTVnNWbk53RWdWZEYxSVlB?=
 =?utf-8?B?TGM2c2cwTnpxZU5LOUhVV1lnUDFHZm5DZUlCQ3BnaytYTzAwTEU1Nyt3MDJ6?=
 =?utf-8?B?dEdaOHJRcFJqZXZLWFBRRGdhaEtWcllGMm5qc2J3S1dHalF0K2U4WjNEZkJx?=
 =?utf-8?B?b0RZWEpBc3EwR21ELzFHcEtheUxOdHMvWDZ2RnIrUlUxZHNJenFuNDZPVEJX?=
 =?utf-8?B?U0J0VGhaUFZSTU5sN2hsV1ZXYjBFamllazJId1VqM3RSaUlEUWdQbDZINmIx?=
 =?utf-8?B?OVh6dFBsdmJubFpZeVJiSENiQnpyM3p6dVpFbjBPWWJuVDRzK0FFMmtUVEs2?=
 =?utf-8?B?NnZrVHpCMVk0MWZ0ZVl4Wm1uL2VtWHFvRzNxc3l3aXJONkt1MWtndEtLTFFn?=
 =?utf-8?B?K0Y5b0FaRlZVV2s0ZjlxRXd3S2YzYUhTbmFqMHM2U1p2VnlLNGNYMkpKbG9V?=
 =?utf-8?B?VWtrYkY5SXFsYUZRWlZITjVCc2hDdVEvRkwwb2FVZjRPMWdKUnlCZFpNZmwv?=
 =?utf-8?B?K2k2ZGhhWWxBcWR5Ync2VjdHV0tPcFFqcFhEaVQrMFA5MDYrbHdMQXFpVlo0?=
 =?utf-8?B?ckpKTGpVWkphSVpUNExYVnRhakZNL3BaRy95a0RJMmFjRWFtbmFQOVdHbHRu?=
 =?utf-8?B?YnlyV0pJQzk0alBDNWdGN2tCalRQREtBZFJUd210aWovdTUzcktBanJJQzI3?=
 =?utf-8?B?bXZ0b1VSZytxV3FSaXEyYlJ6WHhBa0hpOGtBc3dxSVJDRGxwZWNZdFpRYnJj?=
 =?utf-8?B?dUFOSWQ0bmh3TTZ1clc2Y1AzVFR1VnpNSDRMYzBaQldkUXRVMHJDaVpLMG9P?=
 =?utf-8?B?MFNDdUV2ekIvamdmcGZ0SWVuVnNBUDl3Y0JWMk02dDRCUEZwUXh5enlTY21n?=
 =?utf-8?B?a0s3Z3pVTjBRV2gvQ3Bma3V6RjRXT1kxUzc0dG5hWTBsU2s1emp3ZTN1ZHJi?=
 =?utf-8?B?a1BMOE9lN0pPL01UdlI2S1YwcVN2cXpZN01iSEdEYU5CUjNpdDhHc1EwK3dp?=
 =?utf-8?B?WFJwUzNobVNMLys4SW8vcDBOSGJ6NjZHMVR2eTZSR2xZVUlIeHl6WUhhREFz?=
 =?utf-8?B?cjF2V2lOaGpsMGhsUDBEZVM0SXEwVFdPZnBnK3V5dHZtVk9uNVphZFp4VkZ0?=
 =?utf-8?B?T2R4MTN4RVpLL3h5UE9WMFhZckNrb1h2dHR2TU55WC80ME1EdFRMd21scFJ3?=
 =?utf-8?B?ODJMUmdKSVdqTXRScm9WM1kyUXJoeTFuc2RQVkhsYXpiOVRXZ0ZKTDljdk1H?=
 =?utf-8?B?OU4zWVFXYldWWHp1ZzVPVGFHamFyVkZzSGNpemtHaEp5VmdkRDMwV1RJd3ZK?=
 =?utf-8?B?cTI2NldJMFU2b252M1VYWmxzdy9FMk9CakR0SHJjU1JTNThSc0gxRElmQ0Ri?=
 =?utf-8?B?a2M1UjVmUStLZnVCN1VWYXdJUjRJMXp4VXlxRWVrRWxhSzcyblovWHBmc1JO?=
 =?utf-8?B?Nys5cE5OV2FFZHVHVjVkMkF3NnpSYTVZZjJlT2tqaGFVSmNIajduTWtuQ1FG?=
 =?utf-8?B?MDFhckZ3THFEUkQrMWV2WlVqOTBuMUJ6K2Y3US9MK3ZFdzM3NTFhdDRPTFp4?=
 =?utf-8?B?NVBZYW5Da1h5cHRPSnl6emRudXZMbzdHQW9hWCtObW1qZUdSYWJhOTQzdTR4?=
 =?utf-8?B?NXA3S0hNRGE4QXRRN2p1V1JxRDd0eVJLOXZ4WjlJNytYUUNqVktBZmI5VTl6?=
 =?utf-8?Q?HQg/OeSxzOGZtrJ536EAHVzmq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c06ed6e-4a21-4f69-3653-08ddcdd88468
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:13:17.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOVDsTNkKxVc+liJp1fMezkXvbJ42WqZzm2ARcT9mD/fceXObiFoS8ThJH277eYEIXYyBI/CHZAZkeJo19yvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:13:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19601

From: Jan Kiszka <jan.kiszka@siemens.com>

This unbreaks the build but does not address the maintenance question
for the used packages yet (dh-nodejs, libwolfssl-dev, libwolfssl35).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use archive.debian.org in favor of snapshot

 conf/distro/debian-bullseye-backports.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
index f1461ab8..15949073 100644
--- a/conf/distro/debian-bullseye-backports.list
+++ b/conf/distro/debian-bullseye-backports.list
@@ -1 +1 @@
-deb http://deb.debian.org/debian bullseye-backports main contrib non-free
+deb http://archive.debian.org/debian bullseye-backports main contrib non-free
-- 
2.43.0

