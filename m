Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBFCA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 13:08:42 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.web10.8955.1755781719471837295
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 06:08:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=by+S6Chn;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpCRnqWBlAz7XFnLCzEFQHlJraI1JI2PgY+I2NwnZZHJlMc/uc5FgHzSKSHn2TFZ/UlETHSs+FT3cjkQawOqqOHEEoQuL1z/ou9QzLd7z6hnseiz9TmtPg6T53APmj2ltX68KXvmCNBUbKNo30yx7qT83l1IRdpOXE8rQSwrtVMgvU13sZoDnkvjb8YhnUEL/dX8WpQUnhnykdxXdVkW/x2YipylO3VuXKEyiusA10wcVsnDIbJy3rISWFWldHSPezZv5YH0vrFFtr1EKruWmYZQI4HRmoX01T3KZ2MpOBvm092QQxtPmYNfx286JLrlPlYV7e3wnJ+Df8F4OG3p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXo6mvK7sG9h8QqTknYwVKeGOkgI0z8qhVdv3JRTy00=;
 b=adSfiXv2Gh5I6g/5OYP7YU2BmHADS99P+5mBsG7Mp3lvaukOzFCQonLNx8f5w6k/zQTt8hMEY9fim/NtuY7+nUGIDu1ze9sHUIjFBjUGSAngrAx+7EHa5YkcsRcMAdPyRJ1WLAiAnYDPygb1HFPFwc37xdhKei1SwY/gqwzwu3rOD2V17FT2iwt6f5srtaT+RYSU2KGM9EHrBKXaFezvZxf694TgrxQB84EhJ++qkndHG30mOiPLt3AdGEmwWsZ3XneS0t7tUelT5WURF6DNwguS0B3jDpjA/nDPtKrGuN+l4FgRmACX9xE9nNhHexY7oF4FwbbC1/1pKKZmefkMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXo6mvK7sG9h8QqTknYwVKeGOkgI0z8qhVdv3JRTy00=;
 b=by+S6Chn13f2wYLSuHM1gwN7cCjqnME+yAShXO2uWzJCbZn5EzoUWSp+7lSPnBlEMO0EoeZ7xQhvDWqRDO7WAou4iP5VXgbncqFnka4LACSApYeJA+t3elttOPOBQFJyF420MDOp88isJgceh0x2NxgonSDHG8tKTSmhcAjuT0g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13231.jpnprd01.prod.outlook.com (2603:1096:604:34e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 13:08:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 13:08:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add
 RZ/G3E xSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add
 RZ/G3E xSPI support
Thread-Index: AQHcEa8T4LeK6itfoU2U89T5+h/5Z7Rs+COAgAAdaaA=
Date: Thu, 21 Aug 2025 13:08:33 +0000
Message-ID: 
 <TY3PR01MB11346EFFD9F8914171836AC9D8632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
 <20250820084645.6988-19-biju.das.jz@bp.renesas.com>
 <aKcBPxrTxnIw8BgT@duo.ucw.cz>
In-Reply-To: <aKcBPxrTxnIw8BgT@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13231:EE_
x-ms-office365-filtering-correlation-id: 9c2679d1-0a44-450c-6d73-08dde0b3d521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Pk05m+GVEkwuNnsnJDNLs7rsQVon2N8BTTZ1QnQCc+XNHwQcORtI9181+i/M?=
 =?us-ascii?Q?OgN9qiuh+y2shviKCeF/Yyebb9K+2RfhBvxkGI+ZUBnhnOcrlCwqMv40Fx3B?=
 =?us-ascii?Q?AoxOAerc2v/rnE0Rled4rJmJrMzL6ow6gf7cPPAuC/6jx1x3lQ4pi2RZeaco?=
 =?us-ascii?Q?gFNHVDnsyItzqvTRhn/eRD1PXKB+ZJ/pfV/HLh/pFFzFbx60EIN9VlKdvfEf?=
 =?us-ascii?Q?FzAjTGLna03VZrf2tLWqdTVhg79TmzP69cLrMbFoBDR0xficrQN1uzUMfaqW?=
 =?us-ascii?Q?ndZP7FEHzfBGbcHG1EIdMyMGZP+tJSTNL+3E4vv61zXDnqlsgLZQWsOBz9ZN?=
 =?us-ascii?Q?d98R1Uv0VFw3y8StJs5Qpx/byJ84Qmzt5nQpXKP/9m+8Bw+3JEoogqMmJH/U?=
 =?us-ascii?Q?pSx7BMvijsAtXvDXcrNWUKvqxhbmzUkawiM5v4hIbRfThve6hyCWG1Gg9IxN?=
 =?us-ascii?Q?dCj3wB9JGhdDBS5Q9F2YhJNff4SxgZc7wjGn8JrRVNDrAY1Gzm0c/zBqq0NI?=
 =?us-ascii?Q?ZXpI2xMN+Lw02Hs8qr010hSZ0CWT0Dvp7XtScpvmjRXQSJEhERMStojtje94?=
 =?us-ascii?Q?3P5HH5qyKQ+LdoNM1oLEJisVjhC4emYesJhO3/3f+4KuBu/DK/FExekioR8V?=
 =?us-ascii?Q?35nSTpXtoFO3y5JN3vQdP+VVseHufFO+DXEIp7u0vWN3f2xGCkrwemfB9ulg?=
 =?us-ascii?Q?OpbfwHO28VSz40H0EVNTGW6e+Vt8gRVxHTolv3e5JteLG5ofrUSc3gP7fdwB?=
 =?us-ascii?Q?jp+Ot8URAD8l9OEuLoo/fTvpxfpLbBGU7W1b0sP26oX97ETdzss6batq2JaR?=
 =?us-ascii?Q?1Je1r8uaRfP0++KlP1GAXJmmBpm18B++oNjeZifTJ4RRRq5DfDg+vovcTdoD?=
 =?us-ascii?Q?FnEvIXnfXlo0vxg8FHXaPGZFFW1nkCzAI5AzH03EiuWH//vaF3x+oOD0u2JW?=
 =?us-ascii?Q?wAxGMc7j21Sj416sGF3gNvhEYycxmS94fOBRY7e3qgMbC+GaR3GkCvx/eX8F?=
 =?us-ascii?Q?NLT6Uq0l4WDtNIFUaE9qZ3G2bynjhKGPE48p+0uwDMSL/OXogmpt8Fgg7HUu?=
 =?us-ascii?Q?3oG9gUMxhjIWVsnjkAyrCpvhqOv5lvmj+gvUnDJJk5z3kfTW5nPY07rRmaS+?=
 =?us-ascii?Q?TTdTJ6uU/6SnsnWxYBaxlHN1cML56Uior2N7zkDU/CmfCAxk53JosAu9abfo?=
 =?us-ascii?Q?G1duv9t7n8czaf3VvLtrsYjYlKIX1Bayo5uI/Mw5lpveywMU62KkMjqF4Pv9?=
 =?us-ascii?Q?lQ5i3TPB+PAeArZSel9yQ2Q1+/djN/t5/EmWaVnZpxXJ5qi63wqsrCAIzSEe?=
 =?us-ascii?Q?tboWGGgHVIjMaIJ1OQUoxY7It0wPX03NbrgQfnv2d4FUeP2s99q7ifLpMjvh?=
 =?us-ascii?Q?/PMbRfkrMv38W0tOuvEgejoeVZ3NcwfOlDJxfOkQRnK0OdR880+9E/CKBzuh?=
 =?us-ascii?Q?xXgzqHmvxqi8M8Hqq6mqwciUP2rZI7sDKj6G9pXtpjshNYxJ2m78V3H7AYds?=
 =?us-ascii?Q?5v6cI4QF2BSX+gI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GrpoUdxaAm5yWkU9+IqYSbxn5dPp19G0tuf9kwDgsirMVyTpYoz1iQDx5cgz?=
 =?us-ascii?Q?8qLuvrH7e6yPS0Vy1GJoKXZ6O97UefNN6OiFSMl0UMy9aingq+qH7JzFkdO2?=
 =?us-ascii?Q?fzWSXM+BkBfp2JypKXrMoibGnxlo50p5CWJUyR3kwdKwni0zWTV6FeTZgSqf?=
 =?us-ascii?Q?9iVDnUvlmdvhkCOc0V8MudHeJ9MY2fVQw2WIAuPV7lhBIXLZU2nuJXOJ2MRo?=
 =?us-ascii?Q?t8HZ9TziTnPbUrjfHFYd7TfbvAWUbM35g/xqYuedcvBOy7qQkapTINrlY8Jm?=
 =?us-ascii?Q?7VzbvYBYBfylcBA/aalMITpKPJ/W0iIbei+jVYVQfbVxPscnXHPrBgZTRwZf?=
 =?us-ascii?Q?uVFzOAU6kGJ3449TxjhybkvJEj8OCg3Z7UQx6wBfHNOlAxviUooMA5hJmJkS?=
 =?us-ascii?Q?wsb/c7pEeOFOZZn4fBRWK8p3prPFJQBzIAl95bKm/PEDHCoujzzFxYsawZVE?=
 =?us-ascii?Q?mfSFoG99LQDvwl9HKpLEPMhxnzuS63N0PUnz/jZgLZ3LLRoDS6XhBH+Z87Yt?=
 =?us-ascii?Q?Z7YNZTY453qAk7TI2ewvqZ11p7D4JtX4OS6FihSi4T20mJPR0+FfoIInjDHG?=
 =?us-ascii?Q?lH+FyiZGKwnTjDFIZdrIhaN8MgJ6slI/mdvOlvk1GyFch2r9iKDNzMnBKu18?=
 =?us-ascii?Q?ZjDpfJ9saAcyucITxIb2Zb/8MLBcyj6WMMIxCFwRj0HUJq0U1agwkwQw+YxM?=
 =?us-ascii?Q?0NtcHwwJIvpIepH33Q6XMBm8PQEo575bRVh0q3RWKtoeK0WgrPXncKXGcv1P?=
 =?us-ascii?Q?PDIYTGWCtqkMpl2vlHAN7umviToQjMrAAvuX3JTso6RX5Q1SOeVwBZ6Bbimk?=
 =?us-ascii?Q?rDXf+9YRHqDUxflDd6Xhx/HCFOxMLJWPholkRKQZcMm7JFjPAVzGEN1TQTD8?=
 =?us-ascii?Q?TrRfnq23GiopmFkjWwlstbiuxpCJDpMYnUY7iq6oVKQyuorAFqq5xWgH18+f?=
 =?us-ascii?Q?o3KBIDclTBzhKE3LdWR7uPJTq1L8DRbAkOa1Pi+kLdAshyL4qMhlsrmoo6NN?=
 =?us-ascii?Q?GNdI3py6c2n8SftqaqHMvYD60liVlaaMxkjtkU1nSqVofqBWi0lS0tSjihXU?=
 =?us-ascii?Q?nNGVLfS9Nst77VJel7R+NAD79ofbXjbv/Ydv2f5HX72jacgN4i8Qj4ylt9qJ?=
 =?us-ascii?Q?2Ac9bfs3yqqyjnHzq30/VY7hwDkQQ9srVx3hyLOJyRrherpX9hwAIV6zuYsb?=
 =?us-ascii?Q?obqD1Xluh8hAowZWnS+AQZN10nR94KcfqCtGIkO5ycEx7PIfYO0wkXaI4K4y?=
 =?us-ascii?Q?zw6BZsP3BNXlsZXuwiE6qVv2eLfRAnwjmApvASwWP8BHLDHfFKE5COFUJy+W?=
 =?us-ascii?Q?15YfoWUhcIw58FIZC64xHI/WVppzjjKjh0zFKrpUNBmHPiuqnFhSemar5Lj7?=
 =?us-ascii?Q?L1t++akzHRXjsWLDjdKLMO8xte6i91Mbg2OKiDYJBD1MWOLVDr2W3MjFP9Sf?=
 =?us-ascii?Q?IXmrIYcapU+UQb5HnvFzNPFwCoQHlbKekdIT0IGwu0MK6dH+qKIPs+2UkSF7?=
 =?us-ascii?Q?nirf/t0hW7YrwE7vGuq7xPD3690XNi7zIWS0G3aWjwr4IvPGQNSVRbPFwn58?=
 =?us-ascii?Q?B+VIanYfDmjFxM7nU3T8yV6+DEU1nB4gFLyPlcAX1syIjH5z0vV8VMEexeC0?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2679d1-0a44-450c-6d73-08dde0b3d521
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 13:08:33.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH43Ee6jqpQDcwZy0GRsqlGk/FXZRVsmX5l9GsV/Ye29kDVPHihBosBodPKkJAChSRUn+7QYt3nEtWR2KSb2Cnm9Gw2+RrZCDoYEKu3wGJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13231
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 13:08:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19935

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: A=
dd RZ/G3E xSPI support
>=20
> Hi!
>=20
> > commit 687cac9559d8e9277830bdfb68b57d7403695b1d upstream.
> >
> > Add support for RZ/G3E xSPI. Compared to RPC-IF, it can support writes
> > on memory-mapped area. Introduce struct rpcif_impl for holding the
> > function pointers and data to handle the differences between xspi and
> > rpc-if interface.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://lore.kernel.org/r/20250424090000.136804-7-biju.das.jz@bp.renes
> > as.com
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > [Biju: Squashed the commit 798dc3f19c9e
> > ("memory: renesas-rpc-if: Add missing static keyword")]
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> >  #symbol 'rpcif_impl' was not declared. Should it be static?
> >  #symbol 'xspi_impl' was not declared. Should it be static?
>=20
> Not sure where these #symbol.. comments come from. They should not be her=
e.

I agree. It is a mistake from my side while squashing the patches at last m=
inute.

Do you want me to send a patch for fixing this or you can take care while a=
pplying.

Please let me know.

Cheers,
Biju

