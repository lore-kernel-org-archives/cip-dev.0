Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E4C433FE
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 05:43:23 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.126])
 by mx.groups.io with SMTP id smtpd.web11.20411.1664948588630450595
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 22:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=sdRJRZFq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.126,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIBwCpXjGOXyz/+cNp47CbKQ+IoeOQZP/A6Xgs291FZZpb9kUv/G6ZrqtWrDRCer28Sfv17fWdo+mGzgwNde/d2sImorZntcEIXr+in+1jc5uqRzCXOL0nrhLQ7l3iq1V5Cl+KSKYqQT2LT60dQI5zbPVQhLa/qPPKFJH1IIkf7yz3D9YabovELE5zTTpgMi5G0YxlxqDTIBQ7phqXKLWgLzt8nETVdy95hVlxIUWdbkkrZXqGCkpXhhXsMOhR35rRn3z6V823mL4fM2ADzlduJUT0brcRyc9wDHJw+EwCxaSa4VGHeDmBAk2NVvfW7K9OUvpROBLwFGSRY8f9XXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FjX/NRF48s90D2/NNSoklNjNCKVgqTSlbzcyxJkPyw=;
 b=cn4BWl9x8/RUjs2x3w60rJ7jZDIM29Oyuk3Gc7d/g1r/eiAj6jkFBg/y6mIgwIXAbzjnOVNG3OAILt8U8tnJFxKPpOH5DlSPbx8QFGEjp8ovD8x3ZyK5gJT2fZUGOzDnI9Xv5sS2F4PfLgtDR3Pn7DiYQHdx/0c8kWdpFLlttMu7iR6O1CEV3qqL2ynugKZF4S19K3yOXnsA9XeYmwWKlct/DQmsCNYm19MO9+uM/8DFs/Sb60fOWb+HZdYHTz38g1VR9bbyYruuylBC74O9nq4H0evNU3P9DK3eqZbvhj8qhIDrktv4xSZcenTzPpi3qdRS2cgfIxAwz9NInUZpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FjX/NRF48s90D2/NNSoklNjNCKVgqTSlbzcyxJkPyw=;
 b=sdRJRZFqdy8lOQmkmMjz/zIhY8Tf4OU7Xl+K0GvGeerSgYLMZWvsSLZhoOSXoBbBo7capx6QRJWX8NGn5mB1KMejp4x/BR2GqajTTmqkw+PBcYDyYjf5UCvMNheel+hZaCnFsWtg/5dW4nHar6z/zRuE0G6rUhpZB52PnYFLnIo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10820.jpnprd01.prod.outlook.com (2603:1096:400:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 05:43:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 05:43:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
Subject: RE: [cip-dev] Preparing isar-cip-core for RZ/Five
Thread-Topic: [cip-dev] Preparing isar-cip-core for RZ/Five
Thread-Index: AQHY11cLD+nXUF1J/U+2DDdWjsMwZ639GkiAgAC5FYCAALwKAIAAu2yA
Date: Wed, 5 Oct 2022 05:43:04 +0000
Message-ID: 
 <OS0PR01MB59229290D693DD8AF95876A6865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
In-Reply-To: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10820:EE_
x-ms-office365-filtering-correlation-id: 3a4964d4-f106-4272-e612-08daa6947950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w+N4RRT89DTlAtSVwCTkrhD2bcga4DifayU0aLzE/SS+6jQnzaNcsaRwpxVsxn66mJQyC7DnB7WgdSbVPWkU2kiACcYNXIuqlZ7saSb9i5nsIcj5QB9vXDSlH/og2Wkl5JgByWafcBGVxDRkbiaToxwcuoKGn56Zui3Q4B4uzklyaybN3zPHgwtXSCnMXjDc5h5Uvp7T6h1HyFKaicF71Wmw9z0QG78qXk7nDqwVcWl0oC3NYor+Ihsxl63zSn3yTQc0lgGcIOQhkIsPxCdX53cG8gGWJN10PnlKIcWk/vdQQTKIthQZIJQ68s/4eorxxoLNIoYRU8zGkYxt85Q3YATmt1MVwTMnxHjE195SNan47fR8sP8+MnXZ2BRJIJHuD80U7bcqk25S18zf6+fCZ4c1q4pgIMdKuirZMkfBbScL2xWlj8g5ZntYyFGto9N00xCg+QrJ1MGZ6HBElJdj9drns/MCIwQuVALQKBWVEtsnU0pi1e5oGWImozRaksfcBw+MUgl6IUspYAkBWnhKbBNVh2rmaNYpO6jdxYD2zPiPpNvlAx33nsp7JFQR5BBys/r8AqIxdWgFogz7FhGjPMOtPP8fozu878P0mDIGlNy8vxVG2xaM40PZatjJMlxXkFhzbVsz+/v8/gT2QK/QrXe7B+KJxA+XFR08eK3dNB/8PhD/mXF2i14OcNocZ8K/nMw/AA4Vwrk62LN2fDQuRNX9yX+1hO+nqNXHrOW/YfK8aSUwEwXNSYaspSvxS+NNyzFxCT8+gFAMJ/vGvm35ug==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(110136005)(478600001)(316002)(71200400001)(66476007)(66946007)(66899015)(64756008)(76116006)(8676002)(66556008)(66446008)(9686003)(26005)(5660300002)(41300700001)(52536014)(53546011)(186003)(2906002)(7696005)(6506007)(122000001)(38070700005)(8936002)(33656002)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PYqcLSYsmvZo5V7iKyGjV52qgWn9K25WnGgVx7Hy5TRHf+amIzlFlht/8w8V?=
 =?us-ascii?Q?Bn6jt0QRBuXEeC+jvTIr5h2+246mdlq74/v6uUqN+QquaFmuY4m3NybewT+X?=
 =?us-ascii?Q?mPrHIBM5SLSkDT6ZN9z31QsbGbUcz23sSKol3Lp7MQ1Lbzz3Y2YNh7v0KIpY?=
 =?us-ascii?Q?lFaC1ACxNnrfDl2TDiqx7z9Gx2UaTA5l28SJC0qgzfWfh7Pu9AmEbDMJ6R0+?=
 =?us-ascii?Q?h1rrJx9YlvKkriIbIsPzyCKTwZGr6jfwJEA4QhXtweSzVDEra7+QMgAq7btk?=
 =?us-ascii?Q?gvQHHeAYH6Rsrpfu3naVl859RDaRf1uclN0pKivpUVXGNqZaErYnKriSMsKn?=
 =?us-ascii?Q?nKXFMrgTE7bJCqTFinkrsWyd462QX3F7o6/O9ELCi/qfB+558yrpkPzUjAdV?=
 =?us-ascii?Q?6l+zyhG5tmPpnYudG3BMGc6vRNuud+gyzN73aRbtp9qIVgDy29PMcPtY4j1v?=
 =?us-ascii?Q?9CPtYFYgbpeOCVRHud7pYVm1c9izDkDKqTpDfWWZnr3qWOKL62SamDmi86WI?=
 =?us-ascii?Q?Oh/Hns5GDWmJMQUYmmmv1ds9q/ZrduKTgiDnSJqOHhNCGcZCmkyywo+pAo9E?=
 =?us-ascii?Q?0Jq8ha6GqZ8SQ//B8i17LdEKF7A39G0NQK2PLsmi57HXs3j2dXBD/WliE8gE?=
 =?us-ascii?Q?cctj8gFDt2FlI6HUXNyvOct2HAbtxtdwSW/IHlH/qy0D9KBYwDue74x9DeGb?=
 =?us-ascii?Q?5z14paI9vMJhcVNl9AAaknyWUOrC04G483NyB2K/LWOvQuOLVZU6T28wQ5SI?=
 =?us-ascii?Q?cgjlytB4PScIbb69gXMZXIZZkpM9JqPGO4Y3wT3VT+z2jE2kloGv1o0xFIsL?=
 =?us-ascii?Q?hJJ/EwL8MQ50uEHv6pEvzyUoLjjhE4ruc7zOACNLEYPT9RGCr7Iwf8MdQ/QL?=
 =?us-ascii?Q?DjNJceCQ6vLQQsBo++lVVt7FsBH7ks9I9qDwOYWXph6e9lsl451eSXesgGZw?=
 =?us-ascii?Q?3rWwevoUJToLFEF76ydMJRDTQhCEQcNACNIlqmDDPp2smPsg0XhpnfWJzaXW?=
 =?us-ascii?Q?uuY3c+Q4ZpVDsr1f/uj3UTE4Ysr18Dm83xTjn3Jz/8YRRFWO/p0SBl/0bPnr?=
 =?us-ascii?Q?QNb6/7zq5c8SZtLyZj9YEMn+JbbFsNC9z17ASacMIKOoJUpBmsWzlklN+vQQ?=
 =?us-ascii?Q?vu/sJXjODp/mSeKfmFTgu9HZsr6ozU5RdiAHEaEFrrUqaEoxtpZcfERpiX9o?=
 =?us-ascii?Q?9dcGfPqW59XtYtiyB5cJ3UYb9NWQQyaYBz1zVQMieLruv6PzNqkaqQJv/VUQ?=
 =?us-ascii?Q?Pl1rvDW2Iua3yj+HjBizNtL92+z03TalFezxlhsg3Hc0wZf7PzpyCToLnpvO?=
 =?us-ascii?Q?noOxiyIuOhLzq0mjrTqUNPZ59/46+9H4WEKh/+KiFzqXphSoX5ywPuMvp1E5?=
 =?us-ascii?Q?3W7Vmrdu2oIxZOYsxaZy6pnktJimoJ3T9WRVygPxz3JecA9CVkXuTT6Z0dyC?=
 =?us-ascii?Q?R8Sw36DCX2k3K3jh/nDUoypoq0OGVWRcMIv65Q+Lu/t5548bNmDVjKwE1Vqy?=
 =?us-ascii?Q?J8F5YoaQ9ENCwf7oIShq8VsWx5R0E6eLJyBeZfgG+tsxIXXtXOuMuGZuhImw?=
 =?us-ascii?Q?jPCYBNHlE02n/niQRoopmSsyQ35ahyrd0hjgXX+8ezrKOkTZ2A4itPqPsNYZ?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3a4964d4-f106-4272-e612-08daa6947950
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:43:04.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 2RV0vJRHOmL+zJ2DaXJvEmtKDb6cvDuGDEdAynHvQ1zq4+rnfw5TT8NjwErDR3Plvze4mEiLpBr6LvMWonIL8yuIsXy8y3vxmJPaMB94kcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10820
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 05:43:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9641

> Subject: Re: [cip-dev] Preparing isar-cip-core for RZ/Five
>=20
> On 04.10.22 09:15, Jan Kiszka wrote:
> > On 03.10.22 22:12, Chris Paterson wrote:
> >> Hello Jan,
> >>
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>> Sent: 03 October 2022 19:36
> >>>
> >>> Hi Chris,
> >>>
> >>> after getting qemu-riscv64 ready (patches will come tomorrow), I
> >>> also
> >>
> >> Huzzah
> >>
> >>> had a quick look at the RZ/Five eval board you shared with us. But
> >>> that raised a couple of questions, maybe you can help:
> >>
> >> I can try :)
> >>
> >>>
> >>>  - Why is the default U-Boot hard-wired to a very special boot
> mode? I'm
> >>>    missing standard distro boot - which would include UEFI as
> well.
> >>
> >> Good question.
> >> @Prabhakar Mahadev Lad or @Hung Tran, could you help answer this?
> >>
> >>>
> >>>  - Where is the U-Boot tree (upstream support is apparently
> missing)?
> >>>    I'm still trying to understand the instructions how to replace
> it in
> >>>    QSPI, but first I need a fixable source tree.
> >>
> >> The Yocto BSP is here:
> >>
> >>
> >> You're obviously welcome to fork/fixup as you like.
> >>
> >
> > How is the upstreaming status here? For UEFI, a U-Boot from this
> year
> > is needed.
> >
> >>>
> >>>  - Where is the kernel tree (also no upstream support yet)?
> >>
> >> Kernel tree used by the current BSP is here:
> >>
 >>
> >> Upstreaming is still in progress.
> >> We're having some fun sharing things between arm64 and riscv, but
> we're getting there.
> >> I'm hoping we'll have something bootable in v6.2.
> >>
> >
> > I see - over 700 patches for 5.10-cip...

RZ/Five and RZ/G2UL share same drivers except CPU, IRQ and Cache.

Already RZ/G2UL full support is available in 5.10-cip and we are going to r=
euse
the SoC and board dtsi from RZ/G2UL for RZ/Five.

So once, if we mainline CPU, IRQ and Cache and backport to 5.10-cip
We will have full support for 5.10-cip.

Cheers,
Biju

