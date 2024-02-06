Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A770C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 08:20:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.17237.1707207649784404789
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 00:20:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4168Kcoe2973277; Tue, 6 Feb 2024 17:20:39 +0900
X-Iguazu-Qid: 2rWhQ9h8CM2SzfOtnP
X-Iguazu-QSIG: v=2; s=0; t=1707207638; q=2rWhQ9h8CM2SzfOtnP; m=zwwii/qTwOBlFOyB35Re5votZLsljSHh7Cdn407CWy4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 4168KaFn711435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 6 Feb 2024 17:20:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVqWS3kfF1XGUApq36dgrId6cfucU+wA1nm8rtrISEe+1KPE0XIR3hxMxp+4Fi0/RRmoZCb8OwLK0wplEbMc5glu/xyBUtJP10rA55+ZAJV6rTFM8NjgMuhnweRNrT3v31ijm+8G2mnpH6BBnTmW1jieIK9djgTY0MbB0mBWsuBDPaO1MWxglK3PRrvgRVJVGuE5yLggkPHUCnyPXGd17mLynpEqMaPAuRKonWeCKg1ZXz3oElqgNwaSJVZ9A/IjZ7xv2oFm/HuDoPtNKPz+JY830Fq2m1/zXSc/mdmNN8iHUFzocm6V7+96uSniFleZVtwOA8GEl4JDy9FYWDnfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9zEb4oHia4J5s/MEApqYH90PQIkh/eKAxEjlE1cOM0=;
 b=K63txENO9vE50tsxX9rDQR7JTyi1m6CiF/fXlL+yl5c19IYyKLPTO40H0BxK9+wvI0Nal+0gXCubWWKnnzldZLK8V/vVu6ugEULH9yiFGifMSoA7QpfvKl6zqUDWyBcQD0Bt+01gyCkWj8shbhoLWzToFcxWw2paUqgiu6Nb4dL60JVLqZSDhDHdUOGXBtrUCGu2K/4Bbs6OeSkyEyDwWRHlAxqzQ7sssyF0IbRz6kihZROJTJfE20v1vFWrnzbEFT73Ncm0Ie0B7XPn6+nK/YEQZfPLsrBWJ8LNQjZlKnwCwLvAL2BMiA/kDzP2XS2UdaId4n34mZc0CnLyrHX9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Thread-Index: AQHaWDCvJ+U3+B+tUECol5TM+8+8Y7D8+Qmg
Date: Tue, 6 Feb 2024 08:20:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F9F9461AF95DC15E866292462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB11885:EE_
x-ms-office365-filtering-correlation-id: b0971498-865c-4959-54c6-08dc26ec7ca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B7czpnVIeYboAao5PKB3XbZQ/ah62m5QwKS97HsjOBroQ1+QcBKDUr06L38kwiRlX1PzviK/hyqopaNLbLBNoSMTfKNXvFz9QySv38dUOgkj1qw/gNEMEpUwK8E879obyUT5pifXRej/n77lZp2OJHDa00O8DDZmIZvSa0sy8tJIlpW/hjVRN7kgsjUZ1MQXhjzSsAhIu/JMjePv6JOv03nnLO75H1D+NA20vMYMZw2NQcCJIYqXC3F86/qVcToA2gl+YT84VPCJDcz2+0qwqeZkc4AjhEjDAFoybSGZtW695w6+UfR4L2thLBm5LlsyBOGMb3/lbgPE1qTUtHtti2rPi72gQ0tSK31wKRCd87fNfQh+EkpKl+Aa7hOuqvisq+M4hcwdNr08UjNcKbbF9pH8FS3OqfJzAkLLH/l07anjVMBz+aV4P8sAdphXOM+0idql2CPHk73ECoizQ/DrynOe/o5kGtr9+Nb1iC53ILl3mS0HdSBDPWYD6jhoHQgbGBeHQoANinr5C47rqL2MVeNbIQGe0JvoOJ/l/s8Xyv1VLwtwxkr/YMO6+ZbNP5H8PWJ4MMq14IDn10aCeTJN5kVDOJDRiHgLg71MaIfONyZMrCfN1lnMtfqh4F2RhZec
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(52536014)(2906002)(55016003)(86362001)(41300700001)(83380400001)(38100700002)(122000001)(26005)(53546011)(7696005)(9686003)(33656002)(6506007)(110136005)(71200400001)(64756008)(66556008)(66946007)(66476007)(66446008)(478600001)(8936002)(966005)(76116006)(4326008)(8676002)(38070700009)(316002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WXBqTFdkeUREQko5QVVDV3hwZ25SZW9DY2IzbEs1b2wrZVpLTHY0c1hG?=
 =?iso-2022-jp?B?ckl6ck11cUlBdmFJc3loU1FEdzdQb2Q2eHVwVjdNaTZXT01CYXRJZThH?=
 =?iso-2022-jp?B?Y2pTYkRjMUdwa2dKWUd6TEhKOThTeTVCZlN2TXFIb1ZsMWR2dzdYaysx?=
 =?iso-2022-jp?B?RTRnYlZxVEN3NElXNHFOUjluU29YclhTNmpkaTFMVHFzWnJZQnA3OG1m?=
 =?iso-2022-jp?B?RDVIamtQdUV2R1o5bVNGQk44NXRiZHVPejQrVXFyNWVDRlMrNThyZTJV?=
 =?iso-2022-jp?B?eFRDSFZEUVBNNnZOeWlKeG1XVmI4UnBRa29ZZlJZei9KMjEyNnh1b21m?=
 =?iso-2022-jp?B?TUtuK3ZvK2U5a2pBSDJwTmRteWFPTnl2Y1RQVmR5b2RRcXZpNndZSSto?=
 =?iso-2022-jp?B?SjZIWnJiUkNsQ3pIbnZDUXlYSStaQjRHNWQrQXhXZzQyeTBWeHQwVXE0?=
 =?iso-2022-jp?B?RlZmb3JoZVFjT3pmcHFzRVhkRnRCbHFWZEVFczAzNTdhU2l2ZDJJQW94?=
 =?iso-2022-jp?B?RUhTZzRPd2IzYiszTmw5STFsd0Z0TmkrOVhYbVFBNGpQK3ZGVXhkUEhH?=
 =?iso-2022-jp?B?WHpoRnJCVkxWZ1VjdjlVZU0zeVV6c2hyNnp6S1hpVlR5SW50L0JjbW11?=
 =?iso-2022-jp?B?YTZMWXhiMlhFWmVXYmI1MmM0UDhpampYSDJnRXRPNWRWMWF2SjY1VnBl?=
 =?iso-2022-jp?B?UERSN2RiOStQdGN3TzhYeWFTczBZN3lGcHd6dXc2S1VUS2VuTG5Kdm9j?=
 =?iso-2022-jp?B?TjQzc0ZDWmxHTlFubjltWGpWUHNMRlUzd3U0WXQzQjJFcjBuN3NlSklP?=
 =?iso-2022-jp?B?dTN5UTd1RlN6MjVIL3BMQmZ3NkREUkZZdVArMnhhZTU0b0xRK0dLY0pN?=
 =?iso-2022-jp?B?UVFXN29obCszV3hZMElVTDlvWldib0RrdlJTL1VWSjQ4YWVLNGMzc2t1?=
 =?iso-2022-jp?B?bVEvdmcrWTRReXlIR3M2OUZUVTRrS1I4Vk5lZUV6MmFRRmpQdmdzM1JC?=
 =?iso-2022-jp?B?MUtEa2x0SHJ0OVZYY21vMEt1dktyTUJ3UXRXdzRLUFpGSnV6cHQyQS95?=
 =?iso-2022-jp?B?OVpKSFZNNVMxTUFNZkRiV2MrbzFBb2NCY1Nma2NUT2ZCQVJCZDBFYmZi?=
 =?iso-2022-jp?B?d3ZESXV2V2hBRmh4ZXphRjRFbWNlQnVLNXI3VDJBN2xmVld1NzJkZkg0?=
 =?iso-2022-jp?B?MWFlVTZseGRxdElpM1I2Vkl5Y2pUb1JNRVRQSW1iOEdwaVZ4Rm5rK3BL?=
 =?iso-2022-jp?B?VWNYVFVEeFQrWHE1clNKQ3A1bEdYa3IrTmVOeTBMbVREait2cGViaHJM?=
 =?iso-2022-jp?B?ZVNCNXlZR29UeWVSM1VFWmdyM3pjT1lpK2JzSy80QUZMRjJZWERwZzFv?=
 =?iso-2022-jp?B?V0gyU09FZU43ellHMGo4WDk5Qy9YejRkMndNUXVxdmd5K1R2KzFjSy94?=
 =?iso-2022-jp?B?ZVpVY1IwZDc3RTh0bW93UHFabXdPR1E1OFdDMDc4Sk51Ujl0UXJTOTFh?=
 =?iso-2022-jp?B?MHdmQ3dBMmxlL2xVVzNDQkFOMDRFdW4vWnM0VnJMbExwYnl2S0k5anh1?=
 =?iso-2022-jp?B?NXdaVVhGYklhdll0RURPbEN5Sk5RV2NrakEvYnhiMTRXamY2WTNKOEZQ?=
 =?iso-2022-jp?B?M2FXS0lnSzIyLy9oUW5oN0FXUTBoWHZhRktBOUI3eEFyTjRrbkI1WldF?=
 =?iso-2022-jp?B?aHVkblpSY2V1UjM4SHk1aWxDYUFORnFpVVlaRHNIOHRiQm1YS2lacTNF?=
 =?iso-2022-jp?B?RDVIbS8rQjd1dGExbGNCYkFIL2dNV0NKdTVqbFZRam9YR2wrOFN3WFJL?=
 =?iso-2022-jp?B?NzVzUGtGU1IyRWFuQ3Fjc250d2J3dnF0UUw0bU5DbE8xN0w1NVlxL0Vw?=
 =?iso-2022-jp?B?V1RKWFBmQXlSaXRFYUU1elE4YmUreGlDdDJvbjdCSjN6bjBFK2EwZVZO?=
 =?iso-2022-jp?B?ZWVaRVp3TDFUNXNKVTRUVk1rdFhkNGNZTHBacERZTHhoM20vWmVVWGcy?=
 =?iso-2022-jp?B?Z3ltTEZjc2RpaG1UQUFWZXZzS2prMm15aVRMU1NMQ1RxRkpGbWFQWVYz?=
 =?iso-2022-jp?B?MnVpOG9NRGdZejZORVgzdmhDSkJZT21TSWxKL3lMM2NFMGZyK2Z3NmVU?=
 =?iso-2022-jp?B?cWhDalF1Sm5zY2RRdHNHdFpUdUEvTlpDeFlRSXU2SlVvSHArZlp2Zk1X?=
 =?iso-2022-jp?B?L2RHZUlORWtwenp4VFJCTldMcnAwbTJ4cnhqRFdKQVVnZ3NsUHd4VUdl?=
 =?iso-2022-jp?B?cjZVakhobWR6V1doMXQ5SkljSFd3REVSNVBtTXNFay9BWm9Cb3Bjb0VY?=
 =?iso-2022-jp?B?MUMrS0lwT0pRMEZCTGdzaythcWd3aDBSUmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0971498-865c-4959-54c6-08dc26ec7ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:20:32.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWnwEQ0uvshmBmQn42+71dR4Ua9RXRfF5AnOjPYxiEjJamCGt9MJ8n3MZu++wnKpPHmfQyHMvswyApbHS66H/U/7XxqdZ7lZbehTiUzbPPl6gAgaXk4hOKZqtKpHiik7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11885
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 08:20:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14774

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, February 5, 2024 9:41 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
> SoC
>=20
> Hi All,
>=20
> This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> support for this SoC has already been added to 6.1-cip kernel.
>=20
> RFC->v1
> * Patch #35 updated according uptstream for easier maitainance.
>   Rest of the patches have been unchanged.
> * Merged RFC series [0] and preporatory series [1].
> * Previous test run results can be found at [2].
> * RISC-V Renesas defconfig file can be found at [3].
>=20
> [0]
> https://patchwork.kernel.org/project/cip-dev/cover/20240130203346.94488-1
> -prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1]
> https://patchwork.kernel.org/project/cip-dev/cover/20240130161555.85042-1
> -prabhakar.mahadev-lad.rj@bp.renesas.com/
> [2]
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/116050470=
5
> [3]
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/rzfive=
-5.1
> 0-cip/5.10.y-cip/riscv/renesas_defconfig?ref_type=3Dheads
>=20
> Cheers,
> Prabhakar
>=20
> Christoph Hellwig (5):
>   dma-direct: add support for dma_coherent_default_memory
>   dma-mapping: allow using the global coherent pool for !ARM
>   dma-mapping: simplify dma_init_coherent_memory
>   dma-mapping: add a dma_init_global_coherent helper
>   dma-mapping: make the global coherent pool conditional
>=20
> Conor Dooley (1):
>   riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty phy
>     node
>=20
> Heiko Stuebner (1):
>   of: also handle dma-noncoherent in of_dma_is_coherent()
>=20
> Lad Prabhakar (34):
>   ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and
>     interrupt-names properties
>   ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
>   arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels
>   arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
>   arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to
>     board DTS
>   arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
>   arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
>     to specify interrupt property
>   arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
>   arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
>   riscv: Kconfig: Enable cpufreq kconfig menu
>   irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
>   clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
>   clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
>   mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
>     dependant on ARCH_RENESAS
>   dt-bindings: riscv: Sort the CPU core list alphabetically
>   dt-bindings: riscv: Add Andes AX45MP core to the list
>   dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and
>     Reset Definitions
>   dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
>     documentation for L2 cache controller
>   soc: renesas: Identify RZ/Five SoC
>   clk: renesas: r9a07g043: Add support for RZ/Five SoC
>   cache: Add L2 cache management for Andes AX45MP RISC-V core
>   cache: ax45mp_cache: Add non coherent support
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
>=20
> Niklas Cassel (2):
>   irqchip/sifive-plic: Improve naming scheme for per context offsets
>   irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode
>=20
> Samuel Holland (4):
>   of/irq: Use interrupts-extended to find parent
>   irqchip/sifive-plic: Make better use of the effective affinity mask
>   irqchip/sifive-plic: Separate the enable and mask operations
>   clocksource/drivers/riscv: Increase the clock source rating
>=20
> Xiongfeng Wang (1):
>   cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
>=20
>  .../cache/andestech,ax45mp-cache.yaml         |  81 ++++
>  .../devicetree/bindings/riscv/cpus.yaml       |   7 +-
>  .../bindings/sound/renesas,rz-ssi.yaml        |  21 +-
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 350
> ++++++++----------
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++
>  .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  17 +-
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  19 +-
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  19 +-
>  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  14 -
>  arch/riscv/Kconfig                            |   3 +-
>  arch/riscv/Kconfig.socs                       |   5 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/renesas/Makefile          |   2 +
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  72 ++++
>  .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  27 ++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  24 ++
>  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |   8 +
>  arch/riscv/kernel/time.c                      |   9 -
>  drivers/Kconfig                               |   2 +
>  drivers/Makefile                              |   1 +
>  drivers/base/cacheinfo.c                      |   1 +
>  drivers/cache/Kconfig                         |  12 +
>  drivers/cache/Makefile                        |   3 +
>  drivers/cache/ax45mp_cache.c                  | 239 ++++++++++++
>  drivers/clk/renesas/r9a07g043-cpg.c           |  32 ++
>  drivers/clocksource/renesas-ostm.c            |   2 +-
>  drivers/clocksource/timer-riscv.c             |   7 +-
>  drivers/irqchip/Kconfig                       |   1 +
>  drivers/irqchip/irq-sifive-plic.c             | 178 ++++++---
>  drivers/mmc/host/Kconfig                      |   4 +-
>  drivers/of/address.c                          |  17 +-
>  drivers/of/irq.c                              |  13 +-
>  drivers/soc/renesas/Kconfig                   |  12 +
>  drivers/soc/renesas/renesas-soc.c             |  13 +
>  include/dt-bindings/clock/r9a07g043-cpg.h     |  20 +
>  include/linux/dma-map-ops.h                   |  18 +-
>  kernel/dma/Kconfig                            |   4 +
>  kernel/dma/coherent.c                         | 161 ++++----
>  kernel/dma/direct.c                           |  17 +
>  sound/soc/sh/rz-ssi.c                         |  63 +++-
>  41 files changed, 1143 insertions(+), 435 deletions(-)  create mode 1006=
44
> Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
>  create mode 100644 drivers/cache/Kconfig  create mode 100644
> drivers/cache/Makefile  create mode 100644 drivers/cache/ax45mp_cache.c

I reviewed this series, there was nothing to point out without from 1/48 to=
 4/48.
# from 1/48 to 4/48 are already applied to Linux-5.10.y-cip.
I can apply this series, if there are no other comment.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


