Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB3EB8FA5
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 09:07:20 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.108])
 by mx.groups.io with SMTP id smtpd.web11.4271.1693991234471679590
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 02:07:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OiMgXgJd;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.108, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6xyrm2ncE8B1fJpRhj0ILag2NimUxMwb6xk0+O4exYHWpMMYuDgvpi8rNqGAHefRgWJiElxwc/USEwitxYoUXkYJzICCOtANs3O7TvziW/mUDSfVhCD2EAzT3qVQQuJH2/07rgkO3uF5bqf2oSrKVLasfaqZ4cC3V0I79QvFbo/uPA/W5HW5LSBO+LITs7n0ajnapHnUVT4jOtZpNDbLtzfAUTbfLvDib5oYjpmPfIy8xcCSxiSBOk8F6MkrlKQeMSE9YV2PppqQIYdOKKXQjkbf9UYm7COZJANC4O866A39lzWl/c9eqRT1y6drxiRORf+gAPu9Gn/s4wsHlK1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp0JHEpst4M0a0t8ovvir3v3Vk4wdE+k1Sf1xlQiPl8=;
 b=J36uyDPjPGvWg1OvZyDTZ++Piui6jp4Wq2x0cLFV4I6BkLyHMJBjCu4K1yryzVITOJ0WFZAnADHtv7gdS+SPtnMFGi4JTfsAlvEYapdQUCPItyFLTeiolhyIEV/jaJl9UXMMyxkL3QqKpHj2qs5lB2goAuFj/GtsK2D3WhTWjVhfC9krhjlWFsP+BKmZNgCJpaPpl5986TfzUNRCtQ93PBdBNxsLJ9W1+3zZrvcf7WH2W5wirUx456t+qSI7UPIX6V/tlWEsET2ZN5XgpRV0a9Ti7Gu9VluqlOFdYbM0i76zt8LPbxLDzfxZbRHtwvaPmXHHokl6rsOLiLYBzO2GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp0JHEpst4M0a0t8ovvir3v3Vk4wdE+k1Sf1xlQiPl8=;
 b=OiMgXgJd27ghg2vS+fFUeLydVNE9KoZhu9v/elB6QcHhEKN6qKFawHbUaKUiElQC4CcafJi6ophEU32zcTlyVdzUXYHm8ciqmJOLAzMbLaEuMJN+pBn6wkmsD+DkFrRph0MCmP/QDWtf/m2NoVJyy3qONvj0xilg3IknmPPSZ1I=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6014.jpnprd01.prod.outlook.com (2603:1096:400:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:07:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:07:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 05/20] drm: rcar-du: rzg2l_mipi_dsi:
 Enhance device lanes check
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 05/20] drm: rcar-du: rzg2l_mipi_dsi:
 Enhance device lanes check
Thread-Index: AQHZ4BMhoVcQeu59P0q0jeATtVSbGrANfPmAgAAEbaA=
Date: Wed, 6 Sep 2023 09:07:09 +0000
Message-ID: 
 <OS0PR01MB5922FA219F61FC154B3FB0F486EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-6-biju.das.jz@bp.renesas.com>
 <ZPg8SUiVWyqxw9O4@duo.ucw.cz>
In-Reply-To: <ZPg8SUiVWyqxw9O4@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6014:EE_
x-ms-office365-filtering-correlation-id: ef162e89-99c4-4e5f-3304-08dbaeb8a677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6rKl524lqZIF/BrxUUq//0XBu4VxPYUL5+e+3heeCMmH+U6p08hck2TTdQzYdOb1OccOW+SogdIpZWmo0DX/i82akbmYVB0LMGE5CnQ2iAwsGeo1u56kaDHDKTJtsYWAby/rHtkxegwR2E/5A3s75Rn+uVIQAoEsTKggjS3Vig0i4qL68WvYCMjfJBmt5w6FZa8ZnDrakOzAPFW1RkSrE8CzWlX5yCvGHjARdRKT8bT7AMkxGhdcfwwpV/9ZzfhDX6+iMH92Z7PXXBncCnKePGDyluVJGeoiLpMH2nWCTimn3g4qh8HA59M63V/4l9IMlewwtzbUdwmc82TZc6ci81lF8JdZsXJfeA+TxsRFXNOLzILVrnCL83PeGy6lQ9wSm2jm6MVuhAn/yhBwfuDo223DQjs0Ez498Fo80K4Mukp8iaEGo7etKXH42ipWA5tkXFRx+a9WP8zHEBtE0/W8inZWn47uB7wFlbftA+EepVHJ4vnt3ezu4wc6E1q1bgnEOr79ZZKjnx0OOfZlIgz3GYCexIv7ubc+stdreSHeqwWrnEFei5P+HY/set+V4fFMY4waJS6hhuV9gE8RCQDaOpTonFGACkgygqqccmqtDPM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(122000001)(9686003)(6506007)(7696005)(71200400001)(52536014)(33656002)(38100700002)(86362001)(55016003)(38070700005)(107886003)(2906002)(26005)(478600001)(966005)(83380400001)(66946007)(76116006)(8936002)(8676002)(5660300002)(4326008)(41300700001)(66476007)(6916009)(66556008)(64756008)(54906003)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iAB7XfYv+6LcYihEtQQ8uK3s2wul9rQxiH2640TUPHQIYTT82+zlW2UeYbFc?=
 =?us-ascii?Q?m9kVqzP8NssAlsiucE/mbBoFXVSrGxC3VBRWwIVhb5dDbw0YnZZQzEa1Vwrm?=
 =?us-ascii?Q?M9KSmiyJrD6THk/BndKoiFxpEdAaBA9wK9UChIYIKkKga0Rddm0r4pdNeyct?=
 =?us-ascii?Q?uQY73OFrf04zzwL9b1H1/jwNImUY7+KxjqxczP9RzrTelFWRXSAOr8L1R2GK?=
 =?us-ascii?Q?QPgxrrgsvXxzjXfxXow1KkHaG3m+gjL9tCtzidgazuvNsHpU4kSy8rMIBi/Q?=
 =?us-ascii?Q?+d/L6OolcmKh+qhGr3pIi6nCmjRkJYO+/hDaWiDkPemnLyATuKYYQDV431m1?=
 =?us-ascii?Q?WrrwxNkv8T4utOUsUBAncz1ycsRDL0BTOdG6WJ9s/M4inSfMHX/PPM88aWy0?=
 =?us-ascii?Q?qP13GPHl9qQu0sPmXghJfF8twzcJf4GRwNnFiK2a9Yb1a1gfhUrxgSMMxKTN?=
 =?us-ascii?Q?I5Tez6b+ACKVdJNHcVyMwve16bYt4p8R7ioLNVXMZhxIgezyv7hSHAmRkvuC?=
 =?us-ascii?Q?NduR0CHACszkTEARc7SDN9cEn1ke0gFScFzRA+2ltBCY64axBmKawPPmVd91?=
 =?us-ascii?Q?9dK0GJCy+gc92m8Y8gv1XgpkMufxfzzBMuIH5y6BJ1ekOu7gdo1F3ZhMELbn?=
 =?us-ascii?Q?zutDubT8NFgNjzu0RZMlHy2rv/VtctzLztq7qXxwg/sgDyZNA/NrL6uqg0y3?=
 =?us-ascii?Q?HrDygwiZbNN9mEDQD05dhlmM5Nn8BQDL4sdPzYW5AdFjL4vtJwqrm8qYEYm0?=
 =?us-ascii?Q?3ou0/iGykaOB1RdKl+3FoPXX/4Ui0MLFicsm3k0nqTthIVXmhOXGqhIzJxW1?=
 =?us-ascii?Q?TKfSvs1cIbTUsoJWF/5y+Dc3mGRIt6390FmrZ2TJAhHQ6onstRTMB1zdlorm?=
 =?us-ascii?Q?bYkHYqW369vxo429knu8DLnL7fHkxqDV2tLQB37jn35YjhfukyATK8Rr+0Xj?=
 =?us-ascii?Q?ug28cpn6xtRDxOeq/il2qfyEbOxgfInPSy/a/VGEUXbyP2G5Z5wsxBwf+FQY?=
 =?us-ascii?Q?JbCZbLU/L1V8LOL3Zf5eA0Ka0Ro1Fl6NdXX614wxENF51o+1X6so1ybpDFQp?=
 =?us-ascii?Q?Am0QaXFU96JaZLFIqIFENeUPcks/D9sSrW/aTgHfBuQDCn9DCV3n/KNL6nu3?=
 =?us-ascii?Q?leIdKTMM/Y/xBASDsT7F/zlC7svLrWP9Pel/3j6Jf3RGbDuO5/I3tzsmpqAq?=
 =?us-ascii?Q?VHYdovfRUoysSPz51zquFcXRAwUj6JLyQ6MMikPQIrGRLWLPRyOpk0LERx4I?=
 =?us-ascii?Q?nuCc+fflMqTOotilANhlURjqQ4u/n33xQjuGXzXNc4d8Ln2JomsrdwOeqcmj?=
 =?us-ascii?Q?HAIh6GzZmfBV5zrN822I6RcNha8YlIy5kCp1TR+Q057LPVxK60fIJsz2qUuI?=
 =?us-ascii?Q?c+Lh7+scznhQJLeJ9daLU31QyI8X+n6NHevS5UUyR4+RXugJursBasnsia5T?=
 =?us-ascii?Q?xboRW9p44RXkFnwhd16aDeaRcZI07Tg6eSBxYpth+WN4mIDF8cBmk49tq9FF?=
 =?us-ascii?Q?ud17EL4qY9G605Aq/W6B32fUp+JOJnEm/Cvj8qCM1RTY9lEMmF5GtdrmHY1Z?=
 =?us-ascii?Q?2Yb6stYnAdvV/UlPxI1nrpITplv67Gk2p7QBOIrHlCnpIRWxJNu8NMmP385D?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef162e89-99c4-4e5f-3304-08dbaeb8a677
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 09:07:09.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIq/i1Q2y7Wuald6WCuIC8cKk4QsJUGHLoBWUPl3RVv2FIctetFZolnl68ssB6EXyNQkXZ8heSMDUBvc6XOw+kz045B0k/R9Cjfxsi+EOmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 09:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12983

Hi Pavel,

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 05/20] drm: rcar-du:
> rzg2l_mipi_dsi: Enhance device lanes check
>=20
> Hi!
>=20
> > commit 418bb3a69e1355c8977c528f8f3896a0aaaecb80 upstream.
> >
> > Enhance device lanes check by reading TXSETR register at probe(), and
> > enforced in rzg2l_mipi_dsi_host_attach().
> >
> > As per HW manual, we can read TXSETR register only after DPHY
> > initialization.
>=20
> So this is kind of strange:

OK.

>=20
>=20
> > +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
> > @@ -220,12 +204,6 @@ static int rzg2l_mipi_dsi_startup(struct
> rzg2l_mipi_dsi *dsi,
> >  			break;
> >  	}
> >
> > -	ret =3D pm_runtime_resume_and_get(dsi->dev);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	clk_set_rate(dsi->vclk, mode->clock * 1000);
> > -
> >  	/* Initializing DPHY before accessing LINK */
> >  	dphyctrl0 =3D DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_=
EN
> |
> >  		    DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR; @@
> > -259,10 +237,62 @@ static int rzg2l_mipi_dsi_startup(struct
> > rzg2l_mipi_dsi *dsi,
> >
> >  	ret =3D reset_control_deassert(dsi->rstc);
> >  	if (ret < 0)
> > -		goto err_pm_put;
> > +		return ret;
> >
> >  	udelay(1);
> >
> > +	return 0;
> > +}
>=20
> If dsi_startup fails, it does not undo the hw register writes.

We don't need to undo all the hw register writes. The
one on the rzg2l_mipi_dsi_dphy_exit() is sufficient.

>=20
> > +static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi) {
> > +	u32 dphyctrl0;
> > +
> > +	dphyctrl0 =3D rzg2l_mipi_dsi_phy_read(dsi, DSIDPHYCTRL0);
> > +
> > +	dphyctrl0 &=3D ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
> > +	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
> > +
> > +	reset_control_assert(dsi->rstc);
> > +}
>=20
> If dsi_startup fails, this undoes the register writes, but
> reset_control_assert is now redundant.

Since we are using exclusive reset controller guarantees that the reset wil=
l be asserted[1].

https://elixir.bootlin.com/linux/latest/source/drivers/reset/core.c#L430

>=20
> > +	ret =3D rzg2l_mipi_dsi_dphy_init(dsi, hsfreq);
> > +	if (ret < 0)
> > +		goto err_phy;
> > +
> >  	/* Enable Data lanes and Clock lanes */
> >  	txsetr =3D TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) |
> TXSETR_CLEN;
> >  	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr); @@ -301,7 +331,8 @@
> > static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
> >
> >  	return 0;
> >
> > -err_pm_put:
> > +err_phy:
> > +	rzg2l_mipi_dsi_dphy_exit(dsi);
> >  	pm_runtime_put(dsi->dev);
> >
>=20
> So this looks strange.
>=20
> My suggestion would be "rzg2l_mipi_dsi_dphy_init() cleans for itself in
> case of errors" (as we usually do), so there's no need to do
> rzg2l_mipi_dsi_dphy_exit() in casa of failure.

If I correctly remember, the R-Car DU maintainer wants
balanced API's.

Cheers,
Biju

