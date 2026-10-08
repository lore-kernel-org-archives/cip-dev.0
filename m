Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B69FCA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:16:07 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14259.1791461766658387916
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2026 05:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hVcH0ctr;
 spf=pass (domain: siemens.com, ip: 52.101.84.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdIdk94N/X73ykmIX1BeYxBP8zI3XFPrGJsSswRcDyW0yYCxCJD/1w9yLK+T2XEZjCMpXdI595m4V12YESlgWEicLKYVnMynmrEFV2v8hbAHzWyymR1ekD2/RoYqwNQHEMxpFvqT2chJ/tcspmEydudPuWK67KAUYA8OEkVQTlKhwpdjFjFd3zQSD5wXC9nHLbZJUg/bkfHxeIyV8hr9jfv4OkNmrACcrla+QAa7+FhjQXOMK/rappgOXWvxGLz9FC1rt694d8xe6qM51Bf+aj3CtI/XbfB21D4afFU1zpawTdDcKYagl4mvVvp2/0R0hi2BOX1mac/pBlMbAn411w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEzjh9FxL3elbMxpEWqHitEitq0cI0SQKXk0y/ihhHU=;
 b=icw8frWuhSCJP1dt4+NiAio2mwMIR1DcGx5aDY8y5uG1DeyQe0KFuRRWUHqw6AEY47cuPnphhTLfTLLbOMuByfZPPRCttQ8trBaC4Pn9GE0rvdIgxfv8ajExgr2U/4Qcga8ndrV8YPgmEEdyaB0GZLO6wZRxtmQwBIEQ0z9XxwSYu/hPPazOGjkc70bz15OrjBZ7YLGTPxReZbe9BZrLE483AERYQ276kcUqvhVoYMJDc9PRUukOTFLnpgy4ifmfTHVoPS3rV+NZPYUACI9PPm/8RxQAfKBkwUuKO4HSC58NgIqwl5HnfmgsloNga31uaf46WFppaeerYtp9a0nL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEzjh9FxL3elbMxpEWqHitEitq0cI0SQKXk0y/ihhHU=;
 b=hVcH0ctr+mkvRVwDVV2SLcOvOti4GSQ4uYNmwMf0AJEPB2nrM39hI6XoBlGZdWg/3mzcXRYSUWNM4m4hY2tphllkl17H3VJhUHvtST69s6giwzFLVHISUVhgp17YnQcPDC2vGgQwuZHC5YknZPgs4aDbM98uOPhpPo0OBe692UOuElFEsPec1xqVLgV7iTvgmxu9/csRcgMpFr7x1teV2GHCq4pW++QmfLXpPxfoUKj5uG/AyVzFCNS2BEbvItd8nq/TOPSoV7pKF6O1AGCZalqqahwo3Iff5H1ntLD4BlLnnGXJ5rwsXHL4olezuylQwrQVSbiC7i0r9fso9mR8lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB440592.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:3b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 12:16:02 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:16:02 +0000
Message-ID: <c927508d-0448-45e4-ba11-fbd5d6a9db5f@siemens.com>
Date: Thu, 8 Oct 2026 14:16:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initramfs-crypt-hook: emit TPM DA lockout metric
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
References: <20260928133951.3500729-1-sari.sercan@siemens.com>
 <62c6208d-da8b-4069-b8ba-c272c9604b93@siemens.com>
 <20261007120129.Yv9HhVFB9UhVdvxgs8Y4ptKTKotAGBbNjlhj7yCHYaY@z>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261007120129.Yv9HhVFB9UhVdvxgs8Y4ptKTKotAGBbNjlhj7yCHYaY@z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB440592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da65afb-e532-424c-0e11-08df2535eb8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	DTqv69KOP9tpwvePD4YEq1ZZSjdkunAiB5Fm+EMh44PzX0ebJ4PiFfcdlGSVt6LcaOgI3yMao/RSRMd8FoB7tH8PQQuKESNZK+O47p4AZfwwUrbXV/tVBpINyc6OZ2CJNWV/M+2gl9icjpizqtpOx8adsg39cxthiqPdWKQ4nMKmOFBpmDumwKK0IjKXk6S88bc/y8hGAzwyb2RrFl12TUl6NgyvIHANmw5Yhq4Uono+5vHulqhdwgoOGCfbmIZBTP6FD/1TIND4/H3iPhfx2Zc3hD1CwXwtko+UNbxzzJCyOyx6KT6ES8FWGLPnB6tmqiWQY9CJusKokcrBm7/al6ufPbNIGLQYwg7qkrpZBg8Zwztk8eL/w9YnGgPOf2XtI0vwfindlGaG2QGZNOqysyH551dG3ZXCsrzYxQahQx6+w4AR16aKGO7gAoN9Oxn8dqCcuwyxrR0RDF77WhVr7fIK/S13Ge32D/W1SbtAarlv0KjGOaqgOn4SpVg6z/v0BzkGjjQ8U+lzQHQft8oV3lHegYMraf221kq4SEyufB19M11nfDP78rTHvkGKMncTMGAwLEif+TCO8pGh+kSkDM1YZWCYkTb1Gy8eu1lXYEwEtsXt43PP6llym7YeB8P/fU7dGdfse0AlLzwbVkvSCbnSYpoEXenFoXmuEn9QitY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1JqWjVmcUZRS040Ny9valZhTEozeDViTkptWjB6ZnQrSGV3czNXZXhRQzRj?=
 =?utf-8?B?OW4wR0x2R1RpY2ZMODRSMnlOVktKaEhna1VpOUJNREllNlFLamZwcE1kN3Vo?=
 =?utf-8?B?dXhSaTN6Ykc0ek5xQ3BWSVBFam1EUzRrb2hoQVJpS2NnS1dtM2tGM25hWG1W?=
 =?utf-8?B?eU55MTFWUUNHeWJXUmpEaHlEdlRYaUdjSUpPd0dRSU1vZjUrcmprWUhoT1Fn?=
 =?utf-8?B?TGdkWW9wNHUrbkxDcFQ3ZVlMNW1UdXNKSU14Q1JQVEcwTVZSR0J0NDJBdXJn?=
 =?utf-8?B?Vi95cWVFcHVDaktrN0p0RG1ENURJZzdJNnk5blh4bGVGdWI2TElETFdlRS9S?=
 =?utf-8?B?RURlY3NUOC95c3ZJS0RqTm12VjFhUEgwdGpZN3BTOXJXNFN6RHB4c3FyaFh5?=
 =?utf-8?B?YjdGUk9EVlVxSnhBaThndCt2cnFwdHJXZ0xVdGhGSDFONEp5L1RScVNCamFk?=
 =?utf-8?B?aWFDbmF4dkNLSHlZVy9mNncvWE1pT3dlcEU0WTVnRzBlRloxNUMvQWRyUTlv?=
 =?utf-8?B?aEpWL1dpYWo0N2luamw3N3lBKy9BMW1rOUxaa3JzbzVUNm5mTFljdUR6RDFX?=
 =?utf-8?B?K2p0YXV2MjlPbUVQbGdHR1FxQ2Y4aDR4NHZQRmVEaVJSVUxuQ3c4Nk5GUHE0?=
 =?utf-8?B?VitCSUxYTFV6Y3BweXg2ay9idXpnNFlINnBpNmY3SHRmeHBPWDlRVWhYYkdP?=
 =?utf-8?B?aFpsaGtFb09YMmtQc1c2anl3d1NPODdONDRYOWZFUUd0TExkRVVFakJwbmxW?=
 =?utf-8?B?TkFBYUwxUEVyZktSd0g3MzBuU0tKSmRlRW5GNzl6WlBxcVFTTHJIak9MczVR?=
 =?utf-8?B?ZDJmbFdSS29nVWVyekZsSjBhTHU4aWZZZEo1Y1VRbTFZNzJGQ1ZXdHdJSWMy?=
 =?utf-8?B?VDUzaXRMYUdXR1BOSjVaVnVqQlpZWXlRY1ZvN2xLK3FDTW43T3pQTkFFQnhu?=
 =?utf-8?B?bHhiNk9ZNitHak1vcG5taFJzelBTajFXZWRNdTVraDlXZXR3TWl4TysvNDBV?=
 =?utf-8?B?TmFyclljRitYaXMvbDVLQkpwNks2ZDRnVU1peDhhQkY2UTJoaHAvM2hwajlV?=
 =?utf-8?B?UkxmMTEzTkw4SUI2ZjlDc1VwaldqMjJHOENObzh5cmNXQ0IyRWJVd3d0RzFy?=
 =?utf-8?B?elNzSURURHd5NzAzOWd3cVR0SXVjd25xRnZCM25UM1k2ek12N2FTOFppUEts?=
 =?utf-8?B?QTRBUGlzRjdYM3U1TS91c1p3VzdtT1NGc1pibjRabXRmM1dMNzRVdTlWM3Ru?=
 =?utf-8?B?ZXBDOXdVOE53TXRzVStON1o0WU8yVmNZNXZlWi9uRUVvTjhkMjBUTktKanRW?=
 =?utf-8?B?TVc4Y21pbGhZTm8wTE5meFYxWDN5cGxZeEJKbG5aY0xKdG9KZWtPdlNUM3Rv?=
 =?utf-8?B?S2VPUy93YzdkeEo4YnJBOTZNdndmV3p3Y1Z4UzlsWWpBTEtjdU9Pa0poK1NG?=
 =?utf-8?B?QmRmcUVmUExRN0ZlUEdVMUdZY3B3b2dFcTR0bGNROXdHUjUrNVU1a3dSTXR0?=
 =?utf-8?B?TG5JSnRPNUxWbDk2dElDZjZla1lsL0hqbXh6bFplbkpTS0FpRS9pMkgrU1c5?=
 =?utf-8?B?Zy9MNHowcnFPaXhqcTZIbHlxa2pPUDFVdUUrTWJmd3JiT3RWSElVeW9HZmJo?=
 =?utf-8?B?TFdOeDJLQ0F2Mzc4UWJaZTJCUHBWdm4xK3pDenZhaVpiNHVQL3dxc1h0RnU4?=
 =?utf-8?B?Q1pjNVgwVCtCSFc3dURUUjhsSTZQWGRMSzU5SVZmcVkzTG5pRTl2STJTckEy?=
 =?utf-8?B?VkhmTm9DU1BlQTdvQjkxNmJnMkMyczh2RTl2QzJKd3NtSHdKRU9QL0k4QUk1?=
 =?utf-8?B?T3hKSmIzV0dVS1lSWlZ4RDF4TFM5YVdtL2pzNlB4dGxvMys4R0piN2kvaS9D?=
 =?utf-8?B?QXpNQXNoTThFQ200TERHNGt6ckFrZUxZSDVaNGpGTExIOE1rQ1M2VjMrZnpS?=
 =?utf-8?B?bnBLUk5JdWRGMEU2bTJQWjB1a3VMMG5MUFIwSUZ1RHJUa3NRNnZMVkh2emw2?=
 =?utf-8?B?UmJoWjYrd3RydlgzalM4dWRLaDdrTEdFNEZrSmVuL0JuVUlIWVhNd3ZBRXJ6?=
 =?utf-8?B?dlJDTlZBMGd3OHNhdFlBV3pMNkdJZmVIMzJmN1hUeThIQk5XdjFtYkc1aFVD?=
 =?utf-8?B?M2hlVitRUHNNa05tY0k1UEF3S1dKQ0tWTHZzUDAyc0k2TWlHbTZZSTNtbzdF?=
 =?utf-8?B?QmNiNVpING41YUE4aWJNM0NlTG9RWU5uOWx1cGlWbjVpSFJuRkl3bjhpM2Mv?=
 =?utf-8?B?Q2pBWFdqdXpCMHlSNlJrS0pjMGxlZzJnd2RWUm1kQ1NpOVBUNTJjQVFKQ3Jw?=
 =?utf-8?B?ZTNkQlhDTi9sZ3cvVDRNaDZuMUE2NzBmelJXdVJrY2N4ckVaN2RHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da65afb-e532-424c-0e11-08df2535eb8f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:16:02.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyNpeUCCcUpyrgz/5s627kAVvm+x+sYAPGSNC8FHpL9s1NLd9r/wzYZ7xn8TJR18oU7LbzFFcQIRxGSiVx6FwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB440592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2026 12:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24439

On 07.10.26 14:01, Sercan Sari wrote:
> On Tue, Sep 29, 2026 at 10:39 AM, Jan Kiszka wrote:
> 
>     On 28.09.26 15:39, Sercan Sari wrote:
> 
>         The TPM dictionary-attack (DA) lockout counter increments on unclean
>         shutdowns and failed unlock attempts, and eventually locks the TPM.
>         Its trajectory cannot be observed from the running system without
>         querying the TPM again.
> 
>         Emit the DA counters (lockoutCounter, maxAuthFail, lockoutInterval,
>         inLockout) as a single 'tpm-da:' key=value line to /dev/kmsg
>         after each
>         unlock attempt, so a rootfs service can track them via journald
>         without
>         touching the TPM. The metric is emitted on both the success and the
>         failure path, so a lockout is still reported before the hook
>         panics. A
>         multi-partition device emits the line once per unlocked
>         partition; the
>         values are identical, as the DA state is global.
> 
>     Do we really need the output, including redundant ones, in all success
>     paths? Why not limit it to the less common case the lockout counter is
>     non-zero? And please de-duplicate outputs for the same TPM device.
> 
>         Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>         ---
>         .../files/encrypt_partition.clevis.script | 2 ++
>         .../files/encrypt_partition.systemd.script | 2 ++
>         .../initramfs-crypt-hook/files/tpm2_functions | 23 +++++++++++++
>         ++++++
>         .../files/tpm2_functions.buster | 5 ++++
>         4 files changed, 32 insertions(+)
> 
>         diff --git a/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.clevis.script b/recipes-initramfs/initramfs-
>         crypt-hook/files/encrypt_partition.clevis.script
>         index ceeacd1..e473dfb 100644
>         --- a/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.clevis.script
>         +++ b/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.clevis.script
>         @@ -16,8 +16,10 @@ open_tpm2_partition() {
>         tpm_device="$3"
>         if ! TPM2TOOLS_TCTI="device:$tpm_device" usr/bin/clevis luks
>         unlock -n "$crypt_mount_name" \
>         -d "$partition_device"; then
>         + tpm2_report_da_metric
>         panic "Can't decrypt '$partition_device' !"
>         fi
>         + tpm2_report_da_metric
>         }
> 
>         enroll_tpm2_token() {
>         diff --git a/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.systemd.script b/recipes-initramfs/initramfs-
>         crypt-hook/files/encrypt_partition.systemd.script
>         index 94346a8..40eeb4d 100644
>         --- a/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.systemd.script
>         +++ b/recipes-initramfs/initramfs-crypt-hook/files/
>         encrypt_partition.systemd.script
>         @@ -15,8 +15,10 @@ open_tpm2_partition() {
>         tpm_device="$3"
>         if ! /usr/lib/systemd/systemd-cryptsetup attach
>         "$crypt_mount_name" \
>         "$partition_device" - tpm2-device="$tpm_device"; then
>         + tpm2_report_da_metric
>         panic "Can't decrypt '$partition_device' !"
>         fi
>         + tpm2_report_da_metric
>         }
> 
>         enroll_tpm2_token() {
>         diff --git a/recipes-initramfs/initramfs-crypt-hook/files/
>         tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/
>         tpm2_functions
>         index 1c6bbff..20ece43 100644
>         --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>         +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
>         @@ -65,3 +65,26 @@ tpm2_key_get() {
>         tpm2_key_del() {
>         tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
>         }
>         +
>         +# Extract a TPM2_PT_<name> property value from "$da"
> 
>     Please make $da a parameter, not a global variable.
> 
>         +tpm2_da_prop() {
>         + echo "$da" | awk -v k="TPM2_PT_$1:" '
>         + $1 == k { if (NF > 1) { print $NF; exit } f = 1; next }
>         + f && /0x/ { print $NF; exit }'
>         +}
>         +
>         +# Read the dictionary-attack counters into globals.
>         +tpm2_read_da() {
>         + da="$(tpm2_getcap -T "device:${tpm_device}" properties-
>         variable 2>/dev/null)"
>         + da_counter="$(tpm2_da_prop LOCKOUT_COUNTER)"
>         + da_maxfail="$(tpm2_da_prop MAX_AUTH_FAIL)"
>         + da_interval="$(tpm2_da_prop LOCKOUT_INTERVAL)"
>         + da_inlockout="$(echo "$da" | sed -n 's/.*inLockout:
>         [[:space:]]*\([0-9]\).*/\1/p')"
>         +}
> 
>     This can be folded into the caller.
> 
> Thanks, v2 has been sent to address the comments.

Hmm, but I'm not seeing it in my inbox or the public archive...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

