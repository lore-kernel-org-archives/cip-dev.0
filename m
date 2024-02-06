Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3058C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 09:52:14 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.95])
 by mx.groups.io with SMTP id smtpd.web10.18147.1707213130711373505
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 01:52:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QR7ePwAu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.95, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVedw5RodA5KX+UB2+V6n1aZ6sbdR8r3W7sRhxSR31HDegDUsez1Y+tv41SoSsUPpz2IslhT5cLjM1jdIqD+yIWSjm9dmctmM+uy4lRdBBvI6zuJ6XekBEt7vMjwJ9hZzja+9A1oCA1V2jGQAk5knfjnUuGraTEJoNTEsxkfGpvkvKuK0hXcNQ2Sk0KTku/DCbQTPrTHDPM59Qyc3e8aqSmSzZPAXH1pwN5qDVGAbRzXiKnTuiTPM+d3MhUbWClK6zngLXFTtl2jBFh/9nN5ma0k9KGuqlXjAojPxgHKn7X1035mMb1hTcvAZsbchgzikh9/PGrgUS7+nBvib3VLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/eT21uXaThN6iDPdQGd+cHW4rQVCNzUodqLKiMoCXE=;
 b=KLuhahxs4rr1nnwSSZGdTyQAPXctjh9GCZG8mJHUvcfulsR+LZMgsJMgOa9V6+x7Hgrw92IDdjWfnD7m4GqH/dzqQJjvIewHJwqbcOc1HAVIQ6hmeraAuRIyc6l6JNi6r3rQtt5V7sR/6rphl+Zt9tMdh0jKofeUu8qvodGLKSN7aPqWpvnqPKWXqxuRQsjSWe9YEudLsPLJrpkgAguC4HIKSA+xFdG6W+y1vhBLRuatM3xJepsoYZUqJQOyKUKBixOapgn8UNyFWGyRi5cMgvU93/FsKJKmqmL2uVapPaN2kpekr5abeADOY9mF6Z60y1oLvy7K3T5NK5QKEWBSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/eT21uXaThN6iDPdQGd+cHW4rQVCNzUodqLKiMoCXE=;
 b=QR7ePwAu/Pa1QXlocvaELJadLmCYEOkN01KJz3KLoiCE9+yAgFl9pvb9BmJRqFjVeUkItcg/12MU8sGwi9IMUbVEzDXxzA4TFvE755f8lERG593vRLKZdDwK8/m/KuqWvgNu/b7YHMWHZCWTCj0FNCOaHDD8HE/0/FJMpAiWKYs=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9973.jpnprd01.prod.outlook.com (2603:1096:400:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 09:52:05 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:52:05 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Topic: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Index: AQHaWDDAtSOiX4zTq0m8Hpx7oVOkBbD9CV+AgAAJuWA=
Date: Tue, 6 Feb 2024 09:52:05 +0000
Message-ID: 
 <OSZPR01MB7019F985CDD1F11C0671EEBBAA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB638894EFF5D8E2BA83D45B0992462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638894EFF5D8E2BA83D45B0992462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9973:EE_
x-ms-office365-filtering-correlation-id: b376b182-f936-4ee3-6916-08dc26f946d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gt+q/ko4o8rA+LxKGAKpUxBhUisoCeYv/kIO0J26NclEsPKtl4HFXmEpmRoVkTXBfAFRhS/bFOs8JV0v5GovEmDTgtR5fp9SLz4meg9bNB/UlwTseUt3Joz9yxKeNlgdQ3NNAN69zqgrP9xaGERZTU5SH7cj3d93KUO9hzPxs8/N5+5nMUg1DairNHBQeMg1oZ8W+JieYzb6qfCStEoam/+1hGAmSszXwJ50SSWeo7Bw+jHS/ckmnX4IvNCZOf5TdG1coxu4sznMbTmA4iR8aoIMnngcIjO4lDTcO+3x8pidd1iAWCFSlzakVq+Gk5FTGr0i3V6LrJt3/EZyuHQs8WUiznZU5p2CLPRt6SWxGaBU2gqAdDSM/lYJwrO40t0OEXpWFVMItNq0dEjJssrrG8XyDLI9CqAB0nQpvnSwY4EcwtgZqImavapqQk2NtKEwnsQOW8eu664RNfcDz2CHPhP8obacVf0okpW5fEdJ6Q7AbiwpPonAzoRWkzDU9KJAEViQhoM4/eiW6ZYPNMrbYmirEHS6QmnXNbzstmnLWkts7/w5oVMUeK0bgsdpGgVWeQznNWjRMAnzeR6HfudbCNMjd/g0qyJtYlEo1kO/uwKINiHY5j1wAd+dKdjA9lM5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(38070700009)(55016003)(41300700001)(107886003)(38100700002)(122000001)(66476007)(5660300002)(66946007)(2906002)(86362001)(66446008)(110136005)(76116006)(71200400001)(478600001)(6506007)(9686003)(83380400001)(7696005)(8936002)(4326008)(53546011)(33656002)(66556008)(52536014)(64756008)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0J2WFZpSjNtOXNoalFBWC9RVHpSb1AvRDRYNmcrMXNESkpYOVV5NjBy?=
 =?iso-2022-jp?B?bzZkaU9xOHhQU2JzVFNaRzFZZjFxaU1HTmR2cWhJQmFoZDhRVjdxYUFm?=
 =?iso-2022-jp?B?SUQ2dE8vSGV6UHhlbVhPNWNRTXdCT1dHb2luWlZ3QUhhaFYra2l2aWI1?=
 =?iso-2022-jp?B?MndaM2RSakxKbnE5WDh1REtjQnE2c2VkNk9PWXpkMVpCUmF6bHBWVmFF?=
 =?iso-2022-jp?B?WmdGSHZsTG1HR3BVODlOcDhlV1NDdjc4THNyQVg5MXRnQXdwd2F4U3Ju?=
 =?iso-2022-jp?B?SVZTZTJicWtFa2ZsQmhaaWw2ZHdHaU56ZHMrSkQ5ODVobnVOMjRmYk5B?=
 =?iso-2022-jp?B?MnZPT1psYUhicE0vaUxTS3dHdTNBSXh4cUlHOEpRK3JFV2xKUDZ0ZGlP?=
 =?iso-2022-jp?B?cGFncWNORUE2MEFkYWwyeFdBZUM3TSs4ZUVGbGhXZjdzcDZYZGUvMUUx?=
 =?iso-2022-jp?B?VWoxcnY3ZHR1bENoemI3YTZwYnQrcnNNSW9tOXN3V0E5TlkwRnJJaW5v?=
 =?iso-2022-jp?B?SWZzbGJNWCtyUS9OeXUxcno0SGFzOStsbGVUUUs1T0dyUTAwSC9ER2s3?=
 =?iso-2022-jp?B?WC9nTE82TmZ4SEF6ZnVtbGNGdVJNdC9WeW5JdWl5WVF3Q0o5UFdaZ1Mr?=
 =?iso-2022-jp?B?d29Gd0tYUEFwVmdQZzFxSmptZUNxTzJtVDZDdHppeGpNc3lOMjhXbXlM?=
 =?iso-2022-jp?B?bC9seUZMQ0hBR01Kd2hrdFlVK2ZDcmhVdnJnams0Tjl2REJHY0U4YkNB?=
 =?iso-2022-jp?B?U3ZlUldjL0xzVUhieEZMR2d0bVRxMHVhWVNwUjdyb2xvNVpycmw3TGww?=
 =?iso-2022-jp?B?Vk9Vd1JtMUo0SGNYRmlBdkJPSmkxamJjbUhvSkUwTEs0WUlUbTBPb2ov?=
 =?iso-2022-jp?B?dDVUYkdLUVl5ditiVS9OTkdNa3lkajVqcmNLMFQ0b1lIWW9MNHRYRENS?=
 =?iso-2022-jp?B?VDVhZTYrZWZRMmNuWFNUR3ZzdTY1WG52MU1weCtHNGNnUlRWQ3JhR1B2?=
 =?iso-2022-jp?B?ak1Da0xTUzBWcTh6cjlGLzIvcU15d0Y5SnRRdStGRVZxYXlKWUoybnRL?=
 =?iso-2022-jp?B?cGJGTFFkbEYxRytpUEpsSDdtSHpQMWRQMURhNVVxdzhQcDRzNFVUWVVB?=
 =?iso-2022-jp?B?THpvbGlMM216SEU5ZnpLbVJLelVpTmxFUWZEUGJyb2NQMm9RNHZwMXVu?=
 =?iso-2022-jp?B?L1RQZEhReEZsMzlwYkE0VUxHWjZDTWI0WExES0M2NlloSWhzK0trY3VL?=
 =?iso-2022-jp?B?c292ZUtiKzVzbkIvamJmbWhKS09WV2R0cGwxNUFFTWxtcjRLMkdpNFFD?=
 =?iso-2022-jp?B?WmlGaW1KRUU0SDRFYTZEZGRrRlJTU24vMExRcEJNNUlPc3h2cVc0Y2N6?=
 =?iso-2022-jp?B?TVdWdHVvRng5TE80WkFONktxNHB1bWhjSW1xeWpnczJ1NERzNkxSd3hM?=
 =?iso-2022-jp?B?eXpBWDlNZXJoaURXTnJUYXlmN2t1dmZGc2N0MENBNDIrTFhPUFp6NVhk?=
 =?iso-2022-jp?B?bmVVRURpK3RnTTFKS29XVlp2TnF0czJObXNtWFY4NjM3SG1peGZMejFp?=
 =?iso-2022-jp?B?U0l0NnhTbEdOTUFrcHVpSmJxRlo3NU9rOGhMZXhDeEY4V1l1Mm9HMWFZ?=
 =?iso-2022-jp?B?SUhtbXd0dzBFRDhHazdTekhlVEVJL0xaTG5LeG1ZMXliR0h6YXI0S0hX?=
 =?iso-2022-jp?B?ZmVsZFRkcGxuREpKWTB5NFZEMDhkbzQyUUZEQnI1Zlk4VkRjcmFTa1FQ?=
 =?iso-2022-jp?B?N280bjVrcVJtdnJWUXgwRHFYdjV2b1RKSTRMemtOVkxsZGtHajVUQTdo?=
 =?iso-2022-jp?B?bC92QlhzbzVjb2RybTlFNG50Nm1GaUFUUUhnb3hyZjViWEROcDdCQWVB?=
 =?iso-2022-jp?B?RlAyNTQ1aGorWGl5V3RjYTRVTnhZR3hDdHhOWGNmZEVQRW5ZNEoyTVNJ?=
 =?iso-2022-jp?B?dHVKZUJFaDRyVC9aeCtjd3dXK24zNXNGQmNDR1RnOHF2VGs5KzlyeFdW?=
 =?iso-2022-jp?B?UlFDanFiT1hnNnBQL254WGlBa2o3VDJtaDlqMTE0Tm9IcHJrZzZhNkdo?=
 =?iso-2022-jp?B?VXRLR00zMk90YzRzVldJUEpqUFJ0bG1UWjZrWVhPZWFXc1VLZjJRZFBj?=
 =?iso-2022-jp?B?bXhwOXV3M2tQZVVNT1Jkc2dVTnllOGR4RnlDTkt6ZW9JNFFOaTB4aE00?=
 =?iso-2022-jp?B?Y2JKemxQd2ZwRTZBLzAxRFNYa3NRUHcxTGRyVEdMbnMzWmlQK1ZHdU8v?=
 =?iso-2022-jp?B?WUsxSlc0TENQM0VOcW5YNGhEZTU0TUFYSmVtMGJRSWdLb1lhM3J1ZllB?=
 =?iso-2022-jp?B?V2dhUm8zbThmQUxwR2JoZE9NMW9sOGlxQUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b376b182-f936-4ee3-6916-08dc26f946d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 09:52:05.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m4j3ech4prUiyWTaHI25ENWNDry5ahw9xx2bfR1GQNdlN0EP6J/XwcNimBRnlIEA0DpFb0itO11JYPvLVccELhLdJoaZkJDRATw2NLY5thG6geA4ta8nSSqayaAZpM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9973
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 09:52:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14779

Hi Nobuhiro, Pavel,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Tuesday, February 6, 2024 9:19 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-=
dev@lists.cip-project.org;
> pavel@denx.de
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify dma_init_cohe=
rent_memory
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Monday, February 5, 2024 9:41 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
> > dma_init_coherent_memory
> >
> > From: Christoph Hellwig <hch@lst.de>
> >
> > commit a6933571f34a9aee843fff2aa4b96949c57d6274 upstream.
> >
> > Return the allocated dma_coherent_mem structure, set the
> > use_dma_pfn_offset and print the failure warning inside of
> > dma_init_coherent_memory instead of leaving that to the callers.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Dillon Min <dillon.minfei@gmail.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  kernel/dma/coherent.c | 78
> > ++++++++++++++++++-------------------------
> >  1 file changed, 33 insertions(+), 45 deletions(-)
> >
>=20
> I can not apply this patch cip/Linux-5.10.y-cip.
> Could you check this ?
>=20
> $ git am -s patch.series
> Applying: arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN =
to board DTS
> Applying: arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board =
DTS
> Applying: arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() =
macro to specify interrupt
> property
> Applying: arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI chan=
nels
> Applying: arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific =
parts
> Applying: cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
> Applying: riscv: Kconfig: Enable cpufreq kconfig menu
> Applying: dma-direct: add support for dma_coherent_default_memory
> Applying: dma-mapping: allow using the global coherent pool for !ARM
> Applying: dma-mapping: simplify dma_init_coherent_memory
> error: patch failed: kernel/dma/coherent.c:37
> error: kernel/dma/coherent.c: patch does not apply Patch failed at 0010 d=
ma-mapping: simplify
> dma_init_coherent_memory
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch Wh=
en you have resolved this
> problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>=20
My patch series was based on v5.10.208-cip43, I'll rebase and send the v2 s=
oon after testing.

Cheers,
Prabhakar

