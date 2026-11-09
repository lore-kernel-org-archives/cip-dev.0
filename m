Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8818.1794187595834265716
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 17:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Ho/jSjOH;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794187592;x=1795397192;bh=ntMT6Mo+2iUG4NfiAlp6oUXk8tMJTuKwJqJrd
	ejZxCI=;b=Ho/jSjOHF7r2fg1v6O823/XD4133UshMVKFnuYPvklePhQkxjrRGe81FaW/zrrkRAu+
	GP2tfzxOGL8pd7C2dnkYWaIBK3jk/07s3Rcql95c0bw/jcS6DkM/Q8pbdtBuBzOEUUVQS7cPIhoCr
	z6r4BoalIoxNUH+zHtlz5t4mt9NW1jqNqRtzLPWp2sOqADYVTFLfBIZ5a10MgMYSLCTtKHU/mpaNm
	3YJcZjohSpjzA7e0/9OGjNlAeUDlzQvxNcZ+YDdCej/3jQREB49iTPyMNvaDEalB5hrEtvNU646gw
	iXkvleBCDboC7u8U+Hw4nyD1jJcFGX7+7RY/9LuK41Rw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A91QWvV2442553; Mon, 9 Nov 2026 10:26:32 +0900
X-Iguazu-Qid: 2rWg7mGwtAGDB0bjIv
X-Iguazu-QSIG: v=2; s=1; t=1794187592; q=2rWg7mGwtAGDB0bjIv; m=JwtGjuaEYK4LCOkYZ20TGDbCqLqyqDprFczA77CDtU8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNBvX0z2Xz1xng; Mon,  9 Nov 2026 10:26:31 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZCY/RGb3R86b0bEAJCpJXiyd6zwzytyzMDFUTQ28bGuZ7VuPgEnhucReQek4a5WBws7lJKeA4f6Dnmm4wTtj1Jl02i60ARmvi6t/NkFCOt8Rjw76gyRI0ebzQp3KKGhY52XYDlifeTktDmSVZDo/QDNLKkMOL0+OIu24mObybv6MNIGfXV3kJzgTBE6AU3dRtEoUiUsz2NRf5L0ZkYlh3JYhW92VbwASIcnHC6PYAuPwRxEb0gI0Quc9lIN1v+5xs9aGW2Vf1YyeeN3ivi9uiyy0dotoZy2eps3SkNFQqejRCroT2OhFGt1QRb26IWSiwxKyUp8nwp7nw8K0smq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntMT6Mo+2iUG4NfiAlp6oUXk8tMJTuKwJqJrdejZxCI=;
 b=ntAI1dIH8W1fK8a4kMvxHtEjomOKtw4XaIS21TtOggIopJeznpNci30UrY4iSdtvvSTmaHP+yMLQk+tsm27WSxYo/eQy8SWv38o4VYYwN7Ae9zKkbS7X7XU8me9zj0l1f8nAyVDFWtDu5ghxN6S1AwHODqCc+wRDmdxfNY9fvPETyKq2U7siltvPxIFOjJIUxM+LGcKgQDH+VEGE/JNZZxlbbSgEpgWcV1qXQPsyxQYlsB1OeEcRjY6G+1Qi5HrGTRa+0YvmGqsDIcDxeF8mJEWJjILoOgeqZE0IVLUvQgE0+ZHrz5eW3AMMRrxk4yA9OoXqSIiTHWtR2KzF0t78uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][RFC PATCH 0/4] Fix build images for buster
Thread-Topic: [isar-cip-core][RFC PATCH 0/4] Fix build images for buster
Thread-Index: AQHdbc5P/KMNTWJbiU+SbIkiAQ93/rcgx8gAgAQq+hA=
Date: Mon, 9 Nov 2026 01:26:29 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481812E870D90E56EB40FB6ECD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <c30f288d-19fc-4319-811d-ac98e853ef13@siemens.com>
In-Reply-To: <c30f288d-19fc-4319-811d-ac98e853ef13@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB13684:EE_
x-ms-office365-filtering-correlation-id: b07e40d7-1aa4-44d4-1524-08df3e007adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|4143699003|56012099006|261021121427099003|261022115727099003|261022075727099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /MKQtYUkcPHAWLOFziHNdqjCBKL4afpIla/R1pEHoR3oVFOK8Je6zNXZ+LHASDm8a12iXNXCyvYXqyeL0IuREVQxaumMam8yp6e6Tgyv6KGRHcHNrzz6w3Q0hKovysEqg6XX1yJQaexrRWADWz30yQmZLJprsRc8QkhMGWxpyXp7L6GDqO4qerpc9czm/VjVdYq10LZXWpvyvZ3Q9kKLLNplDqD/OFSelgPBV8SYDMeqNYz30EPY1t8ueQSu7Qfkfta9pY/W7b7dTStWTCZAuJlmbxpUuUNaYyz7i9MqB/dmY1FfSDLkKxlO0BlX52PVk34WYZOX51WyOrlwp4OCOsPmTIbMVLSVE4e35KNgaiijb26tmbcaDK21w8Z13aneA1iUnV4lZJDhvricD499nQlXcGDSNLo5QcGd+MhlY1BTmkDenaQEpxte0YEOAV4JcWhzsbqvj/x+IG1kp6/yO1AWxem4y21jmtzUPSlJNJipliJsZhVQ1Hbo/q7wUuYEzDxSVnSN1zYGwZ2xQS+yjTl1wFst6Ux6t4Dv1XjVtOh61rcWgGL/9tamrluCT05q33RpSjtag6MY14sD8aT0YyhuFE1K2FK9pdt/A9V2Kasa5LUOtaPlkqTJ/5TGH+ppv4qXTbu/CoPTioOpgqagrQvO4MiYcWO7vyODH3FIomK9OjDVvhtArN99qGAOBg/KxBjjG/a6Q+eEeGarTnaaYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022115727099003)(261022075727099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnNQSWl4RFFZZU0zeXMwQ0Qwa2ZuOFZldTIwTVF0K3JBdHpheUFCNlZvMnd6?=
 =?utf-8?B?MTBFOUkzWkxENGtPK1hxdGFZR1hKeFRTSmZobEhUL2dnOTJvS0RBSUpJQzR2?=
 =?utf-8?B?NDlvZHRXR2hkR3ozdHVWeGVjK2swd2dZZFF6Vm80OEFkQXNKWmhWZk1KRE0x?=
 =?utf-8?B?NVNkVERjRk9leG1tR3FkZHhqTnZUaVltR0RTeVFOR1lyK2lzYWdDOVB1VWF6?=
 =?utf-8?B?eVFMVmtkNmFaMXV5SEtlc0dnNFRBUldacFV4YXRRcWc4MUtoL1cyZE8xRkRV?=
 =?utf-8?B?L3FrNzYwYUZSWmpLYXNKSTUvblRaODZ6a0laS3Fta0NDbEVXU2NEOC8zemhL?=
 =?utf-8?B?TThWVHJXTDVyTFAzLzV2K0gxUTZldmFuVEpxNHdQTjBmcGJjQlN2elV2cWlO?=
 =?utf-8?B?b3dzVnVxNllNT0s4NGhGUnllUjF3bUh0ajNIOFpxR0lxMzh2UHQvWUFYNVhX?=
 =?utf-8?B?OW1XUWROQzk2ajZQQ1FieGxxajJXWTJ5ZUdjSnpGZFB2TjRIYllwSXhMNVlZ?=
 =?utf-8?B?eDBCSDkyRU04U1R3NzFKV1JndDd1WS9mM3ljQ25VOHNseVMxQ2djV0Z4RExv?=
 =?utf-8?B?Ykc4RVc5ZVVoMFRscm9LTkg2S3pUY3VqSTlkb0tqbXhPallVUVpGRVh5bWNk?=
 =?utf-8?B?cjVGNVhXZXc5dXJsTmY0cG1WSFVpQ2lZNG9xb2RSa2VERWZzbWFKRWtlb3hh?=
 =?utf-8?B?VnFUeDQ2MWpuVkpheEZSU2tJYmxDTW51WE01UHRpMjVtSHlNVkhNbzJRTU1U?=
 =?utf-8?B?SkE5NS9neUx1K1N3d0lURStISjl5b0RHYzRST3VOQjFPZjNlZGlqUWF6MU5h?=
 =?utf-8?B?TXJ5emdGcVlHcm5QRlJJZWgvR29DbkYyQXJsVTlSQldEem1vWWdPdk5zaDNJ?=
 =?utf-8?B?RGVFRS9aN0hRb2N1S0ZFd1RBaXVkR2Jwa3FZbEVTM0hKWXorY29Ibkt4TlRL?=
 =?utf-8?B?MXdpd1BwS2lvV3Ayc3U1RGxIb2x3NjBrQmYvU0tUOHBnODVrNnhPeVFIM0ZG?=
 =?utf-8?B?d2trUjZ3UWdmbkZhRFY4Q2NodlVxZkMrUE15czlQL29qeWZpYWg0VnJHT1Rj?=
 =?utf-8?B?dXlWc0ZWQ2dTZW5tRE9DcWJlcjB1SVl4eWVSRlljVlVNVzBlMFZDZFdleXNN?=
 =?utf-8?B?bEpEckIvYkVpWW9qZCthNkVzTisvV1JzeDQveFVaMldxcFB0Rk55cTBid0hD?=
 =?utf-8?B?WkRkTzRXdmZpTUJOd0dNNDNWVFRHc1plNFh6Zk9WZlhHODAwZ1VpbkpXSVZ1?=
 =?utf-8?B?eG1ZUXFMUHp6NzRVaW05ZEt3VW1FS2hhRmV2SzN1VFhkQXNJN3cwZVZVODlt?=
 =?utf-8?B?Wjl3dW9RcSs1MjYzSWEyZ0Z1eWd3dGNiTlVTZWh3TllMaTJyZUhKbklJWHZN?=
 =?utf-8?B?azBSQnAveWUxeWViQXZiZVg4ak1pL08vb25vK0VTd1BrL0FaOWxRc0J0dmZn?=
 =?utf-8?B?eEdNMGRISlJ0NWNXcmFVcFBERG5Fc0hKODFoNGpXUmZtTUlwWFkva0p4d1hn?=
 =?utf-8?B?a0F6K2hUcnQxaTJFWERzSmVjUVk2RU5XaFlOT0h4b2ZkcGRmRGNWdXdibllG?=
 =?utf-8?B?YW9xMU5UQ0lVM2JFdnNkekUzRVd2eHkzUHUyenc2Wm54TDJGVFl6YkRtb3d5?=
 =?utf-8?B?MmZrZExEYUNCc0ZhakZjbEY2bXdVYm5uSk9NV1ZhY3lOTHJ3aEc1aHVMQ3dK?=
 =?utf-8?B?WEVyWU8yZFlYQTRrQ0hYTnpaanlNSG9GOWJnMnNpcXk5citUeE9UL2JKeTBu?=
 =?utf-8?B?ZnpsWHltb1FubUk1Z2hYZXhEeGtxREpMcHlETW96Y05ZNEtmdlgwRW1SclR5?=
 =?utf-8?B?NXdMKzJndFNkOGRlbHl0Wmc4S0VLOUdNWkZLYi9xRVNiQk85Qmc1aWpJb1Ni?=
 =?utf-8?B?Vjh6U3RIa3B1bHZ5TTBzb1FnUVh1VHBrUTV0MU1MZTd6M1pUUWM3SThLOWtz?=
 =?utf-8?B?dUFySGRmcm5zeFJDbXR5UnIybm1lMlFUUDhQMUJtTldBSlBPUnMzMEgwLzJm?=
 =?utf-8?B?MmJPMjM4N2NmSnNyTWpLYTBmUnVTS0tTaWJDY2lHWmIxdy8wTkVvaHY2Nmxh?=
 =?utf-8?B?WEF1RnZiWFBHMDN3L25QVy93MFdPRUZ5MGZ0NnYwR0R3dysrVDVJU21YbStT?=
 =?utf-8?B?ZVl6WVNtUjJlYUJnUlJmeFo5N01VcHVrZG94QTI2VkpJRTQxajNrRlVoejVR?=
 =?utf-8?B?MEFRRHVZM2JNcW9Sdi81SmtJbjdrUHY5SmQ0SFBkNXNkb3pUWmprUDZEanZk?=
 =?utf-8?B?TFJOUzgxQWFmYjR1cFA3K0JWRmliZnVXU1A0YlhaTFc3NHhSNVpLeVRHN3Rt?=
 =?utf-8?B?ZDdJOXR4amxwMlYyV2hSeEdWdTRpRlY4MjJYMG1IamFuaXJsYjIyRHJYeE1w?=
 =?utf-8?Q?uafLp8DNeFjW9krU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Skadd0ucuZ8g9qoiJsmV6uCMlAPSZlExGVa5MxIaceu+xtgF+AL1VNsY3eauT0LB7mmBrPJPpqJ0Ocyktu/axCUp8end3aOWT7FEiH2Bk4ZaK7TN+P2MKSIpwPNJZEQhbXJyjxdFapweYa3wbjHmvH6iRck9fv5l+mIS+vP5T984zjun1nVsZjLb77yLUv2N2Ebbqet7naVqG8Iu/UHZamrIGiW9v2ZECQSfP8senifDzbRwQRd2gSMSwcwvry0rPk07Z4GuFB+wscYvt1Cnp6J+hYe8wD4npMTMVlcyVEp1sG4vd/ZAd5c34eD/+sRYnVmjnR2Jzn7UGoMmXajWOA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07e40d7-1aa4-44d4-1524-08df3e007adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 01:26:29.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SG7KZpJTyyYHph3BhE/QG5T4pBzmlBo/9lc+IonA18ZvzwYUb/1xQlpsU2tCApKQijcZHq2Wc7YGsEEAKV9nig9P1rezxJlLiDW10hy7ARYsNf97zziQLqFXcc8yh3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13684
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 01:26:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24665

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNiwg
MjAyNiA2OjMyIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8
pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRv
c2hpYmE+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBS
ZTogW2lzYXItY2lwLWNvcmVdW1JGQyBQQVRDSCAwLzRdIEZpeCBidWlsZCBpbWFnZXMgZm9yIGJ1
c3Rlcg0KPiANCj4gT24gMDYuMTEuMjYgMTA6MDcsIE5vYnVoaXJvIEl3YW1hdHN1IHdyb3RlOg0K
PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIFUtQm9vdCBidWlsZCBlcnJvcnMgZm9yIGltYWdl
cyB0YXJnZXRpbmcgYnVzdGVyLg0KPiA+IFRoZSBidWlsZCBlcnJvcnMgb2NjdXIgYmVjYXVzZSB0
aGUgdmVyc2lvbiBvZiBHQ0MgcHJvdmlkZWQgaW4gJ2J1c3RlcicNCj4gPiBpcyBpbmNvbXBhdGli
bGUgd2l0aCB0aGUgcmVxdWlyZW1lbnRzIG9mIFUtQm9vdCAyMDI2LjAxLg0KPiA+IFRoaXMgY2hh
bmdlIHJldmVydHMgVS1Cb290IHRvIHZlcnNpb24gMjAyNS4wNy4gQW5kIHdoZW4gYnVpbGRpbmcg
J2J1c3RlcicNCj4gPiBpbWFnZXMgZm9yIHRoZSBCQkIgb3IgZGUwLW5hbm8tc29jLCB2ZXJzaW9u
IDIwMjUuMDcgd2lsbCBiZSB1c2VkLg0KPiANCj4gTm8sIHdlIGNhbm5vdCByZXZlcnQsIHdlIG11
c3QgbW92ZSBmb3J3YXJkIGZvciBmdWxsLWZlYXR1cmVkIHRhcmdldHMgKEknbQ0KPiBhY3R1YWxs
eSBwbGFubmluZyB0byBqdW1wIHRvIDIwMjYuMTAgdG8gZ2V0IHJpZCBvZiBzb21lIG9mIG91ciBw
YXRjaGVzIGF0IGxlYXN0KS4NCj4gQWxsIHdlIGNhbiBkbyBpcyBwcm92aWRlIGEgbGVnYWN5IFUt
Qm9vdCBmb3IgbGVnYWN5IGJ1c3Rlci4NCg0KSSB0aGluayB0aGlzIGN1cnJlbnQgZml4IGFzIG9u
ZSB3YXkgdG8gcHJvdmlkZSBhIGxlZ2FjeSB2ZXJzaW9uIG9mIFUtQm9vdC4NClUtQm9vdCAyMDI1
LjA3IGNhbiBiZSBidWlsdCB1c2luZyB0aGUgdmVyc2lvbiBvZiBHQ0MgcHJvdmlkZWQgaW4gImJ1
c3Rlci4iDQpJcyBpdCBhIHByb2JsZW0gdGhhdCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2FzIHVzZWQg
dG8gInJldmVydCI/DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

