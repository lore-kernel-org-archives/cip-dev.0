Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD08C001DE
	for <webhook@archiver.kernel.org>; Fri, 18 Aug 2023 07:34:01 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web10.6409.1692344035355618002
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Aug 2023 00:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=EVV7t3sf;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNMlvA7c1VKiZFhNu8n+vSOF+f0vZ7WbJysqOrNz4thghSVRQhdxDNvsKRWSI7rhAQOS+eBBVqtNLZkbC2/pSk72jqOZCBQI1SDndwowRq5XQX06pVFnc7FlLurxxhrc3p3QXKa4Sxxo+elcvpTqcI6dQAyn83ctm7yMY/uZll0t8tEjwR4e1XONdb+70bdF9HuOdorFj7BCKuOifbSbreCha+jLhTy/EoClzOFsKDB3px1b3c7Dun8sPUGs9g//FsWd4gufUFIVOqqm0yryQ7pFyslIlM6TsXRn/KG8OQakMVg4qNb9HqtHJcwLi4/ujkA9xLKpuK9z0qHbieDB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyNMjLAV7Uz7vVGzxRVAqqTjhQnSrSua0ItN0QIHDGg=;
 b=ELTsKs97ZVgB5315SSsW1ZmVhrJUh6AzM/AQokAZexRKn+C/gSPr/gJ8lOFpS1TzbY/ZhhYjv5vlJ2lhtVLRRv6F9zBhL7n/n0Ch2jS/8YMwW4lMUaOT8IUf7R8elzvLPiuvRVES+KRIs93wGP6LyTXMbguIBF6jVdZB9tQu04qFbReMLwpaTlZX47ChK7Hqr6ufeH023qZeQkDeVivZw6pmJfAFiGRjT0Be8fwOgH3twO+zsHSwspreizBKPb+mG/6khxV9/iEXWeTG69LhNEZpffPf7dMXgEUnMZAnrMJtD6HI2Zwrc2uS7Gf7eyWmIA5PwO4Q+ZBo0QaWDBJ8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyNMjLAV7Uz7vVGzxRVAqqTjhQnSrSua0ItN0QIHDGg=;
 b=EVV7t3sfjG1+TNRNK+Gb/mhil7UwD6pwSG4GxXjoyv9T85gWl7mr1H9s6qIDP2i6EEOBm7pAP8hL6tY1SbfdggToXbVSIhIbux6hxsln0HW0T72haLSW2rE4SWFieOgQyheE1wlsceDOL2osHQ21i7CnWb+OoHboeD47t0/Rpdw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB11116.jpnprd01.prod.outlook.com (2603:1096:400:368::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 07:33:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 07:33:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Thread-Topic: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Thread-Index: AQHZ0E100m17uQrRP0CVNaQTghHK2a/uVTwAgAAH+MCAAU46AIAAAENQ
Date: Fri, 18 Aug 2023 07:33:48 +0000
Message-ID: 
 <OS0PR01MB5922A2FDAA64811FFFC503BD861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-3-biju.das.jz@bp.renesas.com>
 <ZN3/SjL50ls+3dnD@duo.ucw.cz>
 <OS0PR01MB5922BA551BDB1C3BDBA8EAC2861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN8eWPfNz0Q/v2vg@duo.ucw.cz>
In-Reply-To: <ZN8eWPfNz0Q/v2vg@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB11116:EE_
x-ms-office365-filtering-correlation-id: 5833d884-ac9e-4ea4-de0f-08db9fbd760f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pK7qCGg+HvNz8lr8lzwUUuARdUOBWsCBT1Lzi66lWMUuDEavoENtbKRZJlOsYD1S5smdUdnYJIkBO3gcaXpINkZXUWy5AT2FL88mQm8wd3/vZZu2VYqvAc5uxfTVwnJjsDPhXcDReJkb7b8U+SRtissubwIqiKvoCh9fN/gWPuVPu6cwezfMGoKamVhoWZgF7sXPIEbb6bvy4ZdmjFyPJgdD/wxIpGT0CCqkxm5I2FKPg7lU8bw/I2+utwhwVDt2eIro4xpTWAS65ryF5o3KUD7UR6pGMomHFcOxLBVxEYog3+44/U3+W2N5ejLBH3zQxb7pPI6NDcUbR3xUlAuhIMBeA/pFGtrJNC0i7LFb5MefKHj4ngXQOuvBXjQ43VLxXpl3t1tyl6h4KZQ6yxi6ODukDnqhMFiWJW23wHZ6MdwtkOAm8ilvd2VKL5y0gWnhI11g+Ys2jeMCEfTBxPHIuHuhFOH95y6FzSzLoAYq/i27Sjl7sAYQv2veM9aHnboNgeFG5S6jHnig/nwk5XZ8NFBucVCdNsMJFaV050zSDaKaRnp8EoLJE+P/Ij0cBqHFuZ208nIXOOSZyEazy+4jGO4rMzee/9vNeEONV46G6314lf3Yd8JKRFdfHzrIOclp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(1800799009)(451199024)(33656002)(86362001)(122000001)(55016003)(6916009)(54906003)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(478600001)(76116006)(41300700001)(38100700002)(38070700005)(71200400001)(6506007)(7696005)(9686003)(26005)(107886003)(52536014)(8676002)(4326008)(8936002)(5660300002)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7kBcv1SBfkGX+U8Bf59aGHq4yTHiJP0FlYUg6w+9Fx4KSO/dTU6cXxKf50V1?=
 =?us-ascii?Q?ZsLXo7D3u7b0oSR5wX7Gn41IWzhPo5gWAP9Oso8KHg2FVE35d+lbf6Wd8r2D?=
 =?us-ascii?Q?E6Ok/1v5iXXaJm448hFEVxOB/MZNGv8GTquheZTJVOoCznryJQpwrDXwx4VP?=
 =?us-ascii?Q?d3o/enfz7r/uBOVSXf6Ea2vaflbRXTyojDqrm+1yrt9Kf6ztekXNM5SZkqc+?=
 =?us-ascii?Q?0+pnjyFf/3yacPaXY03vPWMoxexd4WwuWaq0jdx1KnDSrs/lYDhVcCq6VC6G?=
 =?us-ascii?Q?LNxykKjNNmBhIjJQBECdUjNjusZybQoJlbZpslYzWaV0wBYamohVb/FdirMV?=
 =?us-ascii?Q?1ntbj58587axaaEdp0oegnNC4TFKG2doPyQhPWfErfCu9mM+fVyvI8b2Yx+q?=
 =?us-ascii?Q?2vWz+Q0QgHO5/Xx+yYqiw0XGutTlMHlsj9/Nj/hbdJ4VLdyhcz9RqztyXewK?=
 =?us-ascii?Q?p1BuRstHIWA2AN4YVgDX8eRcx8u7Y03A9rKqe7b/CLP6qt6++fT7oBVh8XU9?=
 =?us-ascii?Q?6LE7VGb0jrF/8TS05Jkfuae79Tl8O2jJRAIWvWYQUprXT+AU6l5Webthor7u?=
 =?us-ascii?Q?MfCiB0sw6NanDkihjIbhY9thtnNFcSqjxuYTkvq6wHi+MOwekm2YtC9iyCIM?=
 =?us-ascii?Q?fNjw934UA+R/gkbLmNJ485jA7Krg4JcSi3kijnYwkp7IR7iWufIxY8HRb4ML?=
 =?us-ascii?Q?eBwEQCHHU5woS6cgQ+OxtkceBo0uTXe/Mhhhxm2FOvFBVYT8LljxqvPeZNp5?=
 =?us-ascii?Q?bbve0UGwcpPWz2pJnnhfBBqNKc1ZQDMW1fY8lA0mcL0XA2VIPOE1gkcYHDv9?=
 =?us-ascii?Q?+LkWsGUqT0qjOrWtFK/3RGR3lBweTYzlRtmUtn5YVhFsVfrH5WgA7/QnZ198?=
 =?us-ascii?Q?n5hZVY4dviQn8opYokBhPziLqSaY1/D0mx3a1KpaP6imIMX/me5IgCSH6fy+?=
 =?us-ascii?Q?HJ3s0JylxB3JhSzS5MwuRpLL+U5nZlpM8tpUHSX9ige2ItuPCaDw9zJ3hN5Q?=
 =?us-ascii?Q?E7qXHbIG3G8iKrdyXTsOZsCmzwAzFjKumPF2uHQYqc7czg61AgcQRRgu38GM?=
 =?us-ascii?Q?zKKZXzWl6kBxS2+shaOmpUcKOVhs0Kdd67vAJdrd3rvePH+ahkwsDLwkcM8r?=
 =?us-ascii?Q?10MXRA/UVhYCp7P9KRwujdET2xTu5cpJpM2vg8Tjxwy6oZhzVpZkMRqlfpB5?=
 =?us-ascii?Q?xs+ZBbJW41KDkhh6U0e+BGRGvAfFkPmcCt7OCegQuzpdbhbzJMoLi0Y4Kqk2?=
 =?us-ascii?Q?E9tqMjVHFEeEh/B1GFb2M8tiAK7cvEl43iA+6jp17IZjWMTTZgrPfnokjXkE?=
 =?us-ascii?Q?HpwuPuTQ5CAC5IKUk5RVJyQWFWKy4xdzhWXVO5Ku72Xbup3wQsHF2gMNecxq?=
 =?us-ascii?Q?LUQ/Jf8bDygEnav62zL3Cf9/XCxGYFig8oEZRZZtYzHgCzlBSlr6iKkq4a1N?=
 =?us-ascii?Q?CH/E52B8Zh7gCSylywceY68GlYNkp7F+E8yV+wB8YSX7Qm1CksZUNWEKhcHs?=
 =?us-ascii?Q?0DFO1fZqfkpY6sUGIlAC+sC4H+cma6cV4975+FZA436XmjERmHK11qoMvK8x?=
 =?us-ascii?Q?5slIuD8js+0Ehw+SsH2fsq2N6yrqDtmXPEqHjq3X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5833d884-ac9e-4ea4-de0f-08db9fbd760f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 07:33:48.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9xB5AlC/qrj0PEPPdf/BtlNuF7i4vF8z8q1hFznqKZ3MEnoc4Fg1RW9+9Q2yCfTd7TpZRVxCG340RZcpeiF81epRkFgYysCykDIxBvs3Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Aug 2023 07:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12771

Hi Pavel,

Thanks for the feedback

> Subject: Re: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA21530=
0
> driver
>=20
> Hi!
>=20
> > > > +	/*Clear the latched registers */
> > >
> > > "/* Clear". I would not mind checking errors from regmap here.
> >
> > OK, will fix it. I checked most of the drivers are not doing Checks
> > for regmap in kernel. As you suggested will do it here.
>=20
> Up to you really. I doubt regmap will fail in any real situation. I just
> noticed because you do check errors on the first one.

Then I will leave like this as to get some benefit for boot time.

Cheers,
Biju

