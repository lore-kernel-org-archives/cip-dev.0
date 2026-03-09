Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4EBEF3718
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:29:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9429.1773044945901908387
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=SOgAwEjY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.68, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWFtiOhST0zm8vEiOQVBw0lY3dxIHNRoov27dGRMltNGvOkpAhHscu6eGJRu7aFDtO3GG0Rtp/dQcmGEExL7RCYqJ5nzhS8FA8KIAZHsHNyn3YUn3dGJyf7dxR5ho7eV4h5K6CEA19pOX3ZlWy0vY60Bv0Pi9MswxmER2jgJp8QkHGSW5NrTbgwF93YrS5015RlDfuus3pdgxfX+CzUkCzwT3CbCxnWG4YUxfBv8gh0VyUiPNRXX5MN7DL3F+XyhWLA5G0LivU50HQA7bjX6RYp1I5ShrnPExaGAWWq1/LDhk1JUxPpKyJ7Y2o5/WNWqnYGJQ8vD+Jr1DXiZg7GbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ygOyX/SIfwwNaUBmNUx6YiYlDY4yOL53/Waz2G52Fw=;
 b=lpio/SOixHB5KxGpk1IWFTgV7SBmMATHm3rQ4sLE7E2vNqYijJ6oZBwuJzES57qo9ATElZuVmA9gM5lG3PbIElxdLROBWW7toh4Hug712oMRsPRMXcSwQzpZc3oddXOGLd5TtBgHQbh2VSQrvCnalr6IyNebAnov08ADSr6t1ozQpumqWrRhl2t7LkxdozRQxv4w2Fh3xUuB/0bzzyJhrM6KsIRJlmZPcniw/zb54/B9oYNlOw2FJcBCsVCyknQWYoukHzMO/vYZYxiiUs4XmZ3vcFp6LM76haV5/rd8tdYH5ZVSctAlv3YSjPd8aS/FY6aC2uqM8QFCy84b6Q9Jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ygOyX/SIfwwNaUBmNUx6YiYlDY4yOL53/Waz2G52Fw=;
 b=SOgAwEjYlt49hg7pT2m7Jw/47+oh2UL9RxLKTIFuqW/GuHVFj+KWXvOhMpNI1zxw8U3Qu76CSLHs5TQlm0asfaWHyEFFGt8+GeA/0AKwoTHeK/MM/XmtIRu5ly7HOOzMI/+HtaeEw5uEoj07+BjM082U2jq6IoyAQDtcJsuSl98=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14038.jpnprd01.prod.outlook.com (2603:1096:405:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 08:29:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 08:29:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@nabladev.com" <pavel@nabladev.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 6/6] can: rcar_canfd: Add support for
 FD-Only mode
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 6/6] can: rcar_canfd: Add support
 for FD-Only mode
Thread-Index: AQHcr5mHshVaF+ruw0um9Db4y8iycbWl2t0AgAAAnIA=
Date: Mon, 9 Mar 2026 08:29:00 +0000
Message-ID: 
 <TY3PR01MB1134681F114FDB63D377944D98679A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
 <20260309075112.35445-7-biju.das.jz@bp.renesas.com>
 <aa6B3tuP6oufeYb6@duo.ucw.cz>
In-Reply-To: <aa6B3tuP6oufeYb6@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14038:EE_
x-ms-office365-filtering-correlation-id: b2eddcd0-ff2d-4ce7-e582-08de7db5ea60
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18082099003;
x-microsoft-antispam-message-info: 
 G8N0iE5Wayww74dUYwdDmmtKePmIjFBXGTImwtgFPzmUW2dOvA+lEcKuit/d6yQcJMfSmQ/qZ2OaEK0SpC+9p0UMBPj+htUBO1ZL3J8ePBwG51TlFvL/Iz3ZyHmzpFFSzy911eZ0KkoMnEnd3X6yx8/0mVtzaX6tLvDE+t6E/qKMu46UBpdBG2DBmwvtXCovQcVqjg8VpbUkwGWo63YbuKVJa1bmR3Vckb95E/0sL0Q1Kk9mUY0Uc3O3OqFG8zXc5ulAGj6w39zDERCaseF2m0bDsACKewnIE8zp7i2FhGM/KJfP5nWNz36uzUdlfezzdZ64kfvWIYJSudU895JdV3Wlwtq5+/nizcjvh4UtnwfbJIup2irQquL7dH2lbp9lXRbbgI3j+vRVpuCOVnZvj23fTyD3Xuhs55/UrnPhf/D5YW4MCp1UfJG4J8PtnVu2yfsrty4ajIW3rnWbAe5LvcoKl3Y4ooBKXYOzuTyF9yh/vTWNK4aW7IPebRd3UasFkeCyvZOMjkNC7H6UfhJBzwQBf0GFjDV+h5I4ILdw1avdH/iryD7Y4aXLfEbzOnqsfTtGmpf5PcVidcYj2XtM8NMwFIcgFzib/b5FuAlcJNjiX8FVib+Ia/i1SzP6GfNdQKftY4Gjp0wUTWgsQLccZsfHH6rVTp7b2FE2T2KyFzaI3zUur8L661p9h+PdZ0aJlnaSg1tjM2CRbMAGObnUC1tmSiN39IvvmS52zw3J0G13HxgLFqh2GCSm4UhUrB96
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?daMpuZ9G0w0Efx5GaNE72HrXGiiwYx11S11g94TTGiHSytc4UxKOr8iNkGp0?=
 =?us-ascii?Q?TmWqnDXkp80I8L17THl5UJPChz8XnS6o+6QIGwjpN6lLRUWp8VaFtiqaUV/w?=
 =?us-ascii?Q?PwrwYr1uCH+7hgx/pUPzDQUQnSRcq3LVQThagpFb6XqJPU/9eqgoSEActgWW?=
 =?us-ascii?Q?x60CMUpEmO4T+snsgvVTrE7N6cDU6WXShPwbZ4pHK8fw7wwQioGfiaszQgSG?=
 =?us-ascii?Q?+sn1M4qubtq4xuikMQg0TPymGpjTIO+xW/yY8nazGWKp0IkS4TOhrJkMklDL?=
 =?us-ascii?Q?2SrpFOKAxEj0dP8/Nk82kHtIMGAkMSAuJ6DLvri853SQVQbG8+BhkxJkvhuy?=
 =?us-ascii?Q?QyUYjqeDUy3uGt7lem1X5CidCyll6Y3NnZYQm8sN0cppLTCccNhFSEVRQYwI?=
 =?us-ascii?Q?Dg38ittGQzvRfXKdCOqFtBL70G4JYPw/2GZogynm5mqhSpvsl39ZuuR5WWnV?=
 =?us-ascii?Q?oKyOfkh7m1FMhzV3zElfhTC1VWDwexG56u9KlFynl1uYFMqPH9neKm3QUziL?=
 =?us-ascii?Q?2JXv73VlRRix+JMg+M7gdgWzpZx8RRFhTFCZC5CmewsoNW700IIE9vK0Njd3?=
 =?us-ascii?Q?jXhGS6iKiD1AEjuv9ft1MAvsStbPuR6Z/cNosHZEff5tyimJSX14KPItgSAc?=
 =?us-ascii?Q?qGZ6knWrs3FpV5PlWNdYGJmeYIxPk3fxg/KusMwuypPtwX91tGLgepKvK9k1?=
 =?us-ascii?Q?az/mI8N0YMNKSCNnUHKRJZgx+PONOho/RRm9GtH07Y8b3iYWfZfhg/7t2AfA?=
 =?us-ascii?Q?V/J1UAzGat+vhhgnSSJzQvwEebEwVoo9HQu8UWt48KXUyMMfxRAz3C+/cwMB?=
 =?us-ascii?Q?CgvmX/nDYwyxKTyXz3jpqgqIE2dhqsUUBxf3n8/WCJRySvfAmioibG/w4jzT?=
 =?us-ascii?Q?33Qz0cwCoFWbENQO0ptRMBGZSjF/HXa7HV9vRzwUEnVvMTMkXJoB0B7kxK/s?=
 =?us-ascii?Q?y6+7TFF9vCwzUb1wIcDdmSFM3fcQobPFJG+wcyTfI7hBFJUuCRvXezbpZmYw?=
 =?us-ascii?Q?GPlnTEkZvQSzIRb6AL0lLjD5LY1rDvETIFFuJI3ccwTcDCpzCwT1juYNN9Al?=
 =?us-ascii?Q?7rl/hdhPr3CFPyQicHdlwoT+yB6jfl4sNzFMtWrofnI+zcSaSwWWQWDLY/pk?=
 =?us-ascii?Q?2rRtnrW0cySE1L2uUjbdN8fsu35lv90cKTGhnnWzsRLlUqgJwBUCbFIL0j/W?=
 =?us-ascii?Q?J1R9+kCc3jH2WiW+/RVtHabq9yx8wtn1A+Ny5W4KDqzFQhaVSDJdn5D9ep//?=
 =?us-ascii?Q?GZYuHeTXevvYpD0ISqMg3NzCaLqNA9DESEDfsxCBJoxJA0Z3eXlvgLHDhF0Y?=
 =?us-ascii?Q?c49nYP0ub6bRC9FJnFNKjG8O4v3QQMmd6qmU0ClmPBZ5NRLKVQam+UbP8wuI?=
 =?us-ascii?Q?TzDUxkdZgeq8UC0OlWxbHyJYWVokNWx5G3hPqPNwgtyKxYi6VukCIiuTDPCk?=
 =?us-ascii?Q?Hx6dI41LzTNbzskTosvDAD0Zgydifo/ME1IzvQDHtCWc9+UK3jBuTH5/iDjI?=
 =?us-ascii?Q?WiSkCZD/DPEh0tzMATELpcGxOoNnwwvaCcGMl2ybfhl47o7pfGE7nQhOuiQ4?=
 =?us-ascii?Q?BayMALhSR1lm3DLS7MDxQujFESJocyKxZvJvGXQjxN/fc5xLqxtlfQGIfmN9?=
 =?us-ascii?Q?dOIKXbeQbXn3ivW0pFV5H3zQtgTxMo13tNLpgZaYKYlt2j5y1kviJf+nJzNc?=
 =?us-ascii?Q?nVagipQWNm7dyuvhiA+tvTtxOh9zoSem3CG8hMgMiZfJamByh/oVGeGuEyr/?=
 =?us-ascii?Q?DgBBCGNS3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eddcd0-ff2d-4ce7-e582-08de7db5ea60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 08:29:00.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B26Qzcddf+pZf8oPoEV/AZYGvZrqZ5c3NhafadPl2bU9zcLzicSh8d1MjT/4/ivGVre3dOxiQX49G4fb7hzjH5VC7eJc/8hpng4xcW+sz5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:29:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22165

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 09 March 2026 08:17
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 6/6] can: rcar_canfd: Add suppor=
t for FD-Only mode
>=20
> Hi!
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstream commit 9a2b56a48c219d189366dd9bf4c2b42afde2f361 ]
> >
> > The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode
> > called FD-only mode. In this mode, communication in Classical CAN
> > frame format is disabled.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://patch.msgid.link/20251126155911.320563-3-biju.das.jz@bp.renesa
> > s.com
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c
> > b/drivers/net/can/rcar/rcar_canfd.c
> > index 68e6c7ac6649..4bfc7b5ac0ae 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -829,12 +830,20 @@ static int rcar_canfd_reset_controller(struct rca=
r_canfd_global *gpriv)
> >  							 RCANFD_GEN4_FDCFG_FDOE);
> >  				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> >  						       RCANFD_GEN4_FDCFG_CLOE);
> > +			} else if (gpriv->fd_only_mode) {
> > +				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> > +							 RCANFD_GEN4_FDCFG_CLOE);
> > +				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> > +						       RCANFD_GEN4_FDCFG_FDOE);
> >  			} else {
> >  				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> >  							 RCANFD_GEN4_FDCFG_FDOE);
> >  				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> >  							 RCANFD_GEN4_FDCFG_CLOE);
> >  			}
> > +		} else if (gpriv->fd_only_mode) {
> > +			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> > +					       RCANFD_GEN4_FDCFG_FDOE);
> >  		}
> >  	}
> >
>=20
> For the record, this part is way too confusing. Long term, it really need=
s to go to separate
> functions... and be refactored.

OK, you mean split [1] into 3 functions?? please let me know

1) rcar_canfd_set_classical_can_mode()
2) rcar_canfd_set_canfd_mode()
3) rcar_canfd_set_canfd_only_mode()

[1]
			  if (gpriv->info->ch_interface_mode) {                           =20
 828                         /* Do not set CLOE and FDOE simultaneously */ =
          =20
 829                         if (!gpriv->fdmode) { =20
=20
				1) rcar_canfd_set_classical_can_mode()
                          =20
 830                                 rcar_canfd_clear_bit_reg(&gpriv->fcbas=
e[ch].cfdcfg,
 831                                                          RCANFD_GEN4_F=
DCFG_FDOE);
 832                                 rcar_canfd_set_bit_reg(&gpriv->fcbase[=
ch].cfdcfg,
 833                                                        RCANFD_GEN4_FDC=
FG_CLOE); =20
 834                         } else if (gpriv->fd_only_mode) {

				3) rcar_canfd_set_canfd_only_mode()--> set fd_only mode here and else p=
art(!gpriv->info->ch_interface_mode)

 835                                 rcar_canfd_clear_bit_reg(&gpriv->fcbas=
e[ch].cfdcfg,
 836                                                          RCANFD_GEN4_F=
DCFG_CLOE);
 837                                 rcar_canfd_set_bit_reg(&gpriv->fcbase[=
ch].cfdcfg,
 838                                                        RCANFD_GEN4_FDC=
FG_FDOE); =20
 839                         } else {=20


					2) rcar_canfd_set_canfd_mode()=20
                                         =20
 840                                 rcar_canfd_clear_bit_reg(&gpriv->fcbas=
e[ch].cfdcfg,
 841                                                          RCANFD_GEN4_F=
DCFG_FDOE);
 842                                 rcar_canfd_clear_bit_reg(&gpriv->fcbas=
e[ch].cfdcfg,
 843                                                          RCANFD_GEN4_F=
DCFG_CLOE);
 844                         }                                             =
          =20
 845                 } else if (gpriv->fd_only_mode) {                     =
          =20
 846                         rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdc=
fg,       =20
 847                                                RCANFD_GEN4_FDCFG_FDOE)=
;         =20
 848                 }=20



Cheers,
Biju


