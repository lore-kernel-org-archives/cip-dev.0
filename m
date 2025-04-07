Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6947C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 11:32:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.75])
 by mx.groups.io with SMTP id smtpd.web10.45036.1744025569640964626
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 04:32:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KHrEQWfT;
 spf=pass (domain: siemens.com, ip: 40.107.21.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvNj9xfREh8ZD6e5P3eT5UQLhjVIdv2ZdV9QsCr474ZUeWtDQt+VANhNh3dNpPTkXz3dEThgu/n9cdaav/RV9AqMNo7jmv9OcsBaZtFR3enAf8kqJOLTgH1h62nMwuJ7haODx1sIFpDM64zns4Fv6FG6tnOFYrfOvsH/dqnVlIfx/T0hRhWdwHHnUNALDsgZPxQQWxgc/5/k94lNq29pGbYwMdvZC5LnOBwDL/x+cgqbKQhzy6MUXHHE3auKtrhZMZkWhKCR4kIowp2+kbGkqqh85+2IQMLQ93gWi6//aw3kT0qYNLiAUl5lUp/6qiiQQRlTbaD4whoOeAvs6JGPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=powObcCpu1zrkK3bqZtaQEvvhkKiUlru5w1KQatEImk=;
 b=lZjMf8NguoJIpWcrJuUkxVqn+8pIqqOfx2fM0Z8PdLl36aTA10nMgG7VMHlQw7ZCfSyRvck9l0I5xBLhLsqtjushPZdty4qAas9hdoUCeozfXfa5F0lRXScopYCVg/WhJ0vUAGX6EoGrwmkc3glrYk6EqoYE0N/1PXDrF8YjAurdM0+GRzZkIhfI4JQuKzOf02wCTWzZkmwSna78qvP+WhejGYfNo/2leLPACG7E8FgrXWaD1lmSYAu4yZ3udg7Vmc7jqajZWj2tNhCTafBvqp72IBULoO2G9u8F7trW1h1b3Ejfrc8LLzElFslt+nylglfBBVEHoMiMwVtrCIDKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=powObcCpu1zrkK3bqZtaQEvvhkKiUlru5w1KQatEImk=;
 b=KHrEQWfTfZt4Xf2+s2XEvyZ1hxKA0FOimZy/7ctdbNIhbqYMXSpjJxz2n2QeJXuPlmvD1lqsIt2H7wYuuddoBHmZcJ6n6/PUEVa4pDgPnm+Oaqv+PT9USIN5DBvDms5w2x1WBNO1iPRBgpEvgOSnQgAcZ+4eCtyv5ARRC67+QRM95DN0nCy7Tf8AN/UfFr3qusYTPpvFNYJVUgHWxkK3nDZURjrSU2dtLyKXK+z3QOSVpQrklOqnga0pRq9yAUrZoZo4W2iHRYVoWUjX3gG4+IjsLQvR+LJ+zv2OTD1P4/OuFWQTAmqK1apfE3hd6Pnn71YzPW1LYLwswC+8Ez1LVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 11:32:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:32:45 +0000
Message-ID: <17262384-94ad-45df-a855-4118a7685abd@siemens.com>
Date: Mon, 7 Apr 2025 13:32:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2] Add documentation to provide
 project specific signing methods
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 gokhan.cetin@siemens.com
References: <20250318124218.2193306-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250318124218.2193306-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: a4644eb2-534e-4f50-13b8-08dd75c7eac0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?emhXbnpaMVpaUEdBMTJUNkVIZ1lSTytPTU1xallWRXdYWlFxd0lsaUZ2TnlE?=
 =?utf-8?B?bGpZRWtvMGVoeHcvdG5Mc1pCR1BxUldqVVNIS281MGFJdGtkNVY1SkovOVcy?=
 =?utf-8?B?czFRZlRKcUZBZEVLeUR5Zy9vcVVKRFprc0h5bmtteFNtZlRBWHVhM2tvb1R5?=
 =?utf-8?B?aG95OGVwR0h1QXdRTnV0czROd2pja2dYTnZEYmFXV1NnRmUvc29tZG5GK2E2?=
 =?utf-8?B?S21mRWd0eG8yOWZlOEY2M2NpeEtEZUQzaDc2OFVXWVU2ci9GcXpkU2V3aTl6?=
 =?utf-8?B?a1hnZzdWcTNvUkkrWE8rS0ZQY0NzdnpxN0JURFI3cWRJdTdSSUhBdThQVUp4?=
 =?utf-8?B?Z2RhRkw4UzlKOXVMMGRnTXlPWHlJUDNSd0QvL3p3elhMdkNFb1YrL2FOeFdk?=
 =?utf-8?B?WW5TYUIwUm50R0VNQytlcnFwenNhMDRsZFhRSjVmTWNVb3JheG1XMHpxWFdj?=
 =?utf-8?B?a3AxOHpZc3V4MHFyeVB1eDlHcDF4VDM5dmJKMUUrdElKZzZqanJYNTNCUUVF?=
 =?utf-8?B?MzhKd2g4eWtQallGemxhUWdOL0lacVFab2ExaUlPTldWQWlobThXN3k5WFBx?=
 =?utf-8?B?bHVMNTljM0Qxdk5HanYwZ2NNSkNQTFFzTlJ1RjdKbS96VGpxbDQxZG9BU0h6?=
 =?utf-8?B?WWdSTXVwbFhYei9lNEMxcDBQa3JRcWYxeGRJRk05Yk52aGVRcVdPYmF3MmVz?=
 =?utf-8?B?Z2F6NTFuMTY4K0FtbWllaExRQ3Y1ZG04eXFiY2NPbzhLRjFMUmNrQktmM0dn?=
 =?utf-8?B?cnpFOFNkV1VoV3dSWC8vcmZMWE1XTzJRam9VQjZET0M3aGNGT09Fbmw4bFNV?=
 =?utf-8?B?bFFmeUk2c25WUGs3T0R5SHlxaWk5d0VSYjVTWmZYNW1FT0t4WVJDY0hMYnRV?=
 =?utf-8?B?dStQOTQvNlZUbUt0U09ScE5CUXQ2ZytuZUZBYVF6V0NFY3Rac0JOd0N6Z1pp?=
 =?utf-8?B?dU9BRkdJUHRBZ1NXdlJhSTQ5Nm9VRGVHQTV2WWV2Y1dJemlFMmk2c1dKb0FI?=
 =?utf-8?B?anJxK2Nod2ZZeU0vbzUrNlphTkVydWJrN2hxTmJtcDdjTmdMQkFjeXoxK01W?=
 =?utf-8?B?eE9INlVialhZOUx5RlBLL0xEdFd6UEJQUlV5SDJYZjYrNHova2tQWnljTmUv?=
 =?utf-8?B?TUQrTkhwMjllaWcwbjFSMExqRnNoU2xFczV1RXYxMnV1d215Y2hIVDhaN09C?=
 =?utf-8?B?RlYyR1ExMVlubE4zcDB1WW4vL1o1TXhzM0YySUxuYjlIdVJxVC8rV2FJNnpj?=
 =?utf-8?B?REtkVHpuVnhubGh6TUxBRkxFdXhONVhNQ1YwM2NUL1BUaXNUM0lZMXZSYklo?=
 =?utf-8?B?RUFBQ21DT2tsSDR6QUNQc3FmOTJvRmZEOS9TSlhyNERqZThOS0w5NHBPQ3dH?=
 =?utf-8?B?MlpRdFI1Slg5YXZSTVR5NE94M3E5Tmd6eGkrYkQ4VzFIOHljK2dwU2k0aFBk?=
 =?utf-8?B?VmpuUjNnNTI4OGlEYUxjQTRkakxTMloyaVFSYzNLUHZqWWxmVHYxV2cvMXRD?=
 =?utf-8?B?ekFOWDlqNVFNdnMxd2FNRGNoWmNmdmkxL1pManRNdUswNzg3ZnRGYXlOZ1lh?=
 =?utf-8?B?T08yRGRha3BCOURiV3JIenVIcHczZGRFNVdZblhRdm5wdVJEQy82NTRBa2tZ?=
 =?utf-8?B?OWZ5RndabUhjTjg1TTVSYXFSN2IxTndXVTVSYk44cVB5UUVXUlphTXJ6ak1s?=
 =?utf-8?B?QmJXT1NxYktUbCtzMTF6OCsrNmU5bjFpZzM3eFBocVBnOVVmS3NlZmp5M3pF?=
 =?utf-8?B?ME9QSzN2c1AyVTRyK3NBTmxHb1p1Q1QwREI2RGNLSWVzZ1l4Rzdmdk5ha2tM?=
 =?utf-8?B?VEdRcXNndlAvLzhnWDFSRjNJc1ZzNVJIQ0JGZCtKaVJvY0RUdlBSRnNVeGVL?=
 =?utf-8?B?OXRRaVc4K005NzBHaU0wMXNFSUdmeUlpcEFNNmNEOFMweXpFeGFQYlVoWGtF?=
 =?utf-8?Q?Lj2mx9JkAqc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MS9rUDI3U2NnaWQwWVlKR0IxNFhKbkxBTWN0TGYwZHhxbU1pZDJuOG05c0w0?=
 =?utf-8?B?UllvaEw5SHhKckR1ckJGc01aSmlDNGZDSEVqRGJ5Zkc1U1EyN1pXeklaZmkv?=
 =?utf-8?B?SXdJY09TUFR1Y3lnMFZYbXBtWFJ4bEcwOEJzampEVFllZ25yYldrQld6WVo4?=
 =?utf-8?B?eCtEblBTWlgybjZySnlQUWNJeFhsYlRLY3VjM0NKaVRQUmdpVzJvb0NOTDAz?=
 =?utf-8?B?YVZpSEZQWk5lSWNsVHZRQTB0Vk5NM1NoZHBnVmJCWWw0M3BSSDdXTmp0QkdC?=
 =?utf-8?B?T2J3ZHE0OCtpKy9uZW1veTlUemVoR2o5S0hwV0JZZUhjNVhoTU1kcVBDL2Zv?=
 =?utf-8?B?aUtLWHVnL0xjV2g2MTlwYWZoYVNXMjZ1QnIzYlhaN0poZUhKNFZNMjMrN2F0?=
 =?utf-8?B?NnNXS241Y2Y2RDhKTEdPSXhCNHNvd1IyckFQbjNNZGl5cGY0VXB5V2VYWGt0?=
 =?utf-8?B?TjJMWGpkOFlOa2xZNEUrUjMxb085RVVyamo4VkZXM084WmpBY2RQdGVuTUxz?=
 =?utf-8?B?UkFtUTVqOVJLRHFTREtPU0E0Y2xpWEcvenQySHhub1pidTF6UFRWb2ZwOVpG?=
 =?utf-8?B?VTdvWm02Yk13RUx5blo4bmJ2Y051aEMxYWw1Z0FmSWM0YXVSeVlHVkUzU1lM?=
 =?utf-8?B?SUtTM0Q3dXhMb20rUzY4ekpOTThVYzdVb015YlFRUFY0Z1owNUJvaUtZRjZJ?=
 =?utf-8?B?RXM3c0JyeHhIWWViY3FUUStUSDRLNDJtdjlHU25KZThiQTNkS3R0S3VaMjdX?=
 =?utf-8?B?YW43WDR1dGRXVmNCSFZwUDlvZzlEZU1BYm51OEwxMXBaWEdmcXpNRWg4cUFJ?=
 =?utf-8?B?WFdWU3p6VnkrSUNTTXlLMStuQUNScnVtRzBwR3ljakZwem5Rd1JHNVlBbmdB?=
 =?utf-8?B?V0p1bmZPRG1MSmczY2RDMGhRU1NnSklCWnZUQWhxa1R4QUxDL1lxQkVBdDB3?=
 =?utf-8?B?UzV0bzRxNUpKUE5RRkZRSWFiTUtDZGV2dFd6TFlKRlEyN2J6SlowZ1hlOVc5?=
 =?utf-8?B?MElWcnV3Z3ZjclJYTGI3SU5hZGgrUERoZ01MVExpRFNlQ0l6U2JuR2FPQ1Zq?=
 =?utf-8?B?ODVLam42ZkU1dlFWR1VkRHJzRDc1L0liZm1FNTJtMmI0SkswMUNJbkJid0N3?=
 =?utf-8?B?eFJySEg1dzJYVDh2NFRSSG9JaUhsMnh3ejBveXlKK1o0TDM4dUoxOXNzT1cw?=
 =?utf-8?B?endKZ1haT1N6RUNkOTBRTjhpZHFkZnRLTU1jMFNJUXgyL0RXZ245UFNaN0gy?=
 =?utf-8?B?ZTA4ZnhMaFo1YjhtMy9BZUxwbXhjSlpQR3hrdmZna0hnKzFZWjVZdjV5bDFV?=
 =?utf-8?B?L3NoTlNrb2NaVHcxWDU1Nk9WSzlybnZYZ3liRTdsUEtRNWI0NThDQXYxU2Jw?=
 =?utf-8?B?WHFZb3VHOFRSTHlhajdqdm9lYUkxb0taRVkrSjBnNnhQMGcxVmtGOTcrd1Fw?=
 =?utf-8?B?SHh6YTgxb0h0L3dYMUVUYytDcWNOcksrYTlpOU83MWlySjBrYVRpZG9KTS9M?=
 =?utf-8?B?MHl4MmFsQ2U0YXV5YjdtN0JDRnZMT203ZWRVZ0NscE9xWlZ6TzJJbncwTkFq?=
 =?utf-8?B?enV2SFE5aVRHNWJ2K2xsVXBSZWw1dW1WaFR5ZzlVVE04NGNGNmN2NGUyb1Y0?=
 =?utf-8?B?d3Z1U1JkQy9SdmpVTkh4RXFDbGl5UGJUdDc2eDQ4UDgrZFN5NHlpWDdMbm9X?=
 =?utf-8?B?YXlDM1J3YWR2aGUxTmRRQ05QZS90ZkNlbHd0QVN4NjZST204ZE9UV0JZaW0x?=
 =?utf-8?B?a3F6UTVGS0YzakxJbnF2UDU1MDZCTzFJOXFqYk9SMXAzSkZON1l6MjB5TDBa?=
 =?utf-8?B?WEdpb0NwMnY2Q1pFelNTOXdCNStVZmw1WHdnUFBSR1N0QndNb3ZVaGU2NlhI?=
 =?utf-8?B?MUlXWXk0N2dubXQzNC9VVlJoVUtaakt2RXpQN0FKdndpaURsS3d1ZTlyQ1Q0?=
 =?utf-8?B?NDd4dUtOaXNUcHBud2M0UFFaZnNWbC9VbmNEVmVncVIvUEN6ZTZ6MUxSRkdi?=
 =?utf-8?B?NG84UHpjQWc3OVF5MUZvN1dwSDdLQmV6STdMZTVWbDVmeGdHdVFDT1BkblZs?=
 =?utf-8?B?VEFYb2hZVXZjekY3UldIQmdDRGdsVklHVTlrc3NQMURIYkhncnhCUmdaOW12?=
 =?utf-8?B?eXVTOVlIWXc5VTZQaEtBeDRHUmduc2o2clpNQm5Qd3pxSTlYZ1NFZWU4Zkow?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4644eb2-534e-4f50-13b8-08dd75c7eac0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:32:45.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNMTUBo5A2GdOZeidg/Q885CHvOJbXG/2lLUaaIHKy1s1LwEvy1TA/361LFmYBOUTqshgZ6amcRyA5Mc7c0u5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9156
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 11:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18486

On 18.03.25 13:40, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This documents the preferred way to replace the signing scripts
> provided by isar-cip-core with project specific variants.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - fix typos
>  - rename to README.signing.md
>  - Add sentence for the default implementation of sign_secure_image.sh
>    and the used certificates.
>  - Add sentence about certificate providers.
> 
> As we had the discussion how to unify our signing scripts this document
> provides a overview of the current state of artifact signing in
> isar-cip-core.
> 
> It is currently a separate document to have all the information for easy
> access in one place. I am open to split it up and add the specific parts
> to doc/README.secureboot.md and doc/README.swupdate.md.
> 
> If I missed something please let me know
> 
> Quirin
>  doc/README.signing.md | 91 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 doc/README.signing.md
> 
> diff --git a/doc/README.signing.md b/doc/README.signing.md
> new file mode 100644
> index 0000000..327d981
> --- /dev/null
> +++ b/doc/README.signing.md
> @@ -0,0 +1,91 @@
> +# Handling of signing processes in isar-cip-core
> +
> +This document describes how to replace the signing scripts
> +in isar-cip-core.
> +
> +In isar-cip-core provides the infrastructure to sign:
> + - EFI binaries
> +   - efibootguard binary
> +   - unified kernel image
> + - update binary for SWUpdate
> +
> +isar-cip-core uses the Debian snake-oil keys as to provide an example and during
> +testing.
> +
> +
> +## Signing an update binary(*.swu)
> +
> +A swu contains the signature of the `sw-description` file with the name `sw-description.sig`.
> +This `sw-description.sig` file is created during the swu image build process by calling
> +a script call `/usr/bin/sign-swu`. The script is called by class classes/swupdate.bbclass.
> +The script has the following call signature:
> +
> +`sign-swu <unsigned file name> <signature file name>`
> +
> +The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb`.
> +
> +To validate a signed *.swu the image needs to contain the public part of the certificate which
> +is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
> +
> +## Signing an EFI binary
> +
> +EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
> +The script is called by the wic plugins scripts/lib/wic/plugins/source/efibootguard-boot.py
> +and scripts/lib/wic/plugins/source/efibootguard-efi.py. The script has the following
> +call signature:
> +
> +```
> +sign_secure_image <unsigned efi binary> <signed efi binary>
> +```
> +
> +The default implementation of isar-cip-core is `recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb`.
> +The certificates used by that script are provided by the package
> +`recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb`.
> +
> +# Replace signing scripts
> +
> +The preferred way to add your own signer is to use
> +the overload the necessary recipes with `PREFERRED_PROVIDER`.
> +
> +## SWUpdate update binaries (*.swu)
> +
> +To use a project specific signing script, e.g. when using a HSM,
> +add the following lines to the build configuration (kas file or in the
> +conf directory).
> +
> +`PREFERRED_PROVIDER_swupdate-signer = "<swu signing package>"`
> +
> +The project specific public certificate can be replaced by
> +setting:
> +`PREFERRED_PROVIDER_swupdate-certificates = "<swu certificate>"`
> +
> +### Content of the swu signing package
> +
> +The swu signing package needs to provide an script at the
> +location `/usr/bin/sign-swu` with the call signature:
> +
> +`sign-swu <unsigned file name> <signature file name>`
> +
> +The package can provide additional files necessary for the signing process
> +or a separate package can be used.
> +
> +## EFI binaries
> +
> +To use a project specific own signing script, e.g. by using an HSM,
> +add the following lines to the build configuration (kas file or in the
> +`conf` directory).
> +
> +`PREFERRED_PROVIDER_ebg-secure-boot-signer = "<efi signing package>"`
> +
> +Alternatively an own file name can be used by modifying the signwith parameter
> +of the boot partitions and bootloader partition as described in [README.secureboot.md](./doc/README.secureboot.md#wic)
> +
> +### Content of the efi signing package
> +
> +The efi signing package needs to provide an script at the
> +location `/usr/bin/sign_secure_image.sh` with the call signature:
> +
> +`sign_secure_image <unsigned efi binary> <signed efi binary>`
> +
> +The package can provide additional files necessary for the signing process
> +or a separate package can be used.

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

