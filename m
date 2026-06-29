Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C612C43602
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90651.1782734760808314429
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 05:06:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65TC5woK2207909; Mon, 29 Jun 2026 21:05:58 +0900
X-Iguazu-Qid: 2yAasonkh8MmSpMLZo
X-Iguazu-QSIG: v=2; s=1; t=1782734758; q=2yAasonkh8MmSpMLZo; m=punfUCQCTyrY/iXG9GkoA+8l5g9yYPXdSOBpxPtfplw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gplNj6YcJz1xnk; Mon, 29 Jun 2026 21:05:57 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiyzUxytnfZeflHrdRsA/TxNDbp/nSE8oLBxXg1xdMS9OwJNLIsy+rqi/ew5MMa0fu02qMAPMUQmwKe2rL5zrYy+gLVf19HasLluk5Su1iNWu+Q3qHuOZy8TxyvShLkNG1pEvK9PW/WVpxPKkfKckTtqFIP44f2L4WA16z2nbE4dR30hD+p0vtaHGynY8nN18Ig8EM7ggsFx5W+kqBUZo26zLE6amP7rkuMPBlkfT+Dj4RcIy/e8of88PnCLt+jeTI53XzqvvETU5vQEcr90TEALsHOmkna+BojRULLSt4UEmY++OQC/NAESH0XkoHOgu2S7pAd2mlhxvx3crmhmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl/FAnCxa9YpOsJg+2B5ryU9B4Cwy+0LdAQj74RQygo=;
 b=Wc1r2INot6/C/o4cd/WLtmNFUW2I3VUzwsuolsBeqbZUPMQURiR58kaKaLGr4mUij3yzuGw5U0CKHQ+5B1lXgJHndqN1PQo5ochdtoe60Wdgtyr02L6whpevFdB+l+B4MQqTo1zKNLmeLhEdCym99JiwTiGcGkbiZRai7d5v5Tm35ztIlyKUmIZZyHFQustCog54zChi7OktNu7WZKwpczCVx4SMFNb+BSEXNlhxflc819Piq6mBt4n7qkCPC+SDHOs3Zq8QOelG0+Isx0pkFbp6KzeZQsHTgIUpuscW2ZBd1u6d3ZfVZq/3E/L09+qSbDvtMjM6Cnc2gA4ruREdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] Revise README files to reflect
 the latest changes
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Revise README files to reflect
 the latest changes
Thread-Index: 
 AQHc/9wX8akHVB2NLkytfu/sGsJQbrZItVEAgAFYFMCAAfWWcIAAFXiAgATO8NCABHojAIAAHXdw
Date: Mon, 29 Jun 2026 12:05:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110756A3B581CA3043809212CC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <8b2cfa70-08fe-45ff-8695-7564b37f36b8@siemens.com>
 <TYWPR01MB11063B595D1725A7B252067EAC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075F67BFD39AEA29DD9D095C7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <38ec0a76-9e33-4976-a6a4-612b4c12d935@siemens.com>
 <TY3PR01MB110758EEF7898CFF2649036BDC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <d109ed7e-ede4-4e0e-8651-b59fff75d8ca@siemens.com>
In-Reply-To: <d109ed7e-ede4-4e0e-8651-b59fff75d8ca@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY3PR01MB10385:EE_
x-ms-office365-filtering-correlation-id: bb261fa1-4c07-4b9a-ecf7-08ded5d6c5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10070799003|38070700021|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: 
 5A/nOsXvS9xYAN9ws/Z9by1fLoR7wHm/cYROn5ElKoN3o6BFFcpGVo8VxZI+A5ukvdBwS3SSgA6FAcBx5KZnfL++epcijj3xQ+avDPnMD0i3zyjbnGpgwBBgrcKhpSWNlTV8B1nik9fXqxSCN1UocLG0GEEyfsYf7ojlKghd3UT6p47Mm1jTJjEJe4IxQpzV+MjFEVNr08W5G+cnfzTT/Oxa3ow9rMwhltG/JtI9dUIs3WdRvaU4L6hT1P8DKbrkRmR82z8t8IPtcadhxjFLRyYkEsWDBZzsPxvNBxbzlG36sjIEyzRg1X+/cbtJXbaEbcISgJkx+XtwLFYclIkPdQb46eHNaWIB0qwUNRFFKGuTAE0tFysIVidBqjwFVdvX7pc7TRtEgichrKwFPqpLSdG+YsiiwCOz6TZvaHnCSOPoDj0GY7RF080axbzqrQjDVjqA6AvY3PckenRHuNGhvrZPX+MnS1X5vL5ylcKr+qK+xJ2M/8HyfMc/t0/HNGNS836Guiz+qV7Im9wwKeHaBzEeXo7A6QVG1rn2LrUsNXOiSRAN9KIR5UXYzKYE9YdtrU6Oy9JWAd28O+RTwDMZRMn8xtz8STiAWUXV5vtUFOZq6NvNJebCr5UcHHKxqVxqZ0iqEISksuVXbMadXH45e83hxgWoA6RhEdLSdWHQrgCaPEaLYEWjxgBVw3JHD+quZCdfwuQhVESnCddvPPoIRNjj1UUysxuAVjzUsJrDh+M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(38070700021)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U2FBNU10VkgzajVsekpTYnJ2NWZQNW1DUSs5UWZHck1TT1FVY1VFdFE2UU5W?=
 =?utf-8?B?NFVMbjNwYzFuS2FYYWVOTGlpUFlGNk85eDVudUV3MUtxWHVHZXdrM1NvcFMr?=
 =?utf-8?B?VzRVZ3lxZG5DSW4vZ1FEc1NPdXFkb3NVUXkyNHNIaTdMUXRPMklTL0NoUlVa?=
 =?utf-8?B?eENhRVl1dnYyU0hvVmlwQlo5dnVyL1ZYOTg3eHpqSXJEVzNrMTZTakhDY0Fr?=
 =?utf-8?B?bGxqWHk5TEZkd2xkb0JNUnZTeHAxbDl0WU9zcjlYTHFrQm81Q1dzcHk3RzRT?=
 =?utf-8?B?MmxJK1piMG5KUCtEV1laa3lvSjdFRVlLdWNYNk5JbFZoMmpWUnFWbStWTWhM?=
 =?utf-8?B?bDhDSEdIZlVXZ3JvUndKTUkxVDVyaVlvR0Z0WUU4WmdhWjVVUjNXdmRXbS9W?=
 =?utf-8?B?SWtqUnVUQWxtQ1Q5c3M1cVhHenZGMnNBVDd4SFZ5Yi9PcFcxUHI3T240NjFk?=
 =?utf-8?B?ajN3Nk5TZUpKeHp6dVFhYXlRNHFnSVhtZEp6YWdTeDNWV1lzRk0zTGZkMjRq?=
 =?utf-8?B?TVFaVUZERnV5bEU2ZTZLVnFjY2Z2b3pnSUlKZ2lIZTFYNXhIeUpOZGNyRjg5?=
 =?utf-8?B?d1Y0M2JDOVRUQVlFQVpPS1ZPRWdIVG85dUpmQ1FWZnBUVURLNlZqVEFOaERI?=
 =?utf-8?B?TVJqbDVzYkMrVExOdmVWcnYxK1BTRHJXZ3RxSGtKTUE1eE91WnBYNkNmTlV1?=
 =?utf-8?B?dTBWYjJvL0lONEE1TFl3K1RhQ09MTnlKQktIdHp5UG9Ja09xd0JvblR1alFx?=
 =?utf-8?B?ekFFMjZ4TWM5amIwMHNyNzZjWVpQcTRwUXFLT3pDRDdYcDZOcXBmNTI2ZjNk?=
 =?utf-8?B?U3VvdTkrRVM1Q2ZveFRrM1JxQ0wxTGN4M0NtOWpxczVjSk1zMUFCUE9aeDdh?=
 =?utf-8?B?R2I4bEoxNk00WnNVbmpKNWNzcVo2S3JpQnRwdVAwOXpFQ05nYTJuSkVaVHR6?=
 =?utf-8?B?TlpjZzJTRHdIaVVPckkxeGxzYVVzYktqOU5pSEI3TEt1Lzc2bFNpNUFlNk5u?=
 =?utf-8?B?WXhmNzF4Q2JsMnpzZnFrbURMK3BTQ2VoZHdKdHFuK0hUV0dDeTJpZWlhWStN?=
 =?utf-8?B?OXB2T05VT1YrSXRBMnMyaUFsL0FxWFJEUGlYZXYxdVhmVldjQnkyUUI5eGtH?=
 =?utf-8?B?Q0V3K1R1VHhYT0ZVOXB2cWp0Ly9XcEVRcjJDZjZmbU5ZWnpGYmxsMi8rKzlL?=
 =?utf-8?B?UWdwd0traW14SjFBN3hUT3M4R2pxVWpsUHorcGdYTTQyQzl6VU9UbnowK2d5?=
 =?utf-8?B?dWNyWjgra2lMRHpxNlRlaFZ5ZXpQMG1zNGcrVUM0a1Y2aUFMYnR3T1d3UXI4?=
 =?utf-8?B?Qm8yM2lmS0FIMzk4b0ZiMEVmUEFkYWVCVkozdDIyVVZENlQrVGdJSENUZlhu?=
 =?utf-8?B?eVFFMUlKekQ2UzZNZzR4U1ZKSExxN1c3eTVWMGdDTVpka3dOdW1JZnAxU3pO?=
 =?utf-8?B?dG51Q054ak9QWDlzVFBYVnd4NW5ZOE9sS213YnlqMzFML3pSSk1TajhNTDdS?=
 =?utf-8?B?T0YzRURkZm9ETFBQejR0bUgwSUk1MU1GRGFFbFdUdmdPMjdmdUlYUnFtQk9G?=
 =?utf-8?B?eHFpWFAxVm14UU1NRXYzVkptVG1PM1pkeWpoZE1jY04vSWc1WXBsdVdEUUlI?=
 =?utf-8?B?SlBpU2Q5VitSaWo5QUlQYTJzWk1jYlN3QVBpTTExTzd4Z1RQQWltb3A0ZG1J?=
 =?utf-8?B?SGlsaXBHd0dESDBGT0lhWmc2UCtUYjBsendraXpGUjBlTE9IZ1N3OHp5V2VZ?=
 =?utf-8?B?Vm5vYWNlaG81aE40NkVjTG0xeXVMY0pSRjNtaFpPNC96VVBFaDZkVWNrNWIx?=
 =?utf-8?B?a0tYT1lBRTMwa3kwdGdWd2VPRXZ1clZKb2xjMnRaTVkrYU1rcHNTejBlVHpS?=
 =?utf-8?B?dzZab2ZEV01DUTJsZkF5OWpvTzFOWEdPRzJ1WHVNVlVrNXE4dkJsQmc5UUgr?=
 =?utf-8?B?cTl2ckpaZ3FrcUEwSXREZXA4bjgzeW5uMWs1RVl0MDlNMnBSUlhqdVJzMHNL?=
 =?utf-8?B?UkMrbkRHSXc1TE14bGlFR2p5dGJBeG4yUHhBRWU3cmZDQWhUdjBJRExHMGJ3?=
 =?utf-8?B?R0lacThLUEx0VkpocWVmQk1IRzAyRE1xajFZRnR1ejVyV0ZFWGVqZVlVWTVh?=
 =?utf-8?B?cXN0VFF2OHBMcHBWTURJbm1JVXg5ZUhkTG4vMG40U2k0OFZMTWlGOFRMVlJW?=
 =?utf-8?B?cWVoODhTMVllNjBvT2dIb3ZSWDcyL0RBeThJcTNROUFYRFd0NkZlS3Z0WElm?=
 =?utf-8?B?dHRQTDE4ZHNPbUpQUVFlVFFWUHk3blVkbGpKSjFoaG8ra3FremtDQi9HRTlG?=
 =?utf-8?B?L29DZWV5dFgyMmFtdWQxU2tWdm9ZRGpNSW9hSGU1cmhEZ2RUWDZPVHdvQ1Ix?=
 =?utf-8?Q?v6BLp14BY+UsatYaY2QE1ji+FVBjnwania6dVcTjjGC+4?=
x-ms-exchange-antispam-messagedata-1: YoZ2TtO1OypYWuWbjQbJk7ybgGHUizhgK3I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ljPyPLdi16jX2DOGIJFeNjxfIcoUa895AWTuD3H/x1G9g7HddNwPFqa6XDKTtGUmoD+ZPxxmW6nTwVCiRahhnCd2BIgnI3fJ6tp5KcPgqRJtXe6UkDKE3/5wY+kLQqHP7ScKBLOhBUZyfFUaP7HqLsr0gvL9ZbswakZsB+F0G1hkEHF+kajvVdFkSiJ5Tu6gnRNomLZlIlm5iTAR6EKhvvnlUw0Ux9YEsnF527+uJmhEm8eJPkMavBcT1P1P/z3ldRqY/a8eUpIGWJQLCuyaiBjQQgBrcSKXdT/LBCEHaktw/3Fu1z4uOED3FLMC6rSuqGsqZP03/+k+0x9nKxCc3Q==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb261fa1-4c07-4b9a-ecf7-08ded5d6c5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 12:05:55.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bs4LkTCYO6PddpGh6IKZUMJTXUXo/lB6urKqly70wVUM328Ypzo5ANhZ3+Qt/g/LgEZ07WVaY02vxTGHdc+SZDhKgGDjZECQdHBHEM4Ib0/FXDrUmrmr/o7bRmVRbhUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 12:06:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23307

SGkgSmFuLCANCg0KPiBKdXN0IGFzIEkgd3JvdGU6IEFkZGluZyB0aGUgcGFja2FnZSBvbmx5IGZv
ciB2aXN1YWxpemluZyBpcyBvdmVya2lsbC4gSWYgdGhlcmUgYXJlIG90aGVyIHVzZSBjYXNlcyB3
aGVyZSB3ZSBuZWVkIGl0LCB0aGVuIHdlIGNhbiBhZGQgaXQgPg0KPnVuY29uZGl0aW9uYWxseS4g
SWYgbm90LCB0aGVuIGNvbnRpbnVlIHRvIGxlYXZlIHRoaXMgdG8gdGhlIGZpbmFsIGludGVncmF0
b3IgdG8gcHVsbCBpdCBpbiBvciBub3QuDQoNClRoYW5rcywgdW5kZXJzdG9vZC4gDQpJJ2xsIHVw
ZGF0ZSB0aGUgc2VjdXJlIGJvb3QgcmVhZG1lIHRvIHVzZSBvdGhlciBjb21tYW5kcyB0byBzaG93
IHRoZSByb290ZnMgc3dpdGNoIGluc3RlYWQgb2YgbHNibGssIHdpbGwgc2VuZCBvdXQgdjIgcGF0
Y2ggZm9yIHRoaXMuDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPiANClNlbnQ6IDI5IEp1bmUgMjAyNiAxNTo0OA0KVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo
77y077yz77yp77ywIERJVENfRElULU9TVCkgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10
c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogYmFsYWt1bWFyIGFk
aXRoeWEo77y077yz77yp77ywIO+8pO+8qe+8tO+8o++8v++8pO+8qe+8tC3vvK/vvLPvvLQpIDxB
ZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgZGluZXNoIGt1bWFyKO+8tO+8s++8
qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFz
aGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIDxrYXp1
aGlyby5oYXlhc2hpLmY3NEBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtp
c2FyLWNpcC1jb3JlXVtQQVRDSF0gUmV2aXNlIFJFQURNRSBmaWxlcyB0byByZWZsZWN0IHRoZSBs
YXRlc3QgY2hhbmdlcw0KDQpPbiAyOS4wNi4yNiAwOToxNCwgU2hpdmFuYW5kLkt1bmlqYWRhckB0
b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiBIaSBKYW4sDQo+IA0KPj4gSWYgd2UgbmVlZCB0byBp
bnN0YWxsIHRoYXQgcGFja2FnZSBvbmx5IGZvciBoYXZpbmcgbHNibGsgc2hvd2luZyBtb3JlIGRl
dGFpbHMsIEkgd291bGQgbm90IGNvbnNpZGVyIHRoaXMgYSB3b3J0aHdoaWxlIHN0ZXAuIEFueXdh
eSwgdGhlIGtleSBpcyB1bmRlcnN0YW5kaW5nIHdoYXQgaXMgaGFwcGVuaW5nIGhlcmUsIHRoZW4g
d2UgY2FuIGRlY2lkZS4NCj4gDQo+IFRoZSBpbmZvcm1hdGlvbiBhYm91dCB3aHkgInN5c3RlbS1j
cnlwdHNldHVwIiBpcyByZXF1aXJlZCBpbiB0cml4aWUgaXMgbWVudGlvbmVkIGhlcmUgaHR0cHM6
Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2NpcC1zZWN1cml0eS10ZXN0cy8t
L3dvcmtfaXRlbXMvOCNub3RlXzI5ODYwNTQ2NDAsIHBsZWFzZSBoYXZlIGEgbG9vayBhdCBpdC4g
QXMgbWVudGlvbmVkIGhlcmUgdGhpcyBwYWNrYWdlIGlzIGFscmVhZHkgaW5zdGFsbGVkIGFzIHBh
cnQgb2Ygc2VjdXJpdHkgaW1hZ2UuICANCj4gDQo+IElmIHdlIGRvbid0IGluc3RhbGwgdGhpcyBw
YWNrYWdlIHRoZW4gdGhlIGxzYmxrIGRvZXNuJ3Qgc2hvdyBhbnkgaW5mb3JtYXRpb24gYWJvdXQg
dGhlIGN1cnJlbnQgcm9vdCBkZXZpY2UsIGluIHRoYXQgY2FzZSB3ZSBzaG91bGQgY2hhbmdlIHRo
ZSBjb25maXJtYXRpb24gbWV0aG9kIChyb290ZnMgc3dpdGNoKSB0byB1c2UgImRmIC1oIiBvciBz
b21lIG90aGVyIGNvbW1hbmQgaW5zdGVhZCBvZiAibHNibGsiLiBQbGVhc2UgbGV0IG1lIGtub3cg
eW91ciBvcGluaW9uLiBJIHdpbGwgY2hlY2sgaXQgZnVydGhlci4gIA0KDQpKdXN0IGFzIEkgd3Jv
dGU6IEFkZGluZyB0aGUgcGFja2FnZSBvbmx5IGZvciB2aXN1YWxpemluZyBpcyBvdmVya2lsbC4g
SWYgdGhlcmUgYXJlIG90aGVyIHVzZSBjYXNlcyB3aGVyZSB3ZSBuZWVkIGl0LCB0aGVuIHdlIGNh
biBhZGQgaXQgdW5jb25kaXRpb25hbGx5LiBJZiBub3QsIHRoZW4gY29udGludWUgdG8gbGVhdmUg
dGhpcyB0byB0aGUgZmluYWwgaW50ZWdyYXRvciB0byBwdWxsIGl0IGluIG9yIG5vdC4NCg0KSmFu
DQoNCj4gDQo+IFRoYW5rcyAmIFJlZ2FyZHMNCj4gU2hpdmFuYW5kIEsNCj4gDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gDQo+IEJlaGFsZiBPZiBKYW4gS2lz
emthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2VudDogMjMgSnVuZSAyMDI2IDE4OjAx
DQo+IFRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIA0K
PiA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gQ2M6IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCDvvKTv
vKnvvLTvvKPvvL/vvKTvvKnvvLQt77yv77yz77y0KSANCj4gPEFkaXRoeWEuQmFsYWt1bWFyQHRv
c2hpYmEtdHNpcC5jb20+OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIERJVENfRElULU9TVCkg
DQo+IDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6X
IOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIA0KPiA8a2F6dWhpcm8uaGF5YXNo
aS5mNzRAbWFpbC50b3NoaWJhPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1j
b3JlXVtQQVRDSF0gUmV2aXNlIFJFQURNRSBmaWxlcyB0byANCj4gcmVmbGVjdCB0aGUgbGF0ZXN0
IGNoYW5nZXMNCj4gDQo+IE9uIDIzLjA2LjI2IDEzOjE1LCBTaGl2YW5hbmQuS3VuaWphZGFyQHRv
c2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+PiBIaSBKYW4sDQo+Pg0KPj4+PiBZb3VyIGR1bXAgaXMg
bWlzc2luZyB0aGUgdmVyaXR5cm9vdCBjb250YWluZXIuIERvZXMgbHNibGsgbm8gbG9uZ2VyIGxp
c3QgaXQgYnkgZGVmYXVsdCwgb3Igd2VyZS9hcmUgdGhlcmUgaW5jb25zaXN0ZW5jaWVzIHdoYXQg
d2FzID4+Y29uZmlndXJlZCB2cy4NCj4+Pj4gd2hhdCB3YXMgcnVuPw0KPj4NCj4+PiBJIGFsc28g
bm90aWNlZCB0aGlzIG1pc3NpbmcgdmVyaXR5cm9vdCBjb250YWluZXIgaW4gdGhlIGltYWdlLiBJ
IGNvbmZpcm1lZCB0aGUgc2VjdXJlIGJvb3QgaXMgZW5hYmxlZCBmcm9tIHRoZSBib290IGFzIHdl
bGwgYXMgZG1lc2cgbG9ncy4gPkhvd2V2ZXIsIHRoZSAibHNibGsiIGNvbW1hbmQgZG9lcyBub3Qg
c2hvdyB0aGUgdmVyaXR5cm9vdCBieSBkZWZhdWx0LiANCj4+DQo+Pj4gUHJvYmFibHkgd2UgbWF5
IGhhdmUgdG8gaW5zdGFsbCAic3lzdGVtZC1jcnlwdHNldHVwIiBmb3Igbm9uLXNlY3VyaXR5IGlt
YWdlIGFzIHdlbGwsIHNlZSB0aGUgZml4IGZvciBzZWN1cml0eSBpbWFnZSBoZXJlWzFdLiANCj4+
PiBUaGlzIHBhY2thZ2UgaXMgYXZhaWxhYmxlIGZyb20gdHJpeGllIG9ud2FyZHMuIA0KPj4NCj4+
PiBbMV0NCj4+PiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1j
aXAtY29yZS8tL2NvbW1pdC8zNmIxMQ0KPj4+IDENCj4+PiA5MjY3NDA4MmFhYTEyMjhjNjBlOGMw
MjM5ZmE3Yzk0MTExDQo+Pg0KPj4gQW55IGNvbW1lbnRzIG9uIHRoaXMgdXBkYXRlPyANCj4+DQo+
IA0KPiBPaCwgdGhhdCB3YXMgYSBxdWVzdGlvbjogSWYgd2UgbmVlZCB0byBpbnN0YWxsIHRoYXQg
cGFja2FnZSBvbmx5IGZvciBoYXZpbmcgbHNibGsgc2hvd2luZyBtb3JlIGRldGFpbHMsIEkgd291
bGQgbm90IGNvbnNpZGVyIHRoaXMgYSB3b3J0aHdoaWxlIHN0ZXAuIEFueXdheSwgdGhlIGtleSBp
cyB1bmRlcnN0YW5kaW5nIHdoYXQgaXMgaGFwcGVuaW5nIGhlcmUsIHRoZW4gd2UgY2FuIGRlY2lk
ZS4NCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hu
b2xvZ2llcw0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5k
YXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


