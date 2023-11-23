Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBCC5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:51:57 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.109])
 by mx.groups.io with SMTP id smtpd.web11.90095.1700743911680095442
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:51:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=NzFmoa2N;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.109, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc+87tbwxy6ayZ2T1p6uE/XmePgiKTM0kUntR8uAJE4Q+jXPqSOP0p96EFtI3E2V32dTyzqHrmLI7FljEMX3N7AXw37thrkCpCBi/h6PA6sreRFXgnBdIkSdor6fs9o3Aa0bf3/96K4S9dN0Etn94w4pwi4L4863k18nqcXbWge6lP2vHx1chzQi+kZHTYQpQJaJ06lREjLpTD0kzGdFRoHMKbms680PdliUGqzidyAzCl4scNxH9fno72F2zoQbchT/C9hC1wMshNtkcLQMNRI5YcCQ4RjL/bfsJx4VpOXI5L4d0/g6Q7GJ6Ca5XPkKbxkiVpswSm3qclT1TjI+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCbuGsmZbGsEZlzOuOZks1jBz7dinMpyla5mkwi+9IE=;
 b=dlMPCRlMWHK74cx9dnzZ1YoBA5ucxWkTVg7sOA/PwytRWuQ2kpCO6UVPJNiTJa0n2RoJfX1PwzIL64vUH//IGTO5XXr+VFXZaS6JEwgOq8u3zuIA5YfU4kO8L0KBBn+uRRjCNhA7Fr+o0kjuEQ745Y4GmU1ZimuYbYdFv3cS+BhGFysZhMr+n5v/AWXaEJHVQf+jCUe2mnDJeAblaHdqgyM2ZN0Rrct88gP3U+9ZATig0GIInHM5I0v4UTRcvGOTBg5A3webKEIhbJAdysvTuKr9yh8xwYgiYtC1538Yn9bNMW7BL1IrXefg1LvmruHAG1F78/AV4N5/DnHNx/mhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCbuGsmZbGsEZlzOuOZks1jBz7dinMpyla5mkwi+9IE=;
 b=NzFmoa2N0FMGkayZwUtJPpO/zoqOm5/JpZGAWFVmywJAmz3ey8Mvr5Dz9HNlyxyEDJg37xPcU3IbqPe6n9xjp6bjRUZvWebQiViX/Lbdu05qVouQm6m3y7KHavTtS/RI3jSzTfJZamWarrxKJRCoDky/wWMah+7P5xU5Ch33elE=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by OS3PR01MB9800.jpnprd01.prod.outlook.com
 (2603:1096:604:1ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:51:46 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:51:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: AQHaHVCnCyOZxfLIuEC42b1j1b2u8rCG1g8AgACwIMCAAFRNAIAAAKkA
Date: Thu, 23 Nov 2023 12:51:39 +0000
Message-ID: 
 <TYVPR01MB11279EA307E36F38584CDCA4686B9A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
In-Reply-To: <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|OS3PR01MB9800:EE_
x-ms-office365-filtering-correlation-id: 7ebe1fad-e2a8-4f0e-7d2e-08dbec22efab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IILOjTfGeQZWjA9kARvMoPeaDgXMkFo8nwBTAiYVa/zea6w6/QiM3MTwj0UqajhW120KYhFKEX/qW7unL6IfY39j1U9Xkhgdz4Z9+k/pc9GB8eeAbQuqJLfc77xM9GHwd7509aFo49UB8B32II6ukJ4qH4p09sSHH7sFHywCQItwzE8Zt1Cn3Js7cNc3t92jarzJMB7dUG+pKXwyWf/wILrDrH8a52G/6EoNpmetY5R6+h5Pm8SJTjdf6SsITD0nQoEUbIVzPxFL/tJNVXUO6fSO8sG4LVIa7hiZh0EaeplIyaC8yzx0OxP+zLJ8ljazn9A02dNc5F5D1vccBD2eRC2nTyIqco5kz25OnmbJM80caLP7fihjcb9qHef5yxqk3JU4wGGROveUtCDB+CXzOLkxhyF1hL/2+P02OEfQykINI05TFIm4lL8NgSNHF8NIIvceZs6Hm+Ov7gEv4nIVme1FySS4D+ebVpMyxIUBcz3ZDYnRs2A/ht/2XefcjzaGuCUzbcFvcXianjeonLSwh8y+tm0hpQl369l7vFbPbtSoQN4/b4BHwQ/4Z/hkg2OULfnMYJ9LC0ohQobhhyGT9B4wOmFnrYz6NHwJ39UyKvM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(33656002)(83380400001)(41300700001)(38070700009)(6916009)(9686003)(71200400001)(316002)(66946007)(76116006)(66556008)(64756008)(54906003)(478600001)(66476007)(66446008)(966005)(5660300002)(6506007)(7696005)(26005)(2906002)(107886003)(86362001)(8676002)(4326008)(52536014)(8936002)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Wd+3iS2++aw33CjR8BLR+qB/gJJmW4EgXh/3RxFT0zTnWtkARSVYUBBSWSdg?=
 =?us-ascii?Q?UZavwrqw2NnaLX4PIq9tnPDuC7RGjaSDJkrUYDqLMTx1J/lKUl5euru81Kg0?=
 =?us-ascii?Q?lTE7zxhgEJ7Ow08Sa1rLbZBk6tY0NHmu31Bji7svmUZSazQcLUDXzJKSoLfc?=
 =?us-ascii?Q?+RIV8CwfszyV/ZhXvDjUjCwtcjsFZUoPSq4FILQzT90yIBMBtrZ7lcwZ0EVK?=
 =?us-ascii?Q?uM3/Ywzk7DemTi/tN1E8wxoQhGM/aYsjuc7bn2tjtwyXubVvbKCxFxohkBjf?=
 =?us-ascii?Q?7VmbcNi74AQfey0o2eQ0DUgQwFXmtv0T/uBVE3iaMUswGY5JKPWweDxA+RGV?=
 =?us-ascii?Q?gO4IKB7TI/JK+IOUvQYVabtkUdiExUdYUY0LxZIowf90FMW7/HaM5J5KS+K+?=
 =?us-ascii?Q?pz4Z3cicsfXyA9IpXZRWpgdvVj+YyI/foW3jtIxNWirSyU2gmXJE40AZIMec?=
 =?us-ascii?Q?50+/kJoVlx39WmZd4lFbPd87Qrj8N4oeZohCCejOp4LP6eibxHcO48oyjj4z?=
 =?us-ascii?Q?KNpoL6ls1MP2yhJoPKQ/Z/8OIQwyFvwLRex9fj0KOEPjSNWocfF9qNgK0VJ5?=
 =?us-ascii?Q?pK6XWWBJMKdH+hKnBPIklRFYY8lAsJ7DE9MvbomBDkDJ3+YV8jF/82rOYXg4?=
 =?us-ascii?Q?0dxwNU4j0LUJISaXkSiP+5sRlrj2aXm+9TnxWMRqvxc+BZt4pD6tzilODOws?=
 =?us-ascii?Q?2XskZ6k9MyPSGx9ezr9U5WfxFANI+7KkiMigQ10n1wa3fdj6bNZL/+nba88L?=
 =?us-ascii?Q?03wjwXDbRLXPg+nYflkeKvtoaDV2kTcOHncE0lOgV3V4FLW0VLABhpvjBj0f?=
 =?us-ascii?Q?RzmbtNs6nNtzxqyw+M0CMRNCmZLdTayoclFPQR0X4bSXd4aRtrRgBYDQb55Q?=
 =?us-ascii?Q?NFR0fTbLj6I/4KsJJGYGpc/HkeSXSgUoktFcnwuVuwsfGNWwdXH95s9igTOX?=
 =?us-ascii?Q?P4S4wofN1a3PCKQspORtOsCQLH1iAT6FLg9ZeDmz6lPmvADyyBZFzhdT5qav?=
 =?us-ascii?Q?w3/PyF611n7DBlM+/bI4mWZeyN0xwOgz8upm8z5nTyLMpUCzdYcRMQ/Khuea?=
 =?us-ascii?Q?le08N1dsB1Cg9TLsftQVTSV+vr0ifrs3E+baojYCoxH2N3+TPkOjcXkzWvJj?=
 =?us-ascii?Q?+JCx6n36M/QLSxScseC/CbRUEYBIk3mcGd3eh80MGx6SxRU0zxWJcUwXBoYe?=
 =?us-ascii?Q?OrMgLFqNCBu9X2t9vxycfo5PAUaK5YCkO3t6AulkOb5syxKehNkUFvPUKAVD?=
 =?us-ascii?Q?4nNHPtFa9e+p8vEY0BBI/931ZSduD5iywnVR4502/EKTO6ndo/+YzMlSXtAU?=
 =?us-ascii?Q?SKYUrLM9zgW3jcCWX/fJC7KAYGEBEe3EMDMyezqN764oywhJZ+ong6TTufGJ?=
 =?us-ascii?Q?Wl/Z1NiOk/8FGpxtxcLLRf9IeNpv/d0lb2/ZD4EIXb2LzQe3gcByYNPTnB+p?=
 =?us-ascii?Q?YX8VuGceBMsSO1MZW+vL0QtGEojN6h1jNTVT/66cruj3G2OwsXvh8YelihgQ?=
 =?us-ascii?Q?A6naISEIVlYn8EiF3lxobJ+x7gq9D6n6c/0zecVHKhd0VHDsuT+ZHJbcQfTl?=
 =?us-ascii?Q?0o9YnlNyx4Q8iqjRgVFzcVVqZE3+UgRx8dW1hRxpiDo4pedWxBlQ4Dxoigle?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebe1fad-e2a8-4f0e-7d2e-08dbec22efab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 12:51:39.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBlh+RDQHtt2EiG7TYBUBUm5wsE0OVSuk/UrX59mI3fp162nTRikD5GPqipfnB1CQQ33Pb1BXyAS0JpsC4tBjj0xbjCr0kZOTkdaU3p5n7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:51:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13669

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>=20
> Hi!
>=20
> > > > This patch series aims to add versa3 clk generator support on
> > > > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> > > >
> > > > All the patches are cherry-picked from the mainline.
> > >
> > > > Maxime Ripard (1):
> > > >   clk: Add trace events for rate requests
> > > >
> > > > Stephen Boyd (2):
> > > >   clk: Move no reparent case into a separate function
> > > >   clk: Introduce clk_hw_determine_rate_no_reparent()
> > >
> > > I believe we don't need these in 5.10. I'm okay with this version
> > > as-is, but if someone says these are intrusive and we should use
> > > 5.10 versions that don't need these, I'll understand that.
> >
> > I have n't added this to 5.10 as it needs lot of code restructuring.
> > Please let me know if I need to port this.
>=20
> I was trying to say the opposite thing: maybe version without the perf
> stuff (similar to your 5.10 code) would be better for 6.1, too?

OK will drop perf patch and will send 6.1.

Cheers,
Biju

>=20
> I got build failures in testing:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/108260187=
0

