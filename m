Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE33E7717F
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 01:38:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.1159.1733881105323992504
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 17:38:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=TDEgp/J8;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733881091;x=1735090691;bh=DrA6mHhYGGkcFbdJmpws6VJbbxbO06VQ7JmFyKC
	wJT4=;b=TDEgp/J8sPxHBu3YgJrNsSEU+OeJT3lMYKnbKP50lzMEpUH8pDgb9k6gpWuI1v0bI9yiO
	7SuxS+tTL6m13Ei8Yd7Ie7SXFJFTw++HuXj8uUa4PnBJy76dG1H4o9Gc0Q1ku9QqybdeoUqwoKWZx
	jU9ej16j1RbCOTCPLr3FURMYMUgDr3I/mbmz6NyyPL4/ZIRb4ciDf5lSJnKa9yESWx5urfkACpnqm
	aXPAMA9qhZsFWL29I6gvAPxSb38vAIZCrjN6dwr/5Szx/ezcXcUjX6VzEJfAmumWTXzUZS74fzHE6
	WoT1DLu5xoyxslOgXoAgmVazRYY544rcMgU5RhyiwQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4BB1cBWh1400487; Wed, 11 Dec 2024 10:38:11 +0900
X-Iguazu-Qid: 2yAbaKzOe9mvbQa9Ni
X-Iguazu-QSIG: v=2; s=0; t=1733881090; q=2yAbaKzOe9mvbQa9Ni; m=VWeR/gGEmn5ZM/6vNoj5JN4KM3QQ1/WYdflc54lQCEE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 4BB1cAqT2629817
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 10:38:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3RD7RMaP7Pn6R7+m44JRlvyxpWxpEp4ii00/PprDO9gwGtcpJRJfdG2lnIARMfHJn1RgcB7O2GqLMTntey3v04HbhnOZtg+ubD6XcpdCx5FIcZmKbSvCOWOB1MENHEUuTiJFKmroqE+UcykSnf5f02BonjiLRbKmNaj/6D95su9zdM6K2tM22Ryq07nC0CWtnQ8tr9eBOmztQh7SX/mk5kQMHBALKwr7OftdglaJvUahoq55WYV9zMVF/xGZ6H59jm6Q0YjQ+BACaIFzZjMZI/J82RpmW6xYJVIppLT/b78geYdzKLAdp6oVbPYUj92aMHtKckQ90QsbYVUKN29BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feuYyeMCQC2+1zT4kXb47QFLHYm8O5Kcr5EDcqB9L7M=;
 b=kxOeQD7W5fBlTPI0z0GDKsygQjAUCZq/jMQCWtM02OBZHisGjgok+iOqZ/62Jk8ZS1HYYv8lB+AV21eDNcvs7SDEjzaHK3JeqJqe7aDkQ0AnZqCT53od+rBZit9TJgisB0dXX6fb6FLmtyp6URchT0rWa1nZm1I45mG999ef2c2qOLPWIpUGEHjwmKXZPUnx8QQ1fIBjRSG0aRYo7swy6Xw4bOpE0opkc8r3uyYh6luAkTqDM7driNQiYCWAjXkatkuYe7rdq4V0/GBzgZBaLBCzH3Yv8kGd4BE9Jj3XHsC02be5n8doi8YIxUR1IcZf7Au2/H5PQM7oHayNs7LXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l-smarc-som:
 Enable 4-bit tx support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] arm64: dts: renesas:
 rzg2l-smarc-som: Enable 4-bit tx support
Thread-Index: AQHbSmOyEUAbX1knJECXZmOzXEpFtLLf2wSAgABqibA=
Date: Wed, 11 Dec 2024 01:38:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388C7C072C55EA78AADE357923E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241209175611.20172-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Z1iTW1Tao2v41eq7@duo.ucw.cz>
In-Reply-To: <Z1iTW1Tao2v41eq7@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9532:EE_
x-ms-office365-filtering-correlation-id: e8415a40-1b62-46cb-7464-08dd198476df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QXM4LzNoaVVuQzlqN0l3a29EU1hXbEhtK3hTSUxEakVnV3hRRmhCUXNx?=
 =?iso-2022-jp?B?NU9OQUZQd2RKS2hkb1ZWY3dRTlA5Q0hzQWpiNzRxSW45cXc3cXEvSVZh?=
 =?iso-2022-jp?B?OXBxZDlNUmRKdjdnc25FVmdPL2FzbmFPd3NsMGR6akdzMkRtVXViZ2g2?=
 =?iso-2022-jp?B?bWl3VFJYNm1xb3ZYVjFYaEVyZnRJdk5vcEhhWUVLUWwwYXNsZXZlb0RD?=
 =?iso-2022-jp?B?c1QrcFZjdFdjb3ovT2R0VXBMVlFpUWY3cXlLMURrc2xuUVJmMzY3S3dB?=
 =?iso-2022-jp?B?L1lXSi9pclc5UlI4bFNwYWdOY3g1VmJVQmc4M0NSVHZDT3dld3pwVkVE?=
 =?iso-2022-jp?B?Z3RURTcyR0pMSy9SQlJFbDRkYVRaZUYyTVNYRzNQQ0FWRm5mM1JQdWI3?=
 =?iso-2022-jp?B?NjJZUkRNOHh3dTZJWmY2SDloTU9BV3hXQmVZRER3NHdIZFFJVVMvYXh2?=
 =?iso-2022-jp?B?YUFuZURpcFRwWktiT0ROUDY0dStHRjFFRkFMbjhoQVFIVkNZeEVjWUVk?=
 =?iso-2022-jp?B?Rmh6bkpHSXUrUEUrdGNYWk80YUpmUGY3NTFxT3dEUDZFZEp4eUl6RW1p?=
 =?iso-2022-jp?B?aDRsdlI0a1lGL2VzWTkxODN1QWQrRlNvSWhPYWcvVyszd3NwM1dJMEM4?=
 =?iso-2022-jp?B?Yy9TY1VScXJXLzhkNU9lZysrNW1MMldxa0hzR0FlM2hGc1U4WDNxcU1H?=
 =?iso-2022-jp?B?KzZ2S04yUnFEaDd6Y3l4Q3I2MG4ra3gvQ1REd1R1MFRKSFlZV2kyWkJu?=
 =?iso-2022-jp?B?TE1VWStTMjVBanpMV2loc2V5ZlJubGVIUXE1WmtFYllka3hwcWVrbURE?=
 =?iso-2022-jp?B?ejRXWHNqbndYdW1WL1ZuZFV2NzJLV3RPRTRmQWdTZmo2c2ptOWNXb1pB?=
 =?iso-2022-jp?B?RDNteUdvWlNYdXRHOVRqZVRrU1QvQmJEV2hRa3c2TkJ3WW56Snl4Wm5M?=
 =?iso-2022-jp?B?UXA4MlRzODZxUlV2MDU0bjg5RFVBNmhrdlJKTzYvVFVkODR0Z2Z3aFY2?=
 =?iso-2022-jp?B?dnh5RXE2UUNTVEhNMTVwWEVPdVh1K1pOK2Izb1RUSkhjWjk2NmhMS2Jk?=
 =?iso-2022-jp?B?UEgycUljRVpVUFFUUXgwalNibGZLY1JEcmNJa2swQ0RPK0V0RDlSY2dS?=
 =?iso-2022-jp?B?b3IwRE5LTTBHa2FGLzVSU0JSMVJveUZmekZhV1FuRGx5d2xJUTNMZGFL?=
 =?iso-2022-jp?B?Y3BFYkc3bmRDOXhhaW84SVM5NENGdWVFaEU3TnVoZFVLc0lQczI2djhp?=
 =?iso-2022-jp?B?OC9EZWIzRzBzQmVpSEJac2tpVXdnWU55QUg3VTlhZkdkYzgzSUhuYjVm?=
 =?iso-2022-jp?B?QTJUZmpPNXRUdWFuNWYwa1JUNSt0V3NWb0NBRVFPTkZFU2NRNmNaOXJt?=
 =?iso-2022-jp?B?TEpScVYwZ28rVWpTbXRBSXJPT0VqaEppVC9PRElWSGlmWG9EZmN6RmxC?=
 =?iso-2022-jp?B?c0JoU1lwQnovV2hQSGlrWDlLL0orcXIvR21DczZuUU9pUkg5cUo3VGNp?=
 =?iso-2022-jp?B?WnRPcFlMb0VFOG50SXBscE1lK3VIUXcxM29EKzJUWFVSUWVMTllOSDg4?=
 =?iso-2022-jp?B?WVhjc25MQWt6Qmg5emNxdnQ4SG40TEJUc3psc0FnWUhYc2t1UHNiTUps?=
 =?iso-2022-jp?B?cy9LcTY3NzQvRklxblBZeXJ5ODVVaTNGTEhnSEppek9aYWlvSUxoOThm?=
 =?iso-2022-jp?B?YXVUa24ySU1oNzRnU0xuaGMwdW1tVXRQQUU4Q0lpV2pxUUdPSmttb0Vo?=
 =?iso-2022-jp?B?L0xrTmdVQVRQaEpkMExiV1p1TkU4YStkaUhscGlybTJsYjV2cXpxeldp?=
 =?iso-2022-jp?B?K25lQS9velYzMUhqMXU0VVBCdksyYml1VkJ3OUIwWW5GTlN2UlZmb0pF?=
 =?iso-2022-jp?B?RzVVVU5SRkRkV2xYZHR0aExHc1hNaFFSRTdIWWtCYVVWR0l1ZGlpMmhr?=
 =?iso-2022-jp?B?OEE3M2IrVDlYY0ZPbWlMSkhyYTlPTng3SE1aVk50d2IyMitjY1ovdGIv?=
 =?iso-2022-jp?B?c1RzK200dE5WNExSTXV4N2Y5dzBVMExUUkczVVZRQU0yVStCU096UTA5?=
 =?iso-2022-jp?B?QWoyR3d3c1RtSTJiQ3ZsS3lSQmwxdDQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YW5ENWdPSWxhU251UkplWlNqMGhrTEpSTFRrV3RmV3kwNHFOVVJTcnU5?=
 =?iso-2022-jp?B?VHpXWk5DWkxxdjFMUEsyaS9LU09FbUJoemVOS3k4dHg1TENVRWVnWUFE?=
 =?iso-2022-jp?B?aGJKWnZBT1hyM0Q4Y0JwQUt1VGgwT2NlUHRXSjc3S3FkcjNHNWVzdXBJ?=
 =?iso-2022-jp?B?UldzMWY4bEUzdnlwVy9BbVFZbkR5Q1FkL3kvZ3UwcVFOQ1pSeHliZkto?=
 =?iso-2022-jp?B?L1IvdjV2TGxKTmxmS3dpVE83QWVkSVVrdDZPMmpEQkcwRE4zNFJDRjlC?=
 =?iso-2022-jp?B?aW5kMVBCNHVLeWF0QnB0dGNtVjZCVUFDaFBpcEh0MG1wVUtueDd4LzhF?=
 =?iso-2022-jp?B?clo2elJORlNYQUREc2R3VUVIZldFTDVZSGlESENwenBsWWwxdUtPSUND?=
 =?iso-2022-jp?B?VHJSUjdUZ3BjUWM3b2tLbjlsUjVrekVDWTFaZkRyK0VKdWl3eVM0a1NR?=
 =?iso-2022-jp?B?QkhZL0FpbldnUUlUV3RhU2pUTExrOU1PZFhveWEydG5MSXF1N0tQRE5a?=
 =?iso-2022-jp?B?UnJZZE43L1VxNGEvdlVlaXp4L2VYaStkazJJUFo1VUkzLzB1MHQvVFlZ?=
 =?iso-2022-jp?B?MnlqTTFuYjBFVEJ6NnZiNzlBZzFvTllNMmVVYXc4THhzb1ozS3VxQjUz?=
 =?iso-2022-jp?B?MjhFWTlEZndQNmdGY2Rla2JIYVhKM241OFBndTdCNnY3ZWlsSlVIc2s1?=
 =?iso-2022-jp?B?K0hudk5YcjR4NU9CT0lhUjJxWGhSS21pVTZXelV6VjJYd0Y1UFdUVU1w?=
 =?iso-2022-jp?B?dEdYY1dJY1ZMSWkzQklrdUROa25DekR5T3VNWWpENjB3bDh3ZnFuVG45?=
 =?iso-2022-jp?B?ZGs5blBORG91WjhDRENnWVlpSVVTVzYxYklZSmpkZ0JPSXFEdnFlempo?=
 =?iso-2022-jp?B?QUhZWnFzdk81S0tpSzNrQ04yYytjOEFrYmZvNDk5cy8xTkNMVTFELzVX?=
 =?iso-2022-jp?B?MXA4OHh2T0IyUjcwWnQzQzl0NGh0UXN5dDcwK0RqLzVyK0s4STdVamRK?=
 =?iso-2022-jp?B?QkVCUnc2anFxOWRPTjZkTTZBNzloT1pSVUxGUVhyc1JUbnZBc2IrYmxo?=
 =?iso-2022-jp?B?MUlEcUw0VE9la3dmQjFBL2J4YzU2aTFwVmF6SXYyODYrU21zL2hHbFdO?=
 =?iso-2022-jp?B?SzBnb21wS3JPVGo0Ymt6M01Cbm1kdFlFNUs1Nm5FR3B5VWhOSWIzTGw0?=
 =?iso-2022-jp?B?MUQxWFBaWStuSitZS2tIYTJvc2hVUjlFaHNNYitNL3ZISXZoSXArMHhZ?=
 =?iso-2022-jp?B?SnVhdGY2aUtIbGF2aXdvNWNZTHFpZVhVZS9OQmlQblplRk9RUE0yTjdI?=
 =?iso-2022-jp?B?QW11Y3ZHZmF6cUhVZ1BxK3JQcjExL3N6TnByTzNLbjZieExYNzZFWFdm?=
 =?iso-2022-jp?B?cGdPK3A3NzFXamFFR2Y0bExsNU04WHZ0Z3JWUFp2UFhkL0hYaFFPNUJH?=
 =?iso-2022-jp?B?RXdMTGp1VEpQVTluNSt3dDFtQWlmU3lwZS9PTFc4S3RUb0VFYUhYSWNP?=
 =?iso-2022-jp?B?bGhjaTZzRDBYb09zZm5ucTBLMWJkSFBZMmdIbGVpSHJDdVBMOVFReFV2?=
 =?iso-2022-jp?B?ZzhJS1VGLzhiNlJrSkpsMEtqWnZxc0NscUQrc0s2ZTVzNWVTbFgvZllW?=
 =?iso-2022-jp?B?OW0zUUJzMHlyaWUvbjIwZnVpb3U2Njd2ZEtBcEIxT2hmSmRwSDJUcFp4?=
 =?iso-2022-jp?B?aFkrVlZzTEdZeEk0QW8vOENqRjVldUVTc1JjSFhpRDFhUWMzMmJqZy9L?=
 =?iso-2022-jp?B?bDFSNjlBSVVWSWhMS1czNzdJcHVHdmlOUUlaTkZ4SFFkYUF1dCtJZGwz?=
 =?iso-2022-jp?B?OHI5NkdNNnBFcTl5am1meEdXZGVsUDN5NUt3Y0c2SzRIRGsrdGZJRStT?=
 =?iso-2022-jp?B?MzFJcFFsRU05QXY1aUN1cXNvZVhUZm0yVjgrTm9wMTZnZFF4U0o0NElW?=
 =?iso-2022-jp?B?NjZYZnlPZ2JZWjgycjlxY2lBSlUreUQrVEpza1dRSGNvT3N6NHhGeXdK?=
 =?iso-2022-jp?B?ZFVPRjNudTkwK1V3MkF6N2JwajM4cjdOSlVNVlVCL0dZcUtDQ1NtZW9m?=
 =?iso-2022-jp?B?VTgrRGZ0NVlTT2p4R0FhSVNINk5Bc0lSclUwa2ErZkwvOWdLcWNVOWRX?=
 =?iso-2022-jp?B?dWFBVjZ5Wm5LTllnMTJsYTJHa2RaSXpxcy84cnRpTWhkUHdnaFl5bWQz?=
 =?iso-2022-jp?B?NGM0aWVUWVVWYjVrTnJmbE5HUVFuWHI1SzRTeVJLY2tRL3VMdndPNUw2?=
 =?iso-2022-jp?B?Sm1HYml0cENPZFpsWDNjVk5SUE1zZlBhT2pyZVN3dlV0QXd4OE41cEhm?=
 =?iso-2022-jp?B?eGthSlpBaEpOWlViRDVoNjBONDQxMytZMEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8415a40-1b62-46cb-7464-08dd198476df
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 01:38:07.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfGPMTBxE4vYx1pskJaNQFjh6p2JPdbP8lHDwSF8rioWNCFAMdTqrI7BCMVgu5LvtaWsCun0NbZXWTBIsPCnMT9d5WmBy8zBPWgO7sL7OiF/gbzPj+a/028xaI7jpXVl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9532
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 01:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17395

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, December 11, 2024 4:16 AM
> To: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] arm64: dts: renesas:
> rzg2l-smarc-som: Enable 4-bit tx support
>=20
> Hi!
>=20
> > commit ce3adea16612a677dd50bdad6861f37f5dc878c3 upstream.
> >
> > Enable 4-bit tx support for sbc node.
>=20
> Thank you, both 5.10 and 6.1 versions look ok to me.
>=20
Thanks for your reivew, I will merge this patch with your Signed-off tag.

Best regards,
  Nobuhiro


