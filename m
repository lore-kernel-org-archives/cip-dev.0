Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D8FA373E
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 16:00:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.74])
 by mx.groups.io with SMTP id smtpd.web08.9328.1666800012600898869
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 09:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hxJR1veA;
 spf=pass (domain: siemens.com, ip: 40.107.8.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2JWBeaBK0mkBPwUx1vNY30rty8FI7RWQltCQkEXMMQKn6aMMhurxWh6G3D48V+hFIjEWawnr7GhqTX7ltnCgKbg6C6qtJApK0fwDbmongwGQg5wsZ6QhdLFH0UtYc2MDyLeSwhBfAB44+TtopR2sAqvK3xxUQjYiPmp3e2+m8z2lu+pbdeRp6PlwBaTFQ+uddnYFUxTPGNZZo90BCTFdQ9O9qJqnBWVy+uYHksD1TWBoSA9N1wpDuWJstwxCT5RgT4M+MVS2KBwCY2ayRu9eNEDIVJQhL3xuK6OcFaKdtmHLQtl1FUkWUd63ysBb5aecCZbVnfr5um4TUPkdnoFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2W1MwhDCIFNCStUbOZKLIefrO55Ka8b5JTtNvt0EKk=;
 b=Hkucehw73+2oHpNuzB39s3daqGoAtzfJyFSJGH3+82/qGzAL5IR2krTWF9LEYWlk5buSac7x6gm96mwbmzUEmUcJ8ABKq43a9HtGSI5+e+zmKBOSk7szLA/Y4iGcb3nxhmGa7P/SUEMEiJgg4Pv0c4c+5zkGJ1+/YuyjULP4nE/ZRf5lyfkAkHtl0s9Z5t8evsG7SF+5mX4xW2E7P27n7oq3D/9dEqxbR839quDiN67vQH8qPL/kZQySCnHk9z7ZnPDLsqSvU5wD40cRPNqQYFcJOBeBHd3xuQwbiO+AnnmSX5JmfrAmj29QSzNwu+UREMndoW1UaZDOcLM0/Xdjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2W1MwhDCIFNCStUbOZKLIefrO55Ka8b5JTtNvt0EKk=;
 b=hxJR1veAd7uYuJDb8UePP0XMypkUbWRt48LyPkQhD9kIOeRLtRnfDUSGWa1r7mQoZJkEq7cP2T2+4MaicZcSg4HdBOBzoNMhbxskaq6gezic1LmvOvqlK4ZI981C3rJQbj04YrHROcspNT/1ueEc6BAMb+dN3OZCiTbyg+iWjwSNJON2zGBPaR9tppNTLBv/3Qf1L8wRbmkxeIcNbk9Bi9yZ33hXSP7PNkUxmcz1o218Aj2H6ojAWidkhir+GXqlOxq4H1JFTp85bADbMlJbZi1jt3QI7dl52M8E2D24I8cUnfNk1fg6nBnqBlSTiG20bFhDdDic7ImkQZM567x6Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 16:00:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 16:00:09 +0000
Message-ID: <4e5a1133-8b45-2d45-101c-b059a89d6251@siemens.com>
Date: Wed, 26 Oct 2022 18:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-4-sven.schultschik@siemens.com>
 <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
 <d8d40615-4e43-86ad-c947-cd3c0827e389@siemens.com>
 <PAXPR10MB5037772EDDB7F8F29463E6DB90309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB5037772EDDB7F8F29463E6DB90309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: d18cdd03-da01-40f0-ac4c-08dab76b281a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qa++TDr7JfJhdRtzngNhL+H/6axOzHQ0sNzwOJNUj3DA575OBmOwpxPsbCZMqazPDWvhj/upTGA05nM0789iD3hhlD/Z2oE/toYvkFRbigBTcg5cCb48hu7mmft0rddYuBYj/WHaP7Yl5jPkNZtetNitqP3q0Zeh01Q8rfILVtGzzDd8t/pg8Edvg4ck0g5Ou52HPe0R4BpdoErqXWI2wAP3C2GrfDBOdHW3/xen4zOPAHJuo93ZuK6FS5ghbpIjIkBESexSOU9CRwIcnK1sjGOnWSeBCXTJH4QTxBpqye/4zIEOoMOE4Gd8fpe3OC7OB7FwH7aHRwvZE/YDg4r8yRxqm4wEbuSUdP1buLN6r16gXMciEK+AofZnNSTptOPmaSb3FC6PeUUW0j10s78qrysWGTIQY+zVznTqoqld7gh54XFzAc2DH5SRTgwmPfTYgPJuY25Yjp9aVRcMxrwurWqk9Hv1seiyN1Oj1LePgtsLxEjCJOA/ZBms0343CO5B08DbdJCNVT6iXptAhCF58VWHybmbzSD+NpI6pLZpdnhk4LfbQPc+dIDVhYEIVrtuqqWBDtAyCaciKJm95PooyDFYIkKE//woiNGTJ6YNzkbGpMpxwEcMeVOnDLgu5pc41Q79yMp9OW3CdxslUKClQkOLlwMYJnaNYtq34TNvcrjLBUBSjy47LZ/0yqe5O8NLsSgFpd6mq9RTP2G4k7hzDiS/Cw/zSkOca7x0wUCN4vla5nNAD62Cojat8KGGJuhmhv4nC443Ki8hpaGVG1sZm6VjmLFR8edKHzROrNqzpJ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(31696002)(86362001)(36756003)(31686004)(38100700002)(82960400001)(2906002)(4001150100001)(66574015)(44832011)(6666004)(8936002)(5660300002)(6512007)(26005)(2616005)(83380400001)(53546011)(186003)(6506007)(66556008)(66946007)(110136005)(8676002)(316002)(41300700001)(478600001)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0oT6AJfrj0Bpgz+g6bFcJ9do7HgeSJJZuZUvs1vOwl4rUUkbhblFserBJA9V?=
 =?us-ascii?Q?FEywnWOoHRqlmn1VeRwV5xUGjqzI7hdm60ULusd/3GILSr8LMf5v7Dh7bHo0?=
 =?us-ascii?Q?DH87ettrzNY158xVXK8EE3vESESg9NPLBaQXBGJJTisvIZeEggHO9rVptMkV?=
 =?us-ascii?Q?b0p/b7GNkOS707TxplWD6ia2i2I/E2wHBP3h8XO12ZRWmpa0vnfQ9GZxVvTM?=
 =?us-ascii?Q?O/CSwGb5zF1mc2QjRuTqIaMgV64IugtR8PdG8GbAG6PKXDQxys9wfMg51Fn1?=
 =?us-ascii?Q?3GNuBA+30klRM3svELHA+nr1FHZ09y0v/QzexeJbQvUJaPJ7gYNY6yEcwLHd?=
 =?us-ascii?Q?hzMTMfb5WRH1WT63uKgP0Wdbszy/MiJwQGd+iA3K6z2y8rQy8c8bbdGpBsfI?=
 =?us-ascii?Q?8IHVJyA5H8lNOm7VP2MhKtEgrXf5nNlrQc0Ua3hQplgK1UtT4Moc7QYiwc86?=
 =?us-ascii?Q?dhOhaiuf9jDnhJOcsUkkJtK0DVK22IE1+h5+qSsYKmRiKFdP+Z7kHTH0E43N?=
 =?us-ascii?Q?Zgc4j880ETj9Du7Q1BBa5hlNO30yN+5nA61FTlOQb6+cCSPuF+JHkWE0T/YK?=
 =?us-ascii?Q?i7Ex9E/+2Q76v8xs6DF674dRui2apRrPvzhGhWxZabHSfkcBTNmphpWCuprK?=
 =?us-ascii?Q?6nyQB/KnVxUkdD104XrJ/igVThw34sEEsNzX/YIw4iHDj0cn9YFAdyxEhgvx?=
 =?us-ascii?Q?LiAqLSqm+X7H5mx3xd8FQjvyW4y87P0OMoNoUqXVju6fWMhnoFTkhPm5YKj4?=
 =?us-ascii?Q?HbaaqPn4RcgZTBpjLT/sMeZwb93vxwrgvDxzAQ+0YvX8lHslEHf8SMehdkfW?=
 =?us-ascii?Q?dOTzt2cvy8laRK4Oo9ISypcTdSJoAPeua7wypb4DYbNck6Ra6JyK7a32Rydx?=
 =?us-ascii?Q?ESWCdlyXUAmbQZK46sFpHFothiJWCQ3FJmn9V2HGs7ev7SARNA8PsLT8Dxoa?=
 =?us-ascii?Q?VgFTybcdSts7+nDjJvPWnGDrUqRa/tLpj5KVxqWFiZOFLGQO1xRQ+IR1DglH?=
 =?us-ascii?Q?KxdO4R5AMihcBoY2IGqVR6ZGbqlGS2tzUiFmU7UiJ4MvPfF1/jD1GmZG6vsn?=
 =?us-ascii?Q?1nvQMOrzuzUPB5sqqj/6FmykKspxFzar/zlFpo1dGgardIdjVsNJtaK0LWI3?=
 =?us-ascii?Q?oMiJvj9F1LlPPht6s/RGe0zFNWL6KE/1ZMAe7KBMf2w9INYXeRjp+FHrM4gG?=
 =?us-ascii?Q?+cVVEo4KCbywO4s2Lu6v+RGSDHI6SW6JDM4OZheV3x/gqGPMAQngamgChfN+?=
 =?us-ascii?Q?KWUq5Ci0a8DdK9jCQgkaSMaJr6NmhKLRPtGAAe+Kw6vPCxHG+zN15zU1AseW?=
 =?us-ascii?Q?SBPqKVk8CcVpIg4X0Q028iTwzggFwlUE3NvY8QgNh4p63qLJl/Jt4/+kOU+I?=
 =?us-ascii?Q?lZ3Ml7qzi0Ergg1E1X01dILLIy2zhoVDi5M10/gYn6w6XoH0tEjq8kxDGdm4?=
 =?us-ascii?Q?RmhzYjvDAMfLcajkAA8t4xLxFxi7VBmMlPfzZyKEXW753XPbxlPchKfx+JrK?=
 =?us-ascii?Q?lFYMxeLXvmxcz7nsSOmmEb1iV9Me53GB+vZp1dX9TVhtuji88UCBNRYwsclt?=
 =?us-ascii?Q?7Qnj2KhDePLq6i/fH8v9ahkiOxAsIRO68ceVgf511te43Wj33axEqG6SkSAi?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18cdd03-da01-40f0-ac4c-08dab76b281a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 16:00:08.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zluXJz31tWpMSAdzIuqePj95mW2rkQSFlDsyxSLSRc663uz9jr2g15HRtjokKohpvwilN0pI4r1YfXZUEHlH9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3949
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 16:00:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9867

On 26.10.22 17:27, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Gesendet: Mittwoch, 26. Oktober 2022 10:53
>> An: Su, Bao Cheng (DI FA CTR IPC CN PRC4) <baocheng.su@siemens.com>;
>> Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; cip-
>> dev@lists.cip-project.org
>> Betreff: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
>>
>> On 26.10.22 09:36, Su, Bao Cheng wrote:
>>> On Mon, 2022-10-24 at 14:27 +0200, sven.schultschik@siemens.com wrote:
>>>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>>>
>>>> Optee is part of u-boot In the secureboot scenario to use optee and RP=
MB as
>> secure storage.
>>>>
>>>> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
>>>> ---
>>>>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 7 +++++++
>>>>  recipes-bsp/u-boot/u-boot-qemu-common.inc     | 2 ++
>>>>  2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>>>> b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>>>> index 956dcbfed..8e6428238 100644
>>>> --- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>>>> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>>>> @@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>>>>  CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype}
>> ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load
>> ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r}
>> efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}=
; fi';
>> run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
>>>>  CONFIG_EFI_VARIABLES_PRESEED=3Dy
>>>>  CONFIG_EFI_SECURE_BOOT=3Dy
>>>> +### OPTEE config
>>>> +CONFIG_CMD_OPTEE_RPMB=3Dy
>>>> +CONFIG_MMC=3Dy
>>>> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
>>>> +CONFIG_TEE=3Dy
>>>> +CONFIG_OPTEE=3Dy
>>>> +CONFIG_EFI_MM_COMM_TEE=3Dy
>>>
>>> According to lib/efi_loader/Makefile:
>>>
>>> ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>>> obj-y +=3D efi_variable_tee.o
>>> else
>>> obj-y +=3D efi_variable.o
>>> obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed.o endif
>>>
>>> The `CONFIG_EFI_MM_COMM_TEE` conflicts with
>>> `CONFIG_EFI_VARIABLES_PRESEED`, so you have to choose one.
>>>
>>
>> Right. When we switch this, we also need to switch the secure boot setup
>> procedure so that the result remains securely booted.
>>
>> Jan
> Do you want to do those adjustments within this patch series or
> do it separately?

Well, if we leave out enabling CONFIG_EFI_MM_COMM_TEE from this series,
would that leave something testable / minimally useful behind? If not,
we need the transition to secure boot keys in RPMB already in this series.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


