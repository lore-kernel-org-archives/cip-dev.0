Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F036CC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 09:27:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35743.1792056471126980298
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 02:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=wj9/jf1Z;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1792056468;x=1793266068;bh=+uZM2SaCRoW8Bc5HnXF4BTX7CuXJAOt5GoQI4
	Ag+xN0=;b=wj9/jf1Z3BVb/YFSDsoJ7VZrbprVs4S1PZMDMaM1bPrfcjHXQzVspdKRP8gum/VXjf4
	d2YTMA+TnwFmfv5I+VkA9CNEV93cR876dXMXkX1B3M2mAYDSp+BPyKY+4RH9JUvme0N4oXkNiNhXS
	pBwMAujnPtrKECqWPhWaSzFG7fhtyiONWym3Jx5xv4Q1x/lv5BDNlKsZmpqsu6mtneyLEVJNKaK6n
	i6BX0x4UOuelqNcuE1JwX59mojyXha0DKvaHxVUayOQxwvdui9of0JWWlsfHr06UAUfD6pkETsT7R
	QGBRHHBUCdTGiI94IGOEmJ5BP7S1Xmde1fyOr0QlPQVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69F9RmrL039921; Thu, 15 Oct 2026 18:27:48 +0900
X-Iguazu-Qid: 2yAaQEjZFNUiOCddn8
X-Iguazu-QSIG: v=2; s=1; t=1792056468; q=2yAaQEjZFNUiOCddn8; m=kQPkxqXP1wfn+RdgeNo4cHq35Ix0/SlCn/lWg+kdYtw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j52mM4fXNz1xnZ; Thu, 15 Oct 2026 18:27:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqzA0fdAou+7aHaE+ywdujInlJxGem3i5CDTX/SUwzmJPWkP7tuH5Nx4wjwe0FdSXW6OwRUz9eLrJnEcSWsagY5yHYf5zcMr5Xglj97NgotGAGikf9Nr5moI0+IueKeUavP2tuXV9bgSpPUsnfExtPWBDB5gnvhvraJKjbjk+UVgc6Zgatv3vwuL5vl2f2+6KaMjJ8YzN0BHE/OtM1YrNs804CeC43dSdvx76MEDBzjDL8M0b9xd6mk8nB9l/+oIjNOg8SwnFOtz3bs9n6teVmYU5gGPWZdLnzygIKaPK08g46Du/eyFfEo7ntsSiuaZ+ReergZtVVZIEUMpNulcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uZM2SaCRoW8Bc5HnXF4BTX7CuXJAOt5GoQI4Ag+xN0=;
 b=eyb5hqVg0q/htDfVqj8YRSiuJGi2zaVadiMyS0UOVXD3R00Ujo99KrRtbgs19f1A5XQ3NC+pXosW4jwEfBAXkxqFe5GGMsnl9IJq3J+dRZImsCNeSYUiCCYq+qlGnSbVh6WLSEOqCsnlF9eoST2m/wjEmwb855A14emWtuN4mgfE1toneyhoNC4QOPiXd+cQm9d1RyirPdfuk+bXyArSuzmKAWMTaNWPVMMkRxIIH9Lm/0sWt72CTOuWM69zO1Q30zPVhKan8d/x5wYr8BpHegvJNgjsSiW53UgUASzUZ/7ps8+MUGyIRFYv7VdHRFnhzAukg8ukJWXe6yaT9Dl69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHdXHQPnO8A3LGWHkqbNk5B40wSzrb+VAqQ
Date: Thu, 15 Oct 2026 09:27:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181C7FBC82DCEAF514B697CD9C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <76b4f5f4-8e5f-49dd-b5fd-0c35f36a5740@siemens.com>
In-Reply-To: <76b4f5f4-8e5f-49dd-b5fd-0c35f36a5740@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10795:EE_
x-ms-office365-filtering-correlation-id: 6c962fee-f859-4b12-e790-08df2a9e836f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|18002099003|22082099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 
 AlX+iCKKNnTmx/h9zz7/z1IEEFBrdFc1tqmHtAn5czdlW5eNYI7+NDug6JrWmniVtU8iSYfpyxCvXMZLSZD/AMGDeVoQbjhz7DRwTD+EyrRYrFbDLULpcvFMmfShuPmBffl3ziwqYBPoffGjzDs5PjW8fAkvm7bEGWlmJky7UwZWTRMZ2LeO5N2u6ed/+Yk6Z41YKf3ozCq6tYWPf0C3+LlP4pRdyo48vds55Uo3Ai/XKIv4sjfwKybrEGp3Xjh4wdDRNKvivRTBj8maATT+q+Q2eX2dp197Ewdx4nXgIT4M07W01RDwTlgYbZKT+7OlRaDe9Ze7FHbV1x4WXKhziNlk4fECuOCJA3Cuawg4KzEn5t6E+sac0T9YgxrBUkYPBlyCSk+raUujejLtZVDUscX2gu1k3yjD6j2y1Os8ZmqrA0KnOrdW3VbrvWkG84A4YCFEgbwWqgY4uPzCiPjLwOJdP3pLx3qbJHphJoa1MMALvijAAUvxKlEr4LnMJiZiLnO7pDFCPnN7uUYBjsprDmVUkJA64IUxisFoyZXY0FAVEnjhV+hmAKd6FRdZtNJ6D8KSuj/x0DYNGsdv6FtSYRzN1EaO35IUicsYaRcNJbW827DBV8yvWb4I7sXuAatXEPW0Iq38Mu0JTvmG2ZBdZCm6PwAHKUuS44ok84Tr3Zw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eitQamNTYnZGZ3VzeU1CdVhMdTg0SG5KTmJ3OGVTL1VOemtNL1lhQ3NrcS8y?=
 =?utf-8?B?b3FSaU5tMHZOMVFRd2FKVElmN2xremhhTWJ2MG5UUGtUNTMzTE92WnZ0Y0Mw?=
 =?utf-8?B?ZHdIN1lmdnhldFJxV1VmNUNKQ1dHZXFpbnFsbXo5ZU0rTFE2SEpUOWRQdlVB?=
 =?utf-8?B?N3JFaW5RODRyWjlPQlNUQXdBa2w2TENUY1hSZ1VCRzBjcjRuQ2NtQkpiNFpy?=
 =?utf-8?B?a3p3dTJXK1RkME0xYnk5cDR1Vi9Uazk2QVhaeFM0M3gzcll6dFVkck9pb1hM?=
 =?utf-8?B?VXY4Nm9iaXhKdlBqcjdRaEZicmFpMTUwbXY1MHN0OWVsOXpxdkZ6TFRibDBu?=
 =?utf-8?B?TCs1eUVTMjRUNGNkL1g3eU1GOWs0bFlodXF0WlJ6bW9BYXQxTFhnMitMQU4r?=
 =?utf-8?B?VDN6ZzRzOTBidU9LU2JtYzhFT0NZMnpscExEZjdSdkNuY2REakJ0djRTeGZU?=
 =?utf-8?B?Y2RoOFBwN1cycElJQ1ZLMlNhVmJ6T1BXNEpkNkNSd0puWHFWMXgxK0c4SEMv?=
 =?utf-8?B?d1FVY1NWZGRzakQwVU5RTWx3enpFaUZEb0Q3enFpMlEydE5YMnJSeUYzUVRG?=
 =?utf-8?B?YlJqd01NS0lUVnNJVG5UcFhRbzRrT0ZodGhjTzRJSlZleXJKZEdnYUphNTA4?=
 =?utf-8?B?ak51eVZEVVFJdUtJL05iK1Q2cmg5ekpxejd2d0RkMVNVMmM2NkdqekVpMCtQ?=
 =?utf-8?B?Z0NBMS9qMUphK1dCaGl3NS9XODFwcUFiZXMxWGRmZDFva05TZ0pHUktHVnpv?=
 =?utf-8?B?NTFVOUtldW1EdXB0NDNhY0lpbXVFTVpHd2hmK0ZtRmZMa3IyVEdDQmZNYVpW?=
 =?utf-8?B?YUtpeE5hd1JaUUhFeUErTTRkZmRJb1dkMStkTzFrcC9XaXoxRXYvc3lPcG9Z?=
 =?utf-8?B?eU1SaDJyOVZCRXA4ejdTVEdTZXRNVFFsSzl5b2RlRmNxZjhZRkpJU3BnK0hu?=
 =?utf-8?B?VGs3S1B0WFlKR25HaHRoVW5oVGYyVWJOajllVVJCcVpNendVdVErVkFMNlpH?=
 =?utf-8?B?NUZyMTB6WThUSkZNb1JwRmh0YlF5a0JCRU5DWjFlUW01djJqS2p6Tjd1U3dr?=
 =?utf-8?B?eTRLTXZTUGw4QTdPZHpGMUJCOEU0TWtaNGxSRkpNemNqSVlCc0N4WlJMaE1Z?=
 =?utf-8?B?VVRiNjNjQi9jTllZbnFzSDRiQWVtUjBVM1R6V0dKUzRIbGdHbzZxekpqWGhu?=
 =?utf-8?B?OTI1ZmhvTlg1dWxLSlZ3RmZNeE95czNQV3RqT3VXbHBQbVE0RUV5STBybVVW?=
 =?utf-8?B?MGpLZm5kT2xnd0VMdUVVelg0YU84L0NVdzBaZXdJd2Q0M1FqVzdEdGVZcDRE?=
 =?utf-8?B?eFNWYmg1Z094NWY2aUd6SEFDNzVhcithTXJtTmI5L3c2L0xoMFh5MjZsSUd4?=
 =?utf-8?B?WmRtSlpvY21QeWk1emp5aW1Tam1qbnNReUxoQzVCUXkvb2c4NE8xbkV1QjFI?=
 =?utf-8?B?RXZVY1FucEhLQy9EQm1IN21pb2lUUSszdTdSQkdqWXQrS3lsRWd5TU5LVno4?=
 =?utf-8?B?cFRTMkl3TDdncUtJK2xVWXJFZFRJei96dG9VS2wyenhkYzZWdS96N21mdWp3?=
 =?utf-8?B?dWt3V3VXM0RoN01iT3V0MjBYazh4c20yNEhqK1ZTK3BpSHhjUXRlWEJ3STVH?=
 =?utf-8?B?by9mT3hqK3dGSlJzRUVrQXZNSTN0cG45WHpFVkpwSVIyMk1yWE5TeXpwQmhT?=
 =?utf-8?B?VGVQTnB4RkJ2RVhZVkRyNThmVGdodlpSV0gzTS9BdUo2ck01ODJtamo3dFRh?=
 =?utf-8?B?eUY3bWorM0NvaFd0V3ZueG9ENktRcWdBMWZkdFVCNWhVamtLMk9ybldTK0lD?=
 =?utf-8?B?L1pLcHY3OWtEUmVCcDR1d3R6WFhlN1U0R1Zib3hZanIrQ1VXMVdCdHBScGJq?=
 =?utf-8?B?YzZlaFo2alMvemkzOWltNkNkNjlrZ0FtcEVTZXNUTnd0MlZWQ3hPMWlFMzl6?=
 =?utf-8?B?ZktYYVJ5NHpoT1JrQWVuZFFGNlZtaHdWUkx0QmxjT1BrOVYzeTJaVjhrdzdX?=
 =?utf-8?B?TUhEdFRpNEdudnB2aHpqeFEvc2NhTDJZQmVxT0VyK1I5YzdGZzA2Qm9qV0R6?=
 =?utf-8?B?c0lUWVBRUkQ3b0M4M2tkaUErdFhqMXdKTlBoNGg0cW1VUEgwNEZVWjRmZ1l2?=
 =?utf-8?B?Q2ZtT1oxekQxS2h6TUViQnVYekFid2x3Mms5NTVSNDRaRmluYTh4RzFGQVhC?=
 =?utf-8?B?aDBIZk0xWFZ5QTM4NGE5M3h4NS95dFppS2hXVEVBQUdTU2tobWVkTzlhMkts?=
 =?utf-8?B?bHFkMEd6NUpsUlZaWUNOVE9WOEM0cmJmUC9oU2xEWDZTNXFUdEdHdTZyU053?=
 =?utf-8?B?VUpWU2diQ3F0dWRubmVpM2ZqRGpBRXo4WmZXcTk3cCsyVEczRms2cEZXVlFh?=
 =?utf-8?Q?NhUo/HFspWD1ND9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	nYk0SH82Z34t48fKnQ3KXKo740NIjQC/ciOUFqBlpOhkv3v3EAeHLF7YKZzron7t+WSkdgaKhWC9STdnBeMxnupYqh6x5pkMoEZRBNEiyMw3631v2UH1W0T+QuC11KkVJ5cK6fNGI2NBtzMTPHdvdKvftH33Vrn76ISKl3FytCMh4hp7Sv5SJe4+KBTBE/lGsK9f3zq8ZdPYgcc41TJwagzpmYW+ar9HO6lloHnORi0p5SnTVi3PiNbXkT5OTlmUA+s2jtwD/6cuL9ISGjk7RGo4NGw20fFnO0j+aw/D9+clouFKQ+TnEii9kygubGfjNkcSIONRBcmyUr1tets0FA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c962fee-f859-4b12-e790-08df2a9e836f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:27:20.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrTl0S7TDMWudEqfZVfPQNockMylnVZTWiMc/b3F6TrMgdrsRyfk/qZAEMzK1sify8bDLMPb4A16aZclulio4xBmcTdRTol7tCmep+7siys2fJhXzxjdxPOxGlYQTGT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10795
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 09:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24472

SGksDQoNCkkgY2Fubm90IHBhcnRpY2lwYXRlIHRvZGF5J3MgbWVldGluZyBmb3IgcGVyc29uYWwg
cmVhc29uLg0KDQo+ICogQWN0aW9uIGl0ZW1zDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0
ZXMNCg0KSSByZXZpZXdlZCB2Ni4xMi4xMDcsMTA3IGFuZCAxMDguDQpBbmQgSSBhbSByZXZpZXdp
bmcgdjYuMTIuMTA5Lg0KDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KDQo+IGxpbnV4
LTYuMTIueS1jaXA6IGludGVydmFsIDE1IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2Ni4xMi4x
MTEtY2lwMzINCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiBTZXAgMjggMDk6
NTQ6MzggUE0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBUdWUgT2N0IDEzIDA5OjU0OjM4IFBN
IFVUQyAyMDI2DQo+ICAgU3RhdHVzOiAqTGF0ZSoNCg0KSSBhbSB3b3JraW5nIGZvciBMaW51eC02
LjEyLnktY2lwLg0KSSBhbSBnb2luZyB0byByZWxlYXNlIGl0IHRvbW9ycm93Lg0KDQo+ICogS2Vy
bmVsIHRlc3RpbmcNCj4gKiBBT0INCj4gICAtIC9tZSBhYnNlbnQgbmV4dCB0d28gd2Vla3MNCg0K
SSBjYW4gdGFrZW92ZXIgdHdvIHdlZWtzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYg
T2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJzZGF5
LCBPY3RvYmVyIDE1LCAyMDI2IDQ6MDkgUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVl
dGluZyB0b2RheSBvbiBsaWJlcmEuY2hhdA0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJl
IHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlz
Y3Vzcw0KPiB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4gT3VyIGNoYW5u
ZWwgaXMgdGhlIGZvbGxvd2luZzoNCj4gDQo+ICAgICBpcmM6aXJjLmxpYmVyYS5jaGF0OjY2OTcv
Y2lwDQo+IA0KPiBUaGUgSVJDIG1lZXRpbmcgaXMgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMjow
MDoNCj4gDQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdk
ZXRhaWxzLmh0bWw/eWVhcj0yMDI2Jg0KPiBtb250aD0xMCZkYXk9MTUmaG91cj0xMiZtaW49MCZz
ZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwNA0KPiA9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4g
VVNXZXN0ICAgIFVTRWFzdCAgICBVSyAgICAgICAgREUgICAgICAgIFRXICAgICAgICBKUA0KPiAw
NTowMCAgICAgMDg6MDAgICAgIDEzOjAwICAgICAxNDowMCAgICAgMjA6MDAgICAgIDIxOjAwDQo+
IA0KPiBMYXN0IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNib3Qud2wubGludXhmb3Vu
ZGF0aW9uLm9yZy9tZWV0aW5ncy9jaXAvMjAyNi8xMC9jaXAuMjAyNi0xMC0wMS0NCj4gMTIuMDAu
bG9nLmh0bWwNCj4gDQo+ICogQWN0aW9uIGl0ZW1zDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVw
ZGF0ZXMNCj4gKiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ICogS2VybmVsIHRlc3RpbmcN
Cj4gKiBBT0INCj4gICAtIC9tZSBhYnNlbnQgbmV4dCB0d28gd2Vla3MNCj4gDQo+IEphbg0KPiAN
Cj4gWypdDQo+IERhdGUgdGhlIGRhdGEgaXMgY3JlYXRlZDogVGh1IE9jdCAxNSAwNzowODoyOCBB
TSBVVEMgMjAyNg0KPiBsaW51eC00LjQueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVz
dCB2ZXJzaW9uOiB2NC40LjMwMi1jaXAxMTUNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRh
dGU6IE1vbiBPY3QgIDUgMTA6Mjk6NTIgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBXZWQg
Tm92ICA0IDEwOjI5OjUyIEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51
eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2NC40
LjMwMi1jaXAxMTUtcnQ2Mw0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIE9j
dCAgNSAwNzoxNjozOCBQTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBEZWMgIDQgMDc6
MTY6MzggUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1j
aXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2NC4xOS4zMjUtY2lwMTM2
DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgU2VwIDExIDA4OjUzOjA3IEFN
IFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogU3VuIE9jdCAxMSAwODo1MzowNyBBTSBVVEMgMjAy
Ng0KPiAgIFN0YXR1czogKkxhdGUqDQo+IGxpbnV4LTQuMTkueS1jaXAtcnQ6IGludGVydmFsIDYw
IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2NC4xOS4zMjUtY2lwMTM2LXJ0NTANCj4gICBsYXRl
c3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCBTZXAgMTYgMDk6MzI6MTcgUE0gVVRDIDIwMjYN
Cj4gICBsaW1pdCBkYXRlOiBTdW4gTm92IDE1IDA5OjMyOjE3IFBNIFVUQyAyMDI2DQo+ICAgU3Rh
dHVzOiBPbiB0cmFjaw0KPiBsaW51eC01LjEwLnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBs
YXRlc3QgdmVyc2lvbjogdjUuMTAuMjcxLWNpcDc4DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFz
ZSBkYXRlOiBXZWQgT2N0IDE0IDA5OjMwOjU5IFBNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTog
RnJpIE5vdiAxMyAwOTozMDo1OSBQTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4g
bGludXgtNS4xMC55LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb246
IHY1LjEwLjI2OC1jaXA3Ny1ydDM0DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBU
aHUgU2VwIDE3IDA5OjU5OjQ3IEFNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogTW9uIE5vdiAx
NiAwOTo1OTo0NyBBTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4x
LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbjogdjYuMS4xODktY2lw
NjENCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCBPY3QgMTQgMDc6MDc6MjYg
QU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBGcmkgTm92IDEzIDA3OjA3OjI2IEFNIFVUQyAy
MDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC02LjEueS1jaXAtcnQ6IGludGVydmFs
IDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2Ni4xLjE4Mi1jaXA1OS1ydDMxDQo+ICAgbGF0
ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgQXVnIDE5IDA2OjE2OjAxIFBNIFVUQyAyMDI2
DQo+ICAgbGltaXQgZGF0ZTogU3VuIE9jdCAxOCAwNjoxNjowMSBQTSBVVEMgMjAyNg0KPiAgIFN0
YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4xMi55LWNpcDogaW50ZXJ2YWwgMTUgZGF5DQo+ICAg
bGF0ZXN0IHZlcnNpb246IHY2LjEyLjExMS1jaXAzMg0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVh
c2UgZGF0ZTogTW9uIFNlcCAyOCAwOTo1NDozOCBQTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6
IFR1ZSBPY3QgMTMgMDk6NTQ6MzggUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6ICpMYXRlKg0K


