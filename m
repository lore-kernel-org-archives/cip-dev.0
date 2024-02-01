Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C112C47DDB
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 04:51:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.8719.1706763108619919492
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 20:51:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4114pdQ72445809; Thu, 1 Feb 2024 13:51:39 +0900
X-Iguazu-Qid: 2rWhQ9h8CDIIxsDhDW
X-Iguazu-QSIG: v=2; s=0; t=1706763098; q=2rWhQ9h8CDIIxsDhDW; m=0eAmqwECUBZtpqHEduL44quE6I5iZ+DYrjsfm7DY6eo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4114pbl0918253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Feb 2024 13:51:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmFiCNoj6J4AGqXZ6sBNFjzxOuTcsFuTV78uDXIvRqJmXKXzWHARPun6vFBAJUHBf0rR6rJLXoZIMMQt/Nl/MwZo0cO5HnUu30zHSGRy2ISWI9obqJPXro9+KbG26Vc57PhHkUJrnuHpcXdY7aOXK/bxiSrYGlINJBzjgELCXgIxcMrAc631K82fDh9TCpFA+sz9jY0wfNYenI6+xnmCd0S04D9AObEtfAHh7qMeDEdZe5k+JyDYme16tCTermfFV/hlyeIZB4oYzDZxjMIemQKUfXGQz2hHO+XduXV0YjBqqUZCQCaO8jH6IUWyf95xFUnUGn9QXAUN5ngDyHrYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA9qi5JYoqxYKgpintYRwXJem4w9ZvQBFvniMH1GLdM=;
 b=LrN7Qe32DQNixO6pobhdbsy5hR7EE0NyWiSo3Ju9/ZYWrai5zb0G6rV9CZNd2vcrATEkEZczk6iBU4uIGPLhTbJcSCIuINotvBGgfi+9oyS6a0ke5gHxpZnHFpKwluFmfFNIjIjjcFHRd4CBnBsFqsKQEVwQ8wIgRZMg+xCbKtzOAVPsLtAQA3BqGDph+MQXi0ZYlPO3RD8S3cNtHqjgxkQa21sgG4e9/iZkvhCQXhH9tkuyPQmSFC6buB9Ph86N68Oz0xM+t7k6ucQPdnMva6LFZjSvv4dTjlkn1Ed3SgSAA/J/IQTZK4xzKuWQkjw2/sbvBmb0DSMgfbXvEzwPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <pavel@denx.de>,
        <biju.das.jz@bp.renesas.com>, <yuki.saito@toshiba.co.jp>
Subject: RE: [cip-dev] [PATCH 1/1] clk: Fix best_parent_rate after moving code
 into a separate function
Thread-Topic: [cip-dev] [PATCH 1/1] clk: Fix best_parent_rate after moving
 code into a separate function
Thread-Index: AQHaVDcExJpI+dge4kSg6B2OSOu2erD06yfA
Date: Thu, 1 Feb 2024 04:51:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385B41C163D5989EF569BBEE1432@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
 <20240131135604.1488157-2-kazuhiro3.hayashi@toshiba.co.jp>
 <ZbosLzzxqI4FyNpq@duo.ucw.cz>
In-Reply-To: <ZbosLzzxqI4FyNpq@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|OS3PR01MB9898:EE_
x-ms-office365-filtering-correlation-id: c4bb806e-d90d-42e7-4027-08dc22e17758
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y+zvStwlqFg1n3W6fjonZ+wUdCW6Dj2Gxm1bw6DfNkKvBrd5mjvv1yR67nUL2p5a6zRtvibtqZtWpma93idqtsrwJnk6wayIzO2oLHcr331t07i/6Jn4d3vZeDQvf+JyZS2547u5i2C23J24ruOZx/+jj97GX1SUSFGPXyZeDg9iC0TjzRogKG0BZIn0e0ojUcCxp/CtHbXwXOZkV1LIgSFr23ymvngagO/GAJ3YmaXrxkfrHC0WvLsgdtX8rxNcwduHJcyag5BCM8NY2UPo9ca1fRuWhba4XJBTZUeZvrAwE9z9n6isXZ+aGx5nAlMjgaHpy7OUSihZLGZ+vBF5am+UGvjOvWloyUB2KQW3BX5Rw3HRO5sZNbo4lMV8uvFAxVjMTYNKLZBXGWDs2RHdjQIG0qDKM12pipS2BQO+9Mpwcdpg2TfMSImVumuCcdWJzpDUdPaWa2W11bQm/EApqez37X+GifoQJbO49iFL0zaZA6pYB8c1YPfziS+IC4wTY2TIK+e7evy0Q1d7FjF9I6Uh5544QCj3NlYT9d9yuKgRU9wtF2yiwxaEHirFXh634y2dCCHrXxCjua5gXVDfk5cLWjUCZnFIN2LkMEHh6shZLw2yBzXp8AbfPXQda4Sjb1Ad2SGUPMaNg4M55E3kwQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(38070700009)(83380400001)(6506007)(71200400001)(76116006)(5660300002)(54906003)(9686003)(7696005)(66476007)(64756008)(66556008)(53546011)(478600001)(52536014)(8676002)(8936002)(66946007)(26005)(66446008)(4326008)(2906002)(38100700002)(33656002)(6916009)(316002)(122000001)(41300700001)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T3BqcnA0MHdOQ2FjUWhEK29vOEFYMjljYTRyTHRqS09LcGorcHFXME5w?=
 =?iso-2022-jp?B?bUN3QVZ2Sm90M2NTbjRVV3lpR001V1gybndHZlNKVWRVaGFvR2RHR21T?=
 =?iso-2022-jp?B?QzVRb0dhSmE1YVdCcndqVGZqRU5iZXBPWEYzSTJqZldOMVZ6OEZGYTlt?=
 =?iso-2022-jp?B?UGgxbDVYS2huSHFPcU1kV3d0eSthQVFyek5TQkg1MWo2VkxTbzR3ZGY2?=
 =?iso-2022-jp?B?bEVGM3VKMWJMdXhFMnBWeHlldkJjNmFocFRmQVBDSXJZVG53SVNxdG81?=
 =?iso-2022-jp?B?d3k5anltS2xncUdaeDVOYWZMNzQ0Y21wRWZnU0xHbEJXT2ZpOTNKaWpi?=
 =?iso-2022-jp?B?ZUk3MFVhZkRYS1QvN3RUaXV2RUdUVXcxTG5hMWo1WHlUalMwM3VtZkNO?=
 =?iso-2022-jp?B?Y0NIYWVvWTBYanFlYWpwK3B1RnFqQUtrZWJXMnBVME9VWVZyUitteXBx?=
 =?iso-2022-jp?B?U3dxTkhCY1l6Q0JML0xta1A4TTZDZjFjVTZsL0I4c0VGb3pxQWp1MTd4?=
 =?iso-2022-jp?B?S0FJam4rWU0xMVhLZ2J6Nlo4TkdySmpHTjYrT2hoRXhpeDIwYlFoMHYx?=
 =?iso-2022-jp?B?UnNEdHNXMW5vYmJHN2hndUJqdW1scGkwQmJGQU9oZjAranY5NjhZZDIz?=
 =?iso-2022-jp?B?MmE1VjFoV3RqUlpvQjNFT2pqSmZOcE44K0VYS2pVc1NnRmJPWUNneUU1?=
 =?iso-2022-jp?B?SDFCS0VndEV5Mm1IcHg5dXgvN01LUFN2OTMrVVk2OUkrYVlQUGc0N0Nn?=
 =?iso-2022-jp?B?OHZsRXE1RU1BK3d5WEQvQUwzSHhFV0Eyc0kvL0VudWlvNENxRU9HcnJO?=
 =?iso-2022-jp?B?dTJzak5LQkY4TGhGY1hKeUhjRXZ3S0N6K012cnRhQ25DL3A3QmF6Um9j?=
 =?iso-2022-jp?B?bDFpQ1hMMDJPQW9FUytTMlNPT3l5MXZ0aitrY1BHaStHLytNTXlkbE14?=
 =?iso-2022-jp?B?d3A4anFhVFR1M2pSMEtWWlIvcWFPdVJha1UyakFOU2NQcDJPRHlsS1o1?=
 =?iso-2022-jp?B?V2YvanRiVU50RzdJRG9hMHA2eGlNQ2NLWnF6aEVKTFRTYnNJSnQ0RnFw?=
 =?iso-2022-jp?B?WDZPUzVYNjNGWlhoVWY0Y2wyOU5pV2xXSHFodnpPKzZvMDlXVW5JaGFy?=
 =?iso-2022-jp?B?UjlPR0FVQkkxU3RlT3lheUhhWk00YmJzL1pSSWFTeTZWTWxkSlc1Sm9j?=
 =?iso-2022-jp?B?NmlhdXpnWUF2OFEycGlaSVFZcDdScTJOMlJKb3NEaVpUNHFHZnJHbGhr?=
 =?iso-2022-jp?B?RXhmb0hHR2VValkxaGl4V0Q3Wk1nVU5qVG5vSlVTQUt5NHZPZUtVY1hL?=
 =?iso-2022-jp?B?RHV0RmxzOWw0Vi9hbmFjb2tPR2xweW9xbk1SWllQdWNPRlREbEFxSUw5?=
 =?iso-2022-jp?B?TnRjdjN4Q0I3czZpMFZjL3BlMzQzWFZDRThRWHhxUDlxN3BOcTBWTmla?=
 =?iso-2022-jp?B?YUVPdmw1ZDVTazJEUkpvMEo3cjBmWDZPK0ZnMExSUDZCQlhDcTU0S2Jn?=
 =?iso-2022-jp?B?TDl5ZHI5WVNlVjZpb21UWCtEdDdwQnFGU0lna1Npam14V0lxRU9saUk0?=
 =?iso-2022-jp?B?dkUvTG13ekNJK0lxOEFuMmtHRU1ZM3VqQ1lUZjFscFFLV3JwbXBtMTk5?=
 =?iso-2022-jp?B?LzI3Ynhzdk8rWEFEMnhRRnlOUzRUUk9NMVRYdjdJR3REbkdlRTBZY1NU?=
 =?iso-2022-jp?B?TGJsbWtJTFB6WW1LYXVaYVN2MUswZ2d5bUU4YVkxNUt0Uk90c1B0L3Vk?=
 =?iso-2022-jp?B?aEtTSWdnU0hwMCs1bnc3ZzM4TytkTTVsY2t0WEpkWExIN3lQZEUyMEto?=
 =?iso-2022-jp?B?TnVKdVdVV25lcUs1em1mMTdlVy8xWWRVT0NRZVlHNGpGamtVS1FtSDl2?=
 =?iso-2022-jp?B?WDNhQ2QxVTIyeHRPVW9Pa3VrRW9Eb0xZWWx3U0h1dWpjcGNRUklTcWZl?=
 =?iso-2022-jp?B?TFF1MlZXYkdJbmJxSE4zdkVEbWxJYm5yNmxESzV5U1l1VnJTZVkrbUM0?=
 =?iso-2022-jp?B?ekFtTkhzQ0tGcjBzR2JYdStxZzJKcjFoK3FMYWt0Mys3eEo3SmNlbW45?=
 =?iso-2022-jp?B?cDZEWWxJY3djOVRUREt0WlJhcGE3SzY2NDIyKzF1a2hYTFp2WDB4WFhu?=
 =?iso-2022-jp?B?dnRjQW5EdDkrL2VLU1A3ZEF5cGF1ZXM4MUt0MFdQRzI3U0ZYaG9IcnQ2?=
 =?iso-2022-jp?B?OTUzWWRBdFgyL1BlcWprYzNuN2Uxa09lb1ZoRCs5WFVmaGF5QVhHalJm?=
 =?iso-2022-jp?B?SmwzVThZMEZHRDhHUzN0aExDaTROdEoxQ21SMGUwdnJUSUNJVkRLTVBj?=
 =?iso-2022-jp?B?QysvZ3hCM09Ld1pyS1lRdm5hSExob0hMb3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bb806e-d90d-42e7-4027-08dc22e17758
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 04:51:34.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXBFWDB2Yt/ieMXs4wFIyN/4zXrPkfTa5NxgrT+1yPYBIpAaIfh1o5W3W94DPeYigkxaFB5c6BeJgjyKE8Qhmkk0uh34TTlOp+JGPe49vNVaGtmkRQ08FdX2lChw7QmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 04:51:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14573

Hello Pavel,

> Is there something wrong with the time here?

Thanks for pointing this out.
Yes, the time in my environment was wrong due to recent setting changes...
Let me resend the patch just in case.

Best regards,
Kazu

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek
> Sent: Wednesday, January 31, 2024 8:17 PM
> To: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{=
#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de; biju.das.jz@bp.renesas=
.com; saito yuki(=1B$BsnF#=1B(B =1B$BM%5.=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
=1B(B
> =1B$B#I#G""#E#A#S!{#E#A#3=1B(B) <yuki.saito@toshiba.co.jp>
> Subject: Re: [cip-dev] [PATCH 1/1] clk: Fix best_parent_rate after moving=
 code into a separate function
>=20
> Hi!
>=20
> Is there something wrong with the time here?
>=20
> Date: Wed, 31 Jan 2024 22:56:04 +0900
> From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> On Wed 2024-01-31 22:56:04, Kazuhiro Hayashi wrote:
>=20
> pavel@duo:~$ date
> Wed 31 Jan 2024 12:15:57 PM CET
>=20
> This will "fix" itself in two hours, but I wonder what went wrong
> there.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


