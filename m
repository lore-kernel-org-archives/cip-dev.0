Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD611C433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 10:08:16 +0000 (UTC)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.129])
 by mx.groups.io with SMTP id smtpd.web10.11908.1632823694304181515
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 03:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesasgroup.onmicrosoft.com
 header.s=selector2-renesasgroup-onmicrosoft-com header.b=IAuVkKWY;
 spf=pass (domain: renesas.com, ip: 40.107.140.129,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V16ziJmkFgRel+Y1nus4AThohK2buozkbG98okQ0dDRgekyLTcHT/toiYaBxOo3xymUHwMcKKZqk6fYkSnhWo9YSpXTc3nodxtEsoMCmAX6YVTqwuZDSULIBi3zgtXvNl9cMnR/2OT/wC7ut1qI4w3Mp76FwaTK4AU3jRG4Yan/RMx2CSU7mjHKduE55my7VgxoeV5t7FU95iAJfBLphVdVFymDfWK/M7mBp3k5vV2p0KgkMfvEOsg+aHro50wyuTs8bx52z7L5kyVyoGD1vsVpfnoaFgMKCdFYda/HTqqMKwrmHEv2PqaMMfqh4z2fohgD4PfC1nFXJVLtGQf+udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kniacGt8ZSIyRVVqKRdJjbiouUTrl/8OAuFoUZnO2Bo=;
 b=RFpG2mX1yFm+Q7KSq90jQziu2nuSe/MV/pKO7dtQSvtXiNMBj9lROV1hYpbRBlJpNT3QTJ4x0imi8PnFbHrUKOZWlXD+ge/+8Ain5+mgEIUeTXi+jx3R3ah+EiwIZ7nIVFvrxWtZZDuD3TAPDmjgry/NnP1yrROfW9yXn8DDCFrKWMIa30WVi3AsCjwjPsJl+SVlMiSryE5x8oxorKeFh9UtaWJV5FGX26LV57t5rtrCdXxxnOZ/5Y08qSwNQIhF8v1OkdLeLCQRaZaPkWQ3ecU0mxXb/aWmUq3IwJIE8CCcNmejh23SfFJ40RXwSC/tUx6G6TigPaiEimtIEKMb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kniacGt8ZSIyRVVqKRdJjbiouUTrl/8OAuFoUZnO2Bo=;
 b=IAuVkKWYC9dvysBFWQ0+Q8dU566FncQQq0/7c74g4iuCw2lVaB9c+otEhBSWQIoAoX8OTmgdJ8qTuNlQOCQ0ADY5DjjNMFSbb8P4LygXgMLI+rN/VCLwFYY913LCF9+ziUM9ZCP9kqyAoKZAWsChiQD0gn2M2tOh4ENbwb9msHs=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB3969.jpnprd01.prod.outlook.com (2603:1096:604:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 10:08:11 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::6496:6d28:639a:158e]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::6496:6d28:639a:158e%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 10:08:11 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "Bhola, Bikram" <Bikram_Bhola@mentor.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Jan
 Kiszka <jan.kiszka@siemens.com>
Subject: RE: Prompt timeouts on ipc227e board -- randomness related?
Thread-Topic: Prompt timeouts on ipc227e board -- randomness related?
Thread-Index: AQHXskjVa8mpvXuxmkSBmLL4hUsxqau5PKug
Date: Tue, 28 Sep 2021 10:08:11 +0000
Message-ID: 
 <OSZPR01MB6877A8787F60CB9D584474CAB7A89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210925200625.GA19637@duo.ucw.cz>
In-Reply-To: <20210925200625.GA19637@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36297b11-0264-4c88-5173-08d98267e0eb
x-ms-traffictypediagnostic: OSAPR01MB3969:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3969ED19E04C69010C98DE92B7A89@OSAPR01MB3969.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7LEGMt6/28sbEhSIjAJ4LzWurYYd3HWO5JrNOvW3uOgSSaiBwLz7XeKg/ie5Wu9t1LYPnmfGvSRUPZ4KKgryfUDe9dWItQlMKi3+iKwaE1Z/33rEnaJdZDa59c7Dp3t61vyyzT5q7FL1jHz4KBMX6lBMXYWZdQOECuKBnCGeFVW7SOUy3QFeQRdYjcvJ1AVQyMfyVIZLqJo3VMu5p3+j9Xdx57iB/WP4gQtY0LmGuQ5707RsdbKAQGzF6bPqTcUDsr9TUMeC3vUmfMwfU+U1E0NZz/i2wyeUx5aPEPxR6IqpkoD0hsDB8Ke7KqdwMYJ9qZA8fm82D3lWlh8+lP357FOpL0WGTl+yVO5QQmlxZaEYwPU8U2u/bq1dGjlj0N5GGUwvs9WfO34kuH2w8mGSqMQq2RjSDqD7rQ2AwaSk5eVB1sjcw1ZWEbe6qoaMbo47Xj9ZgC8bG3qWZtffFIzJ19417Wod8HgWI62E5cU4J5rAlrzczZeQrMFtEzfvrduiz0WMvl/11o5IraNCmxVzl84ZdWh/hQBdq3w0mgEx5Z3SGW02MTQryBh66OIPrJkQki78hpv//7us/dSOMwPQ/d00ar3WlUJzxMNJU2i9MKSw9SpzUicOBDS3P78JVPpWARYkNBrkldimQGMLkp3TYpF9elBcZli1MxT3cPPEjk8P3OvmC7G3EDTaJLRp+OGUbbSkUhei1J4YzypcYNVyFHY6dQwm9pqkn4Z8n15s+/N/a/a/svPqVKVWSCtKFRDAeRsaD8GYxIqu5lMUchKVkyRtsh+XAW4FcZbMQu524ww=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(83380400001)(76116006)(186003)(8676002)(2906002)(66946007)(26005)(8936002)(54906003)(4326008)(966005)(110136005)(508600001)(38070700005)(86362001)(33656002)(66556008)(64756008)(66446008)(38100700002)(122000001)(9686003)(55016002)(5660300002)(52536014)(316002)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dERvOHBXMk04WUdFNlhVMVk2NmZuOFVkbk1HMk9jQklQaWZKQlBmWitsd2pE?=
 =?utf-8?B?YXZJWndlc3dXMTR1bEcvbmdIalBNWUxrVTlBYTJzWFR2SHVvRnY4ZmppYU5B?=
 =?utf-8?B?T3lXWHRSaFRlRXYzRC8yMnZkbTR1TmxNUXFIL3hGQWxmYnhQdm9qODZxVkNi?=
 =?utf-8?B?VWxHS1pSL0txTkpvc2QwZld3OWw3M29kRlg3V1VVanJBQ1NGSVFXd2RPMitX?=
 =?utf-8?B?ZnZ3OGhZU0FkeUJTQnlWT2pwKytacm9lQTdkMHNVYUt3aklCWS85Y29lOHZI?=
 =?utf-8?B?MWEwYjNhK0ZvcGtzam9SM0FRaVZUSThWQ25BNzRlcFdpVGRDdE9GVC9uSVFa?=
 =?utf-8?B?djgwaXl4eStpclBFWWgvMWFrQ2hlS0hCUkZKR2FVZjllcDArSHRSMnlOUVhi?=
 =?utf-8?B?R3BaRy9yVWxoVDByZys3bFdud3BLUU13TEtKbGthMHQwTTdONGt0b1RiNGVN?=
 =?utf-8?B?TWRKUEdNVE0raDNyS05mMGgvSEhLMThOWWl0VW1WbWlVZGc3N3FhY1J3S0Y2?=
 =?utf-8?B?YUNCNzFGMG91WW12VkhMN0k1cWRnTUVDcitpK2dQV05iclRsVGEycEtlYWtU?=
 =?utf-8?B?bkUrWDQ2ek53TU11NXVZY25CWWVHcnJMN0s3K25EK0poNkpIU2tCY0kydm00?=
 =?utf-8?B?SjU5bTZnSmt6YmYxeEVDU2VZVDNCVmRUR2c4bjhaUGF6L1RUTXlWbzhIcFY4?=
 =?utf-8?B?T2R3aGd6QkpiL24xUnBnT2FiQTZ0SUlHZWNraVkrUEJlTjlpM2xZS1o4NHZk?=
 =?utf-8?B?M0llWFJKUzVjQ09DZ1kzajhucU93cU1uTGNudkI0WmJmQXcvR2VaQnhOVEVS?=
 =?utf-8?B?Nk5mZUlCZG1QUDV5aGpWcFN5WXpLRG1YSG5tQktwa0dKbWgrQXNQMW81VGRn?=
 =?utf-8?B?ajJqWnh3b1JSeThyQ2dkdFBieXBrMTE3OFJLSUR4bDd6eFlYaUd6OG1wMnlX?=
 =?utf-8?B?L3BoZExUak0rZmZmci9DNEJEanVab0hIMGFWaWxCK0ZQck41ZjhkcDNmUXBH?=
 =?utf-8?B?TkxQUXNMZjcwVmhoUi9pWDRHT3Y0aDRtN0xPcHl0Y3V6UHcxR054US8xRHEr?=
 =?utf-8?B?U0hvYzFzcEg1aVJZYSsvMVJWRlBtcFREcUdWZ2xqcVlPQnRSZloveVo3SDUx?=
 =?utf-8?B?Q1FqV0RxUWJWYkVvTzg0ZzR0MUhyeHdKcW9Ma0Nlb0Z5bHRDSXdYSGVUSEJE?=
 =?utf-8?B?eDgxU3o4dk00MXE2YTJCaG9oUWprWWhGNUN5YUw2cWM0d05VeDU2TGFXRFlB?=
 =?utf-8?B?SnZWSUI0Y3JGanVkd2NFTGhVdkpFWkxUQ0hyM2hLdnlpeXdLMWptT1h6QVRX?=
 =?utf-8?B?YURzOWNtQWN3V3R0N1UwY0J5STY2NitTQk5lN2lLN1kzZ2ErbXBHSzdCQ1Nk?=
 =?utf-8?B?SGtYMWdEQkdVNVhsNEJqVU1seHhXY1BpcTg5ZTdYN0RPRHVFTDRHb3FxWXlh?=
 =?utf-8?B?bGs2MmczRWFyRU9YaVJQdSs0K2ppVk1TZGVteEF2S3dYcklPOG9zcmpDVXI2?=
 =?utf-8?B?aGluKzZ1dUFnVE1ZQ2Y4WXRqU29KL05qMUV3TkNKZXlPVWtDSVE1bjRXM3pT?=
 =?utf-8?B?azB6aU9VODFGS25JcDlKRVRaL3ovQlVIVkdETzdQaTlVRXRFVkFqQlNab2tO?=
 =?utf-8?B?aXREeXF4UDN3QWh3YjFhRVB2YUpreXNTU3ZIeHg5TFI3enN5ampSTkF6Q2Vp?=
 =?utf-8?B?MVRiVnpuSW5HbWphdE5iU3VGdWhLd0JyOTlrb05rMlVlcFZ1ZWlEVloxSWhF?=
 =?utf-8?Q?AxQMHDyykUaNP23TL0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 36297b11-0264-4c88-5173-08d98267e0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 10:08:11.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 F8U4h7HDT+4VTn7X661QBkGbPl1n7ATJ1NgG3+w82aonmmzCCVmRDio+ZTlpk8usaxg5qE08hcEsmHri2/0Pj+6e5AEAr692rpYZYX17tlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Sep 2021 10:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6754

SGVsbG8gUGF2ZWwsDQoNCj4gRnJvbTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiBT
ZW50OiAyNSBTZXB0ZW1iZXIgMjAyMSAyMTowNg0KPiANCj4gSGkhDQo+IA0KPiBJdCBpcyBub3Qg
Zmlyc3QgdGltZSBJIHNlZSB0aGlzIGZhaWx1cmU6DQoNClRoYW5rIHlvdSBmb3IgcmVwb3J0aW5n
IHRoZSBpc3N1ZS4NCg0KQmlrcmFtIGlzIGdvaW5nIHRvIHRha2UgYSBsb29rIGZvciB1cyAodGhh
bmsgeW91KS4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiBodHRwczovL2xhdmEuY2lw
bGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi80NDQzMzYNCj4gDQo+IA0KPiBbWzA7MzJtICBPSyAg
WzBtXSBTdGFydGVkIExvZ2luIFNlcnZpY2UuDQo+IFtbMG1bMDszMW0qICAgICBbMG1dICgxIG9m
IDIpIEEgc3RhcnQgam9iIGlzIHJ1bm5pbmcgZm9y4oCmYXRlIHNzaGQgaG9zdCBrZXlzICg3cyAv
DQo+IG5vIGxpbWl0KVtLW1swOzE7MzFtKlswbVswOzMxbSogICAgWzBtXSAoMSBvZiAyKSBBIHN0
YXJ0IGpvYiBpcyBydW5uaW5nIGZvcuKApmF0ZQ0KPiBzc2hkIGhvc3Qga2V5cyAoOHMgLyBubyBs
aW1pdClbS1tbMDszMW0qWzA7MTszMW0qWzBtWzA7MzFtKiAgIFswbV0gKDEgb2YgMikNCj4gQSBz
dGFydCBqb2IgaXMgcnVubmluZyBmb3LigKZhdGUgc3NoZCBob3N0IGtleXMgKDlzIC8gbm8gbGlt
aXQpW0tbDQo+IFswOzMxbSpbMDsxOzMxbSpbMG1bMDszMW0qICBbMG1dICgyIG9mIDIpIEEgc3Rh
cnQgam9iIGlzIHJ1bm5pbmcgZm9y4oCmZXZpY2VzLQ0KPiBldGgwLmRldmljZSAoOHMgLyAxbWlu
IDMwcylbICAgMTkuODU1MzI4XSBzeXN0ZW1kWzFdOiBhcHQtZGFpbHktDQo+IHVwZ3JhZGUudGlt
ZXI6IEFkZGluZyAzbWluIDIuMDI3NDc2cyByYW5kb20gdGltZS4NCj4gWyAgIDE5Ljg2NDIwN10g
c3lzdGVtZFsxXTogYXB0LWRhaWx5LnRpbWVyOiBBZGRpbmcgMWggNTRtaW4gMTUuNzk0MzQ0cw0K
PiByYW5kb20gdGltZS4NCj4gWyAgIDIxLjQwNjQ5MF0gc3lzdGVtZFsxXTogYXB0LWRhaWx5LXVw
Z3JhZGUudGltZXI6IEFkZGluZyA1NW1pbiA0Ny4wNDE0ODhzDQo+IHJhbmRvbSB0aW1lLg0KPiBb
ICAgMjEuNDE1MzU3XSBzeXN0ZW1kWzFdOiBhcHQtZGFpbHkudGltZXI6IEFkZGluZyAxMWggNDht
aW4gNC40NTc0OTVzDQo+IHJhbmRvbSB0aW1lLg0KPiBbICAgMjIuMDQ5ODA3XSBzeXN0ZW1kWzFd
OiBhcHQtZGFpbHktdXBncmFkZS50aW1lcjogQWRkaW5nIDNtaW4gNTQuMTI1NDA2cw0KPiByYW5k
b20gdGltZS4NCj4gWyAgIDIyLjA1ODUwMF0gc3lzdGVtZFsxXTogYXB0LWRhaWx5LnRpbWVyOiBB
ZGRpbmcgOGggMzRtaW4gNDcuMzg4NTk1cw0KPiByYW5kb20gdGltZS4NCj4gWyAgIDIyLjUxMTY0
Nl0gc3lzdGVtZFsxXTogYXB0LWRhaWx5LXVwZ3JhZGUudGltZXI6IEFkZGluZyAyNW1pbiAxMy4w
MTU0MDVzDQo+IHJhbmRvbSB0aW1lLg0KPiBbICAgMjIuNTIwNTEwXSBzeXN0ZW1kWzFdOiBhcHQt
ZGFpbHkudGltZXI6IEFkZGluZyAxMWggNThtaW4gMjQuMjEyMTcwcw0KPiByYW5kb20gdGltZS4N
Cj4gW0tbWzA7MzJtICBPSyAgWzBtXSBTdGFydGVkIFJlZ2VuZXJhdGUgc3NoZCBob3N0IGtleXMu
DQo+IHdhaXQgZm9yIHByb21wdCB0aW1lZCBvdXQNCj4gZW5kOiAyLjMuNC4xIGxvZ2luLWFjdGlv
biAoZHVyYXRpb24gMDA6MDA6MjQpIFtjb21tb25dDQo+IGNhc2U6IGxvZ2luLWFjdGlvbg0KPiBj
YXNlX2lkOiA5NDE3MDY2DQo+IGRlZmluaXRpb246IGxhdmENCj4gZHVyYXRpb246IDIzLjk4DQo+
IA0KPiBBbnkgaWRlYSB3aGF0IGlzIGdvaW5nIG9uIHRoZXJlPyBJcyBpdCBqdXN0IGEgdGVzdCBw
cm9ibGVtLCBvciBkbyB3ZQ0KPiBoYXZlIGtlcm5lbCByZWdyZXNzaW9uIHRoYXQgb25seSBoYXBw
ZW5zIHNvbWV0aW1lcz8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gCQkJCQkJCQlQYXZlbA0KPiAt
LQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0
b3I6IFdvbGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0
ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

