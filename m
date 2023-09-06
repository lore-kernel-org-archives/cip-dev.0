Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC15EB8FAD
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 09:22:41 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.131])
 by mx.groups.io with SMTP id smtpd.web11.4459.1693992153598933716
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 02:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=BAEYztOU;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.131, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCXmb/wAOa6c14r82uz276CsEWyVdVrAJz1spZX7gzn6LNmGrwxN40lKw7P9F84Ax2fUjn6/XMaS4lToZ11sy8MzIOY4oh7yOWYuIv5A+hS+TWmmdLnkHmnzWV0WxXDxZx8BzlRZ1BoC5vWOYpEo0N1s8UZQpkPI13ROLSZxpxweWtQwxncmmt1jh3cYLkOaCgomEzaO9VEZYFP1nar6od6NDk/S3Rc4/L8IWPT1vnw9kCv+qEagrqIab0IQMrSMYHUGACIt/j0VjgJ/LWkh5Sv9Qzw0hV/b/64P/U7H1F+GcwuRnVUy80V/DmGjI8wnUqO9Uls2j03cyi9aBS5hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX2qiRI4D/V43itcDNGUhdTWgkQ+WrnvaW/3x4kJs9U=;
 b=baDV6i2pX1AczZuwuSaaWrRPs1nwSODwakz2C1hvcjIXXW1gog0g4FIDgufi3a92nPRQvIX53JpiX5koFb7m0XFG0AiszPAzk3TK3YVBdbpuJvzcN+5hEigOaXMPKTNm964VVNF16dEauSfrfsFYS5+wOOHz/EDxKuJj14jd9LTkJTlpmmW/Z1Td5mXwAp/dN97WPmAJjtgj494orX6Azbpwi61smUYjRfZ342aUtdNrHtkXUxXmg0HVfowmOxeRaU72tRrATWvot6sbVuybqdkDmpufaa6VpUlsLt0UUYzB39dc64ou/PRzvcKaO0B31kEjuhl52MLLjtsIvlWpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX2qiRI4D/V43itcDNGUhdTWgkQ+WrnvaW/3x4kJs9U=;
 b=BAEYztOUpboWR5A2sd95tqCfcWHnr20zLKDubXqC9yHxMCHotoS1AEk/OSRrKf+TAaMQ/InyOT8YWNLwMawyzqudgvl8M4XiBoeDClfGdGBgEmH1XV0yPE+lXuQ0eX7dIOhiswnJ1VykEL/GKR+ywSeh9Xnw7CqDEHhDdGe8GwM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9734.jpnprd01.prod.outlook.com (2603:1096:400:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:22:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:22:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 03/20] drm: rcar-du: Add RZ/G2L DSI driver
Thread-Topic: [PATCH 6.1.y-cip 03/20] drm: rcar-du: Add RZ/G2L DSI driver
Thread-Index: AQHZ4BMfrJtnGY/shEWrE6zQEx6t67ANe8iAgAAKoxA=
Date: Wed, 6 Sep 2023 09:22:29 +0000
Message-ID: 
 <OS0PR01MB5922F2136892D76640822D4186EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-4-biju.das.jz@bp.renesas.com>
 <ZPg7STHDn4LbLy7f@duo.ucw.cz>
In-Reply-To: <ZPg7STHDn4LbLy7f@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9734:EE_
x-ms-office365-filtering-correlation-id: b88066a0-a9f5-4dc6-733e-08dbaebacac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3YurhRYXj6dY7/docYsoCuWcMLn39mhsT7H1ujMvh/W/piEXDyy7o+Y++TmyxR4GppTm3iIzUgsccKahdzFMGl1fnt1G+LvxXgjXr04KoG9Bl0AF3eaw/wDF3AZV88UAY1eD5lopvgfJ/Rp+W1hZVgIuaWYVQfthVol+6hDms5d2Kur9ofUi7kLhk/vH+esaicdkF6ce3uw2dQ6NddHmHx6lL+tY6APywMC5fZfyRBWt6Xxu7TTYKLGMe0GFcbKjLxmuCMpOTCiz0ZUeDCDPTLoPkJTQ+AYk8G2El0XW8Le3db3lmJ9z/8EkxvSbf8T9IbYtLWiVmQwOiYBstR7tC7UGvS2PvjX/tdlg7q7zeUlqOZyrx3YbjfFtqEN0N0kA/59lkXYhJCDcNHajijVZl5Z2kIBjMBg9q1fih9XXsUp2ZNYucx/qiYjweuUAY7DsjAIlt33gp0L8HasaohqXT/dEno4g7m9eA/UaqERohjSWFcf1Rbin/aCgm1Jl91ZYG9HWCYR8Kq6ywN0KJSfBzR6aWuSKiSIgqXJs0HQtOMqJM42dJM7zycpY3zdFw50jJD8Ffu9RHwicyIdqdoRY2JVPRwpNxBEBSfg05sZ34XI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(122000001)(9686003)(6506007)(7696005)(71200400001)(52536014)(33656002)(38100700002)(86362001)(55016003)(38070700005)(107886003)(2906002)(26005)(478600001)(966005)(83380400001)(66946007)(76116006)(8936002)(8676002)(5660300002)(4326008)(41300700001)(66476007)(6916009)(66556008)(64756008)(54906003)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eiDCsVuUjw7OTyjV8OsrmROOXfv4y22bq2VijfaZsqLabxF5qRTfJRAjB8xf?=
 =?us-ascii?Q?vUxx01/mivvaTHSaqLqlsuhb45rt/3Z6bEJePRCIchg5o38BnRiiumjzdmg3?=
 =?us-ascii?Q?z9L1hdWzXYE0IipLmKrTFmR0W2GJKkyZOd8wQWhikOqqXabg2YvDQ7Ra/vQ0?=
 =?us-ascii?Q?yCtAIg79vcbSjqcD9j0Ikn4HTyYHT+LJq/r+WYUvVlG6jyANip3ilrX1bThU?=
 =?us-ascii?Q?zsVNm32nuakdukcfShOXqENbXTjzS4yIyAnKXKamOQz7PwGQezXtOZkRQNnV?=
 =?us-ascii?Q?rZ5GVWp3UCKurXUBxzHRDnqMgJxYqOL3morXp8XcOXXaLDFRTeSKWrt/gWKb?=
 =?us-ascii?Q?gTbq9dD9/bvIqrP1xq3n59jK1XgI98qowz3NgItNYviHTl7ZxgjR2cKAbYDa?=
 =?us-ascii?Q?9P4VB7lR5KHb+v/CELsOi52FTJi/IiES3dThv6TBfkbnfnwYuBBc1b0BLHsD?=
 =?us-ascii?Q?pOd6Lx00mnemOiUMHUKza9r6TGZX3Y60bco3RoiNQPwO6Z3MH+RMdPMThVEW?=
 =?us-ascii?Q?hvRqHZG4iJLVilmvCwfJg3h1zSbOxn8Ytc6RDoUCZwMM12MPLvzxZrdWcV3d?=
 =?us-ascii?Q?AWYMKaTth1hCQDHYGQ2vxgG1D0M6131ak/Da/1f1uVniMBKNCj5S1EZDusx8?=
 =?us-ascii?Q?vVdoYGAHuk8hU32orx8yQZAQz0H37OpKysc9ih6Nz7zSQ+9ZXLd1ljY9jGP2?=
 =?us-ascii?Q?skMntkodBziG8XtzilTFLpPAPlpM8/h9mGk2F4wQrYBwnOoIJAGZmnBIpTo1?=
 =?us-ascii?Q?7j2+nnLoqs9w+XHgWuVnPyWEwRyeLmFCQ4zwHLX3peniQ8o1qlY+RVdjQMFl?=
 =?us-ascii?Q?fzW/ubakWGKaXii6FafTyyX7qNsWjr8I53/D/eHYtjb7gl7VsmvIvTs/+pru?=
 =?us-ascii?Q?tqD+KJVm+mcEmcRMZ6pPr9BQy2FMUbosRczkuTY9D2AHkFcmmAfSjro6r9cw?=
 =?us-ascii?Q?VnNjnMqyf7JYfBjMVLQYxUJGHUbV7y6ZlwhaylXPTaInlpogyIlr2CQSkxT1?=
 =?us-ascii?Q?5DGGrJExjk/CvVuWiFH1JW2UgvECZSceCg0OgYR9MW92NnPGZsyfesTFz5IS?=
 =?us-ascii?Q?/Qi8XkpwTse+3NGD4q91KJa29H7omipMpFWVimAgxyiLyfP39rALl2NlPWZC?=
 =?us-ascii?Q?FioyFPGlNfoEFQYNRjV2v2yzMsrV5OD24tafd+ohJAjbHVbRyC7h342JYiZT?=
 =?us-ascii?Q?EoJa1nzsL2lBi8YeKkKIwk6mmpd4CKq8euUBjXcdX8zaYuD5VK5C+TjOkOj0?=
 =?us-ascii?Q?MrbS5O/EvB7I/TCS9ITHDfWq3cf4LHZo8g/WwnysVJZ2aJ+sMDVCNlWiQi7v?=
 =?us-ascii?Q?rd2NeG9+XesocxihvHPp6K2cr0LpHR+SQkr2CWfetk85LVCDWQt5fScbkMB5?=
 =?us-ascii?Q?PHl8BUi4REi9eMGLaMvPz4tCoWoUobjiW0Gp6Ge3iFNJuM6dP2T55WzSGiK1?=
 =?us-ascii?Q?TShTn3BStIkG0MV2CTU//7U5+2vYTncDA4C/TmBQP1751Pm/naHofgaEZCfp?=
 =?us-ascii?Q?D16W0fX2OyQboAtdTTSNkT96SIOjviTf7B5a59gkFnVrDocjY5101qOOMzdS?=
 =?us-ascii?Q?NrS0PWnhZ596MWeK5adbLdmzvGLBZdl2KYmFap0JNrexnnqj+stgcErqN/pV?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88066a0-a9f5-4dc6-733e-08dbaebacac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 09:22:29.1588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70TZqc00GFRNUIsyOCZULmJVBGGYpCJsIhEAYb7B3nXudX/stj7T/oDnLtPiR2ZMVoSV3mVYPNFxPA9S+mUXq76I6OeHoojyTwRq0OKKRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9734
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 09:22:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12984

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 03/20] drm: rcar-du: Add RZ/G2L DSI driver
>=20
> Hi!
>=20
> > commit 7a043f978ed1433bddb088a732e9bb91501ebd76 upstream.
> >
> > This driver supports the MIPI DSI encoder found in the RZ/G2L SoC. It
> > currently supports DSI video mode only.
>=20
> Tiny nits:
>=20
>=20
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
> ...
> > +static int rzg2l_mipi_dsi_start_video(struct rzg2l_mipi_dsi *dsi) {
> > +	u32 vich1set0r;
> > +	u32 status;
> > +	int ret;
> > +
> > +	/* Configuration for Blanking sequence and start video input*/
>=20
> " */".

Agreed, Will fix this.

>=20
> > +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h
> > @@ -0,0 +1,151 @@
> > +/* DPHY Registers */
> > +#define DSIDPHYCTRL0			0x00
> > +#define DSIDPHYCTRL0_CAL_EN_HSRX_OFS	BIT(16)
> > +#define DSIDPHYCTRL0_CMN_MASTER_EN	BIT(8)
> > +#define DSIDPHYCTRL0_RE_VDD_DETVCCQLV18	BIT(2)
> > +#define DSIDPHYCTRL0_EN_LDO1200		BIT(1)
> > +#define DSIDPHYCTRL0_EN_BGR		BIT(0)
> ...
>=20
> > +/* HS Clock Set Register */
> > +#define HSCLKSETR			0x104
> > +#define HSCLKSETR_HSCLKMODE_CONT	(1 << 1)
> > +#define HSCLKSETR_HSCLKMODE_NON_CONT	(0 << 1)
> > +#define HSCLKSETR_HSCLKRUN_HS		(1 << 0)
> > +#define HSCLKSETR_HSCLKRUN_LP		(0 << 0)
>=20
> Mixing of BIT() and << looks kind of strange. Plus (0 << 0) is kind of
> strange way to say 0. Not sure if this is worth fixing, but usually peopl=
e
> would not do special define for "NON_CONT" when it is 0 and they already
> have "CONT" defined.

It is based on Renesas R-Car maintainer's suggestion[1].

[1] https://lore.kernel.org/all/YllPoxf6tAh%2FW+7e@pendragon.ideasonboard.c=
om/

Cheers,
Biju

