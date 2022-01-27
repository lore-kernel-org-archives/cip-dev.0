Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB66C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 08:21:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.26008.1643271694305694623
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 00:21:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 20R8LVRN016121;
 Thu, 27 Jan 2022 17:21:31 +0900
X-Iguazu-Qid: 34tMJmyIPkilOsDEsC
X-Iguazu-QSIG: v=2; s=0; t=1643271691; q=34tMJmyIPkilOsDEsC;
 m=TwlePJwWmjvCMHH3Soa4x/gsp2fvtI9Sgz/kU6/PQt0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 20R8LUb1026703
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 17:21:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVaXr5Cnu+ZcmbNN6jQKJqQ23EGO73J2Bg+hKvTuP8Yes0/yqiJ7vrltjDgevmCtof6z0RWRzaGKgw9tU2gJ3IbMaPgP5Fubxmq/3IRCcLDkyoQLnlrVtjUa8snOD12Khz0Crr6kHcNFzc2SF8DaY+EGGivnPGQpZNjiykm5eUBvl54wnPeO3z/jlHR+rmxn6/GGTriIm9ICd6QKLt29Jh7ZOiLVxGQo2mkudMEacG/hGaye8R2ynd81OF+r/QoG/popV4x8cy4hHNYyhnSCewsz2AoMv3WetBSj94hOtsrRYf/xXCgyVBI6HPoV22wWIgGPQsgtddaR0z5qm68e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl9oCZPmllYmtKDa1S0wcw+cIlSUwq3sQr6CmfZMYBg=;
 b=Jw1WkzWUuQNkOpgIZRop1UmUmnGdjnNR6mdf5fOBv7XHhbkEIKA7K6eQEgq5c3OHMc8Vmhkq03JSHaZlX8NK50k8iZCxQiV1k3msu2gN17sH9zcSv4B/Ukxawk10d0yKHXTx25nxm19eyxpq8xKj5ZHNlnPGFLyrpgSvsFcuQ/MU+FHPfjP6eB1Qv/Auxru29ifEPoGPucvRfyNIq4UV77Tc4ZnsmnRrBHSeUqoJb/Qpx33LBTpunbEDGPmjq7wDVheiLt2al02q5KLAaKqY+78oPhsB/jP2svFQXo6g2elmIZDL4NUEL8JV5XPHXOPc7zihR4iXwYp6s8/Cd7+C7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] New CVE entries in this week
Thread-Topic: [cip-dev] New CVE entries in this week
Thread-Index: AQHYEw/I3wnFNDfceUCL42N/VFMKnax2hSCw
Date: Thu, 27 Jan 2022 08:21:28 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625245CB9B3199BE4A7E812492219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
In-Reply-To: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b79ca6-801a-4811-1d9f-08d9e16e0480
x-ms-traffictypediagnostic: TY2PR01MB2794:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB27948211A140B6E1C2D2373592219@TY2PR01MB2794.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gVlr1YFeEakBmTL2WMHsrdrWnMGaptVmg6n6TFxImPx+BTqdkAqaxVvXq1zT81VZucGhDKlwzw89o2JyX7HVjnPJVDpcieWxd14u7Nw4QY2TlAwT16Ws4lC9uwp2VCr3Iqc+1uCn8rLhTd4tU4KcpybU3ZqZs/5yeWhF3hYScYPiYbQhFjEbhHaXsHHSGMmQhD6L9Sz7i7ccgDkkjd91nxUuj0i3QYQdmrkGm2U6uFal14kcLpy+l5YlZWfAcUOFHnGf3YUbsMAwRLvVPJ25wuwfvdiw1hRYMSHrpNZ1sCjHtLMXyarvR3RhI94p8UMoas7bI5c9iyFfqSbGitWtH03qj+yTx36lR+xI59+cqMz58akAqoWutLhAB2w33dhXbyAvXO+Q4YVryZXyvoEbOPuZV0pGBpxo+9Bi1vYdRSp7Wur0Yr0jp/q/qOvmWMtjHhdcGYoLEkeRtSnw/j6SlEsx7SzOyPXxgY45IKjc5pXISVDoDQl8C7zhqF+nKZgdRXL1cxKH9ZfX6jBSfVTcXP0UZc/MuGRUku/enl5APANeNyncYthMHI2dt5jcF6xHKeq5faFCoktQlpOJGi/9cCs760L2lPbUMtej/+6+o+yIsa/n+LF0p038TJ73wY6b1k4vcdlOYebtHHBPPqeI9Tvae6wRaCPhYrQ9UqXKjwViTDC6uQGhATcYOaPQlRCPDY28z8z+tCSQ8MWE702aJA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(8676002)(66946007)(53546011)(55016003)(6916009)(71200400001)(508600001)(26005)(66476007)(8936002)(66556008)(66446008)(186003)(122000001)(86362001)(64756008)(38070700005)(33656002)(2906002)(83380400001)(76116006)(5660300002)(9686003)(38100700002)(316002)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UUViNHFaTUcrWWsrK2xaanFhNWN5OXIyb1NPcWxUT2ZBN0lrRVhyRXEzZWRN?=
 =?utf-8?B?em9kcDRqZDd5RkNFNENDZHZNM1VmNXpXcllvVGVjK21BQmVZRnFHRndVdk5X?=
 =?utf-8?B?RFNFdzQ2a3hNajE2M2hPdHZKaGQxVktqdm5hT3ZTdGc1WklyWStRSVVQN2hH?=
 =?utf-8?B?dHMwVDFlcGpzSVdMYnpmYVVGdEQ1bmFtUklQN1pjbTM2VFYza1lTQkM2YmZt?=
 =?utf-8?B?TTUrczhranFkMjk4TStMWGl3c0lIM1I1WDA0WmczRlN0cGJPQjYvTlpUVmpm?=
 =?utf-8?B?ZG1ES1ZWLzRiL0FJK2luYVljZTQzTDhlU09UUXdQSFVYWTJZWTlBaTF4NWxI?=
 =?utf-8?B?emJFYzFsb1BON2RvT0xLVEp6VjZyVkRiOThmVEpPU2FXQXIzRjZaY0ZReENs?=
 =?utf-8?B?WVAyMDJpNGx5eGVyb2hUalJibkhvU28rQm5rY01WQTlHYnJZb2F3UElrWFZy?=
 =?utf-8?B?OE1rRFBSbndYR2NoSVk3bU43bFZTeFZ0RWY1TFhWRmMvVFNZdlBsSDREclZt?=
 =?utf-8?B?M01IdlJtS0RhNnIrV1hsKzd5dVJhK0hOS0hJNjRmRTVFRkVIT3VXbEJ6cHg4?=
 =?utf-8?B?VERWSE92U2d0ZjVYMWpCdXBNRm5hNDlENTk3TEJTOG1zSTVFTk5sOGdGM2g0?=
 =?utf-8?B?VnFzZysxOGRMdnQrSGN3TXEzNGxiaVRGaU5Sdm1wOEpqc1pqbUlWWDJQYW5k?=
 =?utf-8?B?WitINldPUGppZzBlUTI4eDFNSThSSVZLYUNROGtmcXU2Y3JLM29DVU9tcXcw?=
 =?utf-8?B?NkhtVkg2endTU0wrbGVqbWVOYjUxN2l5Y1hZODc1MkhqNWR1YnpkNGxLZEl0?=
 =?utf-8?B?WVc3Vm9SM1cxME4xc01DQmI5U0JyWmJqWURuMXc0Q29DS211WTVMdit2djNN?=
 =?utf-8?B?YXUvSk01eEhybUhTaC9MWjdSZmdSbU1PUlM5N3FFS203SDNFK2MxQkQvRHJV?=
 =?utf-8?B?ZVREcU9GR0FYYjlyWmZxMDZrT0hwcUZHMHBpVVFJNlBlOUZyMzZJOUI2SS9r?=
 =?utf-8?B?U2M2VHU2bUNiVERYRzhUVi9OV1ZtbEQ3RmdaSkVjMzBaWWJvaVBPT3o1MFBr?=
 =?utf-8?B?cVZFSWFqMGZWWHYzVERORTVvTVkxd01lcFJNRnAzdHdBdTgwa2RMZFpFTWlD?=
 =?utf-8?B?KzMvRmFodkRVQ1lXVjAvUlhpTjk0VTFyVWVTenF5bVUxb0NvN3YzdDJ2OE90?=
 =?utf-8?B?V1FrY0FPYzhOOEN1Y1NzS3djTjZVc0hVZFNOZGpDL2c4N3VlNVdxcVlrOFhk?=
 =?utf-8?B?OXpSSmY1TGNIUWpzWWphRHZsQ1N6MHlxaWRJL0c2Y2VhT0dJWERhTDQveUda?=
 =?utf-8?B?T0JaV3p4M2NwSDA1bENTNTJVNW8vdXNUOER4VHN4UklYa01uZ21nL0hiNkhK?=
 =?utf-8?B?QVFjUmRaSWhCWTliVllhV2kzRThPMVoxa3RVdk1nUVM1c2dOTnFiTVRuWDFD?=
 =?utf-8?B?b21mcERtQzdZTG9lWlFKc2xldnBlWFMyY3dJWkVUOXVDdDdQNDhmdVE3cVRE?=
 =?utf-8?B?Z3ZDQlU4QVJqdzBoT2VzWmFDZnYyNEFjWmgzWHVXSWQ0WGJBYjJKZGhsQXpN?=
 =?utf-8?B?OU91RmpYNXVXc2FiaE8zYmtjVTkwaEFPWmVhTXZxRitVejd1SXB5R1FpcUo2?=
 =?utf-8?B?Yk42U1p2QVBUcmxLcnVtRFQ0ekxBWDMzTjBmV3NXSTc3cmdud3c4dXJxU3Fv?=
 =?utf-8?B?dWtvbk9ZSHdIbDYxRVA1bVZNMXlyM3ZIU2pERUdLeERDVHU0eDRLVno0NTZU?=
 =?utf-8?B?ckcxaGxpYUtpSjJjTExycWFqYmdiaXB5elVteDJHaDc5SVgyZTlmb0NJY2tM?=
 =?utf-8?B?Qk5FZExBRzdGenc0VVlJL3BUcmY1MURGRlpWS3hHT1Y1blQ3L2N1aXRPOGMv?=
 =?utf-8?B?R3YwVSsyemJ4dDlObk1la1F4ek0xdkttNnNaaVNHVjBSSERNSVdLdWVTNUVU?=
 =?utf-8?B?dVlnaTFWYy9XTWtJSGkxVGxHYVJEdmh4d1NDTXN1OUpSMld0NXlLdWIyQlpm?=
 =?utf-8?B?dkdMQ2VDNHdNSmNDeldDT0tFVytpTFdraEdlYS9FQ3NlVnYrUkNyWW5rTElX?=
 =?utf-8?B?eFNMRHIwcHNJRVpnRlBHNVQwVU9rNjFuOXc2eWltQ3pESnN2c3RURldjRVVx?=
 =?utf-8?B?MDVMd09lVk1vVGNDamVRUnV3N3p2R0ZLSmFIWGhmUkpET3FRa0lldGhvd01N?=
 =?utf-8?B?cXpSSDVsSUgyTnpwVEZnaFRrMThkaDA0anhOVklvM05BZjlmR1VSeTFtQUV0?=
 =?utf-8?B?QlFyZVk2dzZtZWNKcVFJMWZUV1RyWjlQYmREYjI0RUtjZ0VvRzFvYVQ4Y0tU?=
 =?utf-8?B?RHF3U0dlRjJrdk83ZUxNemJIYUNOYkZnZFNVcTI0OXBlWktiQmxtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f1b79ca6-801a-4811-1d9f-08d9e16e0480
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:21:28.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Vx6mZnujofU/EwU4T1oVg8BuvuGCk/bi+an6nqofNUx8gFe3fxzdc3z0LAHZj4iuiSQFHSLFhB2STQWw/lJD8t3tCzpjYoJVi4Qm5cEIUoIoOwq/XkSpFvlZnz3BwWim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2794
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 08:21:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7496

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBC
ZWhhbGYgT2YgTWFzYW1pIEljaGlrYXdhDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI3LCAy
MDIyIDg6NTEgQU0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
Pg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gTmV3IENWRSBlbnRyaWVzIGluIHRoaXMgd2Vlaw0KPiAN
Cj4gSGkgIQ0KPiANCj4gSXQncyB0aGlzIHdlZWsncyBDVkUgcmVwb3J0Lg0KPiANCj4gVGhpcyB3
ZWVrIHJlcG9ydGVkIDQgbmV3IENWRXMuDQo+IA0KPiAqIE5ldyBDVkVzDQo+IA0KPiBDVkUtMjAy
Mi0wMzIyOiBzY3RwOiBhY2NvdW50IHN0cmVhbSBwYWRkaW5nIGxlbmd0aCBmb3IgcmVjb25mIGNo
dW5rDQo+IA0KPiBDVlNTIHYzIHNjb3JlIGlzIG5vdCBwcm92aWRlZA0KPiANCj4gVGhpcyBpc3N1
ZSB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgY2MxNmYwMCAoInNjdHA6IGFkZCBzdXBwb3J0IGZv
cg0KPiBnZW5lcmF0aW5nIHN0cmVhbSByZWNvbmYgc3NuIHJlc2V0IHJlcXVlc3QgY2h1bmsiKSBh
dCA0LjExLXJjMSBzbyA0LjkgYW5kIDQuNA0KPiBhcmVuJ3QgYWZmZWN0ZWQgYnkgdGhpcyBpc3N1
ZS4gQWxsIGtlcm5lbHMgaGF2ZSBiZWVuIGZpeGVkLg0KPiANCj4gRml4ZWQgc3RhdHVzDQo+IA0K
PiBtYWlubGluZTogW2EyZDg1OWUzZmM5N2U3OWQ5MDc3NjE1NTBkYmMwM2ZmMWIzNjQ3OWNdDQo+
IHN0YWJsZS80LjE0OiBbNDFmMGJjYzdkOWVhYzMxNTI1OWQ0ZTlmYjQ0MTU1MmY2MGU4ZWM5ZV0N
Cj4gc3RhYmxlLzQuMTk6IFtjNTdmZGVmZjY5YjE1MjE4NWZhZmFiZDM3ZTZiZmVjZmNlNTFlZmRh
XQ0KPiBzdGFibGUvNS4xMDogW2Q4NGE2OWFjNDEwZjYyMjg4NzNkMDVkMzUxMjBmNmJkZGRhYjdm
YzNdDQo+IHN0YWJsZS81LjQ6IFtkODg3NzQ1Mzk1MzlkY2JmODI1YTI1ZTYxMjM0ZjExMDUxM2Y1
OTYzXQ0KPiANCj4gQ1ZFLTIwMjItMDI2NDogYnBmOiBGaXgga2VybmVsIGFkZHJlc3MgbGVha2Fn
ZSBpbiBhdG9taWMgZmV0Y2gNCj4gDQo+IENWU1MgdjMgc2NvcmUgaXMgbm90IHByb3ZpZGVkDQo+
IA0KPiBBIGxvY2FsIHVzZXIgd2hvIGhhcyBjZXJ0YWluIHByaXZpbGVnZXMgaXMgYWJsZSB0byBn
YXRoZXIga2VybmVsIGludGVybmFsIG1lbW9yeQ0KPiBhZGRyZXNzZXMuDQo+IFRoaXMgaXNzdWUg
d2FzIGludHJvZHVjZWQgYnkgY29tbWl0IDM4MDg2YmYgKCJicGY6IFByb3BhZ2F0ZSBzdGFjayBi
b3VuZHMNCj4gdG8gcmVnaXN0ZXJzIGluIGF0b21pY3Mgdy8gQlBGX0ZFVENIIikgdGhhdCB3YXMg
bWVyZ2VkIGluIDUuMTItcmMxLWRvbnR1c2UuDQo+IEZpeGVkIGluIDUuMTctcmMxLiBzbyBiZWZv
cmUgNS4xMiBrZXJuZWxzIGFyZW4ndCBhZmZlY3RlZCB0aGlzIGlzc3VlLg0KPiANCj4gRml4ZWQg
c3RhdHVzDQo+IA0KPiBtYWlubGluZTogWzdkM2JhZjBhZmEzYWE5MTAyZDZhNTIxYThlNGM0MTg4
OGJiNzk4ODJdDQo+IHN0YWJsZS81LjE1OiBbNDIzNjI4MTI1YTQ4NDUzODExMWMyYzZkOWJiMTU4
OGViMDg2MDUzYl0NCj4gDQo+IENWRS0yMDIyLTAzMzA6IGRybS9pOTE1OiBGbHVzaCBUTEJzIGJl
Zm9yZSByZWxlYXNpbmcgYmFja2luZyBzdG9yZQ0KPiANCj4gQ1ZTUyB2MyBzY29yZSBpcyBub3Qg
cHJvdmlkZWQNCj4gDQo+IFZ1bG5lcmFiaWxpdHkgaW4gdGhlIGk5MTUgZHJpdmVyLiBXaXRob3V0
IGFuIGFjdGl2ZSBJT01NVSBtYWxpY2lvdXMgdXNlcnNwYWNlDQo+IGNhbiBnYWluIGFjY2VzcyAo
ZnJvbSB0aGUgY29kZSBleGVjdXRpbmcgb24gdGhlIEdQVSkgdG8gcmFuZG9tIG1lbW9yeQ0KPiBw
YWdlcy4NCj4gDQo+IEZpeGVkIHN0YXR1cw0KPiANCj4gbWFpbmxpbmU6IFs3OTM4ZDYxNTkxZDMz
Mzk0YTIxYmRkNzc5N2EyNDViNjU0MjhmNDRjXQ0KPiANCj4gQ1ZFLTIwMjEtMjI2MDA6IG5ldC9w
YWNrZXQ6IHJ4X293bmVyX21hcCBkZXBlbmRzIG9uIHBnX3ZlYw0KPiANCj4gQ1ZTUyB2MyBzY29y
ZTogTklTVDogbm90IHByb3ZpZGVkDQo+IENWU1MgdjMgc2NvcmU6IENOQTogNi42IG1lZGl1bQ0K
PiANCj4gQSBkb3VibGUgZnJlZSBidWcgaW4gcGFja2V0X3NldF9yaW5nKCkgaW4gbmV0L3BhY2tl
dC9hZl9wYWNrZXQuYyBjYW4gYmUNCj4gZXhwbG9pdGVkIGJ5IGEgbG9jYWwgdXNlciB0aHJvdWdo
IGNyYWZ0ZWQgc3lzY2FsbHMgdG8gZXNjYWxhdGUgcHJpdmlsZWdlcyBvciBkZW55DQo+IHNlcnZp
Y2UuDQo+IFRoaXMgaXNzdWUgd2FzIGludHJvZHVjZWQgYnkgY29tbWl0IDYxZmFkNjggKCJuZXQv
cGFja2V0OiB0cGFja2V0X3JjdjoNCj4gYXZvaWQgYSBwcm9kdWNlciByYWNlIGNvbmRpdGlvbiIp
LiBUaGlzIGNvbW1pdCB3YXMgbWVyZ2VkIGluIDUuNi4NCj4gSG93ZXZlciwgaXQgd2FzIGJhY2tw
b3J0ZWQgdG8gNS40LCA0LjE5LCBhbmQgNC4xNCBzbyB0aGF0IHRoZXNlIGtlcm5lbHMgYXJlIGFs
c28NCj4gYWZmZWN0ZWQgYnV0IDQuNCBhbmQgNC45IGFyZSBub3QgYmFja3BvcnRlZC4NCg0KQmVj
YXVzZSBjb21taXQgNjFmYWQ2OCB3YXMgbm90IGJhY2twb3J0ZWQgdG8gNC40IGFuZCA0LjkuDQpJ
IHRoaW5rIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoaXMgaXMgYWxzbyBuZWVkZWQgZm9yIDQuNC4N
Cg0KPiANCj4gRml4ZWQgc3RhdHVzDQo+IA0KPiBtYWlubGluZTogW2VjNmFmMDk0ZWEyOGYwZjJk
ZGExYTZhMzNiMTRjZDU3ZTM2YTk3NTVdDQo+IHN0YWJsZS80LjE0OiBbYTgyOWZmN2M4ZWM0OTRl
Y2EwMjg4MjQ2MjhhOTY0Y2RlNTQzZGM3Nl0NCj4gc3RhYmxlLzQuMTk6IFsxOGM3MzE3MGRlNjcx
OTQ5MWY3OWIwNGM3MjdlYTgzMTRjMjQ2YjAzXQ0KPiBzdGFibGUvNS4xMDogWzdkYTM0OWYwN2U0
NTdjYWQxMzVkZjA5MjBhM2Y2NzBlNDIzZmI1ZTldDQo+IHN0YWJsZS81LjE1OiBbZmViMTE2YTBl
Y2M1NjI1ZDY1MzJjNjE2ZDlhMTBlZjRlZjgxNTE0Yl0NCj4gc3RhYmxlLzUuNDogWzAyN2ExMzk3
M2RhZGI2NGVmNGYxOWRiNTZjOWI2MTllZTgyYzMzNzVdDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQog
IE5vYnVoaXJvDQoNCg==


