Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC28C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 01:44:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.3927.1639615243223440152
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 16:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1BG0eXjY018615;
 Thu, 16 Dec 2021 09:40:33 +0900
X-Iguazu-Qid: 2wHHOe8oOwE19r8AZk
X-Iguazu-QSIG: v=2; s=0; t=1639615233; q=2wHHOe8oOwE19r8AZk;
 m=LgOanqp1q8peJpjLsRzYcrYXy752lOYTAJPUF+U8R2s=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1BG0eVEa016655
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Dec 2021 09:40:32 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id CB77D100307;
	Thu, 16 Dec 2021 09:40:31 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BG0eVsg011129;
	Thu, 16 Dec 2021 09:40:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUqQQ6JPLKTPGcYMRB4aQYI1IBfknx9AwV2/TsBxzp8WWwgYws6KdbiedOZjWEiCBodsFGUW9SysrccGfMieQyryuXHqNd+cybsNRNPHAuYsLSRRX8Yp13jugVNgSHs/WIheOrP8f0YrEaJM2Rff7shxZcdgYpAhd66T3KcCl7eWF+O6qDk3d6pRHlKyg8UTFdUW6I3f1AsRwTHb6K+ghtgswK3VAMfd1is92hFKkRuCe/RzuPDJAV6S5dJCFXDGmBzP7LWYAPChS3nobZEqraocl/ndkyZtxmGEYtGkzgk///ymIG4Rx23RbwxhZgHV8P+nhsanyGFVcXAUzOAEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFhn6Pzpn5B9BlWV3mDXT5tDbOw0+6SKl5kEv2yc6j4=;
 b=kH9kAh4UOy8GAmpf4TX6Kz4EHW3tALQA4yljiHePZvjl3zgoKo1fMl7Oafs5QNkQVCeA+hGEg6ACrNdD7NezNJNuv3OnrDSJi/VtymAMlhuO1vxcA/fnbFx0K/4y5LTTCtp1zDShwpoNjowz73NFBTIQfoVvx/017HIXLYI2PP215Np7lQoadMGoD+K4jKHTbUlfeezPB+C952V9mKl62lEOMNPVMuzKq6hugW/vMlXoOTnnaSRATLMivaN/JM5OPWH4eANfWqcdIPgqdHgq71cQLOkLr76vEc0KDYV4SQMKiCy0nGvGPjHQDjVTlBNauNhhtwe4u3eS98SKIBVb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U08XT1uNy8MwUSTHJk1/2W6AawzVAKAgAAILACAAOotRw==
Date: Thu, 16 Dec 2021 00:40:29 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB625203ABE988E764E38A8C5592779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211215100537.GA18047@amd>
 <OSZPR01MB6877AA575BACD21ED96F9B53B7769@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB6877AA575BACD21ED96F9B53B7769@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d109e180-fa14-8098-5470-a34069b8034e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673bcd57-4ff7-42d9-b793-08d9c02ca8e7
x-ms-traffictypediagnostic: TYAPR01MB5040:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB5040B4E0406B5E37227A5E0F92779@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 L8Kf0583Ee7VzYQfRt1xXUS2/erszlKilblTAKVwEI/1eAh+XQsrmkIGg9ltcVQuoSOsbKQ9MZcCG7r+GvRTJGKxP5Sx7t0Z5yoNoVPZt+DIvxnxu4wQ7tyOQew1STXovDkA9hAhUeTzie9UVXw+sQ5B7Wpm5vUb2b6GYAi8SPlFwJ1lxFs5/1czKNQPWTJ6h9irBre8G6xPdhO+4o+3aeGu/IicsXetQmJzdWwke/UjgyiM8MY8LzAr2D0TJ2AnMDqHGkLzOiH1LzwAGaY8OkUFwzD0bypxFY7H3xUzvTQetMNL5zp3r/6BFWojXebypHJWImIXEPUXLGdwV8gD2JMes6vbpKRTjGGN8yobKvdL3h/67q+ZOZARQZJvcBN3MkVcOPE4B61Hra0XPzPxlZitfjZeZuerDn7OcQ6+7lW6WJiVky6cAcsu++HShLHei/9pi9tAN1MnnizKq9OwaKkoY8/GC12Gcu6l5Gr0FIh411XSffoA0TsGJ9FacTrVhDVfXqStgydlTtxf3jGXuiNGZRwsZjW8vdbE5ktR4kWb2pzj1Iw77IK/zqswWBghZ6apHLD08A+zAn6V6CUEKkUQa6iRHVb2KCgdvUW5ldt6R2eoNKdw+R3H4Dc/eWFHTKwX5QggA2eHQleCEFIELf5P04A1XRTSD7W4WrBKkyPnjngan/QbHKaiLz0bGJ10JKA3rIvYk3M62J2UcFcXMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(26005)(66476007)(71200400001)(54906003)(66556008)(8936002)(64756008)(86362001)(66946007)(6506007)(55016003)(122000001)(508600001)(7696005)(2906002)(186003)(33656002)(55236004)(9686003)(38100700002)(110136005)(8676002)(5660300002)(66446008)(316002)(38070700005)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VDBQWWdvWE9odEVST0UzaTFUSXBRcGw0S2ZjeU8va1pOYkw0UTVCbk9S?=
 =?iso-2022-jp?B?Skk4WU5JbGpTVVJXejFiUWJLbnVUVGNpQ1krZWJKR2lwWS9zU1lEdHZY?=
 =?iso-2022-jp?B?WHpIUnZ6TlJjR3dNazVSRGY2MjZpZUtKQUtlRUVtNks0UW9EYmdDWXc2?=
 =?iso-2022-jp?B?UzNQeEt5b2ZOekl0WWxhYVNOM2R1Y0VvcHBvTVNacHN0ajdEMFc3cm5a?=
 =?iso-2022-jp?B?SXZQTjBKbEh5bGFmSHJpYkkzTzB2S0lVei9LZHZWVVZZUHJCWkNwQWdh?=
 =?iso-2022-jp?B?MFhqN0tTVzRRc3BhUWs1UnQwcWpDQ3cxc2dqaEVJcFFtZGErMVY3WS9W?=
 =?iso-2022-jp?B?QkM3MWx3Z2QrMlB6WkZlYlkzVmpvU3dpWlhJclRnT0ZDVVorSDFzMzdV?=
 =?iso-2022-jp?B?RVd3YVBJUjg0eEd6Ri91dGN6amZlNnNKQU5kSllocHBDMjA1TGVCYzBN?=
 =?iso-2022-jp?B?WENxeXh5d0t5OWF6RnJSWlpGTjBIS1hCSEhORDJGTmJGZFhWd1dEUnA3?=
 =?iso-2022-jp?B?eE56cG5SY2Z6dlJ2aDAzWGo4QnBOa1krWTNadW14ZGQ3b0lneDlPVjlo?=
 =?iso-2022-jp?B?Q1ZTN3AvVVpIdldIYStjSXJnRlYwMlFrZGYzcDVzemt1dGlNdG9PRjBR?=
 =?iso-2022-jp?B?OWs2YUpIQmRqcTJjY1NwN1FNVGR5WS94bjg0bVVUc1l2V1c4ZjY0bzNS?=
 =?iso-2022-jp?B?TG5uUVl5WnRnNUxFS0xWUW1RRDVWdkZxY2lMVEhoQjc5dmt5bHkrSm9R?=
 =?iso-2022-jp?B?NnAreGFGdUROclc2SzRycWp3UVJQYTZlU3lqOVdicW5TSkh5RXJhbEN4?=
 =?iso-2022-jp?B?Zk5VZjAzOFZoQk5mN0dkN2VrYXZhSGc2WU8zMEY1UVBjejhaVFdDTlBR?=
 =?iso-2022-jp?B?ZDRmOWp5N1hmWWZFcFVMeTBtNWJrcDl1eFAzenllTGhPOWFMOFNjOFlv?=
 =?iso-2022-jp?B?OS9JbjJEN2c0UUNadGlMVE9lbThBdzl6ZThqT2kzYVNldzA0S04yUkJP?=
 =?iso-2022-jp?B?Z29IdStMdjdpU2hjRzJZeHV6cnE0Tk16cFhxMFBQUlhKMFZ2cWtVYUxB?=
 =?iso-2022-jp?B?czJ6TVk2dm16NEJtLzVrT2R5UFhhdEdWaVNmTGNSMTl5NG55UjZqY1h0?=
 =?iso-2022-jp?B?QmdDQlRONldPMm1NNFpuRDVZZTVjenNPWnE5ZHRqYXdKbkNjUldtblRP?=
 =?iso-2022-jp?B?YVpVUkt5eFdYRGZ5Z1haMWpBTW82cVNSVGYxWDk4S0pTYU5ZMnJ0TGlm?=
 =?iso-2022-jp?B?Qkp4RVJYN0g5K2V4YlJXMTQrTTZoa2xrR1BmaHRiWWdVVFIzSGpCUzc0?=
 =?iso-2022-jp?B?OHJZS3RSMXpxZlY5eUN6OG1tYUxMVnBKcTl4MTI5TnB0bWJBSXJ5MVoz?=
 =?iso-2022-jp?B?WG93c1pBNlhKajJIVGJUZlVYVEVnUlRETktPSjAvMzFWZ056SUZPQS82?=
 =?iso-2022-jp?B?cnd5VytPSHd3STZUVGErdFlsckNsd0gzazJIV21NM0l4ejljK0ZlUWpU?=
 =?iso-2022-jp?B?OXBJOTVQYU9WWkZrZUEzMERveWtOcGVqdUpKb1c5Q2lPYVVDd0lnNys0?=
 =?iso-2022-jp?B?SWpkUmFCQVZGLzNFbGNHRjNvMmZ6Z2NRMXNaamltTHcwL0NoNXk4eE9Z?=
 =?iso-2022-jp?B?Y1BzS25WTXpMZHV3LzhLZ25VdERnQTdQTytqQlFOVmpPZm1od3dtTFVN?=
 =?iso-2022-jp?B?ZHYrcm91Qy96bElPdnkvODlMdmlwZmk3R24wbFFlMXBkSFRzbGROZGFP?=
 =?iso-2022-jp?B?WER3ZllNTXE0dVZUMXJDNmhSUzhYL2FoUWdLek9oVUR4S3RSenE4RkVl?=
 =?iso-2022-jp?B?OTRlbm45eGlpUVJyZXhsd2g3OERGNTVVeDBYYjY3UlUwOEJJYkVrM0ZB?=
 =?iso-2022-jp?B?cExRQzFZMkZDTExYTDcreTdJUllDRnpjK1l5NkdQK3VXV3d1ZmVUaTV0?=
 =?iso-2022-jp?B?bFlNNmN0dkFNekxXWHB0NUxiRFZYdHpZVHpLSEdlRVA5OHJoNXpGZ0ly?=
 =?iso-2022-jp?B?d2NjUHZ2RUFXdVFhYk04dUIyQndxNmJUZkIxbDRmN1ZESGkyM09mZWF4?=
 =?iso-2022-jp?B?MVh5WVI4ZDN3Z3dZUUd0US9aOUJCQW5sblVVa2hlSm40NWdKWm90ZnRX?=
 =?iso-2022-jp?B?Z1lpYklORm1PV2djeHliQ3M5dUZxcFdlbjhiZ2w5YTE5ZXhVWXV5dCtU?=
 =?iso-2022-jp?B?dUVIODlhMktPYTJGMkhGbGJQQzR0UVZvMVpxK2xHanJTaHZtY2hoeG9E?=
 =?iso-2022-jp?B?MVAwMzFtNjJRbHlKMVRrN1dCZWlNc3BzbHl4SFp4aFIwZGlMUzdoMUFS?=
 =?iso-2022-jp?B?YTVWdXJ0a2VLTzVxVkxOTTF5VGY2V3Y5T3ZOMnhSc2NJQzh0N2FMZXB1?=
 =?iso-2022-jp?B?ZlBUTFF2K2g5dHhtUHRCZS9DbVRib2Z3NGVjeHV5M0E2R1RNc2k3eUwy?=
 =?iso-2022-jp?B?UVZkVUxuUlc1cm1JMmc5OXV1NFVXTkh5UytBclhETzFiSGRmdllWV2sr?=
 =?iso-2022-jp?B?NGVaVzVk?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 673bcd57-4ff7-42d9-b793-08d9c02ca8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 00:40:29.3863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 yBwR57BYvpHuMVEZiaPwM5t7mYrQl8WHqXAEBXZNwMO9qnjyKdGGZRmlbbBG28XL8D0TCW3vbngiWRALUomatcR+AoHPAnlC6vHIGLjvlBB9wZcJMmrPrMpLblab+a+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 01:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7112

Hi all,

>> I have reviewed patches and they look okay to me. I'll proceed with
>> testing.
>>
>> Do we have suitable board in the test lab / is there plan to add one?
>
> We don't have any boards in the CIP labs yet, but there is a plan to add =
some.

I think I need to add the board to LAB first. Of course, source code review=
s and
build tests are possible.
And If my understand is correctoly, I think this is a new board that is not=
 on the
reference board list. I don't think this has been discussed at TSC.
I think it needs to be on the agenda at TSC, whether it's a reference board=
 for the 5.10-cip kernel.

Best regards,
  Nobuhiro

Best regards,
  Nobuhiro

________________________________________
=1B$B:9=3DP?M=1B(B: Chris Paterson <Chris.Paterson2@renesas.com>
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B15=1B$BF|=1B(B 19:34
=1B$B08@h=1B(B: cip-dev@lists.cip-project.org; Prabhakar Mahadev Lad
CC: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B); Pavel Machek; Biju Das
=1B$B7oL>=1B(B: RE: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC id=
entification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 15 December 2021 10:06
>
> Hi!
>
> > This patch series adds initial support for Renesas RZ/G2L SoC [0] and
> > Renesas RZ/G2L SMARC EVK [1].
> >
> > The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
> > DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video
> codec
> > (H.264). It also has many interfaces such as camera input, display outp=
ut,
> > USB 2.0, and Gbit-Ether, making it ideal for applications such as
> > entry-class industrial human-machine interfaces (HMIs) and embedded
> devices
> > with video capabilities.
>
> I have reviewed patches and they look okay to me. I'll proceed with
> testing.
>
> Do we have suitable board in the test lab / is there plan to add one?

We don't have any boards in the CIP labs yet, but there is a plan to add so=
me.

Kind regards, Chris

>
> Best regards,
>                                                               Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


