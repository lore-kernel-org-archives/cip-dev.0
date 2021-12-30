Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A9C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 13:36:57 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web12.64285.1640871414798061002
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 05:36:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=MGYXAJ6P;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.131,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5ZREzygiuPmMQ1HlbXHUKqgEZiUvKiIpiM4j8aV5WXf1f0EWVn/vnkSssCKuMuXLzkTBa4AG+xlNua3F3G/U96oNn5HW5QIWfD+sVG5qZgoYvGHws7JS7PESC0A3U0Lce908OQHH5niEGs3iqcTOpa/ew0/Ns16cljW0SxeFKoH8oTxu9sHdKzfORB3BQzt9YCe/RaTHIy04ernBV8x/Nq3tUlk92ypy4w1dSMpns75bd0q7T+OYSLI5Y3daOZAaufderHIjXqbYAaE9+x/8c90/mfk4QBUG3YSujqzQa0Si8rv5BNR2KL7b9StUL/0lR+xRagrw2/F0e3rggR7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIFWBT/uWr3I35QzZZvZ0jszk01VdW3KDuE1bQ6DqdU=;
 b=XBxx72HBjvi7rAAnapEVoiHuE69GiBeyOZmM7E5dkLTNjEPKzXqSYzuWaaWRBEenk8wPpVZSSocKOviAcTGflCGOzPUSmJFGuHnDTgCgh5BWE7WTNc3rHvZN/rkBUSof9qPM8urrV7g/+T5LO3zMqAcZrYViaFcNTtQOXHK/ncLD54hR1V6k1AIx9B3erUb/tEUFrsEgUAA38KzOjd22Wl1OWD+vC4FT5qqCwHv80o2tgoy11WruOR5ZHCby0IKu0NsWVTNR6gSChrNXtdfuzVdkCx9lBU9QSuRIf/MMBrNKC4YRK7AFWLmsBJNzGzFb0MmXiZvnyxaL4PvXeo5LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIFWBT/uWr3I35QzZZvZ0jszk01VdW3KDuE1bQ6DqdU=;
 b=MGYXAJ6PXA4FDgZ0BLdgNu9QJ1iCnF+oANxysxXU5FyB+NdplG/LW4uLZFrg5bnUN9VC9Og0pLfyQTfxr+mXJubrNX+vvCnSr6VxYkX5MCAxUN0qE7GcHf5ZdN2TApNQ2j/CX8nzgxh9/Y7XE+xZrAc4+pqJnT320hCU5z+Hixs=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB1570.jpnprd01.prod.outlook.com (2603:1096:603:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Thu, 30 Dec
 2021 13:36:50 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 13:36:50 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Thread-Topic: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Thread-Index: AQHX/Wu5aCXeX0FDIUGjJQNt4fPvbKxLCYtA
Date: Thu, 30 Dec 2021 13:36:50 +0000
Message-ID: 
 <OSZPR01MB70190F986BCF1C9EB757CB73AA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230105507.GA9799@amd>
In-Reply-To: <20211230105507.GA9799@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08f08d4-3e99-4609-8d9d-08d9cb996f1e
x-ms-traffictypediagnostic: OSAPR01MB1570:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB1570D95AC234B0245B5D337DAA459@OSAPR01MB1570.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xgQloN+Qtp7eZaIy0eP2MyHx3mN1COWv6IlemnYcNITuCyswGAz3U9umf0DCOobhzE7Jskv01DxVbZnTmA5aQYsVFyNYOp0O0YOKgJIwcVElUL97n5kzkks3oKUCakxO9ixHNCqIXact3RVnbpA4FPeq5A5bxR6cRCM/V9LNJF8x0uoN1jm8VRXdGapPBxtFJY0JjTf6b14/DeJZP6l9pJsT+zXACqlJ7/j9j/OYlwrhkQzZdOU26pvKHArFDiOEnsfY0Bb388lUA3k1WBATFhcuzf4nm+rPevlboxJOWAya3grphHi/hwXWhAxH0hbILXCCym4y/Iw2lCP1bVQKuOk/L+7M+BsD/FciiKaoLgaAhz4QCfz28GR/svw0xLqgtOh7WEwtNESs10XkUcdAj90q8bIV/occkhlPCozduGBlz74/sQ6Fyim0QK/IWd1ThvW93+E4SJix0jq9rqDBy/AX2j/HFBf1I42aXwyPrKWjAxIwSrwTmf3rglsUS9zXQv+JafHFmzrpMjo6qOuhVgrLNwctz80sS20c+B0SsM316/sbu/loFzyryZQpn8vrVkLAa8LrU34ZssX3PPlHnv6kVK9Lq0ecneHW0mvkAodFA02Y0lhpuAv7jI7OBV724XPZbWVRut+IkFocicV3509hQsiJPXkrRfZOsLo2yQYcjFaU1cf1DVfKb09sWXoY1CSaw8mmYr7n/mnzm3qvJQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(83380400001)(107886003)(7696005)(2906002)(53546011)(71200400001)(8936002)(26005)(33656002)(6506007)(508600001)(9686003)(4326008)(55016003)(76116006)(38100700002)(52536014)(6916009)(5660300002)(86362001)(38070700005)(66446008)(15650500001)(66476007)(66946007)(64756008)(66556008)(54906003)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kSoYgrpPCSXpShk1glO7cMCdJ0I6hVY+WnQO2Cql9/+S2OOxZHATjg1nPmbY?=
 =?us-ascii?Q?ozpdqUxEbr5ABGlimiBzTbzzuPn/0GK3Mq4gS9SxHfbPbmxGb57zA7a65fCT?=
 =?us-ascii?Q?MlvT8yhOcT+WZSjFKlZpV3arLoQWDPh48u7uIFqXgkYYrzybD2+0/iG3BjHd?=
 =?us-ascii?Q?iVS74tzAeeLuDGdbgWyPT477Zx1grAwXIybRryCN8Kk1NnwlUlh0PpgRI2jy?=
 =?us-ascii?Q?rlrrvKxD0Ew7i4weZTZ52FGfXqF8TxYrOe3g3tANDJGfaMA40ob7gxCEWYCt?=
 =?us-ascii?Q?ARmSOUFNp02IX3pq8hHDugBOI1tzvjNUV27MZo1ego0dqKtN7IAORADqmR0F?=
 =?us-ascii?Q?qesPVIfeB/aVXhvDZLENKjek1bWIEOaolZlMxEgZFa900BtxNa8SX0MEm5SX?=
 =?us-ascii?Q?zTgkRLJ1LbZKIt+tN5VtQ7tsaM9LfQqg6JzNAFSdo7wPfXwEUmizfEHWoomT?=
 =?us-ascii?Q?6wnU1p7gIwY3kCV8et67WrUGXxyTw41gD0vSTVVTPinj+lhVEzmgw/RmfPnD?=
 =?us-ascii?Q?BkexJyBCU6lDfwkj0+YeJTf5ewPYMgk/u89B7UE0WIr3d1IX0Tk9fDwYkwdp?=
 =?us-ascii?Q?hNJYzqIs70LJR0xNUCnyMYND8e+wFVkQM2P9hiS6JrR4+87Ne0o8MRJXfeah?=
 =?us-ascii?Q?alPuGCWig2Aj4laB4RMEJRIDK0FIX4m1wupTKUWAvO/c0PfX811Lm0cNo5Lv?=
 =?us-ascii?Q?AwFwmlWl7MYATFFydnmjKQsNFScDq9xHdHINKOFkH1gNTv8Ddcc6VDvOtjHL?=
 =?us-ascii?Q?+DdaFwFNNkDlPXTVozv29w0wXuFwEXkloatDpMTMcueb3QqdWEcV0F2U9C6X?=
 =?us-ascii?Q?kuInSB4hcIBtTXfQotkRa/iAQzra+zJjO00k+Bz5NC/4zKg9nZLx/veFdqlp?=
 =?us-ascii?Q?2Tw/ta4ZHsG3+0MvtVyQ9paFMD3GteySySwksfbZZdiMZD5GZTNX7gyxmrLR?=
 =?us-ascii?Q?4XtKEWyGPCU40IZf2TzaFiO4bjF7Gac9BA4Gl0NJoyE2MIi5nzyGF/NJ8YvJ?=
 =?us-ascii?Q?uIL/hUJ4PtZPc4cjYnPwjiFTNpY2I4pgMNsHhy8P2FXu1YL7++oK3p9jBDid?=
 =?us-ascii?Q?7gYEDZHmuo+l2lczKNPi3k9x/LTDu4LvMe2pit9P8B4Z/QdqCNTlqFb5tTG5?=
 =?us-ascii?Q?1ETO6t5QqnrQck5lockpEh7vV8QnRh92SHM9ZVzE4jQsacS17Cq8U5dGanXo?=
 =?us-ascii?Q?p3obZkrkuUBB6+MMYrrSQlmk/d+a47LRYQC5IQyalSSu0FVQJ2Yp/6YwNfvN?=
 =?us-ascii?Q?zjAE1T8/vuqW+FsC202c0xaKKmFFO7hoFZx8Q5YH3ReN4xaPTZtuvn22tOzG?=
 =?us-ascii?Q?0HKrTaiotVVHyboLXNV6IEOBSn08q/gdxlNh0QTqMaoqNPwG/i6/1bz2oeSf?=
 =?us-ascii?Q?Ds1x6Ld7fBcfPe4m/4P+9dkfEX9YPDyQqtqymxlCnB+/q7HEyN1Y3LcFkkaP?=
 =?us-ascii?Q?tateySOWQmgKri2eJmeTb7iPOIWhRWLPjktVmgUuSvXwY2YM+at4RLJjyGYq?=
 =?us-ascii?Q?IE2xWoKh/d6CAluA8qBWdlXN0fUKtQOycCfhMiiuWuyL2LjhK24T4REtHa+B?=
 =?us-ascii?Q?M60y1heY1BWXEUnTDjSjn8Ye3HjHnTqPL3brNhqd8PoNcs2sTB7jOIfP4D4r?=
 =?us-ascii?Q?O/3B1CuVxXRI1WyNJT1Ph1ToH88vRMC3OxNhFgsWw/18o4QAqf6YIHs5AYH2?=
 =?us-ascii?Q?dxZpwcAeCK4VrxeLwyuKybZG4CTMQTqSQSp3eZzIV9t9SN/w4WY0TgjBal6+?=
 =?us-ascii?Q?n/AOQT4HrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f08f08d4-3e99-4609-8d9d-08d9cb996f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 13:36:50.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 CI+NC80AStbeVQYnwrCVPrhP1DCqtxAq0uDH4M71TwbYQJT5njjwndG0z3orI87JXqo2DvmWAUe0VHOYWIdY4qeMQFAVUuf6myLu4rB9KECUI1oJA7l09k7uKT6eHIMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1570
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 13:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7315

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 30 December 2021 10:55
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi: =
Update slave dma channel
> configuration parameter
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit bed0b1c1e88a27b76c74584128cadebc6fa58622 upstream.
> >
> > The DMAC on RZ/G2L has specific slave channel configuration parameters
> > for SSI.
> > This patch updates the dmas description and example node to include
> > the encoded slave channel configuration.
>=20
> > +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > @@ -48,6 +48,24 @@ properties:
> >    dmas:
> >      minItems: 1
> >      maxItems: 2
> > +    description:
> > +      The first cell represents a phandle to dmac
> > +      The second cell specifies the encoded MID/RID values of the SSI =
port
> > +      connected to the DMA client and the slave channel configuration
> > +      parameters.
> > +      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
> > +                    MID/RID value of SSI rx0 =3D 0x256
> > +                    MID/RID value of SSI tx0 =3D 0x255
> > +                    MID/RID value of SSI rx1 =3D 0x25a
> > +                    MID/RID value of SSI tx1 =3D 0x259
> > +                    MID/RID value of SSI rt2 =3D 0x25f
> > +                    MID/RID value of SSI rx3 =3D 0x262
> > +                    MID/RID value of SSI tx3 =3D 0x261
> > +      bit[10]     - HIEN =3D 1, Detects a request in response to the r=
ising edge
> > +                    of the signal
> > +      bit[11]     - LVL =3D 0, Detects based on the edge
> > +      bits[12:14] - AM =3D 2, Bus cycle mode
> > +      bit[15]     - TM =3D 0, Single transfer mode
>=20
> I wish there was better solution to this. Device tree sources are quite h=
uman-readable, this really is
> not.
>=20
Do agree!

Cheers,
Prabhakar

