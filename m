Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A7EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 16:27:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.2948.1687537668069486318
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 09:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 35NGRjXC021822; Sat, 24 Jun 2023 01:27:46 +0900
X-Iguazu-Qid: 34ts1GHAf23cZ8JUKe
X-Iguazu-QSIG: v=2; s=0; t=1687537664; q=34ts1GHAf23cZ8JUKe; m=m4KX/VCwePgJ3uy+J8vguCrtc2qQS9itRbTminpBLyY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 35NGRhYo013208
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Jun 2023 01:27:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNCVaNPz8iq659j3viUHF6gbFk6VG99mCTjnw0J9Lh8kDRn1lPHMLfYedJm1Jh1yvCqPV9Xu/zjNcUdb2wEnzAobjitgxn6D1IN/PD086zRPYVMDZ0wiJT24Kv8OJMKyOikS0FboBtuiYzC85cNt7XVj0h6t4EaUR/OXtjFDO2mBQaYFrUtaWepn0daGwD5GN9vraZYC4mPrscTV49OA6KDUUOZUJM51VaAwKrZpvk4OvGoJr5Z22+tIMu6DNK10PjqbODg75sHEnoJof9rOVpo0JIknx1Of4Vt/O4F5lzfVMT5O52DgoAYpkFZRQgHhAeovXKCxp2M+/LCcaULA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqyhpGsXt9gZ7ts3L7wiVPADZIJZZiUm4g3ov4+7hFk=;
 b=bRMlYGKFT6kZhgwiuyr93dGpOdy00i985dCdvubtAKdItDyISdgwLa3rvuKY0+6VH/FhuTlcro8YAaXpfGfySwc1B9aiMQ7IUVD8N+ux/thP1P3i7VbLwozim4VjTH0x1syQ2CRjrSLOItbVOHKiy9PR/2QsWbz4FmDhnDbmik0LokjwDbzPwUWu9JdTF3faTI9bYRas8lPq9D0XdVSKSdirJlEp2A+crBfkhtPA0QfCNYjDfAFrJgCs//gfVzM8cLFX8aQhTNatPiSJF248HCgj5Ze6x+YFetfUp0gpt3wUWBhQQNBJqrtmSmRXJogRptuP4zYRQOMd5DKo9Ke5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 0/3] Enable swupdate targets in
 reproducible check
Thread-Topic: [cip-dev] [isar-cip-core 0/3] Enable swupdate targets in
 reproducible check
Thread-Index: AQHZpdvXcWwtjjd/r0C5e6dsBr23pK+Yda2AgAAY3fA=
Date: Fri, 23 Jun 2023 16:27:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55426E11837823C188D6DC1AA423A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
 <920059e0-642a-f83a-de35-937dcd4f4e06@siemens.com>
In-Reply-To: <920059e0-642a-f83a-de35-937dcd4f4e06@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TY3PR01MB11409:EE_
x-ms-office365-filtering-correlation-id: 9e3f22e4-c06d-45e1-0bcb-08db7406c45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w//JYXm0eGFaeq2YoXZqgvihyblcOVuSdN9SbhWI5O9F2/yC520uYebnRg7n8s/6t7/2WiKiz08BHPCkkDedxseHA8lomE2CvPgjoUQaQWI42OROBuBjevsashGHnJEHf/IxWy4xku50eyR41xDAtzUs13/65paDrjMvlkHjF/LmgsoVIHbFpx3Pxy0CBtrH07X0CmMA2nSbWPFEyGU15eFWh4FqKuhFLwfMYTaocKyR0HgqOyFEA1Efe54I2jZRiBNofp9vSR/EYEeuzHW66pNyg3SntkODA0yUynGRQEJ6pi4Ole31HiwptuW28LTpq4/CFiotoGELJUHuj2W5dIxsvcBt3fjxKMQnWa1h+3Gg4qr9dHs743lXyLLKFMlOYuoaJd/m7+vy1RPa1BdzZDPjwYahAyKZYqeBEnUolgK9u0iuE7qPPDr8hzaSps8eKliKhN/E+u9KaZQnwBmgxWscpTFpQoh+ssaoeZjln7ZqUtf/1FX8mPRKTwJSROrqt16mCYfg+HlogSG8USQvRCowTRCkIoJDxX4ivjsJL9sonityjgqzyJtoEmmuxmqvL38I1rU7oqcw6woNP4r8vcjeI0aggz/38BfiJq+4Kjo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(55236004)(38100700002)(83380400001)(122000001)(55016003)(6506007)(26005)(66574015)(186003)(9686003)(52536014)(107886003)(33656002)(2906002)(5660300002)(8676002)(41300700001)(8936002)(71200400001)(38070700005)(66476007)(7696005)(4326008)(76116006)(478600001)(6916009)(66556008)(64756008)(66446008)(66946007)(86362001)(316002)(85182001)(54906003)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bHJpVnB6QXNHanhyK1dCTVRONjR1SXFVUGFYVjdIL1RsR3hJbnBidVl3RXZO?=
 =?utf-8?B?OENJazhmU3lvczB3WnNrWnhCNzMvOEtCM3J2V3I3MjNyTCtNaWxyZmlWQkFa?=
 =?utf-8?B?NzVUNGpacTJ2K01aUXJvOEdVRDdwcHArS1MxNUdRZWhPdkoxMzltYWtYTFVC?=
 =?utf-8?B?T1lpRVVpQlBSSWdkM04zc3dscmRkVzVyN05OMmNxT1RSRFdVSHdMRG5idWho?=
 =?utf-8?B?OEExVis5NjdrUzdRT1JDN3dybytSNFlrdTFTTnZxZ2FybG4xMDN5VlVKNU5X?=
 =?utf-8?B?bXRyTGJmc3U0ODBscHo2NU1VU3JCdXVkeERubmxiN3lMYk1WV3l5d1R3VkFJ?=
 =?utf-8?B?L0FTeGdETUpWSEFGUmxFYTI0MS9JV280NTM3NmNTUTNwT0VuY1hiUzZUR0Z6?=
 =?utf-8?B?L3RZZWd6azUxMXA2QWluNVYwOHp3QnRzWHY4Sy8vQVh2dWRkOXA2V1Y0KzJz?=
 =?utf-8?B?amoveTFEaG5TQVlEVjBPbmN1WWFwRllPTy9sTUlNSGZxUjRJL1hsNEg3VDRX?=
 =?utf-8?B?UlVyVUc3a0RLd1M5SmpBM2hnSnRVVEVZczl3N1I0MWFqYm9EeWVnYXg1Nmhp?=
 =?utf-8?B?S1VKcm9jWmJZMWFDRkZndUZ3N3JWbDVINUk1U1V5QnI5alVVOHdDall4TU9E?=
 =?utf-8?B?VUxBNUhIOGd4VmlwbWFYSzVpMzNIcytta2k5cWtpTmxiMzNCV1grVnkyTGVM?=
 =?utf-8?B?a3NhMWk5cWw4akhwbnFMK3Y4eXYycERwSzYyRHl6T1pRMnpVRVVza1JlaEh0?=
 =?utf-8?B?OFF6MzBFUGIzaVYwWGFNWE9kWVdZcDZqb1l3WjJJak1pZ3Z5MXpHK2pUZkRo?=
 =?utf-8?B?Z3V1S3lXdmFBVjNPeEd4VkxNbndrK2k1dXZXWUVSa1BXTS9OS3pIYnI4U2NE?=
 =?utf-8?B?WGJQVHlaejNSUnRyS0lDK2pNRUdFbVlaV3dyQkJNNy9YTzNqMmU3blg0Y2dS?=
 =?utf-8?B?M0lYVmk0bDJGRnpkQklLMVFBUnZNUDBaRjl3MnhiNW1TKzNFVXc5T1h1Y3pk?=
 =?utf-8?B?OTZKMVl5SFBrcG1pbHJTSGwrbHorQWw3cDZRMDNKVkt0UEVnMkZRM2xFS2RF?=
 =?utf-8?B?WkFYOUd1NDN0Y21MTUlXdmpCUXNEcGkyM05ZVXR5NFF3dml5YzBCRm1xYkQr?=
 =?utf-8?B?QWhiT1h6M0x5M2JOOVRkYStqTHg4bnBFdXo3SGtZbVA2WkFCQXZyMW0rQmxB?=
 =?utf-8?B?dXRyVUNuQ3lUSUpMZW5uem4rYzM2Y1p0Z1E4VW0wSEQvdnQ1ZXYwRGNTSXJJ?=
 =?utf-8?B?Wk45R2hKTC92bzFKeG5PVjkrZmp5VGZYWEJwTlFONWxpZ2g2dkRXcWYva3Va?=
 =?utf-8?B?S3FhNFhhcTloTzJZajhpdDZCTjlJSDcrSFVQMC8wTEpzaDhJSTRkdVN6UGNo?=
 =?utf-8?B?MHRIWlpkbUgrQVJGSXAxZjVnOUQ5TkpCbU44ZVlyR3oySWphZlQzZHBvVFgx?=
 =?utf-8?B?N2lZbmdFbFZsOS9KUCtSOWplT2luclVZSnFEaWkrclBINS93eDZER1N3NGVW?=
 =?utf-8?B?ZExLR1k2VUdGU2gyT0pqWHVYQ3V4am5qZVF4THU5eDdERmpwbVBJallOOFBS?=
 =?utf-8?B?YTBvTHVsSUFWQjVET08vQUpMNmYyUWM3a0JISnY4U3hIN0RRb3NkTWdacGM3?=
 =?utf-8?B?L2RUSDZwdHo3Z3QrTXNrM3JXMEtCME42R1AyY1QxaXlaeVFOKzZ2MHFDdlpE?=
 =?utf-8?B?OHBHTDZmRWJ0Zk9ibUl0eWNnK2wzTk1ubkxFUmtyWURIdFBITGJubWhlZUZn?=
 =?utf-8?B?eWxHUEF5cWhsOVdFMEM3NVBhYkQzenBqazUwcVBaZEJiTkUzekhMSmxvUHhY?=
 =?utf-8?B?ZnlOaUFtSU5VOWhCa0tPN1VaZm5RV3pXbnJ6SThCWnRvYkhjSEM4NzBpZE5j?=
 =?utf-8?B?eVdHUEdSL0llUnVYRklDdndmcEJiM0RyRy9oRitld3pjVy9XcXpaOWNjY3Vn?=
 =?utf-8?B?Q0VhaWRJWndXdlRhMFJ0eXFyTlVZT1huVk9RREdETUtyZ0dMU01ueWVkdzZO?=
 =?utf-8?B?eCt1S1hrelAxOWRwelFHOWg5MUVQT1ZlS1RXRUxHWFZTWTRmWU5YaUZzTlMz?=
 =?utf-8?B?YVlLYTg3TlB5QjB6d25oUHJOazRieHVsSlBUS1pkM0o1VUtrSDJ2UDVuZHZn?=
 =?utf-8?B?SEYxRUFiM1pPbXpNNE12YW1wWVd4c3ZQd2dURWtJVklmRjh6dzZkaFlpeTg2?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eAMva293kfi9eKrzK55ILD/fQxucJCCyJpWpPYdmJtZkedDUnKekpGK723+XmCCyZ4y75wBuV+DHZHUAMwV1oQFeUXgGbnKGh8ZVv287BvFZ6otLptIN0sH2mfyQeqZQ9WIsXWHgHy3Cfc5EeBlig8frTcL6Z6q+8z5OkQcTqB4nWv2ZcWMd3cWX6ulZ0dIpQtWbpuvLm9qAe48xf9eDSQ2gZs0SwnPnHiU5Iv8z2sNm7eDgSVd1wDWuoUS3KSLFhSAkMYnGJ7lURqlIY6MMq45cInQKXvZ72kXb9EyHYfXEUe2y3fWUq0Zod2RuUI4KnE0Qjo9jgLUk9RAgmjTRVjgNWOMk98//4e+SYWoW+evVgasZzTEIomqxZx/g9a53vC8ipReo24NEYJxpitHR7s1It1y5sc23KHzdWet9ti8vAflWKsxizmXo+wCNK4cjP0prdTOJAKCjtX5cY2lCxoLnVcJh+t/RHMwVv2f1QYVwcf+Qpi+b5aahGHCAXOedab+IP3thsTIy06nt1vaQGJHsPhGI05NTCaaPhNFt6YS5r19hEBebuIpyzBXEiTtTooqpqoJI9XUs++J6Horf2sswC3C/akbONbJzA8awVhZGQmqxj2OHRny7WtboUyUf3WN2lhrSZQhS/qpgUl0PiDsM1wiacDY6Z5ZPWtp/8d2N+1x7Tau/0f4+FlTQA8DFGJGqYCZAadDfYgPR0uxWPlHX7cs7SvBAOhzE78D1UdULLvtSb2HM5tRdaio4KlM9TE5ABIatYpIh//YdBml3BEl7htn1ddrQJF8zcKMQ26VOMUHVqbD9rfQta0qzml4Q
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3f22e4-c06d-45e1-0bcb-08db7406c45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 16:27:41.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKnLtaztz3JVu9t+EtnnJ5e0Pkic7RWCODADZNkAAzjT9aa9uvqZa1BuCMPcMQ1j2f2RZGcGIkJLaCLPVvueL7wbSmRZR0NnkYT332n6L4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 16:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12149

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogRnJpZGF5LCBK
dW5lIDIzLCAyMDIzIDg6MTEgUE0NCj5UbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlF
QyBPREcgUG9ydGluZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj5DYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5
YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDv
vLPil4vvvK3vvLDvvJQpDQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3Vi
amVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSAwLzNdIEVuYWJsZSBzd3VwZGF0ZSB0
YXJnZXRzIGluIHJlcHJvZHVjaWJsZQ0KPmNoZWNrDQo+DQo+T24gMjMuMDYuMjMgMTY6MDUsIHZl
bmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxh
IDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+DQo+PiBIaSwNCj4+DQo+PiBUaGlz
IGZvbGxvd2luZyBwYXRjaCBzZXJpZXMgZW5hYmxlcyB0aGUgc3d1cGRhdGUgdGFyZ2V0cyBpbg0K
Pj4gcmVwcm9kdWNpYmxlIGNoZWNrIGFuZCBlbmFibGUgaHRtbCBvdXRwdXQgaW4gZGlmZm9zY29w
ZSB0byB2aWV3IHRoZQ0KPj4gbm9uLXJlcHJvZHVjaWJsZSBjb250ZW50cyBpbiB0aGUgYnJvd3Nl
ci4NCj4NCj5BcmUgd2UgcmVwcm9kdWNpYmxlIG5vdz8/IE9yIGlzIHRoaXMgdG8gcmVzb2x2ZSB0
aGUgcmVtYWluaW5nIGlzc3VlcyBzbyB0aGF0IGFsc28NCj5odHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2lzc3Vlcy8yNCBpcyBmaXhlZD8NCg0K
U1dVcGRhdGUgdGFyZ2V0cyBhcmUgbm90IHJlcHJvZHVjaWJsZSB5ZXQsIHRoZXNlIHBhdGNoZXMg
aW5jbHVkZSBzd3VwZGF0ZSB0YXJnZXRzIGluIHRoZSByZXByb2R1Y2libGUgY2hlY2sgQ0ksDQoN
CkN1cnJlbnRseSB0aGUgZm9sbG93aW5nIGZpbGVzIGFyZSBub24tcmVwcm9kdWNpYmxlIGluIHN3
dXBkYXRlIHRhcmdldHM6DQpTcXVhc2hmcyBmaWxlIChodHRwczovL2NpcC1wcm9qZWN0LmdpdGxh
Yi5pby8tL2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzQ1MjkwNzMxNzgvYXJ0aWZhY3Rz
L2NpcC1jb3JlLWltYWdlLWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQuc3F1YXNoZnMuZGlm
Zm9zY29wZV9vdXRwdXQuaHRtbCkNClNXVSBmaWxlIChodHRwczovL2NpcC1wcm9qZWN0LmdpdGxh
Yi5pby8tL2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzQ1MjkwNzMxNzgvYXJ0aWZhY3Rz
L2NpcC1jb3JlLWltYWdlLWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQuc3d1LmRpZmZvc2Nv
cGVfb3V0cHV0Lmh0bWwpIA0KDQpJIGFtIHdvcmtpbmcgb24gdGhlIGFib3ZlIGlzc3Vlcy4NCg0K
Pg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2Vu
dGVyIEVtYmVkZGVkIExpbnV4DQoNCg==


