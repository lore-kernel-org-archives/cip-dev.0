Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE3C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 08:14:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.14514.1678695236793089938
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 01:13:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hRZ4hLF+;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaYTehDoE66NkVaf/817SyKrwMRvcvKbHvqsvjrymONASscjPAW0YMGaSU5vO3WA2p7UIttmfvdMDbK9fsigkEa/elu0c+zA3YGPZ5lkezq6WLMrzchfSnG6SPh23b5M3XC9DHJi+0WwDqMYFyoNjc+T5h8o3o+UL7mDvx4cEKixWy8ZWlnL/Mzf3BrMxg8ixW/0sgRVsxUWG827iitsrRXlnMyIay6c8f1CUxlAf83dABbyJHfEYdUps9NPJH9OxDz4zm3xG3p0BD37DqrrJu9lnxyLsORncR+/+EpkOmVhCareu0CROeHWGE/BWRfkNVtbW+2zY+zyDKCi4QwOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI6AqJecrc5D7NvrkujfIRbsk6uoPmIAYPnBJD8P6MM=;
 b=UqgW2r2NqI7s+cUcReBJZmJuydPLG1cHpNEOuSjl5L3PuZQZQ7jGPLLLUqJXvYxP367m+RjjY0KNbpQo0TGKuP/3YFpN3arbz2+uTdqUmrfkTUylSaPPoCuI7AyLqw3FiwjdCdZ39iKjik3UNOIVu1QffXp5lMLpyQTE1a9U0zmNvm35OK2LGTjevV5KcLk4IUwA5g/1rf0aWgd5zhcAVILzmj/I5R5h17j6/9c8csMToGNbnrq6WOVVgC8iUbLaXDNMqXMaBuSRlYdedzHK/jdALQByf0BPUOYVc40w//fX+fOCiOe+YUmf66bRpxXrE4oVlgVmx+vEy/qIvsd7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI6AqJecrc5D7NvrkujfIRbsk6uoPmIAYPnBJD8P6MM=;
 b=hRZ4hLF+y7LMOZSNk5stPVvreOQF1KqM1DtjmmiVzeNlzzbz/9sTdn6bplrYRjC+nn7h0HSB54sslne7MGApHsfiAc0XQ1eHtb25rdG1jgYYOev/EnynpZ/sT0ta8k39QrQJTT8dl37wBKnMNl5Npig6lI6FDhl4f5b4pJ8pCPLPxNlBzxE23hdwPAOpbwPzzaVS4PB8sidluH7r0CH9gVQn9ZvljsyX9/HRUaePBZyZN1orQKBPnO2RKrq/9BJD0a174zht8Kk86zrZXyu/DHJljPs5XXJokEmTUyIk1vjy+i4ytfCZ/IkcXBoH9hU+oQX0wPrH7KUy8/R6zsipXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:452::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:13:53 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:13:53 +0000
Message-ID: <e5d1629c-7b48-da7f-d39a-14e8c45c0555@siemens.com>
Date: Mon, 13 Mar 2023 09:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 3/7] start-qemu.sh: Create a
 tpm2 device
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
 <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: c61ee2f5-0bd8-4467-9c2b-08db239ae258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pznsd9bXjSHVOAnzx9ennfPnvKllIryHobc6cpikiNd+K2L+oUql0N8KSPuNqALl9X5wqiFQb7UZLaAWSJmrFzF01EmjkEAi2rh/aqJmawoEJwO1RtvKhechy7YVKv39D/sYg/dmCOSLtCoQso8nTcJcYJ77Ti+/vlKSoNqi3OwlxMBHbGfLyxr2JiNS+jc8Gz6q8/5FCmVghioX6BlAUW87pstTxV0gHEJI+xRqI4M25H6p4XJtCTCyXYMuyEQbWydDGV2o5SXpXEqQq8ANyeeKMamyBiZApsebtMQx1yr1rGzgIjenc+/EqLrtXTkm3LvUl8uBZmt77iW0BQ3q9nbps9KuLL7tm4xO/qjsaJ/X4K4esQEN0pqaXQiMyKLd59gWsIZrY/W1laqHqpRynEQFtrbJVBpEnpMnPglK3XDx2reG2vpAMpFq+66xR8JVbpKjXw95MEpT3NnQs1DoUqS3GQoq1LxdaXzz0NQkRiKqw2SmwSwI8aKIgZQ5/i2y5Pa/EnNPHfYNKR2mPOagyKt0APUdzvEJY+BFf++Jm82mC6KO/+34jOdrwQmr2mgbQ69InohNQ5lwfxCyRaSB1W/uFMHC+TcDxBuppHBHPXEinyVwcRl+/6FGiZNyUx6C2oGwn9K5pwW58gnP7C3lDjDPfgAnEUbJq0wEYOwN3O+hzzLhJ0MlLIRYN8g6a6Ty/VD7rYaL+GnY/TJQiVvPsGO6kc7hJG8OwzB6eFEW/hY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(82960400001)(2906002)(41300700001)(8676002)(66556008)(66476007)(478600001)(316002)(86362001)(6636002)(66946007)(36756003)(31696002)(38100700002)(6486002)(5660300002)(53546011)(26005)(6512007)(6506007)(2616005)(31686004)(186003)(6666004)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTNiTFk2Q3dHU0N4aXplMXhJaDNvQVpiYXhDdVFObkRVMENKZHY5bGdJZ0NK?=
 =?utf-8?B?aWtTSUZHMlIya3o1YWZqakplMzBmR1FSY0RVRjZ1by9WRzZKaGtXSTFIZ2ps?=
 =?utf-8?B?ajErdEJvZ0xKSkxmNFlLK2IxcDJnMkFxeXp1aFNGQS9Uam5tUGdOMUpic2Rz?=
 =?utf-8?B?YSttK3luYWo0ay9qUHFvWFhHamRmTElMbGNNTnArb3cxMnlJYlpUWGI3Tk5v?=
 =?utf-8?B?ZkhteE1ZdlJsc1JETnJrVnFCaXRTd0NQVTNLcmgyUGxiR0xremZLcVhlV2t2?=
 =?utf-8?B?VWpSaG4wQjZQbmVCRTJML2NyVTFBWDc2U2pZTzZUdlMwMytkb1Ewa1JQT1kr?=
 =?utf-8?B?Z2NlUlNPUzV5Ynh5ZlhZaDRjT0dWNU5VVVQ0T1RvOEFhUFA4eEMxUzh4ZWJ6?=
 =?utf-8?B?OVpBUGE0ejJmR2tYWm5ZcVpqQkQ4M2VsQzFCdEd5OTRheWNEZ25OdUJrTjFG?=
 =?utf-8?B?NHNBZERiMktmY08wdGhVbE9rUjZZdlU4ZERDdDhVaUNUb0Q0amhhaUsrOVBv?=
 =?utf-8?B?MmgraFNGWDZQTkZLUlJEYXlPOHVsd25wRklxam5SN0NvNmtlc0RzcjZYZnVO?=
 =?utf-8?B?VllrRkNIWGJFUlBDZExTYUFRdCtEbnNxYnh0WFNiOWFHUzk3WVZ2S0czTlNQ?=
 =?utf-8?B?bE1DVUtZSngzRGNVdktmcDdlV3JxSjQ3TFRQZy9VNWRBcEw1NXJxN3A1cXoz?=
 =?utf-8?B?cmdxVytQQnlZVFJmZ0grQnJ6V3RLdjN4SG5UVXhLNmFsWUFYaytZL2M0N1F3?=
 =?utf-8?B?NEllRkpSbVFlLzIyTURIVmZ1cGYvT0llYW5iUHdhcW5hZEVMUFIzV1g2N2Z2?=
 =?utf-8?B?VVp4V0dKL0NzSG9MQlJUZlBLNXFCR1o0eXFkakVScnFjR0E4Y3d6bDlDWDhp?=
 =?utf-8?B?TXRpMmhwblR5NEVZVlU2dHpVckJCdmJRbWNqZ1RWQ2lnRlNNbUhvcXhLVW00?=
 =?utf-8?B?SWlEdHpRUjhaeitWdlA4MEI4SVlqdVBKQVkybTU4VmJmNHJtdEd6QkJydFVC?=
 =?utf-8?B?c1NpaFBpdDI5TmVtelVDQ2tTMk5zUVptKzYzMnZSVTV1bjJDdDZQRWxRRXp5?=
 =?utf-8?B?am8wQkIzaEhyTFpJSWlzRUJpK3owbkdLQnQxT1ZWcndrZjZZbHU1YUs1NExu?=
 =?utf-8?B?Mm9oc3R6bWRuQStxWXkxOXhjYzZMSjhHMlh5UFBPSlBaQ2hNRkxMaFVqa00z?=
 =?utf-8?B?NDdOQVErREJ2SGY1VHdLVXBLMmdabmJmaERPS2c5N2RIb2lGazhKcXVZdGh4?=
 =?utf-8?B?dExTcENMOWlTSk9IK21mMU1aYVhTRWpiS3pqV1hxajFQY0J0dVVyVnNwOEpj?=
 =?utf-8?B?M3NKcis1SkNyemErdlIrR0htbDkwTVBUdTZwUVVGUXJJZWFoaTEzQ1ltR204?=
 =?utf-8?B?bmpzZ253YnRmVlBpemxHMnhlUnlURUtzK0tJMGpuSkZVcXlsQmxoSGJBUkZN?=
 =?utf-8?B?Tmx6Qk4zUHlXWm9EVGRBUlBQT1IrQWhJejROMTM3cWVLMjBMWHdPaDRYOTF4?=
 =?utf-8?B?bWtZL3ZsN09OMTNaVk9PWmcvMUtJVk9LbzhnNEpGcDVQMEJudlYrUkxMZzNO?=
 =?utf-8?B?NFpyQWJPeFpQaDlvYmR4Mkh1SWpwSG9JaWgxQmYxbGFlRGtNWjFSZDdFckFI?=
 =?utf-8?B?QkcrcU8xTVMrWkRwdUlFcTdCajQ0cFA0cjdGMWwrZURqVnArSXNZZGpQWjcv?=
 =?utf-8?B?dnY1Zkx4V3ByME1vSmhJOHJRdUVKTlEwaGNKWWlkRXZYaDNNTjlDUk93Z2xw?=
 =?utf-8?B?Z3VvVnd6NTRiMWptUmkreTNIa3JFRklXWWZ4eWxjNjBXUmRBQUxqSzBQQjM3?=
 =?utf-8?B?K2s0Y0tsY3hoL3daN0dIVHVBcTVCNXJxQnRTVHVneHZVNGgwVGpkempKTVVQ?=
 =?utf-8?B?R3RKM3l4cVRUQzA2VkVwMGk0dWFYdlE5cWxvZDRnbmhINHgzQ3l4NUZUQ2U2?=
 =?utf-8?B?TlFuY1oxQzErMXc4Z0Uyb3M5SFZSR1ZhaVAxcENFWC9VN2ducnFMYXVYcTQr?=
 =?utf-8?B?ZlMzL2RpZ3RXTURBdWJFSWdkbGY5Vmd6L2VjQmpBUm5qT2h5MDFMYlRNczBz?=
 =?utf-8?B?ZENLaWpYSFl6c1A0MWNmRVVQakplWDZlM1ZoRkg1Tk5UQm1lR21HcW16dVhQ?=
 =?utf-8?B?eDBTMmNIaWhlN1FKMGlnR0tJa2psU09ibjVYcnhTcVNBS1k2RW1mMDk0QllG?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ee2f5-0bd8-4467-9c2b-08db239ae258
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:13:53.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B9Yf+or7oIZjjfD5czRNmuDPMNML2BkKF2oMaWv/pZIVonCmyL333nTZjkByo++MbIFZgen6slN/oeo/045eWeYVhD3peaP0q12ApQZihM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 08:14:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10994



On 3/13/23 08:08, Jan Kiszka wrote:
> On 09.03.23 11:28, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows testing the partition encryption with qemu.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   start-qemu.sh | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index fcfbc5b..b46b066 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
>>   elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
>>   	SWUPDATE_BOOT="true"
>>   fi
>> +if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
>> +	TPM2_ENCRYPTION="true"
>> +fi
>>   
>>   if [ -n "${QEMU_PATH}" ]; then
>>   	QEMU_PATH="${QEMU_PATH}/"
>> @@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=" \
>>   	-m 1G \
>>   	-serial mon:stdio \
>>   	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
>> -	${QEMU_EXTRA_ARGS}"
>> +	"
>> +
>> +if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
>> +	swtpm_dir="/tmp/qemu-swtpm"
>> +	mkdir -p "${swtpm_dir}"
>> +	rm "${swtpm_dir}"/*
> 
> This kills the previous TPM state, preventing to power-cycle the VM. We
> rather need to persist it aside the disk image. I'm massaging the script
> in that direction.
> 

This was for debugging purposes as the TPM is no longer accessible after 
a number of keys entered.

Quirin
> Unfortunately, the unix socket can't be pushed there as well - path
> string becomes too long...
> 
> Jan
> 
>> +	if swtpm socket -d --tpmstate dir="${swtpm_dir}" \
>> +			 --ctrl type=unixio,path="${swtpm_dir}"/sock \
>> +			 --tpm2; then
>> +		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
>> +			 -chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
>> +			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +			 -device tpm-tis,tpmdev=tpm0"
>> +	fi
>> +fi
>>   
>>   if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>>   	case "${arch}" in
>> @@ -158,14 +175,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
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
>> @@ -174,7 +191,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>>   			${QEMU_PATH}${QEMU} \
>>   				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>>   				-bios ${u_boot_bin} \
>> -				${QEMU_COMMON_OPTIONS} "$@"
>> +				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   			;;
>>   		rv64|riscv64)
>>   			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
>> @@ -199,5 +216,5 @@ else
>>   			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>>   			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>>   			-initrd ${INITRD_FILE} \
>> -			${QEMU_COMMON_OPTIONS} "$@"
>> +			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>>   fi
> 

