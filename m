Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81608C5AC67
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 08:17:41 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14336.1786609060364135516
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 01:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FTHjvmt8;
 spf=pass (domain: siemens.com, ip: 52.101.66.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+gWV94hVaE5CpBGbTFi3hEgKfr3lKirglBwSeSx3Wy6K7AhXagc7vIbDY+DTl6ChWBosPqSsxUZoqdqzEyJAXdgHJVBimsoNJXLdToBwUoPe1UsOmAUKbjPmjxStBwcPi30I5qbd8BszzVU0J/TE5NvTl/KjIeAWTCWcYNOSDhhyFrmvGUQy1Am8W7BLfWr/P66rC3Wye6O10c6BZ36yMS9CH4mS1OLcrYfMugkyGj0YCBmBFoOeyv9jiDpV+mhAtk90aTr5ocuWw8lzaLuL3S+LRuK/VEC84pNoW6pUcjee56IGN6LoPMSo+coi0l6qOoJOkLpmdBuYcs45nj54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpIYlcD8XiHTxgoYtQTBprVn8UK0REiistbjR8Zcl5c=;
 b=bD51z17S3dH0MmOQp9Lck0qIeQtQkgFAelkE5g0nmtX6DsgyAYEz3ovsH8zqWv0IkbFkyKing6a9ofQSJh4I+Nvja57y1toQ8CMusSXbFKpu+h0ARArMKvVOR1BqMK2fU8pLQC9IN/Xds/QoxCAW9bMvG+L9HXM/QCP/BEcn9DIWCs2tTsB0f6NgrWc37rMEa4E3Qw+kktF8OqKk+csUXq7+/0EkhB41J4KADH8Y9tPeE5S6O0xYdmh1wLupTEtyHA04VutWM2tvCpbuaDQRHso2Li/7enHGL1Nf+6YcYeVsy6HB95YW4abwh8Q9kpymv0hDPy6C9vFNWU7ti59/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpIYlcD8XiHTxgoYtQTBprVn8UK0REiistbjR8Zcl5c=;
 b=FTHjvmt8KFn8I/wrczsTMeiD1CG/QrrOkVPIly4u6n9R2GnbiDItN4Cl/6vH9JTwk+FmU9j9EgUc10/soNZC/Q1fNEWmgrYunJaFcM6/0Ykii07JWgareyrmAM7axQFpaS55gY9qT1LdVDcwew4/gtU9XGe9dvJGMLsNfQiku8gnxaABdgh+qSHyy5B3n2/V147rHzh1qou+RzxVpvXOreUUj+UNJY3Hw1CwYWJ82UJjSUkIQ8jgMaRkcGq57Wob6nqI3yFrbqwwKToMtOhczII0PDDsibKaVw2h3UzFd4vlT+sJW1fV9gKdBjlJmYKDdcSFF2r9rAByQoUuxU0+rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 08:17:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 08:17:34 +0000
Message-ID: <0b1434c7-5996-4ae3-8a92-19bf59c4501b@siemens.com>
Date: Thu, 13 Aug 2026 10:17:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update Isar revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260813070728.102577-1-felix.moessbauer@siemens.com>
 <aff77ff3-832a-421f-b73a-5c858c8c88c4@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aff77ff3-832a-421f-b73a-5c858c8c88c4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: f0dab50c-8be1-481c-7fcd-08def913534e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	x8I0zKuROee3SiySk0XcSfNGFDrx6TaAm+21POhJgqNUo09WVLO2vaKmc4TOhJtoZZ2FpCDEkDIHRqvts4Kapl29xPKcpzWDUp8PZgM/LbK2cWu5F7QnPis/UXxiOt1JLL0o6BKQ765jL0o8xNVtgeSr7t+clof8sqt7G6bIIfT9o0GtjIJupvem+0qElv1lqtXBCxEa//JTRQ/QGSSc3COsXWM8kYYNY2/kYWGBWbMPwy3gk5mKY+lhxTDMVnZiDH3buOaa4W568wbCB8iAWymteEP5hjvJEaMnrRSZ9rF+FB+Gq2e7IvepPoB4J45EPujNh0s76nBcArLGtM4Tfy6gVa1zTMFJgtG2wD+TWMCgjr17C/2SkKMBN7kfyQKwIUbGooxinNkmGZ3RznCbCUhNazCOcimm3XqGExv3a7AVXdavP6lFdVf8l6MRjq0pYrdtOoEb7dUjuug/Txy+YRWsRIFWvC6OqCSmKL+0y9JW2gk6N/KzI/9iI2XWsLdTXnW6XiXDjsE8byQmWI2JV0hJ41lQl7fBtGOQy5FrHPUAhwWtahYc7toGfvn+8Buo8Jgw+vPNpVKLLWq84VcjrZ+0UdF1XIg9+7OuU467NQ9DadhJxDymnZvz3FeSnt3sJVErjof8pJGhfLGAXDKWUvBdHkqhNJo8W0PmheXGS+U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Znl2RldRN0RqQmJxc253N1FDcUNwS25ETG9iSmR2ekYzUU03TUxUNC85OXJj?=
 =?utf-8?B?aGNpeFpDQlphNFBqOVlUcWJHYUNsRVg2THI3TXNQZTg3eitnQTIzeGJLNitB?=
 =?utf-8?B?ZU1jN0VHMDNYdDB5OUxBOXV2OXNITUE5dzg0QUxVRmJDZkUrYktRRUxkbHBm?=
 =?utf-8?B?dHlWNWJMUDlnN3ZuRkE1ZUkvand3ekhvWnYzeEtUekpXTnFIWnlwRDdxK0t6?=
 =?utf-8?B?b3dlb0VIQjlqRnFaUmkvQXJOdGZFaXVOSkoyY3lRam1JR1J2cTREdWdGQ0hu?=
 =?utf-8?B?WHN6Qng4cjJpN1Npa2ZiSHMzZ0xpeERLaXN4VzhmUmRnT3VialVZeERjMmFO?=
 =?utf-8?B?WWhla3FYSDVMcWVqMkRqS3hIdnh2WVdZeGhVcWtrL2ZrMkRqbExNRVZWT3FM?=
 =?utf-8?B?WUs2U1h3Q1NKaFF6bUNqWkhIbFNwQXJlTHliWExWVlNKY3NWeUhmK3gwNmpM?=
 =?utf-8?B?VFhwc3JvL3UxRlNjQ1lGbkljb3JnaWk3VVY3VlkvaEVQZUsxeXdKSkJGSXRv?=
 =?utf-8?B?YTVEekd5eEtudU1TZ0JkYUttdVJ3WFRWK2RZMWZwajNxRjJuYVIvRUNIN3gr?=
 =?utf-8?B?OEZLdzRwTVllMCs3clRWZlJ5anpLK0dhZ21TbytnYWEyYStNZTJtRG9FTzBZ?=
 =?utf-8?B?aER3dVM0VVRoOTcvKzUrZDNjZnpiT2k0cGM3OSsyc0hMSWlaRCtHdzQ1dEtW?=
 =?utf-8?B?Q3BPNTdidWZJUm9yVjh6bTBVTCtXa2Z0dW03WVJCcVZYeUdUbXBVZDdSdDdr?=
 =?utf-8?B?UGxER3U1cFg1bW9pdm1WRmJEOGJPdFNFclRUaFcxdit1OHhNdFV3ZjMvbTNJ?=
 =?utf-8?B?bWZlV3I5eVNXSWpCc05YM3NRNFovd1pGNG5OVWpTVVV1MDBsR0FVTmh3aExx?=
 =?utf-8?B?cWxicDk3dGh1WEdxRnNsdStITGdmMGFSZXdyWHArYk1PZGNQdWI1MWcwK3Ru?=
 =?utf-8?B?UUVCMjJycnlDVXBrZEhRQ2V4Wnd3NTlQV3JrTDdaY1FOZk05RmJMbFc2Z2E5?=
 =?utf-8?B?cVlhQU1QVSt4cnBZekhXa1dNaDdscHJvVXlPVTR4WlBWYWgrQVpiNGlueldM?=
 =?utf-8?B?ckUvOWNKM1VLVzRjUDYzcTBNMXJQSVQyc3NPVlJIVVYzcENoNmozbW9BM1Zy?=
 =?utf-8?B?c3kvc2o4c1A4ZlIyelRVVDV4b0VzaVdMYzZ6cmFYVDljMktQTXBzRDJUNDVr?=
 =?utf-8?B?clVxSDQvOHFaSTFwMkFSU1ZlL2diL1A1OE02UHVGVU9FU3lDY0pkSnpxTzVs?=
 =?utf-8?B?MXM0dDJHMzQ2QnZubTRHbTdISWJlVytCd1RkSVduc0E4UStab21MaW5DSVcy?=
 =?utf-8?B?c0RxMXN6RzhhWXEydjhnZXk0U2NzcFNpSmVGT3VwdzdrcW5TTnlEbTRxdFlS?=
 =?utf-8?B?clNtbkRtRzB1b3M3SUx4VzlDZDZwd1FQQy9yMFJFanloM3VaaEtrcXozVnpk?=
 =?utf-8?B?YmxxRlR1dkFXb0dBVmgycFNHL0FSQ20vRWNUWGJtYjRvOTk0WUZiSG13dkZU?=
 =?utf-8?B?N0JhaCtEanJmbndGNW8zTitxRjBDVkxtb3RIUGJmK0Myd3JnTXU0UHY2S1ZB?=
 =?utf-8?B?dENiQStxZkFTeFNhTjlvSDBwY3RMUDE3SzJQUDBuQk5ZaTNya2Z5b21KSkNO?=
 =?utf-8?B?Nlh2UUs5K2g0RkJDbUlnMFhWeUdySURhY1NIbEIxWjNCcWhRbXUzMWh2R1NK?=
 =?utf-8?B?bkpqSFNidmU1UFk4L20wSmI5YVR3QnVhaFloSW90YXAwd3ozQmE2UG1xTW9E?=
 =?utf-8?B?VVQ0VGdZRThjdXlXKzJYdUtwM1pDSUtsVUVkNndqcU1XSFFvb2FoYjZIcUFw?=
 =?utf-8?B?MnFZdmlDd2p0d2VMaDlFMWUxYTVONGUvWWEreHorcEcxd3R0RVFmb0s1NHZE?=
 =?utf-8?B?MkxITnVtRUtMZ2dxdzByWDIzN0FFYTMyVUo2eWhwNEQ0cU4yS21jblhTaUFU?=
 =?utf-8?B?cUpGbjQ0dytuUGhNT0hvK0Q5alNCREJuanl2amxQQnIyVjg1VW1nbmxPcUJK?=
 =?utf-8?B?Q3lQWFI2M1pIS2pjV2QzQW5QWkVIY0hNdlM2MVIvOHRjNmd5czVOb3VCTlA4?=
 =?utf-8?B?QWsvbGhCaFF2NGM2N0l6Zi91NE50MnFEakE0SFEwdVp2RGFVUmVTZmpxREtQ?=
 =?utf-8?B?RWQrcEZsSUQrSitxZ1YyL08zL3Z0dEFpcEd0enIxdzROYzNRcllPYVZBTEJN?=
 =?utf-8?B?TExhZzViaWxkRFg5R2V3QkpYYmpaSXBlblRoemlEVC9hSnFINVdPd3VBdjlD?=
 =?utf-8?B?YTM5YzdsNWs1ZnUwYlp1Q29xOGF4NWhDcjRONVlTZ3hBZENjOEZaeldES2ti?=
 =?utf-8?B?TzY0OHRMNHhGVGdTYVBXN3liRkxVaWtXQVE4a2RpVXZVTlowQVBVa1F5TXBB?=
 =?utf-8?Q?Xbod3NL0rhyZN4q8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dab50c-8be1-481c-7fcd-08def913534e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:17:33.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4NFsFyCwjYJQ1ROxCa5RNNxluEdC+3XtEcGWBc+WRL5t+WvAPkqe2PY5H4HyHp7kvzfQHijh+9Ebljb0DrVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 08:17:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23913

On 13.08.26 10:14, Jan Kiszka wrote:
> On 13.08.26 09:07, Felix Moessbauer wrote:
>> By that, we also need to update the firmware deployment again, as the
>> previous interface was incompatible with sstate in combination with
>> hash equivalence.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>>  kas-cip.yml                                                   | 2 +-
>>  recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb               | 2 +-
>>  .../trusted-firmware-a-qemu-arm64_2.13.0.bb                   | 4 ++--
>>  recipes-bsp/u-boot/u-boot-qemu-common.inc                     | 2 +-
>>  4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 5ed7ad2..4fcdec6 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -22,7 +22,7 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 481db3b2e8949336576e50a78aaf5d101f52c8d2
>> +    commit: 86c761e45e446c01874c0a36394f8be1f7d938d3
>>      layers:
>>        meta:
>>  
>> diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
>> index 9c2bece..3f51dc4 100644
>> --- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
>> +++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
>> @@ -14,7 +14,7 @@ OPENSBI_BIN = "fw_payload.bin"
>>  OPENSBI_EXTRA_BUILDARGS = "FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin"
>>  
>>  do_deploy_firmware() {
>> -    dpkg --fsys-tarfile "${DEPLOYDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
>> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
>>          tar xOf - "./usr/lib/opensbi/${MACHINE}/${OPENSBI_BIN}" \
>>          > "${DEPLOYDIR_FIRMWARE}/${OPENSBI_BIN}"
>>  }
>> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
>> index 7fcd144..e07342d 100644
>> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
>> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
>> @@ -32,10 +32,10 @@ TF_A_EXTRA_BUILDARGS = " \
>>  TF_A_BINARIES = "release/bl1.bin release/fip.bin"
>>  
>>  do_deploy_firmware() {
>> -    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>>          tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/bl1.bin" \
>>          > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
>> -    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>>          tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/fip.bin" | \
>>          dd of="${DEPLOYDIR_FIRMWARE}/firmware.bin" seek=64 bs=4096 conv=notrunc
>>  }
>> diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
>> index 18f871b..c20787a 100644
>> --- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
>> +++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
>> @@ -26,7 +26,7 @@ python() {
>>  }
>>  
>>  do_deploy_firmware() {
>> -    dpkg --fsys-tarfile "${DEPLOYDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
>> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
>>          tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
>>          > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
>>  }
> 
> This is already in next.
> 

Oh, sorry, it's not. Will have a look.

I just hope that these breaking changes in Isar are eventually calming
down...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

