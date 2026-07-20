Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3CC44527
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:00:27 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5586.1784541618081748094
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 03:00:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=a0ot9RaR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.16, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSC/s5rg5NBnSHKDpO5sX2P8hmHyq4J+hBN9hnO2GayHiltqXL+aeQOFwJUJjGCNafEymYPVcXZX/mjw1gbueBo1xlFGntLvd1VbvU2RoHPXzVdBPZaUPJ2Z3mN3JqqKX3iLaNui7woUPKtQTe0cEf07WKUdqYTjTLAv8mq703G9Qmbr7ewrI+98tZIVhvqfVx57wmANZvEcujCHPxnbDabmEsvZ4QR41EuqyjTiAb8f9UzcB+57oxHKwE9XSQbRxglS1hkark1NbvXvcXezP0HBZ1WHPeiyuaX0guVwDh1QZ7+d9O7vJk/dylYoYfyxRsySwdlllHlHJNEJpP+LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F46iqxadfvjHGzFIBVLOyJa/nwULVFzXNVg2kvdfi8w=;
 b=vuSdFd1X4cDLccXXNY5TchemqYKprxT9fKtWSTY8cIg3CXEBAmUVA/UPJt+ORb0u5MTezGoQUMjVntiabcRpWynucEoPEov7zGUMv1DVD0E0TiuzAwtcQcuSInwvjsRhxDg2SnrKHQ54uI1iQD5NPiJtPL3k9zHfZpSVM13PDqh4mOzZ1iHCCoC/t/jyztOkW+Dm9fGYlgioibgUeuvSgMu5h+zlt0DCxoccWaeMklohk+1JcauZEg22Hwii5rlPNJWXCWDK66DUJeJzR4gvIzCOmfoEjphIwb19HFUvm/+40GwZ+yCp1aVjBJmg27Qir5jmHGV2vaueKFZ9zpLviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F46iqxadfvjHGzFIBVLOyJa/nwULVFzXNVg2kvdfi8w=;
 b=a0ot9RaRLU7q71uq+eZ2SL3M1O7VNJJDlimEl7lGnHYPg/c2viPr+Ez6tqdjedZe6SN6iF8QWbiy0WG4ed1CWhl3oHsbQiHXJuEAXUi87BYad5BL8hGD/YefjSGK5APEYFkPc01ItFXm9zZHa59CIEdtGZ4FCtq1P/N7GW5MSDY=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TYYPR01MB6874.jpnprd01.prod.outlook.com (2603:1096:400:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:00:15 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:00:15 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Add suspend/resume
 support
Thread-Topic: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Add
 suspend/resume support
Thread-Index: AQHdFRDLITzMyBU6wEWNLMJNyqAcErZ2Mp9g
Date: Mon, 20 Jul 2026 10:00:15 +0000
Message-ID: 
 <OSCPR01MB143150D7B98E42453819C9FB8AAC32@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ali3OLuCzcYfZswf@duo.ucw.cz>
In-Reply-To: <ali3OLuCzcYfZswf@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TYYPR01MB6874:EE_
x-ms-office365-filtering-correlation-id: 9c0858f4-354f-4ab1-603f-08dee645b283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 8svTiV11hAlYrW1ZnZWGAW8lc/PApxFaFdXIBs3Wmredc3wsLqcaMJ9vXWnh/hiCd8Lr9O+GpUbnqMgDmfodRbpyoV3f8evluu0IlyF1KkEFUBbBBazdoop+q5MSbPu1I3IIEcz61gvxgwgmWPyLEFdEZBMd+kc+kA/PeAxrEHP1/pK862rab+tdb4l0llC48DJhlHKUO546zMhzKUmchQQ3INMsLSz6uehGPvVFT5pcZkny4JtOoztvc/DrGheq+isGdd3yBcrpsfPu1oLci3MA4LhUBodxJ7x0NF2KCuVp4Vah8foO7/DOzaFsS1EDZTgOp4Mj/8/42Fiebmfl5KqiwxYCvq5R8j8qF95UEhY1BhItWOI8sOH3XXw5uMJBouQIToHfRrox8TH8J4ACXDXmYb/D5UEysJyudjxo1ylCmbMqTx1/1tGp0hS/cBMrmutO4Aw7C4rmZiAsAjCFc3Nv88TFS2+GnKPN9x8djunoQ4rIcJKVW0+kWxrxceUKCyjHB6JDrbx8ng6P4qNSPcn2BvHlzJUC0iSC7mMSAvrVQHkonGWUlGJ7avKv+MvrKfmu99C5lfyp8b9U7wOf0RD7/lR7DvBiLxubLRIXUrdXCerzwlXdfbDl7SS2scml5pN8hjYqy5bypfIiOlE5ODYC1Vdqf8UgUJO3Tna2ofCqXc4gw/MTIpoeEiKnUbsjivJAqYeosh1fwtgkzVWSYE8pWaY9wf+T+gX3oOVLYn8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qSML2FL4uTBJs/phOVhOJWCdSgbEfwP4IDnITGdk4DmRoAc153Z7OQgjOOAB?=
 =?us-ascii?Q?DepX5kRqRwOZk7AiM6cWJ7JulFMdKnIX/I86t0yLtxw0Wrms0WarLQKQs30z?=
 =?us-ascii?Q?MqGtuvH3I0fbhUUVuDL1J1Q1oXZT+KvrOE5ONruA4cJ4+dTe2l6X+3gsKeR0?=
 =?us-ascii?Q?MUIYpr5fdaj5qAf6aK0ErYK8qT6ainTcXZza/wOSnphupZZ3OSQ7CVJ7dVbj?=
 =?us-ascii?Q?hG0FN0caYSiYqr4uBJipVYn5E3MmJ13+rt4NgeVAykYZAf8JNlMLL0GRGSm9?=
 =?us-ascii?Q?78YztUpmKofnHUe/ReuI3R5XmgQtFYalcu9Y/tpc2Zd4xu/AfQRkv5bRQ+fK?=
 =?us-ascii?Q?IjEqewCWuor/zQOFcyLI6adYbqJOeiCRhGWQbNjXLvWimbgd+ULuSu1OA3Re?=
 =?us-ascii?Q?ol97aU/HKERixvY9lpRdIqXOyVbF6L4UEd7y0vRugYda+j5XpeMHl7PPDJ9V?=
 =?us-ascii?Q?Fh8vKGfj/87HjYGAyjnu1y3EnGXRPoS5AlF9GEfnRMLd1j4BXVTfbRQqsLzN?=
 =?us-ascii?Q?xL+2Cyb832GLniM+cBtN1CJq7ljimxf1m3uk9Gc7tBjTzeF7Zl9MHhoqctKL?=
 =?us-ascii?Q?jkzRO2dRZoQLIXpNxFiA2gHvGdL7wxQVsvsLAL2IEVvCNw6Gmq0MasuLdneW?=
 =?us-ascii?Q?l2NZIdFBYd4vaibcC6DaMUQgDI+oaM8hromjbY1g0ZGKPzLTSHvvF1GGUZfX?=
 =?us-ascii?Q?Q5kNDvbKBKzlTOBmsvwHVnLdPnvPjannLsM0c9kSaqxFJ6EyCBw2tGUFkSdL?=
 =?us-ascii?Q?9xFKhxlyHNXwegWJXaJ4UwiaUCe8qHNtcF04BG82hfWbA7xXqQ0GfWdRzv/h?=
 =?us-ascii?Q?KIxQDx3tcwp9nO82Kseb7RImfdG8PfAPaha49Oxzt/FY2YHBIsRK0KTNe4aY?=
 =?us-ascii?Q?Tia3TTsfszK9ZZX8NXly7Tls+10aWYZH61edEMhayQ0FpqPhxk7WYHq+q2ol?=
 =?us-ascii?Q?xcad5JRJgEHdl+Ib8fA9noGCT5mb8q/eDB/c+yoMXIme7anU33Z1CXD91QNv?=
 =?us-ascii?Q?bNBLga/y11OzMq/uvnAUc+hVzG9qKGXCfME8I1ghPXX2EH3zJcTnHZO2+dac?=
 =?us-ascii?Q?JSsWhw8T4Q0AGWW2wlYaHR3XrJWykGMXCT2yA9/xD4vstfoXhvQt2hlAlKws?=
 =?us-ascii?Q?/WkgP5Z3KI79+XkWlBYZNt9rjthGOuiQYcKXjWlQVV11247pCoQYyvPjBIJl?=
 =?us-ascii?Q?VxBFdOfrcItdyf5TeCW52Fr8KWc0e1YgfpShm8T6KAEHv0Oag9HmG1TrqSCx?=
 =?us-ascii?Q?ftZd4oAhPzHFFxSR6+KUzqhExp4xrVtdCKxPxT85XRonj1vHZVJ+VOsJmJdn?=
 =?us-ascii?Q?G5GHFXoa1fB3Dqt2LAalQv6LVDnZoJuTycfhkB1M66czcb89aM8d1Z9RFPti?=
 =?us-ascii?Q?MkEYUg7Zq8666l1owgBJN1PypOx1dEU/pFJR5Fnv60VBV1Q06ouEhnNSYE3X?=
 =?us-ascii?Q?/mqNUs7Lszdl1VqVIHWFWwTgPURxkDVMC/6NsAT39kzPExi7bXsfd9AsqYky?=
 =?us-ascii?Q?L3qHBi8QxZxoidLn3h2BKMgzewazMIK4ltuMXAKsoFx7ozf5S/uA+rGHAwdb?=
 =?us-ascii?Q?VjN+AfaQUfc3otIRFE+LnuzLPAsI6iUuPqMayQYkpAaocy41OtU2pThDmVxI?=
 =?us-ascii?Q?72u6IuGhFmHUc2hUyqPf6E6HSbBNVcYqLafpAJTCccFVoRLCLEk4PUhwDko0?=
 =?us-ascii?Q?nxswt3OAnQquiMe7vmwexYeuj3CqNwAGECiseTsOeAvzqCcPoLmzHqWJ6GoV?=
 =?us-ascii?Q?InlNNUZwLq2QJfgOovNddlndhx6SMypmgS3ELBXHoAQXDmpIUYS+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0858f4-354f-4ab1-603f-08dee645b283
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:00:15.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqKtO+S+ydw1eRqEc80302FRVJBAVrt3SQYlB9cQ9QyYJKNfspAyV6eDOUMvCqJOne226yAifJHqePR4+gpMU071prza5sKJQZtP9LU5QbnivsAlcBisB4LM8XAecJ42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 10:00:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23676

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 16 July 2026 11:49
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Add
> suspend/resume support
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> > On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
> > callbacks to control spi/spix2 clocks.
>=20
> ...
> > +++ b/drivers/memory/renesas-rpc-if.c
> > @@ -1024,19 +1026,15 @@ static int rpcif_probe(struct platform_device
> *pdev)
> >  	 * flash write failure. So, enable these clocks during probe() and
> >  	 * disable it in remove().
> >  	 */
> > -	if (rpc->info->type =3D=3D XSPI_RZ_G3E) {
> > -		struct clk *spi_clk;
> > -
> > -		spi_clk =3D devm_clk_get_enabled(dev, "spix2");
> > -		if (IS_ERR(spi_clk))
> > -			return dev_err_probe(dev, PTR_ERR(spi_clk),
> > -					     "cannot get enabled spix2 clk\n");
> > -
> > -		spi_clk =3D devm_clk_get_enabled(dev, "spi");
> > -		if (IS_ERR(spi_clk))
> > -			return dev_err_probe(dev, PTR_ERR(spi_clk),
> > -					     "cannot get enabled spi clk\n");
> > -	}
> > +	rpc->spix2_clk =3D devm_clk_get_optional_enabled(dev, "spix2");
> > +	if (IS_ERR(rpc->spix2_clk))
> > +		return dev_err_probe(dev, PTR_ERR(rpc->spix2_clk),
> > +				     "cannot get enabled spix2 clk\n");
> > +
> > +	rpc->spi_clk =3D devm_clk_get_optional_enabled(dev, "spi");
> > +	if (IS_ERR(rpc->spi_clk))
> > +		return dev_err_probe(dev, PTR_ERR(rpc->spi_clk),
> > +				     "cannot get enabled spi clk\n");
> >
> >  	vdev =3D platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> >  	if (!vdev)
>=20
> This change is not exmplained in the changelog, and it does not look
> related to suspend. I guess it is too late to do anything with it now.
>=20
Indeed, this change should have been a separate patch.

Cheers,
Prabhakar

