Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28570.1793860985868429703
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:43:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f9h7QKEM;
 spf=pass (domain: siemens.com, ip: 52.101.69.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfNq23rtCZQVO+w/VFN5b+/vCDpgtq4QtQbTgXlk51tie4G3HNGOe5RqYJY74ALgBgO4kYUDF1daYybz4nL7ZU//zRQHyZdHQzjsvW2zMMXCLUA4eBdQRkB62qaSFFb99FuwmSTMSxt2wTzNETLP/JjL5pGoy3J5NMHARND99YOtz5ynRLOQhNiY1BXM7vLc23y2rA+tQCTu4iuLzSsSnPvG+3kgwSM2lPY3uD1myWWXUiyYHS60u3ZadykMoyYtFjA6UEiquIDI4Lt2PYSh9kme/ToDfIXoOqjWMiS1pzjZ9JQ5LEWjjrHBJVkt9gQKwe4qbvO1ldGaoG+nKmmUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exJLkoYPvzx/sfV24+aqeN0tWQt8Mf0M74u1DO1o0b4=;
 b=ynTjMfOHVTsbiWgnP9CC/f0/F1EntrNZSRbwsKQKQiW5nTQP5Ycm56euXyaKkfuH01wLsCUJn/+rcxNeKFrVRu9l0z+8/Kw8zuPH+8KU6zE3yiG0tPTTVPJ2vL5zzo/6tAiG/cGP7oUl0R+N6tlVAksCnJyZ16tHy+nes6jD132Uu2SH0yKPEq1liL0risM/jFkukNuTHM3krk4OaGgbjGrtvHRPG/q+84fm2caHNBFUyN9pZyq0eU5ol1S9TaS0/nFEHneeXxlAMrMXj2hNKRdjKoeh4T8BiIQMfcLobEl+QAprfzP+9iT6xW7Qa11YP+6FaU4JI+RoUsIS0TG4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exJLkoYPvzx/sfV24+aqeN0tWQt8Mf0M74u1DO1o0b4=;
 b=f9h7QKEMvAvIWDCEAprVEoKlXuUFzRAohDr+on++vCtEX9qhLdnuhC9vNcDkt4VD190xLZTEi1bXVkUAZEDe1wVPXgcdceIJkwHNev+zjP2/GMd5kiueR3A5qlrSOFjTMOCAYbtWkVmlIA76Tc8GKcY0Jzwd7Xne9GmBIxBNfvcz4cRC2PGHL/ndo7SGzD4T2mZKL+s1iBfIjLAjNOsCWRZj81P1aQipM1ZbX8nfYn47jgaeqcaK8ww4kU0Hy8LIw2h1rXF0rZ5Ucnc6p9Jg47kVsnWpeNdWPsLtXUdB4MNP3ckD0q/F6DTXm8aQqNlDRQ8L2Qu59gUdw+YZJaNe/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1d9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 06:43:02 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 06:43:02 +0000
Message-ID: <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
Date: Thu, 5 Nov 2026 07:43:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 939140bd-dffd-4d11-d573-08df3b0809e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|29003799003|6133799003|55112099003|12006099003|3023799007|25016099003|260925021911599003|22082099003|260925022911599003|18002099003|261102123227099003|260925021311599003|261022105027099003|261021123027099003|56012099006|261021121427099003|261009223027099003|261022115727099003|11063799006|10067099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: ZXIkf3qNRQYYYMpIPGFHBnN6Ue2xqKMDOQFzHEDPPedirJeCH7FFixMLRGETMaQmStDciC41tElqOvEPHurgI+w3E5qvltirJXjCvNwfKQt2GZfK4zn0i52FZw5o07+BXQnKU9O+amjBgE+W6d7iolGMrNtTNVe0LTBolTx/LqYPg8+GUqRrs2Cel+kEhgy1hRpHKmZfingTriFVhfjwYAFfCyAFZz/WL9JCDi7HIJLJXWf4Wb8vJ4uU2821oTotAYu2v5MO/u3U4cotzXU2IYOpEQWw0JZ/Ps9u7sd6l9rxFHloZli+bq0x4fGi0Ltg9BHIi9EdRioPAxn5Pt04nn3w0uYkuYhK1y1XYELZg4JKvYOTVNGF9jOBuBEt2VewuUx7RBwBa3pFWCGRkMcMyPTYcGcqTULFmH6jmnCtbbsr6x1BBD8SGNrvkM0N572IwA5u6J0bKAZcpe1RyLqH1y/KSrsbn3uQpMw8G3JFzve1PxHwlF/JPL2AH0LJwpuMVOPHqI5ACXn3+JoKI/dbtmX2z3capopJQesc66984ETHY45FgL1BPXI/eBE4uuAPusRfeX3+UmwwluHIySvN8h4z6SH20DsDdfMNJLzS27uARprWQk2pRgB9KDw4jik6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(29003799003)(6133799003)(55112099003)(12006099003)(3023799007)(25016099003)(260925021911599003)(22082099003)(260925022911599003)(18002099003)(261102123227099003)(260925021311599003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(261022115727099003)(11063799006)(10067099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWw2ZGhsN0pUV2w2WHdUejI4N2tCMFM0bU8zY3NwVzh0UHMrZm5ZWDI1d0U2?=
 =?utf-8?B?cDd0T0YvZXNmcmJoSE1DM0ZuK2RacFdSNDNHby83dnZMNGZiOG1mQ0R0bnNx?=
 =?utf-8?B?dDdRcGZrVTgzYTloZDM4MHMvRXhXYTFqb29VdTFwSVVmVXJJMGcxeHN1OHF5?=
 =?utf-8?B?QW9LMGR1N2NHMVhiWGhwMEQ1RnZ4SmdoUHNhdlNqMnhtaWRveHVveDE1Y01w?=
 =?utf-8?B?U2Z0OGdreC9PYlRWdHJTTzVhNmpHN1NLTU1SeGRHTUVuYzhhL21XUUJ1YnVt?=
 =?utf-8?B?ZUlqTDlHVmlCTWR1SFYwZzA5dmlsbDVjUi85S2ZYZXZ6NS81WEQrUGZFWkxS?=
 =?utf-8?B?dFFxcmRZeEpSMTh2V1c1VWFwWnEreFBMQkdweDlPRHRhZmR3anZpQzY4R3h4?=
 =?utf-8?B?bm1kVFNTT0FOVnp6bTdyMjNiblhEZlVOVlA2Z1B4eVdsYmdKVHEySWFNc2RI?=
 =?utf-8?B?QjlWTDRGQXJlQ25qU2Jtdm9xa2ZRNkpFTXIrbVNuZ1VoK0Y4MHhtMEJRdUdH?=
 =?utf-8?B?dnhwbjdCeEtMZStIbFFNNXZTL2x4Wll4MFBxS3BhNkI4L054U2ZBd201MW8z?=
 =?utf-8?B?WGZ1MXlhUGdnZ2ZLbFVrOXh5SEhBVjZGeXFrTU5Zc20vQmo5Z0JJK2pOMmMw?=
 =?utf-8?B?ejFvVXZyM2VWQlNyTnk2Nk9UVkU0UFUvcmxBay82UEkraFFLSjc2WjlUNnFm?=
 =?utf-8?B?V1BxWXNEVFcyWlRMN043UFh6V3IzMXF2a0E4ci96N2h5SmN4VkRwWGJWWjJH?=
 =?utf-8?B?UGVjdlUyZktXWmhSeDM1QkZWZzNWYStjVEZxZUNtZVF3NEF5WHpmS3pSQTVO?=
 =?utf-8?B?VkxZTkk3K3hMaVBJdDQzbE5UUmlVQ0xtY1NZMDRjeXJVcXE4ZjVhM3d2Vy9o?=
 =?utf-8?B?WW94M2N5SXlac2xPRmtPQk1SRDVIaWltcWw4M2VJdldWaFdERHQ1ZFZvUEU1?=
 =?utf-8?B?d0JOeWhvUHc2SGNIcUd6RUhIWVR3TnQyMWNLNkQwcEttcUlaTS81NmxqdUVQ?=
 =?utf-8?B?V201d1NoZHplMnJOeUQ4NDlPWkxkVWlTZUdYQWxyNmxGV0lFNGtCSUkwaWY1?=
 =?utf-8?B?R05YM1F5di9hK1R0TXFacjZaYWZkZFpiQnFwL3NleTBuMngrcWpGNU8yQmVP?=
 =?utf-8?B?alFXQUpOcVBuNHNGSEM1cmd2STcySlh4SlFUQk4zMTdtVXc5ZkNSaDhGQXk3?=
 =?utf-8?B?LzJrM3FJSCtydnZuOS9vOU1mZWtXaWs1cnpWWXVMWFVyaENLZGw0T0V4WWgw?=
 =?utf-8?B?dkMweEJoMTZ1YkJWRnhpKzJBaFBWMUllelBGTmFUcjl6UmdUbWM5ZmtiTkN6?=
 =?utf-8?B?bjJZdmJYSGoyZFBKYXhOcWh0cVZ1d25FYmxISVRleFprNUJWVXAzTGtBai9O?=
 =?utf-8?B?MFVETEpLdlo2WUxuVUVmVmlubnEzTVhQd3loQlVrUlBNOEg4bjRHaXl3V2NW?=
 =?utf-8?B?MkYvSHdzN29KaEtpMGpmOFVyeGpSZGtVZ3hOeVo0NzF6RmZsSVVkWEtQNDFM?=
 =?utf-8?B?Nit2RUVrUlgrTDZrSGNac2ZvU2ZEdHRzcXJXYXc5Y1lJMmg0SkFaRFYxMk9Q?=
 =?utf-8?B?TDR5VCtraXA1NWFZQlg4WWU2bFBUMEpUdVdaZGtJbXhCd2JTWTIvZTUvSG1t?=
 =?utf-8?B?M3FBcS95YVN3RUhua2RaMFBrS1hNUEN3K0pqR281SE9YcWh3NTVYbm5jWktV?=
 =?utf-8?B?SmhNUm9CMm5haHJOdy9Oc1VDdjZKdUI5L1ZnNkpzQkkxOEUxaEZzZUp0MHlO?=
 =?utf-8?B?ZmgrMzZCRVdGVVlybUxTcHF6b05xbUd2WXg0L3JGUU82UTRrc0VpeC9mUUxn?=
 =?utf-8?B?bGxPd3huaGdjYkhNU1lYTERHZCtBZmZnU3hxNjhXczhlWHBKZjRnd0tLU25T?=
 =?utf-8?B?UndUWlZuazdLZmlBc3o3N3l4dnJQS2hjT05FZzJOZWovdUV6clZaYWJxc2pR?=
 =?utf-8?B?U0pKeTNYUjdqdldlMmdzTzltRWtKY0VtOXdkWU5yajVYSjhRWXF2MDBIanFh?=
 =?utf-8?B?aE5pUkxidzNqVDFoYzlodS8xY21DVXVydkZiY1V0UFIxODRqTjVCS0srZlE5?=
 =?utf-8?B?VUYyNDlVanZKK1J6ekZZTWJsa3Z6SENuS2xVV21JdmJablVrMjJhZ1pOSXFJ?=
 =?utf-8?B?NTNHbkJ3TGFScGZtY0huSW1meW55ODZyamxVMDR2aUYvdGQwL2pZWDVpayt0?=
 =?utf-8?B?b2ZWa2M4YW85ZURMZndqRDJoUEZrb3cwZmkrTWxMVWxKTFIxb2Jkd3RMQlRu?=
 =?utf-8?B?Q3VMZzE2ZGNXRnk4NXRnc0dVaE9WVkhwTVdEMXNyNDBzU2F0eTlHeE5DUUFl?=
 =?utf-8?B?Rk5GdVVsWjRBV1RIK0tDeFdoNUlvM1NnSDQwSlFyVk1yQ0t6STgxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939140bd-dffd-4d11-d573-08df3b0809e9
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:43:02.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utqgqZSjxwl6Ei91E5qiA4pWx6csLN/OcFcN0d0e0mQz+2+3ZAE5zMsfNKfG7RO+wB//dsfTTzXwg1ciwKAPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:43:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24639

On 05.11.26 07:30, Nobuhiro Iwamatsu wrote:
> It is no longer possible to retrieve the U-Boot source from denx.de. This
> change updates the mirror to u-boot-project.org.
> Since the mirror has been updated, the hash value for the tarball has also
> been changed.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  recipes-bsp/u-boot/u-boot-common-2026.01.inc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> index 9038dc7..60dffe0 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> @@ -16,7 +16,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  FILESPATH:append := ":${FILE_DIRNAME}/files"
>  
>  SRC_URI += " \
> -    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
> +    https://git.u-boot-project.org/u-boot/u-boot/-/archive/v${PV}/u-boot-v${PV}.tar.bz2 \
>      file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
>      file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
>      file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
> @@ -34,7 +34,7 @@ SRC_URI += " \
>      file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
>      file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
>      file://rules.tmpl;subdir=debian"
> -SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
> +SRC_URI[sha256sum] = "536c2204bb875236dcba41f5a5802090039a4b7a704dd284fcb9640e66a84a8a"
>  
>  SRC_URI:append:ftpm-stmm = " \
>      file://ftpm-stmm.cfg"
> @@ -42,7 +42,7 @@ SRC_URI:append:ftpm-stmm = " \
>  SRC_URI:append:secureboot = " \
>      file://secure-boot.cfg"
>  
> -S = "${WORKDIR}/u-boot-${PV}"
> +S = "${WORKDIR}/u-boot-v${PV}"
>  
>  DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
>      libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
