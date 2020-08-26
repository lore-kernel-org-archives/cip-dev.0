Return-Path: <SRS0=A8cy=CE=lists.cip-project.org=bounce+64572+5258+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB317C433F4
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5AD2087C
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gCMNlrv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5AD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5258+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3eCqYY4521723xJBLPez5rm8; Wed, 26 Aug 2020 04:35:17 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.107])
 by mx.groups.io with SMTP id smtpd.web11.7799.1598427649415184596
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 00:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYiZ+tkvZDcEiI3tBHY7y++/CX3XP8QcqbkxY0Jb8Pzu27uz2iVFp0bMG3EbWWHJ90yHe+jt8/F+PfLz19lhPlt9Var2aSFX14Ijy98L97p0gsSLwQS6biWxHBZ+vxMA/sxF2aiyHOHmjHvwgzMVkNEjlCHqFNIzWCxxuhN5K9tOkIhuOWbVvWpn/6ff4o14LW6OTAjhI/0jy06blKRbU8A+GTWBELZmCuyQKphgORC0vKpsX7EfxuzyCiRhzCsceGXLcxqp7p5eLgECBGVaBmWd1ww647nRXFU1nvBG2M37o/kKtM9oHdZfpMM6YBgnAd/jSXKbbRM1zMnijiYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75txI/tjBuIeTdKtaG59heI6XKNf7z6zPN8uKb54zY4=;
 b=QNvoqCtl8DDNcori22OdoqNsbnjRopp82Rg0+5ReXK1nHdEwrWbemHfb77ClPSctcLicW2MKmq+IzT97pX+wZC14t35HACjOKg2pZpHnems9+cAV02zPJwk9JZU+1s0F3YLZi621caPpFtyzSg8WF/nk4NkZu1ID1fPZR3MudJ5HFqgpvYqIKwkBMl8bH41EmpxcgcqYiOaMKc06L6gPClpgS97jVHP37f+SH159juevxIr7CFhjcsTF/jKoJTOmfSEiOJM12I5QeL0lRmWSExGWMtGHlezSDww6bDvtf5K1eIH1PppTentDSj+tsMUebOux+LYKtt3AJNRv3wJt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB3663.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 07:40:46 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 07:40:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Niklas <niklas.soderlund@ragnatech.se>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove temperature bound
Thread-Topic: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove
 temperature bound
Thread-Index: AQHWeuK6XTx19eY46EuanJGrB82pyKlJ/UYAgAADzAA=
Date: Wed, 26 Aug 2020 07:40:46 +0000
Message-ID: 
 <TYBPR01MB5309A40EDFAF9156799B296886540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
 <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
 <20200826072132.GA7244@amd>
In-Reply-To: <20200826072132.GA7244@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c053795c-6961-4dbb-90f0-08d849935845
x-ms-traffictypediagnostic: TYAPR01MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB36633002112B16E89E9654F886540@TYAPR01MB3663.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 u1LiWm+eGZR2oxL1czSRDxDa0j6v3FNwi4RoHP9RfSFaMO/+bd6XEoCIYNzG7YzVwFiqGGW5ZFPERJ4NbG+M8HM7RyjhEX6wgBADg3ino1EBXGbyVzySHqjdRw5Anjtv1RWj4Fil6sHv71fyLNItFzsqjW2czKenYhzpPQ2VHl5bcxJS+zkrJE/2pM/JRXqC33mEnaFUkKstAqEy1pPk3UcThMgCTFr4XwVdV3pyY2HJW1/UC9ZcNuKJQ13sYKrRk4ljVfd1r6Q5gGEqHI6mqBKX8yX2yZXoUi9W3Al2W+L6K4x4goJKULANVBPhdNbExCj4Nez1YCKPw+nzt2b2TQ==
x-ms-exchange-antispam-messagedata: 
 5yv+HSxzsUUJEUGNhSqSUIAcd/EO59os7QPF3pxP5y+dNN8znmojfO/bxFzWfCDEwHmYORNoKUWBd3Mg6LI6Xa5risdPRqIFt+dZOuHZz/cq19oMd7741ecRRIkubH08oHfNvSKY9Czc5zeKRGjH5Qb1NqgK7GNfbhombuYdzDOVjAGAAM4IAAfwvWZvl9r+Zy8LbJWva6E6Ye3YtxWefsvAQf4LINsaHwkX1YBrUR8NL0ORmjp7LUr+nF1Jh7WBN0QKJuaHB0tQfPXgRqro3GWXk2lAEvsE6Kt1jv2Ap5heyrNTfVAAAYVEQkhGEIMqFs8/hHBgt1N8dQ4hAvNWaCDOyown/hrqhFhZl60xDMb7hu552Co5adqchbNe18v72u04N4N7v5t0RNUq6ih8ZE5KXo4RlkPv3qHaNKEpkwZeM/hmiEw9QATVZ0riEejYl+YD0alB2VKmQeIzeq9y1aXJhnXuXSHpC2Q6+JVJzpTuolzza0GWNu8pyvSKqEyB7dE8fw4dRwbjrfKYpq8D3NNLSDXANNkKW21Ra1RrjJNzvAEDo1YAvsHghrmWlCqUtY567a6Ky60cmTE51zxJc3Lh+b2lvaty9kO1D5iyzLIswKvVD7PqzudLHakvx4meNOzCL9DJy5S0plGyRCnRog==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c053795c-6961-4dbb-90f0-08d849935845
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 07:40:46.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56wp8EvS3b1XVqbUPQzEsMJbLMuwTooU4pR10TrwELVMnTsdmtN3thkuGmsSTfKNNE8s4igIoGp72+j6wlovBnhOVYxmSNoc8+3VK+OAf8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3663
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Kb8KI3hu5SsiHTC3fm78PHj0x4520388AA=
Content-Type: multipart/mixed; boundary="P6BTxNz3zKpgb4riomXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441717;
 bh=irMq1mKjuuDBLzvGszrY/PxW9C07fuyorYnVWwEU3io=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gCMNlrv4MmZEHU5uJ8/c0AXiX1+p1KgOzZawZhEj85g4Z7Z6LWjoBbok4xvsDg2Dp/N
 220MIyhp9f3BKkJs0TqMGc/jHzzz5NeO/gLx0zHUXWvnI83RePXns6ziZyceAjBqn7hnB
 Y4fyXPRJ4hqfdSas3M7MgD7k4O7kKcx3zKY=

--P6BTxNz3zKpgb4riomXw
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove
> temperature bound
>
> On Tue 2020-08-25 14:21:48, Biju Das wrote:
> > From: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > commit 0f510a2457cbbba18a98492bab1bf540be57ebd1 upstream.
> >
> > The hardware manual states that the operation of the sensor is not
> > guaranteed with temperatures above 125=B0C, not that the readings are
> > invalid. Remove the bound check and try to deliver temperature
> > readings even if we are outside the guaranteed operation range.
>
> I'm tempted to ask "how was this tested?" :-).
>
> Sometimes sensors have glitches producing very high values in normal
> temperatures, and it such case clamping can be useful, but I'll assume yo=
ur
> sensor works ok.

Niklas,  Can you please clarify?

Cheers,
Biju



>
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void
> *devdata, int *temp)
> >  tsc->coef.a2);
> >  mcelsius =3D FIXPT_TO_MCELSIUS(val);
> >
> > -/* Make sure we are inside specifications */
> > -if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
> > -return -EIO;
> > +/* Guaranteed operating range is -40C to 125C. */
> >
> >  /* Round value to device granularity setting */
> >  *temp =3D rcar_gen3_thermal_round(mcelsius);
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--P6BTxNz3zKpgb4riomXw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5258): https://lists.cip-project.org/g/cip-dev/message=
/5258
Mute This Topic: https://lists.cip-project.org/mt/76406706/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--P6BTxNz3zKpgb4riomXw--
