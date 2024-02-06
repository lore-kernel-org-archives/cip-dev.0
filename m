Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DADC48286
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 09:19:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.17817.1707211153694259101
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 01:19:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4169J4Yk4032562; Tue, 6 Feb 2024 18:19:05 +0900
X-Iguazu-Qid: 2yAbTaOOqJCfAliwMz
X-Iguazu-QSIG: v=2; s=0; t=1707211144; q=2yAbTaOOqJCfAliwMz; m=cHQ6FWm6U2aURhk3LIRu8x70G+9KvE9YIkKZGBQ9ug4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4169J3PH3679632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 6 Feb 2024 18:19:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAHeOtQwcuWzx/7Er5Wn6OD6MTtiqiWJarsFwLIZvwgjhyoyP4ndTbPI/lMvxf63JoHDvZPkKIe9/8IlJzc2LPlU6rvKhr4ai2fp/aw5Ru+k7THtROXAHtCGj05IxqjCGY409VKJHyjw9Rsolq3XYOE6DzemtYkCavaWFr0lzH1thklrjRQSYXJXLH8THhOVBlng1g8Rg2hLxng7DtkazYIOBEUdWfM1sBqzU0vSl0BxWl/1177HRK1/B+/J8v+P6KB8LCXZGrB/vhJW86cNrf/53hHw/pW4xX4m8jemNsLONoOQqciUa2Lg58XuiE2ScB1+t8BHHGKWhEZCMpNEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow7FDX3VlXzl3P6bFQO0JxedV/bncXfNNXCQd/WOgF0=;
 b=RwVm0t/ogbLsMAx0a1RScprV+UWjoFetPujqeL/jkmeJG88XyrTxhzjuqIvLo6x7YNElPHCQADWRYv48MoksHMOJ2jPCvgw7jIJfo+KFdMz5C01ns97VmcmKsy+NV8p/OU3NZNVyS9COFF/QK1JRUD/rzVj4VHOotvF/ITn4mb920MW12XVL61gLTV8HUbmw/IXZLu/k1r8Lp9EOiWt86JogbhK8gmzFdVpGpTyCgSCtIPgCiHDPC1BovZRVj2rY6loxF3kLuZd87gtEP4lHnx63dhu6R/1XQED8jouBbQ2TmHt9iJQ9PvTXBE8e3e/EgLORQLHgVIzkzDjFsgrBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Topic: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Index: AQHaWDDAtSOiX4zTq0m8Hpx7oVOkBbD9CV+A
Date: Tue, 6 Feb 2024 09:18:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638894EFF5D8E2BA83D45B0992462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB10020:EE_
x-ms-office365-filtering-correlation-id: 0de3e21c-551a-47cb-1372-08dc26f4a71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HZwJmGZGQfEhJoNgmXFTRdlhknqhJLaBbmVnuq2wSbS/kY7kqhG6qElYv1Bxekubr6xsuv5OFi7G2Xtr1rErgCaOB30n42uFFqLk6ljc2teRqAHCfzjChO0N5ohZVN5+I0J1tLGX0ymEIsiCA3ODeh4XWAsD1fVumXOi8V4chqtbG0U6PPU+MYOLeL2INruf4qeVgxtgdztCvt830dLAZoLgS0yyPyiZzdKV15GzNuBCFWTVc9SC/aY7xzZzfY+zjjJVfaMWSvCwXFZdE4q5KL4AFXh/ghN8uQmXApjcOjg/hpPeAtOYur5+orV8XiK1/x+AWCFg0ejB2S/Q0MtfrHLIhKflTSWdBVPfQ6/SGVr2dAci3UVtQJUMH7BiEfacc4qLiXMt2n2vqFJTbxem4gIqN48U1IPERAFx/xxxVNTrhOQfPZz9GfgTfygoHvBKa27YaKHAp+zft4FQTKuyEPMzGBbS9pJ8hk/dLFDcXpyySpuBIPTut2ctZkcfcFE/vqGYOAnMZcV6tFCU5ZfgAuzPmNOedC0TCjI2cOhQxan/GUalK10wHZtIzRfNvTlh5l5pxv7tatOBlNZhoQ/7MVGujhdUp5l3cO4zR8AybP3GHTu+rsZyoYNURfigh8fmkDlTGe+VVedpO7a+tunSGA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(52536014)(5660300002)(2906002)(55016003)(83380400001)(26005)(122000001)(86362001)(38100700002)(53546011)(7696005)(9686003)(6506007)(8936002)(64756008)(66556008)(33656002)(66476007)(66446008)(478600001)(71200400001)(41300700001)(76116006)(110136005)(8676002)(66946007)(4326008)(316002)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MzJRUVhLMTF5ckhuYUFUZ0dRZFZjQUE1UGZRZ2hvenhMV3NkL1ZQK2Uy?=
 =?iso-2022-jp?B?dDdNb0FBcm8rQjFkdWh0VTd6ZkpaLzhmWnB2SjYrUklJTXFXVzl3SmZS?=
 =?iso-2022-jp?B?R1hleWJGck9jSmxQMzdCVzNreTNxL1cvd0NTdWhyZzlVZGtPYVhkVWMz?=
 =?iso-2022-jp?B?enpicm9rTEFBcEQ2N1R2R3dEMFh5Zmhxb3c4TkRFOEpYQ05pNUY4VHhY?=
 =?iso-2022-jp?B?TkR3TFFDK1RhbklacW9tODc0STYwclArU3ByT28vaXgyOTVkNHF0SThH?=
 =?iso-2022-jp?B?ZzY4Ui9FdFh4YjNneXdWa0dCVjFtOFhWMWVsSHplanJUZzhYYUd3TzEx?=
 =?iso-2022-jp?B?L1B3dUt0a0Vmb0lVeU9hVm45LzdyV0M0aDUrbDN0SWlhYnJnbGNqZjl5?=
 =?iso-2022-jp?B?TmgzVjR3SXpvaU50UEg1T1k1WkkzdHI2bE1nSVFZamJHVUJLWVA0alB5?=
 =?iso-2022-jp?B?OE5maGUvUjQ4Skg2dDIwelJ6OFBpVXFXQlducmdXejk4S2pNL0pGYVVY?=
 =?iso-2022-jp?B?Q1BwV1hQYllkTDJSREtydWloTFpTQVEyaDg2aWI0ZEZ0VUltV3k4NzRp?=
 =?iso-2022-jp?B?bG84QnR6cHhlbTBCbWc0dU13VmloY0hsSnl1WkZuc3RnT2FsZUhIeFN0?=
 =?iso-2022-jp?B?Y3RTMXZtcWhBVjJvbHZ4UFk4cFlsb1YwcXVvcitlb05SZDd3M3N5OGhC?=
 =?iso-2022-jp?B?UTREN2paTzkwTGFFU3M2MTdZSEtJcGZyMVUxcW1GdXZZajdwU2ZJaFFM?=
 =?iso-2022-jp?B?ZjkrSlFRcVdHZjdBL3NBQUYzRUdWVmhnQXdha0tRU1hkMmFBbW03cHZK?=
 =?iso-2022-jp?B?Y0Vuay8zbjdVc0grWVRhMjdKSzhzZ0N4S2tJRjBqckc5Q2lrRUwzcXRh?=
 =?iso-2022-jp?B?bXB5OFRiZURrS285SlZvQkgxMG1UTGgrYVBFZzkreEw3ZjlzNkxQM0xu?=
 =?iso-2022-jp?B?ZktKZ0dkeXlaL0xXMS90OWtjaW1GZFpSSU1ydElBdXJGa3FRaGpNQTEr?=
 =?iso-2022-jp?B?a0xCUk92N2JXQ0htUlRMWWhVTHZvVFFHeEVQWVlYc1N1R0k3V1IzRm1K?=
 =?iso-2022-jp?B?TXMzMk43RDMwYkpMRTZid1htMldRdk1xRFpaU0hIOCtHQkxZWUt2NG5O?=
 =?iso-2022-jp?B?blk1WXpqdGM2b2dlQU1ldEtUMEdBbzBBUVdJYitSdW11cWl6ZXpQUVhZ?=
 =?iso-2022-jp?B?WE81aVU3NHNJOHlGNGIyS3RuSFlLWWhHbUJIQWh6eWx4bTQ4TnZxSXVY?=
 =?iso-2022-jp?B?WGJDSmw1eHpJbk9zNUE5b05tMVozM1VtUlNoNisvUzV6KzRjQ0pZNDN1?=
 =?iso-2022-jp?B?L1dHdWFiaWZGNG9mYTM0dVFBMlRRNnNGZi9Xck9JaHZCV3RCRXBsT2tK?=
 =?iso-2022-jp?B?TFR4YUtDOGwwVnNYenBmeHV3MzcxTE1tTlpJWlhUQWJQNE54ckJ2aE94?=
 =?iso-2022-jp?B?RzdKazJzZlJOOEJ1TmdyalIzcm1sSWhmMzJva3M5aTBOdjNPMVNTR3Jk?=
 =?iso-2022-jp?B?RGR1V0MwQVQzdXl0UWxNSnF0RTVoZnZIalg4dDhpdnY5czJJVlhnckxy?=
 =?iso-2022-jp?B?aVI2STBENG1kei82b1k2S0ZFZkZOMkp2SFo0S3c2d3d5MGhlWHZnUUoy?=
 =?iso-2022-jp?B?WkxqLy9LRkwrUzJaanNpSWlMeW9NV2NvM2QxLzZoNjRlOCttay9PbDhR?=
 =?iso-2022-jp?B?SzVIZU5RTFFMY3NLOUJZUjlGQ2t6MzhtTzRyVm9udmE4d2tnanU4MWZl?=
 =?iso-2022-jp?B?NTNJUVFyRTRORkhGenUyUDdrM1BvZ1AwT2x4ZXFxdG5GeXZ6cXhDL2ZV?=
 =?iso-2022-jp?B?THdoQ3JtSndZcGxkZlpzQWx1MVlLNGRVS3grYitCZmY3UFJYNFJKbU95?=
 =?iso-2022-jp?B?ME92RXVRUk1TcXRiT3hwQ0NvQkJKTzU2QXVoUnlNeFhvVjkwRjZoSUp5?=
 =?iso-2022-jp?B?YWFlS3QrdGRjd2VEMDJoN1VRZFJEa0ZuNXpqUkZhdHJxUEcyaWNXeVdT?=
 =?iso-2022-jp?B?MlNsMWFOUmxGRGZwVmJHdWFqVXVwSHJkem9iQmtvRGxtckcxY0xZZ3o0?=
 =?iso-2022-jp?B?QTlOT3gweVhoZ0hGRGdodGJxcGhOeTRBRnJRZW1MSEJOU1pTRXFELzNi?=
 =?iso-2022-jp?B?L2ZCc2lSNG40TWE1S0M3WkorMFc5ZW9sK1FNTThLL0hKbEdlVExaa3RB?=
 =?iso-2022-jp?B?dnN6SU5LVkRPeEl1R2l0Q2hOUHhyM21tTFhGZGtYVDBxTS9STlFkd3V4?=
 =?iso-2022-jp?B?aHkvQWwycjdraDJkVVAzZTF1VlJRZFY3Qnl4d1F4S1BocFRkT1ZPTXFs?=
 =?iso-2022-jp?B?ZkxSWXE2VWs5SCt4VUxBcWpGSHdjTHFEaUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de3e21c-551a-47cb-1372-08dc26f4a71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 09:18:59.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biWiGyZis32JxTKwNvESDH2gnaA6a5YCVqUPzOEx4pg9xBr7iP5Wnc+pvmUfjuEmDm4/4xhK688JjSnYQJO1FHF84RgCAAC+FkbIIntWj53orzBN7zz3rMN2ghnlWIvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10020
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 09:19:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14778

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, February 5, 2024 9:41 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
> dma_init_coherent_memory
>=20
> From: Christoph Hellwig <hch@lst.de>
>=20
> commit a6933571f34a9aee843fff2aa4b96949c57d6274 upstream.
>=20
> Return the allocated dma_coherent_mem structure, set the
> use_dma_pfn_offset and print the failure warning inside of
> dma_init_coherent_memory instead of leaving that to the callers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Dillon Min <dillon.minfei@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  kernel/dma/coherent.c | 78
> ++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 45 deletions(-)
>=20

I can not apply this patch cip/Linux-5.10.y-cip.
Could you check this ?

$ git am -s patch.series
Applying: arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to=
 board DTS
Applying: arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DT=
S
Applying: arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() ma=
cro to specify interrupt property
Applying: arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channe=
ls
Applying: arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific pa=
rts
Applying: cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
Applying: riscv: Kconfig: Enable cpufreq kconfig menu
Applying: dma-direct: add support for dma_coherent_default_memory
Applying: dma-mapping: allow using the global coherent pool for !ARM
Applying: dma-mapping: simplify dma_init_coherent_memory
error: patch failed: kernel/dma/coherent.c:37
error: kernel/dma/coherent.c: patch does not apply
Patch failed at 0010 dma-mapping: simplify dma_init_coherent_memory
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Best regards,
  Nobuhiro


