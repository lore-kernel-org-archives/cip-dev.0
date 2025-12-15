Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8169AD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:45:33 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44963.1765791927431987404
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:45:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=BKI2zYCr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le0Gf0X2ufVIYfooCCgPOVJr7OlCHGhA450jn1ILE9HhFB1RUaHnvNMPauuz0jBzlLjmizzn5m9mI4vlUx1eDCUxUXmj7ARAvaY7KCL3gcMbIWlo6Hjpv55V98dIPqHpp8yp9QaTTf+2gpEUo2z/IIuVcQJILsrl0uHs/oX+75D+MHN6XCY//UQyJ5GzFFbzS4Jzfq7jWDoX73ZBPhQmKmJxxGKaYKN+4mjZ6oAZrHbOfwK2pGOmf7PLj34tO2WUTJybAniVaEUtfz0TZjUJ8e5eeOhxCouk95jfndUNCnd2RrQ6A6ZT7/joJBwJF0NXRyfWuZru/3EpnolJrBdc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIQJTJD1e3AB4C4hUEFC6jQax9SUa2OQLYWqn8S54t0=;
 b=k2Tj0Bo4//bk5+Zer3zHxdtvfH8ofcJMVlQVdPJUM+0qq4OH7ad0Xa1cEC6/g6aOi39KdNCR/zKcSy43mKplWL0QfDM5o2jy42VGWZppRzIVvmxniKRqGx9ais8ohae4GH4W6xgJnO8VTNoo/+gvHqECJTcC7KxMvWJtOjkXz5EvHdu6u/MxuOkMpdLYU2bAfxnD7ryanEEIrpvfCDY0L2Yz4tS4TaPiKMC6TBiFyGzknNulymXS/Zu2UjgFaogpzXUzsCrGlEYYRDO91luTgoxDSo3JYxklgDr7p0s58hRyIN+iCJ1tpD34TSBysQbr1NFpkK/L+8/fGfaUbs3bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIQJTJD1e3AB4C4hUEFC6jQax9SUa2OQLYWqn8S54t0=;
 b=BKI2zYCrKE7gQXJ8HDE620M4S6jPT5kDsmf8R+ZaGJvFdrKtPxLzyLxvuKWkxfoQv11LRlYzM5a4V16xXBLQI5++c7zwG+1rymqW7wVc+2/l1OQMBxkrQsyTo2KG8+XkSXpv2N/nECNBPedxsl4K7vfrBCiK3TkjKqfIWBgp/vs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:45:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:45:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 2/3] net: phy: micrel: Add ksz9131_resume()
Thread-Topic: [PATCH 6.1.y-cip 2/3] net: phy: micrel: Add ksz9131_resume()
Thread-Index: AQHcbPFi5C/xdfA9YkCxi/8JuIsmu7UidSRQ
Date: Mon, 15 Dec 2025 09:45:22 +0000
Message-ID: 
 <TY3PR01MB1134603C01D07BB721E7AECA686ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
 <20251214120122.3784-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214120122.3784-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: bd0ac5fe-b0f7-445a-8c8f-08de3bbeaaa1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?G4rMsIgDDnq0SmYTJJVqb+WrcOJqiUPphUkS7xS8nbcuhCD4zkBTrSX3Kk95?=
 =?us-ascii?Q?dGNKsbju0tLM1DW0koOUsfYBgR7UvxhzF3ZCfLymSgIHt87wqfLXDbHPnjkA?=
 =?us-ascii?Q?T5Ewx/dWJ2KG78rR+B2pRyzN4aPJRoHNQ+8DpGA80EUrjjiAL7EjMhOamUr8?=
 =?us-ascii?Q?Lz6o5mWu5RHcDhNFTNkTvrq1KaH80IbtJjeCs7USZb4n8+G2NlcmvNI2XaxI?=
 =?us-ascii?Q?/dC/1UVbqpVya5LIQgavAb/rZWFeQWzcC0264qqVLbeL2C6GoeL7jxwHEmJv?=
 =?us-ascii?Q?9IX4475cxA8vd0LOobZ2vLNR56MH4qAIlDiLqR+eLPoPkS5vLlBRLZs/DDt2?=
 =?us-ascii?Q?KRYp4uGe8/llAHOjZAI/r8gpLwiOKfDfoKElQPwVKh4iu00M+Qf6CS9rwsC6?=
 =?us-ascii?Q?8JzzdWTcdNAVjxVpgGR9QLXN5uEltg361D7XNScG6eDWlTrPrQ8FIZHAJghl?=
 =?us-ascii?Q?qoUytLAdh58+QOnYb7qZQxgIwcjqUz8ksF90n3AZ1UWr0Bhor7w6oHeij8xv?=
 =?us-ascii?Q?ubo+7ggg2dBnMYAiVfwM9lITdp0p2R3RbvcLQqpLgyL3Dl2SN2bJJ0EC/usk?=
 =?us-ascii?Q?2MDGRZEd0m5QpYGKE0cSUkelatQsoRrkU1wsrtjuhOwLqoJTPt1JpokHv0Wg?=
 =?us-ascii?Q?u6ikHiDIS2tW0PCHHbfyopN+vB+MR0ZE0Lxrb3kXNTJu+sZ3YV51wHgRL/PA?=
 =?us-ascii?Q?1Y4VA7Keb/wqMgHLiXRy+/l19i1N1SYgG4+QJoElLlr7MKdXFKodVqIC6Trn?=
 =?us-ascii?Q?LA+2eCdqJ5Jg+yoZLJgrOhD172BCw//DrxSVpT3YxZUXzXxI6A0jT3euJnRK?=
 =?us-ascii?Q?carWs9Bp94YHrKxvaA+UZdUHS0LcIo3PXKrgksyOMA/TMbxI+2FmXTkiw6fd?=
 =?us-ascii?Q?3G8deh/f7dWmNdJD62w5xCBBvfoQzJqSatoIwSNtvdjlNCYNVxoWsBwJ/5P2?=
 =?us-ascii?Q?k/peBpQvnbJlmtb3itkbhtWKnLSV7qJJWl1MSpF4XitSluY4svZXtybMUp6+?=
 =?us-ascii?Q?gdSHKriG1Y3ubdhbMchn8YFrmwBFXeBL0SPKGqV2jkgTa8pNzWKAQ9U0Ecu5?=
 =?us-ascii?Q?vIx27SlR2AiwaoYVQMn6tXLLbHq6JJr6KI1b0DNULE4GvqpR1XeSMDr5rtui?=
 =?us-ascii?Q?U8tLdtgeKQSH8gAZSrk4x6btf8l3DvN7SXsb7LJSbzVJjHJ58qFAseHtK5tO?=
 =?us-ascii?Q?3S/rQUCxJU+geMZgWMQ8ABOGybwLJeP2mAtReU3S2LiLHWRe/6G5sH1KcbiM?=
 =?us-ascii?Q?ZR9xK4aSPh+2athaYR3dCUhC3KBP98okX230cCoAltEvhqJRl47VmZ8EaNVn?=
 =?us-ascii?Q?JuyF7+dD39FmrRqcDhtyXhM3Lt4/aOfvfDrDikDB3utkuMatJQBQLkqYYAda?=
 =?us-ascii?Q?4gubfccSKugSgdtfWCCWv7cI7XtE6rdEvlZvA5D8efrqzwrmlx6lvksYAMpi?=
 =?us-ascii?Q?V+ALAON26ke+32UvFvVnzq9sg6EVbM8uFpZGpsDYjW0zeVt5gM+TpA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?icSU6r+Jfpjr90DZZ8PAUyUrgxNqnltGNHDEeddDFZyi9afmlbXlumsvxsPA?=
 =?us-ascii?Q?krLCkj/2TxPGTC9j4GsqFIIN4I8/8X4ROT4OjJJdsyZe9lcCWxcE7bRP9N4l?=
 =?us-ascii?Q?f+8Ewvm6Ga4iRm81eGk9Jez8oDO/Ar1I5qOtF/Eo8JKkmbdxKbpSfNXKRk2z?=
 =?us-ascii?Q?6wJJX8pJnyw76vkC6+Rhu41m1Zia6crZ8rvaxh4mCE0vsCXVu+aAYaKRcHR7?=
 =?us-ascii?Q?qKEKyCav9iE4Rx7Giz6pBZiTEoX/JYlET5kiAydwzJmIUVn5yKYN6v86Du7l?=
 =?us-ascii?Q?KKycqRp+uC5U6Un4GFQ7KD/OvjJQbn7I9jja2eaalMRO/vxVgh2BIMU2/gnJ?=
 =?us-ascii?Q?be55BU9l+AB7Ko53Y0KxafPwaUw/+jF+9q4KX5gV4QBR90xnRjiB/fT4s2F+?=
 =?us-ascii?Q?F3VLDckjxe5C/Rnu90BWRFz7jnWwyx4OAKhnXvQnI8f5ZxKLZpEhlDlOmAQ8?=
 =?us-ascii?Q?e02OJKveti6xaBCuEyvxR68Pgf2GQhT+b4IOinzWe4wVGiynqj3U9HGLmiMO?=
 =?us-ascii?Q?gHMY1rh6VPxi9iVcQsGGV9zgf3bhvnVzV6cBhY8tM61c7+/OE9wxPDxk8jMX?=
 =?us-ascii?Q?xYTCOb0G8HLN/X/8PZptRebjR0Lj4nrMoUXZ/SD1MhZRRGAdccbgT64xQXUO?=
 =?us-ascii?Q?smuH7oj/O7QegRvAU129q20VNDK3gBrl0d2+oPoUTZaz1cgN5cNvduP/bydi?=
 =?us-ascii?Q?IwGHmVRQSooihEGIXsOSmyyEK8YK2DrO/6DqT3DCyO4T/g5RmXqsdlErMn4B?=
 =?us-ascii?Q?S84N74czZzlW/sWCQp4sHI3wqk51SaqIIMO8xVp9nSpJm48OzJ0GIIgD6foj?=
 =?us-ascii?Q?LSuDwjAJnRDTxSELCrTZFn0GThtusnwEIgJ6K9ipRIm1zGaMGSB25c9mjE2e?=
 =?us-ascii?Q?mfzGxmp01/ZYN5m0Whia+oYiocQWM+kHmuhLd1Nq0EjzWBc2JC0tu+kG+hl4?=
 =?us-ascii?Q?SVwesy/GwAbVyNm/ssKQpHfdPXLDJQH9kNSkysUMwbG7ahmEWY9pIn6l8ze9?=
 =?us-ascii?Q?UB35AKQR2tbMa3t8DrvM6ohp20teKymBNdpOzReRNzPfFHrf15ejIUqpkmCW?=
 =?us-ascii?Q?ThUngVd3HqJJr8qbPgkyOxY2r3D9cDM9YmTjJo0tzHxjdKzR8NXZKCgYqCzB?=
 =?us-ascii?Q?RSQMGGtMXoIYJZjxWEH7HLBhfk3utq4PkbzGOa074Pf1mH1n4Nh+hhweDHyH?=
 =?us-ascii?Q?cWVDWq2BNivmveyWuow6QwG/CaaUf7Hqqz/RIQezqhMJqNJvhWTT1mHy+7zq?=
 =?us-ascii?Q?meornIZu/IAC7Wy6WOetPX0PtBfXbD9Kk/AWEZdl0sBV57lXaGGBcBArrFdQ?=
 =?us-ascii?Q?WzNx6qGRPpCtEWpf/xBmBnA+gqGhF3WrdnbK4taIGiQQGr1FOfJ5kv7pcU20?=
 =?us-ascii?Q?rGXvfYu3OSh/gXMhX37gMZpt5s/uBQu4ue7GXl896/LZHC1OrVG9IUeuNIEt?=
 =?us-ascii?Q?0rwxpRTsZY1PDSrKCeI/CLQnU/ymOwSL/XGPpmJySnNZvvxJLQY+LWX9Bxsj?=
 =?us-ascii?Q?YCDFDeUznaFsxRAOVSugEKDCeu7/3G4soxr59imNpMy7oJVlTHLaaG2c9q8p?=
 =?us-ascii?Q?WYitZXL/yqa1jUamt+ZsGbZO0gGP1HG6D/Hk1YbweeZgQ0mH9LqZyeClPG2u?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0ac5fe-b0f7-445a-8c8f-08de3bbeaaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:45:22.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVaEunluJKGEGH/CEnEsgcbf1IoivwZyDFiOf52RbyYy7IlIqnp8CvJdg9D5TXD6DgVCCgrcPVXhMYHwcU3sCRnTKmoifjkb2QHVcTLM6oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:45:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21039

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:01
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 2/3] net: phy: micrel: Add ksz9131_resume()
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit f25a7eaa897f21396e99f90809af82ca553c9d14 ]
>=20
> The Renesas RZ/G3E SMARC EVK uses KSZ9131RNXC phy. On deep power state, P=
HY loses the power and on
> wakeup the rgmii delays are not reconfigured causing it to fail.
>=20
> Replace the callback kszphy_resume()->ksz9131_resume() for reconfiguring =
the rgmii_delay when it exits
> from PM suspend state.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Link: https://patch.msgid.link/20250711054029.48536-1-biju.das.jz@bp.rene=
sas.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/phy/micrel.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index 63=
392514c894..61c0f0cd4e5b
> 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -3194,6 +3194,14 @@ static int lan8814_probe(struct phy_device *phydev=
)
>  	return 0;
>  }
>=20
> +static int ksz9131_resume(struct phy_device *phydev) {
> +	if (phydev->suspended && phy_interface_is_rgmii(phydev))
> +		ksz9131_config_rgmii_delay(phydev);
> +
> +	return kszphy_resume(phydev);
> +}
> +
>  static struct phy_driver ksphy_driver[] =3D {  {
>  	.phy_id		=3D PHY_ID_KS8737,
> @@ -3422,7 +3430,7 @@ static struct phy_driver ksphy_driver[] =3D {
>  	.get_strings	=3D kszphy_get_strings,
>  	.get_stats	=3D kszphy_get_stats,
>  	.suspend	=3D kszphy_suspend,
> -	.resume		=3D kszphy_resume,
> +	.resume		=3D ksz9131_resume,
>  	.cable_test_start	=3D ksz9x31_cable_test_start,
>  	.cable_test_get_status	=3D ksz9x31_cable_test_get_status,
>  }, {
> --
> 2.43.0


