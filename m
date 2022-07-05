Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F00DC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 23:35:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.158.1657064107439284260
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 16:35:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 265NZ59Y024370;
 Wed, 6 Jul 2022 08:35:05 +0900
X-Iguazu-Qid: 34tMKWQBVI4pzRFvic
X-Iguazu-QSIG: v=2; s=0; t=1657064104; q=34tMKWQBVI4pzRFvic;
 m=tEDporpT+pTTWy7s63khjicV5to1/eCG3fV+85KCHSk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 265NZ30V009766
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Jul 2022 08:35:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwmGSnDguyeG/oGWP8UAd29GVHkJLG6lEQrWUyDuQAQef+FstJpiQAuCVkwNdjVB1awD0vGNMYS1V5GCyxD7H5BMbl6+9JUr54f9JTriuiQ/0LEq8I6RpvffrcdBwyn9axxGYL2nTZiW1Vqx2C+yKsK6dZKkFd0zAR8aCPyjT4pZIobr7/LQ5H+fT5zI+8mNb5SSeBbxCf7UU4ro+Hzat4gaoy0zgA153HbYR7iLt/9gQ1CQN4ZXEj2q6nwVzZobFsn3rGoCT2f6hR8+jM2TXPzWwWNqxgMyJKTbKm/faMZuAGiaNGZxRyGRrBBVBWw8Z9wmi7zshHiP8Yfgf7qs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B1YRfL0/R6p73m28tG4iqasru0a1iQevQoS6T/rsI0=;
 b=cYN3wj6JILchWgOW/VKqZtCOItd/TdCtc0n7bhyIh8aOguDx5yfXZWCwDWqtRsZGWyBCj0wBsVs6ic1KWZjeFBFIzlOGpYFxF08Y3M/3hN9Pu7zWwFPDq5Dcu3DSUCLilf5gyD21m/G9X8GfAqNw4N/YhH6sZjG2Qjb7apdsnKTHkX0o4rErb089pNAW+iNRVNO23YCgIuhMv/Wx1IpiKN4wgM57NPp2oX9JzxH2V6tSZLpXkaST7tmoXwmZC4LiwaSQo5DRhYN2To/fHwtgdOtqx4HP/HIFjLjeVk9kGwjMJIsKLegKudyw+iksOYl+OKyiiO75XZulHwOf7ne1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: qemu-arm not working with 5.10.126-cip11
Thread-Topic: qemu-arm not working with 5.10.126-cip11
Thread-Index: AQHYkHf82whCYiHQYUiaPMMZamMbSK1wE2uAgABaV2A=
Date: Tue, 5 Jul 2022 23:35:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A7C21942A100C15B17AC92819@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <8742d63f-0f50-e327-6fae-204c9b89448a@siemens.com>
 <779f0e84-a41a-a25d-19a4-b8fcd988d62f@siemens.com>
In-Reply-To: <779f0e84-a41a-a25d-19a4-b8fcd988d62f@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51a91de0-eb3a-4c64-f156-08da5edefaaf
x-ms-traffictypediagnostic: OSAPR01MB3940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nWhcuUP+C2RJPAvTzGhu8Mr7l+/sF7Q/dXlKQO4fRIbI2/yVc2uTipYYClhJnul7RFYNT0TQ1YnrQ/YLU9Pl6eoJ/ouiSGpWIAm7mlqvqj/324KKCFmY/YNE3/5BAmBtIyudd+qEasl2NMp7w/0xywbIWYgmh74sDZalz/sMuaJkN+l/OWddtSfNnduJdzA5rsd26cPLYzZmXgCG73yPA9m+1se4189FYgW2X3Vt8US4vLEv7tqv7vwF5MAyCAC+i3GYaZ9qGCfLWFA4V2CHlDaDNxnv6AkyhUmtI+q8f1jEJyKGnAyd2cvtZAX2sYJdk2maZ/j9Aw6j0Uay1QAmyqwHoRX42GpoP9ON2JV2NjMJSEDgJSu7CTYQo/ruSNkh6wG5XGCo+ak8bKlfoZo0sP2zPjbb4aScdYbfGs1VBzVTGdDtCIwsawCPkTqeIJZpJALYzQxqOcLXxhDgC62Ss8NE7Z48Bk2zt86f2UPf9d+Ss6Q/le7WdloRxMJzN1+hhT9Bxpse1KTJ8Nyjw6LHja982o7i87C6Cx3PHUQmYqirEWR9DitmYEMrCjXnIs6qfBxh3DWOguUuNzSMLNje8xEkYJlGHnUCqAvsa8fl018s+CmkJ/zRdjof4fq7VRrjBRXh2ld0GfoOoEqyf/u5uewWc1RKtXAqCdFAWzS/vyF+ayUHwis8jMoUZEHAonlY5wwzOVPLXxSqEzbbCOdEzNIEJ1HffNAj1mjUSbl7ROnFjcBHQQw5DCxRiJkoDjJxLuu0xhOloiwLWhvU2t/iYyiWT447dCMneKSjKLsVTcNwM2B156PVvX0bol3tIurYoyN80ZruziNufEs8U2oahvWu/Jcsd7nN73nUraABMW0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(83380400001)(5660300002)(316002)(2906002)(110136005)(38100700002)(33656002)(71200400001)(52536014)(86362001)(966005)(41300700001)(122000001)(8936002)(9686003)(26005)(38070700005)(64756008)(66446008)(8676002)(66476007)(76116006)(478600001)(7696005)(55016003)(6506007)(66556008)(186003)(66946007)(53546011)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QndqZmxQYlVQYkFYeG1FVk9ZY1pMSGEyRUhmWHk4azBrdHdRM2doNWdja1NN?=
 =?utf-8?B?SFBuUUVsVzhsQ0NkbHAvYTlYZlg4TTNuWVUyQU1NNTJnNmtra0VTUjdFNFVO?=
 =?utf-8?B?OHZtQ01qeXBQRnk1ZEdscFNtSzlONmdVVUtMSEJPTHRnSG5MT295WERmMlpD?=
 =?utf-8?B?cmNGYUR3T0hpQ1o4MjR0aEw3MCtDdmRpcjZuaEQ0cHIxR09wdkE5QUpOZDN0?=
 =?utf-8?B?cW1DSW5UeU5KRDRPZkJ6ZG54RExMQU5zWHQ5eXNjUWcrWWRUYmFvMzBsM2gy?=
 =?utf-8?B?bzY3YXBwMHVhVTdRekYwc24rcHZ0TFdNVk5QQU1HbXFkdGdMSmwzTmlKRlVu?=
 =?utf-8?B?b2U2UUVEVFpCdkxnZDFXczFFNGdpQy9MclZUeUord05yWUJYUEFTb1hYd1p5?=
 =?utf-8?B?M2dqRmZaN29veldsdDZqTWx5bjQvOHc5dzJ2NTBCZlVCVjFnWGtEVWUzbmJM?=
 =?utf-8?B?bEJKWHp1ODFkZE12SDdGd1FMbGRxc1VMWENiUythUnFPdUhkbktiVU91RFVQ?=
 =?utf-8?B?eVZCODZWeTZzck1rL0d5cEIvdUtjU0lNNG5VbVo0QlJxbzRnRUtxdG4vdDhD?=
 =?utf-8?B?Z1A4SStKMk1KblcvUVJjQ0lqNUFpVW9NdVh0eElPRlVQdUc3ZzJ0V0hXVE40?=
 =?utf-8?B?dytaSjBMaGE2UXAzMThlZmpIV1hNTmUyemdtdW5wb3lTbXNlZlVEbVhqd09w?=
 =?utf-8?B?UEgrdVFvaU0yVlJvT2U1c0lhY0szNWpDUzRpOUZRcUtQT3h1SnllZUFoNEYw?=
 =?utf-8?B?MXd0enZZUkFyVzVYYmNCSjlXdG9qZDlpOUVzaTd0dHdiV3NvcHZxOUFKYUF4?=
 =?utf-8?B?c0FsdVFyajMvczV1Wm1nTU5sQTdPL2ppdXc5ZjUvWHBKMWwySUM3QmxXd2ww?=
 =?utf-8?B?M05iLzR1dGZqeU9ZZWpId0RYM2Z0a05EY1RCVitza21TZmpmT0R0MmxsNTFY?=
 =?utf-8?B?NjRuWGhUUC9GWmRzY2h0eXVVb2N2aXoyQ09jZHFCcEdDQkIyRS9qa2hBK1Na?=
 =?utf-8?B?L2xwZWJWTUNtVFVkM1c2UXJpMVBZNzVMNGRySWRzSkRjU3VGcThacFFaZ0NS?=
 =?utf-8?B?bjUvd0RhYXg0ck1MTnFWYlFncUpvKzZVditHaG9kb2ZMaFBGV29kQktIVXg3?=
 =?utf-8?B?T3UzQkVNVnpnZnJzL1JCcWVPSmNjMGFtd0hjSmlEWUk3VDNMTFNJNEwrdFJq?=
 =?utf-8?B?Q2ZWVjdmT3QxcGJkMDlGdGxraVZlNDJhVWVsYkRWUUx0QnBsZDFlUGhuSEpi?=
 =?utf-8?B?Vk9OOXZIMllTc1dNbkswUlBrNDRmSi9qV1V4WnN6N3hmcFFxTmR0bjF4MnU1?=
 =?utf-8?B?Vmxqd2RudE53cm1IZWwwVThnQkxmNVRKckFiTVB3UlpEU1JBKzA1czh1Y3ZF?=
 =?utf-8?B?amdSSzhVR1RtWWt1UmNEU2FWTm9DQzByTi9TLzNQc2tnZ1dsMkhYZUVvb2Nj?=
 =?utf-8?B?MGVUWC9FS3p1a2picjF4Z0lZdVFlUkdRK1lIUThHZ3hoQlRYTEZPTm5zUHJP?=
 =?utf-8?B?Nm9JU1VBYnc0S2w2NXEyNmNQMSs3c0s4Y1kxT0dqU2ZyR3JudUcvL1ltWDM3?=
 =?utf-8?B?cVNabTd5dis0TEt2NjhMZmNpSml6c2lxc1JCK2JZYVp0TEZwdjVMYzFHR2Fu?=
 =?utf-8?B?NjRVT2wyM2Y0S3V6YXdKeDk1UlFSbGx2OGFBNjJYT1RzSXpqSS9NejFEL0Ey?=
 =?utf-8?B?eHZXTXJvdm9uV1dIOGF0RFBxV1hCRnFqTFhrK2NFMG1LVmhrOGJUZmg3TnIz?=
 =?utf-8?B?a25UYk9wYWw5ZHo2WnZBcmlUcFdyYnhNcklyUGlsMmg3M0p0UTVoc1V6NGUy?=
 =?utf-8?B?QVo1NUIzU3FGMnViNWZzTWlDdTRQQUd1YmlLajNRVXNEQ2F5M1lWaDJkUmdm?=
 =?utf-8?B?d2JKN1hQcjFvRUtjcFVvNWVyNU1MUmJ0N2NUWG5aUm1pdms5eldidVFXaUR6?=
 =?utf-8?B?VXE5VXF6czBHKzMyNE5BRURzUG55ZjZYMUpZY1puQ2Q2bzBXcTJNOS9BejNz?=
 =?utf-8?B?NkNZcUdwRVRQM3pOWHRUTnlubG81M3MydmlUNEc0aGZwTUVZaEZJRm95Lyty?=
 =?utf-8?B?NXdrbWJDcCtWU3VOREJGK2VERmU3Ulh1Q1RGcUU3a1AwRVJOT2MvaGRKTHow?=
 =?utf-8?B?YThxMk1hdDViKzk1ZjFoTjI0b2x2ZmxxaXZYVEVaRHFjN0VVRXhNN0liQ3FL?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 51a91de0-eb3a-4c64-f156-08da5edefaaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 23:35:00.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Ek2CVd3ulDJdj0mI5DXdfjCkuI4lSRZlg5eernB9tMd4A+FefuQyGl/gDEHkwU/prAdDXuqcr26z8qU6A5gRzCsv+V7tzOlTqCXQxIFDwrgKalX/b+SB0Ryw13P9NMX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3940
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 23:35:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8695

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA2LCAy
MDIyIDM6MDggQU0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
PjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqENCj4g77yz77y377yj4pev77yh
77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFJl
OiBxZW11LWFybSBub3Qgd29ya2luZyB3aXRoIDUuMTAuMTI2LWNpcDExDQo+IA0KPiBPbiAwNS4w
Ny4yMiAxNjowMywgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBpdCAv
c2VlbXMvIChzdGlsbCBkb3VibGUtY2hlY2tpbmcpIHRoYXQgdGhlcmUgaXMgYSByZWdyZXNzaW9u
IGluDQo+ID4gbGF0ZXN0IDUuMTAtY2lwIHJlZ2FyZGluZyB0aGUgcWVtdS1hcm0gdGFyZ2V0IGFz
IGJ1aWx0IGFuZCBydW4gdmlhDQo+ID4gaXNhci1jaXAtY29yZS4gTm90IGdldHRpbmcgYW55IG91
dHB1dHMgZnJvbSB0aGUga2VybmVsLiBKdXN0IHJvbGxlZA0KPiA+IGJhY2sgZnJvbSBuZXh0IHRv
IG1hc3RlciBpbiBpc2FyLWNpcC1jb3JlLCBhbmQgaXQgd29ya3MgYWdhaW4uIEFueQ0KPiA+IGlk
ZWFzIG9yIHNpbWlsYXIgb2JzZXJ2YXRpb25zPw0KPiA+DQo+IA0KPiBOb3QgYSBrZXJuZWwgaXNz
dWUsIHJlZ3Jlc3Npb24gb2YgY2lwLWtlcm5lbC1jb25maWcsIG5hbWVseSBbMV06DQo+IENPTkZJ
R19BUkNIX1ZJUlQgaXMgbG9zdC4gTm93IHRyeWluZyB0byB1bmRlcnN0YW5kIHdoeSB0aGF0IGhh
cHBlbmVkLg0KPiANCg0KV2hlbiBJIHJhbiBzYXZlZGVmY29uZmlnIGluIG15IGVudmlyb25tZW50
LCBBUkNIX1ZJUlQgd2FzIHNldC4NCllvdSBwcm9iYWJseSBnZW5lcmF0ZWQgYSBkZWZjb25maWcg
dGhhdCB5b3UgcmFuIHdpdGhvdXQgc2V0dGluZyBBUkNIPWFybS4NCg0KPiBKYW4NCj4gDQo+IFsx
XQ0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9jaXAta2VybmVs
LWNvbmZpZy8tL2NvbW1pdC84ZGMyZQ0KPiA1YTE3NzJjMWQ3YWFiNzgwMjhhOGExZGIxYWU2ZTZl
ZDlkMA0KPiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tDQo+IFNpZW1lbnMg
QUcsIFRlY2hub2xvZ3kNCj4gQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==


