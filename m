Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8600DC46CCD
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 08:49:48 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.98])
 by mx.groups.io with SMTP id smtpd.web11.47329.1703148587348485239
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 00:49:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cPZ4V7O/;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.98, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaVOmzZB1iIz9CKTJ0UrUZAMjDHPmp9N3a71C9gex+qbQXPN1l6jXtNH0LRmdJ/69Gf68Ja8SFvEhQ6t822GECwE/d2RGNp3RTIK0lE4i7k2XT4Wa7ppIM44r8C5HshjOGgsHOiyvSxsRsDsfmOBX7drHDYqjZIIaxujvCQ8Cs070gk+SOsbR26SZOUdOQdA32i42prnOglBNXZjcF+uuy339R71EvDzVxJnGKTwXt3extNhOeyWt4WIBew05rG8v71AZa2PbnIrfchf9uqO1f1kW739bC8ciPfQVm8zr2B9lpvloFarsyK7ansckzHXM7MpEjyK28lb+HPXykuhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfySF0f2LUa4JhdGW45hgtN+Dw+Ih4Xp7ZJDJbDkV+w=;
 b=celbRo2LqGPmgIgO99F0hJH3owkSCMln1tE/RsTDz6RBORMU5qutKMj6sSMhuV0tHB75X5GvfGpiKOVJ6nF0Tr0FD0183h/eusN8u27z3JOXcUe18akl37dbXNJlbQ+f4UlX51NrTYKAvUil5axJwG2/UCgOwqmdV5QHd2TsBAGbdz4ePCV2GPjzoRC65tn0sqyvJ60eg55mryKH+lam1w1TIPnqw9LA73cnqg38crEoC97eYdCrfKd+rkPMErZh/0/1rZ/WWzRm7KIcsZGSq0J/b2HmynoYUMVOdu2f3UI/N/QVzMFI0GUhB7Qrlv7WHgdI/A3J3Ptn2t4jzMbPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfySF0f2LUa4JhdGW45hgtN+Dw+Ih4Xp7ZJDJbDkV+w=;
 b=cPZ4V7O/2V2z1X2DHeEQDT9b2imL/nbRhpWP4ii3OZc1R3iaZuPHTuLh2oEjPc6h0NF4dYKyyteL2AehKqKita5oADEf4hDe5JTJ8wH/0zLMQLyf13rO7wE/IKtx7zS6KDsLewJaYAMFfj+RjJgszUxeoPyxhXA13KY6qXhtNug=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYYPR01MB10513.jpnprd01.prod.outlook.com (2603:1096:400:2f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.8; Thu, 21 Dec
 2023 08:49:41 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 08:49:39 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: AQHaM5k6r4FdyPL9lEyRrWqxPo7zA7CzbWUw
Date: Thu, 21 Dec 2023 08:49:39 +0000
Message-ID: 
 <OSZPR01MB7019A140A463A5725D1A4F95AA95A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <17A2ACCE7B70050F.28867@lists.cip-project.org>
In-Reply-To: <17A2ACCE7B70050F.28867@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYYPR01MB10513:EE_
x-ms-office365-filtering-correlation-id: 852dc504-69c6-4f71-60f1-08dc0201c4ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ed175Ox5g3G2EW6G/5Y8STx31+uaO8Z86Jg6QC/JTzhd2Zsak/iAOYVXeblrD4jnkrDVvbcjIPx9m8mJP9wQC8vLWMKqz/jNuuYC2OuYqMItX1PlsveBlBcj01w1mLiE1oLyZgU03vfMb4tm18XxD3XP6XLAiKJ/tUpJokB5zeZQXUzn7YIBUX65AdHBwS7bU4OgT7ERX2h7Iy0PG4/BL00sByXCB3EnoG3GwfWIExewfEMkkfQQW1jgiPEM7iCTUU8jeFE/LlF48oFpKskEMpHoWvy6m/ygdJ4D1oOeTK0MflyDTljjwGz46KG0pnto7IO6qH5NAlO9UxLRsdhZWLsEaJdGudhMI1TXVuy7IxyeUvt6bY5Q9SoPnCSvWCoAe3REXqccP9GUET2ENSw4xRDtqy+O3JnvRkvcPYWScNYiPyPCaYQE5i5GVA8+SewbDc5jeA1nv5siehwUJ0T1eYwDVbqMI8EvH2uzeg79/fM2qMr52coq+2U83jRCPEzK+bNobe9a5SNsHW83ut6wnxw7Wpo8vsCat+oBKB99TynWbTZTZcKnWjGbUI854BemBBbpvu9GsCaZZl9Bx0U76ivAwkIl9yRKVEaEcCPhQsIRLjoKL7ZSJJwRYSTHvs+eGcTOv4cpDbLyAY5QUZg/6w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(66899024)(71200400001)(2906002)(7696005)(6506007)(86362001)(33656002)(9686003)(45080400002)(53546011)(478600001)(38070700009)(83380400001)(26005)(38100700002)(122000001)(107886003)(41300700001)(5660300002)(966005)(110136005)(66556008)(66946007)(76116006)(52536014)(55016003)(4326008)(8936002)(8676002)(66446008)(66476007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jJdri9HrLoVvk9K2zwSl6Rg0DCEOpXzH3uQZHeHKJY97bPmG2SJi/OK78yEd?=
 =?us-ascii?Q?M9zG/6H3siByIPxgd4YSUUCRDfC1U/nAPlZcBuGvuRiJgCEEEB6s7QROeeNx?=
 =?us-ascii?Q?3Cd1wys8ow4Ir8qY88lHvs2DYMidGpZT7STHEMvwqDwyB9XYyd5+9hEHDVbW?=
 =?us-ascii?Q?zRmnxpF+Fy8n6EGIEZI3PcP6K/EsJzBQfuyo6VQFAF88id2IY7G+6YxQ9eAt?=
 =?us-ascii?Q?ktfLmqb82ktnXQlSP9W0T1EOJ9ridQNmia8kWS3GeZRjD7k+NHqQhoc57FGG?=
 =?us-ascii?Q?R+631n39YDCFaYCw7cMPeCq9RTufHMkuDp8gvnfgWm9vf2tVFt33FjmS8tFb?=
 =?us-ascii?Q?YlprLk6+wB91OcJ5py14njdveZbhNolR5Qg18Wz517f0SjG+z9ODDzxAt4KC?=
 =?us-ascii?Q?8NI62NwVEGtoJS1xn/EI2VAJvi9ZgliZ7dBVUfayLQl4ZL88JobeO0Dcy9l+?=
 =?us-ascii?Q?cu2YBsd2Y6gUQ5tRxBAT8W/27ll5G6aOue8SipsuQwNhyqkHs8ieI2PgV/P3?=
 =?us-ascii?Q?zRB73XzFLNV007QyTLDIHEqx3FYMKqy8CeUhKxmqfiVS/zF9LWB2pprLNC0P?=
 =?us-ascii?Q?/FtdIWkV5bAzh/nM/nBF3E1QKnSwGV+MKJ4V+W2VmR3LBNDDzCcd2ic4DFCF?=
 =?us-ascii?Q?TDzd4fA0tZeobZTZhnF2nRPRimfEuNcuqxolSuylO2pYQZuUkuuqXiPJHdF4?=
 =?us-ascii?Q?prMD7EGBhSMGp0/zLgW+hlqYMriEBNoQgmeOcZ7Yh2g0GGyUZY1CyUT8waFC?=
 =?us-ascii?Q?pMEJAq3DZD03ejpTcN4xkenFuc8c/36jXEXo0HZ8oLCm3gKFWfmEsOy43LHO?=
 =?us-ascii?Q?Xj0y/K2DhIFOW3sqcDgmS3r5jebLsIRu+AWCMfvUNgoxEXV5khQ2rqfwJsGL?=
 =?us-ascii?Q?pDdVpWj2TcbXRUCYMGjl52jpmGVAtomtyT3+tSSnmYi0npX0t+F2rt/h79Ch?=
 =?us-ascii?Q?D+mFjF+r5O934fmxijeHtPi5uMgjGHaonNEtDb8DZ93qPDgi9Kr+TamFvjrW?=
 =?us-ascii?Q?cOnFdwJkW91yaqmkYW8Kf9vc7NBbm8qh0XBWqtnphnutM3iZgnUBWLDe0Ppi?=
 =?us-ascii?Q?rzr8McDoGJrJ1BT9bGhkCM6bEt+3A4OC+HRCb0YuyfMDUNzRatC3fK6+rcuP?=
 =?us-ascii?Q?OQjfWrlmH5lM0//VdYl8dcWVZc4l3p8OmqhdOW4xi6IcTxxr7bwanSZZtPds?=
 =?us-ascii?Q?heNHwqbkfq+hN5jxAPBPxTWhsV62KZLh+sVbQnFGDOZ4ypFr+Dqr3Ly+6tS0?=
 =?us-ascii?Q?cICGernMRgTh2zIcJVjk6jl2tCq04Vd53lMxJXMyXA67r9XJIRriw87yIfhM?=
 =?us-ascii?Q?swZ0ixU8lhy5cpsgFYTJSAVByuYo4mIWPEKudb4FFFTTeB5t6gAMG+hcyVYJ?=
 =?us-ascii?Q?PNh9uF+QESpAT2VuiVvBTNpR8+lM0akPptU3qlxZkyF+NEYEI3bOk5tWA9zV?=
 =?us-ascii?Q?g9w79VBtob4wrNW5rt8GwpHsmQMbGh4+GuEg7JufBfY/6WqKlpoyNW92KBSl?=
 =?us-ascii?Q?vNG+MLoIbexzjeRABzASotI7PAsLzbe+jT3rtv39d8hbvawcm2LqXLoB6SAi?=
 =?us-ascii?Q?T85BxGbNo6XB74VYxgApGt6mhpdS0VEJusnA0iaLm1bCsK69J5iyvsysSnAF?=
 =?us-ascii?Q?kmbXKjSJAxn80QvekkyZgNg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852dc504-69c6-4f71-60f1-08dc0201c4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:49:39.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP8m7J1u9vZbtvdGrZNf47t7T/l+QEyYRYrCq90svH+lEOrqCouYxZt0JdRt1L5xF4JK/LRQvz1jzBk07BR0lMkci83t4J4FDY3COelnlSIb/teYSmearULgKKpr66Zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10513
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 08:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14182

Hi All,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via
> lists.cip-project.org
> Sent: Wednesday, December 20, 2023 11:06 PM
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC=
-V SoC
>
> Hi All,
>
> The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces suc=
h as Gbit-Ether, CAN, and USB
> 2.0, making it ideal for applications such as entry-class social infrastr=
ucture gateway control and
> industrial gateway control.
>
> This patch series adds initial SoC DTSi support for Renesas RZ/Five
> (R9A07G043) SoC and updates the bindings for the same. Below is the list =
of IP blocks which will be
> supported by this series:
> - ADC
> - AX45MP CPU
> - CANFD
> - CPG
> - DMAC
> - Ethernet
> - I2C
> - OSTM
> - PINCTRL
> - PLIC
> - RSPI
> - SCIF
> - SDHI/eMMC
> - SSIF
> - SYSC
> - Thermal
> - USB Host/Device
> - WDT
>
> Apart from first two patches all the patches have been cherry picked from=
 upstream kernel.
>
I missed to mention the CIP kernel version in the subject prefix. This patc=
h series is intended v6.1-cip.

Cheers,
Prabhakar

> Sending this series as an RFC mainly beacuse, as the kernel image is not =
generic to all RISC-V
> platforms as the HW is noncoherent.
>
> Complete defconfig file for RZ/Five can be found at [0].
>
> [0] https://gitlab.com/prabhakarlad/cip-
> kernel-config%2F-%2Fraw%2Frzfive%2F6.1.y-
> cip%2Friscv%2Frenesas_defconfig&data=3D05%7C02%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7C5480cc71b459408ca67b08dc01b05b94%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638387104162652724%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DpGOu8cYF4I1naKC48q0muPihyt9avlwiOrOkU4T=
2NSE%3D&reserved=3D0
>
> Cheers,
> Prabhakar
>
> Arnd Bergmann (2):
>   riscv: dma-mapping: only invalidate after DMA, not flush
>   riscv: dma-mapping: skip invalidation before bidirectional DMA
>
> Conor Dooley (1):
>   riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty phy
>     node
>
> Jisheng Zhang (1):
>   riscv: mm: mark noncoherent_supported as __ro_after_init
>
> Lad Prabhakar (25):
>   arm64: dts: renesas: rzg2ul-smarc: Drop including RZ/G2UL SoM DTSI
>   arm64: dts: renesas: rzg2ul: Move PMOD_SCI0_EN macro to board DTS
>   mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
>     dependant on ARCH_RENESAS
>   clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
>   riscv: Kconfig: Enable cpufreq kconfig menu
>   dt-bindings: riscv: Sort the CPU core list alphabetically
>   dt-bindings: riscv: Add Andes AX45MP core to the list
>   riscv: dma-mapping: switch over to generic implementation
>   riscv: asm: vendorid_list: Add Andes Technology to the vendors list
>   riscv: errata: Add Andes alternative ports
>   riscv: mm: dma-noncoherent: nonstandard cache operations support
>   dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
>     documentation for L2 cache controller
>   cache: Add L2 cache management for Andes AX45MP RISC-V core
>   soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
>   riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>   riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
>   riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
>   riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
>     ADC/OPP/Thermal Zones/TSU
>   riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
>   riscv: dts: renesas: rzfive-smarc-som: Enable WDT
>   riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
>   riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for
>     ETH{0,1}
>   riscv: dts: renesas: r9a07g043f: Add L2 cache node
>   riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
>   riscv: dts: renesas: rzfive-smarc: Enable the blocks which were
>     explicitly disabled
>
> Samuel Holland (1):
>   clocksource/drivers/riscv: Increase the clock source rating
>
>  .../cache/andestech,ax45mp-cache.yaml         |  81 +++++++
>  .../devicetree/bindings/riscv/cpus.yaml       |  11 +-
>  MAINTAINERS                                   |   7 +
>  .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   3 +
>  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |   4 -
>  arch/riscv/Kconfig                            |  10 +-
>  arch/riscv/Kconfig.erratas                    |  21 ++
>  arch/riscv/Kconfig.socs                       |   5 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/renesas/Makefile          |   2 +
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  72 ++++++
>  .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  27 +++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  24 ++
>  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |   8 +
>  arch/riscv/errata/Makefile                    |   1 +
>  arch/riscv/errata/andes/Makefile              |   1 +
>  arch/riscv/errata/andes/errata.c              |  66 ++++++
>  arch/riscv/include/asm/alternative.h          |   3 +
>  arch/riscv/include/asm/dma-noncoherent.h      |  28 +++
>  arch/riscv/include/asm/errata_list.h          |   5 +
>  arch/riscv/include/asm/vendorid_list.h        |   1 +
>  arch/riscv/kernel/alternative.c               |   5 +
>  arch/riscv/kernel/time.c                      |   9 -
>  arch/riscv/mm/dma-noncoherent.c               | 105 ++++++++-
>  drivers/Kconfig                               |   2 +
>  drivers/Makefile                              |   1 +
>  drivers/cache/Kconfig                         |  11 +
>  drivers/cache/Makefile                        |   3 +
>  drivers/cache/ax45mp_cache.c                  | 213 ++++++++++++++++++
>  drivers/clocksource/timer-riscv.c             |   7 +-
>  drivers/mmc/host/Kconfig                      |   4 +-
>  drivers/soc/renesas/Kconfig                   |   4 +
>  32 files changed, 713 insertions(+), 32 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
>  create mode 100644 arch/riscv/errata/andes/Makefile  create mode 100644
> arch/riscv/errata/andes/errata.c  create mode 100644 arch/riscv/include/a=
sm/dma-noncoherent.h
>  create mode 100644 drivers/cache/Kconfig  create mode 100644 drivers/cac=
he/Makefile  create mode
> 100644 drivers/cache/ax45mp_cache.c
>
> --
> 2.34.1


