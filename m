Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D4D5C0FF
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 16:18:06 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.60])
 by mx.groups.io with SMTP id smtpd.web11.16804.1731082681052808669
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 08:18:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Hba4/lVY;
 spf=pass (domain: siemens.com, ip: 40.107.103.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyPaL1B1uf64vlZrTQ9+6FsXspdiip6xyxDMqJy2c/HhxC68DvJD8qHW/KvAv8Gk3DkKbs45asUha5PfolYFoAc/8JKZ//tu55lUE44RMT5dGfI0sUVN+gKJq836XlQhucLEo3KGerCQ8CY0LZpyvd4zJEb7TEqJONA6IxuE5tNcxyn7WfGCzdXR97siqz2rq4S+3jJv4QPeCTkvzQEKibylTIjnp2agliTXrnoWKsQQku2taQzY8tuCsHmAar8DOryccVdF6+AC7vf4JMB3X7HS/74W5cHRQMde/DL+IVYkQWoAT2hYMXXe6W/jksCgsa9lECVQcuwq8471kg11ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocngxpKvYFn1Oh/5YzFHRTeiFfMh6DXsQ3BDXAvJEaI=;
 b=y/8QGbejdtrIVyLXrG56gHdMgNJCmid86a9TroPkMAlHwKIrgJXSTGUmucbANR0FX40rcJlpo1o8KVu8dCsbfQljbKcO0x0/M9hXbcOYD9llvwhHEnADF0PsIYmM1U0eNCR+AqJy8ZLy9jJJ7bYx9MzbKj4Tvgm+IEBG9b4dcqEDsSxwZeKAnDEe1KIgFyTNN5XGWtJd6X7vDo0lDdQOHC1VSejYqz7Bxfv7r+7yxEq5Aqi00Z+hXAieBRa5TyCC1ciTahzzTK2ntbISPk9m7/PbnsljbcNHXsPIRpeq7MJ6/uzRe3CG929CWpSkzxKitiJF+D6lVU8vtZKm8jEsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocngxpKvYFn1Oh/5YzFHRTeiFfMh6DXsQ3BDXAvJEaI=;
 b=Hba4/lVYetvcx7rt/fjrQVX9D5sMpbnSbrQ8eIdTbpAYxwqRd2vWuel9o4qeq08PRjhWTrEnsRpcmFdJCUAG0hoGdmCPoYNd9epqvWfKQ/BfannTPlOH1zcR1P4wqppYC3RYgxUbkMo2zfbttX3oIdy7oQqhKf8XcOB/cno3+hGVsebMXpHlrSbQiLYIsz4mdTTbq5a3VXWBHe64onb+E46jFLvzWbVQagrw9zn/gMPpD67gm1fOGqy6dMT2JwRny1yV6dURSPrO1yOp6QET7JdL8gfztNnWiy1cGwxbaj83cScL2K7sAszzU6cAE5L8uncaPMvOyl/D8jZg3oxrfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16; Fri, 8 Nov
 2024 16:17:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 16:17:57 +0000
Message-ID: <ed6122d2-113c-43d2-a6fe-8bab867ec51d@siemens.com>
Date: Fri, 8 Nov 2024 17:17:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
 <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
 <AM7PR10MB332073758FFEA64F2CAEB1A8865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB332073758FFEA64F2CAEB1A8865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: d35bcbf9-393a-4ea8-9819-08dd0010e820
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dGljTEsxd0pTWU1mS1NINkhvK3VnVWJybE5RQmtXVVhJR2NpOXBGNldueGEr?=
 =?utf-8?B?YTBmWEdXU29iZjFIWEIweGpMLzlQSHRpckVzd0RRbEZXSzJycExJdURHN0gy?=
 =?utf-8?B?RlZYWlRTWEoybWtLOGFzM3k1STZuZUhWcGcvZDlTTzBXQlJ2ZTdxeHMvM1Zq?=
 =?utf-8?B?b1U5R3NlczBaUTJOL20yeWVjTzZieXNQMjlJOXpTTUkrenV2ZzJKUmpxMEVH?=
 =?utf-8?B?RVNmYi9kMmtIRGd5VDA5cnB3OFQ2M1NFTjgybkVCWnJEOHdMdWVuRnFUSW5W?=
 =?utf-8?B?dGRPME01clhqZFhLeFVIWi96YXIyK2FjNjhNNldsaTVZT3UvNEFoQXM5RzZC?=
 =?utf-8?B?ellWMkJCcXJDVVg4NnE1cC9OaXNxUitkQjFPRXhtalRtVDBzVzRkN25mZDhD?=
 =?utf-8?B?SUZzRHgwOExaYW9oeGo5VmFwbTZhTHpzUVR1NjE0ZEhnYUZZemZlaU9NQk9t?=
 =?utf-8?B?a25JS0JKSDhIZ2JtRVpzN0tlZDUxbE0yZFV5d2RNYVFuK3NIUHFTTkw5REJy?=
 =?utf-8?B?KzNYN0YvVzM5enNteDNGeFdpQ3puVHZ0dmM2MEM2cHViS3g0TEtsbFZwY0c0?=
 =?utf-8?B?Z2ZBanp0V2VLaGN3aUtqTnBpbEllbGNpUDAwQkVEclFHV1Iyb0p6anpPOUtS?=
 =?utf-8?B?bTlWaFZHUkxYT0NlZ05tQk5KUzNPZmw0c2UxVmw2RURXazIySjJ1N1doNkhJ?=
 =?utf-8?B?Sno3NDlWREhEMVpZNXhWOW96V2ljQlpzZSs2VjBLYStabEtidzRETzBkNGhM?=
 =?utf-8?B?MGRMMzZuSXFpSE1YVVVtY2pQSjNNblFxcTBpaHlGZGp2dkpzSHhMMjdHUnZj?=
 =?utf-8?B?V1NkRTQxYm9FQVp5VkFHTWIycWhvbzVCNEF3WHdLRDB3NmdKL1FtOWNKY1ZG?=
 =?utf-8?B?ajdrcW5PZGRWYy9vYy9mUERweUM0WXR3LyszZ2FuWmNDblVBaVNLTExudUll?=
 =?utf-8?B?N3JrZUVCM2hFd3daVDFFUVNCVmhzRnJtMVBndVk0K0p0aVZma2dDbTR4WFAv?=
 =?utf-8?B?RFd2SjFsNjJqR1Q3SDNZbDA2bDFsY0VTLzBWVk91bnV2ZTRlSEFpN0ZuN0xm?=
 =?utf-8?B?ZWlpNkUwMTFuVHFhNXhUWlJUckxDUGVYQjZTR2R4VkVZWm42clp6aGNrWEVs?=
 =?utf-8?B?ZSs0clNsYWIzVlJpSXZLMnhpSUxub3BZYUJ3YVlmbGtvRnM2Vmd3WWlLZ0py?=
 =?utf-8?B?ZnlndEw1TXowOVVwUlkwNGRjdzA4VjMvNFovcWttOFZpeWkzZnB4Uk5qSWNW?=
 =?utf-8?B?K3lkTGdLcDI0bC9WY01RWFBkV1dmb3h1U003MVQ4QzFrdFN5RTVxUVlLSFQy?=
 =?utf-8?B?WU1pbG1tY093NjVSamE1ZEdqWGhBekZJelpiRHZncDZveXEwSWxCQWdSakkz?=
 =?utf-8?B?WGxPQnkwRC85SkZxN0NBUDlwWUthWFBGeDVXRFZQbmZjT2dyN1BuTUNvRzNp?=
 =?utf-8?B?TlBKZG1QRHNxN2psa2VIYXkydU5HTmltMGlyTjVYZXJ1Z3FKRlNUcWw4eXZI?=
 =?utf-8?B?OWEzc3pKVVZSTjNjZHBpeUFPaERBM0krYW9IUGNIT2c1WHpHUi9nQ0VxTXQ0?=
 =?utf-8?B?NnpnVkNsMklUS3R1dE9LOHBVUjgxZ2tLMktNUjlsNUFKUmVxeHo4clNiTWx4?=
 =?utf-8?B?ZzVUVEJVRDlRS0tRNm5PZFhOTjhOb0YzaUhXR2srbUMyTUtYVXlNWCtxVDEw?=
 =?utf-8?Q?sK0MtYjn/RU83No7itfh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXM0UVQrMlZla2VCc01BV0tSd0lHR1QzTEFYV2ZuSEN4SHRtaS9nVk5BNEZN?=
 =?utf-8?B?UE8zRlE2b0FERmwwb3Z1Q2c2T2Y0ODhNN0t3NTNvT0NXUEdRRjF0NEp2SEF2?=
 =?utf-8?B?U1ZsMXBHK2daV1FZQkVBWXJWb2g5TVdodWQvdEpTZzV5Vnd4VitFNHVhanFh?=
 =?utf-8?B?L085OUwyVjJBVHlWNnIwNzR4RlJRMjYrWkRKcEV5ay9QeHhDR3gzUE90UGdF?=
 =?utf-8?B?b1dKR1Z4Mzh0a0IvdUNGWGszQ0dsTWZvQXhNamtTSGdqUGpPbysvR2ZRYmMx?=
 =?utf-8?B?UWxNeEd4bkF0U0hFTmVHd2RRejNvMkFkVGFSMVNYaGVNR0hmL3V5eW9rOUdB?=
 =?utf-8?B?dnBTOU02aWljYU9QR2dZQk5xWXpsZGRpT2RNZlNseFk4ZlgrTk5wSy8zcEI3?=
 =?utf-8?B?eXJRcEpjcExtSGdkeEFRV0FDQkNaMXU3OFpjREtPZVF3VW5LN1NaV2tkV0l6?=
 =?utf-8?B?eU4vMDZFb2d1aXZaVTlxbzBVdU1BNDhYa3VqMVJJYlZqN0ZuckdCdzcrMzdH?=
 =?utf-8?B?WUZ1TUlVL1c0akQ5eUQ5NGUwNVBMdzU1UFZaVThobFZnMmdWTjdXT2VKUHZv?=
 =?utf-8?B?QjN2R1V6bXNXWXRUY1NWRnhwZTlVd2tvWGczZndSV3czeE1uTjIyeTJPZ2tL?=
 =?utf-8?B?T3lIejViTHY3UTFlRWR1Q1ZaZVF1MmdYd2VGQk9lK3dSQTkwN2FCcEF2UlZx?=
 =?utf-8?B?Q0JHQkcwRUhTYUZwN0UyaWUxWGZacVlPTWVITm1nMzF6alRXZWZlTEFzamNL?=
 =?utf-8?B?WW1zWS9YVTJ3Ky9laGVjZzl5eEpSMEE4ekpNQUYxbWhKcmRtRDR6b09zNmFL?=
 =?utf-8?B?MnNDVE12RmJ2UDh6TEdSU0JYeHZWT2pwVXE2RUpqakVJYktWVzk2akNwRHFE?=
 =?utf-8?B?YWdEMmcvVWpIOXRyV1gzN2R0MUxUYTR5aXR3dkoxaE9zUHlDQS81YjJsQ1NM?=
 =?utf-8?B?YXhIMVhVbG1xdnV1cjNCN1RGRXU3cDlBT2hDZkxDdlRuVTlJeWFFL01HTFc3?=
 =?utf-8?B?OGdiQUgwc2ZPQ3NkeHFmOC9ENnRMUm02UU9mVWlVUHdjTUJEK2xIUzJrNnUw?=
 =?utf-8?B?Yld1UEhVY2JLeEhVNjBaNnNnbVhpbnZGWlgxbkxUVDFXV2NxY2syOFQ3cWI2?=
 =?utf-8?B?SEZ3dHZpb25KdXV4K2d3N3hydndxQnNhbGd5MWZVU3BmVGFsOG9lQ0QvdTNi?=
 =?utf-8?B?TXR3UjliTDZaaDZ3a2tsclhnZFVuL3J6RE92UkFlUUNNWFRzY0syRCt3Rllw?=
 =?utf-8?B?Z0N6bUxBZWo0SVRZRzJsWTVPQWNzR3B4QWFEek0vL0VnUEdCZUpidDlQWm8v?=
 =?utf-8?B?L1hTQXlrZ3dxd1JTcmxhSlljMUpUNHQxcUlYREM2ZGVhWkNxWkJNTi9oV1p4?=
 =?utf-8?B?ajZkL1M5S1NPRy96WGFVbFhYajZJU1N2UFE4WUQ1VlQ2Y3dLMDVxWks3SVhx?=
 =?utf-8?B?ZFlPbkkrVGc3TjNEdTRzWlhHS291NDVPU0lxcUxZbldUdndCazUzdU8rV2I0?=
 =?utf-8?B?Q2x6YWdubWtwTzNzMU1BMHBEWkNGRVJ1bnNaSXJHdzdSdjF2eW1kM1pMbTAr?=
 =?utf-8?B?NVF4R2xtL1MyaUVHZVdlNGlZVHJ1V04wYUVrNDhzbjZYTXpzTEV1UGdZNlZM?=
 =?utf-8?B?U3Fpa01kZG5WR2NjWmtXZ3pQTW5LUmlqM1N0OEtDUHhSZkFhZUJQY05QWk9W?=
 =?utf-8?B?VnBUelJaS1Q2SDQxOEE1SXVsZDF0eTRuN1NJbDdvWXdoQmFIaW1adFJnTzBr?=
 =?utf-8?B?TFNkbk5ndjNpczkrSEUrRlBaOG05dHViVUlwODBmQVQ2Wk1SV2w4WEU4ZXQ3?=
 =?utf-8?B?cjRHQVp1UFB4aVloZWdRL2xiZHlDYzlsa3N0YjdqSnNaWm8zUFhjS21zcC96?=
 =?utf-8?B?L1hzMTBNWDZXbHFsSnk2QXNoc3NTRWQvUVdJRVFQcjVjdlZtWkVBajJRRVZO?=
 =?utf-8?B?dXYwdDIxZVpIQ25mSEMyRk4zMUVSdXlMRVJ3TWRESnN1dEZNc2FXbXlrcEEr?=
 =?utf-8?B?TDQvbkRDTm93R3RXUTF0cEJmcVoxOXptc0pMVWhKWUpEaURDVXU1ZS96R0E0?=
 =?utf-8?B?UStIUVZNc0diRXdhajQyYXhENlNnc2s0YXVDWk5nemxjbk1ZU2JwdkNtbFlj?=
 =?utf-8?B?U0dxRnNydUNYclNaQUFqZnRqaWJ5NmZ0SDhiUi9IcSs0VCtHWmErazJHdWxY?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bcbf9-393a-4ea8-9819-08dd0010e820
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:17:57.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4wN26090aZ/ZbXAqBeRwaXIC8q2d1zGwf7rGtHx5qc5zGUgvK9g7FEOVzGz8Tfa+Lb0143YTYQaD7c6R3qbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 16:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17232

On 08.11.24 16:47, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 08.11.24 16:10, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>> On 08.11.24 16:02, Quirin Gylstorff wrote:
>>>>>
>>>>>
>>>>> On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>>>>>
>>>>>>>>> Quirin and I discussed this a bit longer today: We actually 
>>>>>>>>> should remove the need of expand-on-first-boot to access the key again.
>>>>>>>>> And that is also due to an idea I picked up yesterday to lock 
>>>>>>>>> the tpm secret after initramfs so that we reduce the risk of 
>>>>>>>>> leaking it via the main OS.
>>>>>>>>>
>>>>>>>>> Our plan is now to convert expand-on-first-boot into an 
>>>>>>>>> initramfs hook that would then come before the crypt-hook, thus 
>>>>>>>>> would only work against the unencrypted blank filesystem - 
>>>>>>>>> problem solved, just differently.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Actually that's a good idea!
>>>>>>>>  
>>>>>>>>> For now, also for trixie, we will just make the dependencies of 
>>>>>>>>> initramfs-crypt-hook release-dependent in isar-cip-core.
>>>>>>>>
>>>>>>>> I guess this is the patch [1] you are referring to?
>>>>>>>>
>>>>>>>
>>>>>>> Correct.
>>>>>>>
>>>>>>>> Just to be sure, still, the implementation of the initramfs hook 
>>>>>>>> for expansion will be in isar?
>>>>>>>>
>>>>>>>
>>>>>>> Nope, this ideas fell apart after trying to convert the current 
>>>>>>> systemd unit into an early initramfs hook. We will need to split things:
>>>>>>>
>>>>>>>   - expansion for already or to-be encrypted partitions needs to 
>>>>>>> go into
>>>>>>>     the crypt-hook of cip-core
>>>>>>
>>>>>> ad "expansion for already encrypted": I guess that covers cases 
>>>>>> like in VM/Cloud infra, where disks can be expanded after 
>>>>>> first-boot / installation?
>>>>>> ---
>>>>>>
>>>>>> In many use cases resizing the partition should be required during 
>>>>>> installation / or first boot only.
>>>>>> That's why, I'd prefer having those steps separated and opting in 
>>>>>> for either!
>>>>>> Although package dependencies might be tempting to combine those 
>>>>>> and reduce recipes + initramfs hooks, the use cases and options on 
>>>>>> combining those justify a split.
>>>>>>
>>>>>> As an example to point out the combinatorial complexity of just 
>>>>>> those two recipes and probably there are even more combinations to 
>>>>>> come when keeping the systemd expand from isar.
>>>>>> (which probably also makes sense for non (customized) initramfs use
>>>>>> cases):
>>>>>> My current approach to streamline that (downstream) is by utilizing 
>>>>>> a target-bootstrapper (kind of next-gen isar-installer).
>>>>>> That means, expansion is not a use case after installation for me 
>>>>>> when running on target hardware, still, when deploying on vm! 
>>>>>> Similar combinations apply for encryption, not necessarily mapping 
>>>>>> the ones for expansion.
>>>>>> I am aware of the target-bootstrapping/installer approach is not 
>>>>>> desired for many other scenarios (e.g. vm, sd-card based installs,
>>>>>> ...) but it already shows a good amount of combinations.
>>>>>>
>>>>>> Apart from that, not related to the initial problem, but maybe 
>>>>>> something to keep in mind when refactoring/reviewing the existing
>>>>>> implementation: The current implementation will potentially break 
>>>>>> the rollback capability on upgrades from systems without encryption 
>>>>>> yet in case of full disk encryption.
>>>>>> To mitigate such for upgrades of unencrypted systems to use 
>>>>>> encryption, we must encrypt the partition relating to the current 
>>>>>> initramfs only!
>>>>>
>>>>> IHMO Rollback should not be supported - this open opens a can of ... .
>>>
>>> I see. Fine for me.
>>> Then just ignore the part below: "Apart from that, not related to the initial problem,..."
>>>
>>>>
>>>> Right, I don't see that use case either. We are covering the initial provisioning use case here. Wiping everything is a different thing, and I would not address that as "rollback".
>>>
>>> Rollback in terms of A/B not in terms of wiping out.
>>>
>>
>> Then I do not get what you mean. A/B only comes into play after the first boot, thus after encryption has been established.
> 
> 1. Assume you have a product based on isar-cip-core deployed in the field without 
>    disk encryption enabled (initramfs was built without `OVERRIDES .= ":encrypt-partitions"`)
> 2. After some time the requirement for full disk encryption gets relevant, and the image get's updated
>    to support disk encryption (initramfs of update was built `OVERRIDES .= ":encrypt-partitions"` set)

I know these requests but they can't be implemented securely (it's like
trying to pull yourself out of a mire by your own hair [1]). Therefore,
I don't see them in scope for isar-cip-core upstream.

Jan

[1]
https://en.wikipedia.org/wiki/M%C3%BCnchhausen_trilemma#/media/File:Muenchhausen_Herrfurth_7_500x789.jpg

> 3. Update .swu file gets applied with SWUpdate. Thus, passive partition (lets assume B_rootfs) gets overriden and a reboot happens
> 4. After the reboot we boot the new initramfs from efibootguard part (B_uki) with the initramfs-crypt-hook active.
> 5. A full disk encryption gets applied. This includes enryption of A_rootfs partition as well as B_rootfs partition, and data partitions.
> 6. Afterwards while finishing to boot B_uki using the B_rootfs we identify a problem / watchdog triggers / etc.
> 7. Reboot
> 8. efibootguard setting identifies we did not commit the install and falls back to boot from A_uki using A_rootfs
> 9. A_uki does not include utility for disk encryption, thus, cannot setup dm_crypt mapper accordingly, and fails.
> 10. Device bricked.
> 

-- 
Siemens AG, Technology
Linux Expert Center

