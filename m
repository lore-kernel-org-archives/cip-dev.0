Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3477C47422
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:23:34 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.73141.1705307008034912594
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:23:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zhtopnoV;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2Tmk7J8YzegH2R6vw9ukjv9glwmFMsmSRS25kWE4mtYG1EkXP8Faex7nBG1xOSrvTyhdGFWjoxA8LHRgwyeawA+O9p/hq+sFOr9Y0mxhNZVon2+TwdU6oKuNln3N0FMrRtMxljLILVv0CKfGyrKHpRlwg3tO8DRY2KDtGzNGfqZzNinMZ5SJN5fUam7WzyNYylqAdVTB0zC4QMlvc+nqVPuJx+mSaOGzm1ZgwbGi5zFbwvHfYJRgtAem7scWwTmUkHuZq29cFd44SmupX+Qikr99wdKqj7kEQWiF7RiPvEafHL5lLaSpdgQl9EPRV1iDft23ogvU6G1JoT+C3wzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywOjnOzb7eqG4pgDmKpEWAR7d+4p9SHdR0Dj9eMucF8=;
 b=Oxq/KxbH2uqz2/x2shzwsvib+8dPN5a68p0CTxyPm4RpWaXzRZKmyHbbysVWQ5Wqk3ZzV35JQMtdRJBM8LrD/FwU8VrOR3Ebkn4oLINQPLVhvdEPE65PB2s5X++U/hJ9IZCATeeF0i7SJH2W0GZlepqF+pOwtl3ECqThk+ziyu7Q47CU+mXD/pGwRROJXsr6NuQ4d6NCkKjRVQzpG18cOhBn4yPZ+OQEzBKJWMpw+Xl7smbodGm+EeKl2t/UPqZJjj35Wt89fWva5BQT5Yiah155pJGEOuOsx7z+V/DnpXbmeB/IsK1kfZDqPBHCpNj87uQ765owKiLvGtCS7p+5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywOjnOzb7eqG4pgDmKpEWAR7d+4p9SHdR0Dj9eMucF8=;
 b=zhtopnoVPho1oVV88VI/BVkPsTL2/2yrM+iAlKvjdElbvweCreh/faiIxM83ZYUkRqUN9GwAsPvQ+y0T3iyjqdvI43afQ7BS2b2nv/DEF43IDXQ8c+NQszdBW743S69OYQyAAOhqMEgbcjUTtbaGXwQB6xeGM9B+BUVwERrsDVWwCyMFZVGZzWBEMKLGETR7lUCEAET8FGBS4AQBPduz0cHGet8WTymneMef9BPi+nkdNe25IaulrqFKMEVNkvTBmXyTUiIhrx1mpLRFDFTuqYKl2Gx4rpiXpAtVX1Sr4L3sxsqJjdt9ZzSi6S0/EERkDS7ZkMhUHJs2OIt+YiaNSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 08:23:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:23:26 +0000
Message-ID: <1ebec834-3b81-4a96-ae8b-ed835c37d6d5@siemens.com>
Date: Mon, 15 Jan 2024 09:23:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Content-Language: en-US
To: "Cetin, Gokhan (ADV D EU TR C&E)" <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <PRAPR10MB542285F67BAE6BF88C132356806F2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PRAPR10MB542285F67BAE6BF88C132356806F2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3502:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7c3ac2-7092-43fb-e229-08dc15a33f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3QJMFNXBZ4BIF+xMy27R2vv+Diy8ghso7X3NwIgVE9TV+5+6B3pZpJftmpnoOkpF6D+LGmHNDdyfDSPLn2U6HzkYptyPLxK8A7o5IAYTgogBAA8syfQ2oiDdJ7rJeBrOjlsjI7ZHJyitZZ6J5QkEiSpJ1CkVWmqo9zqaYHXRTudDcxHziaRm2ZrqqJMe57veLq7nHFrk7WrB0xxGut6aga4mQQqKQtZt3KTvD+pZA0AU1xlhatP5OaD3oTza0E4OxgEsWGEST0SnE533MSOC1CcyGKmB9zJ33N5hK7QyLaIojHaF3kdzYoXnK18QB8GwkvTjxy1LGnH6GVc6PjgjO0qLtMjSX5xRETH/x8x4ZQ0WLgngwQ4Na+qzUQNfGmi/uqXb9g02H2Y4uDsGixkjLqYlcyuokPlZM2mi/KxMnt03Hu5sm7OSVQQXJqVotc41kbUKfxVNxKuXzXHC0PEBA8/YFn3IiAQ+kTEMonIjMop0Zl2W1UqvUAlScyQYiOeyL1VN2Vt0FpkWsgapBG8kS0wV8JWTiemEjaZlFd18CsziiIdL/48g9NoqiGkHG1krMFKCRYH1cT4FVvkoFEf1JxywpqYAO3ItGGFybJOKTpFr2njlzXvG8FcLlL+8GsObkgcu1Vtwyzlu2IDVsDombQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(26005)(53546011)(6512007)(478600001)(38100700002)(36756003)(31696002)(82960400001)(86362001)(4326008)(5660300002)(2906002)(41300700001)(107886003)(6506007)(83380400001)(66556008)(66946007)(316002)(66476007)(110136005)(44832011)(6486002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlNwbDhMOU9KVEtKVStDMmhmVm84L3NBYkRkcGllYTNCV3piMFVRZk1yTG5w?=
 =?utf-8?B?Zml3Z2dFN1JIck1mSHRvQncwWEFmblgzM1BWZTUxKzBoRGFhNkpxYTZMY3JJ?=
 =?utf-8?B?YlFRdFBGN0FOM3I3MGlYNXVkTVBLL0JsMnplbG8yNE1sc0xSM2V4VjN3L1FF?=
 =?utf-8?B?YnR3MkZOK3Z5Q0psd3RhTGx4cE0rb0JvVUYyZlBja3JKVmZtUkZ0SnM2NEpR?=
 =?utf-8?B?L1Q0TmxLbmpSTVQ1bm55UWVvZDJ0L0dLc0ZYdUhWaExQUjFBVVQxbjVVYmND?=
 =?utf-8?B?Q1RaS3hMLzZpWU1ENTN1SDVvcFI0ZGNKMDdDRFFIeWlwVmdtK1hpTVhLY1lv?=
 =?utf-8?B?MmJ6NFhIYVljZGloSzRBdUoxS3RIckxoWXFxcG0rNWVWSmlSdXo1UUYzckpP?=
 =?utf-8?B?bkJ3MVFBQmZQTnFaSTJXUHFjT2lGbGpBZDFkdGNEQ2MxRllSN3p6UERjbFdx?=
 =?utf-8?B?aU5wdWoxQ0JBWUxrMkRReWp0eXZYNUdjS2VmeGdJMElPQVF5SkswUnhlTjVJ?=
 =?utf-8?B?SkdXUkdrekdvdkN3cUdnTXdFUlVKbXFCTUlDaEtXOVFJdTNua3BXTjZXSG82?=
 =?utf-8?B?OEkwdSs1UnZaQUQ1SUt3cmpMb1laNlM1WFk3bXlXUklhenFhNGlIRjJQdmRI?=
 =?utf-8?B?VWV3RUM5MnJ5ZG1iQjRvS1NsSG8zR2RIdmE0VlFTQ0c3a3BkMjR6VHpvN2Zt?=
 =?utf-8?B?QkN4SU1ZZDRGZ2drSU5JSjBCUEYvdFNoaU96b1hCOVN1MUxRUk90RjcyMlJm?=
 =?utf-8?B?LytwajN6dW5xQWdUYXlCaGQ4cG1hS1k1NkZ4NHFDeFU5VmdCc1ZPSWFSeEpN?=
 =?utf-8?B?Z2doSXh1QmhBbksrbkNzc2R6eWxxanVwUEgrbG92elRXMmJndzdvUHpiSDlV?=
 =?utf-8?B?NW5VTGVpODNCRjV0QkQySmtxRE9WdmFUeGlrVjNEelI4YXhvd1JsR2RXSVJV?=
 =?utf-8?B?QjRrYXFuUms2SlE3SFVaVkdPajVWMEtRbWxOUUo2TGdMcEYxK3dETll0OTl4?=
 =?utf-8?B?YUhkblc1K3NLdmhYOVpGdzVHV3VUSitwSkdxZXpZdnp1Q2NDaXJEdytab2J4?=
 =?utf-8?B?cHNRQTNScFQxNW1RazhjRk9rNzh2eml3dDhQWWZLOE5pa2pLR1ZRc1FqeVZ2?=
 =?utf-8?B?a3NJR0N4am9sa0kyd29KY3hmcXJ4UTROdkFFMGhqazc3OGh3N3pOeWZYWC8r?=
 =?utf-8?B?OGhyelRINnk4cUVSNWdseUVWV2svSU5mQ1ZhM2EwSWNFSlFCSjQrOW83WlBp?=
 =?utf-8?B?UFFXRkZjRHRmMnFpSG5zRk9HbEo2TFoyY2o0UHFsKzVnS1NkRjBnb0JsMHdN?=
 =?utf-8?B?cG9UQ2lHeWZGbWd2eFAzaS9FUVh3cEZjRmxaSEpvYzJqU2xTU3c4cFZNcWR5?=
 =?utf-8?B?dmZCUmJSUm5WRk96TFBSaU92ZnJtQ0FZUDUxaTZtcmVqVFpUUWtLOWRJcVpi?=
 =?utf-8?B?M2VwcnBuSjdiZk96ZkRLTjZQb1NxK2NKR01ObFk5RVpreWY2SEo0TnFwZ2xz?=
 =?utf-8?B?YVRKNkJHdVV5Wnd6Umd0TkhNUDEzZGFPL0IxQUhQY3BpNnhHWnl6emFiY1RV?=
 =?utf-8?B?L05OYmxLYzJ1Y3VlVDdmeVV6dE5aM0kzQWwzUW1MRFlXV2NIbkVndnBVSklJ?=
 =?utf-8?B?WXUwc25WelpYb2pYclZVbkpERm9HVE0vY0lKcE9KZTloUVgrN08rTWV6S3Vs?=
 =?utf-8?B?dTF5eDR0MDdyZzA2c2VVcm9WK3BvV1lCT1FhNzNDeUt3c2hBaUNGK3dHQ3Zy?=
 =?utf-8?B?ZjhMTS9xV0FvMUdDRFlFcnRmakp2SjZXM0xhL05WbXIxV0JySGRoN045by9X?=
 =?utf-8?B?K083WGwyNXVvb2JmYkhzbU1iRnRmaVJJR25LUERKWHFwUFpCUkppc29LR1Y3?=
 =?utf-8?B?RnBMaytKQTdvWHd0NitSSEJWVVhjc1dYTVBlcFlvaERhcVlsMmJXOWl3WnZJ?=
 =?utf-8?B?WVRSL2RBM2ZnTGR3UmVieFppN0dmbjQvdEFrTkU3aVJsR0tlOVovS3BDSzBW?=
 =?utf-8?B?emhEMzI5cHdKUHNxSUF3TWxmWWs3OGRFY01aSzZTSzFHN0dIa3A1SGRySzBk?=
 =?utf-8?B?SkVwYkNMaXpLbzlpcTdFQzNkNk9kOHZsMG00dXQxeFNvK01DUDAvUExHaG1D?=
 =?utf-8?Q?Ny1KuyKIfTy48EJBsEKMk7+8v?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c3ac2-7092-43fb-e229-08dc15a33f22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:23:26.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MT3Wfp9EdW7vYtX9N61OLm/QgQuDjXiK8gdm1DfagnAxjYBpBo4JGTLJJ6dMUOfz+pRZ89Gyn7Huh6RrUDnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3502
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14380

On 12.01.24 08:03, Cetin, Gokhan (ADV D EU TR C&E) wrote:
> 
> This adds necessary crypt modules and loop device in case they are
> not loaded at early boot as default.
> 
> aesni-intel is dropped as it's not needed directly but its dependency
> aes_generic is the required module.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.hook                    | 7 +++++--
>  .../files/encrypt_partition.clevis.script                  | 7 +++++++
>  .../files/encrypt_partition.systemd.hook                   | 7 +++++--
>  .../files/encrypt_partition.systemd.script                 | 7 +++++++
>  4 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 37b373c..d08594c 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -34,8 +34,11 @@ manual_add_modules tpm_crb
>  manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
> -# add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel
> +# add required crypto modules in case
> +# the kernel does not have them as default
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>  
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 6d8f209..0318966 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -36,6 +36,13 @@ esac
>  modprobe tpm_tis
>  modprobe tpm_crb
>  
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly for re-encryption
> +modprobe loop
> +
>  # fixed tpm device or do we need to find it
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 0a39da6..c3b31d6 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -31,8 +31,11 @@ manual_add_modules tpm_crb
>  manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
> -# add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel
> +# add required crypto modules in case
> +# the kernel does not have them as default
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>  
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 2ac8d30..eeeb55a 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -36,6 +36,13 @@ esac
>  modprobe tpm_tis
>  modprobe tpm_crb
>  
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly for re-encryption
> +modprobe loop
> +
>  # fixed tpm device or do we need to find it
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"

Thanks, applied.

BTW, I would assume that dropping the Intel optimized AES algorithm
comes with a certain performance price, but let's leave optimizations to
those who actually need them.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


