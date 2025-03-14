Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B146C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 13:50:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.20])
 by mx.groups.io with SMTP id smtpd.web10.14788.1741960253231705496
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 06:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=hcr3p3Oq;
 spf=pass (domain: renesas.com, ip: 52.101.125.20, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/WczMAZvC6RYMYg61+7g4yNKSYXh6AwVM+fMx664D8lLEEwMddY5gd6QlY9idBxozmgiUjytRrorRFLtFYFNivOinxS/rKftMV2+rOf2/hWQOuLP/4cf5bLEK0QEUOCSKzS4qY97fKzFeDi782CZdV1zPtycfHNRocg0ntOujlcUo3oG2Eezmpql41lkTKzldVybjAACfH1yqJImsRWIfs+gd4lsP0zASdqdOdlOzwZX1Lv85B53RZrqEIYcxTf99xakEDQfXDsiJi5kBoUGUsAPThisRZ7mMGzNzAFpfBPDTp/3AIkQvPtBat42iSGbKPNJKqcpeI9JjYTorzpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvLjXe98Mm6hqREK6ooVomwVdD1r+Nau+GJrFYUWLiY=;
 b=FtIX7BlyRqeRWcwGju9J5x/4bmgPianDFzEOPbxXzqDLdL350l6R2pBdcZM8qhuQys3drWXWEb/34L487lsjTtvd+5e6Nmga78o1wvrZyK/SAO1+nxfti/ZoytOqv8eEpJSXHOKo7XOR4ucfC8xBuiRCzeJ7KrXT3/MnVniM0YdWbzkbMkGJzz8FCDlaAxst1gZybcURBNec/c04hjwqAK899tQvF9YEUrh6R9qhy9CXYGwM26pkYdEdHE1msWOY4pKjrtYdFcbybSwOSh1RIzsogn1+/BQmQOcZ/xUb1Q1dNxtV35jw20kWRjSurKM6+nSurBIcUW6kGolEivSB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvLjXe98Mm6hqREK6ooVomwVdD1r+Nau+GJrFYUWLiY=;
 b=hcr3p3Oq9kOLfkZiZDd5h/oUxGtacGPGF3E5ODakhuwaclgRAoJpq72L2/eFfsEqdd+5KfkHfxv5vmK6sqbh8iGiy3rz49UIVPvIrIlf2YCH5mWUWuJUE0bzFwfOBlOzBE1vxQABxLa5OO+EoCNLry4MTldkNyrH3o319uemDYk=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by TYRPR01MB14208.jpnprd01.prod.outlook.com (2603:1096:405:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 13:50:48 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:50:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: lab-cip-cybertrust will be temporarily offline (2025-03-20)
Thread-Topic: lab-cip-cybertrust will be temporarily offline (2025-03-20)
Thread-Index: AQHblNRQ1Q66F6QQ60WLnUEcqhXmR7Nypmbw
Date: Fri, 14 Mar 2025 13:50:48 +0000
Message-ID: 
 <OS3PR01MB58963343415A02F93FE7715FB7D22@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: 
 <CADPJy8XoZ2656ueriu+a44bLQbCKOWB+_a4JcvBr-eARPbb-Yg@mail.gmail.com>
In-Reply-To: 
 <CADPJy8XoZ2656ueriu+a44bLQbCKOWB+_a4JcvBr-eARPbb-Yg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|TYRPR01MB14208:EE_
x-ms-office365-filtering-correlation-id: 675ab309-ce62-42bd-daee-08dd62ff39f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?blVXNWpEV2NaKzQvb3FRTDFZWkVWS3ZXbWg4WmlVNUY2NzU4R2hQaXFscFAr?=
 =?utf-8?B?eEwrNkx1TzBkNWtyOXdIYnl2WTUvVVZIMkVrOFdGbzhaWEthUytUTEFjcTB3?=
 =?utf-8?B?aklpbURRUHp0N0NMMUtZZlZpS2tZaSs0eGJvRGJhYzhmajQ3TngyTndkdUZB?=
 =?utf-8?B?ZEZvVXEwY0FLY2N1TmlxSFpJczVMQzdpYnZrU0NDcnJKU0M1Y0VPeXNnQmxY?=
 =?utf-8?B?Ly9sSjBlVUxLSDR3NGE5WVp6TC96MkJzdnozUktWVGhmNVE2V05OV0NzRmdW?=
 =?utf-8?B?R2MwNWZjenowSU5zTWhXZzEybWhPR3FHbjU1bWF4T3crVndVUVAwZ01rdmpC?=
 =?utf-8?B?V014RU4wUDFpNjJnbzJDa1ZqTVd0Q2I1UmV0MDV4ZGEwUTJlWjNqMWh1dzJF?=
 =?utf-8?B?bUNqeWFPaXJ3YXNvcFdINlFJZy90YVFoSHpqY2pzRVlsMzkvNVV2cHl5VExs?=
 =?utf-8?B?dUkwRmlQV3NKS3RBU2NjMURKTHRieVJ3R2hhdDE4V09mV2FENkp3ZEZHTlls?=
 =?utf-8?B?eEF4R2Y5R2FBYy9LendaVFhYYjc4MmJ2cnZNSDE5VE5FMUdHVGE4TnV0Rk4y?=
 =?utf-8?B?WWQyQlBkQk9EOVhOTGUxWFZIaG9PbVlNWVJiMzM4eTBBZCtjVjRYb2VNSkYv?=
 =?utf-8?B?c2dKUDJWMHBkdlFpWlFmcGJJQXdPV0hleVR2djI1WERZUzRvOVhRWDJVaUpt?=
 =?utf-8?B?R3FSWDdZTFBYVzh5dytMRDIrTVViL1NFaXk5TjhZS3NXdDlVK1ZJOHNvYnF3?=
 =?utf-8?B?ZEVIUVA1dTVLY1NEVk0vSFRHdUljOThrb0FyTFVFeVlnTE10M1ZpeHo2S21z?=
 =?utf-8?B?a0ErZzlSRFRVNGtybU9qL0J1Wk4wVzFSM3RtbFA2d0NHOUtkeDFIM3YxcFhY?=
 =?utf-8?B?djNWYUo1RmtjSnVpMkkrRnhURXBDYjFBOUNvais2VGUremJnM3FmRHdNeWJE?=
 =?utf-8?B?bGRvZU56UXZzd2pPcmR5QS82MGVUSnE3d0hDd05ITzYzSURjK3pVYktKby9H?=
 =?utf-8?B?d3dkQTNveFpLSjhETVBLa3EwQXpNRFdvblp5R0M2SG1uOGFGODJKb2tEQXVO?=
 =?utf-8?B?QVh3eUlYVXY4VTduNWhaSUpmYVU1YStrRmtyZWd1ajl1Z1RJV1l4OUJOeGhV?=
 =?utf-8?B?T0FhTEdvTEkveGlES0pWZ0tLbnJpQ0dqVGgrc3MwRlk4cjNNWE4vTWduOWh0?=
 =?utf-8?B?RWpFRVdUVU1HZlZGbGJHNzRENWswZDdYYUlBZE9NSHlmWlVhbHZST1QvbGZ4?=
 =?utf-8?B?VTFBWjF3STBualZyR1A0bTk5MEkvbEF0RXd1SC9yUjVVYTR3WUcwWDM1ck03?=
 =?utf-8?B?SU9LMDIyL0dLQVAxZWRzWjNOTEY2TXlVbWF3ekJaZSszWGNUMU1vb2dCU1lo?=
 =?utf-8?B?c1djZHpwd3BTa3Uzd3E4SE1RdHZXQ1hKdEtmeGV5d3ZYSWpCN1l6S2QyQ0xI?=
 =?utf-8?B?dUZLRjJkR3F4Y3BNQnBYVXlSTTgwY3JTbXFuQytyendzMmQ4U1JLQ2U3cXR0?=
 =?utf-8?B?VERLeXlmdXJSei8xSjI0YmM2R2Z1KzAzcHhQakxsWGUrWndKSXU0V2lyNDV0?=
 =?utf-8?B?TmROM21DN0tVemFMS2x2ZlBXdmQ4SEhSelhHUnpya2hvQjBwSmpqOUNXTysz?=
 =?utf-8?B?SnRpZmVCcVpmWE1QYjVBYzNKMzM0ZkZXU2pXOWJMalVScTVDZEs1aVBIb0o0?=
 =?utf-8?B?TmZUYmxMZ3E5dXFDWGxocVMyRm9uTFZlWnhqa2svU3djZTFXaUVFc2JjcDNM?=
 =?utf-8?B?OEU1eHEzZVNwNjdRK0RkMUQxMHdKSVkySlpyaEl6aTVWbWNLYkNGWmRUSllq?=
 =?utf-8?B?RGJHRURXYkRhMTRYUHF2ZThLSFM4RkVxVHBIajArU3VNYVN6UnJ3VG9HdTlY?=
 =?utf-8?B?Wm5qd0NjbFNNOTBZMkRHREpkbGk0NWxOa3NYZ01HTi9lZnc3RTVMdkVtQ1dR?=
 =?utf-8?Q?cQxGvX0FBw2yPKrQk2wvvNqS/2rI/F53?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVJVQXJjbXRrUDlBdnVlcGRkTTI0K3F1V1BaVmR6VVpZaC90NFQ5YVV0aFVk?=
 =?utf-8?B?b1BaZ3Q5Q01UZWk5aCtNSVAreWx6Qmljd0l1dVFZaklCL2RGYjRXcUdJc1Jw?=
 =?utf-8?B?TnVSbEtuNjdSQ1pEc1JSZGJjTFBwek1PeG5HUTJXQkhNWWd2aXNOUWxnY2Fv?=
 =?utf-8?B?R3R2WVJnRVMvY0l5VEZjMzAraTdqVXVIOHNyN2xXRmozM2dLQ0J1ZkJGU2J0?=
 =?utf-8?B?YmJsSnBLZFo4V2lIQVdSZW5XL2FZUGVXYy9yY3lVK3Z3Y3VoRzBnMkViSldY?=
 =?utf-8?B?RGl4Rk85QWVyZ3hIT3BqSU1GeEtQL3lCSVhjMjFtZ2hkWUpzYkw4Ti9qTGQ1?=
 =?utf-8?B?QXQwSXpTQnpsUlpCL2tmaW1XT3ZpaUk0Z1RiK3RFL3I2U2JUMFVaYTZyWTBK?=
 =?utf-8?B?N1Vlb05aWHlLMGxMTzIrTTBaRm5TZ1hNSkJuZDhKZzdhWmNwdFBQSUFSLzRo?=
 =?utf-8?B?aWtKVnk5bTJPdVVhUTY0Tk1UKy8zb0srMzhhelNOTGlJaDVUMW8yWStQQlcw?=
 =?utf-8?B?RGtYbEoyNUZlaWEwVk0ydFZYS2hTa040QWdSM0tOUTJsNFJEd1QzOHd6Slpx?=
 =?utf-8?B?YWhQa1RGWlhQaUw1SUlQRlNydWV6dEVtbVhuakRQbUExbnlQeVFuajdEQmJv?=
 =?utf-8?B?ZXJnVFZ2dktrOG9hbkczdytJd2JYeVlWc2dVVTh4akNzUFEycWFEaTNNL3J2?=
 =?utf-8?B?NGpEZEZ1L1FqNDNxQVR5SDV5NjZWcVdOWHNkS05TYVY2bnN0Ukd6L2hIaHZ3?=
 =?utf-8?B?aXk1ektDdG0razJoTDJDMHNLZVFXNkFKc0FWVWhVTy95Z2FrbFBwS3diS0NC?=
 =?utf-8?B?cFBFV25hZW5CQVB5TDV3em83MlNuMFJVczB4dlFSYmo5aW00aVNaQ2VpMWNU?=
 =?utf-8?B?TmJXRlhMTlpxWVhOSWhGZWdDQ3JYRlE4bWdnNUlSK0tINkc4N3pXa2JIQ244?=
 =?utf-8?B?cTlFekVYd1k4OVI2ZVNiR0RFNVUvcjBtOEpGODlKTGNXUnZiVThxaVY1K2U5?=
 =?utf-8?B?dGROcmNKR0pWdmJkN3l4K1E4cDV6TDZzbG4xcm1pa3B3Z2ovdkVteUtJVU1p?=
 =?utf-8?B?K254L3h0Z2FtbUxERXBtbzg0ZWM0cjBEcHRLWndrTk9zNDBnZGhEUUE4dXV2?=
 =?utf-8?B?cVA5bHViUFd1ODQwTXY3Ym5hUU9uZ1psVjFOSFk3Rmp2V0xnMEZBelVKSm1p?=
 =?utf-8?B?RG5lNWNaODcrQnc4dTNjMVIvb1J5aUhkYkhJYUJZZ2I5NFFyb1JsNW9QOFpR?=
 =?utf-8?B?ZW5oSHNMbG5IazRZa0JOa0tWV3dGTmkrTG95bzI0bW5URmNzQm9ybVJsWlFD?=
 =?utf-8?B?c0ZScyt1MW1qZUptSmNuS1lFMzFYanc0b2Z6bmFvUXZCSzlNUHJ6dVFBR1BV?=
 =?utf-8?B?QUExU0g2VksvSFBuVUE3a1hYOUdiSytEZjZWaGw4QVVmaDVGeUtDZHdpSGhk?=
 =?utf-8?B?d0FYWU4zcVViOGoxRDNTV0gxOWZBYW1FRlVMSDRJVUgxZTF5OEFnSXl4NzNm?=
 =?utf-8?B?NHpJZzd3YkdrK1Z6dnZ2M0FqQjlXNG5QcjNsY0k4K055b0JYeGNEWFJoL2Q2?=
 =?utf-8?B?VHhtbWlHUlBSVlhkU2VhYitPeGlYRzRHTmRoNGlMa24xOFFoTk1mNElROXMx?=
 =?utf-8?B?RXlpVXRWWFNHTk56R1hrc3I2WW1zcXhjclZHWUc3SW9xRC84WjNwZ0xjZkFD?=
 =?utf-8?B?K1RQWk9sb05ISzZ3R1A1Z3JnMXM0SFJzakNWaXB0YWhKRUJZckZLQ2o4ditM?=
 =?utf-8?B?YytjM3VJZVdvZ21GVXppQmdyRFkwK0RYa0FId2U1Z05wcFNGV1A0ZjRYMVRp?=
 =?utf-8?B?SmduQjhMYUtqYmtod3NFTXhWTHRoNFVuNHdoNnpEcFJTeHFncE95aThGVkl2?=
 =?utf-8?B?Q3BVZmc2RTRzbVRvSzZENUpabDJ1cGEyeENvWHhxVWt4aWFTeDJRU215VGFl?=
 =?utf-8?B?dXdMd1FieFVXdEREVkJ6M2ZYc2x2ZzhJU3MxdVI0N0lCWVR5aDhUYThTUjVs?=
 =?utf-8?B?SVhUNU5HZzhNTjVjeHl5Tm1QOXBWcjV0K2J0aVJ6UFAwMWQvUlJpaU1UbHUy?=
 =?utf-8?B?TzEzUmUxVHowUE5tQkhiazB3V0dscG13b1NhMk01NTNFa1hNVzRicUk0VXlT?=
 =?utf-8?B?dktZWWhzSUU2K0FRSkozWVhLQ2hPZHZ2K3VyaUJzcS8vWUZkblpzVU5PdTVL?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675ab309-ce62-42bd-daee-08dd62ff39f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 13:50:48.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSjV/0VJ/TbuXzKPLD9tlq71QZrFTbBBO0r7O4binOseXNxKXLteiLYSLuFgvluLtqTGKMbetl/ILxQusWbzaLkkIjwvGAZslKS+2D21WJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 13:50:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18218

SGkgVG95b29rYS1zYW4sDQoNCj4gRnJvbTogSGlyYWt1IFRveW9va2EgPGhpcmFrdS50b3lvb2th
QGN5YmVydHJ1c3QuY28uanA+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTE6MjkNCj4gDQo+IEhp
Lg0KPiANCj4gVGhpcyBpcyBhIGhlYWRzIHVwLg0KPiBUaGUgbGFiLWNpcC1jeWJlcnRydXN0IHdp
bGwgYmUgdGVtcG9yYXJpbHkgb2ZmbGluZSBmb3IgNSBob3VycyBmcm9tDQo+IDIwMjUtMDMtMjBU
MjM6MDBaDQo+IHRvIDIwMjUtMDMtMjFUMDQ6MDBaIChVVEMpIGR1ZSB0byBwb3dlciBtYWludGVu
YW5jZS4gSSdtIHNvcnJ5IGZvciB0aGUNCj4gaW5jb252ZW5pZW5jZS4NCg0KVGhhbmsgeW91IGZv
ciB0aGUgaGVhZHMgdXAuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiAtLQ0KPiBIaXJha3UgVG95b29rYQ0KPiBDeWJlcnRydXN0IEphcGFuIENvLiwgTHRk
Lg0K

