Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112BCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 20:56:44 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6235.1762289797129069461
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 12:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IPM12HdQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytbS4GJNYY/G+pMMe6fPocImuP6mCUV57eOKoRpt1ZAK0DEFlsbZOCS1s4ula/wN/ZU2I6DdHUEs+UvCLP++41Iqw6AV/LLFmoCLNX7VXAiPtBjBk3bYGHFDRTaSCwQaqRg+HG87vq4fj6msZdNDQjrra5MrL98B5a7t1sKP69Hgq6l5QPW3wkQAnCLi+vha/7Gzb+aqOAY+qyImSwY9fbxPZ1febV91JbAdoXy/vsicqcj2BzNm0g2cHKZ5tiLv9AL18QhbYTGRumZFUTBnttf5nfI9S9HC3hkB9ba8H5ALkWi0SUUznvlgoRFmccWhArbb12hh2l0kMRLAGVGefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEyfFSyJI6gW74fhSW7BShdPJRbWLCl/qDPcPlHOOSc=;
 b=LhN0+fZUWfRj3idX8UUn2EUnw77ry1zwdMF4qRBZh6QbatKyCaWa38+T/tmlah/GcEyXtGcpXYCBM/2Dzveg6fCsx9cFTCGMiQ4jn+r0/EejKqwzMyog3psTUEmEQHS1JQsXGKDykahoY+dk3ufviOLOjkS3LtWHEoLhoHIMSa8/8uSZETX3vqjSrtz9PVjmUMmOemPFLSN8nG/RnY2Nu5NgPR9ROmH7RUDUWf0qdaC3dEQUydqB9Jl6B6SkoNMrXhKVYAtCooyRdR3UnChymIn/Lic1+zF5fmBXFjXsVBglKqwfH3oGn9YX0jldHoSipMTj7T8hnezhr1BEi5uAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEyfFSyJI6gW74fhSW7BShdPJRbWLCl/qDPcPlHOOSc=;
 b=IPM12HdQzUVOUWES9VHdB2f1KJPtzjoYcz2hzSy/KEyxpBrHtC0qmAKXbUCLOE2xgLsiW5Zj9dybLBHuBxTwqA9SThL9Mu/NtsmMcoHBhiEZ3F+yia3Ty+bQzMZ3IsprZQDYAYBjMj/y+0yj4LMUBIULe2UE9UV2qROIGEvtvHQ=
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com (2603:1096:604:2b8::6)
 by TY3PR01MB11241.jpnprd01.prod.outlook.com (2603:1096:400:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Tue, 4 Nov
 2025 20:56:32 +0000
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c]) by OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c%7]) with mapi id 15.20.9298.007; Tue, 4 Nov 2025
 20:56:31 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 6.1.y-cip 12/25] pinctrl: renesas: rzg2l: Fix OEN resume
Thread-Topic: [PATCH 6.1.y-cip 12/25] pinctrl: renesas: rzg2l: Fix OEN resume
Thread-Index: AQHcTYpI/7XZ/bSsv02X3z4kGfKVC7Ti1CIw
Date: Tue, 4 Nov 2025 20:56:31 +0000
Message-ID: 
 <OS9PR01MB16368C765305362F5F4132759FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-13-john.madieu.xa@bp.renesas.com>
 <aQn3uxHX0ebCjGta@duo.ucw.cz>
In-Reply-To: <aQn3uxHX0ebCjGta@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB16368:EE_|TY3PR01MB11241:EE_
x-ms-office365-filtering-correlation-id: 34a234f7-4cfc-4f9f-c6b9-08de1be4a1f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1ULdOLm+mwE9ifM8DBqRV2mkr/kphyrXQ6DCvUM+olg30SvYcT/WGat2DreX?=
 =?us-ascii?Q?YzlMWYu2ftse2dKaFzj31qbLegul78OXv1kCqIACd7/qaFaPzjI2BEwxsZg0?=
 =?us-ascii?Q?QKwUSsOTEZFNdiVWUSPODml/rGK+8roGNUh15xtGzsUUxTWFGOtOS7s8aMcD?=
 =?us-ascii?Q?cTBTcPesN3JjoZBFUE3LqxRvzCEzQF61fd/cI0OhjuQAbT9qm1enKy7VDU5D?=
 =?us-ascii?Q?wdmHSTxYGJNf9N2CdfM+iabqrEoi35WeQLQBK0ol9ZR5QqjPTv0mQH5CwtcR?=
 =?us-ascii?Q?nCdlkNkRidJqhM+hhR4XUppvHZXGVR9x3Nol8AmJVOTW6v0vDMOiZA+/oV/b?=
 =?us-ascii?Q?i/tkp4qowakosW9zVo5WwAikHM2qsy5UUtqIl/eQsqYXbfyKfk5I2ACEDzY8?=
 =?us-ascii?Q?uHp9E8mrgQS5ONmY6JpIqpWzg71dz7iihpVJJ4NNv9Nr4KTGMOPBaovsjuVz?=
 =?us-ascii?Q?6JNIK875SO2st8nsE8gPCY//JqCzLhiuUDwlFUrUA/uxKwEPksK3T92l3Da2?=
 =?us-ascii?Q?wqyjptxDhwcUe9jZ1mlSeanxxXp+i+dyzVLBnBkk2xQ9S8duREucq7QhOxYc?=
 =?us-ascii?Q?cuc7aqpqCORIVnPeTznTIFA+j0AfKEQ4pgIPVIzYeLdvAAg3SvEZsa7J81on?=
 =?us-ascii?Q?PzG1Tb1QjRZSFiMpuEjtWeTo+2qOfkyMoCCyBG6tfSJYNBFucqrG9484UJiL?=
 =?us-ascii?Q?/2PfveMzJ3SHHEka8FEg+0SQFicxAN3yShHn7SUkXAGv/x8HnCwf1j1IGNWa?=
 =?us-ascii?Q?elPZQzOSErVX2IAyqZCgCRrVDiTDtwi8yK4Hs+ajDfeipsXJbh5YlyTt/RWy?=
 =?us-ascii?Q?1cJo9MwPmXtbcxFw1xz17/kRNFSWHa3XYLIqwMxOzB3qt+KahJIR1UqLHP9U?=
 =?us-ascii?Q?ONMqWeVTckjfPsotvh8737y/t4yJQnn9pIiAUF4axAYEwwzqB2v/OjcE3Ujp?=
 =?us-ascii?Q?9Wz2ttHk/9d2Mkl9DPf6O8Qvhd3DTUUzOcrA2G7ABjdfag+iM2OKRx5WrOGV?=
 =?us-ascii?Q?vayAw9mqaZHiS+cGT2FiqOvCYzu/dKjcl725151jvbvgEXhfd9Vb0oXcM0aw?=
 =?us-ascii?Q?2Z/gR/Er4x3A1qH8waLDYfl3+33ob72mZZ3D8NNGkc98LYXFf4Py6lClSkad?=
 =?us-ascii?Q?2xIZT866bGQ1JpWp45dfLW5UsINv5YkdHbsKVZoLIqRw/1lU3zG5TFZ4i8xe?=
 =?us-ascii?Q?9zxe6mYmxFxMSQxH88EtB+HCakr8z9Fk97eTRdQI1kFGTi5WDLF25RVxuGx2?=
 =?us-ascii?Q?rM0Lc6tIiH8vw3mrvRJ/loAMhXFmcHAAoba/If6IHUivNO7CbVQ3sJCpCoz5?=
 =?us-ascii?Q?due11d/0E7mVEHtKQ9Ftz+HCPqo2FcmTBWZyJ9sdn4ESRih/7/RhFa90pbu1?=
 =?us-ascii?Q?d8FH43O+A3tQbqiKR/B1uvGR542N237J0TPwbLOihR6KRecUtHfmiNMgXXJY?=
 =?us-ascii?Q?trZx0ijdTheQmclLdf04iovbRLSiJh8i01z1EyGgo8kO40hchQdq9kx5UYAJ?=
 =?us-ascii?Q?ZOB9pWFY3zabg60RNrLdbZw0uK3jGVDkbXP7?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB16368.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?VDzZ+ebRKXT4QBgnx0wLPdSN5JvUmVQSTXyIIBczILpdJ4dg8+wGr3KUi3mx?=
 =?us-ascii?Q?z/DgWt4o84H4mdQx6Wqvg7FHAGzsSANQJyxPSRSjQUx00vhTGbK+kwzKZcE8?=
 =?us-ascii?Q?t40azzs/JLva39xme9KptglqmiXGruoPfZcrpbpS5FbmEF6WFU1HLQkRw1Ak?=
 =?us-ascii?Q?fpOKesz+aglpnMV0HJ8CDDLL3xdeaDyYjceDI9NuLGevTqSGx5meEZS9xX93?=
 =?us-ascii?Q?hwtliL81Vg3ybnlw5R6REvxDAaTqt4KB+/HXwGJ0hJeUBv0h5w02W2t22pMD?=
 =?us-ascii?Q?jc+jfETIc54AiK1jubTgmwPEjC8z85J30jz4aovTddzKER6CX6/lHg4WBd2p?=
 =?us-ascii?Q?ylZZqQGEds+3k4NLge8g4zkhXWMV5RBJw1sQE3vMONB5bRE/vW4qMm+6pjqV?=
 =?us-ascii?Q?jah/5CYY5Nh/Zn00IqKjRMSuKFoKRJHKd91WPjOFnz9PiAJ3sjPEIXhHJgig?=
 =?us-ascii?Q?xfCUUfZF7ss9FkeXaLiTZrH9C95CDKomwOr/Is4w4vQZUmGhg9lkHi6HJqOM?=
 =?us-ascii?Q?tHCP+rctFN4PGUQFu1p3C4fPv/q40vUtXvkRUdGxxKi+aytldvSaAcPsd0p1?=
 =?us-ascii?Q?nZhPFzIzjnqu0oSYqlndnk5ohcB0RifXZ7UmvZjxHq5/IqVtWXfZXjegnfzN?=
 =?us-ascii?Q?Wf9kyfh1brgxIZZTXx3PwS8opPlturgFkhxSjtIP9LALizOZ0tXEdWs7Kmj7?=
 =?us-ascii?Q?mGjOwyT2Q/5WVmyXUdu6dvlzwXQj0pfVUNfursZXHlvJRFPSLiaR77Dps620?=
 =?us-ascii?Q?AXIE00lYqxrYccUrD7lV/aPXuj9d6qbVQFpqjBFei8g9kDzQXXQNyczLdOol?=
 =?us-ascii?Q?vrLCG2k9WOPbHFij9RVkpHy7VT6s4sSSRFE/tKoGE/UiVTtHy4BNiw9pJNYx?=
 =?us-ascii?Q?vtcVRlcpc0096R44OXCNLH7A6Sqv5RVtR2uQD6dP2l2qP7C/rfC1ZPPLvxID?=
 =?us-ascii?Q?hJ0U8ficv0PRKnk3pVbkAKQXeNkWu5Bvn8BsafNMrkmsWcmiipMnNuaYsar8?=
 =?us-ascii?Q?7+o/VaLiJFOqZKfr4hev0C2Jpxss9S5IcUudkBS757dEy0d8O2zdjpVv2DkX?=
 =?us-ascii?Q?wgiMo0mOokvAseGrEH2nTV1zoYJxCz1vKsVuCctTX9h/C/FvM40W4eYncIrM?=
 =?us-ascii?Q?X2JvjC+Mcfvq/PB2PS4xnSbKAM7kLYlvtO5Ka5r3jHy2A5oCUIzbS1A7lOcP?=
 =?us-ascii?Q?66vNHJ6n3DPCTuanrnpLXADV5gRvsFZDDylQkJY/YVrfm9NCFBeZH+VEl+fB?=
 =?us-ascii?Q?1C+g5JxJrXepeMvy1PXiu9Tn2o1tQTH2ZRnLcZvds44YzOiyTXK++Nz6LyRJ?=
 =?us-ascii?Q?868WaH23MkbzLzvOG/INxUGjcLZu7b/yeoEQnPN8Co1V3lOV/MqoIPE4wz9j?=
 =?us-ascii?Q?F0vZ+Q5TIHte8JTG4y4tH8SQ0BYTVWOG8/m6Cn3/YSygsKanvNcjY7kZU8U9?=
 =?us-ascii?Q?X0qQpH2+wubokFgaHSWgmOkM4tyyBLDcmXcY2CktNJZ68WGF+huvVrK0N0ik?=
 =?us-ascii?Q?t8m9kpS7VKSI1W8Ytb2ckxJFoA3A/UhVeaTdAIoQqu6Bvdg/EbOPI8q5QBD7?=
 =?us-ascii?Q?Uwfn/7x7zmnXy4Bu1Zi6zmUVUW6J1rDdtpWbLVC1nWQvgEa2WX6CI5OCJWf2?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB16368.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a234f7-4cfc-4f9f-c6b9-08de1be4a1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 20:56:31.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FYYeMIpYZF2XJyPtyjlmfJp/4yZxIVLwF+p6bq30tS1fJhEt2CvLgVAa6o7LNfoev8b3M6SEhoKKZq9sG5Dm4x2f/J++AvJfAITmlVPLfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 20:56:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20356

Hi Pavel,

Thanks for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, November 4, 2025 1:55 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [PATCH 6.1.y-cip 12/25] pinctrl: renesas: rzg2l: Fix OEN
> resume
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstream commit 30247fc3254a4502465ab809d49e2167ace5a6f2 ]
> >
> > Writing to the PFC_OEN register is controlled by the write protect
> > register (PWPR).  Currently the OEN register write in resume() is done
> > without enabling write access in PWPR leading to incorrect operation.
>=20
> > @@ -3150,7 +3152,16 @@ static int rzg2l_pinctrl_resume_noirq(struct
> device *dev)
> >  	}
> >
> >  	writeb(cache->qspi, pctrl->base + QSPI);
> > +	if (pctrl->data->hwcfg->oen_pwpr_lock) {
> > +		spin_lock_irqsave(&pctrl->lock, flags);
> > +		pwpr =3D readb(pctrl->base + regs->pwpr);
> > +		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
> > +	}
> >  	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
> > +	if (pctrl->data->hwcfg->oen_pwpr_lock) {
> > +		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
> > +		spin_unlock_irqrestore(&pctrl->lock, flags);
> > +	}
> >  	for (u8 i =3D 0; i < 2; i++) {
> >  		if (regs->sd_ch)
> >  			writeb(cache->sd_ch[i], pctrl->base +
> >  	SD_CH(regs->sd_ch, i));
>=20
> This is "interesting" piece of code (just take the spinlock always?),
> plus we already have similar code in rzg2l_write_oen, could it be
> shared?
>=20

I agree with you. If relevant I can send refactoring to mainline and backpo=
rt
once accepted.


> Best regards,

Regards,
John.

> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

