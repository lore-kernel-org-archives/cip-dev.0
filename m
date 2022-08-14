Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B8C25B06
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 21:37:37 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.102])
 by mx.groups.io with SMTP id smtpd.web10.9714.1660513054279516866
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 14:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cCc6v2th;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.102,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFWddXXPTXcBTWOGcg0m6JMD2v89X6mFuLAEvS7CvTvsz+rR6ro8zbQJBBExnfxmyE6pTB5wNhzCxmRfFmXMVPp88+oACibSnIkw+iTfybJ9loAljpCb5Q5A2KnpCWJWd71HI6uExsiiFGQeLgSBV9eyODUvmtwrdWCArCSQtv6c5xes/WjvcKibdkniBf8P6jZZvkseWuNuHHOqmFf3M87IFIEOOPc37k0VWY+bslep4jze+hTMtTKjogWJt2zNC5VZDBdgMdqBX7hEnTiu3iceH0SjWHJ/mtMVa1DD4yf7qX6JIy7CesL3iDt7licp9zIr93WuU68pPoKDBiujGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n/JhHUqQlAFngdB/+gK4mq/gvnUrPXBsXSrlUX8gNk=;
 b=YXFcYjkhwyaD47HI8MkMNNYWreOG10ObR6HAlVQ1nQkyG2KTYhWuCp28jPrz/4o2cwXdApWB5rCA2FIhVlrFqvP4kRQEtGojoL5QAM5eLklRoejno7WeIGXhUGH/WPrxCy03qxLXpxBzpPXs1T6pkipxCGoMw2lh7kfvzGdoUqgu/esm3hlwiCs/Hy3j8TJLAyE9Ii3un9quDVynFvgljv3PYqw03raW7ZkzqirkoOL6chMXvIOYigWNP98mXQTa9yv94z2DYO+dI0OtLPDBdypKE6N7s87IjjAum+lc5Yart+zbmKksmYJclkVlteOeOqFX+8wBnew2qaP+XZBlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n/JhHUqQlAFngdB/+gK4mq/gvnUrPXBsXSrlUX8gNk=;
 b=cCc6v2thpyaI4dN0ko6ugp6HnElI6H4Bsvgky1t+OcXN6NRE++cpqmgM5JLAudNZnGfbBbD45Ld9yc1hg2vuJDYOVqw99xIGQkJM7NxMgAqm0WeCQ4n1DxjXuXDqVZxP9MdTu/oLg8aBq63aG4yy+0nEobGQQfL0F+LnGtJ/Xmo=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY2PR01MB1980.jpnprd01.prod.outlook.com (2603:1096:404:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sun, 14 Aug
 2022 21:37:29 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::bcc0:2df9:c146:8c18]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::bcc0:2df9:c146:8c18%5]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 21:37:28 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 01/27] dt-bindings: pincfg-node: Add
 "output-impedance-ohms" property
Thread-Topic: [PATCH 5.10.y-cip 01/27] dt-bindings: pincfg-node: Add
 "output-impedance-ohms" property
Thread-Index: AQHYrxrz3jADPNKLBUKwNjzkazhzkK2u7MWg
Date: Sun, 14 Aug 2022 21:37:28 +0000
Message-ID: 
 <OSZPR01MB701980BDA00330E249F7C013AA699@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220813134522.GE24517@duo.ucw.cz>
In-Reply-To: <20220813134522.GE24517@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dec3466e-3307-413a-44fa-08da7e3d2fe8
x-ms-traffictypediagnostic: TY2PR01MB1980:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EDwFUVOcrcHtW6toNtkBmN1pcpF2cX/fOc7YktvI7ozFBIhRb+tE3u5yyzFk9JljtAPqZCnaT9ESIZ6lz4KQtW5oL3hL2/lfFk83FMHTWCOTF+C3dvsF3TX2sCoUEzUr50LkZKTAVLusm6XXTcW5FE5PIJ1USKLkQ7/kmbT+gLhuLEL6IYjtuRTbn/8/nId5CQqK7nv37hxAc9yr8twU2WThfe2obdwBwU9gk/lgQX2WNIDVBikCzeUIBKVKu6WdjjtMBwSlOuLtKvHrpt+rha1DczATYPHRoqaQYkYkCSgnhss/3/ljsF6ZgJ8q1OU5I39IlsLe6NYOrs0RBlRbRAa+S4rvD+lGCVfd/QT1fT+20/e6rC/xrHNRzuLy/mR+Or54KJvlNfSk7mW9gJLokgUYSpVpgeZitkstfSumQmR+0csT8THa0QIWdho8EvDrzi2vSTm0inwzyB6lBpRLSOBVkKCGrZaaLQe08lJGBhfxj2rU+rgk55Np+AlPAG0EVxj3/Y8IoIwN2YZDV6GwzE+Nl0yH3T2oWDrOCK3H43APELEcTnKB69v6AK1MKFQzNolbaGxrYXEojZhHRAwNBm8i/F3a97RtMxSh9tWOVLo6VdCDIgOsf/bJfy2J/VGD39DYvc3Oxt5ZOOrT74/KsDsmKkhmCvbspFsqMBOuI47rtLeA2K3x96rwhNgWdQFZMpCjEt67YDpRDpv/9qCg5BHnVWNpbOGqYhkX/te6ODmX/iLD0JlAsESAl8faHtlpKBSvyHhUd27YsPydU/j0exYEkL2ztLjAVXqJYynHGg+Rh8p0U0DlNXbk8HiAw2zS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(4326008)(38100700002)(122000001)(38070700005)(5660300002)(76116006)(66946007)(64756008)(66556008)(66446008)(8676002)(66476007)(107886003)(186003)(53546011)(71200400001)(478600001)(26005)(41300700001)(6506007)(7696005)(54906003)(6916009)(9686003)(83380400001)(8936002)(86362001)(33656002)(2906002)(55016003)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?VsIqObgA6Yn1JTpwOU3y4BLru/NBtwH4TCqEotikgZ1hVTYOCQDlSkpk61c9?=
 =?us-ascii?Q?FsoXhvcUUcciESre75btG5pKHvsW09gW8mIAa6hxSGVyBArT1Y2yH1ezYi0g?=
 =?us-ascii?Q?Bbp3f7Qh0r7IgxVmkzmFPHHBI3I/Mwi2g3/zd24M26L0Ld2DPc7N7lXVBcRv?=
 =?us-ascii?Q?hipFnZRXPVqeY5i+OkiQGhdRrLbhm97FSeHFZZBN2LkYZLZG9q5NKUD5bN/V?=
 =?us-ascii?Q?QnDGxhxbU1Okrb6XqCfm6VVN6T28ehLIT7lvGwcHnDQD6LIx7BqiaT6xjacO?=
 =?us-ascii?Q?ol5CITClEpRqtO1VhNS2G48Je+U4f7osn13SDqeILHjoEt0cWCQeo+V5+Cfv?=
 =?us-ascii?Q?voxCordXrvfdLFf+ovdVL197d7XOlt9GFAI7nGMPNC9ZtB4KfTKZf2ZWgzq4?=
 =?us-ascii?Q?Y1BS0gwq2SI8uSulc6ZRhXaRji+3OkzK9ERwhhBDQr6allNdbg4Nlgmf24HC?=
 =?us-ascii?Q?SbZfP/GIlC+97MExQ1u03GAkRFpjgELCQn7RT9b0ie4/8BvBV1cwVGK1QjmI?=
 =?us-ascii?Q?83QIarruke43kVvKGzamWyNbriZsYMEaP3wLohWWmVPgXw2Uk7Vn5z3Lh0l9?=
 =?us-ascii?Q?pyNxgr2C+Vpm5xYNcTQa1lx+9D/YIlEx5zvP0sUTxmBclAP/7HdSYwa6s8Qb?=
 =?us-ascii?Q?USwj8+7/SpoD85tk0ixqTv8zgDZLZiJ8k/ovu10tdCdcMmrEyScuEqvvl38V?=
 =?us-ascii?Q?LiK0NxkzRNtJke+uDpEzGXOAjAWKFKclGkhIlHpggDsWuyEM/ybwy5O8wGsu?=
 =?us-ascii?Q?uaQlNYEZTHUyqwqeUS6Tb+c4slKsGXG4RM8FUZpxEXf+DAhbAjbnwebn6+XV?=
 =?us-ascii?Q?4x5LaEx1MPsWnIcW5F/XY+YIehN3t6p+nkKtDAEuRm5SVqBjNJOADayKEoQn?=
 =?us-ascii?Q?o0VHvEP9rj4UAlJENsj3BHdFzIr/SUXVz66devNgh+cmxajmCB0nvfPVHzS0?=
 =?us-ascii?Q?CgbPsvp7RwAnc2JH7q3ZPoCfELZNO+vVcX66CuusHtghCbf3V2W/NsEjGlZl?=
 =?us-ascii?Q?DUhPwkTyuvSxsDBU0yH0tnW5oIbuJD8b7QBHfcfKv5tQ6jEd1aYyCEZqgBLL?=
 =?us-ascii?Q?njO+d2HCYpHY+hxN3Dk9Jee0Ps1tb5AEGjR6ue3xwVqxgMo6SVkY32VWf7ns?=
 =?us-ascii?Q?RzqLc/WNBO4qGlbS8VIO6TppLX2hTBHhBiwR3VYJ3mJcCAd4UEZ6RZAiag2t?=
 =?us-ascii?Q?aQZvUWlhPtdRYp5TRR7GVIGN+5PuM372dGotsHfJJfAEGwSXPVZkAQJMEXnz?=
 =?us-ascii?Q?IXgtMOPQo794wrz1nAAMkBpMXYEFAGVGUTdz3Ph0x9pngeWiTHuyEphfIssd?=
 =?us-ascii?Q?V5Msl9EzNUaqfNWV7GMLUIdWF04D1wL6YF7ILaEQiv1Nwb504f2b92DPACwC?=
 =?us-ascii?Q?y19cNsFJuU0GpDPRdMOSOgFtF7PwGMGD+7xLptGKVLqE2d1fdlB0prlBdGwt?=
 =?us-ascii?Q?wejD4x1t5Vd+C9aLSs0us4J9yPn6AxLF6Wz86yEMif9UedXjL89vKtd2bDf3?=
 =?us-ascii?Q?y8zwsvjb6/NzQBB46guo7EMbQCI6Ix1miC9uEXd+GnQRK4+zY3+6melLAVvU?=
 =?us-ascii?Q?9rXWxwTlmDk404WHzAuYX3DvLjdWP7r7WBsn79kZdrdzKV3pvv5PvO+V3kFV?=
 =?us-ascii?Q?VgJJERyx6n9DdpSGWtyKgoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dec3466e-3307-413a-44fa-08da7e3d2fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 21:37:28.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 WFaZ0PVqAMOShZtgPSv4cK38Sz7M91DM9LuTSnwC2TyAiQVuRvmuyggLZ9ivWUIiQUiTXpUXYVtHr1mDN3zpYwucxWAWfm6XBcf/a624jsOnqNGJ9HiGizXgKhlNkl39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1980
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 21:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9211

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 13 August 2022 14:45
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 01/27] dt-bindings: pincfg-node: Add "outp=
ut-impedance-ohms" property
>=20
> Hi!
>=20
> > +++ b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
> > @@ -114,6 +114,9 @@ properties:
> >      description: enable output on a pin without actively driving it
> >        (such as enabling an output buffer)
> >
> > +  output-impedance-ohms:
> > +    description: set the output impedance of a pin to at most X ohms
> > +
>=20
> Is that right description ("at most")? Later in the bindings you support =
specific values, which IMO
> makes sense, without relying on the "at most" part.
>=20
I have followed the description text as used in pincfg-node.yaml file previ=
ously.

> If dts asks for 1000 ohms impedance and implementation sets it to 10 ohms=
, that will cause problems,
> no?
>=20
I think since pincfg-node.yaml file is generic, hence this description, lat=
er the dt binding file which will actually uses this property will have to =
specify what values are appropriate that needs to be set in dts/i.


Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

