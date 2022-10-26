Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46167C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 09:10:02 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.114])
 by mx.groups.io with SMTP id smtpd.web10.5437.1666775399846490200
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 02:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QaPHiwAa;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.114, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWXzKUnUIb4LJX/P/A1jNALFbo2WgAP2qy27OobDn83kZ/sotK5E17kookNJS9ZhOb2afJVBhnmM+hKf0OLgAWNr8K9S0rZDS0Dui9SM6yIWIG3fjXkAJCOPRcJiF/z5R+IUpPk6yRKn3NQ33l4fk/oa0MDbBQ17NrfT7q2cpGwaeZiLbWcO1LGqkgVkX0aJYKephH69OwfxPBTHe060OeoUwVWh0QVLvOyrsInT30dw5vkl9taTOyr/lI604jKvdcxR/glkSi6yYWZuT9VkNBs9DCRIoI/hh9UlBzoWKhSWhbtLsGo7Ig7vedw1cvGAP3r44hGKxclY17K90sUvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/iT1HIMdt7ghtSKo668bXHyK4qSWOnHTwHr7bpDSJE=;
 b=Or1Uuu+ZQ9tFMUFZwtIzvfJ7fSFlJwO9r8Sjf1Jj/40iL5MX6dvCK7rozD/qfxqnNtMDXnfJ5QI63kaTs5/Vph64G4bc0vPkl8tuBZYA47vzYO6QO9CbuF2fli8MdXCFd4oPQ2Z85EV2NDPwI+rstfnwg00NogPGqD9vzOSwv3lqTz8PAqD7A7koJLX20nOq7YEU7bRd/f+a6K6P3PNi6M7ZrSv1iGmBHR81j/y8AKX8UqDhJpOck98EZtdT5LzrpNkRBS4tvAj7nUlEGBVaL8ZU4qtrqKZunXovqHgmbjs8JUI2jChKDrdXbe0LmuEUmjO5eyDpdNGeA+OYxag1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/iT1HIMdt7ghtSKo668bXHyK4qSWOnHTwHr7bpDSJE=;
 b=QaPHiwAaVdFkJPyudspJwZYnQfH+LvTRTEaZcO9NQ//AL/8IcF3kHyb4FGj6QO3QRXyPyZbQz4w9cT/Qlln5vQBLuDSR2tQpTx9QA/J8u42VsMnIJmSIGd9+FDULSSKXwiGnfrJl3xfeDCpm3BDadjcF8PSfUc5YV1cqDCVhQM8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5473.jpnprd01.prod.outlook.com (2603:1096:604:a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 09:09:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 09:09:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, "biju.das@bp.renesas.com"
	<biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Topic: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Index: AQHY6H/zzYKSpGl1vkq2qGSSr3+iDK4gYDyAgAADATA=
Date: Wed, 26 Oct 2022 09:09:55 +0000
Message-ID: 
 <OS0PR01MB592279F2C193D52F724D777D86309@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
 <20221025144131.1309463-13-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94206965A39B29C0CA0F5DBA92309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB94206965A39B29C0CA0F5DBA92309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5473:EE_
x-ms-office365-filtering-correlation-id: b48bc859-53e2-4d32-e038-08dab731d97b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Hr+AQIPWApp3qzGf2uOuJaFKP8kKUW2zkALx7jMOo4yXxbqqhrfJqZTNYr5hhSCiJ0iVPcOL9HnyDGGjWwNPpxRQRR2rIUi9EhGd+ie9PyAkOvw3FY1PxbB5hx6/9QLt552JQXd1NRlAUnfCGbrrzKw/aBEz02ZxEdKnP+yLZ7tvSIlNOXL5b612Ooh6mvsZXWepAFKgcdobtpb6spOOIJcOa6TNtkAn/E5Pq8SUrjoVQq2LvYhKpBW7dRJkLIPSolFgVnYMspXcXtpeIln3QSIVP1p7LAd3tnrX3hde6pT/mdnFzPgrP1kKhx1KKFl5SOmIiUJm6T1qbqMlB2rXqP9N72feDkW1Y5HJQOEP2J7iLPncMh+J15evGBcTGMMnKGfuFSWG2HhuZisB1Jh4o0zXlqbU3yGa2b3bQmNWRJbWwtZADL/yJsAgc6h5XecFQpnWbcWPCCR4nsFmnZPVJqHM1CPhDDwe8b4Pf9+c8ldb++l/pobinU6Hf2kRe8OVR2np57N60S/HxzOGqvf4vd9Qe9gBYGNkdXmND+QYRkyo3fR/YyqB3rA3EwPZp7j6Oq116JidET2kvxUjaDnL2edw/VFboLMhHCAXNApupWAKUMQ54yGIR47l1t0R4XEUJ6uizrDslAMtwmeQvJJ36Dxx6Bpu9UgVoZeBXEdyoKSS4NJOhs3QKkhSNJnMyWxS2R+kfZntKGy0m38ZVZ2oi2NTmIFlYvKLUg8MdPtjdthJAnCKpYq4oNdcir+pbCXbdh2w4LfhJQWSY0XiG10y/Wz/3SC82K2kkQGLI5VSjN4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(83380400001)(186003)(122000001)(2906002)(38100700002)(53546011)(5660300002)(52536014)(41300700001)(9686003)(7696005)(107886003)(6506007)(110136005)(38070700005)(33656002)(26005)(55016003)(66556008)(54906003)(66476007)(316002)(8936002)(66946007)(8676002)(71200400001)(478600001)(66446008)(4326008)(86362001)(64756008)(966005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Tys5eWJxMDBQbFJJZkE1a2Zycm9sTFJRaWkzN0VGVG54SkJWMHFSUG81?=
 =?iso-2022-jp?B?eS9kUE1sTVNiemhwVVF0QzB5VEQ2NDVxWkNYdGtudlNLakRSeVZBRUUv?=
 =?iso-2022-jp?B?UndYMkg3aGhob0kwaEhYZjhSOEVrV09xNlovVnJFUzBXV3VwNVF0OEMw?=
 =?iso-2022-jp?B?cXorajhwQ3hpUFNlYWZIbWhwM2ZRb3Q5Y2hYL292YmQ0a1NjNzlMbXEy?=
 =?iso-2022-jp?B?ZEdPWVRwZVFSY2pyY3hFTDI1RTNaYXIxVkM3N3p5TG5OMWI3TWFkVWt1?=
 =?iso-2022-jp?B?bkVPUkdhMVZKT3lpTnlpOXpXb3gzU29panBuLzZkd0R2QzdMMUVLRjR3?=
 =?iso-2022-jp?B?VlR4L3RNTEpWclpDdlhvR0tnYi9JdEcrY2h6Wk1nZnI4SkNWZEs1Z2ZF?=
 =?iso-2022-jp?B?cWR6ZGdFUm9obXcrcXF0d2hGNVNlMStDZTRCZ3U5QTV1R05DWVR4aEJX?=
 =?iso-2022-jp?B?L1AyR1UwSlBZNVNHVFNvdjU0QUllRUdINFphdDI3azRYNmEvTW9UR3c3?=
 =?iso-2022-jp?B?UkZJL2gyd3hUampuQkIzcGk1VDNwVGZnaTc5U0NQbDE5SXI0dUZnQ1E3?=
 =?iso-2022-jp?B?ZGVQZUVxaVdTODZuMUVqWHJFSE05bnNSRnBTeWRXa21weEdnZkg2TlZm?=
 =?iso-2022-jp?B?UDdvYkhYbUptenF2KzdCMzc0V3lkNHlmdUdTTS92OVNRU1h0YzFPUU9x?=
 =?iso-2022-jp?B?dUdRYzhDeVVhdWVhaUM5N3Z0blNpMklQeVNlTUNZQjlyUm55eVMxOE1F?=
 =?iso-2022-jp?B?dHkrQkpMUnRheGlhSnZzN0hIb3k2NWErNUdMOU0vQ0JDZVZudjd5S1Zm?=
 =?iso-2022-jp?B?ckdzWkVNSWJzQlZVVU9IcXl6ZzVwQUhxOWtKTUhDTncxeUljRExqaThs?=
 =?iso-2022-jp?B?UkxVM0RnTUVpdklDNUdMN0VOckJITHN1Y09XMFBWeEdYcVZ1dmVwWGpZ?=
 =?iso-2022-jp?B?aXNHMkN3clM5NGVJb3FOYmN6MDJzRndHNmFNbngxbU43QUtRemhPZzQy?=
 =?iso-2022-jp?B?MjdHTFo2dW5jVVBsMXlta1cyc1VnM3lHbnBBeVJGdXBQTnpzUUJmeHUy?=
 =?iso-2022-jp?B?OGpGR2NoTlE1UDZPRldWd0dmZlRQRUJyYThsc3FDL05qT3IrRm5ZbUJN?=
 =?iso-2022-jp?B?ZzBDczJWNHIvYjZDc2FiMGRieFpoLzhRRFBONnRNbStVZnZINEpZNlI5?=
 =?iso-2022-jp?B?RUF0ZndBQngvWUZTZ2Ura0hJbDRLcFBBTUk1NVJueHJUVWFHZFNlQUtt?=
 =?iso-2022-jp?B?aldjaklwb1AvRTNZQ0dMckwyOXk2dVhWQ3J6cVVWb2dXQm1BNktrQ3pS?=
 =?iso-2022-jp?B?ZUZrMU80aXk3VUx3RzRzVVBBWlk4WlcrNWM3SDJNSXNxUlFaL1VnMkJ1?=
 =?iso-2022-jp?B?bHNtR0xxUTBsZXY3T01KQUVFQnFmWFJPcjNKQkEwWHNzSEQzVitLbDFs?=
 =?iso-2022-jp?B?cndiWkxpZkIxRFJ4K1g5UTFvTXFOWmViZU5iRHk0OG5IVjJmOWxMS0Zz?=
 =?iso-2022-jp?B?UjdrZlkzNkV6T2l1S3lMMHlqVTRkYWlRakF0bW5MdVA1Rm1nY01CRU1p?=
 =?iso-2022-jp?B?ZExEWWh5MHg4SlBFZUtxNElVallqRHFXRW1kczFDR0d0VU90eXhLYVVV?=
 =?iso-2022-jp?B?QTlOMXJicjRZdTN0NExlY3NTMGNLOTlrdzlDVHBEUzVvYnhyeGd6OWRQ?=
 =?iso-2022-jp?B?T1VtN0VqcG51dlQ0ZnpGYitwODBtdzZUWUQzUWdFVjkzQis5OHJCTmhS?=
 =?iso-2022-jp?B?SW9wVWpydWVMSlpJYkNRdjFlbnlBVGpaZytuS0dXQi9NTnhzRlJyZ1FS?=
 =?iso-2022-jp?B?dEdVUVhHVWVZbWgyU004VDl3YUZMMTJsOTJRbEN0TFpJN3lOVlFGeGRL?=
 =?iso-2022-jp?B?TThOeVdNeTdUeFVvdGhHYkhWZlhMSHE3bmNib01xMTlPMFl0UDdYK2tn?=
 =?iso-2022-jp?B?UFYzREh1SWhHTFpUaWJ4dXdXMGNwaEltc0pRK2YwNVJuMXFBNlQ2Q2I0?=
 =?iso-2022-jp?B?K0R0R0xZUXpqMnFEVW04Wkw2NVdObnREazJHdkl5bWtjT0FDeXBFbFMr?=
 =?iso-2022-jp?B?ZmdsZ3EwbGpPenBsRlpHZHZQM1F3TWFIRy9KYitScVFZVW5uY3UzQTFm?=
 =?iso-2022-jp?B?blprdXU0SG9rOWFCVEtIbVY3cXJJWlhLOTg5bjFDWTZSUXg1SjF4Z3dM?=
 =?iso-2022-jp?B?ejR1SWZWSVF3alphdG1vQ1pmcUFjZTNLTDIxeFpEZjVkVDlFcnBLblV2?=
 =?iso-2022-jp?B?QXVCRlU2aG8rS0c5S1hadE9hL1BPNVJDeDN5eXR2UWU3VS93c1N6ejA0?=
 =?iso-2022-jp?B?VDlaNW91bnlDRjhTUTRRTnRCeXUwWTRpTnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48bc859-53e2-4d32-e038-08dab731d97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 09:09:55.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rTJcRCWYAnb9LCVzZFX7cT5QYXMtTpcJLokmUz8QyAuuaOh/vfIE0xp3DBkyweZiJq9IWhGB3iTWE9S+5F3pHKx87pvH5kWP4Pg6QnbZ1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5473
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 09:10:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9848

Hi Nobuhiro-San,

Thanks for the feedback.

> Subject: RE: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface
> support
>=20
> Hi Biju,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Tuesday, October 25, 2022 11:42 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface
> > support
> >
> > commit 1089877ada8d2da5f173922f1061ccfe721ebf56 upstream.
> >
> > EMAC IP found on RZ/G2L Gb ethernet supports MII interface.
> > This patch adds support for selecting MII interface mode.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > Link:
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/net/ethernet/renesas/ravb.h      | 8 ++++++++
> >  drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb.h
> > b/drivers/net/ethernet/renesas/ravb.h
> > index 0b5801f7e961..76ae3b5c568e 100644
> > --- a/drivers/net/ethernet/renesas/ravb.h
> > +++ b/drivers/net/ethernet/renesas/ravb.h
> > @@ -189,6 +189,7 @@ enum ravb_reg {
> >  	PSR	=3D 0x0528,
> >  	PIPR	=3D 0x052c,
> >  	CXR31	=3D 0x0530,	/* RZ/G2L only */
> > +	CXR35	=3D 0x0540,	/* RZ/G2L only */
> >  	MPR	=3D 0x0558,
> >  	PFTCR	=3D 0x055c,
> >  	PFRCR	=3D 0x0560,
> > @@ -965,6 +966,13 @@ enum CXR31_BIT {
> >  	CXR31_SEL_LINK1	=3D 0x00000008,
> >  };
> >
> > +enum CXR35_BIT {
> > +	CXR35_SEL_XMII		=3D 0x00000003,
> > +	CXR35_SEL_XMII_RGMII	=3D 0x00000000,
> > +	CXR35_SEL_XMII_MII	=3D 0x00000002,
> > +	CXR35_HALFCYC_CLKSW	=3D 0xffff0000,
> > +};
> > +
> >  enum CSR0_BIT {
> >  	CSR0_TPE	=3D 0x00000010,
> >  	CSR0_RPE	=3D 0x00000020,
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> > b/drivers/net/ethernet/renesas/ravb_main.c
> > index ea76fd98a767..bc259105a55b 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -537,7 +537,13 @@ static void ravb_emac_init_gbeth(struct
> > net_device
> > *ndev)
> >  	/* E-MAC interrupt enable register */
> >  	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
> >
> > -	ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
> > CXR31_SEL_LINK0);
> > +	if (priv->phy_interface =3D=3D PHY_INTERFACE_MODE_MII) {
> > +		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 |
> > CXR31_SEL_LINK1, 0);
> > +		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII,
> > CXR35);
>=20
> "(1000 << 16)" is a magic number, so I suggest defining it or writing
> a comment.

Renesas RAVB reviewer doesn't like macro, he wants plain number here.

See [1]

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022091406=
4730.1878211-1-biju.das.jz@bp.renesas.com/

Cheers,
Biju


