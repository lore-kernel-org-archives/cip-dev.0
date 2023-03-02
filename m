Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99769C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 09:10:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.10912.1677748234609180711
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 01:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 3229AWmI020193; Thu, 2 Mar 2023 18:10:33 +0900
X-Iguazu-Qid: 34trpHMSkXFHXjhJRN
X-Iguazu-QSIG: v=2; s=0; t=1677748232; q=34trpHMSkXFHXjhJRN; m=SOulsVgDD3grDrFTR672RebAGaRcgigIH/fkUH+TnzU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 3229AUuT019872
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 2 Mar 2023 18:10:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdBuQcYNM+FQ96Iaw2QFRuxhvOkWZ5E5SzGjlLw9s/r3nOUOAZ02oZ5eZaSqPlyOnNYn5NH1XaKE7fchBVQjq82sIeyZbJuWB88LPJPEWbgpYU8JofRxFiNr4cxHYX92gmXVR0jojlthP1tv1uXWswfX70X14FsqhSYEawrHrN6qLdV+sRSH5vvnfWJwc7Met1qEM2cj39n9j3ihy+oay+JA2P0Etix0zUZ6ftLw0C5yi5CpCbmys0u0IAp6MQ6na4iXfTTN5CkLIaakDRUcvJ8Z5CIxHMqD9E+b3uhA+OVCuO36/a7NK3CNyvqd2nhzaWoDxqNwobJIRsDMFMBV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPe6zvU4xAHVoEC3n5MEUMM0Slg5OqqG/B6jQbQ3fkQ=;
 b=W7Ay6uqG4y+vdGP/0T4PPphu5pT6F33+CECaItbDnFXLYyh98txIqMBY1dfmmsmaQAUXfy5TKx1NRNrd5+uPvdeH+XCZdofhyRyzYXot/3c3YrFstv8GJV8NXBWD8IXUn5B8dBz726W7Uh1GbmZS58+4yc4KbIEUaZ3Famk/YquytUND6k3XsdUwpFE6gaFhyIqiLSgiUjlF/mPKskElEHDT+9fdEXNE7oVuvKyDK4CzBMZOQuhnoVt1c6xGL6z8nOpL4T8eCyzj7Ly/ofdMVOhRJTqr2MFE9spHr43aEkOrvkSkIcUbpQAPo8np1LGWtltxLWe4al3JUBCPQ7Or6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] isar-cip-core: Heading for a release cycle
Thread-Topic: [cip-dev] isar-cip-core: Heading for a release cycle
Thread-Index: AQHZNVfLai4Fm+W2TEiFBYuqrJzud67kQTgAgAMgNcA=
Date: Thu, 2 Mar 2023 09:10:28 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB8295ABB0D0C78AF1C418CB6AE1B29@TYCPR01MB8295.jpnprd01.prod.outlook.com>
References: <56d6a637-5654-7923-4f47-e76b554d578f@siemens.com>
 <9b75d165-3fef-f2d8-2d79-72e952aec8d8@siemens.com>
In-Reply-To: <9b75d165-3fef-f2d8-2d79-72e952aec8d8@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|OSZPR01MB9633:EE_
x-ms-office365-filtering-correlation-id: 1ad150ec-5f9c-4799-5ddd-08db1afdf781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvgGojiyLHw8zRa38A9YDRUC2OSXrFYkjb5I+ScGELWtVF3PW8CpmEs68pknnmZSZmWPcLfdQGjrdz6MOPLKqZWbzoX1yRM6BDCpHUmpKrl/qwPhpWV3NohQTBXuXW6+y4X3Z+7M9SAQ4837DtSwLGqtBExSmhcoqcRyT2B3Ceift50C/WJddpAJxgUA8ZamMqVfWkHwogT4dNz/gf3lCQfeO2BP+YCItjWRvcVmZ67mnlg5rwZUN7V4xKCm+ShfYBdRY/3+5jBhN1sYDDDBWkdiOY8+E77X6hNghRx/EjK6+zux786FOr2LoCY7EVKcSiFIIskS2v/kv/WeY6fx+jkc8iUj8O3sHkVgyW2gIJtVjioKt2cNz/KmAIvHGIqq1p6AmUdqKOPXCZgPK3DOFGQjF472oEPkU7gYQ0BDjCyYmsUXUP1kiOZHCpTpX7jraN53psYVB2C3Hu5fwjc5BwwssJnlcfr9InjDRNHMdvoLjBcOtVY+DmWQS5ugptjH8hdhgaVY/aI340/tftCnaZmKrCp0Avs+4R3u6seC0W9sIHMMJ/LtjF6uiv1hMAVwu1aQw2j19+OfjAzVoKFf3KReqlxPHmRdgHBohTg79nkFaeE280vsc+oed0F3eICObWzXdBQcAYRQub1xeO0kSJNOdj08Guu5t8eHY76SAekiocdBe5RSYnggYMOMA98EVu6I+8Yu3zs20EdZfolkBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(66556008)(186003)(9686003)(122000001)(38100700002)(38070700005)(71200400001)(2906002)(86362001)(52536014)(478600001)(316002)(55016003)(33656002)(7696005)(6506007)(26005)(6916009)(8676002)(64756008)(66446008)(53546011)(76116006)(66946007)(66476007)(8936002)(83380400001)(5660300002)(41300700001)(66899018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZJL1lUL3ozck1lbXZ0aGdiemp4YSsrOVJMeUVPV1AzcXBUQytCK2VOMVBZ?=
 =?utf-8?B?bDN0eE55emhCbjl4UWhLd2lLV2xPOGZHWDZ3anpnblVXQWZjekJDR0tKTkk5?=
 =?utf-8?B?Z21pKzByNmRUZnQ0L0IvVGlvQTkwYTNUcFJQR3Ira2dqZXlNTmhqeTFRVHE2?=
 =?utf-8?B?YTFLZWYrUFRFYVc2djNFM0hpZE5oS01hdmkzZWhhbCtQTjRFMGtYaHRRdEp4?=
 =?utf-8?B?ZkZTTHdDY2N4dWoxZjJlN1kyOFJHTGFoUWgxKzdzYkhwSW5wM09CSngweThE?=
 =?utf-8?B?eFJoNXJJM1dXYmYyVVpRNHFoZVhiblZ0YUtrQ1ZaenVRSVhDMEhndVU2bDhp?=
 =?utf-8?B?emxSTlBXaHI1RVVJaW82bWJiT1lCd0xnWjJvdkpYQXhOWGZnNVZXWUc2UEhJ?=
 =?utf-8?B?WmVoSlpBNE91U2Y0UmQ4YWh3WWdObGt6Zm43cm9KRWF6RDIzcFB6QWtXZnFv?=
 =?utf-8?B?Z0lzc3dEMmFFWVdLc3NOdFVuMXBMeUJYVEdQenZsNFJCcldCUlJDNWN5UTZL?=
 =?utf-8?B?RXNlSjhxOXZPTmREcnM2c2NLNGZwcWp4U0ljSGJ0Mk41MzFSbUM4elpFOEN4?=
 =?utf-8?B?cWdxWGhQSFpWOFlGY3FmeHpxa20zYXVmbDdOVkljd3BYRXJiWFQyeEVPQTBa?=
 =?utf-8?B?ekh6cGplbDRTY01LcXVRM3lySXlxb3h6c2N4b2crRE1yMzdoaFEwY2JxczJP?=
 =?utf-8?B?MjJwNzREUjVIT0UzY01CYTVYL01FbUFIelY3TXlGbFdhZDcrck5wZGdBZnZ2?=
 =?utf-8?B?Y2tiNHZZRTY0VHBtZ0twc0ovRTYrSWtHRGRHRGRwRkpvL3hTcXNBaGZrTWMx?=
 =?utf-8?B?V2dnU0lEQ25lSXVKVVNpWUI5OHpGM2U0a29LN2huS0RrUlRERkxZQlNsbTVI?=
 =?utf-8?B?MnZTZXQ0bVp5L1BEcE5IS0s5dmdjZEVKazZsNVJCQmphZ1k1ajNycmV6eFVW?=
 =?utf-8?B?TUdjcTBBWnM2S242NHhiV3lqdHdjT0d2ZStQTlQ4WlJNdjNGUFFEbzFUR1Rh?=
 =?utf-8?B?ZHFQYnFqWG1ZV3AreXMvSERiYVhnUHM5QzNsOW1uQU4rMEREQ211dXRXVWZR?=
 =?utf-8?B?UDNnLzUrVFZQemZSNVJzcy9JVHR6L2NWWkNTbk1zbWYwaHFFT1EzZ1htYnVv?=
 =?utf-8?B?WC8yM2k0L0hFbFpBT1gyZVpwenVBUTJxM1V4bVhycWgxQXY0ekNhWHVEU0xL?=
 =?utf-8?B?NDl3UkcwVzhVRGRHVXMyQy9jYkdERUZQNFJkSzExU0I5WEtoWENCMDNsTWtu?=
 =?utf-8?B?TEpDUTduOTRLRHYvNHF0TFFFR0oyTS80RkVFQnhEY253N1FVV25Hd1dDMHNm?=
 =?utf-8?B?aytHVHFhd2RRYy9iWFZ5R0RnU1o0MWN0Qmc1U2JneXNaZW5vZEptbzRKWnJK?=
 =?utf-8?B?RDBBUzYrdTF4WHd1RXlXYkJGeWFqRlBQU2VBL2FnQzRIWDJoekUwNmdzR0ZV?=
 =?utf-8?B?ZzM3bzhuSnRkSEJlRGduN0NLdzhCWEhoY21Jd0tXY3pwWkhDbThHZFpMeGR6?=
 =?utf-8?B?ZFdEUU52YVh3YVJrSWhJSDNETThkeEhzSVkvNnkxN0F4RU9UYmdydkFGdTg5?=
 =?utf-8?B?TFBMY1VTSE5CVjhZNmJGNjkvb0ZqWkErUkJoeDN2OERZamN3T2RFdlZEendx?=
 =?utf-8?B?NGJScnZIRmd1d0lxMXE3RlA4TkUxdTByeFBBdldUMWFOZkY0aGU1UU9GMEZU?=
 =?utf-8?B?Ylo4eVV5aWhPaXBnM3NPTmpmQWhlUVF5QVlVcnZFNWFldk5HTzdJS04vTXll?=
 =?utf-8?B?T2x5cTBFNXRWdURNQ2M4dUJsdGdwTVA1QmRLTjMyWjlsZXhxSWM2allrdE9F?=
 =?utf-8?B?TWFaMmhHT0lEbkNQc2J3a2duSENuQW1NdEhkbzBLcFdpT09odzBOSEJvSVRR?=
 =?utf-8?B?TjB1OVdEclN6aDAyN1hFU2YzbEtPRWtDT1gxSHY4bFNtV1p5RU5SOVQxcklQ?=
 =?utf-8?B?ZWZGajdTNnFPOXRxNGxjRjRBcktEY2hPRDZ4ZWNLSzFvQWZuZWtMM3dVM3pw?=
 =?utf-8?B?WGZCMEc4cyt3QWFrSVFNQXp5ajBRMGljY2JvbnIrY0c2c0Ntbjl6WDBnZk5Z?=
 =?utf-8?B?L2JCNVNQeXlPY014cUZQN2x0ZFlYNFQ0SmRRNVF2aWczUFNlODBnSzlvcDIv?=
 =?utf-8?B?ekNyc1J4NkhtdHRhbjA5d0F1RlB3K2R5bzZPNFY4dFZ3NkFtdmI3UW5NK1BK?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad150ec-5f9c-4799-5ddd-08db1afdf781
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:10:28.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO1CGlGO5Qk/IwOHD3bfirFuQ1W+6YJPh7QNpFV4AhvSPtrQQwBm9+pZh8pz7vsBLxAh/xvNqa8CnTxCwSINwf1HdWr5AUYpXFCYO5U/QBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9633
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 09:10:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10873

SGVsbG8gSmFuLA0KDQo+IE9uIDMxLjAxLjIzIDEwOjM4LCBKYW4gS2lzemthIHdyb3RlOg0KPiA+
IEhpIGFsbCwNCj4gPg0KPiA+IGF0IGxlYXN0IHNvbWUgb2YgdGhlIGlzYXItY2lwLWNvcmUgdXNl
cnMgYXJlIGluIGEgbmVlZCBmb3IgZm9ybWFsDQo+ID4gcmVsZWFzZSBvZiB0aGUgbGF5ZXIuIFRo
ZSBwbGFuIHNvIGZhciBpcyB0byBmb2xsb3cgdGhlIERlYmlhbg0KPiA+IHBvaW50LXJlbGVhc2Ug
Y3ljbGVzLCBtZWFucyBiYXNpY2FsbHkgaGF2aW5nIG9uZSBldmVyeSAzIG1vbnRocy4gRmlyc3QN
Cj4gPiBvbmUgd291bGQgdGhlbiBiZSBhZnRlciAxMS43LCBsaWtlbHkgbWlkIHRvIGVuZCBvZiBN
YXJjaC4NCj4gPg0KPiA+IFdoYXQgYWxsIHRoYXQgd291bGQgbWVhbiBmb3IgdGhlIGxheWVyIHJl
Y2lwZXMgaXMgdG8gYmUgZGVmaW5lZC4gQWxyZWFkeQ0KPiA+IGNsZWFyIGlzIHRoYXQgd2Ugd2ls
bCBvZmZlciBzbmFwc2hvdHMgb2YgdGhlIERlYmlhbiBwYWNrYWdlIHNldHMgdmlhDQo+ID4gc25h
cHNob3QuZGViaWFuLm9yZyBhcyBidWlsZCBvcHRpb24uIEJleW9uZCB0aGF0LCBJIHBsYW4gdG8g
ZGVjbGFyZSBhDQo+ID4gZmVhdHVyZSBmcmVlemUgYXQgdGhlIGVuZCBvZiBGZWJydWFyeSBhbmQg
b25seSBhY2NlcHQgZml4ZXMgYmVmb3JlIHRoZQ0KPiA+IGZpbmFsIHJlbGVhc2UuDQo+IA0KPiBS
ZW1pbmRlciBhcyBpdCBpcyBlbmQgb2YgRmVicnVhcnkgbm93Og0KPiANCj4gSWYgeW91IGhhdmUg
YW55IGZlYXR1cmVzIHRvIGdvIGludG8gdGhhdCBmaXJzdCBpc2FyLWNpcC1jb3JlIHJlbGVhc2Ug
aW4NCj4gTWFyY2gsIHBsZWFzZSBwdXNoIHRoZW0gbm93LiBJIG1heSBncmFudCBzb21lIGV4dHJh
IHRpbWUgdGlsbCB0aGUgZW5kIG9mDQo+IHRoaXMgd2VlaywgYnV0IHRoYXQgSSB3aWxsIGZlYXR1
cmUtZnJlZXplLg0KDQpObyBzcGVjaWZpYyByZXF1aXJlbWVudCBmcm9tIG1lLg0KDQpJZiB0aGUg
U2VjdXJpdHkgV0cgaXMgcGxhbm5pbmcgdG8gbWFrZSBzZWN1cml0eSBmZWF0dXJlIGF2YWlsYWJs
ZSB3aXRoIGJ1bGxzZXllDQpvbiBvbmUgb2YgQ0lQIHJlZmVyZW5jZSBIL1csIHRoZXkgbmVlZCB0
byBiZSBpbXBsZW1lbnRlZCAvIHZlcmlmaWVkIHVudGlsDQp0aGUgZmVhdHVyZSBmcmVlemUsIG90
aGVyd2lzZSB0aGV5IG5lZWQgdG8gYmUgdGFyZ2V0ZWQgb24gYm9va3dvcm0uDQpEaW5lc2gsIGRv
IHlvdSBoYXZlIGFueSBvcGluaW9ucyBhYm91dCB0aGlzPw0KDQpLYXp1DQoNCj4gDQo+IEphbg0K
PiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBDb21wZXRlbmNlIENlbnRlciBF
bWJlZGRlZCBMaW51eA0KDQo=


