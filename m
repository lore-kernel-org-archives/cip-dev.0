Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7338.1794461183483507045
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 21:26:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=akqKpVlY;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794461179;x=1795670779;bh=x9bkgvIQnU9jNmCXVJeB7B1es6JElZevx7QM/
	NYlH9c=;b=akqKpVlYww7GV+fS+Mltlx7gvpHA6760ixwoJDd9lWE4FC/5ISC5QG2tnHHtKSKbwOM
	7Xi/TKORzzfCgBlPTGUYc1T6oWwuDMgOZtWbryfOQhd1OftgxX4/sufnxVRk0lKMFdoK4Dit5J9lH
	oowHSWH4wM+eggV4RbfcvMYE7/pS/jH5qdDfj/rmtiueIV5LdBhSABh8rz9grVWoaW33smNsj0Emd
	SVLcX1zi50rZIId9/TKgYacw2B6bPQ/50D6VEVgqjLqC0qZiqj5ClFjP0/KSCsBUAbaYVZmmk6Vv+
	n3jY/8ijLcjnDXVqBFQxJvUfLd62V6kPwi5q626yes2g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6AC5QIYs1446933; Thu, 12 Nov 2026 14:26:19 +0900
X-Iguazu-Qid: 2rWhEvwfQPH0N6dedh
X-Iguazu-QSIG: v=2; s=1; t=1794461177; q=2rWhEvwfQPH0N6dedh; m=cajwrS4hTuaffCTUNabHgxgEa0jItWTDroyDaCgwA5M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQ84n4wQPz4vyn; Thu, 12 Nov 2026 14:26:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNUdOttXHra1W2LpPGHqYCkeRLj49YdpTArPEbOnJmdEqlUOl0qN6TutVw05GXvxY8bzXCH8As8Gee4VYtMp4lL/w/+r2poJ8r9Duh7lfbDUIB0llwiW/GR3MYfsQtDS3XqhDbSxtZvduK4olmr9VmQjaN+PH0qblmI+RlHME1BphjA6pnMlo+wegkFoIr1sdM2SFO89c3Drpgy+3qOCH4ZpFK3qe5elmbQOyqKFxmCNsJSHCpoLOKI7HZNcBf8xWmzGcaGdLT9mo2/zkRGBVUFNwsWDu3OksPpume4Ge6MtQHpwEYByiY9Vb/ycwZDsZ+6V9ZhDikCzW6DXXZwAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9bkgvIQnU9jNmCXVJeB7B1es6JElZevx7QM/NYlH9c=;
 b=GL0dRwxa2fcjUIPxNtHShzK9KJYSJdHK690nLTO/sWqlBR1O3T/HU63BszDazH1tyTbD5aLP8vwaX+qm6pqESaB9rZIEYAU6cD1m/WFHYWnZwcxbSOAiopoyNYLknDC0nhCnxHyidWtp0qwD9fjMRDbe7BlwmS7UQVEUCoeOOjdBQB5KcMjcj+lvSeHWfRDENifsUYXkaOVrWWOHn05J/SMhojHfPzV0wR534yge1X/JbJaECeLH7agCoZi65KJ+3kBXfLoApY9fKXkXj30OLX05V0EWXctO8qcVq4lieb1bpMVtOMfdmbMeolc8X6HZqjOyvOM3IcP67m8y4OqoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <s-adivi@ti.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 0/4] Fix build images for buster
Thread-Topic: [isar-cip-core][PATCH v2 0/4] Fix build images for buster
Thread-Index: AQHdb/6s7f3ygl4ElEW9+h333cgx5bclOrIAgASwczA=
Date: Thu, 12 Nov 2026 05:26:14 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148189E77E74AB2FBE7B1AE44CD702@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <d140afbf-cc17-49f9-9b21-2cee0fb6a9b7@siemens.com>
In-Reply-To: <d140afbf-cc17-49f9-9b21-2cee0fb6a9b7@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSOPR01MB12200:EE_
x-ms-office365-filtering-correlation-id: de835420-bf1e-43fb-cd30-08df407d7849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261022115727099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: FCJctANO1N2H1c62ISlsmvHHuBOQS5zwJCPdm5k8RYUGy1co3NmWkk0Mz0W/YUGOkGb4LIYjvRVINHkotm7WyPllKSfCJvwNzkjP4VgEe5Ej4YzYofRcR2P71tM9TI3RKCrrdxFse/323K8clGw52ozijRg+Ya+yyJXg1w8isquxkCE40VbRnhB1e/9PIvbke7vkiJebCmTgevN430jRRQyYCxHwNMLT1rpiLHk1RRhWl8JA7LS07p37QgC8nuPp7d5werF0wepZ3FgRKfm28HHFA8zLt7qIA6uGhCRtGVag0d0kFksOeW/N1/vEp2pDn9gtaMtDvKLVzFNLmoDVtYPE1x4/iekY4lDJwhO2rGPoPVFs3d6mLpZnelYn5tS1OKkXQvky7N9lZfcXp035gVH+D1v0LbIsUllHQWAadMu3v/j2obkmUDiobFRXQqTXbmF5ysqCJOqM7+8/dlCYaFNRMqLArWJ8J8Ho01gZFGEx06BXyaYnnHANUyGWbwL4GeAD4ZX001m0UyiFd4qXvxauxvylnS4rvksTx+ZVbyNH6NtFDlQmWZbHdRUhprSOW8icT1eTWaQjwhIdUPNTBrHvpiIZcYkciAUJD6bT7w3JUKmIOO1W3AJsXIdNh1fE4WqciHi4K0/tIvDjQ2vWi4nJLgCxU5vQ4FfdLzp5+oKL/FJDwUXY36hsSKbBWInpQrSSXt9gQnUJ/1V5EmNRGrq1a7ekcXHFT9D6VyC89mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0JSTDlMQmd1c1JlTm1YUjlleGhSUWg2b2s5NGdrcE13dVE3SWtVRzU3a3hk?=
 =?utf-8?B?Y1dBWStTNVluOE9tOUlhZERKcHh0aXVBMFBIVy9kUy9hVGZmYm5qVVRGMjAw?=
 =?utf-8?B?cG9QSTZ5ZWJTNksydFZaZ2dSaGxDQUNGZitVdEc1Zzl4Q2hlQWw4ODc3N3g4?=
 =?utf-8?B?QVN2V3czRktkTEdoQ3FWeDJta0ptMFRRNlpwb0swYXJnWmhieUlJdWNJUWFv?=
 =?utf-8?B?UzB5WG11UFdkZzNFUFpRNVpFaGR5cTNmS1l1MnJlU1ZBZlkxaHMyK1VLNUs3?=
 =?utf-8?B?ZDNPbk5ZR1RsRllGMGNtYXB6R3dic3NHdnZ6VkFiaTJBTE5iUWpCRHE2Z2tz?=
 =?utf-8?B?QnpWRXg3YVRUVW9GTW1JeHBIVHphR3AvS3haRHJyNTEzMjdKYTFTV3BwWlhX?=
 =?utf-8?B?ZTBYZ3kzdE0ydGo3UlRlUTFpcXRtNnEwbC95ZUgrRm5ac0pvYS80Z29BMWpQ?=
 =?utf-8?B?c01rVi9GdUNjUTBtbUZ6QXZzU3BIMGZOWDlxSXY2TkpDTmRwN25CalZ5clov?=
 =?utf-8?B?QlduVktreGRYV3BSYk9DZzd0cmNMb3pyL1k4dGtZNTZSL0JlZDcySXNLOERT?=
 =?utf-8?B?MEZya1FCVGpqUit6L0c5Zjl1Nit3UUtsWUdnSE5lM0dIdU5tZ2d0c1JYdUpn?=
 =?utf-8?B?R2JlRTZDQk5pZ3JiYVpCRUV0T3Vkc1EzTUp6ZWtoQzd5eFJCT0wvbHVGR3Vi?=
 =?utf-8?B?TFJOY216VnlSTVpzMDB0ZzBkai91OTdWaWluVWxkdG9mK1R3MDRpL2F2eHpk?=
 =?utf-8?B?SmpRd2lqWUFiSlgrdjh6NlY1NlJkNWpLTm1FZnJJN2RIbzY2M2V6K2l6M0hV?=
 =?utf-8?B?c05ZcTh0VnpwU0tocCtaM2VrYy9Bb1R6eitwSEcrbjZWd3ErTEJtcTg3eS82?=
 =?utf-8?B?cEF5MGRLM2E5UndHNk5YS1JJNUc0Y214ZFpIZHlMQTF0NG45ZFZiR1BuTHQ0?=
 =?utf-8?B?WDlJL0hPRlhYUzBDL0dwd0xtWGU2TGhqWmFqcHlDbldzelBVZlpxYVdHTCta?=
 =?utf-8?B?TkhJZWlia3BzaitHV01hck1ORHU1SFlJVEZXeU1uQStPcThlVVdGamx3RTZC?=
 =?utf-8?B?ZkFqRTlnS2lsVGFmUUhJTzU3ZTRJUEFVdGxvMGdlVUx2TldRaFFLUHVnbFdW?=
 =?utf-8?B?VytOalM3QUhMY1FVdW1iSFZkQXRKMjlNSlJSQkdtQlNPaHVUU1MzS0NSaU01?=
 =?utf-8?B?aUFlNkJqQndBN1ZqOFhmTTVaMDhoVDZKYjVTMm00K00yNW1NUTZNVmlJYldU?=
 =?utf-8?B?V3pUZVZVWFFUejJXYjRrbWp4UjcvVzVNc3IrcGJmeFd2cHpHem1jR0UyZVJQ?=
 =?utf-8?B?R0s0SU1XbDYrendTdzlHcFhBZFk3OGNxZUVVMnNlKytOSjdPb1k5R0V3dmlt?=
 =?utf-8?B?UzU3UVBNSkpLTmp3ZmtxRnVCclJEaFJLS21zaEczd3RNQUJDQ2p2d1hXMkNi?=
 =?utf-8?B?NjU5ZVFHVTlRRkt1ODVHZk0xK0hUR3puWTFnKytCZFlsd1R4TjlJa3pKMXRy?=
 =?utf-8?B?UlhWaWRLRGwvWDZKQ2pOYjNrdi9wckc4WER3U0pIL3h2a2VGZSs0RFc5K3hP?=
 =?utf-8?B?ellVK0VwK2N4bkxLK3BIeEhFMHExRWFpQVROMTdvcUs3cHB4cmM1c2pKK21S?=
 =?utf-8?B?VldiNnlVdnZJTitLSGlKeW9NVElVNHJjSEZDamJWUGs0OVVrWlVQL3lMRGM4?=
 =?utf-8?B?NlV2VWR0aDRkYUcvOEhKQmMwMkVrZHFSQjNmZHMvckhmdlRWbi8zU1VDMHVs?=
 =?utf-8?B?OXRiQWQ2dWR5NDZiSWZVOHFCZlZUUTVTUlg4alliUEx0d054NHFaV21wVVNu?=
 =?utf-8?B?OFdNeUwzTjA4ei9pZkd4WnBRb3cyTEgwZE1FaE5EL2tWTWZyMGkwbyswdkI1?=
 =?utf-8?B?azRiQ0VEeXJPWTc0cEdNNmE2ME5RL1VZeVVyUmNPTkRnZ0JRaWE4dDFKU1hC?=
 =?utf-8?B?VnEyTHFGc0xiQUlqN1dBU1ZHOVVWN2JCeWNRWkF3TmpXMmhzUnBrTTRLbms0?=
 =?utf-8?B?b2RMWnBoM0l5d0xWLzZnd3JtUkJXSnNjclpPTjRaV2lXVWJYR0ZFQ3p1ZXFs?=
 =?utf-8?B?Q25UU2NqN0ZFdndwUlVYK2ZLWFRCOGNlSGhUZGY4VG5mTEpPSjJHZ1RMd3J3?=
 =?utf-8?B?UnBGVktSVHp2R2tpczVVY05UemNNMklQL3BSZWRqZ0dMd3A2VWZ2ekN0dXEr?=
 =?utf-8?B?TGZLR1FqZ3ZOYjZVS255eTdYRzhjYlZZUEpBYktXTTcyenZXVG9Zdm8zSmVN?=
 =?utf-8?B?TE9ZZjdaQy9GOXdQTkd3dUd6aGt3NitlMmYyYTIzNUNTZUMyay93WDFkTlFJ?=
 =?utf-8?B?MWV0WE5YOExPaWpKSlZzTHc0L3RaY29UZVBuTE93RFVib2JjR1ptbDVINDNS?=
 =?utf-8?Q?MFLfoOwmBiT9bvxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c/Ct8G4vaFS//xjoq/dZmHGWqq4X+BOEHfFiHIDCceL2ihxQ0VjWevWmuqWvnx+KbyctzwatWfYK5kawt3+N589TTBAKyh8Tsh2g69R60fS3gZL3YQ8GAGy26uYpdpQqObbhUd34l/UZQjpFy58z3AmeB/D8KqjacrmMGb79ao1arX8t845pUY3i9VuTvrH+xrXv8IVVgQKEiVDscG3LM/lfjUcrgrJ8CTlgwzzhz199I4ObhkDrs4Yzhe3pFjny9MZzN/obSQUl7lQoEQHwr0aO0xPagMGftAqpHK5bqAuBJrSTTbQH5I4apln+5+vw1lStCLJUvStXebkrbnj/Iw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de835420-bf1e-43fb-cd30-08df407d7849
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:26:14.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G6bXU9F/t8AGRNmmP6lyh4laEsTK85f1bYSVxmrsPugaN6IolEfkdBUg0upvX/2PlkK4WiCLjIEsJfMAFmY/VkNKsm4lMDL17JvKqjn7suPXJej/JBvJtGAc+JC0C9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12200
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 05:26:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24769

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA5LCAyMDI2
IDI6NDQgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp
77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGli
YT47IEFkaXZpLCBTYWkgU3JlZSBLYXJ0aGVlaw0KPiA8cy1hZGl2aUB0aS5jb20+DQo+IENjOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNv
cmVdW1BBVENIIHYyIDAvNF0gRml4IGJ1aWxkIGltYWdlcyBmb3IgYnVzdGVyDQo+IA0KPiBPbiAw
OS4xMS4yNiAwNDo1OCwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBz
ZXJpZXMgZml4ZXMgVS1Cb290IGJ1aWxkIGVycm9ycyBmb3IgaW1hZ2VzIHRhcmdldGluZyBidXN0
ZXIuDQo+ID4gVGhlIGJ1aWxkIGVycm9ycyBvY2N1ciBiZWNhdXNlIHRoZSB2ZXJzaW9uIG9mIEdD
QyBwcm92aWRlZCBpbiAnYnVzdGVyJw0KPiA+IGlzIGluY29tcGF0aWJsZSB3aXRoIHRoZSByZXF1
aXJlbWVudHMgb2YgVS1Cb290IDIwMjYuMDEuDQo+ID4gVGhpcyBjaGFuZ2UgYWRkcyBVLUJvb3Qg
MjAyNS4wNyBhZ2Fpbi4gQW5kIHdoZW4gYnVpbGRpbmcgJ2J1c3RlcicNCj4gPiBpbWFnZXMgZm9y
IHRoZSBCQkIgb3IgZGUwLW5hbm8tc29jLCB2ZXJzaW9uIDIwMjUuMDcgd2lsbCBiZSB1c2VkLg0K
PiA+DQo+ID4gdjI6DQo+ID4gICBGaXhlZCBjb21taXQgbWVzc2FnZS4gQ2hhbmdlIGZyb20gJ3Jl
dmVydCcgdG8gJ2FkZCcuDQo+ID4gICBSZW1vdmVkIHVubmVjZXNzYXJ5IHBhdGNoZXMgZnJvbSB0
aGUgVS1Cb290IGZvciBCQkIgYW5kDQo+IERFMC1OYW5vLVNvQy4NCj4gPiAgIFJlbW92ZWQgdGhl
IHJlY2lwZSBmb3IgUUVNVS4NCj4gDQo+IFdoeSBkaWQgeW91IGRyb3AgUUVNVSBmcm9tIHRoaXMg
bGlzdD8gWW91IGNhbiBzdGlsbCBjb25maWd1cmUNCj4gYXJtK2J1c3RlcitxZW11K3N3dXBkYXRl
LCBhbmQgdGhhdCB3aWxsIG5vdCBidWlsZC4gU2FtZSBmb3IgYXJtNjQuDQoNCkkgZGlkIG5vdCBr
bm93IHRoYXQgU1dVcGRhdGUgaXMgc3VwcG9ydGVkIGluIGJ1c3RlciBlbnZpcm9ubWVudC4NCk9L
LCBJIHdpbGwgYWRkIHFlbXUtYXJtIGFuZCBxZW11LWFybTY0Lg0KDQpCVFcsIGlzIHRoZXJlIGEg
bGlzdCBvZiBmZWF0dXJlIGNvbWJpbmF0aW9ucyBmb3IgaXNhci1jaXAtY29yZT8NCg0KPiANCj4g
T25lIGNhbiBldmVuIGNvbmZpZ3VyZSB0aGUgYW02MnB4IGZvciBidXN0ZXIsIGJ1dCB0aGVyZSB3
ZSBjYW5ub3QgZG93bmdyYWRlDQo+IFUtQm9vdC4gV2Ugc2hvdWxkIGxpbWl0IHRoYXQgYm9hcmQg
dG8gdHJpeGllKywgSSBndWVzcy4NCg0KSSBzZWUuIEkgd2lsbCB1cGRhdGUgaXQgdG9vLg0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

