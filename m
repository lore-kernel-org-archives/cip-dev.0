Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10102.1795487537935345289
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 18:32:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=NKyK1f29;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1795487534;x=1796697134;bh=CKsbxngIeLuJfrZ+36t9CWuF1/xNIhMxqhnET
	DZSJrQ=;b=NKyK1f29TGkWEaX/nM9471HWs9YTXxHVp9nm0b63A8LLAAAuX7KSJR6OfKwTg/L5eAp
	8rGxdoHHdoj2CcktY9/Y34DEBN4SdBdUjxHVOLjZJ60IkPydop/j52TievdfaeuK6kBBk+oRNRqaZ
	mndJj3mHNRtpJpfrzaWK6CmHtDTwFOmG+q+vXF31HKug22e7yPUQL5cr5lXikE+YHGZ7oFqBp3op7
	1RoUU3m8qQAl/ZmQf9nkS/UTfbZYpJs7jStCZQaRfFr5NrAQTHT3U4OeA7D2/SU4IbFDqB6/Lalla
	H6xa3FEAq48yQYzjqt6OrAhktD1qRhFjh5eZDdhPh3iQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6AO2WESH1491405; Tue, 24 Nov 2026 11:32:14 +0900
X-Iguazu-Qid: 2rWhTexGsjR0FJDiOd
X-Iguazu-QSIG: v=2; s=1; t=1795487533; q=2rWhTexGsjR0FJDiOd; m=1Rcrps7pjOjlcxDKwVEkVFr7VH+akcqkD1mHWDcSehs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jYRfP3JFkz4vyt; Tue, 24 Nov 2026 11:32:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNqSR2s0JurtZMZMlabm0hncOypw6O+PVM1G927CnxCFZd+NaFljNEcFitT3s/Mb0p7QW1BtaZ1MNbQZGvbPKrVxRB29x5uJFzWIYhUrUCc85kfg5scFwVoF7FIBuD31xTYs4DW/7KKFvEdxCiCffEYgCNndE0lcbNgTnknpAfUujspIDFtzQCQoQZqWSPX4404sg/5YuAE0wz/H2e535mjQZI1VQbyafFjZ92/PmvjR0SSo+1ZsGKrh1cqrBfmzYqZkJdxPy8oyn5b5XvRSVqYa6aydGfybIcnqmlj1pyoquTwlVs9HSl+MmU4JNNBFcCuGmmWlLp0izwXYQL9iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKsbxngIeLuJfrZ+36t9CWuF1/xNIhMxqhnETDZSJrQ=;
 b=c6/Pqgw8VVDCdmdiqX3QY/aA9+7T6/XioE+uYU/WhBg41ttnU/nuMvE3qFwu7piL3bEAoJchaKRmjQS9icJWl+tSt7+lnkj3SyP1d1gs6RL9c5rlQFNqjAMM55yra69dJkLU2LxmjURAuvVmW2roMM7h7Gw81zms2hmS/oksaJVqtC+xp9ZGtJcgSqGJWPEKADrw0G9/W1Z6cK1/QL0CqL904a2X86SeRnFOKplxknN7G2+orVSpezdl1IaqWpQz11NrpVig2Xh//YVWH9+K6RAf0plL4HcLEJ9XUamDZweL1mY70Wc+d8KTfY2dleqWEn8yHf4kGhGo2XqkDtxJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Topic: [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Index: AQHddok9jnhS2BPEv0mDi2aejVq0vLc8fwdQ
Date: Tue, 24 Nov 2026 02:32:10 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818259F230784C9BEE2DDD7CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB14933:EE_
x-ms-office365-filtering-correlation-id: ae8c21ee-e404-4e9f-57ef-08df49d3243a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|56012099006|261026121527099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ksYveP9XiB6M/3caje72VEkFsgwJC9+Yy+bkkI9g3tm9gzxA+2Hf88eP+VOSytRiakCYSLyoJVDopej1AYn/Mllv/EZ00y56JM+HaIlbDCL7+Y9T9NscnsjEHXDKf4giE0a1nEE7VQSlTvivQmBLeLx5fSV3zgeikdr/kP3y4olKs+VhwWAhtBqs1rtAAH0nlcdva5f+91zQKRHQLI3f15SmZQdVLSCa3+DCpK+GSLffKHmZ8szd37Ga78ObFE8/8S/dyLZpbL2p5FK5vmVg+RdklAQV0Ie7IIs2AhKU/2VvLl9uvOGWXui9ChgyRmRp43qtcClffn/D8tiCzJemZ6jpCC9ktKTlJE0W7UF/nLHIDI01RHhTHV+uhaYt1s1nIEVoG4mGoyy80EYQl4zbHej6KckyzBRrNEK3X1icb/F8f2PUkQTBVs/R/l7nhDOwNhqEaYshle1gxgKB5cPZD18iMUQqpD+jay/STguM7ZqcCBjt291O6dQ6RHEJuryoXiGsqYKXA3HDnF2Ljecz/pVoTH4wbA7lAnWyPkKSqAyPNndfLjwjpyq9PK1Wgx7bj0Tevm3o3vKLJx1sKeOTlNY0RVAdDCI5U5IDlwW3ylJQ0DW2YpMcmGWErsvING3A3kVit1FXtQ7OI2Dv6M8aEcOGOYlE+Sf0W226UUU28XGlTON6WyWPq/9Z1uf/P2fsaERXv+F1UBFSSRNlFMkbg3Ejlb4zPAfzDvssfUWIKeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGkxT3BhSHRLUUd2VHFyTzRDbkFGSHVKWlRhSjNsTEM3SVorTnJwcnppS2hB?=
 =?utf-8?B?RnhvMGtSNU9wQ3dDMEgxK0NYWjJWY2xrMXZxZjlGbjNxcGpjTTN3aWJva2V3?=
 =?utf-8?B?dHBiaS9VV3c2OGtKL2tEUmRuei9KSUcvNFk1NHdOVVgzeWtuR2JXZzFEYmRa?=
 =?utf-8?B?Q0RJSm5CSnozaUJSZGhodDhObytyeXc0Z24wOXpIR09XL05WMzRrREsvVCtx?=
 =?utf-8?B?dEtnQjdHb0NscnpHSzNTL2pvOUM4dHdteW9vclIrQ2h3TmprcG16N1RkR2x0?=
 =?utf-8?B?cnBSSVZoUUxhczVuSHpCY2tMQnFWNlo2SEN5RVRHSlI3ZmlJVEx4b0lJNFBw?=
 =?utf-8?B?bUZWZlRyVEtEUUZHY0tGSmNNS08ycVNZSlRqS2c4YTc3djAwSzRQcHhxbWRk?=
 =?utf-8?B?L0dBZFNWRitjb2JmRi9ONkJ4NU9LMVlpSVIxenRRejNiN0Z0b3hVTmQ1RUtP?=
 =?utf-8?B?a1p4bS9zOE51V0hiR2hEQ202aUdYRGMrbHR0dGFrL20veWNnK0lCdEMxUjB5?=
 =?utf-8?B?WW9LcVZmREVjSEkrTTBzTkVGeEtBdFVPYmJRMDg5cm1nRnlhYWoyWm5sSC92?=
 =?utf-8?B?WkRPeHZUbDlvSFBzckpvL2pPMDk5ZnBmVWxpSDVaV0g5SUM5blZKd2l1Zk1x?=
 =?utf-8?B?bm9kQ1VUNlhHZnhhQ3Ewd0NVNzNJWHNpNGM3RDhpTVUyV0hLdHJaalNjbTBs?=
 =?utf-8?B?cU85bTg4MWRscUpZQThDeFAxZklSUithajNKTGZkMFNQYVQ3cDhmcllRSFNX?=
 =?utf-8?B?RmRVcjUwQUhkcjFaeE94Qm9Hdk01M2FBRzkrWlhWRDRvZG1lbzUzQkpVR0JM?=
 =?utf-8?B?OW9Fb3lkdW5XUHE3Rm5KWTVReUpOdXJZZWoxdHIzWEdLU2pyTkxOaXYySVlF?=
 =?utf-8?B?ZDhaTTBpSWs3NzJFTVJZSVhTWTUrNkIzOExEdXdqME9PUnJ5dlJ6aDVNeVBJ?=
 =?utf-8?B?MVZ1V1czUTlrQ2VoamMyRGRXbFlpOG1sOWRvemxLZWNlbzNsdnBvZGtocFJp?=
 =?utf-8?B?TytrUWQwR0dkM0htMmE3cjBhNXV1S2tZWGUxR0F3M0JFSjB0OE9KamthYy91?=
 =?utf-8?B?WU04R2szc0tkay9wVkQ0aHNyTm9ZQzlTWCtIcUpCUFJzakRTa3gwcnkybWJP?=
 =?utf-8?B?UEFSckpHNDdlNUY4VGpaOURrb1hQcnBXOFZxTXpVR1Vod0dWMHdHK2MvZW1q?=
 =?utf-8?B?a3AwZGNIcm1tYTBzTkxnSHkreDVoKzg2KzJsQURIZkl4WHljV3lnU2xGSy83?=
 =?utf-8?B?SVp0NlZBZngvSnM4Z2lsM1FNbGpOS1V2UXpsdG9XekhnTk1NZWY1K2tqSHVm?=
 =?utf-8?B?OHU5SmhROHJ3UTNwNWFNRGM3NFJHb3hxYnRLdDhISzROcFFNMFdWbUM0U2Rr?=
 =?utf-8?B?b2t3NnlYT1pDS1VlQjRMbStUSW11Nmx2dFR1bFlMMzc0VkppeXpZV0FGZkdF?=
 =?utf-8?B?dnVyYkptY2dSUjQ1bkh1SHVjT1dmRHU3VGJJOGx5YjBIdlhWUXlwdmlvcmZN?=
 =?utf-8?B?eXBxN09zUW02L05hT1R0bWNPaWFoSHhLbE05RDB1MnBGZEFxZFBQR0ZKY2M2?=
 =?utf-8?B?THRhTk9qSFhNK2MyQktaSmRUc0d3QzVtSnNiMUdPUW14eHBFRUU4UTczSlky?=
 =?utf-8?B?NEhjczY4Ym1SMlhuK3hBbUE5eDlNMEVqT0FSVkwyeWZ4K2xsMTR2Z2w5dlZo?=
 =?utf-8?B?cGJydnNuYlRHakQ0eks0S2RWVlg0b0dYa01BeWk0Wk1mUlpFc3QzRi9LWGox?=
 =?utf-8?B?bmxSQi9tVjFaKzk2SDhmc0l2bUtQeWJNV3BKdFBvL3lCK29UTkNVU3l6amJR?=
 =?utf-8?B?dFU3ckpsS2NOa2xETUEvSXNpUVl3R25WRWF0dEpxWURKeGRUMXY5SmZCNGtS?=
 =?utf-8?B?ZVRkN1NadksyaGZkN09jckxqVjJOKzE4em9YNjJ2dE5TNGZuOUtwNmM0NFpy?=
 =?utf-8?B?eGJhQ1pHZEFCaDF0Y21FZHlKd3lTWGtaekcvUlZJZnRPL2EwVlY1Q3Uya3V4?=
 =?utf-8?B?Y0ZPajdodjhOdnI2TGI4MXprRTRJZWJBM3RoK2tTU0UzWmgvd3kwa3ZLL05Z?=
 =?utf-8?B?S0ZUVmtHaDZic1dFcFBYaWJBODR0Ym9nVkpKTzhLa2pXQ05oaTZMQWhEb0lp?=
 =?utf-8?B?a0xES0hCdGZmdFJZelZaTUpkQnViTlFwVzc3TWJKUnlMcnYvUkhqU1M2VGw0?=
 =?utf-8?B?aTlWaGViaVR2M0plcHR2aFdPdWJxVlF4UmJLdE80Q2dBVzcwTExZMjNXZUti?=
 =?utf-8?B?NXVTOTdUWFEvUVFGR0hGLzViUFZPU1JISUo1ZmlZTkJNRFhFRXhRL2tyWUVE?=
 =?utf-8?B?QnFCMHZFUU1SbVlHcnlCTjlQS1BoY0NzVkpBZDFsMUZ6d0taLzdDaDFtVHlk?=
 =?utf-8?Q?26cQBAGRCbxv0iw0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RKdWTZVKsnjQ9MG4F7TYOGFHowKgsTq+mcQn5B+LcX/zOaoWnD882c7kpoTf5Dh065OdlVRCx1FZHPVKk+7EesrT3EARtEAW937TbGAw+M6HR0V/u4A+vANugY5eFc5Ap0HqamJKvsSjMYt+bxHz3JC3sVomLrlcMgpUUE9pM7Cog7AHYjonMbsgBNkA9BQ2vzIu5jyMhvVQSez+UJ7VDlj5VrMbn++qdW8HNQL7uPS4g51+0whRO20LZxo08/MJ4LxvPFmnStkVH1ZByENbT6UbwKkXQ2McwXmbiE+5qhEdKi9OVJD20pcBjV2ClNFdDZjDpkeTkxNjVZGLtfK7ZA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8c21ee-e404-4e9f-57ef-08df49d3243a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:32:10.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj/V+LwNj5LJZ1pczwkUDkRWa+tu2c5vM/vlRW39fgmEHZm1P306Yszj2NYUqiJHN5hQF4IUAnZu59Ib1PzdYSq/QADk6zyl9lEUAcGdcOubzFAfTEkv5+LT21jLvK8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14933
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 02:32:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25053

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoZXMuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1
eG9uLmRldj4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTcsIDIwMjYgODo0NSBQTQ0KPiBU
bzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPv
vLDvvLQpDQo+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPjsgcGF2ZWxAbmFi
bGFkZXYuY29tDQo+IENjOiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAwLzY5XSBpM2M6
IEJhY2twb3J0IEkzQyBzdXBwb3J0IGZvciBSZW5lc2FzDQo+IFJaL0czUw0KPiANCj4gRnJvbTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiANCj4g
SGksDQo+IA0KPiBTZXJpZXMgYmFja3BvcnRzIHRoZSBJM0Mgc3VwcG9ydCBmb3IgdGhlIFJlbmVz
YXMgUlovRzNTLiBBbG9uZyB3aXRoIGl0IDIgY2xpZW50DQo+IGRyaXZlcnMgd2VyZSBiYWNrcG9y
dGVkLCB0bXAxMDggYW5kIGxtNzUsIGluIGEgc2ltaWxhciB3YXkgaXQgd2FzIGRvbmUgZm9yDQo+
IHY2LjEgWzFdIGFuZCB2Ni4xMiBDSVBzIFsyXS4NCj4gDQo+IFBsZWFzZSBwcm92aWRlIHlvdXIg
ZmVlZGJhY2suDQoNCldlIHJlcXVpcmUgdGhlIGZvbGxvd2luZyBjb21taXRtZW50czoNCjUxMGQy
MzU4YzQ2NmJmNjU4ODAzNGYwZDNiMjI2NmVlZDJiYzBhNTEgaTNjOiBtYXN0ZXI6IGR3OiBzdG9w
IGhhcmRjb2RpbmcgaW5pdGlhbCBzcGVlZA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoN
Cg==

