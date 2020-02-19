Return-Path: <marian-cristian.rotariu.rb@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A09C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 18:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE75D868CA
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 18:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48M3CTweiHfw for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 18:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410120.outbound.protection.outlook.com [40.107.141.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1CAB286866
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 18:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZEC3s6XBp2n+p1P88o8X6IKaYhTNQELrkQyC2Lbq7eWa1e2R/82iHSCB6lu+XgpG7atALnE3HUYLQdACIPAp3oGyfWQsvC/eUhaH/A+H4MH8PhaPpyWahqH3CLDZt+PHH0PWRjsclPeeIyoADtv9CziuJ7RCYkWshu+qf20Lq/Hs4I2p4IYssghRqvaH/0/r3sL/cWO5F94bPWSbG1pHIehDy46OB5PFuqxzqqL8UuMp2iaf8IonwZUwWT2vSplK4Mpq/kB2qxHcs3ojUbMxMM5hQHrkWosD2yfQ2v7Wbg9u8iwwkupApb4D0Dzy2UsVVTVaL6D95ikb6nBG2T1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni+skdiSvJtez9/uWV+lVsARcE7z21j2yKdV7qEV7Vo=;
 b=ZRns4gNzmbCBazPNNW1ucCsmOy9ES89v7gXhF7bg+/kLkWk4EyL4oCzxdgnXt0unVnrBpjl4xtKIC4vUQMJqPUxILKT1c1fRbDb7msGZSQ7ahLVb6E3ewrBetjbklHz7id/HJzloLNoDMldE6nY35KYumEAZI6Qxwi7up6I/MRvFyVdp83LQhxRsTbzs9DDiSsueIbfFM9zfidj67mUYkJul1CW3mDiFXLhqJucnZaUHk9oOuscMsQITKar0rrjhxi8TNY9MdLsCaiMs7bp9OYpGxprptEk8ZtOo10cFs7dpJAoxEiBw2q/IRpqivv1UFx4CCz/Y2vxq501iYtua3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni+skdiSvJtez9/uWV+lVsARcE7z21j2yKdV7qEV7Vo=;
 b=YRQK8OXuwt2UPavXRwmOlYXRxd/fj8ocuvy3wqhGWKBsO+zsOe7Z9TvXU01KC4Pjbno25Z23KVUoftuDb/AQDOZJO+Wcx/vVEDD+M2srZlbghO57+CUUgfCRjK/TwuLk/DaEqHBrKNDehe4BHWsZ4ed8vC+u6pOz3MIgYqlS1MY=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB1715.jpnprd01.prod.outlook.com (52.134.231.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 18:43:55 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 18:43:54 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C
 Backport
Thread-Index: AQHV5vgUFJ1eGbW+QEK1kD+F3MeRIKgisZyw
Date: Wed, 19 Feb 2020 18:43:54 +0000
Message-ID: <OSAPR01MB50283C072294D5EC66955D12AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219074158.GA29804@amd>
In-Reply-To: <20200219074158.GA29804@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99d9cf9f-3d99-4d23-75d9-08d7b56bac0b
x-ms-traffictypediagnostic: OSAPR01MB1715:
x-microsoft-antispam-prvs: <OSAPR01MB17156727DB8FECA0BEDD9E0CAE100@OSAPR01MB1715.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(199004)(189003)(64756008)(66476007)(66946007)(66446008)(66556008)(316002)(9686003)(6916009)(55016002)(4326008)(966005)(76116006)(478600001)(52536014)(81166006)(81156014)(7696005)(8676002)(5660300002)(2906002)(86362001)(26005)(53546011)(8936002)(33656002)(186003)(6506007)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB1715;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dg2A57HEf6fK1PDiYdwu8J16XuGT+iWcamsw9LyD3+5TsHppW6/g96nw4celpJD1x3yEcTbI3pYf3ckxxeHzvgw4dMwbLij2afuzxNeOKx7NQpGO25T9p2scPtENetpWVrN96X6Kq59aUwTooa0VMjrYNHuJriDbcMwMVTFOYiiTNH6VgI8nl2Nmtd6rlR4+lOd5lakNwPfZimQFJZwoCHnw2El8g20uSMEWYEwqUJFZ/cGLqLcpygbuup2GEL9ezn5UqPVdYKcapfruSSFHPBzEPGx60tm6T8biW6CRqm+MuKBNB/ZiKexO6jZhEbCOhNBb80qc7WA0W8uEUWHf5kzd1/at+zQ9VE7UgkYInCa9gt5n4ZJtTnlaotf3yDpA8BJ6QDLJ9OjniLwocFdvgVGz9zWypfv7AueNjuFLV0+gwUAS+myxVbqTulp078LMgeFwQkbLr3rXDVagUuK8mz1YnRBbntHg+OTy4H/MZ9zvHG80Dg7fllFkYkXa4+ByF64xq7SlDG5GM/Ry23rWPg==
x-ms-exchange-antispam-messagedata: kQCFUyPFJ9jvpIK5J9pQNBtkG8+wVv7pZZFyRWftmL6ThDu0r1zGVrtuiSDrb6fNfpWnSNKZrQQdrMpkUy4KXyKs7yAWaVrOYn39LArcEWMk1UH9JTi4s/F8XDck5EnV+xqoW4k31Zl1eqY4PIX3vg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d9cf9f-3d99-4d23-75d9-08d7b56bac0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 18:43:54.7385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xG3FhSZzFj5vx/2XDofaNbvYAaftLVGynnPNqTL61ARuaQ7LJfRb00dLa6R09oWR4QVWoSg+LlHytcVXZVpR8rwuyNajEyGJFAZxODu5Aug7w0IuyghSGTTEigM4NhYlVONfljz9gf3edTmfXPJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1715
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C Backport
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 18:44:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel!

First of all, thank you for the review.=20

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 19 February 2020 07:42
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C
> Backport
>=20
> Hi!
>=20
> > This patchset revolves around the following patch set from upstream:
> > https://patchwork.kernel.org/cover/10969899/
> >
> > Unfortunately, the driver is using a slightly different version of the
> > USB API. In upstream, the connection between the fwnode of the USB
> > controller device tree node, that is the connector device tree node,
> > and the USB peripheral device tree node is nicely done via some new
> > function calls that are basically some extensions to the graph
> > traverse and graph discovery methods for the device tree parser. This i=
s
> needed for role switch feature.
> >
> > I tried to create the minimum set for the USB API extension and it
> > should not affect at all the current behavior. All the modifications
> > are additions and some rewritings of some of the current functions.
> >
> > I also backported some fixes where I have found them.
> >
> > Tested on Si-Linux EK874 (with RZ/G2E SoC) that we have in house.
>=20
> Ok, so this does not look bad, but it affects other people's boards, too.=
 I went
> through it and will have some questions/comments.
>=20
> Is someone else in -cip project using usb-otg? Are we reasonably sure thi=
s
> won't cause problems elsewhere?

There are not many USB Type-C connectors, not even in upstream. For the com=
mon
area of the code (drivers/usb/roles/class.c) I see only two drivers that ca=
ll
usb_role_switch_register(), Renesas's and x86 Intel xHCI driver.

Does linux-cip support x86 platforms?

I am actively trying to find what could go wrong with this implementation. =
Also, there
might be another way of doing this by attaching the graph connection to the=
 port
controller device tree node and create a device connection between the two =
devices
(the role switch device and the port controller device). This might get rid=
 of all the extra
additional patches in the general area of the code (no reference to fwnode)=
, but might
introduce modifications into the port controller driver and into the role s=
witch driver of
Renesas.

I will attempt to answer to all your comments, maybe this will look better =
in a v2 patchset.

Best regards,
Marian

 =20


