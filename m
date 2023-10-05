Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4EBE7C4F3
	for <webhook@archiver.kernel.org>; Thu,  5 Oct 2023 06:57:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9823.1696489057614331229
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Oct 2023 23:57:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3956vRR23564795; Thu, 5 Oct 2023 15:57:27 +0900
X-Iguazu-Qid: 2yAbsjsmdnvNBFZLrV
X-Iguazu-QSIG: v=2; s=0; t=1696489047; q=2yAbsjsmdnvNBFZLrV; m=FdiLFWuNeestqoZ2lSz8htM1zRd8ZZfU/mvfBb531zQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 3956vQ6e3988559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 5 Oct 2023 15:57:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVP4cXUj4TwiOclgInQk/P8v3QfyCLxtS9laiir1r57Wqs+bKXtAnBfchcNqN/OSswJAPHcdlJHOlI0A3GGwpMiA3PZ+qKSRkXlYxFLGCSP2apQoASTqQfsQzncLZQIuqV7qkCKtjcxFsNfrq5ghveFDcq0mPZeg0732wgjIumT6WVjpkDOXdtWlLyJeoLzAq/oOFGthxx8olidTJoc1HCGk2oU8oC7+ni3VcaO7dPyosDj7TwAf5ehPd9JC8GaxkXQTOBphDEJ8tpUq27NCbcm8kQHCrhtuZqBgaMdWXBl0GsXBjtUyFhKgUYzD+dXOzOoxrn6iK21NPwYv4iV6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQEyVBlT+VyvIfB9Ud4JJvMbrmIHzKbFDY0ufJJPfJ4=;
 b=PtIK+FSljLcxc+s+8FkJeyqOe8CRbWnHFpH2TtRn2EPS1YF2UGoAdDoRBUGuridSW3r/Eg3UIh6vZRh02bleQQFIemfl95+yB1HXK7BpCaWXnuyg6XynDK68mzWCCHmdBd7YQE3tNG5CmcMJV8n5zMXiPeymYoaDvqqG7+/ZTC8MC70+QgVukaMxR6znJRjQV338QqnJQBhj9DFX9lrl9YpQfFVCt1pBLEcOTCr3cCvUFFUixbLJ1tCMcL0iC9rRPE12n9rtAFVAw4iY9BupExtIhzTk30g+vQFlMc9xgkb7YPoM2TAvVi6tqxOV3EKeThLGN6WpEg+9XFPlDeVDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] Request for reviews for 4.4-st45, 4.4-cip80
Thread-Topic: [cip-dev] Request for reviews for 4.4-st45, 4.4-cip80
Thread-Index: AQHZ9cp1IMS7AW+gF0ihYV3dwrsV1LA6tVRQ
Date: Thu, 5 Oct 2023 06:57:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245FA52A10B2B824B8E8B9692CAA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <809419142.671756.1696317771828@webmail.strato.com>
In-Reply-To: <809419142.671756.1696317771828@webmail.strato.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS3PR01MB7849:EE_
x-ms-office365-filtering-correlation-id: 218fd963-b584-4ca3-8612-08dbc5705428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lXgDhXc3TAkuGbFMKVBbOrZeZJRcUCtWKYVhU7c4XvwyOPPwpMRs2wfOVOX5PawLgqxDpx8EZS5t2B5hK6vXea/HQ0aR34Or+pK14QK++jGCrW8XQpXutypR3v/bXwxJdKjm44Z9IjfiXCW91okTnWVDDFbyeo2zt6KDoA8XvRwNdrky7ms2oqPvC79Ev0YSQrRIFmXXe0vW30dMrDdpZ9HHhrPaRfGw0y76DNXOQxCd1vd9PpEAiakc2mnuoTw0gM3Q+FstCIdH1AzS5PQ5OxYoPY2kCmGjmTJaAYP9+p0YfrdiC2D4hQj4NAXKBneN5G7mhPurH/hDeNhgqeDrQn/YXNolCaKoem7InwCIx82TzLx2IlE6V1ikdXhkh+LYF+uYS7FtHqGrKiDPF+/uw+YEDI1QIsBiQxKBm3z6Zg2MXzj1MeTsy4sZtZSGvX2PXH08i8oG98rt5i4SmTEaEyR40ICD3YZ5TTEEsRvS4161UK7Wmq1efCtUnnBKhKlE/C/nKyYTy0VAR8djKveCrlfD4leg9s+f439v9magWLsEtKL6FULJwIObUsVpYHlA4XHLuMYVLIGRQNrGAxqAinA5JxtQPu4QUpeE0ASguN4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(53546011)(7696005)(9686003)(6506007)(86362001)(55016003)(38070700005)(33656002)(38100700002)(122000001)(66556008)(2906002)(71200400001)(966005)(478600001)(26005)(83380400001)(316002)(8676002)(8936002)(66946007)(52536014)(41300700001)(5660300002)(66476007)(66446008)(110136005)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUpOSWhEQVpJRmRGZnh4MUhCVDl1aWlibVRCVDZZOXR1ekVNMVRpdVBraDNT?=
 =?utf-8?B?c1UxUWF0UmJ1YTF6V2ZnOENuQXM2K0VEWlcxZzFqM1l5VURkalhFT1lXMXhE?=
 =?utf-8?B?U0dGQnZGS2Z4SnE4aTZtMTAzL3BGZDltWEovTTF3OFl2bVlFRHpyeXRqd1Fv?=
 =?utf-8?B?MVI4dE1leDdpaVJlaWRnOW0ySFRoVWxqRkNnQVMxWDY2SWpDbkVXVGh0YUcz?=
 =?utf-8?B?aHVxbkhiRExEenNIWjY5MWpvKzFYUFlUbG1FSHZpeHFvVGEvMzBiRWNDMTJT?=
 =?utf-8?B?ckoxS3B0c0tNRExpNU1mUU1Oa3lKSVdSdzdXUXVBeVVpRTBHVWw2OHdDQUc4?=
 =?utf-8?B?aW56MU82b214Vm8ySGhCUTNPWFdoR3NPZWV0V0JoMjVzOGYvRUZEOEVNUmEv?=
 =?utf-8?B?N3UvbnpLenVlYlJ2SG1aV2Z3OS9tcjV5TWtXWUtZSkErcG1Ca3RWeXNsRFNN?=
 =?utf-8?B?Y0JIaVVPaEtMSWhLQnFTR2Erc0tQS2xDYlBMRUthWDVJbitnLzgyQmlRWWRn?=
 =?utf-8?B?VHhMckdMOTVNZXM0L2h1QkM5Nk5lajlUZ2pIb01PQ1BOV0NEL1RPSk42TDc3?=
 =?utf-8?B?eUxsN3ZDNlZOc2F5dzhsbnlQWWxDRkdINjFZb1J5MTBvUGozVmk5cStFNmFO?=
 =?utf-8?B?WFhaVlBVZG40OExXOGVIMGVMeEd1QzFBaHcwWDZaOFk2MnBUNkxtVWN2dUty?=
 =?utf-8?B?OVBDMjZXRkdQZnpFTGNFcWpFSVF0Sml2eWZKYk9hbkQwVEQzU01CTVZqblNL?=
 =?utf-8?B?OWFxYlV4N1Roc1ZCSmdrd3ZYcjZ4NGE4UmlGcUpoelNyY2lQNjRCWW1jK01r?=
 =?utf-8?B?azJRSlZIWnFFc0p5aVJoeUJ3MGFPWkJiTjlWamwyZG1McW9JQmJrQU9VeThv?=
 =?utf-8?B?UGhmYk1iOG9CZzJiZHBvNzF0eHowZkZmOHlQenJIeXB4c0dpNGtxbFVLTDFR?=
 =?utf-8?B?TERRc0tnbWM3Um9iRkRabVJxL2dSUmpJTE9rQjUvVVlWVHpkSUVnclJST1d4?=
 =?utf-8?B?Mm81cTVzUUthczRseGtJSU14eDlpUndjNjFQZkk1SEQ0aVFUcnl1WnlqOHpB?=
 =?utf-8?B?ZktKaHk3SGs4eFNUQ1Z4V2l5RlZnQUQ2UkhrTzc1UGM3cTBhN2tIMVhodjNn?=
 =?utf-8?B?akduSEhZVnoyb3dDckI5ZWxoSHpicElFbFVXK1ZOVmptaHhkME9NYXFNUC9P?=
 =?utf-8?B?OUdVZmcwSGdzMXNQUDRpTUtNYVBsTWh2SGw2QllqRWQ5Yk5NRjZxOFlicGV5?=
 =?utf-8?B?aWVGaWFueFpNalFuemlLbkxOeFQxYllydHIrSEZqbEExVnRod043SC80NUU5?=
 =?utf-8?B?UmtkVnZnRENjQW1jMkhNcndkZS9HcGYrOXJORVpsVkZUVTl3UU4zYlNWYmpZ?=
 =?utf-8?B?Y2g5Y05OL3FuK3RtMEZLby9Uamd0WGlrZ2h2cjgzMnlsNTk4bHp3ZmxBSEQy?=
 =?utf-8?B?N283ZlRtbTNSSDUwb3JMV3JNYzlIVE5SVzBuT0RQRjBwZnFoaTRQSVFZOEFv?=
 =?utf-8?B?ZEJLYjJsSG5XcDVBSlhVeXlaVWdia1BlYUJLbDJlaVVIRnJ5K2dteFBlY3dU?=
 =?utf-8?B?cjBqcWUyU0JRZUJhUHhOaG9qL3lFZHFVaG9OQVpIS0lEbngvblAveFVaS3dJ?=
 =?utf-8?B?K1EvU3FPOUlkYVZPYTU0OXM4UFBhMi9ZdVNTZUI0NGZTU29NMS81aytROUYx?=
 =?utf-8?B?RlBlelJZMDZLN2NpaEZpQXMrenhyU3JZS0JSV24rYllLbzJQWWZJWWlMS2NO?=
 =?utf-8?B?T1hXS09OMWkyRFY2VDZnSW13N0hROTFsT0lZMDZHbzVsUCtnRVlGcTFkUjky?=
 =?utf-8?B?dENCQVB0UElxOXllbzVCRnJ3enJjMEVkS0pXNzJaM1MyUkNGQ2w2bUFqZk5D?=
 =?utf-8?B?QytsU1ZMS01VNG9JMkx2aDVSckRCZVYweFliU0hUWmlrbVA2OW1UeDJScnVz?=
 =?utf-8?B?Y25ST0xKU0QraXRaRFlUS0VwRkU1bjVEaW5WdmExZko2WG5nRHNraHFkK1BK?=
 =?utf-8?B?UGZST3RuWkpuSlh6dUo5elFBTm5tOUtNM2dzQzE4VWlxcExsZFRoQitrWTdn?=
 =?utf-8?B?ckdDWk1qb0gyTjRRVHVwZ0tjWGVpTGg4YWpHTGhhQzlVZlhTVXhQZDBtUG9U?=
 =?utf-8?B?Y3hyWW4rNVhreGVyYXU4QkpCc3pISndTNzB1Wjh4eUJPcEVDR0MwZU1CeHE3?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218fd963-b584-4ca3-8612-08dbc5705428
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 06:57:24.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdMWhxOcnLccM7gSNyFoTa+axL9hJx8YbsRqkGw/8c0VwFz/f5Q9Ozgkty7ebLVbGrsgTZaQyaQzXUe16yZ7t1wUZGutCnuZGUzoaD1Dx+WpHIT6VvB5+FL9fZGWfcbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Oct 2023 06:57:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13292

SGkgVWxpLA0KDQpUaGFua3MgZm9yIHlvdXIgd29yay4NCkkgcmV2aWV3ZWQgdGhlIGNvbW1pdHMg
b24gdGhlIC1zdCBicmFuY2guDQoNCiAgdWRmOiBtZXJnZSBiaCBmcmVlOg0KICAgIHlvdSBmb3Jn
ZXQgdXBzdHJlYW0gY29tbWl0IHRhZy4NCiAgICBjb21taXQgMDJkNGNhNDlmYTIyMjAyMTk4OGIy
NzkxYzhlZmVmZDcwZDMyMjhhYyB1cHN0cmVhbS4NCg0Kb3RoZXIgY29tbWl0cyBhcmUgTEdUTS4N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIFVscmljaCBIZWNodA0KPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDMsIDIwMjMgNDoyMyBQTQ0KPiBUbzogcGF2ZWxAZGVueC5kZTsgY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIFJlcXVlc3Qg
Zm9yIHJldmlld3MgZm9yIDQuNC1zdDQ1LCA0LjQtY2lwODANCj4gDQo+IEhpIQ0KPiANCj4gSGVy
ZSBhcmUgdGhlIG1hbnVhbCBiYWNrcG9ydHMgZm9yIHRoZSB1cGNvbWluZyA0LjQtc3Q0NSBhbmQg
NC40LWNpcDgwDQo+IHJlbGVhc2VzIHRoYXQgc2hvdWxkIGJlIHJldmlld2VkIGFuZCB0aGF0IGNh
biBjdXJyZW50bHkgYmUgZm91bmQgaW4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQvbG9nLz9oPWxpbnUNCj4geC00LjQu
eS1zdC1yYw0KPiANCj4gQXMgdXN1YWwsIG1vc3QgYXJlIHRyaXZpYWwgb3IgbmVhci10cml2aWFs
Og0KPiANCj4gKiogbS18IGRiY2ZhNzgyZCAxYjkwYWYgbysgfCBpcHZzOiBJbXByb3ZlIHJvYnVz
dG5lc3MgdG8gdGhlIGlwdnMgc3lzY3RsDQo+ICoqIG0tfCA2OTE5N2IyYjIgMzAxODhiIG8rIHwg
cnRuZXRsaW5rOiBSZWplY3QgbmVnYXRpdmUgaWZpbmRleGVzIGluDQo+IFJUTV9ORVdMSU5LDQo+
ICoqIG0tfCBhMzQ1ZGY3YTcgMTlmZDgwIG8gIHwgdWRmOiBIYW5kbGUgZXJyb3Igd2hlbiBhZGRp
bmcgZXh0ZW50IHRvIGEgZmlsZQ0KPiAqKiBtLXwgZGQ1OWE3OGQzIDBjOGIwYiBvKyB8IHJlZ21h
cDogcmJ0cmVlOiBVc2UgYWxsb2NfZmxhZ3MgZm9yIG1lbW9yeQ0KPiBhbGxvY2F0aW9ucw0KPiAq
KiBtLXwgNzZiMDhlZDk2IGExZGI3YiAuKyB8IG1lZGlhOiBkaWI3MDAwcDogRml4IHBvdGVudGlh
bCBkaXZpc2lvbiBieSB6ZXJvDQo+ICoqIG0tfCA0NTczYjNhOGIgYzA1Y2U2IC4rIHwgZG1hZW5n
aW5lOiBzdGVfZG1hNDA6IEFkZCBtaXNzaW5nIElSUSBjaGVjaw0KPiBpbiBkNDBfcHJvYmUNCj4g
KiogbS18IDJmMmE1OTA1MyAzYTIxZmYgbyAgfCBBQ1BJQ0E6IEFkZCBBTUxfTk9fT1BFUkFORF9S
RVNPTFZFIGZsYWcNCj4gdG8gVGltZXINCj4gKiogbS18IGIyZjU0ZWQ3NyA3YmY3NDQgLiAgfCBt
ZWRpYTogZHZiLXVzYi12MjogYWY5MDM1OiBGaXggbnVsbC1wdHItZGVyZWYgaW4NCj4gYWY5MDM1
X2kyY19tYXN0ZXJfeGZlcg0KPiAqKiBtLXwgNTBhYmU0YjM3IGUxMTBmOCBvICB8IGJ0cmZzOiBm
aXggbG9ja2RlcCBzcGxhdCBhbmQgcG90ZW50aWFsIGRlYWRsb2NrDQo+IGFmdGVyIGZhaWx1cmUg
cnVubmluZyBkZWxheWVkIGl0ZW0NCj4gKiogbW98IDU4YTNkMWQ0YiA1MzEwNzYgbysgfCBpcHZz
OiBmaXggcmFjeSBtZW1jcHkgaW4NCj4gcHJvY19kb19zeW5jX3RocmVzaG9sZA0KPiAqKiBtb3wg
Mjk0MTAwMDFmIDliYWVlYSAuKyB8IHNlcmlhbDogc2MxNmlzN3h4OiBmaXggYnVnIHdoZW4gZmly
c3Qgc2V0dGluZyBHUElPDQo+IGRpcmVjdGlvbg0KPiAqKiBtb3wgODJlMzZmMGMyIDYzNzJlMiBm
KyB8IE5GU0Q6IGRhX2FkZHJfYm9keSBmaWVsZCBtaXNzaW5nIGluIHNvbWUNCj4gR0VUREVWSUNF
SU5GTyByZXBsaWVzDQo+IA0KPiBPbiB0aGUgc3VyZmFjZSwgdGhpcyBvbmUgaXMgdHJpdmlhbCBh
cyB3ZWxsLCBidXQgSSBjYW4ndCBzaGFrZSB0aGUgZmVlbGluZyB0aGF0IEkgbWF5DQo+IGhhdmUg
bWlzc2VkIHNvbWV0aGluZyBoZXJlOg0KPiANCj4gKiogbSt8IDcyYTFhZDU4YyBiODg4YzUgbysg
fCBpZ2I6IEF2b2lkIHN0YXJ0aW5nIHVubmVjZXNzYXJ5IHdvcmtxdWV1ZXMNCj4gDQo+IFRoYW5r
cyBmb3IgaGF2aW5nIGEgbG9vay4NCj4gDQo+IENVDQo+IFVsaQ0K


