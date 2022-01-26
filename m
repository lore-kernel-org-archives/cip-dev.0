Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29032C28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 07:58:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.9824.1643183908508472741
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Jan 2022 23:58:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 20Q7wLm6001297;
 Wed, 26 Jan 2022 16:58:22 +0900
X-Iguazu-Qid: 34tKV35MdvJQSgjNf9
X-Iguazu-QSIG: v=2; s=0; t=1643183901; q=34tKV35MdvJQSgjNf9;
 m=d6+FdfgQt37VAysXQ/34YzA2hqigA1EjyfBg+A8m6xY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 20Q7wKdW001481
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Jan 2022 16:58:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5r5wAoF0lScTmwWX3qP6hOXpvhOM8RhaNH9f6Jel1EVOTz7rfiCncpYY/CenmnItDk6whKqM+LtitqypYln97erzmx7TTxvFOnDuQHFuNg1lPEph9PSQZfaCT3DMlfluBkWBC/ERbXrwgwq7TUbWPgMjQrqqbzGbbYakaKeD7qe1+qgobfl8hJUjh3rlTdfDY8NYEWHmqdYponqFI/Dn7iVlAWVri78VdTeGEAkaW1SGyGjiH2guHNQvYwra+XeipEaKcz/LPL3kNkT+jnMir3GZv74QR/loNjR04/dAMDrD6eAjv9mG777FT77g/epwCSbpoiKQ6NC1ER7Kpp06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98rhXWHC/4ffnmg2turnZiJFIF5/121PXwD9CikcDhc=;
 b=Tx+97ETeV31mf5W5zNnobqx3YFE0zpqr9UgzlIkwFmSjwc9Nyy53v3/xEzYqzaskleRJxlBNJ2mUC3em1NqxEUMPuQ5RmVHBpZ//jl/xlqa8fA3z3JiSXCJPZf9Wydu4pVs1pDeLnkq+8rJ3ARMZRzDGwhTaIag6yBk6WFN+HYIr3sx2eRWVcRHo7ZdOZSwrtDw2WINSAYlVOfb6hWI3AErDiBZFtIhsAU9y+RAeGoPFPNfa/WCmTjk+zLSWsKQDqxRG0OBnJ7IgTfo403Q66Eb9nylLgmrOqoah80yxJFbhJDN2ceLYzktoqw7FYzpVikCeHbwFTe02NF1XakcsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>,
        <alice.ferrazzi@cybertrust.co.jp>
Subject: RE: [cip-dev] Preparing a container for kernel compilation using the
 Debian compiler
Thread-Topic: [cip-dev] Preparing a container for kernel compilation using the
 Debian compiler
Thread-Index: AdgMY9eyAPGayKlPRVGrKjqb5zpAXgAD71uAAYWsbGA=
Date: Wed, 26 Jan 2022 07:58:18 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62521FF8A958C48F0609DCEE92209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <e13b5b70-23b5-2919-0ee0-2a69afa477ce@siemens.com>
In-Reply-To: <e13b5b70-23b5-2919-0ee0-2a69afa477ce@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698b0a9a-d746-427f-da02-08d9e0a19d3c
x-ms-traffictypediagnostic: OS3PR01MB9529:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB9529A99A7B47495670B41D5892209@OS3PR01MB9529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 V9iF/EG0IS+zbxAdcGcZuq8zG0dCwyo1sNMdegKRVE1vrYu9vHxblFeMI+4mZcAevLKvt7orMPueqBNFe7xwm6sZ6H+FuGsEaH2pyyhofOmbLZJVPhglzGrTMJsuzsHKxuKnpld5P9WmR+j9IU05MKnN8Q4dbO8JCyErxfwv6/W2jGjBieBHbOqUW6gH6t6O0NUXGqhQqU/zEw3aPKu0QpZTcVMpn+cGlRyUU0Kg2OU16sFxcRBwScZ3aXMt5HsC073gRWbT5nVyHNvPC4odkPx9KAYA5Sicmo51pBMaz1Ln1C0kCkDWZdOzmk9IM5dycGmgtVWj/KMAx8CE2lKhGLm39eoHUEOLD7zwUQidHO/5PnxVf3775J1TuWAewokGDqIMtywKQv7Sgrcxth2hvmYwvtmGoIHkIuSnWQX1xpz1kBiC9ek1WOhT7fC0IDxy6v4vbfNEody5S6bTwXIyjU52r0ZZljjbiaW656P5Obq4xazioiLrYWCARO2dc/accMA2AFLFtE6uU7cc7IPrndxhZeFz3xWyESVlhv8ytrFqMMUEEPMmzpjedhgZBQvvQPtkO3ishmQDfPyd7nowFgiuZ5Ay2s4qP9wWJbohaTYvX3p9Ovzm5YVIuFG7Es1V57rCUlZxcCittE/BU1Jyl28LnW1BvFP7xAfVMQoVAgOHLPq5jCkQRSkIoXWN8SBDrNEplWp7LcOVFTKSvUtC+A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(33656002)(9686003)(508600001)(316002)(110136005)(55016003)(5660300002)(86362001)(64756008)(66446008)(53546011)(6506007)(2906002)(66476007)(83380400001)(8676002)(76116006)(8936002)(38070700005)(66946007)(7696005)(66556008)(38100700002)(52536014)(71200400001)(122000001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WE93S2FsYm9HcVRNQTdjL2VxWXVJZWxUN1NrU0pieDdpTnRtRXE4V21WRFFU?=
 =?utf-8?B?OEQwd0dmR2dDVHhxRkdkUEV1M2tHNVR4aXRGdzI4anVtNGlOcjhzMW5ORndY?=
 =?utf-8?B?VWtEb3JhSU9IOXZrRjdKazdydFhZQW1Hb3VRd1lrMkpWNWVBV3JKSVZTSUZt?=
 =?utf-8?B?Y04wU3FSSlNCL041dEZKRi9aZGpPMXY3cFBacnlRTUM0dTNlL2hwcytvQVZ6?=
 =?utf-8?B?bmNTNW9nc25xajBWWkM1RnBqT001aVgvZ01iY0J3Sk1lNzdMUDZBdldKWEJm?=
 =?utf-8?B?d2ZYM0JnT012Rlk1RVp2R3ZnRzZYZzNVS2oxdTZPSHlqeklOY2MxRE8yYkxN?=
 =?utf-8?B?QmJLcjBkeGVxQWI4WUdwUlgvSW1KZndlQ250OG1iM0JEOHMyd3cwcTcreWNK?=
 =?utf-8?B?dGg5Wk1uSWNWc1JxanBLK0tyRUNmVXBoLzA5UTRzOUtNaElKR1pacWUrWW50?=
 =?utf-8?B?NkRlUCtVa2ZpWE1xUXphd2EyaFFkcEJpeCtFMUZDSy9FZVJKdytDSDNhSkRn?=
 =?utf-8?B?MWduZWVNcUJaQzZkd2xpVURqdHpTZzFRZFpOMTZrN09TdXhzUDhjT1o3Unkx?=
 =?utf-8?B?bEc1UVFUNTF1RDJjT2w0UExBbnNwK2k3TnhId0lWWngyQ1ZmTXVjc29QeTRO?=
 =?utf-8?B?ZzRNM2FwMnNFQVlTcGIzSlMrSHZNdnl6ZDF6TnVHR2VBTlUwd1U2VVEwbHNp?=
 =?utf-8?B?OE1obE5CcC9QUVl1Qkg0OG5nalZPMlNjS25EM1BpSER1dFpUOWpKTGxQVDZw?=
 =?utf-8?B?M0ZsY1I2Sk5ZaHFQR0RXWnBWOXNQaG1QYXlQa3NDcnVwOEo5dWZUQjYwdG0z?=
 =?utf-8?B?VEFKY3V0dCs3YWZmMmhGQTR3RkNnaWNaMTU1NEZ3N1hIWmtqaWJMMmFDbVJh?=
 =?utf-8?B?TkhoM2hRdnh0TjhBcjBKaVFiUUY1NDMwRUpsS1lqUjFxOXhMR1V0bGxpWk53?=
 =?utf-8?B?ZE9IdDlJcjJUbE9VaXdTWDFLQWdFK0pOazZ1L005U09hZk5SZXNZQzUxSno0?=
 =?utf-8?B?SG0waFFwL0F0V3N3b1ZrWDdxdUw3Z0pDL09yNEtRSUEvQ0RlOXhpdEU1cEJV?=
 =?utf-8?B?aVBtWjJkcjFXU00vQ2Nuakt6a1dTMnhsNU9YTXFNQmtqK3NGMGUrS2Vqa2tE?=
 =?utf-8?B?NExieHh6dmRnRUI2WFdRdktaNFp6Z3VuNFllYkdSb1U4R3VlamV6UGdZSjUx?=
 =?utf-8?B?T1FXSnQzSkFKRWpzMW9VbDk5UEJaVSsvcWNQSm5PaUVoRVdqem04WjNMdW1z?=
 =?utf-8?B?NjdROVppaTIwNWRBdU5tUDBRL2hBSWtONFZNeEoweERDMXZMODl6QzRtSVNi?=
 =?utf-8?B?K2JJOHd3R2o4WG9CWm9zOU0xVTVtb2pIQ0ZKWkdmWVJYZUdMOVdHVmQwOXRF?=
 =?utf-8?B?K0EwNE1hUDdkeW5rWWdsbzNqdTJBVi9YaVJDSEpkVm1FN3hXOTROMlIwVWww?=
 =?utf-8?B?dnhIR1cybGo3MzNzVzNTaHFqV1BDYTlGQ2dpWEw5STdSKyt5VFRmZVdYT1Fm?=
 =?utf-8?B?NFUxekxLYTFMbCs1VGZvZk00ZGc2dzNVRW5EQjl2cjByRy9uamdMTjJBQ2dn?=
 =?utf-8?B?ZHBZSnd1NVBMN25IV0dQaHo3a3l5TnVHVlJLeElzSVBEbHA0Tm92MGVaclha?=
 =?utf-8?B?KzFSNXA3Yk9ScWtQMWdDQldVOE83QjBZTFJlNU9WUitxRUgrbXU1bktTeVZ5?=
 =?utf-8?B?ZnhTR2IwOGxhOTAvNU0rc0daeHUwQ1o4K0o4M2lzdndTd1NSZXlXYVdJQ09Y?=
 =?utf-8?B?eEd4M3N3YmpvN09TRmxieE9NYzlVYkVyVUhjMTNYVm96bktGKzZEczZNSmor?=
 =?utf-8?B?VkQ0UkdaeWVUOUFmN3JCaTVRVGRUMDV0M1ZMZkFKWlVjN1d0REZVbnI0cll1?=
 =?utf-8?B?eDdNREIwRTZyWUdqUEpzYXhIRGN0ZFIvTkI2VHo0U3ZnQSszZzVWWXgwRDlM?=
 =?utf-8?B?U2lHTTdkSmVYWWV2cmxBR01MOEs2MlFKZThWU0hsNGZxNTJ2eXhIMVlGKzRZ?=
 =?utf-8?B?TEpxS1QxSCtOZWk3Q3N1dVVTNm82VHRmN045QUwzbXZCOXIwYlhYRVRIS0NT?=
 =?utf-8?B?d1FnVk5FLzFHZzl0SWNEUXhkdGRST2JXTDNnWHlxLzA3K041TGlWWlZySkF6?=
 =?utf-8?B?ck5HNmdNb0M2bGNGeHh6aHlCQm5TaXkvQnBYeXpubEwvYnlLa1RXR1p1ODRC?=
 =?utf-8?B?T3hyOE5CWGhjMlhrOTJ3VHRzTmdFRGNmeDZyVlJiKzdPcmRBMG5kVWRuMXB3?=
 =?utf-8?B?aDlKdWtJRWVlanNKME5GbHc2QVpLcm1QM3FMdjNUSnV3clRYZk1vUlZHeHpz?=
 =?utf-8?Q?CMMrMNbRoaD5LwCzWl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 698b0a9a-d746-427f-da02-08d9e0a19d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 07:58:18.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 O6Y5GLcGsLLmrQPN9LE1qU6CdTon62A4GqgubRsjIROrcYbBIJDB931sPeuMX3GbJ2p3xv8iOG2uIoyOKennF7JLm2RKFeMv/u9isK/DUhMzVZQYB/HTgLQz8iBEgduf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9529
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 07:58:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7481

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxOCwgMjAy
MiAxMDo1OSBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47
IENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbTsNCj4gYWxpY2UuZmVycmF6emlAY3liZXJ0cnVz
dC5jby5qcA0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDog
UmU6IFtjaXAtZGV2XSBQcmVwYXJpbmcgYSBjb250YWluZXIgZm9yIGtlcm5lbCBjb21waWxhdGlv
biB1c2luZyB0aGUNCj4gRGViaWFuIGNvbXBpbGVyDQo+IA0KPiBPbiAxOC4wMS4yMiAxMzozNSwg
bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgd3JvdGU6DQo+ID4gSGkgQ2hyaXMsDQo+
ID4NCj4gPiBUaGUgNS4xMC55IHRyZWUgYnVpbGRpbmcgaXMgZmFpbGluZyBkdWUgdG8gYSBwcm9i
bGVtIHdpdGggdGhlIHZlcnNpb24NCj4gPiBvZiB0aGUgY29tcGlsZXIgY3VycmVudGx5IHVzZWQg
Zm9yIGtlcm5lbCBjb21waWxpbmcuIFRvIHNvbHZlIHRoaXMsIEkNCj4gPiB0aG91Z2h0IGl0IHdh
cyBuZWNlc3NhcnkgdG8gcHJlcGFyZSBhbiBlbnZpcm9ubWVudCB3aGVyZSBlYWNoIHRyZWUNCj4g
PiBjb3VsZCBiZSBjb21waWxlZC4gV2UgYWxzbyBzdWdnZXN0IHVzaW5nIERlYmlhbiBhcyB0aGUg
Y29tcGlsZXIgYXMgd2UgYXJlDQo+IGRldmVsb3BpbmcgdXNpbmcgRGViaWFuLg0KPiA+DQo+ID4g
SSBoYXZlIGNyZWF0ZWQgYSBmaXggYW5kIE1SWzBdWzFdIHRvIHNvbHZlIHRoZXNlLg0KPiA+IENv
dWxkIHlvdSBjaGVjayB0aGVzZT8NCj4gPg0KPiANCj4gSnVzdCBhIHRob3VnaHQ6IFdlIGNvdWxk
IGFsc28gZGVyaXZlIHN1Y2ggYnVpbGQgZW52aXJvbm1lbnRzIGZyb20NCj4gaXNhci1jaXAtY29y
ZSwgYnVpbGRpbmcgU0RLcyBhcyBjb250YWluZXJzIGZvciBpdHMgaW1hZ2VzLCBlLmcuIGZvciB0
aGUga2VybmVsY2kNCj4gaW1hZ2VzIHRoYXQgd2lsbCBzb29uIGV4aXN0LiBJIGNhbid0IHByb21p
c2UgdGhhdCBoaXMgd2lsbCBiZSBlYXNpZXIgdG8gaW1wbGVtZW50LA0KPiBidXQgaXQgbWF5IGJl
IGludGVyZXN0aW5nIGZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIGhhdmluZyBidWlsZCBlbnZzIGFs
aWduZWQgYXQNCj4gc29tZSBwb2ludC4NCg0KSSBzZWUuIEkgdGhpbmsgdGhhdCBpcyBhbHNvIGEg
Z29vZCBpZGVhLg0KSSB3aWxsIGNoZWNrIHRoZSBsYXRlc3QgaXNhci1jaXAtY29yZS4NCg0KQmVz
dCByZWdhcmRzLA0KICBOb2J1aGlybw0K


