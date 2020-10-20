Return-Path: <SRS0=DZv+=D3=lists.cip-project.org=bounce+64572+5596+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D942C5517A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 13:01:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C7122475
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 13:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FVzxugSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C7122475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5596+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JyKnYY4521723x5kOTTqeKFR; Tue, 20 Oct 2020 06:01:34 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.113])
 by mx.groups.io with SMTP id smtpd.web10.5706.1603198893275194077
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 06:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHl1BpdVecjG4nFEHFszdrH7B9GnqapcE0L/pOWSkXEshkNZsBN1z74SWGMdBDj6fph+fKOAfBcbBQ4D/ABslRZbd90++neATo4xbKwke74PtpB123XvBJ7J22ATli2PRZ9sKoAOwsoD3Ne/ZX8RVCcsyQO0W+v0wy+1xoxH4q+nP+4UGwp5yYwYvdO1b392Ys2aQQ4V4K70lCeRcqMaHx/y5aY4luqTwqnK4msOQOA5DE3J8+G3e7MHQLw2qx09iKKV25zst/neDc3Fv4MuGPKt3uHzrhHih4Lp2CP5LvFwFGOuXwkgIRtIWKKmyCbVdcIWYXzZWsBvumB660JIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+AlG/3Uq42PTCXpSgPShwYp9ftXVo4tn5r9y1QNTL4=;
 b=JYTDD4yVwSdU7peA+GtlAdHlKRu9lKEbGvO70Dzr4xQzFO99b+vPdrhAm9C36a8ePstLLfeO/bO3UW2L1Xl4cxOXoUi1IvolOAolFRPpvdheXq+oVQyvYnTma5ml1/ma0RJyBr6uznyWUThLvpydC97MqZ+jutLlVZ1KdMVL9+IpEJZPMiR++hQGHdjHi0mo6m01lNU8EK1mNZD+gND9ISsANTTohAC4QjL1WuTHR8134N69klLix5W7l6htwa6Tefn88e+aEeVmOF2ELsKCE2lJEtL8Fa8N7QhAXC/yVTEAPDdW8cSIsP9IhpPDUN5QOwNFynlj7m3c8hc9Hcq2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB5223.jpnprd01.prod.outlook.com (2603:1096:604:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 13:01:30 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 13:01:30 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH
 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Index: AQHWoKK3exH1hEUZukOZtIVkSqUhZ6mW2nsAgAlFTmCAAFCAAIAAEBAw
Date: Tue, 20 Oct 2020 13:01:30 +0000
Message-ID: 
 <OSBPR01MB504893210A9C263F008A8F04AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014093914.GB1866@amd>
 <OSBPR01MB50488430A9BE629033D6990FAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <20201020120144.GA15948@duo.ucw.cz>
In-Reply-To: <20201020120144.GA15948@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 483ad426-d144-4db3-4b58-08d874f84376
x-ms-traffictypediagnostic: OSBPR01MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB5223DBA7439AFC72E2018075AA1F0@OSBPR01MB5223.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 BpaKGvBOU58KFP+AT+QxacbFA2Z3QoVDJ6r8RVr3oo23jpQNpByxpuUOH9HHtaI40G4cbej7AaMew2g3K8yqtHlNsegzkmUzr78WtyGaJXy+uhaoj3YwSwy21rk+gII71tZxc25PdVK9Rvw8+Kcd0xLlE6dptsMJeFogGm7UBlkOVJqFcFiKSRA9BjJ8n4+VUNocnbWbBe/k85t2iVgkr77tpYr5GUl1Z+t57VZVwTVRbBkIb/PWcFMOB0SLNtedhdQ35X7alae7I4TJDHfc/kIozdDTDPDTobNfTAqhq+G4GYC4GapChlX/iQci11JSLVI3Y8/dvPNdoiSQYJh3wQ==
x-ms-exchange-antispam-messagedata: 
 onICjhyPQn+LEC12YRIfkUeB1LIw3Qy5sJJiMbtndpObb6V3isRV7cYrXwgaKjG5KURKrrfJV3QQQhAYXA1Bb8eo9QtJSiWB5h4wsAewFuSNcOg94502yUJz9zIuOpxDjUJVq0JTVAwi657VBquPOmrNZVqV3yee8GWWKzOlRikIh90hsNWHRJ5WSZb48uQ6e91SuL9EH9dbJNejmNiJwRcLlXr/RpoklL/RVepCtdE0rtUHXKBv9GqtSkPpb+QFNy0GR39Cchx7+Gv2EtOXI5XFFQfCdwQYM4GNVkWbqKFVekUQ3RpYVjC8y9l+1lslDyGlQ6B0zloagCxxjN14STZPLRLA5RzanRu5oSIVoaz3lgaY3giHO8Q0PDQ1sxtFH4S9k8RcJoDZc8V7jljrRwozlu3a6L/PnjxRBYFLdnepybguPSGBJ6ymDyztdV2tf3/ZfaeQnwGQSch5/FyVxybwa3j0knp48qSu0s5iHfwBTYU+oFgkugDAxGpdhPZfkka5GSOsy8dU97hYzfO20Daf/c7F4PHhwqOBZx86hBmir6/E50eVEQHZgaX+CoXxIN9wt2ZA328395DUbiKLxg/2GWJdwYQBzL3pvbKYjyvgWJMbF3imE1NZ9ZieW2qCFQo+o0cLu/oV5Vi26hIOMA==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483ad426-d144-4db3-4b58-08d874f84376
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 13:01:30.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOn7OsGv6vAgnGIkf2L5NYcJhdRIK7ATgPIrBJiK3vjd7iGSnySDGlBOBgV3AyVH1d2pGMQx3jCSIzTFRE8Os78HSF4TWpN+yaBltF++p4g9YlYRjETUDRwCsLw6Px7A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5223
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gJAG9jdShFt9RAU6NSAFWmREx4520388AA=
Content-Type: multipart/mixed; boundary="G8OdVROJYDGdWzW1sIb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603198894;
 bh=Lz8N2AbR49wgug0jPr+XCC3Fe/y1xQKugRdJY60zwuA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=FVzxugShKGR3UDsVQM8LjJs12ggoQHlIlMg7uqtaBBSsfW5D37LzRU9tXF5UG9VHVKa
 npNl84IR9Wd1VuchC8cg1l8l2n35PHjzZbQdcAT1wgr+SjDCocVEv3G3lXuyAO9WeQQDk
 nAAF7f0g5A0ALAcdiI711kvHEQ3FvxOMCAk=

--G8OdVROJYDGdWzW1sIb6
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: 20 October 2020 13:02
> To: cip-dev@lists.cip-project.org
> Cc: Pavel Machek <pavel@denx.de>; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@t=
oshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PA=
TCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3
> and RZ/G2x
>=20
> Hi!
>=20
> > > > This patch series adds support for PCIe EP on Renesas R-Car Gen3 an=
d
> > > > RZ/G2x platforms.
> > >
> > > I quickly went through a series and code seems reasonably nice.
> > >
> > > > * Since the changes are huge I am sending the patches as RFC.
> > >
> > > And yes, it is quite big, which might be a problem. OTOH only Renesas
> > > seems to have PCIe EP drivers enabled in their CIP defconfigs, so
> > > there's good chance noone else in CIP project is using this code.
> > >
> > > [If someone else _is_ using it or is considering using it, please
> > > speak up.]
> > >
> > We haven't received any response yet, is it OK if I send a non RFC
> > version or shall we wait for couple of days more ?
>=20
> I guess I'd like non-RFC version of patches 1-22 in a series. I
> believe it makes sense to add 30, 32, 49, 50 to them, as they are
> simple and fix a bug.
>=20
> Would that work for you?
>=20
Sure ill get on posting the above mentioned patches as non-RFC in a series.

How do we tackle with rest of the patches ?

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G8OdVROJYDGdWzW1sIb6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5596): https://lists.cip-project.org/g/cip-dev/message=
/5596
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--G8OdVROJYDGdWzW1sIb6--
