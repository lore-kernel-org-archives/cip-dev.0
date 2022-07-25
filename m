Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54EC433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 22:52:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.188.1658789553222295521
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 15:52:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 26PMqNnt029794;
 Tue, 26 Jul 2022 07:52:23 +0900
X-Iguazu-Qid: 2wHHCGtN74JSvgzekb
X-Iguazu-QSIG: v=2; s=0; t=1658789543; q=2wHHCGtN74JSvgzekb;
 m=kH7Xrz/669q/Z5g8UCLwScq8IZFxFMZRIe2OMSXJcls=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 26PMqLKU002697
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Jul 2022 07:52:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCUCRcFqsIvJO5KQPe4uoC1x9wCZMTy6BUDIVZunqo3j0KiC/BeLPEfM2u1Q4wPrVgoNXRt4l50WK9CO3yjowezrHTvC1vVVf46WU7zhbYFbeoTrjWgM+Sw6ywOEXLWVbQw7nGTaHWnP9Bxy1TFpBXY3XinhSjfD8j2RRHCO3oG627UZOOhrJ5zYpiFmOKTUbL+2QfOnGfLdK1LFkTzT6pey0RQg90GnHLJCWX/m/2AbcbyggUtN99l+ZmZ+ejxDHoapqvobnaqViDtYQMR6ed+uUefvKoU82hXFLRVdCg64Ly51Gy0547M9nKxRql4a3ZAzuxc/TretBVGpQdNzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQknnWI4zwxXKzaPK/G0G8VAzXwktcGjttoAl3a4Y84=;
 b=PxTVgfYgOSpyenU2wXX1Er9EAPZ3it/YmNBGnBr0B0NjlDbxXVubkKmQdiaP25d9qbyl9ILk+GyN/a5Y4bUs1qC9x0eMWxcOlkuBmGChaS7btES+AJo7fPZBjUt1FYE5fczjOPyvIvvYK/HqcDEe2auFsZxWUvF2Rh7rYNIh+0r550O9p55j7TpzvWPp1SmMVJ/XqyRiS49qGAWHdMapnQb+gOSeQtc8ZRIxqvfZehDzWv4MJ0hEXY3Mdtc7Z4omTKWuRLAHBcrm11wFkqihIY9MCtqjv9houqjqcDFspPeCCsOSaFh52yRzOgHDdWBkxgoqLvABKcJo8fnwwB+ZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Topic: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Thread-Index: AQHYmog20i4cFFT0D0SHleIYX59aX62GGlyAgAJUmxCABpLXAIAAuyhQ
Date: Mon, 25 Jul 2022 22:52:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420D7180FCDBBAB0F37D54C92959@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
 <YtcJMyA+/T0z+FWS@pollux.denx.de>
 <TYWPR01MB9420BA71EAB56F360A3056EC92919@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220725114110.GA4516@duo.ucw.cz>
In-Reply-To: <20220725114110.GA4516@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d624915-2744-4b98-c326-08da6e905459
x-ms-traffictypediagnostic: OSBPR01MB2583:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TmMkbYLWksJGBM6Sdq823dX/h6aVMVD20WF1MwNxDzrlP01OdEd4pqbK0JQOwZ3NRROusNPD2bcmb142ycJXJBtR3GT+jkGPJ8WNiZd+nEpfBtvxy7fpe1cZPlSNreDKNqn334IElhdBmNemhJRxT+lQdZd3B0j9+tvZVAbVDVVkC2QGeVfTNoZprzkmyEvU6672J3N6z6+LV3Lo5qh9rIVMgz205LCFWm+6ZhtMDH3qZ6CsHXRcpykc6HoC+aTT1QU5AvM3txa+fzw/K8Z7ELyUQro9hC7UopatU3fLFAfsDGpLcQWW03YW/ulHrwvumoUjYNx2a3xqYMBxRyc0NDiihDaiHYwKn7+yf4JoCe6FEQWAzpMORehu1hUf5Wn37G/8MKmDotKpdcig5/1cF/CTK1yBs+/oSo2RcqPutL3TNm2QTSQTFeRHPBzcus0a6YNz1z9QPgIYJ3mARKREeSV8GhaZHU56UC82sSvR9ecK/+E90D/oRbXdtHaTs2eDxeScE/cdRpjFXo2ojnkprzZLO3sk7TkjF8QdIHFg2c/ic3cG6DNgGMKc6+VjkALdmcw09ZrmvgJ1GefJGoo4LbdaK0AQedrvp0JshlQ3M9Hpp7lKY/cKFgvY7UqHOKsO964F+hAGbwW5LNLIiFS7iCnpjMnBYPBopPwrHF46hZwH3NZ2Avpn2ulZBT0xz9ZtHMjucedjLKy/MOFuLovuSJ7Ug7tJ1/UR+eudvc3xKDRbstYcP+X5Itas59agrkt6RhEG3Hlw9uwjzlQq9bEWufKhl9Fl/VsSjHv6im7OLcTi+Wlxuia5sLlyMXDu2scf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(26005)(4326008)(53546011)(186003)(9686003)(8936002)(71200400001)(478600001)(7696005)(55016003)(33656002)(66556008)(41300700001)(86362001)(122000001)(38070700005)(6506007)(83380400001)(66446008)(66476007)(52536014)(54906003)(8676002)(6916009)(64756008)(5660300002)(2906002)(38100700002)(316002)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cFZkbW9JTUlPVktGcS8yZytZNGZBSkZ3dDM3MWdrTUNsM2xxeVhzN0Z4?=
 =?iso-2022-jp?B?TG5pUHZGdkM5NHNHSG9xM0M5Z1JwcS9zK1hFdlgwZ2dQVEN5NlBNc1Fj?=
 =?iso-2022-jp?B?MnRQVnVWTUtlYTdiTEVMaXl4NkVTU2xNSC9lZXp6bkJsSm00WDltWHRH?=
 =?iso-2022-jp?B?QmpwUWtSMFUxVmFuanVmak84TVh3QU1DMGdOVWhKZHRhU0RCcnF4YzdE?=
 =?iso-2022-jp?B?a2RVYjRMcjhaVWNhd0dyU2dxdXFZOUt3T0NlS2k5dlZIRVlMSWlKT2wy?=
 =?iso-2022-jp?B?TVpqWjZDQUZXdUhkVFpLakVvYzBJeDJyKzFwUityN3ZmZVVneE9QaHhx?=
 =?iso-2022-jp?B?VmdpRFErVXpFT0xraGVVa1E0c3o5aS94YXJ0UC9JRFMrSkhEWXQ3RDU1?=
 =?iso-2022-jp?B?NGkrT0xmVGxKc0FnTXpSZWtiMW9qdzI5N0d3VHl2VXhwaWpiRFd0ZXFm?=
 =?iso-2022-jp?B?OVZHMW9BOSt4Y2puY0drUmJFVWlEZHZGRk1sREhvLzBrWUUvVHdScDU5?=
 =?iso-2022-jp?B?WjlKS2RlR2ZaM25CbTIrVmhrUjE5M1lXQXU3cnpHQ3FtMFhPR3gwUU4v?=
 =?iso-2022-jp?B?bk9PRXJkUzhXQUNaR1BLSWhEd2U1VTM4NmR6QXlkazdGak4zeVhOZm4y?=
 =?iso-2022-jp?B?YkR1cGl4VkRQUHNIVVJZTE8zZUdNMElhUzJhZDlCcVA3ME1kMUttQXhj?=
 =?iso-2022-jp?B?eTNIVGdiMFFiVmJ0cE8zL0hUZTZnb00zRC9DT0ZBSDdwNUpUUUxBVldZ?=
 =?iso-2022-jp?B?OTJQUUUvZzNpUWwwWHMraUlmMEEvaU8zMGhjbnh4TCtOM0NrKzZpcU9I?=
 =?iso-2022-jp?B?b0xRaHVUSFdxSFRsZmZYZm8rQmVQcHBaWVg4QUdHa3o4YjVNZmtaMEZM?=
 =?iso-2022-jp?B?R21YRHNma2VZR2czakI5d2VOV0NUSHVHVGdScG1hVFFlRTM2MkkrL1pk?=
 =?iso-2022-jp?B?cm1MUTd1Q0VvblI5S2VjdFFqWTNSWlVMemtRWGVnTlc1U2JZSVMrTnVD?=
 =?iso-2022-jp?B?Z3RyeFdmOWszUGZRNG5FN2dzWC8yOTdyWDh6UURoalJHN3dlTWFHVGdS?=
 =?iso-2022-jp?B?a3JidXVtdXRTSFBraG1NZ2ZBWVRmUjRrRmVrUW51M3lHajFQMFo2K0Jq?=
 =?iso-2022-jp?B?aExnNmY0N09HOEpWU3RVT2xuMEdWMkpPREtTNFJaWThXbTFKZmF6MFda?=
 =?iso-2022-jp?B?VmpKVHZTUEhxczlUM2lHRS9WMWdUWlEwbUNOL3ZURHc4dlZvbUtPVzFJ?=
 =?iso-2022-jp?B?U3FqZUdlTll1T0w4MnV5TVBYR1B0UkpyeU0rTmg2L1N6aCtmSUFzNWtE?=
 =?iso-2022-jp?B?UloraFc5elAxZTM2akhFTnQ0Nnp4UkFuRUdublFKaU5menRpK0ZJUmh1?=
 =?iso-2022-jp?B?RkIvVzk1SXl5QlQ3bmVnYnJFcytDZkw1SStLL1lTckJScEN0eWhLNGJU?=
 =?iso-2022-jp?B?RC9PT2xwTEJaZnRYaDdudVFVSElHRlNtT09SdTdOY2xVaVAvYmlrQ3pr?=
 =?iso-2022-jp?B?MzVnbjdUSm9SbFhEcGxtL2x3MlAyNVhNN0NvQ2QyQVV0UUdWNHJCYVJq?=
 =?iso-2022-jp?B?TCt1WmhQY1l4MlJDNW1YVGl5UWM3bjJwdjAwZ3JhR0pzUDgzQkdackxE?=
 =?iso-2022-jp?B?SGdyVHpqZktVR3o5RU0vSFBab1k0ZnRaM281Ym9mdUtENzQ0Smp5OXF1?=
 =?iso-2022-jp?B?bGhIcDlJbUVhT1BXN2ZPRnJEMVdCZ2VHNUpHY3ZHeXdBMkhmYk9LQjVl?=
 =?iso-2022-jp?B?ZCtzUEoyRDhBdDBCTnVGd3FoNUlPQ3NIbGI0VGFHNno4S0t1Z3o2L3hI?=
 =?iso-2022-jp?B?cW10eUlaZUU1TzhwVVM5aldPOXg5MWpsd0w4Y2hSMXNlOXNpVFdPVHVB?=
 =?iso-2022-jp?B?bFlpL3BYNzhBRHRkUU8rYzVmR3diWGQ3Sms4UitQV0l3RExueWtZeDUx?=
 =?iso-2022-jp?B?cjE4SkU5cHE4dURDYytYcElQRWpTT2MyMWIyQXAwRUg2OXhjdjg2Nkhu?=
 =?iso-2022-jp?B?bCtiRWRGanAwbnJSRXB3MElrYllnSDk0SHhUaGZWMW91Z0RkWGovamtX?=
 =?iso-2022-jp?B?MG1qcExiZEZUU1RrdTdrdU5Cb3BUMHhHUVR5Z0hLMFVHbWhRRGEwQkc0?=
 =?iso-2022-jp?B?VGZ5WlpDcHh1d2VMVU9sam9NVU5xUVA3UnNEWTFyOVZPbTIvby9abEd5?=
 =?iso-2022-jp?B?QjY0VnUzQzhCdlVXVldaT25wd2ZkNVVTeHBzQmZoSTRKdkVUd0tYQWtu?=
 =?iso-2022-jp?B?aFdpbDAybU4rLzN1TzNhMHJWNkZoRytUZUd0bGNuMzhIWCtmYk9lajFw?=
 =?iso-2022-jp?B?R0gyelhWbDN0ekNXRWloNm1NVHJ4bjFrelE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8d624915-2744-4b98-c326-08da6e905459
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 22:52:19.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 FH+1q67qO6ssGn2HqsKnI+yDrdaT+ZpkFL90NZgGlLRG30v33ZihHwh19YDZwOJg0SpGbwbHg8/V5gLkn7c4LcOdEsB/e6Gh2s0q4PBU7jR5kyNyUJ5K4zMC2rI3sXmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2583
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 22:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8908

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, July 25, 2022 8:41 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: pavel@denx.de; biju.das.jz@bp.renesas.com;
> prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
> driver enhancements
>=20
> Hi!
>=20
> > > Thanks for the series and for the fixes headed for mainline. The
> > > patches look good to me (but I can't test/apply them due to poor
> > > network access at the moment).
> >
> > Sorry for the late review.
> > I reviewed this patch series and found no pointout.
> >
> > > I can probably do that on Friday, but I suspect Iwamatsu may be
> > > faster.
> >
> > Yeah, I will apply this series and push.
>=20
> I applied the series, tested it, and pushed out the result. Hopefully tha=
t is okay.

I was waiting for LAVA to be fixed...
Thanks for pushing to repository.

>=20
> Thanks for the patches, Biju.
>=20
> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


