X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.6329.1657277838454117140
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Jul 2022 03:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shreyas.karmahe@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 268AvGoY003894; Fri, 8 Jul 2022 19:57:16 +0900
X-Iguazu-Qid: 2wGrayp4pGS73QkHLS
X-Iguazu-QSIG: v=2; s=0; t=1657277835; q=2wGrayp4pGS73QkHLS; m=wLIi5mal+YOGOaq8uuBqeNWP67idWquMCol2AutVU78=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 268AvEsi034755
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Jul 2022 19:57:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL0DscnujuhFJsm98AMBPxCnbTG0haA3Jl1oTwv/Qv9oY4jhLhkQcwa/PX66o83+bSR3eIepDUokhT4QoPlt2t/C7J/L8vKG2oDPQuz3ABfZCGbrjdarnOa+UpEOFDf+DFHwU36JzyGWHUCnI1lVmry4OCpfgb4PstEZNEijLGtCepohRMYn39PpETixhW2lvJSr7P/5znSldaGG+TLIUMdqvTb464Q7+utSjnmZQ98ZczuOkTDC49U1pb1Ff1u1QeFFs3Z4kjIY2pCckOspHnwJNJENRoK6wN7Na9gavuvPHAdQ7y8K3ejWbMU7D4M/QZJFcOI/7tmfCL9qsquXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVjuXy6AKUxEmjcrdy/wioh0alqXI0Tvkp4vI3ve3OE=;
 b=Ge/DL1+Rmqw7UhrQtzAxC5m02vemZPy2hkagRTPhE6zGXQ10SvNdujgmMjTioZ+oUzZn96Js6tpwk+GGXikEe0ZTiTvuqZEMy0rHSowLQQCY7vmMhooAvw1SXHhWVHvZK+RfR1wFDWeZF/EjfZTP07OyiPzPugkRWH+MLP6/Wctpl/X7VJNaU3y1IDfOaQBfWdyLZqS5uRq4NWyab3GC5QrOq43/Gkt/ozwB10sJVjU+seqZaISBSqiDza/2bgkU6lOVv10zKqRAQG6qM/Y3QnjKUcHihMK7efPaqkHbti8Tq0Dy3dTqPsj+Gv5Zz9O9GX2pvfi9QgywnSjUwJEfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shreyas.Karmahe@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core] cip-core-image-security.bb:libpm-google-authenticator debian package
Thread-Topic: [isar-cip-core]
 cip-core-image-security.bb:libpm-google-authenticator debian package
Thread-Index: AQHYgljIf13Dld520USYg4tDfKXqua1Tse+AgAc6jvCAGX8YsA==
Date: Fri, 8 Jul 2022 10:57:12 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB8877BF7C94A43323C2B5E53CDC829@OSZPR01MB8877.jpnprd01.prod.outlook.com>
References: <20220617144440.1846381-1-Shreyas.Karmahe@toshiba-tsip.com>
 <36fc490e-dd45-2922-e7cb-6adb5f675877@siemens.com>
 <OSZPR01MB88777681FCA17016AB061AE7DCB29@OSZPR01MB8877.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB88777681FCA17016AB061AE7DCB29@OSZPR01MB8877.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2640f88b-617b-4420-1fc1-08da60d09cec
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtIt99632EepUZU57Jx6oxlanQIT0OqjJKKzDV99hBbqOkihVFjSlF9Z+vVow+YF3aNepm86vj7aMfvKYrd+wCqIwfVA8XFh6MqN879EHSp8aomaLgnZ2sEvwwS3vosL8Nl2rUYUNXH+ozNHSXbxhLzbQDaWFF7XBsQXb6SXa1VwLDK7ZgKqmmihJihW5JlAptc8Z2mA9Hw6p6+qO4lxbEauifFpABiFfr7ZyDRn/T6X0pMPwM3LCjJBKE7XRsH+6avYP7fqsWdDHhpczn55fbl3ZoV8dHDnhWHUtYfLC4BcJWIN3T06en6vXa8vBHDpuQJuS39FywJJ7PCfOmXbG8MNP9CbYUa5rSioAVgnmZ7nVTTjZnxnyXjuHhjSOZM5B0ihDq1r0ue+49iSokFN1VvUWLTgjHKxFtcKDoX87ryAtT1YMmxNwvtYGZBMPr9mHsLCHkYPB8TNpqYtsFyQrscE3SqroJJ649Van5bLYaJNHYBFjPTYBzt1JbrcBOiG9A+gQynT2PGR8NGkWtKgjLtNj1SdYovW8U5GJuI49Vk/fGWuBUkyelF0roMWqbeeIv79+mPXWL49nasPRWNbsZ0XqE/331OeCZ9KiSw4iCH29jMsBnqz+aJLvW5bwbcxZLaF0buXx5qWVEb4N9Py8At9VDyBXdXt2KFV06Kaq2k/xIeXGMw2hBXfVw3LWNTzRUGFeOIl5jnS90tBY14A+X5D+mngHTSrxvEXr2DpVpcHEQ4fuReuAOkvCVO/jtyDs1jh4Nm1oMXVI2GBgzcWoTZ1vZIaqvVerXX3jbmktCVaDzxFF0oaLdAnslxl8Ee6798nxzswZD8qAtjimdtZMlBb6fpYUXx8CYnLHSIoiZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(66556008)(8936002)(52536014)(38070700005)(2906002)(9686003)(33656002)(8676002)(107886003)(122000001)(66946007)(5660300002)(64756008)(66446008)(86362001)(66476007)(54906003)(966005)(110136005)(55016003)(26005)(53546011)(71200400001)(4326008)(186003)(76116006)(316002)(38100700002)(478600001)(7696005)(6506007)(83380400001)(15650500001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0tPSmRMdnBSYkc5SUIyMFVWZzgzWjJuVExnSVU5ekIvUUpNeTdOd1h5R1hw?=
 =?utf-8?B?bGVqclpnU0ljTER1dDJlSm5YWG5sWVo4eWljd0FEazZsQlRpSlRVdXhhR2V2?=
 =?utf-8?B?WHJNam80bUp1WEtVK3gwdDN2empDOWlJK3U5bDdYMW1zZHIybGg1bVhMNnJt?=
 =?utf-8?B?SmRMY2IvamJnbVBFa3pqcFpaenkzSHV5emEwSzFUZHBoT1NhVkpoODcwSElt?=
 =?utf-8?B?MUlQOHh5V2ErM05FMXZZNGZNS0dqMWdhdDJJKzhsTDdYbGl5a3VpK0lhNDNC?=
 =?utf-8?B?NUIwM3NPdzBzZlM2ajFqQkphNTZIKzRtVmJHdWR0RWFjd1hrSUYzVFcwdU1n?=
 =?utf-8?B?YlRVeGtDSTFpMnkvOWNkTkV0Z3lmNEtzdDBONjAwUFVyRnpzb2VIcmMvLzZq?=
 =?utf-8?B?c0Q5cytRamdaa1E3cndlckc2ZFRQMWdXRlhBZ1lyTkxXZ1QvSWtmVlVneFRs?=
 =?utf-8?B?OW01Z3VtenErN1JiMjd2NUp2MXgzMXNHVFJ4NlVWZFJ4MGgrMUFnRDEzMkc3?=
 =?utf-8?B?a0VnV0prTUpPejJaeFJaVFZNMkh1clFCVWhub3dldkRKaE5RMzFWWnB1NXlu?=
 =?utf-8?B?eTVpY3ZvT1RGbmcyVE1lMUdXYVpzVGR0U3hoVmRmQm1GeS9ScXg2dXBpODF2?=
 =?utf-8?B?YnQrdklqandLOFgza0k5QmpaU2pVaGlEN29tNDRMWWVDSXVjVjRWTmlocWFq?=
 =?utf-8?B?aHB4Q0dmN0RLYXpYaU14bHphVDVxR3RDY0RMdDZIQzhDdFBjaWhJTlVVUEdR?=
 =?utf-8?B?d3QzRW4xMUFzMlErUVU1ZFVQcm9JY004bkt3WHpCTVZYc2FsLzBNMTB6RlFX?=
 =?utf-8?B?emNtR3JQSmNyNk1Md1JUN1k3WnNyV2dwYnRpZm5jWDB4eWZUTkFDZlFDdlBB?=
 =?utf-8?B?Q1pIYzVsQTdteEE4ZzBsaTBmZkhFeFFMa0VxYnA0UTV3em5yVm04Y3JKVXR6?=
 =?utf-8?B?TVRDK2NaVno4VytwazIvVmE1NUNLTmJHV2ZYQ0RySWs5NHJRWnNVTlBHUVl3?=
 =?utf-8?B?VFdWYXBZSmcvS1FEeWt3eU5sMlVacFd3WXk3MTlmand4SjJaT3Zaa3IyOHY3?=
 =?utf-8?B?UUFGWnc1aFoyd0VhTlcvWnZNdWZZaWlUeVNlNk1ibkJ2czlRYXR1aVRKYStF?=
 =?utf-8?B?L0wyQ1A5MG9uU0E3RFhtV1F0UHlhOU45c2VGYW1vSkhxT1R5SVEwK0lhdHM4?=
 =?utf-8?B?eVRkNmlMWEhkN2ZYSnJIV3RJeDhPQk4xSHJPa3FNZFNSa2tCRTdPb211WEtl?=
 =?utf-8?B?RTZRMVFaRDNCdGdvV2tUMVQxYW96Z2RmZGpoY2U4OU85TXo4VkFSWXFOWW9F?=
 =?utf-8?B?bzlEUWtZbzEzQzNzOW1mdFFaL1I3ckxwTitBZ3VaK05NUkNwUlArZmZzdHVC?=
 =?utf-8?B?TFpuNXhCdEZtOFd4dU91N1V4azdqb3hUYmUwazNrNG45Z3MzR1FxNDc4UGJs?=
 =?utf-8?B?UlZNYnFMOXpJUDlrZTRpYmNQbnJiSFhXZ2RZcUgvTm44bEUvREl6V3NTbStn?=
 =?utf-8?B?VlJ4djltVmFhTHB5RFFhcXFuWjlSR2lJN1ZGa0hxczJKSVdkWEhGbEF3THpl?=
 =?utf-8?B?WWJ4VElaSGl6VG9GVUd6RDRzU3dJSXVweWpMTTQ5OC91WEt5S2lxNU5NWEZF?=
 =?utf-8?B?MVZ4emdVVTNpWmpxNUJXbGpzZENLa2sxbWtVWEhrdWF2Ti9WTlFYd0MwQ09v?=
 =?utf-8?B?UWpVZjJjbEZybkl0UTlINGtMbjF3ZnJWZVk4d0d3WXJWenZhSmFmL1ZTWnQ3?=
 =?utf-8?B?SEZRUVBURUVLa3ROM0FBQTVzak5LaTA2UFQySEUzamwxN1NOOU1zcWQyci9E?=
 =?utf-8?B?RW8rNkN0ellOZFY0WnZVcHJtN3ZoVlBSS1RYNWpISjdOQ3pWeHlJbklyOElx?=
 =?utf-8?B?WWZOUkpXTXhjT1FuZUNJS2cveEdoNmhnbk9yUjJ0dEI1Lzd5Q1JBVk5BZUNL?=
 =?utf-8?B?eWoyMm5oZ09CYjhJOEZ3bXVFZ1pBQkVwV1FrOFdsOFRvUXk5a0ttSXRub1Yz?=
 =?utf-8?B?TDlwZUdIL3F0dENZNDE0M1lwNVNNSmxJSGhYcWhXc0ZpaTJBZXZ0bFVqZm1t?=
 =?utf-8?B?ekVCcXlqM1ErRExJTUpaN2xpV2I0U1lqYkJwZHFvaE4zWWY4dGkrTHYyRlZC?=
 =?utf-8?B?cW16R1BoL28yTGc1ZXVPOVUwK2k3czdLb3BGRnpOUGl6Nmd1eGYwMWVpelAv?=
 =?utf-8?B?SEE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2640f88b-617b-4420-1fc1-08da60d09cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:57:12.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjuLNFV4O1au4UwVVjIbEa+kXpUkN+B0mUmNwxNXHvJS6oARM6gxXbk4dq7JHDnY7iSyEeDwjXtDV45H2Ze8mS4o7ffwMdhkB7Y3dTrWUbU5UrnoqY6Ghao5nsLFqVFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8608
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>

SGkgSmFuLA0KDQpUaGUgY29uZmlndXJhdGlvbiByZWNpcGUgY2hhbmdlcyB0byB2ZXJpZnkgbXVs
dGktZmFjdG9yIGF1dGhlbnRpY2F0aW9uIGZvciBsb2NhbCBhbmQgcmVtb3RlIG1ldGhvZCB2ZXJp
ZmljYXRpb25zIG1lcmdlZCBpbiANCkZvbGxvd2luZyBNUg0KaHR0cHM6Ly9saXN0cy5jaXAtcHJv
amVjdC5vcmcvZy9jaXAtZGV2L21lc3NhZ2UvODYzMg0KDQpCdXQgbGlicGFtLWdvb2dsZS1hdXRo
ZW50aWNhdG9yIHBhY2thZ2UgaXMgbm90IHlldCBhZGRlZCwga2luZGx5IGFjY2VwdCBhbmQgbWVy
Z2UgdGhpcyByZXF1ZXN0IA0KDQpLaW5kIFJlZ2FyZHMsDQpTaHJleWFzDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbToga2FybWFoZSBzaHJleWFzKO+8tO+8s++8qe+8sCkgDQpTZW50
OiBXZWRuZXNkYXksIEp1bmUgMjIsIDIwMjIgMTE6MDEgQU0NClRvOiBKYW4gS2lzemthIDxqYW4u
a2lzemthQHNpZW1lbnMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBk
aW5lc2gga3VtYXIo77y077yz77yp77ywKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+
OyBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5Q
eWxhQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz
77y377yj4pev77yh77yj77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1
YmplY3Q6IFJFOiBbaXNhci1jaXAtY29yZV0gY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmI6bGli
cG0tZ29vZ2xlLWF1dGhlbnRpY2F0b3IgZGViaWFuIHBhY2thZ2UNCg0KSGkgSmFuIEtpc3prYSwN
Cg0KSSBoYXZlIGFkZGVkIGxpYnBtLWdvb2dsZS1hdXRoZW50aWNhdG9yIGRlYmlhbiBwYWNrYWdl
IGRlYmlhbiBwYWNrYWdlIHRvIHZlcmlmeSBMb2NhbCBhbmQgUmVtb3RlIG11bHRpLWZhY3RvciBh
dXRoZW50aWNhdGlvbi4NCkkgd2lsbCBjcmVhdGUgbmV3IE1SIHJlZ2FyZGluZyBjb25maWd1cmF0
aW9uIGNoYW5nZXMgYW5kIHJlY2lwZSBjdXN0b21pemF0aW9uLg0KDQpUaGFua3MgJiBSZWdhcmRz
LA0KU2hyZXlhcw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClNlbnQ6IEZyaWRheSwgSnVuZSAxNywgMjAyMiA4
OjMzIFBNDQpUbzoga2FybWFoZSBzaHJleWFzKO+8tO+8s++8qe+8sCkgPFNocmV5YXMuS2FybWFo
ZUB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBk
aW5lc2gga3VtYXIo77y077yz77yp77ywKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+
OyBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5Q
eWxhQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz
77y377yj4pev77yh77yj77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1
YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV0gY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmI6bGli
cG0tZ29vZ2xlLWF1dGhlbnRpY2F0b3IgZGViaWFuIHBhY2thZ2UNCg0KT24gMTcuMDYuMjIgMTY6
NDQsIFNocmV5YXMuS2FybWFoZUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBTaHJl
eWFzIEthcm1haGUgPFNocmV5YXMuS2FybWFoZUB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4gQWRk
ZWQgbGlicG0tZ29vZ2xlLWF1dGhlbnRpY2F0b3IgZm9yIE1GQSBhdXRoZXRpY2F0aW9uIGZvciBy
ZW1vdGUgYW5kIA0KPiBsb2NhbCBzZXNzaW9uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHJleWFz
IEthcm1haGUgPFNocmV5YXMuS2FybWFoZUB0b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gIHJl
Y2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCAxICsNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMt
Y29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gYi9yZWNpcGVzLWNvcmUv
aW1hZ2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiDQo+IGluZGV4IDNlYTU0NGEuLmU1NmQy
NzkgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2Vj
dXJpdHkuYmINCj4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1
cml0eS5iYg0KPiBAQCAtMzIsNiArMzIsNyBAQCBJTUFHRV9QUkVJTlNUQUxMICs9ICIgXA0KPiAg
CWF1ZGlzcGQtcGx1Z2lucyBhdWRpdGQgXA0KPiAgCXV1aWQtcnVudGltZSBcDQo+ICAJc3VkbyBc
DQo+ICsJbGlicGFtLWdvb2dsZS1hdXRoZW50aWNhdG9yIFwNCj4gICINCj4gIA0KPiAgT1ZFUlJJ
REVTX2FwcGVuZCA9ICI6JHtCQVNFX0RJU1RST19DT0RFTkFNRX0iDQoNCklzIHRoYXQgdGhpbmcg
Y29uZmlndXJhdGlvbi1mcmVlPyBPciB3aWxsIHRoZSBjdXN0b21pemF0aW9uIHJlY2lwZSBuZWVk
IHNvbWUgdHVuaW5nIGFzIHdlbGw/DQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9n
eQ0KQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==


