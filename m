Return-Path: <SRS0=E5Il=MV=lists.cip-project.org=bounce+64572+6640+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E4C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 07:50:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F8D60F6F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 07:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5F8D60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id M8acYY4521723xWt32DNyN1A; Thu, 29 Jul 2021 00:50:18 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.6591.1627545015387923298
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jul 2021 00:50:17 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 16T7oDnL027516; Thu, 29 Jul 2021 16:50:13 +0900
X-Iguazu-Qid: 34trjo5NuVc3RVauau
X-Iguazu-QSIG: v=2; s=0; t=1627545013; q=34trjo5NuVc3RVauau; m=/AsdTRdiTBAC9U90jnl2hqJXZmNCe1tJP4kW+np8bsU=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 16T7oCgG031704
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Jul 2021 16:50:13 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id E36A2100110
	for <cip-dev@lists.cip-project.org>; Thu, 29 Jul 2021 16:50:12 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 16T7oCNo003251
	for <cip-dev@lists.cip-project.org>; Thu, 29 Jul 2021 16:50:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnkPv+zPRJd0e6m7Ndrf5TM1XnELMDB08O7JepOxyC1BWAEWbb5NlqT7APm0JBELT7lImz0URiDEOBK6RGp9HdQaQraQdzz8+GHjxY8vRFKrSijJY+z6mm2MNDrT58kgP0kLT/TMQm0i7XuJerLlI3tlKO7KbHnB0j5ThI5i2L2FH/zJR59cgocNFPad8a6qJzmSFPcb+HH8kxMdXyKOUA2/7ZfDT4gxkPf63ak4mHzCpLTyVkd3muCxZHPiANczHhQot4OJ/Kt6V3QOrm3T797K/xMKzOdzKeTAs+6sXFxqCnDbu8fcUak3k1H5cfDZjR/az397N792LnLP26QSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0Zp+YS7Be222Oj7f32ONsZq6Mu+lFIALQDdqsfE3to=;
 b=WMQjDpY0FyoWJyV1hjtMZf4lu98OHtW71qlAMlh3ViFMLW4Y+mihvOkQtGaQLiGfFAfZFks6KtCghh40Ro/8KQby3XzPZAD9De/3p2E/Td1ydkmnOKODCwlTpLueOOJ6cwKYOFZlPcV4Qrye+H6lDchc9H5TS61qIdmu0e9aZSjkhMLz54ZKYVinTR8o+ybYCr2RAjxYdaZDTZwItp+S8Xn2OGoSpO2GlXA3iio4GMf79Ci6GvBewMdnd7+9TioS0pXVutuONs7SI21sCVbE3iQ/kNV+/J+/ja/MS4L7rTwfVAoKYftI0hyohVGKNi+VceG1ktSHDegjuMz1Ls1Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entries this week
Thread-Topic: [cip-dev] New CVE entries this week
Thread-Index: AQHXhBfg3mxbHrxKVkuPVe5kCp43OqtZfDqA
Date: Thu, 29 Jul 2021 07:50:07 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252DB5C0B863E4028766A2692EB9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
In-Reply-To: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58d23c47-e84e-47ee-0d95-08d952657c39
x-ms-traffictypediagnostic: TYCPR01MB6897:
x-microsoft-antispam-prvs: <TYCPR01MB6897EEFC2E8BE8B950C0377E92EB9@TYCPR01MB6897.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: HgazsCHO8tdtySQAnQFOESI4mipBNPyT9VjtiUoQ5eGWdTYim5ye7dQhgRp4D22xvFN3zlUfsT75nPaTjVv3E3T5XaJuSTKda1JSUtuiFZYl2MtgiioG2cu6ro70Qg1OHIE5AnX4VQCOAzeCUA6Yc+TUnkziFVO6oL08puiJPjztoq6s5D1V+A+f8s5PZfPWfG87FrluYyc1HtVZHdK0M3dJIBaWUvtqBIOtH6bvGfs9i96lQaxLS0F3/8WyDL4bpvIW+PldQzoAOyfvXxINq78uNmWDrKfAOdALM8vftIKnmPOpWZx9/HkyfMgtIeMVWe99t4Biu27Qzk7YeqtdmbL+VrjwoxHFM4v8WHvWNA1J1pXICKDlytD+/tTda9QFTyU91fIuQqtTxPj2qTH2GDPKOqB1e6QmqLCmqky7uRivJ/EOanSk+6h26ocT4qBckITgXCAkMSsmrUzJBGD9T3uSnAhQyIjWRKw1eCNV0oDB5lSQ/GIic8nd6eFsQGMGy/p3vtOLUDWHd+ZgA/RtfmbkALCA6efA8ZSehEwUB+agZFw0YQAeUOfYa7Jvmbb7pzttRkBi6+B7Mi39oiwR6YsbhHv3q6G5Ms0J3CGnJhGERBuwtTdm9cLGf1/qBbJYU78T63e5FRu5XC9rXo799Vk60rLiFGc46uqgMz/agCqWclJliGg2GSoMErZvPWfkxCbYOa5Yxoaun7JKN6z7A4BXD+xXLRCG9WN05ikqQcKB9i02r2CtOslolHGc00NxeYFiiaA7jMs7Efv/MIJCx0AOlU6EJDxhKTFl9+c0i7k=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNXOU5kZU5FMkgxV0VrVVU0YXljZFdqZHp6YXA1bFhzK0kyTWwvODlxUkhV?=
 =?utf-8?B?SDVHMlVKMXlNYmUwcWw0SjlXUVNSNDVrRGdaaTJJbTllclM4NGtHMkExcXlM?=
 =?utf-8?B?V0dPWTM4RDRlTy9EMXF3VEJyQlRjTEo1K2tONmpadFA1NjhERGtNUVdjQm9l?=
 =?utf-8?B?anEzNXMzcjNYMGZjaXQ2eTQ3djRIcU5OWDdNZUwvNzVlLzlxYkorMFEwVWNC?=
 =?utf-8?B?azZJb1dIQk0yVjgzYzFPWXQ5L2creDdwV2h0OTFtWUR3YkkzcFNMZVJXTXlz?=
 =?utf-8?B?cUQrazArQnRxNWpRRHNISGZTNCs0Y1lqNXcrQkpoRHZlQSs3aFdEMWthYVdU?=
 =?utf-8?B?Yi9WZWJmTFVURklmNTJFSGR3OUFoZUFUK0duY3AvZEQ1VUJqS3d5elZ2Y1ow?=
 =?utf-8?B?SGJ2WkRROXdEVEE2d1FJWWhkcHdUalZaWEtMZnFMWlMva3lORGdMMVQxZ21K?=
 =?utf-8?B?eTZyelpGZFRGU0xoUlNKWEdEamlyUnZzakptdENzakNQQWJWbU9wTE5zSU5P?=
 =?utf-8?B?TmNzQnZtSnRpT3BlSFJkVUoxcWphU0RqOU85OW5ZakQrLy9jN2FiY0VkNHVK?=
 =?utf-8?B?dkt1OFBQd3VuZjhKNzRjYi8yU1AzNUZjcXVxVTNhblZqU3hiUHBYYml3aVFh?=
 =?utf-8?B?SFhiTlVzWFNQRHJSU0d3RkJ6RGc0bHdSRVlvZk5kUEdzQ0w4NXQwOEM0Ty9O?=
 =?utf-8?B?anp0ZXZHTU4rTitYZnY5UDdZZWlxYlByVzFHV2hieTFnVEFTaHRCQVY2bVBV?=
 =?utf-8?B?aDE0ZTNrd2Yxem5JNzBvSHloL09KRXRYY3RHZWVKNE41R3EwUGhLbDRKbVV6?=
 =?utf-8?B?a25kdXlNM05ZY3VQNUtXbmhHc2xoNUIrWERYWERFc1dIYkNDZGt3aTZIUVZl?=
 =?utf-8?B?Uy9CR2hYMnlKSk9RL0hGck1TeTRidVNweVdBWktZdktFamZsZEE3VzZmZGVV?=
 =?utf-8?B?eVNoYkVNR2llaVBYUE82WGpRaW1icG9Pa05XRVprWXpiUVJoNVhrajRPTHZM?=
 =?utf-8?B?ZnFBYVJjSEQ0RFRReFp0N2xlclNSSVNjT0pIOGJvVUczN1FZZ0dycncvRWxV?=
 =?utf-8?B?RitLWnZOQVp2SU9yTFBoRmhoYWwxVzFpZVlnMS9Oc2hXWWlYOUFiQzh6M1V3?=
 =?utf-8?B?VE1BcUNxOUpmeVFBWFdiRDMxYjE4WU16ZHNtdmFzVmZRZEY1Q2NYdHBndlR0?=
 =?utf-8?B?a0NMVHVKdzRWY2FWYU9rdDRmb1NDZ3V4UUdhNnFlaS9CVno0cmNFSXFGWW8y?=
 =?utf-8?B?RjhPWGFPcU9kUVd5cTIrN1BPM3prMjBvb0hBUkhhR1d0bkdJWmRvQThzeTNH?=
 =?utf-8?B?Nkc5b0lKQ1kyQmRsaHJqRWhJdkZGOTV2N0I3dC9hZDlaejRSSTFNZlpnNVpa?=
 =?utf-8?B?b29aVUtoSWNtbG1OcE10V1dPdld3WXoxaldRWjJITyt0OTFld1d1SjVVcHFD?=
 =?utf-8?B?TlBnZFBIN2NTR3ZQdUxWZkJ2QnpoSFN6VEc5aDFsTnNpbE85M2wwS0Z0a3Iw?=
 =?utf-8?B?RXVVd0JxL2FjNUFCSEsvWEIweU5rQ0xmYkNSSnJ2bFpTODZwQnRVM2pnZU5u?=
 =?utf-8?B?R1gxbE5tUi91MzVNZXNQaUJJakJKNSt3Ly9zaG9uNlBQcWlCTXJPM0xRK1NR?=
 =?utf-8?B?OHZ5NUZxKzNUUHVmdVYzb2F1c2tBeWpqVk1Ea1o2VkxNUFFMYkRZbnB2dUw4?=
 =?utf-8?B?SGZjV1FFM2NGc1E5L095aitlejdkV2doK2FWMk56bjhWam5oZURFd2V3ZEc3?=
 =?utf-8?Q?3Uv/UiaPrjXUXb5Ttk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d23c47-e84e-47ee-0d95-08d952657c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 07:50:07.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IFXfa2ljimmr+cetRh/HaOdWedv6TIQpCILGAroIrC++hAW8f4VdG4mvps+u3KX1LHmCbRYoNq8R3N5lrVMnPpsPsB6IrNCCjdCPi4jFvvclFjSxtAAp7mXQC38Fh+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6897
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7ZI6eWK9kbhZD15RULxq7a96x4520388AA=
Content-Type: multipart/mixed; boundary="4G5JGZBLe08baPt2dQDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627545018;
 bh=9aDcjGHyCmw0zyAtBMK8NDRVyK1g7PoOsQby3CB/1ME=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BCIFaQBFEVPWpiXKh1aNVqlP6bYwFQy9AoECtW9L5yoFBeRskF63niWVTrOYaAG71XS
 loJHEgl94IS+vGslhxyG0CCEz1RQhZHlUuGtemhMEln2Y3l/UhfW1mIoUqYVkx8iPBxx3
 TN49SKMX32u27LlJKnMtpRFpkOjmsGmdn68=

--4G5JGZBLe08baPt2dQDQ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIOW4guW3neato+e+jg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyOSwgMjAy
MSAxMDoxOSBBTQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBOZXcgQ1ZFIGVudHJpZXMgdGhpcyB3ZWVrDQo+IA0KPiBI
aSAhDQo+IA0KPiBIZXJlIGlzIHRoaXMgd2VlaydzIENWRSByZXBvcnQuDQo+IA0KPiAqIENWRSBz
aG9ydCBzdW1tYXJ5DQo+IA0KPiAqKiBOZXcgQ1ZFcw0KPiANCj4gQ1ZFLTIwMjEtMzY0MDogdGhl
cmUgaXMgbm8gZml4ZWQgaW5mb3JtYXRpb24gYXMgb2YgMjAyMS8wNy8yOS4NCj4gDQo+IENWRS0y
MDIxLTM3NTc2OiBtYWlubGluZSBhbmQgc3RhYmxlIGtlcm5lbHMgYXJlIGZpeGVkLiBUaGlzIENW
RSBvbmx5DQo+IGFmZmVjdHMgcG93ZXJwYyBhcmNoaXRlY3R1cmUuDQo+IA0KPiAqKiBVcGRhdGVk
IENWRXMNCj4gDQo+IENWRS0yMDIxLTMxODI5OiBJIGZpeGVkIHdyb25nIHNlY3VyaXR5IGluZm9y
bWF0aW9uLg0KPiANCj4gQ1ZFLTIwMjEtMjI1NDM6IGFkZGVkIHN0YWJsZS80LjE5IGZpeGVkIGNv
bW1pdC4NCj4gDQo+ICoqIFRyYWtpbmcgQ1ZFcw0KPiANCj4gQ1ZFLTIwMjEtMjkyNTY6IG5vdCBm
aWV4ZCBpbiBtYWlubGluZSB5ZXQNCj4gDQo+IENWRS0yMDIxLTMxNjE1OiBub3QgZmlleGQgaW4g
bWFpbmxpbmUgeWV0DQo+IA0KPiBDVkUtMjAyMS0yMTc4MTogdjQuNCBpcyBub3QgZml4ZWQgYXMg
b2YgMjAyMS8wNy8yOQ0KPiANCj4gQ1ZFLTIwMjEtMzY1NTogdjQuNCBpcyBub3QgZml4ZWQgYXMg
b2YgMjAyMS8wNy8yOQ0KDQpUaGlzIGhhcyBiZWVuIGZpeGVkIHdpdGggdGhlIGZvbGxvd2luZyBj
b21taXQuDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9z
dGFibGUvbGludXguZ2l0L2NvbW1pdC8/aD1saW51eC00LjQueSZpZD00OGNkMDM1Y2FkNWI1ZmFk
MDY0OGFhODI5NGM0MjIzYmVkYjE2NmRkDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


--4G5JGZBLe08baPt2dQDQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6640): https://lists.cip-project.org/g/cip-dev/message=
/6640
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4G5JGZBLe08baPt2dQDQ--
