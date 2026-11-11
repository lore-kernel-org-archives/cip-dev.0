Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1571.1794357711852784359
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2026 16:41:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=lM+fTHVN;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794357708;x=1795567308;bh=Ipg0xd3TtSl3haew46EgdXIOB4EXnzqC+Ihli
	13JX+M=;b=lM+fTHVNkqDbdl+MP+QTyzBQr90Y4IMWeSrASFkLT1pa+4qMSmBX236Z6Q4vZeu3o2J
	FCbUEQMbHGpP9IgoCAxD22r4x0wnud/TUP8lZF0bR+EEwcd75X9vA+CSp+Gozo0BI5EHMCTdlCOjy
	0DPmRb0Jg0dWix8JnWksMTXL0prA3ewq/oL6XZ0NHozz48BUkySPKeDG7BjPBsJKgMLgu7ULcjfTI
	xucflvhIAn/lzzhQr6p0YxX1csxTmkcsXJHN24XM5VF+Mw82RQC1MtL41fza9kcs7LmahXYu/tcDh
	uq4TvYBospWldM0bTgUGSDtCTPuV71gbITA069TPVQmw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6AB0fl8d1078067; Wed, 11 Nov 2026 09:41:48 +0900
X-Iguazu-Qid: 2rWgYSPeppLohTEo0x
X-Iguazu-QSIG: v=2; s=1; t=1794357707; q=2rWgYSPeppLohTEo0x; m=xK0HR4n3cp6oYccLN1/PfBqMQJDCOH2LfquVfwYgpac=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jPPpz3GZXz1xnf; Wed, 11 Nov 2026 09:41:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dq/7ooZ4Y32dipE6LQIvb35FjUFh+nMxlDoKGiiIqI1QiNmGWQujlTRmZU7W2I+rVQ/4NckJR4FwKnHDIPcpnJQrJOtdDmkznpuuoYavwngWvQlNlZ5674MobuEgJIo4+UlGSel+A/qCCq4sc14SVuC3VUB0MgVLxz9yO7ZHZljmI2IHL4l23XYz1ueUyKhIPJnMx70WItrR87xi5PnuNR5nNlHf+BB1DqqBqKc9DHGCCq0IS+r0COKeyjCKNI9H/8cl8iaAQa1KbcwkxbpY2mS1jbtehN/IdUD0iiDma513VwqdzEkpDBBusBm6SY3Y63yHgn2A+t7rJfgnr06A+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipg0xd3TtSl3haew46EgdXIOB4EXnzqC+Ihli13JX+M=;
 b=lVr/ZeevxYz9dx/ijXtqFG6CxUdrn9TCdLULkrtTHsOHNwgUohwc0hxeg8yjz1rqvaLASatrmT6Zqz+jV2006xaVd7U9HNilqyU32UBH1O+Dxl3KbU1PkeThEOI9vOC2h841BQe/lS1+O0o4+n9iL2D+KWVwM/yNryaYN0FjK8sH0Is0ljKhqK4Gm2lURqyIkXnjnu6j1XmxbqBy206wR53K7FVxIgTc10Idt2cG1MVgtYLMbsY4wGNcTKVyEHnGoM5BIxm6cmjVUSrb/eZ4VKSciqVrYpWB/O+koH6mdVkYcuyJD0GJec2C2RK4TwOvUqKDAXp5IXjG7u+DwfsAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH] u-boot: Use release artifacts instead of
 generated archives
Thread-Topic: [isar-cip-core][PATCH] u-boot: Use release artifacts instead of
 generated archives
Thread-Index: AQHdcTFUceFG+tmFAUqvGAw4GvTJyLcoCCdA
Date: Wed, 11 Nov 2026 00:41:44 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818F0DADEA551A1A578750FCD712@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <87ba589e-3b20-4272-b264-74225378e6e0@siemens.com>
In-Reply-To: <87ba589e-3b20-4272-b264-74225378e6e0@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB14458:EE_
x-ms-office365-filtering-correlation-id: eb432f36-9aee-4968-cf55-08df3f8c8f9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|11063799006|56012099006|261022075727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: RL8AGnBWqwAxO7SoO8lzv2KGVhDV69WATXsHFC5687jbZylC3afAxI7WStxdsN3OeHy6DlMxFNCyvt5RsIgjVL+wan8Nuz/keroMG/YLv3riSkvUfQFZx4yrsyCzQsoLs/z1u8Z4Fkq5rHDaTLAPODTBQpQW/F5I6etii9x5I1Ky4wTybi0AdzlEy1W2y//sAEih9XkJCnRXSXTO4DnZdVFqNRjT9X6Ukub8CaW1zBUHtp4fpciOrorTfCe45qgVQlR5hOCaOSJ7PbThbQ22JdatFfjww7IsXTaHQjgy4kq+P58p4ICjM+od2VxTh5hK0zmUCc33ZSO9HLCSUQ2K4ndaO2UWwVhJEPVqTAjsTZzSAEF3VZRnwwUBiS+RKz1gEjh188tp+ztuGYVFMBQYtxl1ot5EK0mhVMGJJNYt5KLR0hVlvaaVsfpqs/384kakMwf8Fq2ePmMzCP7Lf8AhqrhvjgmgIUHJ6YoVvfpboXC2iWfi2LjOixEMhwwQvYfnSmfjxs1IqeY6YekM3AkQsXVZmqAMWrH8GRNw/q2gUPKnGJFaAORQNmd7Bq5oHxT53agebifa8ZjYMWV5taDhnjejnkmXea8W0d6hOZpGj04gADRIqYDxzo5CsMCVR7rbfdF+EWIZq+F7d3f8R2qwPKIarlQXPkVS6rLynxrXFuK7/9pCGiQsi6ASSDZA2oimrMnoPWVkqeLtrXpzGi50qSQjbtiSUDww/H+Q2w7CMck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmFxclc3Q3lYRHA3K0tpTHlTa1JnajUwTDhiZEtnaThkVFltSm5WMWk5R1Ix?=
 =?utf-8?B?NTRTUUlDb2FlYUN0YmJPZ2UzK1FZREhzeVRyK1VEbjZFL0tydWJoRHMzUFYy?=
 =?utf-8?B?Y2M0elBxRkRqODBsamF3aWM1RjVOZ0pITE8xdnpHWnlyNkJHbHBScERVVk1H?=
 =?utf-8?B?aEVab0VUNk45Mysrd204aXozZHVZNHBsbUE3MlVFNXBNVmRWZ0JMdmJCd0RC?=
 =?utf-8?B?QXZYc2t1aDBUalI2QnEwZCtYSzN4NEowRFVpaTZ3K2NvR0RtVzlSaHdVSzh4?=
 =?utf-8?B?TGhWU2xZd2NnTitmamsyd2wrenhzRmtnQWVYSUkxY29RaGhyeDJTM0RINmJM?=
 =?utf-8?B?S2F2ZzV5dWtqbWpuV0F3bnYwRUtXdHQyclpNZnN5aVlpWHcrbTRoOVlBSTNM?=
 =?utf-8?B?RkhnZEZKaEZNc20wNVFCS0JwR1FOV09qeHluWFlkOGlGS3N5RWhKWUl5VE9r?=
 =?utf-8?B?SE5Cazd0ZmM1RHloR00vREkvZXNlK1EyZkJtUHMxTTJ6OFc3TXJHYWVneXkw?=
 =?utf-8?B?ZU13dEFFYUl3eS8rL1NtWWJmNWNTZVJWNVExeXF3bWRqT2ZadGU2eVgvdUpK?=
 =?utf-8?B?aW5KVHlncUY1VGRQejhXZXM0M3ZybFdaZENFTlNNMHVlRlFMUTlzSndiOTYv?=
 =?utf-8?B?Vk1aVFZXcnNMSEFaeTB2ck4xVHNXWmRNZ1FXclEwLzlrTExSZVI1cWRIZTBE?=
 =?utf-8?B?YjR5S2hWUitKU0orNi9COVE4VVJKWVgyK0tQM3ZmaGZCcE1MRU5HQU9zTnk2?=
 =?utf-8?B?dFdQc25wakNhTitKZkZTdjMzMWxsZ0xObXNqL1c1ODNTUW90aEFhTEt6bVVr?=
 =?utf-8?B?ZnpJd2hKM0JFNS9wc0wxTGRLZ2hhRU80VXlCNFEwUlcwcUpqMDhnZG8xWG1E?=
 =?utf-8?B?WVVieU5ZRTh1SVNEYXF4dk9kVU0wV2VCeEE4R0JxZlRZbkZ2Rm5xOHhaVm1u?=
 =?utf-8?B?N2pnZ2NaWDhyZUVKdGNBYUdVUmt0bE5EVDMrOWFSamh5MjJjK0JlOG9rQ3JW?=
 =?utf-8?B?Q3dhRHNKOCtkanhkbmpEU2NWclMrY2JjQ3VnWE1iR3Evd1VoVlFCNkpCenlI?=
 =?utf-8?B?YzFDSFpXSWpJU0N4OHljTndiRjk3K2NJTWRyU01TV1YwZXVPRlBLSWNva2M1?=
 =?utf-8?B?b3oxYnBrRmt2WEJKWFRaQnQ0UzVwRWtSRUVYYTY2QWcwV0h3UDlELzhuWXhP?=
 =?utf-8?B?S2djMzFEVFNVOHF0R2lGU0ROVmRRdGpLYmRaYy9qM2FMN1FCMDZWQ2ttNG5z?=
 =?utf-8?B?a244eURDb0Q2eVFHWWNuOXB3R1hpcHp3eVh2ZVloUExHZFd4bjJYRHJ2QWZh?=
 =?utf-8?B?WURYK1BXSGpMdHJaOUI1YmhJR3llTTdtTU1XL29LdUlna3l3SXEwZk9ma1Zz?=
 =?utf-8?B?SURHYndvZlBpK3JXVzltY0dObTBzRU9Vblp0WmxKZm5IelgwUnZPd0pBL3ZX?=
 =?utf-8?B?U2c0REphbHprNFkyelY2UnlkbnV6VTVJVjBaNlpDZjFrV3kySGkwOFJ6ZGdR?=
 =?utf-8?B?eHIrTVR6UzlmUnp6YURsWHloMk5lamJMTHpDVEFkazdVSStwUDBscXY3UjZ0?=
 =?utf-8?B?R3pwWEhDNm9UY0U0NlNjQmQ4NW9qajRYTTdWK3MzTFF3bXVZaDdVTlJnZ3Fp?=
 =?utf-8?B?QUlZbUVVNUlGOWMvSlBEZHhvbHVXNzdSd2R1RUpsY2EybzdlcUhGalVFeEkr?=
 =?utf-8?B?TG1lQUtnNmxHcmlXVW9MbzE2T083d1AwWFd5cTFvY1h3OTQyNHRJNmJYenNW?=
 =?utf-8?B?bjE2MGZtVWNLSmhUTDBSNDdFdTMwcE4yRmwxRzJBQld2MEI2WDQzQmQzandQ?=
 =?utf-8?B?YmFuZ21qS2dSemhSVllHSWJJVUkrVmtaakRZOXJZTFlnZFh0c0dIemthZVhL?=
 =?utf-8?B?TXNDYjFXemludUE0L25mYXhRWUJlN21WWmNRQnlVcFdaeXhUOUh0RGhnUkJZ?=
 =?utf-8?B?d0VjMk5GblpTVzBGckwzd3BsRGc1QWRkMTlFNHpyWm1xVGZzWG1sYlRRTnB4?=
 =?utf-8?B?YW9YdGlVcFVRSEFTbGMraW85dzlyQVNzWEVkbkxMMTdOaFVOQ0ZaYTc3OTUw?=
 =?utf-8?B?aXcrQVYzbjE0UzlrZXFwSFQ4OWQ4RjNFMjNjZGZEalJpVjA4VUJIdXFyUDRr?=
 =?utf-8?B?WUZMV0FSK0RuMjZGSmkxeUNtRU5aWGxucmtLWkJEK0RFcEFqOXR0RmFLSitK?=
 =?utf-8?B?NGkzUWhtMjVCdEJoMWdXL3Z2dFVlTndWUjgxUDd3OEpQMnl2QmZ5bnBZV0dp?=
 =?utf-8?B?eTRJUjU2cUp5V1RYZG5kcURmMUlCeHFiM0hZai95M3IycmZoTzgrSlBEKzNj?=
 =?utf-8?B?d24wUnhkMEV3bE1yS2dDTDh4VC8rczRwOGNPc3NDUEZaVkpjY2JBVVA4MEpx?=
 =?utf-8?Q?YvEJ1zsiURDeNwcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zfN/r5w6l8H7rewJX96QNsgo4MMVipn460QmiUklSXMmJMh8NVJuO8qUUyiteFyJgwa9s/E/TAQxhhJQsT6TDpdholaDUlUq2gQpO2HeK9fegJKneBrIG8gF7XmlXg4TeanA9VmyisO9JfnXbEaYppj9f3ZvoN62OuyDjrySwqpwQo8fSpLJwMUHHE6Xq43Tu7dkyL12r5ALlLMoCPK1g59lx6J+Yd81AluNPCIAsq/sOflOFfbxiiaby58zqZcbGUrQO2HWqSx0u35U5og5bGvrI3T0pwjR94JNxyJgI9UNszO3bzETbKatTpD/twF4YeTRiNvFGzuUr+BvLJiPHQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb432f36-9aee-4968-cf55-08df3f8c8f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 00:41:44.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6/olCLlXbOuYew+3JWOWgjbgBFh4IfKSYU6SxgHTgUBFLFqr/Z/x7fOWhrkjkRkxStKiB6oQGic1J2yklkVkEwQaQdGOYDthrYcQcGhG8zIavycQMCqY0/LK98aiAZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 00:41:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24736

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDE6
MzQgQU0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPiBD
YzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPv
vLDvvLQpDQo+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiBTdWJqZWN0
OiBbaXNhci1jaXAtY29yZV1bUEFUQ0hdIHUtYm9vdDogVXNlIHJlbGVhc2UgYXJ0aWZhY3RzIGlu
c3RlYWQgb2YNCj4gZ2VuZXJhdGVkIGFyY2hpdmVzDQo+IA0KPiBGcm9tOiBKYW4gS2lzemthIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gU2hvdWxkIHJlZHVjZSB0aGUgbG9hZCBvbiB0
aGUgZ2l0bGFiIHNlcnZlciBhbmQgZ2l2ZXMgdXMgdGhlIGJpdHMgZmFzdGVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCg0KVGhhbmtz
IGZvciB5b3VyIHVwZGF0ZS4NCg0KUmV2aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1
aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVo
aXJvDQoNCg==

