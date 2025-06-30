Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49EC8302F
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 12:40:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.51])
 by mx.groups.io with SMTP id smtpd.web11.39101.1751287210954367817
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 05:40:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iDwQ//1Y;
 spf=pass (domain: siemens.com, ip: 40.107.159.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1dAfzVsjNfs91GSd5tEPnF8IEm+9XUWl8s81i3A7Ppsns8Tq/zbf/28ZxcDJ9ivzowcsCb7ZMC+ApxAX1seF2Lcscefy3Ie17Kn2jLm5g1NDO9bYrzC1xQaHUA9Q3t8037ieDpeXXL9R+whziLozdYHUfFnZBfwsH2eifdxg2xW27CHrkcwarHQJMDTvyT4svj3/qDMzHoy8PhGr8Qf01ZfcyjEDgwHaxjH4KAKb93JwyvicamK3qpTKkUGqGiySs+UWq3WzccIDANSZBlUP6HA8G7ukSvFDMLQmmDxsqtiGMRTAVQfcJRy3xcfMSyZhPLoefb0a5VXKDTMT0Opag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0blHuA4ALQJ5AQPKN8gdUqw7dvzLsUpu/ZxxFS/c9Y=;
 b=JRimkRx+23usrtmerHasIRfASSF/GD23N8rcHkqJKo6BQxU/0blcs2lKtVqHZ+AyfsgTmiNIAnLW6pH+G5d78V7K5o8y7isgvdymOcob/TVUtTU52W2r4n0eqZY3LR2i1J9qHS52DdV3ZrAY92HFqGo5ctC+XnMezXoOH//i4pYlfT83TTEq8xwhcbGe2sEt1/i2Dbo7Urv8VEuaFnOE/SxZpDFqfxgNhcqj2/EFCF1m4TWihW1v9/mJRtK2FYL+GdcLZLt83qyEodq1C2h/mup8gnFyAeCcMV/PAKuf6IP1ruMJ3w8r8u8qs1BC75nRzzK37ifGQsfBJatDbCWGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0blHuA4ALQJ5AQPKN8gdUqw7dvzLsUpu/ZxxFS/c9Y=;
 b=iDwQ//1Ygc+e2UjotUlGZCKxKz0gJxLJ17UXP+JtEdpgQDJLvV6yCXiuGfUAUQJwntrQfwDsrS/NiSQ67v0PtsdacTm7it8jpYk6dBMQjSoSiEW4g98XsAaxDxoPhGKTj+9IKm6ceVbaV2U2Otb72uvIgN3tG9c4tcjIX+ZCp9ljLnHW71R6UDYggClAcMMAoxQDTYr6gcQb4DXBFFV4osLk9gX32ZhQl83+qokgMo3X4eW9DikJb/R/xm6xDraZIr0+LXooCMV2Q/cFC7zvTQr5cSnTJlsKM8ij2wI9mLqNsI/VV7Y6J9MwUiOHHM8803OhyD/ufw9gA5TdMNu4Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 12:40:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 12:40:06 +0000
Message-ID: <3aeb0c6b-d6e6-408e-9d83-3abf18f9b81b@siemens.com>
Date: Mon, 30 Jun 2025 14:40:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] initramfs-crypt-hook: store initial encryption key
 in TPM2
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: ae556379-411b-40d3-7156-08ddb7d33dfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWM3dStPOFlrNkVZZ3BuVTB3QldmY3MxbHNaSm52ZGZ3NU15Z2ZQY1JkcE41?=
 =?utf-8?B?a1NmdE9aQTlucUhpd0ljRzNZTHdTTFNwWTF0bncrWjdiQVdYcHcxRnVqTDRP?=
 =?utf-8?B?eUdlMFY2VExpMUx1WFZMRW82ZHZtUGdnSzFzS1NzbjdRSUJUeEkzajN6VUl0?=
 =?utf-8?B?WUFnMHJVc1FmYmN3dWlCRXhhdWd0NkMwcUdYY1prTUliN2pJSXljRXJFRFpv?=
 =?utf-8?B?emRFT3N5NW5oK1E2YzdXaDlFV29BdmpaK1ExNm1iaEx5eDVaVFM2UVNlbmRp?=
 =?utf-8?B?K0lmT1ViWFF2MEdYSDRJdTh2dWFpZlV3ZmNqU0w3dThyVVRRTE9aVnFsTGhK?=
 =?utf-8?B?TWxCMFhtVG5GNk5DWFErNUdaZVBNek94ZU9PdGJPUU1ndFA0aEh3cFRKYnlB?=
 =?utf-8?B?N2hCQzJseFU2K211WDBwajVsalBqdnNTRlRtOFJydkxqYTJGTVp4QUpNLzZ2?=
 =?utf-8?B?K2FsVjNid1ExT2dtZW1LWnRwSHY2S1JHbXUwc2ErUURzTGdzcjlacHFVeFJu?=
 =?utf-8?B?MGd4S3RxV3prUEwvY1crQ1kyR0ZnUGNjNllJUWY5eUZPNWJ5R0oxVlJRYlFp?=
 =?utf-8?B?eG91dmJQVUhCVHpGQ1BtQVNVK3U5MFA3dGlBM1NyMi9aOVJmN0hMY3dQMHVQ?=
 =?utf-8?B?UHlYcnNZYktGRmxkUUliNzgxbTJFOG9Vcm9reFcvVXlCVnhvMW5QN1A5eFFJ?=
 =?utf-8?B?WGdSeFRETCtaWDNuT2ZPT2RIUHJvU2p4WXV5azF3R0VRS3BsaTJDcjVwM25x?=
 =?utf-8?B?UThXdjVBM3JXeldiTWgwM3NDeVUrWE40c1czMWUvYTFCRFNsbERPNHZWTFNv?=
 =?utf-8?B?TStudnJKOVowdTBvZXdEUG05bTZoZHZDcUdJZ2JPdnZFNnBzdE1OYlkwTVE5?=
 =?utf-8?B?R2hyK3JXSU9OYnhkMHNoODdmR2xmNU5Wb1ZyZ0dHT0hYemtzTldkTnA4bW1L?=
 =?utf-8?B?dHFtQm9yVXV2bXM4am1tN2lkQTBKYTVpUGo3cnlTS0NzQURzYnRLSUxFNHFM?=
 =?utf-8?B?Wi9tVVk5YmcwcXpSSTZwd3p1NVVQdFBKa0krSUdPQVkvMStMVit5cjBiQWhQ?=
 =?utf-8?B?MFZDK2JYV1ZENTJ0ODd3SUcvN1c1SHRzY1AvWmhhaElCbUlNVy9wUHU1bUM2?=
 =?utf-8?B?ZGliWk40aTA3dFIrQ21pSXZkclY1YWZYaDdyMGExWXBsd2EvemcrdnFrbEw4?=
 =?utf-8?B?Yi95blFpcW9nK2RDTlFlSEFsQWRYS0ZYUFkvTDhsck1KdjEzS3J5TFA4cXlv?=
 =?utf-8?B?ZEhVVVVVbHlmbDk4c2F6US95N2t3dzBxSXZ5U1B6Y2szL3luNy84VURKZXA2?=
 =?utf-8?B?M1dOeDFrTEdPRWhBMkhWQWZ3R3BET0xzbDdYRjdPSVhmTlhWN2w5RWo3Q0lE?=
 =?utf-8?B?RW5NcW5oVU94bHJXZUFWdmFKaFBvclFzd0s2cUJuLzlCalNOUGovWkYvdVdv?=
 =?utf-8?B?OTF5c3hiUWdyRVZZR2ZZeS9vYXQ4NFBXY1RKZTYvRFdsaStaYUdEaUY4dk5U?=
 =?utf-8?B?NzY1N0duTnUrT1dZSzE2cUYxWDNCS1NUaWxVS1hoQkRYNUZKMEc0dFgzNnp2?=
 =?utf-8?B?aTdaL2VhYTNlTlI5WEF4Z1l1VUNnWnNGUHhQNk13dnhnR0swRmZidkZkeFlC?=
 =?utf-8?B?ekdFNDlMaHpFNUVYeERxUzR6VmtwbkFJQmRkY3VzUHNSL0U3MHpMZGh2ZDNS?=
 =?utf-8?B?R0RKWktwYkdwN0RzVkIybnlDVjBQeEpBWFlQK0k0RXB2a3BCSGVpUUE2cWdI?=
 =?utf-8?B?RlBlanNyVHBBY2ZqdlQzS2xaeXZtNzFBZFBUd3I4aUcydlE1MWVUSXJTZ0cz?=
 =?utf-8?B?dlRUdVg5N3Q2c2FPT3FMYzZ3eXFBSTgvZ2R3R3NYcWlVaWVuR2RzZTN6YXdw?=
 =?utf-8?B?RXdkajdad09oRG81QlcycjhSbE5MV3hPdVQ1djFvSFhFdktCd0UxT2FYb3Zt?=
 =?utf-8?Q?6h0g4PV0mV4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWxpRDg1QnNDZ2FacVVncWVweHJ5SmR2ZkhBVEcrSFU3cTJvZ3FqTkpieW5U?=
 =?utf-8?B?eTZIYXZGeWNBb1U4eG4zN0xna1FVMzdKRHVvenFGY3BXdEFNb0FNZFhhSjhF?=
 =?utf-8?B?cTJheXZ5SnR6eTdCZUhtMDFBeDhBZHc4YnBZcWhHeGNtRjl4c0hheUlMd0dD?=
 =?utf-8?B?dlFiYWMyVFNJVGNQdm1wRk92TGRRNVM3ckNlSWZucnlwVUp4WW1jODEwVEsr?=
 =?utf-8?B?UVR1cGpWeGd2UUdYRXZkZHJpWUp0L05KSlQweFFHNGs4cldMNjNrazhJV1pL?=
 =?utf-8?B?bGc0eFVUMnVoL3J2QmJLc3dXOE1XSFhOZkQ1cXNTRnRWbkt2dS9jZEJWT2ZW?=
 =?utf-8?B?V091SmVzQzlVclRhQ2RJa3I0Mkc4Y1dpS1Vsc2RqSS9saVR1NGxkVkw4MlNV?=
 =?utf-8?B?aHJJa1ZoWkk5VXpjUTZpckNZK2g1aVN0dlVuaDBmQkRQeThTRHJkRWRIdHlv?=
 =?utf-8?B?Y1BIRG5aQU5IU0FVRDhrWjdHd2M1SWVpWm8zQXFyOGNiY1NndDEvbHZVTEl2?=
 =?utf-8?B?RTliTHloa2ZaMGtCcXUyR2luS200Zmw0S2Q2aUk2TUVyMlVtc3VoYTFGM2xK?=
 =?utf-8?B?WmliYTVPVTZVTGI3eUQxZGo0Z2N2NWRjVnY4ZkV3TndHNDNqTGNUb3dJaWxI?=
 =?utf-8?B?RmtBN1NUTEtpUEUxcWZyKzFibS9oRUdhYncyVUpKRVhJbnZvdklkNDQwQTRT?=
 =?utf-8?B?a1Z2VW85Q1FMT0w2bzJvWjFIQjV6ckZJRSt6N2FuYnYzZDd4OTRoaDB1L0RK?=
 =?utf-8?B?eU5EYVcwRVR5ZVVvQW9pU1Q0VG9yUzFXdUFFazBjcnVEUU9FTVZCSkt1djV2?=
 =?utf-8?B?eUF3MVh2ZjNDV1RYbmtkbWZiTmI3emVpR3pHKzR5N1RScDBRQXRuREFHVnlS?=
 =?utf-8?B?LzNySURiQllub0lqR2cyblpVSkZRN281Uno1a2VIUWxFcUpDdVpqWWN1aWI2?=
 =?utf-8?B?QXZ6MXlNU3dZQkdITlZRZmFJK3JBckUrTDBmblliYVM0M1A0UU5oT0ZiSW5K?=
 =?utf-8?B?VUROcUlRTWg4emY1Vmk5Rzc3bUEwNFlaZVAzV3RWMGN0a2hBU25va1Z3UGJt?=
 =?utf-8?B?WDRWQ1pXN0l3QUdWOTUzKzlGV0xuMktjREp5YXlTOWhSZElYZXlxNmpBR1Bx?=
 =?utf-8?B?aWJvMGlPTkFreXVJckhDZ0YrTTBLZEpySHBSZFc1QlNjeTJlTG13YmcwdERD?=
 =?utf-8?B?TmtEOWo5WjRmMVRVUEZjN2E5WExJNkF4azdzNUJoS2RUS1doRElIY1YwaUk2?=
 =?utf-8?B?aUtHcnNTR2JtUDhDbUx0WTBscy9lQ3d4QVgzak95M0s1d3Fsdlg0UUhpbTRW?=
 =?utf-8?B?Tkg4a25uVVJiWjkyT2ZnWmozd3lvTDN2YXVZS0dzdWdaZHY0NFV1R3AzZGZG?=
 =?utf-8?B?aUZWbWx2TC92TVd4VWpVSEx4QzRxbmZkbGU2UlVtOFZQbkNOK2lyUzRldXA2?=
 =?utf-8?B?NDBoZHRObW90S1E0ZnV3SGFGNzdPbFlRbFYwZ2JsNFJFSkt2MFlDZzlLdmZO?=
 =?utf-8?B?aTBJQUJTNmNoS0x5VGVqYlViWUx5K2h6VEQ4SUpLTEZDc1g4VUR3TzVjZk9P?=
 =?utf-8?B?VGFPbEFmZm9ncStxL1lHV08wUGExcUE2Y0cvQlgxQThQN2lCYWx1dk9xUlR6?=
 =?utf-8?B?UXkxZG5sdHRRRUZWeWU4TGJqZlVibTZKR1NsaTAvY2hLV08rTzF1c081b05U?=
 =?utf-8?B?dndqUHdBUlFPMDNFMU0zOWo2VndNTXZkNkdPWS9vMDhENkJyZ0ROcTF6Qnhr?=
 =?utf-8?B?cFhIQzR6VkxzaDBQNnlhR2htRkNsZkhVQ0Eva0pTQzhqYkIxY01INjFHM2JT?=
 =?utf-8?B?UDVjRldjeVI4MXM4SFFnMytMTDU4SVVwUGNhcTRyMzB2alVYb2c4bnhmdG9m?=
 =?utf-8?B?TnpVYVh0d2dVZEZhK1JLN1l4N2VXYTE5aFJvaThHQzFkQW5lN0VzcFFBQTBT?=
 =?utf-8?B?ejdhdXBrQkV3eHZTcTVKWDdWeGxLb1hrMlpIM2JOc3JQMVo2MkcrM2F6VFo5?=
 =?utf-8?B?OFNmSXM3dnJtTUh5NXF6Rk5TdGVGWmIzaTEzVXJpMGhLNklWcGxSb1lOZ3BU?=
 =?utf-8?B?RmlRT1RmV2IzOWtVc1hoTW5KUXdHUzZpdkNYVXJnMFFOV3NzK2M4bUZIMU85?=
 =?utf-8?B?OGtVQnVOVE8rUE9qa0RQUEhFeVErVXI1K1ZVVUdGS0kzV2xHMXVGYlRHeitI?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae556379-411b-40d3-7156-08ddb7d33dfe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:40:06.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXfcapJweatwLsp3TzzqTyePdTUy8CMSynpA1176B8jvFJfXwMy+1/lf2Mo7H3q4wYDor21b/liUda1cafASmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 12:40:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19257

On 26.06.25 11:09, Claudius Heine wrote:
> cryptsetup and systemd-cryptenroll do not currently support encrypting
> partitions directly with keys stored in the TPM. For that reason a
> temporary random password is used for the initial encryption, which will
> get removed once the TPM2 token is added to the partition.
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
>  .../initramfs-crypt-hook_0.8.bb                    | 13 ++---
>  2 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 2b4bed02484bface7b0370e6ef1b9953e8ae4eff..9e7525117a03debdf2c526ab742e9428372cd0cf 100644
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

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/10508871856

At least this tool, maybe more, were not available in buster. We either
need to drop buster support or make this path an optional one, using the
existing implementation for buster targets.

Suggestions?

Jan

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
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
> index f3b6c82e96eac82137fdb528838e468987b79f46..b7884aff741df69eee88d5def94868c66f541126 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
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
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> +    e2fsck resize2fs cryptsetup head tr rm \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession \
> +    tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictcontrol \
> +    tpm2_unseal tpm2_getcap tpm2_shutdown \
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

