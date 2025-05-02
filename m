Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52232C3ABAC
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 08:30:27 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.81])
 by mx.groups.io with SMTP id smtpd.web10.14509.1746174624963955262
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 01:30:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PXqJCQmk;
 spf=pass (domain: siemens.com, ip: 40.107.105.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+HjyXev86FICdfx9QhFUjS9hmF3zyJa/nDyAq38lS5bCL4vFJrBddEmMUb8HvEGG5qmU1oTELiH8TbWUvS3daCkmMvVIveJJMQtfDZSzrNfg5+4kpY7pnA0SxVMRSuerjgci1R6zmhasiNEIhRrtkJpbO46aNLtnrFjqUBfw/H0+FqAWvCUhF9Q7NqdyORDBmVAMkP+xsn3FqmSjmnPhriP6bL5jXABXYhck4qPicwox77H/bbQemUXsMw63JYBc6rj2rhRCy3UCDR4qpCtdxWw+M3ZKozbjDMxoIZSSeMXc4AdEL6gTwUPYEVNP13qstyEZds88JsV1AXTxeneeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBNrbPxaoo0/dPcFbnCvS7Yzswv/PWAVmFXI4GMn6j0=;
 b=BZdCnMsn5p9SdZoiqjEpPYJFbKThE7jJNIUsClYyT/PHZkF+D75Mk0yqasY2qzQR/4yxiaJOm2Q5E6WWISG1IqpYJInRhE05OyqXUr0M0XjVAD0Mxuqfom2ilAQd3DVImDVVKHmlEnhCjJcmB8689tbQhT7ksMORHksNq8WSsbyU//BxsHDFtoMWyvCaHi7tDsnffmEPupaW3uqW2Y8uoeafC3LzRznIbWwW2R4Pu1ANdcF3vz+5/nRmpQ1+xe37dyukA4hmv1fwPAy4pjuCQ1z2A1vnPPl7Lkh/1d0m7Ug2HbyxqQl6hIi33MxDszNaLs6DGJMFKZjYwHem/NBPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBNrbPxaoo0/dPcFbnCvS7Yzswv/PWAVmFXI4GMn6j0=;
 b=PXqJCQmko8Dkqp/2P0I+XGRqHuXm9W/jDUFeHDgi8wPoPQp1/97q9Aux0e0dSulV3kwFSpf2sOS+excXEuCB+P6LcG7lkw4u24TKmhv8grhD0JHxt1M2FVaKj559oq8xTAz9xBCO5N5AttJs9jHwQyyNOAW0xhMmpOVgSQHh7BQye0fYr342Dq0E38gpJ8OmevcLWUPK32FkQAYND+8tSOFLxaU938vG9euEwt7pYOVvJZWstq/196G8lpNh5+FFRGLJKBepU1DP3LlJuU0I4jbGpk6sr9Y1YL9a48iTv7C1uRtQaRbdEPxtbeb8/DeZjONVqIurDeLNWT5SttypRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 08:30:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 08:30:21 +0000
Message-ID: <63bb1cca-43f7-42cf-94a3-6796db68543e@siemens.com>
Date: Fri, 2 May 2025 10:30:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip97-rt54,
 4.4.302-cip98
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 40567a64-76d0-44ba-521c-08dd895393fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aElUa2dvODBaSm0zSWw1ODgyVmR4UjRZVFFYaVdwR2lTTm4xaTJHOGhyeHJv?=
 =?utf-8?B?MXIzWStMNGI2RHhnN0FVWU5peURaak9OTDdlOG9yZXVUcUVKMjJiUmFwZzJq?=
 =?utf-8?B?Y25jRGZpVEt4YlB0Z3JockYxMldNZjVENGhJOTRiNEY1ako3QzhqZDN1WE5Y?=
 =?utf-8?B?dWJPeWJxKyszaElOYlE3Zy9KdW9GeCtGRWMwanV0aGNmSUtFTDhDM3FSZHBz?=
 =?utf-8?B?TkVrMVNYcWhUNm1QWDF3d2wxZ1o1OXRudy85RXUyeEJaZFIrWGI0YXFQYUlS?=
 =?utf-8?B?WlNsUzdxUFdWN1d0RGw3TnhuaDhhODh6cDQ4NEdSb3F6elg1aE1BYXJXZlNw?=
 =?utf-8?B?bTVqVEkxYXRTNVkyWWlKQkUrL0Jja1V0VnJPSDJYcTdyTkwveHU2dUVpZ0ZW?=
 =?utf-8?B?Tmt1SkZsVHhGMWRWZSttVVBVU0ZOUTE0ZGNCaHl5OHZMaGMvSW5xeWRYQXFi?=
 =?utf-8?B?YkV4S3M5bjVDYlY3NWR1ekcrRlZVUU1JRzdEaHhaRy9wMGtnN0lnbkJML2lp?=
 =?utf-8?B?azF3cVBjL09oQ05hNTJqb3RGRXFhV05SQmM4T1BrY2FGVkV3eXl5djdScHA5?=
 =?utf-8?B?Z1QrT09ob1hkN0pEdDNSNTBkRlJoaDJkRDFsL0JhOGRWNkFyWU5SMnE0QjE4?=
 =?utf-8?B?aGlPRElYTHh3eUg5Q1hlakR1ZzcxbVFyMjBEeTYxZnl0KzNDeVhlMk1rdGtn?=
 =?utf-8?B?dzd2U0NZV3d1a3pMb0JWclVVdkJmTFkxUDhaQk1pbHlxQ2Q5NmRnSC90L1dH?=
 =?utf-8?B?SEZWdjBxc3NBYVk0bS9hbzNJNjlHb1JLNXIwL01wTEN0Tk9UbmFVZjhSN0xY?=
 =?utf-8?B?WEIzWWl1clFOTkVFSFlnL0s1Vlpob2lvUy9vVzBUT1NhcWNLbjJ5MlBnZmxH?=
 =?utf-8?B?REgzb2o3WHVxK1Y0aVVhekNkRnVsZ1EyaXRwU3Z3enNmc3Bka0l5NGFCYVpU?=
 =?utf-8?B?QXREKzNHMHJYcW1VSHo5NUxwTnRheTVVRExDbHRkNFFBRGtHMXdxSzJzamsy?=
 =?utf-8?B?M0c3K1ltdXVEd05XU2t5MWFONGVIcng3TDNITFl1Q2NYVXZpSlZUemRZTjBL?=
 =?utf-8?B?RFlOZDdmSkw0cmd4anlpRzZCTWMyNHZSR1c0dVhGcXFJeDN3emJsa09JbjQ5?=
 =?utf-8?B?ejB4WG1vb1c3OUN1dGFmMEtvNTR2WExZaDZ4SnNudkdIUzh6MFFHWFlFT3ZL?=
 =?utf-8?B?bzdNejJlOU1EbWNOYVgvOXNLQ1JIZng3TmhxVVhUUEtsNmdzYjEzNjRFR2tz?=
 =?utf-8?B?Z3hWejQwSjUrU3pEUmlZQXprZDR6WFkzaTBiNkhEUXh0NnU0aE53WVhMamRJ?=
 =?utf-8?B?S29WV1V5MTJrMkZZZm4veXBjd3k5aHRhdHJodHduV28xMTlxZWVITktWbFRG?=
 =?utf-8?B?THNQaUs2V1BaWkRYWUJXaUlMQVppNFpoYjAzaENlNTVFSzAwNWltRkY2bi9q?=
 =?utf-8?B?a1JxcVZESlhJTmRLTWdzM0haQUNjVTVya1RhU0tiZGYrby9XdVE0eWJ3WHQy?=
 =?utf-8?B?Y2VVZkNqUlZVUU41NllFMG5DT0lqdGY1WUozUGhiRkV3MUttVUlkWUFyakdI?=
 =?utf-8?B?dlVCOTRlMTdNRnJJeTZDUE1NNTlNVUhHbkFRRVE3a1NNSTRqUDZDc3gwdmpH?=
 =?utf-8?B?QTNoYXlBZEZ1NU1FMzF0VDlKSnB6T1UvYnVNbVVoVUNVYVJBL0tNNXhFQnI1?=
 =?utf-8?B?OVRXOEpkSmlRY3gzaGUrd3lwRTNMQkdmLytrdHFtaUR6U3J0QUZUNWNiWDRx?=
 =?utf-8?B?WU9qVDRtTEZTS0FiOXZFR2FJY0lRRGFldy9laWw1OUdKWHJQT0VXdnNKdzBz?=
 =?utf-8?B?MFh1aFBFSFNaY1RITHFZbzd5dW4rcjlCRWx6VmVZazNPSGNXQ0hMWjVIUXQy?=
 =?utf-8?B?V0p4NUJ6bHdsUjgyRnVFUE1rMitBbWZSSUZMbUZTOVdOeUVROWhuYisreXdZ?=
 =?utf-8?Q?U+wdgEO5Xdg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WW9tb0ZxS1ZhcmdXdEx6NmYxOHBxaGttV08vTTJnZ3lITStEaXRLM1ZNcm12?=
 =?utf-8?B?NjFWaUZWbzN2MThHT1hhcEdoY3ZheUlQMTNUazcwSk5SWHRmRG1oUEZkN3lB?=
 =?utf-8?B?TDcrd1JtZnZQYUxzbHQ5c0I3TU0wb1pqb2lMczk3SzVLVW1EUzdETjNsdjhL?=
 =?utf-8?B?anlsQk9udTFsU004dElmM29hbGxzZUtROWs0OE5GTW1OaWFvZWE4dFZTV25q?=
 =?utf-8?B?MExTQTBBZ3BiNE1CdkFNQ2UxeWJvMjNhazd0ZXFYR3Q3b2ViZklqRFVQbjRi?=
 =?utf-8?B?bmFBL2x6VFhjVDZIM2l5MXc5cEVSMVhtQ05GS3dMajAwTGRyZm5iRStFRFdQ?=
 =?utf-8?B?Y3hNejBpV2lwL2RYK29XMzFDc2VBNUVjVGxTaFB2dzJTM1d5dGRKMUlMT0R4?=
 =?utf-8?B?NjJ2d3MwZUV6UUhDcnNhQXVZWWg0dldWTHhBb2txVDUyN1cxNnVFYUl0QkhG?=
 =?utf-8?B?eTNLdHRuTFNJcEo2S2ExaUFsRzQ2S3ljbzU2K2EvVy9SSHJ3SmdUTlhjaW9D?=
 =?utf-8?B?Q0c2UEZqcWRndmVlSFMrYkRGcW1KdDcwSlN1VmlqOU1QenFaZ1hpbWxkYUtG?=
 =?utf-8?B?QWdoaHdtOTg2WXJ5NHpySXRvaG5SdXZ5dmZmNUFwL01Tb2IvRFlMdUdGSEJE?=
 =?utf-8?B?NkZOZ2ZJVTJhcGo1dXlOekdMbzVNYWpPQUlHQW1GeXR0dU1XanFYcHZiM2hW?=
 =?utf-8?B?U1B4OUkzOU1DcTNBcXhDeDZGbjNLYW14K0psSS9BOHVQRTZmTFFOeG83QlZE?=
 =?utf-8?B?Zm5RTzN2YkY0VCtnZXc5ZjBmSUdDa1ZkQTBoaXZ0V3F6NUNXRGM4eTlsYVRi?=
 =?utf-8?B?ejE4QTZMZzFWZVNnVnlRenU5UW5GMHJXVlFFREVrb1V4WjBnR2dPSjFuV2xp?=
 =?utf-8?B?UFhUNHhZMGgyQzJiU3lKcU1hdUQ5SFdTdy9OdFNNaHkzTzhNVXFOakowem5X?=
 =?utf-8?B?dDNGc3BROU5CR09UVUFBSzJubnVYNFZvZXpOek9iemhtMkgwMzFJWjNwTDNV?=
 =?utf-8?B?dGFhU0x4S2xBZ2hFRXZoeVFMZWI0TTZsekxBZ3MvcVJEUE1PaVlsMFJUSkI1?=
 =?utf-8?B?Z0N4eW5uVGFnRnhxOWhqQ0JKQ3NHUHYxcDlkQnNlNDc5aVRzc2FoWUhwNnNE?=
 =?utf-8?B?Y0pkQmlVQmhTcHh3QVh5MzQ3SWEyWm9idWlveGt5QTloUnhvZ3FtN21kbGdH?=
 =?utf-8?B?ZUVMNkhYaEZNVjJxc0YzWWVkZU90NkZkd2xGbmhjM3pCb05oWG83eHZ5Y2t2?=
 =?utf-8?B?cVBtV080b1BhL2pmQkx5ZnpvL1p4dFY2SnNpTElnZ0c0anZ0TERIUkcwdGZV?=
 =?utf-8?B?T1BGZjVZeTZldlFnMDBzQ3RGRXQ5ZFZxOWdjeVpJd0RUS3pjVGlRQjRIZVJ2?=
 =?utf-8?B?cCsycm02M29qbCs4bVMxV0dxVEh0KzJPRVkwUUhVL3hRTGtFaSt3aXVicVFQ?=
 =?utf-8?B?dTVkYTZkdSsxNVlaZlVQNzZ4dGJjMjVvYWI5Y3ZCcEJFZTRnci9uVjBWSStD?=
 =?utf-8?B?bXQ0N3hxc2txNHo2Q0ZDcit1czZad3JDVkpvekV2YU9jUVhvaFVhUjJSNUV2?=
 =?utf-8?B?K1lCb2VnMWRvNm92eVlKN21NVG9sNXVrYURQNmc0L3J3eHZMSG13NGxnb09O?=
 =?utf-8?B?Rm1MMHZOWURIc0ZRTUo5N3dsZzR2TWt4eGx5azN4TitwcVNpcmZ4TEtGeXY5?=
 =?utf-8?B?SHYwUGc4Ylp5VU1nTUdyOThxVm5sMkVCcURjWTR1ZnhXNEtXWjJHNHlERTI4?=
 =?utf-8?B?R2lBdGtLM05GUEE2WlRieG9ibXgzTzJXUzRTdi9oSmM4SW1IaHpLRkJyRnFj?=
 =?utf-8?B?Vk5tSWFKcGw0K1JnMWpqcFp6WEFDNWVjZDlBQityQmZVZk9vRE9Icysrc1JQ?=
 =?utf-8?B?RzJiaURJRUV5OGJjQW1CTUdnTzZRTFRXQzdMdVNVcFR4TmdXQmJlYlc2K3RU?=
 =?utf-8?B?Y1FBQmZ5dHkvYUhydVlqbzErUWVIZnB1ckhqc200TXRCVTNaWVVtb29mdXcy?=
 =?utf-8?B?K1hTZTFBRmpvdXA1MGhSTVdDRVBZMlBHU0VvVSs0R0sxMVRYQnBtNFVoa2Vq?=
 =?utf-8?B?M0pJM21yS3FTVURCSk9vMjQrUm4za2JFSzczLzVUWnAyWlZWd2pxR0Y0REMw?=
 =?utf-8?Q?iIpkkUWxl5avOhddcoLV1Mkrt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40567a64-76d0-44ba-521c-08dd895393fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:30:21.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAv8Zt/AAzsl8RuXBFjpUo+P/ykfQn31gO1crnJTtLjUkhXbAi1FlPV73DfyCKmhEcY8Sfxkoi1CzZW9wXBLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 08:30:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18755

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip96-rt53.bb => linux-cip-rt_4.4.302-cip97-rt54.bb} | 2 +-
 ...inux-cip_4.19.325-cip118.bb => linux-cip_4.19.325-cip119.bb} | 2 +-
 .../{linux-cip_4.4.302-cip97.bb => linux-cip_4.4.302-cip98.bb}  | 2 +-
 ...{linux-cip_5.10.234-cip57.bb => linux-cip_5.10.236-cip59.bb} | 2 +-
 .../{linux-cip_6.1.132-cip40.bb => linux-cip_6.1.134-cip41.bb}  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip96-rt53.bb => linux-cip-rt_4.4.302-cip97-rt54.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip118.bb => linux-cip_4.19.325-cip119.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip97.bb => linux-cip_4.4.302-cip98.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.234-cip57.bb => linux-cip_5.10.236-cip59.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.132-cip40.bb => linux-cip_6.1.134-cip41.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb
index 95ba0661..6d4f6ea4 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "591f3fb22080d25c3e41228b8da30ecb95cd4cedbccabb186df895e11a0debbb"
+SRC_URI[sha256sum] = "bda79ae2ec79d9f56c958703a0cb774d472a722c224b9f1f5239e3b820298b63"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip118.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip119.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip118.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip119.bb
index 218e3a81..4c6a1cca 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip118.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip119.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7dc88b9e0ddb5ecc7c8e248ce710806120e2efd281156938e8322841d0101584"
+SRC_URI[sha256sum] = "fa4074ce57bcbc0b33502e9af8c3999cc3059cb3a51454293126bdc90a944606"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip97.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip98.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip97.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip98.bb
index a33c565d..07fcbf95 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip97.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip98.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "96adad4dfd19ed4e277da07f64db5a0a7a8cd9ba0b854247a647d2d707c89ee9"
+SRC_URI[sha256sum] = "6d9676ddff825d5a54bdc0a05a7438ed9904add5bfd1c16605933be92be5c004"
diff --git a/recipes-kernel/linux/linux-cip_5.10.234-cip57.bb b/recipes-kernel/linux/linux-cip_5.10.236-cip59.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.234-cip57.bb
rename to recipes-kernel/linux/linux-cip_5.10.236-cip59.bb
index 9dfd96ed..5944fa6f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.234-cip57.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.236-cip59.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "4127b9d2acedeaadcb6e8c205adbbac06fc2018aef132de9fc7b295298980858"
+SRC_URI[sha256sum] = "7736cc18c665e9574d954eb58e1420abc2eebb17333c0b7508f2ed15e829c2a5"
diff --git a/recipes-kernel/linux/linux-cip_6.1.132-cip40.bb b/recipes-kernel/linux/linux-cip_6.1.134-cip41.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.132-cip40.bb
rename to recipes-kernel/linux/linux-cip_6.1.134-cip41.bb
index 16364537..7ffc745b 100644
--- a/recipes-kernel/linux/linux-cip_6.1.132-cip40.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.134-cip41.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "49a702507398f3ab10d4ad744b4561983fbfa6d92dde9e10a9582d7bddc7f32d"
+SRC_URI[sha256sum] = "ce52d230840ff625fe14a0ebc094c181a869f7004ff3fe28bad393d627d1dd67"
-- 
2.43.0

