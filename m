Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A06C27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 15:40:44 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.79])
 by mx.groups.io with SMTP id smtpd.web10.11760.1718293236207493036
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 08:40:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tF5pFWXJ;
 spf=pass (domain: siemens.com, ip: 40.107.14.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0R1CZF2/rDN3jChk1v+1fpQNXS4REAK1suDrG+MLzPVQvD8nZmIobe8qQUxxS2jhXVg4gvGJno1yOEGDb+YU4tQgSrGa99vU0reocPrXMTC0fe6TQ4gtLiJxjWBTLlPKH+K6WUhNl77Tn7zo9Bsk9piUOop/sA7ZiedVEfkGH2MJ6WbdOTOUQrOc3CJ0DVH6ZRbdNEq2/I7nIiVz41UmouU8bJa6EknGRI3BOqaKealwe8nN4BW+GCtzvMjmGfrwhK0PfDO5tm6p5YWc/LI8dvvZibXBUNja91tOjaA9QwAk/ps4IMfwJ97+gh8/n1jDmZXbMKqnGidJYuz3Ppx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t81mxqxA2te/kLZpZd5o2QmWEl+mqB/B22KaRU8+lNo=;
 b=l22wQqC6VfMvl8LxIBcPlcEVNeb3wJ7LgpI0RME1DtFWi7VBTKmCLKk2iLjKkU492WV5hOcA3akenWqJrDq/zNJEAYg88SDIeCZGMabZdWMEUB49YRnpcrlz5iqF5vJmBfTZ6X+bncGQic+zmxdNXunuKSGjp1mP0mf+LQ01SBH4IxhqI+0f4Euf3TcmhimsDAerKRwnw+P9Kke319xgLw/SSCWmf1YGgd1XJ6ao9zvaKH2LT1iYab4hxXH0Yb9/jCmv2bpInfgOLLTsZ5HPdB5gsg/D5qyMGlNa15JHwS/6nPf8One1rux8Avrc3pyEHlr3oaf4EGk3X8HspO8LpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t81mxqxA2te/kLZpZd5o2QmWEl+mqB/B22KaRU8+lNo=;
 b=tF5pFWXJWeqV6BR0tsQfzdkuvQNZlea6UEtymCPqzpWAJB1hicjspW9CQQaOdd6HXVBdz4BIdF0DG6cyTRsuvaf+AsJVNAvQN3geQkEChSsxogPAxIt1Ojdwa/vuFdugcLIcgrIJ2na3/DJsoS1nNfXNdGm78rmG3jbHCtdARMdT7nTHYNtHOlVqVeGIny6O+VURJWSfgsXc6qoBUlpQR1FIkl9Jfm9Mo7EztfdQvFGNIALvOZl5F66+g67ulX7IRVkjpSIZNyTtTn/65XYdvxQQMgD+gqFHvCGpriAMXVozesn67uNMa+wuAZFVuPo+io2rDFIf7PcoAWaNxeuDvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.38; Thu, 13 Jun
 2024 15:40:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:40:32 +0000
Message-ID: <7ebccc12-cd4e-4d58-9345-8609df2b71e9@siemens.com>
Date: Thu, 13 Jun 2024 17:40:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/2] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
 <20240613091636.1156475-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240613091636.1156475-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a8a14-5f4d-4ae5-bbac-08dc8bbf28f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFZibjdsVTliYW9lZjk4N09vWE0weWxjdDFVY2pSeW13M3NBeTdPcHNkUENS?=
 =?utf-8?B?Y0U2TW4wTmlJckw5Ym1nUm8wNkpaek1RTU5hQ3lsMHdHLzQ1U05seThuYUlE?=
 =?utf-8?B?alJlR0EvZWtrVXpWWEtHYTNMT1UyLzVvTnFPUFBodllEc2p2bXdkOFcwS3Ft?=
 =?utf-8?B?YXFtb0RNYVpKeWJ4alNXWnI1ZkxQeTZiUHFUZnNXZVhrM1J0SUNUc1cxL0xH?=
 =?utf-8?B?YWRVRkE3M2hxc0I0NmkwQkovdjlIalRFaGN1VndQY043dUVEclB6Y0JjbE10?=
 =?utf-8?B?dlVnZEpuZUwyVlZhRmt6ODA1YURrOG1kN3VaejNCWm9qaUpGMDAwK2FaQm14?=
 =?utf-8?B?ci8wWktaN1NkSlVaYUlQWWFKNXMxc0t6RGN3QTVjRjRsaytTbUZNZ3g1d215?=
 =?utf-8?B?blUvQXpIZUtOVkYxQWU3RmswRnBJRHNBVTV1RGx6SEFGQ3lQMmJHbG8xVlE0?=
 =?utf-8?B?ME10eTJzQ1B2T2FXc3dVV2RERzBMbytGQUkzL1RpcE1pT1NseWg4a2Z6N2Fz?=
 =?utf-8?B?aTNhemtWdzNJKzdqdjRXN282NG5jMUo4T0c0NHJqRHlYbytsd3dLeGJnM1Va?=
 =?utf-8?B?cGJuYUh2WGxBWGh1VGlKdFRxWkNPdlVLN0NrWmVkOHE1M2VaZjRiV2ZzT0VC?=
 =?utf-8?B?Q2Y2M1BCTEVPOHBkTkJ1R0c3UXFVVW9mTENBbjUzV0p0SlYreW1mTG5LYzlJ?=
 =?utf-8?B?OWt4YjVpQTUvUnZ3eWJPN3Rxcm0xNndybHZkUEI0Ujh6N0pxSXpzZ3BoRUly?=
 =?utf-8?B?YkpBU283SlVNZ1psM2lkdDF4UVdYRFIwMUFrY000bE5kbHk4NmpTR2MzN2pt?=
 =?utf-8?B?OFBxUVJ1SjhMRFJHSGZHSVFTMlpQaUZrc3hrWElQK1YzMVhRejZ6L3J4Y2g0?=
 =?utf-8?B?V3NNKzMzK0VXOEdncmVRU2hDNXY0YXJDbGF2cWVhNUcrUTJOb3haMXN6Znl0?=
 =?utf-8?B?UlZYeVlEYjY3UkRJc29QVkxHOWNDUnhyTm9xNGhGeHJJWmhDdjBYTXpYMzBC?=
 =?utf-8?B?ZHdzc3M3eGo3UFFyTVFUK0gzSUdMVnVWY2VMcDhJUDhFOGZWSFljUkxvaXla?=
 =?utf-8?B?NEd6OFJFMTc3OWI0RnZRaTJLRFJhS1Ivdmp6Ty80SS9udWRIUkZpSzA0NmR2?=
 =?utf-8?B?ZHducTltN0dZLzBkMUZPVkhqb0JQSldpZ1NDSkdxMXJ4K2x3YXpvYTRESVFR?=
 =?utf-8?B?aWxsSUxiVzV3RWNsbHo1WUFtSWlqbzZwVVhVbDNKdVVlL1NraHBVZEVOTWN1?=
 =?utf-8?B?VGpyOFNlMnhhQUhGYm11bi9Uc3JOYjV6SlREdUJhZk9zS1NEMHFVQXZUOU83?=
 =?utf-8?B?dzZrR0FkZi93bkthTjdYMVpRQWQ5eUp4SE54aWFhK2FuTmpmV21NOVVzTHFX?=
 =?utf-8?B?aEl6Y3BLSHExWGM1YUN3WG50V3U2Lzc5b0o3cXV0MEtQYnlZbkcvaFY1MUxW?=
 =?utf-8?B?cEw1WkViNHpPRjR1T2FHRFExbG1pMTBwak5aOFlLckw1a3JQRmF6WGMrczFj?=
 =?utf-8?B?TXBQOUJ1UFpHV1J5SWlMeVdZRUsxY0JmY0trOGtMTkJ3TlBWVnBUL1pTYkRD?=
 =?utf-8?B?UE1ZSlIwazR1TFJWUElpZ2NoRW9aclhZemZDQ2IxSFQ4dzFHWlY0cGU5M21y?=
 =?utf-8?B?M2RoTkRpTVJPVTZublc5bnBpWXViNmF4bXEzbU4zOXJNVWF3czRzQTBHdmVE?=
 =?utf-8?B?QWdxekNFN3VFMkZ6Lyt6b0FLdFhqaC9rUzFicEZnTWNHanBVK01PNUsvRHFI?=
 =?utf-8?Q?nLonbv5yLCFvyuoWe0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTFWSVJmaDhRRkNMREsvcE9IbHBuQXZCbkNEVFhqdWhQK25IVkZHcTF2MjQr?=
 =?utf-8?B?cEg4dzI3VWlZU0NqakhjMjRJTWVoYnpuV3d2c2ZyT1o5V2xyTXJoWFA0NFhE?=
 =?utf-8?B?eUlJS2NKcmxiMlBBbjVPSHpIdWx2Zi9sMm1OTTNvTDhzdDhYUHlkc2dTVXhW?=
 =?utf-8?B?TlBtUjNkN1p4SHd6SVZ0b0xDTDVhRHd6VkFUTlBUcmdET3lEWG1wMVQ1Yi9z?=
 =?utf-8?B?WDcvZUtYWnBIK2RyMHZYbWVrUzAzK3pUZ2ZVS29ZSEtqemc2MU96RThCWXpD?=
 =?utf-8?B?R2tKTFRFWFRGZ0p3aWdVVlE4bk5ScUdvcjRvMzkyZTN2SFI1KzJsZzV6VXRX?=
 =?utf-8?B?R2dsemZkN3Z1RXpHS0VER2x3UStaOEErMENzSHNobmlSb0x6QkRnNzA2OEhB?=
 =?utf-8?B?OG9aMW5LaUpuTlBLSFdTR2s4SDJKVW4xaW10N3JBaXRQV1FiVC91Ump0SUk5?=
 =?utf-8?B?enJOMTVBelJNa3dyZDhmZUdURGI0VTU3Wi9HWGN0MGFYZ0FGc2J1WGVoREt0?=
 =?utf-8?B?QTFvUlpOTDlnYjNqY1NPampGNTVUMVo2UlJKU0NOZEZOMVpsVjJvL3pxMVpX?=
 =?utf-8?B?dWVNSlRmM2ZveENHbzk1cUVDVFh3dTJ6c0FkY2dsUHFTOFdBM0dRWUg5RENS?=
 =?utf-8?B?d1lpbmIwdC9mbVFzWXdxZitrNFhibmR3SzgvNVVHNnQ4NVJJbk5qa2haRWl6?=
 =?utf-8?B?bFJWNnYrd1VOeGpNWFpRSXdWcTQ1bUVVS1NneXhydXJObUxpcUZ0bUNGSlQx?=
 =?utf-8?B?dGhmSkF4bU1GeGs3OFE2aVc0K216M2FXUWpHU0hTVmZpbGtBOWxZaXBmYWhV?=
 =?utf-8?B?cWNPYUxDZFg5VndjZjZOVXErNmU1MGE3d3B0cW1UUW9PRCtZWG04MnFZYnZO?=
 =?utf-8?B?ZWU3VGplb1hIUk8zRUNWZ215L0Z5cVpZWmt1eHdLQ3YvU1UveUtKNnlJVmcr?=
 =?utf-8?B?am9EUEtLYnhxUHA2eEFVM2Z5YVJ5RVV4ZGZCOUpTRHV0clRDeXJaZk94bDIz?=
 =?utf-8?B?SjR6bUcvend1aHd4ZjNuaHdxajdVTFFoekxRVGhwRzYvcXE3SWZOYVQ2Qk1P?=
 =?utf-8?B?ak5DYTVRRTQ0cjh5R0FlN1lrNFo1elUrclp6ZGVDTi9RS3RCc0o3ekE1QzlC?=
 =?utf-8?B?eUZkVS9oLzgyRS81M1RnUlFlbmZLOEFGMkcyZWorRFFIeCs5bkFGU0Z5TkMv?=
 =?utf-8?B?bWZ2VHJob1BMM0VkeE1ja1hpNWJIOEJ2cWQ2ZGJIZzM0L0pZVGdRYUJBbm1i?=
 =?utf-8?B?TjltYmZsSmNzM1BidlZlWGNldWJIdHpMT3l2SUpCWktFeXQxeS9mclRvU2tk?=
 =?utf-8?B?eHVEalNHeTk4Q3J4TWl0dm1QaWcyb01vcVNUSVRNQ3Y1WTI2T2k0ZlR0dW5W?=
 =?utf-8?B?cWRyNXN3bjVqdzJCQUdtNW8rN3hsSE80a25mdTNuUFFvVEZlTXFlTVJ6aUln?=
 =?utf-8?B?aDRKOWJYaVJoRmxhQUNaeENXb1R2b1FEZ2tZT3daaW9OUGNvZnAyYkpNTEhw?=
 =?utf-8?B?SHhvNG5OWnMzNjZSalByVXNLczNnb2QxNTJaYWkySVQ5c3ZheHNac05pOTdE?=
 =?utf-8?B?bHNpcmVsTEdCM3lrZUZKQlZ4aVRYYjVSTkhsMjljYTBTRGY4aU9XdkZKL28y?=
 =?utf-8?B?VG1XQnRzR2RsWTdXN25zNFRaR3ZOT0Y1S3JTMjBEN3BJT0dmM3Jsd0VOenhI?=
 =?utf-8?B?R2NkQXl6YkUvamhoa1IzMDlBZjBTNHNGc0FPTTU0M3JVZkVMTFBGYW55cXpp?=
 =?utf-8?B?UHc1clFVUEIrTUEyVnU3bVlLdkkzNzhvdWhjNUtLRUpkVnpFQUM5anFWVVl4?=
 =?utf-8?B?L1BnMFNZUG5XeW9PM2xhVUZXVmdnYkVoaTAwaE9PY3lYUktPbU1UWHloZnMy?=
 =?utf-8?B?UDF1OG9NdnB1TlZ5WWZxZDBEYnl6Z2tvVWxpRzlGdFloelFGUGRIWHozTzk1?=
 =?utf-8?B?WnVNTVEzMC82R3ZCUVRzZ3ljazJIV0VRbnBUYmU0OEd6SkVzSU9adXpkSUNE?=
 =?utf-8?B?L1pCbVZmWmY5KzB4MTFJVTlJbVlhYkJxaU91NmxCeTNGVVFqeSt3ODkvdFVY?=
 =?utf-8?B?WHAwQ3VMMWpydmtmUmVHMDJUem0xdytWWVpXUWd3bHdPYWZGZmQwVkRWc1cr?=
 =?utf-8?Q?dq5K7RB00Qc6cvjtr+dRzFPfH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a8a14-5f4d-4ae5-bbac-08dc8bbf28f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:40:32.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiiLNfvaMS6PoO29bqDl1QrxnLXPkN5OLB3nqtZwWpXEcuvpzaCeRHhl1jM80k+Gip1qcXLzmczVuLmMxYH2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 15:40:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16220

On 13.06.24 11:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the issue that wic arguments --size and --fixed-size
> are not correctly interpreted.
> 
> This fixes issue #104.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
>  .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
>  2 files changed, 9 insertions(+), 55 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..2b06fd1 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -136,40 +136,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  msger.error("file %s not found in directory %s",
>                              boot_file, kernel_dir)
>                  exit(1)
> -        cls._create_img(part_rootfs_dir, part, cr_workdir)
> +        cls._create_img(part_rootfs_dir, part, cr_workdir,
> +                        native_sysroot, oe_builddir)
>  
>      @classmethod
> -    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
> -            # Write label as utf-16le to EFILABEL file
> +    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
> +                    native_sysroot, oe_builddir):
> +        # Write label as utf-16le to EFILABEL file
>          with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>              filedescriptor.write(part.label.upper().encode("utf-16le"))
>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> -
> -        # dosfs image, created by mkdosfs
>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>  
> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
> -        exec_cmd(dosfs_cmd)
> -
> -        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
> -        exec_cmd(mcopy_cmd, True)
> -
> -        chmod_cmd = "chmod 644 %s" % bootimg
> -        exec_cmd(chmod_cmd)
> -
> +        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
> +                                  part_rootfs_dir, native_sysroot, None)
>          du_cmd = "du -Lbks %s" % bootimg
>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>  
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index e82e990..48f7523 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                 name)
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> -
> -        # dosfs image, created by mkdosfs
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> -
> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
> -        exec_cmd(dosfs_cmd)
> -
> -        # mtools for buster have problems with resursive mcopy.
> -        # Therefore, create the target dir via mmd first.
> -        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
> -        exec_cmd(mmd_cmd, True)
> -        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
> -            (efi_part_image, part_rootfs_dir)
> -        exec_cmd(mcopy_cmd, True)
> -
> -        chmod_cmd = "chmod 644 %s" % efi_part_image
> -        exec_cmd(chmod_cmd)
> +        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
> +                                  part_rootfs_dir, native_sysroot, None)
>  
>          du_cmd = "du -Lbks %s" % efi_part_image
>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])

There is no change compared to v3 which I pulled out again due to a
regression. Does it mean that patch 2/2 of this series should rather be 1/2?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


