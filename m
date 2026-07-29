Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5EEC53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 02:12:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2598.1785291151498608925
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 19:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=uSV55NWu;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1785291149;x=1786500749;bh=eNwUPzDhXuuyf0z24v5YItJiVrOOw1wo08r9W
	3iMN0I=;b=uSV55NWukPepTYP5XOkk0ys3BDeW2QE29XNh6LsrKWLYuk1THRPWHI0Scry71qTbzvl
	uXIbGu/Dxlo1Io0ebom/N9D4ohn1/SYRxaxKkNnI14/oEbqnpX9e+szl9BAB7sQJNglBsi7vT0fcE
	QrqE/wofidCib3pXeeA2PEMHjgfqCKCaNHClh5R1c4ZkqZzbFcYgWVL37ebXaUG8Y7XEUlG0U7+Pt
	XEMeA8tdz/uDSfp7104YkjwpdgEfwqKB/IfQA4GiBA+RreaxtQzbJo51FMIKPCeKgsv5TtE9woLOI
	yDrJjCyJEZDPn7gVJlo4XQY5DI73jcq3FLiobCyLKdgQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66T2CShO2790060; Wed, 29 Jul 2026 11:12:29 +0900
X-Iguazu-Qid: 2yAbeCtgwD711TcL1o
X-Iguazu-QSIG: v=2; s=1; t=1785291148; q=2yAbeCtgwD711TcL1o; m=yqusvD/6btGGiDf4QwOoGPGWoeUuOlQ5vyEf2a4pSRg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8wp40w6Qz1xnh; Wed, 29 Jul 2026 11:12:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R80Pqs0eZ/GbFNcpk8noBdWE3VU304BD867zdGd9om2u2ICgcOD6PQYBDhhpj+FzxEAG7yZs6pJd0tbu/7aZ4GsIuSq4R1huZwXKb6qH9Zx/dZC+BvCv68aP6a4B+uC/Fn37aJYbJHDLZzQuj3tnmpVrrsv4KLq+DTJ6xEhkZexi9R49hhCjOwAJrSAN+AZwCd/iPkN9oyBMHM+Qcjh0T7+YUbZKjvr5chJcibHBElYcm5JoOlLn6wCNk/ZUsIKmjoIc6Q3fCxXCPz7e5ZceJ6tVbeWfOiDA/aAy+KAPUj9klp4YELY8c3+9Wtuc9Y86XIhKsr3ZU9qQ51bhCpaEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/yrj86dPPYgdhLJ/4mpnE+L3KvUx16RPKk8DoWja7U=;
 b=McY56+Os/ZZX2j7Vu/bDnrI910Dw2P3zTm9oUKPcis/PF/kHVcjKLBi/c5s9he3ua3SUOL9hQzGtmyUaWdzG24KHXCKcoLxZfGyF53fYVi/+JnhQpfQHMyG/eSXHNnaMNp83GJbOSvgx4xzBWie7rUK6qBEfh07lsfjj8cZyXYwGK7md57iEu/I9U7XwAeCCEQN+oPxbnSrn1b7b6ni6WHZbthd53zmpMMHx532BsS/BpeTOv+WrkjWacRawqWMxLck+WvqBupWnzTf4d8ivXYIAxFYH30UGcrg75DBSLkE8v3MnESaLAdOu+aHSil+ywjLfo/iraghEfyW1/9yKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip v2 00/17] Backport RZ/G3S USB support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip v2 00/17] Backport RZ/G3S USB
 support
Thread-Index: AQHdDrGT1qlxY/RtbkC65+XP92ggv7aBbAGAgAJ1kPA=
Date: Wed, 29 Jul 2026 02:12:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F9211DB748B56B67830FCDCA2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
 <amdRDRxJSeiQI1Ql@duo.ucw.cz>
In-Reply-To: <amdRDRxJSeiQI1Ql@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB15076:EE_
x-ms-office365-filtering-correlation-id: b43a59ec-ef07-4624-4426-08deed16d4c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: 
 XKQVzvaUDohPpgHbFPR3MP9W0gj/wS6VS1bg49+Owi/xOFzewjXzn/opLIE3M3NC9F9gz1cjxQe7uUzaA8SIGzqv4978BQuqDbnNkGwSpYohe7TMr994z/eE9moCGCrZMvPPzvB5RAIzKfEF9iWSPcoVxm5E5sDKYfMNeb0l1Y7PLBZGZqKYs1+vZqKrgt9lglEmbPOiHDshqpqpeU/Aqen1MytpAMUIAlsVEEyDHde1CAHgKJcWWFxTsoXqHwWZ3BWYwDK4aBqAFGIIHU5enM9yIaFiphNW6aIr6z5M8Ubev6x5HQs9v5Mqlz3ArwWGG9l2bLvRBonZBAOQsJToB/PBelDM4+mXkXTENmLS7FRDE245SinBroY6BiOHLUTluKuRs49zqNXVEpwiiy/BavzXHRz59WoUcFK3yZPoo8i6fxQeuDS9XCjjQn1IU5ed5N1Q/AFRt3B0XvM+0ExgjMkKe05rG3k7n5NQJeNgjbATzBha+TSEinTdso0IjtCGxU8tnJarNHlcUdZbhdEn03pYPpctMElHn5ruwa3G+jVYngoJ+Iciu51nPFdISJZ8l+MDaSGkIenWWH3X1X/VjJz4MChsc6HG01TQjJO1CPcXtVkMeCgj7I3zsFHQXbvlnqbpEZcpHaW/Y3tECJgOn3bAPR7tSfTNZflQmjgc6GjzDu7MVLwn2iyvoJylQV/so5k/Dey23COMyuYKBkW2QA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bHBxTlViWldKd3EzUVl4RXEwZmdLc0czYlYvR256U2NoeVowTkdaVmZI?=
 =?iso-2022-jp?B?YWoyQUo2WmVNSERoS056b3hob1VoV3B1V3pSSEtsenRsZjZyakx2SGxj?=
 =?iso-2022-jp?B?aTl2Y09ueUxTZ0VoYzRPVzZlUmpmR2Z3VjJDc2JhRjRFVytrUEhRdzNG?=
 =?iso-2022-jp?B?LzFzL0RBRGVTNG4wOWZSd2FmVG1RcSt5ZDRJU3pvYURVT3daUTd3Q1Jn?=
 =?iso-2022-jp?B?NGFlaksweS9JSHBoYkxmcHRaQnJ4SndVcStkWk1SbFVCWm55VFlpV3dy?=
 =?iso-2022-jp?B?Mi9NZzQxZ1REOVd1WUVlQjVxbmJpOCtoTmRMYkJOdGt0NXZxUUJtdVNB?=
 =?iso-2022-jp?B?THpNQ09GUTBWbnZEU2dsY25ERlBIeXhQZlhsNWNkNkNZbXAyUVpmdGo5?=
 =?iso-2022-jp?B?OEFQVHdxcjh5alZaelhiZ2taa25zMmVHZzNjZlJ1RjhaZWZQelZlTHhx?=
 =?iso-2022-jp?B?M1VUWEk5TGRxbmJ0QmFPUzR2Wk5nRjltQmFJN3ZSazlvcDVYc1JGVS9Y?=
 =?iso-2022-jp?B?cVQ4LzNDbytRQlExR0x2RitRdHMyY24wd0FKbnl6NVJsUlF5RE1ON29t?=
 =?iso-2022-jp?B?K2lEZ1lJWkQrd05ZQXpoUjVBaVZWMURoc055M3JsR2JUQTJOeDdRWHpV?=
 =?iso-2022-jp?B?em9wZjkyM1RxNW9aQWRyY05iVHhvWjJPOVIzSGM3TDlDb0xaV1liNDRl?=
 =?iso-2022-jp?B?bmdHbFlvU2RCTkViMXYvTWtYL0NFR1E0VFhMY1lvOGZ6SEd1Z1lXcWFx?=
 =?iso-2022-jp?B?NEdCbk5XRlZkanY5V3pRYld2Z0drZUlEbnpLSTBCbFdDT0w4d0hXRWNF?=
 =?iso-2022-jp?B?aFRSMUFsVUtTd2g3RGFWbXF1VTFSK21pM1BGQmxEMHg0bC83Kyt2dUJW?=
 =?iso-2022-jp?B?MEdrOXdDQkdaeDhSK2JJMGxnWTBrK3Q5U2pIWlpNNzg2VmE1VXFMS2hX?=
 =?iso-2022-jp?B?bDRlRE5lWnF4aTJJZ1AxbU9sbWpaMTIxb3k4UWU2bmJVZHhMR2RRRlhy?=
 =?iso-2022-jp?B?YmRUQU1jRzBYZHN4TXVKL0U4NUtzcUp4SG9IQitRYlk4cW9aa2s2b0Rq?=
 =?iso-2022-jp?B?YXBkYVJLZTlwMWVDWDhIRUZZOFFsQlMyVFU2Z1RTOFdvZVVCaytaQjYy?=
 =?iso-2022-jp?B?N1p6QVFNdU1STThqQmp3KzBZbHg3Sml1UVloYWlHRENOVU5XcEpsazM4?=
 =?iso-2022-jp?B?ZFY1eDVob3FzaTVFcUNBMFdiY29ZSVJ1YUtYQk84MHFvdksxODZEZGw3?=
 =?iso-2022-jp?B?TlZQYjB0b2ZZa0NIRVVKUTJYaFNEUWYxMFp6bERNbW0zSEJ5dHlHd052?=
 =?iso-2022-jp?B?Rm1qMDBiTUJJRW5LUW90S3IyQ3c2eVg0dFVLV3A2RWRyZ0p3dWxSdjAv?=
 =?iso-2022-jp?B?cG5VSE44c2lsd3RuRWhuaWl1eTE3Z3RJNldWMWxpekp2V3FnYTBSdDZp?=
 =?iso-2022-jp?B?bmFmVXF4NnU1emNjcjFDTjNXNVdMRlpJa2tnTFpydTJwVHJwS21KUmdy?=
 =?iso-2022-jp?B?bGdMZnEwUlU2dEpndURYdTN2WDV0Ly9PWW5IQ0gvbzljOGVuM0k4Uktn?=
 =?iso-2022-jp?B?Sm85alp2TkZzN3Y3OUF2QmtoK3JqVE9JVzIvOVUrWUoyVGZ0V3oxVnR5?=
 =?iso-2022-jp?B?dlRpZ1ZubXg4UDh6QWpvRFUrSS80YjNtbWl3UmlZWWxmY2J2Uk9zd2xH?=
 =?iso-2022-jp?B?QmFnV3pmRDlVU25HaXNvMWVqWEMvNTJtQ1p0K0RyZzVDY1pVVmhrQjR3?=
 =?iso-2022-jp?B?S0ZweGtkUGc4VXZqd1paSlZESjBkRDNFSXdNV1ZiU1dLcmVLN2wxeU4w?=
 =?iso-2022-jp?B?RXpldkEvajFuVFR2MGErcVVLTC95WjNyMlZDeUxJbEtuSExHODZjR0oz?=
 =?iso-2022-jp?B?Sm9jVVRCUUtQczVqZmlSOTFGb25lQ1hTQUh0djkyWDNtdmNZYkNuaEo2?=
 =?iso-2022-jp?B?RVNkUm52VVJxYVp5VGQ2TGxJMmQrQkhKT1l3Y0Vra2tJQkljWnNPTHpw?=
 =?iso-2022-jp?B?TUhyMCtWV1NIcTcrVGdBTEMyYzh0ZXNrckhOM1ZlZFJxQlNhN0FGSjM2?=
 =?iso-2022-jp?B?OUNaZ3VRaWNIeFczYlgwRENqUG1LekxtWWQyYjN0cVZtYXAzcEFJYy9p?=
 =?iso-2022-jp?B?UGV4cmIyMlRuK2JBbW9iZEJjVnQ5NlowNGJQWWFXd2JFMlJwTUdtbkVz?=
 =?iso-2022-jp?B?SVhwbVYxM09TcGIrdDRLcjF6RFo4Y2NiWFZGeWdBUEJleWVlRzVPR1dV?=
 =?iso-2022-jp?B?YW9wWWg3bnkzWEtzQ1AvN1Q2dWhPSy9KN0kyOFJCR0JvcXdTSjl2QTBh?=
 =?iso-2022-jp?B?YjZOeXlqTGlaSm9RRVhmd1Jnb2RyaEJFM3ZPK2FPOENHd2F6Q0VEUC9S?=
 =?iso-2022-jp?B?cEhhRFQvcm03VEJXc3JXMUNjdVJwUU4wbjE2N20rNTh3M0FSUlpLeDVk?=
 =?iso-2022-jp?B?TE4xTkdPMEtGQlpjR1JXUHYrQjZHbnhEWVBsTWNCMmJIeGxVWkp3c0M2?=
 =?iso-2022-jp?B?SUI1VFhPc3lkdjJTSUYwQml3NDJZOHlQeC9BbjRlRVMxT2JCYS9DZmw1?=
 =?iso-2022-jp?B?MWpQMVkrbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	mbRGaq55+BGDGTUNMlepZTiVYzrrW4MvjSd+uWUSw3k30qC74Ujvz5sIE9tSm+33nLf6lOzmZBEQ5fpG97zlzTr9oUxj4CSxDH7HMqvrKRPD9dZlNxVg2fPF9LBPWi9iHKaZpxOY+J7fDW9mzUzRX4YZIMZprA3+OlVQW/T7AXMS+08jLkodralgKtJQWjeJaxGcd2NUfvfMtjG4Z4bX0eTFMJwTz9hRKD48+2pQjbf8HQjp7/jcVMxG+yprmZ7RkjCSd4eBOMNLlVScYO8s/GFnIVs9NQaMO3HtRLrq78uz+Q59lXHvKy9W57yCekAGuTdiAjoubQE2+iCP6hGC+Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43a59ec-ef07-4624-4426-08deed16d4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 02:12:24.7110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrR6M872A40aIyl03rv4EFuYLR6GycTvD8H0EMaNIm/zHmZay1vBoC5UNRJhLreNWkd0/+jZe86I9ZXiAk50iuTtKIY/2rfPKYzOuGhM+fcgR/AaM0jUPjfQlu8c6CIX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 02:12:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23811

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Monday, July 27, 2026 9:38 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip v2 00/17] Backport RZ/G3S USB
> support
>=20
> Hi!
>=20
> > Patches backport the Renesas RZ/G3S USB support.
>=20
> I had a minor comment here, but that should be fixed in mainline, first.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I also reviewed this series, looks good to me too.
I will apply with Pavel's reviewed-by tag and push.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


