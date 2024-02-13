Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63453C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 08:56:53 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.80])
 by mx.groups.io with SMTP id smtpd.web11.7637.1707814602851691984
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 00:56:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RoPJvklo;
 spf=pass (domain: siemens.com, ip: 40.107.105.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VffU5DQQJQay807c0sd72N2sDRtExXopikxr+8dwLY54s0pa3wk9vnpl4NYo7k/DVaWu1F6YLW6Gf+Y4GdaB703+rEVE2YeiYiN8wXWyy6m02db5rAsd1OGfrk0oT2Bx8+EI54xZPSJ1BynGZo+eEaEkfmrHgWkUY41G/4KUldCEO36osGoEZ6kITYQsoJd9sGEX/izdkafRP4WYtU1S+nbmy1ScZnvBmnbMuwDpMUjxXn/ebUAcyS+Bo/N7lyYimAhJDil0oN6QZk6I7vkQcDpGDQGqbUIdfuNKZayO+7S3lYgptRRUTxpWBaFYw2bWFvtqwYNh9b08mgp47euuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1ekoj+VVPWrFcVfszNBQa0h4N6hdKm4weyc/1+lC40=;
 b=ZCqsbGHCvx5U5uLZxAKNHwaTl2ahuwuEtNRyTfsGqdeProjcfnjL9+vCGT2ZIbxdHuXZDLVTjGlm/80JqOZ9pnXkq6UsK486nWzeUeWa/nYnEsXPy7jk635JYKoG2To2C6q90ZrLZCNQr4/TiyDHqa8sytF+GiooRSRwTQxZsj274INihA1lj6w2APjSdkkQpgbSNlNn1CaBOynNoiWHdR2Ktbg/4ZGv0EtdSHr/MOMBc48hqfC3fPP3GS7EFJ1Y+15oQxhaMBiZDik/Y+mhP1yGC2RmkYjIdlKJYx861HxFXA68b52av3ftwUobJlim2UDWsXm84RnUtsgRfilmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ekoj+VVPWrFcVfszNBQa0h4N6hdKm4weyc/1+lC40=;
 b=RoPJvklo4R5UYu5Ee1d27rF33YaTNfxOhB6RSHpAE65jo8MnM3x7rgLMCZaxQ6mboxf2HepwVMdawAfOoIokR2RNKgqF2EWiVp48hogGYudzEeRjjP/SbvgHPUe3c6cKhMNgRAvwYIeCVzTVNB9HRfPKzDIjNCDSFe05mRTTdTf38dRQcXm9cwQTHQ3Fchxpo8Sp6Y+deUaBmy95Tntr4+iaif8Rn/KUttEKo0hAApD8phyZScYbvPi0nFYaE1nJlRt2NlV0ewGji9eZnonQTcRmIR8YzmwKWMotvilrBmtZ3q7hUB9E4NeLNfwxbs0eP5VGooBw9yrpcaCY9gKH/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 08:56:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:56:39 +0000
Message-ID: <21a1606f-18a4-4a1e-b078-b1ac093760e5@siemens.com>
Date: Tue, 13 Feb 2024 09:56:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] refactor: use change-dir to split
 rootfs parts
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstroff@siemens.com
References: <20240213083058.424760-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240213083058.424760-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4027:EE_
X-MS-Office365-Filtering-Correlation-Id: 7add6db2-3e4a-475d-908a-08dc2c71b120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tKaOAeclG1uY3yRG83VMD25EZ4a4WwS9E1pvBU3+GavnAhCOHZ0TUPEPLcBWak/AukhdgMtiA+qND6FKMA8tnMBrIGQxrppSEoGCX9gMLz5zVW7QlYEiNMzTNB8SDlgwu8Jv/Jm2x+avB6yIPp7vjUYRdULJ80kq2nZeGnVymtETZ7Hr8SExLDKRinPdopaU8XTsh2h08HeRm0H4FBjSQ7TO8GpBUpqJnInj4i/jP4620QzaMcHTIB5sNS5NEP/GLx9ni0mvrv0OPfzvbnTV2A5d6WgY8teC8BttsIsFD38CEU1SiBsJs5rYvCgnj0jd1G6vQi84juyOesNhCmJqkyLYyRFhWEcCU8rEXu9zqOlo4uEsnIrXuqO9nUOlJ9ska9c9ODl0xq2ZDac+jL40gldCzXJLC/Hx2/SU6HeEcfZ9PJa9GJzQ3udGas64ZvfgKBAmkwmuNN+81f9jl+5pS1Ymof5Vr9TNh+XK9kExYjhfzijYaChfxMrY6o22tk+O4aR2486H+n2IMqEiMcSbH1ArFCfxU0CoVcP+QvHyUI63iD0fbyF7v4QDivtuM4mr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(44832011)(4326008)(8936002)(8676002)(5660300002)(30864003)(66899024)(2616005)(83380400001)(107886003)(36756003)(38100700002)(82960400001)(31696002)(86362001)(26005)(316002)(66476007)(66556008)(66946007)(6506007)(53546011)(6666004)(6512007)(6486002)(478600001)(2906002)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUF5dm1yK0V1R1JJcGVLN0swd2psNTk2bmltV1FNbmtXTzdkWHBwYXI4TVpt?=
 =?utf-8?B?NDladUh4cHZIWWc4VjlyZTFKcUs2LytJN1ViUDZLU2VBVkRKRmkvWmQ0RzdG?=
 =?utf-8?B?QUc0RGlTTlM2Qmd6d0pZQmQ4TndKSytFQkRMSTlHcCtHSWZtOXEvZkJSejds?=
 =?utf-8?B?b21KZ1kvVmN4RjNjQjVqZ25Ga0xRYXQ5UnpxS0p4ckZmZUkwTjA3dU1tNWZm?=
 =?utf-8?B?QU5SQjFtOFhQU2NDUXlVRm5ON2l5VU5hWjFFU1BCQUFLSXBqZ2o3TnlIcEFY?=
 =?utf-8?B?YkVBVStqSDY3QVFxTVFSeDhvRUVwQ0FCZEFKcWRBQnJmRFV2blhMaFV3VTdY?=
 =?utf-8?B?TVJZUUlHN05QL0EvWDVlakZhMGxvcUZ6TkZWUUtlYi8weFI4MGdja042cjVi?=
 =?utf-8?B?OHdBbDZsZW9wSFFPbTJUSEJlako4S1V5YTBGbTBwYkRPcHNqS0JFN09ZdENK?=
 =?utf-8?B?SnZkZUpVZEIrNmlwWjNOeHE1cWVQUjZVaEgvOHhNWUo4d3o0b2dQamRTNm9J?=
 =?utf-8?B?d3BST3k5bVlBVmswZXVUQkhSV3c2bmI0UGdPLzJnb0p5dlpxVWMrVUxCOFlx?=
 =?utf-8?B?NjBCWG9sdk45U3Y0VFFLUEJBTkRuWDlGM2owZ0hTa1BjRGR6MVZxejdiTCtR?=
 =?utf-8?B?ejVNREV1b0E5MDVlNXNyQWFSVm5mM0YxSk1ZZ01RYmorc2N6Yitab0tJQXFp?=
 =?utf-8?B?YjM5dTNMM0xDMlh1dHZMdEVVRGRkaXhiYVc4Uk1iZ2RsZkNYZXJYV3RKOGtz?=
 =?utf-8?B?eHFtUEY4ZCtjV0lhVHh1dlJFUU1PME1OWFlxNElNRjg3eGw4TWhLcWNzM2FY?=
 =?utf-8?B?NVFvOVhQMkhZekdESFNtSGY1SXJDY2dZeENmNUMxanpPc284bm1uZGVVL05E?=
 =?utf-8?B?dDFsUUZvcTFlTXlVbC8rd0NBV1czSHoxcVptaS85clR6QndMMUR6ekd1WG5j?=
 =?utf-8?B?dHRUQkJoZnZPMXh5Ti9NdElRd20yRm1kaG9KandTQkdUZklmZjdoS0l3Mmht?=
 =?utf-8?B?Nm1xcUNIN216RWFSc054d2cvUXZhWHhaUUNvNWswYlVyRjNyWmQ3aitJdDhn?=
 =?utf-8?B?SWsyY05GMVJMYk9QTm5ERGhlaHJnY0dNVTRvNWpMMjRsK3V2YmlOdk5xTzlR?=
 =?utf-8?B?NHZjY3JsTTVDOHdBeitURWw2dnFUVlZpZzFRdHBVSEQ3bFdOSXZOY25mWlpj?=
 =?utf-8?B?ZVhyOWlMQk5QYkNMc0lCSm9sMmljdzBTWlUxZ3JLcjBPdkJzbzFFT2hkNExj?=
 =?utf-8?B?SjkrM2VIWW12eHEwTDQ0Nkd5SnJkYzFKb2xKR040alY4S1g3RGVxOENHUU1r?=
 =?utf-8?B?ZVcrRzlKa0hPMGFGSzc3amxSdWhoamVGNlFMY0IrdDdZNlRmQjNnMHBxcXEw?=
 =?utf-8?B?cUppSHIyS0JDbVRUcFVjeVBBL3QyT2NlT2QyWVI1TzNxVXZ5bFVSV3pvKy9y?=
 =?utf-8?B?MmxWQWg5Vk1IU3BvNkNrZk0xWit5YUU5MUJEcExYV1VHeHBON0VVUVdkL1Rw?=
 =?utf-8?B?UlNRNUFNdTBDWmZYbUlXMU9qY1J6bHZyM21wK25pZzFmeDA3T3R2UjFhUm5l?=
 =?utf-8?B?RTFYR2ZEUEVkVkRrbDVpWk1KZEk2YnJaU3VlUzI5dFRITUkvdGU1QXhqbTVK?=
 =?utf-8?B?ZE9GT2JraGtlQ081azJQUTZjeWdFeXhvT3lJTy9CTDVTazJVdGkyTHZQSHg5?=
 =?utf-8?B?eFhDQjlnWFJtZVhZeVRidG8wZk4xUFBYZk9NZ2xpVWRIaThXZVBsbmJxNU9q?=
 =?utf-8?B?WUdwZFE4YThNZGU3VGVLMGNqWDlqNnl1Zi8va092RVlHVEJXV0pyaVVqbHRX?=
 =?utf-8?B?Y2xmZ2JvWDhYRjhQTDQ3cFZNU29HU2tLWVBqQzVuTXdkbUxXVEttQWRncTZ1?=
 =?utf-8?B?bVpMVWVLdkhKcDIrTlVySmtwN1lPdy9aUW1TUXQxNUpaZmE4MHpPREltY1JX?=
 =?utf-8?B?OTA3MGJ5czNiY09kcDcxdzRZNXlnNDBuU0d3YzZhbU5icnNvSW5CQkJJRXQ3?=
 =?utf-8?B?TDB1d2IyVWZQZ2x3Y3AreTc5SmZkMHNQRkFsb3VhcDhJbzFMWEpINDhXTTMw?=
 =?utf-8?B?aHV4Z0NlUncrbUJvd3c0YnU5cFJOOFhWeGVBdEM2bk10NGpralg0ZHptNzJY?=
 =?utf-8?B?ZWEwR3hpN2gySWlzRTZ1Q1hNYVJJUVBjY0dGV0JDRHBlMjlWU1haUWxYc0VL?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7add6db2-3e4a-475d-908a-08dc2c71b120
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:56:39.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3xCWLSr4FRErEP4hz9775Kz3ne9d64YmyKkG8/xu/Rgrdy50ljh4OwPch32G5I+A0XQvwOAEfgjnLitfxAPyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 08:56:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14934

On 13.02.24 09:30, Felix Moessbauer wrote:
> This patch refactors the WKS script w.r.t how the rootfs is distributed
> across multiple partitions. Previously we used rootfs-dir with a full
> rootfs paths plus the sub directory. However, this is not ideal, as the
> relation to the rootfs folder is lost and also the new rootfs dir is
> technically not a rootfs. While this aparently did not create any issues
> in CIP, we still believe it is semantically incorrect.
> 
> This patch switches that over to the WIC option --change-directory that
> is provided exactly for this use-case and only deploys a subdirectory
> without loosing the rootfs relation with the permissions pseudo dir.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> 
> Changes since v1:
> - rebased onto next
> 
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-efibootguard.wks.in                   | 4 ++--
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index b9c8f3f..b4a3ec4 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index aa704f5..4e43178 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index b16da0b..a5d94dd 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
> +part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 22e23b4..291b97c 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
> +part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 7fe68d9..2f9d4f4 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 19ca1e0..83b1d6e 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
>  
>  bootloader --ptable gpt
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 43bb782..f33bb7e 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


