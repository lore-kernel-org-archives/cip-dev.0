Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F958F8FA8C
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 14:58:36 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33352.1776783507038911713
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 07:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aENEeEHG;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7+9VDOmhFqA+3J+LxKnaIjTa/sF1ao+IVsv8C+5e4HYPceanZr56E5/x2Gy1ojo3oDyT84LBMrSgnkVDapQ3ooTIDohHn9fR2YCmMCa9sf6IjzCeBTQ5vRBh18qXhOG2KI3OkEe5qZzZh4rv5NSsVrFGBQqWz7N4Zi0Gd/dC4Dc3NI4oKrR74POyqY5F1U4tLC0suoxAjp8GQNydnAFMbKRXdI7i5QA1FBTWH+QoW0e5mol8XFjb6yRxq959iFKUdkcKAP/OM5wurV8KyqgP5U2EuAifKSb6O9xIpJRqW/AEKsAc4fp4vzXz5nL4SZmwoeHVn3YeqkSRn2eE11euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZahmIqWKb9ysz5rJ91j7DppoLSyVY5NQNoaJ26a5fk=;
 b=EDuV9F0jSVxJpGlGxzWryKZpYkDfsKqD/D1uO5FsDwy9LWrioO5L66Mh4khKbEtVb0qZ3rigAf2sL66V5lkIFqeY4RRIofykwmr+c33nx6QbszQmQVQ4J4tpK+7jV0T+/jI1fzbb81V2+hSUBEqMKCSLrQXgEQ2x6F6taoZErXa5S8dU4GLKbMMfhp3AJBzWb8s+ZZXAvBC7jYgF8cMLmCZg5+UchRoWpp1nIQBm/xaDW3OoZT+KcPRG9h9cGO8i0Gm+8Z37+gBiJKYSEqogp8+26vo0/LqwEHoaafDRs/dvqc8nNR7jw+b79aJh9EGjQs/ef93g9dECgc494zp2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZahmIqWKb9ysz5rJ91j7DppoLSyVY5NQNoaJ26a5fk=;
 b=aENEeEHGaUpbg+ufJhtCePM2W+yXZ7zICO5AqpbBI7Ook57TDw3BX1moPetneowfVbcohQVHYakvN/GLrra8U46Wc/680G3oIz4HgHyP4yYLGrR3oVcjjMeWfphkO/ktftBS8Zmfv65pXOFNpxgK1G/F9vA/cfiwtGq56D5Ctcr1TGog2p1aCI9MJM0B7VJ6GrPPygST6DFOsyNzNcjMh6NmnzIrWb//GWaH3vKxqqPorQ7CPzCEuy5M1jGI4m7DyT6ddDgj3543IsDTEgu6OckLS+QuomYjD5otMs1uc0Rc1lb2+MmJXleKTDt9WDNivhyOcG5Oyj0bbxxaEHtaWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9483.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:323::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 14:58:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 14:58:22 +0000
Message-ID: <81513558-4339-41ee-bfcd-c0a24582455c@siemens.com>
Date: Tue, 21 Apr 2026 16:58:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] encrypt_partition: evict stale TPM2 SRK
 handle before enrollment
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
References: <20260421120550.3746353-1-sari.sercan@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260421120550.3746353-1-sari.sercan@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: f89bfd00-3d85-4ae6-692b-08de9fb66edc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	gXfwYR9MT/HfRQpEQehXbScjNO+urr1gQSdLN8PUXD2f0z1LE4tjK/UFLRNerAOPB7ebTIHrCLjzURMtlhuCsiGkZR4TABH9ghRJCeA//ZDopLnlLrEkazYiI2Ks/fxcW8E1Tv2JG45GeGunfEEmXLg1bkuyMw/GVVdxmGc6LZfi3Ha5QSlB9l3nrWkJbFFYtT3JUFYDNwRYeq42Hll2pwgqpIAfm37BbWERDKT2FvhiyCh+GdyLWpem5IJ4VFpvhWdRjm+SIChyTD6aG6Ujo6DxCUxAad4sGpLN+lBbGHQV3InV1uHK5mUKLkWzcPw2e/pPjfDTFgDdc8RAW+/SDPo3YaFhZ8LnrmU5hqsOoBbV+m1cWphY9I3nR+ZZjNVQZWjju93t8aDps3Oo/NQq8A+Hcj28U/+pZrNqA6c68nw7vt1rYgmrwhvMt2gVZqM2iB2Gk4KfA7eXhKrlZNzMqqStq0EffNajfOLYnNUCuugPIWFGldfPF5BK3BtZUi3SDtKmjgquvq7JIUbA+FkIK+xjzCywxnGyINGwB0mPeoS88btNI/RBh0kxorrh8pOS+q070w7HqDOQi7Litamjq63vSPZzgGiorlMnB4H3UBBipvwWVV/tQFYDRVvyj7lf68m86Z4mBxKURsktFlKv0uUiDT6bBZ1Vi1k+OLH1a4IKZE4KBGb6OBaDMMWIpOTATiNZFONpHxxpQhvfgYUn+IR6uOG/NsxPh3hdDGLYWYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVd0N3lYS3IwK2x3UVc5WTNMOGZrcmdiek9LTHFPSHNSMlRCUDQvSW9LSzRp?=
 =?utf-8?B?QmZvZUc0cjFHZVNDckF5OW1EZWRXbENLdkRGN3pOb0Q2MnRxMHp1cTNhYTBj?=
 =?utf-8?B?TmVpbVliT2dYbERPYWovR1dvbFhaTHZNaitVNXJpUUxnY29mRHNQUGdsKzBK?=
 =?utf-8?B?Ly9PNElFUDlRRFNQalpKYk5VTkE0YzRWbFA3c3NuSFBsM1daM0cwOHdldElR?=
 =?utf-8?B?WGJRT2dZakdiZmdvK2tnUEFBdnZtM1BubzFSWjhNQ0piYVdDWjkrVEZUSCsr?=
 =?utf-8?B?ZGFtSTNTVmJidEh4UGN3UVJyUW1sOTdYWmsyeFc4R3FXaTgySlgraHBzY2RY?=
 =?utf-8?B?YVBkR2lzbFNCcmdOb2NGbTlxUmRHL0Z3QVB3UnJHRVludjgzMHV6OXUrY2hn?=
 =?utf-8?B?SDVmMWFTVm90R2ltSjFUOUcvcDU1VFRNTjMyVnpORjZGUVd3R0pMckl0c0hj?=
 =?utf-8?B?MmMvWmdxek1ZNlhSS2J1NXFVZCtPWmdYR3hSYVdCMDVPczNLS0tUZElFeWZv?=
 =?utf-8?B?VGZEb0JVZzdZWGxadmUrTEdNRUs4c05Fb3FZTlpUVmJldXZJajdjbXZSRUkw?=
 =?utf-8?B?TElMcjN6dS85RnNFcUZST25wZVdtejhVNjBoZ3oreVNnQTBRWFRYc1FnUm16?=
 =?utf-8?B?MFZHclVxenYrSXZEZ3RZV0NTd01uR0gvMVlLZVRzWXI3VHVXTEdTTmN2QmlS?=
 =?utf-8?B?dmRBZmhPZzE5TDk3UlQrUmo5QVVUbFBlcE1ybzBBeTYrMTBVNlFFSGdPck5C?=
 =?utf-8?B?Z01ZaXhhSU9hcVRwRVZJR2tmbGFtU1pSby9BQUw0M3hkVGJueldqUHV6Sk1H?=
 =?utf-8?B?RUVla0FxTHpKQ3RGRy9WSHhVaEFFNCtuelFmaWJsNHVTS2ZvMXFpL09zeTNM?=
 =?utf-8?B?NEYwWFJsZU43Q05Sbm5rVWRPbEU2M1RheWU5WXNlOFNQWURVRFkrWU5BNnNj?=
 =?utf-8?B?WWJINkY3cnhCUnp5VnZKN3djcGVmMzZpV2RWc1FGOVZ6T3E3MTh1MTZzMDU2?=
 =?utf-8?B?NE56bGZ1WWJxanIzZTUwVUFuRzRnVW92L1BGMFVOUDJTOUhFdVpwVWRYZHBF?=
 =?utf-8?B?VVphVit6blRDVjliajF2ZVN3TjFBU0MzeStUc1J0cU5XVytpSi9ucTZIRXli?=
 =?utf-8?B?OHhmQTI2Z21iUUcwMTBjZytZS09JOWRhOUpiTWJCcXIveEU0TWM2ZVROZDJY?=
 =?utf-8?B?RGErb2t0SmVuOUlmWStwZ2taVFo2eldtTXVwbW5rMEdGd3JzRTVGQ0hoZ1RS?=
 =?utf-8?B?dVQvaGg1OEZaMHNrTmRoVXJVeEFRWjlydmdpam95MElnNDJ2NWtWWnhvUkUx?=
 =?utf-8?B?ajkvYU9Wd0YxUFdFSTgxTGdycFBGSHF0M0xGR0FRTHBnTDZueGVSL3ZTaTYw?=
 =?utf-8?B?UmYzVllMR1B0T1UyVE1MNWlJaUE0SnFwVWxYWnJEb1lWQlZ2TVYxVnZQaS9s?=
 =?utf-8?B?cE9SdCtyRm5KanBsNmJNV3Rtb0V5TkgxYmNwSEk2UTNnWjA2cFdEQ0lGWWMw?=
 =?utf-8?B?UW8rYUsvRTh4M29EalJVNE5jTk5IOUR4MHduVjltRTNVTnZPdHNOS2VIN0J6?=
 =?utf-8?B?VXI0clEwSzZhVVJnTGl4MTdMQmRRLytKcXJTRlFEQXNwRzZaQjRJekVkOGZy?=
 =?utf-8?B?ZFBocEFncDZsdEpKcWZvT0JHMWcvM3JwOHIzRGRMcGtNeFVwMTJXYXp3RSt1?=
 =?utf-8?B?NGc3M0JOWVVHQlk3UmFVNlVzUXpTN2lDaHIwTnZvZGRkRTRaL2dpNXVPRUhu?=
 =?utf-8?B?L240TkZxU0hOSEIrMXJaRmNaU2ZpVXNJTHRCWjRPcUJFSE9FNEdpNjJjRmZF?=
 =?utf-8?B?b0tlYmZaT3BaYzd3ckU5VFg4VklLYktGb1VPR1cycmVESGZlWjZIOGxERk93?=
 =?utf-8?B?czFqV29OQ0Nlc29oWS81eDRrbXZnQmlGOWNqWTVEckVseC9VTVdRQ3AzTEp4?=
 =?utf-8?B?RXRDQXFqZ05BUDFBZURDa1AvWXZ3Z2FOd1hlMU1MaEQ0YTV4cHMwYXpCNVJ5?=
 =?utf-8?B?cVZEYXhhMGZSaUtXY3pXM2lyMFgzNXZ1MThHQnlzazZ0RnpkQzhnTmUvSmZs?=
 =?utf-8?B?eHdZTVo3T3F1OGM5UGh4RkwzRU9USVFtNkZrUkNXUWh4dDBabmszazBldGpo?=
 =?utf-8?B?K3Q0d1diY2ZKejlaU2c1MVBDQ2ZrV01IVzZRaDYyZkRHUWVvR3NaMEpwcjd4?=
 =?utf-8?B?RE1lV1h5eFluTlZheFlYdWtuNi84Vis1UWdCWUVXVnJsUEhoWEZaOGhiRXZz?=
 =?utf-8?B?YTIrUzRLWXY0UGdRckJUMEg1aXl2ZWhpWkNMQmJNQ1VWa0xhTmNlbzBkL01S?=
 =?utf-8?B?MmxtS05QNWFCcFd1ajV6STBBcG5TRklab0pmL3hQV0RwK0xqejR4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89bfd00-3d85-4ae6-692b-08de9fb66edc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:58:22.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnsq+WdqdXO6mndbNiOJHfjUD+FWXq6KIDMGBBClh7XW6jbAODfycEkvc3lq/B1md01YYcfNTU1a1whtDvGJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9483
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 14:58:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22778

On 21.04.26 14:05, Sercan Sari wrote:
> Since systemd v254, systemd-cryptenroll persists
> its TPM2 Storage Root Key (SRK) as a persistent handle at 0x81000001.
> Debian 13 (trixie) ships systemd >= v255 and is affected.
> 
> If the disk was re-installed while the TPM retained its state,
> the stale handle causes systemd-cryptenroll to fail with:
> 
>   Failed to seal to TPM2: State not recoverable
> 
> Fix this by checking for the handle via tpm2_getcap and
> evicting it before enrollment.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../files/encrypt_partition.systemd.script               | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 1b7c83b..94346a8 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -26,6 +26,15 @@ enroll_tpm2_token() {
>  	#tpm_key_algorithm="$4"
>  	#pcr_bank_hash_type="$5"
>  
> +	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
> +	# evict any stale handle before enrollment to avoid
> +	# "Failed to seal to TPM2: State not recoverable".
> +	if tpm2_getcap handles-persistent 2>/dev/null | grep -q "0x81000001"; then
> +		if ! tpm2_evictcontrol -C o -c 0x81000001; then
> +			panic "Failed to evict stale TPM2 handle 0x81000001!"
> +		fi
> +	fi
> +
>  	# check systemd version and export password if necessary
>  	if [ -x /usr/bin/systemd-cryptenroll ]; then
>  		systemd_version=$(systemd-cryptenroll --version | \

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

