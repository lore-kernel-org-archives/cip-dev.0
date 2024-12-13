Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C61E7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 12:39:32 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.14144.1734093569544845411
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Dec 2024 04:39:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AknPRCzc;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I41eDk6F8ellxyBB2hcuTN3eo2umf246KBeBNoI4mHMOZfN2L9Ntw/zy2Uq29akjxPLKYXWiLYNc7s6zTGyJQeakQUSkE1+jd9IRS8tgDCLpLiqXnbBqHknF/OKDb90RzZ1I2IT4ZYKOjGyTYs+pDSgen6X2iv0x4Q/y+fY2Q7TFW+Sm6V6qUGF86nufoGfh4crd65HzyW39+sRn0R+INtzRFCiwM9IAJWiG1rbvJ86U7TOuYMs3U/KrFJtVoYDmfxXls+WDpjbiYlZ0EYS3rDl8i3vyZcoXzgZklK2lfHtQeyHzxTaM9t39AtirgXqnfjMGvOsosB4pgF9cUmoq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiKwbI9V8jERlaXR6nhrTrytWXgo/Cuv8e2QpzMVkE8=;
 b=yui/QLlqSIw7S9yaE+H61SYNYi0ozwrTBprF/fhFu7PGHtjvqpBvoy1EONTffbqveIcp/DtFQjdZIrKtLodEGdI8R+lTmJus4n2UeZwleBa2Z8a66m08NoJN7toJ8ypcgzhKA3pmqgFLxIVFRluD8ER7MXqu0Wc7PXnUhL8+zldEmYQ23ZmATekxxVckNJX0A0Z3uCXvx8+PHqWoblHJdVlrZj7UvMZSZ95UAq2R+oBOPWupcAqPVdOzCXEioLE8WL0zrLQDC6wVHhwsBdG435qYZ9Zce+Jrk+J23F8yqJUYxSn6jzHYfadSlt0RRqcrewGe3vaYTXzsK+1ZFddv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiKwbI9V8jERlaXR6nhrTrytWXgo/Cuv8e2QpzMVkE8=;
 b=AknPRCzc2wSOs5lzgHCqpsqp/nkj+BRP8xlXng2f57NzcsSpuGzFqCtQE9TVkGVQOWf94DDxyqOnE8+y3ICyp4G2VR2tNEw0gz+y0bF1At2s/IwdZavDMmMkFu4IPQVcN/qxfPOCeLy8Q3E3xKLZdZKdJn0mFWOZIVdFCKVCTxnFRilXSuMOa2w2yQSIayqGBB3TQhxcI2RRlAnUyziOCTzsHwLgWz7dvZKZ8aghCfJYz2f0JcLcPitQzqm4U8BevpVz5SflIOnDchQUSSaKpG2AOOYLcQy1jK5N47YgDmGrmKwMEXQz1bTiVMfzGlGnakVULn7z9p1joS7nNbA9YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6454.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.5; Fri, 13 Dec
 2024 12:39:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.000; Fri, 13 Dec 2024
 12:39:25 +0000
Message-ID: <f832a682-e022-4c8e-8ad2-1cd32b1f5a33@siemens.com>
Date: Fri, 13 Dec 2024 13:39:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.6
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 279fc8cc-0257-4c9a-15e4-08dd1b732d7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDVsRVFXTkd2VzZ0MnBCR2UyRHBNeHBiQkNPelpWek5zZElCRmU5UnVENXI4?=
 =?utf-8?B?UW8xUkRkV3FPRzZDN2pMZVNkVjZWUlBBNzFZaXYwQ3lRN1Z5b2RyKzVpdG1a?=
 =?utf-8?B?YlVjWmIrRUdQRlhhUmV2ZnRhZlBkYVIxTXRyRjZqTUIxc1NObEZCUjBGWFhi?=
 =?utf-8?B?ejFWUlFBY0NUUjlrQ1lPM1djNVQ1SkIxRTV4cW40eGgwSFpydThLWDZDTUE0?=
 =?utf-8?B?UnB2U0p0WDVHM1F6N1NjTlFnbFR5SnRzS0QyQ203QWJuV2VNU2NlQmtJWFh3?=
 =?utf-8?B?OGIvcGNiRytPc2gwRW1nQjlybDIveTRvS1lwRVhsS2M2M1VaeFdlb09XVWxq?=
 =?utf-8?B?VllMVTl1MGN4RUVSb09YRG5nNmVrSU9IZzNJdUZNOVYrYmtBZitCZldaejJB?=
 =?utf-8?B?aWQ2LzhlRytETGloSy9MVDNmbXZIRWprUkVxNThlMXd6bE8wMVlvSmNqVm0y?=
 =?utf-8?B?alhBY0dkN2gvUTZQTnh2Q2ppUU5PWEFUUW1Ed3BZZkpUdEwreis0VHVLNHo2?=
 =?utf-8?B?czlHa2N6MkZZRlhVL29RNW4yczlCa1I0YzRVMXBEZkI4bFNsRmEwYmh2aVEx?=
 =?utf-8?B?K3pkVzVVdWNVUDE4bGE1RmFhb0ZKSWN6a2tjOXQ4c21kcmRQSmdHNFZib3ZJ?=
 =?utf-8?B?L0EyS2ZHeXc2d016cXVRTnlFbTRKNHh4MGQ2b2duNGlWYTJGQk9kSDRFK2lO?=
 =?utf-8?B?ZDZWdXV1ZU9USUlyalA1QWFvSmlWRWtEWmFlZUN2cGdDRjcwd1o4NTFUcE5O?=
 =?utf-8?B?R2swYTB0TDNMSTd3NFdGTGdudHhhdkl2aGRKNjJkdUc5QnlGVTUzN2tGU1pF?=
 =?utf-8?B?eHV1RndsNXgyY1RsRmIzRmJsTWlKRXRpelk4WFpXU3pZM1BkOWdlYkZOaGg4?=
 =?utf-8?B?N0RONkVpYUNqamJ2ZDlVQW02TzBkaExqRHFtV0VBRlpJOVhzSDA1RzhINXcw?=
 =?utf-8?B?UFA0WDVVenJoOW9vNVVLKytNTkxRWHQrU1dJV3VYUWYzNUpUcGF0T2Zic3Zv?=
 =?utf-8?B?OU9RWXBxdG5kK1lXNnJxUmFHcm41WERHdXZaRGpoejlHUks3SFpXcGJMOEs4?=
 =?utf-8?B?OFF3SmROMzR6cFRLekFiWnd1RE9UZ2NicllFV3JmRkZVdDZSOSs2UVVMRHpH?=
 =?utf-8?B?QVhEaDVna3V6cldueE1IWDN1RXB6NCtQeDY2eEcwWlJ0dVNhckRIVVE5VDc4?=
 =?utf-8?B?aEUxZHZpdVlFNmFPN0tPbDcrSGVTbXl4WTJFbVByaGFRdzYzRjJhbElKQ1hs?=
 =?utf-8?B?dzdFMGF4eEkzMjNIRS9PTVJlVzY0d3dzTE5NNm9ZYkdtRXdrZld5S0xRNUhZ?=
 =?utf-8?B?dno5a2tXWXlJUVEwQUdaN0ZFbXJDWnk1UFF1TDB5QWRiZ2xWVWxaK0hlQWh5?=
 =?utf-8?B?V0FSUFg0cDFuYXExeVhSS29tc0tjc2ZuWkpwNHlOUzhwR1FaMGxwNzRDaHQx?=
 =?utf-8?B?OUd2L1JiOWlqMklOcmoyeGNUTnI3dW1UQ0JOcmxDL0oreUpKVkE2aDF3Q0cx?=
 =?utf-8?B?V2xFbWVDSm5tYzNPSHhkTHJndGxlUnRsMjJOZzVwTjZpdHNvOVUwbkpoVklK?=
 =?utf-8?B?U0pnYnhIQldWcWNWTFpETkFsUWRheml5cW1rTUcwU0dqV1RQNWE4bk1SQk9j?=
 =?utf-8?B?VDA1OGRnbEhXZVc4UEgrZFViL1ZqUFNCZ2tzUzFiRkZvTnp6RHdSZFBEZDQ0?=
 =?utf-8?B?ZWZBblhRMDl0U2I2YzJDTU1lamlpUTZSdldDVDRBNzBpSkhFbVBCSWw0dTFT?=
 =?utf-8?B?ME1pV3RzZ3locUdLSW9RODdkOUlBcFRiM2l0VG81ZTNJU21pT0NTSXoraGky?=
 =?utf-8?Q?BWFKJSRDcLZVmx28+ZG3OYGlWNStVcO/6ed4A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDkrNzFOV3JYSk9pSGRPR0lrUmo5dTFzbS80Sm5PMmdIWHJMNitWYVhPSUlF?=
 =?utf-8?B?MWRKSHVjOXMzK3FhNUhVUVFVV3RBaUE1M3ZIa2g2Sm5lVTF5L3U3em5Ic0NS?=
 =?utf-8?B?UHZKWncveUUzaEZaNVRhb2ZvbnB6Uy9mVTNudGlQVGhEYnMrNFpQN29KbUVE?=
 =?utf-8?B?eVBZQXczb3NZS3FYcC9BZnQvRnRCN0ZRdzRTL3k1bE8vc24vRmFBZ2huZWlM?=
 =?utf-8?B?aVRjRmU1S2tHQzJSakhsYVBsa1Z6ZUFoSzFYYUV2WmlVeXA0MVVJK0pXaDVh?=
 =?utf-8?B?NVErK1MzMWhDZzVNUlJsRnRRd0R3cnk0WXMzckFzbjlyTUhRQ1Z4Y2VIem5C?=
 =?utf-8?B?NTUyYTBHUDNxcXF4MzUxQ2krT0MrVnRSK0RaV2FENzhMUXhkL2FKc0p2dlF2?=
 =?utf-8?B?eXZ5TWRtV2cxOWFXMElnWnZwQzQvQ1hHN0cwaU5NSHM0K2J6NVAxQjRodjBz?=
 =?utf-8?B?cTJMcnk2OUhPUlNjN2lmam5iekw2Njc1ZEFkZnVVQWxCUG83NW12Z2pscjgy?=
 =?utf-8?B?WHc5bDViMmZBRjk5UHZPeEpLeTZTVnhoMkdBN2czSHZRdmFyYTVhbS9WZHBU?=
 =?utf-8?B?NndERURwY0xGbHdVaDhpMDM2YWhrRkwwak9CYThRYUQ4VXZIclNuaDl4ZEth?=
 =?utf-8?B?U09hemN1VHV4UkNJc2M2QWVLZktRVHdiaTloVjZ5K29rSllXTVRvclNLUVlX?=
 =?utf-8?B?VVV4TFNaSTBsRU12Yllja1ZDS0pGMzV5K2RtOGkxeXJ3OGJuUFFaajhWajNU?=
 =?utf-8?B?azhKWHZrN29XdGxzUGxVMWpFRS9SQXYxUm85VjBwZEd4Z2xWdjV1NHA2OEll?=
 =?utf-8?B?a3ZERzRvQzRqM3NKVVpRbllBWldCL202a3UrKzlWZmJzK21FcFc4N2VKWndt?=
 =?utf-8?B?bVo5cEtwN2xSN24rWHVFMXU3V0pwR1BFTnhSZlBRMkVhSmRENHFwb3FvcnRK?=
 =?utf-8?B?RVRqdVRjZW11amxaT2ZoRk5TWjQ4ZEk4OFZTMCtOOUpqbzRHNWxmUDB0Zm9U?=
 =?utf-8?B?MDNLVGFWYXhkMUJjd1JybzM5RU1PK1lZOS9QYVQ2MXczcXBNOWZUdnJWQjRG?=
 =?utf-8?B?cWF0T3kwNzYrTjZsNEVuVHhsd1RDNmtpQklXd0lPMzhPTDN0NTJyaWFQM3J0?=
 =?utf-8?B?K2Y3cXVNTUZ0ZCt5bXZGOWhRY3VaQmlERmlLVk5lT1lzd01GR1ZibFFnWkVl?=
 =?utf-8?B?WUQvNkpWbVRCRzBQU3hNNU9wN2lzVmVIQ1BDcVo4YzQzd1VoWWJQVDZSa0V1?=
 =?utf-8?B?dFYyZmg4ZSthYmkvQmZIdDNYQ0x0Y0pnS3dJNnM5NTBDKzZUVWFNcm10dzBJ?=
 =?utf-8?B?ZUdFc1AwZldWWStYK2pGbktqdi9wck1BWGVTQlhLcjhkR2dvMFZFakZHTENG?=
 =?utf-8?B?Y2thdVA1c1FtSVMxaFZYS3ZEbHp1WVFjQnhyeCtzZFRkTHh3UmdIbHJ0THVS?=
 =?utf-8?B?dVJiM09DYmdHU2FVSms2WWRZT3lpY2tSdGIrYmhjK1o3SjZxS09penZVWHJj?=
 =?utf-8?B?bGFTb1FaekZQVE1Wd3pKS1RQZXk2M3M1RXpkTktjNDh4aGFBbGMyL1pVZHlp?=
 =?utf-8?B?RXdmREF4b3lTYm1KaUZNSWdaZExhZ0JTc2NHUVcrSU1sMVVlcHZFRmVNcGZG?=
 =?utf-8?B?Qmo2L0dDSzhxeit6NmlOSGVua0VhbUtseUczNlRMd24vbm5IWkZvWFlRRjFq?=
 =?utf-8?B?VlcwVUcvMzJ4cm41dHNBK0RCbW1Zc1l4TjFPQmZGMjN3enhTTnkxVG9uZWdj?=
 =?utf-8?B?bzQrVXg2c1YyaXRLN1BjeDVTMDhoTDNrWUk1U25wK0JyWGxpUm9nYm1ha1E5?=
 =?utf-8?B?MVBjaWJDSU5FMkNkY1U5Y0JJcXNFT0dWOEhKR0hiVktiMjhoTHhOVFhSYVR2?=
 =?utf-8?B?OCswSnlRNTA0NWE0SEJtQ1A1VDhUcG8zWWppY0Z2M1ZZMStnMEFDQ0VsS0dz?=
 =?utf-8?B?YmJ2NnhHT0taTHp6bEVsQmQ4Y3VabjMzV0VZc3FXRm9UY2ZQbVNMWDJRQ2FZ?=
 =?utf-8?B?UHhmRE5qc0pwMDZJSGY2ekpxeCtMT2cvMjNmZXVoSEN2QWxvYWdPL0s5K0sx?=
 =?utf-8?B?NFVDM3QvbTk2bGVzYTdoWTFOQ1RlZzV2bUlPYSt1YzdKQWtGTVFFU2NaR3pq?=
 =?utf-8?Q?sswL+ORauMVtnjZOf9YIzl2D2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279fc8cc-0257-4c9a-15e4-08dd1b732d7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:39:25.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx4pvSnhr7KJRnlrEzd170se7BTzYTjxdUtvi7zwIqhyJVMjnF0QiBUicCBCN6zsRQ4RUM9E68+JT3CAp+792Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6454
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Dec 2024 12:39:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17419

A new release of isar-cip-core is available.

46 changeset, 4 contributors, 78 files changed, 579 insertions(+), 614 
deletions(-), these are the stats for v1.6. A bit less people involved 
compared to v1.5, but more code changed this time.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.6?ref_type=tags

Highlights are support for expanding partitions before encrypting them, 
EROFS support for immutable rootfs, early support for upcoming trixie, 
and many version updates, including EFI Boot Guard 0.18.

Thanks a lot to all the contributors!

Jan


Felix Moessbauer (4):
      fix expansion of erofs exclude dirs
      erofs: ensure only dir prefixes are excluded
      define RO_ROOTFS_TYPE before using
      squashfs: ensure path glob is not expanded by calling shell

Jan Kiszka (37):
      kas: Update to release 4.5
      efibootguard: Update to 0.18
      Make the read-only rootfs type configurable
      initramfs-crypt-hook: Prepare for EROFS as alternative
      Add initramfs-erofs-hook
      Introduce class for generating EROFS images
      linux-cip: Update cip-kernel-config revision
      kas: Add option for selecting read-only rootfs type
      Provide recipe to rebuild gnu-efi 3.0.18 for fixing armhf bug
      swupdate: Control self-building via boolean var
      swupdate-signer: Ensure compatibility also with latest openssl 3.3
      u-boot: Use efisebdb with trixie for generating the UEFI key database
      initramfs-crypt-hook: Make dependencies release-specific and add trixie support
      read-only-rootfs: Do not install tmp-fs with trixie anymore
      efibootguard: Use prebuilt python-shtab from trixie onward
      Add Debian trixie
      Replace sid with trixie
      swupdate: Perform checks for supported configurations
      linux-cip: Update to 4.19.323-cip114, 5.10.229-cip54, 6.1.112-cip30-rt17 and 6.1.115-cip31
      Update isar revision
      Switch buster-backports list to official snapshot.debian.org
      linux-cip: Add lzop as build dependency when using CIP kernel configs
      linux-cip: Update to 4.4.302-cip93, 5.10.229-cip54-rt23, 6.1.118-cip32
      Update isar revision
      initramfs-abrootfs-hook: Convert to hook.inc
      initramfs-crypt-hook: Convert awk statement into simple variable evaluation
      initramfs-crypt-hook: Convert to hook.inc
      initramfs-erofs/squashfs-hook: Convert to hook.inc
      initramfs-overlay-hook: Convert to hook.inc
      initramfs-verity-hook: Drop dead verity.conf-hook artifact
      initramfs-verity-hook: Convert to hook.inc
      initramfs-crypt-hook: Add support for expanding encrypted partition
      linux-cip: Update to 4.4.302-cip94
      Update isar revision
      initramfs-overlay-hook: Fix copy_exec input
      qemu-arm: Roll back to qemu_arm_defconfig
      linux-cip: Update to 4.4.302-cip94-rt52, 4.19.324-cip115[-rt39], 5.10.230-cip55, 6.1.119-cip33[-rt18]

Quirin Gylstorff (3):
      efibootguard-boot.py: Add option to build without initrd
      update cip-kernel-defconfig to lastest version
      qemu-arm/-arm64/-riscv: Switch to cip_merged_defconfig

Srinuvasan A (1):
      recipes-devtools: remove setting of DEBIAN_MULTI_ARCH as foreign for DPKG_ARCH = "all"

srinuvasan (1):
      recipes-initramfs: remove redundant initramfs-tools DEBIAN_DEPENDS

