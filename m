Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDCC38A2E
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.104])
 by mx.groups.io with SMTP id smtpd.web09.5949.1650615623697667626
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 01:20:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=IxZGowm0;
 spf=pass (domain: renesas.com, ip: 40.107.114.104,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm4zZNn2Y5mA9MsvfcfZlswdaHufmbeAlmbCjTlOsToo2xDSdJD1Wz1CxFLy8QFFVRBJ38qmyyrWY+QAmUMbkP8wdhDzSnqG4p7hlaUoHhvNDHHPtbAdgzhlx3KEByTqMuK5gH6eUmKay/vLLegP5SOzICmh4XUw6GXbqOnT/p3AD57CEjz+qrkk/w2sqHxwerzjsxfJcg1z4ezKkC32QIHyWV+JoVDg/hKieoV3hhNSR4m3rdBAV+mgSVc0rnfrjw5qyMzVTcQOMuO4N+i0IcUP6HpS1FubCcWCmiVJRFZ/ag641g4BjYAkoHq9UsV1xWrcmHkP9y9MyNyMfMX3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eguUyWDcLQNKv/Ti3ayaBdG5EbDjOMkyT7Ed6nSKqWs=;
 b=Nnu4xfME6/cMK8brAw7rbzJdO0XokCrIhdbgrlBWYAMgn+/MuNjLCZHHx81sgocRKF9m6GaMVBoO4A0ubrX7sYekB7aPa28zI01E1KzcjUeY4caOcu3I6RzYE0XyiJIL3PktDdMBNoQIOKoKBy2DnQqqqOpelMbt0AXuYu8cXvFdwUMPiuUgkqMBz366kdUStUpXbTp4Q0USgLji4oHMBeQnhoAyPUAFfMB1IYUSjXaHU/8KXR6g2hUKUkEB36ItiiNsZ9RiWtmFSAyrE19bdTJ1FGB3u9QYZYM0WX+QbPz7NNTC6RlDAj5RAyJuwt1E0BqeRrkA0Oze4arD5JBMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eguUyWDcLQNKv/Ti3ayaBdG5EbDjOMkyT7Ed6nSKqWs=;
 b=IxZGowm0t7GArWdxrg8+ofiB4e1n3wWfWdijbL+ZL/rHiLeT1XzP5w8+Hsg/r3HqoPpyBuvndpB36n7bjBsYDo7EpwnGkcHeIaazPPrtF292RJOCwDTVjlDe+42CpMPSqXlE8g3LJNYOW+HEIr+BH9Crxd3lOZYfuBfoBpJC4jE=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 08:20:19 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::cc79:534f:2195:e5e8]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::cc79:534f:2195:e5e8%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 08:20:19 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: gitlab quotas and linux-stable-rc
Thread-Topic: gitlab quotas and linux-stable-rc
Thread-Index: AQHYVgyL/OhSLn7ag0uW1WUx9AvXeaz7gZ6AgAASgoCAAAMsUA==
Date: Fri, 22 Apr 2022 08:20:19 +0000
Message-ID: 
 <OSZPR01MB8124677435983160D3BA8330B7F79@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <962465f6-8d5f-93d6-1a51-51658c80e167@siemens.com>
 <OSZPR01MB812492601D8BE4113AF1EE8FB7F79@OSZPR01MB8124.jpnprd01.prod.outlook.com>
 <b4fc1868-d545-12ac-3920-56ead88c8f79@siemens.com>
In-Reply-To: <b4fc1868-d545-12ac-3920-56ead88c8f79@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ce58aa8-7a92-45da-3820-08da2438f07e
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_
x-microsoft-antispam-prvs: 
 <TYYPR01MB6603DAE6A441D19238A1A7D6B7F79@TYYPR01MB6603.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hcH81beViLFKFaVuqKnSAedmvyBeTmD0nH3PROG4NW0IXN09BC6CFLAqLvABWhrhGT230O3PvyyYyR10OC1oWA4Fa5+Xl76z4sQrZVCFPriwSb9HwfsVDUDY5XV9+PYomqvsHHVQBtxAQzZLowRC/lJdFXuIEZ+9Eem8z7KzjqMM2Z/l6gdzVPmX2VRZeUSfjKpflJPoV2+GLCNl5R5UIyxK6Zrhpj9zf99PeW6ORYrzqzE5wZCW1+O8MMPiwgm9l0Fnv80dVr7wv+b1r+D5FZZdBPOoBYr7E4pBJoMc4Oezi+35iXWGjpYbtuIaJfKl/wg7Ck7MElPYGv5kpGTq269oQ/SgSh3nCKU4ATOWvmfu1f+H9QuMs5LwCURToZW4UD53mw0vFSSUeCxH96Zd73kyblAMyijdC7NMj79tZphbDEJueb7cFJ5kK2QDoUG6e4nGxw5NwSqcX0BelN/2sWN6d9YW8aTGr1lEU20idwpxT0IRp9wGQ31BTD8ghwakIMFlwINBB1dQvjPW7jqZXuCQLqhkTrOtbf8guimzrrQmkV3ZzykZilxlKMHsAvOcdziq0Hh2FO27Fww6yrepJjl0U/EzmYkgtLeVsVsRv3RQ7DlpK4TqSPL/IDFOqO3oFk4/034a2dYi8dxFJt9T10kEYh1yiLKdnoqRthiRCPbciWYZWN8TFOZsKzjMR+jNz2sTSHLV1CzXj4RuVBRF2Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(186003)(2906002)(76116006)(5660300002)(83380400001)(66946007)(66556008)(316002)(6916009)(558084003)(33656002)(8936002)(4326008)(71200400001)(8676002)(26005)(7696005)(6506007)(9686003)(55016003)(508600001)(122000001)(38100700002)(66446008)(38070700005)(86362001)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?HuYUqYSg/CMydtVhVedSP83erP2f3s3coOgyJo7TbI6ChrjEDvyjuBD/?=
 =?Windows-1252?Q?1z1RfgPl2Ie89TGQAnHN1mLXnl20UGFP9xBHKmHg2AIwEKXolznvw8r0?=
 =?Windows-1252?Q?IAStXgII9Z4p9Yw9So85Ic0Fj2dVosKwoCy4G+rYUHxV6cR0j4LFmZVm?=
 =?Windows-1252?Q?iygv4DCNsAWCBYx4AqbJTMHrykbJ40ytjxqUki0dHnwgLAeC00zomyfU?=
 =?Windows-1252?Q?CW62aYn4v8c5rP+SqjLxDm7jdmxeQE6c53VfPtscRnJGGjPBKlXGHHmb?=
 =?Windows-1252?Q?lE+2YghoR/smGeExBLgvDJ0Hxin0mbggq1fBfnnqfOZxwC6+UdiH2uZz?=
 =?Windows-1252?Q?SOn781YqF/j05JdoURe/v42EuhpVRcYriO5PzUVpT051K9+RC44nR1aJ?=
 =?Windows-1252?Q?QP9x4AkTEKNuhaUd4rcDaot32mazN9UjqaONGQu2YNl1zhCifXjCHUlJ?=
 =?Windows-1252?Q?R10ufCKi2zppa7Mvd0rC3DT+Q9zE42S+EcMak2YYaHlc+8+QP5NhCvkg?=
 =?Windows-1252?Q?edLZPPKiPgPwpXh7P3hsOJne8lGxtsvkj7MPmmGPukEwHP0W3+X4UoiZ?=
 =?Windows-1252?Q?ZRtzMVUALdond8atDJmzf3YyS/84R+8/DWHQlG0ZYk8jTdMMPYW/QuKc?=
 =?Windows-1252?Q?NmjmXMERP+TOCWaVqFvrbtZHq8Q0UuTupd3AXSwOn+T5oL+9f90kutT5?=
 =?Windows-1252?Q?fsHbvAvRinNfmLsJ1kdiS+uNtbCipVuCUP1vUF4mKx5IQKqXq0ikWP4h?=
 =?Windows-1252?Q?+zXYIvHDf8myZXyI1Wj1aoj0e9tzGfXyQgz1+knaGxAtfZvbWkvcrIFQ?=
 =?Windows-1252?Q?sqI3vtj6sifgaR/CtiFUBhszDvO7T3r1n9O23Rqlwke74B+hSBakX9T6?=
 =?Windows-1252?Q?9sfLpp3f1iVZB0Wsb0JRFvav6rAARk/X8kNy3tC+s00aDkUSEK75dorV?=
 =?Windows-1252?Q?bbVbgUp24bY+CgzRRc+Pd934g1fVnK/g+9eqnf0KNpY/6XAJJqRG0FQe?=
 =?Windows-1252?Q?fDUp6D5hE7rt7OD9MGER2zMbAByJPmZZ+EvhUH09V/0/KDY42uVrJLpU?=
 =?Windows-1252?Q?yCTFP6mEmJ/vMyKe/gMjlNsl5w4JloXhdmfaG/qZCQtpryQ5ezqSgp44?=
 =?Windows-1252?Q?jC63SbCkaJCEUHHQ+xzLibd0/jFsy/KwiNx85Hxr3zPyC5vX3XKC5ez0?=
 =?Windows-1252?Q?Dy08MF5LWGD01aT+X2Ay3cxLXeXlCQXIFGlTT+w6EH6skMTa/p/lzEwk?=
 =?Windows-1252?Q?UOm0qj8fQSAChiS9rFQe5nAOd5z2la3i/G9lR+S7gt7By3/MseJM9o2P?=
 =?Windows-1252?Q?qfPdMVs0Afc/b0AfVqsbJGpXRO5fn/AAw+aA16pk7dk4pLp/A8bykdop?=
 =?Windows-1252?Q?Bh5rVGOvmvDbwTjIidKf2QJSjPalyKXumg3BhGMxpPit5VFBSVcLUTeZ?=
 =?Windows-1252?Q?PlGLDdppmg0PUWcnKVNIxWSdn7IbLW/EnYayvgD3jgJQR8aOgyxXs54T?=
 =?Windows-1252?Q?zgKs2D2CAXSYQvxPyfqTF9kxYZrIsZHQPZBT3Wiow/ev+oz30Q/ojwfr?=
 =?Windows-1252?Q?XCx+JMWz0snCOyVGpTsQ9gZhDQYgFZhbx4oXJAyYCYtTtmzuCY3ISZsE?=
 =?Windows-1252?Q?oerRX7SePLm0Gt5q9QV7Z/ZxsrDR0qS8Ma2PSqNaiH+rFEjMzmsIK9pL?=
 =?Windows-1252?Q?AEf7uERJXE17QphL6kvgSKGGQbhck7mrpSnunEVgSAK2oqRpj3XFwWUH?=
 =?Windows-1252?Q?geubjegvQOEQ7FpTwuaQoSGdDh4jSUJp7viJ8wxW2vq1Pvt/mEzaonvH?=
 =?Windows-1252?Q?iRkrqq+uI5V55BJBj5uUVu03walK/28sD3OHvVZ2zDjM4q2pODbex/ln?=
 =?Windows-1252?Q?ZQqoAxVZAhkgP9NqVZ5G1biWvHA9pl8pqVE=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2ce58aa8-7a92-45da-3820-08da2438f07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 08:20:19.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 GOlHxHAtW5yoQpEfFFa6LzGBP8Jw0w4TCF4E71pod79ieCcWy64idT9OQzx2Mpy3sajxNo+BdCDHIrOoHLHV9fiZkP1u+WiCh3vP9rJY02w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8183

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 22 April 2022 09:08
>=20

[...]

>=20
> I've also clicked "delete" more than once now, but it does not want to
> die. Maybe open a ticket?

Done. I've put you on CC.

Kind regards, Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

