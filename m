Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC7C4708E
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 09:46:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.8332.1672825558412589261
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 01:45:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 3049juRs019400; Wed, 4 Jan 2023 18:45:56 +0900
X-Iguazu-Qid: 34tKVCYlZOG2dUDf9O
X-Iguazu-QSIG: v=2; s=0; t=1672825555; q=34tKVCYlZOG2dUDf9O; m=+F/WisKxK2DF7SjVOspq9jRvu/sxoSIGgmmWq5P+6I4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 3049jsWV024179
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 4 Jan 2023 18:45:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkGHgMXiTRRFvaaMc5+8nq0x1giELbT7jSI9Ywy3IuZBZWTU/fTDQA3muiOZ/YUWC4Al+tY5PCso0ImPiSPB/48PD2+6uQNx7QebUksvrp52lk/8mEPTKfJiR4mAcsIaiDXp+x9vanUwzH/r56YItGobhTxipO66HJXRX5ZW3Cs5Z+4LMk+FVa7hqDzCpcZEL16w3LSqOIuRNJR2tz3Q9CvN9pSU7liADv20jyfy6jIxPl+GiXS98C4LOaV3suMWPne2nzKGdwpwGAfEg8yWbJGZVgAPmK2GX2yNBe+FGcAvsYHKWLmRXsPxhiTcI98YLfZ+A+PIDK/MyFOfzEjsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHfIVMydyG2tbiMp63wvj+ede3WCZpYpQ7QTES+5z0Q=;
 b=hvBCH7Ud2bQt0yl8eZI3aJL2WO6CrpJj64UO634EhGKx7blVKqhDmUh4aCW4IJD078CrU+I9jD6bjqiFyvSOdZWMIrTVmytPO0D2xoJ3ez0xi+iNnf8wj/Q7tvdGJkEyiFZiXH17feYMsEUfK/WQoKxHpx47K5YfkSKOUGR4S1WechhQcnSldpvxiG7QoGOyKJ6zqrmLSy8NgRcUMaB4JdHIQf6L8APM4y9P97J9sj708f9INSQ8YfhcVBCkR150lxZDkD3cRU0A2TpVoY1W399wfN8+mpSh/ZoCG+4VL+KL8DosS/PQK7C3pG2RUk627gB+kpscqC5SxhE8ZC6DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <henning.schild@siemens.com>
CC: <wangjing@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 4/6] kas: set clear text root
 password
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 4/6] kas: set clear text root
 password
Thread-Index: AQHZH29uHy0Ntri4eEqDZEpECfeIlK6M/GyAgAASWgCAABNcAIAAwFYAgAAgBFA=
Date: Wed, 4 Jan 2023 09:45:52 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542B60C93C8997A7E546FC9A4F59@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
 <20230102170818.17689-5-henning.schild@siemens.com>
 <56ac1818-f754-ae13-ba5b-203d0a13725b@siemens.com>
 <20230103200854.79dbe287@md1za8fc.ad001.siemens.net>
 <20230103211812.1c3941f1@md1za8fc.ad001.siemens.net>
 <192ab2ed-d727-0232-9e9f-41ec3c14d573@siemens.com>
In-Reply-To: <192ab2ed-d727-0232-9e9f-41ec3c14d573@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TY3PR01MB10284:EE_
x-ms-office365-filtering-correlation-id: 07730f5b-ace7-4f18-ba83-08daee387821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xtg5+HN8nxTP4mtEO0cMdKFXXLfOUamWS6VVzNS/QP5v/K+2Wacla+nOw9ZFQLk42COJpASLVCh8njflHJxH3Xrhqys/jvwXctGX9NDAJXiWfvtUT8fr7INZqtlkQ3waYR3OYg8gfeXYN7HjmbQNGc2ovdek7c4KdtEHlCvTJCuWfftecGMBUCHqtVugTxQ4rjR1sMOj26VCSZiLB0RGtbQmrVdxgXfQ3Eem/Udnh1q2R2C244r+5u8agofVTnmcpUiSJtjYy89O0MzncJuNcE02V10hL9JwPOimfSO4FXm9rJyaMAg+MNSen2qfXwGOBBTnKxwdnk4cx1gqz8jj1PP1qudiNK8SY+POhgc/HskuJKhkRNfklLosAACuUvLINvbijTLiRMI874IlDFDHlXkeBBTGqt3GroOv0wBBfLDECGDxv0/0vaHVPNCPt3K8MXOtodeF4EZZqixD+va0IUNuduuEl2Q8RlyTHXVgXKO7GqTaAZwNALgGKJjz7e9b9/FhXgS4UekaxKrm9r9UztfEaZu4Yzp1xAI++J6KwKnKq2lh3b7jfuZvmOPc5qxqCUnV0Krv2+a4g12L3879BPE0nmTwpBOTwiipe+DzdSsVlISTbR6tzVAW08Zvy1DBXGZ48XSbEY1hzQwnSSKGHC+UJ2HWManoJYoabldBr+e3cYZevUHw34jCbzg55IMQj7lPSKSKxf3s7KmHb2tdsGqtKKyRz7LlkJiZpZce5ACJup41HwrPP88FH5Z/X8pT54qlEgFSbUPVH+luIRiUVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(85182001)(64756008)(86362001)(38070700005)(66556008)(66946007)(76116006)(2906002)(66446008)(4326008)(41300700001)(8676002)(66476007)(8936002)(5660300002)(122000001)(83380400001)(38100700002)(71200400001)(966005)(478600001)(316002)(110136005)(33656002)(55016003)(52536014)(53546011)(26005)(9686003)(6506007)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amFycDBkZ1FmMEcrdnhTYWU0ZzloK3NjdFN0QmFtWEowNXhDVWJPNEllOXNs?=
 =?utf-8?B?T2E5d3Q0SjNvQ1JUeEZqWkVWTXZTN0psL1RsOGhGNVkwQWJNWFplRkJqQ2Jm?=
 =?utf-8?B?VHRrWWk1UDVKQnN6bzB0Z1paMUtTaDBwMWowTW55UU43OUhWdVFaSk5VMTVa?=
 =?utf-8?B?UW1ScWllRnFzem16dHR6R3ZCcUlhU3EyL2R0WjN1Q0xKWTM0R0RhVjJiS2ZB?=
 =?utf-8?B?LzZ6Z3dXcUNzTE1vRFlsekJhNVIvRHIzSlFaWXNYN2RqZWIrRFBvbENhUXlo?=
 =?utf-8?B?eGxyU2ZOVXJpSmlTSlVGMElrdlloc3E0MWlFVEJuMmJRWFZkVTNqTXJUbWhI?=
 =?utf-8?B?VVhNcVYwelprNGV6NUJzK1NpejVYRXhvd1FKL013ZE10Q1hOZ2w2MURUbTdD?=
 =?utf-8?B?WG1TSWxjVlpucUo4Tk1hU3laYzVoUFpub3EyVnFyZzg5S09Hczd0RkdiN3Nn?=
 =?utf-8?B?OTVBN3RwVXlZd3F5V0F0MWI3WXZzOFo5b3ZvUVNDRDg2ZndOTm1PcFVOMEE4?=
 =?utf-8?B?SS9HNVJhRGRnQys3TGtpSXBodWZjeWdTOVVibkFIMEZIWGJRZGRHUmQyOHN1?=
 =?utf-8?B?VHlEamNFYVo5Qmgvbzc2QkMwajBDUEJkYTk4blBIM0dZLzVJVWJLQkpRTE9y?=
 =?utf-8?B?ZzJYNTBWOFFZNU9DcVdOQzFUb2FBaC9ON1hyWS8reXZRZEc1dW1GTUtkUmUx?=
 =?utf-8?B?bldueSs0dC8wWXNYYXJNY05GdDlzekxjcHY1ZHE4U1NzZWlia09kbk56bEV1?=
 =?utf-8?B?dU9OV1ArSzZQOHlvWXNtR3J1dVRYd0VqbzY3QzROVGZuSnJycXhsdGloTW5t?=
 =?utf-8?B?UG1vMnM1TGVvNVBTM0o4Vkw0YzlGbEZlcHZXZk4vcmZoN0M4RzExWW1BdUxr?=
 =?utf-8?B?Q0JmRlN2RjJEMGU2eEJ1cHZubmU3UGRySU90cmZhc24yT1NQQ3hLako4b1pl?=
 =?utf-8?B?QXdDdzBERWpqWU1qeXVqcDJZZFdQakVSTTUrclFQRUliS2lITkVMUGhDbnAx?=
 =?utf-8?B?OEYyenU4MURMd2I4b3NhaStkcTZsbUxSbDdMcmFiM3Z2TjhsREtzcWg0Z0JT?=
 =?utf-8?B?amh1MVdmNDBzUU0zSUVzY1Brd29ZWnd4aG9CWjdPRHBEbHdPUUlTTHF4alJH?=
 =?utf-8?B?U21MNVpVczhZZ0szVEFxcGRCZ3pMWWQ5TFhNNzd5eW9RU08xWDNFUzNhQjlO?=
 =?utf-8?B?VngvVk91QUxieDJkRTVSRzNab3JaS1F3L3FyVWEwMW9LQS9MSTVHeUlmbVRS?=
 =?utf-8?B?WUdKRW82ZW1oeFpDbHdnZEQya0EvN3E2d1lDY29tbkg1RDg0b3A0OGhldkhr?=
 =?utf-8?B?eEVBQU5PS2ZRNzVwRklwbjNPWWJhRDJ0azNxV0ZBMkVrek1JTit1ZUFiUGt4?=
 =?utf-8?B?YUE5TDdRcW1yZ3I1cEpyWlFXL1Z6bnZpMnZWeG5ibG52cXEzTFZLWWFVcUFS?=
 =?utf-8?B?bnBEdXhvWlFkenFWVUNUc3labTJOaW5MSEZOUmwxV25DcjZiZWdXanpHdnh2?=
 =?utf-8?B?OHZFYmQ4UVk4MXVjMUlqS2FVVWRyOTBzTUgxZVo3c0xsZE04aXNvZktSWlZC?=
 =?utf-8?B?T1V2VDU3dFNybGQ1Q1B4RE1vd29aVmxUYmF0eEtJbVdnRjFIVU1qWUV4MmpG?=
 =?utf-8?B?SjJWVFczcm1DYm5sK1JpSGFObWNwQlRzSmxVN2t1Ulh2UGQwSC9CcW5rUW16?=
 =?utf-8?B?RHJaM0VXditiUHVtMXk0d0pIVkhzaUVCTjQvL2N5dVRxSjNmazRPY2taRUNB?=
 =?utf-8?B?bEpoeXhWaGVlOVhKQ0MwbFhaSGxDNzQzOTNwNHlkUDVPRXlKL1FaSlE1M21L?=
 =?utf-8?B?SGVkdHNFajQvMkV3dkFCUzMwcWxId2E5emI4RWRoWk9IMzd0clZVVWZFUkZW?=
 =?utf-8?B?enZRY1dsRGE3ME1GYVArdjgxTSt4R2VnTFg4ZkRxL09aTE0xdS9ESjduM29R?=
 =?utf-8?B?L0dKUHRROUhZUmFCMjRCZWEzY0c5VSsvaWhrdFNMSndCTEhwYmc3dytRUU9X?=
 =?utf-8?B?d3NoQVE5aXpCYmMrZ0xaek9wL0l0amJGSHM4UzRCVUNGWUFWTS9mVFpUYjh3?=
 =?utf-8?B?YUNjVU1RK3dYV1ArYjE1ZlFDTU1JK2NlMzVFOWRxazg1cDM4KzVlSXdCbUV3?=
 =?utf-8?B?TW8rVzJLVFpkZ0hYVjEvdEpYS2JzWENlSjdKWWlNc3BHcGFldUdyZERSbldi?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07730f5b-ace7-4f18-ba83-08daee387821
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 09:45:52.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONRvbX9yN6SLxC3FWGCkJWvBZoXSq4YtIEEPDHKB69+tFG4+3mL33Jz6l0X/CIMQQs1KG1eJCP9ZvH8m3B5t/QWERcGVyNO8av2te6jxP0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10284
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 09:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10295

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYQ0KPlNlbnQ6IDA0IEphbnVhcnkgMjAyMyAxMzoxNw0KPlRvOiBIZW5uaW5n
IFNjaGlsZCA8aGVubmluZy5zY2hpbGRAc2llbWVucy5jb20+OyBweWxhIHZlbmthdGEo77y077yz
77yp77ywDQo+VE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS10c2lwLmNv
bT4NCj5DYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IFdhbmcgSmluZyA8d2FuZ2pp
bmdAc2llbWVucy5jb20+DQo+U3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV1b
UEFUQ0ggNC82XSBrYXM6IHNldCBjbGVhciB0ZXh0IHJvb3QgcGFzc3dvcmQNCj4NCj5PbiAwMy4w
MS4yMyAyMToxOCwgSGVubmluZyBTY2hpbGQgd3JvdGU6DQo+PiBBbSBUdWUsIDMgSmFuIDIwMjMg
MjA6MDg6NTQgKzAxMDANCj4+IHNjaHJpZWIgSGVubmluZyBTY2hpbGQgPGhlbm5pbmcuc2NoaWxk
QHNpZW1lbnMuY29tPjoNCj4+DQo+Pj4gQW0gVHVlLCAzIEphbiAyMDIzIDE5OjAzOjEzICswMTAw
DQo+Pj4gc2NocmllYiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPjoNCj4+Pg0K
Pj4+PiBPbiAwMi4wMS4yMyAxODowOCwgSGVubmluZyBTY2hpbGQgd3JvdGU6DQo+Pj4+PiBUaGUg
Y29tbWVudCBhYm92ZSB0aGUgaGFzaCBsb29rcyB3ZWlyZC4gTWlnaHQgYXMgd2VsbCB3cml0ZSBp
dA0KPj4+Pj4gaHVtYW4gcmVhZGFibGUuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSGVu
bmluZyBTY2hpbGQgPGhlbm5pbmcuc2NoaWxkQHNpZW1lbnMuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+
PiAga2FzLWNpcC55bWwgfCA0ICsrLS0NCj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9rYXMtY2lw
LnltbCBiL2thcy1jaXAueW1sIGluZGV4DQo+Pj4+PiAxMGY0NTk0MzM0ZDYuLmI5NzBmMzljY2Ix
MyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2thcy1jaXAueW1sDQo+Pj4+PiArKysgYi9rYXMtY2lwLnlt
bA0KPj4+Pj4gQEAgLTM3LDggKzM3LDggQEAgbG9jYWxfY29uZl9oZWFkZXI6DQo+Pj4+PiAgICAg
IElTQVJfQ1JPU1NfQ09NUElMRSA9ICIxIg0KPj4+Pj4gICAgcm9vdF9wYXNzd29yZDogfA0KPj4+
Pj4gICAgICBVU0VSUyArPSAicm9vdCINCj4+Pj4+IC0gICAgIyAncm9vdCcNCj4+Pj4+IC0gICAg
VVNFUl9yb290W3Bhc3N3b3JkXSA9ICJvQzN3RUdsNzk5dFpVIg0KPj4+Pj4gKyAgICBVU0VSX3Jv
b3RbcGFzc3dvcmRdID0gInJvb3QiDQo+Pj4+PiArICAgIFVTRVJfcm9vdFtmbGFnc10gPSAiY2xl
YXItdGV4dC1wYXNzd29yZCINCj4+Pj4+DQo+Pj4+PiAgZW52Og0KPj4+Pj4gICAgRElTVFJPX0FQ
VF9QUkVNSVJST1JTOiAiIg0KPj4+Pg0KPj4+PiBTZWVtcyB3ZSBoYXZlIHNvbWUgY29uZmxpY3Qg
bm93IHdpdGggc2V0dGluZ3Mgb2YgdGhlIHNlY3VyaXR5IGltYWdlOg0KPj4+Pg0KPj4+PiBodHRw
czovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2pvYnMv
MzU0ODIwMA0KPj4+PiA2MjANCj4+Pj4NCj4+Pg0KPj4+IExvbC4gSXQgaXMgbm90IHRvbyBpbXBv
cnRhbnQgYWZ0ZXIgYWxsLiBOb3Qgc3VyZSB3aGljaCBjb21wb25lbnQNCj4+PiB0aGVyZSBjYXVz
ZXMgdGhlIGlzc3VlLiBCdXQgaWYgaXQgbmVlZHMgdG8gYmUgdHJpY2tlZCB0byBhY2NlcHQgYQ0K
Pj4+IGhhc2hlZCBzaG9ydCBwYXNzd29yZCAuLi4ga2VlcCB0aGUgaGFzaC4NCj4+DQo+PiBTbyBw
bGVhc2UgcmVtb3ZlIGZyb20gbmV4dCwgd2UgZG8gbm90IG5lZWQgdGhpcyBvbmUuDQo+Pg0KPg0K
Pkkgd291bGQgcHJlZmVyIHRvIHVuZGVyc3RhbmQgdGhlIHRlY2huaWNhbCByZWFzb24gYW5kIHRo
ZW4gZGVjaWRlIGlmIHRoZSBjdXJyZW50DQo+YnJlYWthZ2UgaXMgZGVzaXJhYmxlLCBhbHNvIGZy
b20gSXNhciBwZXJzcGVjdGl2ZSwgb3IgaWYgd2Ugc2hvdWxkIGNoYW5nZQ0KPnNvbWV0aGluZyBt
YXliZSBldmVuIGluIElzYXIgdG8gYWNjb3VudCBmb3IgdGhpcy4NCj4NCj5JIHN1cHBvc2UgdGhl
IGNvbmZsaWN0IGNvbWVzIGZyb20gc29tZXRoaW5nIGluIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAt
DQo+cHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vYmxvYi9tYXN0ZXIvcmVjaXBlcy1j
b3JlL3NlY3VyaXR5LQ0KPmN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0Lg0KPkFkZGluZyBh
bHNvIFZlbmthdGEuDQo+DQoNCkkgdGhpbmsgdGhlIGVycm9yIGlzIGJlY2F1c2UgdGhlIHNlY3Vy
aXR5IGN1c3RvbWl6YXRpb24gaXMgZW5hYmxlZCB3aXRoIHBhbSB0byBhY2NlcHQgb25seSBzdHJv
bmcgcGFzc3dvcmQsIHNvIGl0IGlzIG5vdCBhbGxvd2luZyB0aGUgc2ltcGxlIHBhc3N3b3JkIGFz
ICJjbGVhci10ZXh0LXBhc3N3b3JkIi4NCg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVj
aG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCg==


