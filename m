Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF27AECAAA1
	for <webhook@archiver.kernel.org>; Tue, 30 Aug 2022 07:14:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.8717.1661843649846332457
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Aug 2022 00:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27U7E7rj004472;
 Tue, 30 Aug 2022 16:14:07 +0900
X-Iguazu-Qid: 34tMJNUJG0CwX77Gwj
X-Iguazu-QSIG: v=2; s=0; t=1661843646; q=34tMJNUJG0CwX77Gwj;
 m=Wja/vN0cOBhvf2s2LjNdF/k3akagqkYz5IIJaEB6DGM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 27U7E5mJ008321
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Aug 2022 16:14:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7C4xnH/8PUKIiepxQB3fyqs7mI+k5aOA+QXxUQGRKNbvcchrecosBV5G1Z8vhfOlgMxF4/rvhKZlYKVV8w2TT7FnA/Af0dsO9auTnvmwTJwXROLozQ021tXOpSFQTA/wAuKbJG/DeJXRrswtmcITOvGRRHUQmfFbmZrJVFIV4OIg7VTjudUh0jKPb2xVLLLIZUDHsNg6TLpTo2OYRV2eIpZ7McSPFq1qNRNyyyFYAC1bXE7EIqAOaUWyvdZNCuDspw60NCtmGYTyU3DyKo4/2IniCZacTqcnh1ku1s7aEfpdOK2dj/RZgGN1Etj2hgMSpxm/dDfRAcwrv+eIsPymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO3EgISGfp7GjkDn/8NCHI4rn0V2FC3zg9MpWPPmpWE=;
 b=TlKX359gP/fZoKuHrDtAFEaIKGk5mRM45ZM6Z1HdsWLeNyM6PeWOQqQhHds2KHMe5BaUIk7Sf9o5nexKZfThkU7/2bGHGgUTz0PZQdo/UB81MFIocqXxn+EGJG5fDTVzI76SsFr8w23uZQlHsbvPEqHpsKn4LsLtWkOD/M1C86ZavgRUTcQIUbKMTlmWNwI2NCPAqSa2OkRB3h+OoUAxXJCLKj3I9fg7pCPl4smfLOjz94Ln8zWYk91qMUHQUgEiOLYDsMif5OIYcB7hHBrVUKBu6zVzooRynSWgq09ekek3l3a0fR9Y4pfcyVIAt4LQcw1/9wd8WaGed3qrDvAbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 0/4] SWUpdate on BBB
Thread-Topic: [isar-cip-core 0/4] SWUpdate on BBB
Thread-Index: AQHYsrjBxpgVecoe+UKRBHoZ1/eQtK20lCcAgBKFrKA=
Date: Tue, 30 Aug 2022 07:13:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6147702A4B04BA048D29FD9BC7799@OS0PR01MB6147.jpnprd01.prod.outlook.com>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <e796fcf5-7654-13fd-8001-71fa611398e0@siemens.com>
In-Reply-To: <e796fcf5-7654-13fd-8001-71fa611398e0@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 119ef21a-d4bd-4619-4e8e-08da8a5730d1
x-ms-traffictypediagnostic: OS3PR01MB9317:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WKDezUD2f7UH/OBXhwzaAQlp7gNboC2SK24NsGJTrd6tngmXhmd7vVFyNkEF+wHEp/hiWRWAtYS7ulRzobJ4XKuHEJNwTezPyOm6yedupoakWGRDdil9mrItrE4JNtXHm3TkYhHV+on13eJJk9rjZl5YXqyDaDAccFRMngAA33+3RDhfY6HvedbueJalktBkmhIXrI67g9V5wfvQIE4fzRwo09ynyVEDZYqBKkd0IGWczuQsq1ZJ6ryyk0jIMZUfsWIj8nfXFzCKW9OeOLWkepxeqiwNtKsMGaqTZCwxt3QU9tMZZx6d6dWdqBfEPH1EFJQ1F2AuTTCiYnct7liS4MLl0js9V4LXpbMqa17aDqWh7FxxZbtah3+MtTCrb/yZoAaKZ7F9zjEo01Uj1TRefAqcytea2OUJHH8Yr6GDXL6UioZCrT/ShJn3m3LX1+19OsH+mPpoya2n21km9ebE7zN1Bgyajf5dNUY6373u8s5Yhk1R9vXTGyACslJEc6lQWfwrV+f+u5IC3XSQTLlMrIvlH8/WYTTmvDibUM8fa8SyIYWqvFjtCdQ4ajZeNdv5ZZ3iWpIGs6ubaFxJ7nwLOjyfL/MaoIPridAz0fFEDPtZRQSTnKyThVuYnzsdu9nUmswIz97q4lrKkJxwNzEwhavq7Dwlfm/+uCFTAS2p++tQ1MxK96junFAXi3+AxqCHsK4PKeSocNEWKfa45E6ILRfqVnSoamSjLwjUH2lJFhqbLeqp0JyZdQeiDAbRJeMI9TP8rnmWQkl2zpHpoUipfRCq2Mtp7GQ6dEOKRSDxbSm7f8YhhsgVpOd2O8DO6Bo3Y82ABm8yPKIZdtW1bhSeLg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6147.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(66946007)(83380400001)(186003)(38070700005)(38100700002)(86362001)(64756008)(8676002)(66476007)(122000001)(55016003)(66556008)(4326008)(66446008)(76116006)(316002)(54906003)(5660300002)(8936002)(110136005)(52536014)(6506007)(26005)(966005)(478600001)(41300700001)(9686003)(53546011)(2906002)(7696005)(107886003)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHVJOEVxQlpIbW1kUzlwMktaR3loWVlXdGZjaWxXNks4cGE4R1FTRzJXaGtY?=
 =?utf-8?B?cWtBQmgvekdsaGF6eURieWh1TWV3bTlqd0tNZjJQZi9vdWtMYkFmOCsveWho?=
 =?utf-8?B?L2crM3RHaStFaTdGOUlIM1ViZ2xDNnkvTVJzK3JnSStJUUttSmtmcUZwN0Rs?=
 =?utf-8?B?STVuLzVtZkVOMjhVRW9CaHB0WitibnIrTkJ3SWdQdHU1S2o0VytNUGFnWTdz?=
 =?utf-8?B?Tm02Q1pDdzZ1elBGbkpsb1RXZzBTNk05N2VOQVhKeTk0SlhMc2RSNGhWaVJK?=
 =?utf-8?B?emJNdCtjN25NZ0VSV2pGKzBUNExZb2NCV0xndFlpd01ScGtJeFZ5SWxyQnV6?=
 =?utf-8?B?TVE0cS9hcHgxOGFHTHdLZXdsSXJZVjhtV3ZNaEN3Tk1od2V5K2NXQ0NnUWlE?=
 =?utf-8?B?MWsxQXRIMFJybERHRlA2dzIxZ0RvdE84RlVPTkFrQkp2RFhaOTNtOHk4VGJG?=
 =?utf-8?B?SGVSb3A3U1FBRGlsRHdmSWhmS3dNS3ZQN0poYUowMi96QTFFUTBUa1U2MVk5?=
 =?utf-8?B?L1RuUTh3SzFTb2JlbWU2QWcwL3NMckphMnVUdHVvUWhpUFp5aVVBRW9WS1ho?=
 =?utf-8?B?Sk1yVmJYS0NWR1gzZi9YR3drM21hcCtWRFNISG9LT2pqdFpCeXhPNDYxREU0?=
 =?utf-8?B?MGwzQnkyZkdTWWFZR2ZkWHloOUZSS09XcUsxNStnUUJ2VEMxbVVYMzByYzln?=
 =?utf-8?B?SGtzNUxLdWlKSEh3R25TTi9meWlUZk1NeHpnOVF0VFJpcTNic2RVNVhNNzNj?=
 =?utf-8?B?L2pUbHcrZklVQUUrVFNTdkRlL1BnN1EvRHBveXNWdVc4Njd4YUt1RWZ2R0ZO?=
 =?utf-8?B?VDBtTkpnQWphQVV0U05TM2Z5UUtiVUR5VnVNRXRMb0paVnVkRjlPejNxQ3BU?=
 =?utf-8?B?VVF3MEg5T1ZTeXQ5TlYzQTRuTWpPWWl3d0NpVFZuQWZXM2dkN2ZrRklrWjBu?=
 =?utf-8?B?ZlIxYmkyQ09BNGpiMU9raThIMXp3MWJQUTJCNFNMbjhmVTF0ODdibko2Yzl5?=
 =?utf-8?B?bVJFOHp3aXMydmRVOHZySkNSeE5HLzE5K2VGdGwzY3RPL1o5Y2FIL29XdFh4?=
 =?utf-8?B?UmRzQWZPTk1rNUY4QmtxYVVQV3dEL3NNcnMzWFd1dHdGUFFLd0FUL2QrVStX?=
 =?utf-8?B?cHkvbHZ4clp1VVczbUtBdFNIb3ZEZ1BJQXVWVjFzMlhRNnRQaVUzSURIUVps?=
 =?utf-8?B?dXg5aXdZd2JKcS9wYTM4UGs5cW1uVnJqUzJpNWxkc3U0d1JuNnNaL0hlTS9P?=
 =?utf-8?B?YzFxVjJnOTlzcjlJemNkZHAxdzdxdWJzQTFPQ0lobm4xZFVCRFZ6R1dxWGF2?=
 =?utf-8?B?V3gvU2FIU2dFeGk1QkJRL1o5UnNrSkg2OUJwOFkxUysyTVJ1SW41QVo3MDdZ?=
 =?utf-8?B?eElZcGpiL2l1UmRTdm45Q0NNeWNibnBHQXVwYWZKMEhKZjUyQ1pSdkdIdCtR?=
 =?utf-8?B?NEJJanpTVUVZRmpkWitnRXBoWFU3amtuMVE0V2prekZvaXN4ZEtidlJ6NG9u?=
 =?utf-8?B?cVVoTjVvZDJOeWpEd0YwV2ppcmt2elR4bDVQTERuK3JDN0h2bnVKQkdrdTZa?=
 =?utf-8?B?MkhSWTY2YmVjeUgza01TdmdCYi94bXQrb0VsN2k4L25iMnR4Rjg2cHIrckY3?=
 =?utf-8?B?YnNRSEZkZXpnd3BaSlBicGlLZVlKenNCdmExSXhsM3JTM0RIa0ZaTFBaQjg4?=
 =?utf-8?B?ekgrTzRjMCtmVG9ydFkxVTAwSmxjNjEvcXdKcjB4ZXlHVFljWmk5UG9UVE4r?=
 =?utf-8?B?TndZV2VvSUQ5Y01HNW9FelNlNVF6MVhkdVRqM21HMGoyY05FaFJZUTdrSURM?=
 =?utf-8?B?MmVWT1k1Rm54U0NneXlMVS9Vd2syajJRbFgySXd0UGVBRS9zRmRuQzV3eGZv?=
 =?utf-8?B?N0w0aG83YlZtVFBhbExUd1h6WVh5Zk5mWFAyZmtSdG55NzJxamdkaFVZbURC?=
 =?utf-8?B?NTZsdmp0cDlMd2hKaml4eTRERHZuY0VkMWg3SlFMb1BQL2hNTFE2OTQxL0xz?=
 =?utf-8?B?bVJLaUMxbk0zYi85eGkreis0azhzd081VHgvWStZWjN5MUdTVkdac09abmcy?=
 =?utf-8?B?WUFmV05xc3d4NmxMUUl5d2s1YzI2L0Q5RXFweE9ZNEswK1lqU2JlTHp3NmR2?=
 =?utf-8?B?dVJMT3B1SlM3MktTdjA2Qk9qRUxtUFdqMGNxTWR4U2tZaGc2cmRSd1JKQXFW?=
 =?utf-8?Q?poU6iFRTgNKXMTBrqM1n45I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6147.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 119ef21a-d4bd-4619-4e8e-08da8a5730d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 07:13:51.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 nVkQC3nOj6pICt7sZQnZtdvOCId29oyMRjna4TBxyGW4dIavMq36SGcTPjMzJN7czIO3qbdCb9FEvoxfWbfQBceYqBD6boY4/FJcQoQEGY3E8DvEoAizVLngd3gk8aAc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9317
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Aug 2022 07:14:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9322

SGVsbG8gSmFuLCANCiAgDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQogDQogPiAgV2h5IG5v
dCB1c2luZyB0aGUgVUVGSSBwYXRoLCBsaWtlIHdlIGhhdmUgZm9yIHFlbXUtYXJtIGFscmVhZHk/
IFdvdWxkIGJlIG11Y2ggc2ltcGxlciB0byBhZGQgKGFuZCBsaWtlbHkgYWxzbyB0byBtYWludGFp
bikuDQogDQogSSBkb24ndCBoYXZlIGV4cGVyaWVuY2Ugb24gdXNpbmcgVUVGSS4gSSdsbCBjaGVj
ayB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBmb3IgcWVtdS1hcm0gYW5kIHdpbGwgdHJ5IHRv
IHVzZSBVRUZJIHBhdGggZm9yICBCQkIuIEkgYWxzbyBjcmVhdGVkIGlzc3VlIFsxXSBpbiBpc2Fy
LWNpcC1jb3JlIHRvIGRpc2N1c3MgU1dVcGRhdGUgb24gQkJCLg0KDQogPiBBbHNvLCBJJ20gc2tl
cHRpY2FsIHRoYXQgeW91ciBjaGFuZ2VzIGRpZG4ndCBicmVhayB0aGUgVUVGSSBpbnRlZ3JhdGlv
bi4NCiA+IERpZCB5b3UgdGVzdCBpdCBhZnRlcndhcmQ/IA0KIA0KIEl0IGlzIHRlc3RlZCBvbmx5
IGZvciBCQkIgU1dVcGRhdGUuIEknbGwgY2hlY2sgYW5kIHVwZGF0ZSB0aGUgcGF0Y2hlcyBzdWNo
IHRoYXQgdGhleSBzaG91bGRuJ3QgYnJlYWsgVUVGSSBpbnRlZ3JhdGlvbi4NCiANCiBbMV0gaHR0
cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9pc3N1
ZXMvMzkgDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiAN
ClNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTgsIDIwMjIgNTo1MCBQTQ0KVG86IGt1bmlqYWRhciBz
aGl2YW5hbmQo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5kLkt1bmlq
YWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNj
OiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1
bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz
77y377yj4pev77yh77yj77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1
YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSAwLzRdIFNXVXBkYXRlIG9uIEJCQg0KDQpPbiAxOC4w
OC4yMiAwNzowNCwgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEt
dHNpcC5jb20+DQo+IA0KPiBUaGUgcGF0Y2hlcyBhcmUgcmVsYXRlZCB0byBzd3VwZGF0ZSBvbiBC
QkIgdXNpbmcgdS1ib290IGFzIGJvb3Rsb2FkZXIuDQo+IEkgY29uZmlybWVkIHN3dXBkYXRlIG9u
IEJCQiBib2FyZCB3aXRoIGFsbCB0aGVzZSBwYXRjaGVzLiBUaGVzZSANCj4gcGF0Y2hlcyBhcmUg
cHJlcGFyZWQgYnkgcmVmZXJyaW5nIGEgYnJhbmNoWzFdIGFuZCBwYXRjaGVzIGFyZSANCj4gYXZh
aWxhYmxlIGF0IGlzYXItY2lwLWNvcmUgYnJhbmNoWzJdLg0KPiANCj4gWzFdIA0KPiBodHRwczov
L2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL3RyZWUvY2lw
LXN3LXVwDQo+IGRhdGVzL3N3dXBkYXRlIFsyXSANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1w
cm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS90cmVlL3NoaXZhL3N3dQ0KPiBwZGF0ZS1i
YmINCj4gDQo+IFNoaXZhbmFuZCBLdW5pamFkYXIgKDQpOg0KPiAgIFUtQm9vdDogQWRkIGN1c3Rv
bSBCQkIgVS1Cb290IGFuZCBwYXJ0aXRpb25pbmcNCj4gICBTV1VwZGF0ZTogYWRkIFNXVXBkYXRl
DQo+ICAgY3VzdG9taXphdGlvbnM6IGFkZCBjdXN0b20gbW9kaWZpY2F0aW9ucyBmb3Igc3d1cGRh
dGUNCj4gICBBZGRlZCBSRUFETUUgZm9yIEJCQiBzd3VwZGF0ZQ0KPiANCj4gIGNvbmYvbWFjaGlu
ZS9iYmIuY29uZiAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMyArKysrLQ0KPiAgZG9jL1JF
QURNRS5zd3VwZGF0ZS5iYmIubWQgICAgICAgICAgICAgICAgICAgIHwgIDkwICsrKysrKysrKysr
KysrKysrKw0KPiAgcmVjaXBlcy1ic3AvdS1ib290LWJiYi9maWxlcy9ib290LWJiYi5zY3IuaW4g
IHwgIDc5ICsrKysrKysrKysrKysrKw0KPiAgcmVjaXBlcy1ic3AvdS1ib290LWJiYi9maWxlcy9m
d19lbnYuY29uZmlnICAgIHwgICAxICsNCj4gIHJlY2lwZXMtYnNwL3UtYm9vdC1iYmIvZmlsZXMv
dWJvb3RlbnYtYmJiICAgICB8IEJpbiAwIC0+IDEzMTA3MiBieXRlcw0KPiAgcmVjaXBlcy1ic3Av
dS1ib290LWJiYi91LWJvb3QtYmJiXzIwMjIuMDUuYmIgIHwgIDU5ICsrKysrKysrKysrKw0KPiAg
cmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2NvbW1vbi5pbmMgICAgICAgIHwgICA1ICstDQo+
ICByZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvaW50ZXJmYWNlcyAgfCAgIDYgKysN
Cj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2UuYmIgICAgICAgICB8ICAgOSAr
Kw0KPiAgcmVjaXBlcy1jb3JlL2ltYWdlcy9maWxlcy9zdy1kZXNjcmlwdGlvbi50bXBsIHwgIDE1
ICstLQ0KPiAgcmVjaXBlcy1jb3JlL2ltYWdlcy9zd3VwZGF0ZS5pbmMgICAgICAgICAgICAgIHwg
ICA3ICstDQo+ICAuLi4vZmlsZXMvc3d1cGRhdGUuaGFuZGxlci51LWJvb3QuaW5pICAgICAgICAg
fCAgMjYgKysrKysNCj4gIHdpYy9iYmItdS1ib290Lndrcy5pbiAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMyArKysNCj4gIDEzIGZpbGVzIGNoYW5nZWQsIDMxNSBpbnNlcnRpb25zKCspLCAx
OCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIA0KPiAxMDA2NDQgZG9jL1JFQURNRS5zd3VwZGF0
ZS5iYmIubWQgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4gcmVjaXBlcy1ic3AvdS1ib290LWJiYi9m
aWxlcy9ib290LWJiYi5zY3IuaW4NCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWJzcC91
LWJvb3QtYmJiL2ZpbGVzL2Z3X2Vudi5jb25maWcNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNp
cGVzLWJzcC91LWJvb3QtYmJiL2ZpbGVzL3Vib290ZW52LWJiYg0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHJlY2lwZXMtYnNwL3UtYm9vdC1iYmIvdS1ib290LWJiYl8yMDIyLjA1LmJiDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVzL2ludGVyZmFj
ZXMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4gcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWhhbmRs
ZXItcm91bmRyb2Jpbi9maWxlcy9zd3VwZGF0ZS5oYW5kbGVyLnUtYm9vdA0KPiAuaW5pICBjcmVh
dGUgbW9kZSAxMDA2NDQgd2ljL2JiYi11LWJvb3Qud2tzLmluDQo+IA0KDQpXaHkgbm90IHVzaW5n
IHRoZSBVRUZJIHBhdGgsIGxpa2Ugd2UgaGF2ZSBmb3IgcWVtdS1hcm0gYWxyZWFkeT8gV291bGQg
YmUgbXVjaCBzaW1wbGVyIHRvIGFkZCAoYW5kIGxpa2VseSBhbHNvIHRvIG1haW50YWluKS4NCg0K
QWxzbywgSSdtIHNrZXB0aWNhbCB0aGF0IHlvdXIgY2hhbmdlcyBkaWRuJ3QgYnJlYWsgdGhlIFVF
RkkgaW50ZWdyYXRpb24uDQpEaWQgeW91IHRlc3QgaXQgYWZ0ZXJ3YXJkPw0KDQpKYW4NCg0KLS0N
ClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4
DQo=


