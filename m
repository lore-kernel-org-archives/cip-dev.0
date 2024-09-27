Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E226CEBF9C
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:09:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.67437.1727438989018958437
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Sep 2024 05:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qSNDCNj/;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4oJr2VV6kMFiUQ2aI2ESwtOOmSMSa8qd2r89S+OP5rcmHlNsdcHwx09pj0uhgEapeAxocXW9+1u0JxB6GlGrHEy+QZGJRh4xi7vzMQL24FQQlTm4nzE0K03aJvosCRp1vIQX+nY1c2DLC9y+VK+EqtjEgDXde7GbWgM1T6S7J1f6LVlkTfetiLvz0mwN81e2Kl5zntVvZMn6n0jPorMHQsUWZEyFW7uP0jlMFGhLUKBk2sbxcYQ8AMryzwWgYNe6c3lw35qtCdfmCnHjadoNomK94dR83deX9r09BuIQ9wLr6nIvGwHDqtHikIXXYhRTDBGFXRbB+CXZjhdd259wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFafGZcHcObGDOAm9TCcg6Tsog5uXnj+tMvc+nafBRQ=;
 b=QJsmyzqFtxiNkreig8D0dY9ndsN3Hr0NXCTgu6QFAoavjEHNUDWK/NWft86DVnf+uq7/66SohJZoQoojSUsqvLp5HvT1oE+a9MP/JnjKc8TuxlmzXcVrcIdTh3DmgpFaoucL+NXcVZ4QJ0raHO4kGUlQ9UkAdD3zDahAnISWhmCOD/QIW1AKRSYfoeGNDdMgVHQGQN5Ll/UEvKa/b9gyMR/UPZx3MmA07PQJ+5HhIJ9mkIEVQmkWabyX+9ZssW2kMRI0sGsXL/ZYGaDCGB2cD/AZ2EFst+F/4U6ahHkmE0AcDxa0ih+uImIFRCtzRmrbFSS//AcylAge0agku6sEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFafGZcHcObGDOAm9TCcg6Tsog5uXnj+tMvc+nafBRQ=;
 b=qSNDCNj/dTUi7oDZgT6QFPxvwzCgoA2NtWEurd3akmVJphZvidpI92iYzbZAfUgw7gFPE39O+OGARXUCpJ0b3U2ELoZRv4RDUvJ2wrE6HGCnxvwZnC9/vgSmpBBax6JHGbjjpWt5fZJleDeFppAeJPlWTdzV5+YS6vuUU+e7UOoLgIucj4+7TFS+ugXROB3xG74RnLtPxPz4xWnY5UqP0X2nNOQzzE0lwu8zMAV/QM5+j/hm9bEtz9UPbBPGD7MaUp2hDKInMkTlupbUfwTDDJihkXyJ28WQt8QdXpFCicbk9W2JwaxCBoBonnPkpb4A/PMowqhFhbS3ecpYsDe1vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:636::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 12:09:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:09:45 +0000
Message-ID: <3ddad90a-2800-47cd-b322-f4029465d5f2@siemens.com>
Date: Fri, 27 Sep 2024 14:09:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: update to 4.19.322-cip113[-rt38]
 and 6.1.111-cip29
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: af5e3bb6-2358-496e-a1a0-08dcdeed46cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d1VURzJUUS9EYW9IeXIrd1hmVU90NEZ1eGkwVG5XVy91SEtWd1J0N1J4ampB?=
 =?utf-8?B?SS9wK2JSWURLUjFPSVliWnZObHVCelJQMTA5Y3ozY3pBYnl1c3Z0MkF4Y1FZ?=
 =?utf-8?B?REUweFRxcmVIQ2NXQy9pT291ODdFTEdhdHZQQ2VrVnVlUkdPWUhiL05rN1RU?=
 =?utf-8?B?eXliRWc1anJCUEt5VitSQUZqL091Zm84T3F5UnZNc2dTb0hBL3dCbUVmN3Y3?=
 =?utf-8?B?Z2x3bTE4d3o5YlZpYlVIMU1yUnltd0RXTzNsNGZiQU5rdS9Fb1NlSlBaNjBa?=
 =?utf-8?B?dEZIYVlQcFdwYW1MbjBaZlY5VUpaV2FIOEZ0bjhtNzBwMHBTQXQzb0dDWmpm?=
 =?utf-8?B?bzdzakhaNEQvclBVTGZXUlY1YlYxMHArZDY4SXlqMDlqb2lrdDRGSVdObXJw?=
 =?utf-8?B?R3pkOWNhUlByWXRJSzRRM3YxTkRCUlJzRWhWbXZoZ3hjYlluNmE5YklxNEg0?=
 =?utf-8?B?SXB6c2xXdmRkMGd0M1pEV0NIbkFYR0FFR0JjWTdCVW1oTjQxTEMyYnZobzZa?=
 =?utf-8?B?TVFla3pkaEtVRnFrZ0xTT21VOGUrZ1BxKzFORHlSNmZIRHBqMkZyamZYVHpk?=
 =?utf-8?B?ekNQbnkxZGJRZHVVTDRTUkJtR0FBTHpHU29QVDRNeVh5NzNnYTArbXJ5dERa?=
 =?utf-8?B?NEFxVHZGRzlkbDc0ekVsQVdRTTNSN2Ryb045dVlWRDZPa3U2QzhYSzluaHBs?=
 =?utf-8?B?a2QyOEcwTTVVYkFDTkpXT3JMNlU2MVUvVVhBdjkxcG9JVkFicFdKTjZCYnZl?=
 =?utf-8?B?ME4xemR3Wk4xOXR4ZE4rRWlLOEoxNnJKYkw4UGl0Q0NhblYxckFNM1liWTgr?=
 =?utf-8?B?ZXpGNU5QdERqY3Z5cXJFRVNiajA4VFBsd0ZFVk5SS01EWHdsS3hMM3JySnc1?=
 =?utf-8?B?bk1nVHpPaEk1RGpjbm9NM2xUd3VKS2dZdVNvNUJUYW84ZlV4Mnc5Rjg0R2Q2?=
 =?utf-8?B?TkFIZzJwRyt1RjcwSmdqcTVxRjdwTUlabk01VHExZURWMHRCTExGY2FiSWIr?=
 =?utf-8?B?cVNtVEljd2RKbVlqb0gxMlJpWWZZQkJjL2svTEhldHdIZVE2OEllZytLTTJJ?=
 =?utf-8?B?Vm9zUzdHWWVEMU44VGw3Q3ZuNEhjQkRZS20zR255eEsxNzhTMUpWa2tzU0V0?=
 =?utf-8?B?TzN6Ym03UXUvRFFOVjFxOGhubVN2T3dabHcxSWVvNUswSFJPVi8vWmtPV0Iv?=
 =?utf-8?B?TktzNGJUT3FITFhMY0xSREl3U2laT0ZPSitrRFJKV0VDYVZEWFVJc3daM2xX?=
 =?utf-8?B?cGxHb2RXYXRrWHJLZndyUmZEKzdHbTRUZ0tLNTI1Tmt4SDFyanBRYm1CSlh2?=
 =?utf-8?B?WVg1VmNxbU02Z1RsSkcxQ2pibHNKOXJrbDNpQnQ3eGN0WENSQTFQNDV6MGdl?=
 =?utf-8?B?bStBR2dLcDI0Q250SENDeXVReEdrZXJtS3E5Nll2VFZOWVUzYkJZajQxTFRy?=
 =?utf-8?B?ZVRUYjA2dXNodHdnTmI2MUJvS1RudHdaZmoxK2psYXlzQzRlWThBd0FiemVR?=
 =?utf-8?B?T1ZHdmJYOS91OENxcGVjZW1ROE1EVThHeTZRR3BJMnNieTZBNncrZ2xUMTI1?=
 =?utf-8?B?WXhleWxRSi96bWxLVXAvUDRxL0JMMGcvUmFzZE5FbW43M0IyMlk1RjNQeUd5?=
 =?utf-8?B?VTJuVGdMNjZBRFRMWExkQ1hFQ1hkTFliL1BjUWM5TVg4ZnBtVUw4dk02ak5l?=
 =?utf-8?B?Q3BiY2RHRFVETzNrYlBRTGJ0M1RzS2xTM1VGbm52bHpuYXBQenBucHNqY1Y0?=
 =?utf-8?B?YVFXa1FMUWMvWWFBU3VzeWxZd01zcm41Y2dIUFR3V2FnNlFVcEQvR2ZBNk5X?=
 =?utf-8?B?dkF4SUFqbWxQcUNid0pFZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHNBemxJUlN6dXBJeGJhVVpvT3l1c2JtR3R0UjNMZXpybnNGbkhnaXRNQzRR?=
 =?utf-8?B?NkcwU3NCMFNsbW1Dc2oxNDdRNlJqeVppK0N2aUdqeVdvb1BaZ1M3Vy8yVTV1?=
 =?utf-8?B?QnU5dVBRZ0pTdzFNTXlSTDRjb0xLcXVSb1BoWWl1SEVyc2dMcE5URzJ0QVdz?=
 =?utf-8?B?d1ZZTGtHWGtkTWtxeS9NcGMzQ0Z5QUtVMXN6MTJIVDdyd0VNMTBRdVZHTHlM?=
 =?utf-8?B?R1NXNktGQjcyOXY4WFI4a2NGbFYzYXdUcWhaT0NHSnJKak5ONC9lejM3Y2M4?=
 =?utf-8?B?a0pJOFE3Mzc5WDE0RWhQbklWQ2ovcHlabnA3TGpLbmhwd0hTRmZuYXo3OWZy?=
 =?utf-8?B?dzU2Y2hxVFVSYmJ4dUZPYnZzUDVvK1BYcEJtMkc5K2V3WlZjMDcwdkpjTUZw?=
 =?utf-8?B?eVJ1bUR6a3lXbUlEMFpiK1UycFEyanZTMktnWkhpUHVRSTZLeGhoeVZOQU1X?=
 =?utf-8?B?RTVHNm1XYWg2VGJpSVd5blBCY0o0a2J4Y2VRQmdjYTREMy8vRnNTd1FRdlRG?=
 =?utf-8?B?cXpYcEt5ZXNZYUxabFhqdmp2d0ErZnNiVEk5Z2ZTUGh5ZU9yZ1d5TlhTbmQr?=
 =?utf-8?B?dEhDMWoxeTV0Qmlpb0M1Z0YxRHRJMWtwS1M0eEF2azNWZzNUSVZhcFVZTVJL?=
 =?utf-8?B?cHRNVkg2K1d5bjJiZlo2T0dWT2FKRDdySmNyeUZxMC80T0NiU0xieTdCdkdI?=
 =?utf-8?B?ZHZ4ODZzcUZoSnFaZm9qRlVRTFV1Qm8vTEdOUzBzOFRBdlBYdUIxNDZrMTl5?=
 =?utf-8?B?Q2xHbXR0VkxiYlg4cXJhLzd5emxtRTJhWmhVemxqTHNJRThUQVZNRlhGbGkx?=
 =?utf-8?B?VFdvcTRLTW1ZOWpNY3dCTGdLdStLTHlVTTBSNW1OME1ialVmSytkbzdCVmk2?=
 =?utf-8?B?cm9HNW9XbTF3NVkrUWNQeUFjbG03Ykx4bjZBcmdXaGRlNWI4Wnd1L05HQzZD?=
 =?utf-8?B?bTc1SHZ4Szdmejdta2JuYmdjdjc2TFpXcDRzamF0azIzK3JQeHBRU1JuTDg4?=
 =?utf-8?B?OUtXN2JGOFZQTlJoQmY0TlN6cDRQdFB5b3pSL1RCdFR1Vmdkb1ZWUjlyZkY1?=
 =?utf-8?B?Wk0weThkOHA1SThFcExiYWVLOFVhOFF0c2ZkQlFHM1pYUlJmaVBTbTdwd2VI?=
 =?utf-8?B?QkV2NHJCcmczOFNqMlpNSDVIYVBaZGpWK2tLM09pbnd3TkNoaTE0R2xCd1ZY?=
 =?utf-8?B?eUZzVk8zODJkOXQ1WmFVR2FwbnBzcWs2bU1QT3FpNWtQS09sNGp0L0dkMzRn?=
 =?utf-8?B?SzRta3hzMkkrc3Q5RXBiVzBlM1RVKyswKzkzem1WRnNSeFVucWtMNFJTTVhh?=
 =?utf-8?B?REUyQllYNkhoTmJ1dmVIbDhjUi9NTFJ6RktSblMwQTY2bUM0aHJ6SGFKR0JB?=
 =?utf-8?B?YnpSNUwvSWQ1b0xnM0FMdXMwR0hKNTBIN1QwSlFQaGdaUGl4cTNER1gvNWFF?=
 =?utf-8?B?VVU0ZmFVazhPckNiM3hUK2ZRdDI2cHN1bWZwa0hUYnV5TlhHZzFWbkRvbjF3?=
 =?utf-8?B?enhGL1R1bUYzVUh6QTVWU1lINVZVSUNnR3JCU3JHVzVLTmZNQ3lOV1NkM1dZ?=
 =?utf-8?B?NEhIUEs0R2NNVFE3VStTOVJpejBrRmtGenp6cWxnaTRiUDFsZW80ZmJUWDg5?=
 =?utf-8?B?V1QxcEl1dHdYaU1nVFFOM2pJNHltSjVXZ1AwOVpNQldINTVYYWdhc3dVQi9X?=
 =?utf-8?B?V3FYMDY1alA5L3ZObVF5M21UL1RzVTBXR1ZIZXMzcllML00wd2hVNW1rajBY?=
 =?utf-8?B?Q3JxQzh0Z3FCbTBGRmh4L1FjTVloeE1EekNqYlIvR3JiRHV1SXBDVVBwMjYr?=
 =?utf-8?B?ZWFZdmh1WnNpSkt6aTh2L2pQdDA2ajV0MXZPWEJIb2tEYk11Q1AwaE1JWHR3?=
 =?utf-8?B?S1cxYVFRWFFvZHFZaVJHV29wZkdiMmRIMkIzVVMwZVhBcEZUaFZYeWhLNUlo?=
 =?utf-8?B?L3B1RHZuTXlFOW4zaktQRlpKQm9HQzh6SEpuRnNlK0lkOTZxK2crakM3aWlq?=
 =?utf-8?B?SW1GRlVuVGlxOTR0czBxTmg0LzNpbFFpd1pmQXlMbW1wZzNsUGhUVEw1cnAr?=
 =?utf-8?B?RjlUQTIydXNrcmh6cUdscW43TExybTErOHdpNUFwb2dRRC9ZRTVkRStVNmRV?=
 =?utf-8?B?ZHMrMDdqZFR0NFBNUEVEajlmcC90S2h0V2Q4RVU1Z05OaFU0TkNpVThpeWRL?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e3bb6-2358-496e-a1a0-08dcdeed46cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:09:45.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsEmrqw6U2VE4BV8XVQayyWepnBsgNd36XogmLVY6JkQ+XHvbPuIhhxBh+HybZfENra8Efqhtz4jbIRNvlfI0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Sep 2024 12:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16928

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....317-cip111-rt37.bb => linux-cip-rt_4.19.322-cip113-rt38.bb} | 2 +-
 ...inux-cip_4.19.320-cip112.bb => linux-cip_4.19.322-cip113.bb} | 2 +-
 .../{linux-cip_6.1.107-cip28.bb => linux-cip_6.1.111-cip29.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.317-cip111-rt37.bb => linux-cip-rt_4.19.322-cip113-rt38.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.320-cip112.bb => linux-cip_4.19.322-cip113.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.107-cip28.bb => linux-cip_6.1.111-cip29.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb b/recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb
index b8c2e5f0..1b25f72f 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "693b37345f7411f4f5b81e2f01cad279d23186c3d633938bb4e8f06637ebde3f"
+SRC_URI[sha256sum] = "eac40d6041d66b3a1e9c1aa2268a431c03c096f04008e94a079a3bad796470d7"
diff --git a/recipes-kernel/linux/linux-cip_4.19.320-cip112.bb b/recipes-kernel/linux/linux-cip_4.19.322-cip113.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.320-cip112.bb
rename to recipes-kernel/linux/linux-cip_4.19.322-cip113.bb
index d01d429e..61b3fb70 100644
--- a/recipes-kernel/linux/linux-cip_4.19.320-cip112.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.322-cip113.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "15a4aae7d9092fc0a75fe677712f45c2fa0ad561ed94e4ce6dff9a9104039840"
+SRC_URI[sha256sum] = "c968af618a23cce994806597446c1a40624b52034ce77c2879a5677af8de66c6"
diff --git a/recipes-kernel/linux/linux-cip_6.1.107-cip28.bb b/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.107-cip28.bb
rename to recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
index 4de454b6..b4db33ab 100644
--- a/recipes-kernel/linux/linux-cip_6.1.107-cip28.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d7d491b9617751ef83e71fa9380a5d6b851ae90f30096b3debbd0d8d5b81cabb"
+SRC_URI[sha256sum] = "1aa412d9eaa31c566568537cfd9149cb1b12449d937f93b693c97a425b47b89d"
-- 
2.43.0

