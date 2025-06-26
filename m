Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D97C7EE32
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 13:04:42 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.49])
 by mx.groups.io with SMTP id smtpd.web11.7546.1750943072966325119
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 06:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hZXd21zh;
 spf=pass (domain: siemens.com, ip: 52.101.71.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC2R5ZdrdhbzO9s0rHRrmMnoyydbCrpvbL2t85hs4buvELn/EbQ75M4x4BlPkk4mKW3ZXywd7V998KqqKCQVdAB6dw/0wPwvSLGFG5or9Q7gkUmIizIF+Tb6cFBMb3ZaEvBv+kCUvz1WizDZCLYWNH/tD8o3PvBInEz9VxjJjo0wCLlSnr/jC7IWez+DQ3IaKvR6zPsShOro19tRy5ie1sBcch+4GS+/kSdwbc+HkMqyYXm2rGUVrs2InEkCGRxLI73WnLKR5wiQVoXRkx4+yYOt1F6Shfwa35LTogxKP1fEo8/iqNKZt9BpkynFnjFr+HA7nHa4mhfGp8m+vygdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj6VJOa1mGz8gM7cESyRJ4RgqMmJHFGj0uZKU8Cww7g=;
 b=EEci0AP3dAh7VF6bSGPMzTFFt+Bw9DHjyXPMALkNREB8JsElStEomAsh49jzowi1b6iLuy1qDty5TS0xMazF0kkv/WuTDRF1IDGyWPBg943HctzS5mKOUCVY0w+fgoPzkvjbwAwMn4BE4P1y1hQNDSAy4YOA+YEWK78LMEHbqSQ73FN/ikPdUhOTakL6iSDaCGrO+207uOSTYW5CSELTOCPUErtInJlCzI78d9FplUcLWKVerC+NtrAWExIYyRjvhrBBcx9dIdAjiGdKofexZyttGEBbxvfPkiSLqiNfnVn717FUpQIH5gyK20A0nZGy1WFVlr/nRGZ6z98aYb0tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj6VJOa1mGz8gM7cESyRJ4RgqMmJHFGj0uZKU8Cww7g=;
 b=hZXd21zhNogq8lItR25ozKyyGy/kWXCNJZYkSi63PCzFHo3rOXUE9Bs9N23o38XxmoLmDXtjRmk+fnZBjFzINtWn0dYtX89WXljdhvWuNteA2V28VyhkHkYczinqt8RB10HEQ0gsyzDLY5Xue2OVvleioLyk/QIfdv+nFYyIoi29LlLquMRnbfijFXRhXe+44cmJpMqtLszynHZpUcREBA7wFVxlI46SPHrpke1DCy4NKRtvtpkp5WP4MS7Dedp2sebAl1cpRjOD6aTfwZ5SQm6EpZld6IBrI/lF+f3pzvnnSwcLwLXSKJtFrwxC6A9/EjWvpAp68mTCrT/+jUy3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB8158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 13:04:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:04:23 +0000
Message-ID: <12d427d8-daec-4dbe-a91a-39783bbb3fda@siemens.com>
Date: Thu, 26 Jun 2025 15:04:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bf46d0-fb4f-4694-4c13-08ddb4b1f8c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZU5mWTFtRUVGMm9FUUFjK0VFT2M0V2k2WHZIU250QVZlZHhJWTE1TTMvUTlt?=
 =?utf-8?B?ZnNFK0oxd1Vzd3oyamc0MS9ZNVdVc3ByTzg0cHU2bmN1d3VqTWVacm5BQ082?=
 =?utf-8?B?d25JbGZRSTJtUXBIcGE4QlM1TzNNRVpYWmhpMkNpTmpab3BHa0haWHRhN093?=
 =?utf-8?B?bzRsQkxwM0RkYzZqZlc2R3lwSDFUTVl1SUpvM2hhZ0M4bG5kVXJSWUZ4c2Z4?=
 =?utf-8?B?YkZEbTRaZkxkdWMwZkx5OTVmaDd5b2ljdGhZcDNwek1zMlhXbHFtU3NEUXdH?=
 =?utf-8?B?WEt5YVNXaVlyOURhbXRMRmR6MUE3YURSNWhQbWVKVm5SVEgvQmc4MzFGL2xO?=
 =?utf-8?B?TUtzeWs3ekczU1Vnd0szSWNQalNpMHpmSy85bHJjdGFTRlBSUEdZejFJdVM0?=
 =?utf-8?B?YURSWmxHWDJtajZrcVUzVHhIQjRsMkV1d1kvTVordDBkeGFnMzBkUHRlSzAz?=
 =?utf-8?B?VXV2QUdYM0pGUVlDNHhEQVRieGMxaGJTcHJud29BM2hqZTRvUHRGTXV1QnU2?=
 =?utf-8?B?SktjbTNia0lObXJaNWNYNE9PSXY1NFl4YlZLR29CSldHQXlobkZKdm9CdEFx?=
 =?utf-8?B?dGJMQUIyaHh2U1YwQXJPTDBoR0k2NjBoQXJQRGtBYmZTTGFKS3kxc1hyeklU?=
 =?utf-8?B?UWlmN1pyZ0FieE9zdDI3WHpKYnFhQXQybGdjcDhmQXJtYlpoMjhBZWtZS2pV?=
 =?utf-8?B?UWJDVy9uQlRrUlZhUEE5L2R2K1dkckdKczdvcFlPQlZkZVk5QkVkOUJpQ3c5?=
 =?utf-8?B?anIxWHM4dVMzc3cyaHJ0bjAwUzZzUUFCelY3dE96UjNyU1ZHbmNEeGdYaENt?=
 =?utf-8?B?akxMQ29qaXExZ0JBWElqOUJwSXFRY0UzNW41bmt2OWZJRnNKdnc3MWlTUlVK?=
 =?utf-8?B?elQwRitBZWxjZEtqWlEraWpzRVJkVWlZbVpvMUNvTjZWQUZIWm9qbC9BQ3FO?=
 =?utf-8?B?Qzl0clF0M0hKbkRSL29lYitNSmRrMEZIVzNBdURySVo0S2QrV0xPajNQdGdj?=
 =?utf-8?B?Q3BEekJJaEdGUUZzNXVSaDFQYjQvSDhJVXBHR05xbHZDMjRGekF2aCtBcWx4?=
 =?utf-8?B?aXhXeUlUOUdUcGlDSytRVjFaZDZUZGV5dEtJOUhPQXdRdEovbG5xOHY0dWRS?=
 =?utf-8?B?NzVCL0ZzMzlsbFRFclRiYWV1cGhPNndDVk83cDdJOXg1YWo2NzJuZHcvK0Qr?=
 =?utf-8?B?WVg3a2dqMFdGT1RYUmc1ekRKcm1xclcxOTl0dkVCa25PSmVDWEV4N3VQM3Ez?=
 =?utf-8?B?OVhmRzZpZUZSQ2k1OWNrNGF1RGNwT2x5NUxWb1Q0VVlObzJ4VDRobTdXbTI0?=
 =?utf-8?B?TXdIYzNja0Q0THBaamdQME5TWFp2cXBYOGxkcnpWYnRBYjkwZjBSVDFqWE1a?=
 =?utf-8?B?VG83SUUyUGNGMU1BR0g3VE1vS2U4UGNhR0RYMktlVWpYTTFLdXR6VUFSTWZj?=
 =?utf-8?B?bzJYZFdkUG5QOWpIS0IwaWhFTHFkVTN0MUZxaWo2TXVRcHYvMUNmQkptOCtR?=
 =?utf-8?B?eWVZS3dNd3NGVU50TWhQSXBuR1hIN3VEazB4eFFmTmFqM3RCM1B1VDBjVWR4?=
 =?utf-8?B?UW8wa2MreHpIQkh4VERWMmlKcDZNSnZlV05CMGJLakNUYzYzT1M0UWU2YjVj?=
 =?utf-8?B?TXN4QVFxWlBFYVVyZ2pvK3dNY0VCaXd0MVlCdnN3eHhpUUtzSGdUMWM2M1F6?=
 =?utf-8?B?M0FDSlFQekdBQjRKUHVqeWJpMkpqczl6TG4wOFkydTY3VTZmTzlmTlZ3N2lu?=
 =?utf-8?B?TFJyVHF5aElQY2N4QnVQWGtFTXBBZ1gySi8rTDlGbGtYdmQ1dzZOL01aQSt1?=
 =?utf-8?B?L1I2aDlWZ3ZYeWRmbHRwNWdBbWVrRmdOeC9BZ2Z0SXh5bkZ2VFVVUE0wbDNZ?=
 =?utf-8?B?MWZ0cnYyTStJV0o4U3FpQUs1V1VCUkpIL0hoREVheDVGN29KZ1JCMmZvN2Yw?=
 =?utf-8?Q?wrfKtfnGujo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVFheWJLRFF2WGdGY1ErZWhtOVBVSjdsNjJJVXFTMkRCUXg5VWhDTUtxRm9B?=
 =?utf-8?B?NHhwbXlkTmFSM1hodFZtVCtsVnRZOFZLMG8wVWRxbEJnYVQrRi91SGJJRjJS?=
 =?utf-8?B?K0tpOW90VnRnOXgxcXllSTVDUUZNSjU2Y2V1a2JINGE1dStHd1JiNkxDczJ5?=
 =?utf-8?B?YURWeEVnVWVCdDg0eUJlYUhiT2RwZXN1K0xjYTE5MnZQYjNYdkg2aCtFVS80?=
 =?utf-8?B?N2tIbVVpVE03MHRkR0tWakM1NUFrNmVSZ1NvZTljeHpCVTVlVDM2QStnUjA0?=
 =?utf-8?B?Z09PbDNoRG4wb3ZuSUMxSXNXRTJFZkVLZkdSbWl0dENBRDRyWVZFMGpodFJo?=
 =?utf-8?B?UVhoYzBaTlRHMmRQZ1JHZDcrVUdIZHRXUW1pK09LeXM4L255am9UZXkwZTJ6?=
 =?utf-8?B?aU1takhkL0kzNVNGWmpjS0VUVUJVRlVlZWZ5M0o3Z0pZR1pGbjhVRGN0L3F4?=
 =?utf-8?B?ZjI1ZXo5N3h6T1JwN1NuQm90VUtGSzVGVUZIRlVBVit4bFJaWmpCaVA0ZFlS?=
 =?utf-8?B?NG0yR0ljSG5QOWlIYWFFOGxrVnBCWTBjKy9jVnNLOHVnUUE1Z0IzRVg2WHlV?=
 =?utf-8?B?TlJjN09VdnJ1U0xNSTBWWnNuSVlKWkZFM0tqQVJUU0JXS0RCdEZjckk3aEh1?=
 =?utf-8?B?RTFqazJZanBLWkZIa3c1Y2UydS9MRzA3Rnp1R0hHMzAxNGpVc1M0akNodm5W?=
 =?utf-8?B?QWUyUFhyQzBqRHJGS29vK2V4TXdvYVQxeUVOa1dRcXJBVXpUbE83cVZXRzRI?=
 =?utf-8?B?ZXMvVEdNeFlkakVua1Jja1dyY0RabEV3VUcxeWl3Sno1ZmVpTC9UN1E0Z2hO?=
 =?utf-8?B?MXhJYk4vWm9TRXlsK09zNGt5Z0RYN29TVmhnbVJWeTZGdm9Wd1BEZERuTVlx?=
 =?utf-8?B?blVrWTRuTUg3aGYwVDBQcy9kUXczNURvVjRFZXRxVmFqSzZ5aTFtM0VRR0pr?=
 =?utf-8?B?Mlkxc0RNYXZrUnhnUVZSdzlNaSs0SzkwNWxvWTdrNW0wM0syeVV1OVcraXZJ?=
 =?utf-8?B?TEtRS0FPcHhJUTlRVGRjRVNmb05XMjVNaHY1dS9XK3NIRWlyd1RMQlg0emVP?=
 =?utf-8?B?MXRVYnBxZHlMaUt6QnhMemV1ajhPem5xSk9PNmdYQTVYWlFPam5JWENTODNm?=
 =?utf-8?B?bVFiaUJkNzZ1Qm10QnU5UUhHNVJYQ3NjakJpUnAxODhyeGM5VWpZQkhzckJv?=
 =?utf-8?B?Rk52ekFvYlY1OXBkS0lLa1czckVsZStmRU9keE5rV1dFOVZZRkRzRUhFbU9R?=
 =?utf-8?B?OXl5SU9ZcldDRFQvbnpqVS9BQWdhT09UUDhwVkVYc00xc0RJSVp0ZEpNREIx?=
 =?utf-8?B?NjA0anQ1ZUVxS1lrNWxEZnFNTUEvK0dYVXlISWVsZmVJTlM5cE9Xc3hpb1JB?=
 =?utf-8?B?aWp6WW10VE1tL2dFbzJlZDR2b1pvTGRJeEVOOE1TUUpIYjZkSXBBQWlhMXNs?=
 =?utf-8?B?aU5DMHJnV2ZwRmlMUmFFR1J2RTRIRUx4S25NOForRE1nNis2Z3VjUDI0TW5r?=
 =?utf-8?B?b3VMdVBFR3QyTVh3czdObE53bjFzUVd6NGlSME1nQ1ZCZHhPMVlyWTlaUmVJ?=
 =?utf-8?B?VDNFeXA3Mm9zVnROMTJQZFNVRlBla25OWlA1bU1SMHJuaTJ2a3NlNDJIc2JN?=
 =?utf-8?B?WGRpcUs5U1NvbmgrdDQ4VzJvdkp1Vm1nY2JoUkd4cHdMNUlwOE9JUzBJN3Fm?=
 =?utf-8?B?amVNQllVa2dXTEZnZ3BvaXp1TjA1ME1ZMDJvL1hKa0RPQWpUSW05TzJ4T0pj?=
 =?utf-8?B?eHlhRm0rbnRPYWdVZ29pZks2VUdLcGdOZmNyeWxEK2NScXJSMDBNR2c2QW5I?=
 =?utf-8?B?OGFpeTZnazE2d0ZMcmdrTXhDTkdDT3ZoeWU5WFgyOUFOcG0zYSsvOTI0VVk1?=
 =?utf-8?B?M2RkdG1kN2QxWWlDOWgwZ3p4V0VhVms4TzhGQWhRdEY2MkpSUGg2aTF2Rnda?=
 =?utf-8?B?a3hlREVjREdUcFY2ZUdkek1YMDhUTWlHWVQ5emRvdkhPdHZ4SkJSMTFhS0Y3?=
 =?utf-8?B?RDhXMFhMQ2dYa2FjeG9ya1BKYWg1ckEzMUN6c3JJK2tXamxoc05jbzd0M1di?=
 =?utf-8?B?Z0NlUmp2YnVxcXJVM0E2aEp3RlpmeGV4WVNJK1dNUTZNZUlwcnRoeDFiU0NP?=
 =?utf-8?B?aTF2cjFBM1E4ODc2cEJXeThSQXpCV3VMSHhEU0NHQkhSUjB4b0dwMndVcjgz?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bf46d0-fb4f-4694-4c13-08ddb4b1f8c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:04:23.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk3rMV21zPRm0w1ZG7QHiZiWaiIdYwd4+SkSWra0bWJiMHgaumtceDlKwgBH5yPFj1rJlFuqWFq2WZzMdWRZL4kaMSGgw+2GF1Bk05g/DWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8158
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 13:04:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19244



On 6/26/25 11:09, Claudius Heine wrote:
> Hi,
> 
> here is v8 of my patchset.
> 
> Kind regards,
> Claudius
> 

Looks good to me.

Quirin

> ---
> Changes in v8:
> - Rebased on next
> - Added documentation about the power fail scenarios and the LUKS header
>    example.
> - Link to v7: https://lore.kernel.org/r/20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de
> 
> Changes in v7:
> - readded tpm2_createpolicy for clevis
> - Link to v6: https://lore.kernel.org/r/20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de
> 
> Changes in v6:
> - luks formatting of format-if-empty will now be redone when if it is a
>    luks partition without a TPM2 token, this makes it a bit more
>    power-fail save
> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de
> 
> Changes in v5:
> - Switch to use TPM2 protected password instead of static initial
>    password for encryption
> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de
> 
> Changes in v4:
>   - improve documentation and commit messages
>   - reorder commits, to put re-encryption recovery up front
>   - extract static temporary encryption key patch into its own
>   - switch from lsblk to blkid
> 
> Changes in v3:
>   - Rebase on current next
>   - Extended `noencrypt` documentation
>   - support clevis tokens for re-encryption recovery
> 
> Changes in v2:
>   - Added more descriptive commit message
>   - Added more descriptive documentation about noencrypt option
>   - Fixed typos in documentation
>   - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
>   - added re-encryption recovery patch
> 
> ---
> Claudius Heine (4):
>        initramfs-crypt-hook: store initial encryption key in TPM2
>        initramfs-crypt-hook: add re-encryption recovery
>        initramfs-crypt-hook: implement 'noencrypt' option
>        initramfs-crypt-hook: add 'format-if-empty' feature
> 
>   doc/README.tpm2.encryption.md                      |  57 +++++++--
>   .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++++++--
>   ...ypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  13 ++-
>   3 files changed, 171 insertions(+), 26 deletions(-)
> ---
> base-commit: cad5026bc860a2eefb828e03a9205ed8803cd958
> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
> 
> Best regards,


