Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C51EEB106F
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 15:20:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42653.1773156031866844673
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 08:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=PtGIOA41;
 spf=pass (domain: renesas.com, ip: 52.101.229.38, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESS5R2hi+gx1Gy2ZryQPcarcpEfs2LwYDuSYOmpifs6xTY84c4V5KH5jaj1hfZJmlJTb0RirGA6xQ3Ho1022A5spoUTN6ZokXGBAJtVatOeaFIPCeoGRNOH6LV/iOH2xRf4+/NBuDSei3NWAuWYPiZM7xKlvALFkky04NenW5vgs2XIWeaI3SaUCFpGBK7g+l6E5sg18uk4vYouClxXS7ZbL0qq7qMyOs7Hl6g3xthPS0L19Mhu4Ii7B3KnwdcO/8yD7qn9bCpb6KBWbdrOVOsiJD1sDxr1JEOOLKoSW3NHqAx4eEUdJbj/QzU2nQoy5gX3mX8k7z343YeRp/gOKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U3Y1R9aQHi3uP6rVwYtk9fm9DaPh5vpUgOK8Enj1BY=;
 b=BYhm+H3ZQGB11CyE6e/WSpsXCkA0UICTmmTD2yHbebaC13wX2OExHNuUkzr3CHhZZD9/ZtWNoD369HW+MY7xkuDZto7LCo53t4Fl9txzhh0aqbG5PO3veQ2dCIhPt5jYzKzZl6Qm+vJP/2JcGmnbwseRKageT6N7TOYwC9XbM8+9Z2su/CadG8XfDgVQYSZwIzKqjuCDh9h8l9r28TgAKL/4e4xu0OQGkIDQ5pV53qHmzPk6e/NaZxlaLYP6iYtgJqMUGBxwPjM2UBZEc6tHqMD4pvghH2RJte6/EM3gcXULA0iYEwwhdKkB6Ijz54dCoF+ZjSevibxMvbYTjM/g8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U3Y1R9aQHi3uP6rVwYtk9fm9DaPh5vpUgOK8Enj1BY=;
 b=PtGIOA41Vazd/CIwNmGjPpHc1lUoLOWG0UecZWIkg+geMTNdk1E4XBJdJh8VIcql5hGTYw4rIQ0KPHcxLYirTGPuda1/J8NZlLKq/uGcR4Ob0L8vgtxslv34IMlYZtOJMjep8n7Pouu2k4jf6Ckdsy2effS0v+sloyLezcLTaxk=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY7P301MB1981.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 15:20:28 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 15:20:26 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Thread-Topic: [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Thread-Index: AQHcrlJt5uBMXMXd40m8Y0szIkJ13rWn5KMQ
Date: Tue, 10 Mar 2026 15:20:26 +0000
Message-ID: 
 <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
 <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
In-Reply-To: <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY7P301MB1981:EE_
x-ms-office365-filtering-correlation-id: af8a4335-47e0-4a7c-5d54-08de7eb88e6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 rRiHzplbKMc4ihIYVcI8t+S26x/pYWyQ+HZt51/BQhWZzH0y45Td2a5bmX97zz7jxjhi0q1wqMqQiUELJxrX6BblZW5UU54MM+JG0mTTO3ek8docfxrcIKu48UCDneGWT77cMfumpXPkJQW1kMid22xjEqDN+2XjybH7ZhWhVO0zYW/pRGohlR2Djo1clVKO0CCWU7lNUAMH2kIQXW8SBlhDpJxBmVF64sfnLCxPwVRx7jvKETguEZOkAdWNQVsMLMDIdTyTZjL2wNwH1+byQvP15NgNb+2UWuhaZuuwT3/YRzAw1ONnR6Ba2FR0+1EiUlb/2xsrw0DoOe1W8AFK17a8tdBOuq+5OKlnCPF4Uom3UawYckNI7PcWQOaKI8jfcVq+Hfd5jZvTYSiu93eLfSCrajAemn4PttakZB87Qgy9Qmmv1hVP+gWJRXXlE5e0QPTl+Eet3OOilvf4T02iecK4HYqX/COwXz2NTk7oYQ1RM7I0X4RV7tL5/nFazSYJA+hH3qajUwxMEssRNKdCBOEjn365qLi5ZjjVcYT456nL2GQRv9H9JWlfWzRoO8K74WvxnO5I2WH9kc+IFzNNv2nGbdczOwoWzc5iaPk1uPeRNC22R6QOUX2+mzI9pht9DdkHTs8hwnLwquBy6kKPKNXvL8lLRuSrkDAxPZLaIpibR3Ctp9Sq74557qV+9tZJiuQEughXWqWf9mV97qsyVqTMkoMynM3+jYZPIp59BNj6K/1NSzrvhszFf6rRTkLjdiJslJWECje6+8JBWUgs7lGvPK26t6Thtbs54DPXpGk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DFEqPRI4rzmBAN6suetBsbnlKf/MlL0bYvSfYUjcwPr7gQJC5or6vBIJsKcc?=
 =?us-ascii?Q?ZO8/M7Qes7dLsPM5VHj3MPikbH3mW7SK/yNmUEg473kI++dPETwCStSqSh11?=
 =?us-ascii?Q?zLGli1amFfzlgWcjcQeWw15Bd5OCPoehlTU5rg7aPaGJUFRbjZYpIY2j4SEQ?=
 =?us-ascii?Q?JHU7vhBWmkkXqqyDyRIPYEYExoK3/hVX8sHNT0W83Ur64CETIHyB3yHilxE3?=
 =?us-ascii?Q?eGMcHF83pvUXK4hN0BRempGe/5z9Amru7+UyqkdsAuxADEOOg8qDGgiODaby?=
 =?us-ascii?Q?+uTmFLvfwISjKL1nZf5wMqjXI2HZz2wkVTHa+/pSj2VG/8VzY1mSRLgE7FUI?=
 =?us-ascii?Q?eXsnwzHaYeKtuayrbf5/WC+VwXlm5wEEUPg3PTwh4E/xf+1eLm5C8/oGqPIa?=
 =?us-ascii?Q?XU5iZgWA+v46W12f8vQP0sCzVoRwZd/hGBaaLPXnowbkkoRWlLqUoQ2cBaUg?=
 =?us-ascii?Q?p/BXsoMZGxNE8g4uIZZ6kH8Xae9SQwkM0GcwbrbWv4JZAEluiO3nJ9Y5pklb?=
 =?us-ascii?Q?T0NKG129eEqQhXrSknyAZxhkC4UIh/UT933GIvg3WgFHLY6RmGAAartNzK3V?=
 =?us-ascii?Q?EkLR2POymqXweWxDVTt3ZyPau8DNL56oNXWBZVFTlzO7G8P5HfupGfw/uwUH?=
 =?us-ascii?Q?XixugMDWaIDDkcV+s+4sluzWkAC3kSLgnIliWh7b6N5P7YhQ/GZndb2jdDE0?=
 =?us-ascii?Q?xb7N5XvT0NzSojCny8dyKJaqMgKZmBOsEVOUGQu141N+zf6V4JUJ+w4TIWKZ?=
 =?us-ascii?Q?P5unZ268G5QQOzardsxbNDzWLcpTigG2wbvC7JUaHX6zjqMHrhq481EbPWQU?=
 =?us-ascii?Q?7B0+Djn+b5ZXlKwHUQYG7Bhab9VbqE76HLc2HZJfV6EgygkEqhB+jPdoMTYh?=
 =?us-ascii?Q?wZUVpbTGISCQwBh6tSDxvuoS4vOHOK/YEDjXnwGsz5mWbvM6/tj4EWgGsMuj?=
 =?us-ascii?Q?YSrfYTQ6Lt55z+sJtnWjWCXSGWEaS2Z7oqBvIpOEWjbFb0dfmn4jmbBS9o9B?=
 =?us-ascii?Q?Ke3FBVnm3LAORR21iXGUpzKVBt6KsM3i8reKNkMAOJLBBf4Da7Zcj5msdhRO?=
 =?us-ascii?Q?vfTDu7LuUi3wm7jt7XrYiY8yLXi34EePWc3xMtemp9nSv2KM1vymEKOP8cZ4?=
 =?us-ascii?Q?6GXQKoDbGKz1hRcytuR0W0HE+LX3pPMSNsPWnFzS01fDc0mXXfzMSU9HzkOl?=
 =?us-ascii?Q?TnfcvDzN1gb4tus1lKA6vVp6Q+tjTX8H1ItpXGKomPfYS/qo5PTbTJ/ckfga?=
 =?us-ascii?Q?WOWzvsmP/Hsrk2FsxUG2i/VABWNu+QuXK3eaVJiuDdAEiC05LwU3goIOsmyY?=
 =?us-ascii?Q?7Zdx2wwkjzhpJ7Mnc7MV9t4WQfRAu1kW1KAKGR1D9gQzm011Q2mcvkPya4gM?=
 =?us-ascii?Q?2Ee485PfJ5yj4308jnIX7GquOFVWPh/W4670rVrWuB6Hz7qqH9mxuHL34Zn6?=
 =?us-ascii?Q?HJ856jYVPBtURLD7+l/v5QIUdM+BsAgnon0FrJTlICEDBE9/BZAhQy7VFdvb?=
 =?us-ascii?Q?JIPOfdz/N34szAAEYhuEQ18xJXvQhGoYWSVOSbf2eWD2MCLN/Asx07JILV0h?=
 =?us-ascii?Q?U0QVkMeQ585NHinY5JrT4KYGEA0tR2qVlwfFZf7eiH77ojkDGdGatoMITYKT?=
 =?us-ascii?Q?gcqP2x2/T/tMoEinag1hbHNNW8WXiSqnASYwBUpmKn6Mz5HIGuOFhwVhvoyR?=
 =?us-ascii?Q?Y4kFch7KLj9Lc+209dx9u3jIR5YW9TpB6xZ+lUsXwD82jtXVKMZDkFS/fggO?=
 =?us-ascii?Q?Q+opntZVO7/ct8teAcRGVKCymv34QJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a4335-47e0-4a7c-5d54-08de7eb88e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 15:20:26.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F69Zbt+RUCW0EEBSLjo+lI+WVazAUvtk20vRVkXKDDqq6qLeXwx3vvk2ploiJ98KEu3wW0PFoPB/aFEI4YI3jooI9Zyxeoo55YuXWlL8Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P301MB1981
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 15:20:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22228

Hi Pavel,

>=20
> Hi!
>=20
> > This series adds display support for the Renesas RZ/V2N SoC and EVK
> > board.
> >
> > All patches were cherry-picked from mainline kernel.
> >
> > Note: This series depends on:
> > https://lore.kernel.org/cip-dev/20260225121232.129678-1-
> ovidiu.panait.rb@renesas.com/
>=20
> Thank you, applied.
>=20

Looks like this series is not present in the 6.12 branch, could you
please double check?

Thanks!
Ovidiu

> Best regards,
> 									Pavel

