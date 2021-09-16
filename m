Return-Path: <SRS0=JYer=OG=lists.cip-project.org=bounce+64572+6742+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27459C433F5
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 12:05:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8839660E52
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 12:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8839660E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KPw2YY4521723xM1qdmJxFOA; Thu, 16 Sep 2021 05:05:10 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.103])
 by mx.groups.io with SMTP id smtpd.web11.8.1631793901122484409
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Sep 2021 05:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyGLhp1dwOsCUubnLHiNIyydXwDcMlkY+p5tJbxQGmTAWHlcfR123juALQdHlfop1vAkO8xRpef9JyQ00IMyy6LTjIOw+9WE8NVZ9wCWEMYdM+b6NYfbjyZzwKjo8uRitZQvwCjc4OBqBu/m9qn/leRah48+mQL2bDgApgssBW+FI37um5r6fAiqz/H8ReI4j5/y8jf7wPe9x71XdvW7mbiOx7KKVumRcU7F2obmArMEsHsD7fJM+zEo6qRwqCrXHjw+4YlKNXVwPyXOtl0LFnqCCLZZpBaXYPBl64qKcXh2gBilYP7AA9UBTLz7oeT1BBN6yKEah5QITedfMEaDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PV4SIKhzaBCMn57doGvrbZjlnPMMG82/u+mASu2qV7w=;
 b=TJosYOYLqvne28vsL6OA3ZaziDt3Ks336TtiJG4h6JomdvP7AeQ7Xthjf7ssTquz5V3S//39yNRTlY69dY/0OAsAVUISkP8l4UPkdegUS8t43HI84BL9f8Hbph8J5TWdSHaoPUX6fGk/cLxS7O6lZ7cBtQ3H3Kp+cBT2u/mvPt1hIL2I0gYr36GuJUPa4QHecq0Eu6zKErcLWiedcw6lB7+7H8+9USmaAyaaqAPw+B2wYRHe905VicFIYg3scL49N6TvwKYx10g44xF6xqXAIJ55RK1vJyKQVJStmGnEkwkoFfD0UQtHJ1u71TAEbKaEuOQ0XXkwutJg5vBroJ3Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS0PR01MB5585.jpnprd01.prod.outlook.com (2603:1096:604:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 16 Sep
 2021 12:04:58 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3c89:5065:e852:bbdf]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3c89:5065:e852:bbdf%7]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 12:04:58 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHXqsGp1JN8DLqKXEae7CGB6w+Kd6umjvpA
Date: Thu, 16 Sep 2021 12:04:58 +0000
Message-ID: 
 <OSZPR01MB687795BB6B19A8DF08020566B7DC9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <9b032547-c6df-a419-fedf-75e5ec8a93a8@siemens.com>
In-Reply-To: <9b032547-c6df-a419-fedf-75e5ec8a93a8@siemens.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f44c2d9-2ce2-4ff0-a294-08d9790a3463
x-ms-traffictypediagnostic: OS0PR01MB5585:
x-microsoft-antispam-prvs: 
 <OS0PR01MB5585B334E5457AA5FA4AB3FBB7DC9@OS0PR01MB5585.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 1NUjiSOTRuAJP/9/WHlku/eQGabKBIhIAYcLwsz49L64/z04boaqxzYp+nIyzJCwnvBrF46KqYoiUN67CEmnuYuDtZkELl7mwzBYvWaEfJe/FoHC5AC0/IlcSiTMZ47xCOPevrfHMwZwcWJgYQ3eG0pdxy8DklICdCQBgsRz9UJ35cIUMDNks57RpmWoj08NPafr7AnFljMghcKtuNiFQIMS5Gr+0PKfcmsmkxbyEbjtQVhmft1FVdEpCyfAvKO+aoDpMBa94ScjF8bADBbnHpxTA2iubaMaRg3b8yyKkNUEaQtvyH1J4sfctvPBIHJ5937+XJSzzwvEypDWnq3Ydr2gXC7UuiE+4FJnwnrjm/efP4OBjzR/AhiHfh3CfnA/Q/sLh0YwKQwgq661N0OJOCETYxfySSY6Xqh6cctUk73Bt9q9DQpWTvjAKOGhlkYpJPRnsaViwvdR26yoayIXshCMtplczCROCfs87mWilWEx5zCIP5bDLXVgmZTN98Vxr5HkkFqu9LJoWzoInLKJ4pqoVFzikZaHPmXsSJ7WU8OZ3ROCJaJ0B0zZiLrSU/7dVkDs5sQm8ktV00yLLbc5TLAYxjY4N2AdoilDwmw5Vf3gnzQTxrlDAALptK/xxyWZy8pGtWpB8t/cUT6UtMi++Z+lc0VGmY2JEYiEBQS4AwpnAMRuHQxvEaexikKVXwaBrOCRItl0Z4n0wwrkVug4U2tsbbhEr0gHq8M242QQ4G0PDRG+gMtiAxRuZSYoR1syECm0ibeQR2NkWv7XLwMKXvn9KNI+dPfgUlAnEHyEFbj69AyOuiq1oRD8LR5scWHvYYbxNr+CZd17CdEzWoBN0g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?OQY6oPpQeX4AOrbHpbUs0K1S6KWZ23ld4pkX3rhtoEdoD8rn90RrerUe?=
 =?Windows-1252?Q?Kdg5TgRbbqF2KY270SgDgR2qrwIemT/VWd5iFBfYwpQP9jJNXGdEIYOE?=
 =?Windows-1252?Q?52MktNgp3UInMrnc4xGzuBEMOiiPx2+xtu33i89Dzw23j2/we2ypNz1E?=
 =?Windows-1252?Q?lYbferTQjvLDzcU4goTcaH+xCWlasl9nRIZpNHu9ZPJRcTZk71Cjy/tz?=
 =?Windows-1252?Q?xX2+3whnuvFyYfiIVIQMTmoZmGdXw7GuqGSgQY98nH6aR1ku6NQ8ylpa?=
 =?Windows-1252?Q?jcqcmT/6uSG17lqHZ8MQ6f79y1e+uKq/9EPLd+eluaTDVkBseAe3bRd4?=
 =?Windows-1252?Q?C87R7OvVjpKjqv+2Xng3Zpq9hIZMCwRpQ5kVG3fr3hGiS8woGwXHcZbE?=
 =?Windows-1252?Q?LmRqEoqcS3IjK56YuXJ3+uXT9uA7amQJeu2Rv5gOdyS8LTdFOXjpK4B2?=
 =?Windows-1252?Q?rKtM1MVMQpD8ShdD/IuWdXMrGGiWelUXXlFm2PApotb0T6VF+5iL52Ox?=
 =?Windows-1252?Q?Ms8y/yvYfdvJapZ2H5r9veTqVvZMqVnHQtoCvF97syIzSBvSIfohB9+Z?=
 =?Windows-1252?Q?oHv05WXjNLC8Z/X4VtQKy8r3sEXdOiqTXyWRQxHdA9eyE5nRy02r+vw6?=
 =?Windows-1252?Q?LVVbQHA6sphtCTW+f7CFUaSMaz+0Zsgta7iGO1c2jUKI9iTjKgQ8vkjs?=
 =?Windows-1252?Q?Ro7SWMKrCJnaMZ63SzUX41hlm8/uGyxNZLetAdO5qnQHBV+RpznZsM0r?=
 =?Windows-1252?Q?e4DbQjlE40XoSMv45UDP5UYjxmUlyRxPFDWCWmovcf/hEc5sNCGcWIb+?=
 =?Windows-1252?Q?ONXrFVwRiQ5I9BmZLmO6NPSXdWYavnt8N4fRcENuz7yDQY6Hg3nqxAXl?=
 =?Windows-1252?Q?Pca2Vyc8j0jJnY3ZG/2evlJbvxNWeUxgoSMkuWKBHVOQGVTjChVtiH5y?=
 =?Windows-1252?Q?oLJId2OM6H4BBA5B9TCbg5amBVaKseUuxmfmKTm9kC1kSBZT2jd9O4c/?=
 =?Windows-1252?Q?LDOQ6XpeL+RnLyOvCl3TpRlKfoPHhD1wJ+usZ6/fbL11K+RKeNW8xoVW?=
 =?Windows-1252?Q?CES2PX6frQG+v/7Yjuf+cQvuFIsu1mFr+4u9oS3OtHcpf9tSufod9dpN?=
 =?Windows-1252?Q?a85cneF2NQ3NYHViq4ZGMP1TSs5Q72Jc4iPXjjPGudMeT6V2sNomaASc?=
 =?Windows-1252?Q?7gcj3bnCZy7/KiKBbaIE9RkYOnFeRukO2A7wyZGMQHZPgAKrdfeVYBMc?=
 =?Windows-1252?Q?buCgpIVvFijhqURe+HvhrNk6U4NgUinAmLpwK7pafuyLmuKaaMwQ28It?=
 =?Windows-1252?Q?KP9CrTQHclnai0hs79f5aRzOWf+NVB7XPvBuPFGcrEHGaz8edVOSU08+?=
 =?Windows-1252?Q?xs3GSfrrXaOjg81K5S7ihjk0lbqxfsaft6Xsf9NnGi8ZHhr1IGCJQTnb?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f44c2d9-2ce2-4ff0-a294-08d9790a3463
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 12:04:58.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub3PNfcst5r/XL8SXpU7kN2wgDAlL65usQAlXtqPR37wp55r4OKS4igLTrU7c9XTIDFAAgmjg6VTAnJBG84QBdtaGX4d3AQ+BMo0pJnF37A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5585
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ttPCPnuGTRwjwmrDUKgQTJ8xx4520388AA=
Content-Type: multipart/mixed; boundary="swMWpoiAHiELzKNUuca6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631793910;
 bh=557ylpt5vyH77Yg/grr/3WoByU059hiT2a1qQVRJqno=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TXltCNPZx47fBvA2zcWXQ++quYShY7605NUd5NetO4/cPUuwgxlSnNj4NKgleL7kJcG
 4ZdGutitG3mfTDplbrKiEP6uCBaUBDLcXQTG3aZwP/6aDj6sv+U+ijmi3CbhBFKMed+0d
 ARSCYQu2ZqFlwbDXFiBJyywidNKgTgAOsrs=

--swMWpoiAHiELzKNUuca6
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Jan, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 16 September 2021 07:11
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.

There is a chance that I may not make it today. Just in case I've added som=
e notes below.

>=20
> Please note that we moved from Freenode to libera.chat. Our channel is
> the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> Furthermore note that the IRC meeting is now scheduled to UTC (GMT)
> 13:00:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%
> 26month%3D9%26day%3D16%26hour%3D13%26min%3D0%26sec%3D0%26p
> 1%3D224%26p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D
> 248&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C7f495232a8
> 5c44b56ea208d978d8ca45%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
> 0%7C637673694777997101%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DjITtPWySL7jFizH7hwZkcwtG90KbqftA70TEkBYMCEc%3D&amp;reserve
> d=3D0
>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
>=20
> Last meeting minutes:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclo=
g
> s.baserock.org%2Fmeetings%2Fcip%2F2021%2F09%2Fcip.2021-09-09-
> 13.02.log.txt&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C7f
> 495232a85c44b56ea208d978d8ca45%7C53d82571da1947e49cb4625a166a4a2a
> %7C0%7C0%7C637673694777997101%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3DzkeyEhzTKsDWpLFE59PjV9AjBn15GHu%2Fujcy0YxpfeE%3D
> &amp;reserved=3D0
>=20
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu & alicef
>   2. Document new LAVA domains in wiki - patersonc
No updates.

>=20
> * Kernel maintenance updates
> * Kernel testing
I don't have much to update since the TSC on Tuesday.

Kind regards, Chris

> * AOB
>=20
> Jan
>=20
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


--swMWpoiAHiELzKNUuca6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6742): https://lists.cip-project.org/g/cip-dev/message/=
6742
Mute This Topic: https://lists.cip-project.org/mt/85645942/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--swMWpoiAHiELzKNUuca6--
