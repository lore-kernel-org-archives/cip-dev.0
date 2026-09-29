Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F32C9832A
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 07:39:14 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2694.1790667544998303349
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 00:39:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TIelkDS2;
 spf=pass (domain: siemens.com, ip: 52.101.72.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+98tm3cKZOKQTfk/ShIkw6fqsZd6mV7RLEkO5HnkhdpjOQX3b0oCYOYMs759bg/emsaXhIZ2f0FusInru+8y9eVfW7Hal8SkqkeYz/kk8JDG1XpBp194j7mRVOXydFGPWMx3ORB1xoQh5+AoNCNqemOa2a0pELxhKAuvdWAptOgJBvSX8Dy/3gI+aFWOc0LiXciBPKj65BuRpS8wdACYOxYmsjGYQ6BcwIqgUcfr8g/sls6zTNdRypRygjF+jj8Y24joM4IwengixUL24zry5FYsPZF5KLotdud3FxW0vbtprBKM9idL2D55fulBQsdwdKRvV27xVftmcD0OF6iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koZZEP6RY7ySxI8TGDUyFrDc68H/9ZpF3NJI65Tmu84=;
 b=UID4PCATE3RqeYsnd0QrP7pYdR/lU9g7Wc4m1fk+PrLBusxYJ5CJN/gBdaWZK24QKsFcFwygn+v2J90tvIwr5HOvzPvNbDwymF2nNDLANO7bXkII+fL0wkxS0Pvk3bSzTgrQk/CqDsZM9J28kKEIRibMasybvBsHwYiMSfJiByNCRGrpaGosEg3yNZzYDy0lA+0ALqTwtakKi1UX/Zsw3nFKsyvAxIBJCuNagGNxkQPUScah7d9tiQZrbW0//rKM1PchBmjWfbn5PuWTZ6LhEsw/yIJaFPFx1rJxswHifaxhph78BLL1m7BsD+MR9QJ8Q8QeFfzrb2qZMDklXt7Rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koZZEP6RY7ySxI8TGDUyFrDc68H/9ZpF3NJI65Tmu84=;
 b=TIelkDS2umw29+O/8bBRap7acqMecjJoqIzaeDAvAwCT4Pb+4v0LhErSAv1L2dHwcy9+NrcMvcVYLqi7UsmY6Cny+w4fWpH306qp1KG2+a9hYV6SRAIjMm5oMXLjWPsH9OIm3sKUVCeCDl7HgTMOiq/qD5i7+y+SjGzTDrLkaoVTr56YBTpaHjewakT8NXKMqSqL31FiFrEKarb11UtQRUn7m5mhBnxXO+FPq1CY4ISTZtitpqsjsHHrc8Co6bqt6J6rt+rSnGr0I/qFxk8fHAIBYPwM+B9as/BD7c6oRygWcklPt9zGiIiS85T2RZ+Qh2nGrChFglzS7+ulDkuNiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:f8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:39:00 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:39:00 +0000
Message-ID: <62c6208d-da8b-4069-b8ba-c272c9604b93@siemens.com>
Date: Tue, 29 Sep 2026 09:34:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initramfs-crypt-hook: emit TPM DA lockout metric
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260928133951.3500729-1-sari.sercan@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260928133951.3500729-1-sari.sercan@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: a202b517-0a3c-43b1-543d-08df1dfcba52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	KeT94b0urdiYpJYRe4tYPKLLGFlHICZQG0/t/+NeT+0jCpRx2g66m79Oex1JFmFHBwzexp//PAtKmctN46EzguOjs4aRaME+QCczLuYOjzWEKHQgbInPD8YZtiJUy5QvBB4Kd6nptb3nlQLY/vu+0qRpOVHuwPdTz2/SdayfV6tZ0Nxy6IrAHJ0fqkJRgIGMM2v64pA9hZ5CmGrpeJHJnRRXUU/nwXtMvv7qiwV0F3pJZvoA2K1pvonBmhEsZUqS5OZIO5/IHuyuHL+w6+mmghQu3/L4ljWBq0L9J0lQbMfNdv8zpc/qpaSdncJaaxEYhzMMZWRn4T5WCCFOpAcZcjz15BDPdy8CA2yFFoJcNFMCGaL+R0XjaY+nbpN+k8UleHwvNigLf0C0rhtRL8TZYAB09eYkqwDQKOHo57j8lxSk2lNXhm0mKUueKb5y68Tnfm5i+yDai9dq+70Tvfdr1lDnAeDXv/S2mgpANrw6PD6hQw9ud5xdoXS2TjycSczhOKcmqpfi6UQKbwvPlrE8CWHRMJrO5sc/ZB+k7U2+CpOjzhqQd8pgdel89VsQUqorh9c4qEt5bIWjV8h7OnagJhOT8zZ6riv3k2PK6HCxDH3b1rVJftQEbQ6RFTy75aWdrgu6Q2FsY6KByW4aCC7U5xdiCDxjBfTFz2SDwaejgFE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZW0xcWl2dk9STFdvcVQzZG8wbzBJblBaZ1VXTlV1QnpsZmt6T1RnWG1RTDFi?=
 =?utf-8?B?WXRaU1EwdVVxcmxBdHI3TW41LzBkNmcvSEtvdzJhNHYwODE0S21oWndXdE1x?=
 =?utf-8?B?SFV3TkM5ekxlcFdWUlJGeGV1YjlhVHJsSVlrZVFGRGkwd2FjUzNzb0dVR2hq?=
 =?utf-8?B?dlhGMXhYL2JTbVFJWWIvbjdoWmFkNHZ3US8zUGsydHhXbFg3dzNNUzI5YlF1?=
 =?utf-8?B?L3NQK1BmZDBCdmZVZnR0ZElVTkhRc0NyUlM3cXdBK3paZWpqcFZiajVKM0Jh?=
 =?utf-8?B?ODR2eStTUzZkSG8xNnEySjgzTUFxOTI4M2FmWHFSVzRKUE9qbElRRXh0UHVq?=
 =?utf-8?B?L0ttbDlXU0lVU2xjV1NNeFVsZ3lJNlgxZEVSUkFKS3ZpblZSaGRuODh6SWtN?=
 =?utf-8?B?bTU4TzBqZnJwOWNwV0tZRWhjM1UwMDMvb0RLU0crRk00RFpTc0pLZVEvMjhz?=
 =?utf-8?B?V0RwdDVKZHk5R3J4V0xzLy9ONFg2TXdYVUxaQlN2RktEUDJudXZaTHk5Ylow?=
 =?utf-8?B?aHhJUnV3Q1ZPbHBOMUJ6NytKQUJFY1YzYXg5ZXJ5dUZVMkRmWjFxckM5aU01?=
 =?utf-8?B?d1JmVXpKWEYvcGVhT2NZTEMyRkI4M2k1OXJkYk0xT2IxOXVjc296OVMzVk1p?=
 =?utf-8?B?MFp2eHE0d21qKzJOcFp1MWNHNmVkNDVoV040amhXaDdHWW5HNEhCOG0wLzhL?=
 =?utf-8?B?Q3dUaWhxeHE0TXJiVkJyYjBnL2l0c3U5a2dlVjV4cUJ0WitLaXNoWGZaSDBv?=
 =?utf-8?B?NWwrT0tWNkQ2QnIvWHA0c05ad3M1K2pBc1kxenRjaTV5ZnRjbW1aSjRjcGRU?=
 =?utf-8?B?Mzg4OXZWa3NYUmRqSkpUSlJMVUlkSWloN2U2dXdObjR4TG5JanFCckt1dk0w?=
 =?utf-8?B?OVpkZDdCZnhpRkdidmRTMm9FUm5ENWxMYTJUYTdOMGs2QXlCbEd2QWdNZWd0?=
 =?utf-8?B?dkVwNk14WE91VGZLVFlIcnVNd2RqbnQvTGorTXlvZWlnVU5iMDM1Z3gxcXd3?=
 =?utf-8?B?NUlHckZHNVZlRFZhVlF0Q2xrVXk4bmJDQWtybU5QT0w5QnkxUStJNnZsRloy?=
 =?utf-8?B?YWEzYURrcXZYbWE1TnVQZ3NEVXRHZ1FmR2tiNkEreVVxcEt6YUg0U0NpV1NV?=
 =?utf-8?B?cFJTTG44eW1JcWhBTFNtK0tDbkdMWVY4RnFteFpndXloOHZ3L0FrSkt5RE5P?=
 =?utf-8?B?R1FEY1JVMFdEdDNwYVB4R28weHo5SEo2bmorSitPQk8zS3hkaVduUzNNNXQ0?=
 =?utf-8?B?SG03eU1uN2VrNTlOV2wrajJqc0JEOURzOTJqam91SXFaangwQXBwREo2MUsy?=
 =?utf-8?B?cXcwYXRDblJCdDlrOWQrYUtNRWVHYyswYXlzblBQR1cvUUJoMWFXZ0k2Z1l1?=
 =?utf-8?B?V2hjaHlEcDVEUHRrZzR1UnFFVFkwSkY4YnJYRHphQ1R4YkQ0THRyK1BwWTJ0?=
 =?utf-8?B?RWxNL3NpSjE3eHMzQy9qb2NxRGh6YmlmWUc4TUhoTkpSN0liSHIrWWVuVDkr?=
 =?utf-8?B?bG1EckJKK2hiZ3ZQcVJUT3R1ZzFCS0syeGNEbUo5TTVORVE2bDRoaDU3UFlI?=
 =?utf-8?B?bUYxVnAzRG5SZDdmcWRTVEkrSlhjQ2kwYS9DcXNwR0ZsMEd0bmN5S1hzNTlK?=
 =?utf-8?B?QUJucmN3ZmR4RFBnOVhzTGVIdlFHdEtING85RW9MOXNZOFRDTlVMamJjSi9s?=
 =?utf-8?B?QldvMzIzaDhFWDMrMk5zcTNsdWZBRWhOVjNSeFY1cWpSbUVxLzRXbkhFdDli?=
 =?utf-8?B?OWtOMDVCUFU3YS9QbXR1QmxVM2g4aEpxRUVYK3QrdUtQaE9WVjJmaXlJZm9l?=
 =?utf-8?B?R0FyNjlycVN2L2s3a3ZoNGt3MFJhdmtSdXZQTDFtNE9TbzZ5Y0lheEMzZE1v?=
 =?utf-8?B?cDhTelhxSkdBSTFYMTRZYjlqUE93VytZaUVQK3l6MEREaG9ERnl5b0hGcEk3?=
 =?utf-8?B?dEs1MTcrTHMxaWJvMlRpM2d6UGg2czVqeHdHTm9yR1hOUUNTRUpxd1ZkSEpa?=
 =?utf-8?B?Z29UMzlYSzdMNVdITDV6ZnpEbkY4ZzRyOE9nNThIaVlFeUFYR1RmMEFqeGd5?=
 =?utf-8?B?Q20xdjlreGZlZlRpNHBQYlFkWG51UGM4UjFYWUlwVzdQOHBSR2YzQ3plRWZn?=
 =?utf-8?B?UVJLOUFvRmRpRjQ3VW41WnRhT0Y2YUdNd2dYc1RCaXBSUUIxNFZTQkJibWNS?=
 =?utf-8?B?ekpFN05Eb0JMWmg3VGs4cW4ydVVtamh4WkRBWmIwcnAzZkFSMGdGdkYyMnow?=
 =?utf-8?B?Y29JZkhodmlOdVlDZzJ2eVM2S0xKY01MY3Fmek5RaGJqWVcrM245QTU5dUc2?=
 =?utf-8?B?bUIyQjNMbVhFVkI2RVNaY01WdkRKeFlBR1ZHSmtaZ0FCQXdha1lmZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202b517-0a3c-43b1-543d-08df1dfcba52
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:39:00.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxSOYcGgs2z/P8LR3M/1bZSi3bnEwO0u8Vdrbd0omkFQADuO0PO5m0uuUY5ixhwJPF/mlVRbsULVhpk0iud3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2026 07:39:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24372

On 28.09.26 15:39, Sercan Sari wrote:
> The TPM dictionary-attack (DA) lockout counter increments on unclean
> shutdowns and failed unlock attempts, and eventually locks the TPM.
> Its trajectory cannot be observed from the running system without
> querying the TPM again.
> 
> Emit the DA counters (lockoutCounter, maxAuthFail, lockoutInterval,
> inLockout) as a single 'tpm-da:' key=value line to /dev/kmsg after each
> unlock attempt, so a rootfs service can track them via journald without
> touching the TPM. The metric is emitted on both the success and the
> failure path, so a lockout is still reported before the hook panics. A
> multi-partition device emits the line once per unlocked partition; the
> values are identical, as the DA state is global.
> 

Do we really need the output, including redundant ones, in all success
paths? Why not limit it to the less common case the lockout counter is
non-zero? And please de-duplicate outputs for the same TPM device.

> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.script     |  2 ++
>  .../files/encrypt_partition.systemd.script    |  2 ++
>  .../initramfs-crypt-hook/files/tpm2_functions | 23 +++++++++++++++++++
>  .../files/tpm2_functions.buster               |  5 ++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index ceeacd1..e473dfb 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -16,8 +16,10 @@ open_tpm2_partition() {
>  	tpm_device="$3"
>  	if ! TPM2TOOLS_TCTI="device:$tpm_device" usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>  		 -d "$partition_device"; then
> +		tpm2_report_da_metric
>  		panic "Can't decrypt '$partition_device' !"
>  	fi
> +	tpm2_report_da_metric
>  }
>  
>  enroll_tpm2_token() {
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 94346a8..40eeb4d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -15,8 +15,10 @@ open_tpm2_partition() {
>  	tpm_device="$3"
>  	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
>  		 "$partition_device" - tpm2-device="$tpm_device"; then
> +		tpm2_report_da_metric
>  		panic "Can't decrypt '$partition_device' !"
>  	fi
> +	tpm2_report_da_metric
>  }
>  
>  enroll_tpm2_token() {
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> index 1c6bbff..20ece43 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> @@ -65,3 +65,26 @@ tpm2_key_get() {
>  tpm2_key_del() {
>  	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
>  }
> +
> +# Extract a TPM2_PT_<name> property value from "$da"

Please make $da a parameter, not a global variable.

> +tpm2_da_prop() {
> +	echo "$da" | awk -v k="TPM2_PT_$1:" '
> +		$1 == k { if (NF > 1) { print $NF; exit } f = 1; next }
> +		f && /0x/ { print $NF; exit }'
> +}
> +
> +# Read the dictionary-attack counters into globals.
> +tpm2_read_da() {
> +	da="$(tpm2_getcap -T "device:${tpm_device}" properties-variable 2>/dev/null)"
> +	da_counter="$(tpm2_da_prop LOCKOUT_COUNTER)"
> +	da_maxfail="$(tpm2_da_prop MAX_AUTH_FAIL)"
> +	da_interval="$(tpm2_da_prop LOCKOUT_INTERVAL)"
> +	da_inlockout="$(echo "$da" | sed -n 's/.*inLockout:[[:space:]]*\([0-9]\).*/\1/p')"
> +}

This can be folded into the caller.

> +
> +# Emit the DA counters to the kernel log so a rootfs service can track them.
> +tpm2_report_da_metric() {
> +	tpm2_read_da
> +	echo "tpm-da: counter=${da_counter:-?} maxfail=${da_maxfail:-?} interval=${da_interval:-?} inlockout=${da_inlockout:-?}" \
> +		> /dev/kmsg 2>/dev/null || true
> +}
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
> index 453ba97..09338ef 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
> @@ -22,3 +22,8 @@ tpm2_key_get() {
>  
>  tpm2_key_del() {
>  }
> +
> +# tpm2_getcap is not in the buster initramfs, so no DA metric is emitted.
> +tpm2_report_da_metric() {
> +	:
> +}

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

