Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6071EEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 11:05:55 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.120])
 by mx.groups.io with SMTP id smtpd.web10.10325.1689851149029719748
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 04:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=BzRUcpIU;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.120, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgIF2EiLC3cW650YtAnq8vQlu4b0lir6RUWBdZLGSy2tmCH6K9F5YX/g1y7carYw9BgNqB6aTny3TQDnraKqHVFG7y6dwx6uuzd4oBugSZBXaUyNRT3c5qDBjV29MtoEDqWvs6Fc/tgaVn/gRhlQaB0ar4HTU0tC7WuWTVJVXwdiMgtiCnc0uABWxHtNXQysWZNe7OiLxp44UYKnn80nIehvwt7bsx8xFDBYVQzxHYYqV+6kXUJIanyGdyOI/aXNkIl3qRIljQdb+P5deWogdUHzZJK1mCq3QikadalQibowlYxl1Vn/1i91PMBZscYafvskdcmTxXUMLCU7Av9Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpCReK3dxwBXZ7c93n9ipzorzfy3bKz0MHZhC7Mcwyg=;
 b=NmzGbrpSP8nUbvUZIY85+J/6eeKHAoWUFdfQf02ihIqqVC0gasF84uDAP0bfOHstNxP4uF+21Svl/Tp9hlGO2wcpiJpEgCUrrK7Ab0TIKO1G/yWxGMiI9K4B0lnKD758B2tjHtmwAKV6QnCFw0RTduqzdYNPvvqKkebKh5ycD1a8gfoAysl/6cmpuTmrZje5RjNN6gVAQUDW/sbWMLuv9C9CQbrrrbsjEe8nfPMsk7pn6rINI1NA5TqifzFTZmhZWBo56zsOY/XMd3k04aoovG52RzLMR57gQ5exNeh0/UM+pzWfyCyT6guYV/jOhmUApXHDuXeVt2R2AM70z0fANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpCReK3dxwBXZ7c93n9ipzorzfy3bKz0MHZhC7Mcwyg=;
 b=BzRUcpIU7QaXN2hTUedaW0JC7O8A1xOI0kv+QG+Cva7CMYsdSDlAekaFavCzY0S7pwm4Obvt1LHa4RThWHb7fz5CsWF6T5HeQZCIk/hBIjP0DY/58P4BTp8qpcPSGq9Ub16XsiGN0czCunGy3pz79TxlNUTJnp2h/EXHaa9SJk8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 11:05:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 11:05:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Thread-Topic: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Thread-Index: AQHZuvDqpQajSixQ/U25W2tLFlIJRK/Cfk0g
Date: Thu, 20 Jul 2023 11:05:45 +0000
Message-ID: 
 <OS0PR01MB59226BFE2B45FE21E9DAB14A863EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942068546B387A153DB9EDE0923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB942068546B387A153DB9EDE0923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8124:EE_
x-ms-office365-filtering-correlation-id: d1417b75-7786-4544-7375-08db89114419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KneWnIIyJwWTgKgrUKX1RzCkmWZqRjw51R89wNXlXThums1ziytza/zdo1Y6UeSW/zIZXx14FdNSHdfwUnrhaXInELj0rLNJvntdgkfZmqkoZ4905bMCascWY3zs+zpf3CC8+FjCKtdG/h/HiAouaDcu970/eTd6BlfToX4KO2obiKKyq1x3A1+Sx1Dt0JzaUrB+WBW/r/ebT6UQPOxAISa4+VWxR+WuwgbgP4pbP8/RMVDN2E0YStm+GBY+u3sfUu7JU79IqKmyp3FiLTxXyYY2XDKQURZOufKWA2Cd0/CZqlJilGLi6V8dRhCQpkHwn+1fIPTC8YOvonx20sr5+akECrYLp91kMVdE1UW16hrPxzT7DEKBJeGAw9VN4VvRMTActc9EEl4TI1Rz3BI6RjO9jHrgCgwntvNyXPco+0wPsts0Yq8FNddeL1L2BOm3ijx97Cqwioz5kxE6bfgh7hmTLT9ifc4ubXISXezRWEKKrAVjCoBc/28r8OPFvnKwyHhvh/ypVHQ1cSTWrmmJS8yNZP4UheRn6E7VbNM8anBYLdkIgwevkZ6k8aoadDtzf2bWqQW76qackBAsBMtN4vBjNC37EYaGe0SJNGrHllA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(53546011)(107886003)(478600001)(110136005)(7696005)(9686003)(55016003)(186003)(6506007)(26005)(86362001)(71200400001)(122000001)(4326008)(66446008)(66946007)(66556008)(64756008)(76116006)(316002)(66476007)(8936002)(52536014)(8676002)(38100700002)(38070700005)(5660300002)(2906002)(41300700001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RTVDdk40QlBVR1ZNNHRYdElFTmdqYk44TTZTZzJYaWEzNW11WU5qOWRi?=
 =?iso-2022-jp?B?VWFOdnVCclRMOW9nV0hxZ2RMbGM4TUtxaU4waFBFaHUvOE0vREppbGQ1?=
 =?iso-2022-jp?B?KzFqakd3QXdPbmVtb0FyeFVBRk9yNUdObzRqWms3Z1U4NWJnOWhSYS9Z?=
 =?iso-2022-jp?B?ZzNHWTVQSnRKRktqUUtBajczRkxZamx3My90TTB3bHhjSzAxR2RjUFo3?=
 =?iso-2022-jp?B?SDdnMTZMQU11c0lWZ3ZjQzRQc1NXTGM2eXVhVk5JY3UzQXNFUTUzNGhL?=
 =?iso-2022-jp?B?N2gyZys0OGFXWURSazRXVXFLdlJJY0JTYWp3R2xBSHB1TXJaL3o2SCta?=
 =?iso-2022-jp?B?RW5ESDNLYnp2RWJSYXNGcnczTGhDWmVPbGo5TzZKNnNvUTQ1RC9DOUlR?=
 =?iso-2022-jp?B?OVZySFVKem9KeDNzYlpwS2ZXN3pJeTkxYitNaXdYTUhPRFFydXdLSkVa?=
 =?iso-2022-jp?B?WmFKSkZSQU5wZWxKU2Fza3hmUVBZajNDTnVhcFZaMVljTU1BUWFuclRV?=
 =?iso-2022-jp?B?U2ZoMERRUXBDQkt6cHV6c0t6OW9WNks2bDhJM2g2Y1kyVUxsTzJwK3o5?=
 =?iso-2022-jp?B?d1JYUVd2M0dZSG5qVi9SZjVWa1VObGtwOUR5WGljN21YUENPV1lQL2cw?=
 =?iso-2022-jp?B?MnltM05Ganc0ZTV0dEFrWDhVekVSc2UwdERFaVI4OUI5YVdxMzBpS2ox?=
 =?iso-2022-jp?B?TGtOWXJocWZ0T0VHdHIyVkZUVWZjUWtOb0dZaEFXUml1V3lLMFJNWXkw?=
 =?iso-2022-jp?B?Zjd6WldoOGFXd0d1bGptRWk2WnlKSkxBU2NWdGh3MlFObDlYOUZoSkQ5?=
 =?iso-2022-jp?B?dEg1UXlDRENiSDRUdUV1YmFydjRIbm5SRURNSVVvUnlaa0MzQUt0ekZa?=
 =?iso-2022-jp?B?aVk3azQ0UlRkV1NjOStPRlhtNkZjVlMySldONmhLT1drTVVQRlRsRE55?=
 =?iso-2022-jp?B?Tm5sTGJMdFBEQkM1MDR0OTRKRDVPSHZOa0oyZHF6YW5xYkYxR1lkSU1w?=
 =?iso-2022-jp?B?VnR3cmVUa2VXekZvU0F3SFBkWjdzcVBFZEtmblhnNUhKKzV2emRKQmVG?=
 =?iso-2022-jp?B?R3Q3UDJKYjRxUU0yVWlKWDBHSFh5VVJOQm93TWFTZDBvbmZRQUZmV0Rw?=
 =?iso-2022-jp?B?M2JwTCsyRUdxQkJqbjBNekVnS0wyZ1Jhb1lGUFh3VUhNb1pOTXovWk84?=
 =?iso-2022-jp?B?VFRuMVJzRUJWTDBvOWlRYkhrNE84cXJGNFhoVzI0R1BMU3MvQVd4dkZz?=
 =?iso-2022-jp?B?R2UwY0FMWGNlTDlnTkxJa2dJa3RrMUtTZnA4ZHpTNTB4Q2RGd1ErOTk5?=
 =?iso-2022-jp?B?dHROQXlDQ0FLRTc5N0xlWGUyemxIcHVnaEZZU05rMFUwZytob0hodWsy?=
 =?iso-2022-jp?B?U2ZhVzN0Zk5meVczL3M3K2M2UUkyd1ZPRFo1UXAwVGNJTUdWQ2pid2h3?=
 =?iso-2022-jp?B?NVJIelhhY1UvdGFxaGNuSW8xUitzRHphUDNieHNJNVN1N0lrcE91dmxv?=
 =?iso-2022-jp?B?SWtqNXJRdEVrMUlKbjhkb3FVZUFRM1FRVTBDWS9LNlU4eHAyaytNa1gv?=
 =?iso-2022-jp?B?T3pQSm1GNXcraWZxQTFEVVJnM0ZIVGFHSHYxTWJZeDJTaWpoQ1RRcGo5?=
 =?iso-2022-jp?B?ZHZ0N2ROVE96Q1BpbVhHR2xMK0lYemEyMmJBWThscGZPclNwVTJ1SEJk?=
 =?iso-2022-jp?B?TDdPbDg3dm5jTW1lbHhZU2lBVitKemZOUmw2TVNtYnlYY0JBT0ppakhS?=
 =?iso-2022-jp?B?cVRUVnJhNGRJRzNzdzM2ZWxVb3F1MXB1S1daOFZiS0JJRy91N3RkVG5Y?=
 =?iso-2022-jp?B?WHl5N2oreVBteEJWTHBYUkdmN3BBYU1MSnphUlFyakVWZWhrYVNONTFl?=
 =?iso-2022-jp?B?TXBRV3RMcDJ2ZkM5M1hnOFR0a2drdTg0QUhaVHJnNHBrRUZwZ2Z4YTJr?=
 =?iso-2022-jp?B?Wmc1R2RveCtNSmpqZGhGenR0WGlXL1lCYnhDZzl1ZmkwWDZBRElzRkZ4?=
 =?iso-2022-jp?B?ZTRTT0NUUXMrWGtOYm9DMzBGVkF3cS90enlYdWk2QlBTVlNEc1Q5QkU3?=
 =?iso-2022-jp?B?MndKY2ExbzZFaFRuYVBvWVA0M3ZBMkpYYUV4RnRuYS9aZE1aWnBNL3VZ?=
 =?iso-2022-jp?B?azZwcFJUeG9RWWQxKzVYRTVwUXc0MVFXN0prblJuWHNLUmdaS0JnU3Jl?=
 =?iso-2022-jp?B?MVRJUHdndHFSd21YU2hEbjk4YWNrN24wSWZmMnBXcHhoQ3FrUEk3OTRr?=
 =?iso-2022-jp?B?WmZRVHQ0K2w5WTJJN0ZqVEVzMnFOcDhHMUR2anNIL0NxMmYrRmc1MkxX?=
 =?iso-2022-jp?B?a0g2cg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1417b75-7786-4544-7375-08db89114419
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 11:05:45.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgsU9rQ+iY0QNQ1TJ7b3zw8U1lxG23ezug6cxAf02o46j4zm3ok/pEOth0AUV6OGSdo4qMWj1C7LHYcYuDJuC5Igj5rdDIOe5rvfXIHEanU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 11:05:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12463



> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Thursday, July 20, 2023 11:00 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-
> project.org; pavel@denx.de
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: RE: [PATCH 6.1.y-cip 0/6] Add RZ/{G2L,G2LC,V2L} MTU3 PWM
> support.
>=20
> HI all,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Tuesday, July 18, 2023 11:11 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>
> > Subject: [PATCH 6.1.y-cip 0/6] Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
> >
> > This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> > MTU3 PWM driver.
> >
> > All the patches are cherry-picked from the mainline except patch#4-
> patch#6.
> > The trivial patches#4-#6 are cherry-picked from next.
> >
> > Biju Das (5):
> >   arm64: defconfig: Enable Renesas MTU3a counter config
> >   pwm: Add Renesas RZ/G2L MTU3a PWM driver
> >   arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
> >   arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
> >   arm64: defconfig: Enable Renesas MTU3a PWM config
> >
> > Lad Prabhakar (1):
> >   arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
> >
>=20
> I reviewed this series, LGTM. I can apply if there are no comments.


Thank you!

Cheers,
Biju
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Best regards,
>   Nobuhiro


