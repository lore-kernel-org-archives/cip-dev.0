Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F07C00140
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 06:40:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.8139.1661323197493813110
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 23:39:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27O6dmbd016391;
 Wed, 24 Aug 2022 15:39:49 +0900
X-Iguazu-Qid: 34tMQUQJrloRTkX545
X-Iguazu-QSIG: v=2; s=0; t=1661323188; q=34tMQUQJrloRTkX545;
 m=/P1QBmmpX3BfNeJ6l8fKMaM/Yai+lpiP/ep+RBDt97k=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 27O6dlqr008089
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Aug 2022 15:39:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PneugBrMyuTw2Kk4+tO/B4evuYIRhii5Xa2JDwUr0+ELBVuG9Db/hxibNbYa/dRj7l9eEDYqUGU0R5w+Vyre/Q5IZdE500TO75HgU9ZpwcSU6OHlwuEARXm9WLa07wmvN9y/5EWa51AJ87t1e8FweDxT8GulR25DttBDqk8akXvWFsy7HyZuRTzO50w7ndi6GZrJKbOZc7HwmIkIyP+8xvqo8HcN1r+F3BdfeA5y2gHPUCu/ulD9CMFJ2yPN4C+b5yDVlkGFpbnz0wXVvdqTF9b64nMakugZTEV8SUPDXlUozAj/hpDyypnPBX70RrvJkMGeUmKzu0GeM4n0PMAXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV2ziOiqWjrg2nFNIy3ceO1BUsDcETcFsboI5pbueEs=;
 b=bbvktaMjLoHJzN9448LB3drtun0Ahg6QL8DE2yxe+0zGU9fDdZhv9/2eAXDMITOX+PeQCqYelq2AxbXnTkoeVgrE1+jiyazVVP8XV4fwJYXhDgfJFyrv2zCtJDD+JcdL3Cl3Me2i+hQy8oLrQOzLZ+B8XJOpd1hHCiGVADAfniFAqlsQFBHe4HcQVjQiGlYb1Z9BV1Zv70CaxAyE/PDkVdNT+tZl4wdfqCNvMsCDWaeD1BmLHSssro9eUc8ulIKSoAJo021po72bkc5117kVyqxO8+UeuSSfDaUNbiv/K8VlFrqhIdK57hbNSQRmr/tUZrJ7vXUjXwAYvRSU8FcZbA==
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
Thread-Index: AQHYthlhrdnvag5d30CIu7c+5bRkDa2640uAgAJhGtCAAFeUEA==
Date: Wed, 24 Aug 2022 06:39:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942096F58C098B38BBA15E6A92739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220822112046.1067688-1-biju.das.jz@bp.renesas.com>
 <20220822130443.GA16642@duo.ucw.cz>
 <TYWPR01MB94208953755A099EB76E838892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB94208953755A099EB76E838892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 947a270b-bafd-4a42-8cd9-08da859b6ec5
x-ms-traffictypediagnostic: TYAPR01MB6332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HWA/hrHPivMG71yF8rVC6abSqVVQqrUR4l1UnlGJGSROAD2K0xUIp8czhSAJbNdMgr7XmPP8vaMoTbMKwkROCn8gP7u6cnpqG7tDBIJfj4BIqBodjh8GMY4kSIarEe4dVlnl3sYmj/KZSIb6FOXAVcRTSwkQ37n/cadpUz7gsWwW+9b7wSPd4b964ffJAtF/TuKQe03OJoNUQ8xmhYhRpl7wcBrwrlkYZ/3P6IS/UVdO+vVsF9nhGyzIgs7DHC3TmL9/+d8ECicYwjlvyphxvO6etLWwCgZ1BuIQiyvqPuFyrTAalxqkqfTio2JNf0YvyGml5p7EFYafSs1tGtouFMV0+mUSL3QSxZVgnm8iEauagdUKUKt7Iz0FmzytBpG+8y7q6MFd0nEIscSdb3l66ilpDfmCxdfXDuLvUMHo9wuo4rQWseCE3YkdR118X8rMR1NgB2jl5Jals0rjbgqnvrKvLI6xBTVqK1lQFxQcn/z2u6Aw0n1Ynww61U0Ci+BW8WVCHbbylbb469M+mcxoDPfzQrRPnT/f73lU1xhhhSdTnjSbbt9SSPnRoNPV2YJ4WIGbTAKcxYjnOjmrUgtMWe6Ik/9XidwCBBwBjRPhszO2IFBYlXTFg3AeOhpLrbmYwMnHMduhqzwHkJeL92GMdXbWqeDP7Hbh6sZSHv3RiJj2yJlg3KR9KtiSHr2thMXlSyLZEhHXGCUnTYDqYYc2QSw/TRH0mlbcVQXT03gGi6i2feHDL0vo/I4w0cZ1q7ylaQy+gwre7MJVzBXXTXKki4Fwbzer3vuaZy7/0/e0ebc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(9686003)(966005)(478600001)(83380400001)(71200400001)(316002)(26005)(2940100002)(55016003)(110136005)(54906003)(33656002)(186003)(64756008)(38070700005)(38100700002)(66946007)(122000001)(8676002)(66446008)(4326008)(66476007)(76116006)(52536014)(66556008)(41300700001)(53546011)(8936002)(2906002)(6506007)(86362001)(5660300002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q2hyeWFqVm9XVkt2SEtGUzE1Zi9teDhkOEgrR3AxcFpEVGROSWUwQlBE?=
 =?iso-2022-jp?B?aW1xWk9SNitBMFB4YmgvcW5yVjBBSDc2WFJ6a3NDMXV1NEJIRHlNbGQ4?=
 =?iso-2022-jp?B?TmVwekloMTZkQmxDSEVyc1F3cTJ3UmxBMUpEQXk3M2laemxaVElPc2Ja?=
 =?iso-2022-jp?B?TmR4V3JuQUpVdGxVYnJLTVl5cm9DUW5pd0FrQjdLNnNhQllDU1BsQ2JK?=
 =?iso-2022-jp?B?bmJENDBZRXJGS1orSEdNZGs4ZkkrVTRUMXFpMCtxcHZuVlBCc0N2bGpF?=
 =?iso-2022-jp?B?N0IxMk9zR1VMZm9jYXdEWW5QV3VlSnBnSE53T2VqajdTQUdOdXlMMmx5?=
 =?iso-2022-jp?B?Y08xUHJrUjNTUGIrbnh5aGY1dzZqUXJqMzhjQ0FSaFZYQnM0RlZYaGs3?=
 =?iso-2022-jp?B?eEM1eGtyZDUzNnFRS0hoTnY0Q3B1TUxWL1JTTkp2Q1dsWlF3cTAvN2Y4?=
 =?iso-2022-jp?B?dWJ2MVU0cC9vM0dkL1RJb1h1cmpNbTNGdVg0QmVoYkJwV0h3QzhHZDZh?=
 =?iso-2022-jp?B?c3o1Q1AzMEJjbUxmYWU2R0RuNGFPdjFGOUQwOTVSanVRMEpvYndXd3Fo?=
 =?iso-2022-jp?B?VG5CZkRUUGJRd2d0YzlPdWRvcEcwMS9yOWdWV3dUbVJKM1VkTDVmOTBn?=
 =?iso-2022-jp?B?bEZrbk43UkVoV1gwWHZINTFRZE5HOGtlVjVjNVFmUnBQZjdhMTFIUHFj?=
 =?iso-2022-jp?B?K2E1RVFCSUsvbmhSZFlsN2ppYTRLTTlDMTM1N2ZPOHRPL2p2Wk1DK2hP?=
 =?iso-2022-jp?B?blJjUGFNQkVVUGhDTE1tMFlHc1pMVmpWUkR5R1hxNldHOUgyY0xtK1Zl?=
 =?iso-2022-jp?B?RDJVQ1gvZjRSWi9QSGl4V0RKcTRyS0JBQUx4ZDFFa0dkUzNRbTllZWZs?=
 =?iso-2022-jp?B?bTIwckhtUnAxWnJEa0lPV3lDM0ZKaklGUkN2b1E4ZkZpREJQUEpsblpq?=
 =?iso-2022-jp?B?QlloN3ZJaUFDcE5DSWFlckxzR3BNcTQ2OG8xWUdud2I4cnErZzlFaU5q?=
 =?iso-2022-jp?B?QTBOYUwvZVVibFNyYTc3WFlKWFNuN3B2TUJXMUJHbXdCMGJ4bmpaNS9D?=
 =?iso-2022-jp?B?b0daU0xnVzBZR21HSkhjdlRQSUpaME5qNG1OUmFwcGprMkZnRVlSR3VM?=
 =?iso-2022-jp?B?TGIycmVqSG43Z2k2M3NTMGM2TEJ4QkRvenNITHlheTRDaVFaUnppRVJu?=
 =?iso-2022-jp?B?dUcxdmlPb3B4K3lhS0src1dxaTE1L0dadHozM2VIZEE3QzE0dTlWbkt0?=
 =?iso-2022-jp?B?d3EvalQyb2ZuRXFtcVVrbGx2aENCa2p4bmJBVnNRNUlVb1RuWHlRcVk4?=
 =?iso-2022-jp?B?bTVWdmMvSGhzSHJVVHdsRVlzbFRUYS9NYjRpOTlFN3BYNDllSGRONng5?=
 =?iso-2022-jp?B?WEZpV2szaVI0T3VuNVhHNTFuMzZFTnZRVnMvb0JOTVNuajFxb0RzTU5B?=
 =?iso-2022-jp?B?VkJ2RExoNzNpYmFQa3lHMjhkR2hpb05JVVNqVmdQOUk2MUtJWkdQRlps?=
 =?iso-2022-jp?B?SjUvb1phN05PZXd6MUZhTndZZnJUSW9YRDFmNnYrdXlranREWHY5QnZP?=
 =?iso-2022-jp?B?b3djbFlweHJvOGc4ODJRQnpJZGcxMTFSeTcvZHlLZVM3bldodjM3TENr?=
 =?iso-2022-jp?B?RzhXZUFMSHh1V2s0QnUxUjFNZkxXUi9ROVUwNGpIeXhSY2cya1RuRVY1?=
 =?iso-2022-jp?B?VjFRMnJLV0V2dWZ6RE1CNUNnSU1XbzFla0ZxUnZxNXNpcjhnN1kxWVpJ?=
 =?iso-2022-jp?B?YjVZSi91ajFaQlNwckNtZFBoVjByK1dROU5aY2UyZnBaNVhTeHgwcHY0?=
 =?iso-2022-jp?B?VXExUGRzeXJwempqRkpoTGJaOUFLTS8veWpWODBUcnM1MXp3TTdVbnpB?=
 =?iso-2022-jp?B?T2xjbVhzemNUMERYU0twZGRQdUZQRW80TkRibVNHc2FmQXJZalMwRUJO?=
 =?iso-2022-jp?B?UFlrL2FUVGcwSUFLeTdrZU5ob0NkYXUzV0Z5Nkp1N2hrNE1USW8xakIx?=
 =?iso-2022-jp?B?U2l0MVZ6dm1senhPYXozYkUvbUpzZURwd0tibHJ0WHZub2JhYlRiV2pF?=
 =?iso-2022-jp?B?UEhYbE5ValNSSzg3WENoakR0Tm91c1o3bWhpYmR5UGRYbzNIcVZlRzRo?=
 =?iso-2022-jp?B?Umt5emV2VnhLek1ZaTc3TXdEYStRR2FpNWNyRmtMK1JHd05OTGJrbVIw?=
 =?iso-2022-jp?B?Q2JtdkJvOHVpSVZkQ29uWjMrK1FWdWd1Q0d2VVE2U2dDNWVOQzRZblBL?=
 =?iso-2022-jp?B?d2pvYkc3Z1lpUFlPeHMxcnFqZDBHZmJKZ3A4WlpZUzlwaFFtaTZ3N21B?=
 =?iso-2022-jp?B?N2tjVXpPK2NUNStudjl3SnNUMVJSdVJTSmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 947a270b-bafd-4a42-8cd9-08da859b6ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:39:45.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 M1k2pw1YpK5ZjZxguK4cHYhjJjk5WUN+TEHwiT06MbX3sZ82VZEiy2zspDsaXqE6dSJ2xGOW1WGyUCEwUpaabqmShammrjs5pJIupVO5ogwzN6KFv9d0ULdJye+PAqCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6332
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Aug 2022 06:40:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9317

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> Sent: Wednesday, August 24, 2022 10:50 AM
> To: Pavel Machek <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Chris Paterson
> <chris.paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status fun=
ction
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Monday, August 22, 2022 10:05 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>;
> > Chris Paterson <chris.paterson2@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status
> > function
> >
> > Hi!
> >
> > > commit 02c96ed9e4cd1f47bfcd10296fec6b0b69d6b3c6 upstream.
> > >
> > > As per RZ/G2L HW(Rev.1.10) manual, reset monitor register value 0
> > > means reset signal is not applied (deassert state) and 1 means reset
> > > signal is applied (assert state).
> > >
> > > reset_control_status() expects a positive value if the reset line is
> > > asserted. But rzg2l_cpg_status function returns zero for asserted
> > > state.
> > >
> > > This patch fixes the issue by adding double inverted logic, so that
> > > reset_control_status returns a positive value if the reset line is
> > > asserted.
> >
> > Looks ok to me. I can apply it if it passes testing and there are no
> > other comments.
>=20
> LGTM too.
> I can not find Pavel's test, so I am running in following pilpeline:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6210980=
21
>=20
> If test is OK, I will apply this.
>=20
The test looks good. I just pushed.

Best regards,
  Nobuhiro



