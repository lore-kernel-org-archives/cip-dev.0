Return-Path: <SRS0=4ICD=NK=lists.cip-project.org=bounce+64572+6699+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64239C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 08:55:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FAB61100
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 08:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1FAB61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BDQTYY4521723xkeT8MucKaX; Thu, 19 Aug 2021 01:55:42 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.66798.1629363339768486048
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 01:55:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 17J8tahh009133; Thu, 19 Aug 2021 17:55:36 +0900
X-Iguazu-Qid: 2wHHK91O6pqT3pnzV9
X-Iguazu-QSIG: v=2; s=0; t=1629363336; q=2wHHK91O6pqT3pnzV9; m=agyuBT24qplaxcGDPd7reQ9wJKMtOTeAdDDxskAR3RI=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 17J8tZkb009411
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Aug 2021 17:55:35 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 24AC51000BE
	for <cip-dev@lists.cip-project.org>; Thu, 19 Aug 2021 17:55:35 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 17J8tY0U029254
	for <cip-dev@lists.cip-project.org>; Thu, 19 Aug 2021 17:55:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcWvjDgJ4sphC8FnJ0ZXwfzqZFjHSNJChUh9U5DXXPBmi+TMQrDuEW8TKlrkByIKWFXU0ftIzXD0aPnsmxK1s/+2y6wcq79IUMiaQPUBwZHC9w8uStuBpOYxEUHvzxi75rTKWPvZ+vRpCWJMK37ZGeuilIBqnqARZbpry5Cw2FARZj6pc0GHYVrvQyeoMhNh+6q4SW7j0mnAYii68zTrk2ZNe5AAUN8lkMhvjI//jRP5txh7NPfz4xwPw+6RqKyOsAy0mI2qd3mO+cSwwqK/fPBH5jlLDxoT/G80FST2pV0S1Qga2mivePfKFOt3ERlt2hfIWMZaur6Jup7rFQ/KAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTyRKdA3kgVRFhGL/iRpnG3sPGOsc4o5zaxYvXi4kNM=;
 b=TTo5dILE1TTvoyJ5RfOkG50802DF3rKTxUsIUHwCvC+VcZ3LrmAzmYqgEThK/M9P10eLpUGjj5puW/qBnOyZzG9OaCWz65mZKBx2EyyMVeAYQ2vaGys/AeTDFySdK8DMNwhMH7xqPagQBoQVAlSAASutstpPjDg1mJUj9cMtOyUedw68dK4jAC+pN5kBQqprSKtvCEvG2p/peE+0zfsuNVmhyTt2E+EAdXEYP4a3L5nJ7UpbGuNcfdOlSIiga+VbX3KmNd863z0bKXWKxZXA/2LPZn2St4bOdRNTK/YNTAg845JoEvPBJR5WiVTWCYUnaHuPHEaay3mmb9gxdhSDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entries this week
Thread-Topic: [cip-dev] New CVE entries this week
Thread-Index: AQHXlI8UessWnlzJk0iT0Jfenb+JOKt6aW4AgAAbSsA=
Date: Thu, 19 Aug 2021 08:55:32 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252AEAB34D5F6C5CA663A5792C09@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
 <20210819071021.GB32099@amd>
In-Reply-To: <20210819071021.GB32099@amd>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fee4533-b210-4a0b-465f-08d962ef1a65
x-ms-traffictypediagnostic: TYYPR01MB6604:
x-microsoft-antispam-prvs: <TYYPR01MB66048884DC87207877AE1B3992C09@TYYPR01MB6604.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: Fe41nM//X1aOkOdAVCnhje+MwW/oi5q0lTxLKML+68IHW0kA1H+8vnaKyEFfGpfQt+Fif1Bf7D0UcfxZ0elN2W+iu7juxfWQrwaiu6im9jvaKSBJCzkxdqpHSInQqGnIstLKca30F27iJPUBxkFA+JG5k10YIi3U5qYcSLe2xE/eRxUuJSmE8YKjO4GAC/6MsurkvHsqE9Nb1cck4Y87NrUQvabmZwFQuBcGtFatqcMPUp2zEikA1M0/DXFouSFNMxPq9QQeu6cOFYynM/0Wya52HBTXLYBigF3UlZB7yFnDUdjW54Bixy85Qi8hY3cFBeyJZAaFIlky67BNMWTPOF0bGkZ8R9Zs9TQ9v7B+FamljYNyflbOPgJq/31Jip01s2RDADSI12w/EghA+Z7Uu/dbNNEpEsShXMno7AuymSANQOIo/4mS9SHAeiouVLV/txEyB8c6OxjoSavOz9OMk6PhWdl2QSoH2l4+USNBuU95ISrQkCTnJVtwr2i1T2qaAgj4TR4Z0S1Jx/vcWSzq5kzwhNSsBSxrY4yNlOpx0/TPTRVAKUJgwHqmt4MKV4UNJuFSk0quO0pbhzpH6MtMMR2Bgg/EI1y9+eJ57RoTOQR0fS00l6P4NZ/q1trCNjBBiq5Xz6aZG1iSQIIsKKeX3+lbgc3ojXYBV18QW/vqcoyLYjOmBB3ynhpQjaIhtslnZxWUMK9YkHRyzt7P2861DvQm9uv4qH4aAadU4FViHwOpvh4o4Y0SUzllcNfGYBpw01idd7xUGSJjW4xDdOzkqhEnPoH7Qp0RoK+A++fy8FI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUt4azJWTDBMdjgyZHhSSTVwVmNvN1FGLzl3bnY0N1VsZlRTcUR5SlMza0xN?=
 =?utf-8?B?NmhPSUVoaXp6WkFDSHRGUVBYbTR3dEkrempocUR6VU55eGFMK1A0OFZQSWRB?=
 =?utf-8?B?UkpMM2VkSUpSV3lSREdua3J0ODNSV0RJYVNsWFl4Z09zaHlCcndDbSsxc0FT?=
 =?utf-8?B?eWMzQVFoaHBLQUFjWW5oYnkrdGYwZ21xd1VhSVZlM3Zrdk5Ec0cySmhQcyti?=
 =?utf-8?B?REJPVEx1b2RzQmx4M1dhdGxvUmQvcC95cU1SQ2FCcnlaaWFSR2lSZWZhazBQ?=
 =?utf-8?B?UkdQN0NOa1NTWUdXNWdHSXc5ZFRHZEQyQjRMZ0ZsNzYySXpmb1piWHNGZExH?=
 =?utf-8?B?Ym5lNm1odncxdHRjbVhrNGVCeXVBT1FKdDJ5aEZzWkFteStEa21TUStKN2Zs?=
 =?utf-8?B?VHpzdlJrQ0V0eTFObHBPMzVOa2FMNk0raWwweUZRNEM5eTBscjlWRnErQUJ6?=
 =?utf-8?B?VGc5RVkzVS9EWTNsSnJ3VEtMNEltN0twR09xSkNKU0pENVlYNlh2Z1RFWTBu?=
 =?utf-8?B?SXhMRUUzYWRraWIvU1JHcE84WVpUNzRaZi9SZHg4ZGRmT3h3NUNYL3FLMG9M?=
 =?utf-8?B?WXpYUXYrclBsMU9pQjFOeG5CTUhVNE41ZktBSmF0VzNMQithNDNaQ0d3QUox?=
 =?utf-8?B?QVJlbVcra2ZSampSQXpsdUJTUldDMUlvZTNrMXlqNVR2cmdnblRnYzFOZERX?=
 =?utf-8?B?bU5JZEJ0alVnUWpsQmVDWGtwWTRIZ05LODJ4ZUZNdVkxdmxGeXQ3WENCamsy?=
 =?utf-8?B?YWdGSldwNFpTbGVKemNmbmFxU1FqalJ4NlZQWTJYK0NPbWFhSjk0UHlWdVRq?=
 =?utf-8?B?aW1MNVRqN3NCdW9IbTRKTHFkTWFoQncrM2FZRHFPYzl5K0NESW5icUNWUC92?=
 =?utf-8?B?NUcvL2dBblloWnAybFZQR1YyTWhVR3pBYVRSUUowL0hBUHl5RWVpeWhWTjVs?=
 =?utf-8?B?UmpzVzhOcHJMOVdNWGFXQzhXSFlLMmU0ZHJJeGkxeDVzdnhKTUhxTmE3K3Qy?=
 =?utf-8?B?ckZyT2VSUmg3eFliUEJSc1ZzOGNFNS9Meno4V21VZG54MERIbVZndFVqK0cv?=
 =?utf-8?B?N0d6SlBMeTNOZzRWTWZUaVBpQnlwYW4rbUZQQlJ6dExLSGJkdnZoOWc3V1dR?=
 =?utf-8?B?enczUVlucDh6N0pseWhhYXhCcDhOVVoxSWZUVHNVejZGZlN0THI2aWlXOEw5?=
 =?utf-8?B?YmNnM25CcXNGclJlaGl1U0k2RktMcWd6TTFoVU11MGlNamhnNDFMSjJRc3BH?=
 =?utf-8?B?S1F2dUNoZ0lEdVNzS1JLd1JHaTRkblhWRzdUMnpabjlQZjk0ZEwvMlo2WVYr?=
 =?utf-8?B?SW5lYmpaK2thMzdNQllQVDU3TG1UMDJlZk1sZ3NLSVpURm93T3QxcHlZNkZ4?=
 =?utf-8?B?MWFNQ29VT0pPQWpsVDM1dnQ1SGhaajRJYmlMcHB2YWg5YU9VNmdCeEJqR0U0?=
 =?utf-8?B?WG5rak5LVWhONGtnZDE2aURDUm50Mm13V3B1K3JMMHdtYm5lU205VUtUYUdD?=
 =?utf-8?B?elN2eWpZVlBna2FrVCtKMkJ6SVhvanV4UWNIWVAybjJVeW53VmM3V1p0VW1C?=
 =?utf-8?B?alJlczkyQUVQL29mY3VYd0FJRXR2dzU0OWxDdldVZUorS1REWWU3OGlTR2Q5?=
 =?utf-8?B?OUNzM25oRnlaTGMrQW5GaTJ1alErNG5aTGJOQnNtcVRxM1k1M0l4ckJhY2RB?=
 =?utf-8?B?VlN3STN0Q1lkVW5rbXhFY3RJOWZmUS9qY2F1OWZ3K3BOTm5jRFlBN0tpdHo0?=
 =?utf-8?Q?MHzJs+OFiisxnBO26Se0ErS6l43iVXF4fB5nCX5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fee4533-b210-4a0b-465f-08d962ef1a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 08:55:32.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOPfG/tqnP47Ury6emnYuHdCE1fMSwnbOlsoVYpBsrbqoUPYxgz/vLq6SgrJioUESy0KARvJwl8/tzugRr99ZToUPfXoHGZETziJAPRXsrOVarJ/wKA01Ie4b1aq0emG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6604
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DMsSOB7evek5T0JhWCY7wNHSx4520388AA=
Content-Type: multipart/mixed; boundary="4FFibIIe7lqyxYDao6iX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629363342;
 bh=Ueq3F08S7VnjfyS44peHIKToV29w95trnbYAP9FS+bM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=xM3ZTXOBUdftJfTgvlDaReQK3/ADVAcHp5hhpdIhNvXylDceoN4Cwto4yiZI+KkAk6L
 Gy3o0kAiW0F0VYHCQtyyYMDg20z00aI+Npdd7Za+cZQu8rfXEGPINJbednl7C7iEblqdS
 lOehlAO5ViVY1N+ZFWIbQEhpdTyk/KbzPUg=

--4FFibIIe7lqyxYDao6iX
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDE5LCAy
MDIxIDQ6MTAgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gTmV3IENWRSBlbnRyaWVzIHRoaXMgd2Vlaw0KPiANCj4gSGkhDQo+
IA0KPiANCj4gPiBDVkUtMjAyMS0zODE5ODogS1ZNOiBYODY6IE1NVTogVXNlIHRoZSBjb3JyZWN0
IGluaGVyaXRlZCBwZXJtaXNzaW9ucw0KPiA+IHRvIGdldCBzaGFkb3cgcGFnZQ0KPiA+DQo+ID4g
VGhpcyB2dWxuZXJhYmlsaXR5IGhhcyBiZWVuIGludHJvZHVjZWQgc2luY2UgMi42LjIwLXJjNCBz
byA0LjQgYWZmZWN0cw0KPiA+IHRoaXMgQ1ZFIGJ1dCBwYXRjaCBkaWRuJ3QgYXBwbHkgdG8gNC40
DQo+ID4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8xNjIzNTg0NTA5NDQxODZAa3Jv
YWguY29tLykuIDQuMTkgYWxzbw0KPiA+IGZhaWxlZCB0byBhcHBseSB0aGlzIHBhdGNoIGJ1dCBi
YWNrcG9ydCBwYXRjaCBoYXMgYmVlbiBtZXJnZWQNCj4gPiByZWNlbnRseShodHRwczovL2xvcmUu
a2VybmVsLm9yZy9zdGFibGUvMjAyMTA4MTIxNzQxNDAuMjM3MDY4MC0xLW92aWRpdS5wYW5haXRA
d2luZHJpdmVyLmNvbS8pLg0KPiA+DQo+IA0KPiBJIHRyaWVkIHRvIGxvb2sgYXQgdGhpcywgYW5k
IGl0IGlzIHJhdGhlciBub24tdHJpdmlhbC4gSW4gcGFydGljdWxhciwNCj4gSSdkIG5vdCBrbm93
IGhvdyB0byB0ZXN0IGl0LiBJIGVuZGVkIHVwIHdpdGggdGhpcyBwYXRjaCwgYnV0IGl0IGlzIG5v
dA0KPiBldmVuIGNvbXBpbGUtdGVzdGVkLg0KDQpUaGFua3MgZm9yIHlvdXIgd29yay4gSSBqdXN0
IGNoZWNrZWQgdGhpcyBpc3N1ZS4NCg0KVGhpcyBwcm9iYWJseSB3b24ndCBjb21waWxlIGJlY2F1
c2UgdGhlIHdhbGtfbnhfbWFzayB2YXJpYWJsZSBpc24ndCB3ZWxsIGRlZmluZWQuDQpJIHRoaW5r
IHdlIG5lZWQgdG8gYmFja3BvcnQgYSBwYXRjaCBmb3IgdGhpcyB2YXJpYWJsZSBvciBjcmVhdGUg
YW5vdGhlciBwYXRjaC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAJCQkJCQkJCVBhdmVsDQoN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vdmlydHVhbC9rdm0vbW11LnR4dCBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbW11
LnR4dA0KPiBpbmRleCBiNjUzNjQxZDQyNjEuLmVlNWJkMTZhMDg1NiAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9tbXUudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
dmlydHVhbC9rdm0vbW11LnR4dA0KPiBAQCAtMTUyLDggKzE1Miw4IEBAIFNoYWRvdyBwYWdlcyBj
b250YWluIHRoZSBmb2xsb3dpbmcgaW5mb3JtYXRpb246DQo+ICAgICAgc2hhZG93IHBhZ2VzKSBz
byByb2xlLnF1YWRyYW50IHRha2VzIHZhbHVlcyBpbiB0aGUgcmFuZ2UgMC4uMy4gIEVhY2gNCj4g
ICAgICBxdWFkcmFudCBtYXBzIDFHQiB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UuDQo+ICAgIHJvbGUu
YWNjZXNzOg0KPiAtICAgIEluaGVyaXRlZCBndWVzdCBhY2Nlc3MgcGVybWlzc2lvbnMgaW4gdGhl
IGZvcm0gdXd4LiAgTm90ZSBleGVjdXRlDQo+IC0gICAgcGVybWlzc2lvbiBpcyBwb3NpdGl2ZSwg
bm90IG5lZ2F0aXZlLg0KPiArICAgIEluaGVyaXRlZCBndWVzdCBhY2Nlc3MgcGVybWlzc2lvbnMg
ZnJvbSB0aGUgcGFyZW50IHB0ZXMgaW4gdGhlIGZvcm0gdXd4Lg0KPiArICAgIE5vdGUgZXhlY3V0
ZSBwZXJtaXNzaW9uIGlzIHBvc2l0aXZlLCBub3QgbmVnYXRpdmUuDQo+ICAgIHJvbGUuaW52YWxp
ZDoNCj4gICAgICBUaGUgcGFnZSBpcyBpbnZhbGlkIGFuZCBzaG91bGQgbm90IGJlIHVzZWQuICBJ
dCBpcyBhIHJvb3QgcGFnZSB0aGF0IGlzDQo+ICAgICAgY3VycmVudGx5IHBpbm5lZCAoYnkgYSBj
cHUgaGFyZHdhcmUgcmVnaXN0ZXIgcG9pbnRpbmcgdG8gaXQpOyBvbmNlIGl0IGlzDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rdm0vcGFnaW5nX3RtcGwuaCBiL2FyY2gveDg2L2t2bS9wYWdpbmdf
dG1wbC5oDQo+IGluZGV4IDdiZThhMjUxMzYzZS4uY2ViY2Y3YjI5YjE1IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni9rdm0vcGFnaW5nX3RtcGwuaA0KPiArKysgYi9hcmNoL3g4Ni9rdm0vcGFnaW5n
X3RtcGwuaA0KPiBAQCAtMTAwLDggKzEwMCw4IEBAIHN0cnVjdCBndWVzdF93YWxrZXIgew0KPiAg
CWdwYV90IHB0ZV9ncGFbUFRfTUFYX0ZVTExfTEVWRUxTXTsNCj4gIAlwdF9lbGVtZW50X3QgX191
c2VyICpwdGVwX3VzZXJbUFRfTUFYX0ZVTExfTEVWRUxTXTsNCj4gIAlib29sIHB0ZV93cml0YWJs
ZVtQVF9NQVhfRlVMTF9MRVZFTFNdOw0KPiAtCXVuc2lnbmVkIHB0X2FjY2VzczsNCj4gLQl1bnNp
Z25lZCBwdGVfYWNjZXNzOw0KPiArCXVuc2lnbmVkIGludCBwdF9hY2Nlc3NbUFRfTUFYX0ZVTExf
TEVWRUxTXTsNCj4gKwl1bnNpZ25lZCBpbnQgcHRlX2FjY2VzczsNCj4gIAlnZm5fdCBnZm47DQo+
ICAJc3RydWN0IHg4Nl9leGNlcHRpb24gZmF1bHQ7DQo+ICB9Ow0KPiBAQCAtMzU0LDYgKzM1NCw5
IEBAIHJldHJ5X3dhbGs6DQo+ICAJCXB0ZV9hY2Nlc3MgPSBwdF9hY2Nlc3MgJiBGTkFNRShncHRl
X2FjY2VzcykodmNwdSwgcHRlKTsNCj4gDQo+ICAJCXdhbGtlci0+cHRlc1t3YWxrZXItPmxldmVs
IC0gMV0gPSBwdGU7DQo+ICsNCj4gKwkJLyogQ29udmVydCB0byBBQ0NfKl9NQVNLIGZsYWdzIGZv
ciBzdHJ1Y3QgZ3Vlc3Rfd2Fsa2VyLiAgKi8NCj4gKwkJd2Fsa2VyLT5wdF9hY2Nlc3Nbd2Fsa2Vy
LT5sZXZlbCAtIDFdID0gRk5BTUUoZ3B0ZV9hY2Nlc3MpKHB0X2FjY2VzcyBeIHdhbGtfbnhfbWFz
ayk7DQo+ICAJfSB3aGlsZSAoIWlzX2xhc3RfZ3B0ZShtbXUsIHdhbGtlci0+bGV2ZWwsIHB0ZSkp
Ow0KPiANCj4gIAlpZiAodW5saWtlbHkocGVybWlzc2lvbl9mYXVsdCh2Y3B1LCBtbXUsIHB0ZV9h
Y2Nlc3MsIGFjY2VzcykpKSB7DQo+IEBAIC0zOTIsMTAgKzM5NSwxMSBAQCByZXRyeV93YWxrOg0K
PiAgCQkJZ290byByZXRyeV93YWxrOw0KPiAgCX0NCj4gDQo+IC0Jd2Fsa2VyLT5wdF9hY2Nlc3Mg
PSBwdF9hY2Nlc3M7DQo+IC0Jd2Fsa2VyLT5wdGVfYWNjZXNzID0gcHRlX2FjY2VzczsNCj4gKwl3
YWxrZXItPnB0X2FjY2VzcyA9IEZOQU1FKGdwdGVfYWNjZXNzKShwdF9hY2Nlc3MgXiB3YWxrX254
X21hc2spOw0KPiArCXdhbGtlci0+cHRlX2FjY2VzcyA9IEZOQU1FKGdwdGVfYWNjZXNzKShwdGVf
YWNjZXNzIF4gd2Fsa19ueF9tYXNrKTsNCj4gIAlwZ3ByaW50aygiJXM6IHB0ZSAlbGx4IHB0ZV9h
Y2Nlc3MgJXggcHRfYWNjZXNzICV4XG4iLA0KPiAtCQkgX19mdW5jX18sICh1NjQpcHRlLCBwdGVf
YWNjZXNzLCBwdF9hY2Nlc3MpOw0KPiArCQkgX19mdW5jX18sICh1NjQpcHRlLCB3YWxrZXItPnB0
ZV9hY2Nlc3MsDQo+ICsJCSB3YWxrZXItPnB0X2FjY2Vzc1t3YWxrZXItPmxldmVsIC0gMV0pOw0K
PiAgCXJldHVybiAxOw0KPiANCj4gIGVycm9yOg0KPiBAQCAtNTU1LDcgKzU1OSw3IEBAIHN0YXRp
YyBpbnQgRk5BTUUoZmV0Y2gpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3ZhX3QgYWRkciwNCj4g
IHsNCj4gIAlzdHJ1Y3Qga3ZtX21tdV9wYWdlICpzcCA9IE5VTEw7DQo+ICAJc3RydWN0IGt2bV9z
aGFkb3dfd2Fsa19pdGVyYXRvciBpdDsNCj4gLQl1bnNpZ25lZCBkaXJlY3RfYWNjZXNzLCBhY2Nl
c3MgPSBndy0+cHRfYWNjZXNzOw0KPiArCXVuc2lnbmVkIGludCBkaXJlY3RfYWNjZXNzLCBhY2Nl
c3M7DQo+ICAJaW50IHRvcF9sZXZlbCwgZW11bGF0ZSA9IDA7DQo+IA0KPiAgCWRpcmVjdF9hY2Nl
c3MgPSBndy0+cHRlX2FjY2VzczsNCj4gQEAgLTU4Niw2ICs1OTAsNyBAQCBzdGF0aWMgaW50IEZO
QU1FKGZldGNoKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGd2YV90IGFkZHIsDQo+ICAJCXNwID0g
TlVMTDsNCj4gIAkJaWYgKCFpc19zaGFkb3dfcHJlc2VudF9wdGUoKml0LnNwdGVwKSkgew0KPiAg
CQkJdGFibGVfZ2ZuID0gZ3ctPnRhYmxlX2dmbltpdC5sZXZlbCAtIDJdOw0KPiArCQkJYWNjZXNz
ID0gZ3ctPnB0X2FjY2Vzc1tpdC5sZXZlbCAtIDJdOw0KPiAgCQkJc3AgPSBrdm1fbW11X2dldF9w
YWdlKHZjcHUsIHRhYmxlX2dmbiwgYWRkciwgaXQubGV2ZWwtMSwNCj4gIAkJCQkJICAgICAgZmFs
c2UsIGFjY2VzcywgaXQuc3B0ZXApOw0KPiAgCQl9DQo+IA0KPiANCj4gLS0NCj4gREVOWCBTb2Z0
d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBE
ZW5rDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBH
cm9lYmVuemVsbCwgR2VybWFueQ0K


--4FFibIIe7lqyxYDao6iX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6699): https://lists.cip-project.org/g/cip-dev/message/=
6699
Mute This Topic: https://lists.cip-project.org/mt/84986288/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4FFibIIe7lqyxYDao6iX--
