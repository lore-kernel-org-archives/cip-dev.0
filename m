Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8AFC77B7A
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 07:47:03 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.115])
 by mx.groups.io with SMTP id smtpd.web10.3611.1684914417508671985
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 00:46:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IUaZHsnA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.115, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsi/aHbkOS9U7xURJ8I4ynuFnoS59yVi2jdLV3H/Jzb0LcrUy7sNCXzJK8wmykX+q+tr5QpYviyL6wsmYDw8d60kjQ0xwS0qffXik9NI/LIh94WzS6vPu8xBC6FJnTMwJhC/uxNpqQeehcycvV0wXIG9ZjkSnghrI6n4zF9APnYt0njRzshMzSuBep47wyoawut5TNgQXBZe7mblM6cN7Ndpi9KJYMIxrwpFYdgNHQIJ6lU854zitEe6VNvrwTrbZ1Pa5FFGTRF4rbQNA0Ztc/UqGr8BkkXXfDtTip+bS9xZ/xna6RKYuzfCyGrK0PKv7gew5aslLA8ODXeVLrNk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZNsItCqeWYGdPTbIf/1bSKmxBunS3ilFxc9v7wsNYs=;
 b=HRvUCJWwwXadQX9Bz7rVz+dJJYlt2KbW/dZHb3IJ2JDOae9E7Q0nE7CRiTsr3e/ATsCKT8sfxg5KZZiBIkho1GzSYUrkpbOsgzvVQeef23Fbci+gX8V5i6JmHxz8TDG2wCn0aCyqHWke0hhqqL3w409PuprIenCD2qGuRHsSyw8HdQY6PHzI44h5l0MNnPwtViMUJGnITlwJJeFt0crSRH3JJo1JqXx2Cv0PMj6iCzh4y+a+taJbF1oQcExPi/upCqcVgzDzsPahTaWG2lX8BTPuPkabdPP6VEw/wA1i4kMtpRVnaivcOqiv6A6R92gA0yjyaXlb+7Xh7CAgzgSQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZNsItCqeWYGdPTbIf/1bSKmxBunS3ilFxc9v7wsNYs=;
 b=IUaZHsnAPBqICtX+VOi4B7QtVHC7nYCJ2D2AxMVWeeU82ZOFjmv6bGfJ4A479/uH9sLFbOBgw+1dcPTdYkJIorAVnYSWrqD/H14f0K8OfEJGDwx4EGSUt9n39f/wReQ42DnHi9uRGZyz1cBn80RSY+Dxmy5nOVxO9VZ5PNzj0f0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7769.jpnprd01.prod.outlook.com (2603:1096:604:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 07:46:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.013; Wed, 24 May 2023
 07:46:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Thread-Topic: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Thread-Index: 
 AQHZiirvlCSFUDyQGUWjF9mQbrWi9q9iKc8AgAEX+CCABJxVgIAADALAgAEofACAAACScA==
Date: Wed, 24 May 2023 07:46:50 +0000
Message-ID: 
 <OS0PR01MB5922BA0598DCD4AF9804B25C86419@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
 <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
 <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGy9adIV+qjSXZBg@duo.ucw.cz>
 <OS0PR01MB5922E0B4751229CF74A545E886409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZG3AMpZFzOjtWzVT@duo.ucw.cz>
In-Reply-To: <ZG3AMpZFzOjtWzVT@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7769:EE_
x-ms-office365-filtering-correlation-id: 0d3185cd-c2d4-4645-febb-08db5c2b08b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xoESNphyGJx4afIyljxgiriQPenJLMUXmDdRwyWwEXS0foKiN68sHt1IfI33cBuwnlYaO1JNGNtaiz3A+IF67wXlKybZBT/ibbfI9+qLHeSj9Rq5J9y3juTt6gxBoYTcISCmIy0ypnLim+/U/EWCWFraPoCK8z7drDMxQ04nQcot0dEK4eXcluGIXeQQGlYmq7q9QVpDjVFYLKs+r2H2AnROla9zwxL7BmVQkf4FOCjyw+db5kDLGB7OfY/CNiuQMHaWK5yLX8QqVh3v6R3CJUSSe3PU972t9e6QAf5FkSyTDc1ic2jqXChKO5vlza/ALMcC3WKN6gIW+FpOZbjthlGhtEPlFUv9/4rrgKB0H2bQ3oBhC5OYI+OJs21s2K/jbJ5OVA2jhCjBSx8jzmCkPH0Hvhk5hmLN8jNh6rUcjw/JZdMNco/ZbS1alYFPa7HVRptU6EMAnkZKE4gOkCvXKA7By+Av+31selSLEMhhn2TsDixoJezMQ6lH7HHVAyo+Oxs1Jx/bTYiRr+Ke3K4HoPus4lS1au1XcPCK8SGF7zwd5kVQgp77F5FbC8HR7JVd2X68rW4+62PM38/duDaUhVQkM0cNYw5Ym8GwMKQt4V+KJKmANIt5KRtjJWy8GeH+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(6916009)(4326008)(54906003)(71200400001)(55016003)(6506007)(26005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(107886003)(316002)(7696005)(41300700001)(478600001)(8676002)(5660300002)(52536014)(8936002)(86362001)(122000001)(38100700002)(38070700005)(186003)(2906002)(4744005)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?b+AwEJTwiJOakbJir6NVZUV8zMkoI9WNBo//yApgKgc9f9Kkc/UWoUCcbwCc?=
 =?us-ascii?Q?MlPJZmwsGQuNfyIA0PSeB/lu7vBNaxcYpQdwJBSzf1AYQ3jYqXlXMl/2+8fs?=
 =?us-ascii?Q?Kq+TBtOPeAQGdX955bOVBoc4b3tsEzEcJrVvo6CdKLL8wL05xvgNP8HF0kmO?=
 =?us-ascii?Q?IMyfdiRlW6YcrVTuNtIwLmANFK1u+n8iXdUOGXzfpM4W7UiyimOLlOXveLDH?=
 =?us-ascii?Q?9x1JHNf31VVUr8ND8wOvFmRDrDJzoBzw8Eglqn6GHn0wTJKw3YfU3HIJZIXO?=
 =?us-ascii?Q?Vo4Hry2Lnfqm2mVDhubS4nJ0+MBrtWEIhefbNtfOsk7VXCcHX+uUqBk/E59K?=
 =?us-ascii?Q?v+L5gADQOzARMLHHRR7TE//8QE7SkBrXZZmQPImK5hbISRVIFwqUxXIFXNGU?=
 =?us-ascii?Q?FvRL/wtV8bQFf+bE3DCf7OUO5Z9OX+FZdJnrE+CoEBUwVEOzTOLfy7bQRKQd?=
 =?us-ascii?Q?iquUkTDPkYP6/n+G3U1sdNRUndx+GRVQ4AFlsw7Q9b9PkEZINabnUBBn5Oyp?=
 =?us-ascii?Q?0+srwT5NPamlNDI19WediuIvXE7I01vYttcKdOz7mzX0YNvcmzW3jQKbfY/3?=
 =?us-ascii?Q?dkyIjow6S9CaY1QXYv7qDhUXS+SGz4sxNuqc7U9Y+DDYKatC+WZ+atZKj2ZE?=
 =?us-ascii?Q?n/vSRUr/B2N/RzztHWIqUODB+pptOXWGOKilxILU0b3M53ywndYWpQpGJRBh?=
 =?us-ascii?Q?vFt6TknwEhXc4xXtcuulYs1Nns4p6U0yPduvUckmlB/GJ4jLGBPRCRr23kSI?=
 =?us-ascii?Q?jEp1BLyUsCQqlSlIXs7OrAiGWgtsEr0ekWQvMp4CJ1h15aTu/g3IsDbp3JqQ?=
 =?us-ascii?Q?lpNdN9PN3ls5GFPKvuHpDgtzBw/GZ65ZssEwtfjCSgWKj+HoP3C49A442Ogs?=
 =?us-ascii?Q?O4sTOmu5G06UnsZ8UcJYVb6qfGgYPJUmQhxF9g8WLS3R0mKvgHUwc2CtSeUG?=
 =?us-ascii?Q?emwW82RDlPKx4k3cehcAEJeQE3UzY6pLEFL9m4AhtBzfpgVAWo4xVRX4cuD0?=
 =?us-ascii?Q?JmGzHcy098wDsUGxyoUxcSKtjtKWnf3UqGpyYDPLOsG49+AGJQQq6jod9q+c?=
 =?us-ascii?Q?ybKEzhubqRajmaqL/TuIMcu3AJ6967HWxC0UxUkx4LLO0zCyfXnN3YTgY4U3?=
 =?us-ascii?Q?BtKvR8n6YojXhE8Jt/GO7aTnmyFzQCOUKp6yfBJLpEwHp5s2s9HGg2NO2GJt?=
 =?us-ascii?Q?JJYm7mroDJpyX4A6R+KN7tdgke+FbARwgfjEK0IAy0b/QuqxM4NyeJHg9pel?=
 =?us-ascii?Q?blzlC/S/bGjy9XQBkYVTsoomkaE5Bfs1bS6nKR98HUcZ46mJtx/JWKsGrKxR?=
 =?us-ascii?Q?ueXY3fHXvNSij89iLqXZZnbzjJWQi01+Hn+GVz13UbACRAmtG+H5sNzqrJMV?=
 =?us-ascii?Q?yk0XK5dIrGSntb7h35kPpso1jo7IwbCMjy9DfXvYKIWTvFWhZ8Npgl0QlHJQ?=
 =?us-ascii?Q?kNC0ajjlXbXpXN7QfzoPOpUP4TmIy6BidlpDwpUKsUPW5+AqjcO+K4+Z2czz?=
 =?us-ascii?Q?JlaYXbTict9p+IKZfVGEcGg83EKD9DSY9gEaWFm4mXswplw7yeX/jtzJy6WB?=
 =?us-ascii?Q?iwlEEb+Iba6fdGZqRWqUu+mnSB89S+J2Shw2rnky?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3185cd-c2d4-4645-febb-08db5c2b08b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:46:50.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnsUaSl9UI4XE7GYQ4Kb6TgfiuelZmY6HtQLdSJOUM1R/9j4/diX+3BdTjgpDBIOoNhvWylPILAGKXdoKGxscRqWiRlX4qlgpiUc7TUm3hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 07:47:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11627

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
> deprecate old ones
>=20
> Hi!
>=20
> > > I believe it would be less intrusive to make i2c driver work w/o
> > > core changes.
> >
> > What is your suggestion for adding RZ/V2M driver support 5.10.y-cip?
> >
> > Modify the original mainline driver by using the available PM macros
> in 5.10.y-cip ?
>=20
> This is the preferred option.

Thanks for you suggestion. Will modify the driver to adapt 5.10.y-cip.

Cheers,
Biju

