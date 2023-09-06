Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD3EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 05:42:19 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.118])
 by mx.groups.io with SMTP id smtpd.web10.2227.1693978931702830366
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 22:42:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=iS+aN4Vu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.118, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHk9K4+XCdSZXkqh8L3cxc0RxTUQ+8pRCH68l3bsMGHnG8YEBWonCp/5N6x/l6Xlj+U1fdodU5newWG1QAFmzrV8BO2+KW28FCx+uOjEMSHJb7KJwRbTkw65QDbZ4WaOgNplcaCofEu7Z3me0Zwd42RW6qpo/s3MPJfyrSc5tomAWDvymGalqVyj3iJ0GQSlAtnqnyKGKUP42XoxgLGa9sD7sucxfg2H6GsJNQLk5qv8x0g3jc/LUO/kORX4Dxc1colSuHf59ObufQDqMFNmb4Z/zs5zsKpLP3MKwceFTQt1CcKOQFEh5hyS20VBJYh8Y3uZtZreGJTAjOMCgOcWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHGDo4J1vOtQppZQodd7+Wl4XrJmHpC571oxmcpHhYQ=;
 b=QaJTp0IXQY9KID1+xNY15ZJQB+BX1bZ1ZZ85BYM5fetfupvzxpxRi7Ntc/j/x3/VG6FY6nvJPfAM5Hbocxyg4Uq/RJOkD9K8oi98OMam7DxGpY/GrsGV0Y/SyP0QUDGdEO3SJi2OiLOYFEyokgGStZqICy58TTbRqfLxaMevwg2xWhzYBue+RTnH1iv3PcfZaztioojbaohQ1YQVWo2qZ3mcI28G9MxjMY182XXNRj8x/dGtUkES5RQhwhspILe+kiZCwvEUOw/A9JxeKcj9wagd88E4nc1IQNKccAOYxUgZN7+zC+8leHNk1/1Dm+xcZvYA3JucPpEj1Jg7qIrypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHGDo4J1vOtQppZQodd7+Wl4XrJmHpC571oxmcpHhYQ=;
 b=iS+aN4VuT2yGQuNuymzq5tcKpO1f8QlL/2ldDQf6DtA1z0ymuKk2ravRAEdhBl68hEfOx5JPNSdOmzT2zjIai4qCwVESDFR7bFzdoGgkE6MO6K7fX2J7SwMSr+0dO24NSl++PQ/ifUfsjdnVrXiDoM34bCTBJYhA1LSy7Mmngvo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9779.jpnprd01.prod.outlook.com (2603:1096:400:22c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 05:42:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 05:42:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add DU
 node
Thread-Topic: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add DU
 node
Thread-Index: AQHZ4BMwfMqchuYmZkmQHL7pQIUNyrAM5E4AgABk0EA=
Date: Wed, 6 Sep 2023 05:42:07 +0000
Message-ID: 
 <OS0PR01MB5922D5B86BEAAAE23A81C32586EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-17-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420DFAB5C48DC0BE933CB4792E8A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420DFAB5C48DC0BE933CB4792E8A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9779:EE_
x-ms-office365-filtering-correlation-id: 0a4e618a-88c4-4568-5a74-08dbae9c0245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3C2nKzlt/C3m1B++HNEidMwWXGyix4WAUrqmJgB1sLz77dn/kgPwy7TQp2AB4OrBbwAozeyoB4NjfP7kU1GaNfUjjkybmSo0FUbAeIm4rOBP8sPfZeTSu0dMWnBdy3tAC6t826uqWBSrKgwDhZjxJkdWG3WJYuhIR/NKCSzZwVepnUp8wR+mN24dEWbwdW85hj2rS0nUKxBt1+VKs9O+cjpOFRR46BcjxoUSCdhVFMZW+6oUoVQN3tOc1oyy/jda1ppjKMVVpTXt+jszfj0H9yI11sX4BXEiG+EsjwSwJVxeLxFNDovW1LlxHHDOQO1v00DPOc1ATVkqNC5vGnl3vr4H+/pmh5TQIJ89utbBorrgFaoP+nVTWR0VC2pQb+zfKZirutbVGplPhF8IDh4qOJ1Lwv57jdLVDScYRAfgYtL0c/bLszjj6KTbXSmfWlX6NO2g7M6GyK9noZf4XGBHFtwwvWN/yo72E6YIwGNdHL8jrewQYctKpQ3U2gLA+A8wlJvJQkMq8tLfugTGgRHHzogE9QXyaahwQpbWrIAHp2+sKGVtUSkBIx4gj1rVYa7m+sw5mgKal+d4314OrLIa9tgwA4JWHiUeavUXA91fqPA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(55016003)(2906002)(83380400001)(110136005)(66556008)(6506007)(122000001)(53546011)(316002)(64756008)(66946007)(966005)(66476007)(76116006)(5660300002)(71200400001)(107886003)(478600001)(66446008)(52536014)(26005)(9686003)(41300700001)(7696005)(4326008)(8676002)(8936002)(33656002)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?THV1S3FHdGt4cVN0a2U5R3RTT3hPS3JKTWh2R0lFM1MrclNkekh4bHhR?=
 =?iso-2022-jp?B?VFBOMm1YZTVpMTkrWGVqN3cxcW1oYzBMV25mTWZFMTVkZlBjSVFWM2pO?=
 =?iso-2022-jp?B?ajFDd05KclFuK3BtUm1FdThFNEc5UlVVREZGRFZvR0xYODJyczJObmtT?=
 =?iso-2022-jp?B?SzBzRFoxTTY1WGU5RGEwMEdkTUZGamlxRWZleWhQS3p3MEZKY1NyOS9a?=
 =?iso-2022-jp?B?ejRzbk9RMUl3bXpSWFRhZXJzYXJRY0RKWEI5L1FvdFJRbW90OUl3MFBX?=
 =?iso-2022-jp?B?SG1SRHZqWEY0WnYzblNvSThjZFFaT1JCSmxQY3UyS0xLZWVDOWVVeFdp?=
 =?iso-2022-jp?B?NzNOVU4vV2xqVUdtN3ovak4wQWxOZ0hGRytyV0gxMjZMZ3BRYUJ4Uk41?=
 =?iso-2022-jp?B?TFZaT2U5ZmVTeHFRcnZBeG00Q1pIbXRLNnYyR0lwc2ZONjN0VGNNeDc2?=
 =?iso-2022-jp?B?ODBGVmd0Ym5JcXFpUlVzbm5HdnRJTUpJZC9HSzNvRng1MWcwRldKRFZz?=
 =?iso-2022-jp?B?bjVuNTlWYXYzUlVwNERjeVNzNXZkZ0V0bnVzd0pabzkybGlvdUgva1JK?=
 =?iso-2022-jp?B?Rkh2ZXdOOS9BbnZGYmVhVmRlYzBBSElMZkdZSkNKTytqZDJtWUFCdHFY?=
 =?iso-2022-jp?B?SW9QclY5Q2hhTWd0RWZIL3dOSjZOQ2RqVTlJWUFWTXpkTDZmLzRpc0hj?=
 =?iso-2022-jp?B?d1FNeUhXL1RtbjYweEZxZHBNRW1XQkFjSGtUdTEwb09ibGh3bWxCbWtw?=
 =?iso-2022-jp?B?ckdiRjhMK203MGUxS0xqbjk0azZTNEgvUUpnTjhWcTF5cTBTb1ZWY096?=
 =?iso-2022-jp?B?eEZmLzJGYWVWSExnTkFDQmJrQkVoSllraCs0S0xnamF5YUw4SHhXdVZQ?=
 =?iso-2022-jp?B?akR6TC9ZYXNscGNUQ0FLaDZmVzhFUU9vQzdERk5BckRQTEpwYWRNUFE5?=
 =?iso-2022-jp?B?VlZHa21xTVhLTmt0N001b1hhV3NTWjM4d1A0YWlUQmlLaEZlaExUVWFM?=
 =?iso-2022-jp?B?ai9yblpFRlRYZ3JhQVdTNjBOMUtRQ0lzcFBtZHJiVTRpWXp2azdDbDFT?=
 =?iso-2022-jp?B?TzVlbVJOTGxXZkRNZ3Y5b3RqYkZzWlAvMkZvb0RzMGxseFFRcHR2eStJ?=
 =?iso-2022-jp?B?bERTWjc0RmFmWEIyMERGdWxmeGpyQWUwY1hqTDVHZWFZNUk2SjNLRGlQ?=
 =?iso-2022-jp?B?WnNSbWJTVUUxZk84NkcyM0pzWHhmdmxGN0t0dnBkTlcxaXhyakZZYmo1?=
 =?iso-2022-jp?B?NXJMUWFtUFVDdUgxbzBpT1pzcnN0SDkwdE5NU3pLOG5zK3hTNnNHWUlp?=
 =?iso-2022-jp?B?VTh1RERZN1VMb2l5ZVBMalU0bUY3bG9SeEhtUFE5UTQ1cEI0dmg1SnJm?=
 =?iso-2022-jp?B?cW1ETXp4T2Y0MUI0OTAwV2RBNFhVRk5oc29oSkt5M2F3WFBZYW9kb3VX?=
 =?iso-2022-jp?B?bjFvcnBraUw5UGhtd3B4aUs3L0RQZXdZSVRPQmtCc2prbkxCRDR0dUZm?=
 =?iso-2022-jp?B?cXJDRkN4WnNMbWk5ZnYvRzZCUklWWFJlSUxpeTRyTWVUczRHZG9Tbzll?=
 =?iso-2022-jp?B?MlplRWw2QituMlhYVE5lSXZsSW1sUW1rWUtJL3B5cDJPU2hzQ2RWWXQw?=
 =?iso-2022-jp?B?aHdQZkV3Z3J1NUpiVTdJakcwaSs0Q2Qzd2l2N2paei9CV01Qa2dvL2N2?=
 =?iso-2022-jp?B?ZUFZNjJwK3BhWFNkS3ovVDlmRWtRaVNMZmZzMW5NRDVHZWxNcGhFTHlB?=
 =?iso-2022-jp?B?WHo2SjZVR2V4Uzl1c2JkcHhja3JpZWQwVjFPTEJCWGptWHFCWTVvenNq?=
 =?iso-2022-jp?B?UzdBS0VNdGRlREpJeVJ0UnRXU3M2L3o4cVladzRwK0JFUXFyc3NINHds?=
 =?iso-2022-jp?B?Mytib0VmakRqQWdINEg1WVJYUUJlajBCWi9kYm94NUpYdCtFT1cxaGJJ?=
 =?iso-2022-jp?B?TzFMeVlyMlJXelVwRlVPQVVVNUpFcHg5TFZKbXFZaUdxVUhVaFJYb2F1?=
 =?iso-2022-jp?B?T0hibC9aY3ZPdVJPTExxbmFRZnQzVEF3Z0I1bWJpdVRwNnUrM3JMUm9Q?=
 =?iso-2022-jp?B?MG1vSDlqUUM1Q0V4ZWVRdVdSdWpWbmVEQ1BhbTYzeUR5U0RGN1JocVRR?=
 =?iso-2022-jp?B?Qm1uL2xlV0p0a3d0MWsrT0dDUVEwcWFVcXczMHdlWjJhVStZL1hqMExY?=
 =?iso-2022-jp?B?eUpnNm5EdkpUTFpCaFFnaTRXUndhMVNCNExtd0VpOXhIMTY0MmZRQy9W?=
 =?iso-2022-jp?B?bURLMXdncnZxQWJZanZSQW1oTW1lZU5kSThCQXpkb0tTbC8zckw0RWVL?=
 =?iso-2022-jp?B?a0p5eUNCenB4K0lpL08xU3FUVlU0MnUxbXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4e618a-88c4-4568-5a74-08dbae9c0245
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 05:42:07.9131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rO3STx9g+D/mnT+lQrG1zNVkMIUGm3cTDUBL3gssAarN6DdmQ9kmrXpcgTgxbX9Z/Q4gAoC2LPUjeCs+wTyTfvw9QSfsHKwmGyNTGutvxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9779
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 05:42:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12975

Hi Nobuhiro-San,

> Subject: RE: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add =
DU
> node
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Wednesday, September 6, 2023 1:08 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add
> > DU node
> >
> > Add DU node to RZ/G2L SoC DTSI.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> You forgot to add the original commit ID and Signed-off.

This patch is still in review state[1]. I have added here for testing purpo=
se as mentioned in the covering letter.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D7=
42810

Cheers,
Biju

>=20
>=20
> > ---
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > index 52279d3222a0..2eba9e8e5ae7 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > @@ -741,6 +741,20 @@ fcpvd: fcp@10880000 {
> >  			resets =3D <&cpg R9A07G044_LCDC_RESET_N>;
> >  		};
> >
> > +		du: display@10890000 {
> > +			compatible =3D "renesas,r9a07g044-du";
> > +			reg =3D <0 0x10890000 0 0x10000>;
> > +			interrupts =3D <GIC_SPI 152
> > IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&cpg CPG_MOD
> > R9A07G044_LCDC_CLK_A>,
> > +				 <&cpg CPG_MOD
> > R9A07G044_LCDC_CLK_P>,
> > +				 <&cpg CPG_MOD
> > R9A07G044_LCDC_CLK_D>;
> > +			clock-names =3D "aclk", "pclk", "vclk";
> > +			power-domains =3D <&cpg>;
> > +			resets =3D <&cpg R9A07G044_LCDC_RESET_N>;
> > +			renesas,vsps =3D <&vspd 0>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		cpg: clock-controller@11010000 {
> >  			compatible =3D "renesas,r9a07g044-cpg";
> >  			reg =3D <0 0x11010000 0 0x10000>;
> > --
> > 2.25.1


