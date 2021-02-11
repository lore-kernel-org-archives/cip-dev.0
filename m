Return-Path: <SRS0=aODJ=HN=lists.cip-project.org=bounce+64572+6169+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAAAC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:34:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC1764E87
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1764E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6169+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HfafYY4521723xcToTSV2euE; Thu, 11 Feb 2021 01:34:30 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web11.6324.1613036068447122719
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 01:34:29 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id LSdO04896A;
	Thu, 11 Feb 2021 18:29:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0V0V3LrkbzZr8C81h2tYkcrIrfc9W8l1yoUqQN7WxmNQuIJoKQvaBJsfkWR8fje2JdjhkyhiwJwQ+kH6s3LJAUVur3EjWMiqbWePS1fBGkZrVBUvbXyP6/0r6enQzGssU+geLUl36bNtEJsNbVL4IcHMpWjbQGOgG49qi9Vhft2kBjtP5MUuO9mY4JlRMBg+/8rKC/cw4VdXNC3wHK8aSwZYBKLIlG4jCAwt8BDO7+ZjaD0Gu24tpW52D/fAYrgSXTnyBUie8XU5fZAZI93ZLrvDcs5nbQTq58pmxser1aHGQiQEKdYJdzZT72VV8Z+XmSFpPnd38st0+TYxYo7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaSrD9kBg8aQinszZLFl6mA0Q3egFScyVri/eLkF2EM=;
 b=nv/FSFs7gb5kQ5Br0oMYa8I0c928rJU8PKEBMtIBozvRmnnr0G4XA6ClpCn1+6/q25h6YxvovieCPRqU7hPqUyUYv9c+t5pQrkxXM3K+gU68w3bUBdDxtHOlbf3zYmrQUvi9oT/SGRKJzsv3DB3xi2IPBP3mv9dlSCjIYdmg21WrI3aNmhgXY5dptT5veuI8jsLyoAmxpyTRUDVKmHc47drfyd1cMeRoOBlg3z4cK14zJDCRgJBLSJppLAp7wvanicQeDkyKgsmZFKXW9LbzvOLM+fP207hN9J8LtQW94SA8KkfVX9G+koXBpw5QOrnQ7ouKGvbxyrWnbPRH3je3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB5115.jpnprd01.prod.outlook.com (2603:1096:404:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 09:28:58 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 09:28:58 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdcAEM5xU8yiklH9RyqQBeyotJkafwARlZWAAAA/kvA=
Date: Thu, 11 Feb 2021 18:34:19 +0900
Message-ID: 
 <TY2PR01MB4972C0A037152E2057B9B72FA08C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972B6A2FC89273767335506A08C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20210211092031.GA1881@duo.ucw.cz>
In-Reply-To: <20210211092031.GA1881@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f61f03a9-1387-4813-810c-08d8ce6f75c9
x-ms-traffictypediagnostic: TY2PR01MB5115:
x-microsoft-antispam-prvs: 
 <TY2PR01MB5115F608D389FAFC8455CFE7A08C9@TY2PR01MB5115.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 X2et3hBW8lTg3C47n4QRyIILW2dVIM3bRDTkWg9Nqsn/x3CSiFhdd57E/b0L6G6cSTs4pga6YEyO+0TXM+9jM/ozln6MYSGc1VPcPux78JXfcl8UfjFeZjvp2sZ74/FjjSus6CwhrnzKux7YwGzv4PfyTEZpT9AQGHshHUtZGVS/eMi0NgBLu8p9AgNi6ELJKjFhGSSEmmGtDdOn1QVlVYoQiEE9Z8xPk4pwD0L/yPQ2zRyqxVwLi1uCliTa5hIAWL7XvU7exQ+kRf2wC/otHVb80wye6+o+zrJiBpneZNeENe1ACQxtokxMyEQ7nOaV2Ewz3pDljySEA1gcLJdOi/LCCBhEru7ryYFBa+g4y6Dfwb74NFXDqU5PGzshvIObj6ymrsOZUHykoZfWynsUpxeekh0HikQO/0Vv2maYnofQmA+ZaLhP6/18dFNBNJNLgQRDWAhCtFHTuJMyZwwFAy0qe8kT51IyFTkXHqndmCNGKLK8EwRC28o/sCaw8SkGL1cCPWeEXwmRZnivsUucHP1Ur1yvgO2Ip3RJjmu+4MUR5vEco6510ub9fJvSvY3rm+uESVfy6QCOBoolV+IxS2DGL1t4xhT7JPvVndwiuV0=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?MDBCN2FoS1QrR3NDQ0VocFo1UTBMNzhsQ3llclpsWXhKUnpPUWM1VXFT?=
 =?iso-2022-jp?B?bzh1Uk42eUxuMHh1YW93SUI4bzlNUVRELzF3dmEvMjFJUXVvYTNIUUxz?=
 =?iso-2022-jp?B?ZjYzRC9tcTVJU1FTZ3dDRWdLWWt2ZVFpdWUrbm1hd1NyQ2JWWm5xekts?=
 =?iso-2022-jp?B?Q1p4WnZWaG9oeWsvcFlDVjd4ckZzdXB6OVJ2aDl5d0Vta2MvbFowYXVR?=
 =?iso-2022-jp?B?bmZWVXpHZHRDSlM1WjJiTk9YMXA0b1VqcTRTZE5uVGFVa2VWRFRyQXRZ?=
 =?iso-2022-jp?B?RklwVzBnaVJRZXdabXNDclZjMS8ySk1pTFlUZWVYQ201aDhLNXVCdmtC?=
 =?iso-2022-jp?B?ampScitkMXd1YjZoMmkza0F1cXZDK1dtVnFDOXBLWm5Rajc5d21OZHFZ?=
 =?iso-2022-jp?B?cXRCeWs0VlpqUDlRNlR3WEFJbWFVenNqZUgxWUcyRXdMcVVaNW9EVkNy?=
 =?iso-2022-jp?B?c1FRN2dDaFhsN3A4N1VBRmNQekVDQzljK3pGeFFiZERvTDk2WXNaVVcw?=
 =?iso-2022-jp?B?NkczM0NKSk44VlpBSnZrQ1VTOG1YNXBDRzJ0MEFGenVTWCtsNVJKb1d6?=
 =?iso-2022-jp?B?V055b1RWa2ZwRWltd1V1c3FyQThhUm9wa1V0YmdTQ3RKa3RsYmVzQktp?=
 =?iso-2022-jp?B?cUpGcyt3N0VlcmNWWnJUaS91bCtjOFlWZE9vOUVBdzBFbjYzTTlHckxY?=
 =?iso-2022-jp?B?T25tZk42QU9WRGZPVEQ3KzZCSFZBVC9nQ3Urb0VZbTJNNXk5RzlyK1Vw?=
 =?iso-2022-jp?B?RVNjZGp1LzRnV2cxQzVWWVFPbEcyVE9nNUxMRGcyei9uMEpodEUrdHlz?=
 =?iso-2022-jp?B?UmM4Z3BVWmxNSGxra1QxT1NhMzAxbGJRSENsVGNyZVNpUDU1ODcxdDlm?=
 =?iso-2022-jp?B?WmtRd2tQaWRrL24rNERLdXAvd3FaNWxEdVVreStqYnNOOWtCeFNXYnUw?=
 =?iso-2022-jp?B?WmhTTHluQTVUalZGaW80M2pZV2dFSmVDVG4zR2JtQnY2ODd3Szh0YkV3?=
 =?iso-2022-jp?B?VTQzbHg4QXBNaWZaaGdKUlFlZEpWcE82REpWcWFXdFJQMVlVQUNiUXYx?=
 =?iso-2022-jp?B?YTZuenlwdGJHMk9kL2hyWE9BUm9tL0JQL2xMa25pN3pTSHAzbmJ0ZHFV?=
 =?iso-2022-jp?B?ZHJ2ZG1vUTRGZWtHeVFobDExdXdhOWpCRjlySTBSU0t4aWFXcmJhQkVO?=
 =?iso-2022-jp?B?MFZueFlrMHd2SE9aeDBRbzdNVHNacW5yTUJtN2orY2pPdjlHdmFhUHg2?=
 =?iso-2022-jp?B?M093SEduTXVNczBEaUJXalkvRFlDTWVJdmJpY095UlFndEJncGRVYlNo?=
 =?iso-2022-jp?B?bkNGbmRHSzdHTTFVNE5wdEFnQ05KUWd5cEE3eWk3S0hxUVQ1dzdaTWdh?=
 =?iso-2022-jp?B?VjVYaHV6MUZXcTR2M3N3dVdEMFlucUpYQmFzckcxT2RVLzhPVmRIdVQ1?=
 =?iso-2022-jp?B?WkJqZFRwRFBiL1FkS2RsSERLSmd1RFJHaE14bkNnZlFMUys0TjY5WVVK?=
 =?iso-2022-jp?B?bGRic0RCSVU1RWtEbWdOQURadFZLQm44dDJscm5pVTFxUlBNVHE4MjNB?=
 =?iso-2022-jp?B?S0RFZFV5MTFWaVlIdU5DRFo0dHlSUklLQjBscTFSZ2JzeEZiV3ZzYkRy?=
 =?iso-2022-jp?B?MU5xNkJRV0dCS1RwM0JIZ21kR0hxMmE3VXBnR1haWWdnTk40UERvVE9Q?=
 =?iso-2022-jp?B?T21LREJTckh0TFdFRVdDbXZ0N1h6dmQ1eVVjQlZPWER3Yy9vMHAzeTZJ?=
 =?iso-2022-jp?B?RnlZTnhkcnJKV2wxSHFhMldTT1hwcmxRSVQyVDFOZFZUSEhEdFhDaUNV?=
 =?iso-2022-jp?B?UjlITk12dXdNVnJLRGJsamVSZ0VORjBPNzlrcXJ5Y1dFdExOdEt0ZjBh?=
 =?iso-2022-jp?B?Ti95dzhBbENCMmpuQVZLcno2ZCtOb2VHMnI3dnB0K2QyNXE4Mm96cHp2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61f03a9-1387-4813-810c-08d8ce6f75c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 09:28:58.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU661a3l+6kdWMJVpoTDh7e7Xa1ONu/8nbktoTEXJgL2aIc/f6gHWXA4RgM2CD6eFU9DgQAIph12q2Q7DK51Lr7lxpXdnVPNgvkm/CqESdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5115
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1wu4QD35xkGkSRBdw68JSYVLx4520388AA=
Content-Type: multipart/mixed; boundary="ttmXyc8JxaHTmpRhqUkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613036070;
 bh=CBjT3iyKT3Gc2Nd45tHp3KVoHUyPW8UNIZnIlnTmzfw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=joWSXJbH5cqwSru4AjsSKDJyI5lKpaJmc/Eeu0y/shsYVbrHNS7T8C/xORwHyn+EkEE
 2ZpE17B38IzcbtSqFQV/7d3d5t8prJ/pYGi+udDE6O5WTOcHpDkYN4ncFU9dB8z3rcDBL
 FTDIViCN7uZsBQ9SeknNZ5jm1D6KJElJitM=

--ttmXyc8JxaHTmpRhqUkI
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

Today, there were just Chen-Yu-san and me. Very quiet. :)
Thanks for your report.
See you next week!

Best regards,
--
M. Kudo

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of
> Pavel Machek
> Sent: Thursday, February 11, 2021 6:21 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
>=20
> Hi!
>=20
> >
> > Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
> >
> > *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> > starting from the first week of Apr. according to TSC meeting*
> > https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&=
m
> >
> onth=3D2&day=3D11&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p
> 5=3D241&p6=3D
> > 248
> >
> > USWest	USEast	UK	DE	TW	JP
> > 01:00	04:00	9:00	10:00	17:00	18:00
> >
>=20
> I missed the meeting, I'm sorry. I'll go through the meeting logs.
>=20
> My activity for last week were reviews on 5.10.14 and 5.10.15 and corresp=
onding
> older kernels.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ttmXyc8JxaHTmpRhqUkI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6169): https://lists.cip-project.org/g/cip-dev/message=
/6169
Mute This Topic: https://lists.cip-project.org/mt/80547932/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ttmXyc8JxaHTmpRhqUkI--
