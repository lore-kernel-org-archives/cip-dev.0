Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF67C624B4
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.90460.1700745166326382988
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 05:12:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3ANDCWmG1140385; Thu, 23 Nov 2023 22:12:32 +0900
X-Iguazu-Qid: 2yAafrZ6ghi9u2bac5
X-Iguazu-QSIG: v=2; s=0; t=1700745151; q=2yAafrZ6ghi9u2bac5; m=3AaUbPGKaWkKc/uMTQ5EPEiOQ4m9I+KARJjhWpAEK/M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 3ANDCULX2343937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Nov 2023 22:12:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky3Dqo2BXbouLaM+YPS76B0DVBoFtfVTniKjbzRcXCz2iiIBawTlZMFqQF8UKWC9kwF+LBXWSnde6XRCNtY7U5XQjGexeBUaSnMek2jlYzHNcRBMHG09Q2eEdEnWRLTwZ8XMDYsXBli6awSk+oEcgQzlKGGMXRGF2zjaQwtbnvOY0sj7g9FPoBXQMzk46RpNVOgLmrHM68+QqmoArgPT+FihsM4JcaZbbN3pPJxG+/oTK613HwSdqVjTvG06H8pJkc3lDUHv7wnTPdYhte/NzYDNvfwkqZdsBQtpV04Raa+HhnNSniUn3m3AHdh5P64VBH5uAtZnDXOkgmP+jfLffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsmqnuEiwkXOvxeTTgVS9DI+uI79iVlMqQmVqGAXRRw=;
 b=l0Ltl/xaYYLsD7WwPak7tytLbtTHBC1KyC86h+uexq9BqbXmy1KbsXbv/sB2dNZZxcqh8nvoyvNp673Bw8W4pHBNXSc8tdapsigukIXneb8GhfkYMUoHyq+7IcNvchZKaJTkfQhCWRXbG8rZlXBuZXs7PJ/3p6uUvkUtddUxysRYJTg0cp2k/LVXD0NhgX9jGDXcbUjcgDUGOxej/QYlZFqgdl9bLbPBBksychTVw6iqEQXWsU2ldTR7r/Sc3Ct5rpGuz7WJkxJrErxwW0Ctni3g55zgfWp9dGTQ9xp5WJUDXdyXBTecrLYTmBqbC5uqBLgO6dpW0MU+aMzW/uGJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: AQHaHVCr674e6wgZ4kuDDDp23YUTYrCG1g8AgACwpoCAAFPHAIAABxsw
Date: Thu, 23 Nov 2023 13:12:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB112459EC45FD378EF879F18B992B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
In-Reply-To: <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB11529:EE_
x-ms-office365-filtering-correlation-id: b58cfa17-170a-468a-1aa6-08dbec25d7b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t3ZlQwutexwUOp1fNELBEkwHN3k/cb+0SPioUsdCEfgN8yc3PzXIjBThZP9iiDF11sz0u8Uc7oCuR5mbzT9XpjGShEOQgBRGe7QkuPDI1Lile1F5QNnz6H8e9DmJmk7Ye3FYXvVcy/jIYyEyzEJidkwn7g9zYYZEWyneULElZt4UM8JKDaFgIL13H+7KbhVbSoEc7f21YYudmAsvSfleyRqp8eY5CP5OvYAjR8D1VkZHSmNwCk6Y1SvPyx9uit1B2UNII4QeH/hfNtrVPAakjf7DpwHw/kc/WpZQzJbC/rNComAnwzsg7tinowCbz4AseECKTz9o7MoWqnYKjI3qrbOE+dfKp2nbeRjad2gg7ul+vCFaqd8UERDPiEkGv2fBqodzcThJ3pbfp/hwyygYZycQw/z4aWFG2Q3pq6Sp587LTHTt8KO/vtQLQsXl56PjNNHTkeb7tcSNaWM9ecGGu05lXaFU2DKlN4duFSkP0crvCcdlWU2KmUc0r10qOAplr9Wh2pF/V/wIbh/EMpAsej/ves3CwuJEbA7tQEUZAX0Ir5jDikoOzsOiPrLN94wSSiSBp76Iys9+Xl3DEd+HLbeu3hDtdz/g2xcMC9M63nbv3WEa4gMWrWUY+H/yiGjs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8676002)(8936002)(478600001)(4326008)(52536014)(33656002)(53546011)(7696005)(6506007)(71200400001)(316002)(76116006)(66946007)(110136005)(64756008)(38100700002)(54906003)(66556008)(66476007)(66446008)(38070700009)(122000001)(966005)(41300700001)(26005)(83380400001)(2906002)(9686003)(5660300002)(55016003)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z2o5cGFtSFdKZEU4aXM0dkxkM2g2QzRzaXhKTGFjeGNvZWovb0QxU09w?=
 =?iso-2022-jp?B?Q0t0Z2l1REdlVWZjdGpINHI1d3pTVXZZaE8wOHFxVXFzRUQzUXJvQkFk?=
 =?iso-2022-jp?B?S1lqTTlPZ1dtdmNCck1UOUZWbGxLSWQxSldxOEF4bFpVcnZuY3pLU2pO?=
 =?iso-2022-jp?B?QVZtNFRmRWw2VHVLV05NUTU3UU1xcjBGeWIxQ0ZzaUtybVNxb3Nobity?=
 =?iso-2022-jp?B?T0NOUUxFNG5qcGVudEd1T1phWFF6WkNyeXRyWFhrUFJ2bUU4aUNvVXlX?=
 =?iso-2022-jp?B?N3VGek9MbGxKWFdUN1p3b0JJdDNiQlRtMStaZ2hrTkFSNTF3N2hzL1Y5?=
 =?iso-2022-jp?B?cGp2eStVbU1FVlU3MHRENndLKzdTOHpBeDgxNlRXYlB6Tm1tNHk2bjNa?=
 =?iso-2022-jp?B?NUdrcWNSaG94VjdCRDFIMmQyWWkraWRXb2dGTyt3UElVOThUQzZQNUFj?=
 =?iso-2022-jp?B?Nis0eHJocldUckxtNy83MVMvNDI0bGM4c3p3VFJQWWVISGRCazdVMk4y?=
 =?iso-2022-jp?B?eUNIMXlmcUxkQjZPd1E4RWJPdG41U2ZOMXFTTkxpQWE5Q3JJODJ6d0RK?=
 =?iso-2022-jp?B?cFExeENPMVQ5dlJoTi9iT09IRVppZk14Mm5XMjJvS3JkTnlpbEFSc2p5?=
 =?iso-2022-jp?B?S2gydFFKUHlmaGFMLzNOVzVEVGpQS0hkWjZJTDlWMHQ0NG42MXNCYmlk?=
 =?iso-2022-jp?B?VU5DeDRxZjFMUExBb2xNT2s1aDlxTUNBUDhuRjhqamR1N2MyTlFXUDF4?=
 =?iso-2022-jp?B?K0x6b3NhUTBlNElwTVNVdDlhTTB6SHVocDlvd2tkcUhDQVV0TldHclVS?=
 =?iso-2022-jp?B?cU92V2FtNEZNQnBJbWFoQ0krTTVZT2tDZFZLazNrQm5yK2FObXRtUUhi?=
 =?iso-2022-jp?B?NnFudGlDb2hYQnlIR0NDNmlTUnBnSWdudjNQNzhBcWFFeEdTa1hnVXhI?=
 =?iso-2022-jp?B?WXJJQ1N5R0JtWldkQktjWHUrMXIxblFXd0dzUTAvRnF0VldlRk9oaTdq?=
 =?iso-2022-jp?B?SGRUSHhST0FkaWs5YzV2cStuY0FoUkVCNEY5aVRsVjBjWStEdHMwVU5B?=
 =?iso-2022-jp?B?aDFnWkk0OFFOeWVHKzM5b3dHckNKaWtIa1ZDZVpaUUxmRFJsNEJGWHZR?=
 =?iso-2022-jp?B?ZXp6TGEwU0hPaVlLTFhxSC96NXQ5d2xRWnZWem8rQUpSRlFSTW0xMllh?=
 =?iso-2022-jp?B?d0trYjVQelR6b2RFSW41TnltRUhpS25jYll6ZmNPaXBETERqdHkvOVk5?=
 =?iso-2022-jp?B?QzNZQTJ5N0hjR3RERUNJRFZ1c1pCRHJIOXdrUm5LOVNNYkwwc0swdDIw?=
 =?iso-2022-jp?B?dDQvVWo2bStnUE1ZQ25zMTRZMVV5WUJVa0xnNC96ODRTQ2lnSlgxK3Rx?=
 =?iso-2022-jp?B?K0pnMSs0Wk1lcU9iL0NSejdiQ1phUGphUmloeElVMVlNdjluNkhhdWpl?=
 =?iso-2022-jp?B?R1RCdlVFL2tGS0lzdVhWRGpyWUw5VGxTRmtUMEtKcmN4UWZoVWVsMGh6?=
 =?iso-2022-jp?B?UUlWb1IwNzZxTXZHQk5qczlab0prbnk2NThyaHRoSFBuQ1ZuRnFGcmVr?=
 =?iso-2022-jp?B?dnQ0ZTZ3WXVlVTFJeUFEUExEVFR5dm9FQW1RNXNhalg1RzVUNm1hMWJG?=
 =?iso-2022-jp?B?cHZZYjRvQUtNdFEwNUF2TVNwTjdYVy9BcUl0RHlScnhQenFOME5WK1lp?=
 =?iso-2022-jp?B?Y3F3L3k1Q2h6ZDVZMnJpbnpFdFNEVUxuZ2oxK2llTVRYT1FZSkw0d2po?=
 =?iso-2022-jp?B?QWwwS0ZtN3g4YTZnWGtNa09IOVdidlFnOUVuZ0JqQkh5ajN4bGtiNnFk?=
 =?iso-2022-jp?B?ejZMZFNESlhMSEpwWWRxYUFDWHBLME9VSnVhM2d2N0IxV0doZHA4bzY0?=
 =?iso-2022-jp?B?ay9JWTJiKzY5VWwxVG84ZGZnOENPdmhONURuQmtEMmNLRVBFek01OWND?=
 =?iso-2022-jp?B?RSttejF0R1dzLzNLZ0Fra2J1SFRsYW5PRytVSEpFY09QWUw3MkhUNDcr?=
 =?iso-2022-jp?B?M1RtSGpNYkRrbERxRGFESU5lTnVYdFJ3QU5Qa012M2thZi9SMXBGZ05y?=
 =?iso-2022-jp?B?OHFYM0IwRUJpeWlCQ05ZWHU4Nys5bUJzSmtRWUNaSjNsaVlIZjhMVE9r?=
 =?iso-2022-jp?B?SHh1bXlxTE1CdFVXSXdrYlNLWjV0ckh1Z3dsY01tUmxLSnVUTUN2blJF?=
 =?iso-2022-jp?B?VVZabXkxQ2RJby9EUU9ITTdRZ0h1Y3RkWDQvcUhaUmlkTkdlTGFjWTN1?=
 =?iso-2022-jp?B?VzZIN1RkL2tvMXkzdXEzRHFtYy80YXNQSUxqd0YxYlIyNXNjRGpUaEND?=
 =?iso-2022-jp?B?d1habklKYlQwZkNyTUVjb1o0eXprRjRnbFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58cfa17-170a-468a-1aa6-08dbec25d7b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 13:12:27.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+CTJmIF6Y0AUlMCoF1h+Oy7WitviPpZXsjjaQlsVDijdId5KYw3sOy4cQAfi03KVKiBrbWF8V8t+9Pb0dKPDvNghOPu8oTfzY97w7lW1P1kCXMFwDBBv8rwMEeG/RVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11529
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13670

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, November 23, 2023 9:43 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B=
(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>=20
> Hi!
>=20
> > > > This patch series aims to add versa3 clk generator support on
> > > > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> > > >
> > > > All the patches are cherry-picked from the mainline.
> > >
> > > > Maxime Ripard (1):
> > > >   clk: Add trace events for rate requests
> > > >
> > > > Stephen Boyd (2):
> > > >   clk: Move no reparent case into a separate function
> > > >   clk: Introduce clk_hw_determine_rate_no_reparent()
> > >
> > > I believe we don't need these in 5.10. I'm okay with this version
> > > as-is, but if someone says these are intrusive and we should use
> > > 5.10 versions that don't need these, I'll understand that.
> >
> > I have n't added this to 5.10 as it needs lot of code restructuring.
> > Please let me know if I need to port this.
>=20
> I was trying to say the opposite thing: maybe version without the perf st=
uff
> (similar to your 5.10 code) would be better for 6.1, too?
>=20
> I got build failures in testing:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/108260187=
0
>=20

I haven't confirmed the working tracing, but the compilation error requires=
 the following commit.
ef13f8b64728c clk: Store clk_core for clk_rate_request

Best regards,
  Nobuhiro


