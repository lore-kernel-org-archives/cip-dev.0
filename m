Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26A1C433F5
	for <webhook@archiver.kernel.org>; Mon,  9 May 2022 05:48:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.28364.1652075325799406435
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 May 2022 22:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 2495mbx3010037;
 Mon, 9 May 2022 14:48:37 +0900
X-Iguazu-Qid: 2wGqyLn9T2VUzv4RiZ
X-Iguazu-QSIG: v=2; s=0; t=1652075317; q=2wGqyLn9T2VUzv4RiZ;
 m=KVe+QDd9BZ1mPKeA/si6dsMXWBj6GoJRM+wivF8e9G8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 2495mZlW003366
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 9 May 2022 14:48:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQnrKpIQvJBZ8V4XllaX99bDBVbe/6vPihI46Frd2GM4+rtrK31baynM1DFyXNZoVZgntAZtHCwgRyP9ufH9ort/V2Tlvhierr7/eDU0r/Tcp6F1HMtMAQIlNsKs2rwvEXPxxTVJZJoVv74jyTPht+lDTIq/GcCM6Z9e7D0zutONVdJA9amh8I+SjQFiBEQoNnzWlnopGIU53gPRFmV78QgzY5itoAoiIJm/5IhR9sdXqfxwoMyrimFodeiwA6wDlAbOm/axEq7boXIn9lUCM9dw3cELjFXf/kk7a8h2+jX0pHk6SbiYlUp80yXqV3ci1fCQkusLFhwvO5ZoxcAd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEqGpoaCvg3ANrd79ZKKXaokcUgUkEQ0wOd9U30umgA=;
 b=iXjeFuwJhuW7FMLSENW3yO82SAPYnPTEMlR/54He/JEb+vvvRGBxrDd3d3bsaunYAe9Oew3TnBXNdkxc8HAMGxRsbCCKy0gnUhfy0teDcNh+FciyFY+QPiDsnPYApAO7Wpvy8FpYGatkjYLaqwJWmghzthm0TW8oTieecs1UgecVPCV9UcjnrLVT6B2NvcjYyeMiGMP2iQouG7L18XHRvZ5upqF59i5KZFPHcksO8J4cyDfpQuszGie9JcM3zQNDzplIesKPALJf/aVvhbMr8DinEu6PIBRiSCe9N0IvMegVaUzsffE1nxz34/pPtf1p58FUJ8hT/iNqf6BK6MvNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <takuo.koguchi.sw@hitachi.com>, <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <alice.ferrazzi@miraclelinux.com>
Subject: RE: Re: [cip-dev] 4.19 oopses on socfpga
Thread-Topic: Re: [cip-dev] 4.19 oopses on socfpga
Thread-Index: AQHYWyZjjycdTMV2UkeiXZzm4S6pj60GASyAgABnUwCAAqbDgIAM/CEAgAAONAA=
Date: Mon, 9 May 2022 05:48:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420447562C64D084430984C92C69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
 <20220428173525.GA32556@duo.ucw.cz>
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
 <CABMQnVKzp7B+EF+9vFPLbT0qjfYk8-=_UgFVk6afq3AOO+vPWA@mail.gmail.com>
 <CABMQnVLKZ6XW+mvOb2JbREz7RR42faZ9QDfAquLAi8-CXjmGGA@mail.gmail.com>
 <TYYPR01MB8000262CEE0CB266FCD00B21D7C69@TYYPR01MB8000.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB8000262CEE0CB266FCD00B21D7C69@TYYPR01MB8000.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569c1acb-899d-491e-ad5d-08da317f8d90
x-ms-traffictypediagnostic: OSBPR01MB1848:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB1848F5A96627F52C6E283CEF92C69@OSBPR01MB1848.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yZIfbFJTbgHr13Hu3Hr8Vlo1ltazChxk/ceT1J53f2CqMV/aQxWwLUgFpT0NJUh1oMnjD/HCdIpDQzkZsCGliOzkf/gUNjali5VnKGdsYeTRrIFg4Ue472CcS9TvETH6ywTJ12V+JhTR9oCgWGP+n/KpJlEWE0ff+QpCg0gOyXSeiMSeJzYujMVm4cx7LfE/ZCL8/yRqrjxWs61vYjxNq01DSLdKO2e7b9j3vkTK/eNb5D4tdejjHPL+4a2SNeX5o100yEzRv/lrsG8jgoBrnsPtIYNHl5AsIRJazufxJyHCbXSS2d5p2vniOFBl40eaiLEomZyPFAT6s1o082WaMPuYNIc1Og/Dm6PvjjCgdCsupTFJgUcIIHYAX1DRHopoEEkMhLMswHuQKEKs9SGSEBHe0f5x9PEvEOSghA7UepWpOQOrS7mqJZUHP6M/Jxxll9+RL9m5sYYfCXcE5IMNLEAq86lEM/WlzFaeLQwhN38nilkXDY2wMoCCX5mrov9u4wYLRvYhNMkFH3siZytHOyOT9g8L/3QoH/VgJO3PnQJL6XclLmCF37JjUuksD3q0giOfXsQ4p3pH6ZlpOItMYwqUZqb0818xEIe/pMh9WVqMZseZDO5b+1pIPnfTuZ7ZDA1Cw3cCZJMhBnFlg0Lcj/5rlCcLOCr4UNqalPo7pY/5PTCu+8IQs/wt8jefzXqwab6H45wA2Yo32spDI5u5luamKUdC28BfYCGHElAnhRpyKL0u3p5SrWAWuf72vf6bYPC7+Ig1wLkFMLTV+pDAv02RhgulzZhMgDeKNakOZQU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(966005)(2906002)(9686003)(186003)(33656002)(122000001)(26005)(55016003)(5660300002)(4744005)(8936002)(52536014)(6506007)(86362001)(7696005)(55236004)(71200400001)(8676002)(4326008)(54906003)(38070700005)(38100700002)(110136005)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bkJxZkF2UmVoTWloamF3cm9tVlRDVmdlZmYrNWszZytiVGF1d0NyTnBK?=
 =?iso-2022-jp?B?TXhqNFZ2aGh4a1ZDQjQ4cThtRHVjb0RlV3lzTVRIL280VXdiL2dJN1Vr?=
 =?iso-2022-jp?B?eVlmWVNlU0l4Zlh3SEdSeDNjdCsrK21pc0pNMVhyd2xmdU9GcnhQR0J1?=
 =?iso-2022-jp?B?R3AwTUx1R21acFRtNmN4ZHRmZGVadkt5TEU1SjdVZW9hYklIenZxQWhH?=
 =?iso-2022-jp?B?QVBQNVNFSWxndGZaYmpXU0ZpTzRSM0pNVXV5VHpFd0JPR0s1b2YzdGk4?=
 =?iso-2022-jp?B?NzF6Q1VRbVZoK05pQWluUUtNdi9aSjNvWUplci9MVDBQRHRhaVptcDM0?=
 =?iso-2022-jp?B?alRhMS9NKzN4Uy9KbGVFc1JxdlZxNjY0bFVJOG9hV2xmOWEwT1NqRHFQ?=
 =?iso-2022-jp?B?UWJ1bm0rN3JLOUJTSFZYSDJyQS9ZSUlYSldoTW1MbFNzV2swcEpYT0ln?=
 =?iso-2022-jp?B?a1FPVlhiSVNzZlAwNFdMSDdIN0pkWVFVSFN6eWFCc1JsMUFjNGdQT0ly?=
 =?iso-2022-jp?B?dzZHakNxaktNYXBSVU5DNEFpK1VqUTB5aHpqNnVkSHN3WllFSVlPa3E5?=
 =?iso-2022-jp?B?OGZGVWI1MTF3YVV5VTRJa2dwN2JvRlBlTUFVbW55UHU3RW9WalFoMENz?=
 =?iso-2022-jp?B?a1lENE9sZUR1MlNjbDQ0ZFE4R2YveEJHcGJHZDBudWFnUlU3WUxOem10?=
 =?iso-2022-jp?B?K2RTR3VFSEtEZTJMZkxoeEdkMUF6THNWRC9rdGtMVnN5TE9USlg2bFMx?=
 =?iso-2022-jp?B?Nkpxclp0cndaMm4yMVhuekFxelhNajhMeWFwVVVkL2xkUEtSaEFiYU01?=
 =?iso-2022-jp?B?anAxTExhTGJQcjZvVkdOWHEzSUtOSHBMcFVLQU5GdFMrb2JlcjJ5RDky?=
 =?iso-2022-jp?B?dGVlWkhFeFZBSjRZQ2V5dStNZXc5ZDFhVGdFTnhVMVlpZUNmZW1PckQv?=
 =?iso-2022-jp?B?UkVHcWtYMnV3ZDA3MVNXMEZTbHNtd3cxd1ppZTNmRDlxcVlVeHNKRVM0?=
 =?iso-2022-jp?B?SWlPVWFNclZhaHZnbHFVSWZRNGViVDJTSGNOZXRqZnVmTUNKSlNnRGdY?=
 =?iso-2022-jp?B?OEFMQ3RyaW1MTGM2d090QXlUd3NwUVNaRXV3cVQ0TjQ0RDg0dVV2aEFN?=
 =?iso-2022-jp?B?UGJHTU9MV2FENkFNTUpNK0JXTFJrNWlMYkNqdzZlR2lZbndSdE1ETkVG?=
 =?iso-2022-jp?B?QkFoRHovRlZac3dUbmZWRW9vZzc4RVJMSVplY0lKSmFiVExRNlNvOUpM?=
 =?iso-2022-jp?B?SHNXbys4K1Y2cS9wRmxMS3VYTDIxR0g5b3dtdC9UOVA0bmRJOUUzclVR?=
 =?iso-2022-jp?B?MG9lS0hOc1F4Y24xeWpsTWtaYis4ZEhBam5YbXhjMnN5NXFuOEVXTFlh?=
 =?iso-2022-jp?B?VkV3cU5TU0pRNlhUNW56OG9jL3RQa01pcXo2blNlYXRqMi9ha1VBOVBr?=
 =?iso-2022-jp?B?NnJ3YWhqWVRJVS8ralFqQUtKUmVHeW5PYk1TTVRxT2RkMlJyUUQybDNa?=
 =?iso-2022-jp?B?eW1FU3I1VzdjM0NOMDVSR2VIc3FpOFBjblkvMFJmMzRpQW9mVzBCdndR?=
 =?iso-2022-jp?B?MWk4WDBFazdmYjgxYUZ0YngxSVlhRlBCVFNtOFdEQ2ZQMUNNU09sR1NG?=
 =?iso-2022-jp?B?aHNYZTdINWgxSVBYNmx5UlFJVXZ2cEZqTWZia1lMMytscjBxR1JhL1E3?=
 =?iso-2022-jp?B?UDFoR3BPNi9TQkZKeU1CZGlrKzJKallaN1p0Qm1pS04yblZHRTNLeVJj?=
 =?iso-2022-jp?B?N1N0RDdaNTF6bk1mYUZnS2VzcnAyNHdzaWFpMzhCbHUyZkMwSkV1ZGFj?=
 =?iso-2022-jp?B?ak1OMzJ0dU1tRUdRbTZQbFZwZXNxcm1UUmZwNkNtV3dObHpuUEljblF6?=
 =?iso-2022-jp?B?azhaSGZBWFN4QjIvZ250Nm9NTGcza21vSzJ6eUxNclQzK2orcmhsT3BD?=
 =?iso-2022-jp?B?UVJ2R3FyU1U2YytvNGJoZ0lwWnVVdVl4SFYrVVgxdnVDcWFQdHlwT2ty?=
 =?iso-2022-jp?B?RnFEWkNKd25hcm1nSG5yaFZiSmFPb0ptMExKb29zSGpsTWNrc3VINlpv?=
 =?iso-2022-jp?B?MXlNQ2VzaEZ3YWsxY0cwYjFlMXBNOWZVY1dtcnk3UVJUcW9GaW9TMWpm?=
 =?iso-2022-jp?B?RCtCdVdnbm1Ic1NWcTB4bkpCekVZRU42VXh5YmpGNGVoRk83MldSaWgz?=
 =?iso-2022-jp?B?L3BOZ3licy8rRmJRQmYrNWdXVmEwTzJJcUh1UlNXbWJtQWJRVzJKMDd1?=
 =?iso-2022-jp?B?ZTcxS0FpMi9YQVZvL0J2WlRYNVl0cHAxSU9FVFdxdkFyYk1EZFBzUUFG?=
 =?iso-2022-jp?B?TkdFcFZmRGxoTVJZdkZCR0F0NlI3QjdLQ2dBYWRlTy92SWhVLzdVeC9Q?=
 =?iso-2022-jp?B?Wm5xeFRxdnM3ZENNZUVDMHZQYThUTzdhakdWc2RZd3c5QUZVUmtQK0FV?=
 =?iso-2022-jp?B?Rmg4RjA4eHlvR2duSFdYYkJXQi9SRUpuMlJpSUdIU3VTS3dLR2VsZU1D?=
 =?iso-2022-jp?B?dzhUYUZHRUFiU1dsVytoZVBmeU9OcGN0SHdORld4M0lWZmtkQU5tTEFO?=
 =?iso-2022-jp?B?YS9pNjZCbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 569c1acb-899d-491e-ad5d-08da317f8d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 05:48:33.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Ws2srGuEOVvAXAVvRa3xThTXf+ZnCpxjBD8wzWdr29P1V1wbmnGDsNJ1etbSBNA2J3xJ0pxw+jJLhx/+dFoSVBsr0/dR6iQD+NQ5lKy/OyYHKrSR9x7zhUSJJL3J94GZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1848
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 May 2022 05:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8270

Hi Koguchi-san,

>=20
> One of my customer has reported to me the same issue(oops) and the same
> remedy(revert) for v5.10.112-cip6.
> Is it not recognized yet by the upstream or CIP?

It will be fixed in 5.10.114.
5.10.114-rc1:
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t/commit/?h=3Dlinux-5.10.y&id=3D59e6e7df9216d52a16448ad48a45e62def70acbc

CIP will support this weekend's release.

Best regards,
  Nobuhiro


