Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E874CC83F01
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 06:22:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.8136.1693376517383584772
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 23:21:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37U6Ljkx3646381; Wed, 30 Aug 2023 15:21:45 +0900
X-Iguazu-Qid: 2rWgyA9ooVPiwRGzZc
X-Iguazu-QSIG: v=2; s=0; t=1693376505; q=2rWgyA9ooVPiwRGzZc; m=Y8VeyG1JV3KYWanyj7wRh0XtWCGPy659QbBkzibFHXE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 37U6Lh8Q1246276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Aug 2023 15:21:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+HIRBIlgWCRFw1D35wmWBBAmHl+cYHTcL3t28ZzY9HffswfXP+QXbGuuAX2TvgTg7DO5ECRiBEuJW66NxEYnqRzjbhRfIe/iEpZLtAd9WZTfnI9vRGD9t0yCLlr+hHtc6ClHSExRPkjyBslseKMYwNgkEiaFaCXQT2GrsJjFegTJIoS30pyQoY+wmHDWXP6lTdQoLKvktGse9FCn3fhJ61T35z6oFan20eFKGLcvksTX9YPgEiJ7ifYG1na7Q3ZK44ethqLuLI/R0QJt7qylpND+KvBRTiDD7etUnToEqg3UPQhD53NnI/sUQB4+ygNIGpkjg/MJbBSajjBMCWK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddMIQVVHC15ID/mxeyVHf5Ixl3W+su4m1axA/TpZk94=;
 b=FNiyDVbZTmDyppwtKbF9cyK5WsFci5ZxoIm/0g5ktupKpczkW5xUAK5Q93+1IK8RXLTaT1F/Epy9q9IsYB2jpJp2XFMlnSzrWyb2yg9/hKzE+TPTHAmJyzrJxSPRmKYvrnuks7U3203hGSYXnDGKD6WU4yyEmhddGfjshCnpYpXVXYa1F0HGGgMhC2Dq6p7bcVrL/EzWph+X2XhFDu3HqBP7MzcUwB2xpwZc7vSH7n57Zj8IZCCjrlHovJ5T5x+8nUekI1foacAhQWYa8ohg/pfsLnutmy6ito22Q/h12pkp2nTYamjOPdVJNHjbwAsqmrPmPWWEv0JDVpTywQi/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/2] Fix RZ/{G2L,V2M} pinctrl NULL pointer
 dereference
Thread-Topic: [PATCH 5.10.y-cip 0/2] Fix RZ/{G2L,V2M} pinctrl NULL pointer
 dereference
Thread-Index: AQHZ2n/7tGmC6usj9EO1MkQjXTVu17ABuwMAgACjUFA=
Date: Wed, 30 Aug 2023 06:21:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420BBED1C15C5ED88A0E9D692E6A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230829135148.173386-1-biju.das.jz@bp.renesas.com>
 <ZO5V/tvoS/u0DBlW@duo.ucw.cz>
In-Reply-To: <ZO5V/tvoS/u0DBlW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB10534:EE_
x-ms-office365-filtering-correlation-id: 7e7e0a00-4883-4959-1ba9-08dba9216077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8NzUo8Ntqp9UzK7dqNHXeRdfN3A0P5MFwSAPPRo5iOh3IUAijkF37brRIkuvnTnu0QszQ1jA8LfRy1eKmJp9SLvoUAJKndbzJNl5CtGxWMoO3RvhdA09P3WIpMapXiKKrld92NnSg8mZxKBJ0EuyyKanMRSVgCC9Ha+Nno+GeteIKyN8Iw8c6DZBvp1riwAPiqrknSL6zQRQKt7cn1W+hjo+NAO81jIuNNrcEoS8igG47NDWiBh5hyx4lYeyFWFGyfIUPJTRejPGuY2S0GNIaFA15BZfi+rtMXMplvuk+qVRuRkv1MKGUmWHCDhDsXVGrO+S8AHr8RLgR5SOOQ+JRkie/tIryBwcbyzLEQT0d6/7YYptFZ2GIW0k/Xsb99JsIpwDjtakO3mul6tVTaqGwxCpJ5mXB9KPb5NRwE4ag+f/+Wqjfmr3X8D5m8YtXYrWHTenLxSispmOt5n7piWNu2Ka3cCCXUjf6GQTaBCm/+bsqHK+7FBfX30sl16plz7FvWZrsCxvc9+nA8Inh7X5YCO3gZag0QuKMXntLe+ekat7Qvf0EvtKXkYrzOn7FNmwNkdj4eetMYsrmvptDDCfnf2qvr4PgV1qrWpGiyqY7sbGNR0tQ9yCXDw5dGcQxJhF2xkpYw6Nnmn8dwupeUpqhQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(33656002)(66556008)(66446008)(64756008)(2906002)(54906003)(66946007)(110136005)(76116006)(316002)(66476007)(4744005)(55016003)(41300700001)(53546011)(9686003)(71200400001)(7696005)(6506007)(5660300002)(52536014)(26005)(83380400001)(86362001)(38070700005)(38100700002)(8676002)(122000001)(8936002)(4326008)(478600001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UElyWk5oYmhpY01FTWNsM2FWTEtOaHE1aU1pSk80clRJVnR1Ymp0anpV?=
 =?iso-2022-jp?B?UnVDd3ExdHJUeFc5d1UxOTArWEZVWWRnemx0Nk13SU1sVW5OQjBDVVFt?=
 =?iso-2022-jp?B?cGVVVEdZNzhNQXVBQVJhTm9UbVNYRGZUaVRZS2dEL3ZkK3hxdythNVcy?=
 =?iso-2022-jp?B?b2pvSlNvUEhpMHBFM2wvTHAzU0swQ0N1WFFIaGNRMHBWbUZMbXQweUgy?=
 =?iso-2022-jp?B?WmwxbXZ0SEV0WXUydlRpTGcyaHFEbURBZ2dTUWtxdHJuWG9LQjZpZU9i?=
 =?iso-2022-jp?B?UXdHYXNnaWtLMmNwK2orZTBRenltakdneHRETEp1SC9QQnhlTlA0NHFQ?=
 =?iso-2022-jp?B?TDdmb0xyL1B6emtISTBmSzFlWm14Y3Q2K1hGR1JJbGxDZWhwYk1VVFhw?=
 =?iso-2022-jp?B?RzN6b1haVGdkcDNZaHd2cUE0RmpkME93TTAwR3FKQlNhR3h3eXBDcW5q?=
 =?iso-2022-jp?B?a2w3VjgwTVRrSm1vc1JqM3h6b2VuYWlvOU1JSjBqMjM1aHR2bk9CYXhr?=
 =?iso-2022-jp?B?NkpCSjhLMVBTY0gvUWtOd0llYXZSRDFoUmU1Mmp5eitEd3hvNjlUZ0tK?=
 =?iso-2022-jp?B?c1RBcjhyU3FqNElFSDlFcitodWtOVktwR1c2bm9YcktMRjJmekpFMktL?=
 =?iso-2022-jp?B?UmZzMVVLVjFFMzlBc2ZFTVRDWU56Vm5HWUdXNm1VQkF5WG9YYkI2U0l3?=
 =?iso-2022-jp?B?WERObXIyYmxNeU93dEprSHRHdEVHV2Q3dVo1STVQV0hGdzFueDZxdjRu?=
 =?iso-2022-jp?B?Zm5hUnZwQUlibTFhSkxDYXMzbE5nSTE0MERRYjlCOVo0aWR4Sm1IRkpa?=
 =?iso-2022-jp?B?S0xQMGFyS2lSVVNBYVN6MVVlbHZtSllsZExRbGlPYUxwNis5WUkrWm9Y?=
 =?iso-2022-jp?B?bzJ5WmNrNy9QSkFsTm15RDBiWHI3VnBJWG1WTCtmelpNdzYwaTNaWVNI?=
 =?iso-2022-jp?B?bXM3azY4T0RDaFlsaUNOWVpHSlNLeklzdjRKMWo1aFJwZnJ3QUZyOFNC?=
 =?iso-2022-jp?B?ZjhMNXRMd205VWptdUVOYUU1c0dlYWJtSUYzcEtCd1NKWGJmMEVoZXht?=
 =?iso-2022-jp?B?cWlJRFJFTTBZL3dLdG5qdFRFeml5dVN4OFQvZDBLbDhRTVdsOEtXamVK?=
 =?iso-2022-jp?B?ZlE2b1FQRDA2ZXZtcmU3cnMvZGVUZ1VHNjJGYUJ0SVQ0cTU4WFlKcVRw?=
 =?iso-2022-jp?B?eUZOZWRQZzV2VTZnMm1CV0pISWU4K0RDeGd1SHd1dXhrblhhd0JKZ2xT?=
 =?iso-2022-jp?B?Q3AvMmcwcThZWDZLRGI5QWJ3clExdTRZV2xLTDBMNTRxZnk3QzVINDlL?=
 =?iso-2022-jp?B?WkhpQVN3Q0ZrREV0UE9maFFBVXNxdC9jdHJYeGNLWjNlUGVVUGpHdnZO?=
 =?iso-2022-jp?B?V24yeHZSeXNCS09PZGNvZ1dqSkt5WVJaRklUTHFZeHZsSlI0MEJWM1lC?=
 =?iso-2022-jp?B?ZVRPUG5nWWp3aFZ3b1Fmbkw0UWtOK1VNZDFpNHdPQ0ZoZWxlcThDd0VO?=
 =?iso-2022-jp?B?STZTZW1HbHJuV0tTbjQ2RDlmZ1prb2xWTVlqYXJwdVRTbk5SZE9hMzFw?=
 =?iso-2022-jp?B?RlhRczZYV3hSbm9wdHQvRXVjQng3eUhXa1lyUlJ2UWR6NlkzSTY5a2Rq?=
 =?iso-2022-jp?B?K0duNG5Vd2VvQkJJVTkxeXFHZXQzbHU0MEZvVkdDL1N1Zy8vZVNGQStI?=
 =?iso-2022-jp?B?YSszbWVGcVQ0VFE0VktQOXdvVHRmbGRBNlFMOFYyN2E1b2tpWkFyYzkr?=
 =?iso-2022-jp?B?L202eTdXU2x4U2ducXpuRkNabHJXTW5vTmdydnBhanoxUWZvaWE3TUV4?=
 =?iso-2022-jp?B?aDB0dVZhdG8xYVZGcmhRWDJnMjlTQlkzSDNlV3RCak1mSmZGUUk5MjFp?=
 =?iso-2022-jp?B?am9ESTA5VW9YdzZ0OG4zY3NaclZwYTEwOHQ3YTFDSDR5QmtDbFdWR2g4?=
 =?iso-2022-jp?B?T2xnL1N5TkhvSlJHclBZR1FzQ0dVdi94bTQxWTRKSUxzL201dUc1Y3J2?=
 =?iso-2022-jp?B?ZmF6a0RFQktqNjdQYS9nSTE5UXBzNnhPcGN2aFpLSHBaeXkvR3ZtcjRM?=
 =?iso-2022-jp?B?ZHoxSTgzdHl0QjIyM01YUUtDd0VaSWxqanBubHBsOThQMGlxa3d3eDFz?=
 =?iso-2022-jp?B?QWpvT3gxNnQxSlJ0U005dnl1M2FSNWRIeFZRVFJuYjZ4MjhrdkRETldz?=
 =?iso-2022-jp?B?OWpvOXFOM0xkQmlqMDZybG91cGpjWjU4QkM5WUU3MHhnNnBieHg4UkdE?=
 =?iso-2022-jp?B?VUxWZEROOXVGalVDb0ozeTJmVDYzSWRFbC8wSTZrL29ZWG5UeW5GYkw0?=
 =?iso-2022-jp?B?aEpnNEJIRXF3enc4Y3FFM2dHNzFGY2lCdHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	quyIGqS1Ws7BYqniwDCX5FFq7/k3QSpDWLnQf0f61jqwhcS6PyUcjvuw19Gcej1Mlv5WrRK0pRItFleh2tkOpteYTTt9NagrII8CX78cP/dK+xgg6hJ0ubnVK0aoMhGWr8fHuToQRZRm7mdFkQIG0KvgJ8TdomuWikx/yy4Rf+PSKS3Y0bepAN4xZPANelkQ4V8fsoh6JWKUcvajEs+teANS73I2GPoL5QlLomUsDeHESgfeMZjs0KjXsDjtI02dTKmpZV7p7JBEkwR9vyGrowslj2BpN/MYApPqC0EKdQ0CEh32ZHuZYnmvCs7fLDyQi3Er2oTwCsT+ynM5q/cQwORdiBm+KaKaEKGiJJ7prFerZ07/lVPt36yBrheap/DQXpfi5B+/QxS8xCE6Gleh0wmabFd9t8i6R6U7VZvqdyKPBDN5mYrVJxTSkZWRWdfgPKVzgfuN5xQ+945FUqr6g+EIpe2qSBX+dbcHPhMsQQbxlfMvClIPWpjOlWqPkRnP3++lZxEEgZANlWqnJd7NEhDmt4n6TCYvVT9xzoT4GqVOEWZjhkT7goo7U44KS5ua44BDja5KxGG3QY2rkdNw73NqGS7n260QC61cnb8YhQdw5BjO4bB2Tz6LSI7Z6m9RCTE0jInKgWLHQ5H/8X25//e4s2BFr0mh9eZ/lpOizowFZOjoy/tJ3Xi161oIvBFEav+g1nW9NJi2QXa1/08w2Dx/KWrgz9LSRz0m/II/wrI7P0Wx3lrwxSVMbtY0S9gv1lm9t/O7DOU7NQganYWAtbz3+Or65t3i16J3csdd7jo5xuMZpurewJjr958Mez9f6nd0wPBMgMKMfdSr/NzAKPlHSJDV8+c1d3vjPvVTJJo+xUd43vfj+NAuqbrrIYYR
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e0a00-4883-4959-1ba9-08dba9216077
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 06:21:41.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3qHwbgKgoV2YittWIBBTx3B6yZSF/LW29pMAGDAayCSNUcrjzSBMQeWgZez5p9rAWOsshnywyFHmMkub9r/X3KIk9dR6ZAzf/1mZ3MrK0WicFwo+FX7NMNjDOIGd5G1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10534
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 06:22:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12907

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 30, 2023 5:33 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 0/2] Fix RZ/{G2L,V2M} pinctrl NULL pointer
> dereference
>=20
> Hi!
>=20
> > This patch series aims to fix RZ/{G2L,V2M} pinctrl NULL pointer
> > dereference
> >
> > All the patches are cherry-picked from the mainline.
> >
> > This patch is not required for 6.1.y as it will be applied in stable.
>=20
> Ok, looks good to me, I can apply it if there are no other comments and i=
f it
> passes testing.

I reviewed this series, LGTM. I applied this to linux-5.10.y-cip.=20

Best regards,
  Nobuhiro


