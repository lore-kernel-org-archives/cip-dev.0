Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B7C433EF
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 00:22:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.646.1657066970050536675
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 17:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2660Mkrv028385;
 Wed, 6 Jul 2022 09:22:46 +0900
X-Iguazu-Qid: 2wGqnrom51mE8iMme8
X-Iguazu-QSIG: v=2; s=0; t=1657066965; q=2wGqnrom51mE8iMme8;
 m=0c6Tk+RZVXPmoMRmhAEkS8hKTc9LBl0tKbuKpZjCtOc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 2660MiYi027073
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Jul 2022 09:22:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCepWriiaQXJWyInn+N7DWtTB4Lj7679Y+Wf6EfggdH1OeggRKgl3gPODDb9HmuDEz2MPOgxOaAXFSMPnhsNM7Vqh32hz19zhLR9tie8mgRCMTZ1XwO2YCvi3hKttsHdMm1MGRYj/6zt5LeqqZOsXeLC62cgZuNztjiFqVpYA2HFA6zxk1SRsZDikf08inOBzbzUqcX81K8A4vOzjIS0OyAx+NGKsXk9hIve/IxdFDwQpEX8Q1KwTuSogdM6snsimkPea+0WiD0WXI0yOWNPgF8qcKLBoeQwjlaPZufvNv5cVZccfFtnxdEK/vkc0mGB8fv1JaReEz4oR3HcA3Mepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN2z5IsEE0NGbflnWWi931q3NiKSgBdO6YPi8BTsF2E=;
 b=lwE3tJrAREm0NR2so8qS3lyTSJoSn3x/Ca+wtShPOiIzT5jQeAByr0VkwX0S9jwVH/pdGiBmDds3P/goFVmNn4vEZLlfUACEyfMvDUj1cij2dvt3ClqVKBmdsSwws04nEfkmm8h1mLOOOYjjT3M8Q6/vWzEmipdzfyx75c2rf7a6kxAcZDo12UzsQ2iMt1KH0omHWhZbskGsUXpb7XofLlHEf0wFnbqjKv4STRY8nV+Y/Us3HlZ4J81Al7xHjzRdDcVBbPMnqx93tB1CA9UXAc2opUCwQoDUk4uF0JD4xJDfCAekMR6/Giie1WUVb3JkfX8Rt18rtE18L/+fnq7mSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] qemu-arm not working with 5.10.126-cip11
Thread-Topic: [cip-dev] qemu-arm not working with 5.10.126-cip11
Thread-Index: AQHYkHf82whCYiHQYUiaPMMZamMbSK1wE2uAgABaV2CAAA3S8A==
Date: Wed, 6 Jul 2022 00:22:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942063EE6CE8A24C3453D7C192809@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <8742d63f-0f50-e327-6fae-204c9b89448a@siemens.com>
 <779f0e84-a41a-a25d-19a4-b8fcd988d62f@siemens.com>
 <16FF1306F5882200.28475@lists.cip-project.org>
In-Reply-To: <16FF1306F5882200.28475@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0c1b95-a71b-40fa-df94-08da5ee5a228
x-ms-traffictypediagnostic: TYAPR01MB2573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JzBTaQr8ZPedjsK4wMN7F8Yigszlfx/JNjGLTQLTH4jPXMdP9cZGf9N/vs1pMa/WpZtSWf/XdKxpS9IpaapBlaNYduTRYvYXEaFbBRopr7uwXLhYl8Vf34rO+UdN1Vu79+r8wtJD6YlG2sTefpgsmCKiCJLn71D+zDRWbL3WZBReITdBsEpPioOF61VpXbRR61sSSVqjXRCNeUafAh4bydFdBVGZUlAjDUs9qCuhS8CrRwzWMYs+R1qae5UtH0smsdH5XXyMs2EPOVyaVZPQ1XirYNTHeMonGzzUpQOXzpq5aeJkVEaqIZW2SMLlTO52FZT+B/5DuKsUDG6nucBr4C0i9My11fDDEcWmFjWgKgAnmA4vF6LkyIiQljJXIbHz+HsCgNX5qhYszDSqY8GsOuQkbGFWr7b+X9mi3bbK8gg83XVOiF1ZHv7RF57H4f+qK6b3zBWv0oMBVnBftlRt2/P7boujdYj088xy4kPNtcV3lIweN5OVOMERQdkMx+Isd2G4VgCI0yrPqgu3r0sScC4hwnLb5CLvpWE48rGggbEHwTXntIdtjK/JxQmPJ4TUTcgr5Tk7+dSjwbSvuuvK0z/Re/Ra2tAw3vegTepcRxmtXD6Va+G4Jb/gMq+GfJXpjIjXo4av1vAhq0zmhup45dTAnu1N6QNK1jKI2oNd/0Hx6p4y91CIhJf3fPegtVAP81M8iv5CEQlzehcE/u5ZKvjMuoxaA7ohCeMvBGn8L6NM2vyi5ycnTauuTm2KbSwDwCZq61Q7PrRhRIR9jhC+CGk46UJ9jJ8OSMoz4MWFrpTJSkggWfNMTheu/K+oHXviH+rC8fACwAWGLVllH2jrWWqePVLL+HsBqob5FiJXDcI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(33656002)(38100700002)(8676002)(66946007)(64756008)(66446008)(66476007)(76116006)(66556008)(38070700005)(55016003)(966005)(478600001)(71200400001)(122000001)(110136005)(9686003)(26005)(55236004)(53546011)(316002)(186003)(8936002)(83380400001)(41300700001)(52536014)(5660300002)(2906002)(6506007)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1BiZHkxTXE3Uzl0VlBZTko4TStKS0NLTW12blJWaklHWFJ6ei9LQS9taFJ4?=
 =?utf-8?B?WGMzaUdXTm1NZGlLZnhEdHBiaXYyaUVaWWZqREY2c2ZwNm9PSjdFMnk1RDNn?=
 =?utf-8?B?NFNHK245R3VnZVJ1T21OOVlYMFZNNTlSbkFzS0ZkdVZOaTRnVUppODc5Wmxl?=
 =?utf-8?B?dHBhSXdtaWw4NGpWekI0eVpTcHA4TnBpRGY1anBQOGV3dnMybWN5NmQvVXlQ?=
 =?utf-8?B?bm9vU254cFNPRmRKOUFjYjVzQTVLTGtHbTFhMDVvUTNVTVNZTnJqSXgxVk9n?=
 =?utf-8?B?RTNWU3hRSDZyS1g1aEpRTURvZlk1aDMzYWJxdXd6MFcydHRwTG5MUENSYXU1?=
 =?utf-8?B?ckQwUHh1UytBUG1BSjdjTUt1K3Qyd2tmVEpwa2c0K0IzbG1MS0VicDY0VURm?=
 =?utf-8?B?VWxWcU80WU5WMFdJUDg5YUZtMlZkWWJzNUZ2Qnd2RUFOV3FlR3lpYnlmVHNt?=
 =?utf-8?B?K1I0Z1p1THBkMi82WTEyNHB3b0dIMm1qQzJQQlcxREJ4M2o4TXVjUlF4Ykxz?=
 =?utf-8?B?MHdOQXhKTitFa05OaVc4aFJNT2w2d0lLeDNFWnlackpjS1AvRFROZ2ZmcEkw?=
 =?utf-8?B?UlhGemVJV2wvM3JEVkVnSjZ5SkJ4VVc4WHpBZzlUcG9tVHpwQ251WjNmYS9q?=
 =?utf-8?B?Q1hCVkM5SW00T25NQW8xc2dtVTQ5a3FDdFRXMFpWRjZWdmFZajB4Y0dLeTNT?=
 =?utf-8?B?MkRWMVpnRmZsTEVGVzc3bW9QYnlvNnZmOU5aNnQvaHRLVzNpOUw2ckJzanlk?=
 =?utf-8?B?U0F5cGtrK2FyVVdaYWtWRWptOHZlK1pXSUJqanR5bDJQbW13NDJ5YUVyemxw?=
 =?utf-8?B?NnVBbjB6UGRkQ0tycVN5M01jVU9jWjRGa1dMS09KWlVLd1YreTg1M3lmcHBp?=
 =?utf-8?B?TStRMWhLNVVXQzYvNTlBNHU4a0x4eVg2aysyU0ppZTN6N1M5Mk9xcjZqSldl?=
 =?utf-8?B?ZmgxaU1YSEVDYWltOG1telJUazlmL3dxcXhQb3RCU2ZOeG9nTFhydkRrOE92?=
 =?utf-8?B?cEFlUFBpRjhTUkFjNElQNlFtUU4wek96ZDY0eDNScWpQSHR4NDV5d0E3RGd0?=
 =?utf-8?B?VmNrK2JrYjhnNkE4ZXgxWnkzQ2FNSnRGVGptbFd2UU02bzBEUmZkZS9YeER0?=
 =?utf-8?B?TnBjSWRzY1FRQ1dqVW50REdPZWJEclJoeFFmYm5NaFkrRCtleWt6RTIvS1RZ?=
 =?utf-8?B?NEpKc2d4amRUT0dtRmg0MGxzdnVIKzE2Z3F2emM5b3RsVUNtNkRxdkExbGRh?=
 =?utf-8?B?VzZ1bjVMVWcvaUl3c0dOdWNwaHdtL1RCem9jUWs3RVN5S0g4cG9IbHVDbWw5?=
 =?utf-8?B?OVlUbHJnYnRlYTF4NnlLZWhLT2V3eUZOZTdXMUlYWUl6UHlqcWI5dmxHY2Nh?=
 =?utf-8?B?MjNPMU5HYmkzN1FoUUFUbllYd0o0djBjR0k1TkprdEZ3dU5KdVBkd055aTgx?=
 =?utf-8?B?bmlhZWEzZGU0WUtZb2JJUUpRbnBub2ZPbHJyWTE0T2R1SFZrUFl4c0lJT1ZL?=
 =?utf-8?B?eFpjSVE4RW52cmJQLzI2TU9nYzF3bUZjVUdqT2ZmZ1hTczRnZDB2T3VPSFF3?=
 =?utf-8?B?MFBNM3NzMGVSTENPYVhYQTd4QTZqZUdzWGg5NHZLc3F3M1Z5TTFhSWpYNXlI?=
 =?utf-8?B?Zmd4ZFZjb21qb3l0SGVBWHJ0OGt3MkcrVFlwd0RSeHNoQWFpa0lGRHMxZzRZ?=
 =?utf-8?B?MW9GQ1k3T01ZNzB4YmVIZjBpcXVNbndqMmIvQjJiUklLbjJnWUUzaFFnKzFj?=
 =?utf-8?B?UnNNejJER1RLSWFtUURqZkxWaFFQaG1jczlvSkpPSjczSkY0Qi8raHRtQU5E?=
 =?utf-8?B?M01JckFleXk0MFpZbWlodCttc3J0ZGNEaUFSaHBIQVYwUFFxYlFuNlB6RS9G?=
 =?utf-8?B?RUo4d0U1ckRTSWdURDNBTUtlRDd5eXNmaHl3RGZQazYwU292c0wwYjl3ZUs4?=
 =?utf-8?B?UTc5YkZsS0xuSFc3Y1JrMlZlQ0FKN3NqTExQaHpidWNMMzR3T2dPa0kwWFcx?=
 =?utf-8?B?UmVQU1lVdm5jU2o4SEpRUVJyY1dIdFZWUHhrKzN2TlA1R0FIeGJPdzRHOFBC?=
 =?utf-8?B?SzBqaWd4ZXdOVWVMTHZTUlcvWXMySEJzRHJUUmJ3ZW1IWkZCTTNUMUFIUHpo?=
 =?utf-8?B?Qkl4WTR4UHA0cHY0aUx2bENGV0Y4VE0zY1NQTm8zQ01CUXlUSTltVEpYdUEx?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9c0c1b95-a71b-40fa-df94-08da5ee5a228
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:22:38.6974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ZTTwhf7vjr9aAFVc4AKPv+R1EQ0sINuPqRg00e7a6NGK8/qol6p9/OF1mV0VJsK/Cqi1zJaLmTnOwps69OcGWen1L4jZe/f5dqkkhaQT8GZGJt/Lr/8Y8W7piGGjAeEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2573
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 00:22:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8696

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA2
LCAyMDIyIDg6MzUgQU0NCj4gVG86IGphbi5raXN6a2FAc2llbWVucy5jb207IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gcWVtdS1hcm0gbm90
IHdvcmtpbmcgd2l0aCA1LjEwLjEyNi1jaXAxMQ0KPg0KPiA+ID4gaXQgL3NlZW1zLyAoc3RpbGwg
ZG91YmxlLWNoZWNraW5nKSB0aGF0IHRoZXJlIGlzIGEgcmVncmVzc2lvbiBpbg0KPiA+ID4gbGF0
ZXN0IDUuMTAtY2lwIHJlZ2FyZGluZyB0aGUgcWVtdS1hcm0gdGFyZ2V0IGFzIGJ1aWx0IGFuZCBy
dW4gdmlhDQo+ID4gPiBpc2FyLWNpcC1jb3JlLiBOb3QgZ2V0dGluZyBhbnkgb3V0cHV0cyBmcm9t
IHRoZSBrZXJuZWwuIEp1c3Qgcm9sbGVkDQo+ID4gPiBiYWNrIGZyb20gbmV4dCB0byBtYXN0ZXIg
aW4gaXNhci1jaXAtY29yZSwgYW5kIGl0IHdvcmtzIGFnYWluLiBBbnkNCj4gPiA+IGlkZWFzIG9y
IHNpbWlsYXIgb2JzZXJ2YXRpb25zPw0KPiA+ID4NCj4gPg0KPiA+IE5vdCBhIGtlcm5lbCBpc3N1
ZSwgcmVncmVzc2lvbiBvZiBjaXAta2VybmVsLWNvbmZpZywgbmFtZWx5IFsxXToNCj4gPiBDT05G
SUdfQVJDSF9WSVJUIGlzIGxvc3QuIE5vdyB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aHkgdGhhdCBo
YXBwZW5lZC4NCj4gPg0KPiANCj4gV2hlbiBJIHJhbiBzYXZlZGVmY29uZmlnIGluIG15IGVudmly
b25tZW50LCBBUkNIX1ZJUlQgd2FzIHNldC4NCj4gWW91IHByb2JhYmx5IGdlbmVyYXRlZCBhIGRl
ZmNvbmZpZyB0aGF0IHlvdSByYW4gd2l0aG91dCBzZXR0aW5nIEFSQ0g9YXJtLg0KDQpJIGNyZWF0
ZWQgYSBNUiB0byByZWl2Y2UgdGhpcyBhZ2Fpbi4NClsxXTogaHR0cHM6Ly9naXRsYWIuY29tL2Np
cC1wcm9qZWN0L2NpcC1rZXJuZWwvY2lwLWtlcm5lbC1jb25maWcvLS9tZXJnZV9yZXF1ZXN0cy82
Nw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==


