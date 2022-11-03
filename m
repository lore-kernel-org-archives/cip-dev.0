Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DFAC4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 08:25:51 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.97])
 by mx.groups.io with SMTP id smtpd.web12.17028.1667463943630189652
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 01:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=k4lZZAE8;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.97, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEWYkOaAfW7N3E8drXAVthdyPd17o7oh6OupD2Mrw863F7vlEIMYli8dqb1NBWpiDXg+igL6PBnlBA6KjYoGIustVLdk9yEpJtQeqbQ1RZEyokGs1jtkTLxk+WVlb51WfBsB+WbwQTTSsxxhOPHrJ/g8d3HaSi3us0YbjpMVlpL4JJ89EeS1nnj/waCOjr2/rmvH12LCLk0m4onY+ff0xje3oe/NQ4Imtx+N8KR43/zCWoaPm+iz+lp24l3D0+darjPl5igp5VWIGw15V1v52NIljT38+uhK1HemRmfVqb0/9aDX+v5Cn9rbIbXyHhWMbZ1xlKjSOvDgMCavAcwYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co29qJK89028oB3Odvo4uWE1NtskgTskxet1Dnq8fWA=;
 b=Q9gkktqyAP8AAc+8dTJcv96CL5+6dRZ0HC38Ej3AYp6lbRsN5AjCTZHJAtxnKXWrEsmpgH/TwDPUZBQ2oIv0OXOcVT0bIT5UXaXALXvEtQkD1vqYA6dvoSxNCFrlX/u7AjBAPNSNQ+s/aJdTsCLY25MvYzUtYDbcPITNf2hr1WPaa2UNZ0RNK7hE2AJdSvUKfTDDHZxy6bW0FD+kg3lBNJWwTydEYuVqsVDirzK+KPnF0pD8ZD4K1whCYoLUXrg6JOpOhmLegVpz62ELS29upiDKdVWqnOdt8xXVK3zUDwLcw2W1SpnXrzHnz4MMYrra0GoDnOBcW3HqEKw8x/3W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co29qJK89028oB3Odvo4uWE1NtskgTskxet1Dnq8fWA=;
 b=k4lZZAE897F6jqrysi2IhR4md/gDe6Poa3O/TueRr6fSa4N2j+FuPKsXtVF9hi8lBM2p+Kpdd6npQj/VWfHs165kxGGdCisJx2RfVHgKe6b9jPtpW3fyVo7vBrp0DB/JW3PqrQTvd9liL/obZ/9HfwLVgZvqD1AbLrwjSGuM3cg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5539.jpnprd01.prod.outlook.com (2603:1096:604:a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 08:25:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 08:25:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Index: 
 AQHY7u2ZOICKdXoSbkOgcUmh7Q95MK4s0jAAgAAAoGCAAAPQgIAAABRQgAAEhACAAADXMA==
Date: Thu, 3 Nov 2022 08:25:41 +0000
Message-ID: 
 <OS0PR01MB59228C07C6EDFBD14D7E174786389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
 <20221103074354.GA12403@duo.ucw.cz>
 <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20221103075947.GB12403@duo.ucw.cz>
 <OS0PR01MB5922ED582C321250F2BDB24686389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20221103081614.GC12403@duo.ucw.cz>
In-Reply-To: <20221103081614.GC12403@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5539:EE_
x-ms-office365-filtering-correlation-id: 5ee78a46-2190-4584-78e8-08dabd74fee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zPzoc8BJTnmhtM3hL+IwUdiYW/cJE+nmqL3lAMY9Js2q9H84TMuvyE56PzpiraP2/x6nza9S19L+pFH+JvchfMubuEk+4PpYn7tEWBrYOus/wnJn+ywoXF0kZfVF043jWsB6dupqlLPlRa/4QidE0Z+ai75dy4QDlwhcMVJ2XxQPUh4HeN4T/g5kv4DHt/fecVUpxjqQJ1TRrn7zVQLOgihg6mFlxYlZrVZZmu8jBZDeRRW13rfZQQN2tqohiW2YEm83WD+dLbCzC2p8NjOZG+10lS78XLBfXW0yWAYW5494+k+0vofXY+yd2Nj4RGnvqhk+INGyjg9tzN8L3C7WLx4cImAUFQ4UyBQwGXPFgDbmRwewD90oc36IWFG0BFl/GuD+YbVrwvS60QGEsA/7psbMaznq/FneR7LnC1bsJYy9R3WX7bcBW7ZLUKtVh8JtfyYIIJsf4q647vD/bUizW2G+OLV3NQ9KQyNQFmAF1QaOkcwTRRUc2ePf2hrLWnFLLhPmT/i3nTcrTOdqzq/FWTph1lY8TBr72KpKWGXayDv1tMpNmW9HMFfmgBtiKxgDRn3kwv72XhalDJ8WbakI9BW4VHguvAqkOCsfzqmb/LKMQYmgEIUbVBmNSWfYMXqQlW2Vsepbfmnd6LKlGrBV0K0FtAgHKCKkqFMI47EM3KJ3dhLBJzGtq06hz50r83NOxH5Wj7BrvW2Gz4nwU0Q7PKjVAGmzSsNFm1VzrKCtS04jxZYyIG2NRMPSgvyIoKTNyGVMmBX6Irn0PAurMcyksA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(83380400001)(86362001)(7696005)(55016003)(38070700005)(107886003)(71200400001)(2906002)(4326008)(6506007)(478600001)(38100700002)(33656002)(9686003)(26005)(122000001)(186003)(66446008)(316002)(66946007)(76116006)(66556008)(6916009)(66476007)(52536014)(54906003)(64756008)(41300700001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YAXbz/D035Gw3qRlBS1gbK+z4oPwUKeNUuA6hTyO6CobZd7NPcx0uy9h7x1U?=
 =?us-ascii?Q?FX/EzOtN18WVFO/A2pcwOj992W//+dAr2e27/OORzXLKI2+BPXu6goTPKGnW?=
 =?us-ascii?Q?6KfrVYUKN15lyUeHKzZ/ZWGoSOdEiOWhJXXe0v/G2pIEx8cpSIHdkrCl54Zn?=
 =?us-ascii?Q?KkOY9/AKzv9M4hD9yFVd070jvsEObou4vtQnft0LLijjkP2YuF0m+J6Ixds2?=
 =?us-ascii?Q?bT39GhBE5LfwraicVaJ8r0Bvf4t+AmmoZI52EZ77xFZx7LNMdB7y+pJcZJYw?=
 =?us-ascii?Q?dVzmSq7QLNY0FVZJ3f+T0W/lmGUpUlAGOWiwNH4CcBFACUHxECtbYmWhkpF8?=
 =?us-ascii?Q?UJ9n8svMciXPc9VNTxag5ydGfChy5pf6I3173bZwLL4OSBL0oaEQ9MBqULNh?=
 =?us-ascii?Q?OUJbQgIP7SG5QaYXDzhXNyFVw96IHTc5U7MIbCC0O73hRV57sTaVubMNYke9?=
 =?us-ascii?Q?bd1UBWVsX1IfZAKUlabYxVe8QuoKYwfIqGDrgSYVayY+1fYL3yVUC/ttK2cY?=
 =?us-ascii?Q?xtQlddklpzYdZo3g0S8A3AjTeR7XQjZS1jAmYgHLqGk9SGO3f+GxSWDKYfdX?=
 =?us-ascii?Q?X2kgWgLAE8F57nwfCRSZClyqNCYOA/HYN+mI5jehzm4JNs9YiJ0Ii38ysdf7?=
 =?us-ascii?Q?YWkzNiXTef7rCvGrsM1EohPYVOjhG2KW+i0lJQL7J1O4fgeRrU5NewQisRpk?=
 =?us-ascii?Q?UKC81RefbDmKm9JrGnV2S3P72q+Os1S8ow3Sxrwg14FHnUI4X0qmLPUmQ24D?=
 =?us-ascii?Q?K9koTbyuAEMxG/t8/RHSf7dnGkxYH+fglZyNavLHoRCqZATRS+DcqpLVALdB?=
 =?us-ascii?Q?aZtx1MGDFoJnoOTopkVnf6f518+U+0MINlqvJUMtFTXnkutr6spiw742DvvM?=
 =?us-ascii?Q?Ay03swdb67CgFTODX5v1xnk1Kd+8Vpl+14348V4OFoFLKC7bfiOyu4XcTX8C?=
 =?us-ascii?Q?swr6DBnqs9SOvL3gqEN/rNDxtwR5jSF8hgVbJ6a3/dygOG7YLQCb7VgzBDGx?=
 =?us-ascii?Q?OGnDO35Z3JiZcIC9hYIgg11VYUAq8q+so6nVgb4g03FoSWV2zOzYYGC+LiIO?=
 =?us-ascii?Q?GPRCH4nDeyA7MSrcDHZ+Yl40m8KX9/VyDXBAESYyYNkD4TjANDYSVlj53GV7?=
 =?us-ascii?Q?6eKZNBQMGCf93O3zYZW6SFHTmyE0a8N89d8HOqXQl9XphETPLq7XrvZx1vj0?=
 =?us-ascii?Q?oOuv8ZBbLNV8sBhVXPURb0vToxrwKwRjHA7E7xupHh6OOUgwVz/21yxw92Mb?=
 =?us-ascii?Q?c+Vo5SOpIW9zYk20gsh+Z0hfD+Ds5WK4m+cJ86rGMJC4taBjvQFknmelZlTq?=
 =?us-ascii?Q?SNlvF73X8oqZWY5Mv6AJuYCWjNaAjHB+5cxxtKG9W5vs9bY6GHBh5XQEG/aA?=
 =?us-ascii?Q?Z3g9O1y6LdlRQ65qmMF6V0oZtiQAjGzmCiTHhOmj9jYAgM4bsq1g0bQrMnEh?=
 =?us-ascii?Q?3itBWULiO8tGwBPtv/MlBtqhTzjRzRlS27SsYNjBOQq5/lwrbtvSSR/Ge/pd?=
 =?us-ascii?Q?aLh+7PxK9gZj+Rp0XqA8Fqs7NJK6b6nyCewB/frXZ7Y7eyvGzFA/HwBqgp/r?=
 =?us-ascii?Q?3SiDNRtuuzxTqFobzpxWb0N2KZGqzi3lPGlhlbCx97nZOHenYmUvfi6o35OO?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee78a46-2190-4584-78e8-08dabd74fee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 08:25:41.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9XW8XUW636oknkW3VDsYbEPNgwpE78tNVyMS5HClSNa6ScE2LRvLWWOPElfMRBzQIp/U+qSuyDTYH8fg9W9tZgogIUQKJEzGW1djEmiCLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5539
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 08:25:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9902

> Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific
> IRQ handling for RZ/G2L
>=20
> Hi!
>=20
> > > > For eg: if ch0 IRQ is triggered you are checking for ch1 IRQ
> > > > status
> > > as
> > > > well. Similarly, if ch1 IRQ is triggered, then you are checking
> > > > ch0 IRQ status.
> > >
> > > Understood, but checking ch1 status on ch0 IRQ is not going to
> cause
> > > any problems, right?
> >
> > IRQ processing should be fast as possible. You are improving latency
> > of the system by avoiding unnecessary checks and by calling an
> unwanted function call.
> >
> > If it is shared IRQ, then it make sense you don't have any other
> alternative.
> > Since you have dedicated handler, make use of it and don't call any
> > Unnecessary function and checks in IRQ routine.
>=20
> I understand it is just a performance tweak. Correct me if I'm wrong.

Yes, performance is one thing, also it will avoid unnecessary races
when you start handling IRQ's in both the cores.

Eg:- ch0 IRQ handler executed on core0 and ch1 IRQ handler on core 1, which
unnecessarily calls ch0 routine. See the races in rcar_canfd_tx_done().

Cheers,
Biju


>=20
> If there are no other comments and if testing passes I can apply the
> patch.

