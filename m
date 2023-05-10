Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB4AC77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 06:58:37 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.135])
 by mx.groups.io with SMTP id smtpd.web11.10431.1683701913676094071
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 23:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pWCC6V2p;
 spf=pass (domain: renesas.com, ip: 40.107.114.135, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEN2IRgDyQakhIZS4fSX5SCTyVgbvJnzqezxDMlR+Vg1YfYFQPIPrZZVktMQzrH3TC8SFn1WN/mTzYIFlWlgeXkhYGTpFS5wlvSC54HA3QKqIgRqXRT6wHuCepoMRdR054N9OqtVFIdp4Kr97fIs3kYONi5u2O2oojJs6R7rbid91jEFQ/Me26Oy+lsQiWTzVYpZN/uXLh9XJDlmhxTdcg0kxlQvK3tBrznSyidwaThdEhCR27eFPIQJ7zbdUxqEjeuBFkpt+ggQdT8Z9t2VLsh5IM4iEF+3w+VG0yKtP1nbQmBHVLSt5e9Uoagjwo3EXNpE84P4ghFrfwb9kNbfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYpmhY0+ntasiBl8+Pwg1/PlTfY8dNZbm4IFGiXy+UE=;
 b=fDdLCx4vfg7bAuct4MMPvrIML5HS2JJILG66rQ6YVDYAnuTDx/qJOqYV4G3M6n/LkcO7XLT1R4WZ7vJmJFsKpBcIjqKnMvH/e4TjAWL4Fn+QNQPsBIETd2fgiX1I0y7iwM7bOfcq0VP2vrrC3PLpU+lcPuaYim/QOuFY4IwzMf38MELsL1vUluGPL2gDqXzqoSrHWnOrKcucPrySs6tYHsmWpRTr5zNS0sAq6NYfCeZRFhcvZINt2XA+B1gv7MBxOqZ9h+DGqGGdsZvt7g8cHx9EPEWc81llo1Vkmjq0j+7WTgsysWaPjn006d+WcRaMZ3SUzhHpZGB9vz18Tdy7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYpmhY0+ntasiBl8+Pwg1/PlTfY8dNZbm4IFGiXy+UE=;
 b=pWCC6V2plW/4A8gULvQmcCzrrLf+JcqDCe/hhn5bOG80GfcJJKPNhFWKqMoDGZtT9OlAvzsTIX3FOR8DmstpYH9hoCmkdom7LOv8he3FhnK/GLv5kmzgQb8SPCtt7tJylc/AuD7lz2jci4wbrl5+3ejzQAQtGQbx6QlsHCjLqEQ=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB5599.jpnprd01.prod.outlook.com (2603:1096:400:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 06:58:29 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 06:58:29 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht <uli@fpond.eu>
Subject: RE: Size limit in the cip-kernel-sec repository?
Thread-Topic: Size limit in the cip-kernel-sec repository?
Thread-Index: AQHZgkEC40jacwRpqkqontinFPUAda9RvUfQgADVkwCAAIFyAA==
Date: Wed, 10 May 2023 06:58:29 +0000
Message-ID: 
 <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
 <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com>
In-Reply-To: 
 <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB5599:EE_
x-ms-office365-filtering-correlation-id: 087594af-a8f9-48c7-e3a6-08db5123f5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lOwbi8cZ5/Av3g5evXfRXLTghzSgjWVW1dV5JZEqzUMMxXoQq02HMkrlgkQHQ3FRoqCMqExwkPPnQlucLYiW9o9Q10v6rkd4YrGJeEbNWbEzIfLWSAnw/9s2QCdf9OV9mC6k+kkOMO7o6dAsDX6vfv8cYqitrTSR8+EjxVmkj8yGUUxWKoZXTpjqqapFxHR4HjH5k0pmJhBXkgAYXW4vQuzsPRCcCppNA7ycyY/Q8CpnGjYXzaXoa5u1lwPlIB2eVVeAaMbg9lfh6Cmmcp0DDaI2KkFiZudgf8mKX28BjnkLFR+f+aB5Bi4IgaCR4MEMgICuOO5fv7bZqPWa39Rvu0JIEiW0VY+RC0+b/YmSOSnKvlW1+E7rYGrV3Cy8I89k61d6VMNQkd8Duh9ZdruJe0rfobImcRXTVFNKYlyaKlU3US8n/qM1NqO90blgqoXoSgwd5NRNbm7N4giYhQezZr3VVodapG32/UPt7VInwcq4yTBzBjHmuarc40XuIiNEJ9EdmPyr4TeMOdCqg6JvH6VOsPidId33WCBvlmaUJoIaQr2B/vvQ6SGDrUsYVQQk/2q27FVh7khhaoEh3SLNVFgc1INtNDj3bai3Sc5ABaf+haHdLOLdkWcZ8Yl6nXOO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(86362001)(2906002)(4744005)(478600001)(26005)(6506007)(9686003)(186003)(55016003)(52536014)(5660300002)(71200400001)(38070700005)(7696005)(122000001)(38100700002)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(41300700001)(316002)(8936002)(8676002)(83380400001)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K1JwZ3RSVFNQOHUvOENaSzJPYVBRSlFtemxwcHhyNlkwdzlweCt2K2ZaS0dN?=
 =?utf-8?B?aHFJV01hYWZOaUF3dm5tVVpzenVVY2V2SlZmTjFnYno1aklDVHVSN0hadk5y?=
 =?utf-8?B?a1ZRTDc1djI1S3JrL0EyRmdwbGh6TERYTFByL1hMNlFpY09DU1o2TVloU0V3?=
 =?utf-8?B?VFV5WVJqbU9JT2k2ekpibUlCQ0ZaSlBwd1hnV2ljNU16TW9ETzExTXFaTUQ5?=
 =?utf-8?B?cW1abllydEYwZjZZUGdxVFZzUWk2WWt6RHUySy82dVVlWlpnd0l3OUs5T2Vh?=
 =?utf-8?B?eXFXYUwrbVhEN3gvMHh4UzA0S1FBTzFKK1NEaGlocHl2WktyNHFnL3BXWUZN?=
 =?utf-8?B?dFM3RXFhOFJoNy9zekhBUExOZFdYVWdVNTYzNjFnMVNBaHN1MFdwTlhXQitz?=
 =?utf-8?B?dWw5UWpUZExjc2lrWVlVbG9SZDRlT0ZpQmEwNEdRU2kwbXRpbkY3c3RrNWlr?=
 =?utf-8?B?d1hxemNzbVp6ekU1OG5YWHdtUEZqZ3IvM3ZYSGFVRGdYVWpGb3pjcHQzSlF5?=
 =?utf-8?B?Zm5uZm1sWkhITXp2Q21mRzVlWVR1aEFTUjhiSGVRNCtpcW9kNUt6SW4rbStq?=
 =?utf-8?B?OExnSmFvY3FTYWZDUk1aTG5VV1cwSm4xcERST0xQemdScW5RTUl6aWxsY3d0?=
 =?utf-8?B?ci81azhEdllnWFQvdUhXd0tMQnNPbm1JMWZRL29UWlhhcmRDTUhMc1dMUHdV?=
 =?utf-8?B?TDRxbkZjUkI1cndhR2lNa045REwvM3kxeCtxTFJEOFNZc0ZQcjJDWXNkWlg4?=
 =?utf-8?B?ckVlYURkUzlacjEvd1BqNVlHaTcyWWIvK0c2dERWdGw5blFRdERIbkRVRTNW?=
 =?utf-8?B?dHhwV0hob3BCd1p0ZFo2TmpsdWFYR05qQ2x5SEd5N1p4L2lUQ3pEWmx1WDdv?=
 =?utf-8?B?U2ltcnVGY2l4K2VFbFhwTXlEWDEvZWg5cG1pVldwYkkxZDdSQVZqdUN5YVkz?=
 =?utf-8?B?Y2hzVXo4clI3UWdMVWhLTDVnZXJoM0Q3MG9xR0pTYTlDaE9qTGFGZ3RRU0tl?=
 =?utf-8?B?WENNMjFpQmdyOStqVURnZUJYY3FaR01sT24zL0JpUmhDcEZSdDNLeUVORWl3?=
 =?utf-8?B?TFJYa2pUaHdpczNGTWxjOU5TRHdlK1c4VDFUdlR5N2ZveGFnZFR6ZldCUlo0?=
 =?utf-8?B?QlBBc1JOcVZXTTRxaFZzZDR3WDBQV05DUmNaU3Ruek92Sk9rVnFzTWJaQWdB?=
 =?utf-8?B?TnRmeUpSZ0FXTmRON25jdWFxK2hiODZjWjJlM0Q3V0huODdNT2Z3NzJKbTZw?=
 =?utf-8?B?S0FGZmhHWFh2bnNIbSsxSi9Fcy9zcGdha1dKWXN2bzZtbVljSGphSkdtOU4x?=
 =?utf-8?B?aHRCd2NaN0g4amZtb1hnN01GUkdqTUVrRUlJUUpJZndLck80b3J6aVRhVFR0?=
 =?utf-8?B?NWNNeGVKWUcrM1hrcmo5SSttdk9OWGJMSDNTazBwN0xPQkhpL0JzMDlLS0R5?=
 =?utf-8?B?WFB3Rk45dUFXV3dQbzkyK3M4a0haNWozLzBTZnJNaDIzbGpGRGJ5alRnWjBM?=
 =?utf-8?B?em4wTE5uamxES01HaTdRTVU2bjFydng5RnRxVkVPMFNteFJ0SzRsL21pbTky?=
 =?utf-8?B?cTYvd3FmZjdiVGdEeHozbjMwa0xHSVY3T09zZG8yTzI0cjA2QlBwSFhrT0xE?=
 =?utf-8?B?blJGOTJESUtYcERVcnhJc1FnN2NMajVmUTlBa2N6NDdRNGQwdWlKYUQ3b2hm?=
 =?utf-8?B?Q2pYU0ZxaWxhbmNLSGdxc3J0ajNZOVlWUGdYdUJhbDdCRWZNZFgrSnpyQ2lt?=
 =?utf-8?B?QnAzMDJCQzlIRUJGM01VTkFhemdWR0VYMTVsd3pQS3E3b0srUmxUN29OMlZC?=
 =?utf-8?B?aFJTakNNSzVQMUd4WC93YWVUcUVqL0tIQUx2NTF4UXdPbGJoMDhpQXY1TVJr?=
 =?utf-8?B?ZVQzdmNiN3ZENnEwNzVsY0xWV1ozdElNN1ZSVXN5SVdoL3JIYXZoSjM5MjNz?=
 =?utf-8?B?aHVUNkZVWk0rVUlteHpzNzFRdUpRNmFOZHBWaWJ1amI1TGlLS2wvcGp3cnFI?=
 =?utf-8?B?S0ZneEVPSUtSMkxFQXJsbGlXY1h2eUhyRXhSRkU4S2ZsOER4ZW5ydDNtVlNx?=
 =?utf-8?B?VW95OHBGS1ZNMllzU0djT3NwWEllT3Uyc2RiM0RadGhpVFVmL2dsQk93QWpr?=
 =?utf-8?B?SVN4YzJiRkZMOWlZWkwwL0ZvSUx4MFgwNGprZFRrRFd2anorY093dXl2VkZ0?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087594af-a8f9-48c7-e3a6-08db5123f5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 06:58:29.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bU+KqIUSKJG2/RmbkmCXasRCRTYssq32uhHMYQ02rjzyhwfPZilH9xn0MBmj8tL0fEzGyQL64oKXtUw7t5Hf5hMu3EZl/J+K33DvQz3DnMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5599
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 06:58:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11428

SGVsbG8sDQoNCj4gRnJvbTogTWFzYW1pIEljaGlrYXdhIDxtYXNhbWkuaWNoaWthd2FAbWlyYWNs
ZWxpbnV4LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTAsIDIwMjMgMTI6MTIgQU0NCg0K
Wy4uLl0NCg0KPiA+DQo+IA0KPiBUaGUgd2FybmluZyBtZXNzYWdlIGRpc2FwcGVhcmVkIHRvZGF5
IChUdWUgMDkgTWF5IDIwMjMgMTE6MDk6MDcgUE0NCj4gVVRDKS4NCj4gDQo+IEVudW1lcmF0aW5n
IG9iamVjdHM6IDEyLCBkb25lLg0KPiBDb3VudGluZyBvYmplY3RzOiAxMDAlICgxMi8xMiksIGRv
bmUuDQo+IERlbHRhIGNvbXByZXNzaW9uIHVzaW5nIHVwIHRvIDQgdGhyZWFkcw0KPiBDb21wcmVz
c2luZyBvYmplY3RzOiAxMDAlICg4LzgpLCBkb25lLg0KPiBXcml0aW5nIG9iamVjdHM6IDEwMCUg
KDgvOCksIDEuMDIgS2lCIHwgMS4wMiBNaUIvcywgZG9uZS4NCj4gVG90YWwgOCAoZGVsdGEgNiks
IHJldXNlZCAwIChkZWx0YSAwKQ0KPiBUbyBnaXRsYWIuY29tOmNpcC1wcm9qZWN0L2NpcC1rZXJu
ZWwvY2lwLWtlcm5lbC1zZWMuZ2l0DQo+ICAgIDkyZDY3OWY1Li5lZjFjZjFiZSAgbWFzdGVyIC0+
IG1hc3Rlcg0KDQpIdXp6YWguDQpGWUkgSSB3ZW50IHRocm91Z2ggYW5kIHJlbW92ZWQgYWxsIHRo
ZSB0YWdzIGFuZCBicmFuY2hlcyB3ZSBkb24ndCBjYXJlIGFib3V0IGluIG91ciBsaW51eC1zdGFi
bGUtcmMgbWlycm9yLCBhbmQgc2V0IHRoZSBtaXJyb3IgdG8gb25seSBwdWxsIGJyYW5jaGVzIHdl
IGNhcmUgYWJvdXQuDQpTbyB0aGUgcmVwbyBpcyBub3cgb25seSA0LjFHQiA6KQ0KDQpJbiB0aGUg
bWVhbnRpbWUgR2l0TGFiIGdvdCBiYWNrIHRvIG1lIGFuZCBiYXNpY2FsbHkgc2FpZCB0aGVyZSBp
cyBubyB3YXkgdG8gaW5jcmVhc2UgdGhlIHN0b3JhZ2UgcXVvdGFzLCB1bmxlc3MgQ0lQIHdhbnRz
IHRvIHBheS4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K

