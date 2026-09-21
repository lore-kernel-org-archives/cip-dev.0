Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0CC982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47560.1789993170490942307
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 05:19:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qpMjikE+;
 spf=pass (domain: siemens.com, ip: 40.107.130.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgLLqVBPDs2CqJ+dC92Km8dPvhHuAz75KDSZN1oS5k4CylkB9nl+sqf4Do0aCFqCp9GlzzNwI5k0pin4V0bQqtznb3LRVrtinsuW7DNeDuyjf/Qvflh3VsVV7wdp+Xrie2iKtZL9vLXOHuB3KdJflvn2LSuemfwAiLerzsTak/4gO7ceCNygsEjG7jL2LuXif+XsIlwU/+QQOaUB4CQbGpvhUV4unan2W6fUjO2DvmgXbR/k+aQP2qmt2Y97ac2pasWcdUZT/qeUVFYo+f8IEjQNqzajYw6+4Ubh8+9IkDKjk7l8UHnxdNgwnQ8lx89qKcFuU0q/Xzut+gvI8oswOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7XImmlroMY/a2H6Nx593X1YGLUBShQwh+sOFaQTOj0=;
 b=TYZuziTFk3JiIyhg7YkCraBNo+wi/Pb6CMJxa+N90gKmOoPi1Jld3uPB518zvfi8ls6nu4Fojp+KhpKRndbO59wfLoxI6RfbpajaxqLNe5DZtKQR302+wUWRYhEw2S9Vn1wBDJTzWK4fHKvTwoDR9TQPOUEZ1tbZE97PnyMOHNI0YVsxCm+m8/VrGo46PxER5Pg4a5evkOA4Hc7SEs5xSWhRK0nSLxKytefSuZsd9vIZsZ75iCK+BquYB0oH1tnR3G9hbPigKiDWME05ALcTQdv8Ou+33t60SLph7v8wKZPyzAIhK2HNroaAaIvqM8NNuipopE+thTSOqsV39j5ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7XImmlroMY/a2H6Nx593X1YGLUBShQwh+sOFaQTOj0=;
 b=qpMjikE+qdEVuVBUYsSg571jx5G0BRumOv7l44lf0ig4ah3z7jmyvm/tlyonda1iItVbQXO11cTD4xmZJFzxX+6MZLTLGewP2K0G80+kpMt/KfdcwrrlMu08V5c94aQ/Qe7FD3ulSYXsHlORhAT+Q1m0GubImjqmZMOYZVTtHJT1FpuC434w2YCISKn9IcAlKLMcsq+xFg4t8ZwgEZm/uPEvibHxFSUhCaODZ2NqvtqwdG9+6wqi5EtKSKmVsRfF88Yyi8BJdBBjWS+LDu1Q83uqkNjzf6DnegbP3PVKyENpbRm5Lt4L7eas4iUS0J7LfRzrJ2NXuC6UluE59wgY3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:632::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 12:19:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:19:23 +0000
Message-ID: <693473c8-b994-4969-a980-3e7c2e5dfe5a@siemens.com>
Date: Mon, 21 Sep 2026 14:19:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2.1 1/1] Fix file timestamps are not
 reproducible for EFI certificates
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba,
 kumar.dinesh.h95@mail.toshiba
References: <20260921090931.156453-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260921090931.156453-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: a628743b-87d6-443a-62f7-08df17da9171
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|3023799007|11063799006|18002099003|22082099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	itoCvCsYgse4KgSVQeMi5tQB9qvfveLGXc6njdh42yjLjhYQKmfJFFZc7gqHMiqSd6f3C6hEGcoo/9/y8SATWuh98RWeuvJllg2mPSeYmyxsfFxMcJvYRb2KfaSXFj/1SvxYrfpux+KBEBwNBYqdOpgF8Dj6qix9xxw3S6KupKxAvdHFBPII1bMnX9jxBy3J+O8cvsFjQSN1zNYYzswrpCrp8Ie3GfpLua1VtsZHT03wY4kk+77D5PjdddChkF/4f64FglMmgpI60Dhwpj2GD5wcTKzAalsbvQN419h5YrnrRxi6PRDgJs/7btJIN8oc4Qa2mkBhNk1SNENLNf8qZpvT4bZhg9Qa9B3LcPM8XszKJ9olpGim2zbradqh9B7Nkg2EpzGBcLzXE3rpokDc6eqP7z23Vj8GQmYt6pMpy45U1g+bG+KG740UYA4vHC2eNdGSOe0wTenIPFI08pG+hCOXhGFwvuWTYnqL2qcHGjU3rnZdn1mV5eEUi1mLYaZGkfX2cUhpMn1FnnsyXMf5BSoq0uUuxTFD0H3upOiHjzSFHMS5wkqbyDatkJFMExMsdCBtI5sI5tQsMVvFaZfegAV7seyjyKwWcIHWdx7CkLpDldJ4uIvggrX9Jytywq+X
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(55112099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUlNWU95TWdyRlZXODJxZnFtM0dGRStEaTZxS0FNMUltU1Q1MW13empFeVl0?=
 =?utf-8?B?Q2VIT2xQMWhoOGxCRVVOeWxua0F3cUVzaU5scmxaeXdYaWxZaXBneHhjSWQx?=
 =?utf-8?B?WHRJaG1vdjFIWU9rcTkvbmxJdkF1aEZFdVZadzE1TUhsUFVxa2tFRkMrL3pa?=
 =?utf-8?B?ZEJZUGFvOEJ2UkJKRjdKM2NESEdpMDFaWlYwR2lCRDh6WDVDWnA5T1FJZnFy?=
 =?utf-8?B?UEx6dUw2dWcwSFVMNVRNYzNBdjdVZE42NkZJY3VKNTdTZFNLeWlzSm1idVdP?=
 =?utf-8?B?cThkcVRiTlNnUnJqV1g2NEtnRExuWnV0UHJORm5FUlExSGgvZjRWM3JFeGZG?=
 =?utf-8?B?TnIrK0xPMWJNd0NqdDJFVVNrOUxkdU03Mm9oV2YzbXRPdDgzQllpTDRxQ3M4?=
 =?utf-8?B?a3draHJnV0RNSW0zV2RXVkMvcVc1RzU3ZWhPU1Uvdk9HQjFPUWpxWWJkdnhy?=
 =?utf-8?B?QjlSQ0N2VHNjR2VhNTY2T3prL1RTSjZDc25SMmI4bzNoVy9md0srNHhqSWZD?=
 =?utf-8?B?eUc4Ukdac2srdlJlLzBERStFVGp1cVZYbkptQXpkVVppQ000eEhpU2tPOEhZ?=
 =?utf-8?B?NEhJa3JNeTBSTDR1T0hoVDhIeVExVDU1OGZ0WXhVYTJaWWVoMGloaVhVd2gv?=
 =?utf-8?B?c09JQUJuMk5IRjRzY3VLYWV4cHRMcllsMjA4aC9yTGJhbTljUm85d1VIV3RV?=
 =?utf-8?B?SmJ3bkZvbXE2R3ZPdVJRbGhNVnI5NVc0VTJoMmNtblVqd3NsSlhKZWNsQ09C?=
 =?utf-8?B?Wkc0WkZZYzFiWWtoamEvRHkrRzlCZWNaWUF5ekw1VFJlcnRodWNzS0NFeTZB?=
 =?utf-8?B?dSs4TDNoZlZRdytVaDRMTlM0aXBVcFhqek5QZk9UMjJncUY1REZjMmF4cUg2?=
 =?utf-8?B?eEs1ayt2clp2YVpxd0JTQWljNmhuRWxnbGhmS3o2aFRUY3F6WHZ5TDhSakpY?=
 =?utf-8?B?cDRBUDJDdHJpNjNoTEhCYlhqTW5LN0R2MmhYVldndk1GcHovUy8ybXBQV3RC?=
 =?utf-8?B?MGNOTWVHL25DdTVGeVl4dEswNHczeExhRkkzL2p4R2FVTnV3K09ZbVRuT3VQ?=
 =?utf-8?B?SEh5QmVSUjZJZE05U0lxNXMxOThSL3hWc3NMaFpWWTdhVVVCZFVsdnI0Q2tQ?=
 =?utf-8?B?aEdQUCtSRDkxWlUrU3RnSkZqQUhsUzZRSXpDRm9iTTJlQSt2VTdhczJub1Zi?=
 =?utf-8?B?WGNua1hZYW5FTGhHVnNndGljLzdESGdlcm5QVE9NUUZTVm9hMlZUYWRJY09S?=
 =?utf-8?B?Nkx0Q2dDK3VwS0xhcXY0UU5JenpSbVJ2Q2dvVjNnTStKUFhBcTFVWkNKK3h1?=
 =?utf-8?B?cmg3TWl2WlVERkcvbkF4eHhLeFhYMm1TTUxwelhPaVFlVXRqZ25VWlg5ZzRE?=
 =?utf-8?B?RTJnK1U3MDl0cTdCejBTWTZUV0hwYWZUTWtlbzJVWjdDSGxiRk1RenZIN0FZ?=
 =?utf-8?B?UE1oUjJkZ0lEWUVOSmtMVG1vR0x3V0xBeW9aWlZKNStzRGtxSXkrQlJNM1Ro?=
 =?utf-8?B?UGF3RXJCVlFmYmV6M01haFYxZU9vUUtTbzBJTDVvRWdTNmx2MTYxb0QybEpp?=
 =?utf-8?B?eHMzVjlwbDNNalhWckFVdm1sQWFKWXpadDcyRHZMWnJibVpySmZUbmRoNkVQ?=
 =?utf-8?B?V3lWL29KcklUczMwNkJLM3BNY1BNSm5qWEM5RjB5Ri9LcTNxaVhmUW9jNzdR?=
 =?utf-8?B?RmdPYVVCcDd0ZkNPWmtTS1RkU1ArZVZJN0xTczhPRDFBUWxNeGNqNzVCNEND?=
 =?utf-8?B?MVprRmI0bGFIQklHM1BINXBjN1RQdUFQRzUrMHozNVQyZDNzampGVzE3VlAr?=
 =?utf-8?B?NWl3TjFwN1VKOEQ0UFRzckNQZnRQbk9KQ1hkMFhpSmRtc0dBam9zbEsvUEk4?=
 =?utf-8?B?VFZRQmFIRXFZZDJLajdpZit6Vk5uVVY4RVRmd3BIYkNkb3ZOQi85VjZ2T05i?=
 =?utf-8?B?SlRoa3BlVm5DaVE5Nm90WUtMeFNXV3pUQzMrallRUWMwMldjT3RaYUdRSVJP?=
 =?utf-8?B?WEpob0x2ZnNvTTNyUUNUK1JGSVJtRzRNTVR0VnZxMVp5VS9jVFhtSklRMXZj?=
 =?utf-8?B?REkxa3pIc0FnV3BabXNoMzBnOVZnczRXVnhMNXdUUDB3YzRJQTF6RmlZMkVj?=
 =?utf-8?B?UlIwL0RvZnlaRTIxZWwxQlBjZndLM3RxN3NQYS8zMFNteVdjMHF0SjhzV1R6?=
 =?utf-8?B?SWtZV3REd1hZYlZSSE9RNXBzUDZDOEZ3NVo2SkQ0NzFaRUlQWmVLOWQ0Qms0?=
 =?utf-8?B?VVNnTDRjMms4OFlaUm9uSnB5cWJhcTlPdk9vTDNYOG1Ca3BSbnNvTjZXTjFU?=
 =?utf-8?B?REhyYTlneG1TcGdSMTlzekc0allPeW40WkpYaHlEY2ZuU3FqNkd4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a628743b-87d6-443a-62f7-08df17da9171
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:19:23.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXy1lVw7SKL2fIbP8Oy7pE8xxWk7QosY1+h5cvFHwO4WpA82R1ezNCaZdpiDimsWlReRP0SiZLcYzMlVAFc2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7758
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 12:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24257

On 21.09.26 11:09, Felix Moessbauer wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
> 
> [Felix: let dch timestamp depend on SDE, pin timezone to UTC when
> signing, pass timestamp in correct format to sign-efi-sig-list, print
> bbnote regarding chosen timestamp value]
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> index 263f794..b14d6cc 100644
> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> @@ -20,9 +20,16 @@ DEBIAN_PROVIDES = "secure-boot-efi-certs"
>  DEPENDS = "secure-boot-secrets"
>  DEBIAN_BUILD_DEPENDS .= ", secure-boot-secrets, efitools"
>  
> +# We need up-to-date timestamps for the cryptographic operations
> +# but we must reflect the chosen timestamp in the Debian changelog
> +DEBIAN_CHANGELOG_TIMESTAMP ?= "${SOURCE_DATE_EPOCH}"
> +# sign-efi-sig-list expects "YYYY-MM-DD hh:mm:ss" and interprets it in local time
> +SECURE_BOOT_TIMESTAMP = "${@time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(int(d.getVar('DEBIAN_CHANGELOG_TIMESTAMP'))))}"
> +
>  DPKG_ARCH = "all"
>  
>  do_prepare_build() {
> +    bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing EFI certificates"
>      deb_debianize
>  
>      cat <<EOF > ${S}/debian/${BPN}.install
> @@ -35,7 +42,7 @@ EOF
>  
>  override_dh_auto_build:
>  	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
> -	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
> +	TZ=UTC sign-efi-sig-list -t '${SECURE_BOOT_TIMESTAMP}' -k /usr/share/secure-boot-secrets/secure-boot.key \
>  	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
>  	cp PK.auth KEK.auth
>  	cp PK.auth db.auth

Makes sense now as it reflects the freshness of the artifacts that are
signed (if SDE is derived from the git repo e.g.).

It's also in line with
recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh, but
recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
may still need that DEBIAN_CHANGELOG_TIMESTAMP tweaking, right?

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

