Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321BBC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:31:40 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7866.1787733094832799169
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 01:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vla2jJgC;
 spf=pass (domain: siemens.com, ip: 52.101.84.17, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozMRykwTIfJvN8ytzqDL6Li2ipMSOluQJHuKj0yF5CJCroPMHM9oHy7yoj+gXqMueX3v5zNT4GC0z7IVqcULYXJ4TjZ20zbCASofw1sphu+dA4/IlStzpuSY5FJLhoeC/dxOrVlVEkuOjJvwj9j1x3f5+nd3m9+B6DyHo/qslSs7u29LuHIlyGWCmKDT7ZGJncc3UPxMukxLFdTC3JYXy3U8jvQdXSRxhK8Nwyv+s0xfAgBIcUbfekhS084kgckRpjWOL1FA6fuoaRo0l5brxt+l4mp1ZG5N01fGJcYZ/Wx8jXqdiHWYy/kpxWmqQndIzygNnZOOAH71mRBBo6DGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfOLQO1J6m6lo/7QusvrHX5GzfN0XPKuUwFh5aNoXJI=;
 b=i1epoqiibsly55pD+Kv3vbtKBsXsDGcWrfAvhYm+DBQTJHNvG2p5/9ZqhsG0s+2vveYJOUX5Vi/oRXUmkHeIOBC+3cB3FF0cldg9aU5iOyVcr2CN1W94kwdVhDnymPe4XMzU3LHF9NiCZj51I3g5ASgv7nsT2JqpaWevnbXZ55EEB5BV9NQFp0UvUulqn2SzoFylsVrvil66tqW5euDqaSmsPNisHctGX9sqUfGP/v4vohawEh+QAXQkY0yeZQrfHqrc1r89wpr3TjKrsfF2Fi5RtpDzPCJfYTOoVJauURBoIXPvNS1FKSE3lwyMXRgNMG9SobgSYm+aBCqlcCLXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfOLQO1J6m6lo/7QusvrHX5GzfN0XPKuUwFh5aNoXJI=;
 b=vla2jJgCwGiJUHN0WhmsNC89h3M4tdiyPhI9PjgjPSV+0juGmjFsqw31urCBu61a9qlQCHNhDfav2NUMKvX20/S1vknpXICdu9tS1Pt//0mEuDjvmi/7RFI30767VkjzsFkQAJRWbgDXKpE1RrhWmbNOtGlzQH3+reVAeOmJi//uHTjikPc0W7sKqpvSmlJ/vmh3/W+F6aentzBmErfxIxjpPWmi1tegDEjhJvtZYM+sVI94OhVMU7BTzpDrhMrG+iU1kgb2QNx7jJlXftgjxmBksarA87YBLaXQQkBQZ8bEGmBH03N8AE6uhkG/oSzyGYTyTQIJvfWg/Hrm+uSaEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 08:31:31 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:31:31 +0000
Message-ID: <51c1c773-6416-498e-81e6-48294b6cf80a@siemens.com>
Date: Wed, 26 Aug 2026 10:31:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/7] secure-boot-efi-keys: Add recipe to
 create EFI keys
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <97dc63827a8f33a225a39b3884afd6e6933c048b.1787722904.git.jan.kiszka@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <97dc63827a8f33a225a39b3884afd6e6933c048b.1787722904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0088.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::41) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|PA4PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ff579d-7502-40c8-e08c-08df034c6e10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|11063799006|4143699003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	6PIZMrHlgLhow/mOeGa84D/jz6i5Lk8O81Eg1FfSQ5wfhn0pW4ro0k6kYfwlvqHI0vRoIpzFGCMAc5p092hqcLsSMRO8VzUlq7Eu25cQ4Rz4dtloUxTEmCOnMf+iFzkT6UnmgUvK4Iq1NXkSOHTgVRnaQ8SD2mqJ1qNab0aOpR74AwN8Ir7oIKLeXeFFHYILr40Cts316rZJOQ0DjwMg9VOPI2vYI+7mXunNOqdQVCOdv/FNKBnpCcE+SpOdf2K5WX2mv/XUKntmeri2v8zomz7JJZKwrARky0t6TIdemX8gs2uwaIvVALQA1AuD/wJvDNy646rvwjNIpUHlk49vlt88UzIPWgZuqASu4cCKJy2ZZIGFb00zvr+RBtKi3TPFJALMo3Pwv9zLC4mrMa5id64bjjuoBSmO3OGnvYerHHdzovv39Isul9s26jHGGsaWl9U3QvuaFleDwdnd8sCCrJRXWtR8gj35pDxjfZAfe3bUJpAK4MaKSREfPR3v75LgNZXKgjkzWdtSLhCrVbbOzfiHrGmmdYkUbg/Kml1ZCz1uAAJoczqs5TaEC0GUDyZKL6N1wI4c/V8bk4kqQhV2ge0XZA6LjJ6Q64wFqONikmHpMW2pM6h+E6cHfU2Cg/wXhDLm3U/z0Cs1zT9xxeHmMWbS8F0mnF8+vvd0I7RXAEk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(4143699003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?am90eVlTZlowREdoSTZsdWpBVFlTb1U0dmNqU0REeU5rOEl2TmVSZDlxVW9w?=
 =?utf-8?B?b0xTTmVTQ1BxVGkwaXlOb2EyQVMya2ZhTy9WdDlteXJ1bkV2NVZhWm52akZH?=
 =?utf-8?B?ZENBNlZzelZOeEFHNFYwUTlhM1hBMVpLTk1xOEVMM1A0QVhMbHp0L1hYSjNh?=
 =?utf-8?B?M3dGWE5mZTJVNHNnd1JkRk5xckprRFVJNGlKQXBmdHFkSjRLZFdGTHp5YW5l?=
 =?utf-8?B?WHZhTFM0ZDZqQVVsMEFCT3lFd0lTMEV5WjVvREtCMitVUU10eHZxUWlRSk9O?=
 =?utf-8?B?dEwvZ0hqOUxpNzFmdXk3R1ZhM2xTWkw2QzVLbXdYYjUxbytTWThJbkc1RVlQ?=
 =?utf-8?B?U3pkdG5ZY2FtTDNzR0h2SmpPVW1hMFBNRmJHWCtKWFJKd1poTHc0b1VUVU9G?=
 =?utf-8?B?VGpiUG5BSDJ4eFQ3WFJMbGJkSkdDdTEvc3Bld1NnQUN1YXg5NEhvZklQcUZY?=
 =?utf-8?B?VForK1hWOWZSL0pHTUY5UGh4UVpFRm9TcFNxL0hJd1IxYXY2bDVSYW5vdmJh?=
 =?utf-8?B?WktIWkVXSDdWU0F1VEw5NHlzSTlvc1hqaTdJV0E2QloraHN0eEtuV25GNm9X?=
 =?utf-8?B?Ly9lVm1yZjZ6TVhNTWJZa21qcm1jbmsyTDBhTVdYc2MwUUt2NDVyTE8xWVQw?=
 =?utf-8?B?dmlXTzBCZVAwVlZVaWxZMDhla2VjTFFhYUovWUE1T2tITy8yalFPRUw4YUNN?=
 =?utf-8?B?UnlsWENXZ0Rpa1ArejNBR0R6Yi9WNGt0L2JLQ3RucHN6VVdGeEZ6WUZBaFZO?=
 =?utf-8?B?ZS91bFFuaXZxeXQ0MzRWTDlveDVuOEsxdlpXSUM0VmwvZ1d0ZGpHN1E1ZkNv?=
 =?utf-8?B?bjNZZkN0djBGVHQrM2szcHFlcndIYW9ubjFGWERhSEF5LzRXazhCNUFSdm1H?=
 =?utf-8?B?NjVUL2ZveEhMK3pONzBWN3Jkd1AxVmdGT3B5dFk4eFdSaEZ3c0pZbnI2ZG90?=
 =?utf-8?B?SnVPRnRpMFZmSFVMcFZ6UVNmSzB2OVZXU1I1SUpsR3lTd1FTL3U3TWhGMmxW?=
 =?utf-8?B?RHd2R0xzUGRrdzU1ZTNUblI5U2wwdkcyRnh4RXkzekJmaGozeVVnaTJ3REow?=
 =?utf-8?B?OU1JdzVWWFN4KzRqSFZ2eFUwNHNEOW5UQmNKQ20vcktURFpPQmM5R0xjMkNU?=
 =?utf-8?B?TWRtUXVVelVMUUkwM3ZxbE9jcXBhaGZJSHYxSyt3WWI4Ym9ydTBTTEhCczkw?=
 =?utf-8?B?Q3FOcXBqV0FVV1FmVE56ZHRiaERKMnJ2VmkySGZaVzQ5NFhjUVk3MHVIeEhL?=
 =?utf-8?B?cFo4Y0h2RC9XZ2tQV29NWEJxUmFYbnVlU3drWHhOSWdJN3ZDRXRWMUthTlk2?=
 =?utf-8?B?U1VFV2pMajREL1VaUkF4Zmo1a09XNzNpUVQ1azhyM3M4aGxRdTNSRHBnSHBT?=
 =?utf-8?B?YXpOWTFMREs5U3NIUnhXOWdOUUVnUmFoUFpwZUtWckcrVlpkY2FoejRqTFA1?=
 =?utf-8?B?V1BjR0Ewa0gxVG1ZVk4zZXlyQVFYUEFQS0hPbFA4M0RKeEp3cEdLUnFrR3FC?=
 =?utf-8?B?N2hQaXZIVTg4QTZXU1Qra2tSVTNGb0FRWlcwNXl4THBpUW5ta09BK2o5MGVs?=
 =?utf-8?B?Zzdod2hRc1FIQkdWSWNBTTF5SFQwM1p2NHVQcWN3NUY4N0lQK28yTC9zVVM0?=
 =?utf-8?B?WDNwTmRXb2VwcnhqWUhMdnV4WUpKY1dvRFVkbkFZSTA5VDI2cnZyYU41N09q?=
 =?utf-8?B?Mkh6ell2U1BTNUx6Z3Y0RjAyK1BVZGkzcVVrYTIranhhY1ZIdlhiY09FSnRN?=
 =?utf-8?B?anpLVlZ3eUhFSVhnWk5WMEhQS1hMOWw2c2ZyalpwTHUyTEVPajhwcnRDSXFj?=
 =?utf-8?B?L3FVOGIyMnpKT0Z4M21NNUU0ZG9ES3pXWElvVHo3ZHZicWJDTEIzVFBvZnVr?=
 =?utf-8?B?MlRrVjFnUlF3TERQRFlSRkw1ZENlY0JUYzJubWZTdUtzQm1sc2o2RXlLQzVo?=
 =?utf-8?B?UGpWb0VnT3R4VHhKYXlqRUxVT3g5NVZ3V2k4VThDZUFjZzd4TlNNUG1zR0Fw?=
 =?utf-8?B?cFRjTHVBd2hBVGlJVlVVeTJKaVh2YVY2dDdlc0J5RzY4YWVWSFhFSVhjY2J6?=
 =?utf-8?B?TU1ZS1gycjlJbVhRKzJWSGg0SlVrcEREZHliR1p5UE93Z1VTZ2w0U3BYcnZ3?=
 =?utf-8?B?cG1tbmVld0xRekltcEkwMkEvY25qTlFRS1pFNE51dms4RGw2dTUwMURvblhU?=
 =?utf-8?B?WlVtdUFkd0wxVGNIa3VlQXJlcnBLSGpVUjZrbE9aSGxiUE42Y2VsTUhXc1Uy?=
 =?utf-8?B?TXpHTTFaamVQWUFtMWM0V0Y2ZlJrdTYwMzZBOE9qb0hTa0lFb3lwZnU0UVEz?=
 =?utf-8?B?bE1WLzUrcWRDWlVMUTBBdnEzdk95WjFHS20vdlRJUlVWNk5FV3M0OVVaRENj?=
 =?utf-8?Q?BMQF1C7+Hv/wrt1M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ff579d-7502-40c8-e08c-08df034c6e10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:31:31.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +haepzZMsRLllcHxYTcT2kbfo2m6YEfgcWitz3hLfOEkP1ruwXWsjcKDOo7t5IQLdvX0TSebMqAi9wYOmMFDSRlLwNRyeIUo9q2qPdB+Ua4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5780
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 08:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24017



Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This recipe allows to derive the PK, KEK and db values from a single
> signing key as we are using for demonstration/testing purposes and
> simple scenarios. The recipe provides abstract "secure-boot-efi-keys"
> which could also be offered by an alternative recipe/package that picks
> up differently generated keys and/or a proper key hierarchy.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../single-key-to-efi-keys_0.1.bb             | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
> 
> diff --git a/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
> new file mode 100644
> index 00000000..cfa48b7f
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
> @@ -0,0 +1,41 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg
> +
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Generate EFI keys from single secure boot key"
> +
> +PROVIDES += "secure-boot-efi-keys"
The naming confuses actual keys (private portions) with authenticated 
efi signature list) actually holding the secure-boot-certificates - so 
maybe secure-boot-vars-auth, secure-boot-certificates-auth or even 
secure-boot-certificates is more intuitive?


> +DEBIAN_PROVIDES = "secure-boot-efi-keys"
> +
> +DEPENDS = "secure-boot-secrets"
> +DEBIAN_BUILD_DEPENDS .= ", secure-boot-secrets, efitools"
> +
> +do_prepare_build() {
> +    deb_debianize
> +
> +    cat <<EOF > ${S}/debian/${BPN}.install
> +db.auth usr/share/secure-boot-efi-keys
> +KEK.auth usr/share/secure-boot-efi-keys
> +PK.auth usr/share/secure-boot-efi-keys
> +EOF
> +
> +    cat <<EOF >> ${S}/debian/rules
> +
> +override_dh_auto_build:
> +	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
> +	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
> +	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
> +	cp PK.auth KEK.auth
> +	cp PK.auth db.auth
> +EOF
> +}


