Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB39BC77B73
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 16:54:21 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.77])
 by mx.groups.io with SMTP id smtpd.web11.13859.1685206461073296751
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 09:54:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tkQHTvK4;
 spf=pass (domain: siemens.com, ip: 40.107.105.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7yXQwKvlnllKgfC4fKyCiC8Ks4L3TYAW2wIGZ5HX6uhmTCyMWIx+0423fcuu08xbxOSsGYQAn6pPvD1L3NCNkiKnr9riZ+t9yUYslhq0aIsHCWai+hu9rwE9QeUuezWaZUcMKi7rwulTafhXoo72mfEMHtpnMUP5UbTJMnGQYFMu3jBuva46xbf+75FG2oWlw/PDifGYm/UwpT54t0b+Ue/R72YOaxVZ7AlhrZ5YrX0xtiT9945jWqmS/vRyM0PnGkW/q54qAPG1rjd1Npmn5qivYbySrGAB0MdL0Y7VyhnbSuhwcDI39gvQetTw1rNXaLLIOYwmrJyYGZQQwUkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itLXvF79AXQPhTMBsUnSNBEHUAFo/BaENU0APC5fTeM=;
 b=AajGzE+f3i6OCZji1fmkAv+mlGsSq0wc3XL0dQyF6fXtr2JPTWxwMmd9morhIpkfcbKHRRjpO2jPPMxrBL0tKCgOSEqVNbSA4Z88jNMs7UiblZZkc+wdrmd70r//mUvLtB030A0JU5tOvSS/pjRld3Igua03nevQZIXWVfrrJr+zWDFJW9NEKmG9Za20eyAK5VPyO9vPlGkhhc9+px4PHvRS/z8GPbtD11+l9gHYgYS1ouFNQILwkxJ6fbrbBbVPYHEqU/1hHN/nEuC6wJAYfi83qyoTI1wUOTQFzBfBGW26fI50Pxg5dlqmfJBMYDomi+h5/JMOOxIBYDxwbVSlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itLXvF79AXQPhTMBsUnSNBEHUAFo/BaENU0APC5fTeM=;
 b=tkQHTvK44fioHYimq+dAeIHwOdE6wS3ZmETvtxabymhBDD89rfTNDwZIVzihW3fN7cpBsjc0R2E4x+RmE1NLxAYkwhs+i5nIX0V1NuQJiwONaxyzyx5F0qJqpQFduAzVPsYyf1jbtpFs6b/K+uDWgKhlS4cdm/NZnMzZuzKYfRVFkGNQ3arwdFk1Jw6CdyqVQn6Jf7QyTmIACS7ZD2MGYglkZcBw3Qr3ro14WgqL8nTaDzwy95p1r3gTzYpnI8F+Z5Wl2LgWGjANQ7fSn30hKWVtd+nyarF695gfVT2CMffjcI4KbGg/M9pNQCAPz/u7/yB8o6j4vQVKCzJQMKIsmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 16:54:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 16:54:18 +0000
Message-ID: <1b7769ee-84f1-cd29-d9fb-0560b0a8599b@siemens.com>
Date: Sat, 27 May 2023 18:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] swupdate: Enable SWUpdate for RZG2M
Content-Language: en-US
To: Hung Tran <hung.tran.jy@renesas.com>, cip-dev@lists.cip-project.org
References: <20230523082947.5774-1-hung.tran.jy@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230523082947.5774-1-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ddb15c-add3-4dba-bb84-08db5ed3028c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yILEb5Y3w7Yg4+lp4eSY890kSI+FVrRYRxML1e6Bc/595ea1IHEwvnxotDWQfA4kSNgWuCZeWJ8vJT0do4csLwfRs06zKgfMkIy+wCt7Czb2jLgHhfW1l3gqNs3cPjKeJGb6SrS/iw+saM3QZQB82I5HA3Tj4/BcfOzu95smwBh96SsJup67ssOqlz0JedzaIefFNITOeztxoqlPVBUoWKu/bTq35qy7Wde3eLCIuEn+nt+uWIo1WwemEetqT+i+smyChf7OpYIFhBmqhZKMuHexjyvhd9/x5oSIjBovWru4PWDvkMuf1ZAtB+3a6xhQ6KuIudB47Edd9CkFTU7fNK5D8pGV+Uukc9b+6Z01EnyTZ5/mT3S8ikUgtx9H0DO34xhEHqDREnHQERstsW2Y4wZbZcfS7e5etEzx6HuSQjiEUDoIL/N6s3RPIZ3AOmiomcpedjeD80OzbFxxECcmYPuQ2ZYUAwJbR6ATYvaioGeLKQvUySffORA1vmFUR/Zh5mN7I58n+4gCWMUMQesKvvU6ltJJfdolL41NVho3r3FLrClcL2xga6I7ki4D7V0dckSCcZh3BmhDLmuDPJKzInOvW4K8yINZxCPuOoJ1y9zg82HplZZe7mJTQEIZ+0H59MjBc9w6yZb7vztGtJ2LGNbIj55VUN4R1BRp51mPe3gVlkRpqlV1IpWCbXRgTG+yDLtCY90L7miQZ2np1KcNRh94YrLOb7KQ19jV+iaWrB4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(6666004)(8676002)(8936002)(82960400001)(38100700002)(2616005)(31696002)(83380400001)(86362001)(53546011)(6512007)(6506007)(6486002)(26005)(186003)(478600001)(66476007)(66556008)(41300700001)(44832011)(36756003)(316002)(66946007)(2906002)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTRhSTFRWnBWTmpsbXhMWDh1anpUcEhSL1V4WnZrRnFJVEdpNEhqQ09NYjhD?=
 =?utf-8?B?Nkgxa2hVaGxsQjJIVzJ4VUZGUlF0Z21MTmRyMHl6YUZId2RuU003akVNSWp1?=
 =?utf-8?B?WFM3VjFlU1NHcUZHdGhuQ2QwdVFQajBlaGNYeWhWQ2oxSzVYN3hLWU9XSzJy?=
 =?utf-8?B?WEsxdEpzU3d4R1lLd010bjgrTnNIZlBxbkF4Q25qWHF6aHNxUFB4NlBQc2My?=
 =?utf-8?B?SkN3S0JKZkI4VCtXSjBZYzdYUER5MG4wcmpEV2xqM01PYzI1TVhpMmtnQzFs?=
 =?utf-8?B?MUNYdGhrT3c2azNOMzlGYVFSa3g3OHN5Sng3M3lmVUszUHlBdXNYUTY5ODVP?=
 =?utf-8?B?SEhKTVlGZzZxN2wzYVgwN3RGN28zajJHSTA3ZC8xcGgwZWh3M1hieExnNEI1?=
 =?utf-8?B?SmkveWtsSHI1MEZQYmNqSmdDWXZwL0IzRDRGRWxRVUdZdnY5OFRXWWNZNjZO?=
 =?utf-8?B?MWQzc0UvYXk1bkdvVlNvenJUYi9jU1B0UnRXWjdMK2dwNjJpTTVKRDJDZWpF?=
 =?utf-8?B?QmlVNHJvK1BGc3hIZ3FDZllPNVNNcWVHOHZlRW9BWUsrZWh3THlvb1dRcUJy?=
 =?utf-8?B?VG16akhWMVB2Y2gxWUgreVUwQkJkNzM0aDBxNC9tZzBFbFVzcDlXYk4ySWRD?=
 =?utf-8?B?TjJJZllyU2hYdHRGT1NQSkxLMklkWXM5VXhDT3laa3ZXMEdlbk5GdXZIbVo4?=
 =?utf-8?B?SDBoZHRYcmRmQ3pxMWxhbHVmTVpqSWU0Q0ZKVndaNFNoRjkyc0VZYTRWOFJp?=
 =?utf-8?B?enV3SUNQTUl4RTBncWVoNG9DM3NZVmJpK1NVNEZQcHJvTWxBdEZ6WG1wOS9S?=
 =?utf-8?B?dWFjQTB6dW9CYlp2ZnBYSHU4eWtxeCsrdHVGSWk0VnRiNHA5MXlidHFBYyt4?=
 =?utf-8?B?Ui82L0R2bWVLeXp0OWhVbDdqUVplNTAwendZcU5GdlNzWmRiTjZpdVpqcDRJ?=
 =?utf-8?B?aCtORW82eVFDTitWL0VwRnJpWXY2Rkd3MXJadnJZSE9VU252S3l2b09nNEE3?=
 =?utf-8?B?UWhReGNySUEvYkpUbWR6cWhPTDZkdGViT2F4a0J3eGJVRUx4NTZCWnFOdXkv?=
 =?utf-8?B?bWRwNytJQzVNUkpMMzV2UDJUQ3hBVytESlRZWDVDU0VUMDNhSTBwUjZJMVp2?=
 =?utf-8?B?OC84TmpRWktWc0lYNVFVNDhFVHA5Y0MxcE9GNVcrTHZvakRqaENzZ05yUUlm?=
 =?utf-8?B?NWxWNEZZVnVQQjVTU3ZjSGJyNUxsY3p3blhVbDJ6VkVzMURCbmZuU1JxQTIv?=
 =?utf-8?B?c1d4R0RwNjlGZk40WmY4elJkWlMrRlpIL095N1ZZUmQ2ZW5Ud2dud0VTT2JI?=
 =?utf-8?B?Snkza0dKZHdPVExsVnRGemtoWkVTM1ZxdGsvUzdGelgva1VlMDcwS2QxN3Ba?=
 =?utf-8?B?VTJZdUpWODd0ekhrRDhIWlNtNTdsQWl5MzY5cGZEUUt4VnFrUlc2K3RDS1Bi?=
 =?utf-8?B?NG1wemlyRHFzQ3FEbXBGai9EQXVBNzI0eXg4OXRiV3N2T0J1Y09heEtRUGcr?=
 =?utf-8?B?ZVFUb043Vjg5M3ZZOVBsWnJwNWp3TkhEK1ZQU1FUblk2bldrUzB1aDB4TUhY?=
 =?utf-8?B?Y3BEUklUek1WTThzZEJMd2VZYTh5ZnlCS1RCOFNaWmxEVHZ0YzVsdkdJYW5I?=
 =?utf-8?B?dFZJSk1tYjRxeUE3STR1R2VQWFpxWk9sdFNqOTFmUnVtRE1JQVR5Um5IbXd5?=
 =?utf-8?B?SklXT2M0NDdUOWdrdjFNM05LV1RyRnpJWndmNFJGUVFNaW5Lb0dValJmdExt?=
 =?utf-8?B?cGxTalozNUEzNU9yNy8rZk85UnhiM1RtSzNqUEFSUXJ5UmkyMXZYSmh4MDBN?=
 =?utf-8?B?cktKZ1BkVlVZdzZSVnZwdmc1QlllTTZ4UkJlMlNpSmY2Z2pIS2plcjlTcUJs?=
 =?utf-8?B?eUU2MEcxOWIxdUNIM1IrZ09RZzFFL1BDYXBMblZ1eU1weTNEMWNwbytZbmFI?=
 =?utf-8?B?cmRaTDBSc0oxL3dTd0FWc3FnSHNrOCtjdXlLVGYyZHg2TGdJOUpKdFFia0lC?=
 =?utf-8?B?a2g5MTJEUkE3SjFLc1NrTlVOTTIzZnlMMkhYVmVHTU10SnJKVVo0RTdXRHZ5?=
 =?utf-8?B?RHNDaXpLUkdlbGEzUWFNZVQ0YnR5MDZYVmxyRHd3RWVnYXMvdytMclRFR1V2?=
 =?utf-8?Q?wnQW/ESaFqDs6OZkQW7lTRfrM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ddb15c-add3-4dba-bb84-08db5ed3028c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 16:54:17.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUh4zJkZNlf92uNppZnyn2Kf3GYESNlottwI0MaS7IhkIWhhktN7+ClUwQysPsKH6Z/O9ma4mOTifeEUE3P7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 16:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11667

On 23.05.23 10:29, Hung Tran wrote:
> SWUpdate will be available for target device HiHope RZ/G2M after
> this change.
> 
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>  Kconfig                              |  2 +-
>  wic/hihope-rzg2m-efibootguard.wks.in | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>  create mode 100644 wic/hihope-rzg2m-efibootguard.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index e1e187f..74fbc76 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -181,7 +181,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
>  
>  config IMAGE_SWUPDATE
>  	bool "SWUpdate support for root partition"
> -	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE )
> +	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE ) || TARGET_HIHOPE_RZG2M
>  
>  config IMAGE_SECURE_BOOT
>  	bool "Secure boot support"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> new file mode 100644
> index 0000000..dc32729
> --- /dev/null
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -0,0 +1,14 @@
> +# short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
> +# long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
> +
> +include ebg-sysparts.inc
> +
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +
> +# home and var are extra partitions
> +
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
> +
> +bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"

Nice that no other changes were needed to enable this.

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


