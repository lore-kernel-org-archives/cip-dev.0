Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB04EEB58F
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 04:08:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.4442.1694578083927937080
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 21:08:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38D480AM526581; Wed, 13 Sep 2023 13:08:01 +0900
X-Iguazu-Qid: 2rWgoVec2alcBDaR9P
X-Iguazu-QSIG: v=2; s=0; t=1694578080; q=2rWgoVec2alcBDaR9P; m=MFVdLLBCgcpsMDlJky9PDVj3dALNG2f39vDAlRglsis=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 38D47wW12786177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Sep 2023 13:07:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spiec4uyYrIM8wUdpaH0SDCmsttQkUaKiTIh/cPkEq3qNA/zxZO95CJGjfOdOwqsx9oT6cns9BXLHJ+l/4NO9/r90bwgY1U2O+6GqRl+R7b/FcxE/qmCkWQXoj7pv65Jze41mTwshHf0m0zAb079iCY6XsK/zoFvCSUY/eVwdNfQrMQH5qmI6qS8I4o1R/GjF43JMaSL0Q4XRTinTcPruAo/Xt7ryFibdlVucPPkE7MgrCKhINbQKjM/+8ANkmPLOAaQnX93AirO4w+y2zGBWh/5LhcnwK1Ikq5LZ0kNYAXnPjAb/4tt1RyQh7pEYvLSm6StTAVjB52lXM6OIML/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8HhSQw/tB6bxIuVvMnVedY9dw9iI7xB9S+5OhYL2po=;
 b=dpd6hR0HMb6OR914h6goSYnvMCxvVJCuSWts8/CjjmvQbGTLqZHdHtl70HONIT2N/H+1yhj+YU80PPN1R6THQ8deJItAJ6CqRRJwOYBmOSB64BjIXsDknPlXEh6shPj3SAf523M2wdfNCNS6WNczgIqu3TL63XQGpdb9ms6k4uby5r95cJKlIvy9onYmLAtsSu94z+BwGFNI9QrP6BbvqcPsCN7AzjvT8S2j3bdTOlFNFxY7Sr2X1vpINaGPhQ5bjNK8cVnxRkaCIc02u9B0SsyuON7qcQh2zLYvYekVgSJxYzM/QZp5pjyrzBwPSFJup4s4tfeOazTcnugOKBXroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Topic: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Thread-Index: AQHZ5LRS2vrHBLDxKEy6tSmaozITarAWg3oAgAAnPhCAACdaAIAADxFA
Date: Wed, 13 Sep 2023 04:07:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542F9FA4966AA0F34736826A4F0A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
In-Reply-To: <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB8276:EE_
x-ms-office365-filtering-correlation-id: 86c8a47d-68d0-4a4e-81ef-08dbb40f02a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oQZDzDlbirDf10OVejmO0A1zI/jywfnhVfO1PICEzopfrnEyzu/7R2BXWw8onJsn8uHZ8rZ7vCCyKPAYvEp6dpp6PSa+y2Dm/fKlqCe77bZIooxCKT9UK0xC2LWx119xduGsJ6nzlY9GbEWMty4QlGTJvk5iztmgYTMHttEGbqX15VRvwoIS2zbUUHWK90O7fvgUnnfcxfBFGi6oi8bbKE9DEmSFoaMr3M6RLZEpJM57slAw8L+rZ0fIvwLB93iAOzaIF1LUP6HXZ7J0tADod3huR9v4wC9MpZJ/aqFpS4Zbpy+LlROe5U29tf7kATGi67S/nkMBEq0Po2/IQLnPX2crBcoLgJnxW7QJpR8bJTvWS212BkwRHld79fxUd0DlRlh7uUqZDZbZGMKg1SsH1DRL5tfU9wsSFHLcqmYOZVzzvlsrSmylA3l2SJdHj6YIwg0K+tZsXK5SA0WBgFZkHKi6sBgOsPdx9+xfrVsyiSLRlfvfoCUcBKfY5o6fGRrf2IiDiBdmPHiPBkcnEyyukTVoxJ+BRaa3vnIf6DF+xcz5oFR0/1Jj0ZLaP2UBJXfNSHavdu9SQqrGSn/cjM4lcz/DRNWjESFHmgjNEqTLXua8JPQL0qMada/O/P+FW6Zg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(71200400001)(53546011)(6506007)(122000001)(7696005)(38100700002)(38070700005)(33656002)(55016003)(86362001)(85182001)(107886003)(2906002)(83380400001)(9686003)(478600001)(52536014)(4326008)(5660300002)(316002)(110136005)(8936002)(8676002)(76116006)(41300700001)(66556008)(66476007)(54906003)(26005)(66946007)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bTNlNUkxSHo3N0JQY2N2Q1VTbU5LWnkvZXNCeG5JSmkyK0J3K1p0S29OR3BK?=
 =?utf-8?B?SnY2cmNkaWFDNnZBUHNPZVZrQ1dVd2JMd254eklzK3lvRXkyZzNzcHh1VERu?=
 =?utf-8?B?T1kwY04vRmtoRmZnbzhIRlVpZytxU2FWMHh0aFZVRVRpS2pYUkdmeEQ2bmFB?=
 =?utf-8?B?cUFQcVNjTlAxUFpPVCtzQ29uaTRIdmVUdUhlV1ZxeWJRQmgzWk1QQ3lTV0Rv?=
 =?utf-8?B?dzh5bkRCbU41ZmJQZmViL05BRmJkVGsrT1ZUakhIVTdyeHBsTHRKRzB2cDhF?=
 =?utf-8?B?QXhYOEMwWjc2SFIvU3Y1M1JrbVZpQ1U4ZTN6eWVqeExrVjk0a2hzcDBGTW5j?=
 =?utf-8?B?MHJJdGhhY1lwVFFGU00yM29lRmlUdGh3UVJBUDZUUlc0M0pLZVRtdE9jR0w3?=
 =?utf-8?B?Nlhhdmw0bUU1TWNKaVpXelVuQnZRZ2tKZk5tdGZFTGdObExjY08zQ0s3c2I3?=
 =?utf-8?B?YmsrS2dUUzhxRmFCbGlFaTQ1bkdYTzJWeW1BZzllL3RuUk83ZFplTnVRejJj?=
 =?utf-8?B?MUI5bzBYb0d1eVlhcjBQYzczK1Fhb1VSYXNXTWYwVm11amVrQStrSlFmblZP?=
 =?utf-8?B?WnlPSlpMYlBSUDZ4UWRDVlFQaHJTTmVveEs1VG5qaGdnaXQ1NDNVbEpGMm9t?=
 =?utf-8?B?d01oWExCaDVMY1lvZVYvSzk5RWNSWCs1NzJWbzhxcE91WW55VyttdGtVQVNK?=
 =?utf-8?B?a21BQlAra3lhQlphQzF4S2dlbWJkMlNQTXRXN1ZKQ3U4c1l1MDhWRTMvZ25O?=
 =?utf-8?B?V2NVN0FTZG1hUVAxK0FzcVQ3ZUtkaUo4OEQ2TEQrWUk3STVDMXJ1b3VpRU1n?=
 =?utf-8?B?anBNWTRVajJUZ0dMRWw1MUwxSVFOYWxjWmhVTFN3WEN4WHovR1U3d0t1TTU1?=
 =?utf-8?B?Ukl6cVV1aEJZUnZGUmZ5K2hnL2lEZUZ6YWlITktwQk9lUERxcEh4aENTSDNF?=
 =?utf-8?B?QmtqeVZwcnpYWWk4WTVrU0EyUlNUODZMMzNFRnBoSHl4THR1T2RmNFpVTmhr?=
 =?utf-8?B?SUNSbHJmdjBCR3NIYkdaRlNOTWNscG9HYTBPdVlsMXhneWJQMGY3K0hIRExN?=
 =?utf-8?B?VkpEVVQweGpvOHordGwxV0JnOUo0TzBKeG1zWUdnTFp6dGl5V1FJNFc2SFhI?=
 =?utf-8?B?L2ZZQW52bjlVeTNISGFHeUVCTFFIZkJJUWJ4WnNGOGtJNVQyaFQ2dURWRnNj?=
 =?utf-8?B?VkNVMnM4eDRQT2RqSm5kTDhRd1gzUU5EcmNPQWlBL25VL0JhZGswMUM4VkRW?=
 =?utf-8?B?UGY2Z3dsKzdNMmd1dDA3ZkJpNTFtTW4rVVVqYmtNbG9KS3pMQjU0SXN1WWNj?=
 =?utf-8?B?NjlxejF2TElnL25ET21SUTBybEcxaWxHY3V0OHowRkMzcGpUTUlOa3psL2tI?=
 =?utf-8?B?cmY2bWxkVWhiYjdlWG1tZkZoOHFhVkw0TEtFQm56a0RwR1NFRzJLbmxXL1Yx?=
 =?utf-8?B?Y3hWL2luUVVzRFlOc1VWbWtHN0dzY1VHWkFNaUFGZktvUjZVeTdVbnlnbGkw?=
 =?utf-8?B?RUlhUWJEazBncjBtUS9YM3ZyRkhMNjNlQ21MRnV0b25YeUxWV3B5SFU4bE4z?=
 =?utf-8?B?R2k2d2N1OEpEVUoxR1BZeW15TkhmTTFGRzNJNFlEOWV2KysvZjFwN2VFQnRR?=
 =?utf-8?B?eFF6TnhWazBRenRta1o1OU04OStpM1B6TEFGdFFGb290dEZwUjRZRXhuTkhC?=
 =?utf-8?B?a2JlTENzbVlwSS91ZE9qZ01PZm8rRTZrVll6YVRQMDZSWUVhZERNeUJiMGMy?=
 =?utf-8?B?aEw0SE80RkQyN00vQTgrZVZkZGQrdG5uRnYzZlNlL245aWRKZXV1ditQbS9i?=
 =?utf-8?B?NmY2WW5nR1FRcUpTUkpMeVlEa0VsY2NKUTNFM0dkdkl1WXZiNXpjak5uRy8v?=
 =?utf-8?B?bFhaQkFJcU5rK3RCb29NbnVVb3hHcUdmWGxFb1ZaUXhKakZTMDdYUTFGalBs?=
 =?utf-8?B?TTlTalVNM3R6OVFYRmRzaFJpZlk5ZjRrdHgrNlpQSmQ0UmZ5UUVrempsVkRh?=
 =?utf-8?B?Z1RCQXFBL01zcFhBMEd3RnN3aG1vODd1QXhBbk9hbW5DZDFGUHFEZ2xTTm41?=
 =?utf-8?B?TE5tSUcrbHBFOU1ubzdNWjg0WGdJc3FnWHRxeFZUUTFGM3VSdXNxeDFadU9R?=
 =?utf-8?B?SjlQN1haZ3BoQTFlWVVQRlRQSmdDaytEUFgyTWZQOCtSWE5YR1dzMy9SWTlv?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c8a47d-68d0-4a4e-81ef-08dbb40f02a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:07:56.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9kDRjxD/U5hugjv3AdARq+E75SgPu1isO+MA2Eh1+idLge2jBS5zVTk19UyA+vO11t+J8G++D7tuNltXgkACOya9tfDUMmrq2a+KlGd7+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8276
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 04:08:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13095

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDE6
MjAgUE0NCj5UbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykg
PFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj5DYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjm
npcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQp
DQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3ViamVjdDogUmU6IFtpc2Fy
LWNpcC1jb3JlIDQvNV0gLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55bWw6IEFkZCBCQkIgdGFyZ2V0
DQo+DQo+T24gMTIuMDkuMjMgMTI6MjIsIFZlbmthdGEuUHlsYUB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBK
YW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPj4+IFNlbnQ6IFR1ZXNkYXksIFNl
cHRlbWJlciAxMiwgMjAyMyA4OjM5IEFNDQo+Pj4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnv
vLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4+PiB0c2lwLmNv
bT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Pj4gQ2M6IGRpbmVzaCBrdW1hcijv
vLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj4+
PiB0c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk
77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKQ0KPj4+IDxrYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPg0KPj4+IFN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSA0LzVdIC5yZXBy
b2R1Y2libGUtY2hlY2stY2kueW1sOiBBZGQgQkJCDQo+Pj4gdGFyZ2V0DQo+Pj4NCj4+PiBPbiAx
MS4wOS4yMyAxOTowMSwgdmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+Pj4+
IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+Pj4+
DQo+Pj4NCj4+PiBXaGljaCBhZGRpdGlvbmFsIGFzcGVjdHMgb2YgcmVwcm9kdWNpYmlsaXR5IGRv
ZXMgdGhpcyB0YXJnZXQgdGVzdD8NCj4+DQo+PiBJdCB3aWxsIHRyeSB0byB2ZXJpZnkgYWRkaXRp
b25hbGx5IGJlYWdsZSBib25lIHNwZWNpZmljIGZpbGVzIGxpa2UgTUxPLCB1LWJvb3QgYW5kDQo+
ZHRiIGZpbGVzLg0KPj4NCj4NCj5PSywgc28gdGhpcyBpbmNsdWRlcyBmaXJtd2FyZSBnZW5lcmF0
aW9uLCB1bmRlcnN0b29kLiBEb2VzIGl0IGFsc28gaW5jbHVkZQ0KPnNvbWV0aGluZyB0aGF0IGlz
IG5vdyBjaGVja2VkIHR3aWNlIGJ5IG90aGVyIHRhcmdldHM/IEkuZS4gY2FuIHRoaXMgc3VwZXJz
ZWRlDQo+c29tZSBvdGhlciB0YXJnZXQ/DQoNCk5vLCB0aGUga2VybmVsIGlzIGRpZmZlcmVudCBi
ZWNhdXNlIGl0IHVzZXMgZGlmZmVyZW50IGNvbmZpZ3MsIHJvb3RmcyBjb250ZW50cyBhbHNvIGRp
ZmZlcmVudCBhcyBpdCBpbnN0YWxscyBhZGRpdGlvbmFsIHBhY2thZ2VzIGxpa2UgdS1ib290LXNj
cmlwdCBhbmQgdS1ib290LXRvb2xzLg0KU28gdGhlIGJiYiB0YXJnZXQgaW1hZ2UgY29udGVudHMg
YXJlIG5vdCB2ZXJpZmllZCBpbiBwcmV2aW91cyB0YXJnZXRzLg0KDQo+DQo+SmFuDQo+DQo+LS0N
Cj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+TGludXggRXhwZXJ0IENlbnRlcg0K


