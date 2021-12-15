Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB1C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 00:34:16 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.134])
 by mx.groups.io with SMTP id smtpd.web08.34329.1639528454412358019
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 16:34:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=MxpMzTVk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.134,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak3yqNRz6XYIIKrXexwlCL7yBYWXwlk8eCsEV2WrEgH1pkxsERtguTOcvSLRJ6VmsQ13LMCsytWFkuFZsfAgVeF213f8RGls4Oqoe2lqOlV6uYghKQlAsHZOClPMuJ7aKlHqdWFEmZUGASErC8yqZVydJDNbD/Vmp9I5b3RhbVsmuUVuvcmRE04s8IpAK6OHs0jwNp4SNfLWQ4aUuqiDq8zGsrGDkZZrJkpNFzDuYn7cSlZbC3btx7iRaG+pHtC65U23UXyOBGcpGFEfacoaC06TR3jdpUVZ1Gm8BUtqLynUFxYqoSCYVmf3J/LDx5WzYdqwh4rFj5nl2M4c1Wbrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NAydopqcMONCAgp6g2M82hQPZa4qkSGkJmOo1SCGNg=;
 b=Wvf85nqomZfVxGhiB9cQlP1tEW+WuvQ/WM1BKF5FPZ5T+jg7h14f2Zeyb+6NjSiOqWuRhpHWbVQBWm7Z6CDLXQ5CUm5CYtw/WoLJDMkUcoN+jvPbfUYFoNh53Y98GYUDuyVDO2SSitNw+Upf25AsiIdzjHFHyTyBO1D0Mt9yePj4magbuhw1aD9/74fzBjbihpTdFbnjaTehjU7Cukid5SdmVmn5xGfeN8kOm7r3ee0F951y9bvi9s/jco5SknTT+BjZ5wy9QQ/g+ACSxcp8T2zKMWfcddyhwATFLMLLL5LOZBjsB7uLhnNyGV/q93Xhk7KLBkG1T/K+5CPIB7k/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NAydopqcMONCAgp6g2M82hQPZa4qkSGkJmOo1SCGNg=;
 b=MxpMzTVkkLik/c9G35YoMGowc14fMXgDg5HrHVwndh/3mfeTdH97P/Bqn2FG3Davl3adk1BRiktp7pWYTLHOVq5WFjAtGVWeu0OXxAeLqeR420kUUbhpE/k5jRhZTVoLDZ9dQKg+NxE1i3EZFmmKdzCyrQDpOQcQI3TrzslK3j8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB3762.jpnprd01.prod.outlook.com (2603:1096:604:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 00:34:10 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 00:34:10 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Renesas RZ/G2L support for 5.10-cip
Thread-Topic: Renesas RZ/G2L support for 5.10-cip
Thread-Index: Adfw5pxYN+H3x/1pQLW4IwD37ia0fQAOKeyZAAsEaDA=
Date: Wed, 15 Dec 2021 00:34:09 +0000
Message-ID: 
 <OSZPR01MB70193BEE07571A6D88055762AA769@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB70199550B2B2D5D541FB59C1AA759@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <TYAPR01MB62524FB6DCDE6EC9C0B7C33792759@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB62524FB6DCDE6EC9C0B7C33792759@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 879e0bfa-9332-425e-26c9-08d9bf629c5b
x-ms-traffictypediagnostic: OSAPR01MB3762:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB37629A0376159DEF8B83C919AA769@OSAPR01MB3762.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /D+Zel5/qiAVV0CLi9kzeKY4UPgJipwqpA0o2+MkszmopTkd5IqDqyzGVP9uKoAGXhD9JgUtb4D9QGcD59G/0C0+WSTcLZmv146srzvh16BDR51ALEvEEHPyqnq6yH/XGHKhVsuAgRTrk9je/GFO3FSqPvlR3gFcwa5OXr1RL+eYvUwgbiNFZx2mRP2NB/FrqsiR7L+ebev2mo/vSVyDybU1QPKh2QG+qkPtQyZ42/E3LQJVnX/0KXJPHpCGFiwNsPT6flyFoVl5t3BjQgC75ePutsRxiVViwC/b8WXE225YQjxPLU/TxCrvLZwJhA+ewcvnWKDS8jyyXUSgg8ute2zyNOJRUE62hz4x9aJB5KohhyLylD/BKWZB8/0pWYy3045VFvlp67yhtR+7IR5Rn/FQ1B09T5jFvrVZ2f/DZofXqt8LDyWy4rg18+gt8Oo8V+Bgy6x+WeDaynA7phXxlT1ieo1sdpT72i1VOF2xFAiCT7zrttNpGhhyqt+r/1BTiPChCb6LJ1to6CYSdFUSFxZ/nmP1sACjK/GnwSR6MUy8E+C97519Aw4wVERbKsSaAlj86S75kYRbZsPspGsWR9UCeFjg1s1GCCvurqG6Et6m81IX3CMJz1DGDk4ELyKg0wLBN3CVVlOO/AQ3PmJhn1TWxgIlRHUem2AsZF/zZ3aauQICi04zOjWU1gp2mUSbE89EGtyii5KhftLb4uJGYw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(53546011)(186003)(55016003)(6506007)(26005)(508600001)(4326008)(66446008)(8676002)(66476007)(64756008)(66556008)(66946007)(76116006)(38070700005)(71200400001)(316002)(33656002)(9686003)(52536014)(7696005)(2906002)(5660300002)(8936002)(122000001)(38100700002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aWhOSG9BQkhHZ2tKb2tGWnZQRWdrVyt0RnVZOS9CaTVjb1Q2YlpGWXcr?=
 =?iso-2022-jp?B?THN6UWVqTXVoK1QzZnlOU25yZWorRUFOVUkrZGFuYUpWamxaK2ZST0U2?=
 =?iso-2022-jp?B?am02Zk8vemlVbmtSNTZhSnF0Ym01cUtUQkZpSFI4ZEpPMFpxRHVxaDV6?=
 =?iso-2022-jp?B?c1lWdE9Na1dBQlFRZVpNU3hXb2kweW51Vlg4L3ByeXlCU0tER0QvS0NT?=
 =?iso-2022-jp?B?d1hsN2UvZ0JEK0d0VXZ5WGMraEVVdjhOK1VRcjdEMzJjZXhuZFRtNzFK?=
 =?iso-2022-jp?B?eHdvTDMyT1Z2RHZDZTA4TzBxTlVHWFVxTnVLc2FBc2tsUkEvdkNvUUlo?=
 =?iso-2022-jp?B?NHgra0pDRCtORStsQzdlRVQrTzdhRlpqZjFpbEJ5eG5uVTdFVE9ybHZU?=
 =?iso-2022-jp?B?NUFrTmcrejNXc2poRWc4UUoyenBnWXVhbWFCWWhYK0gyK1FrbzRMc1FS?=
 =?iso-2022-jp?B?Q2lpOFo5Q3NHZUsrRThnQXpJMWlocWozeFpSZm5JU2VFcUE3TVRoSTdt?=
 =?iso-2022-jp?B?dXpoNHpSRjVRZkl0N2pSWmIveGZEb09NZHdCQ3FsU2h3SDdvRERnYjFn?=
 =?iso-2022-jp?B?OXE0ZldhQy9kSFBEUld5ZTZPcWI4VU1iNFkzMmFYVE10R0Z3bmpSMjkz?=
 =?iso-2022-jp?B?NWRieFJsSWlZcUFuUUhmc0gxT0FOdVk0QTNxcnlyeGdxYlJ6TERaUzN5?=
 =?iso-2022-jp?B?NUZnT29DQnQ3Q3A0M21RVXRlRFRQdjN6cG9Ga2kzNUF0ak5MdkU2cUJj?=
 =?iso-2022-jp?B?djVkek5KNGVqWE5hM0VFZm12eWMwbXhGSGhJcWNTSXRtQVgwUE5DUDR2?=
 =?iso-2022-jp?B?d1VoOTgrbjE4alY3YnVVL1ZjM2lnUWg4eWVqMmF3T3NqRnJlZ05oNmxy?=
 =?iso-2022-jp?B?endubTBJMmhPTzBaRkZsajVnVnhPdHIwNGJLVEx3emlucnphMHJaRXgv?=
 =?iso-2022-jp?B?NXI1NVNvazRoOGcyTEZxMXJWUUlvQW5tZXNwTi8ybFRpL1RLczkrT1pv?=
 =?iso-2022-jp?B?OHRJQmpPMEE3d2xZUnlPZXNidFcrWjJab1VlaFZHMURmRnZ2SS9raHZG?=
 =?iso-2022-jp?B?WlZNS1BjZFJLczBvOHhVbHFyQ1YzR0hrM2FzOFl2cjN6VlJaVW1JUitV?=
 =?iso-2022-jp?B?WEk1bjJmOHNNYVZQZFh0WXNqVWtMODFTQTVReWN4YUhFNldRQ1gzVGtC?=
 =?iso-2022-jp?B?ZU9BNEJjKzhsUXNzYTVRbDgvdXpVQkJkNHhSWlhkZlUyVitrdSs0WmM3?=
 =?iso-2022-jp?B?QkRHKzB3cGNWeDQ3SDNXejRCUGdWYllkY2Jac0JFcXRBTENQSGp4UWl3?=
 =?iso-2022-jp?B?enlTQjJmQURLMCtLQ3AvSTdia1ozeGYzS0taSnVMRHJxalVGeXFpTHlU?=
 =?iso-2022-jp?B?bVEzQW5oWXR3OFVWWG9laitVd3hCYmVQVldHYXE5UUVhTjRGeXgzNk9G?=
 =?iso-2022-jp?B?RE9vMXlReVcveWZZSzB6STdPbkkwQTRFT2xIdjV3dyt4dzlCL0ZIY2Vv?=
 =?iso-2022-jp?B?VGh6dTRMM3R0TnBmdFNPWk40VjNTc3NyRFBQdVU3M2pCOXBOSldLMW00?=
 =?iso-2022-jp?B?Szhhdm9UQUllZW5SV3hFRUNvSGZrODljZ3JlbjQ2SnZraVNDWURLOHZn?=
 =?iso-2022-jp?B?WjFiNWFRdGdXYmhyZ0FBb2RicjBUY2FOTjNHOHFrcDk1azdIZFpNUEhq?=
 =?iso-2022-jp?B?MkVWQ05kdC9HVWhHblgwY0IyOTFCYVlZRk1mcFZnejJrZ0FFOUwzNE9p?=
 =?iso-2022-jp?B?NVlKcU9KZWxIenA2VkFISVBlOTM5amt4MWhxRk1iOUFSVysvRnd2dEVS?=
 =?iso-2022-jp?B?cVRWN05SQWgxekZ5QnBxdUZsRmlHYi9vSk93WFJCQWZBWnJWTThzdlpX?=
 =?iso-2022-jp?B?d0FEbDZjTzlOR2FTdHBPWHBqZThzZXhFS1pRSDVOb2w1YS94NGRQdHN1?=
 =?iso-2022-jp?B?Q2lHMms0Ym1NRkNRNGNMZ1Z5WU5nVVVOaXZZaGhKU1F0STN4UDRQa1Bj?=
 =?iso-2022-jp?B?SnRRYjFLckhwWjd3Wk1oRXBIb0xvUVNFUnRYRm9NNVBaL0ppTlZtZXFN?=
 =?iso-2022-jp?B?cEV0NGk3NmpwaFZsTm82V0ZrZ0RjTjNoSnVCcW9jSzM2MTJhWDNRQnRH?=
 =?iso-2022-jp?B?K1BabWtTdko3R3NmYVNneHJNMmlScVVZTEpxZkFlakx2cERiOHRzSndS?=
 =?iso-2022-jp?B?a0FsWmE3aktPaDhnM2c3dmVNeFZHb3VsbzhUVU9zSWxkbmhNTTVWUGNC?=
 =?iso-2022-jp?B?N1QxQVFhOWVMb3pwbWxWMzQ0YkJadDB3bG15SWg5YXNmK25GcjhLY1V0?=
 =?iso-2022-jp?B?bTh4WXk3S2Q5UHRJOE0rbXRCRTVOaGNJNTRnWTRtcmtEcmlaWHczWkRy?=
 =?iso-2022-jp?B?S3pUcVJjclBRTlQzeUlydEZTYVo1NmdkQUJUUlRtOVpSQzhXeXdYUEt3?=
 =?iso-2022-jp?B?ekZkRS90SHBRb0V3d25yUVRNK0JZZlhZQ1dzQmgvbFNmbUQyd3l2bDIv?=
 =?iso-2022-jp?B?V3IwUlVTY2hGeEJrbU5PVm9jREE5OTZYYzZwdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 879e0bfa-9332-425e-26c9-08d9bf629c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 00:34:09.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 0/TL//n2XE48vfqT4ml6ghF1xK663lUqKOPVKiJhoCUsonMEl5bmBhYveb0myCqi+/Ao/dkykuyCKNqSevBdUe16VkUIuw6cg5vkmyVRwGHfVsDetYsGKYNO5jKM4j/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3762
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 00:34:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7099

Hi Nobuhiro,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 14 December 2021 19:25
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; pave=
l@denx.de
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: Renesas RZ/G2L support for 5.10-cip
>=20
> Hi Prabhakar,
>=20
> > I have prepared ~105 patches adding support for Renesas RZ/G2L on 5.10-=
cip (all patches cherry
> picked from v5.16-rc5). Is it OK > if I bulk post the patches or do you p=
refer them in chunks(maybe
> ~25 each)?
>=20
> I suggest splitting it up and sending it by feature if possible.
> In this case, we can review each feature separately.
>=20
Sure will send it by feature.

Cheers,
Prabhakar

> Best regards,
>   Nobuhiro
>=20
> ________________________________________
> =1B$B:9=3DP?M=1B(B: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.re=
nesas.com>
> =1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B14=1B$BF|=1B(B 21:34
> =1B$B08@h=1B(B: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S=
#W#C"~#A#C#T=1B(B); Pavel Machek
> CC: cip-dev@lists.cip-project.org
> =1B$B7oL>=1B(B: Renesas RZ/G2L support for 5.10-cip
>=20
> Hi Nobuhiro, Pavel,
>=20
> I have prepared ~105 patches adding support for Renesas RZ/G2L on 5.10-ci=
p (all patches cherry picked
> from v5.16-rc5). Is it OK if I bulk post the patches or do you prefer the=
m in chunks(maybe ~25 each)?
>=20
> Cheers,
> Prabhakar


