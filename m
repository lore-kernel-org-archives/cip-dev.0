Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D7F4369B
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 12:57:11 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44324.1776430624112703776
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Apr 2026 05:57:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iUwitnxk;
 spf=pass (domain: renesas.com, ip: 52.101.125.61, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXRYLsbuQwLQtY7QGAIKSFHyRQvJK/JKeCxmqXBSSUh7H8eK/AKUP7bVIxiZ9gWXImRQa7ajgsZ662p9r+BXoP7M0S50A1cBBvxdGCra6/LpaUfwU6f3t+TDLGudUFVTIS1sm2oc63Gr3xRBvOxjXsPL9vSXZ3R3D0oOFRCWs/DYvwFqIMPAup8XDNqnlwgu9WNHYGzz5pqDxJ7woUcroK+JwxgsqEhQtA+9tR07xIdCHuHW20jRQGz8CpgTTBY+C/3sfRs2Q+UhSrnAk1d4Ak0qKxEj/y0KrpfIhXHESoljSIU9fcVFBxjADO6jvY0cpd/qNrEVtkbdbXnjKyflig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvJdU3KdZVE8qL+ichvyCVeu8mdq8wR1VsfGkuVVbfY=;
 b=KYzMP4CB4qLU+r4iU+HF9Ka7V1h5UhOiQD1pdJ+5LfMFXCAOkulvCCUY4umLz3T9kswRCRWmYQnJXyzK8Ct/iRsN+rL1xM2LROKh69bE8Cjlv/8geb/OJR4kLOvyypsdL1qd5KX/FRZyI7qccrTB6GRLycweSWmz3YxwJU9qZNsRIXOeg/GOK0IseEOmZdtZqWZSL3nyg/yrdvlMmq6xbNE1+2CtKhpdbxOVWG0e64q6DgEkpc7JCg3u4pXTK2WejDI2UKHhYmlUx/X7Q5YRfC6LJsDm6m/qIkFMyGqjfnI3qg7RBKCvLJQFCqG8L3F0hVXV2kF0zyMd4KDN1kT3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvJdU3KdZVE8qL+ichvyCVeu8mdq8wR1VsfGkuVVbfY=;
 b=iUwitnxkfMFF+ltlln2vKyffqUCAMet/NaWkpv8c2ezKavsB6PPcD7CLeiREeXgCce0YEOp+4Y4NiljGo+QDhzSxnqIy4qQp/wcxwQPH1lp+e9rZ/yDuVe5D86eDQZJ/RVkyDaIdEdD0kS4CnHBR9+EONKZutdQPw8so41UV29A=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by TYRPR01MB13375.jpnprd01.prod.outlook.com (2603:1096:405:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:56:59 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:56:59 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 5.10.y-cip 05/10] clk: renesas: Use IS_ERR() for pointers
 that cannot be NULL
Thread-Topic: [PATCH 5.10.y-cip 05/10] clk: renesas: Use IS_ERR() for pointers
 that cannot be NULL
Thread-Index: AQHczeUk/CDhMhZLj0iwNGa/6neUarXjNqzw
Date: Fri, 17 Apr 2026 12:56:58 +0000
Message-ID: 
 <OS3PR01MB8319D23F485EF2123C7F57808A202@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-6-chris.brandt@renesas.com>
 <aeFPtSgi-v1Km1uP@duo.ucw.cz>
In-Reply-To: <aeFPtSgi-v1Km1uP@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|TYRPR01MB13375:EE_
x-ms-office365-filtering-correlation-id: 8544eeaa-90cf-405b-4526-08de9c80cfe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 AstxPD8LMKUcptCqCp8TVs2LA3VnBgsOHtu27HoDS5ffsjRJtwOTcoZbEG7mzg+gK1FLvs+7fo11YNVU7WZDmWPL2MP4c0+Kajv+8binC9Ad/dLxApwE+pTH1aO8034J6dyk+tsUrwNVTZbv0HQ03ROV6+BHgmC6/wwu17LAE375B0uNc75QGVCBYG0xWTmNYkaxJzhCRfHfGqgtO+o3Q5Occ3WHGxZpYj6mfbUVxjw0fFZE6BOaeqbvKRgGcvHomnaw5tAfv/3HNBmYCdEZKvVtsxLwBOxac2OGAPahAD5m7sgEWKE91n5O1f9/rZKisSkMYGUdJWlkwVkGlJZTct3NXckBnykBWWcPij+90zQnfRqnnJ8OwO/kVLB2w9D7xmDfs61mLynHlzwwRPe+s0AOZzmASUeDhL1cHg86NI/o2rIgKd5+l/lxg3alPn6Pu1DS3OLcdv1DPUaNGnkri7nLVVECsMCD2UUlqzPOtg7VsbXwa2g3TorWa9yilOgIufQMlXYQ0d8p3uOexLO7L+GaHv6OnT/0jRj8iDn3o90aLyjSs8gcYFr873kJKlnDtvX1wPyev2tIVUPhFoG3vw/duHlgjiz5RL2IEDZrwQcLBd7EbAs4rpdzfew8GQWjJjS0+zdgA7+QfB1kpTn8Yv4RTN7JDaZ6j/DKWaMGX7KN1XKAMxatYCL5+9z+fOo+QmjiFWV9pSc7/Up1t9VfWAmGv4ddrlktX5qBWlGmBrh2WpNIWzcW1DbHqWw9H068
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HHKh3H7ISvEWbAATKRGk8MuVBBgFFu8ot6uQHiQ5wW+1opte4507ZlxJMvyn?=
 =?us-ascii?Q?R76EtP9Wx/WaqdBKZtN/U5jmv8qEYVuR1Vgnu9Pr2c3PzDDuFlsGuZRh6D6X?=
 =?us-ascii?Q?Yz7/ZOEZ552K6v+R/FavtZpEnEHh0OgcRqvrcyrJMkVa3oRkn9yPbWHBlwKr?=
 =?us-ascii?Q?xhMjnzKfTfjXmnoCImf97Nr9c/jCZ0EjPamuHFSUOeLIwvLXgXh+1Pr+jQkV?=
 =?us-ascii?Q?BQA129ECVutADqD30yQkAw2o55wNUpko6RGS2EJkNoIgnZembe+b65yBvMFT?=
 =?us-ascii?Q?32fyfS96iBRnIpP/oM3GhNGoVM64bFtFVGAEJxpcL2+VJ5qL9T4N+W5TULlH?=
 =?us-ascii?Q?gqAOPTaTFhoNdiE0Kpy5abbmtgO12gVcOfBja1xp9PfcSMqBfHgzULMtdD2w?=
 =?us-ascii?Q?KIBYCusv3bOpvhyyJJwfrezMq+MPZDDNFNmbdadDl5tFXxqC5HRyUqTccLBj?=
 =?us-ascii?Q?MHImP26cH+0ckxXZRD5yXPMmfIUH4QQSY8/LFZkW0/SKPSsvtPIapD/ickzK?=
 =?us-ascii?Q?i11Sm5HDdY9j8MaXXES2y/FQzyEQj9g3pW4spnqDKYyvyQM63Vezq7ExMV1r?=
 =?us-ascii?Q?IyQGBWpxXNLs8mbEE0BU/sfeiassVaAgdw1ggBrmyxf7x0r81V6fWkN8vBCd?=
 =?us-ascii?Q?k0lXLoZd9dDfB0zAhw+bGwI2WXIuFeFJdD6HjxyEwinO6t6lmXr9TIweKYpV?=
 =?us-ascii?Q?p+yL5sHTWCQt9HAv9oi4sUt9Rj2+7Mric6GwMsCcfN3sbRLow+309KiU8QQb?=
 =?us-ascii?Q?D2SofxHBltBtRksOyZKM0zYma6EbUfGUnRNbADVLV7017YnNHuj7s+eDLW0b?=
 =?us-ascii?Q?fUS0IMsrElOgXtW//uhxbvpPBbeNDk/x9MHSN+lan61HUMiWMPbXiv9jOu30?=
 =?us-ascii?Q?KqrdQp6rJE6N726+M1i6pgtafjVoePYbOcgRMSUvEHRiDq9mRC467Kl23Wu2?=
 =?us-ascii?Q?QkdA2cwseuChfI3jPbkGreLSlPE0ryiDexzUqyXf4pjbglDmd6vZXNwaeBfz?=
 =?us-ascii?Q?mpb4l3wvUZlKzitJ+VHWMQidp7Mr9x9GrqbJ1q3X7asQxsKEmG0mTh0fTsYf?=
 =?us-ascii?Q?11WWmj/6yJmE2QhXpi7wKmRDtnNRpkQf9lmYzgPT4o9+FaVeKwPpgOVOBdas?=
 =?us-ascii?Q?Iw9p+Nny7F8ugIhk6aMDg7iGaCbFba1W7uk0LNB1PbqToFkJRJk267hVNafK?=
 =?us-ascii?Q?QHOQWxounMEjjNdIikFMkQxcKyRQyzQIa73ciYufECWuPjCZFZcJxVv3yGgZ?=
 =?us-ascii?Q?S1pH0TGU3A9uDXd4UFMUbtocsHapUs7W7gU2TlKtPiM0vif/T0upTh7QIDEa?=
 =?us-ascii?Q?2T6H4Mra3zFqUbyx41Svf+cPQCMKwwDKtFxsqWP31yS9aeO/gPIieSIk1tdI?=
 =?us-ascii?Q?St3JoDLxVd9ZlRdrT7ea415AALxjyLpu21N7EvjzYkFqNUdOHhGexePz0Dn8?=
 =?us-ascii?Q?l919AtNM57Hq5awCZLt4FJKqRRbRcOYk4Z4wefiI1JHxEIRNjT0nKPj1Mkxm?=
 =?us-ascii?Q?fgwaL/CbXynKs4jugYVsufCHuguK97rY9IZ/Wpt8hftX7tHRTsenGCVyq1eu?=
 =?us-ascii?Q?UGOG5WM1kX+NhUNPIr8zQNFZIXXKERpsa+IXyJ1AOciYEFoRJ66YPH7qL9Fk?=
 =?us-ascii?Q?J09AGmCbsvxME2vej3NoeJV6XmdO60ZZqk479zAdHaY1qlyEWCX55Ncjxn8l?=
 =?us-ascii?Q?dTX2r8+X9kKzWDLp/NCtuupwgDIEySyK8BBj3/qBZYHvpDKmZEOx/4INxAgy?=
 =?us-ascii?Q?UrKbtUXONA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8544eeaa-90cf-405b-4526-08de9c80cfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:56:59.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8tmS35oYgWn1vqyllcxIpEEkmr2BLHvOxLchSPtqQkuMcw24vUxoQIdOkwyx0xQ99BQfAqx67lrBE61K0u/z+Tbs7lEKq0SmojFctnCYvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13375
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Apr 2026 12:57:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22761

Hi Pavel,

So, something like this?

[dropped changes to rzv2h-cpg.c because file doesn't exist]

Chris


-----Original Message-----
From: Pavel Machek <pavel@nabladev.com>=20
Sent: Thursday, April 16, 2026 5:08 PM
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90=
@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 5.10.y-cip 05/10] clk: renesas: Use IS_ERR() for pointe=
rs that cannot be NULL

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 6a636d203cc8d29ae73116bbca8b0ea2c7a90d7f upstream.
>=20
> The use of IS_ERR_OR_NULL() suggests that "clk" can be a NULL pointer.
> Hence smatch assumes so, and issues a "passing zero to 'PTR_ERR'"
> warning.
>=20
> At these checkpoints, "clk" always contains either a valid pointer, or=20
> an error pointer (none of the functions called return NULL pointers).
> Hence replace IS_ERR_OR_NULL() by IS_ERR().
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202408032025.ve2JMaoV-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link:
> https://patch.msgid.link/81260328acb5c78e915ab04afad3901a31c16128.1758
> 793709.git.geert+renesas@glider.be
[<-- here -->]
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Apparently, this one is different from upstream. That is okay, but note say=
ing [dropped this because that] would be welcome before your signoff.

Thanks and best regards,
							Pavel

