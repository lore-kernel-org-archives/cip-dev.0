Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F6EE49A5
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 06:54:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.2814.1692687260268313215
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 23:54:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 37M6sHrx3147621; Tue, 22 Aug 2023 15:54:18 +0900
X-Iguazu-Qid: 2yAbM4uBRI2XIsyR0M
X-Iguazu-QSIG: v=2; s=0; t=1692687257; q=2yAbM4uBRI2XIsyR0M; m=XJ0rsneVe+SzQnD+lCq5HBrf6uDU+rLlY3nYJKJu3yg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 37M6sGW62220015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Aug 2023 15:54:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCYpPbPPTtkiJWwqVps6pKVIr2NTalH9cJe4UL57BqcZDlWaDIKfSgp1Gr1o+EyvrZEzzQgylx1dEUthBh8jgF/xAw2i8Gp8LJXByzjFl3bOaiYhLvclfeyxql5+KXqonOWIO0s4031Gi6lHnE7THkXZFLIQ59cM/knGKj98ltpRetHecTnWGKRzzlAMeEa61tTVlQNRDU4Ks5OPEFCuuq0jKMNXHUZnLgdhqzFWS/aNSo439hvsMG1a6RFHi2yUO7qzN6gKQ7+QF77/I9o1Hguab8xeltG/Xn1HgfJTF15KaVmW8yt2n9vU97gV7vyQcbIEkmR/XaW5JYltGKrXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVKhMmOezyuueF3SRBuR5wF6Lld8A4fmzwWaO/2GrSk=;
 b=hP3ZhEOB3DdcQrLVnt9gWhfm3RmCmMJWr4sNLNUiNKGQet1P8Z5S1OzpFgUUxjk/AdBeX7EQ3VTgQRUR3sRzYLd7cjNtCeqL4gz/5AwDviQ66hWR40vjLC+3fgaGLXEG1htORINVwVP0J+oqMFAc+R7pP95hfVamsMo7UCu+8xDItvnpBDhw/TQPm9QfdnUJe5vNEWmymPqBRSGXvd6reWvHIIrOBd8R2VCq7G/xggupw12bkgEVlckC765sxY7OAOuQ+cTpTILhuF12ohdicJ2M43OgqEIN033uFXPAP5X7+Hz8Thcdyiu20V6NRjIXqGYv5H79F31OM+TjNrZoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <tho1.nguyendat@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <tho1.nguyendat@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core 0/3] Enable secured boot for BBB
Thread-Topic: [cip-dev] [isar-cip-core 0/3] Enable secured boot for BBB
Thread-Index: AQHZ1BVrODSl57aELkiC1J2p3R0+Fg==
Date: Tue, 22 Aug 2023 06:54:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB58802B388ABAA81B05F915F9951EA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Accept-Language: vi-VN, en-US
Content-Language: vi-VN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5880:EE_|TYCPR01MB5773:EE_
x-ms-office365-filtering-correlation-id: 180674a4-a09c-4503-9ac7-08dba2dc9907
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HTLsNdMAfhs2vwVKfjSez1P7Lkq3uRF2PPcrEdzctaql1vYdJI4mSRzmcFcMjj3Nd7RNyrHRV+uVZVstK+68QlydwOApaV/pIhqMHXLFG7Rwtpq2+uWJvBqsFZBOxYLVhwvVJY9L0pLvnBlwg31i5543LMju2Z5amIgKP6OKBWyHJjl96VzdWvHVFnBEnyLYxzx9AbSYvhFxzTBqEAqVJdd5TbAmqqRbSdTCWOtY7aOq5w6JzbQlZ0W/YaMQiJ+lVPBy9J08Hy70L+fXwtrh71jH/S9t8Q/l216cFdbeV3jXf9lOV+gShoonVBnZkhb1/sYGMC5xwZUOdRpcQ/7q5Y7CnAI8yU7kt1FPxH0TqPsfil5b30qMY7iJkdRdmCPUGkvhfMlozhqdHD5epDs/MBNTjMKkg2Xqp9xz0mijYt7ygScpkssvGWvAucP89KVvN4X9zK+1x4P51+OmpWmQCRMI42z8xyRPNHPdIANey2eSY9Amwe1f4JEWIfBdt7spJKDo3wADJlnRxcgOiMhxEivFrT4aPGAheZX1WDV2fw+RACt/nVwfGqG/gYYB0sav/r7cwhAG9bxTplbnuSPun0aDJOo70FIz90K6/J8KzLhxnPTkdU7MKkgX80N/5vlm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5880.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(1800799009)(451199024)(186009)(71200400001)(4326008)(8676002)(8936002)(316002)(478600001)(19627405001)(66556008)(66446008)(110136005)(91956017)(54906003)(64756008)(66476007)(76116006)(66946007)(41300700001)(7696005)(6506007)(55016003)(9686003)(38070700005)(122000001)(38100700002)(33656002)(26005)(85182001)(4744005)(5660300002)(107886003)(2906002)(86362001)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?elJ6RFlYWFVrMTVaT1pFK2hvK3ZVK0hudWtpYWRreDVrWmQvWERUL1dFbGRU?=
 =?utf-8?B?UmNLSHZRM2lOTWdxdFZoMFdkYVRxMEpsNHRFRURVNENwT1dRM0pNbXBQVEsw?=
 =?utf-8?B?RnplSHA3LzNEQXZOOThrRVVyOC91aUxKMnpzL3pwdXpraXZPVEMwdUk5M3Zi?=
 =?utf-8?B?Vy9VWXA2VTdqVmlqU2tscVdpUm5BQXFVcHVyNUFLNWdFWGVUaGJOMDJRQXM1?=
 =?utf-8?B?c01UWXhIcDZTQVhuak5Yd0MyOSt4M1hBZjVubkRFSFJSU21vVWtiOXZDRHRa?=
 =?utf-8?B?Z3ZZVUExMHNRcEJEZFlVd2xsSDZZWUc3QjhTckpBYzZwYTdIZ0NIdDN5Z1JJ?=
 =?utf-8?B?NDlNVllpRlZuRlh5dVJsQ0wzeHJ5Tyt5QmhWRTB5eEZ2QjdKand3SUZ6TXQz?=
 =?utf-8?B?MXc0UFkwbGlIK1d6aVFobXp4cHdQa3dtaUEvbVptSnVMVFd2Y21JNVM4cyt3?=
 =?utf-8?B?aUNEU1JjeTl3UTdIVllrcTluYnZmVXBxUVVvMXNWazVoQ3J6dXFydVgzQmxk?=
 =?utf-8?B?SjB5akRZcjNyUElVQjB6VENvM3BKWmN6WVpKK3V6cUtoZ2lwNWpSd29wNDJq?=
 =?utf-8?B?WDZIUDMxRFZXZGdyMjNtQ2tpc2tKZ05lV3dPNWpqMUcySFRRUnJOMVJXSE9Q?=
 =?utf-8?B?a2wybHh2UDZ5c09LSmdDMjVMMWZla1RrM2xDWlZub3ZpUWZTZ29mRUZYa2ZB?=
 =?utf-8?B?QmNOK3VyRHNMdTltN1dxZ1EvVWJHVTBLdmdZS3ZSbS8ySDYwbktUM0tJV0hv?=
 =?utf-8?B?M29EeEVTSElqL24xQVN3QXVISDdERVJaRmtCbkNtQXl0TXBhV09YUVNBWXJp?=
 =?utf-8?B?dDRxZnZVNjZzbkFyRHA0eFhpY1p0dTZtZDR0S255MEdYY3BPKzFjanZ0SlI5?=
 =?utf-8?B?VDhScUVYaDVZMlp0ZFFVeXkwNmtTVkNxMnFvOE9HWVRRZGVYNDNNbi9qOGNr?=
 =?utf-8?B?QlgxM3M3amduUkVBbUdyUms3azgwOHVTNkNaZU5WaC9qdEZiYjJYK0wrV24w?=
 =?utf-8?B?VUlidVN2N05odGwyQkpNR00xcmd5RVpDOWFZdEZoYWJuV2t0MjN0WDVwZ1pU?=
 =?utf-8?B?Q2hRdUpQOXVMM0s0NDlpeUpZTnZ2S2E0RVNlUFhwc1ZIcmtwT3FjVzExckZo?=
 =?utf-8?B?Zy9hRWVSMTlvQW1DMzA0N0I3d0NhZ1g3RzJoVzBUaVZBOGdQOERRaXh4OTQz?=
 =?utf-8?B?Z2xyVjNnMWVNbEJOVHlJQzBqcnZyanJXNERGTXNJaStUVnV4c2lUb1kwdUpU?=
 =?utf-8?B?d0hEVUVFUmxXY1hNM2VOTFpMUGFEdXlZa1c4Ym1tSENDcEVxbFlVUy95Ui9S?=
 =?utf-8?B?TDEvNnRTTEhWbk1SRzc2NlNQbVNHWDJuU01Ta3ZwL2p2aVpJQ1BBeTBqVTBk?=
 =?utf-8?B?L1ZRR3FxQ3lPTGpvZzNXNVdUL05XdC93TWM4SFBYMUFabU15clJFYkFYL2sv?=
 =?utf-8?B?SEU3cnh1S2ZYRFM1bXNxVFNuNHYzclZVMW9qeS82bnhhbzNqamJCMGNvU1NZ?=
 =?utf-8?B?OGJjYmQ0V20xbWNyNEdKakJvQnZkL2FrR1MzcmlNako1ZXVLS0ZsMWJpZ1hS?=
 =?utf-8?B?VSs4Mk5rR1FhNldmcmJSd2pRM0VXSytPSGhUamFlMEFBTmpOUjFrTE5KazB4?=
 =?utf-8?B?M2FUek95ek1xSWxPVVpEc09IdHNucVVzTmpoYkRzRVJlT0kwMUdBYVBnRlEw?=
 =?utf-8?B?ZXpSK0ZOODBDaDRubmt2NFE2YkdhS1VPRmZSN0c5Y0ljNWZGeTF4OXNaYmlR?=
 =?utf-8?B?QXVFSjczeUVRbTh5UUJVWkZkS01FN3VpVlY1ZkVIR2dXREQwa0YwSTg4aG5y?=
 =?utf-8?B?Nk03d3JJSllsekxyZmNwZ2I4cldEWVNJMitOdG9Bdk45YmRhZ1ZaL0ZyVCtk?=
 =?utf-8?B?cmd5anB5MjFPdXlRR1VUS1FPcG42eVdhb3FRN0E3Y1d3Sk0rRjZHeXU1cTA1?=
 =?utf-8?B?MnlpcE1RYVpKMElKRHkzelBBZlgvNHN1WUh0OWQ5OHdnK0k5ckkrekFhVXd1?=
 =?utf-8?B?b0NCekEwblNsa201dkkwVjh0N2R1WmFKa1I3YUhjTERBbXBFMjgrMFVrdU9l?=
 =?utf-8?B?VlE5cTkyZWNvMUg1TGg2RS9qSHZVTGg0U2dMMWNKVVJqZzM4YUhTSUdXQXNR?=
 =?utf-8?B?Q3haRmx5bGxuMnVlY2c2Wld4MzRjd203QklQZWFSR3ZBUm16NDRKaHlIYnZF?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB58802B388ABAA81B05F915F9951EAOS3PR01MB5880jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v5jgb8FwW95j2eEZtBEfVPiUnp/0PxZPAhntZb4/zxYKENer8m0MF78TgFX9YLdfezZ5I+VnJprpeChZQ9mvIqZuBdaafLJBc7nQOQw8a0LJU6gsEPTi8DO3aJk56XD97LYdjFjQdGSSWtuf0mu7fcM8nWAYR6xIPiv0usaOGR4IffTtVk0P6CxSqjKgRwvXW0RhSIkfPo1yrKequrDbX7iP4GN1WBF4WO4p8O4nQ819MNcPqMcwmkGRIJ3qAhp7u4y1MKCfFg+bAK37Q/8IbIEEq+kMw/30o0HNfe35LtksXwWlx2NHAZM1q4voJ6YkdU9n++nz3uVx8LEWJWXtDva1+A1K/Ml/0Cxw0f2K7ECejBSP7O++OMF84mloXoVOCSX5Vgt6p+0fdkVbltWCELJXSHHan48J/mWAAIzlPhY1zc3zM4zhrPDT0ZB+C00vlQ8VTcyCo3qn9Wk5cdxzJKTx7TEnlwFCtzX3FEPpYmckV31q9hln/PPsVoL/6S7F1bNP017NPDdaY58CM8jF9qg8mY6GGxgncwNeI1Rjq5eOM++WuSYjpR3ZUqDsPdg5yc1cM+3iiaPnunfGe1QOdMsUJa0bjpFEI8NAfI32wgzXRRyBXPyP2SC6R5dxn6scZZCb067xmgtU7qVJjfI5BMrjlU8nYOmnj/b1FiSMXDiFRrZ8tWx+BuyJMaYE2E7RiwL+PCf1Fe51NQ1ZO77KNX9UoSDAAEccsuTgvN+NI8xYJmErA/UHIagatPihLahEJSwRshGM6/W+HL2vUyTFLNo8UHD7YTkumWyzfXGnJqSHXkbPK7yIpSImex2ui9r9vDcbERf1kjC092B/vOLxiQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5880.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180674a4-a09c-4503-9ac7-08dba2dc9907
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 06:54:14.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WckU/b6mdD191zBWJMlElCOnijPPoE1bn6Xwa78sbAyEzmG/+e3ZJweY1hkYBZk6bsjobknlQQv0kI8jEWw/L7uDRbKGVTVHsUyNH8cGUMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 06:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12811

--_000_OS3PR01MB58802B388ABAA81B05F915F9951EAOS3PR01MB5880jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogTmd1eWVuIERhdCBUaG8gPHRobzEubmd1eWVuZGF0QHRvc2hpYmEuY28uanA+DQoNCkhp
LA0KDQpUaGUgZm9sbG93aW5nIHBhdGNoIHNlcmllcyBlbmFibGVzIHNlY3VyZWQgYm9vdCBmb3Ig
QmVhZ2xlYm9uZSBCbGFjaywgcGxlYXNlIGhlbHAgbWUgcmV2aWV3IHRoZW0gYW5kIGdpdmUgeW91
ciBmZWVkYmFjay4NCg0KTmd1eWVuIERhdCBUaG8gKDMpOg0KDQpsaW51eC9jaXAta2VybmVsLWNv
bmZpZzogVXNlIGxhdGVzdCBjb21taXQNCmJiYjogRW5hYmxlIHNlY3VyZWQgYm9vdA0KdS1ib290
OiBBZGQgRUZJIHNlY3VyZWQgYm9vdCBkZXBlbmRlbmN5DQoNCnJlY2lwZXMtYnNwL3UtYm9vdC9m
aWxlcy9zZWN1cmUtYm9vdC5jZmcudG1wbCB8ICAxICsNCnJlY2lwZXMta2VybmVsL2xpbnV4L2Np
cC1rZXJuZWwtY29uZmlnLmluYyAgICB8ICAyICstDQp3aWMvYmJiLWVmaWJvb3RndWFyZC1zZWN1
cmVib290Lndrcy5pbiAgICAgICAgfCAxMyArKysrKysrKysrKysrDQozIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K4oCC4oCC4oCC4oCC4oCC4oCCLS0N
CuKAguKAguKAguKAguKAguKAgjIuMzAuMg0KDQo=

--_000_OS3PR01MB58802B388ABAA81B05F915F9951EAOS3PR01MB5880jpnp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2Vy
aWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KRnJvbTogTmd1eWVu
IERhdCBUaG8gJmx0O3RobzEubmd1eWVuZGF0QHRvc2hpYmEuY28uanAmZ3Q7PC9kaXY+DQo8ZGl2
IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlh
bCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwg
MCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiIHN0eWxl
PSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9u
dC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpIaSw8L2Rpdj4NCjxkaXYgY2xh
c3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBI
ZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZv
bnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNp
emU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NClRoZSBmb2xsb3dpbmcgcGF0Y2ggc2Vy
aWVzIGVuYWJsZXMgc2VjdXJlZCBib290IGZvciBCZWFnbGVib25lIEJsYWNrLCBwbGVhc2UgaGVs
cCBtZSByZXZpZXcgdGhlbSBhbmQgZ2l2ZSB5b3VyIGZlZWRiYWNrLjwvZGl2Pg0KPGRpdiBjbGFz
cz0iZWxlbWVudFRvUHJvb2YiIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhl
bHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDAp
OyI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9u
dC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KTmd1eWVuIERhdCBUaG8gKDMpOjwvZGl2
Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJy
aSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjog
cmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4t
dG9wOjA7IG1hcmdpbi1ib3R0b206MCI+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiBDb250
ZW50UGFzdGVkMCIgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNh
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCmxp
bnV4L2NpcC1rZXJuZWwtY29uZmlnOiBVc2UgbGF0ZXN0IGNvbW1pdDxicj4NCjwvZGl2Pg0KPGRp
diBjbGFzcz0iZWxlbWVudFRvUHJvb2YgQ29udGVudFBhc3RlZDAgQ29udGVudFBhc3RlZDEiIHN0
eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpiYmI6IEVuYWJsZSBzZWN1
cmVkIGJvb3Q8YnI+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIENvbnRlbnRQ
YXN0ZWQwIENvbnRlbnRQYXN0ZWQxIENvbnRlbnRQYXN0ZWQyIiBzdHlsZT0iZm9udC1mYW1pbHk6
IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsg
Y29sb3I6IHJnYigwLCAwLCAwKTsiPg0KdS1ib290OiBBZGQgRUZJIHNlY3VyZWQgYm9vdCBkZXBl
bmRlbmN5PGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiBDb250ZW50UGFz
dGVkMCBDb250ZW50UGFzdGVkMSBDb250ZW50UGFzdGVkMiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBD
YWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNv
bG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPGRpdiBj
bGFzcz0iZWxlbWVudFRvUHJvb2YgQ29udGVudFBhc3RlZDAgQ29udGVudFBhc3RlZDEgQ29udGVu
dFBhc3RlZDIgQ29udGVudFBhc3RlZDMiIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJp
YWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAs
IDAsIDApOyI+DQo8YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2luLXRvcDowOyBtYXJnaW4tYm90dG9t
OjAiPnJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy9zZWN1cmUtYm9vdC5jZmcudG1wbCB8ICZuYnNw
OzEgKw0KPGRpdiBjbGFzcz0iQ29udGVudFBhc3RlZDMiPnJlY2lwZXMta2VybmVsL2xpbnV4L2Np
cC1rZXJuZWwtY29uZmlnLmluYyAmbmJzcDsgJm5ic3A7fCAmbmJzcDsyICstPC9kaXY+DQo8ZGl2
IGNsYXNzPSJDb250ZW50UGFzdGVkMyI+d2ljL2JiYi1lZmlib290Z3VhcmQtc2VjdXJlYm9vdC53
a3MuaW4gJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7fCAxMyArKysrKysrKysrKysrPC9kaXY+
DQo8ZGl2IGNsYXNzPSJDb250ZW50UGFzdGVkMyI+MyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8ZGl2IGNsYXNzPSJD
b250ZW50UGFzdGVkMyI+PGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJDb250ZW50UGFzdGVkMyI+
PHNwYW4+4oCC4oCC4oCC4oCC4oCC4oCCLS08L3NwYW4+PGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNz
PSJDb250ZW50UGFzdGVkMyI+PHNwYW4+PHNwYW4+4oCC4oCC4oCC4oCC4oCC4oCCMi4zMC4yPC9z
cGFuPjxicj4NCjwvc3Bhbj48L2Rpdj4NCjxicj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_OS3PR01MB58802B388ABAA81B05F915F9951EAOS3PR01MB5880jpnp_--


