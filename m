Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF50C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 14:13:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web11.23475.1706883230326448234
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 06:13:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=H+mIOWDq;
 spf=pass (domain: renesas.com, ip: 40.107.113.123, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLGRfXoahrFLm06NQUq/LVbt/jMdhbDkqyUxJVy4hZmhpUwgyMPUM1SqaURRfVtFWEZmt1ct/sTU8nvmfyI2X96PEJ65YsJD12ECjd7Eqgz3rQuEdrGku2Nj8J5ic5WjCtMwYJDK16C0fgaOkEptujvfzsD76Ezb28/8Uyt/VfKOMHIskEym5dWgj09MgOgNrkGDL6QzGEQ5gTKTxjabNp59jfie3O+MPxnhMDGwcxHp8pUqDvMaf3hIgbSntp5chhv1zPC/eu/6IA3jhDFbIDjEfjQW/5K/cZAk52VQhiMQc0DZCdnPOM26uLSZ8zBHHIBO+GJfE/U6vjYow/MCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHBn9hs7YGjXzwm+8oyN90MsxiMLSAKExD22d+RPKn4=;
 b=GEkYDvDfSqTx9xWC/6U/Su7ZlH+ST82Tk7Eoj5oRsPKYOzVT5o6kshSTiwwF5i+pwN5MMfdHkmtuI0wEmhdC7sG1HP/03v5wiII8BHsUSB+ndX19nc8gKTGJrzQ/7iEOa3LFWb7XZE9Hhp+3PfSCItNW+qoBUSd2kkV0wjdiBq6x3uDr2rzkMD6vFWRaHAwAhm9pO4/lMpuANRg32JzyKVRjRIZnYCXWoGlK90+12FYCt+1kjQh2gZMA8ViPr+crvsTGoyl7ZKqUtL4gsw9cyvi5/90mkB56lAAzM/s6GGPhnXcNt+LcPt96aUtePv7uGxRTG6tL0UZiuTMDw1y/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHBn9hs7YGjXzwm+8oyN90MsxiMLSAKExD22d+RPKn4=;
 b=H+mIOWDqMFIeoCgawyOCwCE10O2jbie8Xct2g6NFzr8pRrH4UmwCrr35exZ3uRhUXetGiI6rD/GG4tfxBFc5xqeix31rEGmeXUXIiOp6na7hlH84o/qBd8YxfqO6A6FGkr9FfGQi3foCqKPP+4tV+l3TkJ5E0JK+jy6B+yqZQEY=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS0PR01MB5732.jpnprd01.prod.outlook.com (2603:1096:604:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:13:45 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.023; Fri, 2 Feb 2024
 14:13:45 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "pavel@denx.de" <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "masami.ichikawa@cybertrust.co.jp"
	<masami.ichikawa@cybertrust.co.jp>, "uli@fpond.eu" <uli@fpond.eu>
Subject: RE: [ANNOUNCE] Release v6.1.75-cip14
Thread-Topic: [ANNOUNCE] Release v6.1.75-cip14
Thread-Index: AdpV0JzmAHJdkSMZS0CA5lhb/yUUoAAA8A6Q
Date: Fri, 2 Feb 2024 14:13:45 +0000
Message-ID: 
 <TYWPR01MB11862678CF1C1B3A50C936511B7422@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6388F4C818B9775AF73BBDE192422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388F4C818B9775AF73BBDE192422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS0PR01MB5732:EE_
x-ms-office365-filtering-correlation-id: 4a354919-3878-4e7e-ea51-08dc23f92b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CBK7tdtJBJ/N95q+XeBbbBe5QM+cxOATIK/9SmRnuJ4pwRmEb3iAMNI5bYj6T6sTxiFloGBLxDauJ/mqkwH8m64Y4Dw1gXbqeQeTKY/6bYSH1z+eQ0DdSq3rrsftzlii8w9zvq6vIgoKZYE2XnQ3+SJQbxhH+5m8uFRPLV2Q1tAX0gcaX+RVeQix6MHnpsNe7KDmFmLPOPNnynl47l9GXRjn0jRnWHQLx3WvqumTrScVfIiZryrPsfEiEldOlOZDNMZ43WkIMqWgpBYXGHL0FEUCqGZ+MASeIS2HznpkZ+QIfq99djl6f92sV6YTa9h2WTWC5gAy/bzeX5cWcHfIS1G4cbLAwfJd8ZA1LKsXnYVQ402/W4b5d6d/N+bkEOEWZSZd1RNfFCQwc6koTBE+XppQA+YrlBbmslqbrzCXEYj7rxD8Gu28KmvyvpUMyhU/DiIiF8yS1P9yvNBGvawhBPwBH8i5Ddj8vHfiqZlSr1gS5DPsQr2moCktzunDDoNAJvMYV3lw9hw7luvg8nwi0M7ZsoXlhnsn3Z3hI+YQJQf6zX1HeNvOpEG3Qi+9zDWAL/zKzQEkat9x2IOs7DbwuaeB+ElqbsYpOKQeONnBU+Ke6iWaui+CEG6EGnDbqpLT4c57uzt3pMfsBb13KKn7hg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(9686003)(52536014)(26005)(966005)(41300700001)(478600001)(8676002)(4326008)(316002)(8936002)(2906002)(86362001)(33656002)(5660300002)(54906003)(38070700009)(110136005)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(71200400001)(6506007)(7696005)(55016003)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?2ZIyn5r4WrmmbLtqhIy+WbYg8BYWwszF6lyi+bNXTsSF7v4uHNwRuNYF?=
 =?Windows-1252?Q?rp6LcnvOOf1hqfC3AXQiN6REYdO07wXkAaX1Rtm2pgCRbzdHwrstr05+?=
 =?Windows-1252?Q?33U2y5S/4fE4aKm5ex/oqKNQ4S1EDUrYVMwsrZy14nwNsDeyS9J9GDjd?=
 =?Windows-1252?Q?7QnjXKtRnKDzmjvfDxnskENCdYB3+b9f1rc5UGakBKU+djIdoM1Ez/Aj?=
 =?Windows-1252?Q?/pYN83gSZPCgv/QzkU02hP5EIUMIINsevtaSD6NpNDQYcKQenQXc2uNU?=
 =?Windows-1252?Q?KJqvunHch4ze+MiXE5lhz+CVrz0ay69fqrQfa5kUH/r8ZeN8viQvyMpL?=
 =?Windows-1252?Q?lH0UeeSTqmensABaGAUZKSj/WIK0vrwb1/AKf3iubl3B2DgwqbFE4h/h?=
 =?Windows-1252?Q?cpAzGBt1Ee4JymoqihnAfLVxGDEhI2W3paWic6FBG/9tiQ9GcZxX7eN5?=
 =?Windows-1252?Q?B4pZzoM8Dx/SKupEssgKcNLGvya5qMzSrDKB8VfExxPxnf+aXKaK57Px?=
 =?Windows-1252?Q?IQTs/iM3TiPa5tHJ3mudLLvDpMdABN3fCd1QnSQpbHXJqFdYcF+FQfYm?=
 =?Windows-1252?Q?lCdNIvERO2Bz9k+CvsCPg2XT0tm28Wfqz2hlnDSEzMHh6T+sRQdfxSii?=
 =?Windows-1252?Q?kY+8iPlkwT2jdgVNkhP+8SaAm07rpUjNoCZRIC9C8w+58FN/+bZHLDgi?=
 =?Windows-1252?Q?POItxtdyvxIbF1ucttWHYX04ZTWxgzWFaiqjS2HosRMivGqNWiaxzwbj?=
 =?Windows-1252?Q?JTW7eInHeO7UJb1UXumgEQp37iCPcOdgeTTW0z0HqSNDJVWFnhr2gJTh?=
 =?Windows-1252?Q?aasJp+r4mpxbCsd91m7frZowqVDJ5b9eT09nX8tSAOrGSSdA+/4XczBJ?=
 =?Windows-1252?Q?XEkWus3l1irxLOjOWIWilPrSgYyO4769KhI8St/7Qcu2El54wSTG8NOa?=
 =?Windows-1252?Q?D+viDyEObdE2T2JuiOVtb2ZNV9ByKRS8RoKnPdfDO1oksUTEWSKZRGx/?=
 =?Windows-1252?Q?MbAQDFMlz909sB6WbBkn7dH1An49L9uanKiWINCPQewHoqDq1fLFCf1n?=
 =?Windows-1252?Q?U9goZsl1emLf909FK5HnSr1hFiRSrPW+dYitp812gCkhhoJz8Vkpd8ZE?=
 =?Windows-1252?Q?C3M2CrdQPfs5FVOpyypfreGBz8LVYHy3QN+jLmrB5+oKdQ2LrvMIoo1s?=
 =?Windows-1252?Q?HvyVcq8XT3nh9dqVrbwli6kSP19UVKwHzbG4XU05nlNXhVOG8JiOzpZg?=
 =?Windows-1252?Q?K/TxU5gRP6w90YqWwhSuZ3MQ3ly2wueTBg59xTJOX7R69LUwX1Z6t8PE?=
 =?Windows-1252?Q?0F+zyeThAVFQ0d3oI/a3e9JjiNnykNaWYWqVqsGwpJkqN3UnBSdTaM7n?=
 =?Windows-1252?Q?dMbJqqwFpCQxgC/kaaFqWRla+1WpKPcFiNkH1S2yMak4QL2vmi2ElNcL?=
 =?Windows-1252?Q?6g4JdbraqQqyS9pMrD19cTBse0HunYXfJipFByN9KVSyqYzoDenKL1Xd?=
 =?Windows-1252?Q?ofkp97k7PgpKnXOjFIOSZsZ8e1pp3wecp8XsdjC6WsnIpqYYouwSLI65?=
 =?Windows-1252?Q?/kIvBp3DaRfx1o7yLVkH16k7eWEkh6mO6WYUxRDX9y7mKbE4ufXlqzek?=
 =?Windows-1252?Q?6zGSXBZmYF8vHHGcOSsoaVBl1vDl/SBNvws5QZPEdCcSobGNZU2J9Lx5?=
 =?Windows-1252?Q?M2KxSHZQ1snSoDx4FaAdPz69QPkjbXaGeKBgIHCqOXkbhc4Zz13sMw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a354919-3878-4e7e-ea51-08dc23f92b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:13:45.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhecxLo5k4Kptsc8oBIlveMPQM2+kuFDd85jvVZu9YbLfeqf0wCoo+XhWrY6Gw6Yef6acAoTrkAgBo/S14mBBQUp37Ltv3suhS89aZPAAK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5732
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 14:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14635

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Friday, February 2, 2024 12:11 PM
>=20
> Hi all,
>=20
> CIP kernel team has released Linux kernel  and  and v6.1.75-cip14.
> The linux-6.1.y-cip tree has been updated base version from v6.1.72 to
> v6.1.75.
> This release adds support for Renesas' RISC-V SoC ( r9a07g043f) and
> reference boards.
> Also added fixes for Renesas' ARM SoC and clock frameworks.
>=20
> You can get this release via the git tree at:
>=20
>   v6.1.75-cip14:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-6.1.y-cip
>     commit hash:
>       f555c0a7ff8af9ddf857352bab79675e17c358ec
>     fixed CVEs:
>       CVE-2023-5633: drm/vmwgfx: Keep a gem reference to user bos in
> surfaces
>       CVE-2023-46838: xen-netback: don't produce zero-size SKB frags
>       CVE-2023-50431: habanalabs: fix information leak in sec_attest_info=
()
>       CVE-2024-1085: netfilter: nf_tables: check if catch-all set element=
 is
> active in next generation
>       CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty
>       CVE-2023-6610: OOB Access in smb2_dump_detail
>       CVE-2023-52340: ipv6: remove max_size check inline with ipv4
>     added commits:
>       CIP: Bump version suffix to -cip14 after merge from stable
>       pinctrl: renesas: rzg2l: Enhance driver to support interrupt affini=
ty
> setting
>       irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity
> setting
>       clk: Fix best_parent_rate after moving code into a separate functio=
n
>       riscv: dts: renesas: rzfive-smarc: Enable the blocks which were
> explicitly disabled
>       riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
>       riscv: dts: renesas: r9a07g043f: Add L2 cache node
>       riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty=
 phy
> node
>       riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support f=
or
> ETH{0,1}
>       riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
>       riscv: dts: renesas: rzfive-smarc-som: Enable WDT
>       riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
>       riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
> ADC/OPP/Thermal Zones/TSU
>       riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
>       riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>       riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
>       soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
>       cache: Add L2 cache management for Andes AX45MP RISC-V core
>       dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
> documentation for L2 cache controller
>       riscv: mm: dma-noncoherent: nonstandard cache operations support
>       riscv: errata: Add Andes alternative ports
>       riscv: asm: vendorid_list: Add Andes Technology to the vendors list
>       riscv: dma-mapping: switch over to generic implementation
>       riscv: dma-mapping: skip invalidation before bidirectional DMA
>       riscv: dma-mapping: only invalidate after DMA, not flush
>       riscv: mm: mark noncoherent_supported as __ro_after_init
>       dt-bindings: riscv: Add Andes AX45MP core to the list
>       dt-bindings: riscv: Sort the CPU core list alphabetically
>       riscv: Kconfig: Enable cpufreq kconfig menu
>       clocksource/drivers/riscv: Get rid of clocksource_arch_init() callb=
ack
>       clocksource/drivers/riscv: Increase the clock source rating
>       mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
> dependant on ARCH_RENESAS
>       arm64: dts: renesas: rzg2ul: Move PMOD_SCI0_EN macro to board DTS
>       arm64: dts: renesas: rzg2ul-smarc: Drop including RZ/G2UL SoM DTSI

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6=
.1.75-cip14_f555c0a7f/=20
- Results comparison with previous release: https://squad.ciplatform.org/_/=
comparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&baseline=3D6.1.72-cip13_=
79e2886a5&target=3D6.1.75-cip14_f555c0a7f&comparison_type=3Dtest
- Summary: No new regressions

Kind regards, Chris

