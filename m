Return-Path: <SRS0=NiqM=NK=lists.cip-project.org=bounce+64572+6693+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9855C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:00:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08B361051
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F08B361051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SGYBYY4521723x8nXdbZV5UR; Wed, 18 Aug 2021 17:00:29 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web10.63261.1629331226034372692
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Aug 2021 17:00:28 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id TI3S10284A;
	Thu, 19 Aug 2021 08:55:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck5pMCGVu66iBsZe6Vfjp5XozXdMZIzQW0HApaEHumDAPZbYzjHkexdXrTXPAFKf0gDQFXJMVKC+1GzyrqaSzQB7wEcrs5yiXE197aYEZ7EBUjmKaAIKWcZlnwHf80saKM5wF0W0Jqb5UUfnqZcFwXIVlyXPSGXi3gxeryAWvrfPLmfng/UDYs9TuqJIvJZLGFf3soLVCCnqc2WZKnWeVnUcnQlmsFTtYBnwZdZU9SE/C/ZQJToutEsbycxzrtvPGIA5+x1EyQfAF4GlZ/BKQVFzLUJNoOLK0zvyBHHzax95I0OZNH+GQHa2SNQnYtJQz/3OnghczPVJG8D2MTkblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqbOKaPU2rddw8p9qtgaBOZOMOepl9An830d0iYiTGY=;
 b=L3NEQSw1xwiYNcWOKAjqwhOAqpVsf9d1WRpR/qYwrNUJjoNyNiabD1eADwSj97cgJ/41hSMjuW1O/kPl1MnB60dhhCK9V/PqkzHJAhu9b0KnuIuDnJ6FOW2oIzB/IcWLskSvP259u3F0SqltNKnUXfrgLuQA9iWwfebpn6x6OwKKCa7CNBJEaBENT6RV/8BrVAS19TxM6+8smsxEYrWRrCRgO8hqTpKakBB8WGLB69O4FDIHPGUEGOg2kgEyqGEufDhtvHMgkq1H8HsCWVF0iwlCCfIf9DV5AIP3YZhzPYPm+NknkgBwhdGzlCmOfmW4xd7A4xORv2pZLqTJTwr0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYYPR01MB6827.jpnprd01.prod.outlook.com (2603:1096:400:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 23:55:17 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 23:55:17 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] IRC meeting start time
Thread-Topic: [cip-dev] IRC meeting start time
Thread-Index: AdeT/i+rsaYf7nfrSTWhfzAPz18jAQAYQGYAAAtK3pA=
Date: Thu, 19 Aug 2021 09:00:21 +0900
Message-ID: 
 <TY2PR01MB49723F3E06DDBA50E8D96924A0FF9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49724B0C88AF035E898804DEA0FF9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20210818183100.GA839@duo.ucw.cz>
In-Reply-To: <20210818183100.GA839@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a489751c-f317-48fc-ac54-08d962a3a174
x-ms-traffictypediagnostic: TYYPR01MB6827:
x-microsoft-antispam-prvs: 
 <TYYPR01MB68272186468CD97CCCF7BD15A0FF9@TYYPR01MB6827.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 EEqKkmWecXOHurrFuKF5lJPGT6I9CbDaDXcCKW22M/zLx1UDpHGfVRXIQ3kAZwkXEhAxQ+9SQAFmJdK1Xicp9oJy1UhDAwfyqieKpPkAQ0fP398Dr4LCT6B/rf7NXJ3g8QNO+efTJezIoeZgMhzhJs5DJK84Ex9aK3zivfZlapehSpgbtiuOQBcfDxER1VwUdVRyomFMRieAEt7DzdqDbNUB1iZygMI1nXH7DrDxg9cdtChSFNYTdabyeIB4s8Jrbx/aqRWCgVP90Gb2/7Kn39XCOQUU4oxIl7MkTrWv518x9SFIQ64jjDhNY0/b72dM6N7KRTNkqhcL6adLgDx+FjbaJF0C3LT8e4fK0qIXH/fB4TECGp42zhbmwLABXaYHpAp3pdQYW1BPzAhVzznfKXXAHvN5iW7aPPDsbxD2m9Dw3b6YD+cIPKvHenr9bBOQaMDvArNgqC0nq1wQ3yZvAyQrIRLSBZtRAyfTA7Msnw4Gsl4kLmXwl6BnJkwQ0mGAMWoJDYsmnwptmNpi8re6MWjowDb6wmbYCTGV23kTKthmYuZqPKzstKUyNmGHSWjMqZhIrJRjPhUPHjfen5RnSsEGWY6Yv39kSJeVkJ+3e2YYnlFpnVgeB/tFQklrY+lTU62pe8hKzo5OiVzQwPsdM3P7kq9RYJ8LEcPasddc8UXFNgRsMN+/GGKGrv2gZ/+kbWRlRFYbEdFj+XTsZut+8ZYyCk92bJCx9OURaOLedHkdxe6n/nRby02a+zaY0Aow
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UHF5blh4ektYOFZPV1J3Znc4VEZzb3hseWIvdmRrRGR2YlJ0VWFTUmpw?=
 =?iso-2022-jp?B?SUdSVGp6dk9BbWNOTUYrMk4yek5tNVJJY0tSV2pqSFQwSUVOblpqaVpt?=
 =?iso-2022-jp?B?YWZQTzdUTC9jQ0tIVG16WXg0cld4S2Ftd20xdUc4QStIQWlLS1hMTVRy?=
 =?iso-2022-jp?B?K1JtZGF2Y0xueG9Ib2tXM1Q5T1ByQUVqVnNXTGJGdjJvQW85Myt6S3l1?=
 =?iso-2022-jp?B?cDZFY3pFYk1jN1NGWCt1WlFtNDFtZElJKzFxYmN0UWgvaENTMnZwa1ZD?=
 =?iso-2022-jp?B?K2U2SlRkVlpnSjdvOGovUVFTRndha0lkU0ZGVEhnOG5OakRKOXZvMFFG?=
 =?iso-2022-jp?B?YzlpVHhrRnNnbHVYR2JKaVAxTUltQ1lsK1R1TVRJSHNaWXk1SHUydmRP?=
 =?iso-2022-jp?B?WkhFd1ZJdzF5K1FKZjlQZVdaditiRjNlb1lYeHB4RDhVN1VDT21YNTY1?=
 =?iso-2022-jp?B?Y1ZRSlhncEZENTVYaVRlWWdieTJ3RnkxZFlDaXVGcEdXS25zTkYyb0lV?=
 =?iso-2022-jp?B?bFh4dWRBNHBlMERnWEhXWFdkdXI3bVBjWFUzUGpJOENycnRqOXZpVXpL?=
 =?iso-2022-jp?B?dlhLT2NEM09VTmdvTS9VVHgwRG9PdEpnUGs1QStIZm1TL1BKK3VMWUpK?=
 =?iso-2022-jp?B?NFByRDNaMWxEb1I2QmJPak8yd3VzYTY0dUV0LytIamdOV0VPbmp2Y0J0?=
 =?iso-2022-jp?B?TnJydUdaQkpSL3A3ZTUwUVAxT1NYQ3VhOGVuZVpXTkpPUWVTU29IUUdT?=
 =?iso-2022-jp?B?eUEwZmxPYmxWRjFFbEw5ejlFNVFpU3QrRXg2L1ZIUS95dVh5WHk1Ulkw?=
 =?iso-2022-jp?B?WVpZNnVSVG81UFBUeDc5Q2MxdVFUYUxCUnlsZVAwS0MrTW9Ed3Yrd01r?=
 =?iso-2022-jp?B?V2lLUHdubjkzZFNQUUZCUkkySWFQUjgxMXFLZjdEbCtVZWlRYkdJWG1i?=
 =?iso-2022-jp?B?M1V4UWRDU25jNWVhT3FNaDNvQUJQNmdGVTU3U3d1VXYrN3FGQVUwZTkr?=
 =?iso-2022-jp?B?QjRYRnVYQWsxdjRqRFJKcGxzd08wMlI5SHlSczdMMVlodUt0Skx2L3dM?=
 =?iso-2022-jp?B?bmVpVkllT2xjZDRkV2tlcVExbFFXK1piT2hGaFVLK1hKTnZjMmxKQWFP?=
 =?iso-2022-jp?B?MmNVMHhsc3VoVkNQUzBhSXpaU3NsWFE1cnFtRjN6TkFEQlhjUkFTQU1t?=
 =?iso-2022-jp?B?Y2VHZGNDbnozRW1nVEkvQXZxSExiczQrZjRTZksyNmYxdnFEaTIzZlBo?=
 =?iso-2022-jp?B?WEVMY01zQTlNTHJJM2Z4SkR4UGs0SHJDZTI0c21ZR3ZWTlpObDRDTFpy?=
 =?iso-2022-jp?B?ekdQLzJrb3NKeU0yUVF4anRHNkdzVURwSlh1UHdyeHViOUppWTFUZnM0?=
 =?iso-2022-jp?B?MU1uRm51clpSMzd1M2ZmdUVrWGxPaDJxWWtrVXJNMjJCZDJ1amNnZFhC?=
 =?iso-2022-jp?B?amJKaFJkY1gvZ1VGQ1grTlZ2Sm1yYjZqNHN1N0VnRkZkYUxycGJOdU5E?=
 =?iso-2022-jp?B?OXVmR2hIUXhITjNYdU4xVlg1dHcvbTRvYVFlMDZnL1JOYTNNbStnT1JR?=
 =?iso-2022-jp?B?bjFGMEdlS1NKSEJBY2g5bjZQaTY5VGtPMEV1M2Rld3pBUjA5dGZlaWxU?=
 =?iso-2022-jp?B?bTFXWXgxRDg5cVh3WU05aW5NT2JPY0FoNWVCWmlrQjdvamhtTGdzcW93?=
 =?iso-2022-jp?B?czBiQ04xampJNVpRNGtDd0ZkUFZHZzB6QTREem1EODJ6aEZBSTdxRUlN?=
 =?iso-2022-jp?B?azVYeExJN1VWY3k1K2lHQUFLTlZ5cE1leGpEWDY1aWo3Rmt4ZTB5S3FD?=
 =?iso-2022-jp?B?L0VEVncyWnd1ZHYvQStkL05Xb3VxU1dIMy81S2ZsR0lNd1l6SUlIOTBO?=
 =?iso-2022-jp?B?Y2pOWHVmdVhiVmE5bE10dllncWNWZ3lFOFlRLzRmREowTE9ZbUdQaGVF?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a489751c-f317-48fc-ac54-08d962a3a174
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 23:55:17.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKQhjsZJxsdg0w0hfi4kpCBtF5aokZhKgoD6/i9JyFyb0yO/RSCT0jE7pQxi+Anez+7ZvL+9X0XAZwqOH80Yt7G7kOA1I3Q/yVEYXjz41JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6827
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vg8gqkJo4ln5FG71cB9cps54x4520388AA=
Content-Type: multipart/mixed; boundary="523M5AhnpqinoJDGvO5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629331229;
 bh=yDt4FKy7kzYxt0tZ/enCkSPzv+0VH8bDcOhuAwl6SLU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=vQ6js5Xb/GcUZv0T8J9T47NN7KEFY0vHAHGDkhxNwTNV4ITFwdFxuWrCwM9AFGHgXxp
 Rv7++XpQ11XKmuUGQVq28LZXdNB9M8hdV2IW0/ghadh7gBg+LYY1uf8kb6MFHaI1myRYB
 iJIXXP94qRsKSs0Or92v5So/kguECfYw5Bw=

--523M5AhnpqinoJDGvO5k
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

I thought time shift was agreed at the TSC.
Sorry if there are any miscommunications.
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Pavel Machek
Sent: Thursday, August 19, 2021 3:31 AM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] IRC meeting start time

Hi!

> We will change start time of IRC meetings held every Thursday.=20
> We will start the meeting at UTC 13:00. That is:
>   - Summer Time: USWest 06:00, USEast 09:00, UK 14:00, DE 15:00, TW 21:00=
, JP 22:00
>   - Winter Time: USWest 05:00, USEast 08:00, UK 13:00, DE 14:00, TW=20
> 21:00, JP 22:00
>=20
> This change is effective starting tomorrow.

I was at TSC Zoom meeting but did not realize consequences. I have scheduli=
ng conflict this week, so I'll most likely not make it.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--523M5AhnpqinoJDGvO5k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6693): https://lists.cip-project.org/g/cip-dev/message/=
6693
Mute This Topic: https://lists.cip-project.org/mt/84967414/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--523M5AhnpqinoJDGvO5k--
