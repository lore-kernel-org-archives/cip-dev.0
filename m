Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4429CC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:53:12 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.67])
 by mx.groups.io with SMTP id smtpd.web08.5386.1666774386140237718
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 01:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=F37205Wy;
 spf=pass (domain: siemens.com, ip: 40.107.2.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Jv2JPqBrMKQ+eL5qmiISdIjET/NwVvmxxiTyde2KQRZDq2pZKYzr+gmzHy7AgUJ1nvunr4AO8I2gF+YgwBELxBMHi4goIDH+0NAPx56eV8YE5n0V9NTHukmovxEQaeJsdoo4Ml6u7GwIvMvEL6QZK1nCjJyAvNXAXEe/BU8NCIYwXb6VQwm02c0IzVzUvTb46k5lgyHcsrMSuiU7AQKb8AlsKTAnmIOCwVoLXdrTd5SLWyj2woA9gg2z7G8L8aOmYauEb0aSovsgtu3aWx6pVo5IBafB1B7UMPqqTZY9gV/qIXlgtQc+8exjKkQ5pxIF+vxClZtab5VESF4v9h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GetiSjXeNzMwltCm+W8gnLDRNY+0ModG8g1OEjZ2mQ=;
 b=OhhOArCHYE6oFKOD6d1fkHQjjtXZhhDTWaoQZ3pAWouOjfxMnlbSYFkWTDLG4RBXYjEaTLtf/Ihk7PPoQK333AdBaVVVgp5LS29I7l5YXR6fK/SljlkOdFFHsYaAOGZ2ON4R901LYWSyDS0nTyd50dOzslSfwna16d2PouZNBEtMLVoZddXe7t4C52LlhCoYvzzBSBygh1gOM5khnoSLMnzLivSQNZsZxdRhtfHYcBdXL+DAbsNfRsDRvkrNo+3OazwISSS5FGXSn97NXuWtqjF6PXw/A/hD7JRGeWo1y7XkdZL3hlItZI79p2WZ5GhvCdoS8hGB24fPc7qQ1r2A7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GetiSjXeNzMwltCm+W8gnLDRNY+0ModG8g1OEjZ2mQ=;
 b=F37205Wy6LYHz0JEIvwH8oNlAkxsOX+Sm1kv7Bjj9rc4zvd3DF/DUtZpwuHEowvIGmYUwiXh+itLwDanch1Pn5QLrmETxaJKcX/D1VsSCXCXielrCmItH9KqSenTFEY/gK9zpd/QHXNT0q75f6QxgjuVaaqZ2UoyZr+xR/3C2hOHWLhi/v2u3csdmDpval5TNcxoYl0bd6+erGOBQakOnJo1D9XWOPB8UiJH5x+xUHpK3gYM23lq8VzMecExW6Xg6IWtzt4Bhm3FPyw0uOH/8TxHVdo75cDRN1iH77D99wP1GZlimdaH9nNyK/N0M32EQcUxLQzkNVuT+oPCd+vS7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:53:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:53:02 +0000
Message-ID: <d8d40615-4e43-86ad-c947-cd3c0827e389@siemens.com>
Date: Wed, 26 Oct 2022 10:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Content-Language: en-US
To: "Su, Bao Cheng" <baocheng.su@siemens.com>,
 "Schultschik, Sven" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-4-sven.schultschik@siemens.com>
 <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ce9ed4-d796-4b3e-d33e-08dab72f7dc2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pPxGg+HJAsdzy1UQpuZ5K3krDWZUDVrFgc6VpQeC63SUPf7QiyWSkbqSL8lnSeWa6aLdDq6zPRcNxJxl0WZ6FovYysjWOjtGVQSolFi1wWPHa9CkElMM9g/3+uvbyVrkzM7j8u2dOA7QU+VmkMjtS9R2WvuO1rbvM8YVt8iBID2/wV2m8W5Q16uc8Jqdh5vBjV0fq0WlGemdCezTni9V2sKXPu2VbTU18SCSECrhHnwlu3ctEba8Ysnyz7VYURjoJhPr/HeEBWvOfDMEBqtStwUo9myEJjpWpLjoQ+amA8yOKG+pbkb8gwtOailVPYc2PBd6hFStMnoAEgFwthbqOuDVZ8ABojr57fgFC3TnrbcmQVd1oVXoNM/GTHuK+Z450q62tnAck9nRyziU8vwoEBzlC3nm0h4BGLEISBtaartzFcDFgP8N5U+PH2PqxG/a4GVOSaoLA1rSS6+AcNnz+iziK1qvDNNmlR53G1g9RA7wMYu7UhxlgqFfdCfi7l6mlG7MrEnO5c/7a5sojl9dLQsjKEMuSM25fAZme3rx7FeGBphc2Xkb5RszIvYI4XQzrZPwQ1/lYR1QUSe9DKKD0uBHfhAUhNq1xpPB523zQHK6eE1n+1pgGV/iSBparPFUERlm20bnFkLEOPkELKkjskERoyKB5rxzJyewFBAD2bjduT4KkmwPZAXmDLTNu0MVBtf/ZU9TlczIdoTJL5Zr4hepJz6byi9pyHaAIzzW0jDo8OUB50ake/nW15W+63gon1XlUjdKGFuXkqM8NzfWG3oHXU8ZI8SxgUcWaWHqZQw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(2616005)(186003)(31686004)(6486002)(6666004)(2906002)(4001150100001)(38100700002)(82960400001)(31696002)(36756003)(86362001)(8676002)(44832011)(83380400001)(6512007)(26005)(53546011)(6506007)(41300700001)(316002)(478600001)(66946007)(8936002)(66476007)(66556008)(5660300002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5AUTeJ8ZKUFyOQmsGIK5Q96qeNz43AQGxwB9CK5RwygsoH/mPYq2wELkwq2F?=
 =?us-ascii?Q?z9RGbDJ0MhbmAqb/WFJRGfPJ6lI7IYZrSN6Aa9QdjHKpc8RDWSBlmtC1yCrK?=
 =?us-ascii?Q?4VgsRQa7fJLWWMYh8DEW7vVJXlE1KwP1fm9vi1VhugkO93MrS66nSdqoJdkP?=
 =?us-ascii?Q?JYxGsAemUzvX/bPh/GyukV4cuOAZ1PmSJPmBWu0OzqjYSgC+Dh1VM2L5cbcm?=
 =?us-ascii?Q?2z7jv2NKVhkR2vU7NrXgzh5yuN1acHNI0aV0FBE8KoKd9/T0kpQoiHYFtDb2?=
 =?us-ascii?Q?rseKYAzO9M7a+4w07YRRg05PyeLgE+5LzFL1S9KsTcdD5eTw2I6Crk2FDZZc?=
 =?us-ascii?Q?rrpBaEBP6lkJAP/0DNmHMtQatrnxx9Bsx0C2QXTiviB8vsGJ9B4pD4KY7Onq?=
 =?us-ascii?Q?qosgwdwK6kqDI+4O1sfROw37NYvN4K4qWfYIeKW5pcfgHtAx0xSxlulaaa4O?=
 =?us-ascii?Q?N1FH0uZGZ8xB6b4medUNr/spcPxz4P/WKbllK4xDSQUYZOQ7mFPKPGtgfdfp?=
 =?us-ascii?Q?ZKjpxawyUXHiDo+l4FVOs0Z2p4DvF7O3A2EqOrU+2lll72Gx4n98jdwYEkcJ?=
 =?us-ascii?Q?vqfW1IA4NXCd8SBZHIvqBDQZOxSSIWyfUocjKt0g1ky2o7LzYJMGds+utz9B?=
 =?us-ascii?Q?UErFJCWyZ51nh1ID5Kye06hotVhNn/IffSR5yEqZBKiuyWUkAQbv2bvsFcOT?=
 =?us-ascii?Q?ABWA+deuETvs6qGFvywus7hvftpnK1xRubu5nwXEIVkVexZ5DIAONDUX7UZc?=
 =?us-ascii?Q?QhxYP9lBsR6RuEfovWMHtnAI/F7pL/13YEnNIQ4acqr0MdjVFMdME0IFhQrh?=
 =?us-ascii?Q?vBfagf6l+q2nZJVNJf660FyGcHq6HoJpYBoFsbtkS9OEgoiqlU5u1//z/v//?=
 =?us-ascii?Q?240hRTW1GumRgMBaPVmJF4r/GM7/eRcB5OIcqDIQWnBdfZalwZ+AgsBEWjXZ?=
 =?us-ascii?Q?6PKvHIB+AtijrJIh6kOLOg0RMqaOZSYY4xiVcnjWCFVxPmx0dk9qLn5KiT30?=
 =?us-ascii?Q?o9CAVrSBL4qBa03XSNQomTME6cm/4jzS474YqhJ1mlDjqu9h/wqcXkYI/TPm?=
 =?us-ascii?Q?SLNxoQ5FE6VGNCN9C3nBiGkBDszHdTl8wz8QIWJO0CrBCWVGkORWUA9IPGxC?=
 =?us-ascii?Q?pGql5cTxyaCPDVAgxTKstjlFYE/gOYZb0vU7NJ+YsjXUqtXca/Uf2uMfpg/K?=
 =?us-ascii?Q?8eqZXAapNP7qcdjCBcos94/mtcbCcZ1d8wZTKJqfnT7MomAQoewypEMzsiLR?=
 =?us-ascii?Q?UVy3ZqvQ77Rj0FpMJ6WT4eXmm3koehPSbfME0Zf5abd2mT1ebpsbSn3WSEWE?=
 =?us-ascii?Q?K6mYNOr1R8pVK7RBssxvKE8xCy5NpFWPiaZ/fyfvsFNee20nlUu7RM+02jJb?=
 =?us-ascii?Q?91uPjdePRk0ei2J68819YUMPat1Xrwr2XentT2K731BDN3YoaQBIKL/ye1kF?=
 =?us-ascii?Q?LrZwANnbAMY1/iFOszwi219O5WwmBM+BCh2iyQHClBvyHIUy/6r7dtdE+u4g?=
 =?us-ascii?Q?USrhGz0lGbbQmvatygyn3i/cbhoTNJJ7mCSb/jzFRia8/uLKwtH2/1f2bYIx?=
 =?us-ascii?Q?kA1U9//cbrHgYIOqPR2A4XlVkBYRfuniYypobbpzluy1JPO6eAftyUkyi+49?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ce9ed4-d796-4b3e-d33e-08dab72f7dc2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:53:02.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ63/XjRRQoQKQPePF/VvG1xRcMxYxhYBNJ8630TZJF1UmnMnWvVQ5HDCCHEbmHYzPY9qXQVm2AbC6xfzl60Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 08:53:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9844

On 26.10.22 09:36, Su, Bao Cheng wrote:
> On Mon, 2022-10-24 at 14:27 +0200, sven.schultschik@siemens.com wrote:
>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>
>> Optee is part of u-boot In the secureboot scenario to use optee and RPMB=
 as secure storage.
>>
>> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
>> ---
>> =C2=A0recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 7 +++++++
>> =C2=A0recipes-bsp/u-boot/u-boot-qemu-common.inc     | 2 ++
>> =C2=A02 files changed, 9 insertions(+)
>>
>> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp=
/u-boot/files/secure-boot.cfg.tmpl
>> index 956dcbfed..8e6428238 100644
>> --- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>> @@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>> =C2=A0CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devty=
pe} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${=
devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_A=
RCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootc=
md; echo 'EFI Boot failed!'; sleep 1000; reset"
>> =C2=A0CONFIG_EFI_VARIABLES_PRESEED=3Dy
>> =C2=A0CONFIG_EFI_SECURE_BOOT=3Dy
>> +### OPTEE config
>> +CONFIG_CMD_OPTEE_RPMB=3Dy
>> +CONFIG_MMC=3Dy
>> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
>> +CONFIG_TEE=3Dy
>> +CONFIG_OPTEE=3Dy
>> +CONFIG_EFI_MM_COMM_TEE=3Dy
>=20
> According to lib/efi_loader/Makefile:
>=20
> ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
> obj-y +=3D efi_variable_tee.o
> else
> obj-y +=3D efi_variable.o
> obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed.o
> endif
>=20
> The `CONFIG_EFI_MM_COMM_TEE` conflicts with
> `CONFIG_EFI_VARIABLES_PRESEED`, so you have to choose one.
>=20

Right. When we switch this, we also need to switch the secure boot setup
procedure so that the result remains securely booted.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


