Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A82C4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 11:47:28 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web10.9898.1714734554694415450
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 04:09:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jmJU5+UC;
 spf=pass (domain: siemens.com, ip: 40.107.8.42, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJY0UhxgbZCMGwZMTJ/6u4zQVcSkGKSbzIEGFL+JFEdhNa6dOxVwswABzTHBl0ka07IKIiYFOiNu94gkNrItC0ESrrVxEyoh1AIscfnwld4UL0IFXF5GHdYvjvhJsclVtciCJ9uIQuCy5vFDZ9UR7MXNX5tZZ+FihUTbAd5ExA9C2M95ln0S0xkABVumOXVuproUsFKDoXkem7rdNFzKwqTE+uCQUDliS5iZcUWoNPUq6A/+yiAcgIl6S6lTNa+EjE1tsM0FZFDazNt8fMUzC53WRIkmMH5lU+Z8lL/vWKy/2EOWwYEUB+VX068af2ysaFXv30HWaX/0JY90UdcTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtIxFLmEOiqVCq8UD6q/rCGPDfm/E/k1GyWNPBpxO4w=;
 b=RmCZaPxzrcZVAoSDQOHFRj51SbN5y6SQw1bChWCyXKnjPRdhs/sP4KElSGhW0qjQs2/wqnv5qVjhZM2XC1J7iOscridWDmh7SdfJ/Y5mut0ldyHDtP/G0xw3UbHmr3OFfXuFj79wo/+dR14nKIhqEfNyxMdmEkClR8Gw7LMRoff4cBGKP3o5dDqi6/ZrD+STqUksSQ7vNo8MnQNI1rfVt4k2jS2J++cRkM3nWpxG5I25z5hThCP6cA3QCDbw3kixZrTmK27azao7o73SaQFcD3dtlhR6PRYDJO2a9fkdLndl++o2ORvj66TprA+PI6C//TqbRMO9++2wcisUpDJFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtIxFLmEOiqVCq8UD6q/rCGPDfm/E/k1GyWNPBpxO4w=;
 b=jmJU5+UCjYAJr190rHBSqBixBZNWQ4NYGZKDJ/ggPi35bjK92f/VLXlt2FaK7bc4wR8skWXHgWh9mZL5qsHGduTeYCjkoV4ItsJxjCwuRoR48fqdPnDvZqBALsfdS11l7cj41nbqHuHh9z3Q6VkdFJSlO8+QfsRiQMiWZq8nKDMFF1PDwhm7npczOkTFcx6DjOJEawVOAFgJIBaG4pErJj5zBFN2/cVBBKBz5eE38mgrFYj3Mkzjpd+oe9Ih0qOpaKDKTgioK2xDXcpxUaUpzvz3IIx430L6YCNNp2GcwJF8qgK/MdM7jEgobPfy7+SQTBS/RONq4gmY9dGKoUa7zg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB5979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 11:09:11 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:09:11 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 4/9] fix: use luks2 to identify encrypted partition
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 4/9] fix: use luks2 to
 identify encrypted partition
Thread-Index: AQHanHOv7zxpp4BJ6EifyYoNOrJlurGFW70A
Date: Fri, 3 May 2024 11:09:11 +0000
Message-ID: <2aad5a2f8c384b709a81332e2d356df0efa3771b.camel@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
	 <20240502093240.364093-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-5-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB5979:EE_
x-ms-office365-filtering-correlation-id: f09db69f-bfc3-4335-0a30-08dc6b6175c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YktFbTdsMTV6bzk4OWVpbzI3cDZnb0hHLzA3NFhGNDRaWHE4dks4RUorTFJT?=
 =?utf-8?B?Z0xCYjNUbGswalc1Rmx3NjMvWGRua2F5R0J6M1pHdjd6RTdRM01VZldoSC9K?=
 =?utf-8?B?WlZ4OWg2NFA0V1hub1FQTnFGV2xhUXdZR0h2Q2hTbW1EZC9VaS9xdjJmQzNa?=
 =?utf-8?B?Qk9od2FRUlpERkNFMWY5VU5QS2kvd0ptb0NraVBHMWovNDdwT1dsVWdUdS9Y?=
 =?utf-8?B?TG5LQUk0R1h6b3plZDErNEVwVDBsb0ZpK2dteUh3REVES2VSVHNESFpzOTlx?=
 =?utf-8?B?YkFXS1RnOHJ1eXJONVd6WGp1ZzJYSmllSnZBV1dQUE80Q0hOZU4yV1hla3Uz?=
 =?utf-8?B?clNocTM0d08rb1QyZUwrNnBRUC9KVVdNRituRzdKNWdXbHVzOWZEYkl6OGZZ?=
 =?utf-8?B?aG90aFA1QWtCVEZOQ1JLb1pyb3NvdGZMUng0MDd1ODdwWDQ2OS9sVXBlb1F4?=
 =?utf-8?B?OXBJMUZpbHB4THM2S2NxV3B2RWdvU2FIQ0dqaWtiTVl6NjFRTTd3OEhvUWdv?=
 =?utf-8?B?dWJZRGRpaGdjelFWc1FSMnM3blVzcHUxZHRuNjNYSVNXaGdkckV4bkUzY1lV?=
 =?utf-8?B?SFNVQld5M295ZkpSeFp1YmorNG4rQ012RFF5MVlOaFpkdWd6QUtGeWp5ZkNI?=
 =?utf-8?B?ZnBuems1bkZLWmRkRjNhZFpDK3htU1phRjF1eE0yQkE4Mmt0azNodFhMenlI?=
 =?utf-8?B?U1VuYjdLdVpXc2cvZ2VQekFqUXBmSjNCVEtpT0grN0Y1djVaZm5zMWE4cCto?=
 =?utf-8?B?SWNRT2p5L3ZYR244RnBEaVlnRzlrTThicVYxRlhScGJVb0t5NUx1L20yWi94?=
 =?utf-8?B?R1ZDTzl6dFRQVXZRWFA5MWt3UXFsY0RKUGFwdnhXSnQ5MjQwM3NFbENHQjR1?=
 =?utf-8?B?OEpxRVc2VEVVMk5vTjhVdW1tMEprcFI5K3Bsc3M5a3BIa1Y4QzB5MnFSeU9o?=
 =?utf-8?B?dFFwUVZ6dm5xZ0pBdUMxaWcvMW1uNEJEZWNWdDNpNjR6Zkx2WXMyMlpSTVhL?=
 =?utf-8?B?UzVxcHZGTDJDS1JCWTM1TGJvMkI3aFExbi9EMXBheU1BZ3M2Z1B5aXVneXZT?=
 =?utf-8?B?bkhGZjE2TG9DRk1hTkpnQkdHanVXRE9hcDFpZ1RPTUN5cUFFcnR2ZDh4M0tB?=
 =?utf-8?B?N1RSbVU1eUhJYmdST0M2cDFaLzU4YzgvekZVVGVRQWtmc2lLdW5WL0ZXTWxs?=
 =?utf-8?B?VUg2VVhhbTRycGtTVVpkWEx1TU5sM0tlL0xVcGsxNURKamtmZmtKbzN2YTJI?=
 =?utf-8?B?OWtNU2JISUhuMzFHUVIzTUZ0MHpmbHc0ZE9RNEZMaUFHZ0lXMGRabkRTOW1z?=
 =?utf-8?B?OVNNMVUzNXZkb1ptOUw0bElLSVQrVVQ2MGViNFpmeFUxbDBIUCsxTFBGVzd2?=
 =?utf-8?B?YktoQXQyN2x2V2JPRlBEdCtITlVKUFdDR2R3a1pzKzFQc0NBVS96MFVTMm9s?=
 =?utf-8?B?TjlHZkk4R29meVJGdXI2UDAwNmJaZzdwcTIvQ0MvbUw4cnlvNCs2bFNQcmE1?=
 =?utf-8?B?TmxGNzdCTVVPZnJXeVlXRXpDc3M2SGxMUFRZTDdJN0tjYXZFWWhvcWFxKzNn?=
 =?utf-8?B?ejlha2h3R0NNS0hmMGVVYzEyM09Ic0JJbGoyNGJCVThJRStVd1ZhME1qdEkr?=
 =?utf-8?B?WjVXaHk3QWNFRGFHMnFzQm1hUE1IZ1kremlkN3d5bkZWZDZqbUJGRE1CUlVU?=
 =?utf-8?B?MkhJOUgwY01xZ1k2MVVocGxMdVo4ek1QZEx4eVVhRFhiVncrcWluVmpBWFRj?=
 =?utf-8?B?YzV5Mjg3SFRlNkQ5Q1VlelhMRzFrRWo2Z0ZHcVFHTFZCR2ZOdXk3SjN5MUpi?=
 =?utf-8?B?Z3pYc2p0YzlXNUNNOUxLQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RmkyY1pGK0g2a2F2QVFScE1RQjV6dERPS0x0YkRzQWkra2o3MEh2RVN4eEJl?=
 =?utf-8?B?cjBIYnczMWk3MFRiZFB5SWcycGVKSVpkbjZWRnF2NUpPMUhJMGhIQXZZK1hH?=
 =?utf-8?B?NldoeUN0OEt0c3I2K1h1SThuS0wvR2tkWUs1dzZlSkxJbjR2QzRsTFNVMm9j?=
 =?utf-8?B?RWRjRjRJbjZ1Zlg1RFFXbzZlcVJWNnpDSVpLQ2Z2NmZkMDdVZlBqa3VUUjFr?=
 =?utf-8?B?eFhiWEQ4K0xwcXI2b2FyTFdDNlc2SHR4NTIxeUJqUVNrekxSTzJqSWhVZk9T?=
 =?utf-8?B?Wk9kMTlFeGQxdVFJVk5WTHpQTUVpOHZ6UjhEM3BNd1liM3prVDBUK2V5Q1hP?=
 =?utf-8?B?eThvNFl4SzQ3YnZld2NaelppOGg4cWRyUGxXRCtSaURqbTI3cGhpbTVzNFoy?=
 =?utf-8?B?aVgwdmlmZktSWEtMK2lTc2tCZTJZa2V3dTExeVljbHVMYTFDZzkzZU1XQ1BB?=
 =?utf-8?B?NG9UdldVS2pFc2FxRnpwRmUxdkVqVGNBOWJuNUlPU0RRcW93b0xMN3FBMnVQ?=
 =?utf-8?B?ZytHSHRoK3V2QnAyQ1FiTmY0U0pHNjJQRGNGbTc5c3pzM1NZbXFqcFhuamJt?=
 =?utf-8?B?eFVxOExaL0c0aXdVdWNEdkJOVFVCTDJRc25ZUFNUS2pINHRJckFaNWtaeGJv?=
 =?utf-8?B?YVk0RVZjU01ic1lYcmU4NnlLclh4cXF3VTdqbmVablhHMkpXMHNpUSt6TVRw?=
 =?utf-8?B?UmNrb3ZFWVg1U1NZN1hFTHdvNStIS2FNRUlmdEhndy9MNlIvY3Q4VUZTSndC?=
 =?utf-8?B?VUdQZFZGMWZTR0NBaGZUeDc3Z2VLRnZiaFlFZURlY3VzL2VIenpxaDM0QVBX?=
 =?utf-8?B?SXNRVkYyejZBWXlUR3BLYjJaRUd4ZzhNV3JwcUV6dUZ0ZmR6UmlHU0R1V2RC?=
 =?utf-8?B?dXIzRUdVemFwbS83dC8waEw5NVNTR1dpQTg4WERHQnRZQjN0STRrSHRKWGto?=
 =?utf-8?B?MXVMaVNUazlkeVVUWnQ3K1Bma1k4QkFwV24zTEVubEp2U05XNTRweXBVNWdH?=
 =?utf-8?B?TnVvS2d5M0F4amhLTEhtZDNmTU1DL1ovK0c2QkUzR2JZZ2o5VHFWZS81L3Jn?=
 =?utf-8?B?Y1VVdXBMdk10RUZOSDJoVlUwWmJNbHkzR1J5U25VVFE3U210SjJXelNhcEd0?=
 =?utf-8?B?YmRyWUVuSVNRd2FvTFR5S0F2WHVqTUZFczIvZUwzLzkrNGtHaE0wTUZob1Ir?=
 =?utf-8?B?NUJSYlpBTDRLdXcrMmdDNkdPclA4ZnQ5bmRGMVN1K2ljQ1FxOWNCZ3M0SDVK?=
 =?utf-8?B?bk53V2J6S3hXZkNFQmg2UHFJNCtVZzNwWGZDYkp1Y3JSYUFZKzFhZCt2RkxO?=
 =?utf-8?B?SEdOZUs4SFNuRDBWeERrZFF6SW1GcWtzOHR0V3Exa21FTlhJaHZ4S20vdmpp?=
 =?utf-8?B?WUJVR2c5RURaOGJCSUxUZDRuUGdSQkk0VDZiY3hBenMraXpucktUbDZyQWF3?=
 =?utf-8?B?SnNXS3FQellhd1V1SDBpM0hGTVkrMGdXelA1ZWlnR0EwdTUxN2JDemYwa25K?=
 =?utf-8?B?aHVSK3dKdEFMVzJHL3ZwVWpIR0IwZ25QM2lLL1ltQzZRZGppb2h0b0RIUC9F?=
 =?utf-8?B?a2Uyb1VqcjJ4R21iWDNLcDBVTVkzY0pxWnRvSHJtMy9aRjlEQzB4YUVSd2sy?=
 =?utf-8?B?WFQzbnBaaVdsMml3NDRBN1VXMzlBdXVoaHR5bUpkTklrbjRpUzNoLzJmSC9l?=
 =?utf-8?B?Q1poZDJRRUZLZUttZU81N0tGNm9RQy9aWmNKU2p3QXZwYlYzSGtEMUxYMUN5?=
 =?utf-8?B?WUxxL1VSVW5OZGxBY0xJUktwaUdiWUpJTitpMHhsbVBRKzdaUEZGdnM2QmtW?=
 =?utf-8?B?N0Z2czE2Q05tb0h6c2pjNGFZQkp6M0hqRlRRN05XMGpnbFYxSlozbERFZStH?=
 =?utf-8?B?SWRRV0x2TlkxQmF1T29tSkhxdVhRSjVob0FNM1R4T1FsN0dsRkhQK1REa3VH?=
 =?utf-8?B?Z1NRWk9qOUtTcnI2b1pJSk5LSXJidEdvTjNydDRhQ0hNTjg5NTlLWXgyNG9l?=
 =?utf-8?B?dnNjSm45V1lmWHR0bFNPd2VUNEw1VENSOTBTS2hjY2locU54ZG5TbG1YQ3J2?=
 =?utf-8?B?MDQwMHVEVzYzbk5SOGtYWnFtNGxGOGUvN1ovVFErdXpxOEloRmpieWlzQ3pI?=
 =?utf-8?B?SkpPaHY1SG8rUUJaazByNVVLeUxxNXFCVk9ENStReTZxV3RTdUtQSnZxdkZm?=
 =?utf-8?B?elAvTEsrTkgrd3hTZElwWE1QMGRvbHlyb05ZR3lRMzBqa0xCM0FKSFRxNmFP?=
 =?utf-8?Q?jOwI5cVv1kxifMu6+nLaJJBqc8rQdYbutN3yDhGRs8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f09db69f-bfc3-4335-0a30-08dc6b6175c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 11:09:11.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/oPvpwi8BApGNbUNwSdrbSnYirKuGCX2oXskbSr3uYaGKl+PGn/qNEYO+O6ZofS/mc4JQoUITxRSPy5vrWDt4OGlNpNE6g4X4uP3YxMBwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5979
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0AC8D85570AA547AD25260281CC0B26@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15818

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDExOjMxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBmaXhlcyBhbiBpc3N1ZSB3aXRoIGVuY3J5cHRlZCByb290ZnMgZHVyaW5n
IHN5c3RlbSByZWJvb3QuDQo+IFdpdGggdGhlIHRva2VuIG9wdGlvbiBpdCBjYW4gaGFwcGVuIHRo
YXQgZHVyaW5nIHJlYm9vdCB0aGUgbm8NCj4gdmFsaWQgTHVrcyBwYXJ0aXRpb24gaXMgZm91bmQg
YW5kIHRoZSBib290IHVwIGZhaWxzIGluIHRoZSBpbml0cmQuDQoNClBsZWFzZSBpbXByb3ZlIHRo
ZSBjb21taXQgbWVzc2FnZS4gV2hpbGUgZG9pbmcgc28sIHBsZWFzZSBhbHNvIGV4cGxhaW4NCndo
eSB0aGlzIGZpeGVzIHRoZSBpc3N1ZS4NCg0KRmVsaXgNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+
IMKgLi4uL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlw
dMKgwqDCoMKgwqDCoMKgwqAgfCAyDQo+ICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFt
ZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlw
dCBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy0NCj4gY3J5cHQtaG9vay9maWxlcy9lbmNy
eXB0X3BhcnRpdGlvbi5zY3JpcHQNCj4gaW5kZXggNTFjODFmMy4uNjg1ZDg4MiAxMDA2NDQNCj4g
LS0tIGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiBob29rL2ZpbGVzL2Vu
Y3J5cHRfcGFydGl0aW9uLnNjcmlwdA0KPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFt
ZnMtY3J5cHQtDQo+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+IEBAIC0x
MzQsNyArMTM0LDcgQEAgZm9yIHBhcnRpdGlvbl9zZXQgaW4gJHBhcnRpdGlvbl9zZXRzOyBkbw0K
PiDCoMKgwqDCoMKgwqDCoMKgZmkNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlmIC91c3Ivc2Jp
bi9jcnlwdHNldHVwIGx1a3NEdW1wIC0tYmF0Y2gtbW9kZSAiJHBhcnRpdGlvbiIgXA0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgZ3JlcCAtcSAidG9r
ZW4iOyB0aGVuDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfCBncmVwIC1xICJsdWtzMiI7IHRoZW4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBvcGVuX3RwbTJfcGFydGl0aW9uICIkcGFydF9kZXZpY2UiDQo+ICIkY3J5cHRfbW91bnRf
bmFtZSIgIiR0cG1fZGV2aWNlIg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNv
bnRpbnVlDQo+IMKgwqDCoMKgwqDCoMKgwqBmaQ0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xv
Z3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

