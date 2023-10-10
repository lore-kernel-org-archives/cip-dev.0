Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C999CD68FA
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 07:57:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.85715.1696924647011053448
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 00:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 39A7vOXx2350602; Tue, 10 Oct 2023 16:57:25 +0900
X-Iguazu-Qid: 2rWhnZe9p48YO24OXb
X-Iguazu-QSIG: v=2; s=0; t=1696924644; q=2rWhnZe9p48YO24OXb; m=fmRpA3lDLVVTKdWiz/pE5Hatd4Z/1Mtc4MUgCPJQsz8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 39A7vNvm1930996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 16:57:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaUN6K1j5qNtc6sllt+DTK2MyDSeaha44LlSh7L24PHos06h9Iccvn7tL7WmMKSmE40aD2o2ltL4dl9snigCgZFz5tG5AF2cHlgR2dKCTOCF9lS3fcSFuBOhR/QQ9uzpot/V79t4kyc/bCpsFCf5FrVj8JTgXISxm7jD5A+M/N+YNfyTMiiHNqrnzGAyp1HA4AMcJAHJop3NTi3bS9EbEceMPGmD2FptO4RhrK6CAIw8njqtiRoBMvRKr0+HecE25JARUVXsd8rtAkr/sxZhXIVkV6j2mxNTxEevKdZu7ktxpfq1LhhqjuEylE437cHUPCU13oSXMwLakLwIlXBYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10HzxkMFeMDBKIDyan6U8kAbYxh35IEojpEdcqO+n4U=;
 b=LosEwMNvSotSOu1vsVC+LKY4/M3Yx3+x7ljKv/sTV3NL6KXyy+IjKFekGUxOjsE5Rk74F0CYwfE5AWFjetMXDaOeMs/mpfEIKZUyGa9vpDVCQTt1yzuqyuwwD+fJG0LADYzN0N2AIqEmjUCZXWAKDd1kCdOlrMN/TBK9UNmk1Vsa9AnD6qiBf44QVJMmyME6B2bKzSPRYxvYm0SyovvUi99d+CqX6YaR8wT80z5i9aCLKfnl5BvJPaCGXSovTvGHkXSWqheOrIiKhIkC/PKrWhRkZooGCl/aHiuqwC8VVR4/Z7IdkbWzBTsNqnfbufAy//bNOsM5qWM8SFOW175/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 2/2] simatic-ipc227e: conf: Add WKS_FILE as
 x86_64-generic.wks
Thread-Topic: [PATCH 2/2] simatic-ipc227e: conf: Add WKS_FILE as
 x86_64-generic.wks
Thread-Index: AQHZ+08JhR8QMYrolEeN309dAYLnmbBCp6JQ
Date: Tue, 10 Oct 2023 07:57:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245E6E26A2ABE56ADC4F1EF92CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231010075014.3761016-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20231010075014.3761016-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ba24174a-fdcd-4738-816e-78e0ad61d999@siemens.com>
In-Reply-To: <ba24174a-fdcd-4738-816e-78e0ad61d999@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB9716:EE_
x-ms-office365-filtering-correlation-id: 07a30a71-6bf0-4ef8-0bba-08dbc9668614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GIjRq2anBT5tcyHjTb5DFfuEfNqHFv69CF4EZ80EL7zvhxIlRB6aYO1S5RRcoNr055pDtOrnaed3Yi7UL28GHh+BatqKWeiXgAX/LpkDqwOjw8cvaHXLm99HiT7x1Hv3Yry4TUHgManzkI2D3+0UHJFxGyQiuiSS5ETHwq5+e0CvllySeiZCJf186z6upZMPZwSez9T2hOmWbLXXYElaz5iPMzKn//Qyg+NbnMkk9Z+dZoGCbarle+4aWBLcpLHdcvWQ8MQDeselECWf4WTzmLrK44oe7sq6KpKtNPsDCdiKLLGIegdNWMk+OFnSRe8W+koOzkKtiXJ8B7CSucyphMLRCkha08RU2ZcRlGNQtoLH8VicY04her1rmPP5pyFghudOmU8A4bgVRiT5nUcOXJo3mxKXd35r/tgJifxtdTNqBnLXgX+LKua8IB13E2oJCgsQNXYpbbbd/SebNr2ugJaw7yc5rknKPdNBnEWhIQHAFVq+kh78rYNTQ1rpwAGxhsp+m6eoF5VOVPLPJOr2MB27e03Ko+qOYk6B2FhFlpiLphjSKRlaZ4pkdtvo0QWCCaRto/sQYISJcJSATTs1AZp2FztC9XtJSzcblJVy8y+5A92G0/mP8BQZ4F3miXFCsAOY1f+OjmNRZ3W8nyY3LA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38070700005)(38100700002)(6506007)(33656002)(53546011)(9686003)(86362001)(26005)(7696005)(71200400001)(478600001)(83380400001)(55016003)(122000001)(64756008)(66446008)(66476007)(316002)(66946007)(66556008)(6916009)(76116006)(4326008)(5660300002)(8936002)(8676002)(41300700001)(52536014)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cFEvV213Z3Y5cTF0c1lQZmlPR0M3THlkL05zV2g2WkZ1RzdNblhKcUgrMHJ2?=
 =?utf-8?B?TWlIaVZaWW9mOWd5RWtKL1dWSE53Ny9XWTFNUGVhejBnVEt4NmtjNXZXVHNr?=
 =?utf-8?B?YjkxS3RvMnczNzdrcmNXTDhNTEJkcDIyMGVOMnNKbVVWcmhRK1JJTm40MkEv?=
 =?utf-8?B?S082ODZsdWpkRHVweEtHd0JvZk9SVnJPOGpmSGtPUWs4QVBOdG5Cd1NPTlpU?=
 =?utf-8?B?UEViMC9hMWVqR2tLL3AwRmNuNEt0OE1aSlpkWnBiZ1N4aHFNL2d2U1hEYTYx?=
 =?utf-8?B?cUdySFIxengwK2IrVnRqL1FwR0hId0VsR3ZQalZnanNEYVV3S3o2MEh3dHVa?=
 =?utf-8?B?eUp0d1NQQXJ5dFVYdDN3a1BpQzBxbDZ1c2NEaVRRMXBwOWhVV0NKOGIydW43?=
 =?utf-8?B?c1VSR3lTZmZEcHBjWTV5b0UwempiK2wra3g3YkQ5L1J5ZjBwZTU0cGc4Vnlh?=
 =?utf-8?B?L2JkYXMrMnN5WWJrQyt3Z21qbHFiZEZUTjJFWHFyY1pIZzhaVGowT0JVQ2dV?=
 =?utf-8?B?NE41eFB6akNtN2R2Vk9ucDJidDk1anpOUnNYSHd0UGRnM3ZaczM3bzdFaHI0?=
 =?utf-8?B?RVdoRDdMSVo3dDFab0xDak9BKzNKaVc5YUh0cXJzeDRyYlBuQkZmYnNldUVC?=
 =?utf-8?B?SnUvdXVRU056SXk1RkZZcjVxSHYrK0tnRzVLUlBZRnc3UEpKc0szYitYeDBz?=
 =?utf-8?B?VUl5cmFZakEvTkFaSllmU1E1bHlFT0gxSlU0Z1EzU28wc255RHVCa3RReUFT?=
 =?utf-8?B?OGFFb3NSNU5qd3JDNDFjamhTQTU1cGh1S2o3M2RhbGdYVjdLQVprYnk2aFZ6?=
 =?utf-8?B?ZjlWWWJOVUlmaytOVjlGVGJyM2FyaDhZOU9KOE0zNlgrNEp4MHFlQkJrSmdN?=
 =?utf-8?B?amoyMTdoS1V1a21nc0JhY0JpajZ4K244TE4vcHB1TVBnVzdLWlExZHorMis2?=
 =?utf-8?B?RnVXRklqaUNkQW1VUjFEN2srcnNIQ3FrcWk5VFB4bXRkb3B1TXU1c3FPMS9l?=
 =?utf-8?B?UC8rbDBiVDdnT005NHo0RVBKaUVDWjBhcGNEUXVXN3NvMDJmNC9IeW95aFFj?=
 =?utf-8?B?N1VMTVZDVjRwYmhwalgxUmJsU3l1R0t0N2J2K0JkbHV2eVI0VzRLcnRRZjM5?=
 =?utf-8?B?NDVqYjFsUHp5MGRGWVJ6NGNQMkxhVUtXc2VpR2o5d0xyL2FiMlR1OGQrbEJQ?=
 =?utf-8?B?dXp4REJDK0tQU3RpcWsvRjZmb1ZPSmsyRExOMUp1UksxbFo5MzVHbXgxUlEw?=
 =?utf-8?B?SGtOQ2pIU0NoZVpUa3FJR3JvajlXbG5vZ3dZd3R4eU5hQVlmTEtXQzJoN0hv?=
 =?utf-8?B?WFNmR1owelpFbzJkdmoxRVNKb242RE1NcVl2MzZHNmRBSk5PMGdabGhLdlM5?=
 =?utf-8?B?Y2JmTVNPUm5VUmNkSnFkbGl3ZVdPM3hwUnJjajZXbmpjeW5nTnZJbFNPMzlm?=
 =?utf-8?B?NXVrUDd2eEpVYTE2bW40OVJVd1o1WkJodklVN2tZMGRXVkZwWWtBbDFGc0F3?=
 =?utf-8?B?eVo4Tkk1ZXliSS8yY1AvOVZZLzhUQjlYU1FvZ2xMU05QUzhub0laTXdtcVcy?=
 =?utf-8?B?THRoZnRhVTZ2SUdUZFJDYnRvbHpPcm1vYW9lMFlDbnhZWmtHL1A5WGNjTWNX?=
 =?utf-8?B?MlZxUTV4NlB3cE0rYmFRZXl5ZXhMN0NyWVVxejdQaVU0TDBZNjBXWjU3Yi80?=
 =?utf-8?B?MHdtWmdMbEdqY0h6SDVzQ2Nwc2xFSFVZYXNzOHZLc2F3YkRoU21nS2tTOUU5?=
 =?utf-8?B?bEZ5ODFxd1hiK1RxYTRqVExodzBNSVBYcEM5Uit5b2NuM1ROTlRtWXpuTGhz?=
 =?utf-8?B?V1JzcHZUV2lXb3FhZHJvU1pwdm43YThiYW1jclpINlhIdGdJdUpXYmdPMkx4?=
 =?utf-8?B?NzFzOUh4SkYyVUtFYkRoWnV3V1R2VGR1NlpFNTIzck5BRDM5cGtTcElDRU8r?=
 =?utf-8?B?ZTN0UlFLRjBBZ09vSDNTVXlTU0NpblNaTTJ2NXlGZVJpZ2JwRkwvNjhFZ1hq?=
 =?utf-8?B?elZiTVJqVVdLd1IxVDdDY3d1R0xUaGlOd3lldWFpTGZqVnd1Z0YzQUZhaWFN?=
 =?utf-8?B?bm5JUk9MT2VWbTBHeFdxMXhFOTVXa3k3V0J5TmRBVUU0eis5SXFmZXU1RERo?=
 =?utf-8?B?S0hGekwwUHIxWm5yMWJCeUxEYk50VHBRR3JjUHZXcU1VWnV1WHkvYTRoWWhV?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a30a71-6bf0-4ef8-0bba-08dbc9668614
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 07:57:17.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVeL+l9I9FdrzZFuATiROhOvSDrxVy9o7BNBCUIFS/5i4ZqLh1HBMBa0WxMcWbHnfvA6IeUCPdqjP9jkxvD9tIw/G4Ki1PHr5R+Jt81sq/6s2lteGqfspqu96kJtLnoa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9716
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 07:57:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13342

SGkhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMCwgMjAy
MyA0OjUzIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8
qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIHNpbWF0aWMtaXBjMjI3ZTogY29uZjogQWRkIFdLU19GSUxF
IGFzDQo+IHg4Nl82NC1nZW5lcmljLndrcw0KPiANCj4gT24gMTAuMTAuMjMgMDk6NTAsIE5vYnVo
aXJvIEl3YW1hdHN1IHdyb3RlOg0KPiA+IHdpYy9zaW1hdGljLWlwYzIyN2Uud2tzIGhhcyBiZWVu
IGNoYW5nZWQgdG8gd2ljL3g4Nl82NC1nZW5lcmljLndrcy4NCj4gPiBUaGlzIGlzIHNldCBpbiB0
aGUgV0tTX0ZJTEUgdmFyaWFibGUuDQo+ID4gVGhpcyBmaWxlIGZvcm1hdCBpcyBkaWZmZXJlbnQg
ZnJvbSBjb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jLCBzbw0KPiA+IHdlIG5lZWQgdG8g
c2V0IFdLU19GSUxFIGFzIHg4Nl82NC1nZW5lcmljLndrcyBpbiBzaW1hdGljLWlwYzIyN2UuY29u
Zi4NCj4gPiBBZGQgV0tTX0ZJTEUgdG8gc2ltYXRpYy1pcGMyMjdlLmNvbmYuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hp
YmEuY28uanA+DQo+ID4gLS0tDQo+ID4gIGNvbmYvbWFjaGluZS9zaW1hdGljLWlwYzIyN2UuY29u
ZiB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9jb25mL21hY2hpbmUvc2ltYXRpYy1pcGMyMjdlLmNvbmYNCj4gPiBiL2NvbmYv
bWFjaGluZS9zaW1hdGljLWlwYzIyN2UuY29uZg0KPiA+IGluZGV4IGE2MjRmY2QuLjhiYjNlODAg
MTAwNjQ0DQo+ID4gLS0tIGEvY29uZi9tYWNoaW5lL3NpbWF0aWMtaXBjMjI3ZS5jb25mDQo+ID4g
KysrIGIvY29uZi9tYWNoaW5lL3NpbWF0aWMtaXBjMjI3ZS5jb25mDQo+ID4gQEAgLTksNiArOSw3
IEBADQo+ID4gIERJU1RST19BUkNIID0gImFtZDY0Ig0KPiA+DQo+ID4gIElNQUdFX0ZTVFlQRVMg
Pz0gIndpYyINCj4gPiArV0tTX0ZJTEUgPz0gIng4Nl82NC1nZW5lcmljLndrcyINCj4gPiAgSU1B
R0VSX0lOU1RBTEwgKz0gIiR7R1JVQl9CT09UTE9BREVSX0lOU1RBTEx9Ig0KPiA+ICBVU0VfQ0lQ
X0tFUk5FTF9DT05GSUcgPSAiMSINCj4gPiAgS0VSTkVMX0RFRkNPTkZJRyA9DQo+ICJjaXAta2Vy
bmVsLWNvbmZpZy8ke0tFUk5FTF9ERUZDT05GSUdfVkVSU0lPTn0veDg2L3NpZW1lbnNfaXBjMjI3
DQo+IGVfZGVmY29uZmlnIg0KPiANCj4gUGF0Y2ggMSBhbmQgMiBuZWVkIHRvIGJlIG1lcmdlZCwg
b3Igd2UgaGF2ZSBhIGJ1aWxkIGJyZWFrYWdlIGFmdGVyIHBhdGNoIDEsDQo+IGRvbid0IHdlPw0K
DQpDb3JyZWN0LiBJIHdpbGwgbWVyZ2UgdGhpcyBzZXJpZXMgYW5kIHJlLXNlbmQuDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg==


