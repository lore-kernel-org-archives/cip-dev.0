Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB70107636F
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 05:33:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6223.1775021592649533228
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 22:33:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tX01/t/u;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775021590;x=1776231190;bh=qxIo0clvUU4c1K1v1hsnTm+8qK5T2395v1BCK
	FWNnlo=;b=tX01/t/uPap8SCY77tBGqITDUUJK9wwFA2qhTH1h5stXEohkP6W5InGMD6FxxkDZhO7
	EQmNw0q7foW+gOTt7ru122AymkGeBOdJVnW7X8RR5MPNgclg1yUyLTu3MBkHcpzO1dhyR61mF2Jf7
	C8TYBTxB7c/4gg2qa2T7EyS88qxvgXTKD6z+s4qmWuXIZJ3rTQfVaHLIH5RfT5xeOZKv3FMV41suB
	Q0MgJmMWHzNeEIsp9ovTXnNbUqr2/BbVgHVAOh1mB4wABLPW3y1zkpzoLsngpQliO6ymzPGfVAa7G
	Ng8qr6qQAsIIhaTeJaCHiihjpkEt14qY/xb2aOcnJBgQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6315X97j3438147; Wed, 1 Apr 2026 14:33:09 +0900
X-Iguazu-Qid: 2yAbiBABH4SWwFeuye
X-Iguazu-QSIG: v=2; s=0; t=1775021589; q=2yAbiBABH4SWwFeuye; m=RZD9e5jY2GPcPB1x1fMMbLvsS+5WAhrhauZKA8WrBik=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4flttY1HJnzyPQ; Wed,  1 Apr 2026 14:33:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKXrVeIoWoeUqMCjQ08Y1/ZlgOjLlOwxR6R3a5wLUF6HZiE9rkA2+bmiyjV0P6K2OvYy1IXknczlN2yY/Cyyyp2BEpPPCtHctrKTmqrPU+EteoOcGfOmd93OVa8vgTZmp8gcYJaG/YzLQ1s+5PpPYeaBCrGq3k9At1YRDlzyy6v8LrCtK6qIhuA5MyyLXaEiebgOG8qwlJjiPWpH9HTPvUSbmKp05AFUGtXvmPfaEU2o4oSkFZ/kBrXZUEjvO4MzlK2V5gcdhXmnlL3NFFQl7lkWvqBex21zT5HL3fjNv/ZSL9QP/DfhT72AuFzfxNi3N0HTwlrLNypEoyxjEJcAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxIo0clvUU4c1K1v1hsnTm+8qK5T2395v1BCKFWNnlo=;
 b=MPa2/dE/Rfv1/jZbknYquxAqloWNR+YVvtWZJywPhvs/vbOIYPMUF8eBMkqZFTibnxpn9cCyzgI18djZSd3b5A6bmtqNByc/+kZLJUDlRY6j90ErgiQRonHEOuAylMt5wMV79Eo/yN2rnp7WGiYC1TnmcNGF14PhUytBpBRrylzEvcMWxjPmWa4W2iO7vuWG+mNDuGYAaPwVWAWPE4jzvscMZ64dL4NIHRz1B68RfG+tDe93dzhcaSDHuWvo9RDk6/MV+XJkvxn+9ehO1a1/F7AWG6+wNpkNiUenMr+5X1phmejiXnwzshavLovc8MOn1/Bs++ffmqr5TxGqkieTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Index: AQHcurUEgTGpo9U8nkK25AEyWq+DcbW9ZYJQgAxBJACAABV0oA==
Date: Wed, 1 Apr 2026 05:33:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182862B0AC7F44368AFFEACD50A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
 <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
 <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <fc9fce75-6f6c-4753-8bc7-c14bd03d2731@tuxon.dev>
In-Reply-To: <fc9fce75-6f6c-4753-8bc7-c14bd03d2731@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10014:EE_
x-ms-office365-filtering-correlation-id: 095ea74f-ebe0-474f-70d8-08de8fb026ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 kxMmvOvISy/6xCD7ZKeEYBo5XWF2xTygotfb6BsrZvEAc8mCpE7OJYIE2W3dQRviAl/knByAitiDIyUrH+JfOmPqQl16xDf9M1LnY2BKr9xGAFo40O5KamajrRFAB+zCeLzTxVx1qgKsd4XQYDawUSS8Jgpp3aIiK8PVEgmwFdN/fQnxNzIcGFPLzmRMWdeoX9Yh/TysVTgQY1sguQFu1lGfQaBGD9LAVMUuHqsvz2cAB2a088iLVTiX/0KaND1okbTGlbwyg+F7eZQuE8K8rEB4hMgf3zy0MpaWnajYtXFqTgTgRod146Up9ogpPbc/LvEacVV6PvsXod1tpZd23ZbTBuIXJ3HpW1vYr8yoXh/axoK+bKwIo8d7iV4lzLv05RaxqVJ8lwvkSWNjxYkbW+HWrBTHrjjo84NpTo3AlzP5pq82KKGFvaYnmRZtAxyIz5vey7g/byBpHyAPLv+LYkCvkFjcO3pIKZk0lqpxiPZw3mcKGE/c9rKIEj+jEy22CEQeiooVZQkPVqm41sBHviyLvOKdos92a8guafy3N5wnTJFwDeHhOMlnQkydJme9XbgupFcdWgH3f44+2q47t8/A9dwacaDnz2OGnjppmaQyckrpT2erdCXckYgXNA2hcwObGmgFZu9hNtXmrqu/RY3ziEX38SU1pNDMmBRAtI6XB8Fqdvn8ovamZBF+8JMzq7XePoq1rs7KyIzXkAYvXhb7rsIYWoGppsaTPD+dI/KJ3C1ed4FO9JEi24WZfPehQjZCih6CUKGhd+Q8pmk7qkthAfE2Vz0v7Dp5/RpzPJg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aXJ5WFAvazYzR2JEazVaNW02dWRDbW9rSytRallKN2ZsTUhkT1d2UnFxLysy?=
 =?utf-8?B?aURUaURCeXdXUDRETzF5UzBSRU0xZkR0ZnNOL0xOZWJUWEdjU3JKZmx3ZnBv?=
 =?utf-8?B?cmdxQUV1cGVXOURzUWtaTEJxK2xxK3ZtQUd0bVQ5UWgrZ2hVbTExbjA3ODlj?=
 =?utf-8?B?Zm1hY29tVm9ROHgvZ0ZrME9nZmxYOXJ1TGpZN25XUHU1clpnMFFmQmtjZWFS?=
 =?utf-8?B?a1ZnRWpGNlZrb3UxVzhVUnF6UktGRC9DVGMwL0lGMVYrc1c0amZmVkpYQ2gz?=
 =?utf-8?B?ODZ1bUtnRkVOQ1ZORWQ3ZFFaREhTT0xiaTA5V1RJOEwreDdTa3hkYW5QcTJO?=
 =?utf-8?B?Qi8reVJZWFFJMXhoSTRUZFBtdkoxR0h0aGF3MithZnNRTUU3OXBwR056dHMr?=
 =?utf-8?B?ZlhPRHpDenJvZ2hadzlRL0FJcVFzemZRSzdSNmIvODVTRUxJUHlMN2svVTJP?=
 =?utf-8?B?aUFwclVIT2dkc2Jod1NxZlZVSGJLejNyWHpoU2Z0dlFXOEUxVDNyVmlmUisr?=
 =?utf-8?B?MUZha1d3NXZZSzZMeVZxaEd5UDBMd1FQK3ZKUk8yRXhNcXZuaEEyd29tSG5x?=
 =?utf-8?B?c3ZMbTNkRm9ZWlJUOTdEWjJEclZiaHQ5N2tMWmtPQ2JXTGxCcURiZ2lhcE12?=
 =?utf-8?B?MStLT29rZTBuWFBDSWNkQWtwb0R0UGxQL0hlRlltdzF4V2NQeXlCRENId0wy?=
 =?utf-8?B?Z1hsemFpSHNNWlhnOU9neXhnZ1RSL205UHZhL3gzNmlKQlJmTlpTYW1PL0dn?=
 =?utf-8?B?WXU1UVZGZHZIaGhlc2dOSEk1M050bWlpNHI2dTB2MEt0ZkRML2o1WCtkbytV?=
 =?utf-8?B?cmlBSnpvZzZsNHlId011UEdlN2EwZlc2aklybkI3eHVVQUhjVU51czlPakFr?=
 =?utf-8?B?L0tUVnN4QjQyRUxXaW1KQWMyRENKMUhhbE1pTHpmb0RUZFVxYXF0NFJCVm9m?=
 =?utf-8?B?b1c2SHJSVHZUcnBmc0JYWEVEN1VaVEJjODM1b0NHVSt0d0hvSmN2Vk1KOGVL?=
 =?utf-8?B?RlA1d3RvbU55QUw2TXI5STV5ZkVzeExuNFBzVGptdlM4SEZQZGhaZm1NQmN0?=
 =?utf-8?B?RG1ITDZTdGxIZitlb0NKSEdvWkFzZ3FzY0dFUnhXNU1IR0JidHpEUGY2RUM5?=
 =?utf-8?B?TTdSZGVHR3daRUd0T2dYb2Y5Y1BMYXpRZ053QTcyVERFOVkrVWFkK0w1bFU5?=
 =?utf-8?B?TTgwUnh4YnJSMTJmNUlyVnhBcS9yL1NZa0lNZWVOaEluME5aN0h5RlVRZEFy?=
 =?utf-8?B?TmRRdVEweUxGSnpzYnk2WWZCbnJCNlE4SlVVR3ZmQ1llMHVsS1lESFN4eWVo?=
 =?utf-8?B?cUY4clBmZzBBb3E1ZHdwaG9yOHdOcjBmcnpmUFdzSXZiNDlsc3RIVllkdHpG?=
 =?utf-8?B?TERLcVBJc2ZrNFNSZjZpTU9ReHdHVDhkcVR4RjJCY2FFTEQ3VWg3ZXR5SUMv?=
 =?utf-8?B?UjFnOE5OWVdVWkI3b0duQ0JDOHZDa2dPSnhwVGoxRzhVV1hMenRKZnYrSU52?=
 =?utf-8?B?emd1MlJtaEhLQTFkZzJQdW1PQTZoUStOSGRRM2luR0tuV3Y4UTMvdk1ZTm5r?=
 =?utf-8?B?enZ5cW9weStyUFpVdEYzR0RBN0s1dVpydW1SU2ppY1pESUlXZDY4dWdta0x0?=
 =?utf-8?B?TEhodHNyWVFUVVduVS9xZ2dINC9UMmtlN2tJWGRIWVkvQkxuejFaQVhxbTRI?=
 =?utf-8?B?Lzg5SHVkVnUyQVZwcTViZ0tONFF6Um44bGYyam9zZi9YdWZhdzRzM05DZzhF?=
 =?utf-8?B?a2N3Wit0MDRZN0dUZnJvcEJDaS9hQmFSbWd1bVBCSHRiOTVRTG42SmZZRnpN?=
 =?utf-8?B?OThVQWx4V3ZxbDRRaWlZK0QzMFNxdmZZMXphVkZ4Z0tGRThxd0ZiWnF1MDRt?=
 =?utf-8?B?ZDhFdXNvZXJXendwZlA5OWNUTHE2UnFKdlAvQlFKSExFODhod2dscm5GclRr?=
 =?utf-8?B?QloxRy9aUnBmY1Z6ZjlFQTEvUjdGOWE2RE52TkpWZm5nVWNmcVpjUnI1TGRQ?=
 =?utf-8?B?VlhuOGlIN2hhcWd0eGtkdDZzTjVjUFVXTHpWekhnSDhwTTBXR3B4blJacit6?=
 =?utf-8?B?Z3ExNXNsOG5HQlRtOEU3ZUh3MHlmck1YaGl6S2ZlemJNQWM4eW92N1UwcGxV?=
 =?utf-8?B?S1loSEM0cnZNWFkzU1g4T0VrN0pLRVdIZFJielhEOXhFRlZZR0hlWmN3T284?=
 =?utf-8?B?OUZLRHBidlR1QWs1Q01SYWZlem03TzNEUVBhUkQ5ZHFFSk9QbVdyN0NSMits?=
 =?utf-8?B?R3N1WmdOa2RwOUpsR0dVYkhrRlRWUU4zaFhXS2JiMFJ2dHlmd0lJdno2Mng3?=
 =?utf-8?B?NnVnYysxWjFrbnJVOUVYMFd6L09ZeUxrVGI4TkZSQW9NRk0rNVpvS0ZWTjdT?=
 =?utf-8?Q?VTmjgpxa+F80OfRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZwsIOKDvT25+/XGicSrnR+6Q/pFRht3SIHT5ngMye6T5UfxXD8cXqoRp1lZylOC+v3G3s1jK5VrLqAx/dNAYtk3BLak8Bn0n53OrZrhWZAPP96CvF3EXEd1O9JBRKavgtq111ydqJVqGIQ/elnN2v4n17Cioc/yuRwhi58L1z47CHdurgEu4Ndh/jwbHk3Km0/Bt6dPRDRb6X0oCxWTsNfDvXhf3NUL39CLG+rU02LBAg7AnhrKj2VGnLPQNmO4fDW54IqvCaDA3JUxUxcZERodjo3bxvNX6QCeLiZlXcHZBn0rwwHBiPET3Ds9Lpo0nVvHjkl/bEcMAd9XsvCl20g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ea74f-ebe0-474f-70d8-08de8fb026ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 05:33:06.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKiqsmMi6cS5vZO0+RaU7/kuHr4qBIRGyB0BK0d9BN4B4UG28g7SXA8B5SQO6I+hK5AWYa3gYXrQ9w2IJQUEgQw9IG2LNNx2IZCfTZG774Kwt+TQp46vtPmQ+25eWu39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 05:33:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22613

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDEsIDIwMjYgMToxNCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/
oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIDxub2J1aGlyby5pd2FtYXRzdS54OTBA
bWFpbC50b3NoaWJhPjsgcGF2ZWxAbmFibGFkZXYuY29tDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRDSCA2LjEueS1jaXAg
MDAvMTddIEFkZCBSWi9HM1MgUENJZSBzdXBwb3J0DQo+IA0KPiBIaSwgQ0lQIG1haW50YWluZXJz
LA0KPiANCj4gDQo+IE9uIDMvMjQvMjYgMTE6MTAsIE5vYnVoaXJvIEl3YW1hdHN1IHZpYSBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRp
dS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50OiBNb25kYXksIE1hcmNoIDIzLCAyMDI2IDg6
MDYgUE0NCj4gPj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp
77y077yj4peL77yj77yw77y0KQ0KPiA+PiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9z
aGliYT47IHBhdmVsQG5hYmxhZGV2LmNvbQ0KPiA+PiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggNi4xLnktY2lwIDAw
LzE3XSBBZGQgUlovRzNTIFBDSWUNCj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBIaSwgQ0lQIG1h
aW50YWluZXJzLA0KPiA+Pg0KPiA+PiBHZW50bGUgcGluZyBvbiB0aGlzIHNlcmllcyBhbmQgdGhl
IHY2LjEsIHY2LjEyIGJhY2twb3J0cy4NCj4gPg0KPiA+IFNvcnJ5IGZvciB0aGUgZGVsYXkgaW4g
bXkgcmV2aWV3Lg0KPiA+IEkgY2hlY2tlZCBlYWNoIHZlcnNpb24sIGFuZCBldmVyeXRoaW5nIHNl
ZW1zIHRvIGJlIGZpbmUuDQo+ID4gSWYgdGVzdHMgYXJlIE9LIGFuZCB0aGVyZSBpcyBubyBjb21t
ZW50LCBJIGNhbiBhcHBseS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRz
dSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gPg0KPiBXb3VsZCB5b3Ug
cGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlJ3MgYW55dGhpbmcgSSBzaG91bGQgYmUgZG9pbmcg
Zm9yIHRoaXMgc2VyaWVzIChhbmQgdGhlIHY1LjEwLCB2Ni4xMiB2YXJpYW50cykgdG8gZ2V0DQo+
IG1lcmdlZD8NCg0KSSBqdXN0IG1lcmdlZCBhbmQgcHVzaGVkIGVhY2ggdmFyaWFudHMuLg0KU29y
cnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQo+IA0KPiBUaGFuayB5b3UsDQo+IENsYXVkaXUNCg0K
QmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


