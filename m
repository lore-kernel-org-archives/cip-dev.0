Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CDC61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:17:27 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web11.90618.1700745441917440127
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 05:17:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GHQojwMj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.131, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itachiuvPpUBTps5o2PY4i4Ehb0FtUzYNk+1JDAGdj8qoPNZVMCAdIVfmTdOv44I6Q7v2AVtUT/t5/8kCS88ZRSSrPsN1NPsV0LfBPkFYPORcLEBcJRQ6kBCXN1uVDIpdXD3/qf8qdOUOoLLyN64RhFnwnVwx+VQgCpZtH1wHuLxnjeGPa1a8Muht+S0FRKMMnJNhijnrxPV9rI+w1gm53IKLbCSwQ9Gp6FcOQ+7fwblQe1jeSmJl3Zz1u5F5a9uYADEatD5un9+cPRH6yQ+u9iCh3eoRxqjbXp2JdbUYASV8VLIZYUi01JRe3B0iRmeDNLswGWNiELFmDqejzkT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LehHvbPmmHO0YwV+CMGbEsxMTtp6X0egIRu6IuE4DI=;
 b=Yyu1FySYwPafdSiBwB0AUXnIlBNt1IYEUuUK0XtKvKd1iM0lw7dq8r7iT2KUA03XHjA8E6iuJBHCxE/WDxYcY/bd474C5o1yxQe8NJ2SuiU1ycm3e2Vi7z3552t3bzuNm+DEzcHI7zwLfdGSc5KMQWPMjFl/CRCUD/OkLE1ZkCrKxIvNp+1KAw2iRTUija3Eu1m83cDyWKtQxIu2tABBDobDHYkBHkjZ7tD9Ql8LZz+J4tkFz32y0TsGVdZwp6wEqsUzs5/bPMzI3gYOQjkotBrQrMppO/HPOcn8LU/yiq8uJ23bpgob3quDZrJEeMFhePSBKt/BaKO5ZxGGFuI2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LehHvbPmmHO0YwV+CMGbEsxMTtp6X0egIRu6IuE4DI=;
 b=GHQojwMjFkT9HsgaExRNvkhibAvqD0CegE4AVPWbdqVALwjVFc+zkTetk1dYFHKfQrgkD5OmiCRiz1nMhouQHbqO2GByMLDkjHTXCroUU7leaDWK1HD+d5or8sXxqBo2rcs+CRgUiFC5pTCLKXIFaKgrwch3w48M7/j80TbxIVY=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by TY3PR01MB10191.jpnprd01.prod.outlook.com
 (2603:1096:400:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Thu, 23 Nov
 2023 13:17:17 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::a19:f001:8736:9310%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 13:17:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: AQHaHVCnCyOZxfLIuEC42b1j1b2u8rCG1g8AgACwIMCAAFRNAIAACEuAgAAAn4A=
Date: Thu, 23 Nov 2023 13:17:16 +0000
Message-ID: 
 <TYVPR01MB11279801899313A2F2AA7B28C86B9A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
 <TYVPR01MB112459EC45FD378EF879F18B992B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYVPR01MB112459EC45FD378EF879F18B992B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|TY3PR01MB10191:EE_
x-ms-office365-filtering-correlation-id: c953611c-5b17-488e-d0c9-08dbec2683e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wETN+UQ/wkJHRgOifqu8RPV09KfAokLYSx0NGVn/eKqm/i4jk2k9iDZOAtNmXDYAi+XP02Ju9FfnUDbbKPgwrTtylicAy07GCYE+hxCBJJ98t8rajhmsx2/Rg8sfYlCKxISonCQfALTqVP1JQc9IWewRvSt+x1oi437wMblR737h5GOtQTTE8mstTUt6LrRCM9p6y1YVK1kiui1eKoYAZ0xGEiTmvz8VaIXgIWO7f8q/SawP5OYlNoO86KYnhsDuuOBbiW7qwA3b7jwIfJwB8zu2j5YDC5Rsc0HvLZmHqjmrPOs1h1ssT8o9vU/TwYNqjM9NMldhqp/2+bt2NKCMFWvrhUr8xCCA2C/0PDqaV6W/I8Vuc74QySws2bPnxjjK+aWDmFI5V5P8zjyUB+JvC5aqgv0IFYllkrnaf+bu+rwy5K6fi15AkDvI1TgopwREC1i/xAqVrwIeshw837yDvWfClS/CxpbtvP/sAUovgzcxUXY9Md40GaVBZcDE/zwgCVsMK43YJPsmGH7QAJ3iEa5u56kEIbHeai64FsYMDizEpZzG44KimeUMKBBKBco4GBmSK+XWmRMlOanYiS1TLuOv4F5kntP91d/OtlzcomyTxjRNGQooK4h2kwEKrKg/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(38070700009)(76116006)(66946007)(66476007)(54906003)(66446008)(64756008)(110136005)(66556008)(38100700002)(122000001)(33656002)(86362001)(83380400001)(26005)(107886003)(9686003)(7696005)(6506007)(53546011)(2906002)(316002)(478600001)(5660300002)(8676002)(4326008)(71200400001)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z05pQzZGclF2TEp3TVoyQUxXeDI2bmNPenVydGlPUmI2OTg5Y3BSVUFs?=
 =?iso-2022-jp?B?U2xSQTVYZGJ2b0VLeTRsb2dIekRHKzVGMjlzaTdvZmdNeEx0cWJjM0tQ?=
 =?iso-2022-jp?B?NEJmVzd2VDVOaENFSWQwWTdaMTgwNGVrZ1JnTUVMOGZQa0loYmtLWDVE?=
 =?iso-2022-jp?B?dlJBM0ZvVjdCMllCKyt5TEZ5S0N4REdJUzNucktYWE9XdlkxN0RJSUor?=
 =?iso-2022-jp?B?ZFk0cm5DZVlqUkJqQWFRd3FVQU9YN2ErVTcwTW9jcktYb3Z6UE5SWGtw?=
 =?iso-2022-jp?B?QWxTY0FrbTlBTC94VWQ5WTAvamJFeTVLR1dKRnpaUXBrdGVCN3A4SkFB?=
 =?iso-2022-jp?B?V0FBcDhPNGxlSW5nNlJBT1ZMZGF2YlIxVnY1QWwrUy8xNm9JS1BrKzhk?=
 =?iso-2022-jp?B?cXRQdE4yTEI1L3B3bkt6cGcrRXZaUWxBc1ZNZDVrKzRNTDJ6NGZIUVZZ?=
 =?iso-2022-jp?B?R1hWU2I4U0xMNktGR1Y2OUVEZkEzNXU3Y0MwK1FWbG45UjdsaHFqWkl5?=
 =?iso-2022-jp?B?M1BuTXl4TVlWQkpoVkhiL0tFRmxZajZmMnhCMjEwNHJsdHJnL3F5SjB4?=
 =?iso-2022-jp?B?MjdlcDZ1K3dld3kvMUNVaXN0VWgrTCtJK09XTTR0RUdRMWJ3cndJb0Iz?=
 =?iso-2022-jp?B?QzJCbmZ2NUZwKzQ4RlAyaXlPengyVjJjUzdQUkxhQ3ZWM1VaNGxIaHJ2?=
 =?iso-2022-jp?B?UlRMZWJKaUZ2VW1vSmhSeWl3TERSaUZkaGgwMUk0Q0JjRmpKRmVkbnha?=
 =?iso-2022-jp?B?NUNLVnRvaGNmMEs1RzJWNUtHNHJ3RytQSlNlTExqd0JFMlBBbXV1bTl6?=
 =?iso-2022-jp?B?NGY4cFlzbFRRSzVEUmR3aGVsYk1pTk5LS3dTeGtFcmhydkhoajlRSEtY?=
 =?iso-2022-jp?B?OFJXOFIxZ21xVy9zLytFZ2RDdStwOFdzVldOdlFKQzhmT2xXK1RLZzBC?=
 =?iso-2022-jp?B?VFBwdktvanAxd0diRzVhOE9xUmRNeUdGbURWRVdKa2xiU2I5NkxqNXVT?=
 =?iso-2022-jp?B?THlkblYrWTFPTldFU2R5b28zOVVZUDZYd2tINVg5TEt1Z1drTlplZ3dy?=
 =?iso-2022-jp?B?U3ZHM1VhemtrMjRBMzZiYkFXcnlUK29UbXYrOC91dHVxemdVM1ZST0V1?=
 =?iso-2022-jp?B?SVYwZElHUjI3T3l5ZEo2c2dMSW5mQ2lYTTQyellkRnVUektjNm91eGRX?=
 =?iso-2022-jp?B?amkrM09MWC9DUGJpT2JqRkQralFmeXF0N051NTJlN0Rja2l2V0UveDVD?=
 =?iso-2022-jp?B?ZU9ZMEFacUoweDhKbG1lY2FYZnpOTWwrU0NJN3RxQ0xDK0FNUEp6RStF?=
 =?iso-2022-jp?B?dHhUWWhuYUduT2EyNjNkQlVPQ3NhdTFKcnd2cW83ak04SDd1VlFsUzk5?=
 =?iso-2022-jp?B?MlZWVjM3eU1zeDJrNWpaWVNSb1M0d3F0TjlHSXNXYlAzMnlUanRLTlh1?=
 =?iso-2022-jp?B?TUV6R2hSc2M1QUxDQUVYSDVSWHh1QkhUeHFLS3AzYmtEeGJNaTd2K3Vk?=
 =?iso-2022-jp?B?aWdhaXBFQTFTZ2diUXNQR2tER2Q5akh5ZTU5L3dreTNQeGQybjJRcTdI?=
 =?iso-2022-jp?B?WmFxTnBYMGNWd2k1RmlJSUFyWC9UNVJzY2o3ZkNwKzl0ZkNGNkI0ekNF?=
 =?iso-2022-jp?B?c24zbnB0VlBQSzZ1bTR3eWxOK002YUxnN3A1UzhtcW5xYVhidGVNZThF?=
 =?iso-2022-jp?B?dFEzWDhNZWZJWGwxYUJCcGpYVyt2MjJHdXU4U1VobnBBUjN0YmRLY1hS?=
 =?iso-2022-jp?B?cW1VeXliYjR3a3FPMml6dmZsdVBZQXZwN3pXWnBvR3B4TU42Z0JPL3BY?=
 =?iso-2022-jp?B?Z3hLYVc3OW9CSkRrbDduWGJPaFQxbUZlKzJBQS9YZEE0L29UbCsxc2pO?=
 =?iso-2022-jp?B?TlZrRW5xUzFaVGhxVHNxSG8zYko4L3hIcVBONDdOb3Q0N3pwMXJIeGRW?=
 =?iso-2022-jp?B?aGNZSEh3QnRyMm55NFkyZVRuM2F0ZHJ5WVhLcGdxM2VPWFBRWW5tTTVF?=
 =?iso-2022-jp?B?cjRJSC9XYUtnN05GR1dWS01mVGh5a2Vjd3dXRkg0SXFCN3B5KzBzYm1R?=
 =?iso-2022-jp?B?ZDlRRDkycytKK2ZVMGQyNjZIbnBpQ1ZtUmk2YlJGSlJ3NHRqQThpaEpI?=
 =?iso-2022-jp?B?bStDdHB5WWxqUkVxSjJ4R25Remh3UHNQbDIyNlVTb2xFREFyYTlzNmRZ?=
 =?iso-2022-jp?B?QzJSa3hzVWZtczVzaTlKMDlIRElkQW94eXZ4WDdES1c1Q05abVRYemsz?=
 =?iso-2022-jp?B?OEZBOENIVm43cEllUXRQTEhLNHg2eDFNOUFTV0Z4MUVyWUV4czR6Q0hS?=
 =?iso-2022-jp?B?YzlaQnZ0WFowQ3R1a1JhTExCUmI5Sjh1Z3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c953611c-5b17-488e-d0c9-08dbec2683e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 13:17:16.9002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwD5jSlMUsJLQd332u5UuNqihulPi0oinjs7axd9i/eTBf2h6tw6SXJLTZpIDyapDUDBl2ma8GOCbf6g3TbPcmUrTNJR+ZvFLw+ljwYN3Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10191
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 13:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13671

Hi Pavel and Nobuhiro,

> Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Thursday, November 23, 2023 9:43 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org;
> > iwamatsu
> > nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=
=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Claudiu Beznea
> > <claudiu.beznea.uj@bp.renesas.com>
> > Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
> >
> > Hi!
> >
> > > > > This patch series aims to add versa3 clk generator support on
> > > > > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> > > > >
> > > > > All the patches are cherry-picked from the mainline.
> > > >
> > > > > Maxime Ripard (1):
> > > > >   clk: Add trace events for rate requests
> > > > >
> > > > > Stephen Boyd (2):
> > > > >   clk: Move no reparent case into a separate function
> > > > >   clk: Introduce clk_hw_determine_rate_no_reparent()
> > > >
> > > > I believe we don't need these in 5.10. I'm okay with this version
> > > > as-is, but if someone says these are intrusive and we should use
> > > > 5.10 versions that don't need these, I'll understand that.
> > >
> > > I have n't added this to 5.10 as it needs lot of code restructuring.
> > > Please let me know if I need to port this.
> >
> > I was trying to say the opposite thing: maybe version without the perf
> > stuff (similar to your 5.10 code) would be better for 6.1, too?
> >
> > I got build failures in testing:
> >
 >
>=20
> I haven't confirmed the working tracing, but the compilation error
> requires the following commit.
> ef13f8b64728c clk: Store clk_core for clk_rate_request

I have ported perf patch just to avoid conflict with the subsequent
patch. I can drop perf patch and manually fix the conflict.

Is it ok for everyone?=20

Or you want me to port the commit "ef13f8b64728c clk: Store clk_core for cl=
k_rate_request"?

Please let me know.

Cheers,
Biju

