Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C6C433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 12:38:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.10261.1648125517998845568
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Mar 2022 05:38:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 22OCcT0p018754;
 Thu, 24 Mar 2022 21:38:29 +0900
X-Iguazu-Qid: 34tr9prRwEHD3xU5mi
X-Iguazu-QSIG: v=2; s=0; t=1648125509; q=34tr9prRwEHD3xU5mi;
 m=PpWmrzrmRskbKGWZHoLpkV5C4zAMDETF1QjZqMhPSWg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 22OCcS62004579
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Mar 2022 21:38:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EewUK+Vc4AftB6YBff8pDoQ7DY/kHSOTv/2RUBrsxUzKgdOCaHnm6eh0gKl9i2B1R3cYLxaGIrWCpELLMdMJvTT6m5hp/Tn6GUbBuZbGXcxQBLTofCLlCdkI/XrK6VlhynUv+J/gJ0r6aZiqaWriLVThvAb8hkvMFnbQ3gMYN4IB4zQ/igGuoRtGsPaqovvDMdHOxCvxznCIq46vmczV4OFYdctwE+RYeBVZLMTBMHC0ZWyQUg60RrVcGJju3VDxSewG/5p+MGIHtIm7edFVEK9wzt62HcHGOSfmD/mP+Cy+PPMdM/vOKfbSXeeZQ3+geHonkqle4Q63LUh80dwPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1B0lTmzORaUHBP/bqmvMOBmu3hCnmSY2T9GfqyvLXY=;
 b=boQfkxIPGn26692468usxI/xbuslEtJ08gMBsb2ew5Y2etsK0q0NjCtWxmR64qlvbBMImDeKNQ/ZVoW+rCVWaDJrAZthNmnUSvtmRvvwAj1OLRKTlYfStszhnzIOPu8DiTcpaZsgyTq4SydOSSb9lWK1Ofncj4K5k+g1Gg57UVPT5/GJVU4sqthUOBBeR4CB3Eqsfi1SQZTSFrWEZChmLL4iMdCcq19xxzFv+J2jmXghL++dP9/I+YTraHRBZT88vpAGbkSmB/JQV19JHrVh5dtuCPrTGBZWkDhToPgaCDSvSJ21t5lzNIgNXn1dPvNoW7d9w2wKbHnbTOn/dKfr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: Doing 4.4-cip release
Thread-Topic: Doing 4.4-cip release
Thread-Index: AQHYPP6kbc9MQlS1+0m34Zgk920dFqzOe7gw
Date: Thu, 24 Mar 2022 12:38:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62522189BBBBAE46DEA125DD92199@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220321083518.GA18233@amd>
In-Reply-To: <20220321083518.GA18233@amd>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2178b3e-a5c6-49cf-34d4-08da0d93316d
x-ms-traffictypediagnostic: TYCPR01MB9369:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB9369E1D60B042FEDD6A173CA92199@TYCPR01MB9369.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pKb9sQVZm385cyxARhIitZqNeQ6yj2Rf6DpQDCfk4mLWCpPt40LXcHgUbLBErG3KhJNEFv2aRKp78Hyw+W3a2HsGjKtg60U7kYZJhR6e7iVu9xQ7eVcoM+5vj+VwELQww4hDEmP6G2N3LlQDLSz49HwcYxstqWOAju/Bksl002uur1ZU87rjBte4yp50lqOxHe4RPF7Pu6G9Xo4B2wDB5ehH0FmHF9ho0jjjuGJjo5kZ9yNYwPgJuLWVS0edPT8Qi5lWgFm/gzlLo+rTaC78l9nBKLnTozHdGhTkZWMSiUl/h0hcnf9S1dgb7ifsnhxc4zwp1FASuVaQ1t5/5HoxuNjcxnaVC8r/SOONqsxaYj057mf3W54tjLzh2IoSnIhrnJVBVLPAPmFLGf2YLRpPmNiNA959KQKEBFceg3sL+XL6TYuac0sKPYmnuO3Edi6470so2o1Naux9qZNb402pvk8z+xgySUmZ10FgPBR4a7jhRMEtIIxEqQOxArpKi29v1WuOYdK0uedzh4rIaaVOZm7eIO3MRIiVviIPDRr+UuKMApmqeAvAuayEfbA88LSvsCHuh++Trzi0/QS7nuTRx8kjpzMzZEazoqJJ8efnVApXFVaXpVqNvvq3wt5Rv8UvCbmfZP53/TGzywkO8VjpYgccB0gEvc2S7IATmqDpCsaXAAC7nfWTxOU3FCfJGgzRUnzCUvtG4jWMcQqltXlSQA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66446008)(66476007)(66556008)(52536014)(8936002)(8676002)(2906002)(66946007)(9686003)(5660300002)(76116006)(33656002)(110136005)(316002)(86362001)(71200400001)(38070700005)(83380400001)(7696005)(4744005)(6506007)(53546011)(38100700002)(55016003)(26005)(508600001)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bnJzZm1LVURLcXBiY1YyOUoyVmF4Tm1uZVQ3eitLZEhmUmt5bUZtWWJX?=
 =?iso-2022-jp?B?RVUwNTR2TW5INE8zc3BIQUtkTWtTMkcvcXhCR3NBQTVlSWtUYXdHRlF1?=
 =?iso-2022-jp?B?TkJjYjNza1FrUEc4c3RqUGZPaGR3ZlVmS1FTMlJ5WTVicGNXbUxibEt4?=
 =?iso-2022-jp?B?NkI3THNCemdGdmxWeGRBLzNid2RwcTZiNjNtWVBzaWR0a09jekp4d3Bm?=
 =?iso-2022-jp?B?dnVHSHRmYkJtZEtYR1daZFhqU2JZdjB6aW90Y0VPbHQwdTNKNnRUU2dy?=
 =?iso-2022-jp?B?OUtQYkxlNUsyVG9NcDVRenlqNUt3NFo1OStHejRUeXF6WTF0SkxNam01?=
 =?iso-2022-jp?B?aVl4YU9QMktJSEhlRmVHc290UFNCU1pOVTRSR29UeTlrUGxKWitkZlk5?=
 =?iso-2022-jp?B?VFZxNmV5NzhFamw0VXM4Z3M2R1VLQjBPa05nR1pZRWpKZFkvWm1CaUVD?=
 =?iso-2022-jp?B?VGtJZ3htTEJxZ29nVVJ4Z092Z3Flek5rRzBPaGhvL09vem1vUlFpanVr?=
 =?iso-2022-jp?B?bm82K3l3cjlaZEJFVndNWDR4cWNuMnFVM2tZcUJoV2JERG5ncnl5b2xX?=
 =?iso-2022-jp?B?Y2NlVkZiUkhNNW5UY0t6N2hUcjE1UmhpRG14aEhLOS9hNWVMaFFjRHd3?=
 =?iso-2022-jp?B?MUdTNk90aGVuajJzcUhJNmRtQjJCMVNEUk5TTDQ4K0FuNWw4ZXRMRUsx?=
 =?iso-2022-jp?B?cHYxOXZJVHdZWUFhUVZtM2xpU1BuQjZMN05IYnZlMDl6czE0aGFzOWhl?=
 =?iso-2022-jp?B?L2VzeUljeS8rdk5FR1RXZnJUdlY2eURaVm9SRXZmZzU4TkRFcTlRUUFk?=
 =?iso-2022-jp?B?TXU4eHlmS3VJajkwRjV4MmErMTVnSnFMOGxWN1Q1S3ZaMTdOMXloSFJP?=
 =?iso-2022-jp?B?Y2tUWVZreEFlMXhpaUU4TVNMM1BITVJQQUNFUlNmeHVibFprVEFxYm1a?=
 =?iso-2022-jp?B?UEh5OWlkY0pMU040K21hWk9kSkZDYTVBQnJvdzR1T2h6MTgxeDZ5ditY?=
 =?iso-2022-jp?B?UW1RMjNLWDdiWi92bjZJQzRvRG91QXRjZDhDUWM5ajBJcnk0Tnp1UWor?=
 =?iso-2022-jp?B?ZFI0dkxxaXV1NkcwazdrMzJMcGhLNngvT0FUazIyZm1xRnp6ckpvR0hQ?=
 =?iso-2022-jp?B?S1BhZU1UMGtrdzFwODg0Q3BEdDBsVDRZNE02TGZFajNKQzA3ZUJldFZv?=
 =?iso-2022-jp?B?bjQwdnVtTWZhbS9UZmV1YjFqZk1Bd0h0aHdhc1N6S3VaNXVxR1dEbDE3?=
 =?iso-2022-jp?B?cjRWUEdBQnI1bDV1TkRTdWM4NU1PM3cyM0NVSWQvNkUra0NVRVdQT2ZS?=
 =?iso-2022-jp?B?Z25ZNTFYWW0zWU1hT0JHeEJ6WVlmUzZtV0VVYlpzMXFZdlRNQ1VESDN0?=
 =?iso-2022-jp?B?b1NSbTQwdThYTVkxeXNBeUlGWFo3SWpiUVJJa0d2OVp2akd6OVM4bmYr?=
 =?iso-2022-jp?B?UkRoWU1DWTJBNVIxckwxa0trcHQwWTNuUlhPZ3R2Q1JzbG14MTIwVlY1?=
 =?iso-2022-jp?B?T0s0ZXNBUGdQOEpVRDhLU3AybVVPemI1WjVicld4dktlM2psS0lJZkht?=
 =?iso-2022-jp?B?ZmQwVDR5allWVnFZWmQwWjNod0JxQjYxL055QWxqcGQ2a2VBQTZqZmFS?=
 =?iso-2022-jp?B?Z1ZONlJXYXA3b3J4Q2d4OC9EMHJUZ212anNBeFB5NFBzRm9TZU5QMmNn?=
 =?iso-2022-jp?B?d3J2c3NVT1dFMEJPNDU3c0VYS2tyQjdhajUvSVF0MG1LNFdHVGtnK0o3?=
 =?iso-2022-jp?B?emp6akJmeDRSS3M5VEVEOTNlTUh0enJqMEdrdTBGTVJoWjlza1UxbGg1?=
 =?iso-2022-jp?B?aDdIbEM5bmZEMjJuZUlPWnJSTkVORjdqQnM1UTNMSFRhTkV4TzhUUmhE?=
 =?iso-2022-jp?B?NjRlUTRjbTJTUGtsc3ZrNERPSkNhZlhVaEljTENUY2ZJK05DOHdvdWU3?=
 =?iso-2022-jp?B?OGZtNWpQblhaZmVLUUhqZFdKbFZNS1MyVzd3UDJhdXJzaUJQd0V1SUsy?=
 =?iso-2022-jp?B?K0pZdGc3SDNFRVNabmpsc0N6dDNlNXQ0SEhiaWRsMUtMa3pNL3hOSlNz?=
 =?iso-2022-jp?B?ZHFCS1N5c1lSVy83NFpWSkJZSzZuTitkYk1zejVVUjE1ZjNKMDB4eFNj?=
 =?iso-2022-jp?B?VGFmSHlJcncxeWhmRHdZNC9aaTdGelp2eFlObDJzcXVpSzlpVWpLNzJ3?=
 =?iso-2022-jp?B?STdMN3ZJNmhHZmVVelBIdURxdDNaMGo1VTNRdXhCQ2huUHBqY2tOcGdh?=
 =?iso-2022-jp?B?SEtmc1BUcFI5SUFwRW9MZ3pHdTlWNEZ6Y3dPQWhYbzBUbFM5bXlIa3hv?=
 =?iso-2022-jp?B?QmJSSkpVVXN1T1BnRTVkbS84WXBnWkJJMVhJNzVoMWVnOFNJdytuclhz?=
 =?iso-2022-jp?B?amU0VUs4UXd0ODBJTitPTTljb3F4eDhBbGg4UjJIc2RmcFZkdmM3U0Na?=
 =?iso-2022-jp?B?Ymc5V0F4WXpvQTVqWUpTSFNRREhqczFpdDh4OVhxbE4rQ2JxNDg1YUpj?=
 =?iso-2022-jp?B?cDJNNVVBUDI5Wm8yRTdtYVJhcXVicGpiOWdscjZwMkdUS2VZMXc2dWla?=
 =?iso-2022-jp?B?MVJCdWJ4UT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f2178b3e-a5c6-49cf-34d4-08da0d93316d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 12:38:26.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 PFgwgVwBhJGvzeV80QyafASHmnv24vwAFaEfoFy2qTJTUGgpejhPsNN7sMebHrXXIOHyi4fU9Nn5x00P/Wm0Lk3r1PWXO9Vpj9P3PzBbAjoZrk6Ge+gYlCcR0KNojFaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9369
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Mar 2022 12:38:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7820

Hi Pavel,

Thank for your work.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, March 21, 2022 5:35 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Subject: Doing 4.4-cip release
>=20
> Hi!
>=20
> linux-4.4.y-cip tree should be up-to-date with changes from 4.9.305 and o=
lder.
>=20
> I believe it may be good time to do 4.4.x release; last release of 4.4.y-=
cip was at
> Feb 14, and 4.9.306 contains speculation fixes that are rather intrusive.=
.. so it
> may be good time to test that we did a good job on the easy changes.=09

I see.
BTW, linux-4.4.y-st tree, do you have any idea to have a git tag? When merg=
ing into cip tree,
I think the tags make it easier to manage. For example, create a tag the st=
ring contained in
localversion-st file.

>=20
> We do not have 4.9-rt release to work with, so doing 4.4-rt is not easy a=
t the
> moment, and it may be good to do non-rt release, first, anyway.
>=20

OK, I will prepare for the release.

Best regards,
  Nobuhiro


