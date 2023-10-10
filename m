Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D38CD80D0
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 13:23:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.90926.1696944211714083545
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 06:23:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 39ADNTZk3099404; Tue, 10 Oct 2023 22:23:29 +0900
X-Iguazu-Qid: 2rWhrHNnfY6EEr0Cum
X-Iguazu-QSIG: v=2; s=0; t=1696944208; q=2rWhrHNnfY6EEr0Cum; m=78av4kNFDsL/H4n98tAnc4hE3jr7UP7gkrwUzzo0PN4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 39ADNRbt2424070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 22:23:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA0pPnZMjWnpbj4IN8RNgUz1ezML7ZHw+WJOboiU/4XM2CDloOZD8b5xe8uECoininNqton3M7qRPyMVABup5KYUOoQN9QCdFcpPjJaEfCYWi+BtI48nkhmhKnP3sSfe/ZsM6tHtBu268dGNx4vwSM8fRQ0HOnS/q9cUl+FO4l8iZk44mXCSmzen7NAERb19xwhYMRF1kKLhR4sWGlAqymUqac8G0Bb9WfOA+Cqp5AN2p/2A0j9z9EOIoZar+kwhjupj4zitg+UqTxg60/lwknqHTMWKniu0qZu7Cc1UX7RAPwhrF62d7C8qJT6xDsGU6ZTRbNE696E6vLEiPWJeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmabOoGiqJTW/Dxm9yAUsXbdjF88SlM8cQh2HFNkPaA=;
 b=RgpDPyXJWkllA4UrsjPyjpSmmfw9CMDTc5XAacaR67WTAAjmf5z+83wJbSUBQ+1R1knBJv16rHVsFX9OwTjXOQAoemuWsxpUVM/Xs9IGKetOcn8nX494Jib4Z7+ZHvoP2TmOqILMmZHqKE0Ewm67O/dvmfXj3mTJTTJ4YdRcVyS5CUYjJAenCim5axHQg9APMWs4LgyrrmXpaFjBb4Tjo9JSVNVemVPfpZcagqfe9q5OKkFA20lOw7DELDjpYaWvoq21AcCHGlXjJUQsrI52PtYF1g2ljZ226goH6/TAqvXh4EgWtBaSMRwjSPJyNraO2Dxv1Lk7z3ZlzmjhBQ9Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <minmin@plathome.co.jp>
Subject: RE: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Thread-Topic: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Thread-Index: AQHZ+1FTAtHCB/vwW0aQeKQEbMcuubBCsgqAgAACjsA=
Date: Tue, 10 Oct 2023 13:23:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB112457EF240E3EE05EF931A5592CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
In-Reply-To: <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYWPR01MB10788:EE_
x-ms-office365-filtering-correlation-id: 1d6e53ad-9d3b-4d5f-1ec4-08dbc9941543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 00udakxm+yLMKcRIL+Ik4VGjEZciBjUpv5cGsOqpSvygp1iYY895ziOS7KshWy+MWZZBYsaOYm1NIMumixRNEkwiJrID3FmbsuFDEjLPUr2SuP0RuFz40FLF6arHgMNbReNUBFOjdSkJdTlmEQddagPt6knCLQohytxCQveFUksiQYpTa9A7zNliuubnQr2G8DgyQRZQo0P8TdGePFLnmpNZxUbbtEIljrvurp72NGqP2xE262cIudntULb/cd4aeDDpMFpbTDrwcomUPLES+JIzTynaeIYX9917BClt7b7D8C+7wldBoNLvTkzZPxUsfk6DntO/MoLyXoi1et8kQ4iYmK8qgfdY2sUh88nkBM/LdR4x/sWq21rXw/vFjvS+G9J4d2i43bCmWQ0e4dg1NYmriGW9X8PX0v5wylAK386nGTWvigu3yeoPeOPMPkUOLI6JnBuSW6QyLfCFuaGEDAUqDlHPIvyobeo3OnTivMurKui8/ffoymfbclTiIvJrBJsHVgZJpjfnmphWbsoagCsp/IiJFRN93TvJBHym06NvGEOAGIJRjfcHNjJIfhTGcTY45MC3jkeb0zbJCx4evG/O6ju9fTfN41IdyBQFwT+Z9TyHBshfuK0oETtMpdWhGxx/+mCr+xRB2oqF/6ygDw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(53546011)(7696005)(83380400001)(26005)(122000001)(55016003)(9686003)(38100700002)(38070700005)(33656002)(8936002)(2906002)(4744005)(5660300002)(4326008)(86362001)(8676002)(52536014)(71200400001)(6916009)(316002)(66476007)(66446008)(76116006)(54906003)(41300700001)(66946007)(66556008)(64756008)(478600001)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UE5laWVOaTRDeEpCUnowNFlWNUJYSWZZRmhtQ0Q3d2JyUzQwWU5ITG82SWg5?=
 =?utf-8?B?Vm1ST1dkWjU1Q3BBZlFpcFk1em5yd3BZQzNqanUzMDMxN3pad0NVOHlxdDR4?=
 =?utf-8?B?Wm9hWGFBMlEycU9uZGJ5ZjJlM2tGM3l3SDNkZ1FqMUpsYk00UjV2alZhcFhx?=
 =?utf-8?B?R21vSlZUYURMQy8xdXFXczlGSlhMbDhYY1ZKLys2YTJaUllJYklaenplNnFF?=
 =?utf-8?B?QmZCcnBKUXkvNnUyVkxYUC9sOFg1UTdGbk14OGNPVG1KOHJ3YmdVaDRaM3kv?=
 =?utf-8?B?YU1vN2UrYXNNMUZWK0hrMWVXMi9vYmJaRWZSV0NQa0loN2FUQ01rWlpBRkdo?=
 =?utf-8?B?eU5ZaitnSFhBM01NT3ovQTd3MGRXUFFoUkdIL2YzaStzRXNUbXowSnkrNmJw?=
 =?utf-8?B?S21wTUdnOHorUlJzK3oyc2lIR3Y2Tk1tbFNhblI2bG1zZkdaQ3lMaG5zRldM?=
 =?utf-8?B?STRYcWpzNENTVUlpL3c1WjNtU0RWaDdXUU1TV3NXRGhoV0V0NVVhVHdqUHZL?=
 =?utf-8?B?MlRnSXBiSEhSQ1duLzRZOTNHOUJwSHNra095eE9ZdHN1L0FvRlJVTlRKTGlj?=
 =?utf-8?B?SjIzeHI0aHhJb1U2TGdkdTRGMER0UVlndUlLMGF1TGh1Qmc4dmtaY25qNTU5?=
 =?utf-8?B?eDdETjVVQlFJMWQrQ0tmWUhQdnBFVE9LemVYaVhPcVFQbVB5V3drQTh3cGU2?=
 =?utf-8?B?TXZYZ3p2OGhOVUxpRjNJeVVPeFZKRmxCTXBIM2R2Q0VmamI0SGJ4dFpMTVNL?=
 =?utf-8?B?cGx0SzBibU5BaHJpUG1JdTk5MXBLWUw2TFpwaTNtNUFiemp6b0dGaXYvRFBV?=
 =?utf-8?B?RDRTbi9oSDgycWpxYmdMeWVIY3NtQTE1ZFo4Z1ROMzlkUU1qNzRHdlozVmw2?=
 =?utf-8?B?MVhkU2NXVHJORkpIZkNORHUzY3BwQjNpRVlNZ3FrUEh5L09OemozZkFkTm01?=
 =?utf-8?B?S2RJMDFZbkZiNlNkdTFXUEk5RlNvOHBtWGkzTVlNdHdCNHRyVkluZDAyMFlu?=
 =?utf-8?B?aHcwYUl2OGRBalNFR2tXWFc3UzRubVI5N29pKysrQzdBaVpQVVdrYlNyTmJv?=
 =?utf-8?B?OFpDOGdlb1BpYi9GRnl5SnJHMWlNRzVsOXBRRDF4S2NHSFlib0Q0Z0RPSzlP?=
 =?utf-8?B?TlZha296MFQ3c2JETmtXZllKSGo2SUFZbFYwRk91czBseVNwdXBPTnY3a3lC?=
 =?utf-8?B?MkFXYTRaRWhndklPNm5UVS9odnFHL0tFU0JmMFQvM3ViNTVwSnJBelVCMVc2?=
 =?utf-8?B?YlRVbFN4VVdmdkowUmFVelZ3Y1NOeklFOGEyZ1lqaWdrRkluZDkyei9tK3hw?=
 =?utf-8?B?ZW9xQVJldVY4OFFhWUNEanNocW04TUJOd2F4ZktaSy8xZG9XZUxUY012T1Q0?=
 =?utf-8?B?TnlYZGF6aU1LL1hPUmVrb3hKTk1OU0tjQnI1cDA4dERJRkFuZjhtN2RLU3dt?=
 =?utf-8?B?VFVjZEI2QmlMV2hYQjZqc2sxZ0FCTUo2NWY0UkQ3bjBYSktlWXRrTGtsN2xF?=
 =?utf-8?B?NkJRa2diVmo3eGJXMmV2SWsrb2lDQVl0bnFEVFJyeWJFeGIxaXZmT0piV2V4?=
 =?utf-8?B?Vms2Z0xuY2tLcVc0dDB6aE1ncm5WNitnWFR2d3BiMC9FRG5wenNtOGJhbTFl?=
 =?utf-8?B?U3pMei9UQytKdzNEQWJiUU9oYno3VTJHSzVlYTBURzBuT0U2cnVSZDV6bUNS?=
 =?utf-8?B?b2Nid2pzZmFFVXJ3OFBmSWZCSXVNQ0xtV2tEdGNPaEJSdTd3b21HdVRLc2ky?=
 =?utf-8?B?RjVTVExmcnE3NEYzTkdsdXVxUEV5STVON1lldkxCZEQ2QnNJd25RTTUzbXcr?=
 =?utf-8?B?Z0dJNlEraEFqVzFPT1lKdXlKRUZ2VkN6WksraGRxcFE5cVlhTHhaWU14M3Y4?=
 =?utf-8?B?YlpqWVg5dDNwZ2JzTmZkdmxlZWVmNFdlMm9QZWFVOTNRYTd1NW5DMmtJRTQr?=
 =?utf-8?B?MjBhKzNMSlZVY21HM0RYL3ZNS05ZYUhiTTZpSFFJSytNTzF5Y01yVE1BZ3h0?=
 =?utf-8?B?WnZvT29RNktwVFZYdDN3bVNTT1NaWHU1LzRSTU1mWktmN2Nnalk4bGJkTGpH?=
 =?utf-8?B?ZUVsaWhOZzNmN1NZcXo0ck9Lenk1SERTVnUyc0lyd0swUjlSK3BKejlSdEx5?=
 =?utf-8?B?eXg5LzZRbzNDY3lOT3BOcEJkMi90VVJWMHdzQ0ZTRE14ajNKbGIzeUZ5YkxG?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6e53ad-9d3b-4d5f-1ec4-08dbc9941543
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 13:23:25.1517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNJYtOLn645Rr39npNKWDq59V+jJHKxKA4gfAm9Itfxymjw5iQDKf3k9En2YcbXVVGRAT9mRFiKiyhP0pjT9OZSURREUBan7dltGH4roVfmOgvr7B5eK6xmRkBC6AApr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 13:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13371

SGksDQoNCj4gT24gMTAuMTAuMjMgMTA6MTAsIE5vYnVoaXJvIEl3YW1hdHN1IHdyb3RlOg0KPiA+
IFRoaXMgYWRkcyBjb25maWd1cmF0aW9uIGZpbGVzIHRvIHN1cHBvcnQgUGxhdCdIb21lIE9wZW5C
bG9ja3MgSW9UIFZYMi4NCj4NCg0KPHNuaXA+DQogDQo+IFRoYXQncyBzdGlsbCBnZW5lcmF0aW5n
IGEgc2VwYXJhdGUgaW1hZ2UuIENhbid0IHdlIGNvbnNvbGlkYXRlIHRoZSBkaWZmZXJlbmNlcywN
Cj4gbGlrZSB5b3UgYWxyZWFkeSBkaWQgZm9yIHRoZSB3a3MgZmlsZT8gRS5nLiBoYXZlIGEga2Vy
bmVsIGNvbmZpZyBzdXBlci1zZXQ/DQo+IA0KDQpNeSB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0IGl0
IG9ubHkgdGFyZ2V0cyB3a3MgZmlsZXMuDQpZb3UgYXJlIHByb3Bvc2luZyBhIGdlbmVyaWMgKipP
UyBpbWFnZSoqIHRoYXQgd2lsbCB3b3JrIHdpdGggb3RoZXIgeDg2XzY0IHJlZmVyZW5jZSBIV3Mu
DQpJcyB0aGlzIGNvcnJlY3Q/IElmIHRoaXMgaXMgY29ycmVjdCwgd2UgbmVlZCB0byBjcmVhdGUg
YSByZWZlcmVuY2UgSFdzIGNvbW1vbiAoc3VwZXItc2V0Pykga2VybmVsIGNvbmZpZykuDQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQoNCg0K


