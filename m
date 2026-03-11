Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2AD1062899
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 12:54:34 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20716.1773233673178842363
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 05:54:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=VRaYojj/;
 spf=pass (domain: renesas.com, ip: 52.101.228.41, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2rCcHOKtbd1Bh512fZPXbhsQx+hujlNT3vdYqYv2GbvPDyJHleO8SfXR4ARBb21EfT8g1VmGT4nSY3ceb57ItLalzeSAXDdYJpUfH2BuzEx44zcg2eq/olXdJeiYwEb6k3iP092fbKYpW2M3njoukCwXfKT64ErRznooucoe1nF56T/W2Sci4Gxn3rmSz9J84ZITI8r0gChGV8GTF1NZM1eANy3CI5AkvvlgWDeug1L3G9xs1amXl3cS/4jrokGpr/qImQirGbL2ga2o+AwJbdf0E0zfSwWHTjjyWfuXR2hOTelk1TXcMC+mSApBpezvCjHgD7kkwd25u/MH4+g+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sluQfA+gwAEhIHrCNyqrvuY4Z1TFtJ0w1gnvFSw9Kso=;
 b=ZE1CRjlt/jqYs1f4moHKIsQGqsiFsY2w5dz9q2RTuhm8mQys3X0bDM0Oew+HWAMrTNN4TuhUVRwvV1MMC++Z9hbERN5TWHp/yQyI1tTHm2P2ZJCPcjv1DB512VWSGCK6iNPb6fr14QzQLcqJMhhK5+tAZxXQpaMJRkN5KavEl22BJo0Z+wKHF1W6UNG/oZX9r4DTecANfFmGdtAroqoc65fTE2o/fAxxFaoRTOu4vOXQEqUwu1t5ZKKZm7eik9Z8U3B7PNYb9BEt42HPqi5QiIuAfFvro0enKXfXiIcRTpq7DmVdl1xii66MLit+gV1iY0324/1omMS7u3AXSvbt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sluQfA+gwAEhIHrCNyqrvuY4Z1TFtJ0w1gnvFSw9Kso=;
 b=VRaYojj/ZmwwQzMV3OGU87cD23G2WZlvZKoxk3PVdy6f6Me8Vr+A+XT5n3z8xfubgLMq7i4UWP239JhWZaNz8Gfk2PGWf29G6zqe0y63v3S+VZ6vENZZcK2MNBuVrvAHgTRFacMRx4jK+k16cCajL4ZJcWJpKiFYKAydvAYUHyY=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY1P301MB0377.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:2eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:54:27 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:54:24 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Thread-Index: AQHcrlJt5uBMXMXd40m8Y0szIkJ13rWn5KMQgAFDhwCAACdqAA==
Date: Wed, 11 Mar 2026 12:54:24 +0000
Message-ID: 
 <TY7P301MB198485DDDD0B4AE2EFD658BBD347A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
 <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
 <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
 <abFE0CF056kznlGe@duo.ucw.cz>
In-Reply-To: <abFE0CF056kznlGe@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY1P301MB0377:EE_
x-ms-office365-filtering-correlation-id: 4e92657b-6a65-45ed-0c4d-08de7f6d5253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 CPDROjhzQkEf8xaUlLi3UbQpYwCfWseklsmBwspMbck6KMihdYkdB0Fb36Ec5gn08X4qnogDNWNaFCluGLnnXPT1HhS7XwwJL+Exuz8mzSCY4EL929B9pVGCtv6a/XoMOPzPWin33euJGOxt4prrZrkFwriGgKYPG9jYds3bxcxXpanN+9zR0YhwNFBhlCfGG2909Ho5sj3i8bPmq2E3EfIN4BPVlWXMwsTIgMDWIgtMQLsr+POXqtfcENE04E36/zgK4+zR8bZhndmdnS8e8lz9NPvvTL9CDT1tVmvqLC9RQeLrgIz1kNwU0gawPMMLcJIBmuPFrffQBICG26xPOk6Qols9ztX3If9QLbaBFo6DHd6r1NoQGBs78krk6CQDWgG7H0aX7flygGZALrGB+Q3BQ2Xa4Ww5reqCLJ2cBBjOzs/f3eaXm0YQyLRJIS7N9Zgbd6bwM8UlSqPlQ+RS7RPcMETwjt9R+3H0Zu4HOjMuwAWRuzrmxWXHRv+tiaycy5x4nD33LTieEe2Mo7ZfZQdAEUyGA4X67dFvEoYDvJreZfaCouOEb+uehYByCeOEZkivTWemQVUL5+W+uvXdCOx0shD6kzGvPgCcRNA4PS6SubDoJ3SBy4ACJRs3zSJRREBlfZZKdBYsH4FVD9Qij0Fcgj3g4p7tw+XuVd3tGhMH9NEcGsOINu057GWhm6Oyzy1RtbCLOnyvfTp74OWabp4QoHwwEn6aW0Ik0rKQDutZbLpnFEUzMF4cLjJvVZ4uQJv0rxdmL/cF2kFhgXnm10bHb31t3BexBstpon8zDyE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?LjUXsLbNCh1iC/SqLtzwjXNHafX+dapKdklBCMftIl0+WRnvqQBCNeWGP/wJ?=
 =?us-ascii?Q?WNPyHNFkWf1k3CQ3tXk2bHBInSgPNj0B7lAEsJSOTPwqdNP0oueBI3UUPcX4?=
 =?us-ascii?Q?edjKnaupb7qeY8L/jZMCx3dm5/pG4VoluDkEC3nG1ulVuGpmS2uN46ogqOPo?=
 =?us-ascii?Q?c7njBKv/dooweiS8fg9+Euoqy0D7n1VWerBCn/8NY1AEhrYqFoxrdz7pDtOB?=
 =?us-ascii?Q?7HJiHN89xNr98ft2Em4G2m2WNhG+RADWYkVmrJHYAQTgcUL05G6FJxbKn6oe?=
 =?us-ascii?Q?hFUFWbbWGtavFmi/pJTlN2WWWjuxpeV4qMCn6TtnMWIwchkv4NH+f5bAXQdC?=
 =?us-ascii?Q?8O8IbRRakglyiPeBa/CnS9m/N6oa05oJwhl+DWYrtt0SiaW1OqJTvcZ5JHqy?=
 =?us-ascii?Q?1Ac7IERdkgrPV2EcG1siNtuEOfrcPTgXv9frMxRYk8bbVIxDSf2+yqqKo4T7?=
 =?us-ascii?Q?DizQSO0JXcvdLvGC/dtRxCHoMDYvKcuHsT+UWExeKnq1lf00sTFtNyAcZdVv?=
 =?us-ascii?Q?JyN6YuakRspLXmj9MtWGtZ6rtzRMPEprDttNycpRvEkEh3gTGsW/liH/SZND?=
 =?us-ascii?Q?i2bIZBq7HxZXATIW7xChR51L5hWNYhvNmwWSXVfC7dBvpxDahTd0b43HrabT?=
 =?us-ascii?Q?Mek6KbNXExUPCthhGOwIt+MDBEl3P12SggQp1NtyElC2uzxRSqgPbyNq9GmJ?=
 =?us-ascii?Q?EiXHvA3+opOZ91vFhw5/FL4iiuS0JzLAWuhezv+bBAmnQcnatMv+z6Y/64h1?=
 =?us-ascii?Q?GHERZiNSEmjtNXVY1wSkGlNa/WFC1VXctCrzx6r086zwlUZIchxjzd4jD4MV?=
 =?us-ascii?Q?XVwrhkJHao4hBAHyxkvqjrZXwQN2dtk9BTwerUzu2oz3vpc7WWFZySJo3jZY?=
 =?us-ascii?Q?oZ2od89da0HJ/Qak3PFMEW9YXJmMS1GpqkwZlpiK1Pkaqt/TXxS6mPc0UX8B?=
 =?us-ascii?Q?Jp0P3s2xfA57qpCmNvkOjrP9SlzQb8ryWUEUeluGlLYmfYIXlWbdVv9xumi3?=
 =?us-ascii?Q?YzpSTbPHnUCWcCSWBk3VdCbcg70XUQBXU4Hx6G66uVptYN/bJBVxrjh9/X7t?=
 =?us-ascii?Q?JhSKslcA6jG3SVnGQ6I2CYuu/7ZTwjnPuQeRGzPRb7QlBurfqtl1VXZ0ql/a?=
 =?us-ascii?Q?5h/Ym8JGYTfEFm26yX550SnZqLI2v+Gy/70nBaa7Zzww/REst+XYAx9o+aSV?=
 =?us-ascii?Q?10j02+fc6UCA24flac4wFdEF51krcFE1k0uKiBZX5U7/Vpn5BJ14puemNZC/?=
 =?us-ascii?Q?EvcQridYFB0a5B+T/wULKwT5FLQUhO4GQ805l6vcrbjPuluR9PHc9Yj9lVuU?=
 =?us-ascii?Q?Y9n8NKUch/zssoFFOyKO9cgWt9kNb5F2t+oJRBR+23zupncsBExaIBsCn0dl?=
 =?us-ascii?Q?3IUPz7wFkeiPXWvGwT0wIZqwZ0HqbsITBB5zZuOzFQ36M4Yc5WXVb9OtMo5Y?=
 =?us-ascii?Q?e932u+81BQL5qnwgl8S+KHzJEVZTiG/Dbcl90oAnUpFcxpVYyROJpQCxRfpV?=
 =?us-ascii?Q?zpqb0j/e/MNzAus0CHYYYyX9sTk5a0+BJQrJ3L7JMXZcpFTQ8F55E77dvaQK?=
 =?us-ascii?Q?4nncKwkUMPqb8IfGuBX63KwOVnYXlm37uJVl8s/njIIaOxmAD0vyRhVfDVUd?=
 =?us-ascii?Q?dXoOChpcIkyFJfs4DEc/+QYUvV2aR7x3nSUF/Wj89aW6T09rjrdlwhvMR/bB?=
 =?us-ascii?Q?k3xWF+KJSk/y9NHHTKsx4bU8lMsRloBVFw0EEfujEYxiv2Gv0BhxrohGGWlV?=
 =?us-ascii?Q?jDtu3wCKwZH7JV+dIwGzaRE/2vLpNZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e92657b-6a65-45ed-0c4d-08de7f6d5253
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:54:24.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z843ofdkKvmFCaiBB/3gf9QbVwGciZ+ikDfGhrSqcMf1nud2IWEgLjpzMa5jKTHKbPV3oJmi8DYPKTM/MyMR13rnoNEzT3BIQtI3i5lAq+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P301MB0377
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 12:54:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22343

Hi Pavel,

>=20
> > > > This series adds display support for the Renesas RZ/V2N SoC and EVK
> > > > board.
> > > >
> > > > All patches were cherry-picked from mainline kernel.
> > > >
> > > > Note: This series depends on:
> > > > https://lore.kernel.org/cip-dev/20260225121232.129678-1-
> > > ovidiu.panait.rb@renesas.com/
> > >
> > > Thank you, applied.
> >
> > Looks like this series is not present in the 6.12 branch, could you
> > please double check?
>=20
> Yep, sorry about that, it should be fixed now.
>=20

This is now fixed, thanks!

Ovidiu

> Best regards,
> 								Pavel

