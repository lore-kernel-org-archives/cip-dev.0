Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3792CC44536
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 14:33:49 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1412.1784730823502642800
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 07:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A7XnE/Tj;
 spf=pass (domain: siemens.com, ip: 52.101.72.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkCwh4VMTL6ZPOtO1HJn5sKc5t06sKeS4ke0rwAPiObmXGmtLIE0krpSrdTzG0rQoTV1LSd56cF9/Ojc+St5KHwGXvaA/EIlsVIWgV2wbWgaAGvc/AEpdXsHs70S3WbG8uSPQB6zWhqWiNBmzgpmC5oZg+DK9JxsyqqJnF1ufgCb4D2XE97jmB+zkqWs2TsJdkXMLDDS8/ScxC8lWGAcYK+qc2IZS2PZvr1xx8vBJiRb9aqN5o5bhqHrAXrQoqZr/8zTc9UaGOBRh+mY7ZgcV9yBElCiXCr3jcsf8rVqSLZ5Jb9VbrYCKRSYTxKHkVhYlYL7pw5hJX855cjUSPVRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB3inHNCNbu4XzD6xfTSJQbH6BVRpZkpE3gpX3vtZd8=;
 b=tXK7gHrUvMn6t/E1Q2QaO5rBr0r3zcxRG07G2uD0vU9NkPdngm/tcjIQJ6o3WjjoDakQ945s0Szt/9PAMQeqo9zaUYSR4f3J/OxLT3hIH5vH3oXk9dBQ/Lyotqt169c3RzXyZlGHCiU26NI0Kafx7QsUb0YWAuRmL6OyT1yZUhjv+w8TeywOyD/BVo590bvaJ1mD3jrlMmlVaFcRS2XLpZJ/droWF7YIpuXnHm5EK1aM18aG7sm3Fzm0jH8YJtkukHxa6mWCriPFKQ+u2PtfakFSiXbIiu/b2S/rqFAVm5gmh4NlBvOzh18HDkP9w0KxdN+ufeTho7Xr9xJGQ71yGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB3inHNCNbu4XzD6xfTSJQbH6BVRpZkpE3gpX3vtZd8=;
 b=A7XnE/TjRoIRi5CMm7zAWbDxb6eTqTEsMcqfvyk6IznTRYBQXHRiGDNjnLbm/Cz7ZlVZbpLEw0Jr4AlO4nceY4tDDJd8ppXVfBbzsu8vysd8rZMVi1CNQ0VsQV8HZU4Yd52D67Uey0N5/URB4B0Zz3LMA33k7TlS9z268S56iRlva2J0KXhL4NujC9b4dvS4lGvlF+k7mn+R21MLc6NzVLItHE4yWV3kcsTSZbzJttlp+YcllUcGocWsQFCXh2U0qMskeYZrSL2iYmYSAL6fAZ478lT4zPGcUsA5nXL1lU228UQPkZcF7Or2f5jeNdJP7URGLlum/U4dx7iiCGAoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:329::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:33:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:33:37 +0000
Message-ID: <4103dca4-9686-467a-ba75-b708b3eaf576@siemens.com>
Date: Wed, 22 Jul 2026 16:33:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/3] initramfs-crypt-hook:
 suppress stderr log from cryptsetup
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260716130816.1095792-2-Quirin.Gylstorff@siemens.com>
 <20260717074650.1281229-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260717074650.1281229-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7de169-ed1d-46aa-ff71-08dee7fe3794
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	snBFUwOtOs1ZchxcfOuihtA8KAafksPKA5kmpMAqxX6dXSizjyE6pcFUR33DJlifM6OC2hZuGcZFqrUj9BDQjByuk1oYlBmw6VwOsCySMIlGOTGErC8DQfoLUs1hBZykVpOXm1phuxrdqskALwzfYlk8IYnO5kEIHbywd9M425BsLKx3fwKcI3KRrP25Fkd4OK/BFnecnQyeWDAEvTDm17Ru3UgoDWq8RBM3FIcGCzB/Zjg0f/LPmaA6avok9dbcojIEsTivUcdB1KfPnMxoGiE7OjkkcY2FImuZH+emMGKJVfx7jolhcWcsbn56MKkVp9HuVRQeCmqFVV+ME3t0jnGEHFStVLIKI3Nog83QeCgNqNvSD8IyPtr32wEU73A/6iOJJ3DNtJGlLBlThSs+lSNpRSbPkbYaWjFIcWgn1fYlJYjuq5T0lV+p+FRxBgegrNHw//vZCTRWXHV19bb7Np7cGvYkowZQw8bXDHjwa0gDrJ0szi99LEVCfX0Vjyrj54T2aFz586pGl0zFOc52SiFhUOidMM3Obs+0YGpjzotbppk8Uw+AGSwsmDnbu6krPGxDcYk0DdqLNn34hqQZJ8z7R5MQbZnWpLkIn+Dd82ZZryg4bFYFZ24htk2LwVTSk3fXihf+SsfNG5OrkL/yTHkVBKk7GvhYs2cdNHfA6P0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVJINU1JKzV6RDJVWW1vQ0ZjWEJiSWd1a2RNSlduODdYNkxJZ3pLUDRucVl0?=
 =?utf-8?B?TkRpZHdYNmxuY2RPMFFmaE5lZnFKTHFtT1lvNWZEekluS2dLbWFyQ2Frem9S?=
 =?utf-8?B?WG5Rd1B3T1F4Zjhta29SeHNiMjRVcW9LVzh0c3pzSzlRZkh6OTcwTTY0QlBT?=
 =?utf-8?B?WndzUmlRc3VXR0NrVzF0dUhsbGtJOGJDRlhOYmo1ZHAyaG9kQmVyOS9NNkw5?=
 =?utf-8?B?aEFHWTF1Vnd6NXNpS2FKdGJReDUrTkV3TDljRDN4ZThuZDBqMjI4MUhwclBP?=
 =?utf-8?B?WmFrd00rVUZMYStKWHU0b1h2dFBRNW4wOEhZa1loVm50UXp2N20wTmc5M0Fk?=
 =?utf-8?B?eGhwN29maW85bkE2MzFNNXovRFpvcGUrRWIwa0JwcEN5KzFjak9ucXhNS203?=
 =?utf-8?B?czZBWFRoaXdVS2pmeW1QemE3TDMxOVJOcEZWT3o3WnZFUkR1VlNxR1pnVGNX?=
 =?utf-8?B?M2lKOEtaS1Bac0VOaEhtYTNGVEg5TDJQaklBL3dwaE9XRU95QXhhU1JqME11?=
 =?utf-8?B?NGlEY2MxSnc2Q1NuUnNIWEdiRlVhTStzTzZ2QmNOa0FBS2l1clF5N2p3R3g5?=
 =?utf-8?B?Vnd5aWt3ZENXNFlXV29SQlVvcnlSNVFaMThNSDBOREtQWStjVUJBMGtISC9z?=
 =?utf-8?B?YzhGNFlJbHExdE1PS3p1S2o4WFZLRTlENFp6TmZUS1psL3pUSlZCU2VhYWpu?=
 =?utf-8?B?eW5DeU9LQW1xOVpKbWowS25IMldGQkRDV0RNYmxiNi80VTJpYjZMOUhOME04?=
 =?utf-8?B?Q1pHNG15dlVacFFCWXo2Q01xb3IrYjhFcFpVSHJNbmtJKzNFYkw3NGNLNnNj?=
 =?utf-8?B?TVk1aDlzL0sxcU1najU5T2xaWHpMU2ZnRTlwbEhqMEl6N1U2dU4zcWM5WGJy?=
 =?utf-8?B?SGRIY2ZoZUp5WStFeFg0VVlVaTBuVGR5T1g5OUlOOTc4SmNocFUwemNDcTAx?=
 =?utf-8?B?eUJ6dHI1SVNWYkJSZXFCVkVVbkt1TUVka2FwQ1lMVENuMXhJZlVOTlFNRk5O?=
 =?utf-8?B?dUJNRlJrNUl0cHN4dzZGSnhhdmZmYnRNcGczVjlvQ1pRbVRudEY1M3V6ZC9L?=
 =?utf-8?B?SHJieUY3MFFYOVVSY2hOeGVIaEp5WEUxQWRBa1ZBdEplWEs0SEh6MFFRK2J6?=
 =?utf-8?B?NDNMQnR5ZnJRck9Oc05rZ21mSnZkNzJ3NHd4V21MSE81Zm1HT3M2L1d0QXRF?=
 =?utf-8?B?ZVRyT3Y2VjN6c0t4dS81K3pyMUUwUlNUVnk1U1Q3QWtPdnN3cS9NT0NKYW5L?=
 =?utf-8?B?a2hocDdCcWY4TFlTT1hiMW1DYkNBcEFYRUNWcGZVRURsR3dBc1FXY1dIdnd1?=
 =?utf-8?B?NEk2L3hjbjZFSStpdDAvSDBITHk4alNxU2NlTkhZbDFkYzk4a3ZQOFgvYnVM?=
 =?utf-8?B?bm53M1pjeFhQc1o2YWt0ZHE2WHF2enFhOUZ0UHdXN0RGMkZjdjJSRXFGbllz?=
 =?utf-8?B?K1RHUUNVWWd3MThZQVVJSGFTb1EydkZKM241amU3WS9aZlZWSVJ5SjArVmRi?=
 =?utf-8?B?OFlqRS8renZVVWxDUXJjU2VGbEk5dEwrc2d4MFVFRzkwUW96dVdmV3dWazVY?=
 =?utf-8?B?ZEdKL0NBZ1Z4dGZvMTI4MTBxb2Z4cHZqVERhOXBSdXdBems0UmZQMndQbFla?=
 =?utf-8?B?RXhUdUdHV2JtOGY3cnZwZVZjM3AybmtISlEvbjRnU2JjSy9pTHdlUkxkTmZY?=
 =?utf-8?B?c2FUMEJZUHVzZUFvYXVjL2RxdU1ua080RjRYVmhZb3VpRyszNzhGakhuOUtP?=
 =?utf-8?B?VVRCeDRxUjl1VEE0bDhlNzBDbktuaXByQllYMjI0Z3pZcTJ3SElQd3I3L0Zl?=
 =?utf-8?B?K3BEZDl1TDRtUkZLbENFTG4xdHpUV1BEVVlUazdpV1ZMQjg3eWJXejJ6emJP?=
 =?utf-8?B?TENYenZVVGw1TG8xSXFMbGNMOWFxcnNsR0NPd2tjRjdjamhwRGhIZGtueXo0?=
 =?utf-8?B?MnN5MkxmSXFwZnlKRXlsOWhTZTJ5aE1wcnFlclZmQUpBMEdsWklCMWl3MG1m?=
 =?utf-8?B?UU1lWGRWcnUrRy95Z3dLZk5KM1ZuY1g4bkZiMHZEelRZbk85cmVNeEk0ZmM1?=
 =?utf-8?B?NmVhNDdCbSsvSXlMb09lbEFwdnRhenY0NXd6QnZubHVmb1V1SWpteWpaNCtM?=
 =?utf-8?B?QVhFdzRaVlNNQ2t2VGk4bXh3UXRTaU9wVHFyN2hRdFIwbG94R3h6MGJ6YnBq?=
 =?utf-8?B?NkxKTjVTbjlEU1dIU0JUbU0welJjNkxOVHFTb1NkWGgxQjl6eCtFNWRzK0dF?=
 =?utf-8?B?SFNUSENyOEpNZWg2Z0Zsc2UxblRqV3VwenlvejZqQ1FJZXQ3WUZzTnN2NE0y?=
 =?utf-8?B?WWJJQ2V0S0pVOVAvRU85d2F2R1FSZFI0d1A0ZTlhdWl6ZXdPN0dOUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7de169-ed1d-46aa-ff71-08dee7fe3794
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:33:37.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn2Nv1TUcCFYciI6VW3OFMWRkqcB1HjpihFvDcQIJ/AZRs920GTJWFsRDLybmHK70wNeOKfuEeZ0V5e5bpCfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 14:33:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23713

On 17.07.26 09:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> LuksDump prints additional information to stderr on Debian Sid,
> this information is not necessary for the grep command. Suppress
> the messages to avoid cluttering the boot log.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>     - Added other calls of luksDump. These are only visible if the
>       image is started a second time
>  .../initramfs-crypt-hook/files/local-bottom-complete      | 2 +-
>  .../initramfs-crypt-hook/files/local-top-complete         | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> index 120ac29..0821566 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> @@ -75,7 +75,7 @@ for partition_set in $partition_sets; do
>  		continue
>  	fi
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
> -			| grep -q "luks2"; then
> +			2>/dev/null | grep -q "luks2" ; then
>  		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
>  	else
>  		mount_partition "$part_device" "$rootmnt""$partition_mountpoint"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 397b315..58f82db 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -124,7 +124,7 @@ reencrypt_existing_partition() {
>  	luks)
>  		# Check if reencrypt was aborted
>  		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
> -				| grep -q "online-reencrypt-v2"; then
> +				2>/dev/null | grep -q "online-reencrypt-v2"; then
>  			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>  				panic "cryptsetup repair was not successful"
>  		fi
> @@ -274,7 +274,7 @@ for partition_set in $partition_sets; do
>  	# If partition is already encrypted, decrypt and continue with next partition:
>  	decrypted_part=/dev/mapper/"$crypt_mount_name"
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
> -			| grep -q "systemd-tpm2\|clevis"; then
> +			2>/dev/null | grep -q "systemd-tpm2\|clevis"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  
>  		# check if we are trying to mount root, set ROOT to decrypted partition:
> @@ -287,7 +287,7 @@ for partition_set in $partition_sets; do
>  
>  	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
> -			| grep -q "online-reencrypt-v2"; then
> +		2>/dev/null | grep -q "online-reencrypt-v2"; then
>  		partition_format="reencrypt"
>  	fi
>  
> @@ -337,7 +337,7 @@ for partition_set in $partition_sets; do
>  			# header, but no TPM2 token
>  			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero || \
>  				( [ "$(get_fstype "${part_device}")" = "luks" ] && \
> -				! ( /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" |
> +				! ( /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" 2>/dev/null |
>  					grep -q "systemd-tpm2\|clevis" ) )
>  			then
>  				log_begin_msg "Encryption of ${part_device}"

Thanks, all 3 applied. This one, I wrapped a bit differently, though,
keeping the second line untouched.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

