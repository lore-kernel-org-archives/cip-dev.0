Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D77C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 10:07:04 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.41])
 by mx.groups.io with SMTP id smtpd.web10.26976.1750068422324018354
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 03:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QDOl/sWF;
 spf=pass (domain: siemens.com, ip: 52.101.66.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc2Cygmik3kzky1IsIwLtK+4lPXCdQyC0yQhyM3wlUjuvEL6284S34xSeqSQo1D3yMq7wXN7c/B6t0kse6aPln4k3PmaSgNkWBFL52m8B6/4Kd+MRXG8uxMoLNMdRsrn1gSlxTVMoOZnfGhaCZvPB0/Qkv9TtKogBZsxY9iPcSAF5BM0jf6HKLu1iRZAiLxjg2h9dyBnsqLd2RpaQhXSxDaTPplgh06UH/x78BEdgdUkFbbjyTqA9WuaRnbIDw5GSODVzvlKMV4mIhgipYYScbRRw+jXArmvL8jrMPYLp9uQmgXYLazB4uPMNJXYwK4biUmXKBa7Iwu6Hh+lKkK/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EenuaqOWYRiheqNgXN+ZBZSOabsWhQilWPGVNvSlD7g=;
 b=SfEYELkbbmS3OMl5zEBcBFXQyxg+HY90yysr6UDO4SGlqO6ZVmfGHKlMGjkUAhcQ6wwJx/kAy+ltpn2gXJTrRbdyncxhkhC3s8PdhrzDeKcidh/Q8QlhUMQDiPdapEKL+VPLUW6lJFCrXkl41V1A3w7VqCcWYY7ACtVZCG/UlJUQWMbMPzbYxftIsYZeQj2JWqfL6br8AY8mg/JtHWmPqTbKARpwXBRGM31UWCYaSLtGIojhGhSaL66XmfzX/HOdj6hpCTJ7GVFwjU1SIWc3teSO9KgmktsO/X2ctjB78YVxflg4a5b+ju/QfOr7uFAn7LjyqvQSqL0wzehuoZvO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EenuaqOWYRiheqNgXN+ZBZSOabsWhQilWPGVNvSlD7g=;
 b=QDOl/sWFaH5agvymKpJ0Vh8njrilC6y//4RdMcOBrbyDzuTVHr21ExyEUDoOWapU+3inRm1Q1wXZFeYLV0B6h+FHNvA/uFCjNGJMWgeXfZ7tSTbOZfQw3rcT0hLgyMlbHKSQZvA9/9lBVZQha6dNsgNxmQWs2+iEpo5MkkvdmqkZxCG6jUoOnNc2oXgjHvHbzjU0JcbI68fQK0oAS+CXJYTluocPdAWAMNyheWpIO5WNBH2KlmO5xbVI4D1M4n9jbDSAEkszkvPqRnPCFARRfKmiVIRfBfpkzKSYPTPRro26Z7JG2c3p5zO54uFi9QGCjkUXP+ZRnuc+LDr7sX0Cjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 10:06:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 10:06:58 +0000
Message-ID: <ad98c6ad-d8e4-4e04-8e15-8281b087c88f@siemens.com>
Date: Mon, 16 Jun 2025 12:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] initramfs-crypt-hook: store initial encryption key
 in TPM2
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de>
 <20250616-initramfs-crypt-hook-patches-2-v7-1-82dc9d0dbbcf@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250616-initramfs-crypt-hook-patches-2-v7-1-82dc9d0dbbcf@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3136:EE_
X-MS-Office365-Filtering-Correlation-Id: 40228a63-81b6-47f7-9e85-08ddacbd87c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWcvNWd1bm5VNVUwUlVIR0ZmWDQ5a1NHQXEvRFdWMDk2YnhVWElEWUxvL0RF?=
 =?utf-8?B?NzlDdldOaHI1MGdKajBWNkk0aHJ0S3RYUDVFbDFrNzlxbkFqOVBoa0syaTVH?=
 =?utf-8?B?Qlp4U0lJZTJLbmh3RVlVSmtKRHNIRUJvR3doS1RwL0tGTXN6Wkd1K1FPaVgv?=
 =?utf-8?B?b25OZ0ZTZ2tFNE4ycDY1ZmNXKzNUVVdVTTF6MTd5YzEwWHRPMnVpRWpYU3pP?=
 =?utf-8?B?RzJyaGlMT21rbzRUQVozekJPWjN5SGdwTW5LTVRHUDJyWTF2MzVkMXcwWW1P?=
 =?utf-8?B?ZS83YmpnMkpjVFUxNmhSbGVMS1ZSS0tMRWdXbU1EcEU2WlRsOG1BWDhtdGtC?=
 =?utf-8?B?SXJNcmhPN3hPelp1aEUvSks0VmVUQTgyQkRwUTdoKzY0c09kMHgxU2U3SlRt?=
 =?utf-8?B?Y1VmcEk3SVBRcjhiL0RjTVg2UkVzVERJekt3YW1NWnRtR05UOUdkc2FjdmF4?=
 =?utf-8?B?SkZBNkY5TzhIbmdJVHlodGY3VElVMXJFVlFLOG9OOXgrS2RzM2wvWDJSMUVO?=
 =?utf-8?B?eEJxZDYwN3FsYmVFVG9NMkEzQ2V3WHBLYjZlS3BxOVU0TlZoSFRpQnMwWHl0?=
 =?utf-8?B?MFBYUzVSS1B2U0Frb0pWS0hxa3E0N1JwN1dhTXlqeUoxOXBxeEdhM3o2WUFD?=
 =?utf-8?B?LzhrTkNXZEtnMldITnJMUHRwUTExYWRyanF4OVU1U3lYanRFdWcxaEx2T1lW?=
 =?utf-8?B?UEUyZm5EVyt1VXZQb1JsUDZKMTUvdGx2Q2xhekw0UnhzR3BzUVBoQTJIS0JM?=
 =?utf-8?B?V0RwdEhnNDg2dG5oSlg5ZFNKU3RrenRqbWJBU0JEL2oxUlpIRmkyMW9kdm8z?=
 =?utf-8?B?bW5xMFVsZzdhTEtWdUdyZ291ZnpiWWYxMlR3VDZ1UHl5Zng2Yzd6d0JxUnA5?=
 =?utf-8?B?dnprL0toN3JTLzM4bkVBcnlmZ1pwMXphUW44b2pvbXN3UEN4S09iTHJrSVNh?=
 =?utf-8?B?RWYzaW5BY0dubVYyc1lMcktHUDNaNjRCSXBJMHVxTTZ0N3Uyc2VBV0dPeU4v?=
 =?utf-8?B?SWRka0VKcE9RNmdadzd0VXFISUs3UElBaWJzY2hCUWMzbW93Q0NDQjJLd1NL?=
 =?utf-8?B?ZHlBc2JIUm1hU3FPdURwNnN3Q0VBTGhOMjV3bTh6QjB3cU1PQ0Q1UG94M1hx?=
 =?utf-8?B?aWJMR0Z2T1pUbm9vNjB5amF2RlJMWm1Xd29rUE11Tk5zTHU4L3A1QWg5SWw5?=
 =?utf-8?B?dm1iOVRNZGIzdjdwVUlna2kxYTlydzhEbWRwNmRjNDBRb2tydXdyWUQrQXRT?=
 =?utf-8?B?aFBoUGdDMy95ZWVYTjJIcGxSTWErVzljTS9FSllVcVR2L3dlWkFhMGMxODIz?=
 =?utf-8?B?REo1Z1VMWjJYZjZVUXBpcFZZZW1leFE3eDNlNXZhOFFUR0tvRHdiWW00OCs3?=
 =?utf-8?B?TEpJYk53RkU5VWJmbkxJcVVRZVAwaEZQUzd4dzJGR0F5KzFVMmZzNU8vYTBG?=
 =?utf-8?B?UitFVVJXQ3F5SW5MZHYrR3c2N2NpamtSWW5RKzZsK1ZFdXpkQ0RFTldHd0FJ?=
 =?utf-8?B?NE13STlEUHlScVVyQmU1SlY0VWczeWY1WGpOQlZQa0NlUHp6TGdITEtra2NN?=
 =?utf-8?B?QUJJck4zcXUzcVlHWWpRTGhtYmpqckFJR0VJeFhHbWlReXJMVzFoQjJodjU1?=
 =?utf-8?B?blQ4dUYwbk5HV09oclNiUWdSOFFzLzNuV081OEdFcU01NXFxUXZEdy82RXYy?=
 =?utf-8?B?ZDhCY2FNQnJvOFdKOG54TjY5SVZwR3VkcUVsWDZXNzVSR2FHMHFhRW5LdkRu?=
 =?utf-8?B?WGdyTHBNNVRXME9ya0Z2MWc4ZDgvRnFRdkxydHJxQU1JTTI3ek5pZUVEVS9N?=
 =?utf-8?B?d3o3bkZjNU1QNDhka2NmaWNjTnFWcERkRVZncmg2UUVOWTYrL2JMQmJUMTJs?=
 =?utf-8?B?dnVUTUlkV1hqd09LaHErNmUyMkhkK1RpYWVHY2Era1VYRWp3V3o4azFSUCs0?=
 =?utf-8?Q?2yDE+lhMD3w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTdhcHY4OHZzakdKbmxLUm5pQ1hXQWc0YTllM01MVDNiajZjRERBTTBBWi9z?=
 =?utf-8?B?cEZQYzRyMVJnOXFrN1VNd1E4bitkQ2t6d2ZoWGhUTmtsY2tNTk1pb0JHVitM?=
 =?utf-8?B?QlI0WmxLSy9tY2JlUU1aYnV0RHkvOWYrUjczL3c1MktlTlNWcmhBcUhEZEVq?=
 =?utf-8?B?aUE5UVBuUi96WkFMTTJIUjM1RGE0SU5ldS9zemltK2dhRytsZFN4T1pPNHNJ?=
 =?utf-8?B?dGI5R3crcU1uU1lQWlhyYjdWYjhBenVYam5rUnFNdFh1TGZ5akxrc1o2bG8x?=
 =?utf-8?B?amdRVXJUN1VjdVh3cm5WNWpZRlFDTVJLcVhFa1pKK1pUZ1RZREdsQURmUWpE?=
 =?utf-8?B?cmlXaURrdFdsZnppK0lvN3hwd1MwWVRwTFRuTXg0RW5FZ0ZvR3NFa0h6blpB?=
 =?utf-8?B?UDRoOHN4ajc3b3ZWMDBWT2lEN3FLN2VkYXNsbjdWb0Q3Z1pKMkg2VERtK2k4?=
 =?utf-8?B?V3hMMDNvemNOVG9heEIrUEd2NVJvaTd1NDdJTnlUUFpOaUJnNGgrdlpZOURr?=
 =?utf-8?B?ekFmb3JvaG9LNk9iL0dQSEhtU3dkQlVFN2hJNkY1L1VoUFd1cXp0b2o1RHVD?=
 =?utf-8?B?a1ZVT0xidlFGWExRZHFuRlRaUTMvZ0RpL0I0V0g2RkhZVUFocU04SVF4Y3RQ?=
 =?utf-8?B?czhMZ3JNS2R1akI2a3FKVVJyejNXTGFCVjQxMVBNNStaK2g2WEtMc3BrK3dQ?=
 =?utf-8?B?TzFiMHM2MVgxc2ZnS2R0cnVFVnhHbUs0cGhIa3lUYmVRK00vWTlxMnF5d3dI?=
 =?utf-8?B?MkV0Q3BNZFZyMXkrQ3BxeVYvbFNwMWJXZVFtQnJZZ2RwaWduNUtobEdrTWpH?=
 =?utf-8?B?NzhXRmw2ZXg5RnlYczJCYnFoZm9maVVRc1RCUlJuOStIeW9rUE1HMFIwZXNE?=
 =?utf-8?B?cXluK3FHakZaMGtJdlV4Z0syRE1EYWF4NzV5dXB6SEM5TzJIMTZMbzA1VmU2?=
 =?utf-8?B?ZXoxL1pObm9zeVVnc0ZjaElXYkdNVCtJTnFtUzdTRHBwQktoTm1pSFZPbVlP?=
 =?utf-8?B?M3psQ3UrQ3ZJR2VkdlRQUDlHeUFlU1Jadng1TStnNGdtS3Z2V0NkcytSbUNB?=
 =?utf-8?B?RjlqeTZTbGFHWEFtaVQvbEUyRkJaUGMra2ZhMWQ0dFIyTi83QURUa2JKUm5k?=
 =?utf-8?B?MXp6bWdiRm5vNlNQK0RzRHI0b3ZJODRmMTZnK3pBY1Nyd205Ym5NSXFST0V1?=
 =?utf-8?B?WVdXVUdLd2p1S0lYL0JhcnIzN2FKcE81MVdDazRmQ3puUmFiZlRkZmdYc2h6?=
 =?utf-8?B?eWhkVjNlTGVHV2JUb0xsR1RqcWM2TGdUSzh0UEhtbFdSRlFwNi9NNWxpbGN5?=
 =?utf-8?B?ODI2U0tWekhZN2dJM0NFWGdEbW1sNkhxUXc4cm9GUjZiSzhYZVdRVnhBK0V1?=
 =?utf-8?B?L3c3UnArTTdabVlKNmg0K3Q3eFBWd3FpdXc4ZXI3LzE2ZUZSblp5WE1RcE9y?=
 =?utf-8?B?RDBMTEtrSkp3bW1Bc0pVQlR1SGtSU1JYejhrWDQ0V1lldGN0dkxMMTg2ODZT?=
 =?utf-8?B?dEVZeG93bDI5N2pHUWFDTHRxSklMTXF3K0g0U2F6N1diMEVCZ2JwR0xXNm5N?=
 =?utf-8?B?YmdlMlZFYWIrbXl0d1QrdXJWSkUrOHdNb3pnRHVPWGQ2VGdZdm04VS9QeWNX?=
 =?utf-8?B?dW9EMzMrd2lMMnhXa2JseThHd3JvempSYjNBd001ZkNUSFZNVmRVYjZqNEY3?=
 =?utf-8?B?cXJvcHJBMWhCU09za2NUa3pIYmZHUXdHbTNmWHp6SjlSSXBpOGdiYTJCeDRW?=
 =?utf-8?B?dmlNUnNKSVdxV3lMYWZsZHFXU01vbjhrbEluSFhuN0E1T0duaWdIZTljZ0tr?=
 =?utf-8?B?c3RVdC9XUmtpZzA5V0diWndPZEZoSE9acjVpYitJMzBNTVdKdDlwQ3E4WG1U?=
 =?utf-8?B?YVEvcVU2dmhDcHoxVy9pMk9MbHRHNDNOdWIzMjhORm5SMTFwSlU1eU12THJC?=
 =?utf-8?B?eVh5WDEvTVViV1ZjMVpKR0lKa2YyNExmMVZtZFJHUXpsajAzYnd2NEhBVlhx?=
 =?utf-8?B?Yld5dnNJSzBzK0VyQzZaaEZFMWlPSVJDY1NOdE11NVdSd0l3a3hTK1Z6OUoz?=
 =?utf-8?B?YTdKbWVXdW9qOFVydXZsVHpNamVkczMyWTZhZzJMekRIOGpVOFpQWkZPUUdQ?=
 =?utf-8?Q?KwbS16kWRdQporJ6di3E3Tj6L?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40228a63-81b6-47f7-9e85-08ddacbd87c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:06:58.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pX19CJNOJOS+fyNpaQE0fLjCfZxgvm42WoltuanDpnOiGY5Lc4TJavaBjQEfxFDmTqNr4c/Mgbtl8RBBiO2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3136
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 10:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19104

On 16.06.25 11:30, Claudius Heine wrote:
> cryptsetup and systemd-cryptenroll do not currently support encrypting
> partitions directly with keys stored in the TPM. For that reason a
> temporary random password is used for the initial encryption, which will
> get removed once the TPM2 token is added to the partition.

BTW, did you already try to discuss this use case with systemd at least?
Not to see as pushback for these changes, but maybe we can once simplify
things again if upstream address this as well.

Jan

> 
> However this process does not allow continuing with the encryption
> process in case of power failure.
> 
> For that reason store the initial encryption password in the TPM,
> protected via measured boot based on the TPM2-PCR:7 register, which is
> the default for `systemd-cryptenroll` and load it if it exists.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  .../initramfs-crypt-hook/files/local-top-complete  | 56 ++++++++++++++++++++--
>  .../initramfs-crypt-hook_0.7.bb                    | 13 ++---
>  2 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index ae0dcef4cb62a135beb6d4229237144b6d4edf8b..e511e8ef2d0bd4f4c8fd2fca248312dee173d224 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
>  	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
>  fi
>  
> +export TPM2TOOLS_TCTI="device:${tpm_device}"
> +TPM2_HANDLE="0x81080001"
> +tpm2_key_get() {
> +	key_file="$1"
> +	TPM2_WORKDIR="/tmp/tpm2"
> +
> +	if ! tpm2_getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
> +		mkdir -p "${TPM2_WORKDIR}"
> +		# Open session:
> +		tpm2_startauthsession -S "${TPM2_WORKDIR}/session.ctx"
> +		tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
> +			-l "${HASH_TYPE}:7" \
> +			-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
> +		tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
> +
> +		# Add new key to tpm:
> +		tpm2_createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
> +		echo "$(tr -dc 'A-Za-z0-9_' </dev/urandom | head -c 32)" | \
> +			tpm2_create -Q -g "sha256" \
> +				-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
> +				-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
> +				-i- \
> +				-C "${TPM2_WORKDIR}/prim.ctx" \
> +				-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
> +		tpm2_load -Q \
> +			-C "${TPM2_WORKDIR}/prim.ctx" \
> +			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
> +			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
> +			-n "${TPM2_WORKDIR}/pcr_seal_key.name" \
> +			-c "${TPM2_WORKDIR}/pcr_seal_key.ctx"
> +		tpm2_evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
> +			"$TPM2_HANDLE" -C o
> +
> +		rm -rf "${TPM2_WORKDIR}"
> +	fi
> +
> +	mkdir -p "${TPM2_WORKDIR}"
> +	tpm2_startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx"
> +	tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" -l "${HASH_TYPE}:7"
> +	tpm2_unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE" >"$key_file"
> +	tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
> +	rm -rf "${TPM2_WORKDIR}"
> +}
> +
> +tpm2_key_del() {
> +	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
> +}
> +
>  prepare_for_encryption
>  
>  for partition_set in $partition_sets; do
> @@ -259,16 +307,17 @@ for partition_set in $partition_sets; do
>  		watchdog_pid=$!
>  	fi
>  
> -	# create random password for initial encryption
> -	# this will be dropped after reboot
> +	# create random password, store it in the tpm2 encrypted and protected with
> +	# PCR:7 registers to allow continuing reencryption in case of power-failure.
>  	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
> -	openssl rand -base64 32 > "$tmp_key"
> +	tpm2_key_get "${tmp_key}"
>  
>  	case "${partition_format}" in
>  		"reencrypt")
>  			log_begin_msg "Encryption of ${part_device}"
>  			reencrypt_existing_partition "$part_device" "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
> +			tpm2_key_del
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			log_end_msg
>  		;;
> @@ -277,6 +326,7 @@ for partition_set in $partition_sets; do
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
>  				 --type luks2 "$part_device" < "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
> +			tpm2_key_del
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			eval "${create_file_system_cmd} ${decrypted_part}"
>  			log_end_msg
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index 80a4755e4e0acfc96bb2d0f8e175e2787473e384..b48c6e89384f7f43737fdbb3438d5be15bb5945e 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>  DEBIAN_DEPENDS .= ", \
>      cryptsetup, \
>      awk, \
> -    openssl, \
>      e2fsprogs, \
>      tpm2-tools, \
>      coreutils, \
> @@ -40,19 +39,21 @@ HOOK_ADD_MODULES = " \
>      ecb aes_generic xts"
>  
>  HOOK_COPY_EXECS = " \
> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> -    e2fsck resize2fs cryptsetup \
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> +    e2fsck resize2fs cryptsetup head tr rm \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession \
> +    tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictcontrol \
> +    tpm2_unseal tpm2_getcap \
>      /usr/lib/*/libgcc_s.so.1"
>  
>  HOOK_COPY_EXECS:append:clevis = " \
>      clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
>      clevis-luks-bind clevis-luks-unlock \
>      clevis-luks-list clevis-luks-common-functions \
> -    tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpolicy \
> +    tpm2_createpolicy \
>      bash luksmeta jose sed tail sort rm mktemp pwmake file"
>  HOOK_COPY_EXECS:append:systemd = " \
> -    systemd-cryptenroll tpm2_pcrread tpm2_testparms \
> +    systemd-cryptenroll \
>      /usr/lib/systemd/systemd-cryptsetup \
>      /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
>  
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

