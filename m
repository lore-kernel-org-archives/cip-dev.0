Return-Path: <SRS0=pyFb=E7=lists.cip-project.org=bounce+64572+5866+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A0BC5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:19:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC19B20B80
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KlOk9BJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC19B20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5866+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BLXVYY4521723xwGY5F6562F; Tue, 24 Nov 2020 22:19:45 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.3242.1606285183348585969
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 22:19:45 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0AP6JYnQ019906; Wed, 25 Nov 2020 15:19:34 +0900
X-Iguazu-Qid: 2wHHadmXOMqWqhgUJH
X-Iguazu-QSIG: v=2; s=0; t=1606285174; q=2wHHadmXOMqWqhgUJH; m=slOZcBuSjC7jwmhB6VMm+EXPrCsrJbbPqRdysUfmG20=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 0AP6JW8n012820;
	Wed, 25 Nov 2020 15:19:33 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0AP6JW6m002654;
	Wed, 25 Nov 2020 15:19:32 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0AP6JWM3018158;
	Wed, 25 Nov 2020 15:19:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyEkzLnAN3kB8JJV8jkujRZTuyyP1CRuiw66zpWIvU+VCz0DfqXDtNR4mZbXEhbiqBTbn43pYHr9s44L0vW+B63dQSgLEgYICqSb48NIU4zC0ftep7eT5GuERdOpttd7xD2XCp4mAyvqLVIxL8uniE3BhpLS87j90FOCPIvHt7gXOkmcfi01HmDPG4ST2kaK0UAego4DUdtgMusaJnkfbqoi6TG48+Vz21Nit20UsmhFFu/9ofBEkQx6DyuU4Q0fm6JSCHg7sKIN3g92arNPVwOedo72QsANXAdCMWTF2f0tbl5Ji7yxofXZI1obtRFGWPqbtIzySmgAgRn+RIcPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF1qZmJuVgbaaTtSdALAjB02o/JwkUVdWNnAdewr4So=;
 b=VyUtlozrMXXUlUTwr+lWb1NHI/sfMNYrRcbzNjGDh61plcxPafpuI0PPYEvibQIy45vd8QRcvW38Xadeyop8rPOjA+F1Mj9wFIsjHcoFjhoadxJj+JYiO/gY7slDmmRCjDd7sl+qpa5cs/uY545iLbK+V1gmn1SEHZWLzuj6aZ9k2ITCsQMGKss37eSbr5B4K2WLoJs+afYWabOCm0AEtU+7CL6IqnuJVsBujKnNYBV6pTeLCeV04+yVdbk3MOSuPZ+xYcba89Nn7yWUQPQBI86+Zb0rJGeYRqn5/SFOf5AjGWZp7lWE20PxrJ1xGDcoRCuAOHHuqJXLkhs9fnfdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add USB[2.0|3.0] support
Thread-Topic: [PATCH 4.4.y-cip 0/9] Add USB[2.0|3.0] support
Thread-Index: AQHWwoSb6z8oX35SFkS3lvdIxK/xE6nXpHSAgAC6MpA=
Date: Wed, 25 Nov 2020 06:19:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983B91B50B060127809013492FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
 <20201124190517.GB7488@duo.ucw.cz>
In-Reply-To: <20201124190517.GB7488@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75c2c528-afcf-4d51-7a08-08d8910a108d
x-ms-traffictypediagnostic: OSYPR01MB5446:
x-microsoft-antispam-prvs: <OSYPR01MB5446EF176DA60F25610B9B3392FA0@OSYPR01MB5446.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8d9jGFHPIz9fHSoVtROs4gq7yQXIRW9/ceNtu7YcieRxcZhqLLWxCWLs23GkbbVSNxkHcyAx6FCsgNk7+bH1tggGISXp4VYTdtzLxEWpfSoXwoMkNh28dUkhqdj6V1dfbkuCs9yU9UmRT21VAXswCFeycfOp+q9gxIQ/jmvY/zzHNselmcaTgz8oMARXxw/pcbHJJENq8n5NImKpV95cK0UJYhPi3+fb+Fsmd6E0cbAwmIsM9URMfhA6YLm/abDXpR8xxrxdvNXfCiv/ZKsTwZuyqccE19ZjGkj4IDz20/amJ965FT+l3IjvizGSNTpo+yS6TdjJIYtRnXPaMEzKbg==
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tnl6RFRwK2ZHRGgrTjhHUkRaakNYNXhwbER1MGF4ekFLY2gwWXNmdEtDWUM5?=
 =?utf-8?B?WmNOYlppSGRBNHBLSndpNmFqaWpRRmtRc1Y2d3JGUVNjSGFPKzF1b3JxaWhi?=
 =?utf-8?B?MUVDQmhWWXc4ZENsSElZZi81WURZU0E3YVVTcTFMZGtLZWJqS2RvblowQ2hU?=
 =?utf-8?B?dmZWNmdFeUgxZ2lGSWN2anFJRGpXK0syMXdvTm9BTngzU0NaNm1BZG9IQXZJ?=
 =?utf-8?B?S2p6WjZQM2g3YnN0S1g4aDQxUlhBbndrQzhQRXFTK3VmSndEQ2dNYzVEMS9C?=
 =?utf-8?B?QXhnVFErNWwxeFduRDFVSHZoVEI2ZHEzUkptM25kZzZ5OWNtVEorZ2NFSDRS?=
 =?utf-8?B?dVdPN0lwUW1wSEJNRWhCSERBUDQ5alAxbERDR2hLd000RXd2WUlpSVNCOTUr?=
 =?utf-8?B?VUtTMzBQRkJHOXNHK1lIVkNvbGhsdjBhZ0pHcnRrMU54U0h1N25mRVFCL3pk?=
 =?utf-8?B?WG9tVStIckFURWNXTkFOR3pNUWxyV0h2V0lzZnd4TWtScElUSXlqd2NLRFFJ?=
 =?utf-8?B?S0dZOU56czRwcHNWNzJtZ3JEMGtENXJWaG81TnJoc2xRcnEwSVRLdGdYblg3?=
 =?utf-8?B?YjNoTE1ObHlkM0FtbGxaQmpYNExnRnVrVE1FdGl3MkUzN1RXN3ZBZWlTVmZ5?=
 =?utf-8?B?MnFGNGFPTmZpdEFYaHlFUndzbHFQYXp3NDdxZG9rTndTY1B5ZDVmb1pUMlFV?=
 =?utf-8?B?SkJiT04vZWtnL0E2WFhUNTdGKzBsUmNlZ1BNaUNYOTFvWlE4MW5IaGI5aDdV?=
 =?utf-8?B?SXBUMm05KzdrdkQyb3FaOEt2UnkyRFBKM0haaEtkZHczUEx2enJrc0NGVHpa?=
 =?utf-8?B?NUtNVEtiUHVRY3ZnS3k5ZUd1eTFUU0ptRWxXMU80OC9Cb2FBWi95M3BGYU9o?=
 =?utf-8?B?dmdpUWNodUJneDkxcW5ackF2Vm5NZlNkNWRpaTlobElmdDYwTU1lR0RSdU9N?=
 =?utf-8?B?WHMyc01sZnZaRzBiVXFxT1N6QVY4YkJKbFBkUHNGVXh6NkJ6STNyRVpCNTlo?=
 =?utf-8?B?MDFmdW1mVkNqMk8wL3ZZdFBjQVhxYWxEUVAwL1lRYTcrYXFibjB0eW1UOGo0?=
 =?utf-8?B?aUR6cjM5T29yUnZMcW9RWDJRbVM2VjlGK1JxTTJnVmRNUkNLNDQ5NFh6WHU2?=
 =?utf-8?B?YzlVTHVRekJVb1MxUURweDE5Q2xLeFk0dlJpN1RodmJVc0RVVEZyc2pmL2RG?=
 =?utf-8?B?SzY1NUt6VUh1S3hMdnNZdVdTVUx0SzhTZUFiSmUrcW42M05mdEVEYU5pM2Rx?=
 =?utf-8?B?QWJJRjJSeGp4cDk3OVZRSzFEUFdrYU1KMkYvQ0trQk1FclRzbWFFcVh2eGJ2?=
 =?utf-8?Q?4ftmHmzMo/ym4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c2c528-afcf-4d51-7a08-08d8910a108d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:19:28.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBIu2GREoCLEGLnyWRkC7oz9qbmT5i2fv9AWux7SWxLeJpzHEpaK9/cehUtwWZHDvpP7yTgLQjYUsaTGVGnNACnNnzuir7Mf9tvFBdCAMFyGG+/3ZY7hHIlLTatRmgLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5446
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uqjMh6EAYUHr03ecsICwTruYx4520388AA=
Content-Type: multipart/mixed; boundary="o13qagPgXBPpvvIvy3G6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606285185;
 bh=rOOsT15N7ITuQGiB5pdrlA6m7sOjd+cJ+99DTrSm5wM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KlOk9BJkn62Rsddu9PhGYIxcai8+zAdmkAlonBVIgLk7JieP2+xD3OyKZMQR11x5tDW
 CY6MZ9owSCY+kbrd92enFE6WONtLIM0MgYXdMeJGPp8v5hhBN7mCZO6Ggn89jaANnnQws
 3DQUFMuaMzTXnskJi03VHndeTkt6vqplZ5I=

--o13qagPgXBPpvvIvy3G6
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNSwg
MjAyMCA0OjA1IEFNDQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o
5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdh
bWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IENocmlz
IFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+Ow0KPiBQcmFiaGFrYXIgTWFo
YWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA0LjQueS1jaXAgMC85XSBBZGQgVVNCWzIuMHwzLjBdIHN1cHBvcnQN
Cj4gDQo+IEhpIQ0KPiANCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIGFkZCBVU0IyLjAv
VVNCMy4wIHN1cHBvcnQgZm9yIGlXYXZlDQo+ID4gUlovRzFIIHBsYXRmb3JtLg0KPiA+DQo+ID4g
QWxsIHRoZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGFyZSBjaGVycnlwaWNrZWQgZnJvbSBtYWlu
bGluZSBhbmQNCj4gPiBpdCBpcyBiYXNlZCBsaW51eC00LjQueS1jaXAuDQo+IA0KPiBTZXJpZXMg
bG9va3Mgb2theSB0byBtZS4gSWYgdGhlcmUgYXJlIG5vIG90aGVyIGNvbW1lbnRzLCBJIGNhbiBh
cHBseQ0KPiBpdC4NCg0KTG9va3MgZ29vZCB0byBtZSB0b28sIEkgYXBwbGllZCBhbmQgcHVzaGVk
IHRoaXMgc2VyaWVzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--o13qagPgXBPpvvIvy3G6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5866): https://lists.cip-project.org/g/cip-dev/message=
/5866
Mute This Topic: https://lists.cip-project.org/mt/78481722/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--o13qagPgXBPpvvIvy3G6--
