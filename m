Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A4C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:12:14 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.69])
 by mx.groups.io with SMTP id smtpd.web11.8624.1676646728858083224
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:12:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VqktRL7d;
 spf=pass (domain: siemens.com, ip: 40.107.21.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/AFNwjoZKIy4nhJwCZVVINFCOWc2uAnR1KMQxgLzk/qyC7SHJyhw8+CdRBecSRO2H6QJCkfmQHXp7suMEngcJAZrZQ1O6OtfORJQZgw7wngdzUB0oQU8X4RZFZGxnLzTQpaMU7o4ykajrUzg6FamjLkdgNrgVRGFzOA+AJ9A4vAax8dQZ2+265U64CWYVC6B4bFx78G5k9Kgjws2726gbWNoswgbpdmIbn4/xpppfHD3v4ACy2JCTHjgwD8pmpfq2G6nhB3yaqnESCxnx0V00wfudRdXRVkHWuHGAfaDT8LQPQcU2LdtH/5L4NKrtdxF2Q3giCMhSoNozZ/MYzeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddx9AYLnIodfWmiLcJjxzpTwksBlNdYVa0N7pjFO75A=;
 b=lu3/uqQUHxozLaiq42HtSdGaPWDle519/MNshwoTRw/Nrbmv/36VJlDrK/FBOXXdG3tnfl3o6bh3HdeXH6ff78tEb6pK+i3b/Hm1QlNYfq9itTIaREv4Ue4hO8JsMjH+pqt7fJIk1gnD9Vaj7YIbHcx4iys9FPUcA1S/OIzmA1tv19+nD3VUs49kZuT4euJNC54ilTuS1Aw3KjQaTtfQur7oPRPKAuMEWaqWKvwzSCsY1aGeKoHx4j3HQ8KlQwjW1I96wTx9VL+8Nt00gyDjRmeXxx13mCXetW8kNfoLXTVMnaHeDUne5cUUXrZk2nsoHr3p4OEu4az+fcZq71AoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddx9AYLnIodfWmiLcJjxzpTwksBlNdYVa0N7pjFO75A=;
 b=VqktRL7dYF/62tSZaLKKYzAouNv0oPdVDkR/we8OqKAsIeNX8AsMB+rNupakb673q34PQsY6aI8m3ZsH9Foh6GnvE6eF4nLDktiqWrsxs3nrjU61W3W5h+SLAa9+YY3kaucOpNDAsCrUCNyXzCZdZkhZPsla66w5IH9gfZAJ6rmRSA/6XtumSLOxETBbhx42iQeCVJv+PUQpQiiqXECTQBAC347YoYb99L5fPKU8OpU4ajHelNCEnJo69QSbBoJR558/9VG/Anhtc9+Vpa4Wa1wPl2KlgpZMHY0gSGTJO1PHGwpKJ7xMEeC9UdA3YqZrUtU0+wiii/E5u04KN4feng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:12:05 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%5]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 15:12:05 +0000
Message-ID: <7598764a-a99e-a485-9df4-af7da43512c4@siemens.com>
Date: Fri, 17 Feb 2023 16:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/7] start-qemu: If swtpm is
 available create a tpm2 device
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-4-Quirin.Gylstorff@siemens.com>
 <6fca94a3-1350-872c-ce6e-dd93abef654e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <6fca94a3-1350-872c-ce6e-dd93abef654e@siemens.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060301060502070903050303"
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: c963147c-87a3-4355-a102-08db10f9546d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	knC7rjFX19dzxQJyyrMC3Bg/8WudpAumQQlTAQMDGDolWq0gkboImvftKocWJWD3Fl2RMnTUPORxKxV3WUgD52iBgCnMLaZSeqnJy8pdf58RYxm5dwxC8ZdDaGIM7VZr1h6ef4MWNDl0WLaSFeq0UM9poiQM0jsg5G4Ni2S4e6ub1mdAnzSC2zNegzEUPfAYyo30y2E9y30iZ6EiVfpRPQ8G0nM9j5LqLkb3BirAaqDpkBow3wBA8gzv9X2wB9DrPBOU8KHzSCgZl1UQVmVcnI+ruWXOiAbNeRzr/d8GgnBVL+1CWghJA6XMqfRMtw20VnxNNTVedPf+p9LOb1Zrxo5EH+3MlXNwfCVD83I/ft7M2sJQDf8ywT5P37xFksLfOWN3mKPpVWYolEK5KyWEdAQ26Oa80CeRqOOw3BzjARl7RyrtOmWPHFO8ARbuSrNbMWcrLMUvAujb84OkVkMXuG+y/f84gcL6/73panZcWssPut1dsuloSd5xIvww0S/QxqrNPOeCo/eFvtbtDQUQSGsB+BGpMdG1OBpgqigvv2iFellnaJGW169+WeBHfGsuFUdtGbN/Hi5BIfEi02t5ymCTdU8S1S/AMPb573LI/mi36Fg9lICRq6KQNia4wowmqyYlTgLWx3Dt2lBsdFlnBkoZpbnaE9FDOoeD24RLmtGq4fgJFd6n55zLnb3z0Dh2e/aEwM4Z4R8cG7lKVNj4klFFn1OQD6ItmdV6CcZZCPk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(86362001)(82960400001)(2906002)(8676002)(8936002)(38100700002)(235185007)(41300700001)(5660300002)(66556008)(66946007)(31686004)(83380400001)(316002)(6636002)(2616005)(36756003)(66476007)(31696002)(6486002)(53546011)(33964004)(478600001)(26005)(6512007)(6666004)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTNQMEg2L0tiZkNnWk8wNmdHNGd4cXZTMXhoZDdGRXMxVWdVZTgxWEJ3dzIw?=
 =?utf-8?B?RGpFSVllazUzT0VCTWtaOXZxS2pBWnl0T1lUZ0thbWpuemxQR3daNHpSVXUw?=
 =?utf-8?B?MXFkVXhHSERZd2xDc2g5NzF5MUJVTWV0NndkQTByQ3hqWjNQV21xcEQ2bmhv?=
 =?utf-8?B?ak51QW1UTkxXUVRoU2ZqKzNXWkZVTmIzZk5FWlJNTFhZaTdsUTFtSUpLUTBM?=
 =?utf-8?B?NWdKYUkxc1NoSHNDUFM1SXFYb1d1QXlXVlo0dWppRFZaU0pzMmtBLzN2dSts?=
 =?utf-8?B?QUk5MzJiV054Tjl2TXJZQW9CVFlUc05ZNm5ZOFg0b1JYVFhhdWZyS0krWCtR?=
 =?utf-8?B?c3Y4L0p6ZTl2R3BSVHFSTml0RnJPVzY3bEdraDg5c0JlbkdHWDNZQjROZm5t?=
 =?utf-8?B?NU9BOGVJU012RndnWDI1T3JVaE1zNWlsRVFUdHIvajdqTjVuSDNoSlZlcnpi?=
 =?utf-8?B?ZWlBeTBxNUVOeVZ5OW95UEFtMGxaUFBIUmpodUlZdmJJOG1zNDZQOTZwaThk?=
 =?utf-8?B?WE1zVVVhUFUzT0hBcW5jTzVlT3U3c3Q0WG14K002elNTN0ZKYkp0TkRjNi80?=
 =?utf-8?B?QkhTWmdCTUNUTElLSmtXTFlXNUN0RnEwQ2hEejYyMzZvWUZqYnFNNjBtQk9F?=
 =?utf-8?B?N1pzRVI3S2lzTWpHRHI5VUFXZUo4YzFIanpnWXhtcEl4dUpFTUFubTVRNkcx?=
 =?utf-8?B?NGpqNzNrN1Frd2laQ2lUNXNUQjJsQyt4NjNJSS8xcElYUWZHVFdyRERBeXgy?=
 =?utf-8?B?am9JUjBEUkNtY3J0Y3FxT2NiVzl5UEova2FNeGZCZW80UEg3NHZmVk50WDJB?=
 =?utf-8?B?dkViMjVnOGpmUXlvMC9lR2dOVWFQeEdSb3lidWc1Tkd5ZEV6eW5tcUxDYVVG?=
 =?utf-8?B?czlNcld5VFpZU0ZBbXh5R2krWUtCVnUyMXowNmVaNEIzbnc3MmkzbXdNdnJB?=
 =?utf-8?B?UnVCQ3IvdVp3OFlSUXZYOE8wWFJMdVFZb0lPVW1vcEc2elRqa3I1ZFNqZk0x?=
 =?utf-8?B?MWUyb0t0UWd3WjlBK0ZYSUpGVjlDS3BtWEdwc3lMUitnZExzakEwL3I5TFlv?=
 =?utf-8?B?UThDLzE5am5ON0RvRWVteWZwWmxVRUxLbnhUaGsrQ2NaWXhqanBrY01OMkgx?=
 =?utf-8?B?TkhpaWNGeVpKYzVlT0xxQlAvOTY5OWNsMnRjTVliTEdXTGdDVXVscEpEcG1t?=
 =?utf-8?B?aTY0UWQ1REY2ZjFROGU1RVUxQmlQdHJodlcwUnpyNUFHSEw3cldZdElHTTVu?=
 =?utf-8?B?QkJmL29XcVBFYktvaEFJYXRod3JRNzFlNUpHaFFkbEpFVWVVZHR1QStmbVAx?=
 =?utf-8?B?VWwwWHNkYTBxK2YyY0dUTlRJMDlGSlJIUTcwcjhhOW9pS3V2UjJEQXVnSC9a?=
 =?utf-8?B?RXVtZGgvdVVrNjc4MU9EOWgvNmVucDU5ZUJjbnI4QU9hVkZRUFFURFRVUHhx?=
 =?utf-8?B?WFBLZzBkTE9SLytrbVNSUm9ONkxRekEyLys4R2dPUmV4dk42ZnlKanhycGFB?=
 =?utf-8?B?N2FoenFjaXZnczhZMkdETW5YYVNkVloxYUxkeUpVVklPSzVCdTZnaW1hNGVP?=
 =?utf-8?B?VktWQUtleWtzYUx0TFovaG00R1Q2bFJYWVN1LzgyS1Z3R2pWTkJEZHk5OFps?=
 =?utf-8?B?UGt6L0ZabmR5cXcwRlh1MkttR2cvV0FNcVNETUplOWhKeGRoREdOOUdFT2Jv?=
 =?utf-8?B?RnU4aW1MSy90SGdCSXhmeURzaCtoRXZzVTd0bUJ0R2FVMThWbGpwYTBtM3JC?=
 =?utf-8?B?cS9RQkJPTXFRWERaTEdQdlYzU2lTcXFWc1pySlhSR2pheFZmZXR4ZnMwZHNE?=
 =?utf-8?B?WVRQYS9Hc0hVQ09uS1gvbzJ5TkRkamVyb3VCdTcwMyt6L1U1TU9QY2RhTGVH?=
 =?utf-8?B?WWhRTVc2MDFHM0ZzcU52TlJZSTFxUHpWc1lJd21RenAwdUdiMzYvSnlnb2hi?=
 =?utf-8?B?Vnp0ZTJxVHZVQTZzVzFneml4aUZGMUdVS1c2TVdWa0Y4Y05FRitlN1VuZnRO?=
 =?utf-8?B?anFaTG5pcWUxU0N1S3ZZV0NtNlNIbHNNR0tXM2cxRU8vN3NkQndoemd4VThI?=
 =?utf-8?B?WkJHQTJpakNjRUxJdEUrcDVvb1NaTDNsZHB4bmVkTW1qSGNQUFh6VDdVUjRR?=
 =?utf-8?B?NzR0M2d2V0pxVENGWmZtTHgrdGFYNGNTSHNld2lnYk9JaDI0Ui9wZFpla1RE?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c963147c-87a3-4355-a102-08db10f9546d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:12:05.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0W1J5vysjKi88yqHCM83IHHMgK78YL3trSWpTvpi9L9k8PoQ+Ramc5qyF9G/JsFPdcvn0AtZS7x1dCdE8OkubvC6FQv1PUhQCM9877vFuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:12:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10728

--------------ms060301060502070903050303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/23 15:49, Jan Kiszka wrote:
> On 17.02.23 14:05, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows testing the tpm2 encryption with qemu.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   start-qemu.sh | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index dd16aed..3ef2acc 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -139,11 +139,24 @@ QEMU_COMMON_OPTIONS=" \
>>   	-m 1G \
>>   	-serial mon:stdio \
>>   	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
>> -	${QEMU_EXTRA_ARGS}"
>> +	"
>>   
>>   if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>>   	case "${arch}" in
>>   		x86|x86_64|amd64)
>> +			if [ -x /usr/bin/swtpm ]; then
>> +				swtpm_dir="/tmp/qemu-swtpm"
>> +				mkdir -p ${swtpm_dir}
>> +                rm ${swtpm_dir}/*
>> +				if swtpm socket -d --tpmstate dir=${swtpm_dir} \
>> +						 --ctrl type=unixio,path=${swtpm_dir}/sock \
>> +						 --tpm2; then
>> +					QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
>> +                            -chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
>> +					 		-tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +					 		-device tpm-tis,tpmdev=tpm0"
>> +				fi
>> +			fi
> 
> There are some space-based indentions in this block, messing things up
> visually.
> 
> Jan

I will fix that in v3 and add a check if if TPM2 is requested by KConfig.

Quirin
> 
>>   			if [ -n "${SECURE_BOOT}" ]; then
>>   				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
>>   				ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
>> @@ -154,14 +167,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>>   					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>>   					-drive if=pflash,format=raw,file=${ovmf_vars} \
>>   					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>> -					${QEMU_COMMON_OPTIONS} "$@"
>> +					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   			else
>>   				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
>>   
>>   				${QEMU_PATH}${QEMU} \
>>   					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>>   					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>> -					${QEMU_COMMON_OPTIONS} "$@"
>> +					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   			fi
>>   			;;
>>   		arm64|aarch64|arm|armhf)
>> @@ -170,7 +183,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>>   			${QEMU_PATH}${QEMU} \
>>   				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>>   				-bios ${u_boot_bin} \
>> -				${QEMU_COMMON_OPTIONS} "$@"
>> +				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   			;;
>>   		*)
>>   			echo "Unsupported architecture: ${arch}"
>> @@ -187,5 +200,5 @@ else
>>   			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>>   			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>>   			-initrd ${INITRD_FILE} \
>> -			${QEMU_COMMON_OPTIONS} "$@"
>> +			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   fi
> 

--------------ms060301060502070903050303
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
GTAwggdkMIIFTKADAgECAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEBCwUAMIGeMQsw
CQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQMA4GA1UE
CgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjMxHTAbBgNVBAsMFFNpZW1lbnMgVHJ1c3Qg
Q2VudGVyMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIwMjAwHhcNMjEw
MjEwMDczNjM0WhcNMjQwMjEwMDczNjM0WjBlMREwDwYDVQQFEwhaMDAxMDhZVTEPMA0GA1UE
KhMGUXVpcmluMRIwEAYDVQQEEwlHeWxzdG9yZmYxEDAOBgNVBAoTB1NpZW1lbnMxGTAXBgNV
BAMTEEd5bHN0b3JmZiBRdWlyaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCA
qN/x1wdiSvw0dSlpuclq8Fwi4S3ldLu4MdKANA3DfDb+nd5jbRSKI09GYII3iFV4YkNDUtlq
73VQoJX0udyZM8JoYQ5Z5HaOBNWcXTcjL48LKsZrKsk7UUP2FBn3/bR9VGslALN+8em+6qVr
ZDkxVfRl3xEMi5EgVtorSAIP/RfspM9XWb/WhZJCASsl4fY8+pOjrGxQnitRc6VYXwUZAM7r
L1qX0eLGwAnaa8b5OvNtAxE2VVkAjyTnE5NoiCnbsi6Q+zX3/Ai8zv4pqkbUsHNoLg+qzJsa
CdD5TtfpwNgJgdQfD6Z0F89b7Xg36G7KZllulvicX62fFqzwx2dlAgMBAAGjggLUMIIC0DA4
BgNVHSUEMTAvBggrBgEFBQcDBAYKKwYBBAGCNwoDBAYLKwYBBAGCNwoDBAEGCisGAQQBgjdD
AQEwHwYDVR0jBBgwFoAUtvmR44WfDDy2iXJTnkE0jXAq+b0wgfcGCCsGAQUFBwEBBIHqMIHn
MDIGCCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkIzLmNydDBB
BggrBgEFBQcwAoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWkIzLEw9UEtJP2NB
Q2VydGlmaWNhdGUwSQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpa
WlpCMyxvPVRydXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9v
Y3NwLnNpZW1lbnMuY29tMEYGA1UdIAQ/MD0wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMIHKBgNVHR8EgcIwgb8wgbyggbmg
gbaGJmh0dHA6Ly9jaC5zaWVtZW5zLmNvbS9wa2k/WlpaWlpaQjMuY3JshkFsZGFwOi8vY2wu
c2llbWVucy5uZXQvQ049WlpaWlpaQjMsTD1QS0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dIZJbGRhcDovL2NsLnNpZW1lbnMuY29tL0NOPVpaWlpaWkIzLG89VHJ1c3RjZW50ZXI/Y2Vy
dGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAdBgNVHQ4EFgQURT1zRzKUlh+WlA5LZInILLrGEJQw
DgYDVR0PAQH/BAQDAgQwMCcGA1UdEQQgMB6BHHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEALJcoEKoIAxLyJV+6HTpKciBe
E3w7ht2RSQjG/7EAgjf+kW0Nrp4TyrzteHR3A2sTmRJC2M7/DV763W93qPzPiinqtNlUEDte
KJlHBfr0OUio7i0RZqGvlCGPK1R6lu6e3n7NtApww6nPAveS95UuJnkYzO3gI0I2gUYqzTeJ
BYLxC++jZeO2Va1vSDnNjFUrcLoPrDeU6T3uLXrOF/3XMKlfiXIybQZoWPgNhVhu6N9lJAJ0
2eHQQVWeoaQKmoNuAki/YE1guHR+Rz9dyYa1vawjDNWX8z7wZzNq5c0riHbHYfDpYEfcfli5
/aQB1z3Zgz5SePHBkXMsf+jSrDJKAqmaSyhn4xFpxo8ZnJWQwDg1KbE33/bL0LpGMK7D6JmK
dk4s6t/717RYywFqBvBELzKYKnfQqSQy0AsuGOmrVKXlQXKc3IotXwreL6MOLuzGuNuPuXHi
NgZFiZC09CfWqlJFWTrIsLoT4KXoLqGOM7kjBDoEAaM+QAsy/aFPATsXv+KPfGcK8o5hziPY
g/HTh/c80ZPxq7H87VzCxgu20vxq5rMe6GUZTkTF2YKajVhFbFKp+bM+Uu8MOXZ6PNgsTmzL
8PqdrRK3TNT1S7v6wEQ/oeceSE6RDg6A89vg5QLWIAYMHt30IO/nTXgdL9uAcTuQLjmkWmiH
fWWqzhyrQVowggeEMIIFbKADAgECAhBavnHi3TH66Ts7d1icYK9VMA0GCSqGSIb3DQEBCwUA
MIGfMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQ
MA4GA1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjIxHTAbBgNVBAsMFFNpZW1lbnMg
VHJ1c3QgQ2VudGVyMSgwJgYDVQQDDB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDIw
MB4XDTIxMDIxMDA3MzYyN1oXDTI0MDIxMDA3MzYyN1owZTERMA8GA1UEBRMIWjAwMTA4WVUx
DzANBgNVBCoTBlF1aXJpbjESMBAGA1UEBBMJR3lsc3RvcmZmMRAwDgYDVQQKEwdTaWVtZW5z
MRkwFwYDVQQDExBHeWxzdG9yZmYgUXVpcmluMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxtputBhOSIjdX+ZhaIzZXOkmsV3YBSNTrnA4MTG+TtL5wgss1pfH/YFV8CHLacVX
/cYnD09uaxevNSGV3rRLZF7A77gNl99BE8qqHPAXoB+/ZVQHzo3QdumqpqaO4bqTQYsk+jYC
eDEIlGyzDep9EAMdLK9jWoeYG68ayc6G062I0f8MUHC+oY3G14O454N487PcWj66UMh9zqGS
z0lk5AuGpC1xSks42Fs9TxNgLlh74UZPUZZWtp4+05eyyDay/kkuztI0jJmYMtg0ft7vGOuU
MzFVcxau7llvsv6z94ep/rmC0n+W0lQbTg9FEkeAE/ui/9uE5SqeMp4DSPk5MQIDAQABo4IC
8zCCAu8wKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICMB8GA1Ud
IwQYMBaAFNbv+6fnKrHAXUxohcItj1ZmfoLuMIH3BggrBgEFBQcBAQSB6jCB5zAyBggrBgEF
BQcwAoYmaHR0cDovL2FoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpCMi5jcnQwQQYIKwYBBQUH
MAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpCMixMPVBLST9jQUNlcnRpZmlj
YXRlMEkGCCsGAQUFBzAChj1sZGFwOi8vYWwuc2llbWVucy5jb20vQ049WlpaWlpaQjIsbz1U
cnVzdGNlbnRlcj9jQUNlcnRpZmljYXRlMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zaWVt
ZW5zLmNvbTBGBgNVHSAEPzA9MDsGDSsGAQQBoWkHAgIDAQEwKjAoBggrBgEFBQcCARYcaHR0
cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzCBygYDVR0fBIHCMIG/MIG8oIG5oIG2hiZodHRw
Oi8vY2guc2llbWVucy5jb20vcGtpP1paWlpaWkIyLmNybIZBbGRhcDovL2NsLnNpZW1lbnMu
bmV0L0NOPVpaWlpaWkIyLEw9UEtJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3SGSWxkYXA6
Ly9jbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpCMixvPVRydXN0Y2VudGVyP2NlcnRpZmljYXRl
UmV2b2NhdGlvbkxpc3QwHQYDVR0OBBYEFJc32FVWG9Weg/eke9wkqBgOTMDHMA4GA1UdDwEB
/wQEAwIHgDBVBgNVHREETjBMoCwGCisGAQQBgjcUAgOgHgwccXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbYEccXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTAMBgNVHRMBAf8EAjAA
MA0GCSqGSIb3DQEBCwUAA4ICAQCOXIgWGNMyJfE4Gbdgzqirk9am/SdeBV32YV5ZTNz43Zre
7Z3LRqtrhr09B+BfB/gfDcxAMwQctI15BwW90Yj7IveAf9/vWf3XPkUOLjc5Yicd4ABlWsvG
kZYK7UihD51ZYzDh3Weym8pp25LPLUA07M4+0s2J2RFxz0NqT9Ab0N9zqQKP4lCTM2nHh58+
2QUNlKGGyVG6cQkiZffWp260dL8sliUR96FMDHT55PYv6GoNOtUqA1rDpk4seZQFxDwBNW+E
E1DdKD3CXNMOyv4ZuUjjQvjhS1gleaVMxD+k1vTV4jFW0nnNX4uYCyT4KVdDlxtvs3xSVkZV
DWm2u+zo1biCfgGFtWb9ZfC2hv9GdOr14MJWONF3QDC4uINewUFdsAcD+nGab/7FiAIYNI2r
BDsih5BgMuWHIEJKGKWykFWkh6tjlkaEyWqdoFMpeVzd5wlp4fP/wZ7xg1OddBnhbYb1nCuC
xtYmQfSh9/Xp1u6WQMLYaQHvTULBVCeGzClFY4FPutT4pO7RS1F5L0GaFnjcIsiBp5I9ICAZ
PSdnIpShfEm47olJARhAx29FBN5JlisbzveSNBuNHS9QH5II0K7AClrOcATYO7hnxktvMh60
V4q0S6YD90WWkkRnwv7R3M9Zpohzs0kot3z0vsivYPDq+50h+kABUbjvO/x/bjCCCjwwgggk
oAMCAQICBGAcg7MwDQYJKoZIhvcNAQELBQAwgZkxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZC
YXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwha
WlpaWlpBMTEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxIjAgBgNVBAMMGVNpZW1l
bnMgUm9vdCBDQSBWMy4wIDIwMTYwHhcNMjAwNjI0MDk0NDU1WhcNMjYwNjI0MDk0NDU1WjCB
nzELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAO
BgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWkIyMR0wGwYDVQQLDBRTaWVtZW5zIFRy
dXN0IENlbnRlcjEoMCYGA1UEAwwfU2llbWVucyBJc3N1aW5nIENBIEVFIEF1dGggMjAyMDCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMoDusEPTAOAEOTwI7QkSd3bwzwKSgMb
uzXxUPaoYsEWCApzGe4ezh9ZZz00w9+lbkiSnuEkWuwX+FP50LLkgP1NUksigbwtsZ3dODeB
/H1GVg+5cV4oaWB3Rht5ePYFCROwskp4lUS6DGlunKc+t2NBkHesB0EWeiaJeZSJn0gAt2aj
FyEVP2wpwRHCaR/SjwmQPfCU1jqwuuU0+zS06ELRdS8rBiN0PXstS6Iboy+3jPpPlKnrtAum
jO2NTsfDBDt3q18+ZO48oKZENPda4FGfF0mxGP+0Xr0OII14W1bCMUwFEP/4UWlvFvtjpjUq
orhWV4bxJGe7E/oZ1nmmRn382sl+N3v2Ml/yyb59m7RChDRCm2QC2nvrzfi0hN6oPOa2VHZs
yqepMYHKJvBej2vk/twapZRsY43vbPztA51XFHcrdnJbsqH9RYqXVu4M275l0SN622V1vzsj
+kgMKXIxHfxT7jAl9v8HLFLTc+e9Bre29W1+wpw0d9qDbGGQYO+UN31TusMxpIhT1F5tLkeZ
wTLXUlFwA93cGTpArtn7XS03qCJ3E2IeUcwZydQOwH9FNTBIhUva0WXaefe2YofuefjC+Xox
FjvKzs1NeI8TarI2B1al9iruu2bzP72mS+jWdvk6KukQXEAtrlfaMLc+TmseQGmOxpD29HPK
dphnAgMBAAGjggSCMIIEfjCB+AYIKwYBBQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxkYXA6
Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpBMSxMPVBLST9jQUNlcnRpZmljYXRlMDIGCCsG
AQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkExLmNydDBKBggrBgEF
BQcwAoY+bGRhcDovL2FsLnNpZW1lbnMuY29tL3VpZD1aWlpaWlpBMSxvPVRydXN0Y2VudGVy
P2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29tMB8G
A1UdIwQYMBaAFHBtoFDsqdAsZ50ZFf79BHM1w+LUMBIGA1UdEwEB/wQIMAYBAf8CAQAwggIc
BgNVHSAEggITMIICDzA1BggrBgEEAaFpBzApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNp
ZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCATApMCcGCCsGAQUFBwIBFhtodHRwOi8v
d3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMBATApMCcGCCsGAQUFBwIBFhto
dHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgQBATApMCcGCCsGAQUF
BwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCAjApMCcG
CCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMB
AjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGh
aQcCAgQBAjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wNwYK
KwYBBAGhaQcCBTApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8w
NQYIKwYBBAGhaWMwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1aWlpa
WlpBMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNpZW1lbnMu
Y29tL3BraT9aWlpaWlpBMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9WlpaWlpa
QTEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDAzBgNVHSUELDAqBggr
BgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCCsGAQUFBwMJMA4GA1UdDwEB/wQEAwIB
BjAdBgNVHQ4EFgQU1u/7p+cqscBdTGiFwi2PVmZ+gu4wDQYJKoZIhvcNAQELBQADggIBAFAr
jdme0uraRt5tKTzku+CORk9YnWvp+waEbNw3rQfUuuosObdJNmOMD/j9zv0lTELANwSNRP7Y
jhwyrWDycV80FbhK9EsIUh3frSCc1sbd3/9eGzkMsgSuY60GIHydwsZQe9JFyRDCCO+Rfz2G
Xu+wKh8ENQti6w4U2ygQw2aqtIsFQVQDczqjisfNBkGVSJyp9yXxa2JOrEOjddx5yHf1pVTU
2kNPah3licDQoZ0mCZxyluULJw3RKOWjl9P8A2VpIAPqbeJgaWor+/BzkzvtQ3yaJB5PPGlD
2GFQNJRcNUpQdpDs7cAUkwToikr3ygGVUgImfHghnDDZaYG0twxefqA8+h9lDckAHI+c0VMC
DMt4TAn6bFohAcIpvtafQ+L/+k5hXaBKv//k+ESHakvZud2DAKxw4bssHoc1F/Sse5kGOsbS
O+Ht3igs7vVY6coaYXY0VmMscrJUJtlfySCvNmDpxcJnxxj9P+/h2hzXiQPfjinEj7P6jNQI
2O7Cik2TPY5XLVNGjz5xQrEFLMDyKIwNLdghRLhzMSn/PYo5bqasZ/W982lSGGOErw1XpKVM
sRCyuzWZ1q3sQRd6uJioIiUmj7/V/wHFh4kpvao4oEcQ2NS8NVEBIMRt9qt9XEjVXWWiHVhd
ZCuH/Dy0Im4oK1++s1MjHl5Hd5LqtrtKMYIESzCCBEcCAQEwgbQwgZ8xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5z
MREwDwYDVQQFEwhaWlpaWlpCMjEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxKDAm
BgNVBAMMH1NpZW1lbnMgSXNzdWluZyBDQSBFRSBBdXRoIDIwMjACEFq+ceLdMfrpOzt3WJxg
r1UwDQYJYIZIAWUDBAIBBQCgggJnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDIxNzE1MTE0M1owLwYJKoZIhvcNAQkEMSIEIPFV0IilZQmg/FD2u0l6
kD1WzjbZM9t65TeQUCAiB1HiMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgcQGCSsGAQQBgjcQBDGBtjCBszCBnjELMAkGA1UEBhMC
REUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEn
MCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM0
6383MIHGBgsqhkiG9w0BCRACCzGBtqCBszCBnjELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJh
eWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEB
AQUABIIBAEE0cth+sdQAn4k9Ba4z6n+uklE+66BUI0xbfYJ1nT2GZH99kpjeJZy8n6Y8OPXh
NkWLtLvZJyd4K/XrzSL32eER7ZqVgT5Qaw8jBqYOPUhWeC/gN35ABpxuvmNrJvbsX/bZFgHm
Fe5TZIvndJMLNBr9U05B31/cG9QhDDmETBGQYimti735I49S32Wr1m2y7fvSN05Z0IVWsBZy
DnEI8FoJpgiMaW90g/qJrAlDppYn2/kA3u4dPTUm80CrEVjmYTNb0ZfOrG6x2IGgci0/CHzu
3565/UVphRkWOKH1rR+xwVPXYjpBKfNrA1zD3kehNnzgUc2XcO1yGc1dsJTUtG0AAAAAAAA=

--------------ms060301060502070903050303--

