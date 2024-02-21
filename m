Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E9C48BF6
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:07 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.85])
 by mx.groups.io with SMTP id smtpd.web10.9328.1708506964092766313
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:16:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V4qTWSaF;
 spf=pass (domain: siemens.com, ip: 40.107.14.85, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee7gbIrqku6z1ZGw6+IOO6kG7ekr52C1f+Bqu0rEyR1gEVUDFkHjZdA08ikapsBHKWIgX3QVf5p4zgd2dwDIkx3Gzi0zmhpeFIukU4sSOdQr+Zuujp+bnXiRpza1Yj5NMJpFIlQM1fqIaeDNOyFBH6nxtwCBb+TA6cjQd2XE6gb6nrBg8AnYewl+LKEAUFiqtU5VjDUahJoY9I75fPk69Dl9pZf0lvYM5+LDJhI0oTfLWAjDP1Z3jZ04MH7vajxMV2HAKhv6d6zRvvPq3W3BqhTyD5xz9y/a1ApEzwtOcXcgrzP2vwiWI2h1PPyWMnNAZGjJFZfz+jtGtEcCXznESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnfSF8jjihTVFMI+vgIu185UPE9Shnfx9LJxHOR69Jw=;
 b=lYghUVC5s/9EmrJvrVqgtiwAzbUzt7PwVh64CGJZ6BGw2tNzhbV3soNRIia6Vh3/Eanos6TpCO4ftsEXGxREp9DasShQylmKceIKEtjJafiL3yMcfbz2aCCsiTfjkCaXaprKmPTjjxJ1Iw2UrCfonVg5MkRFiTXPDTTCBni/rX6HMoNStijPgck6csywa1+byz7OtgVmfMPltey3dWORYQqeGAAlqj/qyQefR0yBMEY3L+CdELiIRYOxsJBzatobc8htX6II3KURq47Va1FGhgZuQM1R+Ur6TGqgES10hmLvGvekc/gsEIM5h0X9FyXqiqW29WyotTWj505KaEkNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnfSF8jjihTVFMI+vgIu185UPE9Shnfx9LJxHOR69Jw=;
 b=V4qTWSaFBDHcPQyQp+LSHVUEA+GReLTc5hVADJs6djBWnH+mEb82B+906pH2NtzmcK2eYRAqFBiqaVgmsmPZ5BccpGX/9zveFxiz5DW3QR3ZIJztQgn88EN/S3+xlDvQylbl5cf3B3Ynk2pGl8kbDX7npSnlXkeTL3CHil+8Xut1NZl3JzchviZgZdj8m72Gd+x/KI2UhsUi7MuSRPtCtNGjCz5iz+z02eLcKAZGH8s5Mhh/w9XguY/fIV43zdfk+lHyJadmuiNyD7J+mZnyFpMoLX/Lhwg23dharU9Q3qkiw8hLa5JzYfLYct8hGtO1RFdw8D4WHW3jPF1eMXcMpQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 09:16:00 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:16:00 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Mou, ChengShu(Ben)" <Chengshu.Mou@siemens.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare boolean variables
Thread-Topic: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare
 boolean variables
Thread-Index: AQHaZKRpHFe3Wqv5KEyD9nUEyDigarEUgZUAgAACTIA=
Date: Wed, 21 Feb 2024 09:16:00 +0000
Message-ID: <bc54041633fcd6f6c1da7387756fb10fbdf25415.camel@siemens.com>
References: <20240221090005.54520-1-felix.moessbauer@siemens.com>
	 <a08892a0-3b69-4fd2-8b01-6b37bc491c7c@siemens.com>
In-Reply-To: <a08892a0-3b69-4fd2-8b01-6b37bc491c7c@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB5PR10MB7776:EE_
x-ms-office365-filtering-correlation-id: 25c01b67-86c1-4f31-db7b-08dc32bdb89f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X03cCvM/sIk3ctItg4tD14Hjefd4q6er/loQI83br7fqpV1y3B+HJmInAXU8GUjWrQGRQS1GFuQt+p7w7ZqNktefssnWNimZsR3/OgY7xVWxtpG6zinydDirGMisn6a42SEp3C4bbdwda9jhc8CMv87LvxTu8DG7bdY98BBXhBNo2mAi9Z6fVJcLhN0Pyrja6IKXQYbOBLkxyNW7gfn1FZzdsrelJyp5OwC688Jt5MORr9h9t+T/ZCMgDpq+0KiwHFs3QkvcwCOBbTeuxjNoLXqDF4tJycfjt3Pp++Iw/AedPGiFDYVtVfeGIAfu8fGeyFV069MD3q/sd9UIQUOAMiK9tyBwnOgN75QPE+MaqgYhrwKB6lK3BNijqvVjywLvMVvCcp1JdZSkXWc0ebUFCN5M0cbJF1hsbtWCCF5GBbtGDB2ARFwC4o54I2RESsy9quk39j6/y8jHsZnmvNyM5AZ1AYKZDIv067JZNYQ7uyVFNNOt83A/sX5bNKPRtcAXqMz8HhqhATJhbNBYiYR65XmjhuRkK6gHnU0zGW+r4DIJ1xf+9gPM31uvXmpGlTavI0xpe44oFWRRkEpywbxysAIh97JmvwQ6BJqId2ZpCU1IxFBTdliXvUwJzI0laC1r
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q0FkY0FmWWFvdVprNG1xd0NzK2JkTHh6YXpoQlRaVmlEYXoyS3BCWjZ0Q3Ji?=
 =?utf-8?B?aUl2N2tycENyei8rUHBabTVNYU1hNjZxMHM4cDgxd0ZnWDV4eXNxMUZhTk1o?=
 =?utf-8?B?MGxZbWV4TnZQcEh3WUl6K0lxN0RCM0tnWGJ6dlF1dVRqM2ozVUZiRWtxekQ4?=
 =?utf-8?B?elRKRnZuS1NJWmZyN043dy9GNUhyNEcvd1hxc2tFNlBwR0p4WlhmMFlFVmpk?=
 =?utf-8?B?ZnNEbUNpR2ZNS25NSHVJMmJ6NzU4OHFDZkJ3OEhnM1dxdVlBTzFkbVZXRkdk?=
 =?utf-8?B?dTYxMENIUHhwVnFwdk40NWpzRXlxTGVnaVNaUkxsQ1JxSjdLY1VocmJGdnZE?=
 =?utf-8?B?NE90TnNWRlJWN2loYnRIL3JoYWR0M1JPQlJzd21LeXU0cGRaVnhuZ3JHY2t0?=
 =?utf-8?B?YmFZdUgvZzRzRU9DZ3R1bE9ZdlQwWk0yVHpGTi9xMjIweU52VlQ0YTdLZkJN?=
 =?utf-8?B?S1dCZ2FXMzE2TDdtbUVubGFIMk0vdHl1c2xKSmNFZlZ0anRQVDlrTDJzb09r?=
 =?utf-8?B?ME9BSC9QdkIxdDZoTE1sRVAyVndEenBXVCt2ckJpRTBXbllRYnJoYVQzSzlJ?=
 =?utf-8?B?ZFUzYlhXL0c2eXcxb284MzFsMUJGeVpIWUtFMGFURFlWUCtpNk5IQitRT05x?=
 =?utf-8?B?SUpIYkRibytJNThjOFFaT1lKSzFmZ2IyNVhZc2FxcTREK2J6OTVXaWpYNTRu?=
 =?utf-8?B?c2E3R010VlhpL2lPQkpNSnJiRDlRWitxemMvZjdGd2Q5UU4yaS9SNlp2enho?=
 =?utf-8?B?YmE5dzl0WnpzUHNUMFU1ejNIY0NLanBwT0F0Tzd0ZFZKcitkdkZJbU91cW5I?=
 =?utf-8?B?dTFPMFF1N3BjTHFNZHhpdDlLNXk1NHNUSld3MWsxazhCUy8rWm1hcURTeVEx?=
 =?utf-8?B?U0c4UjZyNGdvZTEzV2pad1JibkZLQkR6bGNKNXdUc0ZtSndJQTh2d1RwS1lW?=
 =?utf-8?B?YlhCRWsyVEFOelJTT2NsZ2NKRFFYaHdxZWdQaWxSMWRoMlEvSWJqZHBhRzVm?=
 =?utf-8?B?TWNLVG1uUXNPQU5mZ0dUVFhEUVdwWW0xMDVuNVltRHplWS90Sm41RnVMMDZK?=
 =?utf-8?B?NHUwMTgvOHBqSG9Vem5vMVpQT3A0RWFzNGVWRHhZZ3NuZTUwRzdCK0VsYnFq?=
 =?utf-8?B?ajNLc3g3Z1Y5Wmc2WVZsZWJJeVVYcmJxd0cyRk9Qc2JZY3REWlNiWE92UElr?=
 =?utf-8?B?dU5ueHA3RzUvakV5VkZ2MXNOZEpSV1BuMmxWZFpNZEoxa04xQ3BESHF6Z2ZH?=
 =?utf-8?B?eE9nRzdyb0k5MUZYSE1WL3dTWVdORGpDeEF4WFlXYTFjNmgyL1JjTG9EU1VG?=
 =?utf-8?B?QnlMcmluK1RSMTBMbjJXRm1od0JXWDIvR3ZISDEwSFZvb0k1d0hnTGJCSEtm?=
 =?utf-8?B?K0E1Wk8ySmM3RHlNMjNhNWVRYTlPNDdDeDF4WjFtdllKOXdRYTdCc0VxaTVM?=
 =?utf-8?B?T292QVowNUF6TE1uTWY0aXZMKzFERUdOaWNFSVVuN1Z0UU83RzU1MmFzVWhQ?=
 =?utf-8?B?eGpCRUdPaW93YWEyQVRxODhTOGU3NUMyYmhrZHRsNThGOFlHTXZqY0F4aG1x?=
 =?utf-8?B?Mmo2V3ZCNkdNd2JrWUJSWHBhMlNSR3MxbkEvZnkyeEE3V0c3U3JIT1lLbTdF?=
 =?utf-8?B?V21qcWFGK2Y1Sk1ZSGoweXlaY2p6eWlCRndpSnU5bVBwQ25iVnZhWWwzeXZ6?=
 =?utf-8?B?Yk93WjVyNHVEck1SaWFWdEhraUIxS1NoSVpEeWZrWGtqeXFrcGNtSDc0YTli?=
 =?utf-8?B?VndMZENVZGdPandCTDk0SkY0NGFadTJZRDE5TDV6Rm8zSSszZ2Z4akY0aE9n?=
 =?utf-8?B?Um9TQm5vb3hiTm5qak5DRVlTNC8zYlVpVlRyK0dIWm9oZXZsdDNHdktvZ2wr?=
 =?utf-8?B?MEFsWUZzQXRwNlBoREcvTUFEWmRkREw1cE9JbUdLNFI4NG43NWNGMGk4Sndx?=
 =?utf-8?B?WUw3UFUyNFIvNVQ0Z2VYSWhIL2gwRHJWSFJrejB4SWdCUGhkNU1LVkNYSXFP?=
 =?utf-8?B?Z1U4ak5BeXhKOWpmbFIweW5kYnNrZVFmSnNvSTkvMVgxRGZrUHBYNW9ReXJx?=
 =?utf-8?B?WkhyME5lZzN3Wlg1QThpclhkRFZpUktyWDdJRkJlTnYrZld6OTZadWVYWVFW?=
 =?utf-8?B?OTJZcC9EcHZXWGFVcnloaEhYSDFtdVJ1STNYWmxERDd0V0lBZHBLNmdKV09P?=
 =?utf-8?B?c1RBNGwrS2k1TGVIOEdhZ1RWMjZWTElhZW9BbFRiZWZyM2VXVlVZTE1BNkNU?=
 =?utf-8?Q?bEHtC64z6X4uUWTSt5ZXmw1JPf+7IQ7hMzw6OgHapQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c01b67-86c1-4f31-db7b-08dc32bdb89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:16:00.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MTkKJZh2ue0hKuENTB/JCj7WTqIaT2ZSrTlF6tge7iWubJK9ma4ycp4Qf14V1bg3VXXUwPHiFYblG7lwTnYeuF6jBx54VWmix7FZcIymC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE47F58A0A24EC4A8C82E2BD4822B4CA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15050

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEwOjA3ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMS4wMi4yNCAxMDowMCwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBXaGVuIGNoZWNr
aW5nIGlmIGJvb2xlYW4gd2FyaWFibGVzIGFyZSBlbmFibGVkIC8gZGlzYWJsZWQsIGENCj4gPiBj
b21wYXJpc29uDQo+IA0KPiB2YXJpYWJsZXMgLSBubyB3YXIsIHBsZWFzZS4gQ2FuIGZpeCB1cCBv
biBtZXJnZS4NCj4gDQo+ID4gYWdhaW5zdCAiMCIgb3IgIjEiIGlzIGVycm9yIHByb25lLCBhcyBh
IHVzZXIgbWlnaHQgdXNlIG90aGVyIHZhbHVlcw0KPiA+IGxpa2UNCj4gPiAiVHJ1ZSIgdG8gZW5h
YmxlIGl0LiBGb3IgdGhhdCwgYml0YmFrZSBvZmZlcnMgdGhlIHRvX2Jvb2xlYW4uDQo+ID4gDQo+
ID4gUmVwb3J0ZWQtYnk6IENoZW5nIHNodSBNb3UgPGNoZW5nc2h1Lm1vdUBzaWVtZW5zLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNp
ZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRl
LmluYyB8IDQgKystLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRl
L3N3dXBkYXRlLmluYyBiL3JlY2lwZXMtDQo+ID4gY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMN
Cj4gPiBpbmRleCBjYjE3MTZiLi43YTQyMTRmIDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtY29y
ZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMNCj4gPiArKysgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUv
c3d1cGRhdGUuaW5jDQo+ID4gQEAgLTIzLDcgKzIzLDcgQEAgZGVmIGdldF9ib290bG9hZGVyX2Rl
cGVuZGVuY2llcyhkKToNCj4gPiDCoMKgwqDCoCBpZiBib290bG9hZGVyID09ICJlZmlib290Z3Vh
cmQiOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuICJsaWJlYmdlbnYtZGV2Ig0KPiA+IMKg
wqDCoMKgIGlmIGJvb3Rsb2FkZXIgPT0gInUtYm9vdCI6DQo+ID4gLcKgwqDCoMKgwqDCoMKgIGlm
IGQuZ2V0VmFyKCJVX0JPT1RfQ09ORklHX1BBQ0tBR0UiKSA9PSAiMSI6DQo+ID4gK8KgwqDCoMKg
wqDCoMKgIGlmIGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRWYXIoIlVfQk9PVF9DT05GSUdfUEFD
S0FHRSIpKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuICJsaWJ1Ym9vdGVu
diB1LWJvb3Qte30tDQo+ID4gY29uZmlnIi5mb3JtYXQoZC5nZXRWYXIoIk1BQ0hJTkUiKSkNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAibGlidWJvb3RlbnYiDQo+ID4gQEAgLTMyLDcgKzMyLDcgQEAgZGVmIGdldF9ib290bG9h
ZGVyX2RlcGVuZGVuY2llcyhkKToNCj4gPiDCoERFUEVORFMgKz0gIiR7QGdldF9ib290bG9hZGVy
X2RlcGVuZGVuY2llcyhkKX0iDQo+ID4gwqBERVBFTkRTICs9ICIke0BiYi51dGlscy5jb250YWlu
cygnREVCX0JVSUxEX1BST0ZJTEVTJywgJ210ZCcsDQo+ID4gJ210ZC11dGlscycsICcnLCBkKX0i
DQo+ID4gwqANCj4gPiAtREVCX0JVSUxEX1BST0ZJTEVTICs9ICIke0AncGtnLnN3dXBkYXRlLm5v
c2lnbmluZycgaWYgbm90DQo+ID4gZC5nZXRWYXIoJ1NXVV9TSUdORUQnKSA9PSAnMScgZWxzZSAn
J30iDQo+ID4gK0RFQl9CVUlMRF9QUk9GSUxFUyArPSAiJHtAJ3BrZy5zd3VwZGF0ZS5ub3NpZ25p
bmcnIGlmIG5vdA0KPiA+IGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRWYXIoJ1NXVV9TSUdORUQn
KSkgZWxzZSAnJ30iDQo+ID4gwqANCj4gPiDCoCMgZGVhY3RpdmF0ZSBoYXJkd2FyZSBjb21wYWJp
bGl0eSBmb3Igc2ltcGxlIGEvYiByb290ZnMgdXBkYXRlDQo+ID4gwqBERUJfQlVJTERfUFJPRklM
RVMgKz0gInBrZy5zd3VwZGF0ZS5ub2h3Y29tcGF0Ig0KPiANCj4gQXJlIHRoZXNlIHRoZSBvbmx5
IGNhc2VzIHdlIGhhdmUgYm9vbGVhbi1saWtlIHZhcmlhYmxlcyBpbiBpc2FyLWNpcC0NCj4gY29y
ZT8NCg0KUHJvYmFibHkgeWVzLiBJIGdyZXBwZWQgd2l0aCAnPT0gIjAiJyBhbmQgJz09ICIxIicg
YW5kIG9ubHkgZm91bmQNCnRoZXNlLg0KDQpGZWxpeA0KDQo+IA0KPiBKYW4NCj4gDQoNCi0tIA0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

