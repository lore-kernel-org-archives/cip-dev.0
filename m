Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A541FC433EF
	for <webhook@archiver.kernel.org>; Sun, 24 Jul 2022 05:40:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.13879.1658641244670571987
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Jul 2022 22:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 26O5efdu023566;
 Sun, 24 Jul 2022 14:40:42 +0900
X-Iguazu-Qid: 34trVKjOPfjPCJQeFU
X-Iguazu-QSIG: v=2; s=0; t=1658641241; q=34trVKjOPfjPCJQeFU;
 m=H0161pDj3MQf3DoyTCnZ8DC+mstBOuBAMtf/ewcMRxE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 26O5eed7016902
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 24 Jul 2022 14:40:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA9/crDPQnVdHGiePmETgY4zHxlkbbxVXRftfvViTIZzjSZRQmMLg5aCMsA61ILlQSugP9UKn/0Ss7Iu7PADikKaBonycND1feOfNkR8iNrDmcLkx4zg4XM/hcSqN5uGkXS3MW4TmoTSPL8PWhnfxPPqbfukcJMZPEVlNupGw4gZsI9vwsXsr31LFEAVdPvS3k/Nvo4jQEmmdRYesztQF6xWU/UtH5EnC2Y/pxbXpW+WnUDCM9k7WNjKsl+JWS6dZauwSWZFVb6jn0xR5V7kqZJb5/v1RRYGO6shZ83kM/cQRxfHzyXmYOUNd2m4T2bkbemU5Rj7dKhEIk+cpyznOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBm6XsLyK/CfCOjewrTsw+cohiB6zsqTSlz1PNkT4x4=;
 b=KvfkGzKWnwYQWVXnIYLYzDoi5Om41sXHnshI6fS/4dBS8UMCGnlRaZcWHyRYcQXls81I9gGFasF70+MaO3jeCFuMUlqHxej5g63yG+XYZYbjUP3W03ZqzHGDY2UmyBxYxCdbKK2UdXNMxBofB8iWr+f8sqjq0coGoV34r7NupCNifjGte3KYw3BS4trvAwENuMq/5vRNLxL8WQe8qz4peGRPMxf2Q6JGHShMGLWqZcREFybgLGXlwwLd0avS0ibJzUQlQU9GUNpnLXi9PNi0pb5Lb6vYBQp7WxWfLpxCcxaxwRIo9y39WORU1QHLMxuIZSWVtcbdzZjgBug7tv9gOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] security-customizations: Fix pam_tally2
 deprecation
Thread-Topic: [isar-cip-core] security-customizations: Fix pam_tally2
 deprecation
Thread-Index: AQHYnrkdjZwX9558tUywHnkiCTXWz62M+utA
Date: Sun, 24 Jul 2022 05:40:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542DB553157E82974F75F53A4929@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
 <c63a7711-155a-7b0f-2109-1ffc4513954d@siemens.com>
In-Reply-To: <c63a7711-155a-7b0f-2109-1ffc4513954d@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac3d3989-b0f2-4f62-03ab-08da6d370955
x-ms-traffictypediagnostic: OSAPR01MB1937:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kPdJtL1vMDpz2PIUHe3KZdkoOxtgsMEfhKUtVZ0o7x/l45gVprcESpzL82caSXOVpsepcTOW9Oc8A1oLlQdtvAhsPvtHnQenn7ZL0K551s7ef+cCl/ToUCUQsVc5DpMBNHjPm3RSlaA9leo7kWzDCAx/q0xEL1EKIF0Xh/c+W0t+HXHGPrIcD/oLF/dQkjNirzryB4PL12MfJx6oWrBW3Oi0k6jffbZovIuunkwvHF2fpSaql+9vaPfVBY6kvrkCpUt5brMgYsDCaESKfMhDuffBKkkLXGC2qy9kkaFMgyYlOepQK/AS4ANTqrqU/Tzm8zeZFOn3p2+YsBjdL1948yJ5GZLG1UkCN1iSH4Bz7lsbb8J+uUgmCS7fYf67E5G997hitBTb+E9cfFJ6qGL4sdKHRUsiCNyWhMUpoFYQsc34eRd07lnrZ1GPnj/jjUmesRNfykQ6g1aecmWueGJRQH4zL/vyyM/JwUh2T4wsnpDH5Srn5k68I5/O1g4dCQzoDot3pgoPLDLc8yOkbWbS8A3OZ1aRUMGAwblRcFmhPttJTc1Jy+WIjRCGKf1DTgMd9yD0gozKeF7U8cEylDY17A8apRfVUU0/oLmTPNmIhTtLeTpgOEcUh89A+bsWDJkOlGPil6MnmAuv1vdW1BJhiil41P3syNQh7lqEOWzo9T1Lnb5JcYhPLlh/5GwnhULK40R0k+vZTVh+E9oiHPxNEJNK1E48HISYFwQpZR6Ynbz5BWac0ka23oUZXsTbnVKR04zktEJv/OOqWz480iLYMJ87Y5x9JB8AmSbK8pDf/wXdPiZUAOv7dst+8Wzbl5TgFokncQBbBNVdLOdLJTrGsw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(186003)(107886003)(55016003)(83380400001)(8676002)(71200400001)(4326008)(76116006)(66946007)(66476007)(54906003)(66446008)(64756008)(110136005)(66556008)(9686003)(85182001)(15650500001)(41300700001)(7696005)(6506007)(55236004)(26005)(2906002)(33656002)(38070700005)(86362001)(38100700002)(122000001)(8936002)(5660300002)(316002)(966005)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SUI5eE9wQ1RKSUM3QTBVdDV5K1lmcStOVWxrR2c2WVNBZ09wOXA2RWpDMFR1?=
 =?utf-8?B?RFFtRk5IRmhlSTdBQWRYUGEzSWxxYk9saitJc3IrNE1UTGFhVTlTM2o3QjZJ?=
 =?utf-8?B?bjhvR09mYnhjbDN0SE0xQ3gySmhNNEhsUHBobzgzRW9EYzB1eGlGRFVXQk5m?=
 =?utf-8?B?Q3orNFA3Y0dmQnJXc2FhM0g2eHhWNWVuQTk2ZUNNVFdwT1Fkb0QvVS80MTV2?=
 =?utf-8?B?RVVkTlB5Q2ZCSDQ2UENiWm4rSjhJQ3M1bW0xTm4yQmM1MVhXdEQ2WGY5TjFK?=
 =?utf-8?B?aFNwZUlyYk9HekExcHJjdlRWTFRHbGowMzNPbVMxcUtRVFQ4K1crNm5hZ0s3?=
 =?utf-8?B?UGE3NlVKQUk4blEweExXSGxoMFYxMTVCeUZ1aXFSNEJEWTN1bDcvdVVFK1N3?=
 =?utf-8?B?M3ZJUTljMWt0bjE2WDZvY2JvUWxEYW9Kc3hKa0czT0d5UUx2RG1CN2U4dTU0?=
 =?utf-8?B?bXEyKzJMVXFQTERJSGZBYWZPZHFjL083a2NacmdneUNGL0Q3R2x1bVJPcjF1?=
 =?utf-8?B?ZHl4VW8vOFFyOXM4Z1RtZngwMlJIUyt2cDQ3c2JvRWpXU3haemZKaVNpNHF3?=
 =?utf-8?B?VUE3eGdZd21OMmdXKzNKUWZVV1F6ZUJDRHVpelAreGUxbmdLOGIvOVdNMHA3?=
 =?utf-8?B?dVNoKzVxRXhwcUh3aWgrTWppeHo2UGU5QlJiOVJvalBZc2FvQzVvVVFObXNz?=
 =?utf-8?B?NFVLTmYxR3poalZDSkxRbjdvbnpBaVp1WUl3OWFZTDZheW5iWlRnN25YSmZ4?=
 =?utf-8?B?MGpNYlMvQ1BlWWV4ZFJkTmxZTjJVRGE5Qk1JVnFJa3VQOW9SMmR2MEpxVEh6?=
 =?utf-8?B?TlRhVU5uUTUzcGlJTkxPR1lQL0ZTa2FuaG9wQWIxd29oY2l4VHExL0Uxbm93?=
 =?utf-8?B?RnNVcldMUFJkUTZKbGVCRlloeTZIdDVRWml4aWtWK0NPS2Fob1VKaGVCVDBD?=
 =?utf-8?B?bFZmbFJrVHRIUnZhWHF5SEhPekpjcm1aRFF3MVd0aXh3eE1CcVBMZGVzWGty?=
 =?utf-8?B?czkxd1FsanlzRy81a1crT09mM0NWYXFsUXlTMFU5LzFoRW1GcWpHVitRZnFz?=
 =?utf-8?B?UncwMDdyblhWRktOQTcwd1g1Um50VWJsaUEyb0J1TnZ3VmNCaG4zVDBwbVpr?=
 =?utf-8?B?bWo1NmwyMmxidXUxd2tkTjdWTEs2S0ZUSHhpUWhFU2NHV2hVM0RtSkhPU0RM?=
 =?utf-8?B?dlZBVi9rTkJmSnVsdzRGUHc0UytXODlUWjNHendjQ0FZSUVsbXV3ZkgydHFB?=
 =?utf-8?B?c0J0WVdRNmpUWGh0YzBxMnN5dC9paVU0OTR5bjRxODFkNUtGd2tZbFcyNm85?=
 =?utf-8?B?aEZGYTRxS1FrbHFVRGhLMWJZRTh2RkFrOXRRa25nYVkxQTVOL3U2QjI5eFFj?=
 =?utf-8?B?YnA5OCtoc0tlbjlxcGZXdDU2dFVzRFhqMkJHdWpKQ2VXQmhGeDVnb2hOZmhr?=
 =?utf-8?B?QXRsOVFqSVBSUjlqQnhNT0dydzBVOFpKa0REMlc3MDNDaUNLVmFlNE5NN2VR?=
 =?utf-8?B?b0g5VHFYNjU3N0N6Szh6YmVJeEE1SnN1VnpaMHZEalFVandzZUdGSGJGNWtK?=
 =?utf-8?B?WUNCNlVLK3Q1bWFoOEJPTDIvYlkzRm05TGdla3h2aG15b3VyVlUvc3krS1N4?=
 =?utf-8?B?Z0RFNGhnayswcnprcE5Odm9uWkFvRWFIRThoNFF5MXdzTUtFTkFaUVlPTTdr?=
 =?utf-8?B?VHgrRXdvYThyME4wMXdFY2srZ08vM0JFaXl0TGJHRnpsb3doT09vcGtWMWtr?=
 =?utf-8?B?N1J3bzBWdm5jYnZyUlJlWTRDaXg4LzA0T2Uwd3AzbzFmYkk1OVprWUNEL25m?=
 =?utf-8?B?czlJOHliL2UwSGtwZ3BHSEcxZjRKWTV3akUzdFoxYURueXBhT0twc3ErTWFq?=
 =?utf-8?B?WE40UzFGdGVKaFQwMmE4Slo0azJ0SklyT0ZRZTZISTQzWWJ2UWtpY20rU09G?=
 =?utf-8?B?aHJOTUNIbTIyUTNjbm0rVHBITE4wT1JZYXFYUDhjS1pMbmlRYVgxa2NLTGo2?=
 =?utf-8?B?ckZqSjJTbVhUMERZNkFtRlVUWnVMcVFXSGxHOWd0Wm14UmNYeVNDZ1ZsUEJl?=
 =?utf-8?B?ZWVPWDNFRHg4UTNDU0dDd0N1S2RWTkpzZ012Nk1oNHhROVhSWnJoMFRBSFNj?=
 =?utf-8?B?YlZ1bGxld0Z3Rm4zTy9veDBwZkwvajJmbUpHMGhIaTdiTHRlTHNpc1RkTVVO?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac3d3989-b0f2-4f62-03ab-08da6d370955
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 05:40:37.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 NOPz43n3VkEcT1d70+GUwt+4/+vafTbBTAZVScklk3KhM2jR0eUrzyNyovt1Hof+4eqJ/2OH4xZDy+RXv5ar/n/wH3N/119Wze0sOIoPljg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1937
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Jul 2022 05:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8895

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMjMgSnVseSAyMDIyIDIyOjU0DQo+VG86IHB5bGEg
dmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9z
aGliYS0NCj50c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Q2M6IGRp
bmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJA
dG9zaGliYS0NCj50c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpDQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+
U3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXSBzZWN1cml0eS1jdXN0b21pemF0aW9uczogRml4
IHBhbV90YWxseTIgZGVwcmVjYXRpb24NCj4NCj5PbiAyMS4wNy4yMiAwODo1OSwgdmVua2F0YS5w
eWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiB2ZW5rYXRhIHB5bGEgPHZlbmth
dGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPj4NCj4+IHBhbV90YWxseTIgaXMgZGVwcmVjYXRl
ZCBmcm9tIFBBTSB2ZXJzaW9uIDEuNC4wIHRoYXQgaXMgZnJvbSBEZWJpYW4NCj4+IEJ1bGxzZXll
LCBhbmQgaW50cm9kdWNlZCBwYW1fZmFpbGxvY2sgYXMgcmVwbGFjZW1lbnQgWzFdLg0KPj4NCj4+
IE1vZGlmaWVkIHRoZSBzZWN1cml0eSBjdXN0b21pemF0aW9ucyB0byBjaGVjayBmaXJzdCBwYW1f
dGFsbHkyDQo+PiBleGlzdGVuY2UgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgYW5kIGlmIG5v
dCBmb3VuZCB1c2UgdGhlDQo+PiBwYW1fZmFpbGxvY2sgdG8gYWNoaWV2ZSB0aGUgc2FtZSBmdW5j
dGlvbmFsaXR5Lg0KPj4NCj4+IEZpeGVzICMzMw0KPj4NCj4+IFsxXSBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtcGFtL2xpbnV4LXBhbS9yZWxlYXNlcy90YWcvdjEuNC4wDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+
IC0tLQ0KPj4gIC4uLi9zZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdCAgICB8
IDE5ICsrKysrKysrKysrKysrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3Nl
Y3VyaXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0DQo+PiBiL3JlY2lwZXMtY29yZS9z
ZWN1cml0eS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdA0KPj4gaW5kZXggOWJhODU0MC4u
YWUwNmFiNyAxMDA2NDQNCj4+IC0tLSBhL3JlY2lwZXMtY29yZS9zZWN1cml0eS1jdXN0b21pemF0
aW9ucy9maWxlcy9wb3N0aW5zdA0KPj4gKysrIGIvcmVjaXBlcy1jb3JlL3NlY3VyaXR5LWN1c3Rv
bWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0DQo+PiBAQCAtMjIsMTEgKzIyLDIyIEBAIHNlZCAtaQ0K
Pj4gIjAsL15wYXNzd29yZC4qL3MvXnBhc3N3b3JkLiovJHtwYW1fY3JhY2tsaWJfY29uZmlnfVxu
Ji8iDQo+PiAiJHtQQU1fUFdEX0ZJTEUgICMgQ1IxLjExOiBVbnN1Y2Nlc3NmdWwgbG9naW4gYXR0
ZW1wdHMgICMgTG9jayB1c2VyDQo+PiBhY2NvdW50IGFmdGVyIHVuc3VjY2Vzc2Z1bCBsb2dpbiBh
dHRlbXB0cw0KPlBBTV9BVVRIX0ZJTEU9Ii9ldGMvcGFtLmQvY29tbW9uLWF1dGgiDQo+PiAtcGFt
X3RhbGx5PSJhdXRoICAgcmVxdWlyZWQgIHBhbV90YWxseTIuc28gIGRlbnk9MyBldmVuX2Rlbnlf
cm9vdA0KPnVubG9ja190aW1lPTYwIHJvb3RfdW5sb2NrX3RpbWU9NjAiDQo+PiAtaWYgZ3JlcCAt
YyAicGFtX3RhbGx5Mi5zbyIgIiR7UEFNX0FVVEhfRklMRX0iO3RoZW4NCj4+IC0gICAgICAgIHNl
ZCAtaSAnL3BhbV90YWxseTIvIHMvXiMqLyMvJyAgIiR7UEFNX0FVVEhfRklMRX0iDQo+PiArIyBw
YW1fdGFsbHkyIGlzIGRlcHJlY2F0ZWQgZnJvbSBwYW0gdmVyc2lvbiAxLjQuMC03IGlmIFsgLWYN
Cj4+ICsvbGliLyotbGludXgtZ251Ki9zZWN1cml0eS9wYW1fdGFsbHkyLnNvIF07IHRoZW4NCj4+
ICsgICAgICAgUEFNX01PRFVMRT0icGFtX3RhbGx5Mi5zbyINCj4+ICsgICAgICAgUEFNX0NPTkZJ
Rz0iYXV0aCAgIHJlcXVpcmVkICBwYW1fdGFsbHkyLnNvICBkZW55PTMgZXZlbl9kZW55X3Jvb3QN
Cj51bmxvY2tfdGltZT02MCByb290X3VubG9ja190aW1lPTYwIg0KPj4gK2VsaWYgWyAtZiAvbGli
LyotbGludXgtZ251Ki9zZWN1cml0eS9wYW1fZmFpbGxvY2suc28gXTsgdGhlbg0KPj4gKyAgICAg
ICBQQU1fTU9EVUxFPSJwYW1fZmFpbGxvY2suc28iDQo+PiArICAgICAgIFBBTV9DT05GSUc9ImF1
dGggICByZXF1aXJlZCAgcGFtX2ZhaWxsb2NrLnNvIHByZWF1dGggc2lsZW50ICBkZW55PTMNCj5l
dmVuX2Rlbnlfcm9vdCB1bmxvY2tfdGltZT02MCByb290X3VubG9ja190aW1lPTYwIFwNCj4+ICsg
ICAgICAgICAgICAgICBcbmF1dGggICByZXF1aXJlZCAgcGFtX2ZhaWxsb2NrLnNvIC5zbyBhdXRo
ZmFpbCBkZW55PTMNCj5ldmVuX2Rlbnlfcm9vdCB1bmxvY2tfdGltZT02MCByb290X3VubG9ja190
aW1lPTYwIg0KPj4gK2Vsc2UNCj4+ICsgICAgICAgZWNobyAiTm8gc3VpdGFibGUgcGFtIG1vZHVs
ZSBmb3VuZCB0byBsb2NrIGZhaWxlZCBsb2dpbiBhdHRlbXB0cyINCj4NCj5TaG91bGRuJ3Qgd2Ug
cmF0aGVyIGZhaWwgKGV4aXQgMSkgaW4gdGhpcyBjYXNlPw0KSSB0cmllZCBub3QgdG8gZmFpbCBp
biB0aGUgbWlkZGxlIG9mIGFwcGx5aW5nIHNlY3VyaXR5IGNvbmZpZ3VyYXRpb25zLA0KcmF0aGVy
IGdpdmluZyB3YXJuaW5nIHRvIHRoZSB1c2VyIGFuZCBvbmUgY2FuIGNoZWNrIGxhdGVyIHdoeSB0
aGlzIGNvbmZpZ3VyYXRpb24gaXMgbm90IGFwcGxpZWQuDQoNCj4JDQo+PiAgZmkNCj4+IC1zZWQg
LWkgIjAsL15hdXRoLiovcy9eYXV0aC4qLyR7cGFtX3RhbGx5fVxuJi8iICIke1BBTV9BVVRIX0ZJ
TEV9Ig0KPj4gKw0KPj4gK2lmIGdyZXAgLWMgIiR7UEFNX01PRFVMRX0iICIke1BBTV9BVVRIX0ZJ
TEV9Ijt0aGVuDQo+PiArICAgICAgICBzZWQgLWkgJy8ke1BBTV9NT0RVTEV9LyBzL14jKi8jLycg
ICIke1BBTV9BVVRIX0ZJTEV9Ig0KPj4gK2ZpDQo+PiArc2VkIC1pICIwLC9eYXV0aC4qL3MvXmF1
dGguKi8ke1BBTV9DT05GSUd9XG4mLyIgIiR7UEFNX0FVVEhfRklMRX0iDQo+Pg0KPj4gICMgQ1Iy
LjY6IFJlbW90ZSBzZXNzaW9uIHRlcm1pbmF0aW9uDQo+PiAgIyBUZXJtaW5hdGUgcmVtb3RlIHNl
c3Npb24gYWZ0ZXIgaW5hY3RpdmUgdGltZSBwZXJpb2QNCj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1l
bnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


