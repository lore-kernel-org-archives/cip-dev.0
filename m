Return-Path: <SRS0=M3jt=EP=lists.cip-project.org=bounce+64572+5766+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD53EC4741F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 08:41:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85422206ED
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 08:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="K6FvL05l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85422206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5766+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3rVRYY4521723xWPNs3iQwu0; Mon, 09 Nov 2020 00:41:04 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.97])
 by mx.groups.io with SMTP id smtpd.web09.8795.1604911263240025089
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 00:41:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obS86bMi7HGS4wuwBNIUdvRA5rkM8pU4cL7hwKzFfK7IO1mBTbT3cYjvk+38L9RwpX8OuFNnErW3zIrXvuisMaHfisZn75eLNPLUwoOgZY7iyQ4IPRDgCm0pfzqQ+CK4mMOX1T9wRdOxngIJHpwyWYJ3uGCXO8guopbcn5JY7oQkrXH7Nx8ETdD9mtepZkP+haztXlnU5ccso4nnhJYUCl7BS02h2wmh9+kc3v/mMDZWFFu2FjN1srV+O3sn9Qi+AdbOLTM3NBT3ulxgxoHM9XxmtR0kBH3KqYbLZb9RYunEpJESXUNyRWcRGIUmhUaC1WEDIjZOvFZIHlTamyTEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaxMI6earNglvYHAKgkvwYl5zXf1cpJiMhah5O4V62s=;
 b=oC9Z5cG5gQtt7jLStmqW8Yw1v+6hIVLQ9VY5S0dpF3gbRluo37UE2XFOvR1QqiIQYK22g6tEuX/FIEjDQKUwiCLMSSZYTULP7SoY4wKELTxYmH9TxY/u+btG4NXODCesqdjZIV4fFqE3MMsVXs3eMrFlE7MVOpV8p05KpU4QdFpuXwOKOISwQNmY9wY3HaDTG7NPGRu/W5GilkuldCVXIqci8lxzqTNA2oXbHpamqJqh6KBV+w/jb1LV5d3mu5CgrTkU2SY2TPbqL3KWPc71mik/lDXj+tCIr+/ubMIOEppzV6JAZAQ/TYT6f/Qh+0PeuZtFbDXXMpFZKeIt68gwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5842.jpnprd01.prod.outlook.com (2603:1096:604:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 08:41:00 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3541.023; Mon, 9 Nov 2020
 08:41:00 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP support
Thread-Topic: [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP
 support
Thread-Index: AQHWtNhA5zQMpgV0FEmTEmzpslKTqqm/CneAgABzn+A=
Date: Mon, 9 Nov 2020 08:41:00 +0000
Message-ID: 
 <OSBPR01MB50481BE7ABDC6B990BC3A72AAAEA0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201107073303.GA14654@amd>
 <OSBPR01MB298301B9CB770BFB9AFF789892EA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298301B9CB770BFB9AFF789892EA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff227242-e21a-4b48-f742-08d8848b2f84
x-ms-traffictypediagnostic: OS0PR01MB5842:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5842AEACFF15973C26EE039DAAEA0@OS0PR01MB5842.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 +ZU+A86iXDrzNlzpG8BGwRrxTzBYh6rJrdCmt2uYT+vcIlqn9Ts8o/2/nUjwDG385TW58zJmBBxrUnN1arfoSksZCR03W43JLLuG3OYW25C/7a8R3V4QZ3LGLw7ytM3+IbWC5wxqCMJpwgh3iS7KJPeMqZ1tK5lrrbz7spMxFpBlos6n6m6hoaPrDuXohrZ690N64qSLdtFb/cxL11gUA4K6jaL2GW009firdYZ9FtSI7+pzf8klEfrCgR+H/JmH/S7jya/vijFDEGIfeF+wQLzADJ5X3wVceRtST6Btd87XwWOZ2dbpuW4zLjClCuLO
x-ms-exchange-antispam-messagedata: 
 4mfRSaIy4Cy/lkVzjzN/RQTl+dNrJfK8kiaX4Z54Tejg/itRezxw1OnxSjs0DxhnXKm3uWQ6FlB13KB/1yrP19W2qMg3K7ZIeB1CoFcuY1ZrscHJvWAAiImP9LkaG6XARZeTDGRPxjR6c7lMqLlwij8WD4OoubcJ8CjFcCfxsZi43V6Z6QZ1oqjUS164faDW4ykxMZGbUhn/a5Jg6NPLvcWXAt67txLRat36Efb/Nbfkm7RKIt0J0oM064FrMMtOHwbkKygWeX3gZWNi6kTfnUDYRegWTLbnlbzwtRVcU5x2Zkqr/8aBEQqJugpvk+pJjvZ6tRid7fdrBTMMpcE3BG1e8zJlNq8MDjvImevd8qCoy4NPnBc93tThSzbNrc3rBayoE3zbC0BNOOJWwlYaYs13b9MDXu0wKHXdIlTstQf1eYC86doO5bXYsC+jrVq/De2BbSgtCFF7lUMpMuFC9Neduz4TyUfcl6OnARyiWdcHn738bdFOQlcS8XleE2A+MK+iRS/ilY2p/99IGxE1D/Uw/ZHnwGTrxD2SaNSRe2d42K5feW8xkQ2I3H/fKyhVG7P1h4oMn9aoR/tfPPuSj98cYxKZ54lt7qyBlPyc0mp7NF3/xO+Cx52Lx0lOzkb7ntZQM9DIgchjOZ2xRUXWbA==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff227242-e21a-4b48-f742-08d8848b2f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 08:41:00.4519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqzhY60NzbSC60tWh8oti0RmWwdFsKC4DIR4IYyHNtODrnU7cUfJN2wmiluoG+WyZEH+Kb+igoDVKT+XtFnPY6KV6ns8b+pMCAI3FH7CmZcV1XtcPcyWF0FYoM/YIJim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5842
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bW6ALT8vUq7NAdc1wv3lYWXOx4520388AA=
Content-Type: multipart/mixed; boundary="6fLGxNHUlF0eobBaWZOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604911264;
 bh=4sg8TlkwyVvZh9K9SHyzVdV/zgJAKwwCMbF6LOaCNlQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=K6FvL05loJR6uEICqVnGgIMtX8akNXz8RaWq8HrW0+SHecrGqlfMT/xfMm3+rpbS/Mg
 Z6HPpphwiO0n0TNNC/+cYxaeXpfIkjM22tqn8u8HiA6608c6aWnaV0cZZ+NSBvD667x1l
 EnrWxljLmT5HGsAi0UiVPRBjFkRtKbIx2zE=

--6fLGxNHUlF0eobBaWZOY
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sIFBhdmVsLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPg0KPiBTZW50OiAwOSBOb3ZlbWJlciAyMDIwIDAxOjQ2DQo+IFRvOiBw
YXZlbEBkZW54LmRlOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxh
ZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0ggNC40LnktY2lwIDAvOF0gUmVuZXNhcyBSWi9HMUggYWRkIFBDSWUsIFNBVEEgYW5kIFZT
UCBzdXBwb3J0DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogUGF2ZWwgTWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gPiBT
ZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgNywgMjAyMCA0OjMzIFBNDQo+ID4gVG86IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiBDYzog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDk
v6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA+IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEJpanUgRGFzDQo+
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDQu
NC55LWNpcCAwLzhdIFJlbmVzYXMgUlovRzFIIGFkZCBQQ0llLCBTQVRBIGFuZCBWU1Agc3VwcG9y
dA0KPiA+DQo+ID4gSGkhDQo+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9y
dCBmb3IgUENJZSwgU0FUQSBhbmQgVlNQLg0KPiA+ID4NCj4gPiA+IEFsbCB0aGUgcGF0Y2hlcyBo
YXZlIGJlZW4gY2hlcnJ5LXBpY2tlZCBmcm9tIExpbnV4IHY1LjEwLXJjMi4NCj4gPg0KPiA+IEkg
ZG9uJ3Qgc2VlIGFueSBwcm9ibGVtcyB3aXRoIHRoZSBzZXJpZXMsIGFuZCBpdCBwYXNzZWQgYmFz
aWMgdGVzdGluZywNCj4gPiBzbyBJIGNhbiBhcHBseSBpdCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIg
Y29tbWVudHMuDQo+ID4NCj4gDQo+IEkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXMsIHRoZXJl
IHdhcyBubyBpc3N1ZS4NCj4gU28sIEkgYXBwbGllZCBhbmQgcHVzaGVkLg0KPiANClRoYW5rIHlv
dSBmb3IgdGhlIHJldmlldyBhbmQgYWNjZXB0YW5jZS4NCg0KQ2hlZXJzLA0KUHJhYmhha2FyDQo=

--6fLGxNHUlF0eobBaWZOY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5766): https://lists.cip-project.org/g/cip-dev/message=
/5766
Mute This Topic: https://lists.cip-project.org/mt/78070979/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6fLGxNHUlF0eobBaWZOY--
