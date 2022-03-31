Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422EC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 23:36:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.4423.1648769813032609078
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 16:36:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 22VNZw4Z014070;
 Fri, 1 Apr 2022 08:35:58 +0900
X-Iguazu-Qid: 2wHH6X4jymmOBJmWDA
X-Iguazu-QSIG: v=2; s=0; t=1648769757; q=2wHH6X4jymmOBJmWDA;
 m=bxZBMq6W16/hMSvYRr5dPtFN2TaEfwwKxEeGjf0HLvQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 22VNZuU9038914
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 1 Apr 2022 08:35:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdexuSsqKCNNAMzRpDjN89mlpBehTFc/GqmMcXozv1d2X2dKJlDfXb8qRUwjm/dcp6d/peuDwoodVhRMRGXfLm2wrQcM1hTsSToIsZ3bkB3r2JHKKo0WMMmZbazwKi8gQQawvk+9lq5fVgn9hfBS3A4nB2zeAyholDsEuZalDajZQAzO/ye63uf98BMIRsVNdUdTpV3CdstH9VxYv2y1qiqhIj6a8DxrQYlOj56Q+1Uti+Qj6TlOtHLwf/rLu2PqeWHLWh7ScVapgfZpi8tj2feGCWOo/MIMoj9+h1YsueyPCwuvIuCOGhTY8IyZgHgiFEf2wcGXbvRVBEopkC0RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0rYQ3Z7m7vT64YWHZvzz3Z4OqiE7+lPXHyW3xZObQs=;
 b=I5RCFFjAP8nOPJMk0w5ffibsSF9YXxqgcdfQW+JycP6kxOxt1tgAHNkHKEE07ddWkMCeQXnKxJ0iXcbMoN7BRww+p+TwfV+g93lRpsMNVCsbrlmJUxIxbXtQcyzWImDCseAvQIYydP0/q2sEubBWcZV8omacBATBlI4/XBIbi3886rbq3uv9JA5ex0o/2UUhMw5fjEWMYXSWTW/Fsu5B0FzNyTXzFwHduGlun6kzo8pRTILguGMu+NBh7mkvuPdJG9pyrNyIqKAYL2oxbNvrn81XSr/rPSpB6Z9rcwz7cQkxwJdKvjUkZ2S+ilwf2G4XkNyKbkQibO4l4Lz8kxj3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Index: AQHYRGexx4RoxYFNr06Ziab0uUPtp6zZOnQAgAAhxwCAABZkAIAAsLIw
Date: Thu, 31 Mar 2022 23:35:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62522F373FD172EC1F758F0692E19@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331092808.GA20092@amd>
 <OSZPR01MB701991610B34316CAB5B2D90AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <20220331124910.GA16062@duo.ucw.cz>
In-Reply-To: <20220331124910.GA16062@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6703697-364d-4000-5c63-08da136f314f
x-ms-traffictypediagnostic: OSAPR01MB4868:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB4868DE1D92B4318CDC99F2F492E19@OSAPR01MB4868.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gXV/B2vZkyFzqAnqjLttFMpzRG15NdTInTgnzw9oQ55iyeaV32AiKild10LaFxUilOBQ7fSRgVkZBexO0LufREctNAY3mlWQHdI5GI43B9BIxJUx05hIJ+47CwJxyGfO9ahhH3lXKRMCPqa8NMFzx8PqHmw4Y4LOMHyNetzgs387DfQ7i2lk6j7RuO4PHdrjKXLwnC6fgUuNlU0hZU06nWHmk3i636L/puIfaMLgOkqt4a+XZfaQ/upCmYOXPrA/BJ0NtPQCwuioRkgAU8W3ow/YS3C8jjwIoAUo69MOTVPRzpT4WrnkUiS2Bj84SxLXh4oBKcPZYre8ZeOWrhF3Jf6/7YnNzXpisQhvZ3KWvbnH6Z3j1Lj588/8puBY5hTaleFdhy1VF8RiBtqfISZI3clNFVzRAEJeeJjIZ9xEZbdsJFeos8CiwDsr7P08w8u4pSGm68rjcdmsvjt8FchiTwZe6f/ScaduU3xrntbIccFBeZqLREEbzSzt41QoV/FTC+BWaFi7UY6u840uQ6LnZ7wnE1cfNFuQ2vocA8FLPEy62VdJsB3dTKJtvVHu/xZPZzPWu4Ao5gYCO2wXz1BKj6/dNft1rx+gFDoj/lCGW8VoXLN9sxQk7X1yFSz1DTZP+JM9EOOApTBGv3usKLbTP9aRued2iZ9PcLAH39XQMevRsKLOl3wigFRwvZU3yMt2LxrBKtxr+13IRxnEXLzrB+3WFzj+5bULgrv14XA3HC4mv7febDqRByyk9G3iwGl7LnZIElU7a3x1NJsE9lip7K0gImaHqVms9QeOZ7BkAlw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(966005)(9686003)(83380400001)(5660300002)(33656002)(2906002)(53546011)(6506007)(55236004)(7696005)(8936002)(86362001)(52536014)(38100700002)(54906003)(55016003)(110136005)(122000001)(71200400001)(186003)(26005)(38070700005)(4326008)(316002)(66946007)(76116006)(8676002)(66446008)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OXFtMXY3UEI0cnh1S2x2Y29tUC83UGE4RHBQeDNPUWo1YThnVE1leDY5?=
 =?iso-2022-jp?B?RWZGMWlFbmk0eW9iTnlJN2xCZWU1SHN0N1IyM08xVzQ1ZFN0SjF3V1lS?=
 =?iso-2022-jp?B?M2RER0h3cHo4MFRZV3JhQVd2bUdOQTJaK2tsSWN5dnFoaGg1UXBPOE9W?=
 =?iso-2022-jp?B?T3J5TE9WeTRQbWsyS1FCbHBINVdISVpLMGZVWFFuRk5zZUNwN2RvcUIx?=
 =?iso-2022-jp?B?U245QzUyYzFONWF4b2xGRTFUbXMxUWZZYmNQWHdlZ1RyOU9vSkF2d0ty?=
 =?iso-2022-jp?B?ZkV2RUZPRDZnVlhaSVJjbjNFakpSd0Rhc3JuMHZ6TURBYk1GK0s5cnh3?=
 =?iso-2022-jp?B?NG9FbG50YTg1MnRWd2NrWENucDdIaENJOFAwNWVrVXFIYmFaUW5xR1d3?=
 =?iso-2022-jp?B?TDEwbWVwL3pFVmhJbmVyY0JXa1dpL1NaU3MydnRrdTN0UkJMblN6aWpj?=
 =?iso-2022-jp?B?QlVxVUZKc2FIaWlNR3BJWWxidS9ocGxUWDRaQ0xDUFI0RzZML1BYanB6?=
 =?iso-2022-jp?B?c2pSS3BvSGEyVkF4aHFjNkVTS29XazVkMFFWVlNiNHFXc2pyQmczQ250?=
 =?iso-2022-jp?B?UHNZVHpsMzV6UHlFV2dYYVgvWDFNUkdRR1NrQ01NK2Q3c24vbE1TWURF?=
 =?iso-2022-jp?B?K1NnMXhFdERRa2dFUDZ1MW1nZGxXVEx1aWFnTDRZN2llUWx3YjZCNyt4?=
 =?iso-2022-jp?B?UkFUTmQ0Y0FVSXVyaEtVRnhOcXNraFpDMmt4elNabTlJWnZhOHVlSTk2?=
 =?iso-2022-jp?B?ZWFUOVZqNHhxZCtLeUthM0lEb1owa25SVERPZFVjR2FSOHVON2doZC96?=
 =?iso-2022-jp?B?NTlsNzNLL2JFa0JqbTNTMWdLTVd5MEE1TFdtMlRXUjNuVG41bGZYcWJj?=
 =?iso-2022-jp?B?bnY0cjVxZ1N5RDFzWVJrcS9raEV1U1JjNTVHUm9tV2J0UklvREcvUE12?=
 =?iso-2022-jp?B?WGhRc3JwdFNpM2l0ZkJnTTk5YlNtLzVJclY3SUVXbXovdEQzcE5rNmcv?=
 =?iso-2022-jp?B?a1hHaW1rOHJmdDhMSDIvTnZ3SWNnditlZitacGI1TWZ6am95VHFlWGFv?=
 =?iso-2022-jp?B?Q3Z2WG9EZFk3STlnYVpEd2w2VUhpY1RMWldIdzZ0MWxteFo4WWFSVjZJ?=
 =?iso-2022-jp?B?NzRiTVNURXpZREw0SG9lY0JhbHpSc1ZzdlFtdWswOUwvaGVWalFTekw0?=
 =?iso-2022-jp?B?OWZORWNXWXAybHU1aU92WXBkTi9WUVdsWDBXTjlyRkc0TVZBenJEajRC?=
 =?iso-2022-jp?B?TE1YK2thZW82YlFKdkduYnZoZXg0NkRMSm9jUmtNZk1vVnhxMHUzZUN2?=
 =?iso-2022-jp?B?TGpjTWxEQnFZMHFuZzZ4TU5CSktrTjBSOVkrZXNBTllleDByTzBNOUdM?=
 =?iso-2022-jp?B?bjE0OFFDVmlvQUFRUHhYNEFOa3BlY0hRUjYrQlRyRnlPdlRCTC8vb1dF?=
 =?iso-2022-jp?B?RldZdnJTSEErcWlTZGRqTkw3TlV5QWtralE4MEs2aUtmaTJLVXltWGx3?=
 =?iso-2022-jp?B?eE03RTYvYnBQRnA1YjZVZm5ocUdWdUlmQm4ya0ovRVY2RmdGUEJSQkdE?=
 =?iso-2022-jp?B?b3Y3M2R1TDVRRG0yMU5OOUMrSnExUng3VXZLczlFbG1EU3RJamVuMnBP?=
 =?iso-2022-jp?B?dEEvSUpMOUM1UHFWWE9iZGQrMXZyUHh3RWhZeW9MRWFNV1VVMm55ZXNL?=
 =?iso-2022-jp?B?ZkI3NjBhYUJPZXdvdGMvUmVzS1N5ZzRHVWdLY1R6azZ1M0JFbFJ1dW5U?=
 =?iso-2022-jp?B?UmFrVmt4R2o5UW5UNnhVckRmckpvRThIdlpSeERhcVhhTWxxS2dNQjhP?=
 =?iso-2022-jp?B?S2FsdHN3TEhTL25sTFNqR2FMWmVxeFpEMlpPdkNmNWZFczZyRGU3U3Jp?=
 =?iso-2022-jp?B?cGJLaDJZeU1oUUtxTnRTNGRDTXYvaTNhMjlSUm9tcUlWQ3BCSXF1Wjc4?=
 =?iso-2022-jp?B?WVZPMERpQld6aU1IRFI1d3NOMHA5QnN6TFhoK3h3RzErMXFzWFFnL2lI?=
 =?iso-2022-jp?B?OFlwcnI5MEdvNlVDMC9hZmxkLzNEdmd6ZWRMekh5RHF3U1I0dUFQSmpq?=
 =?iso-2022-jp?B?b0x2MkVjamtBME5YaGhlR05mSnVUQm5jNUF0OUxKVDJONGIwVjM0eUpS?=
 =?iso-2022-jp?B?NXJHTmYraVZab2xQRTZHWVN1YlRHZExCR1E4aTdscWFNRVVpeitnSWpB?=
 =?iso-2022-jp?B?RExNV0dFYnlZN3BoSWdvanBsOEdGOUM0ZXR5a1BrK25vZ3dFVU92QWxo?=
 =?iso-2022-jp?B?d0QvU3FkQmhjblVoR3VzRGpzaWhCbVZZRTFVQXJ6YmpzVHhFSDZBMkt6?=
 =?iso-2022-jp?B?Vm9YYkt2ekR3V2ExSVlhQkliclFjU2w3RHN6eVJnUjRCOVhJQm9VOEdR?=
 =?iso-2022-jp?B?eWZheWVXbUl0dE8xSW0vSlVvQitLRUkwY2F5WHBWT1diSTE0d1JTZFZI?=
 =?iso-2022-jp?B?NHAyMEZwblRSODJyL2lxM3dQN2w3VjhFUlZyZHQ5ZWduYnk0dWltdlU4?=
 =?iso-2022-jp?B?QVpucjJFL3ZOSDRWcGp5MExKZ2JyTVdxSmxCMTUxWWY1TElZb05hYU02?=
 =?iso-2022-jp?B?cDNwQXQvaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f6703697-364d-4000-5c63-08da136f314f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 23:35:51.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 79mwZCktoZTmgR9umu4qUaVXXgFCHTYZFLD9pq9vaGAoCuVXeRadMXjdEfT9DXVeBTtutIzQNkJYQZI8cLwlsj3YJx+/KDY1EdjAP63uHExF6iFsQ+MSjiB5Ab7Urgnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4868
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 23:36:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7903

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, March 31, 2022 9:49 PM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas
> RZ/G2L SoC
>=20
> Hi!
>=20
> > > > This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC
> > > > and enables this interfaces on Renesas RZ/G2L SMARC EVK.
> > > >
> > > > All the patches have been cherry picked from v5.17 release.
> > >
> > > I tried to apply the patches on top of 5.10.106-cip4, and could not.
> > > Can you double check series applies properly?
> > >
> > I did cross check my base branch and it is 5.10.106-cip4. For some weir=
d
> reason patches 01 to 09 are missing in patchwork. (I can see the patches =
are in
> my inbox though and pretty sure you too have it as have received feedback=
 on
> patch 04 and 09).
> >
> > Do you want me to resend the series hoping patches appear on
> > patchwork?
>=20
> I took patches from emails list, not from patchwork, so that should not b=
e it.
>=20
> Let me try again:
>=20
> git log
> commit 8bb6e30b765989a3c0924158316d689e16317cd1 (HEAD ->
> linux-5.10.y-cip, tag: v5.10.106-cip4, origin/l\
> inux-5.10.y-cip)
> Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Date:   Tue Mar 29 08:32:48 2022 +0900
>=20
>     CIP: Bump version suffix to -cip4 after merge from stable
> pavel@duo:~/cip/10$ ./git-am /tmp/delme.zz
>=20
> pavel@duo:~/cip/10$ ./git-am /tmp/delme.zt
> Applying: mmc: renesas_sdhi: probe into TMIO after SCC parameters have
> been setup
> Applying: mmc: renesas_sdhi: populate SCC pointer at the proper place
> Applying: mmc: renesas_sdhi: simplify reset routine a little
> error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:569
> error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply Patch
> failed at 0003 mmc: renesas_sdhi: simplify reset routine a little
> hint: Use 'git am --show-current-patch' to see the failed patch When you =
have
> resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> pavel@duo:~/cip/10$ git am --skip
> Applying: mmc: renesas_sdhi: clear TAPEN when resetting, too
> error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:558
> error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply Patch
> failed at 0004 mmc: renesas_sdhi: clear TAPEN when resetting, too
> hint: Use 'git am --show-current-patch' to see the failed patch When you =
have
> resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> pavel@duo:~/cip/10$
> pavel@duo:~/cip/10$ git am --skip
> Applying: mmc: renesas_sdhi: merge the SCC reset functions
> Applying: mmc: renesas_sdhi: remove superfluous SCLKEN
> error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:556
> error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply Patch
> failed at 0006 mmc: renesas_sdhi: remove superfluous SCLKEN
> hint: Use 'git am --show-current-patch' to see the failed patch When you =
have
> resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> pavel@duo:~/cip/10$

I have the same issue.
It seems that patchwork has not been able to catch all the patches.
  https://patchwork.kernel.org/project/cip-dev/list/?series=3D627598
And CIP-dev ML is in the same situation.
  https://lore.kernel.org/cip-dev/20220331124910.GA16062@duo.ucw.cz/T/#m5be=
9be981a6acb372766fc280b7fb27eb5a27527
1 to 10, 18, 23, 26, 27, 32 do not exist.

Best regards,
  Nobuhiro


