Return-Path: <SRS0=FeYN=GY=lists.cip-project.org=bounce+64572+6125+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912D6C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 07:14:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6B023788
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 07:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6B023788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6125+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id E4OpYY4521723xvleyZsHqWw; Wed, 20 Jan 2021 23:14:49 -0800
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.41])
 by mx.groups.io with SMTP id smtpd.web10.3821.1611213287891265459
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 23:14:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrO6dqdKmhKQNDR+X0Aki+KGB7ZyHTdFw9fd2Xzvo/abPQ7gEfY/EXUqGgnYroRSV7ts4sETqcKUlFdiYKR/Por5GzveXtK/blQA5qTI4DI4Pa/9nkCezNj5guualfAuNFE1o49Aue1L0+GYQoTq7V/F+yRj6WMClAZSci2mQYh/iMiNvbvCJykUmGCN+p7Gmvd9wWvG6/7c5yKcPxsKfRFtDmWZ3wy2hkIOUdUB7lY5eu4oTOWfK2wdq84O3JvISgVp0HTAuxRQ7QMIbHiXgPwNr0sNEDO1GU9PaUg9/vOpIhm1hOTad8ns27KreAlzxAth/AivAEA0r9LmGfIrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+t3j++ccnZfLN/1AM763dzXgAzmWTIwYj6TOSDzpoQ=;
 b=gDERsT0Qho3r3VcR9+JapSM1aUCjxM/xN9VYlj3p9CQoR5md7arNAL8EzxII0JCrC+XWwg8wBB7BwR0ycaGoul6ucv3L+YgfYgB2OUEWo+2kIu81j2/yBL7vawL/nhi1pmmSIt3jIH28EbMEEdCpDEidxmFfpEV4iPKknJ3YQcSJfoAUbU/e5B1UG5fIimgvtnDdpSbdqY3QDi5i44w0ziJx1qupOOV6ApAxwtcnu98RVm83OS3fAnnOrfH/6mswbrUpYhdLyJcNrBFkGC9OOVbW5y1jv0w7mOfA7ZSO3k857TJUZHe8/4FXasnsGYf7gywHMAF4b4kybGw3+J/VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK2PR01MB3121.apcprd01.prod.exchangelabs.com
 (2603:1096:202:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 07:14:41 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::10e6:6509:1703:b3b9]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::10e6:6509:1703:b3b9%6]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 07:14:41 +0000
From: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>
CC: Jonathan Sambrook <jonathan.sambrook@codethink.co.uk>, Chen-Yu Tsai
	<wens@csie.org>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
Thread-Topic: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
Thread-Index: AQHW76iwuSCoJl0fDESVMNBRrwZAQKoxeIuAgAAAmICAADDIIA==
Date: Thu, 21 Jan 2021 07:14:41 +0000
Message-ID: 
 <HK0PR01MB2450CE13D7E1DF948BFC3B88E2A10@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: 
 <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
 <OSBPR01MB20533FBEE9901A816B78204FD0A10@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <CAGb2v65O8RxbFjgME90NKfVTw6w54rwP0BhCGzDqKOeiRrxtQg@mail.gmail.com>
In-Reply-To: 
 <CAGb2v65O8RxbFjgME90NKfVTw6w54rwP0BhCGzDqKOeiRrxtQg@mail.gmail.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.221.166.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb2c654-ad50-42b9-a062-08d8bddc38d0
x-ms-traffictypediagnostic: HK2PR01MB3121:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3121B53C9B04D05DF39138DEE2A10@HK2PR01MB3121.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 PoQysSwR52bF3ChiRSCfivIfyJA5kGteI7463B0YYEFIeMQbrI9IB56t9/XvdFzP9aVJezZ25z/IZ8CxnV2/Nsv2kZH5ASCAYnHo9hl7nF3NyV7RuwH2FikkPWho3Ubj9uJRSHyoIjnKMCcvl79diZ3HOEP1JQn9Ko9M7ddbWurxUOMLXvB3AlM6CD+DVqTgnn1kNEpmdi1aNAuUdPw3L/u1yPgrvKma3tPZS4zFpXmUU+mcZv1HB2pL0Iyc2Ypcj9CYurMbxmJCRrpwzuGa76G0FGJRfDiasDV2NHbPYODn9MZe6oFw4DX6iCiiEj5B3nJdWXa+YFxSgSYjXZ8p9P/Q5mcE5vL6FUrjt4KrIznQd8sP9CBKju51cqWwjcmFtYsO8BkNTK72vHGEVIujP70mqRRtxp/DOqodF63Dm/enXCbb9oqcJseNQftZ56hY2Xf8V4Mdm+WSkCS+eTJq46R2iZjvNF2qp3m7G5VgXm56njaRwaJ/ZaDZLssZ0Wzc2qaVPWuHJZdhvyugbFv8z58GegzQHd4y1ih7/biUGi8gLfySwhVNbIhopc2OHbA2rEiyw0kbESqicafCJPV8lvLz3wf3S+ZY7cCkyRnDLAtKR7cNMrVG4RYyZMTuKiS4+Sy/WfVQpDZ3VdZeQbWtXw==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?VFgzOGVBUUtwbTkwVUZhbU02VXk0K3ZHWkJQenpxSVhKZE9jdlhMenFZ?=
 =?iso-2022-jp?B?bk0xT0xCcDcwN2J5ZnV0Wi9CVERlcS83ZHF6RDFzTWhRcVRLN1l6czFL?=
 =?iso-2022-jp?B?Mzd5SkN4RVptbEh4T295eC9qeFFhRUZUQXNlVlpScUtQdWcwOWt4Wkg2?=
 =?iso-2022-jp?B?Z01TaVVzWE1EaitvU2FOR3NlV2tuWjlPajRzTmdzMWt3U1hFUys0MUZR?=
 =?iso-2022-jp?B?ZjRLRUJXdGFzUXJMUWxCci80ZlZzM29JazRaTjZ4TXJnRnExS1Q2c2ty?=
 =?iso-2022-jp?B?QUh1ZXlHN3FUcUZoREZiYmRORzRMZFV5Vm95bWFxWm1HU0l5RjRxZlFU?=
 =?iso-2022-jp?B?MDVlKzhuY3p0ZTE1cWVSRGVBWXNoUXVsNXNIblFKbVhVTW1xSFJxdUs0?=
 =?iso-2022-jp?B?Vlk4UnlBalhEREtWTXRCZ2hrUVpiazBLVmR6Y25XVEdUKzNwc3BtZm5I?=
 =?iso-2022-jp?B?U3Z0b3hkYjc3dDNIU3V4S08vSHZHazVvcm9QQ3ptUHloOTN0aFY5QVFX?=
 =?iso-2022-jp?B?S1BUeWQ5eUNsVkMrL0dkUEwrUWJnM1B6N2FOUWVvOUNkNFZucG9tZzBD?=
 =?iso-2022-jp?B?bmNYSldTcDBrSkhOL1FPcHBNRWJCdmJsQklhSjFzQ3NMRTRxMUNoODkx?=
 =?iso-2022-jp?B?R3FBN0MzQ3ZCRDhCQ1RlWWx0ZllHYjY0Y3VkQnlmaHI1WlFWcFoyeUw4?=
 =?iso-2022-jp?B?dkpPY1ExZmUzRXUrZXJjOXlNbVBxQzBsNkdicFo1TzU5a2I4dkkyYXpa?=
 =?iso-2022-jp?B?elQwUVFpZUNHdTBWMUJRT25xSjA0N2R3cXVOanphamV5YndlRVQ2Ky9z?=
 =?iso-2022-jp?B?OTQvY050L0lRa3B0eGlzVkw5UzZLRTJLSkpXMzFoOFkwWnl0L1FFb1Bt?=
 =?iso-2022-jp?B?STIwQ3R2Ui8zMUkzdjR0VXNLTmJReStGcnVneCtDSjhBZmZPYjdBSnRk?=
 =?iso-2022-jp?B?Z1Bpbkg2WVIrT0gzQ3JwdW9EMkRkYVFWakUzeE0xZmpkT2tTOVZZWnd0?=
 =?iso-2022-jp?B?ZTFLQ09YR1hGUUtjZ08zRTkvZUlyRzBKL2ZJc2lkOHl6a1liSmlmMUZS?=
 =?iso-2022-jp?B?bmdVZm45bTQyQXJCeWpia3FUUW5SYXF5cTNQcnpWYU5WeTV0emNEanh0?=
 =?iso-2022-jp?B?VTZHSUNScEVCUTlnK2U3WTh5MVo4THkyUkUxamR6RjZSaUI3UzAvZFJs?=
 =?iso-2022-jp?B?aGJTam5WVHM2YW9pOTBvam50Q3NsYWYvVi82RGw3YWEybVp0YWRYWm5I?=
 =?iso-2022-jp?B?a0E0VEYzSS9Jd0lVUW1kcnlBdWlSSTc1SEpwSGZnRFpvandCdmJCQU9w?=
 =?iso-2022-jp?B?NlpKaTlZQS9Pb3Z6Zk1WYk8xREIzVXdybTA3dVlSVkNENGpmMWNObXhU?=
 =?iso-2022-jp?B?dzYwelhwbzBvY1ZJVzBrWkNZUVlCSWRoVnhxNjlzaFJ3bWlBYz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2450.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb2c654-ad50-42b9-a062-08d8bddc38d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 07:14:41.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2YPDTqpvdrtXCQULM7pOgHhOBecKer15lQa/wP8nvaXzQ3Xt9LD3ll1tZr8skBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3121
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s03SoTfHL3nGy3EuuW2VSSwvx4520388AA=
Content-Type: multipart/mixed; boundary="fDJH8Ku6BPFmew20B3SF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611213289;
 bh=mtU2/UoIBVT9oUVsC17px2YHCtrIvwDlyt+QzxEIss0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=nk94TxJyD41TbLCTmb/IFnMKx5XukiAAIolrA5Kdz7IP6TBZU5FPNBTO5XiF8n6Psjn
 Nz2tVrxkfzy1UuZ9aZfRQ3f6pu6U05TkP7cqqqnX4YiT/GAPeazMm0HQOKNmf1sJ7spbx
 OMGWsOEISPjBvIr6D8YOykSd0Wp8H4CZOzA=

--fDJH8Ku6BPFmew20B3SF
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,=20

> From: Chen-Yu Tsai <wens@csie.org>
> Sent: Thursday, January 21, 2021 12:17 PM
> To: cip-dev@lists.cip-project.org
> Cc: Jonathan Sambrook <jonathan.sambrook@codethink.co.uk>; SZ Lin (=1B$B=
NS>eCR=1B(B)
> <SZ.Lin@moxa.com>
> Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
>=20
> On Thu, Jan 21, 2021 at 12:15 PM Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp> wrote:
> >
> > Hello ChenYu san
> >
> > It seems that there is a problem with merge requests to cip-kernel-sec
> > https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re
> > .kernel.org%2Fcip-dev%2F0282a51a-682c-bb5e-4a68-e020ac0e76d5%40cod
> ethi
> >
> nk.co.uk%2FT%2F%23u&amp;data=3D04%7C01%7Csz.lin%40moxa.com%7Cbf8f4
> e15361
> >
> b492cc85d08d8bdc36643%7C5571c7d4286b47f69dd50aa688773c8e%7C0%7
> C0%7C637
> >
> 467994237789565%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2
> >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DCO3MQKty01
> wlLP%2
> > FXTvVl2%2FCV1wcyx%2FvgudeEqVumgTU%3D&amp;reserved=3D0
> >
> > Did you look into that?

I can reproduce this issue via my account, and thus I think it's not the p=
ermission issue.
The next step is to contact the gitlab administrator.

SZ

>=20
> I tried again yesterday and the issue still persists.
> SZ said he would look into it today.
>=20
>=20
> ChenYu
>=20
> > Thanks,
> > Daniel
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Chen-Yu Tsai (Moxa)
> > > Sent: Thursday, January 21, 2021 12:51 PM
> > > To: cip-dev@lists.cip-project.org
> > > Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =
=1B$B?.MN=1B(B =1B$B""#S=1B(B
> =1B$B#W#C"~#A#C#T=1B(B)
> > > <nobuhiro1.iwamatsu@toshiba.co.jp>;
> > > masashi.kudo@cybertrust.co.jp
> > > Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
> > >
> > > Hi everyone,
> > >
> > > One new issue this week:
> > > - CVE-2021-3178 [nfsd4: readdirplus returns parent of export] -
> > > fixed in mainline
> > >
> > > The fix was only merged into Linus's tree a couple days ago, so we s=
hould
> see the backports in a few days.
> > >
> > > I've also added the 5.10-cip branch to the tracker.
> > >
> > >
> > > Regards
> > > ChenYu
> >
> >=20
> >

--fDJH8Ku6BPFmew20B3SF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6125): https://lists.cip-project.org/g/cip-dev/message=
/6125
Mute This Topic: https://lists.cip-project.org/mt/79996445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fDJH8Ku6BPFmew20B3SF--
