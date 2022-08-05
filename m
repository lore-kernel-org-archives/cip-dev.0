Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4714C19F2D
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 00:57:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.1820.1659661015379001596
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 17:56:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 2750uhMB013071;
 Fri, 5 Aug 2022 09:56:43 +0900
X-Iguazu-Qid: 2wHHCS9NGBn9YuLIE4
X-Iguazu-QSIG: v=2; s=0; t=1659661003; q=2wHHCS9NGBn9YuLIE4;
 m=VULUc7K5/g5DSFyfpIyI5btcMbMha3z2IOE9WtYJSDo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 2750ug6M023134
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 5 Aug 2022 09:56:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn7LqVnB0EdTwI4KaVOfc/OTc12ByNCU2LCprZmXjHNjq6EBo6ywjTqGZpvuT/6LuE77w3Qwpt0OCJoFJJUxKy7uLzpA0xX/1j+dZthbxNMml2tnU7IiM0QVb6N9jPRiSgYJlU2z93zy8BNMoW20ZDkNpTiCm5RDvgwjGTA4AnNezPIM5uxuoZ/ZatV6ID23VmWxbwu7EXQa0CZ2zzC+ul9JFHFuySxjUSw8kexFs0Tcc/T+loExmO8txzdQdQImi7imeiXgnECN1CYxrKP1C5af8KR+ensPAVqHeFhXI+Hz7kA+uZacFlvOSf4n/dxV0liRGcm8hU+CFzfBI0Oq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d+nF28rKj0MaWVui2tJIv9dSeU2UPOviKZh/Z+JZGI=;
 b=LFa2yYTUsezcqWRyxCYB6Qct9EL112pUahSuKEwZmvbtl4fuJqhsv5rPx++x786aDvyJ0FwI9r/3/5svz1i3/EfQaSmqXHcwUABQ/35/yMmXzW7sha166HgVlWN6VXA59jJ/huYo8FmKv3Yoi7Nha3sA14PTQLBHEmZvjhXimMBJiTb7KvrLUYK33xDmdQpEv7MRpjWB6xm/9fcLG2sCVp+ocRGcQs9jJQIvSeSwDVHxgofOfwp0B6JqDxG3wBBISOtiUG3cdfXe0nmej5b0b62724geeg/h06Kk4LTkbC26bKrFKqplyMbIJnrzr/VB2QNOxX4GdROYnUO+IFTxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Thread-Topic: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Thread-Index: AQHYp1mpLrGn/DUkIEWLAWuwmlwTu62eL7tAgABHboCAAQZrIA==
Date: Fri, 5 Aug 2022 00:56:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420166231D55B7837BB9944929E9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420B86CFD0071893D86D2A7929F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220804091651.GA20458@duo.ucw.cz>
In-Reply-To: <20220804091651.GA20458@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66da3963-a644-4281-b904-08da767d5aad
x-ms-traffictypediagnostic: TY2PR01MB2044:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TYOmrBYc0i3+XUkAFcESIHirjszv4qUBbsvU4sxDz5VCeGsjT4TSIGuDw4RjxL8YhQ2nmOpLZ6vQqycSN1ScqkIZCY4mMsbyA+BVrTrkUTSz34cyLXLfPVN+THapNmL00ZJBhGk5KHCTKUTq7VTZenRtEnnBvTWNVWT3FbMDKECHV/aDPlOV2JcqIb9Ngi8fFwBCvob5deojhYkJqrt8gz7phMj+7d9UnXQOps8u7sZs3RauXIsHbwgdnWM1XyuUZolfaSEm5jdEJredLv1ZPTJ5Up0oyEXxiiT6+is+7a7FjstqMjSml2QR1Xwyb8kOWeLRSicPbPkX9uLacq4sfIvIxpKKsLyYOhAwvTFVYc5tYRDm6oM7hfhypVftazaNbbklvsrruEY0EEfC5BjqOMRvV6p2SiXczUuWFJPDgKqb4Rdsq07HjQP7mQyCInBpt0l96qcvnRjaXBf/lM77zYIL3tMXU4LBp/A1Y+rFSzI8v/AtjX2fC17erpQZxyl0FJCR7/Eb885U9S85Ivxt41fe4Y/xxoiWM83H7cfkYgHpCdHwsCqtOhSGrhZYQXMqnZFKhM2q6OYLF/A24AkN4Hhf+3HhmzL15JWjKuEIB67NmavU5fYg3ZzNsSjrTYwn25YRB713KdwoNrQ5GdigCf0s06sgJKvLOZNqyCk7PcgwN/Rqzz+q68imqMuG6Mv3uxvi9TbAFNgp0UcqZL/f4KoPUDR72Kuwb9c2xrZ/ANn5+kwNzC7gWsL4a/X3g1SBPqxzprAOKxeIkTsh0mBwuDXkybzZ1ztUJ42yBzr4h1dzQKQGMLTBT2KzJPBEjdphyQQgZ3zWjZGREwUPiut5nQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(41300700001)(2906002)(5660300002)(54906003)(71200400001)(478600001)(122000001)(4744005)(83380400001)(966005)(53546011)(4326008)(8936002)(6506007)(6916009)(7696005)(38100700002)(52536014)(186003)(64756008)(55016003)(66946007)(38070700005)(8676002)(316002)(66556008)(86362001)(9686003)(26005)(33656002)(66476007)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N2FBZDBGMkxadGNUcDYxQm5iWmR4Mnp1ckh1SGlkUjljKzJtOXJJMndD?=
 =?iso-2022-jp?B?cHdWMm5sbmxaR3dMRFJrSXNLMXpyODZ4MC94Wi9EYUtxWXRWNjA3VjYx?=
 =?iso-2022-jp?B?Y3MvN2s4UXAvdFRYTlJaY0lsOVR1SWZoeFp0T1R2ZjBvazJ6bW1iN3ZV?=
 =?iso-2022-jp?B?NFVEY254YVh1K3NhckVvbEZnUFVWa1ZBbVBOVnpYaVREaUFvMjF6N0px?=
 =?iso-2022-jp?B?V0NwNHV3NUpPdEpqYmlmam5YV1RyV0k4UXdQSzg3RVJjb0RCUWJZWmRT?=
 =?iso-2022-jp?B?YmFKVFpiVDU2MWZmWjFLODFWdEZaNDh1VEozclBRVjhIM1JpWDFQRVdI?=
 =?iso-2022-jp?B?NkRNTFZiZGNMRXNDWUlHUUZKMFdkcmpSUUFaS2hZbEhrTHJ6d2E2eXcx?=
 =?iso-2022-jp?B?ZnBRV3k5Wi9PUnV3dnJaSVRaMU1Wc2dkbEpUOURBb01zcUJ2bENxcGJZ?=
 =?iso-2022-jp?B?aHBrS0tjWGVFR2tCQVI4ekVlR2RTakpVZzhRTnVFRitOZy9FQW85eDBT?=
 =?iso-2022-jp?B?MTRCQnJScDNUU0hPZWh0SWd3UXhRZFIrT2QxNG14cDVvZEJwb3Fvb0RR?=
 =?iso-2022-jp?B?bG1ibTFuemxPQlFHWjMxYVpTV2cyd0p1VXZ5ZVNPTlZLcEJzanBOVFNW?=
 =?iso-2022-jp?B?dEovUTkydVZhZ1RDQ1E2TjJLeG1iVG9jWjh1MEdJa2dUQ2ZCMWlvUjNm?=
 =?iso-2022-jp?B?M3l0Qk5XZUZhRjNUdjA5aitQZU80U0tmZjJ0SHNtMk1MdTBsZVVBNDdm?=
 =?iso-2022-jp?B?MEY3Z1dWRUhaSVRwZmc0WnV3Z3hhdkt1M2pVc09ud3BwS01WUkYxSmNm?=
 =?iso-2022-jp?B?TTJIaktTQ29rTm1BZkd0YUpQMXdSTVM3Z2R0SDU5SURqRXFEZWVNZFFQ?=
 =?iso-2022-jp?B?Y2V0a0VVeGNNNEh5VHhwYjFyTzhXcU03V0NjZ2FKU2N5YzZDTk9acTdW?=
 =?iso-2022-jp?B?ZkplOWV1MmFPdFY3NWtNSXVQMkdYL1RjdnowcVg0U1lIY0tzQ3ZRZHAz?=
 =?iso-2022-jp?B?RXF4U1FRSW5RbUx1dEg5MmhNZ0dsRlBILytmdkxEczY1YWFIZVRCZjJM?=
 =?iso-2022-jp?B?UDlqSDhRVFgxTEc3M3M1L1pwTFFnQkJDNDlzaGt3QlhTWmNSTHc4YzBs?=
 =?iso-2022-jp?B?SHplSE5zaTVaeG9Ob040NjdTZ1N6Z1p2M2dHVVVnbjMraTkralFaUVVL?=
 =?iso-2022-jp?B?RzAvQTJ3NHhrUWJSRTYxSVFOVGRiYStEYUZyV0J2U0pvdytkQ0g3OWpo?=
 =?iso-2022-jp?B?am9Va1lWSmNzWmVKeU5NOXFtVnp4ZGNWVnpMMmpaNVZPM2wrSW5vUmZu?=
 =?iso-2022-jp?B?MU4zTi9zVGJIdDlKaDhjY3pKZEc5VEt3SHBLWmhqZ0cyYnNkTnI4VU5n?=
 =?iso-2022-jp?B?Q08yTDVlVmhVYjd0RkJJczRHbEFRNEpKQUFqbk1DZ3dPSktJeEprTm9D?=
 =?iso-2022-jp?B?eHJtaC9hc1FXaEhLR0g2Zlc2b1E1bzdPVHpZZ21BdG4wT3JBR1hhMmlt?=
 =?iso-2022-jp?B?ZVNVV0RFbkJzRHBUSTFKQVl4Q1ZrYVpkRXVpcXJ3czRicG9PUUNjR3Bp?=
 =?iso-2022-jp?B?U0FDcTdGaE1BZ1hmeU5qNTlYOXZvSmNuMWVkMCtVWEx0ZEpiZFNDN0kr?=
 =?iso-2022-jp?B?ME5Db3VxNnVid1ZkWlpRNG9iV1M0M3NnNU0rMzhQMmlDbytNZ1NEOWh4?=
 =?iso-2022-jp?B?ajE0aGx1ekhlNXpoT1lkU0hRWWNXVEorSnR5M1pETWhuNngyKzNXZ1BK?=
 =?iso-2022-jp?B?QlFFbGJOb0NqVzA0TzRDclhNUXBkZnkzY2dEVXkxM21tdFpmY0VNVlZa?=
 =?iso-2022-jp?B?amM1YnlOMlp4ODMyeVVRWHREVWF2K1JZaVE5a0NvZU9YQldnYmVvR0dM?=
 =?iso-2022-jp?B?SXNGdmVsVHB0RHJjVmIwdWFRQ3BQTTh2SkVRTGdvanErR1JnSFg3TUlK?=
 =?iso-2022-jp?B?dVB4RXllYlNTT3FEMkJ0VHB1d09HL0J2cU0vckVGeTN5YnVRRkMzQnZr?=
 =?iso-2022-jp?B?QkJzcnczV0hyN3F6NWVrdkd6dVRSVURxK3dTclJiQjRLYVFwcytESXpt?=
 =?iso-2022-jp?B?TXNvb1EzdjNrNjRxZmQvQTRYLzRma3BqWVB3b3g3OWxCVWxpa0tTbk4r?=
 =?iso-2022-jp?B?T1BiaW1oV1VCaEg5WGJsR1IwWHBHRVJsMFU0eWl2aHp3UDlucGRxcVJP?=
 =?iso-2022-jp?B?Q3ZyQVVQTXpWc0JwMnd5dWN1V1lpUlRhNW5tK3NuMEd6V1Npd0d5bHRS?=
 =?iso-2022-jp?B?a2luT0R0ckVMTTEyQkh6MFN1NkFHUFlNMW94TlBnbDB6cEcvV0FNUGJB?=
 =?iso-2022-jp?B?V3RWNk8wVWNRZWowQm1MOXFTeVJnSGFzaEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66da3963-a644-4281-b904-08da767d5aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 00:56:39.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Z/lRjWog7+s7jkoVfxQ+BA+UII7W5mZ46NnAbZexOC3m2R99F5heooAJ3BSV72Hg/cyzzNEjTA5rgTCU0zv8WoIPAsW/17jqoQhpHy8a2LG2NS13uaWj5qjTR22k4tbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2044
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 00:57:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9123

Hi Pave,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, August 4, 2022 6:17 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; chris.paterson2@renesas.com;
> prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: Re: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
>=20
> Hi!
>=20
> > I reviewed this series, LGTM.
> > I can apply this, if there are no other commands.
> >
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/604399902
>=20
> Series looks good to me, too. Go ahead with the application.

OK, I just pushed.

Best regards,
  Nobuhiro



