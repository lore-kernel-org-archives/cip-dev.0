Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB38C61DCD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 07:35:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1344.1787902542390273247
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2026 00:35:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J5CqlQbC;
 spf=pass (domain: siemens.com, ip: 52.101.84.61, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX5TrYcwJ0n9NF/TYG/8iPTM/xc+idPF5ClPWDuTOUemG298JYO1ByLo0Txa39yITy5mqg6bug/QJtciwsEbfG2XqcbBqCyzq4jR7KHRGToMzOjS0ZIkk/E2hrGIE5s79cJZWul4tVjN6DmnSOwnrjduy2Q/qNGdYxH/wxEQmNx5zZzKxTE2/7AzlW6HSPxCNQK1DQVfCl4fnkzjbPRiW9gcvxa7HbOWQhypJ71EKsZJVhQ2V21yl4tmVCmfcAn8a4lStQaxN/wTTfnZrI29ck9jgQrqyaoUC9nE9ZttPo7OP5QF3M+a9bSzU2CdE29VPfsHd4KXenyPkpMms+oLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EBwykGGze//avpLXUp7U1gSLjN5378/S0KGVS66qek=;
 b=oksaMZxjIjrkcaMyRPV5mtqz8xvQgLEM2BcFQHcfdsilxuReg4fVSG1VfIM8YRmBep2aSj5V1gSl3iocSG/wo8xGnBeNnGsYgcVr/GmGz3noFapvZppM/PEh0G2Vy7CSuaPHcum+W1Am/NU2IarNUBLxyxX8//ZkqKhA5MUAtPujF9c9SGwVzm8ROi7zy1RXhi2BpPGe7No+BcwUHMOcqc0SHY8/OgXSU3fY4Fm7jcRR1C0vwOmDzQpAH1/f2ZXQucs1Pz8wrwnIg0zHrhzoh26b3HuRFRZzZtml+C0kPODMIqh6039PCgHRQ8rOi4wa56cgEqphfold4Ix+dz1png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EBwykGGze//avpLXUp7U1gSLjN5378/S0KGVS66qek=;
 b=J5CqlQbCRLxfjmKYdFHtQAwXG8ER74XYsfKpVgcZfH3TNo6/Ve2jHs55iGOCb8iIQoes9zxUIcf1mZ/USlUvDAahJx9xB5cBqGWu0IBwzgfGOA3FoRDWKmGEayIJZYCE4ibD3Ri9r5hSgNdZrnGuT5wn9Opf4j8UqlaU802hVXrnv3WVV8WpAGlY0QYMjiXRM6WpL4fx2EPgKczWs9F1kq/jsQeVGbQK6mEgXKiR4DdaMY6ENOJSh6UEjuEgKpKaAPaRyyd6UlwbUDCK1pzk7TKrIiux+jrQwap0iLGFNgKOsOZ0h9oAv3KVcKwxwxo9k4KFJnA6M8uDfGEJKE11xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DB9PR10MB5139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:330::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 07:35:36 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 07:35:36 +0000
Message-ID: <658067cd-ff46-4ea7-b61d-f65aadaf76b8@siemens.com>
Date: Fri, 28 Aug 2026 09:35:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add
 option to clear partition before new fs
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
 <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|DB9PR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ef9586-3174-4e48-cfd0-08df04d6f37c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|22082099003|55112099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	chyi7YssLXTC9YcLmUIoNXLLlIQZfzQ4lUFy6kohshXhD4/diABb7IlDd/3uI0+DHisSohlyVwZlSSHNftskkm0ZVaWAQExEeFOBwLJBb6penxFMkkcRmwq0HE2Ju2AdaKJoMM+vWArZpG1VYW3nhSUk0b9RtUXinKLtYZEhVRpbBdgum0JujLIfN1QwM7uhOf45dh+phCMoYHsQ7Lx/svjZ/rgYmf7tyYYBN6jNp/YxJFurmD/OixNFwybu5mxVJe1DWSTJf/Co3xnZWkzCVQlw91qlqHrwleMkwd+fc5h0ug7KpXc4m6xL+j0xynaXTRcCzI7p24uzBVyE9e5iue1CLRu7k/5ac9kGlGlP5ZXBXqsctLSQiKiWalZZ135iuV8Bj9xjbTak479tq9u7JSLiLAb9muF7lV1vVWqdmCZhk0E8+buqZhHaNfsugvwyE9uhWzxWloWO6N+Z9t+ogVztuVkF+Zy4ObXeT5Xg/4gRSVkZ5lA0x6KQoGuBe1esi8WEQmYLX9jwFzSMwmCogb6syiK9IkeNSdKjF0uwFUGD9InDUtKjP63L1hgrI9lPUto1Gt2zXmHx2ZUOuLQ5UVvopzHuosAyOSvdlNKHdcsWstPRsrq85N/Yz1VuenS31QN5NQGP8M2m8B1ImWGS00yQ3/dknLVE7LvC+991vs0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(22082099003)(55112099003)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlhaOHFwOVJyeXoxYWI1dE85OStpZjB2QWVtRzBzRlhGbEhScGVRdHpBcnRm?=
 =?utf-8?B?eHltdEE3YTk5OWV1VU9WblZMVy9WVElNZE1US2Z2QjlCbUhOMTNxTGpYYVcr?=
 =?utf-8?B?dldnSTROVURIUDFlamlpVlBZSkkybk5jMjI0ckRkK1VNSkNMcDdDbmcwRmov?=
 =?utf-8?B?bGhTSXJFYWk2c1Niek1hdUxSUnRQMm9neUl5VGpkcFJrVms4QUJMRUVqVXpJ?=
 =?utf-8?B?S3hDbEpQa3ZzMHI2UmdaY0hLTFNaZlBqdTVtelJHK1Q1eDhwSHlYR0VCVzdo?=
 =?utf-8?B?Y2RNY2pSNmhMcStkWlcvcUFaRkt5Ynl2R1lHa3Nxc3VucFdJNzB6S0t3ZWg4?=
 =?utf-8?B?TFFDdUFZVkxZMU1RdFdheTBkZ1Jieit3alBacjJDQ0t1STM3eS9meHhKdDdx?=
 =?utf-8?B?V3VEL0tVSTRSZHRxTCtrQ25Qb1E4c0Q0bXl0M1EzSHZDbHdXVjN5TzlyRHRE?=
 =?utf-8?B?eGFGNGZ6bFpnQkFOc3FrQ1JWc0JOY0pzc05zN3g0YnkxdTJ2V2xiWmlGcVBr?=
 =?utf-8?B?NzRaanFValhiNncrZlVZNUNmT1d3QW1tT25uQ0Vab0NNWThmQUs0Q2RJb0Q0?=
 =?utf-8?B?aDdGU1VzUjFWdFl3eFN3bERkZm04NlkwZVFmNXB0OTUzY0NSdGY2R09uQW13?=
 =?utf-8?B?UEkwTFVVQnlYcFh6bFl2OHVNWE1SL2pSa01La1h6bVFUQmgxeXkwQzRCUkRQ?=
 =?utf-8?B?WHVDYmtRS0w0Nk9BcDR2dTBaYncrTmVHd3lXRWJjdHc2Q1lCdzdkMi9XWUc3?=
 =?utf-8?B?ZFFrZGZmVGRCWUhrNUJvSGg2QjUrTkZOVnkxRTNiRUF3YzNNWE41d21CTDVi?=
 =?utf-8?B?RXVGOHdzZDNqL01IMUp1NWxyNkdyQkExNGlnVUk1S2F0NzBSMUdOdVQ2bnB6?=
 =?utf-8?B?VjJxbS9NVTNiYXhrbnpXa1owcC9ObFdXdi8rcmJ5U2tNL3RHcVVLSzhTdGlm?=
 =?utf-8?B?cXVKTEU5VHhBSXRoMzhIZDlXV1lxNnZrNUZNdzJ4aHJwZElKUm9MQVRWOEls?=
 =?utf-8?B?VXhmcTRsNVNzcW9maVA0ZC81TnVLQm5RcVpMSGpwQUpNaTJ6T1gxQ3c4RldN?=
 =?utf-8?B?bWVuZVd1T3JKek04dGd3c0FDV0ZKTUU0SUszNUUzK3doa3NzUllyVWZUTG45?=
 =?utf-8?B?OG9ZNVJTZXFpQ1FGa3llWkVJYkNvcWVuSVo4aGhCRzBNdi9jUmxnOFJIa211?=
 =?utf-8?B?NDFNT09kMVg0QnBrTitwYXA4YXBldzQ1dlBCdVp3QVNMeDlnWGdnbkdlM1Nz?=
 =?utf-8?B?anhUbE9oR0QwdzBpc0N3STM0S1MwS2lOOHhVR2FjN21DdkJ5blE4bGYxU0l3?=
 =?utf-8?B?OEcvdFdBWURhSkgzZnUranBYcExDZC9xSFExQzN0KzIrUFQrZ2ZMMmRkaHRo?=
 =?utf-8?B?TGMxdG5WcHU2OTgrY1M5YTZHTG0xb3NLaHBzV2dDbVdvSk5UTmtwb2VRNXRu?=
 =?utf-8?B?MTRmOW96emZPWjJIcWxTSjB0Zm4rZFlSK1AzQ0xiOEhDV09Zcis2N0dtWWhz?=
 =?utf-8?B?alJ2RWpicUxrWStsNnMyOHhkVml2em02aS92ZkV0aTNoZ3VNNm1qM2JaeVNL?=
 =?utf-8?B?cTg4blFMWm1STXMvZ29zY3ErS3VCbGRERjhLVnRtS1NJR09WUDhrWlM5Tzhr?=
 =?utf-8?B?Z2JEQWd6ckRiY0F3SkkyZzl2d3pzaVhWaFpNN0c1RmI1TmxjaVlUV29oTlAv?=
 =?utf-8?B?ZlM1NUJ2RTJwV1hGU1NEM1Avc3lwL0NIbTRRWVV6SW1jQkdkMk5NZkNONmxL?=
 =?utf-8?B?Mkc1bDhjRFE3UEhFZnFoMzNkaUc5UlpyNnFSUFVPM3NyNVI0S0tybFVlcUxi?=
 =?utf-8?B?RnN2d3IySW55S3hrM21JdDNMRzZ0cUo4bktwWkM3S3NKUnBETFhCYmJnRzNp?=
 =?utf-8?B?MGFIVmViSkEyWERleHhlazdjZVBOc1FxTWh0Tm5WeSt3VEswWHRsWFZhYngz?=
 =?utf-8?B?Z0c0ZjFRWGZ4MnRRVnRQMWJXejBSY3gxelBxNmh6Y0hXN0hLOWhpOWUxWU9W?=
 =?utf-8?B?YmxpMzRJM3F3ZkU3UE9EY3dLckpTZ2J5elZ0UEkvcDlTalB5SGxpSUlIUEJq?=
 =?utf-8?B?Y3FQcmtZQmM5ZVlJQURvYVZTVlp6YnFLU2EzeXFBc0RQb08vVGZRYzZQWHhi?=
 =?utf-8?B?VVJpSm9KbkN3M0NjOExEdUh6R0ZPV3JHcnZjOUZDbkJ5YUovN2d6K2U2WDRL?=
 =?utf-8?B?YWErQTNyNEpUd25FaHlVekJlWXEyNTJlM0hWT1RuM1ppNXhNeFE3d0lNRFhU?=
 =?utf-8?B?akFHOTF3Y3dTVUpPN2dBY0MzcHhZNzV1c2tEVjdsTnp6VXdwUzJRVmw3NEdP?=
 =?utf-8?B?UzY0OExtcW5qU2tWV21BWlZGSWpKMzhESWRKcUJPV3ZrSTd0Yzh4a0tZN01x?=
 =?utf-8?Q?KyFSSWVoxJq+2Q/g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ef9586-3174-4e48-cfd0-08df04d6f37c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:35:36.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heDDXKC1jWuphtHHG1JfbQVpZRTmd7T9GSJSwf/SQDDej2Kla89treP56Wp5nd9xjleyOJRYL7mG9XzquH7sjaZmSvGdfeBkImhunBKOvcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Aug 2026 07:35:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24045



Am 25.08.2026 um 16:57 schrieb Jan Kiszka:
> On 25.08.26 16:37, Quirin Gylstorff wrote:
>> This ensures that the data cannot be accessed after a factory reset.
>> To clear a device, attach `:clear` to the device string in the variable
>> `INITRAMFS_FACTORY_RESET_DEVICES`, for example:
>>
>> ```
>> INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var:clear"
>> ```
> 
> Why this extra control? Why not clear automatically when there is no
> encryption or there is no TPM clearing?

Second, that!

> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../files/factory-reset-script.tmpl           | 69 +++++++++++++++----
>>   .../files/reset-env.tmpl                      |  2 +
>>   ...bb => initramfs-factory-reset-hook_0.4.bb} | 21 +++---
>>   3 files changed, 69 insertions(+), 23 deletions(-)
>>   rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.3.bb => initramfs-factory-reset-hook_0.4.bb} (73%)
>>
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> index 94b5f8b0..8f95d780 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> @@ -2,7 +2,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2025
>> +# Copyright (c) Siemens AG, 2025 - 2026
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -13,11 +13,27 @@
>>   
>>   . /scripts/cip-initramfs-functions
>>   
>> +# entries of INITRAMFS_FACTORY_RESET_DEVICES have the form
>> +# <device>[:clear] - return the device part
>> +target_device_of()
>> +{
>> +    echo "${1%%:*}"
>> +}
>> +
>> +# return the option part of an INITRAMFS_FACTORY_RESET_DEVICES entry
>> +target_option_of()
>> +{
>> +    case "$1" in
>> +        *:*) echo "${1#*:}" ;;
>> +        *) echo "" ;;
>> +    esac
>> +}
>> +
>>   check_partitions()
>>   {
>>       found=0
>>       for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
>> -        if blkid | grep -q "$(basename $partition)"; then
>> +        if blkid | grep -q "$(basename "$(target_device_of "$partition")")"; then
>>               found=$((found + 1))
>>           fi
>>       done
>> @@ -30,23 +46,34 @@ check_partitions()
>>   target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
>>   
>>   wait_30sec_for_condition check_partitions
>> -
> 
> Keep this.
> 
>>   if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>>       log_begin_msg "Factory Reset"
>> +    # service watchdog in the background during lengthy re-encryption
>> +    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>>       for target in ${target_devices}; do
>> -        log_begin_msg "Reset device: $target"
>> -        fs_type=$(get_fstype "${target}")
>> -        case "$target" in
>> +        target_device=$(target_device_of "$target")
>> +        target_option=$(target_option_of "$target")
>> +        case "${target_option}" in
>> +            ""|clear) ;;
>> +            *)
>> +                log_warning_msg "Unknown option '${target_option}' for target '$target_device' - ignored"
>> +                target_option=""
>> +                ;;
>> +        esac
>> +        log_begin_msg "Reset device: $target_device"
>> +        fs_type=$(get_fstype "${target_device}")
>> +        case "$target_device" in
>>               *by-partlabel*)
>> -                label="$(basename "${target}" )"
>> +                label="$(basename "${target_device}" )"
>>                   ;;
>>               *)
>> -                label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
>> +                label=$(blkid --match-tag LABEL "$target_device" | awk -F= '{gsub(/"/,"");print $2}' )
>>                   if [ -z "${label}" ]; then
>> -                    log_warning_msg "Could not find any label  for target '$target'"
>> +                    log_warning_msg "Could not find any label for target '$target_device'"
>>                   fi
>>                   ;;
>>           esac
>> +
>>           if [ "$fs_type" = "luks" ]; then
>>               if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
>>                   # after this the data on the encrypted partition
>> @@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then

tpm2_clear is omitted from the diff output here. But wasn't it more 
robust to put it at the very end (outside the target_devices loop)
>>                   # use a variable from the reset-env to set it
>>                   fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"

Can we derive this from the actual device. Setup up a temp device-mapper 
to resolve the actual fs_type of the device. That way multiple different 
file systems for encrypted partitions are supported as well.

>>               else
>> -                target=$(find /dev/mapper -iname "*$label")
>> -                fs_type=$(get_fstype "${target}")
>> -                echo "luks device detected use $target"
>> +                target_device=$(find /dev/mapper -iname "*$label")
>> +                fs_type=$(get_fstype "${target_device}")
>> +                echo "luks device detected use $target_device"
>>               fi
>>           fi
>> +
>> +        if [ "${target_option}" = "clear" ]; then
>> +            log_begin_msg "Clear device $target_device"
>> +            device_size=$(blockdev --getsz "${target_device}")
>> +            if ! dd if=/dev/zero of="${target_device}" bs=512 \
>> +                    count="${device_size}" conv=fsync; then
>> +                log_warning_msg "Could not clear partition $target_device"
>> +            fi
>> +            log_end_msg "Finished clearing device $target_device"
>> +        fi
>> +
>>           case ${fs_type} in
>>               ext*)
>> -                /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
>> +                /sbin/mke2fs -L "${label}" -F -t ext4 "${target_device}"
>>                   ;;
>>               btrfs)
>> -                /sbin/mkfs.btrfs -L "${label}" --force "${target}"
>> +                /sbin/mkfs.btrfs -L "${label}" --force "${target_device}"
>>                   ;;
>>               *)
>>                   log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
>>                   ;;
>>           esac
>> -        log_end_msg "Reset device: $target"
>> +        log_end_msg "Reset device: $target_device"
>>       done
>>       log_end_msg "Factory Reset"
>>   fi
>> +stop_watchdog
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> index 07e2376a..663b0af0 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> @@ -2,5 +2,7 @@
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
>> +WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>> +SETUP_TIMEOUT="${INITRAMFS_SETUP_TIMEOUT}"
>>   INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
>>   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
>> similarity index 73%
>> rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
>> index 670725b7..c192c38c 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2025
>> +# Copyright (c) Siemens AG, 2025 - 2026
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -15,13 +15,15 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>>   DESCRIPTION = "Delete the content of the given Devices"
>>   
>>   # list of partitions by label
>> -INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
>> +INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var:clear"
>>   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= "0"
>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= "1"
>> +INITRAMFS_SETUP_TIMEOUT ?= "600"

Timeout of disc encryption vs. full disk wipe differ.

Why not allow an individual factory reset override of the watchdog timeout?

e.g.:
```
INITRAMFS_SETUP_TIMEOUT ??= "600"
INITRAMFS_FACTORY_RESET_TIMEOUT ?= "${INITRAMFS_SETUP_TIMEOUT}"
```

Same applies to first patch wrt. `INITRAMFS_CRYPT_SETUP_TIMEOUT`

>>   
>>   # to support factory reset on btrfs, add 'btrfs'
>>   INITRAMFS_FACTORY_RESET_FSTYPES = "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>> +INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
>>   
>>   SRC_URI += " \
>>       file://factory-reset-script.tmpl \
>> @@ -33,17 +35,20 @@ FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('IN
>>   TEMPLATE_FILES += "reset-env.tmpl factory-reset-script.tmpl"
>>   TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>>                      INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
>> -                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>> +                   INITRAMFS_FACTORY_RESET_CLEAR_TPM \
>> +                   INITRAMFS_WATCHDOG_DEVICE \
>> +                   INITRAMFS_SETUP_TIMEOUT "
>>   
>>   RDEPENDS = "factory-reset-helper \
>>               initramfs-cip-functions"
>>   
>>   DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, awk, \
>> -                    factory-reset-helper, findutils, initramfs-cip-functions"
>> +                    factory-reset-helper, findutils, initramfs-cip-functions, \
>> +                    psmisc"
>>   DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
>> -HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename \
>> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename dd \
>>                      mke2fs awk blkid rm get-factory-reset.sh \
>> -                   chattr grep find"
>> +                   chattr grep find blockdev seq fuser"
> 
> fuser: see patch 1.
> 
>>   HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>>   
>>   OVERRIDES .= "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"
> 
> Jan
> 

BR Alexander

