Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8CCE79AE
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 06:07:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.30785.1695190037741184076
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 23:07:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38K67FY21994962; Wed, 20 Sep 2023 15:07:15 +0900
X-Iguazu-Qid: 2rWgoVec2mnxLURhqL
X-Iguazu-QSIG: v=2; s=0; t=1695190035; q=2rWgoVec2mnxLURhqL; m=9jQjJ6b16XrsypU5zifKKHPZ+Jeq2aIgDt+LAoWqR6E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 38K67DpV4105941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Sep 2023 15:07:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHZQQANbRvblDEFOPXEDjeppgkDmzNM9DK2C0rF+uvUMdWW7g83loj4ciA1q2IP55WLY7GYOrrxWe9YDNyWX2h7rkxehfWQSbJAO2Nk5+gsTcM0cDxYg8+GFrxJKLTki2cuAKJr4O+JePzcMQ7P4qz7kCAVU7De7ZHsIYxaaFX0sT+eHLjqytQ5hASOY+gikuD395bsiDn8gzwguvqRTz8dO47b7XS4+M2Jp5KyIDWKbogTpc7C52twjF2yPp9f1VnZaHyM733tWvZy9hcsyn22sgFOWNRW3+B6GFSEJe0DWmsgqHLo927YQMG4KfdCzGscT9QsGRvhvHD8AT7EWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e5qFW9PlgJS7VZI3rWbTSxI/yyfBrzC5c772NVR6OM=;
 b=Si/BXCsmnPd49T7mv7ek8LV/HkNdGqe3FYkpptSz7LMkotSg2hLwOf1Wln++3oTzu08Nq1LfMkdgiRINiXdGuw4qsNzTdVhcuBr0jLzo1XbQwUxRzifhMX9Cbv8E0OxCkN/9Rq+YkeyCXG5jGwsC88djHin19+yONPC/5jD1r0EZ1HoQmRNtVnmf/KC+MTui6iC62Ly1ZvmJzbSiVNbgDsLNqjlSW50UypoE6kSwT+mqxPZqKTV1Ui0p2Vjg0+BKkDexsG+ap0TKo02fSaD6/sy9gRPbGhrBWBd3UPnn+/Dyvj/QhLx+Dfj2QPJ3xX3vSI5IsHj9ssGIShNtc9Xkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] bbb.wks: Add fsuuid value to the rootfs device
Thread-Topic: [isar-cip-core] bbb.wks: Add fsuuid value to the rootfs device
Thread-Index: AQHZ64V19nCWtnFU70qEm2BX3XHTurAjNIiAgAAEOTA=
Date: Wed, 20 Sep 2023 06:07:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542A5E1DF412A466D9BA39AA4F9A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230920054357.7957-1-venkata.pyla@toshiba-tsip.com>
 <4a535981-86f8-40c0-88c6-be079e1c6593@siemens.com>
In-Reply-To: <4a535981-86f8-40c0-88c6-be079e1c6593@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYWPR01MB9788:EE_
x-ms-office365-filtering-correlation-id: 89a5f2a8-7dea-4b4b-0854-08dbb99fd3fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2Ro2dejq8s1orcmKoyDTypNoP9KGDgNSkC2JkqENGeNqeupyqMF7TIuBeUrONf9gtFHpBIlAMSvgIQoCsGSODJGL9iy3ca7ERjJQdVUosVG4kBlyls75csdmqon/VTheK+3gOCxnkdKB5i1PRYWjngSke4ZScwr5EvOnPziKF8LREA/fftGkiET704+PsRxbS9gtAyPmSNPryYw2ohQPd0Tcx6AM/vFOXjmvfMnfaS/PkgZUYNl3drJKnYF++T2LparUgr1viwrPkRNfunzEGXTYxZMk/fp+BJt0Exa7xMCJLqc2HCnYe8jAPI/FNkIf7aJcUo2P0G8pUiBGM80m5Sn74AYNbvDtnuxEUcYpNrlGk6bj1xgG7gKUdaU0Oplq1EWhjM1Cxm7dglFr13pUiRYvO+VDQ86bY/KdDdr53VoASEvTxh9miT30MiA9FojoXJxkdc50cqmcPYjbUzo5YnYq7g0YhsrWBOa0qieOXXmcw9sCbFccsqEBfWM/dpCGXDGZQ/4XzOZoPV1lQsRb+w/V92RAVITw0ofRDBcaX89tdGy2uEir2ZsXdo1I6hfGyNRIUVhopWLxdo1KziG9HnqAMTQNNZo09NIDtfLYIJGC3YIH5jlwju4foPZP25OZ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(9686003)(7696005)(6506007)(71200400001)(83380400001)(122000001)(86362001)(33656002)(38100700002)(38070700005)(85182001)(107886003)(55016003)(26005)(110136005)(76116006)(66446008)(316002)(66946007)(66556008)(66476007)(54906003)(64756008)(41300700001)(2906002)(52536014)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MDZkYnI4MDh6YmFCMkNiOU1raFpwVmhlcWdHektxNUN2YUF0MkdSOFBhUVM3?=
 =?utf-8?B?S2NGb2xxZklDOUtRYWdzVGIxM1p0WGNLMVJWbVhSdTRYQU5oY2VSL2tPTWtP?=
 =?utf-8?B?dzBnbFlORzRoTk10Tk4rZVFRNTBHK2RYVFNsQ3A3NHFMb0t0SmpUUzFDOGVZ?=
 =?utf-8?B?MWNsaEVCSmxaQUZnTDVWa0IxTHdPeldXRXBYNE81UlhrY0ZSSGZvbm9xaStz?=
 =?utf-8?B?czdmYjNsMThSNUpvdERkY1NKcnd6NDRZOGFQOC9sdjRLS0R1djhQNWtLaDM0?=
 =?utf-8?B?Q2k5cDU5QVBBTkpiRkltY0IzM3RlZ3Z3RTFOcENUcW1xWW40QnVRSDFQUDdM?=
 =?utf-8?B?MmdLam5ZcmUySWFDcER0cjRtSjZVdW5DNmI3TFArUDdXTVpEb1BLT3JzVCsx?=
 =?utf-8?B?bFhQcGJxdFdZeGFuMCtkTzl1Rk9LdnZrNVhxaHM0Q1hKcXYyRGV6NHZSRGg0?=
 =?utf-8?B?UDA2dzdVTnM3cEJucVVCdng4QStNaXAxdVFubmVUdERYSXZRUEVkN2ZJcUEz?=
 =?utf-8?B?VVRwMm1rb3kwbXJWOGRKOTB4VS81VXVIZ3kwcUprWWRyRlBTVjMrOXY1bmRK?=
 =?utf-8?B?a3ZITHpPUy9GYUFWTWZiUUhqYmdmOFJwcU5tM1NzT1p1bVBjSUgvYytxOHBj?=
 =?utf-8?B?NHJ1eDZQY0p0a29iWFl6eW5Td2FyeEdwME5ZTEhyd0haL0RXOW1qL1UzOG8w?=
 =?utf-8?B?V0VaR0dGVmMrUGcwTUlxTzBVWlBFU2gzSFRPMnBvZGNWMkk0WkEybm9KNGNM?=
 =?utf-8?B?dmwvUUN2Tms4cm9Salg2WkhiS1RRYUFuV01RemRFQUhBVEN3WDFRbkFmNnR1?=
 =?utf-8?B?WUJJSXAzWTl1bzMwQURyQWVzQVMxMlJESThNUEV4T1pudEtQRHZpb3NzbGlZ?=
 =?utf-8?B?SU10RlQ1UmdJakJDK0RiRXo2VmN6T3dMYkttb2ZMYjJPSkMvOW8waFRXWW1B?=
 =?utf-8?B?SzlVdmhPUWJYaWhNSllTUUZ1SE1mSkxsWHhqTmovMG5VS1ZDeWFjREoraHZD?=
 =?utf-8?B?UHd3czkzNVE3ODhHSjMxRTJxSGNaOTd0UVRuSDBRaWVjSjV4K2tjWWxPaEVI?=
 =?utf-8?B?SlNBcEF1aGs3LzVrWVB6eHMwbGI4K1hrZmdHMlNZU2kwa2tvUTdZaldLNHox?=
 =?utf-8?B?RHBndytOZGJKNVdHVmx3OTcrOUl3dnVHZGxrem5pbkwzeVYvVDI5cUYvQU1L?=
 =?utf-8?B?dDBXc01CbmJTTEZ3ajk0ZnV1dnhUb21VR2t2YnRpbVRLejhYb0tPcjZxZ1Fx?=
 =?utf-8?B?aFpHN3NQTFFuWmoraXd4dGx3bGJabDVnb3o4WWlTblNMamh3M3JieDVJZ1Z5?=
 =?utf-8?B?c2Y3NlZIYjYyanRyOTV2SDJLcmVGYm5PZ0hBaGY4SUtmQitQWHY4Q2R2Uk8w?=
 =?utf-8?B?SHhUd3pNd21vOXN6anRPeUhFM2xRNHVDMjRLNlUxc01rSmx0eGJRdk1DZG1a?=
 =?utf-8?B?bDNwcmRUM0FQYTNFV3lQMzVIZlRTWUlpZEE1SlVIV0Nrc3o4cWZsZ202UzVz?=
 =?utf-8?B?RHJaNnFudjcraVpKQS9mMlloRVVQTDZsSXpKYXhvMWlzT3JvemZJUWVndmpn?=
 =?utf-8?B?LzhkNVpOdXJ2ZDc3dVZkWmdKaE00SDRnNDVUSThDOEZBWFhPRGF2VENCc3pi?=
 =?utf-8?B?REFuc3BWL2JnSUFCK1VjRjNwanFoV0ZsR3NSQ0VXUHpyclVsa3g4ZGZHenZR?=
 =?utf-8?B?dWlRSjJOOC9zU0xlM2tGVGNwOGNKZkFYVWNONmpNd2hIK0w3Y1hHeEtUQTcw?=
 =?utf-8?B?UFB4S0ZuQ29xUWlBckRTUERHNWpOUzhVN3Jqc0lrdHFmYmtOU0YwdXN1VkY0?=
 =?utf-8?B?MWd2bUI4Sy9JTHlOa05icEtsVTY3YXhGSDdwYWdNSGlTUmVyc3BQU3kvc05k?=
 =?utf-8?B?cnk0MUlKakljeHhabmlsL2dibElmWjZOSGJKcGxyLzJLcVAwdUFjSHpOZW54?=
 =?utf-8?B?RXE0d25GbUh3Mk9tNFdYeWlZZkd4dUhnYSt5bnRrTno4K2pIS2JJc0ZWblVK?=
 =?utf-8?B?WXc0bnp4a2hGbDMxZU5jM3dpdEcyVlFPTjBEM0pxUWJidm5wbnZmYTlCVFln?=
 =?utf-8?B?RUovSi9uUnhjSjVReE10dGpUSE9KVWhjSytuN1Y2U1ZZdmtMU1RubFNiRllG?=
 =?utf-8?B?TEJ3bllzR0tqU1d0UEw3elBXaWs4VXNtK1FPUnhCWkk4OTlFVDJGK0hDaEpH?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a5f2a8-7dea-4b4b-0854-08dbb99fd3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:07:11.0261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4waoDWz9GqiDAM+u4la8krALhqZy3D/W+PVP3tS1EalcBEON5PQET9BvlSwTwt+OkIDxcDKF2XxSSIn1CXx2jDvqQb8j/eLov7aMLlklAG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 06:07:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13179

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMjMg
MTE6MTYgQU0NCj5UbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj5DYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9y
dGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGly
byjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDv
vJQpDQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3ViamVjdDogUmU6IFtp
c2FyLWNpcC1jb3JlXSBiYmIud2tzOiBBZGQgZnN1dWlkIHZhbHVlIHRvIHRoZSByb290ZnMgZGV2
aWNlDQo+DQo+T24gMjAuMDkuMjMgMDc6NDMsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29t
IHdyb3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lw
LmNvbT4NCj4+DQo+PiBUaGUgZmlsZXN5c3RlbSBpbWFnZXMgYXJlIG5vdCByZXByb2R1Y2libGUg
YmVjYXVzZSB0aGUgcGFydGl0aW9uIFVVSUQNCj4+IHZhbHVlcyBpcyBnZW5lcmF0ZWQgcmFuZG9t
bHkuDQo+Pg0KPj4gVG8gZml4IHRoaXMgYXNzaWduZWQgZml4ZWQgVVVJRCB2YWx1ZSB0byBwYXJ0
aXRpb24uDQo+Pg0KPj4gRml4ZXM6ICM3Nw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEg
cHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICB3aWMvYmJi
LndrcyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvd2ljL2JiYi53a3MgYi93aWMvYmJiLndrcyBpbmRl
eCA2MTMxYzc4Li5hNzk3ZTk1IDEwMDY0NA0KPj4gLS0tIGEvd2ljL2JiYi53a3MNCj4+ICsrKyBi
L3dpYy9iYmIud2tzDQo+PiBAQCAtOSw2ICs5LDYgQEANCj4+ICBwYXJ0IC0tc291cmNlIHJhd2Nv
cHkgLS1zb3VyY2VwYXJhbXMgImZpbGU9L3Vzci9saWIvdS1ib290L2JiYi9NTE8iDQo+PiAtLW5v
LXRhYmxlIC0tYWxpZ24gMTI4ICBwYXJ0IC0tc291cmNlIHJhd2NvcHkgLS1zb3VyY2VwYXJhbXMN
Cj4+ICJmaWxlPS91c3IvbGliL3UtYm9vdC9iYmIvdS1ib290LmltZyIgLS1uby10YWJsZSAtLWFs
aWduIDM4NA0KPj4NCj4+IC1wYXJ0IC8gLS1zb3VyY2Ugcm9vdGZzLXUtYm9vdCAtLW9uZGlzayBt
bWNibGswIC0tZnN0eXBlIGV4dDQNCj4+IC0tbWtmcy1leHRyYW9wdHMgIi1UIGRlZmF1bHQiIC0t
bGFiZWwgcGxhdGZvcm0gLS1hbGlnbiAxMDI0IC0tYWN0aXZlDQo+PiArcGFydCAvIC0tc291cmNl
IHJvb3Rmcy11LWJvb3QgLS1vbmRpc2sgbW1jYmxrMCAtLWZzdHlwZSBleHQ0DQo+PiArLS1ta2Zz
LWV4dHJhb3B0cyAiLVQgZGVmYXVsdCIgLS1sYWJlbCBwbGF0Zm9ybSAtLWFsaWduIDEwMjQgLS1h
Y3RpdmUNCj4+ICstLWZzdXVpZCAxZjU1ZDY2YS00MGQ4LTExZWUtYmU1Ni0wMjQyYWMxMjAwMDIN
Cj4+DQo+PiAgYm9vdGxvYWRlciAtLWFwcGVuZCAicm9vdHdhaXQgY29uc29sZT10dHlPMCwxMTUy
MDAiDQo+DQo+VGhhbmtzLCBhcHBsaWVkLg0KPg0KPkJ1dCBhdCB0aGF0IHBhY2UsIHdlIG1heSBz
ZWUgbWFueSBtb3JlIHN1Y2ggcGF0Y2hlcy4gU2hvdWxkIGJlIGRvIHRoaXMgb25jZQ0KPm5vdyBm
b3IgYWxsIG91ciB0YXJnZXRzPw0KDQpTdXJlLCBJIHdpbGwgc2VuZCBhbm90aGVyIHBhdGNoIHdp
dGggZml4aW5nIG90aGVyIHRhcmdldHMgYXMgd2VsbC4NCg0KPg0KPkphbg0KPg0KPi0tDQo+U2ll
bWVucyBBRywgVGVjaG5vbG9neQ0KPkxpbnV4IEV4cGVydCBDZW50ZXINCg==


