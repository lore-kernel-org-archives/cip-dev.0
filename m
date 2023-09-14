Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4BBEDE985
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 06:14:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.5829.1694672094720356386
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 23:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38E6Eqr71550828; Thu, 14 Sep 2023 15:14:52 +0900
X-Iguazu-Qid: 2yAaUxDRJ9FVwPpXV7
X-Iguazu-QSIG: v=2; s=0; t=1694672091; q=2yAaUxDRJ9FVwPpXV7; m=rkRwKYhStlRO+icHdboWCRewENJFeoyUvnXhx/wZ1Xw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 38E6Eofv3340943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Sep 2023 15:14:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYXC0ZFgFAbjzYitJq4VIo3PrNjzndAwvLozZHCpllgTZmVA+/5VFBIt/Phc0V+Mg8f+0NqPXy2lKUyV8bp1aoWg25Xan6otTpJfqrUavx8S/Qcaz0E4XNI3MOOVN/3aOMlTkfgghsRIgQ/zS4AC336bOx6N5ax4TB6ywV46bia816Iu0fgtfHE4E/ZbVa1RYkFGt2Y9zHSGKgterCUPWy/w8lL6ix0LZxeO3W1wFy3U5BqTKpqtuZxe6x2yWBsYZex9NqAacmJWkk/QgV7rWsiQLWrrdKcKwnvf0Z5p9isk4lDroLUgUjIK8KgNvsEsLpAh7YIl4lFgl2qMQ1L8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs1ZZ28b+JdMSFvxIPOtm/0qtvdcdXi9NmuxQDTCbxc=;
 b=dwG4Bkic4did+W/tG75qVYKaenmcQnsQCDYhUQc9Ttc+HS0c6h7l5S8Rr4XNg1omQfuJahOsLKXvYDNn47eGzg4KHWg8n4wNwiBOSGhZwYbJr3yhbI+Ggn8pBoQLSGp09yK16K6T7Tgo/s39v2t34qkVKtyJ7OVy9Fa0VSr4ulE7SVD3kEQlftw2J2IV7m8e3iGVg8PooevQkwfDKPFmGePLJHrVDBZnhLn4BTLAbqdYu9/61mlo7t/ac3YjCyrO4yKYrV48roocKYwW/dI1lQSaI7ilOzU3VrNaEZlkWhAP6toVvl0/X7jmS/5Pe1evGQAKOW6Eu7MBomZNEg9liA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Topic: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Index: 
 AQHZ5LRS2vrHBLDxKEy6tSmaozITarAWg3oAgAAnPhCAACdaAIAADxFAgAL03YCAAADMMA==
Date: Thu, 14 Sep 2023 06:14:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542D6B290CDC9DFB4C06E11A4F7A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
 <OSYPR01MB5542F9FA4966AA0F34736826A4F0A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <4062dd3b-77c3-4ff5-a7ff-a195f35b9e12@siemens.com>
In-Reply-To: <4062dd3b-77c3-4ff5-a7ff-a195f35b9e12@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB9416:EE_
x-ms-office365-filtering-correlation-id: 38d8d7b0-530b-48a6-a6b4-08dbb4e9e65d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2PgTQCgJufXRN27Zrp6/awqQU6/nvUgSvNvmIUWYFeOpy4q5LwpBeanzRYCR1CWo3ysN3GQg+1tRxNTWkQ+u1hihZ+Q7xXLDop3a4CnRH9Py+3caiHfZij3+LZzsKiatDA/r/cgBA6Ql+6oOoQ7SxykU/e9ql01X5UTyLRVZn16514F8rt267evwNRNEbwjmsfAm9/9YQaVXRHc75bNJCVuTRTnPncV5sm08Uxg97QMLUadH9oOTgybgNVsBIDYyZTyw8jFDb0emTfpzNirBaezVjfAb9nSdct2kFLEW0Di43Qa8sFI4egKbj4ip4bHsenvsjplAXYjDMkNjPI9/Ieww4MRX3wf5l/TsExuguOH4IUqAT3DmyN+ztJ+GV6yRiwBXpFlSpMH0fjffFMeAPb3hB9ze6nrh7Pz8/ASHeh7BfBAdhwmSxnWNdaXAOoU2RF+0tHbQpU847dQh/F6TTf/mCk9jiTDyQQ1WmeIPZ9n/cZ0FvRTkKitZMMZXrzeVLOMq8RjXjT5qg/J/46voAH55hnFthnk01U2zWr9Q38kPrOVieWS/7eZn5m2A2eruGlGeqyjjxsnKpUbwixXHC84KPxNw0+Vm4GBliF2ZqHIxLLZskNEb+WxYOxb/nzRh
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(1800799009)(186009)(451199024)(83380400001)(53546011)(9686003)(316002)(55016003)(71200400001)(122000001)(38070700005)(7696005)(76116006)(86362001)(38100700002)(6506007)(110136005)(478600001)(107886003)(26005)(52536014)(8676002)(54906003)(41300700001)(8936002)(4326008)(5660300002)(66446008)(66556008)(64756008)(66476007)(66946007)(33656002)(2906002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWlEdUJVUnhwWk16VjVHeTZPT3k1KzNCM3NoV3gyWElwQ0p2UERMVkh5VXlV?=
 =?utf-8?B?MTdCYy8zT3AxTWY4ZHY1emQxMEU4Sk9ZTU9sRUxrelZKOFVQT2c5SnRpT1VI?=
 =?utf-8?B?M3dXVU9EN2tzY1NwMm8zQlFiVUx0MVJrRnI3STJHSFZ0VmwreXNySkVVaVVH?=
 =?utf-8?B?bWNRSFhWalJ3c3B5Rzhwa2VnSk54cGNGbGdOTWlvTENVNnMvMHNrNHRzL3lM?=
 =?utf-8?B?UTdwYmZQVWhmeUF0c05GalBPcDcvcHdOUjFKYWNTaUVNSVFyb1Q4bDZaS092?=
 =?utf-8?B?L2ZEejBTSHJLK3gzTll2UXFrb3VlOTNUdk1xcnFXYlFLSnhjOTB0cTVSU21S?=
 =?utf-8?B?OGNjR3R4NDBzMnVGamdHUE9EUGNLNWo1YW0zZlZ1aCs4YXRJSUU0SXZIalFV?=
 =?utf-8?B?SE1wNG5qanpmbW9PcHRwcVhyb21VNWQvcTR1L1lBaTZkdExJanVZbEZpdTJ1?=
 =?utf-8?B?WVdzUzR5ZmM0QzBkZ1czWDIveDJkKzZVeW15MUc5UmROWmlnNHpVY2ZBWnht?=
 =?utf-8?B?VmJ6Y0ZvTFVLQ3NHWitRSk5vSDJEaGRDc0E1bERDU0ZoL3psbTVwMjR5U2VW?=
 =?utf-8?B?ZmUxVEtKczBSZU9aL1B5d0doaDV6dnRtZE5PTnZteElBQ0xFN0M2RzFodzR1?=
 =?utf-8?B?VEhPZVhkZHBYckZkN2JQWWdobDhGWmozVGc4Qm9jYnBrTml6U0U1YnBsYkJB?=
 =?utf-8?B?TE4ySXcvOXdRZzZVeGo3TDQyK1NuL1dCUW1RSUtXaDdjREN1N0l0ZHpKK0dZ?=
 =?utf-8?B?UWpOTCtDSUZRSTB2YmRPd1k3SlVxcmI1cW1iNGFySzZqWXhHRndMa0pRcWtN?=
 =?utf-8?B?NUpmVWVDeFRVWmxBVmpUWk5BcXo4a0lvd1hJSmV0Yk1xa0oyMkVmMFEvTytI?=
 =?utf-8?B?V3RXblNOeWV1MGJzUkVTaGhqMUYvMkU4b0pYM0RaZnNtaDBtVUJuNDQ1b0ta?=
 =?utf-8?B?S1Y3TGV3Q0dTdXVoZGFjZURDL1l5QWUrSW9rb0NmLzVPZTVpRFQ1aHFXbGVY?=
 =?utf-8?B?aTFDZGJsdTZGd2NCSHNmekxRMVNveFVMc2pacVlKdElRTDMrTFNaTW1JMDcy?=
 =?utf-8?B?RlM4dEpDMTU2UVZXTWhac2N1dDZOTGhJWWxOc1R6emhYVVc5QVFjemN6Q2k2?=
 =?utf-8?B?cHpSRzVTK2xwWk1Dd3kyWEZNMnJvYnZiVWs0bUhxWVlFYXJVa2NiWXo0T1J5?=
 =?utf-8?B?SkNIVWx1RUlLMWNSd1ZXOEJ2ck5KME1JSUNITzFGRDA2WUdUelUwQndpRkVn?=
 =?utf-8?B?aUtEaFZWTVpLV0RRK3k4Lzh0N3ZzMGtHS1BkYjhDU1h6L3p5ekc4bU1RV0VJ?=
 =?utf-8?B?clZjK3kwQjM3ODJvTmxvZGJ5OG1hNXBLS1NrR2FhazRpcjdOQSszVDREdVFH?=
 =?utf-8?B?SEt2R1lWbmU1NlRsN2NtY0VlSEMrZnJwMVptN0Q5M29iT3NBQVNSam1lWlJx?=
 =?utf-8?B?ZjNSNFRKUURkeW05SU1qY0dGK0F2ZDlMRHpQcGNrYWpKQ05YU2xqdlJBc20z?=
 =?utf-8?B?eVJaRFFNc1NNczRjb2IwMm9yTElUbFd4cVhaS1ZOYmV3ZFVEK3VlQUorYzI0?=
 =?utf-8?B?S3VvOWlqOTZIWkRpeGthR0xOUld6S1ArcGlNZXplZ05WSHBtZGxaYk1NR3Zt?=
 =?utf-8?B?dDM5OGk2MWErb05RZHBuZUlHY2FyZEFKSEtMeHM5SGs3a294amZ1UVloNE00?=
 =?utf-8?B?ZHNGRlVLY0dQdHJzOFM4NUNNcCtIZUdaZ0VZWUMyT2lkQjdVRFBKTnhqZmdD?=
 =?utf-8?B?R2VTZEt2ZE9oRC84eXdvYkkzbVBSTWVSQ3RYRWxLdFM0dE1GaWZmZjZVZWxM?=
 =?utf-8?B?UjBVNDZxWVo2MlhNTFNZMmErYU4wRmlYckkxTWo0ZWJ6K1pOb3VEemF5aU54?=
 =?utf-8?B?STNkalpVNDFWQzZwSXBiaFk3bUtqcjJtdkNYOFNpT2hJK2l4OVpYamRRRld2?=
 =?utf-8?B?SFh2eTRIVWp1eHpkYVh4cXFiQms5MUNLSUNzc1lldnNCNW5DZWhrcXVNejM1?=
 =?utf-8?B?bXlvRzVVOVM4NnlxOHhGeWt3T3ZWL1J3YVorRS8vUWRxWU9naVVUL1VRa2NJ?=
 =?utf-8?B?UVRicXRHS3NCaFZnaVZrUVdMRFQrMk13K3I5d0VaNXFtdXMwQitQem95K0xX?=
 =?utf-8?B?UEl3Tmx5SDlKNitiWldYVU1LV3RtdG9IRmY1dDV3ZTdDbWdNSmE2NkJwTEdo?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d8d7b0-530b-48a6-a6b4-08dbb4e9e65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:14:48.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tct8E7qc1fftX09eGG1Y/kYmm1+jr6kyA8nEzcwMaT9lNDMuM2sjP/s1kWuK/IXebZ5SVlVksxjY8MNvyD5OgrbEtCfq6VXxFQvlV/eoBqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 06:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13129

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxNCwgMjAy
MyAxMToyMyBBTQ0KPiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9y
dGluZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9E
RyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+IHRzaXAuY29tPjsgaGF5YXNoaSBr
YXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vv
vK3vvLDvvJQpDQo+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0
OiBSZTogW2lzYXItY2lwLWNvcmUgNC81XSAucmVwcm9kdWNpYmxlLWNoZWNrLWNpLnltbDogQWRk
IEJCQiB0YXJnZXQNCj4gDQo+IE9uIDEzLjA5LjIzIDA5OjM3LCBWZW5rYXRhLlB5bGFAdG9zaGli
YS10c2lwLmNvbSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4+
IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxOjIwIFBNDQo+ID4+IFRvOiBweWxh
IHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRv
c2hpYmEtDQo+ID4+IHRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4g
Pj4gQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5l
c2gua3VtYXJAdG9zaGliYS0NCj4gPj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDl
kozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkNCj4g
Pj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
aXNhci1jaXAtY29yZSA0LzVdIC5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sOiBBZGQgQkJCDQo+
ID4+IHRhcmdldA0KPiA+Pg0KPiA+PiBPbiAxMi4wOS4yMyAxMjoyMiwgVmVua2F0YS5QeWxhQHRv
c2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+DQo+ID4+Pj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDg6MzkgQU0N
Cj4gPj4+PiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykg
PFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiA+Pj4+IHRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gPj4+PiBDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlF
QyBPREcgUG9ydGluZykNCj4gPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPiA+Pj4+IHRzaXAuY29t
PjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHv
vK3vvLDvvLPil4vvvK3vvLDvvJQpDQo+ID4+Pj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEu
Y28uanA+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlIDQvNV0gLnJlcHJvZHVj
aWJsZS1jaGVjay1jaS55bWw6IEFkZA0KPiA+Pj4+IEJCQiB0YXJnZXQNCj4gPj4+Pg0KPiA+Pj4+
IE9uIDExLjA5LjIzIDE5OjAxLCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToN
Cj4gPj4+Pj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNv
bT4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFdoaWNoIGFkZGl0aW9uYWwgYXNwZWN0cyBvZiBy
ZXByb2R1Y2liaWxpdHkgZG9lcyB0aGlzIHRhcmdldCB0ZXN0Pw0KPiA+Pj4NCj4gPj4+IEl0IHdp
bGwgdHJ5IHRvIHZlcmlmeSBhZGRpdGlvbmFsbHkgYmVhZ2xlIGJvbmUgc3BlY2lmaWMgZmlsZXMg
bGlrZQ0KPiA+Pj4gTUxPLCB1LWJvb3QgYW5kDQo+ID4+IGR0YiBmaWxlcy4NCj4gPj4+DQo+ID4+
DQo+ID4+IE9LLCBzbyB0aGlzIGluY2x1ZGVzIGZpcm13YXJlIGdlbmVyYXRpb24sIHVuZGVyc3Rv
b2QuIERvZXMgaXQgYWxzbw0KPiA+PiBpbmNsdWRlIHNvbWV0aGluZyB0aGF0IGlzIG5vdyBjaGVj
a2VkIHR3aWNlIGJ5IG90aGVyIHRhcmdldHM/IEkuZS4NCj4gPj4gY2FuIHRoaXMgc3VwZXJzZWRl
IHNvbWUgb3RoZXIgdGFyZ2V0Pw0KPiA+DQo+ID4gTm8sIHRoZSBrZXJuZWwgaXMgZGlmZmVyZW50
IGJlY2F1c2UgaXQgdXNlcyBkaWZmZXJlbnQgY29uZmlncywgcm9vdGZzIGNvbnRlbnRzDQo+IGFs
c28gZGlmZmVyZW50IGFzIGl0IGluc3RhbGxzIGFkZGl0aW9uYWwgcGFja2FnZXMgbGlrZSB1LWJv
b3Qtc2NyaXB0IGFuZCB1LWJvb3QtDQo+IHRvb2xzLg0KPiA+IFNvIHRoZSBiYmIgdGFyZ2V0IGlt
YWdlIGNvbnRlbnRzIGFyZSBub3QgdmVyaWZpZWQgaW4gcHJldmlvdXMgdGFyZ2V0cy4NCj4gDQo+
IFNvIGZhciwgd2UgYXJlIG5vdCBsb29raW5nIGZvciB0ZXN0aW5nIGVhY2ggYXJ0aWZhY3Qgd2Ug
Y291bGQgcHJvZHVjZSBmb3INCj4gcmVwcm9kdWNpYmlsaXR5LCBqdXN0IGxpa2Ugd2UgZG8gbm90
IGNoZWNrIGVhY2ggY29uZmlndXJhdGlvbiBjb21iaW5hdGlvbiBhDQo+IHVzZXIgY2FuIHNlbGVj
dC4gSW5zdGVhZCwgd2UgYXJlIHRlc3RpbmcgcmVwcmVzZW50YXRpdmUgY29tYmluYXRpb25zLiBT
byBteQ0KPiBxdWVzdGlvbiB3b3VsZCBiZSBpZiB0aGUgQkJCIGNhbiBiZSBzdWZmaWNpZW50bHkg
cmVwcmVzZW50YXRpdmUgZm9yIHFlbXUtYXJtDQo+IHNwZWNpZmljYWxseS4NCg0KSGEgdW5kZXJz
dG9vZCBub3csIHlvdSBtZWFuIGlmIEJCQiBjYW4gdmVyaWZ5IGFsbCB0aGUgY29udGVudHMgdGhh
dCBxZW11LWFybSBjYW4gcHJvZHVjZSB0aGVuIHdlIGNhbiBkcm9wIHRoZSBxZW11LWFybSB0YXJn
ZXQgYW5kIHVzZSBvbmx5IEJCQiBpbiByZXByb2R1Y2libGUgY2hlY2sgQ0k/DQoNCklmIHRoaXMg
aXMgdGhlIHF1ZXN0aW9uLCB0aGVuIHRoZSBhbnN3ZXIgaXMgIk5vIiBCQkIgY2FuIG5vdCByZXBy
ZXNlbnQgY29tcGxldGVseSBhcyBxZW11LWFybSBiZWNhdXNlIGl0IGhhcyBhZGRpdGlvbmFsIGZl
YXR1cmVzIGxpa2Ugc2VjdXJlIGJvb3QgYW5kIGVuY3J5cHRpb25zIGFyZSBub3QgeWV0IHN1cHBv
cnRlZCBpbiBCQkIuDQoNCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5v
bG9neQ0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo=


