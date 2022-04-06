Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D817C47080
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:19 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web09.6319.1649235155831142255
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 01:52:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OfHJaTEB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.127,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhbr0hH1i3E5urjXCzH3QNTT6rAnylGnnanep6zDqi0Pqx1S/TsR0gZ4W8MZO2qfeQLNuLzoDrNwCQU4zR67EJy0hUJ1aeposNYd4Dn/7+ZkHj4XOarCal5NdrgUA6WXPcgultKuc5U0dh1m1g5c41eFCQlpIVnlImRsMZOmfgwchkfSE1AcdSWRr0SZ+g7ZTvrPSl8wr49bKhS7hjnKvGg1X8iQcrrfrQRX76DuDEk7bZAAfurGD9AnNC946jAu5lccchC8WRNPgbClQhhK6cZG8sXcDgqlflIEUSswKF7WAtccc/+6hk9EWtFQikCMQfbG6Wu/dmKyDyDsVdwR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA8/fXziKgg/AZJy7CGO96For4rMaMs0glfIVwEfNao=;
 b=Nrv3VBvdhYtxci0UjOgjRM39OSi4UeiT52KiivwZnADgQhDCqdKOYJ81a8oprdI+42fZq/Cxsk+jIzUERf6xyRplUTivv3ry1NlzjZTDRGTImyNBYV1l+puehnvQLNYeNBlDOk7Ksh9SoIBagw0RIvLKVMfH3P4FjdSZRxYZ/CQY/QSJXW0Vb5DZjlX7okAc0bFfl971Je29tjW9ucsUuwgpzTFY+9HihM5CKlq8TEmYe/uFrvlSI6lHsUwb+aysB9wh4Md9g2PiYGAtgZXOSROwrMDa13CMiWic5Tuldpsn4Sfv3WJCc3dqkp6WYfU2xdhvMy+qVSVNwMlx7mOeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA8/fXziKgg/AZJy7CGO96For4rMaMs0glfIVwEfNao=;
 b=OfHJaTEBQM29EwN5hL45rLnp/a3XOWly8ldOaIPqrrCPHLvUfIKZy/pva+Cs7ldc6raO6ldO48ggpt9KLbexw5CKEnxpUPVaJ6vTj2HOvWeVXlVHqCnFRWS2Vr5i0YD5o/Ri9a7e6jrAGlLY0Xsebe0bxTU0qE63rOv8DpTMky8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB7141.jpnprd01.prod.outlook.com (2603:1096:604:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:52:32 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:52:32 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 11/29] watchdog: Add Watchdog Timer driver for
 RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip 11/29] watchdog: Add Watchdog Timer driver for
 RZ/G2L
Thread-Index: AQHYSR9ZkY9U7mpfIU2TvQWH5fpErazik6Og
Date: Wed, 6 Apr 2022 08:52:31 +0000
Message-ID: 
 <OSZPR01MB7019A80A6DD843117ABC3059AAE79@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220405185953.GA27445@duo.ucw.cz>
In-Reply-To: <20220405185953.GA27445@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9e1ae86-91c5-4f75-5b31-08da17aac9a1
x-ms-traffictypediagnostic: OS3PR01MB7141:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB71411FF987ED3348A85B3D96AAE79@OS3PR01MB7141.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OkVLSGyziU8Zml3QMZwCaEBKl29c/qOtzrvY7453gHAhyxiqQUZNMIBa/mvc+AQy8xbYgPuy2S71xxDC/PPdjXRPcXseAycN+NeNw5B6DkKZvQ6cRrV+PN78toKDMTlk+GFm3cRph1+N7HwXNEL5oou8VcC0PysHJVUXSMS2xJa4HFrUCa3oJ5id90aFKcChAbonJnGWop3+OpmEzZ7QUF2vnWd2u1qTRZxxao0qR67WganRLjJ8emwvkpJNcGV0nl4A7c5xRw2SnlPJQ+6k0XbTI1VzkJaSVdZQwKXP1uhoXkaeNwWCMgk6Tyo1Ml1551sjBCKRDRNJdtctpAhmyTN0Z8B4Gu9SJNnMabhIc1WjLBMwQcXbY277oJKp2qQ+9jjIZv8+uGKRL1VyEgmzmW5Mjq8yQ3lvM8y1QHw55rg61AgRZr1COaul0ITDr5ozKPlqQKFaFNatscJZ2BuxpNdqnpfuqp2garYWG5qtz0NYLcwX0uzI9jih4NmWIz41ZK6mPnDEwi1jyOkXom+7EJfivnHzzYM/DQQlManPmH8NjP/5bdeAgiq2gk/qSwcU+A0Zr+9vKFGl7ub5zF8GrMVSCW7OntL037Tx0B7iNJgRjsld3PERji6JDjCQ5inxpY9PMv5CPyFEarCZVCv6tkjzbGTvPOi1TNzkwKxeDB7AV3F+OwW93dgE2ei4sKq5fLOGF8tEakLLYviCWmkKCg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(66446008)(2906002)(53546011)(38100700002)(4326008)(38070700005)(9686003)(71200400001)(66476007)(8676002)(5660300002)(52536014)(33656002)(66556008)(8936002)(86362001)(64756008)(55016003)(508600001)(6506007)(54906003)(316002)(6916009)(186003)(83380400001)(26005)(122000001)(7696005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Y3ZG0CXwuquFJ/833hFrGPoZ/YUqDSJpEWHOoioIv1LN2W6KPIySoP6hJvJI?=
 =?us-ascii?Q?c9FVniAYgCXHYAJFiFQW7oiZoA/8QTipuShXol+G2ausWtgnWElZQRRaA89i?=
 =?us-ascii?Q?NUgsTr5RdguREKOl/bEyqqZGEPtE1fqcVhrO0SDBF7TgOI2JbULlkWgSl98d?=
 =?us-ascii?Q?u058oABbYLjzJZKjlssaB8N/zmST3yoi+JqxadpoRpXgBHb2rJ/RQatXEOm3?=
 =?us-ascii?Q?ZwXNmcxQyd4QE+ejptQJcB5dceMkrjhrGZcv2pnHWayGv+l9gShXk8A8+ou7?=
 =?us-ascii?Q?do0Q4x7XDhwoL01wwhJcIiNfRafTADqM1xkFnNyypygq59HjIH16yAmUrEq1?=
 =?us-ascii?Q?6TzHMUhC02AolHm2H1VNfcIy51qzdbWUrB3PlyEttnAEL6HeV0T8q3iEW3J9?=
 =?us-ascii?Q?Ga45so5ErYgdvB8M+nISZatOn4cy6w3pxscZa0QJ6D2IiJCRhG3KvdSv5fzt?=
 =?us-ascii?Q?jVWEeuxzHUbuPOyYp5U60eLGIpjRvKHI26dFitMJKegv1Wias+Lke3WproQ6?=
 =?us-ascii?Q?Z5Q/4NIsbjigewStHCHmvN6cqiPLI+PcByB2knlxEUVDl5/nAz9nVyk0qNUl?=
 =?us-ascii?Q?3IOHVkvsy76dsLxnXt0xYiSxz9rerBCR1/+AkD+F+quRB1CVHz2iu3UVoSHg?=
 =?us-ascii?Q?exHAxx3VycsD5PQhdy/SFTri17pHxIFyWTE9qdYlPbJXkZqQ5E8o1emTPQlh?=
 =?us-ascii?Q?Cuthp67D9i1osbGKxcPhklLlrlxcLgTPam9Q3dGt/j0qGWUU8Tg2VEx0ZCCO?=
 =?us-ascii?Q?hqM4q60fIOcan7/BiXv9Q3f1qtwLW/uDP5O1gt1WfzNcKJVYdMn9ZLav667h?=
 =?us-ascii?Q?WLfMd+iH9jUgcc1EXhMCNpfNZwV7bdd8IZ3eJPrYmeDg1WPkfIWQ7U7e5rTf?=
 =?us-ascii?Q?Lve2ndD3slwKX/FwSTJ2tY/Y/kUfvGfnXmYJQy9f3uguPI/KRxCzn6ak/eVW?=
 =?us-ascii?Q?eoI16tyKN4vdrUbBR7GwmHUHMXQlKKUW6eC7Zkg/0uiUoWz8lJT0lT+zmT0D?=
 =?us-ascii?Q?zEhJk89ZIEA6r7SdyH84WrbkYif+31hm6d2f3jKU1xzd2Ae3DC7w+2DRRDzY?=
 =?us-ascii?Q?n6WU+9CcJqkTLGWpBJ0KysVsRnlgytvl4OOusCu9MIjquQs3KpbH5yU8wuEg?=
 =?us-ascii?Q?hfHICjDIbRM+C/FqeQ6gc4FdVVd4YkhdXnbFDdDVgxjqkIhag+rR4xl9Zy/C?=
 =?us-ascii?Q?TuK12+oUBa/ZM2cuIkYnIxZ+b1DGkiz4ZhUrfow7efwcDJtU9Fbj0MZNUqnf?=
 =?us-ascii?Q?WMHBqCUdIREqBe48bspj5Jb1OlB9j3Iw5FLVA3Elq6tfomQt5FcPfSRfebGg?=
 =?us-ascii?Q?0asCOGnGf7810G0+9rJKkg4kLmLKDcBjbs8gjxHRcF4r9pOxBm/DWDqRR2sD?=
 =?us-ascii?Q?6wg4JUjseO37D0J5Brzenf/vWh9en96H/9y0TVMd33Tnt6g7Jbv937AsXU9v?=
 =?us-ascii?Q?TM26k0eveZFeL7vsBeTIXZzse34Lf7qXmHKrtcaF8EOITZT1FV1wy/OSG60E?=
 =?us-ascii?Q?EnJbe7X4SNsxMQ0tmjrzVU0UtxTikw5hkb4HsyvXtz4xLD9FhDBSf+ifdCO7?=
 =?us-ascii?Q?6/sgQIf6xoYTf/YnIZcXTbAK2+bk2f2i+mLxwX4397APu+WcoXo7tAVevw+a?=
 =?us-ascii?Q?jYQearlL88BlAfD1w36Sa2UKfUs+BGFNuZfaNU3ZeGbJWaRhLavTH3etJrT/?=
 =?us-ascii?Q?JGpMQVPDIDZdUYRSSaaRZ37M77EaVhKEwBnRP7L27L5KO//dje8UMgcK5h3d?=
 =?us-ascii?Q?xxsgUVAL4KtpAic0dbmeJ+yurphA6mu4aAmrQhMLHxqtmjEue/Ej?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a9e1ae86-91c5-4f75-5b31-08da17aac9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 08:52:32.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 amrFfJL4Ji+Jo24DBjuqHEfyQmyqjl9ELwXfJx9iuGH0/8xhpu40GLXiJqHy5nlY81v4WfIk6ntF8gSiQlnIE9goWc3kIDu2Cg/NBkuO66y6DUGxeY0S5fSKBXa33Q/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Apr 2022 16:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8012

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 April 2022 20:00
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 11/29] watchdog: Add Watchdog Timer driver
> for RZ/G2L
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 2cbc5cd0b55fa2310cc557c77b0665f5e00272de upstream.
> >
> > Add Watchdog Timer driver for RZ/G2L SoC.
> >
> > WDT IP block supports normal watchdog timer function and reset request
> > function due to CPU parity error.
> >
> > This driver currently supports normal watchdog timer function and
> > later will add support for reset request function due to CPU parity
> > error.
>=20
> > +static int rzg2l_wdt_start(struct watchdog_device *wdev) {
> > +	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +	reset_control_deassert(priv->rstc);
> > +	pm_runtime_get_sync(wdev->parent);
> > +
> > +	/* Initialize time out */
> > +	rzg2l_wdt_init_timeout(wdev);
> > +
> > +	/* Initialize watchdog counter register */
> > +	rzg2l_wdt_write(priv, 0, WDTTIM);
> > +
> > +	/* Enable watchdog timer*/
>=20
> I'd put space before */.
>=20
Agreed.

> > +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "pm_runtime_resume_and_get failed ret=3D%pe",
> ERR_PTR(ret));
> > +		goto out_pm_get;
> > +	}
> ...
> > +	watchdog_set_drvdata(&priv->wdev, priv);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzg2l_wdt_reset_assert_pm_disable_put,
> > +				       &priv->wdev);
> > +	if (ret < 0)
> > +		return ret;
>=20
> I believe you need to undo effects of pm_runtime_resume_and_get() here an=
d
> jump to out_pm_get.
>=20
Right, for upstream the patch has been already sent out once its part of -r=
c release I will backport it to CIP.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

