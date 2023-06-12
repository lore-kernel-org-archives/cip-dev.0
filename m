Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA416C7EE45
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 11:38:12 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.93])
 by mx.groups.io with SMTP id smtpd.web11.56105.1686569888679535153
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 04:38:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=uGRzhiWy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.93, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkX/D7cYloEBUOS6BkPakij2rFVsw9vMJpUNBOtKTaFsXhBH37FDouxbS+l/McZoEEKpJXykvm2FyneQYVPbo4ROGUhILwRbyVgtfROfJ4Qu+xUOe00So+iPUoLKH8/zkCIBEoj0cyltja4LBNQ74BwTmSIz2m1KoMlbkaMUqb9VY7FEwVaskHJuN46n5jKeUv2hXBqQnYJ6yFF1dclR7PsAN7DPsXIP8X4zEpLYrOC73q63/L8cMOclHfRcWF2i+SgpK+EaNUefzW1ecTBBN9Ile0CtZJuIpPPbOBHal3zALohXM3TiyyXPkG5wDWQo4ApNyV2t/3oYoEM9F4bXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA8hs0ojiTD8YEhuQCbN7wnypucx3PsL3ySVVgT5SU0=;
 b=NpkSxXqfU3xE1AmZ/aVchhXpjbE53uHKWZq0YeNpjxnE0TvgmckBEzYWlKZB9jE9evfwTeh4fcWg9jmg1B9GkQki96jMhTNYMEAP2uGjKrSrFFqlyF+q9M6my/1S4TyyvmkR6xKPWP0vDez50iJtFOLp+8DSGVSTBi8nFJ2YY59SPshUFbrnPNelPWYUa/q7xQns+H3wMKToZdA79NM58F/fBSVy1sfS6QsfdQAmVL9J1bF1Py7fNRCe70psBBfM3/o9GdpKzNoX6B3uURlXEHUKmTLuT7WTq38Ep19UIUdKhQP1scuTa+oOtZ3Y0b1dLXzB4Q7qHLYyZbGaBO6L9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA8hs0ojiTD8YEhuQCbN7wnypucx3PsL3ySVVgT5SU0=;
 b=uGRzhiWyqPC7gwV5XhoQi8G2uBFEyOhyO1qhlS1y5RXxjumuDvih31UTu7Q+JxUYrW62z47ctQJBEnhxTpPk+pko0H43fw3eZPUgSqiAheSoKcwWyrBFEAKhbsqxvPQrvrLayCBpb2z2U9iovuXIvulYQT/YWZXITew3clFYk64=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9366.jpnprd01.prod.outlook.com (2603:1096:604:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 11:38:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 11:38:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Topic: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Index: AQHZmEvjJmIiIfwjnEK//0R8nkJPUa+CS+yAgAS+bpA=
Date: Mon, 12 Jun 2023 11:38:04 +0000
Message-ID: 
 <OS0PR01MB592224CE4AF99CA597F70E628654A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
 <ZIMAse1ikTuycJ02@duo.ucw.cz>
In-Reply-To: <ZIMAse1ikTuycJ02@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9366:EE_
x-ms-office365-filtering-correlation-id: 2ddd971f-d99f-4e67-72cd-08db6b397c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FBsM5AYSlASdTG2Qn4Fwvcuh3/bkg6eHUYGBejOR7qNsJgIO5jYCqrzk11q06jY5luFminjxRv34b1RwejCyamacd5pOY0+0YLAHL1D3u3Ni4lVIDKWKZcQkwhnAwnol3wBZI+4d4tKvk+25V/EywaORDYxlDbyTcJWg1Ebe33OBP3+B9dbIS9z5LAlXvUfetlHEJeCu8AFqPNDDw+32qRqcjTvRShgwZJunjWyyW1SvtoBwyqiopfznyoUkOAxmqUAEGy5QWcfhuElT2tR4KC4zA3gcuaTg6m9apH8LdRqy5rtKzQh8jj8gYIAVvpwtR041+qjpu8qiiMnB4aJRPQnqPGwbum1FGujxGQJWxsgSmIs6faMQwTQ6u8iViwSXycWUWJQZsnsdnvpITJ8e+R1IX1KSq30G06ORshDzzz3hZvnl/rhbb/38FyfDBvHZB5AEuJhILAId8bKsBul1YwTZlvTnuVvdQyw53k12DoQRAATUgR8G8rbp9Jza8of0OcPXSqTM+BcBZhVqztRkcNMwZGCn3I4UEeAtArpFJD0vOWNK7Y52ciVFkmrvBVkUAIyhP7wLp3LrrZ5pYmfXzMmZBjYG5ovIn+87TMWnNX2YxJ2ho9oZJzFLt3GkHd/Z44OJ0/MCHbMXF9DYeq9etg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(4326008)(6916009)(66446008)(66556008)(66946007)(64756008)(316002)(66476007)(76116006)(41300700001)(186003)(2906002)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(7696005)(107886003)(9686003)(33656002)(122000001)(6506007)(26005)(55016003)(83380400001)(86362001)(38070700005)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5WzHTCZMSj4TD7t+P9Zi7jIWBBuJBkSEH16VpTKRqvjYEwzcLKfvVoJFe3mh?=
 =?us-ascii?Q?1GvYSA2NDzdNFloP9Ia2pFSBbqvFIZicY6jH1W3kGsBu3y99UH1bLRHgRdS/?=
 =?us-ascii?Q?ro6BJkl6idyruklj8UzetBHGdng5GP1fhQ7l16MbrleinM8pzbIIjGfq90/d?=
 =?us-ascii?Q?457l0D4e2WPdExc22QKMOW4W8Y6PCfy7XNPYjJN+KkDPDhj4qPJFbChZLuG5?=
 =?us-ascii?Q?FzTek3h/AJam/+gwCsyy4N4LCP4rFknTIZHjIxKpmDoJ2RlsQEdKdCb2eoZB?=
 =?us-ascii?Q?OLJiinSFI1VQf7bSXKd9LhxzfM9WIrQM/ax5S+niuKUGN3ywnZajZXEDh617?=
 =?us-ascii?Q?+4IT+e4aSkONZJrrYQmvfb/6xtUQ2CjvnKEaVMMqqnRxSx3++hIPQeX0QGI2?=
 =?us-ascii?Q?U8choXGTyqfNJtAaEd0COV5Sry85qf9vZzzufRRtGJnHkMvGDMyCroSygFQl?=
 =?us-ascii?Q?F5bFk0Jds5b7d1gk5TOPG5NzAQuajpR7V379UsumVdVKKUyGi9aEq2iRb0o7?=
 =?us-ascii?Q?kEWaXkoHJRSK8S89D5RcdVxcthXMdpnFeKG0k+GMiI1EgDfpJP7IOUJiMWR+?=
 =?us-ascii?Q?LqZO9tuYh0ZeCr7OXrXGiJr/dxBMzQUcOKjZLHMKYyid/h012OFEUZeK7slg?=
 =?us-ascii?Q?KGt7SfSEjt6vniO48pv3mYmHvKOeWDd0xnfPLPU5HKO21k7nDy7MuzUa0WHA?=
 =?us-ascii?Q?5jIbFZgJ3hAYErI3NwglIVUqLlJNOfMXAYmu6WJpnXUhVmiOlmqasx7+EET/?=
 =?us-ascii?Q?y6LqCBCvIVYacJNHz9oe6kL2JQorbMaFUlHfjpg2BPa6rOO1L6wS0sxc+lvA?=
 =?us-ascii?Q?6/WxgJUfNYRpdc1kFHgjSBuNNpsPzuhwdwQg0WZMxNElXa7qc7NYZ9iIKN7K?=
 =?us-ascii?Q?ZpXPAVJgrhA8u5mkiW7Ao5Y3qbYud0AcVYD2qBVjtuJllP1y6Wm8crg0JKTx?=
 =?us-ascii?Q?gUWJF5HfMAzQ8YwPFHWGPkLF3WZAaZIyTYJSbBa+Xe2ZwWkmteewmVXyH273?=
 =?us-ascii?Q?8nEQOoe33xwodd59oPY9IwpDexxf2QAbNmbYT1MUgAyq+XktsdmQdOGZhbH0?=
 =?us-ascii?Q?MNVF326wGw32tfjrcAW1RNg8yAdgJ8b84VR971JGdGC9tfOx4hNWUvmyJc9K?=
 =?us-ascii?Q?FZhieNUz4isOgJFrA1f7BTdt6Zq5t1i3KFoxKkSb+72X40ATFyLtwgn1CdcC?=
 =?us-ascii?Q?CtZxz/nO2wv4WoiWgIoRkvsuF5RgIqvxTOpQ7LxZxFnvT/gXLWcKybXSKa30?=
 =?us-ascii?Q?eH4iSBtplqlCa953qdm4evqQ6yqMq9L8yOrc8yLFqwA1KVWvK/6uQ3xFNQzG?=
 =?us-ascii?Q?py1GQu9a45smzIckoMLIyRdS+7W7sO8qWmlJDFCWAYg+R8x0gP/UKULFeIxq?=
 =?us-ascii?Q?Hr7xSnwQjgjJWxKTwZBWbMspOx+vB2EU3B6rlZP1eLE51YtgKdTgyYVc0iwL?=
 =?us-ascii?Q?YEJMTn2CL9KZDWC0y+dEZL9Ki6y/pPmKNpXtIF2+rhK5Hu8n4Qfp4N3vhN2S?=
 =?us-ascii?Q?uEG9E6vAQK0aUxeanEOX+9nYce0Io0UjQ3flruf7zuWJHBZxpcBNjslrOD6X?=
 =?us-ascii?Q?GklTXceoApiWJjsdfVM8wzQRy6Mo7PcATq9x3Ekc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddd971f-d99f-4e67-72cd-08db6b397c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 11:38:04.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYjsmlioyyol5lKoqbSuUn5fOV2fQKko2Rm8ljcDZH0K0Ii2UYnoAuQIg2ivu8vCWa/76y1OrxmpeRIhCKKvpwgOM3LtoDjJQ56WImUddXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9366
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 11:38:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11978

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core
> driver
>=20
> Hi!
>=20
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoCs. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
> >
> > The 8/16/32 bit registers are mixed in each channel.
> >
> > Add MTU3a core driver for RZ/G2L SoC. The core driver shares the clk
> > and channel register access for the other child devices like Counter,
> > PWM and Clock event.
>=20
>=20
>=20
> > +static void rz_mtu3_start_stop_ch(struct rz_mtu3_channel *ch, bool
> > +start) {
> > +	struct rz_mtu3 *mtu =3D dev_get_drvdata(ch->dev->parent);
> > +	struct rz_mtu3_priv *priv =3D mtu->priv_data;
> > +	unsigned long flags, tstr;
> > +	u16 offset;
> > +	u8 bitpos;
> > +
> > +	/* start stop register shared by multiple timer channels */
> > +	raw_spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	offset =3D rz_mtu3_get_tstr_offset(ch);
> > +	bitpos =3D rz_mtu3_get_tstr_bit_pos(ch);
>=20
> These two can be done outside raw_spin_lock protection.

Agreed.

>=20
> > +	tstr =3D rz_mtu3_shared_reg_read(ch, offset);
> > +	__assign_bit(bitpos, &tstr, start);
> > +	rz_mtu3_shared_reg_write(ch, offset, tstr);
> > +
> > +	raw_spin_unlock_irqrestore(&priv->lock, flags); }
> > +
> > +bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch) {
> > +	struct rz_mtu3 *mtu =3D dev_get_drvdata(ch->dev->parent);
> > +	struct rz_mtu3_priv *priv =3D mtu->priv_data;
> > +	unsigned long flags, tstr;
> > +	bool ret =3D false;
> > +	u16 offset;
> > +	u8 bitpos;
> > +
> > +	/* start stop register shared by multiple timer channels */
> > +	raw_spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	offset =3D rz_mtu3_get_tstr_offset(ch);
> > +	bitpos =3D rz_mtu3_get_tstr_bit_pos(ch);
>=20
> These two can be done outside raw_spin_lock protection.

Agreed.
>=20
> > +	tstr =3D rz_mtu3_shared_reg_read(ch, offset);
> > +	ret =3D tstr & BIT(bitpos);
>=20
> As can be the ret computation.

Agreed. You mean "return tstr & BIT(bitpos);"??

Cheers,
Biju

