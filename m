Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F64C83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 05:08:33 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.50])
 by mx.groups.io with SMTP id smtpd.web10.15498.1751519308126714774
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 22:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SE5xuKM+;
 spf=pass (domain: siemens.com, ip: 52.101.84.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEL5K/AsPiujqgVrKIgJvEyOUwIvZpka/kVMvq/enEm/GP7RqXgF6ovG6b541QNHSDWD1PZDZUyMSqABwFW/Miw2G3ZOcnRYv4XckGPpxKWWqSKl1LLKoQMRvk+LvnjZgjR0aFqsDWwJp1uShwiOXbhWn/EEmTuwjMOp9FuN7tjEtpBxWGgV2dINu5sQz9DKsbakF+p89DRwV6j5dweldF3dkFlTEbQmUGBYf5xRXDUvH54O2LP/C4b1ZQxkjZ5szhp1FcUKczmLDimV8Ip4Y/kaOALrXy6NaHukZjrpOPh9jris+DZoao570c1EV8eIHLYPgmJybKxjihA5yvb59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKU9aFTsVzodUu2c6dbBCUBmGcotuboDRokmyC/XFAE=;
 b=RvJyOACtjv2WAXul+tpOoOt2wB8+6RN17aYuam+CvrDPd1Zog9Gu+VZm58Yqg/Hhnpi5UBoMaMfiFSG0DNhbZ+pqcSZgzCMfTnPxi3y+5utdAor3kFX65vMfNa4oez7Tshq9bcZ0SnMlUsTz/RQ+CDriUk5+UCiD0CxBgofzRV0YNcyxEdQlWJr1DZl/bFmhlkVErquQWr1sy9fIzFaj/HFlNIt0LHLujydPtZWDPKeo2kHoH6H00zx4HCFZ86YCzMU1o/toBcTWdwq94R2nYFG/gFk69a1PUmH3C9xkpukUUqEkZtlQ/m1vTSeJ+mNsmBBMJnxiUFbHtdL7XX60mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKU9aFTsVzodUu2c6dbBCUBmGcotuboDRokmyC/XFAE=;
 b=SE5xuKM+SMRqTumnzGZX/WCrS/f5me0JzLKcYLqMtM5yLiZAUw4scCesUFMYZ+dhLF9c7IQgy+SuvLwxnqYQK+Fp6YjMwpGIqFen8Aj/N1IIcVqJ630LECuDHCoynoOeKCZ7LZN/FaASI7ON7OYqBCLqw4QTfjmDHJythnfDg4fM+UmSdCOpFKxfWX9uQXD0Q7nteiqu6K1a61HpvJpAG8q6C4C7hQFcaKYDNvcl5dD2L7mUW06MPAn5gPxqPhj0pUEMieUms0UhFm6SMmx5zkZrcfQnBuJ+1BN6CKF/L9C8ZP4z3vGUfZLFkFVZc7ScjD/V1qLFBkO8YAKbBRr7yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 05:08:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 05:08:23 +0000
Message-ID: <105b0aad-93be-49a7-aef1-1e08cb36da7f@siemens.com>
Date: Thu, 3 Jul 2025 07:08:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] initramfs-overlay-hook: Add support for
 handling links as lower dirs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
CC: =?UTF-8?Q?Enes_=C3=87olpan?= <enes.colpan@siemens.com>
References: <9a4b9986-37c1-48ec-a8cf-5ca5dd196b36@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9a4b9986-37c1-48ec-a8cf-5ca5dd196b36@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5fe59f-812b-4ddb-f000-08ddb9efa28f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Jy8qy4RnO0dWu38JMCyFjKOfg2Oq5DXRVD+lYsdsEipymKfvsjOvOZ7fTbVd?=
 =?us-ascii?Q?xjPx9LyupJN827gPZ5vxXuchbuYmkDfXABpgnaCVX3yTYLsZ+WBFvCeRRljL?=
 =?us-ascii?Q?WKRUaWvr3E9mxLaaMzV4ZoRzPbV7GaF+b7lLV5Jc8KFA2cjs8MDild4oza77?=
 =?us-ascii?Q?FbYo4W4yQ0MrXg58N9MpWxS1ljaPboPRPcN5TbYbmZ/Xcr+BHmqd/VibThNG?=
 =?us-ascii?Q?Qr6essYYXoOiBaALpEjzBb0EDUqDHd2aa3H0JuOjSHfgqNdxchXgxz7CQs/m?=
 =?us-ascii?Q?IOaw0UUgnb/cY43cDNyW6ks9xWpp2rDhlpeiI2T3kgzGiLBnC9xbwRBF82Ss?=
 =?us-ascii?Q?bmVfo7L3l3/DLX5IyMlPgVJvPpiLi4thHHlkdeiXtYqSXnc5yl2CM2O+gMM/?=
 =?us-ascii?Q?rCQyn8AEwfqcj21AwyBEPgzVvXAcbF+SzHIkUrlQ9+4hJQ7tiNH2NcJ6FEUn?=
 =?us-ascii?Q?GhfROGo14wqNViw8QAEiF0+K/ayNXGLzVz5+PuORuYg355DvsCLPKWQl5TrL?=
 =?us-ascii?Q?Id9ba7uxft3jaAXoV9lFTMvJRKrHLrrMsa+TJ1o95wP8Uie+A9I4PzmiTA0f?=
 =?us-ascii?Q?et6+6OrdvkXZEDGju+SW4yH0PV2MR5H8MwSwDmUdHayIOcDBTans610nvmtW?=
 =?us-ascii?Q?qgGBDis+6qv8XMZm+8Behw5N9ZfBxhupT+Gc0j/ywbicsBCPdFGLlSTZ9Ye5?=
 =?us-ascii?Q?QOwVRhmDw7T6ewqk/RIKsNcm6TPOUikUNrGMTxktQJpNY9DvJ/1VvkMbK3Vx?=
 =?us-ascii?Q?si6z8/eXYfeSGgBHPAMiYib1JLtCDhZpIHrasZMVzIcAeIxgJmbA9UqjWIuC?=
 =?us-ascii?Q?ZT4k3NZ1GPNKgYKQ9+DSBqjtXfvGfBn+WZXDPhe3fOwMRxiJ68zQQtxxTi82?=
 =?us-ascii?Q?KnMFy42NWtFlvzUrJ143+Ch7x62uCENevA1cIJ9/J5bU0XGcnwnLNhs9c+vF?=
 =?us-ascii?Q?L+s3ZnJcLG1T/cyTuCy3hd/vJkp/Ii8nea5Z4jbKx6KWI2suVJWtXQMmm7PC?=
 =?us-ascii?Q?F2zrBPaVQkzKtP9MK4FKerXiR8TOUzr/zTyyJteT42Nd8vSUr8pk/UD5E2YB?=
 =?us-ascii?Q?HvlmN1elTQ+3k4OnndEDBA1Red7i1dLBV6ZkZeweTWknCGzTaLMl2W5pwWjV?=
 =?us-ascii?Q?UY+x5xJk5gUUGQ+NfSXBsO02HnkgQtrfpwwmZd9RRr9+ZpGHDQ8E6XH09OyU?=
 =?us-ascii?Q?04aH8FdoNt5ZS3u+7wwZL6sAGRa6GKkHWRIDSyDHaO6lpJhrnq/xG8OHDD7E?=
 =?us-ascii?Q?MVJECg/0IWy+NXqjBXz31QVWBMxOeKWexFLgZBjhWUPGFUMGlr9lrNmKq+SX?=
 =?us-ascii?Q?CiteW1UsvRZTF9v4E2U1dLuGgtOGNvlfhHWb8EBoKnQ5O5GKhXaJit2SWF2l?=
 =?us-ascii?Q?rl/CnkqacT1ZljTZ0dv/OZ/iFH8c+1Z8FXvoPWl0WnxanFUAk7Dg2w7jnUia?=
 =?us-ascii?Q?ZtFBA7bEZpo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZUPuXXqXtyeuMbEO7chgvArKPA0Fmcpa4R4hWsb48XLSkgCfxOGPP3Ke50bQ?=
 =?us-ascii?Q?8kIb+uvo5IlExtCui0+cS4uzcD4aZpASLjcqrgVC7XPH95+QpnVMkuXcF44l?=
 =?us-ascii?Q?Aq0A5f5vnhSttUvqY63A81OMRSOL4U8JKPSpP6pBTpxxxVj1jNbx+E8nDy1j?=
 =?us-ascii?Q?KrHQ8bEXllGUpVAQhg3ukNZGdkPd/pR+ZxnN+XHzAz9e1K3GUnfSNU+/6oVK?=
 =?us-ascii?Q?uC/QHN3o/liqbZVcAjSW/o5ho10W9n0XmCOnynLSYmvzBRfPXgFL0PJWdx9C?=
 =?us-ascii?Q?/B2rRApJigF4g0AHnHhOFsHKNBP2IvtUtR2SSngOLI+bNR302A3JFNy7gFTj?=
 =?us-ascii?Q?fYkUZ24+Y/9dKASir1HEV8ObKoWkvlr6DQ1ep1WqpvT9V9VjE5D0CkNZIAyP?=
 =?us-ascii?Q?efeD9LlxphWWf/Q1/A6LjCTKi+hUcfnORVA4NwJO6/r3Z2h8dJG4MjeRcD6S?=
 =?us-ascii?Q?tFs7DVDUz5PmQFhoKbJLpsstB6Px2uW6dprfEzFwo/Yw/6CxpGcctgvR43c+?=
 =?us-ascii?Q?IldEQ58GZUdU9MRXcjSSEP9qLmVHA/Y8oe0RjozRc1hHxjquj9kpk6g0sxB1?=
 =?us-ascii?Q?hhDxPutmvzdxAznCmWZsvV0UfwcMqNaWDr8xNvbSHMfGmvTfA4b7g/Fzk4I4?=
 =?us-ascii?Q?LZeyzNxunMOxyJL05hUsKsOUTSzmhm0QyO6N5ep6dnmtBdx/YMjIn5VvSF5p?=
 =?us-ascii?Q?h3mcVYfoeviJMDrQnSQZACxXpadmsH8DP/ip+MUVmgcJtPDxatmTVBxMRw+9?=
 =?us-ascii?Q?os1vGntxW6InyYbjtXtJp7tJZxJMLoc/VQq8rw4TfAActFG6fhyVD4no1zHG?=
 =?us-ascii?Q?6H3QUvWoHoDHxkkv4nA6iqJBElSbDsLc8lkVUmX/LKAfmxuhAi8LzAgwkW+j?=
 =?us-ascii?Q?nbyA86HEVbdk1atuIEHt+/9tcyIUaeyU0plQuvv8rAXbvTYjT75pex2oEjYx?=
 =?us-ascii?Q?gFrV3XU17Jz2+eMqS8RlAzRAMLXXwYfbh4ZCObMCx4QIYAF+m+1F2I8wppqR?=
 =?us-ascii?Q?20bHVK30oHPmfD+7Gdv0MzBg8oSmT8EkPa6t9TE1nglOrItl/5vfd7TZawvR?=
 =?us-ascii?Q?fe2S8ChdcepqYZT3e9hnQVYaBB1O1SWr+Ua7+bq3u3OVNx+kL9TTxlgbhRhK?=
 =?us-ascii?Q?2gPDnDox5MoSjUXj4o88RqEcKhEZykI6uuccDDn75pQaEoedWUE1/M7XT0wS?=
 =?us-ascii?Q?01rQlPFXZKbvsbYo3qIuwndrZ082Z328jFtdZaMTkJY916NtxteX9TS3I+rQ?=
 =?us-ascii?Q?1ISQs/uEREfgW4djbY1XZcGCAlnxuE1K4a9Nk2ZK+/tODoLj6TBXsJlIwPhj?=
 =?us-ascii?Q?+20raO7RIKm7XZzSBkmUvaBl62LeRTz/RrBQ4qL10nlZu14DP8egPnuNFtlW?=
 =?us-ascii?Q?tL5ckOLaMRMaP4bWEIcv8e49i6JTT+dqB6aUX1t1R9QnCAX47IVtaYfMfj41?=
 =?us-ascii?Q?ivedSuVXYFR1ujkwVuimw4yKJrD5dNY9eyM0UBcePRqMjSWHUifLzk4hA5Em?=
 =?us-ascii?Q?78Ie1IVv7KGkdV25PBXdxYd5oT6XJ43c3LR2aorbLCBtFXU4q1bHzXWdNPFf?=
 =?us-ascii?Q?TI9inST3Dmuss2NSyPRnVcGTT+MBpHh7Zb6ZpgpD98t6TH9aIFsRGdfFh6TY?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5fe59f-812b-4ddb-f000-08ddb9efa28f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:08:23.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzvUOAaQ4HCM2Xb5jI+vxtfrpFK9y2kPGw3IeywLY3DCIYvd9lQo0rGlmrwfmvGaa7xh1gycc1O5/vaZl1TwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 05:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19320

On 01.07.25 12:45, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> If the specified directory that should be overlayed is an absolute link,
> e.g. /root -> /home/root, mount it fails as we try to find it inside the
> initramfs rootfs, not upcoming one. Address that be resolving the link
> relative to rootmnt first.
>=20
> Reported-by: Enes =C3=87olpan <enes.colpan@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Changes in v2:
>  - make sure realpath is part of the initramfs
>=20

It turned out that this approach still gives error, and those are
related to links which have absolute targets. We likely cannot and do
not want to support them, rather fix the one we cause (/home/root). Enes
will propose a patch for that, and this one here should be considered as
retracted.

Jan

>  .../initramfs-overlay-hook/files/local-bottom.tmpl              | 2 +-
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.=
tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> index 71cc63c5..bc5f0ea3 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> @@ -47,7 +47,7 @@ for ovl_lower_dir in ${ovl_lower_dirs}; do
>  	work_dir_name=3D$(awk -v var=3D$ovl_lower_dir \
>  		'BEGIN{subvar=3Dsubstr(var,2);gsub("/","_",subvar);print subvar}')
> =20
> -	lower_dir=3D${rootmnt}${ovl_lower_dir}
> +	lower_dir=3D${rootmnt}/$(realpath --relative-base "${rootmnt}" "${rootm=
nt}${ovl_lower_dir}")
>  	upper_dir=3D${root_mount_storage}${ovl_lower_dir}
>  	work_dir=3D${root_mount_storage}/.${work_dir_name}-atomic
> =20
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-h=
ook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hoo=
k_0.3.bb
> index a5b39d9a..a50a213c 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3=
.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3=
.bb
> @@ -45,7 +45,7 @@ TEMPLATE_VARS +=3D " INITRAMFS_OVERLAY_STORAGE_PATH \
>  DEBIAN_DEPENDS .=3D ", awk, coreutils, util-linux, e2fsprogs"
> =20
>  HOOK_ADD_MODULES =3D "overlay"
> -HOOK_COPY_EXECS =3D "mountpoint awk e2fsck mke2fs"
> +HOOK_COPY_EXECS =3D "mountpoint awk e2fsck mke2fs realpath"
> =20
>  SCRIPT_PREREQ=3D"crypt"
> =20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

