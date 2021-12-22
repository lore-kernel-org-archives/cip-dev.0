Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A290BC433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 11:05:32 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web09.18002.1640171129800094217
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 03:05:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ekVxWmqM;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKsnjYf0k/5EX5829KnJV55Rx8Np8dKDrpIAr3SvjbekVt/iyOvAm11wtpwDLIxF2XNuMICb2nbpTD58Iipm8lbWBYxJZm7EbzKlO8MTAHticvvKAjKxz9kU+ZDFQGcwXhs2/tIA0Wyf7AN6wwtfcTJQgJLP1tREFxyCIA2h1aaQzm3fyiMZOOkckJCBI3NRwDgpV5kBMPEY9TJ3PXv8Q7nEPGJ5d8ibHG6xaAb5YQKPt5XRFzyntcGe4OH0wgc8rEQ0xDRvEfU2cGYCO+I+Qm/g8eiQq6KkWnQCVQ9LgCb1udV+hq0r106Xq1wWNHgSguzOTb7oFGcHvXu3YrfmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYR1H/rAhZzpdc1L+KUXsWuJgNG9ORGjprTR4UMZqis=;
 b=jTwRhCavvfGT+2H66RnrLjQZ214xPuPLiFr/9eXQr3r2nOcfhk7Xnzb6xZk5vPpNkcFdobp6cBKHDcNb78FstvAJS+38dQ6OM8yZcW55r10sh80tvBT7PXDaYbDxK6SvR+i4iwVpX3G0Ed081YL6xQkxnZwJxcR54tMCD1Uv+csYrjX7q0t8CPDhpPpLqMmUYGsoEwuhnPVgr8k1JstqN7q0ePAPsRmBzJDhMc7A7nWhkjqOeXKdoHxEl89AhCzCY4FcvitvquSsTZxvCRGKPauREItKV35ek1xm+s52jTEE74jLGCglMhD7kSDLYqFCINpzQFB2/486wHOBD/scZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYR1H/rAhZzpdc1L+KUXsWuJgNG9ORGjprTR4UMZqis=;
 b=ekVxWmqM11Ak9IJKmlhN+TLiBiQinBy9RNk4Lle1e+HyBNr3OlErv79ED+MnZRcf/35H4NdCpaztrFVPaH96WTZqc2g+wdhC8vw9ZJquUWLjdSVktVyu2UptnUM8GEELgJYk+m9lFbmbj8cqmuAKP+2g/7k9S+uWDc4SNoMXRD4=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB3762.jpnprd01.prod.outlook.com (2603:1096:604:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Wed, 22 Dec
 2021 11:05:25 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 11:05:25 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/22] dt-bindings: pinctrl: renesas: Add DT
 bindings for RZ/G2L pinctrl
Thread-Topic: [PATCH 5.10.y-cip 03/22] dt-bindings: pinctrl: renesas: Add DT
 bindings for RZ/G2L pinctrl
Thread-Index: AQHX9xi168H/6Vg22EiOmRBdh4uDKKw+VxrA
Date: Wed, 22 Dec 2021 11:05:25 +0000
Message-ID: 
 <OSZPR01MB70194DC4F3E5844E821B3A77AA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222094546.GB15186@amd>
In-Reply-To: <20211222094546.GB15186@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 340f48e6-ef83-40da-055f-08d9c53af4ac
x-ms-traffictypediagnostic: OSAPR01MB3762:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB376269E0E04BFB2182AB31ADAA7D9@OSAPR01MB3762.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i1iDf9/4tPH7zmqGOTmTCrN5eEMTPGYzF9uskz+xy9l7rwytdXn3sI2Qqgn/AUjK8amlPfKJOa2LxyXhijshgaWkOmFcoG36xQmITMkSvwa0A4Uaa5q+QAxlPFZNW731f0CftWR/jEXwulpwP4uUs8fWWfp6rMtb7gkuej6W41RqyGgHZXf5sof8c/GpmOuR7h17tTKdlGFfL2mIcTJV3jAAuqepbUd1VTCnC8oe9BSch1Tzv15eePOa3P3QpmlROpiFxw5LeU3NOUs0u/6dJ7F9lMwA9fNmbXjvj7CD1pqyZfUt5KPH4ZNz4WPhYdVZZ3CkbwRRXbtvFGqsr3eSdNRIP87qEaL6v5xTB6PEg9TA0VHu1HNLl5wO5L4yhQDBv13DHVDgxt8LIn6NGGI4lDtvFqvRtvaCcKgDHmbU/8mqR8lo8PCHfmMVAK5YND3zYpIo2/b9K1TjG0mqoCr2pMZu6P/7rksay35dvbTEtq4RzfhJY2d1AbZiefMbx86DGvbvSdzyQBsEIzK2s1TfB9gWd3fCMzjghsvrhSb+/GqBlyewVLhtkAnMnu5k+eTL8CHSsrPGdJBFo7K7klsvgh1ZBNZAiq5MuRdGEsHj4dbW8Fey4auqUgXZr78c5mflqi7RwFhFzPfCFdPPdA1i8wLTYVRDNd71gfSFYi1jFOa20jabnV9bUts4kqLk8iAJ9pZx88W5jE+wjUhSjhNQoQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6506007)(53546011)(54906003)(9686003)(186003)(6916009)(7696005)(52536014)(316002)(4744005)(71200400001)(86362001)(55016003)(5660300002)(122000001)(107886003)(76116006)(66476007)(38070700005)(508600001)(64756008)(66946007)(8936002)(66446008)(66556008)(83380400001)(33656002)(38100700002)(8676002)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9stqLg4PnZGZ29fK798r5b8QbI8MxEm8aGz87TBzGK5vIf8LSlDOA9ZN3xX4?=
 =?us-ascii?Q?pkuQfz06i3OXCV5Nl/bJn2B+j/k05fwypuTYXxvwuC2Wnntgcry3fuAzj8i3?=
 =?us-ascii?Q?LEcLznTYJVP+4y7xn92y9qDBaHQS8gBEE/tLnWOM3mI7Yxt2EignxYzOq1KA?=
 =?us-ascii?Q?elcppq6owyGR0+2k2s+gNrf8BGwoyqsUlHVzu8JT7So6umAFKpFn0/oY0w21?=
 =?us-ascii?Q?X5lyT/EJc6GCzIRJZL59NsJBDuaKCQnDyIUgros4boyl92IOhO2xaxosv4+Y?=
 =?us-ascii?Q?y4mHZmNLWoadcYB3+pgz+n62opKmX0Eyy5zdeW9mf0zxRaf9QXHrs9j4wWUf?=
 =?us-ascii?Q?g8eoXM4VR3YXjNdzC8Fkulc6wcWU2yGdTV8hDgf3rpWwGLEy2bQX70OTOCcT?=
 =?us-ascii?Q?Pxi0hJgI6kBP/mFpDCeh1Sb4B+BDV9AmALv1e5YhB4POYUU8k9jIB6itBp8V?=
 =?us-ascii?Q?ee0XlDzxM/CcOFrqxMSrdJ4T0rhRoVCUEvR2XllvE8pjxI3NGCSwaMne1Crc?=
 =?us-ascii?Q?ZN9zjSq/Ib/m8FyNQ8p03xE9z7OAWGQ9ga8siVg+zkP1aFSTc/1EPIKAyucc?=
 =?us-ascii?Q?vTzr99tIlpj/derCP7aoKtJ/FjSprG7InVcp/rNY2Dv754EE0GNPuekbql4j?=
 =?us-ascii?Q?hhMH/1xZOgFlHDT5E93Imc0WEYhror1ChYB9nxZE18RbQShyEGV4Uqs6kiFo?=
 =?us-ascii?Q?2AwHHT/5PkXmnQ0Ds/oF+FwiAZ8KRDGWA3JyCVq60HopEhbYrYhJphrf3tbP?=
 =?us-ascii?Q?TMI7RlD/5VQRwqA7I38mgVepq1ChiNjg2fQfLyFgz1zlmRv8dOlrBnlZAL8K?=
 =?us-ascii?Q?PgOc2U8qiDuBOhJKNaCJLWQwQWhI+9ALjisOI/I9UjewFQHCjPSnG3vNLzuu?=
 =?us-ascii?Q?KdTeiSo+n3QylC1Yp5OhTc6IiRWCBpdWfOZt+fVFSAN5Ukuma6b8uiqp1eCh?=
 =?us-ascii?Q?uE3iwYvJARAJVRWecVdZc+NvOFgHtyOPmYSm8YYhJVCqAvwP3qEKpDC2j/l1?=
 =?us-ascii?Q?iAhOkRas+OG5OLVcvFjsoTAuZIMZiTczbtxnJw6jZGwi06eL0ltw5ZuVzoDk?=
 =?us-ascii?Q?ID9qVF73VPxgn/sc4kMPubtNec6t3jmDh7cQ5J/icKK0mKUgH6JA1UfNvod2?=
 =?us-ascii?Q?H30xuMkrPh0rHedVYRRupwlFLuR3dPBHEOpmeY/hfAz7I48EDLuhbtET4IHP?=
 =?us-ascii?Q?sfrNsXJSU4cquyNG85CxrWSatx2XU13iLWGylwiz9V9IsdfOejQXUt4fRc8V?=
 =?us-ascii?Q?eVZ6RIpW1I56fDgeG/XD5LnwXsAKCQyodyAYRTp/BEGk7QyDMmRUNxP0X2VN?=
 =?us-ascii?Q?gqJ+PDkEtGBXvkFt2qzVkWM1mUx4AauutAzKkABt5nLeufKpIZeev+2YAVee?=
 =?us-ascii?Q?7njvP5S233gfhTSJBN88XdkQCPUpwSgWiFm+cwQQ+ZCKZiWnOtsRl2aTcXg5?=
 =?us-ascii?Q?/I7hlNUN2uMlmwiKYnlW8hRH8N2HqQ29kQp2L68S/5CXpbhHb5mc/QMnNGfv?=
 =?us-ascii?Q?c8pnP/WqfUyKuv7R5f42/UD0WNDIqT2g4FHdvMW3k1INcwHh1AzI9BiU8pn2?=
 =?us-ascii?Q?QViNwCysc6vaS1pvQHYbIDXz3d8R6UxV/RDyYYqv+U3OjNgJyqdjAZ23t+Vo?=
 =?us-ascii?Q?Bc8bvFR3bnZfhxAyg5nsyEY4c45pfn8ble23XRfJh2gW9SL5kSNEEJksuNa3?=
 =?us-ascii?Q?VDVjnMmbvl4I1NGnzgSnOEjbdE4E/ROFUT94gmZBRfQPKwGIjoN25euGPuq0?=
 =?us-ascii?Q?M0Fd7ahuOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 340f48e6-ef83-40da-055f-08d9c53af4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 11:05:25.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 InnG3EPWRL9+oKmv2Rrbkcu0e5wb29SMk/cNXbtqKtNhZSnwHtRM7EPUISPT21gcIUnwaD+Aua36jPLN+1Ohw/hyOUC9JdkL3oG2Mb/+9fQg9uxLKQJ2kNpGpBKi6j8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3762
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 11:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7233

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 22 December 2021 09:46
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 03/22] dt-bindings: pinctrl: renesas: Add =
DT bindings for RZ/G2L
> pinctrl
>=20
> Hi!
>=20
> > commit 7958f88aa6636f1927513c887a00e83168f12e35 upstream.
> >
> > Add device tree binding documentation and header file for Renesas
> > RZ/G2L pinctrl.
> >
> > +        drive-strength:
> > +          enum: [ 2, 4, 8, 12 ]
> > +        power-source:
> > +          enum: [ 1800, 2500, 3300 ]
>=20
> These are likely milliamps and millivolts, right? Elsewhere in device tre=
es microvolts and microamps
> are used, so that is not too consistent.
>
Its in millivolts in our case.
=20
> Is the unit mentioned somewhere / should it be?
>=20
I can update the renesas,rzg2l-pinctrl.yaml binding do to add a description=
 and state the values are in millivolts.

Cheers,
Prabhakar

