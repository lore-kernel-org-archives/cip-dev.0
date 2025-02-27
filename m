Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D18C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 12:49:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.88])
 by mx.groups.io with SMTP id smtpd.web10.9784.1740660585577798685
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 04:49:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LQDPrcVB;
 spf=pass (domain: siemens.com, ip: 40.107.22.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmnf09GwkwayzHDUiyGZ9UYIO9XN4i3WJx/PtHfP1ioBwLbEAw4uXt4mfK7ba48WdtZagJin+Ms4vzx6+38lBqggyamZPNZmTGykpsFXj1dQ0nT+fZaA14ExbdSbXbhgx7T5vzH5ijPjZS9gy4iOboxoSncxYZeXP4s97/xy3ykEKn+8+ExAlsa91AuACAJ70F7cY9Qn9DgyNf136ve1NXhxMh5wvMmYH11d3b7f9GbSyGqYH23KPoQwlzS4H0g6qpudb9/svmWkesIpdmM+lC1G1VOmQWj+xVnXv3M6cuYM8iHy94NPyp2AzQ7U1Xc+F3msEPRIUewnnT4PvEO1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR69mzYhHABsSxf6/nwYmHZuVma4BdK7RpANTaqd0nA=;
 b=NSvhY45IvNb6U6CxN3+EbemHMbOvaPYkp/Rib2w+70A1JIHeEN+PWV+rrdufFmGc2cx2gsmENr54Pr8D37/zzh3W1qITWhyoT/RxqelY3sJUkHb4Sb9sIPvxbhG+nSfTehymKgc82oZZabL8nSG8x09Xxi40nPwCHRYKRPSSKnRRyVO2WOgBhcShKLuHlM7pkEoYF7ywZvvmq2URT40HTZr297PfW8t57+ZuH1DurpFE5DXWlSxx/oHjrUlf7yU2qlSKQu8fR3Z5+5CN8Mg3ZcLx6f/d7DqofzzKg+7D6Jk2rzgxv+IKfBmH3nlBWKKNKEHJHABdj65g1fSWw9HyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR69mzYhHABsSxf6/nwYmHZuVma4BdK7RpANTaqd0nA=;
 b=LQDPrcVB5GrRdI4hPLo38rrE/n81xMsKYOAdwfiW8202RMA3P1YUwJcS+SoGvUWjKfELqS/te4xo9z+MGpUI4GzBNXtrAjg1vYngYB6DLq9THXoO6Rt1wfWhrd4v7G42Rb0yw+Oab4+nVIBxm+dFjbUc7koHFBYuOvPeygEzg/7F3Jy4F85j1SF+boH50syxjnuKRiskozSebODJHdMxgAk0Qzo9AAM5mEk44ywchMWziGfBNJuBTvWJS5xS46oUdydjEhNGoVOocVn2+cEHzO3PZ7B2KZeyQioHT2AsoPjO+LDMBPBSJTIDsSBnnYRaCtcdagz7k8Lahu4aA2CBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 12:49:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 12:49:43 +0000
Message-ID: <2ba5dd2f-1deb-4650-a65a-067e3e217f4c@siemens.com>
Date: Thu, 27 Feb 2025 13:49:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] initramfs-crypt-hook: use real device path in
 luksFormat case
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-4-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226095921.168962-4-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 813adc82-d445-4010-7e15-08dd572d34d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QU5tTExWZzhOdEVxWStCN2NYMnpuMUNqdzNveDIvOExYZGszbUFzcEYvaVYv?=
 =?utf-8?B?WlRubVpxSVlQR1pFZVlPNnMvU0pieHdCSzlYOWhRazZYNzNySGhObUNtamxD?=
 =?utf-8?B?V0R6ZTJEU3pMNmwySy9LczMwM0N2alRhTkNnallCOXdReVZjOFo3ZEs0MEhI?=
 =?utf-8?B?SC9yRDZoZW4veHJQbW92MFV5VVU1UXZQd0k3SFY4ZWIrLzRuUHc1NmltbU9E?=
 =?utf-8?B?U2dweGxWN0JPQTFPYWFwQWE1blhHVVZmenNTa090cXNBazVNb0JSa2FqTDd3?=
 =?utf-8?B?OW5EUTZOOHhSL080SHJtT1o0RG5lTmoyNW1PMVFsSWpMQ21KeTNJWi91S2tV?=
 =?utf-8?B?UDBVQkpkbVQraTFudjVvTTFhTDRxbE96aktZcTB3Yk9qRTNXdysxWFhreHRH?=
 =?utf-8?B?MHU4VW1wT0IrRkVFNzRiMGJvbU5mT2FiOFd5SUU5UUZXbHV2WjQyQ3pOcW5r?=
 =?utf-8?B?QU5QK2VrY1hNYk5pSGhDWVV3TXk5cmZEOVBxM2lkTmZ5V2Q3UWdnNUY3Mk14?=
 =?utf-8?B?VGRscGlpay9veGVDNndKZDh1VEJFUEc2YjFLRTJxVTdCZk9yK0d0ZTRiemdM?=
 =?utf-8?B?QmwrZFVFUjY5bmQzc2xnSGUwYk5GaTJNall0bXJlSEpIenFLUHM1T0dSUXdt?=
 =?utf-8?B?MENjbGRHbit5Q25sU0dDcXlXMXYzdGVRUnZvMDF4NmQrODZiWUhtazNDL0J6?=
 =?utf-8?B?R3lpdUFkeDhSb21GV0NhOVhHc1ZCRnRtYXJjSklSb1llM0RGVmZiWUtHb3VP?=
 =?utf-8?B?OWV1cGo1b0tHLzc2VkhlNkYxS3h5TFRPNmdoS2dlTU5Cb0VoY0FLTjMwd3lk?=
 =?utf-8?B?Q1JYVGNpV0F1QWpndjExVmpBeEpaT3dHc2VEWEQzWndCdlRPK3JsSmNicWV1?=
 =?utf-8?B?UUJnM1dLRTYxUmg0cFJjY3FLTGJTek03Zkg1TEg2MzhPS0cwSFZmRkN6MDlw?=
 =?utf-8?B?ek82QzVCVGxQUzNqVnVJanNpZlRFNng5TFhXSmMxWkMvR3NzNEVITVBFazVC?=
 =?utf-8?B?UEFYbWFqUERhRi9meWlBM1JBdFNxc25qdmVtTTZRUXFPMjU1Z2FLVHNCaW5E?=
 =?utf-8?B?Vklkbm10WWpTTTh5bnhQcXdDSGhWN1R6Mk85em5OU3FEUVdKZXhjS0lTaVpO?=
 =?utf-8?B?ZXBXU3kvNFNaL09NRWtmaThnODkzazNOSGtYTXN6eCtPWnB0OHlHcGlLTldw?=
 =?utf-8?B?Ny9tQW95cTN5V3dpdlgvVlIwVkhDZHh6cXVRMXdldTBSS3krY2lHSDhQNi9Z?=
 =?utf-8?B?eStjNnQxUUw4MkdwWHROWEZtMHNVZkdPOEx1VHJZUHR2M0NQNWNsTDVOWi83?=
 =?utf-8?B?WUFEMkdQZER2MDBxZWZ4ZE1IUVRFOTVicnJEZ1FZNlZxNk90aVVHemF0bHBy?=
 =?utf-8?B?RWFtbTZpTEhDbzlaQ1FMZXlJN3ZGT3dKakR0Rk83SFZuTEJlT2F6VWowUzMy?=
 =?utf-8?B?YlRsS1VEVi9QWHkvd3haRk51ZEk5cjV3bmpxYlVJK2JHd3R5K0dxZTJyUUdx?=
 =?utf-8?B?WGhOS2d1cDVkWitxbTA4aU1hb3FURWFZaXdoVjZaYlBxOTl3TGNvaGt2bWwv?=
 =?utf-8?B?ZXI0TGFQSXJiOU9JMkdPRVNQQy9RK3dmMVdmUG1DL2FwY1RFQVdPNmxyQ1Q2?=
 =?utf-8?B?dGdpamlSaWRvWVlmd3dVNkgxTjdtNXRvVGxBUWgvUG8xVWhhWjlCS1AyOURa?=
 =?utf-8?B?SWRoMzNUZGl0QTgwRXdHL2s5VmVIWm9CUFRjLzNqV1BpN3R4Lzl3V3FCaUVj?=
 =?utf-8?B?NkVQbS80QTk4MVRBRnc4UWVjU3dyemRTMys4RXpQU3puNjVlaXdJZUpLbGQ4?=
 =?utf-8?B?ekFsazd3QTNzNE1FQjVPU1lLL2xQRUVvUVRTSG1YeHRFbkt5WDI2UXdUTGsz?=
 =?utf-8?Q?SHUuL/XXYXp/E?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emJMNGU1eDRjWEg1SnlVQnY0SnV5UFM3TGpISk1QZU8vOHVRMEtXU3BMMGUx?=
 =?utf-8?B?VEpYcmh0V2pvSlh2QlpQYkVwb01RZTZXUnR1UjlBRVdvNDNWQUZ5dUdzUHRG?=
 =?utf-8?B?S0lqZXAwS0ZRMk5RMTZYczh3SmdQVTFpQVVmZnlTQ1ZXeFkyQlhSOG1YNExF?=
 =?utf-8?B?bzFhb3Fxdk9DUmhsQTJrSDdaRTU2YVJTSHo2QzFjSGc1NlJKZG9HeXZxUklI?=
 =?utf-8?B?RnBXQ0Fpd3NKLy9WYU9DTDRXWnROY1VXRWV3YlAxUkJYV3ZKeE5KaUJvNVNn?=
 =?utf-8?B?NXNFanlDUzE5eTQ5SkM2UGc4NVdRZEtZZGJrZjE1b2ZGVGQvZm5KUS9QQWFZ?=
 =?utf-8?B?MHRPUi8vODFSTnNwYnc3WUFnc2J5RE5PK0pTckN6VWhsRHRTOUNLa0k2N2pW?=
 =?utf-8?B?RlZRWjhiVVhKcWt1VmtxbVVONE5OUHJtTXQ0cG82NXVmTnBENmUyd1kyeFYr?=
 =?utf-8?B?VzVrcVBsQThyaVVDMENWVUFSTytsTFQyNVM5clFkcy9XTC9XTEtCOVZsdGh0?=
 =?utf-8?B?SHRRVmhrT3liZ1U2WlVmUlFjZjJVOEtpbEVuN2MxWnlmSjVETzE5VTkrOUVT?=
 =?utf-8?B?SmVoaVpSTTNxVCtlTlBQY21TUjlnVDh0b0NPcFlHQisvczg1YzFUSmxEaEVO?=
 =?utf-8?B?UWQ3TCtXMGhzNmZKa3M3SFBRTTgveG9SZEVoaWpBZnN3QkRzaUJaVGF4NDg1?=
 =?utf-8?B?ZXV5MWlMOGNkM295UWFsL0FMWVgrKzR6TFVIVFNqMmpIVEJqeDgxSXlvSERn?=
 =?utf-8?B?UDBxRnZiWjlYTHhzMjZNcitKRVZhMlhUekZxZDlNV2NKUmxtWEFuL1BZeWUz?=
 =?utf-8?B?WVh4Zm9BVzVRc21wVVZiUlFPZGpJZmNWZENCazZqcUZVcVNTWmFqdUttVEZx?=
 =?utf-8?B?eUZMUVJ5aEFqNWJJb2pvUVJBRjFPSWxXR29TL0N3T3ZZVXJVOFk0TjdNelNO?=
 =?utf-8?B?QmR6bjF1ZDNVanZnZ2gzWklSanAvUlRVK1NpY2JvU0VnV00zVlNvcDQzVlMz?=
 =?utf-8?B?ZjZPR2F4cXp4d1kyLy9pOVdKV2Z0Y3k4KzRvOUZvVkpIbU13aGsrcUUxOGpu?=
 =?utf-8?B?RVJSN3o0NFltMUZ5VVpXNmluUUFSei8rdHBpNzZmOURNdlBDdGZMYWRLL2RN?=
 =?utf-8?B?TXBKYm5xVE1ZenI1TkRqQnZMcEU1RTV2R3psUnFBRE1xQVJnOTlJWksxMnhi?=
 =?utf-8?B?UFVQNlpmbnlFZUZnakdVSnVvTThqL2dWVjI2NnRwUE5zdHRjakJXVnNjRVBG?=
 =?utf-8?B?TjlFRXZtcG5FMmNMeWNJY0hxMjY1b3dGTXRyYnFoa0ZyMUFSWXBrS3hCN1F1?=
 =?utf-8?B?di93TWszbDBLQlVuWnNzb001bnVTS2F6aGcwQjdJbzJnWmtEWEhuU2RhbUZm?=
 =?utf-8?B?Z3BMbjhabHhGR1VPaEczOHpoTGdtcjlIWjdaN2tvM1AwbWgwVUdoOHFKbVNN?=
 =?utf-8?B?elE3UzhmR0lTQi9kN2U4UGk4VlA2bXdTTjBvNlpOVE5wM0UvbzdEbUw4SlFz?=
 =?utf-8?B?K2FLZEx4cnpsL0JPV053enBXcWJ0VVZibExoNWVwTXpLVXhtcHNGZjc4YjZq?=
 =?utf-8?B?YWhveGNpb3d5VlV0ZW9WQ2hEWURvT3paK1plQzN1MEdxQXJFV3pCUXA4VTRj?=
 =?utf-8?B?cWxacDdiVzdTUC9JakdBQVR2WGtuTDlRanpDRVhScHR0Q081aGNYc1U0a3Z6?=
 =?utf-8?B?dzdEa3RRdURsUGc1eWl3WUxoZ0V6dHE4SUtRUDkvSktFVklJdS96bnl2Q1JL?=
 =?utf-8?B?YVhzdnJOajY1SEx3TEZ3VVlIVW1jdERCMWNQVHJVdW5qaUY5N3FQYlZpNEJo?=
 =?utf-8?B?aHQ2d1pzdFhmcEl1ZS9HRlQ0Z0lzNUFXM3hlb1ZnSU5PbVZ6RjRHQmcxcG03?=
 =?utf-8?B?dy85QTd2UFlkdm9ibjZVSm5ySVBJMG94RWx5ODBlNmhQMFNHZVZ2TTFVMzZ6?=
 =?utf-8?B?MmNPRlRFS3lnWEQxalkrTGppdm9ZUEQ5R01pRkUySDJLdWFKVUpsZmg2ZmZX?=
 =?utf-8?B?b21hb3ljTFJVMzh0QXhTTFI1TmxTb2tpRWhBQkpuR2JVNWNFUEdhVE1pSy9v?=
 =?utf-8?B?VFlpZ2FKUkZ0OHJnckt5NWlrcUNvNWlYNWhVVnhVMmtHZWJmaTYyaDNkVzBM?=
 =?utf-8?B?ejRuQm93N1J1OU4zR3FJRnpmM1oxNzhyck5vMWdWUjZPenhkMnhzT0Y0b2R0?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813adc82-d445-4010-7e15-08dd572d34d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:49:43.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ+0qWb+lzRbnvhAErNOCPV6yrXhXEYqb80hxab4TaUBAScobqaCF8vl26Pj0f2mqM54ub4qc1UfBrtBTFx2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6662
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 12:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17938

On 26.02.25 10:59, Claudius Heine wrote:
> In the 'format' case the `$partition` variable is used instead of
> `$part_device`, which is likely an error, because all other cases use
> `$part_device`.
> 
> `$part_device` is the real path to the block device, while `$partition`
> is the 'name' of the partition in the `$PARITIONS` variable, as defined
> in the recipe.
> 
> This fixes an inconsistency, it shouldn't be a bug here, but could
> result in bugs when this script is adapted in product layers, etc.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index f1aa0d7..b907ea7 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -254,7 +254,7 @@ for partition_set in $partition_sets; do
>  		"format")
>  			log_begin_msg "Encryption of ${part_device}"
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
> -				 --type luks2 "$partition" < "$tmp_key"
> +				 --type luks2 "$part_device" < "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			eval "${create_file_system_cmd} ${decrypted_part}"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

