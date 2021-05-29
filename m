Return-Path: <SRS0=jOyp=KY=lists.cip-project.org=bounce+64572+6482+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89BC47082
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 08:19:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A8B610A8
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 08:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A8B610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6482+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nXyIYY4521723xbFtAWsDnnq; Sat, 29 May 2021 01:19:02 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web11.18918.1622276340031935345
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 May 2021 01:19:01 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id dRM123330A;
	Sat, 29 May 2021 17:12:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if8UjFIZ8WdL7DDYNuzq4oe/cCSivonnm5cjq9aIhtBp7R+wAQjqBrnORiFAJdCl+gGX2Ax0I3GJOHp9yat1FjUfqEV+z2iC3WGvxzKlZZYAisKdEuld+ObuajgsJjotqpdE7YdHFGbqyyCDA0FoCx1WLKRFXkY2TDS7Py8R66nllmRz8w2pRVSutvknvC9A9Zsu4H8/qqAqXx/5uFOPuLTKJSxwQ1qS7XbIclClpXpgnJIVMjCW7DwGKa88rO8lw673lNKvB0xwhOSjlMNJWtxeuF3p50lPaoQmAkQKWuVV0ofSUrW4h88FYp5wtDIPYAarzQdz5ZatXgSzz2Hgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vPeeTIcsqlSw/dV67cMVJILBqG4bAhW2BHu9as/N0o=;
 b=FKIzkEs8iG/kjNFKLXNxXvWHHBpRDabozhcGhdPKKp4uN30TTlzBWfh/hjR2ipeYAfg6n2m3Kh/BGd8IuP1ir/f9OIrfrDOTKvW56X2HhaUt47xewHAawx7AHLvXZW6yU9LRCkwdZpxpCWwUuRhxHVJAdkmngpcSiBwj7vi31e3dE/2zmYm8eiTW3HvPh3A96A6ly6e9KauZa4QKM9h2eiUx6RCPO8fvIlwFIJEGzeEtSoCYRCwD8SEpZVpoLs13FUe54pc5orFtINNyDTuceMJLm+yySdP317lzsIYDtubiJbyVpWg+rcPJ+R0HRV3qm5Q0mplkRndmbmBycQdj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3145.jpnprd01.prod.outlook.com (2603:1096:404:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sat, 29 May
 2021 08:12:48 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4173.027; Sat, 29 May 2021
 08:12:48 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] IRC meeting will move from Freenode to Libera.chat
Thread-Topic: [cip-dev] IRC meeting will move from Freenode to Libera.chat
Thread-Index: AddUH2du2ux4534KSeODCEfiheGgigAQErQAAACeohA=
Date: Sat, 29 May 2021 17:18:55 +0900
Message-ID: 
 <TY2PR01MB49721B7C329D954E8E7FF684A0219@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20210529075322.GA13576@amd>
In-Reply-To: <20210529075322.GA13576@amd>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d56fc120-855d-4c4f-4fd4-08d922798c33
x-ms-traffictypediagnostic: TY2PR01MB3145:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3145502FD455216405C1BEF4A0219@TY2PR01MB3145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 00XIobqbhfMjS7jmSXO26UTV7fuG6LMjT6CSe966wWWeSN26rC82+lV07Xm7GEaWhDDZbLedRvq1gATomuJIxlvTAxQ3mRB6XYadFGl0xL0N5OBFTVrr4/223kSq6cdImIGahSQhvPnflnR4XjUhLxAA6XUUOFoLCH2RG7Gw3pd+jFPd8Wmah2qTe5m2ToguhAVGmqJm6Oerq5KQbxb57ZThEuwsIdkU1R7+r34c1WgaQJN+igFFc6pSI7QIkjcIM2Rv0kjSpaUnrWoKtGRXb86bls3gvPOmDxNQuE8ydN/Gu2cJ1iX2vhAhw85DCc6TKonVY7YDOgc73jLxGgQr7CJMqqwWLWl2Oo0GIBS6ejQ2DbcdVq+FyvUOv8rQIMvx1U+ou1GOJfEH16gLwMp0p6sE2b5l6pkKf2074Irg/kHzydYFbLgIHg89KnD0cFR5rsdGptfkYY4W7V8ZlbyRuRT5P4oKAINLrznyqEsPhi/VhB+/HzFfkIZLTu9MnHkxDSBBpe7em6yQpS8UvMaDX4DccRAel46WgmdLfKKPqb1AqHf6T1WSnoWbPpR9lGgppRITwG34eLJvkRXsblJPaML5ppVBkqkx8N9YhWbPAElF1BIfXx3ZEXBGP3GEoePmq6PzXuMwKedPrXdPqwLO/HPQGwoeQ7dC+K4XwVLftC6eK5cPuBxHfzVhqQUkIfPNkJXv/MrudwFzWUeyXNgdhHU5fzMDuu+YmGDRzz/mbv7pAFtvGOs3Tmpx+uy8cdy54dc+JHOfB9H7G5jFKhv1aTekdcbgsWnwagXB7/obFJp9thfxHN3QEJZaN3QelEgh
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?aDFpRENWR3h3QVRtbGwwbkRKcmV6UmZpS1hMTlZ2MFNoQlQ5WkpvY3RO?=
 =?iso-2022-jp?B?WXcwUEx4bUN6Z1NWVHR5ZjVrYkYvemg5VC96K0dabGRDcWFwMFBYcmtV?=
 =?iso-2022-jp?B?VzkwN1QxUk1XTFdLVjZPbVUybzQ2Yk9DU0JhSWpqelIrUHdsVU9rOG9o?=
 =?iso-2022-jp?B?RmIzWUlzcVVsSXFza1pnZ2U2VCtIVXpFRUFENXNrQ2hKU1ZNMENwMzlB?=
 =?iso-2022-jp?B?aWN1U1hPcU83S0Y1cVBYYUlSWHpLYW4zNy9TN2k3cGlsQXAzVUJ2enVp?=
 =?iso-2022-jp?B?M0pZZlI2dTVJOENsM1UwUUtrWE9CeklGMndHSFU1SERZbDdYSFppMVZS?=
 =?iso-2022-jp?B?ZFp4dko2bFpjZll0RzR3cVptNnF2RlNaVHdEK2lsbVFQT3l5L3JSNms0?=
 =?iso-2022-jp?B?a3Q1ekNOcGZmeXllUmFGdWRCeTEvMFZwL0dZRFZ4RU9CazVzRkdlSFp2?=
 =?iso-2022-jp?B?YnhVTHBnbkYycjdHNnB1Yk1pTXg5T09TZ2lVZ2dtZ1YyalJ1NG5xSWhZ?=
 =?iso-2022-jp?B?UlQ2YTZackZ1MmRnd2IzQ3RHSm9NWng2S2toOEF0eXQvRmh3blNGMGto?=
 =?iso-2022-jp?B?amhjR1krOUsySHc3dDZkUG9SdHkrRU9KanJ1TjAvbC9nUlRkYTlrckFW?=
 =?iso-2022-jp?B?SlVMQVp0LzBFc3pkcEJoa0J2dHQrcEJjYmtGVk5xenZKclRhL1BWOFdF?=
 =?iso-2022-jp?B?RHpjdEJIb2l4TEY0REYxTGhQeWVHK2NUMXFCWGg5Mm1oaVBlWXR4SEdt?=
 =?iso-2022-jp?B?QUdKTmU0ek5OOVM0S1d1cXpDVHI4dlJvVTZpS2k0VHI1N1k5WFQydU9q?=
 =?iso-2022-jp?B?OE0zZ3BjNGhTam11b1Bzcjc1K0w0MTZNa3JnaSs0cW9YcGlzV3Y2UEJC?=
 =?iso-2022-jp?B?Z0JYMlBxaTVZejFoaEo2SERydnNOVjJhK01KTUhRUTVPNEdndTNYTjlz?=
 =?iso-2022-jp?B?WUl6S1N0VFpyVTN0Q1lPVFFzRTRTTHhjaTk1bnhyT2lEdVZ3dEtzWkpj?=
 =?iso-2022-jp?B?bTJCWmhqSGtsZWtFZCtaaUU0QTIycUJ2czRzS0QwOHJ5YjBjdHU4WUZu?=
 =?iso-2022-jp?B?bjdRRkhWWHloR0RkOHJyTlFzK1ROTWpkNUJCRXZ5R05QVFl5aWlxMHhK?=
 =?iso-2022-jp?B?MzNBdlZYOTdNVTNqQjRzNGtpbVYwYkdIWXNuWGRwMGpib0tTVWpnaFNh?=
 =?iso-2022-jp?B?Z01OS2FoQm9nNFJJQ2Z2UDc5RjRodmtsckhVOENrTzROb2hQN3M3V0Q3?=
 =?iso-2022-jp?B?U3BNMlp6NjFsZmxUTUh3SDRwL0toRkJGaUNHSmw5a3FCZ3VKNlZob2h5?=
 =?iso-2022-jp?B?RWlUSkdrd1o1NnMvQlkvUDNodkw4NENXb2pHUDF6V1h0V0NSZkR6c2s2?=
 =?iso-2022-jp?B?bEQ4RElZM0JxbDk1SU10YmMyRkE4eWlLMkRkaFJ5Y3lDdmhOcG1LcnVY?=
 =?iso-2022-jp?B?c2xoVUFkOXJBaWcyUWsrbG1lai9RQ0lKY3JyZVdXYzlsOGNnUWZPbnY5?=
 =?iso-2022-jp?B?QXlkNVRhYmJaaWc0R1pFc29HcW1xcVduN201dkhQcVFhZVhabTFQKzJF?=
 =?iso-2022-jp?B?RlpkS0o1NWo2VnNRN2FqV24xbHNkOG9YWVIvTEZ2ZEJXaUU4c0F4YStI?=
 =?iso-2022-jp?B?YWtVN0tiaVB5anQ1TTlGWmJxMktXRHhHUTQ4bXdQZnQ3dHA3VEhTQ2M5?=
 =?iso-2022-jp?B?aXljTWM5Wk8xR1lzUjdEd1R6ZDJRRlRmZVdpZUJEaFFtbW5DOHlPRGxQ?=
 =?iso-2022-jp?B?WUVwbU1yc0FCSGVtUXdDRU1nay9PbGZldFRVUGtwKzIraWwwTW5qM2RE?=
 =?iso-2022-jp?B?TVIzbEJxUUwzTjh4RWRRNXhSRWVXZTNkYmxnU0NRVEVlL21FRThOVGtU?=
 =?iso-2022-jp?B?MG13MXV0T0s3UGwwUDY2cFVEMUdRaWdlOVVNaGpSWi9ZcitXd3hPbTBl?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56fc120-855d-4c4f-4fd4-08d922798c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2021 08:12:48.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaGebOdq2PEm6rFlgchAd3Fp0eYaA+/XC2VelYsXWoWyJJXJESIArm72t9scqOD08T2PwsLJxGt0Mf5NpHHmgz97xDmUonepQXjTDjRzSi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3145
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zwaOhdclqoUaokEWLMBMtsdtx4520388AA=
Content-Type: multipart/mixed; boundary="PoMIdkd7kWoxDDMpSRKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622276342;
 bh=b7S2j+guAc9BbhTkDfL6OgPaLOyr87iPJWteYnVRjBE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NEg3XdSIAvjGNjeeAInsHv4bTHcvlkI3q+JVed9RCtZBX7rAE7Vj/+zOGCAGZUDQk9e
 8wZPQi+FLInNbisGXJlVfh2GmMZEFzSypLHp5Bm8aMYXlcgSrd2AoqdyXsALAG4ih0leQ
 zvDc1EYv3/mktV4IewgxVlWf+mm+/3YnxX0=

--PoMIdkd7kWoxDDMpSRKE
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

Thanks for pointing out those descriptions!
I replaced with irc.libera.chat.

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Pavel Machek
Sent: Saturday, May 29, 2021 4:53 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] IRC meeting will move from Freenode to Libera.chat

Hi!

>=20
> As we discussed at the last IRC meeting, we are going to use Libera.chat =
for our IRC meetings starting on June 3rd.
> Many thanks to Alice for this setup.
>=20
> The new channel is as follows:
> irc:irc.libera.chat:6667/cip

Makes sense, but it looks like we'll need to update wiki:

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cip=
testingwg

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PoMIdkd7kWoxDDMpSRKE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6482): https://lists.cip-project.org/g/cip-dev/message=
/6482
Mute This Topic: https://lists.cip-project.org/mt/83162075/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PoMIdkd7kWoxDDMpSRKE--
