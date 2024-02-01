Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47582C47DDB
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.8303.1706760756459146723
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 20:12:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4114CSWw3984607; Thu, 1 Feb 2024 13:12:28 +0900
X-Iguazu-Qid: 2yAbhFUjKpgDa5M6Eb
X-Iguazu-QSIG: v=2; s=0; t=1706760748; q=2yAbhFUjKpgDa5M6Eb; m=DTBLAw2FxPVTYcdNWqUJCjdIVz7qHv2UGwfzO9pYKOc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4114CRbN3820697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Feb 2024 13:12:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuLe2YG60qnz2mQh89EwSAybEDdFzuVgZPL55rghA87p0f1FgqUbjZXPNMmYx2+rR2M3CWZY/sGigdH0rULLSEPNdy1RdPKaiHAPnfT/DYE6F9sRkG1mqH5Vfg/UNN4DF5F7QQ5P4UYjJtVBkXjOK8Ej5URr7mzjeXLkUKH19WB/2NeVRPh8G/mkTT8Z9VcZJznOtWTb/RpbPRCK5x37KRNUrtQoIgnyMQRK/BuzHaVXq8r24js8u9oollskNhrOzMW4a8Hpl8YqEgRAIlk5zOvAab0We3BDvTpjBdWC9DOpPa66I1DShkd5CrYu2+ieK49GeQ48VCKV0P79sdmAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zpdCoaskUEW/j9KZheHZX+cCGBS5aah3YRTcRN6Me4=;
 b=JlZVQIhFQwKoiyVahPCnCFkvzelMW4eHJSNiimA6XPYzvfNk5o8pnivc5cSAAfAZDMd1AvJVE9SHh8d2GJrm7U9mi+aYgoUtj1oM9YByq32pmPq00CNDIM1b56hGPj6c7ffLDSbnPkI4a55P0PN0GcygNb/wY7uiRySkUNFBwnyqRV6JboduyKTF10yWA1XdssAA9uBTga25evXW+UZD7ukRbGEU0reMA6pmelMn7Kp3MXshKs5abdPPBK7HTao1vXLdYLtBsqXWP2BctQ6BlkNq3JCmQ0+5r8uddI3f/nM3eLvuxYuTuz9MVfnxJuvdKfUd4ft7+WokoXSSB/nnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <kazuhiro3.hayashi@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <yuki.saito@toshiba.co.jp>
Subject: RE: [PATCH 0/1] clk: Fix for restructuring for no reparent case
Thread-Topic: [PATCH 0/1] clk: Fix for restructuring for no reparent case
Thread-Index: AQHaU4QUQS/0+XxQDE2nwMgX3iNKjrDzxcCAgAEcUfA=
Date: Thu, 1 Feb 2024 04:12:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63880680E53C59CE9A63B28592432@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
 <ZborIz5UgFSvjKRf@duo.ucw.cz>
In-Reply-To: <ZborIz5UgFSvjKRf@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB7965:EE_
x-ms-office365-filtering-correlation-id: ea401e80-b8fe-4928-16f8-08dc22dbfee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2s2kP43FMpi6l3mGNNAXxpfpErE9YcIx2433Q+8/aewcImk+/mjMgnORzHfvswEtZmVMqQJBNDfEH7LIrwPNOelcL1XilwDcbQ70AguN5UIKbWawGBh11T6UD273tbdQPq9byYJaPE8yy/dm6qLr/eQaAn1wPaAYDJESm8D5lIpxeksTT2slYgW24AFoy8BX2wQPTDhBiGa5uoWoW2HFGG9Te7qDsinwC8SBGny2xSSzJbwK4VSstmLEbOQ/lCSGR97aoX12gpkBlXEM2h2x4xRdMDDZ1js3bzd52x9tQ7KnvJ28m3s4EY0ED4uborKL2BLeqKUCBJr7C+KtD1wF38QDC7Yy+2NF2MIQVSd3HHM7H7tugwDa8eOGuRJE7yGptix17j0hOSlOm08SVyl69B9NabvU757hGh1tVWrAn+2REsYda1zy2NNaGFjTUmAj8lJyh18AFJht/Po7MAo+apNE+pVVgmWZWMFM/Uw1hgk4rjnIidxoVCVw+ldsicPSbUubivAjffH043XA6VG1G0SQHH9EsHmBfsHi96gd6v1xJWmHTaYVpug0OqDHJo7sPI1O3Z19nzzY41eBKWSY4Wi6tSfMLQlVIKHTY/hI9M6JyIBIvfMI3BJTeMlI87N4sIfeWzgsGzyS4bQiX8QhAQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39850400004)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7696005)(86362001)(71200400001)(478600001)(53546011)(107886003)(6506007)(9686003)(83380400001)(66556008)(38070700009)(55016003)(26005)(66476007)(66446008)(66946007)(64756008)(110136005)(76116006)(6636002)(54906003)(38100700002)(122000001)(2906002)(5660300002)(33656002)(8676002)(8936002)(316002)(4326008)(52536014)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZTUzamxheFd5S0k4bDFub0pMaHpCTzc3aG42TC9oQUY5V05TNi8yd0Ni?=
 =?iso-2022-jp?B?a2tmT2ZOdUFWMHZ6RUQrRU1iQzlkUlkvelhuRlBMRDZKcDlhYkFnczdC?=
 =?iso-2022-jp?B?Tkx1bkVtMGIvN1RFVmFvc2paN2JPTHg3TTZ1WGh5Z1pXaDBoNGtQTTZX?=
 =?iso-2022-jp?B?UGs1dVhUcVZOMUpjd1c2cmZzYld1Q1pmbFcvYnpDczhqbW9LR0srQi9k?=
 =?iso-2022-jp?B?M3Urc2ZJaFBRdEZ5bkRuWXY5S0UyRFdhK2lIdC9zaUNQZTlPS2tKVTFj?=
 =?iso-2022-jp?B?SG5BNTZsU0VxQWJjMVU5M1FmaUlsKzNHaU1KcjBiMlBqL2pOUmxzMlVv?=
 =?iso-2022-jp?B?OXczRW9CcnUwZXdkRUdTVGQwSmI3UFZCdXlUWjZqVjVSNUIyVlJ1UE9z?=
 =?iso-2022-jp?B?akpVbGNKY21FMm9QL0YyVkpUVlM1bzJLTUlHdEFNRkM5d0syUktmQjll?=
 =?iso-2022-jp?B?YUo5dURLb3JIelJXQnJHdCtRWmZDY2YvRXhNU1QvTDM2NzRoekpDSWVO?=
 =?iso-2022-jp?B?V1V5cWc2RGZEYjVpZHU2MG5lOWxwRDhyL2V3MWt2V3ZvL1E4aXgxVFg1?=
 =?iso-2022-jp?B?eURPaWVwUFZmLzFudWloNTlhZ0VUNFN1c1lpZGwwa1lNcitTOE9KUXpx?=
 =?iso-2022-jp?B?RVQzZ1h3VUcwM0MxK3BCbHlOeDE0a3VXS0hSS1FUTVA4YlJXL0ZHVytn?=
 =?iso-2022-jp?B?Qi91VW00V1V4MkFJRUxQSExjTUVERzl4RU1vZnpjaW9GbzZ3Z3BRSFlk?=
 =?iso-2022-jp?B?aThVNTdKYXk4RHg4WnVjV2dMM0g4bWtnUjRMcnF6b2h2U1NzK3Avd0JZ?=
 =?iso-2022-jp?B?OFd5ak1xbTJsbit3dmQ5NURNOFptYzM4T09rS0RrSmtMbVgvRzdzeHNs?=
 =?iso-2022-jp?B?cmpjdUxkMUh0SDM3eFdscXhpeXBDTzdKMEtRMHowdEE5M0hUbWpKZVRp?=
 =?iso-2022-jp?B?S3N5Z2c5MEFoTFZueE02WjBoQUNiTWEvUTRIMVQ2SlVObzB5dEMwK3FP?=
 =?iso-2022-jp?B?dXIwcXFGNUxtN1hvZG1peU9pSTFwejcrbFhtS0grNEZLVlhOY1ZMZkU5?=
 =?iso-2022-jp?B?aVJ3WGduMkY3Y2tCNG9sbUxuTWVESnpXQko3U3dOeUV1b2drS1JCVytx?=
 =?iso-2022-jp?B?TjNzbG0yeFU0aDN5cFFBS212Y1hPY1c3UkxISTNnRTJ0THJYUWxVc0Z3?=
 =?iso-2022-jp?B?Wjg2T3RyT3VaRXVzeWg0MzhmYmdYVkQxK0wzUVl2T0tzNEsvM2xYUFAx?=
 =?iso-2022-jp?B?SkxiT2pvbE1XbUsrY0VhcTR4RW9zd0hkY3g4KzZqZkVLZHJQd0pFOG1t?=
 =?iso-2022-jp?B?a2wxdEVQZEZac2Q5eWdGRnVHeUppMG5lczZ1MTM4clhGUE9MTDdSaGVm?=
 =?iso-2022-jp?B?YTZ0bGdoWXg0MnhCVW1BSFFRT0hpK2toeHRYU3ZqSlpXeTljT2doTXBr?=
 =?iso-2022-jp?B?SFdXdGlLQzlnYm1JVHZoZ09pR0w3VFJ6dytrWGpEMGY0R0gzOHZjbnp2?=
 =?iso-2022-jp?B?dEk2ZHRZUWVNUzhvc1ZSRUZiZ0hRMXEyNWliZ0dqdnp0cTJ2QTdvZ1hR?=
 =?iso-2022-jp?B?OTZnVHlMbVpEQnFmNFFNcHg0bTVBc2xtTlk0d0tIRmxidUJVL1pLc2pJ?=
 =?iso-2022-jp?B?MStsOHJmVFNxTS9hTDlidTlhWmZodjlVWDRqcGJ1UVNuVHRHMllTeENl?=
 =?iso-2022-jp?B?bU02NnNsekxMVERxdDZLd3h4L0J0QmlubjI3Z0VnL0RmU085a3BLcHV6?=
 =?iso-2022-jp?B?c3Z1enAwSHFjU0Z3UU94RW00UzgwYWhWTjJvSXlxSlF4OG1SRTVTQVo1?=
 =?iso-2022-jp?B?TkJTemluN2Fuem9kd0xKT3RMZE50MGgyQXoyaWdFZTlVSW9wa2YvMTlI?=
 =?iso-2022-jp?B?M2VJc3BmT2sxcERnK01SWkJtRDhJcDdTSEFTZmU3TkFzTVJRcU85TzFR?=
 =?iso-2022-jp?B?OC9YKytFM0NZKy9uYVA2WHRhQ2txZUhsZEVBUlhFRGFqVjM3WnFWTDJ1?=
 =?iso-2022-jp?B?SWNjQldrNXlZYVFTMVM3WXpsK0lyQllRakJUV3ZNK295SmZ1dlZTMVkr?=
 =?iso-2022-jp?B?Vm41d0toc2MwY3BFQXE4eGRxSUtaUnpYNHBrMWZpKzl1aVJaR3FpM2NU?=
 =?iso-2022-jp?B?QkpVdjBQN0pubFpIdkJOUzNqVHM1VGNpR1lNdDFMd1lDMlZHM0hTT0E5?=
 =?iso-2022-jp?B?OUh2QTl1bzdaOXFmd3pic0cxaFoxcFJzZHFsQTVZRXRDQzhXVmVMTnBY?=
 =?iso-2022-jp?B?bHlTVmNaMDluWnU0SDZoMStjMVFBNGF0c0ltcXFqS011VmFMVXlHaFhs?=
 =?iso-2022-jp?B?amo0aVNqbXpnMUk5NWtaeTlZRnVOWkduR3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea401e80-b8fe-4928-16f8-08dc22dbfee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 04:12:24.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mkKFI+pj5HsHAJ7H67NruF55RmE4GBum5p1t2iJ6dtEOAqBCacQDiEn76z7m6SBW5/YqjSa0Cz9m2EGL/x5PsK7KwFtrtbUseEihTea7og7kjOTNYAlu1y7cDvOWUcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14572

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, January 31, 2024 8:13 PM
> To: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{=
#D#I#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.=
de;
> biju.das.jz@bp.renesas.com; saito yuki(=1B$BsnF#=1B(B =1B$BM%5.=1B(B =1B$=
B#D#M#E=1B(B =1B$B!{#D#I#G""#E#A#S!{=1B(B
> =1B$B#E#A#3=1B(B) <yuki.saito@toshiba.co.jp>
> Subject: Re: [PATCH 0/1] clk: Fix for restructuring for no reparent case
>=20
> Hi!
>=20
> > With v6.1.72-cip13 + Zynq UltraScale+ MPSoC ZCU102, we observed that
> > Ethernet does not work when it's speed is 100Mbps.
> > This issue happens after d94c14f6fa34f2b8b33e5957f5b8dfb5aaf56b1e is
> > backported to the clk framework, which is not a part of linux-6.1.y
> > and probably is one of the dependencies of versa3 clk generator
> > support for Renesas SoCs. See the patch series "Add versa3 clk generato=
r
> support".
> >
> > In mainline, a fix for the backport commit above is provided:
> > be8fa5fd0a48fd2decc4de81ffe72bb3ceacecd9.
> > This should be applied to linux-6.1.y-cip as well.
> > With v6.1.72-cip13 + this patch, we confirmed the ZCU102 Ethernet
> > works at 100Mbps.
>=20
> Thanks a lot for investigation and sorry for the trouble.
>=20
> The fix is simple enough, I am currently running tests, and can take it i=
f they
> pass and there are no other comments.
>=20

I do not have an objection.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


