Return-Path: <SRS0=CqQ8=D3=lists.cip-project.org=bounce+64572+5629+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB2C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:58:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6192224A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sNfrRNIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6192224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5629+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Rf57YY4521723x95e2shYsWd; Tue, 20 Oct 2020 14:58:21 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.117])
 by mx.groups.io with SMTP id smtpd.web09.2494.1603231100317746279
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 14:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He4yEqGZYsnjvZlDK+E9I5S99c3weOWBTmF4ODdMidIQbJD9AnfM8+sMOcyrMFx2uAYVHeQ/jFSdbbDy8/kPNFQiMVr4EuJjzESMl2sr3YtKObFivqPd+4IWmIKQ7706M9C2d7BxcN3iSHIbujKSqlIPe+qMV5pws0RH4+Ux1oed/EfOZZwAt9u3GD/7P1+psXe1g9TDkgYPIkU09NRsNy5pUSl2cVt+2BgWdvgrwjxt4SBA92Euvl9yzkOe5El9O8Hm5nsM3Sq+GaOS9xmxciX6jNwhtTTwY7Nx06m/LOzO4zjq5Ruyx0sljC2I98jLfR6cX4RSCUSj4mXqAPf4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXuD9FjZMnB3YltAw714RLMIrBQhQx8x0rN8m6CY6Do=;
 b=TM6D9pf06YEXwOnNfNpwvcX2GJLoyS3rGjdn/wh12P2I/lAfsb84acf9aQVMGgnFeVkh58QNn8JBGMMaquk05+cDQkj7i5B8sfTOJBreW3oRV0M8WDGpLbocJ/MYjAMJEFkwb2ryk1DwEBptpg/dgLFPLVYSmUIfcMKK0xTKZjwckMa2ko5mAeYSIeIF4oachYJ3hxDTBbAmmvGWLyhjSSmdtI1NsGgdT81u+Srs8A53v4T4zNhovC/hFMUZItb1iEuRizgZ//Gu2f8gUOyQONAFQclxDtMPJZUjB1SZlf53bjtyGg/nh3pyX1B2P02tzZEwDPWt6vxn3e0BIE5idQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 21:58:18 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 21:58:18 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH
 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Index: 
 AQHWoKK3exH1hEUZukOZtIVkSqUhZ6mW2nsAgAlFTmCAAFCAAIAAEBAwgACDBwCAABMHcA==
Date: Tue, 20 Oct 2020 21:58:18 +0000
Message-ID: 
 <OSBPR01MB5048E28ED3AA02E5D9317B0EAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014093914.GB1866@amd>
 <OSBPR01MB50488430A9BE629033D6990FAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <20201020120144.GA15948@duo.ucw.cz>
 <OSBPR01MB504893210A9C263F008A8F04AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <20201020204812.GC29993@duo.ucw.cz>
In-Reply-To: <20201020204812.GC29993@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9ba9562-f6b1-44e3-d292-08d8754340eb
x-ms-traffictypediagnostic: OSYPR01MB5445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB54452EE4A0084F397E030AFAAA1F0@OSYPR01MB5445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 9gOkkmGk/jFktN4n8hKT39OjbOmdt/71cB5ryYMnDso1YpnvOX9vUdiWpHlqj/yC57akEkPPeVgDE01Y/99UgLugoeFkldHhJ8EU/8v96j0gOW/rEmejAufovCs+4ctDpt/EPEB9dmCJx7njLaMtePFi1hROkiLkbUc7YtCYySkOq3vyZn0T4uaYH3wmmZE6Sqhm1KK79rhCbYS5w914kttF1gOPVd05YdeZSmZJn+7tVLVN5sRcR5qJvZY/Umipxzuf0O+W87baMgngoVZf3ubql222JuchJwbgnJxOaPiNZ1ecMYbvgkpfvIGlReTGXg0d9kuAx0kryH+bwaA5IA==
x-ms-exchange-antispam-messagedata: 
 c+Vp67blX5f65IhVY7JDPSS14k7c4fVy60k96k3SkwBOnJYrCFHLDiTe0Yl8bYfbrum3p0XsdI08j8iM7rSFN5Pay8j+tUVywcoUdg38N1k/89FO6V6QCFhSLKLnTmt6W6mJIYRPvV/BTAHBsd52KUYi3iYLoTFG0WTgS/er++vgO26pEKJIz+eUF+pgDk9Efz4WbqvE3qrzn+1HwAQ/xNIiBgHUXYPRRQWztHuQ9r0Gx05YRT51ZPzDuOVip8tQ3QmykXyxozHizVH4RmOsXfTv6NkEbWxFk9AdybjDZRr/OCgizfqqt8K6d53RmpkICLjGrWXKmqMjBWYvIqmCsXrkSVkJZyLdoWGyl2kucrVrVu9QeZzHN8995nWop/KCT44FOVf/ipYPHfhnMSnloGw9h3W0Z6SmQefEibyJLbDxOPFJRSnGE5GzxD/Hsok/PRiWk8HhQE7uclfLK/e4KxB2WpCQ6vNkh0BHhu+YS2A+uxuErfLdmxwrJVC+8at8IRflRHFGBOFL8DVnIUT9RdfMNCbCwWzLpVPgn9l/2yqf8YP7mw3/h45HplFKJOt588SqSHgd/9MhqYFSIW028kL+ridMDGsDVWzP0WSlNPRj1xXkwUgEMDa0Hx4EV2Fl6Za4+PKTTq4JCvOx951+0Q==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ba9562-f6b1-44e3-d292-08d8754340eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 21:58:18.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBFdqQc3psx+lcMb9IPgnqF3Dc2qgNi24mOkWF8GxjFuCd5ZfsvD8rfRz7n6/VX62NCkJTWdqPmsWvhwlqA7AezQRpSywr62fcYgRtBBYBXnbYBi4mTx/mXBdlgsXScf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1xAqabUJa4SjNl473h2VjKj6x4520388AA=
Content-Type: multipart/mixed; boundary="WI6xmLOnllr4sHSn5RVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603231101;
 bh=VbOxgWlWSJ89Q/YOe5F3rj3BSKeVdsUSWxjcE1Kz66s=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sNfrRNIvx7RoouIQjHB+QLEeAmXmGBabCaobrADxJVfDwGr++4VR2pyN3V1Ix3BxahE
 +7XemZ+dsJcmK37ML9xmJStfGJpwR21PmKojmWo4pSYmtCD2JVfPbt6d1MdYeE7a1bJ43
 ur2cKiYaIhkI2lci3OzRzOw2YQti6k754z8=

--WI6xmLOnllr4sHSn5RVO
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: 20 October 2020 21:48
> To: cip-dev@lists.cip-project.org
> Cc: Pavel Machek <pavel@denx.de>; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@t=
oshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PA=
TCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3
> and RZ/G2x
>=20
> Hi!
>=20
> > > > > > This patch series adds support for PCIe EP on Renesas R-Car Gen=
3 and
> > > > > > RZ/G2x platforms.
> > > > >
> > > > > I quickly went through a series and code seems reasonably nice.
> > > > >
> > > > > > * Since the changes are huge I am sending the patches as RFC.
> > > > >
> > > > > And yes, it is quite big, which might be a problem. OTOH only Ren=
esas
> > > > > seems to have PCIe EP drivers enabled in their CIP defconfigs, so
> > > > > there's good chance noone else in CIP project is using this code.
> > > > >
> > > > > [If someone else _is_ using it or is considering using it, please
> > > > > speak up.]
> > > > >
> > > > We haven't received any response yet, is it OK if I send a non RFC
> > > > version or shall we wait for couple of days more ?
> > >
> > > I guess I'd like non-RFC version of patches 1-22 in a series. I
> > > believe it makes sense to add 30, 32, 49, 50 to them, as they are
> > > simple and fix a bug.
> > >
> > > Would that work for you?
> > >
> > Sure ill get on posting the above mentioned patches as non-RFC in a ser=
ies.
> >
> > How do we tackle with rest of the patches ?
>=20
> Well... I applied this batch. If someone can explain the mutex
> vs. spinlock thing, then I guess we can do next batch up to 35...
>=20
Thank you for queuing in the patches.

I have replied on patch 24/50 to add my two cents.

> OTOH I did not go through those patches in detail, and RFC is good
> enough for review, so... maybe you can just wait.
>=20
Sure will wait.

Cheers,
Prabhakar

> Best regards,
>     	     	    	   	    	   	      	    Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WI6xmLOnllr4sHSn5RVO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5629): https://lists.cip-project.org/g/cip-dev/message=
/5629
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WI6xmLOnllr4sHSn5RVO--
