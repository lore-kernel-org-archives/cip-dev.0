Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125ADC61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 06:47:25 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.130])
 by mx.groups.io with SMTP id smtpd.web10.130543.1700808433880229760
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 22:47:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KUnhh0ia;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.130, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6QAtVReN+oKWMv4HE6qRPnQqY5lRXgVEwftcqETwAe8dMWxDPER7WudW3w9RdQhF5mxEObhOdTnnKH694rlP4Q6Zod2mCKvXGxpz/mGg5v4KgQdTjRE+RLdEe8UaRu9Q4LWRLya7+QWnU1k8FLi85JHYDhzJanXIWbX1sp2mYjfNiH4yCj5FbqABVqxLhUWBrjTs5eDbHvP67Kk0te3e7YFKrEWtnf43bG8hFplc7pW5g0ggUhPt2cI/kw5g8cShcn4P3hcGddE2FMpbhg/D4oVnTYiJ9U5bSJgyz9wq7NFn1SSeffvS+EDpS3nMKrwTNRknDNuKZ+Fv1NVRRQf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6HaSFsWiENv8iA7dpP0eOExuF9LEF9wOAVKHgSHvIc=;
 b=mpbKzk1XAEgN5hpxYt6CVOvBx8EeXhenXvGi5acATLerr5aHE/AOZ/qRncLeyXf63ZlntMaVcJ2w5qK6RXZDd05nEGyc3X8eo40n9WLmrtMkuFgu9sBz/zTqySghw/9NW5Q6Ww9h/Syi1jFfj32n8dXlsiP4fco3QIPxDqflAli6YUb6BCT1ScjddH2Kn3L6bKynIbxYtOIY2tgr8pVO4wNiMANvw7rqwXNJPGARc5WRSLlGOOSp+9j2+Vi5E7asm66f0yw8hsuACCJWXptcUpLJo9ccyYhb+snk3PkGdJcmJU+G8J1z9SpoWswn0W1Ji170Qhq5+Cr5oi7zLd/7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6HaSFsWiENv8iA7dpP0eOExuF9LEF9wOAVKHgSHvIc=;
 b=KUnhh0iar/JSWZC7JBbXxf9SMi4/4NNST+zS69fOUyDtuj2JBJJtDKBxaDEH+IeGqWITxZ7W2qE2HxNCazKMTl5D7j6iDwsXNqTZJQEdUVSsHSIArRP6HCk6MJS0Y3i87dlp4umb1INoBMtWVJiHQSL48Rv/3/Hg2G6yAVA7/7k=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by TYCPR01MB10263.jpnprd01.prod.outlook.com
 (2603:1096:400:1d7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 06:47:09 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 06:47:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: 
 AQHaHVCnCyOZxfLIuEC42b1j1b2u8rCG1g8AgACwIMCAAFRNAIAACEuAgAAAn4CAAJIOgIAAkv0w
Date: Fri, 24 Nov 2023 06:47:09 +0000
Message-ID: 
 <TYVPR01MB11279ECE77442D554F00768E486B8A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
 <TYVPR01MB112459EC45FD378EF879F18B992B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <TYVPR01MB11279801899313A2F2AA7B28C86B9A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <TYVPR01MB1124513AF13C5D46BEDA3541292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYVPR01MB1124513AF13C5D46BEDA3541292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|TYCPR01MB10263:EE_
x-ms-office365-filtering-correlation-id: 2ca7082e-fea8-4958-274b-08dbecb92e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0g3OC7H5GF4cxuSQ3Be/4KxLICnNKD1TdcNUAe/a/++j55EPkCUqcISGVeZn93QkhBpbf6cZ2sq3YzJYnVsWtFnTDeLAeEX4rmrOSqMFcalLRoLlBalMz+1Qz6r0xlbjQbcuBu2aX4Fy9UB6aPUGGchh/hdVywo/frLn09aT5I3RzjBM/+k4/z+LgCKX/QGl6biQexjd2+x1e+M1nHCF0H2Ym6awn2BInf/cu8Huiy41496xLnUS0TbExbkQ0uXZ5PLWex/M0dJ5u1bHXJd125cH+gzzsKtnREUktG5pR2y9x5hbd1BXYVobCUmmlkSm55fPg/uqNFyz99UHNbyHJVuSXj9rS+ySTLJ9M5WmQneX+I6PrljFc/IBXHzIS2+hwsLuivJj0VMRhcdf8LR85Gjoa+tp5GKHcSFdm4DhpoW10CSbyxTXdmbHa7yyUxd/G7ICyyaHLa7XYGOMYw7/kPz/UzqGA0AVr9hRFQWu50u6czLQYRGmGDqXdOnYDrWFR22Y8+oE/I2GtQqABJY5kIrySm2UaqTFrIM1J9f40Opbq5nzbOxXLIAB10VGY+ZrgOHWik1ivjLgDwZAoJI0mq649HbpmFgIwvjNrUCx+Aw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(83380400001)(8936002)(8676002)(316002)(52536014)(110136005)(55016003)(38100700002)(122000001)(4326008)(5660300002)(2906002)(966005)(41300700001)(38070700009)(71200400001)(107886003)(33656002)(9686003)(53546011)(26005)(478600001)(86362001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SW94eVoxQ29OeDNuUkQ5OWtEVUNuQXJTWTlRaHYwQzdqaXpkQ3VRbkRx?=
 =?iso-2022-jp?B?MWYyRVlsaVRSRHYrOGIxYWpoOUx2VEFrR20yNCtzb3dIYXlPaUxiaW81?=
 =?iso-2022-jp?B?djJ5Rk54ZmxSbm9KZ1kwdkRmc3pleHlUUkUwVzhDVlIvMVY2SWcvWkp5?=
 =?iso-2022-jp?B?VmhoVGNGMy9GcENHYy9SQ29FbnRseW1VS0MxUjYzTm53bEcyY1Vibm1P?=
 =?iso-2022-jp?B?Q0JjT3dEbzdXaEMzSDRrelYvYi9QVXdZcVpaZW9tMndaWmFZdmoxUHFY?=
 =?iso-2022-jp?B?K2V2TGorRGc5Mnd6c1JxYjg0b0pjVGYrUmtORjZVN1pRT0NDRXJXUFBX?=
 =?iso-2022-jp?B?Snp0bnNSQVNlYXF4UVhkRmtaZVREK2pRUnpZTHR6cXFla3dWL0xrN2k2?=
 =?iso-2022-jp?B?cUE0VS9DZ3FJQStjTUZMTFB2S0t4cG90UjhBSGxtc2Myd3RvUUJycFZz?=
 =?iso-2022-jp?B?NW9HalZDcURMbi94d1VPWmJ4NTNxS0JvTjdEV2pSK2xsbGtGVVA4Zk0r?=
 =?iso-2022-jp?B?Y0haZHNhRC9CeE5NZDJRaElPc3ZFTlJJY2NJMHlYYjdBTUp5ckFxQVRT?=
 =?iso-2022-jp?B?ZGxUS2VjZmZhSFZYeHFyZXNNQ0R3b1FZcUQ0Ty9DbmQzZmgrQTdlRTZ4?=
 =?iso-2022-jp?B?dkpPZU4yVjF6VW1LRzlNU2hJcGMxS1FHNkNNeENPOUp2NnkreHRVZFN5?=
 =?iso-2022-jp?B?YUFFZ0ppVUh6OXMrelRLMFp2RDFxNGk0Z0Rrd0ZoWU9FU0wySHJNN2xs?=
 =?iso-2022-jp?B?YzROSTFTYW5iZUI5M3RXSE02OHBmcVNGUGppT2loelIwcVRQYllpbzdp?=
 =?iso-2022-jp?B?cjMxT0tVRysrbG1TS2hqdWFMTjhEMWhkL1FGMkoyOXZXNWhiOVQ4YTk4?=
 =?iso-2022-jp?B?MzZ5aGFiNnBJQStIYkJ3RlUyQ2NaL1VSNytmM2ZTVld6NlduYktaWTFW?=
 =?iso-2022-jp?B?eUFmTEV3enJ6K2I3dUI4emdtU2ZNUUw2RXdWQnZiVkNIVFRiSkg3UXY5?=
 =?iso-2022-jp?B?Q3l0RUxKcmJQaHVEVVFuMndUam01bUJicE0vRDIrbWpJWFhaMGlWNlY5?=
 =?iso-2022-jp?B?Q21wcnltMGppZUNrOWNlOFl1YWN2cHRJVGNLcmFlMVA0NWpRRjlyV2Zt?=
 =?iso-2022-jp?B?ZzhMRTJpWnFjelBuVGJpMTFmS1U0Wk9iMEh2MUo1cGVkZGw0T2RGeWlU?=
 =?iso-2022-jp?B?OHArTmZxditBWFhYdkc2ZGxDeGtUU2oyVGtPeFdnMWJJbUI1YVI5NXgx?=
 =?iso-2022-jp?B?RGtoQmJjR1ZiSk1FV3k1ZUN4cTJIRnhlcDdDaktENGl1QlJ5V3FuR0Zi?=
 =?iso-2022-jp?B?b1orbjlXWGcwVGVUejdQRFhvbDB4cmpIbW03NGhrTzc3L01ROEZOczR5?=
 =?iso-2022-jp?B?MFFER1pVdHNJbXdUaXFYRm1YOVlBSWI0ays2UTB2UjNaNVZMZkswdGJO?=
 =?iso-2022-jp?B?Nmlid2l1SlVFUXZyYUFCQVNacjgzSTJqeXJreVR1TnM5Z0t6UlNQcC9H?=
 =?iso-2022-jp?B?dXREbDZZNlB3cVVoOHl0QkRsQXhoL2Q3UU1YQjVTalQrdld2M0tGRnpE?=
 =?iso-2022-jp?B?UUpnR0NPRW0zMHZncVFZYU8wdmFkRUJhUG1PemVyOGVYOUNJTFlib3h2?=
 =?iso-2022-jp?B?NVlVZVhjc3RJTjMzQldLRWd5WXhHOS9MbG80ZzBJeGcycEIra2tIVkZ4?=
 =?iso-2022-jp?B?blRPeXB5bC9VYkl4Z2tLTWFpNncxWnc2QVFtTysrQ3ZCODlpWGN2aDdZ?=
 =?iso-2022-jp?B?WmpyNlB1UUdZNDEyc2xkUkNhTGpKMzdoVVNqckJJK1NTZkNkV1FVVGxp?=
 =?iso-2022-jp?B?V1dXOGtDRm9zSlFUWXdTdUt2ZWlDYXUzYW9iQlZULzNnTzMwRWZNWUtY?=
 =?iso-2022-jp?B?VTc4Z1J1cjFhWFBqd284ZnN0Z2k5WGtzMTJvUHBQVVoydUY0QXBTQ3dY?=
 =?iso-2022-jp?B?ZG1UWW1JbWovWVZIaVJoMjJ0dCtPbzh3Z2VSUm9QRW9jeW8rL29PRTNv?=
 =?iso-2022-jp?B?UXN5SnVCcDFVUDNoenAvU2tqczFrMlRobmhPL2ZXS092ejlmTzFZUHd4?=
 =?iso-2022-jp?B?dHFHSi9GbEhYcWZQRGR1WEpzeWJxNjNFK3I2QlI5ekJWQnppcE56WkFr?=
 =?iso-2022-jp?B?dXhmT3cwNFpVQzhEcnVySHloT1YzTHdtSGVHdzY0R2NoM0dJcDQvd09G?=
 =?iso-2022-jp?B?MnN4YWcvVmYvc1FoRmtoTDVRYUxLTmxyVGFuNHdXd3FKTDFHMXRCRm1V?=
 =?iso-2022-jp?B?cHJnZkt0S2RMVmhPeE9WdVhPK2NWbWpGbncxbWIya25TdUJWZUJvMHJQ?=
 =?iso-2022-jp?B?RWhDSzZtaExJMWpBYTYxMElhRnh1TU5zeVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca7082e-fea8-4958-274b-08dbecb92e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 06:47:09.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHk8NbtKfY4cOkWka50iu1uBAb5paMm/n0KWZC2W5hpW2iyAw6JJAilqPo8svVAi3UROfieP7E9X+J/qhcs1TYneJQVGcs1jy4yYm3n6Xx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 06:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13710

Hi Nobuhiro Iwamatsu,

Thanks for the feedback.

> Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>=20
> Hi
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, November 23, 2023 10:17 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> > Cc: cip-dev@lists.cip-project.org; Claudiu Beznea
> > <claudiu.beznea.uj@bp.renesas.com>
> > Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
> > >
> > >
> > > I haven't confirmed the working tracing, but the compilation error
> > > requires the following commit.
> > > ef13f8b64728c clk: Store clk_core for clk_rate_request
> >
> > I have ported perf patch just to avoid conflict with the subsequent
> > patch. I can drop perf patch and manually fix the conflict.
> >
> > Is it ok for everyone?
> >
> > Or you want me to port the commit "ef13f8b64728c clk: Store clk_core
> > for clk_rate_request"?
> >
> > Please let me know.
> >
> Sorry for the confusion.
> I reconsidered about it, backporting commit "ef13f8b64728c clk: Store
> clk_core for clk_rate_request" have a issue.
> It has a large impact on the clock framework and does not work properly.
>=20
> I think it would be a better to modify the perf patch without
> "ef13f8b64728c".

I sent v2[1] with removing " ef13f8b64728c"

[1]
https://lore.kernel.org/cip-dev/20231123182854.422379-1-biju.das.jz@bp.rene=
sas.com/T/#t

Cheers,
Biju

