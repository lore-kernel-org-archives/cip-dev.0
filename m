Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F5C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 07:52:00 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.94])
 by mx.groups.io with SMTP id smtpd.web08.16574.1667461910603085524
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 00:51:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=YAYGq99A;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.94, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM+ul7ATKw55g5UEOdY8hoovwyHTg7+HV0BMU87OWSbWF85rV0M98zfA8TzNmBNDhnZOQ/1AmUMJFX20XB/G4mRKWnIhemK5pWoQLR3FPwtntDakYG/prKSpD4YDHHeB/JE8iaH6MbYftsPK3PhjH1jk/SKsElYBCDmPSOkG6OfHZAm3P4J4lAR13ZyE6pCLxPGiS/nIZ8GMTnZVk9lF5AJc0gQWHgv2f++aG+fspGNTviX5usDLI0n2pBpvLd/x294vEI8wxuyoI1StxMjJ82Z162R0oat/oJ4S87KjEYERHxuSfDELWeb1GRaqKTdQIBQosAG1cLDT3tDMdiUe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw8Z9tfKMF12z/qOMh2Pkr+ea3ke7Z/7Jz+2svFq8R8=;
 b=eN+0BbwI8QzfCZTi/VuqoAEHbWDKg/q/DNAzuNOMJUcNS0/SKrrcLko/ThtPs+wY6Zltf+54Zaxy95i0V92FXx25P9JH3FEa4XgpLEhwTpch/sa0zjM3YbgNU+4bKyjxLM+F5hooivCURfMyLeKStc6XT6T+E43IylmibBkOgxo6eL0KFNj1hAP/aq4wdiR2YL+9o61ZO7aAOXUjWWBKHpCgCkHikr0C53ip6VAB88PYRz4nfjLViuFpMzn6Ct3qEh6xPU7lB2NnZjB1Swuw1TjSJZeMrxCtqEDHF1meANaIbuVjLmaHkvikOmRWc8z76o5VnVXkr0YobZJzfvLjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw8Z9tfKMF12z/qOMh2Pkr+ea3ke7Z/7Jz+2svFq8R8=;
 b=YAYGq99Aah/ITI/2HFOkfSfb5vT6BLT6HTsGsUjuMcXts7NSGbA/+JoZ+//kFIddB6ybqAtoB4eZYpP5ml4qCzHF7kmpXfv4R6vBx6d5KfQY6b/EtJjDlAY7wVa09aUq3T/lpp0VxZQRI6cFEW+IIZ8qqHVv2MtgI5LnIqvK9ds=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5660.jpnprd01.prod.outlook.com (2603:1096:404:8059::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 07:51:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 07:51:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Index: AQHY7u2ZOICKdXoSbkOgcUmh7Q95MK4s0jAAgAAAoGA=
Date: Thu, 3 Nov 2022 07:51:47 +0000
Message-ID: 
 <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
 <20221103074354.GA12403@duo.ucw.cz>
In-Reply-To: <20221103074354.GA12403@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5660:EE_
x-ms-office365-filtering-correlation-id: cb540c46-7314-4d1e-d2b1-08dabd7042b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BWtNOBrOjTB2yy+9X1F6Wqma+jIYdjOncz7HjqrlvVgEMK7+qX83Lsj2iih0JkG03HHt0lS3RRGelcC5MXv75paOsnwlMwYCwcxz1MdKEkkab3iVPSpRdR6rFV5bqRbh2yALQi0iKOvybktfsKPxkc805kbLhBKiQh9rqzcEbdEmEfYMsrT0ulIgfpyi6+Ir7Q3pfJxakw+LQNESN63aohFiyYp61oxcB42Q3YBZG5C64I6R4R3AMD/VNO1kFMNZy8vEzAQUOIYY8Zz+K8kakCjJC94mTER6sKiqH6evrzezo+fPzkKyvWAFTGbNcaxYY1KFcLTwlUyta3MffX5bqU2UDDtZ4bEoXDNTMZfiVy5FqvNOpXO3W3/YDtvtt/UIXE5FTMwkKUn1vx7RteAc83AsFrzi1HWVundD4R0r+yJ+/YdFqEJcKWc549EAPtpM6J+f9IAi7sEOuqNt2AxU8nFfYXpEesnyEBLFnHEoOve8dEbMvvk9O9E7KBl5Y+qZQysuXjkwSFTOjzp+pFOKINSF0per+h0orB0RbjQBzEjQsQxVCuERxoQs7eeOJMBSXM1IZ20f9YK5/em7XaCSJemvU+GhddAVWBdkTvNnpKX5uxKQIFVKgAKqDrf+W6wldUS9cMP29Jrx81c5CktqtRZQta/w0EeTfaBB18rCIuoDCOTyP3gNb/g8EkWEPMqNau3oSWhjiSUKhG2nClbdnKaXPIxnZ8m5oX01aBCFoIHwl2GPlzBNsSiZ0SqL6TWXA3CEdiaRTGx/V20umXxE8A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(186003)(6506007)(26005)(7696005)(9686003)(107886003)(2906002)(55016003)(64756008)(52536014)(316002)(6916009)(54906003)(8936002)(478600001)(4326008)(41300700001)(5660300002)(71200400001)(66446008)(76116006)(8676002)(66946007)(66476007)(66556008)(33656002)(38070700005)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cI26zkHWA9rrVBV5WsFV3XbedJ5FVLnVzTkzGFtQg0nCn2dKH7QeRs17Cy9T?=
 =?us-ascii?Q?Hz1JmlWKEOEp0V4tQ8uv+eEz+fdOufVZpgrDRwSqV8prF2cWbqLdkKSEXBJ2?=
 =?us-ascii?Q?a2OhFkebicx92L9uO1y/n9XehnTkj0J42+Fz+FShEOn839+Vg522xgu6jreP?=
 =?us-ascii?Q?SCWolvxZv2RxXUBLbaTpEf+xUt9mtzhfoA43Di2ivbunXyM5vo5ZaTbfSWu2?=
 =?us-ascii?Q?aDI+jc1gKAI9vCWPDephQ7CiHJMono1wkXUvPGU8aB0YKxp6rY8Edo6m6Dhr?=
 =?us-ascii?Q?6U3Q0c4y6JKK9zxlnvdzV6en+QZb9+N4ThaPGAtVYMPCCeF2OiSViyBFop2k?=
 =?us-ascii?Q?fwJr8euN53uuGWBh2VseZuN5NvmFvL9DxQjwEsrQFuEbOiOXi73Sb2egw6uF?=
 =?us-ascii?Q?1PJzqUbm34cUt1gQgrUCwS3CzvQgVBnJlwYdxgSriusreXH1QApZgaqx7Jfx?=
 =?us-ascii?Q?JpHPj9y7+EQk/bLU3CjPbKxjw/SvNxXEKIRCxlXdkMmtwywlHIfhp343BV6m?=
 =?us-ascii?Q?dIJiBCihxRyiQhgMjwbkrricNElbjpP8O9p9oKRyTIkeDtVzbMyCKhNoD/gx?=
 =?us-ascii?Q?wHoiR5ovysheSEcedaWRnbXI/7dAKzcVyniwXPCBP+1wcTiQ/vqtudeYx8Cc?=
 =?us-ascii?Q?yXVShS7VMcJR/GUlfGnunNzR+RQ6HY2SFvW4KAaaGDDYbhqyFsr8KZ8Zv19c?=
 =?us-ascii?Q?z1PNEJyB6BZgbo6jA5y3K0KhFQLFIAuk8r3GmTIOJEyksbTR0LQgMgHa1Okc?=
 =?us-ascii?Q?iop7o0mkvpC9f8Ob7ltHEi/sWf05MwL6XFDws9EVgqYm2ShqTK3ItyLKaXqE?=
 =?us-ascii?Q?/r8IoA3qFE3LRsHhW3Ovj5n1jV+X3KE9Eode0/kvOQ2yW+ciIyaUsKaDD1Yj?=
 =?us-ascii?Q?Mcj/lEeqsXPLlWklfOPmubihgv4R7gCP+rncEnzYQPSUMSXXULPTwBo+Lk9e?=
 =?us-ascii?Q?WMHA90Q1+0FI+1gJsVRiOphAqmcdY8Z+tsd/KHvFYvehzlBIHj/7ie3yd2MM?=
 =?us-ascii?Q?WL1rP7XXD3Lwx5+uOoYNEUmFQ/3HPkhqOEh33erSp6+zbai/bou18UCO6D2A?=
 =?us-ascii?Q?fUb4c2Ab29e5theQuRhaDy1ZkelI5S0WHWQxu0wzJCjwL+Hm+JX7xDxkafEG?=
 =?us-ascii?Q?t2bRcuO4yHol+ZxJAeCOsDnbY/A9Yq8AhiETRSbljB4VruZoAxIuW4z75Ikd?=
 =?us-ascii?Q?mm1ZcSFHw0imIKB8OqsfI0fL7C4Jv1i0ekrb1kbXI3KpUl8WWN/EOYVtt0vj?=
 =?us-ascii?Q?r8W4dVKDl4c8h78zz6bOvqacEGwnHuocrEhIDXbJQbK/aLasnPSNnAjmZvgZ?=
 =?us-ascii?Q?r3RXfmKFyri2YA5+ERvmw/1q80GePNqglngyfDFo6Ai/otCr4BxMu3gHx6Qh?=
 =?us-ascii?Q?zLEvoO5mc6FdHOfWj+BJLlWQPEIY7BTczen3yjCgKSc3Tr2KOqkZ+mIaFFy2?=
 =?us-ascii?Q?oQET2mlLRemAjrxj8+awBCevNJ4L3UJ5OkHO6iIvhUtqmARyhoRSFioyuBWE?=
 =?us-ascii?Q?hfIEUXNdgfZZcdK0BaGJcOP+5rzyyo0WbvLofkJP9Aqnz6AIm+D+FJYeLgPR?=
 =?us-ascii?Q?MtvyrNUCQxdxv/9a/MOyAFNslRafRTSGRzV4LStm7eKoHZXHGZMahHan8aC1?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb540c46-7314-4d1e-d2b1-08dabd7042b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:51:47.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iSH8k49LAQ848qRUwyRtMu+9tn7Im2nxqGvtxAKuLPJGQLl1H/coM+2XbZbrK99gkcv3EAyW5SuJaPnRILalREwAaTMDP9xkn0mTBYcrVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 07:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9898

> Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific
> IRQ handling for RZ/G2L
>=20
> Hi!
>=20
> > commit d887087c896881715c1a82f1d4f71fbfe5344ffd upstream.
> >
> > RZ/G2L has separate channel specific IRQs for transmit and error
> > interrupts. But the IRQ handler processes both channels, even if
> there
> > no interrupt occurred on one of the channels.
> >
> > This patch fixes the issue by passing a channel specific context
> > parameter instead of global one for the IRQ register and the IRQ
> > handler, it just handles the channel which is triggered the
> interrupt.
>=20
> Can you elaborate what "the issue" is? AFAICT the code worked before,
> and will work after the patch, with maybe tiny little less overhead
> after the patch?

Basically, tx IRQs are channel specific.
Previously if any txIRQ is triggered, you are unnecessarily
Checking IRQ status of the txIRQ which is not triggered.

For eg: if ch0 IRQ is triggered you are checking for ch1 IRQ status
as well. Similarly, if ch1 IRQ is triggered, then you are checking ch0
IRQ status.

Previous implementation is good for shared IRQ's like R-Car

Cheers,
Biju =20

>=20
> >  static irqreturn_t rcar_canfd_channel_tx_interrupt(int irq, void
> > *dev_id)  {
> > -	struct rcar_canfd_global *gpriv =3D dev_id;
> > -	u32 ch;
> > +	struct rcar_canfd_channel *priv =3D dev_id;
> >
> > -	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> > -		rcar_canfd_handle_channel_tx(gpriv, ch);
> > +	rcar_canfd_handle_channel_tx(priv->gpriv, priv->channel);
> >
> >  	return IRQ_HANDLED;
> >  }
> > @@ -1227,11 +1225,9 @@ static void
> > rcar_canfd_handle_channel_err(struct rcar_canfd_global *gpriv, u32 c
> >
> >  static irqreturn_t rcar_canfd_channel_err_interrupt(int irq, void
> > *dev_id)  {
> > -	struct rcar_canfd_global *gpriv =3D dev_id;
> > -	u32 ch;
> > +	struct rcar_canfd_channel *priv =3D dev_id;
> >
> > -	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> > -		rcar_canfd_handle_channel_err(gpriv, ch);
> > +	rcar_canfd_handle_channel_err(priv->gpriv, priv->channel);
> >
> >  	return IRQ_HANDLED;
> >  }
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

