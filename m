Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0792BFB44A2
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 04:15:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14284.1777004136264039363
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 21:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZRvZwIXc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1777004132;x=1778213732;bh=DhM3UBu44v7qkrxke7Fx9lp/ANFNivOtKGHw5
	1547MQ=;b=ZRvZwIXc8Erej9V5pfUw73hWE+OPKTjOIYeY8IURU0VxopVj85ggjkw2OTljqt2tsiZ
	FyCwcAbMV7na9munW2OerRzFgD3g+sP5cujTJSyIFcIwOYCUZ0O5tawLc7L7LVb+AdXPOU/x3sRob
	duWeGtZFGFtqSR82ZGc3WbI64hYXydSf2MIWeZn6El/6ZNkzMZZEFvD2uSjAIMfQ4iYlSGrT6Aqhm
	lsWhR5qClSwQ91QZZ2ihHKVkHt/ufc79bGe2ol9yhmeXe5TrPouHZIr2AgZuGarXmWmGyC1SobW/Z
	mXrVbcpjk5inWJeQ/qJFWzCTj4S+k4yF1doCnAPLMAEA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63O4FV0F3189503; Fri, 24 Apr 2026 13:15:31 +0900
X-Iguazu-Qid: 2rWhBcKdnieUlcMWoK
X-Iguazu-QSIG: v=2; s=0; t=1777004131; q=2rWhBcKdnieUlcMWoK; m=b4Xgjzm9VAQqWuOFBFbxjgT0gGSVa4O4r9y1Pokh+SM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g204L5X9pz1xnl; Fri, 24 Apr 2026 13:15:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUdNoVAYUI+4ZTvxsA88LVRP77ktzB5dQNAWlMxcPRbh/RhgbNYhujjXPk2yoO1QjoRrllUXK2XtIy1o7IM8w4+36sHWnV76mrdAjAeMbnRrcbhIt8NKPFMlgFR9SuJVwdgNN3EJHnpP/nYUUwhLeQmRVbPLC01aHrOzABglPym4pKz/FnXOeuJElqZBytzsPsJGlXJw31yIbivoTgkZZtWTzm90oQBSENp0RHFGO8nko5qSDbjVZnBOh/iPH/+5XVci3/vnGN13vRFSvTHNsuIOtIyj/4+eETZRF2lPKDhwE4luiMxTQtXTdXOTajaR1QFoUsdAk27m9b8jTUKFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhM3UBu44v7qkrxke7Fx9lp/ANFNivOtKGHw51547MQ=;
 b=yyG/f7O8WdjONsWxFBs1GcNaTJC2pYpcAVZ2LcsYLQ5sCMkMCbyE6m2Pvt+eYQNfsR2MbmztpEya/b3VN3ZahmR6Ntrf4yUTGjLKuySAwwA9VQhMuj982D5SP521q8ujHNw24k/aeAFv34rxlKc22Z1HhDfsZS68ixOQbkbpLAewX2rNjVJB1Oa6rKrbBwpSH21R+xWt4Bzen5hWxFCVg+SjB625tr9Lx3dpVxmsFfQXbVZSOmFQgvXQvW4w0KWeS8RrmzeOqb3EsmuXvcpQuaDkChRPrkiC1KW4cDqtIRIC9np3Y2hwXoVwVazaq1Cclvet0fT5U1drPhEOpVjhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <chris.brandt@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 5.10.y-cip v2 00/10] Add additional support for MIPI-DSI
 for RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip v2 00/10] Add additional support for MIPI-DSI
 for RZ/G2L
Thread-Index: AQHc0xmlrgumSxBAw0yOkn4PAN6xkrXtm2rw
Date: Fri, 24 Apr 2026 04:15:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180710B3BCE73D8222AEF2CD2B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260423120630.1487798-1-chris.brandt@renesas.com>
In-Reply-To: <20260423120630.1487798-1-chris.brandt@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB7315:EE_
x-ms-office365-filtering-correlation-id: e039e1f5-8852-466c-9ecf-08dea1b81d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|18096099003|56012099003;
x-microsoft-antispam-message-info: 
 2nQAmXBR2rMA/+2TOXpp+cPqk4JEDAm6roSgEU4potWbKrtYb9dhVVKsWrmob86CEAW8xXcjrG2VMkRckOuSypZLcTVBZl9WX23vn3lraiMmkdmAoNBzrhBe6S094k5a9aPJLIPNSQjTWuO9k+Vaq7QQCsc8zpev5sCFPqFosyDiPYt0Mo/M62BGH/Rc3h6kKGTdoMYIe9RkkytMmu8IYKfzBAbmdJ+qYWuMgBNi1b3A931fgcCjcr+z8qyGQaHyD0D0drJRf46gFnzNoiI3B62vzNitnpMKiBaEgIhXiCDvxREgRJTWz9bUgnbvfbuiFA+ccZSovVBJVq/C11xcPh7dBD/E1L0fd32mKMkd7gL7NpnGz+vQuy6dBuy7mGIfS+4ICvueDkj39TaOap43prM84BqRGuO+rrlG3+gzZWrnuTSx4DBK7KZtNyR2skmd5IjeuFmWkUzxvIbob4ysc5AqdrhXC8cAn601sCR6bs9+zIKSCUAQHU+aCVM5Hi9nIBI0qGeoG58/QXhnsKmu9EM6HxmXW1xi2P0oYDMdbsN4WMblNkVx9mBflm2OfBMR5uhNYPxvXwwHYU2tR6VYnJrAYRSVrcSqtUJsk/h2cqYeIAhYCUdAf8El60k8mONGN6ZKYR4ZVAeGdavjmA2tE5sA+9V3gB9mEnR9TpHLim6LLzP/zusMcphC4VFLOiF2/44hK0Y02qZmTQ0BpcNXFUFyLOBdh4e/sRdOkW+vFlKKrahc+HVdGvmmUGh9rTggfGJ6s5fE7nTDb1hC5YFwvu17gOohTtnBm8LyEeNnCZY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(18096099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MEZQekovTU5HdGFWTVpzcGFXVnpJYnBWY0E0NDl2WVVwOFB0dStCZWhwcnpK?=
 =?utf-8?B?R0xPSDNFajVlNWxSbXVIdVAySHRGWC9SYlNJVEx4V0FiWE45dVlsY3VqRkZD?=
 =?utf-8?B?NkJnaUZaWE81Sy80T2ZTVWRNNWdTaFZJZmNxNjl4cGk4bWRKVEdrN2VRdFkr?=
 =?utf-8?B?ejA3dUNZMjdZZENXOUozMFkvVkxUQnNPWXh3SC9hSTFzdGk5cG5lZUo0VStn?=
 =?utf-8?B?RU1zdlNtTlZOSjhtNTJrdVZycXVGV004SWtzTkhtVUt5WE1mMFZvSDhxQVJB?=
 =?utf-8?B?dGVZQ2NNUjFTWFF4cldTTDJQTGswZFF0WDB4bFFiSk1CbFhKaWZtb1FteVF6?=
 =?utf-8?B?WExJQXNoTjY5WGNVelVvUm8yZys3QlhtVzhMdHBUNk1LZVVpd2ovQWs0S1BO?=
 =?utf-8?B?Q0ZoenNETjJvRUI0eTRwOVQ3QmhEcHpPczBtYTlvalFYNEluSUI2cGIrYWJy?=
 =?utf-8?B?SXBmNVNrV3ZwTTJ5eFFRUmV0b213UnJ0eTN0VWhTUkhodGx3N1Y2K3NOSHRD?=
 =?utf-8?B?b2FvRmZ3bmx2cHpkaDJSSWpjMi9IbGdZR1UxS0J5NTBFT0FwM3hCbE9QTkhv?=
 =?utf-8?B?SHN6RlhGY1R5TlU3LzhSb2Y3TzdjckZDci9HbzgzU3lqSHNNc213eUVwQ3M4?=
 =?utf-8?B?QVpWN2c1UHlCSjFxdzk1aERvNzYvMlpjL3RGQW1SUXVFODRaUEFPRFpGUzNK?=
 =?utf-8?B?YnhFU0IxdEZhZWhUbDdUL25ERHkxMlJFT0pRU1JxQ01vT0FLeWVBNnJiTWJC?=
 =?utf-8?B?RVN3cllZS1lZcDA4eCt4TERzNk9uQTlmL0RhUXJLU3lCK3JiRmVGT05nZWxX?=
 =?utf-8?B?amRyWmJDL1ZGenM5SVFrT1RSOFVMTTRudFhQaW5BK04rbk5GTThOaFhHRDBq?=
 =?utf-8?B?WGw1UHdsc0diWFNSQlpVRDNVK1ZxdXpqUGJTNDUzb3FtcU42V21OcnRtc2cv?=
 =?utf-8?B?ZTJhdjU5QjFrMmdNZjd0T2lJa05MQ24yZzkxKzMxN1ZXLzA2RXFHbHF3K3c4?=
 =?utf-8?B?dEZSaGdRdEZjY05Jd2hyQ1g3c01MTkFORGY5NXF6V25RMWs4TTJ5c01RSmlJ?=
 =?utf-8?B?WS9reDduVUl2QitZeGdGS2hYQkU1RnoyOUpQbmZOdWpKWlRKMnpNZktLVjMr?=
 =?utf-8?B?UXRRZ3NuUmtKNlpwcHB0TUhLWTBNdzlrWnd2NVIzZUp0dm8wMmhYUS9sTzJy?=
 =?utf-8?B?SDgyWkkrV2dUOWpZd00vaXlxb3FHcTdGaXlKc1JPRS9RTkZzVk9sTmZOUjFL?=
 =?utf-8?B?UTV4UXphSlJuM2lwc1d1bksvNXZJZXBUdldvOXp2NEdVTm52OVd4UVE2NlFn?=
 =?utf-8?B?NmQ2RU9Na2dSSmphbDV4WHlsdnpubHB0RGZ5ZTJpbDI3K2FidjhlRFlWcmtS?=
 =?utf-8?B?VG4xTWFKWVlxdnNPZG1tbXk1eXNBT21BU3k0K2licFQrNXdjL1Y3aEdYVWZy?=
 =?utf-8?B?UW5XV2gxRW56bEQ1RVNXT00rQW9OcEV0QTNoWXhUdTdQUnFqS3ZTUTVJWTk2?=
 =?utf-8?B?bUVCNlFlWTUxR0J6Z0dUWUkrT1NnUXZkZjR2U2p2YXluSklZZWE3bHZNYUJu?=
 =?utf-8?B?Z2lramp5RE5BQklhUlVHUERRbTZJTGJWd1VYZm9tcDJxRVBlb20zY0UzYitr?=
 =?utf-8?B?N1BRaGpqdkZkMnVMRlZsbzFkcGdYR0Y1SkZRTkE4NkcyMWpGWDlrTmQrcEVX?=
 =?utf-8?B?bjRFL2VJNzkvY2xPMGRhRGZtOWxzRVN2elFMdC9FVmw0bEZDOE9nT29INWsr?=
 =?utf-8?B?Nk1Cb2p5REgvaGhDVzBldjFpWWlpa09aUmpmZ1dlS0pPblNZTEJoSStKaVZP?=
 =?utf-8?B?a3dVZkdZUTN2azlXT1ZJcjZVcjZkbk9vZTR0Ry9wMEh0cG8zQ1J4Z2FpbGF5?=
 =?utf-8?B?bDdibEFrNWFOTUs4QVkyR2ZVemptR0NtQzA0WTBZUVpCV0NiQkdXUklWNjZv?=
 =?utf-8?B?eW9VSHJvR3FYTUUwUlo0c0tCZktLN3NqaE0vQjloY3d3RVhhYnpqTnd2U3NS?=
 =?utf-8?B?NzRsZHppaTM1aW9XVHU3ZDM3WFRDUmJaVEx1aVp0OC9GWmd6Z0F2VHkxK3dI?=
 =?utf-8?B?UzZsSnVucmcvTkRBMGRtQ1RnRTM1UTk2YS9xcUlhWDJ0UDYrYnAvTUZVRXFP?=
 =?utf-8?B?STBNaStNZXoyMEFBaHBYWjhCWVhrMUZucFNmTG9MV2VJV1Y2elR0cFZuWld4?=
 =?utf-8?B?aG5MeDU5eDJaZlJTMjFOZVgvdXdGSk9xeXpaR0VLRzhOekY4eWVOWVVVVGhH?=
 =?utf-8?B?aVAvWkZXRnhvcmd6SHVDa0F1MVhjWVVpVEx3b1d1RmhjUXFVZG5PV290RmdV?=
 =?utf-8?B?ZjhGVC9KVlN5L296TExCVmNBVlcrWmZSN3VjVVl0dzN4VDV2d3ZFMTdMS0Fp?=
 =?utf-8?Q?/72AE6tWXsCrsNHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	B+ahCEQHwi/vxneyw2KHdoGCQtpY4w/4RmtIi6KwXbONlVzo9bt7tfVJUbIhU8qCzKnr/71O/5s/HatDM7HyTnbzZ3rZE/+GbRJA71zcyDOYkeRizeUYOOeppBunWUC0n+wSSo8y3UU8yczGi7YBBgwiuii2phUUHoN06NpzyLz5EdJCUcSEQM0wCxUhIS2VND20QhuB/HdPoFpvue1F18F7kBHvhO9YO84FWRbbJp0o0bU4En9f8MzPYGetQdPNPu43stvsMw4lOB8nmQeDK1f/cUaFzM0/Q/ianY/VqiN3CN5GFLkPQeDny5PBE23ATgq7wx9LM5/PHa0jp7W+sA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e039e1f5-8852-466c-9ecf-08dea1b81d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 04:15:26.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHyEPxwmtA/JQ/xQN2U/JQjwk5JKMWKPqBj0iD2STfLdTltO5CPCbqyf8Go3yV+kTNnuP6KeuFOcGERuuv+P4n524OaV7JbhIn93Fk+YzmykzoJO7er2KHUPJrLcSX3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7315
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Apr 2026 04:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22805

SGkgQ2hyaXMsDQoNClRoYW5rcyBmb3IgdXBkYXRpbmcgcGF0Y2hlcy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpcyBCcmFuZHQgPGNocmlzLmJyYW5kdEByZW5l
c2FzLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDI2IDk6MDYgUE0NCj4gVG86
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g
5L+h5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvLml3YW1hdHN1
Lng5MEBtYWlsLnRvc2hpYmE+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQG5hYmxhZGV2LmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIDUuMTAueS1jaXAgdjIgMDAvMTBdIEFkZCBhZGRpdGlvbmFsIHN1cHBv
cnQgZm9yIE1JUEktRFNJIGZvciBSWi9HMkwNCj4gDQo+IFRoZXJlIGlzIGltcG9ydGFudCBmdW5j
dGlvbmFsaXR5IG1pc3NpbmcgZnJvbSB0aGUgTUlQSS1EU0kgZGlzcGxheSBkcml2ZXIgYW5kIGFs
c28gdGhlIGNsb2NrIGRyaXZlciBmb3IgZ2VuZXJhdGluZyB0aGUNCj4gY29ycmVjdCBwaXhlbCBj
bG9jayBmcmVxdWVuY2llcy4NCj4gDQo+IFNpbmNlIGV2ZXJ5dGhpbmcgaXMgbm93IGFjY2VwdGVk
IGluIG1haW5saW5lLCB0aGlzIGlzIHRoZSBiYWNrcG9ydCBvZiB0aG9zZSBwYXRjaGVzLg0KPiAN
Cj4gVGhlIHBhdGNoZXMgd2VyZSB0ZXN0ZWQgb24gYSBSWi9HMkwgYm9hcmQgdGhhdCBoYXMgYSBj
b25uZWN0b3IgZm9yIGEgTUlQSS1EU0kgcGFuZWwuDQo+IEFkZGl0aW9uYWxseSwgdGhlIFJaL0cy
TCBTTUFSQyBib2FyZCB3aXRoIGEgTUlQSS10by1IRE1JIGJyaWRnZSBjaGlwIHdhcyByZS10ZXN0
ZWQuDQo+IA0KPiANCj4gVjEtPlYyOg0KPiAgLSBDaGFuZ2VkIHRoZSBmb2xsb3dpbmcgY29tbWl0
cyB0byBiYWNrcG9ydCBmcm9tIHVwc3RyZWFtIGluc3RlYWQgb2YgTFRTDQo+ICAgIC0gImNsazog
cmVuZXNhczogcnpnMmw6IEZpeCBpbnRpbiB2YXJpYWJsZSBzaXplIg0KPiAgICAtICJjbGs6IHJl
bmVzYXM6IHJ6ZzJsOiBTZWxlY3QgY29ycmVjdCBkaXYgcm91bmQgbWFjcm8iDQo+IA0KPiANCj4g
Q2hyaXMNCj4gDQo+IENocmlzIEJyYW5kdCAoNSk6DQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTog
QWRkIGF0b21pY19wcmVfZW5hYmxlDQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTogbWlwaV9kc2k6
IFNldCBEU0kgZGl2aWRlcg0KPiAgIGNsazogcmVuZXNhczogcnpnMmw6IEZpeCBpbnRpbiB2YXJp
YWJsZSBzaXplDQo+ICAgY2xrOiByZW5lc2FzOiByemcybDogU2VsZWN0IGNvcnJlY3QgZGl2IHJv
dW5kIG1hY3JvDQo+ICAgY2xrOiByZW5lc2FzOiByemcybDogUmVtb3ZlIERTSSBjbG9jayByYXRl
IHJlc3RyaWN0aW9ucw0KPiANCj4gR2VlcnQgVXl0dGVyaG9ldmVuICgyKToNCj4gICBjbGs6IHJl
bmVzYXM6IFVzZSBJU19FUlIoKSBmb3IgcG9pbnRlcnMgdGhhdCBjYW5ub3QgYmUgTlVMTA0KPiAg
IGNsazogcmVuZXNhczogQWRkIG1pc3NpbmcgbG9nIG1lc3NhZ2UgdGVybWluYXRvcnMNCj4gDQo+
IEh1Z28gVmlsbGVuZXV2ZSAoMik6DQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTogSW1wbGVtZW50
IE1JUEkgRFNJIGhvc3QgdHJhbnNmZXJzDQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTogbWlwaV9k
c2k6IGZpeCBrZXJuZWwgcGFuaWMgd2hlbiByZWJvb3RpbmcgZm9yDQo+ICAgICBzb21lIHBhbmVs
cw0KPiANCj4gUGFsaSBSb2jDoXIgKDEpOg0KPiAgIG1hdGg2NDogTmV3IERJVl9VNjRfUk9VTkRf
Q0xPU0VTVCBoZWxwZXINCj4gDQo+ICBkcml2ZXJzL2Nsay9yZW5lc2FzL2Nsay12YmF0dGIuYyAg
ICAgICAgICAgICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcmVuZXNhcy1jcGct
bXNzci5jICAgICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9jbGsvcmVuZXNhcy9yemcybC1jcGcu
YyAgICAgICAgICAgICAgIHwgMTgyICsrKysrKysrKysrLS0tDQo+ICAuLi4vZ3B1L2RybS9yZW5l
c2FzL3J6LWR1L3J6ZzJsX21pcGlfZHNpLmMgICAgfCAyMjMgKysrKysrKysrKysrKysrKystDQo+
ICAuLi4vZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfbWlwaV9kc2lfcmVncy5oICAgfCAgNTQgKysr
KysNCj4gIGluY2x1ZGUvbGludXgvY2xrL3JlbmVzYXMuaCAgICAgICAgICAgICAgICAgICB8ICAx
MiArDQo+ICBpbmNsdWRlL2xpbnV4L21hdGg2NC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MTMgKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0NTAgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25z
KC0pDQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0KQXBwbGllZCwgdGhhbmtzLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQogIE5vYnVoaXJvDQo=


