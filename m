Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D1C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 12:18:07 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web10.27334.1658751485587452762
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 05:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=mxx0ZmSl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.91,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhvuXbiHtqkqDJr0DF6Gg2+NOryF6BihfzdwREJ+71V8VQEDk5G7j4g7RcoaEWutrOpAGqMB6jy1sRx2TNAqQeJN7lCJe6N+ggfINwgkQBCy4kILBiaJ964fIzQbsJllkSLB9uo+hZpzzPVLbdDM69Y0+8wCFtCDgO/AI5U9zPhMwACNdB+LwS+dxVYejZ+RBFXC8pahWuubxGbsXlCFoXE14LDz08ROV7Mcskl2UszU+XwQj6QcGsWr8A4rlAj2OrVO1HwWOr7zh1i2XHoCtPOuM+eANRDjtlH29ib2pl8JpWI8eISgUO2/kBrJGqA4wSbqh/QJ9JtFKTiBCg6laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC5XjTKXI5+FMlQbxZJCOnzTbcpJS8l0p32CB+4n8Ig=;
 b=cHtORFYKGgv1DmYdAw4/CLYIu/31K5NbdjKEwDXNIeh9kIH9kH0tiHvV7Gbw+9IzAE6ozmPzL3ru4JhDgPNI67lBmsVLjRMHHGhws89FsbS57sVL0xb3QEvomOhaAVjWt3veokUPelaQGa+8LkqKCYCThiHSkyUd8c3d8XYkPqpfZi4x2UAF5+nBWh233tYrmqJG8Gr7pZWTz00q4I7sM+aqJ454EEBOdPWWGDB1f/egY3IuFl9TIsIIA+aFuOEl8QmsLjcWY7KR+hHfQ5o10oeL0Kx/HmgMLOmlEsSx5B7g4f4asXK38G2lXXocUxUCD9axSIvFsp7I62wwEUXH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC5XjTKXI5+FMlQbxZJCOnzTbcpJS8l0p32CB+4n8Ig=;
 b=mxx0ZmSlJDZUY0fd2G9vkcej3Y0hjKaijECT0fti5d1V3LYugKAlyywHuEAnaEiv/UvPjFRAamEz0ztNwrsxqrfalU8Lylb89w9AI3Sl3BKy0V2qs50EG3gpCx4ct14EaA/Y/Ub+iCiXhnIO1jPc/KGKSl5KBUPCsRWxwS5onhs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2261.jpnprd01.prod.outlook.com (2603:1096:603:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Mon, 25 Jul
 2022 12:18:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 12:18:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Topic: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Index: AQHYmogxcFzlQ6ah6Em1foUIny8STK2GGlyAgAJVwQCABpGxAIAAChsA
Date: Mon, 25 Jul 2022 12:18:01 +0000
Message-ID: 
 <OS0PR01MB592235EE30659E43C668863886959@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
 <YtcJMyA+/T0z+FWS@pollux.denx.de>
 <TYWPR01MB9420BA71EAB56F360A3056EC92919@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220725114110.GA4516@duo.ucw.cz>
In-Reply-To: <20220725114110.GA4516@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ad06c73-d0d4-418f-ae1d-08da6e37b806
x-ms-traffictypediagnostic: OSBPR01MB2261:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O4C7+oHGd17nUENsrto/lBdgasjBHqWywODBiNaqBHn1l1TxjGB+OFjUoSWAAuzuOPigkRkPWydyFhSdR5IVgN+CHSEMpMxBVsX7IlUuUhYI786P6geRqiz/Yl3K0U4gZjjVUnp0AhpMSbZ3u1JwbeKf+qx3rPW61vmanb1Y3tyZJ6GQrWNWGDm0L9+gPRrJmz5sgc22l4hsPfPRrFYx4c/HBDAcdqzWKlSZnTd5GpBJjwOUHN6E/dLQNPIt+gVpI7ibc31NFAbeuviAfOaEJYcKXh7Bp3iorA6le9zwvbJRsNpxL+R+lBjVyb6FaK4P4FhZENV6UvIOJOjxNLDYs5gJhONmaipl64b8TeeVgf+51XTrA4J3cldmmb/pDzodIBiCj0iBf/tYgw7cSu3L+eCLGD3oLSTULL0L/XAllTITT5e6v+3XiUagSQELJh8HGesjydS3dpMaC6cQLkaWOKA934b83tzQEqvDM45zviBVHWBZZ9CH7nufQ9KOSw1VFRzJ0h2ml4jt/a/GdTTgBVcCuMFkKlGf+h3axGzGmy0GJNVOyv86iQWCaa+Cllun/l5rrJ7UmGY7TH4LwxW2QAL7oIVown7+SQNMbXybzk3GJDZq5Pwb2YP1tS6e6DzpNpIzqa+AtSwH9bP4rbwrONS6HFErJ+V64j8IRREKK3L6khgGjnXnIcXKgK3Ov5Vn+8K53WSeX6CRH1py4iMep852tGq9cZoTIHIzSS/P1T1CG0sxj16ECE7QGN5hGhAV/0WcsG2NF51C0vexKnlHUOkKj6ID1pTK9hD+SwwpBS/o01mRJ9ANk5q8+OHdJiCD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(4744005)(83380400001)(41300700001)(316002)(9686003)(26005)(71200400001)(38100700002)(110136005)(54906003)(186003)(4326008)(8676002)(66446008)(66476007)(2906002)(66946007)(64756008)(66556008)(76116006)(86362001)(33656002)(6506007)(38070700005)(122000001)(7696005)(478600001)(52536014)(8936002)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bws43hcum29IH4kjlIWdUcuf45Jkb4T9btjAf7uYVYD6funPRM8eDIa2QoLR?=
 =?us-ascii?Q?6Y8tHJDFwnn2nvTb1DjCvQeyKxzZfncTk+MG91Tdo8qohbJnSbpkCktKk0E3?=
 =?us-ascii?Q?CL5u4qKwMktGiYCBk3uoK8wnkXUug+EZQNFN2m9Hhq/6ZnRV6Kt4+vAvplj/?=
 =?us-ascii?Q?WHEMpFlo/LfXfXxiiP6SCTsNTSU7U146owcybtfhfyxb8ZTV1ue5LSKW7VzM?=
 =?us-ascii?Q?dwihUcJnkXSQH9ftCdeuJrgJCwIHTKcaes4QrMFQwZkC+C60EK4lQgHfAh3r?=
 =?us-ascii?Q?7/o0a6csdFY7bxDekUWrLLPknfzg1/w//J5F2+vcdI+Lja0JjX/KhrkNYlfs?=
 =?us-ascii?Q?Fyw1FsMrusmXm8aVxBrk0uUUIBmaAnrDcRV0hK9hrdAiSimqonVf3QQTK4mM?=
 =?us-ascii?Q?HRXfAmmQry3Au+3X/ma+VdIW5Bb6nfhHNw4jtD8ZEIuqaboqDxUY+tzyW/Mv?=
 =?us-ascii?Q?ykQx77YoUxvvqHlTZrmh+NHfJtlr4MW2MvwNqXECKhXqzLAWjLGzoBVkK0So?=
 =?us-ascii?Q?jrDeA+xMrLv4Aj1uA2SrBfLLhuTqwqjk4bTvGE5aCofe/GQ+BrN2e3jvAhtx?=
 =?us-ascii?Q?V+oMOoHdL0pzIN9etEFzk8vg/4KjJdZe55qrxUst790bcY7SH3ziZnbOvA3t?=
 =?us-ascii?Q?atEwF/YWrvYdVDdcHnzHO30mgLd0JUxP14dwucuXHgGp6l1G8YT/pq9zvkYZ?=
 =?us-ascii?Q?NOTC5+/mRHYi3yFglWG+8EopcvV16e+Rh0F5FjkBVzbuMrQKZdvfgmUN6oOo?=
 =?us-ascii?Q?OZWyQGiYOt2UkzBAesd7V8J9kJfJ9bsfJ8zKKQe2XqRkQ94BVc8FpUTN/bo7?=
 =?us-ascii?Q?wY0VVMLIoV+6A0GGkeZyQIbiKni4Xmoesje0Up+Mhb1vyiVEGfn7j3ZFMUrV?=
 =?us-ascii?Q?OexoUnH+syi5S2PxSEyef+m7ant0WsRJk4HIVaXfgXsdma76lk+klJ1DENN9?=
 =?us-ascii?Q?vO8sl6hdJCzhwkt5t2T+1axnzFPsCe2sSUQBCFA0Lgi729zm0jQ/onMPAW89?=
 =?us-ascii?Q?ksUMHGJ2vL+87oOjZQjlklt9U2qtVdN18PnVEylrdkKv6yP4OWDpBKt/ZD4X?=
 =?us-ascii?Q?QhvY1fOZyDwOSAkXxI14zyJNP4oGH+6alqljJGc7mPFhwqNbL7j7JlSY9tIv?=
 =?us-ascii?Q?RbnGhpD9kaa0I+AQxqbEOWb8Mhw9CwvdZ7VSCWN0lrqazmHZwuqBFykulYBQ?=
 =?us-ascii?Q?QF+KLL7auKV9wSAVVKfxbZbHTx5+qoTcv+7rXMJlMErhFaT8GEp94UkCuqVh?=
 =?us-ascii?Q?eWdsllemMFk7FridG0ifKOfob3pH997xRM8s2Uh5suhR6RxINuqgL/hZXmPS?=
 =?us-ascii?Q?1t2hNDi5pWEjGRAg3i5woCbCq7J8b1KJCOtqy/aar4BZ1bUna0vQZXhUV+r7?=
 =?us-ascii?Q?e/999rSBHKnxGZOkhu/wN4H2KH6FK7Tm7I+AM4un4Fk8QsHOxk8piOIK5mf3?=
 =?us-ascii?Q?HJC2ZTEPwL1SeM5ATlAJitppALQdW9qag+F5u/0cI6B0+3XPczQEP603x98E?=
 =?us-ascii?Q?NuXLk2XsgI4VpiSUhuOIeJEIQxZ+I4IXtKlmpjx6eU/QUlCq8AMphBtHJUiN?=
 =?us-ascii?Q?biJxFH1Yjst4VzJV7HZ12ZMV5vJzGLFbDLZKHkg/wdgaBIXst/j4xksmRVsX?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6ad06c73-d0d4-418f-ae1d-08da6e37b806
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 12:18:01.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Omw1lt7vzv9Dq6IPqbl+jN6ttdQjElcqBVFGozO9QhEls7Z62ja9BDXotAv1gKMV8iRHosVBe3bcn0YkzkRGbzAjs2sBl2dLXwRr63m3fyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 12:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8902

> Subject: Re: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
> driver enhancements
>=20
> Hi!
>=20
> > > Thanks for the series and for the fixes headed for mainline. The
> > > patches look good to me (but I can't test/apply them due to poor
> > > network access at the moment).
> >
> > Sorry for the late review.
> > I reviewed this patch series and found no pointout.
> >
> > > I can probably do that on Friday, but I suspect Iwamatsu may be
> > > faster.
> >
> > Yeah, I will apply this series and push.
>=20
> I applied the series, tested it, and pushed out the result. Hopefully
> that is okay.

Thank you.

Regards,
Biju

