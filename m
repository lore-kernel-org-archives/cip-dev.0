Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E4FEB64DA
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 09:11:19 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.63])
 by mx.groups.io with SMTP id smtpd.web11.35383.1688980269163654464
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 02:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kNjCi8W7;
 spf=pass (domain: siemens.com, ip: 40.107.249.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjahjnMmC1xo0j5Z7bI44OpLMk7av7M14/fYAqAagWm+hlVeGFC4P5Jtz6kdYSZMStzyXboDhwbOwgTr+wAgTkStjrwneqgr3LX9L/hEjOLQArlsee0lQv/Fx+qVtnEvT3dZecC3nObdBcWVwwmcse9hx0PlvhUF9hf9UphCih16x3ct7hmvMJDBJf89h2AdzhKNz0QioD6KHnoQfhaLEBNDFkcE/NbzPmY4ULm6Gi9NqkPYt0Fw3Cw/DGv1FIzTeTS33d2oZY6JdNybsCMyrAYoTst8m+UMu7/LQDA93ihjj5kIQyrmNLj12rrBWa4P8aOAeqJG+Irp7aY4qBYGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2VrjLIVdg0EZ8mHLz7YnEW3SJK2Ce2avWahsi6UU80=;
 b=YEFHA7mNiG33hmNiX0deI8Tmowig7yhiDvwGK/oHu1TxMKMOokSqv+Bi26dCBFYxO+GFbYxpQkoqlaizexwstn/do1EFdIvoPYUW33QcTFuxY0+aEvIX2BOpC+5vJSXjFe36lldLYdSFmff0StbaKmkZcaKISNa1i0Por8nmd3jIGNwXFmiKVaWU3A8AWrA31DNupfMCoimKcsFHFP/juJAtob48HKpzZ04tMKBQMWaiUHhyF8qs7B6+5TeeYuQMSirBteeQms5K1AvCFBsu/AGaBAtabAx89iU4UUt+B+U+M1EQXL4pcTZYslEDntEUERGJpjdfKv7T86pPkbCOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2VrjLIVdg0EZ8mHLz7YnEW3SJK2Ce2avWahsi6UU80=;
 b=kNjCi8W7qWz0i4k01YcTeNtZnbYaXFCj1JUagyns83+/LqnzLfsHOr6PtGwsIVHe3kl1Q97K8qM/fllz6b5K8V9XIqaKEs8Qpv7O4JwhtzJn5ZgKYaydBHRQl9mk+h+AEI858OEJPBjOrHrMIhezRqWeWExfaFBsjZeOv0kIU7f0MpxeNKid7h5HOSr921pTaFxguepwqh+VXzL5u2dvoe+inF9TTwqGx/s+l7nb2ifpsr2UTtmgJFTXasqxKPD6/MvZLRb/C7D+uoP4hwUM2cHKVgP47JWxn80Nb3MLQ7Z1nTzd8K271hWY99y5Gj3JcgTmTWUrmEdhm33/qq1uTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Mon, 10 Jul
 2023 09:11:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:11:06 +0000
Message-ID: <b6ce4543-aa13-f5dd-8ad3-651b6a7027ee@siemens.com>
Date: Mon, 10 Jul 2023 11:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/3] initramfs-crypt-hook: Service watchdog
 while setting up the crypto partitions
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <cover.1688630668.git.jan.kiszka@siemens.com>
 <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
Content-Language: en-US, de-DE
In-Reply-To: <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 52db31cf-6438-44db-a2ac-08db81259780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kPJcDdQlqfE20KqnDRvpJHZmRtL+1CrByDPWzVKevYjrpDAtGS5PNpoL/0bcQXeOb0CrBuxW4Q4bfxcIeWJWc3W6my5shAWSghjWEWpacYiPSJbj6Q0M0fxACN/HmO0j6ULfXEXJjI4v2qQ20zi0iUjsKesQ0hufWbCjZTxQ7vtJgdrAJvtQmJt6nyodPQWNBqJOMsEke3vcWk7N7xJUSMawJD7boABfIJvrn5KB9wSlTBk6HwL1NkSo8z+zIzQ3v2BoF4Ps64RvSwVivSKtOe8ZhhqXr1suSOLElIjGTCbzOh92ON1QgQg9ijeNszUrTIWCYMfDV7/DcTopK4cGX2SaKqDG2J/X4oMZ9xguG9ZsOcMG5AwnrvZz0qn2j3vzJjXucUs+kQtsB/RqpxvPbOIhHisbuc7Frsy9ZnoEqCHt6DlTgKMFInnQBM63dIFw4zF6wSCOKT8AJarY3D4VV0j2iPQ0OTJSzY5po50aRTh0L9Z06PKFm7yMUNiV5AdrsmG6W6ZEOdzMQaWKczImzIhjFcaEv8LXmhyeEqrK3D/r5wETghKF591y5hVWUpFBuf7UyjqoaP9rdNHm8j9NkXyGx4srFYKx1TOKE9QLT5gQM5qyLPE7MZ9HHCpaNhecn7MW8u+scDcJpT29vtCBbw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6666004)(6486002)(478600001)(6506007)(26005)(53546011)(186003)(6512007)(66946007)(2906002)(66476007)(41300700001)(316002)(5660300002)(66556008)(8936002)(8676002)(38100700002)(82960400001)(2616005)(86362001)(31696002)(36756003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkFsRzg4R21yWHNld2Y0SXZ6dXdqUEtycVl5cWY1dGtTZDUrWGc4Y1lyTDUw?=
 =?utf-8?B?YW51OGRCaDdUQkNHL1VNNmdTVkI2T0ZBUkZtSFpaZTRnL0Z3Vjc3VDA1V09s?=
 =?utf-8?B?VndMZkJVbDFXUDJKQWpqNXk2N0VpUmd3VE9kckVpRmpYV2ptWVF5Tzh2eTdE?=
 =?utf-8?B?NFdqQXJsbVQ2MXgyNW9BbURXalFtUjNwdWxXL1JaakFWZXgxNXpxTEQ1RlpD?=
 =?utf-8?B?eTZ0U2xNNUNBek43MDIrYVgxRTZEWS9XdGRSYlpFUWY1UDNSdE1NQysyWFV3?=
 =?utf-8?B?UnJNR1FBY1FCNGxhazNCYlNSdktlQ2NOQTMrc3N2ZHFEb0J2NVdPSzRSMHJk?=
 =?utf-8?B?Y1N6VmMxVVMxTWJtYmx6cGJ2S3hyTkhSb3BOOTZBRHlzTHAzdkI1YVBqNVJ4?=
 =?utf-8?B?L01EeFMvUU5LM3FObWRlM0R6Mi9wQi9mSGI0bjJlRWN2WHBFaDhpdXNhSDFn?=
 =?utf-8?B?aUZTYTNMWmJkSE1GR1RaQUhvaHAwUHlDY1dOUG01YzBrZTRJZWs2VTl6dmhk?=
 =?utf-8?B?a0JkVDlzeUk5MVpIb1BvQTdNVW04bnZ4WXREVDdSWjRPYWc2S1Y2ME16RC8z?=
 =?utf-8?B?WVdFTjJ4dytTSkN0M0lDYlhqRWRCUEltT3dXVTllZko2b3czR0hKS1lPcHRU?=
 =?utf-8?B?VGcwUFYyMXNuTDg2dEh2cDgrM0t6N2RLcmZWQ0p5K0dCMlVKUExrajR0VjYz?=
 =?utf-8?B?aWMySkptMjdwWmV3TFFzcGxqVDI1dUZEOHVpMGxob3d5OWVMSk9VMnlhYmY3?=
 =?utf-8?B?RFAxVHNxcWROOHptWFQ5cHZFUEEvaWJ2YjZ0ZUFLRmNLakpWUEhXYTlpUEJZ?=
 =?utf-8?B?cUwrMkRhRTVaSWVvZkU4M3BzRFhWS2x5TFNucmtOVXFFRXBsUFRsZy9ZVklx?=
 =?utf-8?B?bk9ZbzFKOFB0NmJJU29LOERBMFBCbXNMNjl5VmR3ZXlIK29yRmxkZ0JSaE5n?=
 =?utf-8?B?QTE3d2ViM0twemdwdVU5eU8yYUp5ZjFEY2RBNThrT0FLUTZLRU8vTFNGOXVv?=
 =?utf-8?B?eVRTekZLSjdTUVhyRGJxS09zSTlMQzJRbERRTGt1ZTd4OFFIS21DaWlSTFZn?=
 =?utf-8?B?cUxjZWJRLzFQaUxqRXVwTDFTMW5kQnVyQTlIdXoxRXdmVmxPTHZkbENBTDlX?=
 =?utf-8?B?am9RNm9PZUxRbGFpQ1NWenN1TXp2Q0tLdWVhVWxOby8xMjZLZTJIS0ZoZjNH?=
 =?utf-8?B?K1p0Z1JpTTdjcld2bUVCUFFicXkxaXJCZExhQ0crQjg3bG9pNjhLQzY1MjMx?=
 =?utf-8?B?N1RqL2FOR2VSeVlFa2YrdnB4bDJaS05aZ09vazJOSHRtdVV0SjhSN0RtZS9t?=
 =?utf-8?B?YWY1dkptajNlUjlidFRNMnprRlFRQ2RFSjg1K0JaSE9HZE42Mkh1QUVkeGIz?=
 =?utf-8?B?VnlFTDdZKzc4YXB1RzY3OTNKOHgwbTQ2Sko5c3pwNldDQ1JKbktRVzNtelcr?=
 =?utf-8?B?UHFZVzJQNjVTdWRSTU1sQ0pCZVlWMnZuTEFBNktBaVFmaGFNTUdkY3U5b3Vp?=
 =?utf-8?B?VXQ2dzEwKzVYYkVENlpSMzh0T3AvRlp1a2phei9lWG5VWURLcWxWSGFqMVNX?=
 =?utf-8?B?N3VweitsRDZxK2xCOW9lWlRPNW00N09Pakg0Tk0vZ1VpM2hXOWxRTFUyQU5q?=
 =?utf-8?B?RXk0R1gyS2FrSklzTjYyWUtuUEI2bUljbm5sOXNYV1VTQlBUY0VxcHY2RVpp?=
 =?utf-8?B?TVNtSGZ1WEFSQ2dnRU5sZTRtWm1OVnNDTUZwd2JCNDhLNTVaRFlBSHVoV0Qz?=
 =?utf-8?B?TG1uTC81NWJDeHFWMnRtdlpyekhPZkFKWGRscWtDcHBlTVAzS1RFOFdSWE1x?=
 =?utf-8?B?OHVrcE10dU51eHEzNVFhTWxFWUtzSWxzY1cvaWJVWndSalIycGdEQ2toZTBL?=
 =?utf-8?B?ZmF3eW5rYWUzZTlxaWhScE9USmtzcXBESFJ0V1BBSUVBS1ozWkZsUzRqZE1o?=
 =?utf-8?B?ZWJ3eXk2TElBZExKaHgvRWIwZVk3NmdJUlBOMUxQMHQ2NWhCL3duTHhsNXdU?=
 =?utf-8?B?R0NoQ0R5ajhMdUxocExaYXB5bVpQaGJsTnVjUW4xUUYxNldMRkE4R3ZNSEYr?=
 =?utf-8?B?Rmlka2lxcnpHZGhBamo1Yk9XTmxYNkJTRTFFU0VmS3Fzd3c3MWh2bE40U21k?=
 =?utf-8?B?ZjkzYXFmL1htVXlnSGlFY0xwQjNNemxPMHJNMC9uRkFVSnZ3aFE0NlQvT0hl?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db31cf-6438-44db-a2ac-08db81259780
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:11:06.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHhwGWn82FVJJR+op139Gbga630VhNyxt7m7IGCZXdgHAKuMtcgflWwO35zdQvJDpqp6x2H5CYDqOG33Su7gzQTrEvRvH3jKAZfLP/7si3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 09:11:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12289



On 7/6/23 10:04, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> These operations can take longer than the watchdog timeout normally
> needed for booting Linux up to systemd. Add a background loop to both
> scripts then triggers the watchdog every 10 s, but only up to a
> configurable limit. Also the watchdog device can be configured, though
> the default /dev/watchdog should be fine in almost all cases.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../files/encrypt_partition.clevis.script       | 17 +++++++++++++++++
>   .../files/encrypt_partition.env.tmpl            |  2 ++
>   .../files/encrypt_partition.systemd.hook        |  2 ++
>   .../files/encrypt_partition.systemd.script      | 17 +++++++++++++++++
>   .../initramfs-crypt-hook_0.1.bb                 |  7 ++++++-
>   5 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 9a1c37ba..c38c0e94 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>   	create_file_system_cmd="mke2fs -t ext4"
>   fi
>   
> +service_watchdog() {
> +	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> +		printf '\0'
> +		sleep 10
> +	done > "$WATCHDOG_DEV"
> +}
> +
>   open_tpm2_partition() {
>   	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>   		 -d "$1"; then
> @@ -104,6 +111,12 @@ for partition_set in $partition_sets; do
>   		continue
>   	fi
>   
> +	# service watchdog in the background during lengthy re-encryption
> +	if [ -z "$watchdog_pid" ]; then
> +		service_watchdog &
> +		watchdog_pid=$!
> +	fi
> +
>   	# create random password for initial encryption
>   	# this will be dropped after reboot
>   	tmp_key=/tmp/"$partition_label-lukskey"
> @@ -136,3 +149,7 @@ for partition_set in $partition_sets; do
>   	# afterwards no new keys can be enrolled
>   	cryptsetup -v luksKillSlot -q  "$part_device" 0
>   done
> +
> +if [ -n "$watchdog_pid" ]; then
> +	kill "$watchdog_pid"
> +fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index d04be56c..382fe45f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -1,2 +1,4 @@
>   PARTITIONS="${CRYPT_PARTITIONS}"
>   CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
> +SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
> +WATCHDOG_DEV="${WATCHDOG_DEVICE}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index fa37b57a..08ea631a 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -36,6 +36,8 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>   copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
>   copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>   copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
> +copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
> +copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>   copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>   copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>   copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index eefac4bd..cf513dfe 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>   	create_file_system_cmd="mke2fs -t ext4"
>   fi
>   
> +service_watchdog() {
> +	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> +		printf '\0'
> +		sleep 10
> +	done > "$WATCHDOG_DEV"
> +}
> +
>   open_tpm2_partition() {
>   	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
>   		 "$1" - tpm2-device="$tpm_device"; then
> @@ -111,6 +118,12 @@ for partition_set in $partition_sets; do
>   		continue
>   	fi
>   
> +	# pet watchdog in the background during lengthy re-encryption
> +	if [ -z "$watchdog_pid" ]; then
> +		service_watchdog &
> +		watchdog_pid=$!
> +	fi
> +
>   	# create random password for initial encryption
>   	# this will be dropped after reboot
>   	tmp_key=/tmp/"$partition_label-lukskey"
> @@ -143,3 +156,7 @@ for partition_set in $partition_sets; do
>   	# afterwards no new keys can be enrolled
>   	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
>   done
> +
> +if [ -n "$watchdog_pid" ]; then
> +	kill "$watchdog_pid"
> +fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 997f469d..db65ea40 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -33,8 +33,13 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>   # in a newly formatted LUKS Partition
>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
> +# Timeout for creating / re-encrypting partitions on first boot
> +CRYPT_SETUP_TIMEOUT ??= "600"
> +# Watchdog to service during the initial setup of the crypto partitions
> +WATCHDOG_DEVICE ??= "/dev/watchdog"
Should there a prefix?
>   
> -TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD"
> +TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> +    CRYPT_SETUP_TIMEOUT WATCHDOG_DEVICE"
This indentation looks wrong.
Quirin

>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>   
>   do_install[cleandirs] += " \

