Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70DC38142
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 16:27:53 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.215.121])
 by mx.groups.io with SMTP id smtpd.web11.28206.1675268861903941120
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 08:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=J8M0gof8;
 spf=pass (domain: renesas.com, ip: 40.107.215.121, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMVz5lPSBupk6yPPA0Swc9lUygvyZH+SR8rW+fKDp+YQCR2IitDPbYn++Ys4zcO56xv9yw/pRCAVUvRGDCUcrsd9oZE3KpSRN5wOjowERCh77P6EDX83XyWHJqRcW/onlM2fMnaQTmnvlrJ8EHjtOKJm6kdtGYZjV2Lnn3pa9fsixwToSM3Y76WFcBOXG5U+Migd1tyrshy000pD+bPHD60dAwch9R3f5xAzvnbHU9GcuDSMPX7Aof6xtso7VJE+HxFaLLLs9bpSUia45MI+LvcQfwedxl1XXicTur9fgfNfHOFbCBtUTYHPSeVeY2gzFWzP0pHa0hd2Ji2NmZ5wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EixEygGAGmWQvyBR04HVkwsqzAjTlkPu1x9P08rSRW8=;
 b=Fzwuj5BnMKmrwgEJTb0axTEIs/qSZj51RVvK7hxwNb5Kg1Aq7gIGaTcS0+sSrSDKMHApAXMqkmjUUbYKp7F85tD4I7uu6Gh0Grv4NMN5w89oBmkQsYG1ZxFoQwbRkVRMiP2tF4TWTsOxOB7GFLTh7zdqbB4fP0hPmBq0ko40R8h2/72pD59EhE1lZE2RrMV9lR3MCtxg4T7DDeO8qrdKLX3a/HnuvaxOk/zuuzlb361pO7wE7qb+s5tDuvbJC67/UwO/H8+/seSTkbtHjkALIC/e1TE0ga7ZLqzNx0ShJnfbYc/puOUpAW1Gu5iByrDWgnsl2yVyuaB2xw0c73BO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EixEygGAGmWQvyBR04HVkwsqzAjTlkPu1x9P08rSRW8=;
 b=J8M0gof8g8tGcL/fK2K2Y6mUP2II9blZk/SIj34KvHUlo3KpwPBEPtMAtX18AGOml/VWgHVSi3ahMYa+gvLsuLm0XMvwaF3wNinYTKdJHf3PZSw6mIR9Cl6mfsf/FDyd6naCJuJGfz7KH9jIgDtyn16x3lGNokv19tEjxAaHdZQ=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB11448.jpnprd01.prod.outlook.com (2603:1096:400:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 16:27:37 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b%3]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 16:27:37 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"vadym.haidamaka@gmail.com" <vadym.haidamaka@gmail.com>
Subject: RE: [cip-dev] 4.9 SLTS support
Thread-Topic: [cip-dev] 4.9 SLTS support
Thread-Index: AQHZNZ4AVNSlEB5oBUGKFB2AMcfmza65JCcAgAEij0A=
Date: Wed, 1 Feb 2023 16:27:37 +0000
Message-ID: 
 <TYCPR01MB10588D0EFCE97911D45387F55B7D19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: 
 <CAJDaTYk6Q7zVPv6bVicqoXq8v6p0+x17+DiuuR22_OMWn7G1bw@mail.gmail.com>
 <Y9mdWiWsjn9LtqF9@duo.ucw.cz>
In-Reply-To: <Y9mdWiWsjn9LtqF9@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB11448:EE_
x-ms-office365-filtering-correlation-id: d3113c4e-ca06-40a2-c57a-08db04713b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6z9nlwGazFkpTZjubhNB9tyZBVrFxYLeBax4+ubXjnBkcmJFbixxq30f1U653YTuuYmLDnDRR5zAOFVO7YXGjsqwIPhWus4kWruA+uS2zx6kvvxYIM7bjo0y/LeeRz8ze13wJ1PrGwh2ky3TFwT7TDMK6hr+mDQPZY95e1AUBt1CByuaT62ORfeiNZjjYK29wJuGaKOKIdMZKiUvW7nHwRH3e4mHSwklPIx17wc+MXxgr7uzqJaNN3+1Eo0t+usvvbUMejyU9vb5EIaU2cH2RkvL+K/jsYBW9bIGq2ySiogiDfrPDxwOb74tJH00zr2hye7lgtfJ0ozRqreRh4TKJSMxuOJuVFr299wvbKewUlsu7MWxLK+DZqr3VsjpUW6mhnVu0Niet7LXgJeCp7yIbTZpSG2gRajyps84w1STT8vHo7HeU5kw7Ba/pmiPMpWeyGq32F9xoXqAHwvCbxJygaTzbKsDFHKDGOpH8Imwfipr3Jx+boo9cTQZovDHVtJgIvz5lPpL4eaQ2xH5dutzeCbQ7i1NGgiHCfvMFGBehVoFSjkzCHUpc9JEtOZJI9JIgdEHB3om5ZWW+OcnqsBVe2sgL3Dv1kiErQe1CjGfcvlXQVHpkzl+qwAarKPKBDUwII0pTYdNYAFO0x3uNPZvx1djxwl+zRby+3sjHlcPqgLepGinpZKpOeAh8j8T12kKww9OYZLs5tM/CoY8dfk2kw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(9686003)(186003)(76116006)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(110136005)(316002)(6506007)(83380400001)(55016003)(7696005)(26005)(71200400001)(478600001)(33656002)(38070700005)(2906002)(122000001)(5660300002)(8936002)(86362001)(41300700001)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?vcWkfYaSUgTzCsaKg4VSKGV26ZYIrnXBmSd96MKq70QYn9FJxnvakFL9?=
 =?Windows-1252?Q?0Bfh1ceW3mr8H8/z2H9+DyzntqZ13YKOGpyuig7Bjw65D+S9t8rXXPjN?=
 =?Windows-1252?Q?PBgMtcuUU45pL5lwW4z8cCGl9VUqPnl0/pRSEdWSk2pNyO259L9STfb/?=
 =?Windows-1252?Q?1jZtmhnbk2hTTLOXJb7rE0sfN27bUB8sa4IMm+YjMWlwhWk92Ivuw9an?=
 =?Windows-1252?Q?Gou5Xo29TqKlKtWMlHzgkI/54qMTXSSzjr8sEdYQqWLOlUye2AYmI9Fx?=
 =?Windows-1252?Q?9mQiIOflvSjFns1Oga26Z+J/FmNpocSGk1xZLyYkOgTOLjaxvBAAvsUL?=
 =?Windows-1252?Q?NXNQreWQmSdrRxCH93j7a1/wX/gXmpPKopbxtMQ7QjXray3JMwTFVjwC?=
 =?Windows-1252?Q?YSvn4mrb4qm3w3KRj/hitWgeuECOZ2+vCw7jeRAbSZkKwEu6DMVnImWj?=
 =?Windows-1252?Q?sGCbhl7Uf1OXnF5Uw9hFj17oZk9Ct2IQnS/6v8swx4pTd6ftgKWD7EXB?=
 =?Windows-1252?Q?8wGH8ACNGGxS8BW1T1Q7mEMn+I6U8LAhjm1mlNftzaHDrnfOjn4RrBOA?=
 =?Windows-1252?Q?jAHUMLmpPE39badZaLK7f315W3Pu8FgidWxpeKQYvOnkdsDGyXyvF0rW?=
 =?Windows-1252?Q?XhYizSH8OEC+mvsfYISmiuuIbNcVfQej2RCCpuFGt3gXjVFLsE6TSgcE?=
 =?Windows-1252?Q?78hH8tpCeX1AsnJ1RcGfTEjkcvuWUYyFGWrsbNqtXsQOu3F5BVB1kFKC?=
 =?Windows-1252?Q?y0n7XmjANclo3iTBvUvgVcrdPJ1ksawf5DlH55WCAtNVXqbo4JNHWdm0?=
 =?Windows-1252?Q?5XOxHuybzFuC5/HGNI17Xfui1YwH1/iUqHJNuv8dlYsxfDgth5j6f5TY?=
 =?Windows-1252?Q?c0w1Y7ffs3nmnsC7mEow3QTRuqUFooWpWq6FdvuUzqZoKiZ9jig1XKPf?=
 =?Windows-1252?Q?tsEBgXUUiVPKt2cL66Sm7yyCMJScHCqnmHt7OPPgjNJndlW6/DiKMx4F?=
 =?Windows-1252?Q?TpXd26Hz2JgH1NqUE4WvWUp7igsaQd40JUcjl08kb5Bz7oQ7ugpny2jS?=
 =?Windows-1252?Q?/ninLIxTigfWAO1hb+AfpvyJNrk01aOQyKgZxajacHQIdhUh6i3OiVtx?=
 =?Windows-1252?Q?IEn44VFUicm0yj7wxsPBpUPC2MJTM1zJK1veI0pn3WGCSV1RxJ8EVA5U?=
 =?Windows-1252?Q?ezvKq43F8+BJ5ewitFaAPLeCp/E/M9ivndL9gRV5G4dY8w0Cw/qbUlxc?=
 =?Windows-1252?Q?wjCxtt8OeCcuFvOUqN25KeGnB/XVPj/GGg4g7JAiVpu5Ti9y8UdhvAT2?=
 =?Windows-1252?Q?/UJ/RsSZ30U2bbxYNx6qK9k/Hcvbl9WN6YidHsWluihxT3jLCftEy3On?=
 =?Windows-1252?Q?iK9GzzaDB0p02FukesKYKc+tnFgPfYkTTrl5/TeI5jcsC+AJr40dcaRY?=
 =?Windows-1252?Q?CesAykCksI4JVzvD2Uqh51fnxjGPBZQ8qmPxL8VOvNJ9xIoV+YImAlEi?=
 =?Windows-1252?Q?Kpz7GIWx2zkUg4tW5dBtfjaXu9fv/clXk3oI51ypoq48B3x7wTuojyeA?=
 =?Windows-1252?Q?HP7m5KbUw/e1Xj04S/vq3UxH9s+aUgvUJtR7jZzeth+q3F7mxd/d9FsN?=
 =?Windows-1252?Q?570XlLNlaGHhP7hDCJAgwj1MVLwKKSlbsVXRRA0vhYWXNnNXQbqoGVub?=
 =?Windows-1252?Q?8Al6bp0Yyrnjy6W8AzLgjdkBc+GHCANIsfZg5XeI1FESnXmT38PgcQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3113c4e-ca06-40a2-c57a-08db04713b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 16:27:37.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRSmQRxzbgvopB5mrvo1ZYzkgEIjXoyQYnUWc+OH+Cea9D9Y/ciuC2wSUg6HllH48ziB2xYKjXZH0nQSZk5TaEEc6ZVUJTBiBoFAGls58pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11448
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 16:27:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10563

Hello Vadym,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 31 January 2023 23:00
>=20
> Hi!
>=20
> > Would Linux kernel 4.9 be supported by the CIP project as a next SLTS
> > version?

If you have time I'd be interested to hear more about your use case for con=
tinuing to use v4.9.

>=20
> There are no plans to do that.

Just to expand upon this a bit...
The only real restriction on the number of SLTS kernels that CIP manages is=
 resources.
The project's resources come from it's member companies.
The more companies that join, the more SLTS kernels we'd be able to support=
 :D

I'm not saying that CIP would start supporting v4.9 specifically with more =
members,
but if CIP had lots of resources it would certainly make it easier to conve=
rt every LTS kernel into a SLTS kernel in future.

>=20
> 4.4 and 4.19 will be supported for a while by CIP project.

And 5.10 :)
Essentially every-other LTS kernel since v4.4.

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

