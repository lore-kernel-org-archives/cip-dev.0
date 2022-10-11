Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89AC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 13:33:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.7243.1665495206079100100
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 06:33:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 29BDXGHw015680;
 Tue, 11 Oct 2022 22:33:16 +0900
X-Iguazu-Qid: 34trRiaRoMIpwXzcFU
X-Iguazu-QSIG: v=2; s=0; t=1665495196; q=34trRiaRoMIpwXzcFU;
 m=r6L9PdlB6elTH+hSsYV2ntjE9TvC5iRlQCg9vONf9p8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 29BDXFwn026114
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Oct 2022 22:33:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqCkpQrA+yM7pcZSqAlYEmx+LpDxFgSoFJ1jt00KzonVVULfUI0oKyKdLEmlwJpB+aFNhpSs/+aARbJg8XgvrPrJxs+gkmywmyJtvhlAvbLvq3JSBYp0bZauU+PCwFnP7iRDBZ5ZJkreLgytxZL5RPVcovElrLPeFM3CAcHgShAUqdKVGREm5NOpZr4m0T5imGAeTLpbX2BqSd5jayAkwqFDu5fiLr04+B9CelBjnFUJLOzD2Yi1hyHT0RHxVpN8hTy55wIOLlqo6sJFyrZ7Zb1A8B2C3n/349YpTpV3ZqBfie/l6z5P/Nv5P6A7lTf5NExDJIws3+Z9oiCFktz+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18ef9j0AAb+GQb+FnlnMKcCO/KLHRi1ntFAg8Ragxgs=;
 b=JlHFbucZaMyPEpWBcNA+I0tOCOMuzZ40IdGnDdz2/9Ggt4s0NRBcqI65VYrJnMFArwCRG9TzuMpACcuQyLA7He5Sxs6yPsXB4rAdLOgVuCSkRTSfBTybElmuS+vaQC6AXakXGctLcJVYuaYyPz6Eml4lw0Jocgh8PD+svugINOVtlFocJ43C4RSroA4j+ulrigj7CwlnbqBcatCjXQfWeKaRTmRErH5mzEnDi6/0H7Lai+R/maxc23sLEOGFK74S97OSdiRDRkxA4bo8mbSS5MgALs/GAfdv3+JfsJMtrMusx8cP903vMM3JYVzBlXmO9Wwn0NJbG5hTkHmkSrCAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <chris.paterson2@renesas.com>, <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_probe() error path
Thread-Topic: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_probe() error path
Thread-Index: AQHY3M8lBWQOvAec0UigSBt/jE7st64I45pQgAAqqICAABt/8A==
Date: Tue, 11 Oct 2022 13:33:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94209D48D4F57446874C1BCF92239@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221010173833.1375381-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94209F22CB57D9DD527D3FDE92239@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20221011112351.GA10593@duo.ucw.cz>
In-Reply-To: <20221011112351.GA10593@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5838:EE_
x-ms-office365-filtering-correlation-id: 1dd77470-ceb2-4041-09db-08daab8d253c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Er4Y60XE9b8zZr6RCV9QBXjKIZrEhwaAHBjSJCOfXrtj/vZ8NghaAiJyTyBQNFOaXhXfEBfJU4He7BjteLPD/P0bn1JZ9uIxrmRCfnZU9s9kMsB9VdZ69ro6uAW5wLOaYqCjMsaTwryLSiysFHQ0WTUIXquLSkSnTKMhO8EUhCiFEJZ3DfhgS/jlsAxXGBHo+36df3PPV5ScsKho7LaFEspy61TX9TtYHeaNg2DD5PrxTl9sCprxUCXMr8u5fY6pwm0XvUkQoJxFkxUysignbX6O583Ms1f4/nOHeG2j1+2Qc29nWsvM8wJox0YAD1BCQ4hsO2NXl3DvcRD3PxIQ2T/ErQEiWQlCQH2n3JzVzYIzA2zsdzxBQbx0XuEmJwjJtADnWKD7XmahtXGhnXCG0tDDostfQB5eKQPPTSgyC4+iTCYh4GX9udi1C98iY6BvptpJgGxUpRL1RfvyGkUnS0xp+KdVto9gNJ9vuJ2O4hdlyn8XiMKvTyFZJCX39Fg3gvd2hMVt7vvH/8q8KDQ857DXE02WOHGVUZakCi1UtcswFMeHZmCLeyQEC5+8ikurwwTVL5pJ4MiDUswVjNOx/vs7ULfybRNO1+eeFce4r5DdHHk1DJCtPTqatb+cR7zTEDEnebZ3EQitpml2nYhH57g6XoQQt4ijW0wv3ZV9pWtfWp/joiH/4ECVhNMkaKgWrIQEBWcf623QXJ4U//sKpYxOYCLMcHsQGBSUjak7Xbl+o1ns+UwZSxbtGleFIDs8YHUSxIk5BAA5eU8dYyxEW3M+Sqjf2t6nH0W58G+j8t0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(33656002)(86362001)(122000001)(38100700002)(5660300002)(186003)(38070700005)(83380400001)(9686003)(7696005)(26005)(478600001)(316002)(71200400001)(6916009)(53546011)(966005)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6506007)(8936002)(52536014)(2906002)(4326008)(41300700001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bzJxWjBvTHdiMnQ5bm9YTE1tSkNZRi8xTThiVjYrL0VyMzk2c3BnSnMr?=
 =?iso-2022-jp?B?am5DM3cyejY5RzZiR3JlVU5XaGxra1Bpa2JCWkZlTGdQS1htSjhFRUk5?=
 =?iso-2022-jp?B?VUFGUHpwSFo3TVQ2L1lSK3hMajJjUzdJS2o0aEU0bkVodGJneklnekw2?=
 =?iso-2022-jp?B?OXpDQ3N4QWc2Rm9kMkxhazZUclVidVpXd1JqRGVUeWNIb2pKOGpXRkRG?=
 =?iso-2022-jp?B?UHJWOWQwZW9TZjRDYnVGei9wT0RtcTUxdG94bllnN3UyeU1SaUxGeDdT?=
 =?iso-2022-jp?B?aHorYmV3UGU4S3Fia0VzZXphT2krY3VnMVJPN0JRa0VvcGgvZ0JMMXJG?=
 =?iso-2022-jp?B?YXo5ZXQ4WXlhRVRTRy9xZFZIdW5jQTVOekI0M05mRkU4Yk5JcDJJZXZo?=
 =?iso-2022-jp?B?b1NFcTFZSUV4ZmlETUIwUDNhUVN5aXlXSjh0Q2lxbEg4OXRjVnpXdmJ0?=
 =?iso-2022-jp?B?Z2U1QnNhL1NHWGhTdGpjazcrOWFkRmR5UlBwbFlHRkVVTkRRNG1SN3lV?=
 =?iso-2022-jp?B?RHBQZkZPR25yR0xFbXovbk8vQS9kWG5CSDJjNzdpTDVhM01HTlBBNUYv?=
 =?iso-2022-jp?B?dkxMcUpPMjNkVmg3N3JmcjBVVlRBWmhrNENOK0ozY2E2d2tYU3drOVZ5?=
 =?iso-2022-jp?B?L3ptbDYxS3ZLaXY1Wkt6aC9NM1ppdU93THJVcTBRY2s5cXhuSGJHcnBN?=
 =?iso-2022-jp?B?ZFVCNTlVV0xWeUZZaTZLcU5lbHE1aGtTcTh0TFVzNXNQVSt0eDlvZDFu?=
 =?iso-2022-jp?B?TTJSQVhtSm9UL1RGMTZKbnJQK2ttUnQ1QmJuRjg0MHE2K0dWY2h2eWZo?=
 =?iso-2022-jp?B?Vkw5NjZ0TVlFQkdjVmtUY3N1VlpLd0NMK3p6TlA3bGJNT3RyWThuUis3?=
 =?iso-2022-jp?B?c2JnTWJKN2QrTytRdEcyeEo2NnlISWY0SE54aFJDMHB1L3VRaXRXQkxq?=
 =?iso-2022-jp?B?SUc4bThLaE1wMGdlUm9oeE5nYWZ5V2FGSko4VFJwWEpjRDRnbXdWRUZy?=
 =?iso-2022-jp?B?MS9tNlpRdThEY256a1FQL2g3VGRWSXVuV25KbksyVHc0MkZhZkp4YkpQ?=
 =?iso-2022-jp?B?MlhwTlVaL3p0MXhEc1c4eGNHSDRwUUZpVDNENXdYSFJ1WUR4ZnV1WTlm?=
 =?iso-2022-jp?B?RDVRUnZ3cys5TE1DNThjV21ZY3NLdVEycGVKWjF2S2tqTG9QL1JlSEIx?=
 =?iso-2022-jp?B?OGNzanU3STZzQ2pqWXAyUmk2REhCRUF4dFlQUWpwaDlBdlhUVVRJamdt?=
 =?iso-2022-jp?B?S21BdmRmdnBZbTAwZ3dnK0c0bElFNkhFVE9DdE9kZHdKUmk1NWdpL3RV?=
 =?iso-2022-jp?B?MTZzVkJ4UVcrckMyelQ4TEtHTkIyNEplemhBR1dodW9Yd3JJWVkwdnY4?=
 =?iso-2022-jp?B?bVlFWElVUTBMcDY1SW4xdDE0cnVBaUdUUFlZeXRWUXQ0elRKeHkyOG90?=
 =?iso-2022-jp?B?cGlXMU5aTFlHcER5aWlidWN0N1o4Z29ESG9HcHJIWm5rdHh1S2hwTGVF?=
 =?iso-2022-jp?B?azNjRUxxV0pqaGJpQllHL1Q4T2ovS05KRXlhajB2L3dqVzkvemxzKzUy?=
 =?iso-2022-jp?B?MG5ackJ4MVVuWXdNbkJya3lUcVVZa2hxRFZaOGwveXRNZ1I5YXgzd1kx?=
 =?iso-2022-jp?B?Ym4wdmlDclNTbWp6Zm1ON2xtZG1KS0ZPdk1FeFJPUGNQVFA1SS80a0pa?=
 =?iso-2022-jp?B?QUNEUkNidmZKcmU1V05MMWRqR2g3MCtpWFViWnNBSk9ITUpMSUlkYmFo?=
 =?iso-2022-jp?B?MEhlaUk1Q1BYaVZLakswR0tkUUNxeDJqUDVnOWRjdXJXNDlpc1ZPeHFz?=
 =?iso-2022-jp?B?UnN1RXFJQ0ZtMHgvbDc2bjREeGVwSnpPendCRTVSdHBTcWh2SVVjM2xY?=
 =?iso-2022-jp?B?dk4rRzlNajdJTnUzN25XaEtGS2RKQXRSUWJyMy85Kzd3eENlQzNTT0Fx?=
 =?iso-2022-jp?B?N3pTR0xRMjlFaFF6V2gxQjl0WHNYWEtLNzhVczdqekZNc3pXaVdIcEF1?=
 =?iso-2022-jp?B?TFZRL29abkhnYlZCalI3UGJxYXNBUGs0N1NmUXNqV21yTXdhdVV2SWZE?=
 =?iso-2022-jp?B?bi91TkZIbzdqUXVsUEN3N25rVUhyRjdrTkNHN3JCWnV5bU81UEViRlR3?=
 =?iso-2022-jp?B?WVFYSTA1cElXVzVUSnVTdlNjWksvOUowbm0xUFQ0dU1PWHluWDJNREVF?=
 =?iso-2022-jp?B?UitmeEgzNTg4bzltaHFLaStTdEloZnpKbVRiT0pCamhRME5mZ1Znc2c4?=
 =?iso-2022-jp?B?aW5KZ0VHU2VvVHhYaGJ6UzY3OUk1bWMydXhrV0ljYVBhRnZTeUxjMjZs?=
 =?iso-2022-jp?B?clh0Q21aMmlQNU9yNE5xS24yWlVSUG5yUWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1dd77470-ceb2-4041-09db-08daab8d253c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 13:33:12.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Qz9YV6tzbUq8HxZIIkRZLcooLcXHYPjlLa33m7kYTmOzJUvGm9TpWpowN0ENpRsoHLxdHwCda0MVfGgGElMR/DoOywm163iFAWzwu42Y+XGjPAZxr5Aong3fz+JLCC45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5838
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 13:33:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9718

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, October 11, 2022 8:24 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; chris.paterson2@renesas.com; biju.das@bp.renesas.com
> Subject: Re: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling =
in
> rz_ssi_probe() error path
>=20
> Hi!
>=20
> > > We usually do cleanup in reverse order of init. Currently in case of
> > > error
> > > rz_ssi_release_dma_channels() done in the reverse order. This patch
> > > improves error handling in rz_ssi_probe() error path.
> > >
> > > While at it, use "goto cleanup" style to reduce code duplication.
> > >
> > > Reported-by: Pavel Machek <pavel@denx.de>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Link:
> > > https://lore.kernel.org/r/20220728092612.38858-1-biju.das.jz@bp.rene
> > > sas.co
> > > m
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  sound/soc/sh/rz-ssi.c | 26 +++++++++++++++-----------
> > >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > Looks good to me this patch.
> > If there are no other comments, I can apply.
> >
> > Test:
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6635
> > > 48693
>=20
> Looks ok to me:
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>

Thank you. I pushed with your Reviewed-by tag.

Best regards,
  Nobuhiro



