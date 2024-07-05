Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB50C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:23:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.12151.1720164226554851531
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4657Nhw0605999; Fri, 5 Jul 2024 16:23:43 +0900
X-Iguazu-Qid: 2rWgkjIBWV5jOj81ub
X-Iguazu-QSIG: v=2; s=0; t=1720164223; q=2rWgkjIBWV5jOj81ub; m=HSW+5dhUGF/j21ZMwhY+9OUqyMb7ZH1RhdxMmnoPomc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4657NgAl3433036
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 16:23:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6f+7IbW0sC6f8EiDGmRwdlOOt4+AaWzUn1X5cloc1Vm8usDSGw7kjemuSADrTBf5r2zj+HiBFaA6W4KyNi7HbO4Nie7H45khuGbxLrXUU/tkv5QmsbtVQ7eu0p+J0pGirByz9H3ACLj7fhoy4HaSB555Le4mRIVHYCcGmPVFXsV3o3YoCgaE1pUO8oS7ZMY+CNCOQkwq/pwMaF2UQx5GrlaqCxTBwSW3Myu6SF48W3T8djF2lQuFt8mvmyPdSWt/19nXtaIoo7w89dOsSYnv5P6wUXBU1UrYJcJlJ49wdP29vmWms+qYzk708QOkprtHX+jYYcellZ1St+bkg7hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO4y+VDRfZC+DWkgvRHHSdp5cV9agVNqEMnPA2a/Gcg=;
 b=IjF+ot2qNwLzt55/nqcwf2CaLTerIiiNAPZKokG4xB76Xn5d53c32CF9bn7u7M9zMB6vA/Cc5093KxuMYGqXMfzOCCmcoixQ/UnNtltrbOm4MF3UHulCZpfXyg0gTG45d5IlrckpLcYvBWyLk1kJ1ZepaNBCMJsl0SZrvD6INHjK6WddbeQpmnM4WGswRntHUjRmdmxQKmBQgifhVTBERxVsecZycOvojHecl7IHPX5X3d8dS2EpGtPjjoxtc4wSPO8WmRKMU6tv9ZgN3l+rzpGOX7vjDNiuIoi0cXAnOs4AgC+Bwe5aeO/cklqEzqFh9vMtcyAsBfK4JCI32DEiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Topic: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Index: 
 AQHazfoVk99fsaMHdE2T5O7XjqyfgbHmXT/QgAC9bYCAAHqNgIAAFUoAgAAG/iCAAAk/gIAAAFaw
Date: Fri, 5 Jul 2024 07:23:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110759B742A4217C518ADA6C0C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
 <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
 <TY3PR01MB1107551C9D25C7CC82540F20EC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <6845d328-860d-46eb-90ce-b994da7c3508@siemens.com>
In-Reply-To: <6845d328-860d-46eb-90ce-b994da7c3508@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS0PR01MB5682:EE_
x-ms-office365-filtering-correlation-id: 08330935-0e2c-4306-9a38-08dc9cc36486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M01EV3NFYk8vaTFBaGJCL3lZTS9mVml0S0JnRmRqbzlMbkZNVWN2cVI2VXh0?=
 =?utf-8?B?WU9YT0l3WGhEYmFvbVlmZ0t6UVp3UFVpdkFOWDZOWnlVVzVEYUVkQ09MSjkw?=
 =?utf-8?B?RE15a3hQM1pSUnVrTzdiREZabmpxMVZETXp6V1lIUXNOMGlqUUdYenFPODVh?=
 =?utf-8?B?OXRRM2NQTG5KcU9BdVFuVmVzck1UYTNXWk10NlJBTFo4bTcxK2FVVnUvN0dj?=
 =?utf-8?B?RHpXa2xsQUNtT1JYdDk4ekxzSnlCc3RhT0o0WmQyYWVQbDF6M0tYcytYdXJI?=
 =?utf-8?B?WHZjZnAvMy82YVVuYW5taWNUeXRpN1M0TWkvK3YrWERsQVVpQ2NSV1BvWENr?=
 =?utf-8?B?dkpGWU0zRVhUWDhZbTJkZnAzL1JmUENkM0dxRm83cTRjQUplYjBYOFBlUlE0?=
 =?utf-8?B?ZU1JbEdkY09OL3dhMmJRVkM2QmZOOTBXY1E3d3FzY3M0RmdzZXVSQ3NkbXBt?=
 =?utf-8?B?WUlUMGFjc0tLYkpIcWsxQXlTZG5XWU56bGxHNW5OeFJENllmTVYwWGNpM3I4?=
 =?utf-8?B?aS9GaDE3MWtycHZYd1F1SkIwVXVldW9xZURDMHlkWnJXNDV2b1U2N3dxWUZh?=
 =?utf-8?B?cUdQR0lZU3hGN08rdjVXdnNGWjZNcC9PUzZmcnA3dzU4VFlHNGUzc0FiQmJN?=
 =?utf-8?B?bFJDcmhMYmFhaUhtNVkrblkyUWZrU29nRWkwZzYrR0hUL0Vmb1JERm5LcHA3?=
 =?utf-8?B?VjA0OTdBUktTenJock16dW1jbFNzTW9DRmdyMFo3ODlkK2hIcllIOWx6Q210?=
 =?utf-8?B?eFc3cmJFRTZxU3YrR04ySWxEUUdnb3Fxd3R2dzgxa0tsVEViVjdJdjc4d0p3?=
 =?utf-8?B?bG9QeEZlcjl0ZExmeFhILzYvTTFSekVqZlo4c2J3dWFhbzd2RHN0VnRNT2JD?=
 =?utf-8?B?VFErRHJuV0o5MURZVy9kVmlPSi9SWnhVeHcrdXVpMGd4enFpMFFTUmVzbXBr?=
 =?utf-8?B?RFBUamt2QkZFVmFCMWZGSFBkK1RYa2N2VVprcXFxRmpydHFaYnIxN0dEQTNq?=
 =?utf-8?B?UjNWSjlYaWp3dHNmQmpEdzJucUExblgrYXp5NW4ydzZzUGdoZHBWT0RVUDd5?=
 =?utf-8?B?dnBUdWpOWGtWVExlWlJvVGxLRjBVbWsrcFR5VDBXcjdLVXhlSTAzeUxqU2ZL?=
 =?utf-8?B?cXV3dVZTTzZGV0xQNHFXclpJN1ZIdCtCZ0ZEM3oxSEJyeHgybnYrK0p3eEkv?=
 =?utf-8?B?a1I4MVNDTmg3dzNzRXp3dWQwQlllK1BoWUwvSWpNRnBWZGdaMkVFRGc2ekV3?=
 =?utf-8?B?K1dpdWlHK0ltVWE1THlZTjNmM1N3K0lBRFF6Q05jWmc5ZUZpZzNKcjNoOU5W?=
 =?utf-8?B?b0taY1pkT01Na1NXaWw2NURQZFpxM1lUL0s3SVpHTGdRMVdkbkFkeDJhWGNY?=
 =?utf-8?B?Qkg0VW9pVHR4dGJ5eVRxWVFaeTkwVGdJdk1HMFZaSStJMjBKSGVhVXBEUUd6?=
 =?utf-8?B?c2tDaTBQVVVtNEMrYzhpMUVZcXlhYmRjUFFaZGFmTkQxVHBrYWhqYzd4RFJF?=
 =?utf-8?B?alV0NC92dTRNdFdzc200NVdacXdFOGp6TWl6aUNscjQ1a0hERkdmQVd3ZzRn?=
 =?utf-8?B?dmI1bllGN05PcFJwOWJXWm1wdWl1VS9hTkZjTHIyM2NZdWRmeTc5SVRSdENK?=
 =?utf-8?B?M25RbEhyWCtvWUc2MTdwbkxQVjg4bzFscXVNMVBNMm01dFlmWHJkOVJWRUV3?=
 =?utf-8?B?M1RrY3dMTCtNU3BRYjNjeDZpSC9USjJ2dmM5UE9JNUhqcVBHMWdEZExyTThq?=
 =?utf-8?B?alpaYWFKQ3IxQ1F3MTZySzNySUZpK0s3c2toM0JKdWQxVmVxbXROUS9ySW9L?=
 =?utf-8?B?Qmc3eVQrbERGYXFzaHlGZmMza0h4SXdYYWJ6bmE2YW1RS1VRRU5NRDF0bDJC?=
 =?utf-8?B?LzlSZGxpK2k0a0c2SWV5Z3RzV1ZJcWxOMWtOK0RaWWpiaFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHFtN3c2UXhuNm5pTkVNYm1sWjZVUGtmMmNaWllFWmlLVWVaTGVoOGN0OVp3?=
 =?utf-8?B?SlBYZTRJN2dBcnlKOFZQSUpvUVYySE4rdVBNNm4wRTh5Um1sK1BXOW91clMw?=
 =?utf-8?B?WVUvR0ZZanB6ZE5VRy9IdkNGKzREMHZDTldDcTU3VTVmL3VYdVZkdVZ3WElF?=
 =?utf-8?B?UmdEdGc5cUc2NC8rM0VtV0dpUFlMSzhFQ05sekExMzJ5ZU1pVW1HMFlvc0ZG?=
 =?utf-8?B?c0lMS0pYNTZ2NWswdGxsbVZsaHNlejFhWjdOTHZzL2UwYm44b2dqUEZTRm02?=
 =?utf-8?B?YkRiV1c1NUEwdHI1THlyeVVwNFlnU2lhREVDdUR1dm9UdVJYd2JnZUo0WTdV?=
 =?utf-8?B?NW5Nd25DekxkKzNzTFVnYTdjU3YvZlE5NmJpT1hpamd4NFhNOFZvN0F4dDNB?=
 =?utf-8?B?NXVhbFZlb0k4aVpVWVpPbHpqb0RDWC9VaWdxZzdsUy9Na0EzbktQVWNTT05n?=
 =?utf-8?B?d09kWXo0OTJEOFVrMnNTbk9BK0pWSzh3Ym9xaEQyZ3F0bFV0ZnhCdm1ZeTlj?=
 =?utf-8?B?NnRud2FaRnJ1TmxFRHhVeVNCQTZINDZydlpxNUtqMlpNc05kSmV5TVFGV0Nw?=
 =?utf-8?B?MTNQd1BLb1A2M0xmc3FSbkN0UzZRWFl2WlowMEpHMlJuN0h0U1drSUVTRkt3?=
 =?utf-8?B?UTg0amhBQTU2YmhBZ2lHWmRXaWNUV3duWlNSVTVtVm52L0ZVTStQV0xGV2Na?=
 =?utf-8?B?VGFFWTdPd01iUjZpVGllQW9FYVhUNGtUMmFkNWcrQTFvNU5XRGlQZWxxUjRS?=
 =?utf-8?B?RjlRaVh0L0dCYnhtbEVubnFlcWpCUUxJc1FiamFTOTB5dGhQMjF3ZkRmbWxp?=
 =?utf-8?B?VDZ1VkI2RmJpcXVUYlNGRHJNazRHWUJuRFZVekthN242K0NoWUlTOEN2LzZ5?=
 =?utf-8?B?eFlIdG1tRURNckNZam1LN3RKNkZiaDRpWlNCZ1FyUG85SEkycjY4b3QwM2Q2?=
 =?utf-8?B?TjgrS2ZNTkxBVlBIOHNud0tKR1JGSnpTUWZyTmZFTHRoSmRaMkMyT1VlM1dy?=
 =?utf-8?B?a3RzVmRKMFFhYVNiQ295eHRVbSt4YkwzYTJSZld1UnU5a3Q5bW1pZVRDcDA1?=
 =?utf-8?B?Rk5UQVpvSFZyWXNuQnNsNitNdjAvVkdyeGc3YVU2K3JMbTVqSFRsQ3NORm13?=
 =?utf-8?B?VHlXRlhucUxjSlhoWmZSZkExNXBtUENwd1NaSDJIZUl3VzFmWStoSEp0cFhR?=
 =?utf-8?B?T0lnSHBkTjk1bVNrR0R4R1pIcjBXMHdXeGRwWjlKSnpnd2xqM0RHSDJJcDN6?=
 =?utf-8?B?ajJLdHNHZUxUd2dzaEYxaHN0WXVxQ2I2RHIzdnYvaytuU1RzRHpRTVp6Ujkv?=
 =?utf-8?B?NVd4Yjd1L3JiV3NuVysweGNueExHZnI3QzIzYWRycVRrQW4zWnBvRm83bFdQ?=
 =?utf-8?B?QUEya0dWTmhLN1MxK1lweHJoWTBqRXdvWk1PTVFybnRXWmJ6blMyVlBBakVY?=
 =?utf-8?B?NTRiQXJRand5RTFMaGZaSHJweVNuT1d1ZDU0ZStVZzFsZmF1ZHhSa3pvZXk5?=
 =?utf-8?B?ZkQwVklBOG12cmcydkxWZVh4TldNUjA4RVdSN1RLOHNxYlFuZWxDRjE2Vm9w?=
 =?utf-8?B?MFNPT2U3N1IyZ0ZSM0hWMmJPWktUN0pMWGtaMzdhanREWnBWRXQ0S3ZVRkR0?=
 =?utf-8?B?ZlpUNDBYODB2WXppYWJxZVpYV2pxMTNaTW9hbm9RSTNNWURyL1I0OVQ2elpS?=
 =?utf-8?B?UUp3OVRUMlRHbGpFQTM3L0diQ3JqMWs3TmthNUdGZ1hCUDNOYStkdUVnWWdN?=
 =?utf-8?B?aFR1dGhHcGtPeHNmTmJPVEpUVU10T2U5ZnphaUlXRDZWbDdxRHloaElPUnNX?=
 =?utf-8?B?WHVWaGUyaUNuYTF0NnFyTDhsU2VNQVRxbXNSaDRBTjF0RUJqTWZrSGp3Z2VG?=
 =?utf-8?B?SzIweEpBaC9RZ2dEcEpJSVM5SFhDbzlVWlRZQXhJQWFiNG1sTGw5Y1c0OURX?=
 =?utf-8?B?RmZRVW5RdFNraU1KMkFTQzB3NHIrL2JnRWpFTHFFSjh6bUdhQlNFNUFGOTc1?=
 =?utf-8?B?djZhTFliQ0YxSGQ2RXoyZFI2OGdJSGlQMVhwb2hNa3BGQ01wY3lZNDZWOFpB?=
 =?utf-8?B?V0RVK2dMd05pV0prUVpkcUpJRkhIUUFYZTRTYTVURDdMencxbFpBazdVWXFX?=
 =?utf-8?B?b1l5cm0zN3hMUWJ4TzlzcEVtMVFaZTJDSlpXWkEyMS80WWY5c2NRYzM1dmpa?=
 =?utf-8?B?bVdEQVduMklxWXY2VnRXWnhTbUMybE9vU0FxdDJmSWs2MEFCWVpROEt3K0RT?=
 =?utf-8?Q?U15Z5OTkOq7xGJXLJ7qovgiaYMBUQkNxpyLIej8q7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08330935-0e2c-4306-9a38-08dc9cc36486
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 07:23:39.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1xx3aHaKaZTUyzIh/GgYsDkjrQKtdwIxhN2DRg32K/xsmUUnmVJM2VHwuba0WFug+a7PJMoFbG0Gi6Bpd+PfQAMH9XXfidcUFuJkWbOuxrcKmHan37cG99WvosqTYHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:23:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16385

SGkgSmFuLCANCg0KPiBOb3QgcmVhbGx5OiB3ZSBzaG91bGQgc3RpbGwgc2VsZWN0IHNlY3VyZSBi
b290IGZyb20gdGhlIHNlY3VyaXR5IGltYWdlLiANCg0KWW91IG1lYW4gdGhlIGJlbG93IGNoYW5n
ZSBpcyBzdGlsbCB2YWxpZD8gaWYgc28sIEkgd2lsbCBzZW5kIHRoZSB2MiBwYXRjaCBmb3IgdGhp
cyBjaGFuZ2Ugb25seS4gDQoNCmNvbmZpZyBJTUFHRV9TRUNVUklUWQ0KICAgICAgICBib29sICJT
ZWN1cml0eSBleHRlbnNpb25zIg0KICAgICAgICBzZWxlY3QgSU1BR0VfU1dVUERBVEUNCisgICAg
ICAgc2VsZWN0IElNQUdFX1NFQ1VSRV9CT09UDQogICAgICAgIHNlbGVjdCBJTUFHRV9EQVRBX0VO
Q1JZUFRJT04NCiAgICAgICAgZGVwZW5kcyBvbiBUQVJHRVRfUUVNVV9BTUQ2NCB8fCBUQVJHRVRf
UUVNVV9BUk02NCB8fCBUQVJHRVRfUUVNVV9BUk0gfHwgVEFSR0VUX1g4Nl9VRUZJDQoNClRoYW5r
cyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiBGcmlkYXks
IEp1bHkgNSwgMjAyNCAxMjo0NyBQTQ0KVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp
77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAu
Y29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y0
77yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5j
b20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KW
oe+8re+8sO+8s+KXi++8re+8sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+
DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlXSBLY29uZmlnOiBSZWZhY3Rv
ciBLY29uZmlnIG9wdGlvbnMNCg0KT24gMDUuMDcuMjQgMDg6NTcsIFNoaXZhbmFuZC5LdW5pamFk
YXJAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gSGkgSmFuLA0KPiANCj4+IFRoaXMgaXMgYnkg
ZGVzaWduOiBXZSBkbyBub3Qgc3VwcG9ydCBzZWN1cmUgYm9vdCB3aXRob3V0IFNXVXBkYXRlLiBX
aGlsZSBpcyB0ZWNobmljYWxseSBwb3NzaWJsZSwgb3VyIHJlY2lwZXMgYW5kIGNvbmYgZmlsZXMg
YXJlIG5vdCBwcmVwYXJ0ZWQgZm9yIHRoYXQuIFRoZXJlZm9yZSwgeW91IGhhdmUgdG8gc2VsZWN0
IFNXVXBkYXRlIGZpcnN0IGJlZm9yZSBiZWluZyBhYmxlIHRvIGNob29zZSBhbHNvIFNlY3VyZSBC
b290LiANCj4gDQo+IE9rLCB0aGFua3MuIEl0IGlzIGNsZWFyIG5vdyB3aHkgc2VjdXJlIGJvb3Qg
b3B0aW9uIGlzIG5vdCBzaG93aW5nIGluIEtjb25maWcgbWVudSBieSBkZWZhdWx0LiAgICANCj4g
DQo+PiBPaywgaXQncyBnZXR0aW5nIGNsZWFyZXI6IGthcy9vcHQvc2VjdXJpdHkueW1sIGluY2x1
ZGVzIA0KPj4ga2FzL29wdC9lYmctc2VjdXJlLWJvb3Qtc25ha2VvaWwueW1sLCB0aHVzIGFscmVh
ZHkgZW5mb3JjZXMgc2VjdXJlIGJvb3Qgd2hpbGUgdGhlIGtjb25maWcgbWVudSBzdWdnZXN0cyB0
aGF0IGl0IGNhbiBiZSBkaXNhYmxlZCBhcyB3ZWxsLiBUaGF0IHNob3VsZCBiZSBmaXhlZCB2aXN1
YWxseSBieSBzZWxlY3Rpbmcgc2VjdXJlIGJvb3QgaW4gS2NvbmZpZy4NCj4gDQo+PiBOb3csIGlm
IHlvdSBlbmFibGUgKG9yIHNlbGVjdCkgc2VjdXJlIGJvb3QgZm9yIHRoZSBzZWN1cml0eSBpbWFn
ZSwgDQo+PiB5b3UgaW5jbHVkZSBrYXMvb3B0L2ViZy1zZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwg
KGFuZCANCj4+IGthcy9vcHQvc3d1cGRhdGUueW1sIGFzIHdlbGwgYXMga2FzL29wdC9zd3VwZGF0
ZS55bWwpIG9uY2UgYWdhaW4uIFRoaXMgbG9va3MgcmVkdW5kYW50IGJ1dCBpcyBhY3R1YWxseSBo
YXJtbGVzcyBiZWNhdXNlIHRoZSBzdGF0ZW1lbnRzIGluIHRob3NlIGthcyBmaWxlcyBhcmUgYXV0
b21hdGljYWxseSBkZS1kdXBsaWNhdGVkIGJ5IGthcy4gSnVzdCBjaGVjayB0aGUgZWZmZWN0aXZl
IGJ1aWxkL2NvbmYvbG9jYWwuY29uZi4NCj4gDQo+IFVuZGVyc3Rvb2QsIHRoZW4gdGhlcmUgaXMg
bm8gaXNzdWUgaWYgaXQgaW5jbHVkZXMgcmVkdW5kYW50IHltbCBmaWxlcyBhcyBpdCB3aWxsIGJl
IGhhbmRsZWQgYnkga2FzLiANCj4gDQo+IFlvdSBjYW4gaWdub3JlIHRoZSBwYXRjaCwgc29ycnkg
Zm9yIHRoZSBpbmNvbnZlbmllbmNlLiAgICANCj4gDQoNCk5vdCByZWFsbHk6IHdlIHNob3VsZCBz
dGlsbCBzZWxlY3Qgc2VjdXJlIGJvb3QgZnJvbSB0aGUgc2VjdXJpdHkgaW1hZ2UuDQoNCkphbg0K
DQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


