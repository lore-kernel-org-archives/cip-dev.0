Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C9C433F5
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 14:43:48 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.98])
 by mx.groups.io with SMTP id smtpd.web09.3224.1648840690132137067
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=fjx4Jdb9;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.98,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKqzKs0fF54VuxW+NzMnB4Cpv0G5N4sLd/qE2IGyiCa9CAIZyrLc141cBKpVt4Kv/Ml4ZmqV2q6DTeyvyH81xSeVfEgBpU1DQwGIGQ3ZXmh3YNXCK0g9ADC/6laaBtTe4ka6/eHx53JONuoBM7xoA3DRpk6yHwBDtHOFYiLX1WxkwafpoNN43Oh0gJTVxaRm4UVqjQTVkTFmopLVPLpR3HcHPW44sj53MIxABI2ZHOVdFuT6jTRtiWt3G1b/295pWY4BzBw7Pvjf8MUOOu/R/5qmMwaooN0Vs0qNi9aW1rmIpWXjGQC3ND5PjmwsT6O3cM+P2JAoiMUutKyifbzsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPxJlO9yh/Qi5Cc7LL5g2y9RCA7Q1ubKmJGopKRTIls=;
 b=JV/8IJ1vubxGE1MAB/W9BfROhiZ8JyP48qPNWJfYlyUBT47H9wjnTYt9WvhR9rk+NVHIUZzDBaL3oPBNCP1cqg1fNeKETl4BSE4CcGn2mNsk1LHHPVEZzusvWXyLxcfFk6RBYpffkb3sZvkiekCjSUzrSYti6jEpUOnqvO+YFZVYADttlZ8HoK42Gt8QoNkCYnMTXVMyHbkkCPCXt6iy1HP4BbS2b2XcbObnK194HFp7wMVcliKwSN0EUmymhDviJghAK5Vfg03T1xMgXbD5cBsQzM9YA2aJh4eBuzDiOKFJspQsOKFWsNPBltmEVdw4XtgMrjJ6yfghAZOWcy0wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPxJlO9yh/Qi5Cc7LL5g2y9RCA7Q1ubKmJGopKRTIls=;
 b=fjx4Jdb9Ldf5QKvp47jc9iDHAPAXacrxUpaQI26z+EdXQYA63dw41PUQfvgfCcoGZHhqtZz1Am3lyA/Yy8gEf2Vowp9qZqknK//sG0S/gW+UwKDd2qbGIjqApBejtW9rqFv5m+gt2mpI5kxz0MNF+3GhHFcX30QcAqJyqQNyNvY=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by OS3PR01MB5832.jpnprd01.prod.outlook.com (2603:1096:604:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 19:18:05 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92%9]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 19:18:05 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/39] mmc: renesas_sdhi: clear TAPEN when
 resetting, too
Thread-Topic: [PATCH 5.10.y-cip 04/39] mmc: renesas_sdhi: clear TAPEN when
 resetting, too
Thread-Index: AQHYROgIVbnxauIysEGJE419S4zdrazbbCTQ
Date: Fri, 1 Apr 2022 19:18:05 +0000
Message-ID: 
 <TYYPR01MB702436FFEE2F26957C03E603AAE09@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331101349.GA21513@amd>
In-Reply-To: <20220331101349.GA21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9b1447-8e29-4cb3-230b-08da14145918
x-ms-traffictypediagnostic: OS3PR01MB5832:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB5832B205B31A18B82FB7ACF1AAE09@OS3PR01MB5832.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gC5JVMYSCIUA6cphggZxjO2EPvkGKlqfuJEFAk7CV7QAG2lCZel85OQfP8qcCVEVunL83GdfsoNtDsoImgcNmUj2vGwA3A6DIKBDI+jFrbBGzB97rDqRdjhDsaXqgNA+7OKvPN9URaHr7gDoVxpL9IudeC0zoABW8LJnxblrRO5jg/kJewr0uWoVmuXFQF1kOcewNJG/9mywPNllKgxdEVvEfS+Lr/V7ypcJ4rr6+TAU6i3E7pOSBXkIsH02FM/SbTMUOoytjJZ+eRDWdE0OxqORUzDWcD/0NWro9iwbNcVkQbvGDXPXBKjubIAA/VF2zj1wVGlv59l6ab5TC4s2gg8breCIjLdgIj5K54vycSms2rF8neyyS/GO8xCOZ8qkQ/OmUM+BLq7F45qvtk4dlaeVNTnXW2O4/PpRPlNHraV6dYb64l6ckVe91RDcBeSsPb9Vj8y/PO3h4+NParSfMpO8vAUtibsLYV1dtG0hcxTAUpPQOyfc2x9TxcJ0/ECzPC4Q2a4xgiRJn6Gxsp6fHmA0vnKIJoY+CgteYkA8gNRTCDRma4hb1V1haOJ1MmdCf63JZY9X8oit/YI4isnUMn8nMUIsBTXTdYn0L1HoK9xBwjKcXh6dV4o7cOkG0BROTEeGZjiurPRBIceYg9PDfViluqM1nNUrvMRhTfPthsN579lWeM1aml6dqaebb7iyiN+EXOBPgaO/UTaoEooRcw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8936002)(53546011)(33656002)(7696005)(186003)(6506007)(107886003)(38100700002)(2906002)(55016003)(38070700005)(71200400001)(83380400001)(9686003)(52536014)(508600001)(6916009)(86362001)(4326008)(122000001)(316002)(8676002)(54906003)(5660300002)(66556008)(66446008)(66476007)(66946007)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?E6Z8VIh5RLQXMNoXy0OUzVwNW9W1kEctgQLXdIb0Qgos8x5ODDxVb9NijMYv?=
 =?us-ascii?Q?4WY3Z/yVGPAt5mkXPZArOKohiY+7ile2TyZ+0bXUZ83IbLksTC/NVIVlEKEZ?=
 =?us-ascii?Q?C/kXSF/nduHAusb2hn9G1d0kS3js6SbPyPnsmGKD9oylLv/ExG26IPgNDTju?=
 =?us-ascii?Q?65HExcHEC8Smvx3/jTPksVgTrXCRPb8LuXBZRtBs/Yz48mNua2U30LdDUp6t?=
 =?us-ascii?Q?oJNiK/obHEHjL6hjTkuJ7/nnY39tqjW5PYay1yLPCRlMC206mKEKZun0ZXZu?=
 =?us-ascii?Q?0UnAqyTX4XsF4O0+7oA9uA/76g1M1o17g4cvxD4hExKGJfzCjmr9mClwVDAe?=
 =?us-ascii?Q?v6xhgbzGHuw6UjLJAs7kAIYoUo8IPw2eF+EhrHesNAhWxlJ4uPxUB7HzYvNO?=
 =?us-ascii?Q?gK8PfJZwlp/tAsH32Ha72OZbsSmqbvUGlK5L1JBchRtA8bzqcexEHfU+YahZ?=
 =?us-ascii?Q?3ArmX9U7F/uVoBzQlPmzic0PGOnT8oN5b1tdKpVWZKSjOx42HO4SJ1XdiHSs?=
 =?us-ascii?Q?S5HMrv0dDRiYGkGEjZ9R5xaGlpWECmiPGMFV1tMIbS7vQvoMTYKKHhbGmeRP?=
 =?us-ascii?Q?ssU0tCqgygYjLJXQeA/NNs2Z2XXePHQdBIxhgPWi+rGq01AD/6R/+vxW2Sv2?=
 =?us-ascii?Q?xt9gI4Fea0whitl6PKWNKtVyTjPQRZ10jENf+Bakeuh7owP0241l4N2w8rTf?=
 =?us-ascii?Q?gcGiXD3959EzDyCUwZAFC/BwHOOz2J2HyjZn1/XDrHv0Dl2T6DahFEIdDSiN?=
 =?us-ascii?Q?XpKxKw0b9eqa0145z1JtFU4h1yinecJeZ/3KhuBSye9e5V4o2eFA8y5Al0xF?=
 =?us-ascii?Q?MKcEKzEfT2negdexsj9TzKQ0hwH7ZSN/5y28HBWLteFfVQBM3TESUN1PmJyq?=
 =?us-ascii?Q?1fTcIcse9Y2yxf6sINpWSfW4Bdk9PWF71D8V+XILezGKW5bGiLrk60zyIPXv?=
 =?us-ascii?Q?XdLigTA/u3LEkw6nH6N+yt7xIZQZ8F54SE6k+n8cu3nR+V4GmhaKQZSzz1SU?=
 =?us-ascii?Q?NgpdlaTE5ijxn5JJEgoaEzg07yegy2nkT5FpLXt/m65Jb72qNwdEsAHJhZ0h?=
 =?us-ascii?Q?TTG8qjJqNh/ug/oSnEGKD3Qktmz0BLRn2sbz8LU3Khyu/8fUn8vzXodpuFww?=
 =?us-ascii?Q?Q9Eu5M+osVBd9f0FjTnqnd8V1LoJy///5o5sMcoHzzqYMntzFKs/LERehLZu?=
 =?us-ascii?Q?IL7uM7Vd56likVaH1woO0yjNK/kzoINK/8U9zEgE0dOgDYTe5SEYKCklrbc8?=
 =?us-ascii?Q?w3thRGlhZQRe5cc54PnChuHTvyPX1kKxszTWih0fmL/mMUP+g7LEyy5HvlGh?=
 =?us-ascii?Q?H1L3AF2fA3qBD9VggXCqMpPjKCPst3nYlZeWelrBMUS53JqZ3P20xqk1XOli?=
 =?us-ascii?Q?/XN0HICJqFRDf+66WBkRJMuNI8jhjKmCM8OOXCwjko5q6gp0mpElcYM/wU75?=
 =?us-ascii?Q?h4D8ZHYOHT2M3U5sosfD0YG9kFlwP7SELcI3fc9cqUclR+T9Tf93i4pmk31p?=
 =?us-ascii?Q?IBc2d8DD8VgECJWm61XB3W+hnEdftRPULtGJTFkmWs+Cpt07C6o3f/qxMVvp?=
 =?us-ascii?Q?Hs77l0OuhhaLQ2UWrQ+qDdLwGhEeJUI7KCJxZVCvhZvGEh2VLnPH1BrLkY5b?=
 =?us-ascii?Q?K/+u2Ln2TfvxsU4x+DZWpBOwWIDV1gH1kmy6ci4M0044jM9e6PpOQdXNuVsx?=
 =?us-ascii?Q?bFLU5HqX1a3K7V5L+AxDhejmuYpvcrN+ETeJL0uz+nCOqVnr8oFNWYWzpPEl?=
 =?us-ascii?Q?4pCkCuFC2Ge4YiasAwnGwyag5Wt/ZkB0xdOp/pze9hbTPMybloW0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5a9b1447-8e29-4cb3-230b-08da14145918
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:18:05.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 zuQQJ06vgvMexRz880+JFNQ8asD6rsNEf1sDtm8aB84CpBFlwCfjfOKbolvD78Qf+2uWwWpXJ00oyRjpGiDisUgWZLFl5E1bngB6PRtUu4Qf8HTSdannJBcePTKG2JTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5832
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 14:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7904

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:14
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 04/39] mmc: renesas_sdhi: clear TAPEN when
> resetting, too
>=20
> Hi!
>=20
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit 183edc060e6969a3afe83f663b534f6324fb7e3a upstream.
> >
> > We want to clear TAPEN in a software reset, too, to have a completely
> > known state. Especially when we doing the initial reset during boot to
> > clear previous firmware states.
> >
>=20
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -558,7 +558,7 @@ static void renesas_sdhi_reset(struct tmio_mmc_host
> *host)
> >  	struct renesas_sdhi *priv =3D host_to_priv(host);
> >
> >  	if (priv->scc_ctl) {
> > -		renesas_sdhi_reset_scc(host, priv);
> > +		renesas_sdhi_disable_scc(host->mmc);
> >  		renesas_sdhi_reset_hs400_mode(host, priv);
> >  		priv->needs_adjust_hs400 =3D false;
>=20
> Having half of functions receive host, priv pointers and the other half
> receiving host->mmc pointer is not very nice. Is there some logic behind
> that / is it possible to somehow fix?
>=20
That's because renesas_sdhi_disable_scc() needed only host->mmc pointer.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

