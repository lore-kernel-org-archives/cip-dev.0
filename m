Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F45C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 17:50:53 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.106])
 by mx.groups.io with SMTP id smtpd.web10.113827.1712598647160528355
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 10:50:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n7TVTDtI;
 spf=pass (domain: siemens.com, ip: 40.107.247.106, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLTCeUEUioQ5Ty3bgnYKIBKxhBDruusHlUKlpb9UqRl6FqOKEZlpC96UBMLUpCiVQBIEoXMzA+0zt4WkjZqm5f16FD7Pi5LOlAKlw5ygLMcN6XUh6TVlWzjn340DZnwLNaNwYyx1xIISlA83YSuUQE3hCL+AXSx0SfcMHMEcuhw8GlXgcWkDp3fugETo8T9YtYMv84sifE8Rsp2zEoGdRaJS9+jtTustZFdDM9+maULidoj6a0F8fTohuAe6bDp3IJKzIooQSWiELiKWxSER3ZPN0/LI8s19Iv9kWBFlTJVQsqxpdUpe9LJDjSOMPFLLtoxmyyH1DUZRScS52DHQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKzZsGriF35wKROcM9tAa7YYH1oi/YgzHjwswU5+L8I=;
 b=P18AN8WrSPBg4hLazh2l+xmditK/raWgjkHZgZaK2/hwhyU4DTcDP3Koybs1Tq7hESS8R91ZJ0lZPmbdDVdZSp030nqXPvgxtYmDqrM+4SQmpiMlu4ihoOkH7yA/ayIh+W2P7g3QvdeW37TV2Dkwb/V0sliIVfqV11Ydgu4w2IWdyOQhTeGBffwfJoJZD/wbYrV+nelOh8Rk2lyecILfAOvoamOwgU8IjwGeEmwypMNH50+IrtoeTpHcCwPEKI1XGKYKqLW0yDVBHdgSs+Vr+lC5nkDFj3N3FY7txnv6x0W6im6VjpFjzAJPPZPjyk2ImrUOI2IXMSF8ZBOKnA1JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKzZsGriF35wKROcM9tAa7YYH1oi/YgzHjwswU5+L8I=;
 b=n7TVTDtITUMfDnruXEfj4rXOmgHk97S6HPfhSI+gaa7iIlhKZtx40y41JE1Jf3yyL2jCulrxsmoMki6u9NBBkETy4lyx9ANZMoZjLoi8QSq59BaX8UlBJxKrPqfAqroYp7SC1WWcRYnr2uqlujOvUXxAB4pu5uoQ0J+/RGNCd36HobGn/xWsh+pwVJRn+BHSls+aPE2P3jAY4w8uIKFL26kmv1i5kPvtazJOyerU45q7BustFV8QvFtIpikQrsK3FDW3390Srth7bk7KWPrljaVNPXIkEPRLgnIfCyA6mGxM91QPcH6vf+7IHzrLhd76DAkH0kADY9Yqcpi/wuCINg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 17:50:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:50:44 +0000
Message-ID: <b235ee9e-4f8b-4051-9a27-ad210f395a89@siemens.com>
Date: Mon, 8 Apr 2024 19:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 13/13] Add example to encrypt
 the rootfs
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
 <20240322100605.4129226-14-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240322100605.4129226-14-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3965:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4RyH6fOGp3NZsEwSkafn5sw/ZZ9vQM2qb2i7ZzWIo0EbHMU9+JwqDk5thp3/5fg4d9wlTQQ7TTxMInIJgaHxGk+Jx7wc9fj4rGJu/SsHx6lgVcgTEQDY03aCDLxQxTpLAUTAIuiCjLPBiSTRDzJe8l16gEWsOswU2Tj47NgqYiFjmNcEANmVfcKUB2WbGHJSeXaDGWdoF6zmxknHXn64BO8rR5WKqFk0e81QJxJtfFuewNQeIGXz/FanMrmJJmVeZY8CAiN5dvhiITjaaY8W/T709UcTb0RIA+hdBjE16Zcn4xc6prWYjaJsqDFATyjLd7sMK+67PvVnHBILG9P4e1zpfuji07E/N0+gUAHa26/hwkFE1btJz3vNlpZ0EF4cZDn3eki5GB7YSPhHxNnGizYSDoiUoPFTfM602MJGgm7o6VCq5FwyB6sjszy8FULfMEXhME8pJM48VQf3l4YS30Q3ep00hBe0tkLTvN8zxO4gxyH4ymG2+bsBS7k+nKHJDy/rnhcnYaE5a3VvoRA0kEkmjojFkAFJRfMOlGaByYm2rQ25/g8mTClAIwMmyrDTTPeuPSU5tK5oqO5zmd9KnJWcnSpFNpcBExTQ/QW6vlCB26PZq9KOBuvU+GvXepmec+nJDVROl4BmeA+dr9ikrh2FmnTZ0JDYh0op2HSXdxU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2F1ZWIxS1Vxb0dNdTMvcm9TVEdzV3FacHpqQXFGdzFEVkFORmtoWSsrU3VQ?=
 =?utf-8?B?cjhsa3UrL0Z1MnplVjBpaEdPekJNMkxPQTU5enJRMWJGUTZpZCtyWWRaS255?=
 =?utf-8?B?Rnh1SDVYQVUySmZhQkd0WkpzR1htUlQzMHloby9iZTkrS0EyWkt1L1NFY0Y1?=
 =?utf-8?B?M3NaeFlibS9sSm1zUjFXclJudXYwSGlTN0x1OGx1cm1weWl6cEtIc1E3MWFj?=
 =?utf-8?B?UlpRQ1JkV2FIa0VuSGhTQTlidk5UdlJrWkZkZG5JQ2lnSmtENlFBeFNQeXlI?=
 =?utf-8?B?K0Rwai83RS9FK2VMYUxiSVhBUElmUmJ5ZXp4M2s4ak1BeGFRajdRc0g3cVcv?=
 =?utf-8?B?b1RNaDBFRnJKclJrdW02L1ZjdEsxL0c5UkNaSktZL3UrK1Q1dStHYzN0L0Ir?=
 =?utf-8?B?NmZoQUVYMTFJSFJMSzdWOWlKQjRJVklNdlBqY2tqZTYwbjJ3QlYxQ3FHRXRY?=
 =?utf-8?B?MXFFcWVLeUFQOXVRekIrcXhkTU0wdnlZTUNoTVppYUVaeWgzVG05S1FLTGFW?=
 =?utf-8?B?QlFPeDJlZUdXSzdmME43ODUxdTRkak5McFdNbUZEVVVtVFhaUThreXRlTVN4?=
 =?utf-8?B?bnF3RzZZMlQwNVF4T01DUWxWWHdNeWFJRlZyeURabG5EU05mQzdXc1Z1TWx2?=
 =?utf-8?B?Z3U0dXQwaitHb1F0N09mRUdYVWpPSmp6MCtERkgyN3ZBVW1qOGdsQTN6VWxv?=
 =?utf-8?B?NnpEWmw3VnNCQnhPK3B5aUFHOG80aWNqTnViczlLS2t3anV5NkxSRzNiaFNn?=
 =?utf-8?B?OW44VitWdk50a2RnWE9YTnViM2xaOVFlbVllK2xwVHZLdG1XZFQ1bDNUSW1N?=
 =?utf-8?B?Vk9vOGU0bVVWVkQrdVA2bVZPdjR2UWsvc05oZUdiOVlQelRRSDliRHlYNG5E?=
 =?utf-8?B?NWFHUzdiWHY1eDQ5RlZ4TW1GMHo4eDM2L3pDQW4ybHpQZjMvdjhsSzFqQWtY?=
 =?utf-8?B?NUZQVXJPSFl5aGNzRGE0T1FHRmorbkdHV1UzYkd3NGdFNHczWjh5Q25wb0Z2?=
 =?utf-8?B?U0xBOWM5VUwxM1dOMVdma2N1cmk1Mno3S3JQbEpEbnRSR0pVdFB4azkxQVU5?=
 =?utf-8?B?eWdMdEEvVTVjNnBORGJ5VVMxakZEM2NJY2tJdWZja0dGRDczcjBtb3E2MmR0?=
 =?utf-8?B?d0VJazU2cmtSWVV0MUZVVXIyVU1KUWJ5c09tTW5yR1hUKzV5akM1dWt3WEF4?=
 =?utf-8?B?YTlGbEYvN3kzb25yWE54ZW9wdUN0S0l1NkNSKzVmd29Bd01BTWRuckpucnpH?=
 =?utf-8?B?eHlmMGU1QUVrcDBIVE1jM2VsQUg3RVEvRzA2Mll2ZFovQXpYUzlWYTh1ek9E?=
 =?utf-8?B?NUlrUVlBZnBKbXI0VWNpOUlOemJTbWtZaVBnMGU1Z2JMRThsRXRIRCs3UUU2?=
 =?utf-8?B?TWFralpwNjhkaGxtc1Z1b3V0L1Mza2ZtcnZkQUhDY2hLdEQrUk9qODQ5MlZS?=
 =?utf-8?B?SWNiekVYdzVibW52K1J2dGNIa0NMdFZFaDRZTkk3UE5uWHdmc1pSSjBpNDhH?=
 =?utf-8?B?WGxjRU1KUW9MMUZKYUJMMWFDNVgvV1ZhYkxqWlVXbnp5NEdDOGpDVnRNRmZ1?=
 =?utf-8?B?Y3ZJa2pyOGVNYmF0eHFhQ1VsbEdSUFA1d2UrSUttWmJQVjNaa0ZNQkRRWUZp?=
 =?utf-8?B?cHJkcHdDM2JlWTFHaktkN1dtUVlCOFA3NzRLR3M2ZGV1WFNScGlpTlRvRkly?=
 =?utf-8?B?MXFtRGF3WWU5cmxsVU9wd2RUUDlWalltMUt2NWtwSkFxQVhYbHFYMXpJMXEr?=
 =?utf-8?B?MVdnRWk0WUpJTmlRTVRoOHRYYW9TYW5DakUwejNod3ViNVBLOTdzczF0aWFW?=
 =?utf-8?B?UFp0ZHpyY0MwelBYckRabzZvdlJYdFhWL3dScVdqRC9GSEo1MTBsNGpaRlpV?=
 =?utf-8?B?eFRrSHRlbFdCWkpKWjdNdWNoRnZFVjdIdm1ZdHpTWG1OL0p1LzhSaWFmSXJs?=
 =?utf-8?B?WU4wTmtPVUplQ3BWbEFkZ0FVdGRlVXAxTWp6N3JoR05EQytiLzVKd0h4RVFl?=
 =?utf-8?B?WENnaHkzZTAvMiszSGZURHFFQUJuQTBjVWIyME1Yamw4YUpUclFDSlhRcDRp?=
 =?utf-8?B?b3JhS294czNTRDZ5aVh3SXFhOCt0cEI1Z3hqdnlHS2tPRmdZL1NWUCsrYjkx?=
 =?utf-8?B?djNOdUFHa21WY2NMT2RhWktPaFNpaTF1UTd1VCs0RHU1L1FNaXpxWHcrR0ZL?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a471b77-ec7e-496b-b9d5-08dc57f469df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:50:44.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4+m2ddWcFvjbbKWsZ6DGL60MnEnWr9wLKjanCNVawhQ3Q7TGxivGi6uY7/l5p7x3gNfhWpcnIwDz4i82jIW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 17:50:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15508

On 22.03.24 11:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/encrypt_rootfs.yml   | 24 ++++++++++++++++++++++++
>  wic/x86_64-encryption.wks.in | 16 ++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 kas/opt/encrypt_rootfs.yml
>  create mode 100644 wic/x86_64-encryption.wks.in
> 
> diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
> new file mode 100644
> index 0000000..4001c75
> --- /dev/null
> +++ b/kas/opt/encrypt_rootfs.yml
> @@ -0,0 +1,24 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  encrypted_root: |
> +    WKS_FILE = "x86_64-encryption.wks.in"
> +    CRYPT_PARTITIONS = "platform:/:reencrypt home:/home:reencrypt var:/var:reencrypt"
> +    IMAGE_FSTYPES = "wic"
> +    IMAGER_INSTALL:wic += "systemd-boot"
> +    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
> +    INITRAMFS_RECIPE ?= "cip-core-initramfs"
> +    INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
> +    do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
> diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.in
> new file mode 100644
> index 0000000..800b56d
> --- /dev/null
> +++ b/wic/x86_64-encryption.wks.in
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,initrd=${INITRD_IMAGE}" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
> +
> +part / --source rootfs --fstype ext4  --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
> +# home and var are extra partitions
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +
> +bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"

On second glance, this one confuses me. It comes with zero documentation
or at least some Kconfig entry to make clear in which context it can be
used. I bet it collides heavily when combined with the qemu-amd64 secure
boot example.

I'm taking this out again. Please clean up and provide a documented
example with at least Kconfig integration.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


