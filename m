Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF75C19F4F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 17:31:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.87])
 by mx.groups.io with SMTP id smtpd.web11.3251.1715189483608494625
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 10:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CBeVzi5k;
 spf=pass (domain: siemens.com, ip: 40.107.20.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObhU357+KTHnQwJOwuRVepW2iIfRBUzKBMrmeT51BgHglv02UEmcxNpNc3h9sweHBcA4CXVCgJICVT9GDDYcKjt0ilKqodMyevSAHbDdEXTl/Vs/YtFet6bnpnVhII7kWug32KU0aMAtcNF71NId9rTBHKq7GBHwl/K/1sqWJYu6dXh611UP/spfkQKx9XgjzR61CHjiumdfZEeYdyAeC/OTMjIw3Tn6wfE2NERLoRpWkKjcygL1Zw8arzXCtMNv+KhIUOjC6gJ4ol7LcjLJliXCX3WFXuX+XgS9qNKrdcpYPRw4rHkI03pq937PGTmKnAK2mOi/LMNDABE8Mcsn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBWG+X9sJlKZAXLTS52lrrYC2ltyML6E9NDWqQ/Qx2g=;
 b=N6hb2LwwwqHXRBx7kakXrOoSbA0/IQ3hSDdk3pSqP/CzZMyroKitVeyBxlvxGUoM6oIlMTSPd3KhnCBQMNzyOSPvJRPJsMRCDT+6sTkX3IEMnPF1NBq1BedOKPvsB++sUHyddWWj+i/htq39TpCne+mbX0d2zKyA1n2g7BDRS0i3dxx3OV2qyauwnFzyGKK/QmCTaV5WyTjEXxJHxTYvGh/FhOQKS4PdodHDXuL8r42qpZogTjizfFlcUz/tupzTtXLZRHz0IoHGh2TkLBOzTjd/JP4+aI2udPlVhwz5un5B1h2nezw+btu/6b2PFn84TcGbkR2OvixBA89MeG71qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBWG+X9sJlKZAXLTS52lrrYC2ltyML6E9NDWqQ/Qx2g=;
 b=CBeVzi5kwySIQHbpe3mM5b0hXw8lUPwKodRt+D8uXaWYkE8P9nP/a0Vu3bKZHyvJcxgN1ZrxJYYOr+ou/VZT7UWZys1/VmcsBidCxZeWiw3qV36fH5CqpEf0f4REmIaqUSa5lk9/+oUuhqvQ4VqMQpJeTDvl4tp5yr9QXvissjgEo9xpUJU4LKcwJEvjfhWAxlqhS4Bj9b0dSGMrg8BVUMGCLnfYuSGzD5MVW30hrTQGNaPtcq/PTSJHO8Jsvy+WQbMmzOLvZZT4e404lfFOJ8eduUn/5CZPgV7IvJeTu9XclrO3gfGMQ9Zv48WqW7wAGtAyJ+/1KSWbg0oiZzuVDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:31:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:31:20 +0000
Message-ID: <7272b70c-efff-4708-8c24-7aa67732d924@siemens.com>
Date: Wed, 8 May 2024 19:31:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240508135539.2780114-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240508135539.2780114-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dc5a88-3b6d-478d-80cc-08dc6f84ac89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWRkZzlaOXZDYUpQU242dkg0a3pvRXQrci9jbDVYNFZPeEVuZ0FRK3ZBKzQr?=
 =?utf-8?B?MFdVUEZIMS9HUDBQZjM5TDFsREpyWGl3SW9DRUFkR2pKUnl4ZnpDeXJsOU1y?=
 =?utf-8?B?dEVYWC9yaXZlN3lGSUtEdVpWanZVVkNVN0JTdmQ1N1JWMWFNZG5HdUJHNTMy?=
 =?utf-8?B?UTl4MTdySGxIZG4wOTVleG5nUTFTL0VVWlZWQ2JFM3RlK0JYSUhwRzZ3ZVV1?=
 =?utf-8?B?endBalYwczFCVXJhMXQ2MWpDN0xhcmdER3dTK083L2VrdXlGZllWYXZNRWoz?=
 =?utf-8?B?M0o1RWhGalRydHRLa1dqWG91d2JTUzNQL0ZkSWNPN2RKbHFmdDlNUGcxVzZ2?=
 =?utf-8?B?UWFnMzA2M2xSeEFwaUFKWVhnc201K1ZCTHB5eklid09XMUZoS0RDSnRRVVZJ?=
 =?utf-8?B?elBrM1VIdGhsODFnV1BNd29BTlZidm4vTWN0eXpSOUxCUXdLQVFLWFIwNHhU?=
 =?utf-8?B?aXoxZ1lVNnZWenluU1hneE1HT280MjdsZlc3SDhvQVR2djBNOHhob2ZhbERO?=
 =?utf-8?B?NGMyNHgwV2M4dTdUUU9YN2FUOC8rUFJJMmRGTkNOUnRuWGpkWjBuUURDdDRo?=
 =?utf-8?B?YnVYM0NYai9zQnBEakhkYkxuQkNZdnlHcHVURjRPRGloVHJGSEcxQmg5QUxL?=
 =?utf-8?B?U1ZLakROTlY4VlAyYm05NnN6cGk3cFFGK2M2ZFNKYUtNK05UdmhvU1AxOHRL?=
 =?utf-8?B?QjBjSVpIV2RoTlRodlFGNFJlU1VPUEh6ZmV0a2g0aWxEZFJYVjNheDN4SXYw?=
 =?utf-8?B?VEZKMVphd1NkeVFMMUJGS2RHakZsYTRsNUZqTVFuYVZxS3JZb21hbnpHU3p2?=
 =?utf-8?B?VFUvOHVsbDdIYXN5U0Q1Uzd2L1VQYy8wL1hvOTNxbXlBUnRlaUE4TDNoa2Yx?=
 =?utf-8?B?NDlCVDJuWlFvVjJvNG85UlJYeDR4Tk5aQ0xKWm9CMzAvODBxc1JkMVJNWDQw?=
 =?utf-8?B?ejNtRDRpdkFwNkJhN0ExNEx0T1Q4Q3ZLMWg2Q01uN1hRajBtU1BERk1oSVJs?=
 =?utf-8?B?Zkg3b2dXTEIyT2x4SFhhN2Q2QnNwQVAwdkVPQUZvMldOOXhWeStvM0pqQUds?=
 =?utf-8?B?NEVuVS9PbjR4SE45cWp4L1FVZ3Q3S3dRdUdCZnpSQnBvQ3ZPUHhNTEFkT21p?=
 =?utf-8?B?WXBpcGR3TENHcmZadmZzc29zMkpuazRVQk00QVNBZkpJNWowRXBCcnpORU5H?=
 =?utf-8?B?elE0WU11Uno1VkNYYWxaRXhsWTh6a1JsTEY4UlBOSTFQbldaRWVmYjNjb0ox?=
 =?utf-8?B?MVh6QnpVbE93aXRJK0tqRUFNS05vMlphU3FBYzQzQkN2K1oyNHduMEF2cFoy?=
 =?utf-8?B?YzhtWWY1YyszRUd0UWE0bnltMjV6ZGRiMVdmYzUxYnFkV1FaMHV4SmkyVzFv?=
 =?utf-8?B?eVU2RWFjTG5SNVRjZEtUOFcxSjhBVlFlc2wvYWtLOTRCdXlZNndFQkwxZUpU?=
 =?utf-8?B?TERSSkJSWGNlckMvWm9yOFNLK0laeEpWZmdnZHJDV2ZSOTQvaStqdGJTcEcr?=
 =?utf-8?B?K1hoNFE1NXhGbFcxR2ZtSkpjWmU1Nnd6TVlzT3pqU1FTeEo1bDF5ZDNKODZN?=
 =?utf-8?B?anVBL0FkdkVnbGNxSHNCY1JPS3hyQ1BiazFCSTNNdThiL3RicGVFZUMzQVlK?=
 =?utf-8?B?VloyRkFHNmRhb1VjVlBNc1VHWlRVNnpNNEVoTGFSSGtJd3RKZHVtVFVQMzZC?=
 =?utf-8?B?Ym1LTlp5RHNZQ2U4eE1LSTJFRy9idU9YVFl3bEJ6RW54M3RXOWZ5U25nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGdYbHRvQk1oRFR3akRvaFlPNGxqTjltZ0g2c1NtQ1NrS29qRFhwVlZjWnF3?=
 =?utf-8?B?UFVJZklEZ3c3SEpiQWVaR1d2azNrRjZ5V01WVDBPQjV2OExHNjluUGpiN01D?=
 =?utf-8?B?Q0hCazBHMlUwOUhoSjI2OEJHWXBuS1NFQWZHbkZ1cWpUQUlreUhqbGRNVUlq?=
 =?utf-8?B?NTN3SDhQYTNpa3pzQkw2b1JvWkQ3Nm0rTkdndGQvQ0oydWVMOHBHK1lJOWxL?=
 =?utf-8?B?azhSRC8zVXNyWCtNV2M1ZjI1WlJlRVVGbjJSeFRXQWZkZTRzVXhYb2JVVkdo?=
 =?utf-8?B?eDBEdmc5UktsbzNnaGhXVzk0US92dWw0QmRSeERJbUdBMXBKRmVGempId0hu?=
 =?utf-8?B?SXluRDhtckl3UzZGaE9jU2Y4NEdHckF4OUVNUEJtaWNReTd4ZXo3REp4VG1T?=
 =?utf-8?B?VjNyNDU2UlJGYmRTcnBMckU4aEZvQlQzbEVnaGtseFpBempmYStmS1pZckh6?=
 =?utf-8?B?M3VBaHpoRFZOd29IcDZJdXN6dldZY0RvUTRkTkVKSzhZVXlHNk9GWkR3VzRD?=
 =?utf-8?B?Zy8zWU1WU2tnR1JwSzJkLzNSVktNd3hhL0dVU1VxRTRBeFFoLzVjOU9DcmVT?=
 =?utf-8?B?Ym01RUJlbStYV0pWZHozaVFBRHNCOUVGMkdIbUhMYjQzMGVpSlJNc1dSM1RY?=
 =?utf-8?B?cWxUa3BXT2FuNkVPcEJtQjFhenlzc2lyMmp3Q0JzRUJHeUZSVGJhdDlyWENF?=
 =?utf-8?B?eXIzQkdzUWpHK1pmcnBweFpFeWRUUjBjYW5odlBzODgvSk1wMStNR1V6Yllo?=
 =?utf-8?B?WUFuSmZ4NjZiOHloWHZSL0ZGTVVHSXhpOW4zR0tPMXRCOXpMR041L0c4bHRI?=
 =?utf-8?B?c0lHZmdiakFvS0tjb0xWT3I5Q0dlNGFXT1hGWmRyN3k5d1djS01SelRWYWMw?=
 =?utf-8?B?alhJMW1aVExCR0FFa0d4U0VIbjR5ZUZ5V0F6TVR3VHlVSzBQbjc2OXNHbEoz?=
 =?utf-8?B?eC8vaGRTd3lzeHYyZ3p0Q0ZIWnAxV2x1WGc4djFibmUwSnhTa3hLUExDM0ZQ?=
 =?utf-8?B?MndFL2tzK1dJb1hmeVFCZVhlSnpRRnlaNEs0d0pVdmtZRGlLblVMZnJEd1Ro?=
 =?utf-8?B?S0lja0NsLzM2OUJRMjNGK2Z3dnZDMU5kaFVHWEp1T1c5NjBiY2pHVTZYQnpR?=
 =?utf-8?B?YTdhemdtOTJKT2FYNlM4bXhDMUxINmwrV3pvT0tHdmZBQ0l6NUpxdzYrWDhq?=
 =?utf-8?B?MVdOVDVSczRObzZLSmNZZDlNeEU3b2hkdkNyYU04ZW53djJIU2d4OWpGRWJj?=
 =?utf-8?B?aXE2RnVPem5ZcGpQaERqbGsvelpQb3hhUzU1eEZXVHExdGZOUURjWUtBZTE2?=
 =?utf-8?B?Rld0T3N3bGh5aG96bDNmWkRoUVNlZndBdFE5S3BIWmljd1FXeWFPdUZVSWVJ?=
 =?utf-8?B?N1AzYzNscDd5c2dWd1VOSlhGNDRWT1VvaGlhVkdwVVZUVlhCMmlYaXNYNG14?=
 =?utf-8?B?K3VZc3Q4NlBBZTBuaG45cWV6ZEdudktVRHhvaTlTMTlsdWVvdUwvWGtQMWFY?=
 =?utf-8?B?T1ovWHNMTFdteUdyU1dTWUJxYlJPdnUyZzltQzMyYzJ1Yklkdm5lbXdEWVhT?=
 =?utf-8?B?RmZoVnV4Z2RRODNEKzJKT2JBT2toamZPcTRXakdONEJXcVFQaEtaMzhOWm9i?=
 =?utf-8?B?OEpTQk9lSlpGaWJxOUZDTTgxQU1mYmRtTk8ra1dMUXk0T0w2cU5lSDN6azU1?=
 =?utf-8?B?MzZkVDBXQ2Mva0hNcFU0WURDNTNIaUNlWFRXMnkvUmoyQ3R3SzVWZUhJcmcr?=
 =?utf-8?B?WGNMcnpaV1k1eTZkdHF6dG9UN1NIZG5FRlNTVVI3Wm5qWmJkRCtSRDc2b0VD?=
 =?utf-8?B?dTI2V3RmSVpJNVNobm1wZEtqclBPTGZTcm9XWHFHdmdCZEFGVDlzRFlBR0dD?=
 =?utf-8?B?OFY2WkJIQXpPbDlrRmNUaXdzWnlyTzJQb0llMFBka0xqWU1wSXlFOFEySktQ?=
 =?utf-8?B?S2ZrV2FiUndHY3NOOEJkZ0pDM2FjbXpMZy9JenBoUjlZemRiRjQrcUdpcWZp?=
 =?utf-8?B?bno2R2E1SHRlZ1ZaenZFaFhDVTUxTTQyNlJSa2c0cnNzMjZvczMvdlpDbUI2?=
 =?utf-8?B?bytGNFpvUXc0RWxxUlhnY2hCbE5IdU9pcFllUy9EcC92OWt4YnRIaFNNK0w5?=
 =?utf-8?B?QjQrcU5pSXIwMkpVVmk2SHY2L3ZaS21kRzY5VlhsR2dOeTVvUld5cFhDWDh1?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc5a88-3b6d-478d-80cc-08dc6f84ac89
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:31:20.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pokW3l5QM/h48F6YuMHDgBSDTPmJNWWQMHSwkGbnkp8WHeWpdJnBMDRk0lE2it3YCwa072IOWKhY4oc0FQjPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3949
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 17:31:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15865

On 08.05.24 15:55, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the issue that wic arguments --size and --fixed-size
> are not correctly interpreted.
> 
> This fixes issue #104.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v3:
>  - remove unnecesary setting of FAT-Size(-F) and sector size(-S 512)
>    the sector size default is 512 and as FAT size should be caluclate
>    according to the partition size.
> Changes v2:
>  - replace size calculation with part.prepare_rootfs_msdos
> 
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

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


