Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55ABEB8FB7
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 05:45:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.2206.1693979142420370481
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 22:45:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3865jUCN2811183; Wed, 6 Sep 2023 14:45:30 +0900
X-Iguazu-Qid: 2rWg4AOIlFqr7lUGI8
X-Iguazu-QSIG: v=2; s=0; t=1693979130; q=2rWg4AOIlFqr7lUGI8; m=bwHa8QbFWHPw+M2sWIuu5AnQpZQWq1hC5/YETDdmlmI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3865jTHl299063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 14:45:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obJ1tDBFA6RIHSZNeltEK9yvhulH8p3+Z3tz/jmaYPNh9068yS3n0VZ2Po+PfTwOM8adF9antc4qOVgqi7ris+gEs4Q7VFjAhdw+WEZ+QbmxM9GSPpYagg00WjqAixwDFpuhjWJXAV1DTT9vpKzh/NTrXnE4nmNaPEKqJDkaKKBO4ZIoMNxI0suz64iJpPHhenGvFvkdH0b/5h2TgHAXMHGqzbGBSDq91rhLtQc+8Bi2euriFYIISDjELGixK4VdwGV6BWQd0V/2egOwXfxWjX73An9XsvGwT4QEIfAqwUA2tIRcm/GFYRaYX3dcKkCWIn8b8eoTWqv7pfJ99qjDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urGyqm4svUv2luFtG6QWIYg5UE/L7LPv+dzx/4KbDX8=;
 b=RtiAUgamybdBEj+9JutZSWRMCcCXdf6l0k30Pk2ZegfvXbb3/yWQ8XP8WiS/StjMZQeCnWAZSHZPYsRuJRaVamQDFrbuVKah6ncftizCkBZ8HTPO4OX94NdTliHzt+iritEeq0lkcPEiWOcCrWJ74BpqsTcVBlTNICwOAQbFwxDvva031KDp5cQgFyXeqTInALE+GrCJ9tII8IZauSdExaRrRiaAyQtbAyeJ+2p+b5sYlBZBo8DYhWogGIstJOr4JRrlZBeMXx+afeUk3lUConObUaCWVd8OBAVmaoa9OwK2pQlED3UoBY9krkgyRXzJA7Y5STTdF/yc6zXyKto5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Topic: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Index: AQHZ4BM0YKB3L5egb0OYRnb4ah8VErAM6lhggABewYCAAADAcA==
Date: Wed, 6 Sep 2023 05:45:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420EED43A099ED7F901251D92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942095E6CB6A4BE1B9A5A87C92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922BAC5CF846A96B38D00FA86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB5922BAC5CF846A96B38D00FA86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8678:EE_
x-ms-office365-filtering-correlation-id: 22901f79-8ed9-43eb-befc-08dbae9c793d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N/ku046fvHSG32CffMp0r45ZHtIGpXt2czBd8rXZUw/jhm4gnn603rEhSkPEdXMfNn4NV0kdySnECjowb/ziVtssDzrxkurTmlea6Y74+HOJm2OHSzZQoOU6ZaOO1coB2rT4R95v+vfrpCsbKmDYSapFy21Aoy4nMJr6GKKeVywykpi43+rVAETewka3A56OnUfcKAhVibZE/OlotAw8b/FwEP3IzpRpaW7CeVfpY8bKgZ4vQVszSv8v+PG7uSwt/mZImkNyh2CRs2CXP6QfZf/j4LZOqHWxymsOWAsJLGgbKA90QsIqO+15Zt/MpLvIdwgSVkrlvV0lXOjnkZ6LnOg4RxIXuLr46HGbdtiQdD927vpX+9clpLIJNSYtBhQTbNgqzlLaMx7UgyJQcyw0DGJhJWVj+62xlYMS164i61EAGoYhVgJRX9lFkZ1Ahwkw+nyAfXsWXh0l0VGFAVXeBHVH87i/TLKU+oqnXAa3mEJ9UX2JYo1O3DK6KTxcEsamMsrw6jcIhFrErztQthzQmMazLfx4EyBgWd4gSy51T+huWeeR0fFVWW7LMB3tyNfdl2TRzzjuAwivX1OR8YksEBbW72FHbRintn+7XKTgbfbotfVv7LhOGaufbgX1LfRI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(38100700002)(33656002)(122000001)(38070700005)(86362001)(55016003)(478600001)(71200400001)(966005)(52536014)(5660300002)(6506007)(53546011)(110136005)(7696005)(76116006)(66946007)(66446008)(66476007)(316002)(66556008)(64756008)(41300700001)(8936002)(8676002)(9686003)(4326008)(2906002)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QThGalNsNHZkZ2Vpbkh3LzRJMDJ1ZlRjUGExTXFZOFVNTVVNb2lYeWRS?=
 =?iso-2022-jp?B?VHMzdFc3RmZBRzNmQ1lPUHVjem9JK0VIdXNQczI4NTdYNzZINURNeXBR?=
 =?iso-2022-jp?B?SHFZOFRRaHNUbG1FbHJaS212dHIxUWdzSkNNMWVqa0g5dzIzMTVZYjc4?=
 =?iso-2022-jp?B?SUl4WmNTWENrTnR5Z2t5bGtOVW55SWR6QW1PVzJoK2dXcXdOWUtFempw?=
 =?iso-2022-jp?B?OC9kNUN3U1lVcXl4ZVJzZFJHenkxaUN2U1k2dzJLdTcvbHdyUE5UMlRU?=
 =?iso-2022-jp?B?TEVGcHlwbUhSOXVKMUFKa2FrNGRBT0p0WHVMSnNMdjZDTFArRkY2alZP?=
 =?iso-2022-jp?B?dzIrUHEwbG53d0N5OE9jMndmd29JZDcwaTNVOWVQR1VEeWFDd05tWlFh?=
 =?iso-2022-jp?B?ZGcxcHFNTTAwcXJtaUM1R0hvdktTV096RGdBZVZxTFB1ZXRKeUhJaHZN?=
 =?iso-2022-jp?B?T0FuSUpzbnJUUTBKV1RLcEFOVUlZRjArWDVkQ1BEVDRwend6Sm1vTEVV?=
 =?iso-2022-jp?B?M3Uyd1NoVGFZRTFJNlc2RGVnNlJyYlZVbkV5R0haNUFkZWxFTElFb2dl?=
 =?iso-2022-jp?B?bmtkbDY4emh0YVh3UmdUNXVxbG9rcFhSbW5QeVU4R1RpdzdBMzBJK3Er?=
 =?iso-2022-jp?B?ckZ6RUdtenFvVGQ2RW9SS0h2dzRsNitDejh5U1k0KzVRVjhBUk9hb09z?=
 =?iso-2022-jp?B?K2VLU2NTOGlOUGZZUTdBN3pkVjAvS1RoVzVZL3lTUWFha0w1WTZ4VzBY?=
 =?iso-2022-jp?B?eGdoYkoxdURIbCtOa05pVUtCVWx5aFdXWE9qeU5odUg0WldyYXNQSm5i?=
 =?iso-2022-jp?B?YjRSQWswVUFCL1VvVlRrNEV2bnVOUVZCVGg5dVVkM2NRYytlVGV2b1lk?=
 =?iso-2022-jp?B?VERwdjQ0VWFsZ1NFZzE5Y2Nsa1psamc3Qm56TTJwY1JKLzJjaVZLNEM5?=
 =?iso-2022-jp?B?eFV3NWs1ZGV6cHJlV2w0bnVKZ2d1WDRwVE1IT1JiSkQ2SEZiU3FaaUJT?=
 =?iso-2022-jp?B?eUY1ZHp2WXZpam1na3pJeExrUEQ1MUs0TndDRWlkeWpRQ2Zrdm1FZmdm?=
 =?iso-2022-jp?B?NTNwak5BdWY0MTlXb2I2cmFhbTNtb2UyWXNpelNJSnY0ZTAxYnNweGh0?=
 =?iso-2022-jp?B?b3JnWFY5NEFVditoY2JWUG5DeElRb2Y2MjR3dWhHelpUNUx2R0RHeXRp?=
 =?iso-2022-jp?B?ZTR5dERQQU5SV1JLc05DNjg4YWtPWkhiMFhzSDZzVTNCU1NvNUZacmlF?=
 =?iso-2022-jp?B?YnE3eVUrQlZPY2IrWTBJMmxTNDZxbXpmZCtPallucDhFb0orQmNoL1pB?=
 =?iso-2022-jp?B?cGE5MTNDOHh5bnRkY1BpYlNPMkN0Vm0ycjJ4emdHU3c5bWdUTVpLbWhZ?=
 =?iso-2022-jp?B?emtRTEQxaklCNVg3VE5hL2NQd0hDQVRTYkJsVy8rRk9LZTVaSDlmZkt0?=
 =?iso-2022-jp?B?L3k0WmRNMmJUeVB3RTFScTduLzZiaXhtaDd1TWFKbTJkUisySHIzdEsz?=
 =?iso-2022-jp?B?Y2Q3RXZHOUFZVC9ieGRicGJGZGtuYThic1UwTXNQTUc4NXdPRDVGNkNl?=
 =?iso-2022-jp?B?a1JnYm43TVUyMTBKbTFuWUlIU2QrNGJpdkkwTjZMdTF5OFRzWnZRSUZz?=
 =?iso-2022-jp?B?cU1ZelFoQVJBbjVEMnBaRXFIQmdZbkMyeXg0dVZvaXlYS3ljcVU2M2xE?=
 =?iso-2022-jp?B?b1RnU1lSQkpoZWlWN3R6UUl2UWZvY3BRZjNoREl3SmhhY2pUM1gyMEFU?=
 =?iso-2022-jp?B?cUFOdk54TkFJRXdEQ1ZiQWp1WUJvclpLemJ4OEVNY25ZN0hhV2FCaWFK?=
 =?iso-2022-jp?B?YjhJZ2dvMzRtd285bW1VdW9Za1NzYnhLeExKbGFuYmkxRDJXU0dNNlNM?=
 =?iso-2022-jp?B?aFFPRC94SDRlNkxGdHRrVDFZYnFUUmZkOHArWTZtMCt3L2FJVEYyTjJn?=
 =?iso-2022-jp?B?cVpHUzA4Z0x2dFVib0pYVUlja0lNWXdrbC9SN0lUQUNGRU5ja1hSdDNq?=
 =?iso-2022-jp?B?Yk1OWEFNT3NvalQrMWZxS1I0cllYa2lkaHZIWlpsMFhlYUVhZ0d4Z1Ru?=
 =?iso-2022-jp?B?aCtLdk9ZQS8yaHdFdUozOXRXVURKZzVFOUpzTXhEeVJQT3NtNVM0YnRl?=
 =?iso-2022-jp?B?c3FpMjhUSGErbGplY2ZuNzVwT3Jaa0NOR240ZDBsdmtMSXlLOENRVE8y?=
 =?iso-2022-jp?B?bFhVb2JCS2YwUkhTb3ErOUwyUFVzVDJnOW4yZk5mTE1RMDdGWWZYSkN0?=
 =?iso-2022-jp?B?U3lVem9JQ2M3QmVzeDNyTWVyaXRiOWRzZ3lNYWcrSHVVYXNoRndqUVcv?=
 =?iso-2022-jp?B?TktnNWQ2K204cnJwSFlBejRpUzhWbHYwRmIyWUg0S091dnM4dmRRK0lM?=
 =?iso-2022-jp?B?aDMzWmxrdmk2UmNKcndNOExyeXZHMHZWZnZPbDJ3dTYvc1N1azFMaVFt?=
 =?iso-2022-jp?B?NEo3QzVRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dUP+bopEY7CYsGVvhRDSgOKMUx1KbmfNB6Y5Qb5PurnSgmGZ3076XGzU3THpAf04I1ber2KH/zpFVDnXpd1rsG0gcQz8RIcG68o/qQzfP3f9ZwaRiwxFU7667yiMzhyMf67s20aG6Yx9pZII/+//+H4O38RjWgbcRMb5Ou4iw7Cy9nQ5obJtsfGO83yUNRN9x+Y7Id7iYCa5q8GoAemu5e0o4Lsimw/rX+b5Jpp2ZlU44rZ10wp3ZJvVZvAypySl8R2uX2HuqAQMViYlk2lSdZ3Lmpsh2TfwSVsCiSdlPJX1RaHaf5j8/k288AHfXzaLRuz5bVme9/esRtNvnuNOJz8QuaPzuH4wH34eGZjqUblI+g+93FAqANZFqMRJlwd9eP8bFxPFzIDEMBabvzKJrP/hubU/+OHMZDzDkz5LUTlmhLitS1ZXSQzSt9Nd5W2wIlPaAQ4zc74BfY6DsFxWPdhLEIIHO7PV2WCTFJtaHP508xHmvG7s6MjH4ahOaTXs3stOr3QlJNQc/PVcYWgxQV0Z5ec3eDFiAbVIp5YpBI1wDityDEF4EfTQszWlL38hpbnrepAF2PC5p5JZOmptKszXAXy9RBmne6XmXDxqhSPdT7hP8A9z3ubUH+a+J5D+H8kXSa897bJ/eI2+uDv20tC32ortsBZiQgg7hLvIr+MCAWVLVOdXX5sRGCbihAzWPuNoapXr8/RAWYkbl/2cXQl22MmskwZ1IZKtjVL7iQMqikzqoLr72gUcpfA5qW99o4UX/6JtDuzhPY0nLxXmwj9a7wiZ9w9WvZICZu2pPYrHqvMmEWXTJnj5FA3ROhPKu2Y8BihPOCRpknl/yEmq0LFYb9waOo6S72qVyReCQKIqFrRe5+0m7eF44yj+eEvy
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22901f79-8ed9-43eb-befc-08dbae9c793d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 05:45:27.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjI0+S5BR6dXV4VEtVW5EKI7xlA1b2Gk9llJoQsdD4pm3vxZ60Nm6581ZksTvCvrLHHV0DgZI6pQXsnCNL1ggGkLwaPiyqBwvzzkAY4l9WrDLakQW/yWwP+FdUvxbMnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 05:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12976

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, September 6, 2023 2:40 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
>=20
> Hi Nobuhiro-San,
>=20
> > Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU
> > Support
> >
> > Hi,
> >
> > > Subject: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
> > >
> > > The LCD controller is composed of Frame Compression Processor
> > > (FCPVD), Video Signal Processor (VSPD), and Display Unit (DU).
> > >
> > > It has DPI/DSI interfaces and supports a maximum resolution of 1080p
> > > along with 2 RPFs to support the blending of two picture layers and
> > > raster operations (ROPs).
> > >
> > > The DU module is connected to VSPD. Add RZ/G2L DU support for
> RZ/G2L
> > > alike SoCs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > You forgot to add the original commit ID and Signed-off.
> > And I could not find this patch in upstream tree. Probably any patch
> > after this one has the same problem.
>=20
> As mentioned in the cover letter, the last 6 patches are in review state =
in
> mainline [1] and [2]. I have added just here for testing purpose.
>=20
> I have tested GFX[3] + DSI + VSP + FCP functionalities with this patch se=
ries.
>=20
> [1]
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230704090
> 447.27420-4-biju.das.jz@bp.renesas.com/
>=20
> [2]
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D742=
810
>=20
> [3] https://renesas.info/wiki/RZ-G/Panfrost_for_RZG2L
>=20
> Cheers,
> Biju

Oh, sorry. I did not check cover letter.
Sorry for the noise.

Best regards,
  Nobuhiro


