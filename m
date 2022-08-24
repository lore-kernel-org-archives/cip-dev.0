Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B80CC32793
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 01:50:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.6320.1661305826871741909
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 18:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 27O1oGUB026215;
 Wed, 24 Aug 2022 10:50:16 +0900
X-Iguazu-Qid: 2wGr4t84ToSP9V0pLE
X-Iguazu-QSIG: v=2; s=0; t=1661305816; q=2wGr4t84ToSP9V0pLE;
 m=7UmgR1r/GZbHMDN1PcAVn6isE4LIcxP3VhJcVujY0xY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 27O1oEKP013573
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Aug 2022 10:50:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7zzAyTwNUvXnmrmon+oY+jOmcDyXSQ4SKWD4Ru7rCn9dL1MsAJPee5Zn+fj7MZ3MGsguKnd+r4bvtowi3R+kmY2YDwy2TyHgSwBo7TjdPTG09PtjjJqpmQVXog57whmCfoJpWUxNWICG7lg0wvpRgRqm2VJb9SySuqaI7w9sIs8Rril3RFsSECq9ABN99yAG94KoUzeeQy+MhcvjYOFaQuBqygwGG7L3rKjq7hiintYbXieNfC4kNTNW0UKVhJ87h/tdxylaBFzaxM/mXuEoSUuS2fGClfuw4Tf1bpeW5COTNZ9fbpYBoKaV8Ott9eBkKiVdLKLKfNGLB/Z7bzZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCsWdlEa+jklmDSPbw9i0vba8VHbr9/9kRy7bDDkdOU=;
 b=TSDYX4cCyZj3QSZIiCt80U0El9DswQetvumEMYZgew7AiusW4Wd3PiQ6JUX8WBOoBg6OLeR/0xHlVd2gziTj2QHNaYWPeI63X9VvLjC3ARZJdWVZEq3DPTKBiYLcHDI6HEp1Vem+Y6CpVjou0aeMmtfnXi1L2B9XkccyOVf6A6Ls9OWwHr/Pnc/Gx0wLDGgJ7YAPh8PN270afqMogI/H/IdJhCKPtIPyqiT47kp8xpQAmr3O4T9d3RTnyiaXVTD9/GZ6v83RFY6seQH32j9R674rTEcCs5RerVYI71zoK3i1+OWVvFZQOUhDRzN7CLQfPqWBLb1kPRnVPBK2mHH4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status function
Thread-Topic: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status
 function
Thread-Index: AQHYthlhrdnvag5d30CIu7c+5bRkDa2640uAgAJhGtA=
Date: Wed, 24 Aug 2022 01:50:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94208953755A099EB76E838892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220822112046.1067688-1-biju.das.jz@bp.renesas.com>
 <20220822130443.GA16642@duo.ucw.cz>
In-Reply-To: <20220822130443.GA16642@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65c9641-22f9-409d-ece2-08da8572fba1
x-ms-traffictypediagnostic: TY2PR01MB3884:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CyM2yAalUIbCS6JDCXVWCmQ03fUyHXM80exoTaW0qKf3fSdqR64/pkRsnnoRLMJvK0lZt7PXNXB2nxByzq+LOm0cKsYOxsCLzsxDt6+oN5lXhAgvd6XFi8/+B6JCTzwn1t3lab3IeQqKWYkThKTqbC7JOE2/dyEbbQQSV+VBmq15GQU9uZB/Rj2hE9hjyjWTHrz37Ux9XQznjtZQSUk3xXEDxLfC2bWaGg4txtnlUGpl6j8RlWbAU4fYX2hXIqhW6cWzJVGth93jjO8jWcGE4KajEZW9hS5zCq/5mfDtmrlYInp9CiIsiqxSu4QZTw6JxsJPADOuckqrHXB6GTHNa22gQw+a06BZwvKt1ub2X+6v3/9A2zmqKTh89dldms/W+CNuYAcVOXghmkvLIwQfStSsXpfmXTIygP0GOkohdXSlbIQtFEnAYUYdKSNa353G369QKDDYKEQOckmBfzH/SeUW7O7nWwpTUeP5mhEUuy35yH5ojZtarLqGpBS6GCwQEi8DTdNE1OJebct2eBV2eLqEqRt/yyR88GHw0xAnDkYyFg1MGj32GPDX8Uo31+aXq+m3HeMAcd7ASDnoCKQ9xz4+eL8EjtEZUUlWyN9RJEB4mfE3a/tGs2/rWD4aZ3em3aYyAkRGnMS2JBe6QyVRy9im+Qj3aB4zZs1arvLpIyqYQAW6c9owVjQfXsQ+3ieJkgo4h+/uik8Rb6mI/nx6SQYr5O39OKf8OrAutGqYFrP/8ysHAz2KXNrIuA7Q6drzoHA1UvlV4gKpHcqxrDXpgHvTRYf2g8D+PH83zLI9iis=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(5660300002)(8676002)(4326008)(64756008)(2906002)(52536014)(66446008)(66556008)(66476007)(76116006)(66946007)(7696005)(966005)(53546011)(9686003)(186003)(55016003)(478600001)(71200400001)(26005)(8936002)(41300700001)(6506007)(54906003)(33656002)(86362001)(83380400001)(110136005)(122000001)(38070700005)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?akUxME1ZRnJYZTUvY3owVjA1Q2pVaTF0aUN2N1N0cklPUXpMelFTT0d3?=
 =?iso-2022-jp?B?MktuK2JXQXJwN2poejltQlFzSVZPOG11R3ZPN2pSTVZtZC9NOW1DMG55?=
 =?iso-2022-jp?B?Sk1OK3V2bFNmTnhEci91TytOeXBPTjA3cTNmYkFuYk8vL2o4bUhVRTk5?=
 =?iso-2022-jp?B?OWRHZmoyUSt2TWt5eTdLdGlubTZUZjN4cnFQc3hzQk9pM1d4cmRBaTRU?=
 =?iso-2022-jp?B?V0VrWXRzaHhFcTV1bEZlUW5JZVJvUXJDUThveC82VXFtUUlVNGFZbUk4?=
 =?iso-2022-jp?B?MXV6SDVCWkZndDVOMHVNWmpRZEhzRGdBS0pSb0MycVlEYmxRL3NXdGtk?=
 =?iso-2022-jp?B?UWZzaTZudmE5UkYzd0tLTG1wTEN1MjRmbTZ3dUJLVDhGSFVSZWNEYjRo?=
 =?iso-2022-jp?B?OUw5T2RIakprL0hzVzJuNzVLSlNoWUhRZFBGMElRYkQ2R0ZBMlN3d2N5?=
 =?iso-2022-jp?B?TnRyekJERUhzQ1phaitVdWtBMytueGZiV0tiMHNjak5PaXJhSlBjbnRU?=
 =?iso-2022-jp?B?YW9tUmVPYmI2bkw1Q3ZQNkgvT2hGVEVRWUdFZWJIbE4zVjd0MG9PZ1ht?=
 =?iso-2022-jp?B?NCt1OW1MaGhKcmNDb2J2OEFoa1BzQ09GU3NmWUJ1N3BtSlo5VVRuOWpI?=
 =?iso-2022-jp?B?NUZNOGU4Y1loVlhpS1lLeXVDVmNncGxlZkloSnZqZm1nNVROa2ZjeENr?=
 =?iso-2022-jp?B?RHNLUW5RWFlQWk1jbHJaQU5HOW1sSGtqRDJ1TDlqOGVacTZZd0haa1FU?=
 =?iso-2022-jp?B?VWJPUG53NGEyaTZvMUp2S2dkczJ3anZVeFRkR09iNVZ4WTVQSEdHKzMx?=
 =?iso-2022-jp?B?OGhOQldJbTNkMXJDSFVrdzRjdjR3Yy9QcHNHUnVLenFudGM0Qmh6eVFo?=
 =?iso-2022-jp?B?TFZIYndDaUxTQTZZSENjZjM5MHJxdmIwRHNwNUhLNjVFeUc2K0tTVDBU?=
 =?iso-2022-jp?B?TllzV0JyZXk3cUhQQ2Vua2RpU2V2RzRYcVVVTGZUMVpRalRkeG5WektH?=
 =?iso-2022-jp?B?d1kwaWdXdVFZQURadkJPVThjYmxwbFRjdUFKbDNTUDY0YlhnN2tROUhN?=
 =?iso-2022-jp?B?bC9mMnR2NlFKKzVaNlFydGlXU0hTbncrVk0weTdYdTlncnlGQ05PSHVr?=
 =?iso-2022-jp?B?VjlYTVdNQUQ5MzJEZG5ZRmpuK05MUlQ3dnZ5SGNlUVkwaTJjYWttMEI3?=
 =?iso-2022-jp?B?cmEyd3l3cW5MMnJWZ25rb0FDOW1BUzBMTGVCWXJvNXNMeUpOd3YwKzNG?=
 =?iso-2022-jp?B?K2lseWlPT2p0SThpdTRrei9VRjFqNEdpQjJMcUc2OTVZM3ovdU00WFNj?=
 =?iso-2022-jp?B?U2t1ektqZlhwZk9TSGtjMm1jRUdsOEtJbjlZbitoUUlpMDgrRkM1VkNm?=
 =?iso-2022-jp?B?aUdmUEVZc2dMYVFoWlhiMml1b1hSbno5OWpWMG40SzI3ZzNQd2xPamJM?=
 =?iso-2022-jp?B?d3ZSRkZDK0ZTWDRMcTdHM1NBNmQrYzVRaHh1TzlaaW1PazRmU216bElP?=
 =?iso-2022-jp?B?enhRMzdTNi9ERU5leUtkeGN1eGRDOVBtVG5kMDZnUk9tci9RRXR5V29q?=
 =?iso-2022-jp?B?T2ErRHIrNzhLbnRxOW0wUDNDWEpMcTZCS29GY0djL1c2YWZHQUsvV0do?=
 =?iso-2022-jp?B?ckYwWnN5c3FMb09JdUIwZjU4cnMvZlFBaC9VOWVoL3ZNeEh2T0hHa1Nj?=
 =?iso-2022-jp?B?OGwzUFNYTFNIblR1V2xpdmgzbDVMOUVRcW83L0VZdWVTUm90eWVpbFVl?=
 =?iso-2022-jp?B?N2lPeTZCYUlGbW9TR0syL0ZUM0tGNGtucUxNb3FoZ1JzejAzdGNUNStB?=
 =?iso-2022-jp?B?TzRGalZ1a09zSE1OZmJHWkc0TUhjbmJMaEdVWXpCOCtuV0pqdkZLc01o?=
 =?iso-2022-jp?B?VFNUOHZ2U0VHc0RXRXJTOWczNDBjenhpalRhTnJJUkw4aFdKM2EyQ040?=
 =?iso-2022-jp?B?L2RrTTF6WitYRGpPcG1aY0VYU0VlVUtKV1M1VEFDcFRSQWFXS0tVM2Jy?=
 =?iso-2022-jp?B?dWNad0lHU29JMmVWZk5YN2oxdWdLbUhIV1A1UWlPRUFoQUx3dEJOOVY0?=
 =?iso-2022-jp?B?YldGSUEzeWtsbUJOeis1MTkzRXIwL0RBM1U4d05rc044VjNCQ2dBZURG?=
 =?iso-2022-jp?B?RkFmM3owWG9UelVRZjRNbkhMdHVjc1czc0N2ZEp5ZDdHbURacTBlalpj?=
 =?iso-2022-jp?B?ZVRqTjhKUnBWcHhnYkFjUkh1NHBnby8vcjBsVDhWTC9iZGx0M0t4Yldq?=
 =?iso-2022-jp?B?M0NKaUlaSFgvaGw0WSsyOGNVUnc3MmV2aENyZjhGOXdEZUl1bW0xMXQ2?=
 =?iso-2022-jp?B?NHIzMjV5ak00dzVkM2Y2NzRiWkkwZE81cVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e65c9641-22f9-409d-ece2-08da8572fba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 01:50:12.0493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /sgdVgWiPmri/nteFo1vusOx3nmAjV/cq8M+QX/cai2eosNeerdHycKSKuhLfuIGmqwbuCxKZyI2d80xi2BjaiNQKchb14dCllCZVIJtIswXhqYUgbjWGPQqTbTq7V7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3884
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Aug 2022 01:50:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9314

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, August 22, 2022 10:05 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Chris Paterson <chris.paterson2@renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status fun=
ction
>=20
> Hi!
>=20
> > commit 02c96ed9e4cd1f47bfcd10296fec6b0b69d6b3c6 upstream.
> >
> > As per RZ/G2L HW(Rev.1.10) manual, reset monitor register value 0
> > means reset signal is not applied (deassert state) and 1 means reset
> > signal is applied (assert state).
> >
> > reset_control_status() expects a positive value if the reset line is
> > asserted. But rzg2l_cpg_status function returns zero for asserted
> > state.
> >
> > This patch fixes the issue by adding double inverted logic, so that
> > reset_control_status returns a positive value if the reset line is
> > asserted.
>=20
> Looks ok to me. I can apply it if it passes testing and there are no othe=
r
> comments.

LGTM too.
I can not find Pavel's test, so I am running in following pilpeline:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/621098021

If test is OK, I will apply this.

Best regards,
  Nobuhiro



