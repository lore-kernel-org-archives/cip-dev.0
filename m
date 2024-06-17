Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B1C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 10:08:34 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.53])
 by mx.groups.io with SMTP id smtpd.web10.53287.1718618910423919544
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 03:08:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oW9COMs8;
 spf=pass (domain: siemens.com, ip: 40.107.247.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij0Qh7ofL3x8HeW7hMpPH8Nbj/hyWuK9TbfyaTt/dCmETa2IoKTdBYAJnmmoIX9OpW5owd7YQdPUwSHj8paFoifJR2ImdVzDD4xMOQ1Toxt0esN2cX80Up07G7hkgQH9BxAjIc1oNZEVFF0k/9FK4eM/H6O08zdtbd3cSHQLstD7mPmAnnDI4TgNqgUsNJvAck9ipXo1HZtUg76ubt2bhQLiXct7S//a3RMlpdZ1VyUuJnNz3vnSzQr/LrhKbY144HHNZdprp5es1Ycx+auCqJ5ynzV9SoDO5CskSj44Lsn/X0ZT0OblmPWTajmlvTYNJ+65d9IHU6dmBmVi/uD/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX+rLbrVQz2uKUw9S91qALDmzEJRRzr8dpRFLC9z+yg=;
 b=ZVOziY/jb59O6zVw+kXf6bobxfVGgNet/F917Kptm2sHE/KN1wRtPKW2yJcF95fPnFVPJrAypVZWpjGKiFtotVPw6naCEJEcvj3F/FGu1IPD5wfsc4CXRQDb1a8x1ixFNJz74wHqXkCp4ebah7yBMbnEndzUTWuSJh3eKQOKkQ2HwF0NNy9LmXUzVSIKxwwXREFXu9oC1CYy/tm9v4jhfHoIXbGMflJ8hM1fjV7wTVSd6fqk5U5cbYBY0D/GQy7849Y7DdTgrqq+aF3mSIG7LkRcQYxljqL73mW8wjgDojkAm+v2K9DlSJ5RLER2GsTA5xVeuLARy74SH4/aZMviYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX+rLbrVQz2uKUw9S91qALDmzEJRRzr8dpRFLC9z+yg=;
 b=oW9COMs8v4sFnpGfbBztx+9KXR4vV9+9vz+8Pxy9g3wT+phMn63GL5SC46xj4nHvb6LQ18ZUfuCKsc8QR3H2Fxm72b+slmd5wjlIa/n+BCbdZrFV4wrBRts81RU9qmiKvK1fAQLiQlVutaS+/y2CCQll6Mjbt7gxSo7/hv+xeis0+YxR/ZPtBsAF7F+vvuF9RzbNRdFmyGTOQq25rpexMk4V9OzvJsBzO+Pkk8Q+vbAxUmY3crNjTuNN1mgIw4bbu6FVLUXN0AfSGy6SH0UobL+pnvvq1uv166rgA1smsOG2K3gvOkyCZ7XdEM26NFjg6eK7Z2hjbRqUZmsdq2SgFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:08:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:08:27 +0000
Message-ID: <81ed4a9f-4efd-4185-af20-4389f354fc69@siemens.com>
Date: Mon, 17 Jun 2024 12:08:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip88
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: af7cb404-06e0-4cbf-4785-08dc8eb56e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2VxR0V4OEU3VXl2MU9STGNxcnJPdVJxZ0lCY3JBaS9IalFYWHBDb3NNUkhS?=
 =?utf-8?B?UWRRdit1My9CYVpiZWdiaWo4cmhoTE9QdmdjZHVDaC9oZVYvS09UMnc5NE5v?=
 =?utf-8?B?Um1jS2FPckpuNDdNam04a0x2SGZVejZuamNhNjBNdlJSc0hxRGFiVGR5TGRl?=
 =?utf-8?B?MzlEbEdpRUhsOUxQeEdoUWlTUEFlQ1JBMFk5WVhhKzVackVkem15MGE2WUor?=
 =?utf-8?B?Q1d2bDNFZUZSWTNTaGE3T1QyRVFQVm1jZmsveGo3YXJReEVmUWU4NVFEbUEy?=
 =?utf-8?B?SUZ2ejl1bGZaUGFXeGkvOFBmVUpXdHJuNEZmbVd2RmlLMUJWK2llZHltc1JT?=
 =?utf-8?B?Qzh2Qnd5VkdPMUZiQTdMcHMzWS9iVFVYREpUNFlxYk1nQmpPTStOZU8yKzZz?=
 =?utf-8?B?SHlHMDRwa05RcWgrdFNXTEpETGJqRkZKeHc2QnY3dk9xNzhPOXRZbzNQMDk2?=
 =?utf-8?B?NGRZeTdiQXdKVzh3dWRUYkUydDFYRmc3cEw3bDBrUjVHTEk2S3pVWWdkajJE?=
 =?utf-8?B?SXA3VU1zNXM3cmpoZmtEY2dQOHgyZ2hyRmVSZEhvbXVPVW1OdjVHeGkxcE5Q?=
 =?utf-8?B?U29NVHVKS1BNTDNEZjNWSVZMSmtrcGhvQlZvWnpVazgzM3VkVXZsNjViQjVi?=
 =?utf-8?B?bzlQMUcxeDhlUmVRWXcwMEFHd3BPWWVuM0U2cmJCdWh3R3JlNzJUWCtldk9O?=
 =?utf-8?B?M3Z2M0VycUhXSUlUOTQ4V0dIamlKMXpSUWcydWZDRXpmclN5c2l0Ry9yWU93?=
 =?utf-8?B?SEJTU1k1TU96VW5qVEdOSExNbDZoWUJTK3Y0MWNkaW9uRGdOQS9jZ1JCNW91?=
 =?utf-8?B?Z2FKdlZYQWRYY2VxSUVZUkJ4ZXZsN2RoUmlPc0FGelM2MXU3SHZSWUlibjV1?=
 =?utf-8?B?b21FeWxWWm0wTFZGTFRiVklmM0xXQ2xKM1lVM2VqKzBCd25uL1dNMEpXT0dS?=
 =?utf-8?B?SjZMd0pha0gzTGFrUG5LRDQzYjFsaWpSTUtucTF1OEI1dDArZWNXeTFKV1c4?=
 =?utf-8?B?MDE0SEp4SHpKaGRtSkVlYzhEVmJFdHVKZmFRemI0aW9WQkZwdEdiVC8wTGg2?=
 =?utf-8?B?RkV3NlRucUt3SXQ4TzQxdzVCRURHUHhWbzdTK2NFOHFZODVoSlE1U0FtZGI1?=
 =?utf-8?B?K0ZkVm9MZyt4Y3JrRm8xazRlcS9mcVh2R3l4U2NIaVZOeFJOSGhJMmlOV3VT?=
 =?utf-8?B?T1pIam9NWW1FVzN2TzJNU1FLb0lOU2UyL2dXN0Q5bzJncndoaXI2cGk2WTRQ?=
 =?utf-8?B?b0lWbEY5QjdKMWw1MVo2YWorY3FCUVdTalpkVmpSekcvTjFhYlNFay84WVNK?=
 =?utf-8?B?S1grMHpocW9iQ1J1QUpqVk8wSjRud2RjV3Zwd2ZRNE1nZUFJVGluOTZtK1N4?=
 =?utf-8?B?Tk83R2ZHbG1WeUhKNGNEdXFIK052b2pJNmo3UFcrQkVKS0hnRVcwR0RwbFhx?=
 =?utf-8?B?UVQrR1RYazBpLzN6a1M5TjNVdFE1T2NqUjFaMUFWWHgxRHZqYTB3Z3pHK1RE?=
 =?utf-8?B?RzAvMWtZSlYzNVJrV1F6bXJ2OEJrS1JQRWw3Z1BVMVVvc05pbXd6L2ZTSUZv?=
 =?utf-8?B?WGoxN1hhWUJ4QkdjazJ1eEtIK1pNRUNMRFFLcm1RKy9xQ3NvZGZQOGp4YkZG?=
 =?utf-8?B?UjkyYlJoSFJ6OG5pMER2ZmZPeUc0YXVGRFVsN3h1akw2MVdzd2tDV2FrRGJL?=
 =?utf-8?B?SXVnYXgwdDZ6V25jOEJkWFFCWGxuYzZQYVhudlBLRGFwT05GVkdnZ1VKWkxv?=
 =?utf-8?Q?Qd/qoi2P6evC6kn8vBRmgT8fxLj1Nn+k6WzXx4q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STcrOWdxc1pjK3I3RDQ5YkV2MWhtdDJ3MlF2d09MYWJnb1B4WlE5cTc4ZDg3?=
 =?utf-8?B?bythNWZrdEVYUG5EYzRwOW5pbHFUTXcwcENSQ3hEa1grQjh0RDdESkgrSUZS?=
 =?utf-8?B?M2tzS2txUFZJRDExWkdoa1BCY2tFb0VIYzlqZnE1REJuNnVZQXNOTDlNMTN0?=
 =?utf-8?B?S05rZmVIR0IvT0NVNnNlYnNLNGlRQ0hsNWJzNDM4WUpGb1Q3Q1A0bVE1dXhN?=
 =?utf-8?B?UkVqNFdyMHRwYWNra3FKdm5TeURBOUVzL3hzcFRtK3RSVXpMbGNWeHhQRWNp?=
 =?utf-8?B?K1VOSGpIYVJJYXZhWDlxZENPOEJCVlBwNGhyYlBWbkZscS80SlpsM2lRRHQr?=
 =?utf-8?B?OEFNREl2RjYwOXUvYWlBSklla2ZEelJPR0VoNm8zTlZ4N1JzdDRvNCtaQzRF?=
 =?utf-8?B?U2Jya0hQQ0hrdGxrbWF1YmN3dWErQjZRaFpoYlB3dXBsR1ZrL0FiZW9xNWRH?=
 =?utf-8?B?SHBTQytUY0tTOWFDUTc2VUpLeFlkTmptMXJSUjYreGcrMDV4WkdDdHV6SWc0?=
 =?utf-8?B?UFBsYjZvN1VIUk5DZG1Gdkd6NC93dzQ5bjhaY3htMDBXbk9XSTkxM3VpZkpB?=
 =?utf-8?B?UXZvNzFpaUwxa3l4MlhJa20zNXFLUklTTzNFdkZzMnV2bHEvbHZXUGtLd2Ew?=
 =?utf-8?B?VExMbktnRzhDSWlMaFh0RzVHUXdjclBYUk1tYzRCWFZxc1VmQlREM2h1djhi?=
 =?utf-8?B?emliTDlBVFdYV3ZicFNldjhCbnFhSEtWbmdqR3l0T2ZEaHRVUC9FK1NtMWh4?=
 =?utf-8?B?TWNRcGtBckJaMEgxcnlvTmdvVkR4d2VUSmpFcEVJbzV5UEIwVkYzM2o3ZCts?=
 =?utf-8?B?bStVVVpNWTJCdTljQkorMzRHcDk2RWFiMytEc292K1F1OUgrK0plS1JZdE5N?=
 =?utf-8?B?VGlWVzV4N2ZGdlQrdzBBL3JVRTlGcjIzVHVXUTFaUTNaZ0ZnLzVzUFJPZ2xx?=
 =?utf-8?B?aHk3c3lKanNLUGI1UytDbW84SmNMWjBkMHRSZ3ZTZXFPVExYbkM3MVdQdVJ1?=
 =?utf-8?B?bHpHR0lnU1oxcjVNRmNFZUxjUjRVNktxRWREVVh1MmFIaStRdks1NjByemFs?=
 =?utf-8?B?WjFKOEUvL1RHcHZwb0E4UTVqMWJ4NUR6R2ZMQ2pFTFhwaVBXVFI5RlVXRitz?=
 =?utf-8?B?ZmJMN1d0cmswTFFkTEpJQmRkQ3BjOHhGK0oveTZSTVFCd2wwaGZrU0dGaGE2?=
 =?utf-8?B?QURUeWdUWk5qZ3VTK2h1NW1UVHlUMDFQVkRVeXU2bXZGMnVnUFRsR1lnb0Zz?=
 =?utf-8?B?VjF1MmRmTk9VbXJMT2lIc0FtL29wN1p6MGx0S2xQeE5YVVI5eG5aL0VjNGVD?=
 =?utf-8?B?NUw3RmY5dlZKZGdpUk8rcFdRYlFDRngyNWI1VmR3R2t3SlpZNHAxV1FuM2RV?=
 =?utf-8?B?ZE9wZTliazdtM3FJSzROazVrbGlqaW9kVWhSQTF4b3FxN3poNFpVdHpGWE1X?=
 =?utf-8?B?ZkZabm1MbzRFT2VPcXJuTDZ2ODJIMHQ4VkNMME9LY3BnMlBxMHZQQ1hSdFRQ?=
 =?utf-8?B?cCtUUE9RZStJWjVVekxqUjRZRENYTzZ4L3NEZlU4TVRpTWdnVk8rY3diYktM?=
 =?utf-8?B?KzFwNEtIMytGYXkya0gwTEYyUHY5WnlQRVc5RG5GVmpWUzBnYUlURjgwdTBw?=
 =?utf-8?B?bm1oa204WDl3OC90RkwxaXBPSXRNd2IwWDNTWWZnbThKcXFQcmhzWkNQNmcw?=
 =?utf-8?B?RjVzUTJzbzBqUE8rc29WK0RlQmtFclJIdFRkY3pwNjNDZmg2Ym5iYWVsKzg1?=
 =?utf-8?B?dHkwWGlRWjZuQitqaTlQTFhTNVRBRmZTeCtvZnNycEFaakF5THJEekJIVkVt?=
 =?utf-8?B?ZlNuWXJJODZPVHdadm8rbUF6dTlKN1VIMURmSnRDcXg4TGRIMzNDV3Vvc3Y4?=
 =?utf-8?B?R0JDMUZGKzkzMEpYdlRVWSszMzR2TzhBTEZEN1RQemcwYzQ3WktLd2xmQ212?=
 =?utf-8?B?QWJWcHBuMmJmeVRiZWF3Tmh4a1pveGJhdVlvY3F1bnJ1OWN1K1NYOUY5QzUy?=
 =?utf-8?B?WWtFekNNbEd5Z1d5bklqeitlSWtxZFgxY0VGV2VqaEcwZGVVNXBEL3IvL2Vt?=
 =?utf-8?B?U3doR1BqNy9OWjJHYnk3czgwaWswV1ZFamkrejBHYkVNU2l2MWpVTDVaSUt3?=
 =?utf-8?B?TDEycFBCS2piZHhsTGlQK2lhR1F4Umlkb3JpZGNwWWxOYy9aYXU4T2pnZHRs?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7cb404-06e0-4cbf-4785-08dc8eb56e51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:08:27.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8/CSBk/uQjhkndqPFw9gQvfIln8k7hU5l/od8LyxDudmFWIxdhNDgWh5coIgtTLRiPK0Dmf5kNmQHBNpfZOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8267
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 10:08:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16260

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip87.bb => linux-cip_4.4.302-cip88.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip87.bb => linux-cip_4.4.302-cip88.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip87.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip88.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip87.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip88.bb
index 4af5acd8..6316b018 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip87.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip88.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "439c904acf199e2cd7a6222c214c97c71923f43b511373ea3d110fe02b3b164d"
+SRC_URI[sha256sum] = "5135f05d426126ec6776198ccc9eb1679785a9b6b52d5ccdba1c71373bea50aa"
-- 
2.43.0

