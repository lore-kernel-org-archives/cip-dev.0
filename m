Return-Path: <SRS0=qFRf=7S=lists.cip-project.org=bounce+64572+4726+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A22C433DF
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:09:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BEA2075B
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YeMUONY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BEA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4726+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8B4zYY4521723xbqMNrhsbf6; Fri, 05 Jun 2020 09:09:29 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.128])
 by mx.groups.io with SMTP id smtpd.web12.14746.1591373368082981591
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jun 2020 09:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrg/JzyIk7idzlFT37M86wMepXP1yZ8aZn/RgvdZG103GAxzgq9wVgaRx4t7sI4aZoRUGr61m+lh7F/q2hN/ZTU6ZMHhH9FiGIRHW22Z+5NDYmUWKqmIhnIKn5iF969oR2QqSCpdg+DdUm0fX4ML3cEriQVe/Ll03kRXoSIbrz2voJV3y9LNmpIzOGN0RuCK/cQ0qhOGX/yZjbJQsAwVy9646fpLhSkxTcd2h5SI6HdLJc7fqj2vk4JxEdVfXSMxmaxs984DqKhKuBdQ95V8WuVSt37wUd6pJmRLaDj7r+W6qfOtU4X2to7TzQ0me5AqxnFHKGccFG4bxBVqdjMhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8mCPXDkawTMPfZeAoHY19etFuKZnpTzdHK6v2nJBDg=;
 b=Fk9381Ri3Cn64Lq8Ucg0Gi78rjkOzf0psxfmNoBNBMfae++3bqSWuzzxEn3jqmNvyJpE7MmOZaRQ+y/2OItFF4oLPupFG+1+kAWMPuNBNuc9pZfLe8vHrMx9O+kFWsxYWtLFtvzB6uWipPhdTsl5Rd/6nk8a/wgby/GAjGqP7HR5nnGgOTCXlL2TbNWsts2d4FaZZaQA5CwfR9UEY8KkN3tGXWYKveo4Y8nWb0pOGKMNSG5dXAVaks3rVdAlPmLgMPRCTreqvLTXWakULqj55KaGkxSmnEIfn1h5BaIe6N8ZK6HR0gN1F+DEccXVcV4/qWHyxNzs8grBMQ3aO2x9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2532.jpnprd01.prod.outlook.com (2603:1096:603:3d::9)
 by OSAPR01MB3393.jpnprd01.prod.outlook.com (2603:1096:604:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Fri, 5 Jun
 2020 16:09:25 +0000
X-Received: from OSAPR01MB2532.jpnprd01.prod.outlook.com
 ([fe80::8c2d:1f49:fd5a:3f00]) by OSAPR01MB2532.jpnprd01.prod.outlook.com
 ([fe80::8c2d:1f49:fd5a:3f00%6]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 16:09:25 +0000
From: "Fabrizio Castro" <fabrizio.castro.jz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add
 LCD support
Thread-Index: AQHWOLn8nKklIc/nz06d0U0gk4cPEKjF+fIAgAIsuACAAaqw4IAAGp0AgABIeKA=
Date: Fri, 5 Jun 2020 16:09:24 +0000
Message-ID: 
 <OSAPR01MB2532BE73DBD5306957574256C2860@OSAPR01MB2532.jpnprd01.prod.outlook.com>
References: 
 <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB298388B7BE773E7DD4284E4A928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20200604084220.GA18398@duo.ucw.cz>
 <OSAPR01MB25320997874CB4CA51FD876AC2860@OSAPR01MB2532.jpnprd01.prod.outlook.com>
 <20200605114446.GB26010@duo.ucw.cz>
In-Reply-To: <20200605114446.GB26010@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c27ca400-466e-44b8-a844-08d8096ad116
x-ms-traffictypediagnostic: OSAPR01MB3393:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB33933F8B69EFA16A55537875C2860@OSAPR01MB3393.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 sIlKVcpFGmLYmGZ0rwQibLLywippv6gfhca4mZuu1UCOvHC5b5uzigxHupcOrpku/uNSBG5bM9nHWDIQLT5zjEKwEuuNzvlckWpDHg9M+QXBp1QI6mj8lnomRh8w2opLI2gO2zC+NwHq7LH19ZaJAnVT2L+oKJ1fHvY4rzRunf5h8lVsG4bhKBiiwnAyUCZf2i8wIQH0Hv10Z6a88AXJPMWeldGdASazm1z+kKJoYkKQKO5MeD6g71vrz9Od9Ih24SoYLxLrzNWhhv9Hg1Y3uvNSOCeN+RbN9zcRLg8FMeFjCBSGFOQLettPGL1/wyYSs9vPaaR5H4XtYePT6TzbRspIFpXcHKcBcO/TDr1Fyf0lDlJJrVvP4LsrKLjI0dfLrKc4nqxjPhPb6vUM+euomg==
x-ms-exchange-antispam-messagedata: 
 rJNFQfshIUu43lwm8EWt4jbUxoKBSu/zx//5JgZvmkcuDKrMIw9YnD9ClVD6O+KOTYJLyJeYRj5oeNvV/J0HZOQfdWiP7vYeHOzzfx/kXUcODZG2Lw5xp2bGEQN76gYcZwhr5/gNKtwRsmj7L/76HDj6LtUJHRhDWfgNNFSIRaOEpNUmkmHPmH+YwstCNtnJNyVHEX3u6c3fLPqttvQIyLuvCEZF0esaq/WtMDC7YNX/NxzoKT2XYrX7YeABxdNgU0z9KKvfLQMIHR9mA58JYVPKgxpQrnD0oWZvLLzQG2lJUifEwofmE6K5WNFyEvjotpqnR6wZ/VeNWCDzSy0Vugh7cK7neCLUhF27+OsE7i0gVnqBauWkPZgAYYcNwXmP6BlbbfBngDShnlrJLFaj7SXfPycC7fAfzLDVAeIGrceyPBLfDt+v333tidlaMv9LlzR+sX3gWRnawHTVK+QkXyFqgkCOyCoajKTYocQSdVHNpT1xH6cb/gn9JpwqPXPZ
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27ca400-466e-44b8-a844-08d8096ad116
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 16:09:24.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HN61ontiPcUrkLQi/aeARXJTniNpcRJ8l874sdCEFFVARyZKgZqdTHByv3zR/uEi6ID42eX+7Tf8rLLXnn5Rn60fJjaySzN2gH43QXq8HyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3393
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fV9F0EWGxSnQTZqzoFZ8AwUVx4520388AA=
Content-Type: multipart/mixed; boundary="MyGfcTxTLlIe3kKoNOG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591373369;
 bh=zJ5/fBmOf0xJWBz61FDiUtS9KW4in2VdwUBrrwnndNs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YeMUONY610+jxOzFx+jIfBN4IEdn9AzCIx7aGv8VBmuVYjKtrl05NFMlpF9VcSqc0JV
 LG7K0ywZYte5HoDcXG+oUCAaFkiQNd05Emp1wO0ivYyO/JJt8JzsrPxFJDwD6oSD0IpGL
 EPTY3pLDbBbDQI3IUVMMA4QoheASTv8FM2M=

--MyGfcTxTLlIe3kKoNOG7
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

thank you for your feedback!

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: 05 June 2020 12:45
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Chris
> Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: =
Add
> LCD support
>
> Hi!
>
> > > SIMPLE_PANEL is not enabled in
> > > 4.4.y-cip/arm/renesas_shmobile_defconfig , and it seems to be driver
> > > relevant to this panel.
> >
> > This seems to be a problem. DRM_PANEL_SIMPLE depends on DRM_PANEL,
> > but DRM_PANEL is not user selectable, it needs to be selected by anothe=
r
> option.
> > In upstream, commit:
> > https://github.com/torvalds/linux/commit/bf7149f34
> >
> > modified the LVDS driver to use the panel API to delegate panel handlin=
g,
> rather
> > than parsing the DT manually, and of course in the same context Kconfig=
 is
> > modified to select DRM_PANEL.
> >
> > I think we should have another look at this, do you guys think it's pos=
sible to
> drop
> > this patch?
>
> It is possible to drop the patch and force push before new commits are
> added on top. It is also possible to queue a revert at any later time.
>
> OTOH if the patch is not wrong, just needs another patch to be useful,
> I'd keep it.
>
> Adding prompt to Kconfig so that it can be enabled manually should not
> be too hard to do.

Thank you for laying down all of the options for me. Since you are open
to a revert patch, I think we'll have another look at this at a later stage=
,
fixes will follow.

Thanks,
Fab

>
> Best regards,
> Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--MyGfcTxTLlIe3kKoNOG7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4726): https://lists.cip-project.org/g/cip-dev/message=
/4726
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MyGfcTxTLlIe3kKoNOG7--
