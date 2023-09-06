Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C78EB8FAD
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:24:00 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.118])
 by mx.groups.io with SMTP id smtpd.web10.3881.1693988632359654947
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:23:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=oJfcEQRZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.118, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvDohnVvGZcRbBwDqbLNEnGgK4YTf75QoyfKI6ru15N+Onp14NmBE4NpkZMOIcytam1m+SARK1WUpSmD7Ru+dphvkEvNlJgiVFVPJz35iyA6vGNkz1zeRADlYrlTrzEg2C1jeKSICaR0+rfltyL3LJFhWGhWRvGMxBU3SUmkYSj9eqYWmzr5LeLUS9ZPQqpQppz6dWiha+L5xSsNdKjUcXmtSQXu6wnA71ATyWPgD1pnPrRUV5/mc0mhSyYpyEd9EmrkuSs3YbRs7t1bxF7Rimy3P0y1xJboZ5DvB6R1FFkNxFbyaaBI150Ymy+L6aK93ETG78FmS//RFbC7mfMGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSjICljl4C+kIUz+sB7JrV/B7/7c+CzwJTvRCz2wmLw=;
 b=mYINgLYui6uUT5doChPlu/VjoG8fdBDldraNUmvb49PrnckO46VB50A9UejrG6mcY6hVBe3lWswbCcP0KbG4QqlktDdiUXyL/AnBuFDoOsXFRKE/PXrEkCi8EQAAhRL82bG/v6O4XBP+3UZc6Iz0ATJyj9NnsZecZvqSd579+EEI3A/ivJudus9BPEAIb45sZPbxr1wQsmCeBI1HjEKGt+3AarXwcjCR8ntrzMa+7+7NZdvvbkKetYw47R3tbbd79OYGoi7v3arNGDWkD9ARIT66FzDhAa9ANYmRAo3+rD9RQoN3lUkX9X+/ZYlticEbjW/XlVFLmufq2KTSXr8LDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSjICljl4C+kIUz+sB7JrV/B7/7c+CzwJTvRCz2wmLw=;
 b=oJfcEQRZmca7a8ZdzHtOGtzvYS7fWWQRz5QIP13EJyk6JNnMqeFR3lcS5f0OyieIouXt5rUEx5lbL8VMIpPtdbfbdAc2Ef08R2OV0OY3YVjrklRWRlAqfm4IFLZ3Wd/haGPsAIgAI9/4d+Yt2IDO1zER+jM9mYO4zG4flDSWXeQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8083.jpnprd01.prod.outlook.com (2603:1096:604:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:23:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:23:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 13/20] arm64: dts: renesas: rzg2lc-smarc: Link
 DSI with ADV7535
Thread-Topic: [PATCH 6.1.y-cip 13/20] arm64: dts: renesas: rzg2lc-smarc: Link
 DSI with ADV7535
Thread-Index: AQHZ4BMsTwK4vPeDFUaceS/LpC09vrANdTQAgAAAlTA=
Date: Wed, 6 Sep 2023 08:23:47 +0000
Message-ID: 
 <OS0PR01MB59223C359282423434BAD79D86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-14-biju.das.jz@bp.renesas.com>
 <ZPg1xFmaspa3vHKU@duo.ucw.cz>
In-Reply-To: <ZPg1xFmaspa3vHKU@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8083:EE_
x-ms-office365-filtering-correlation-id: ffda2c27-c4d0-4b95-30fc-08dbaeb29790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UpmX+qKAhAa4HuslISeuxhL4sn/fG0GVKshEHMozDFzaiS/fLYevA2baBlidwv5f25F5fGgJIN6Pho515IYAkBTyr/elVwahlu8xg9eFauEEkmtkMvO05GPHEUg+6CA2zTNAUbO0D8dID1gBIUqGSOvpMIZMIsA3aHkFlnKeICRNHJBtrirmXd1xL3gqCNoxk3ym4o7F0EcJNlys1UZOVmJRbClzC1RDp3KFq+YbjltiAv8e55XFKGYT8mtRplbGrsZqni+3UQyRbCuG6EzbZ+N99AYTRlD6YxECZaSrmJV/n3t6N+lmOGnh4cTAdVrUeLIGWKOUxLXbfh0Mjf59R3iTqcQ/RXbNnAHj8fSfwmw492sQ5WAbb0PP7rPtWKlC0JbubdA0kX/PzD6RGC9ywwRsg4V0gEFA3kNGsJJyNb71rw+ZE3RajhzttQir+CKB/xakB6UuDkWOboXMMHk1lqLgUyCzHP2dunoI0AjYMcB0P8IG2Ecc4Betr2qYmk+MK9YPeK3ITfoy9UJA5IZdCnzgtqgJYLtcWH9Qq55usyRZk8cd4H5jzLhuJX0aJl0Bcaa2SCd+7066Y/Lg+cmFV3GAnQAOPSOCSwozuyQ0Uy0Gb/DL2R56kSXdegXtPZfR
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199024)(1800799009)(186009)(33656002)(38100700002)(86362001)(38070700005)(55016003)(6506007)(64756008)(478600001)(71200400001)(26005)(107886003)(52536014)(5660300002)(316002)(7696005)(6916009)(122000001)(66946007)(76116006)(66556008)(66446008)(66476007)(8936002)(41300700001)(9686003)(4326008)(8676002)(54906003)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kzaH3V2+poV9ER0b5VQ8RXjoa5zEoP6VFBk8CbDjiI4U/SQ1HOELgTb0XG6L?=
 =?us-ascii?Q?stUDCEUD91DyfyaN2FAFN31hwpHJn/KD7YWY9DjFQRNDzdS+0BSavlg7CN9P?=
 =?us-ascii?Q?sPs3THvJJOkq2TCgZWlmkjYfjY/xYxWpbuufnK827iDdll6pNyAOl00KiNlH?=
 =?us-ascii?Q?y4Jk0RtKXMOEVx2fBsp6Cehcd9Qe8x2AomRFfS5LTeaowikte1cgeP0D3MUu?=
 =?us-ascii?Q?NknP50B/DGSP6fZToSQHyZWDW02LOSP5oNFzNuZttR37PPV83QTNaTi9NKX6?=
 =?us-ascii?Q?J55/FTyx62QRxKD+D7xtjlOzl+uEqa+dmFC1EPQyLVT5xYKjK1dGtBYSLanV?=
 =?us-ascii?Q?tux6zvhvvGpH2Gt3BaV6jfP4Mosvpl9NusLHcjeI28M/FaIR5CpChV3NGgh9?=
 =?us-ascii?Q?576PaA7PZ+uJwA7Z0H4pU5J/0V/qMXyX2pp8BX7+5vK8bRaeV67F/zchxl+U?=
 =?us-ascii?Q?Z5GHdAOigllQ60La1qy8V9Fpr1WEe6e71gY8jk9QYXld8XTOnsTwvHFYIu+/?=
 =?us-ascii?Q?RHiCpCNARhEBNH9zApI3kUMiK/ngry1EoO8eRwcOgGQnWMjQqAfUD8hDaPIl?=
 =?us-ascii?Q?rwdFk6FmJCGYQR8IPQKYVtjhGfAHBbI0wdzL5WzboZB+Vkj6SUpteI53to0m?=
 =?us-ascii?Q?uDt9mx8cGQUL7rUHAjOTG2qQmkdfyDBjFzOgLHIIl0ZHW735xPIoRBKDzZLy?=
 =?us-ascii?Q?YDn8sqHhDre+9LQDoyi2uHR8ePv0dJ5Uz1sevFZt1C4JLA6mJf9ekGOQTz2q?=
 =?us-ascii?Q?tnLro2dFq1YMEZZVD9iEabAafEO+1BAZ9qPOA0jCCm8bKSl7kL8Nff20/izK?=
 =?us-ascii?Q?mUomATp+u9AsX8LwvTG/owUS4nERhk/5QgxrPR9SXoJIsKEsekoXexQHGhyI?=
 =?us-ascii?Q?9PNiIaFPcCInSJptOg2IyJgDStugQYtGp04RvM+o4FueD+tBdOcW58J2xDMK?=
 =?us-ascii?Q?hZSp8ZiF8RJGjzlNtzMws2Wflf+ar7Lyg6wpr07j1UdrM+DIMwWaqEIfn6Cx?=
 =?us-ascii?Q?R0riUjJ0aOLlpFYdOP2qcNB5sSTOsg0wLnwSqmmkzZm3pGJDvi7UAZVEZdO8?=
 =?us-ascii?Q?YvmnBAF8h9+g+pBvQRf1DFDBcPA92++NGjzGNpXtO2dI7g4vg71hm++jLsXp?=
 =?us-ascii?Q?/x1ze0rlZM7aVXUUj9Y2mC2/wIgu2j1WEq7+CaVOMBoFOGhJKYPb/w/TpsZH?=
 =?us-ascii?Q?jtIuDzSQpUfyKK33vnimChRWP94i4lp8QUDNW/A6Y9b6/07XGpJxKbu5gT5L?=
 =?us-ascii?Q?zsRuaaWyL04w4H4ao7gQBuQ+ImyIRYJdnu2hm/FTsJhT2lIl892y0wGLNR2G?=
 =?us-ascii?Q?QHr+RwsrwuXXYI8VF0NmCDnArTX/k5UUj8fBpQ0F6n9/PYm8dr1RRbIuHeKV?=
 =?us-ascii?Q?owrdbWGTzcVivzEfXtEai0gnZJOhlWR1xFIheMpEnG/QB+2UwsVs3Hn4KkF+?=
 =?us-ascii?Q?76Bjq55GyA3wM/mqK6mcZOBgtcuDcdB1jfwDu2/ngr7KZXktC/ap4TECGRD2?=
 =?us-ascii?Q?X3aNc9lXhrZ64qp26kdYHkF/0QXSLA9HX+F9KwAsC5uuQgeL6VhZhJZAotli?=
 =?us-ascii?Q?NGnRekuZNI2Gg9iYZTwNT0K44f0F9zqNLiblIfN5GjqaobAX7sj7rSZBSnWQ?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffda2c27-c4d0-4b95-30fc-08dbaeb29790
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 08:23:47.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OA80ix86AdKJwrlKo5JjuDdaJ2SjZktrS8Lb7nVm6vkXqDG5eRjpBsC4/7k0tj7bAxEYrDuata0TsWRntEu7UPOcJ+yHoa/4qV30Hd9+Qkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12978

Hi Pavel Machek,

> Subject: Re: [PATCH 6.1.y-cip 13/20] arm64: dts: renesas: rzg2lc-smarc:
> Link DSI with ADV7535
>=20
> Hi!
>=20
> > commit 961eed28296853a81d792654f392773800df91db upstream.
> >
> > Enable DSI and ADV7535 and link DSI with ADV7535 on RZ/G2LC SMARC EVK.
>=20
> There seems to be a bit of duplication between different dts fragments.
> Would it make sense to put common parts into dtsi somewhere?

I cannot put to common file for RZ/{G2L,G2LC,G2UL,V2L} as
RZ/G2UL uses DPI compared to DSI.

Currently RZ/G2L and RZ/V2L share the common dtb as it has both DSI/DPI int=
erface.

RZ/G2LC has only DSI interface.
RZ/G2UL has only DPI interface.

Cheers,
Biju

