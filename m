Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8EC04A68
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:20:16 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.97])
 by mx.groups.io with SMTP id smtpd.web09.30951.1659003609962908757
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:20:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=OS1B5uSj;
 spf=pass (domain: renesas.com, ip: 40.107.114.97,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVoxu0CRYVytWCdD6d/aBav+d7O355PzlOtp0KkaT96wpIs3Fqhx0SRwtCJoN5PN3Uc4lYRMt3tWyvlxSZdLqdohnpNUHWk5FNWS35MUEd2fpwsTbPw0GO+3LMLi0e5SIPmhQxrXM9Bfzd45rirMlJvL+WRuh5PXPm2mvObSby4ZLJ2fLzPgNHVSU86NkX+niC8CaLuH6my6Lk3hWQ4OhuE9/Ulz+PQ5Ws6ZiyBfbagDqzrIyPj4uuKZeur4otLK93l72ezzjqh/lPaJi9KcyXZJM4m/w3d8J0GObCDFPHQRHyCyRnId7BcJOIAj49TIwFv8/nPIganBFgTaEe2wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp6QlZ8lEWmUXwEkm+3KdE4YohmI0WHAZdGbKVMfK6g=;
 b=LxiJYA0dtz2GZzT72IDL2kLzsNHSduPXEtqPpR9B4XCWbLiAHC+EQbbzgnuGz+Bzsb1g4E8ccbIobtvn25oql6OaVQHpQ69z/kf9DqqQBZIP79BR91BQf6PmN9oHGythJLBGjI5w936m1WLImI5AyDjM6McH7Yi+i1RsCc9T37J/Q+Nzbm6q0pqYWjNhOeAyLsPl1RYEnQQ6aFy7fUHzFlYn0uwpIaQ3mGxJ4nLSOh/Qbox69Wgkgh5RJU5yMF0/VTvYXDdCw8VRsf+EJSv+KtShzzMVZkgg8RY0Lzw8v2ppCOqhEhzjFF7HiBrjbKgDHdykZ9RB4u/q0ignCdlzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp6QlZ8lEWmUXwEkm+3KdE4YohmI0WHAZdGbKVMfK6g=;
 b=OS1B5uSjgzgNdqIFltqy7SE3+DAGlOUYBWzRajAjfbTO0jK/aEIj5phhSLsZO8VqiRKaOcJIpY0Z5byyd8Bj8QgjxbGvgYR8f5RTGmetnzJjtdg8irMRB3V/85C5xYZPv2CmG+KDVxh3SpmG6oxKLBdhiIugCIOd0CwKuieZx0E=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by TYYPR01MB10481.jpnprd01.prod.outlook.com (2603:1096:400:2f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 10:20:06 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab%3]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 10:20:06 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHYolE/h07+Vf/vEkqjl/hlmuXq8a2TkeBw
Date: Thu, 28 Jul 2022 10:20:06 +0000
Message-ID: 
 <OSZPR01MB812409CBA20183220B5DCCF4B7969@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <fd0af4c9-2576-b998-9f13-c5c4b9aa6402@siemens.com>
In-Reply-To: <fd0af4c9-2576-b998-9f13-c5c4b9aa6402@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 322d6226-720f-4490-4fff-08da7082be08
x-ms-traffictypediagnostic: TYYPR01MB10481:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mHvYqvBGu+U9vdwirmV7qdPxJ9+4HIcBI6DHT5c0AYTKHpV6AZhxzOfIiZaL9Q0ejg5tjYM7Y/Qb3UZ2rfwSl1d11ZNB8CWV3IRIobhiRRFKxRBXhOPmA3N5JjWP5+PvCxkPM4iKDuSQQyzRpuf9Ji5sZcDXDfwJ8fDxzgMgz7N8kepZLdE3NZfB67DEALnzB0rIF/2zZc6M4vBNnalbE0E6q2wC8IqxvIyQAsNEx5FTHpSf9Jx5Pm2AL4qFGQ8rcdWOxbojPK4uEnfY9kRuhqJTVprAUHvoh1X+u3jxjdHXbuWL/Cgp6xJWI7ie9AhxOAP7lHS9e8YB+VqD3zSgIv3/HdzHfVePG3M/d+PCt9SfvYCvP32xBlCv3/h9y+ki2HevX0L+p5VOVQ8+JrihcQELf0hlyfrSHN8n1HrBVrMkXxJ00m0e6bowC+y1Ym/ce+ahuuK+7fIcrnPhYU3D9IEFvAGBfIhekwmHp9zZeZJlHlx93dyVp+Se7K64xyYfygwhR8S68mVsJ3Ib3cbSJz6Pyu6NpMAe5/zk0ozqc+sETx0NcjMtRfKsu0fL1TVbeNnXLCQwmymuCxSpgCVM4nmSUDccMphwrntq5YlSR8xJD/IbHl4oGyFiZqLqjIShciLxigCP6dJnccNoWF6PGkx5xBOwAPrn4A51GDt8462VOBO+GXyMMXdg3t9qSlWRIC6JlvokgVImUGvlZod5Hvd0ghN8KLSnuJVDC6mntuiRQdaqnnSd0+FJyqWyegLkVUjRNaA/TCJWse4tCKBZedmfUBic6WKxxqfmQHe9q2nMceFu+NSX0S8DdwDYcuu1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(83380400001)(9686003)(33656002)(2906002)(186003)(122000001)(66476007)(38100700002)(8936002)(26005)(4744005)(76116006)(316002)(8676002)(5660300002)(38070700005)(71200400001)(52536014)(64756008)(478600001)(66446008)(41300700001)(66556008)(6506007)(86362001)(7696005)(55016003)(66946007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?fO/zmhs/PYT5eSDY7bKpUjXA1Gmm/XA1CvjkZQ+nU6aqoiTuK8FgriAV?=
 =?Windows-1252?Q?YbhjJuJ4imCfl9/kblRVlI1ImMFkjxt5TstNsOLuw6VbyWAlCVUhVYSm?=
 =?Windows-1252?Q?U927cW0pytURgI2FtxfJ/bo21m4dpe/3H660rnr1kZAn0oLEa/oNS7iX?=
 =?Windows-1252?Q?J98NC8gc8nFa7jy6vQb3DdJzqwTBVfD+ICOr9mzL1OnzFsR/6bfAF9cl?=
 =?Windows-1252?Q?r/ARDsGrp1RkOB98EdGSpVCAgtUErCdldvmb6OX/0MZgB/QnE6yIsQf4?=
 =?Windows-1252?Q?hdjN00E2PZVj0/z7kMRC2skFEYk0PahCIM4S0Lq07kub10uNmHbFf2W4?=
 =?Windows-1252?Q?2EdRd0qNZxUuvd+D+rb9E7pJ0sIr3/F8KcAnu0IWwrXtZmI2AvA5L3Oy?=
 =?Windows-1252?Q?ofgaaybQavHxPGPCjvMoRCItL9DUIN0wh89pmqdc9nQxRvothvtcYWjU?=
 =?Windows-1252?Q?VCVpDrs9uFSxKTUu+H5ryGZoxtEyZMpMpwOmyIzjNbVLtfkR8uudPbWz?=
 =?Windows-1252?Q?jAkWpK0Ei5SsPsgw/FkpbVY/6eSOtS/qktbKtSA5YIiQu25Ju3BeNrQH?=
 =?Windows-1252?Q?7ReM1hVjP4xVapHn8j7uLGUkMZX00NhQoIRWK1zS9j2GgoGurONsf2x8?=
 =?Windows-1252?Q?Kl4w5dhYyzEtETJzoIA+Eca2/xGfAHxPmA3KraJXYOiUuayojE9F/iLk?=
 =?Windows-1252?Q?TbaG0VD3q363xlUifpp2ZMae5or+SP0bBqou0QQNc5CMBx8Q4Aiv0XQy?=
 =?Windows-1252?Q?UXrA4Bm+kaGy4/8P35iR9hrr8jURis2lpfcdPZ0nCKnmB/Q3CIV7kK9h?=
 =?Windows-1252?Q?1jJMgl90LqIiGsAtdivLBuezjwNsi43tDE8wwndfmX9r6Vwc17Mie29E?=
 =?Windows-1252?Q?ePSVgrELKwLk+uBL8u9o+pARyVyEQ2qSq3amRV5CUDTMkc4X1YwyqiBB?=
 =?Windows-1252?Q?Zi9Gd/UVJDwFPDfWAFWIvogO78WVbQMAW2F5ESFBqPKpIj1/38CK/kNA?=
 =?Windows-1252?Q?nuZKuKReSb78TRgaKzwJ66gjHpNPDdPtWpbZkIdZLOJgZEoSJUxQLor1?=
 =?Windows-1252?Q?3icJcWtqWH6gpKjjFwGwOpFkpYlCthvLIFTmVU/wsw0mmeF2Nd06alNe?=
 =?Windows-1252?Q?KoMbpxWYjwrMxLy1SFnFwrNXhE+3zepNopv61EoO0aaqgv6NF3vp0JD7?=
 =?Windows-1252?Q?j6vhNxdJC5GIIOTqiXrgVpMTaegJqI2nOtDYRdsiVR+C6H6qeaRnzXpL?=
 =?Windows-1252?Q?22/aOHqcDLTRHF6YFhTX8UX+vzaWCctS0Gh+bWmiw1kbe0rJ6ZosXnmL?=
 =?Windows-1252?Q?ZefS6g7Y7OJnHVHUwvbQlFC0s2oNZu18mVI0BvsYiBaPLx//GYZHlP/9?=
 =?Windows-1252?Q?7mqF7UAdipt0NKk+DREHD8kR6jREp6SE4MLrK3eBEuwm2rFP16OyeIZY?=
 =?Windows-1252?Q?iF7AiDhzwLDYSE1coVgZfgo4oLzgbLflbMf3C6g18XV+YIp/+1asFxjm?=
 =?Windows-1252?Q?dLBs0dEH5dX/v5zdpZdY7jdAz8LWVYmnH7KYpwjEc9VIhGS3daH1tUba?=
 =?Windows-1252?Q?aDo7nl4G4ZLWuB0LNtaZ0o9tKkvPtvRstDcGm8nciwhOlx4ms6eD4aYV?=
 =?Windows-1252?Q?1kTUUakLz7UuMTHru7AbruW5JY4VuOSSpwlL7YWVNu/TIl/1we6ETBX7?=
 =?Windows-1252?Q?53K0GWnO68FZ7Wr9Zf0qLBexB9Wvxubgt91ibPuler9GUUaR+NxCaA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 322d6226-720f-4490-4fff-08da7082be08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 10:20:06.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 J4BtVv7WbzC/XoxLdTuWJJMm82eU/+ZNjjha+F3n21VZI+o8JsICc0MWTDjZ6fjstqbomGW71Y8u6wfmjovD+b+CBCv/woST2cCx3j+IQC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10481
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:20:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8962

Hello Jan, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 28 July 2022 08:11
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:

Please accept my apologies for the meeting today.

[...]

>=20
> * Action items
>   1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
>   2. Check cip devices on kernelci old pull request - patersonc

No updates.

> * Kernel maintenance updates
> * Kernel testing

All LAVA labs/boards are online again.
I'm not sure what happened last week, but I've been away since today, hence=
 not addressing the issues sooner.

Kind regards, Chris

> * AOB
>=20
> Jan

