Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB7C433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 07:23:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.3643.1658388174324464430
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jul 2022 00:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 26L7Mjq9018734;
 Thu, 21 Jul 2022 16:22:45 +0900
X-Iguazu-Qid: 34trVKjOPakkmIMIS8
X-Iguazu-QSIG: v=2; s=0; t=1658388165; q=34trVKjOPakkmIMIS8;
 m=VxDDQQRiF9m2tAZtDDXqdx4DDFP5eZCL3rDrn7hbMmg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 26L7Mi3n009953
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Jul 2022 16:22:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDqdH632HdwPu2Rxs2yUT/9a6H6H8qBvaUw8OU1RgabY9fILrdBe4VgM2pUZmmqnnVsWflYV5JvuVB4Iw0xzGxxuM6OzPtC8wvVoRfn8hNasqP0gaQgQrrlk2y+5Wq8rWuPp1xmCX7WzefDsyINGPU+2sVvygr9kcc8NvZRLhAC/ATFchbnGzNaccwrXX17asyToAAUs3aHMSvSzYONqiRdJLaWVTsMTmX8CQ1kqULIoLrQubpNRa2J/bXlPIxwLxTbj2GIy24WwS71glXRFxkIIayylWFUkXexjc2er4zmqn/Ywns9FqAQ/vnptq5fQL/vOmzaBBhe8sGtDtQl9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI4ak13nNpoi6gFHbAj+mX0W/U8p691lNnpXcoDnHqQ=;
 b=X56Qe8IgubKLkYiONwYybpUcXOz8sgPlLJLHQd9J6OWLEHAzUeL7ZyJ06lekTKmc+ka8dEfC259k0q5ua/bsrW3yWMiF+Q8zElFuG4M+lirWg/go6qIyoRKfRcHg0f/DxZP4pketuFIWXC9VvFI44HBIulUZPaqE3APdJOv66eBpeCf6bWjvXCR3H9mWHyfSpdm7RPmxyFteSFGMoHHXR8t6rZOkbeOPUNRmGCD07wAOv86lXIA9D/5twi4YiAlnzV4pJIlOxD4k4K/3XjvGE1VtSzod5NBWSbtydsrs8Rm763jpKRtD5h9hN8YBllq3y7VmitZvn+4GnBYeogToeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Topic: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Index: AQHYmog20i4cFFT0D0SHleIYX59aX62GGlyAgAJUmxA=
Date: Thu, 21 Jul 2022 07:22:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420BA71EAB56F360A3056EC92919@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
 <YtcJMyA+/T0z+FWS@pollux.denx.de>
In-Reply-To: <YtcJMyA+/T0z+FWS@pollux.denx.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99e7b0f8-98ca-452b-2d75-08da6ae9b9e8
x-ms-traffictypediagnostic: TYCPR01MB8659:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c+3bgsb3Z8a7v3arbxMZDZAWTq1krw5Y6LCE2/++SfYsk3S9gfkQXxSukuRbIeSlqpsmPJiH4URJNXzj15a7WDttKEqyBElekkVJwOeRqsMEd/b7YJl5iX047UvjdFQXbw9ISwbUFexa+V9coDLfx2HavTsoS82ixr+BUTno1gM4PqGhuhGSzwEYWEh5IMT4bniOGg44C554W1xDhPJWsH8/RAU0kT/ft5csRpATZLqCEYXqjQ9CWsGw4YMz+WKdDO5WXcXyDi4iVBafqMxtwFvyt59u7B95FN2EWR7c0OeuC4km1AoSlED5EHXex8gxgfvwPiOvv1mGgQ9zckDoJL3TCRKjRdfXMW18dQx6bZNNCy6jRg9QVSfmQQcnK+b7DWzt95fiCz6h6y3jvrAjwxw7F+wdwD2l8x14RKd22xZkicdqj009uEkz2DbRUZTAxZOQtiOHvMIqObMWlUWy99/I/7OtXxrPS8pdh+hbTO99l89VDRuUHj3eRXVpz6ZesfWJGoitmBw24vmX1rNTBwElahxsmiwH9RbXpQbF90PWpZ7UI/IcrqJ9roJ0xCMHEjb4IECLlsNxThcktVe2zNAyVPVu0H+1a04mP28OArLQymF2L75e+VPKN4h5BXhlgOd0i6W9jxjcakk84NXjxWOdxwUHxu6iCjdn+7eywMNvfyQ3ffI0O6rGy97nDjxKAlGW9girjApUFr2ks0SkODF0ulA4EKhFmmaL9NiDEJjslAs6BaGA/oaIm3FZk+Zg0NcQBlf/PPXbEsQ31XxChRFDt42QmjK7OM1OHR16vyx7yrTlj4OPoiWhWLwt+wEu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(83380400001)(8676002)(66476007)(2906002)(186003)(52536014)(41300700001)(26005)(71200400001)(33656002)(55236004)(55016003)(53546011)(9686003)(7696005)(478600001)(6506007)(64756008)(38070700005)(54906003)(86362001)(38100700002)(8936002)(110136005)(66556008)(5660300002)(122000001)(4326008)(316002)(66446008)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U1B3YzNON0l1K2ZWRFJvWDNPbmZiUGxoZ1RvT0tzYThqVnA1YjF0Yk5k?=
 =?iso-2022-jp?B?SUx4aDRHQ3FyWWk0d0p0UC9QZS9vZGtPMlVjQzF1VFNqV0dGamtvbG5o?=
 =?iso-2022-jp?B?ZnFoSEVEUkVwTzFHY0Q5a0VnVHJnd0Q0WnF6QThjTWhvY0pQS3Y0bkNT?=
 =?iso-2022-jp?B?eUMzaS81ZDFWMlpxaWNwbXdWOXRMTXNROTRCNk5jQ2V2cGxuUFYrNGtM?=
 =?iso-2022-jp?B?czdueHZDcW4vM3hhWWJ6OElLMXpFREJXcUF1TmZiSG1XbDdQa3BLQVdk?=
 =?iso-2022-jp?B?bCtWUHpjY3VoZmhzU2VHcFBaY0Uzd1RwMEEyS2FWc3FGbjRPMmk3YVND?=
 =?iso-2022-jp?B?b3g1MGlTWGc4UnRSZDVKV2NkeW90OStQcFl4ekRnd0xKaGJlSCtiYVVN?=
 =?iso-2022-jp?B?emdlRXpiRW42d2cxWUFpWHk0cHhUTDB5a3MzcXNmYTk1ZkNnNThjenFw?=
 =?iso-2022-jp?B?Y1plbmpUdWV0eGkvRkVSYTFGelFwV1hyanpKdStFTUwvUHpvd1hVc3JQ?=
 =?iso-2022-jp?B?Q29ZMDk5V000cUI5akFweFg3eTR3cXhpV25iT25ETzltbU9OSi9JbUk1?=
 =?iso-2022-jp?B?dlFJSkpKWVAxZVFYd05nWGdxUDhzd1RIai8xbGFmM0p4NVkwbURDQ0Zn?=
 =?iso-2022-jp?B?aHJwdjVPcU03MUlzM2Z5Y3hWT1Rxd0hpb0ROblZuY2VkZFhtZWEyOGd3?=
 =?iso-2022-jp?B?NmxBYTNTR2Z1UDZVQk5hYWxUWXNVcG9nN2xhUzlzVHZVQ1AweVRtNlFF?=
 =?iso-2022-jp?B?YmRieEVIb3haY2NJWXVYSUpvU2lnUlMzRS94UzRNUGZKaEdaUUlXRTk4?=
 =?iso-2022-jp?B?R2VJdnV3bDlrVjlKZXRsWExWVFVKZ3dJQWplZnhvMERjQVN0U01acWQ2?=
 =?iso-2022-jp?B?QmlUTVE4RENVeUtZNHozU05EaWlZYjIyczVwOHlIc0IwSkFoV2d2STBR?=
 =?iso-2022-jp?B?R2VKcXFRdXRMR1BFTW1nR1phMmRISlQ3aUp1M25QNnQxcTZXbXpOempy?=
 =?iso-2022-jp?B?bDJoTHEvQnFOY2VHVHF3NVZPYjhGcDc5d2JLOTRmL3dwNlRoV1VYOGtx?=
 =?iso-2022-jp?B?cGpYanRER25nUCtBRmZFQ3F4QjBjMk1CMitVbUM0cys3UU1uOWFmMHdk?=
 =?iso-2022-jp?B?QTRGRWtIRzBPMWNhU3F6eVc0bExiK3FhM1d0QnRNRzRNamFXTVplNktV?=
 =?iso-2022-jp?B?WUJpYTkzTFRONG8vc1FBeS9KSFdIVUVvSkhNNG91QlY0WUpIaEpNSXhs?=
 =?iso-2022-jp?B?SnJWSGhSTHB6Y0RjbEsxY2dLRGJvL0JiR1VUMkJLekdsa1MyT3ZtT3V3?=
 =?iso-2022-jp?B?R20vT1VOZkN1RmN1YitITGlNcXV4aEpnZ1cxc1JzYTFuWDdrNklVNVNr?=
 =?iso-2022-jp?B?d3BkN0lySlpNVDk1Rkd4c2dLdDVXREZMWE9wZ0pDTUdFSk0reW5ySXJj?=
 =?iso-2022-jp?B?WVdpMGdQN3BQU2Y0Y2NhWDl0dmRNb0p2bE1iMU1waTRvaDdpTU9EMURC?=
 =?iso-2022-jp?B?WDF1c04vRHdFL0tOMGxkbytDemEvTTB2YXZZZWVQYXo3RkJMdk1YQ2VF?=
 =?iso-2022-jp?B?Q0ovVy8vMW9ZYXN0bWZuc0ZSR1pkcDNMUlRuR2pLb2UxcHoxTUcySmQ3?=
 =?iso-2022-jp?B?dHp1YnRmNnlPc29SSG5wb0FlbFlCMGxqdHpxSENIYlRzZFdSMDhNSVAr?=
 =?iso-2022-jp?B?Y3J0dlpLZXVOcllsKzZqZGlMTFBXMVBDUWl3enNRMUFLWENzQUJMeU5o?=
 =?iso-2022-jp?B?RzE0OVlVcERramFWTzJta3J5RWtKR21reXBrNU1MT2ZOak1RYnJtbjRy?=
 =?iso-2022-jp?B?RkdOVHhJajNBRGxiUTNDNGNJNGVmdWRXVjRXSlNLQno0RHFHSUNFYXY3?=
 =?iso-2022-jp?B?eXkzMGlCSElTNkdScndjZ2dRcXBzRW9HdmJDVUpIZk9UNmEzSkhsTm5t?=
 =?iso-2022-jp?B?M2x4UURHV0FVN2h4OG9oQjMxMmY5aWFIL0hyaVFmczhmc0VDMVFSVDBN?=
 =?iso-2022-jp?B?RjQ1R0RRY3ZqUHBuQzBRSDdZaHZQQkxtcEdTSmMyRGZxMXE4bWIxa3px?=
 =?iso-2022-jp?B?d0RwM3hDalhJSysxNXcvYUkvOTRSNVBmMzUyVHlmVGw4NEtrVnFuUmNx?=
 =?iso-2022-jp?B?VVFaZmw5azM3TUFrN3B4U3E0UmVCeC82YnE4RDhEdXVoUkViTzFVaFdN?=
 =?iso-2022-jp?B?SzU4K1M2NW5ENmJQTHNPL3ZPdGJCeWdjVDA3VEprc1BMMXBvNGExck1u?=
 =?iso-2022-jp?B?STZva0ZuRlFha0FwM2t2Y2lrMXZQNXQyd2dNTXd4R0dySEoxK3ExblJm?=
 =?iso-2022-jp?B?b3gyeVMzVDBLVjZta2lickNHYVlFc3hBWGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 99e7b0f8-98ca-452b-2d75-08da6ae9b9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:22:10.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Ats+b8oNGkFTJ6K73qHKwQjnFUcixAtoFic1opFgRxIXrLS5iSi30ne20xZSLfhozLPyDV/9tPSeScv7auWDdB0YKIhCQSGL/R5m1POD46O0BDBPs6odRG7Dqt1S4WJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8659
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 07:23:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8865

Hi all,
>=20
> Thanks for the series and for the fixes headed for mainline. The patches =
look
> good to me (but I can't test/apply them due to poor network access at the
> moment).

Sorry for the late review.
I reviewed this patch series and found no pointout.

> I can probably do that on Friday, but I suspect Iwamatsu may be
> faster.

Yeah, I will apply this series and push.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, July 20, 2022 4:43 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B""#S#W#C=1B(B
> =1B$B"~#A#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
> driver enhancements
>=20
> Hi!
>=20
> > This patch series aims to add thermal driver support and watchdog
> > driver enhancments for RZ/G2L platform.
> >
> > v1->v2:
> >  * Removed patch#1 and updated rzg2l_thermal.c to use kernel.h.
>=20
> Thanks for the series and for the fixes headed for mainline. The patches =
look
> good to me (but I can't test/apply them due to poor network access at the
> moment). I can probably do that on Friday, but I suspect Iwamatsu may be
> faster.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


