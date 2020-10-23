Return-Path: <SRS0=KrxC=D6=lists.cip-project.org=bounce+64572+5669+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FAC388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:58:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7F320882
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DFQkqX37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7F320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5669+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EigMYY4521723xYj60o88o2g; Fri, 23 Oct 2020 12:58:39 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.129])
 by mx.groups.io with SMTP id smtpd.web11.2124.1603483118456404616
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 12:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtL74oeb0OqwMKrSakaQJeUBMYpkOnCEh3P30Pt+v0LqB/yvwMiAQsV0UGUWSvzak9qIRurCqGfXOn9KmorjELWec5SYUuCOkrB6LYXPzUUCGbuNXY4b+6CO8W2gK7xkPi7bzauW67xac9WgAs0P1T2m9fjvPWUL0P4EkFUXd0jJr1+2sbh0LSu+u8AnOmZqmob4m4QuI1XLrCQcIdFZa6AAv10WpuNMeeZGdkVW035dnuKeQFWdw1jU4ImNvkgf6cR+5kfDdUe0c2qM9tCbVBIay1n5u85sD9mtJdcBfeA1gvNYtGltSfRXC/TUhDutsRS2JcW7uJRwVtfCjsnAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsJG1xZjSnDBBjslzm3wPV9zUV9vZG70Q/uBv9uJ9Bc=;
 b=XR9Bu4C8j5zocRw+iM3hgfzGmzRJcZSBCGS006B45JMkL3Y26LqaaCBU8cGk+CdZSNOnwwmX+fkZ/konkCj1D63I5g0p2NC3sT/N/8Them0HcSdGjpQDNDVvLgoY8hw0VVvjzz1y56RfwYX96TTC8CU5bxFPUtoBesL50LZOlGbRMalV0HbzZrIs69BshmiEyZf+x26g32pU1ns48dfA4wCyZ0gWf4XH1kzTXw9s45iWM4/Jx5LC6UqFAtQ35LTF/tGdObURMjvozd5aGY+aB5xq3bqUKJZ0D9hyX8Df53eQxwX5prtKLHok9wp/+fpe1ooeSU49ryToti+2Ze5cnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB3864.jpnprd01.prod.outlook.com (2603:1096:604:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 19:58:35 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 19:58:29 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] PCI: rcar: Move shareable code to a common file
Thread-Topic: [PATCH 4.19.y-cip 1/6] PCI: rcar: Move shareable code to a
 common file
Thread-Index: AQHWqXRndcu3UUbobEqfpineXOeQYqmll+lQ
Date: Fri, 23 Oct 2020 19:58:29 +0000
Message-ID: 
 <OSBPR01MB5048EA292D626F32EB60B393AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023194039.GB6002@duo.ucw.cz>
In-Reply-To: <20201023194039.GB6002@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 689f6e3f-ffa5-442d-27a5-08d8778e030d
x-ms-traffictypediagnostic: OSBPR01MB3864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3864650E2A799BF914156183AA1A0@OSBPR01MB3864.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 CTgwg3DQcD8uMjrLNFyxW5Sz7ftKImd7sEJkUPYgsQNTV0RlyutmPoqapI0kkaCVnFA2pF6fRSCsGJbWkdCIFlPp8IfR/115TM0JLNuHEc/YjvCHsmGjLaq/2n5/wENQ7x7y+FDj7SnCe2tEXVBcQ3KD76c5oQqP4LmqllLYGXMJG4dSi4DOc0wBZNmE+R580MX+enO7ZtH4BTZHjxUZXdkAGgLxN3O5HqqCFsDIiUaP6bWDVS9b78k/WvH3SAUw2StLFuOVDUrGfYUQ0m21nklkmq7i1z2wq1eF+q5p6/XXEA8CLR0aHvfwb0m2RVzasQ+R5akjzDZeRiH9qU93/Q==
x-ms-exchange-antispam-messagedata: 
 JTWQsjazfPRzEmtL1Q1BgHlE6KkQUB2b2FgFBuwCZbuDW8Vye3wf7YdjHZRSwgjdixrmV40ayYqeMYd8Al15bpbgchZGDDgDhoNQM036e3Qylj6+81QIe90d06Ac1G4ZLd3PmhbwP4ZO0FvDutYdhWRy/xWX3pGL5fIQas4J62BoqdRIvSL/cpLXfRpoRz4hyG0I74X72s6J6JQaJe+D8DKlf3CP8qXOeSGh4aqIZ5gI48OIqj6icY23+lWDYLyXyHWIodGHxuUwEg02D9UMOFKGuAAAkvIXzckfJrRoopy9oMCRJhjyzMa8Qd+i0QBY0jpRnspbApIKkyi0gTYJNNHuWjNHQ35DPabyQYYW3/mbAeep7B7E6LJ1U9TIY3ZY+SI5AQ4R9m44Iat0pTBfmpJeyFzf4IrQkarHmFLArZ+QlDiA0vEBvMPEE6s5pecS/jgBgHgvAbt04+yuaK64VYGzkc9+tCmYSG9KKhLnP8dLvjQSEO/DMO8G95cgawUf6PWstff8VWBP7k+JJYwXC0crZbesJNMPxb4Ain1AXj8ag6+bBKtpGiSpGtcVVHQ0BS/jBOGk1scP5fhthIpE36CeNEGFhM8MsIJ16+Z3+xEtd52fXsipYlk/jeZc91lOyC4RvXhOanlANlNBVWMC5w==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689f6e3f-ffa5-442d-27a5-08d8778e030d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 19:58:29.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoDfEK2Z0UxriORtFwS/0he0rfEMdRpID2ZgS+P94GxNFGSGDiy+VV5+NVOAtgad8+vuAoFc8hxumfGyHpbAzG38IJSisuILFBjKDEpz0Zl8hMvEgoZczv932ye0/daz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3864
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1BVrZdL0jTnzZccshdLJsEucx4520388AA=
Content-Type: multipart/mixed; boundary="wZkaz8QTsBFIBIolddGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603483119;
 bh=DK6XMO3EyNPGRqW/hNKfyD4DFi7m2y/+l7q4CMP5kmc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DFQkqX37TLDkw+m2X5PLMj2hSgEr7LWguGrPPkHK7soNS1BVdZ8zyumufNBKNtnWLls
 twwq0zLixS8gm0hE0f+Ag6U99CkNlbrWJtOjeXog0ikptTK7BUztoNaMnnOr0rE5mf15T
 2CI8vh7wtxUQEDJTdqQ8haYGVosomyl0Anc=

--wZkaz8QTsBFIBIolddGS
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 October 2020 20:41
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 1/6] PCI: rcar: Move shareable code to a c=
ommon file
>=20
> Hi!
>=20
> > Move shareable code to common file pcie-rcar.c and the #defines to
> > pcie-rcar.h so that the common code can be reused with endpoint driver.
> > There are no functional changes with this patch for the host controller
> > driver.
>=20
> I have merged the patches, but this should be cleaned up IMO...
>=20
> > +int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
> > +{
> > +	unsigned int timeout =3D 10;
> > +
> > +	while (timeout--) {
> > +		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
> > +			return 0;
> > +
> > +		msleep(5);
> > +	}
> > +
> > +	return -ETIMEDOUT;
>=20
> Kind of fun. We test the PHYRDY, not ready, so we wait (now phy
> becomes ready).. and we time out.
>=20
> What about
>=20
> while (1) {
> 	if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
> 		return 0;
> 	timeout--;
>  	if (!timeout)
> 		return -ETIMEDOUT;
> 	msleep(5);
> }
>=20
> ?
>=20
Agreed, Ill get this upstream first and then backport.

> > +int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> > +{
> > +	unsigned int timeout =3D 10000;
> > +
> > +	while (timeout--) {
> > +		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
> > +			return 0;
> > +
> > +		udelay(5);
> > +		cpu_relax();
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
>=20
> This has same problem. Plus, I don't believe cpu_relax() is good idea
> there. Relaxing CPU every 5usec will not change anything.
>=20
Agreed (as above).  wrt cpu_relax() I believe this was added to improve the=
 performance of other HW threads.

Cheers,
Prabhakar
=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wZkaz8QTsBFIBIolddGS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5669): https://lists.cip-project.org/g/cip-dev/message=
/5669
Mute This Topic: https://lists.cip-project.org/mt/77756293/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wZkaz8QTsBFIBIolddGS--
