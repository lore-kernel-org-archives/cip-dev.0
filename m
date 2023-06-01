Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFEC7EE23
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 10:43:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.27477.1685616192241600082
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 03:43:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 351Ah9Aw027994; Thu, 1 Jun 2023 19:43:09 +0900
X-Iguazu-Qid: 2wHHvlq32UY2xROwvz
X-Iguazu-QSIG: v=2; s=0; t=1685616188; q=2wHHvlq32UY2xROwvz; m=2fb0Wnc4VFqbW2LF/p9FiMeKnIMIdjDdlJNDTVKphU0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 351Ah56v040754
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 19:43:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqkGfLYP5Pt2KI63Z1egAGdbTYYxR74fyU2KK/ziMQbYd7Bt10Dd4lJNMx8nYkpO43S/BSpl+Wuu+91Up0GxRMGNA5Wm7pp4ymUrhfB+An6kPVeAxnI66MR00E5NhFqbwqOXSLcmAYTdt8eAtiK5hC20ROJ5xhOsDYXU2QePAiZZwf5//PmYpYFHvbtWalonJURdR4ZDdTPFZxgBgVuXS7Zu5CI/hQgv+Hd+pIVVVakh8RVE/O0+eNdHAtC92bctnHZrflAP+PkW3o74c20PLCDFvGW9+1ogdSOLSECqZqHJh7eIgwaNxgav1jKEQ0IumrKvrJa/k3hgX/wrmKI9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ww41ixWyDtslCD5qfLgbznp9TXO15Gu0MSPtArUFG8=;
 b=WoDmi7r0Q+e9ssAC6BVh+HLp4jEuNQIBAEgfkZOA3hOkAqNvtq5d87r/agy0BYnLWgvjF3ott4lr38k+WcjxVAtgqKfa0oC0JT51bSmXHD4AlqaUTWHJ4fDnezG91kUcy5ExK5xnmuE8I0L+MnTLqRTi0yv617vHvpK/G9sl6nBjARjh+47Rf9x41FlNuXzROC5qVXErlG0ppmiXLkclVrh4hfvafyn6HGOWZ5Gu2tzGwsLieRdwnE2YYCpN/6eAxhKT2+1+VgkT3RExEuIlML67aT0bf7wvqX5rW2mz3Kd+b9bzqBdq2HbP1+OVfIqE+RkNhdDKGMsUf89UQf2xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Thread-Topic: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Thread-Index: AQHZlHS1C93NBKHP50+pnouU5JtlFK91wJ3Q
Date: Thu, 1 Jun 2023 10:43:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542A26EB39703EE7F2421E1A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
 <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
In-Reply-To: <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB8515:EE_
x-ms-office365-filtering-correlation-id: 2a0141c8-87b0-4dc6-ad88-08db628cfa78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IquRLeEPi5l11FFHsGlTXJekqCW5sJd0YLR4K5AezcJGmPdOedsyQ7nSWRisAjO3yrI0H75YQK7avRH7rBW+SlQTh7XJxI9UnV/fIENSlRT5IEtJaBB02EXBFPWHe4A9Lcx+RjWM7d8QR9A3f2rO6MKNgtmTWzV5vof1wLmQGEl0EpjbZ/nopZme0JG3b5yJiNRlHb8JWTPH7MkzyFXSuU1pEdetJ3mPvIod+67KYyefc/1p7HWwoHZx4d6cNtk9V7M/nlZ4PuUnLkfSvKFWfWPTUsqVpxQnL6p/eOZcFR/kTXK8453iWKYjnDJM3jWZ4RYZfKeJ5Tl7ApUhH1hVAUvIe1zB9ZRcIAu4CjGeS/anpFdepWBOonhqPdgtp8qBpB66JwMs7DfVtZqNyNEdYqgeYue2HK2byZoIl/TMurGVSAiz/voIdxqPS9X6s4pVSckYQSvzK+EGnBxITm4Mr5uxRGk4lWjWo032JRgwmW2tKOZ7EzNuOEzQcFBENVy8rcQspmsOgueQfAJpWHflaz6mhN9zQmtJr0lJxivx7aXEpaeDxbElYn0REFvi5aKm6s8v351UzlDcn40xzNX95qkS/1QLXI1urgMgpzhzzqyw8kbdDRlOqd9MJttOeEz4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(316002)(33656002)(71200400001)(186003)(4326008)(7696005)(41300700001)(86362001)(6506007)(66946007)(66476007)(66446008)(9686003)(26005)(85182001)(83380400001)(76116006)(66556008)(64756008)(54906003)(2906002)(478600001)(110136005)(38070700005)(107886003)(52536014)(5660300002)(8936002)(8676002)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VTllUjE5dlNhZ05SRkd5UXdmdlpRbzNNenRib2dhSm5sNzhWek1Lbm5vcFRa?=
 =?utf-8?B?Rlg5LzQ5aXpta21qWVhzR0R5Kzd5QVY2eU5mUysxcHlZUGZKU1BMSUxHYXRL?=
 =?utf-8?B?NTVuV0pUclV6My9WRkhsS1VFbEtWN1NnSEE3QWdLZHRqZzZZY1hSck83M2w3?=
 =?utf-8?B?bFRxalp2R0xiYXpxTU1WOE1xMWYyNkFPOHhQTjR2TDRKbmNHa1E2eldKWU96?=
 =?utf-8?B?eFZ3UGRnZFljRDVTaDBjT2x5STZpS3FLcDZ2N0pGejZ2ZEZZMGFUOUw3ZG5w?=
 =?utf-8?B?NnRpKzdOTDFGd0NUUTQyTi9PYTdXU1Y3L3pKejJzMHJVQytDUnhjZkVaQkd0?=
 =?utf-8?B?TVlmcnZtK0dVOW9IbDlHaGx2UmZoSTJVdmYzdE1ZSG1tWGpGQ29yRVhFdmpV?=
 =?utf-8?B?ZDJOZXkzYXlLMnZVUXBGRDcxcTBMa09MZTJpN0dyRElSckNpQ2xuYU9MdklU?=
 =?utf-8?B?WGN1S3RGYW5taWhERjlYaFVmWjc2RjhqRmNWWUl3dFJBMlVQUG9IZ2ltNC9G?=
 =?utf-8?B?aC9IVlVVL2krTWlXREFVK0hVdE00cHZkWkRJS2RScUJleHNkbEdReXlRRlZ2?=
 =?utf-8?B?WGhEdEhzKzE0TXpKenJCOXlVaUVrV2JYNDVqTWFodVlPc1VSK0tIeGY0RDN1?=
 =?utf-8?B?UWh0U3FMektUUTJzbWRGNU1TTEFGR0xtK0ZOTlNkYlh4VUVqUWp5eUpwRkcr?=
 =?utf-8?B?WjJIM0RwcTFjMFUwcVBrQXZrUXFPQUpibjNOclZiWFJJUzVJNmRtUkJXZTRh?=
 =?utf-8?B?b0IrZkxxbnlsWW9jR1FDR1FJUTB0eGlRNzZOY3IrU0d4Q2djaUlsdjg5SjJS?=
 =?utf-8?B?K1YyKzF2emNrazM5UDRhUHJ2clJ0UVZwN0VhS3BES3l6cUF6bjVKZGFORkc0?=
 =?utf-8?B?RFpNOXBHQ3pFaDgyNzV1MmlKVjhDK3NrSGFUWUYwWnFDQ2JhQkUzM0piS0JX?=
 =?utf-8?B?SXRQRWRUQi9jU2ZDUm4vSEQrS2w3RUZVUTdKTEVXR0NNbFRWTVhlY2hiZmJr?=
 =?utf-8?B?aFpYeGIrT1RyM0JHaWN2YUNqR3R5VndXRFhMdDRrRjBvZlh1QXhJc2RrS0lK?=
 =?utf-8?B?ZUt3dDNNODJsUTB6SzFDR244L2lNT29lYVAxZDVBcnNmVndwQ1YzQkFlZUdI?=
 =?utf-8?B?Y1JCdUdGa2hNK0JpZzNuM2lJZERRYmNuL2tKcjhNa1lHMHA0Nk9xcFlSNTlL?=
 =?utf-8?B?aUMybGdIWHdTUzR5azdDNVNwRVNUVWp3ZTdKc255YzZ5cVBtT2JxbFVNUldI?=
 =?utf-8?B?SkxUOFJPUDZjcUxKemJiZ1RhSm81QktIUlBvU2xIeUFwYjFqY2loQk5TcDNG?=
 =?utf-8?B?TDd1TlhPSnBpd3VZYnRSNGtnR05VUGVzV1VLaG44OGNaeVFDWnFtMzBVc3ZZ?=
 =?utf-8?B?bjZhZkNvaXZub290ZEI5WldNdkNpMGZwc01ZSGFiYnBVdDB5cVN0ek40ZG42?=
 =?utf-8?B?YVdiNWhYR2ZIS3ZOSEFJZ3FGNGNoY205ZFV0VTJHcVV2Vm9pTVZyb2lFcktI?=
 =?utf-8?B?REJQNDU0MlZ2ZHlPT2FLRE5hUlAvNytCRHEvb3NoRTgwRnlkZG1KcTQvSUQv?=
 =?utf-8?B?YmRzQ2F2OXhPSmVzMWZLdkRQbTBLd0hOeXhQTGtkSVMrS0hkbjhQWlVhRG1r?=
 =?utf-8?B?U0w5OEZqeG81UGt0NVJaNkh1Y082UDFxcXBnVlFjcGtkVDhHdHg5aHVJb0tT?=
 =?utf-8?B?dTU0dFo3OWJmb0pPK1c3emtZYmZyK0M1U2lMQXZNWjRhWlJiWTUrYSszbjky?=
 =?utf-8?B?bmF3a0ZqcU40SzAzOEIvKzF2WE9OT1QraGdDa1RqV01QdS9zOGRVaHdsNGhB?=
 =?utf-8?B?ZTQ5dDJac0Y2SWNGSVNJRENSa1c3SXB3ODU3M2xGUWlvL2l3WFMxYUtoVlhI?=
 =?utf-8?B?OW15Z09QRkhNMDFNc0JlRXJYTTBSNDlWRjJpb3FZbW0rVXNtME9RUXVtREtz?=
 =?utf-8?B?R2k1MzNxMGZvQ2k0SnM1bjhqZ09DdzBPRE96ZUFpVEJvSlFhdXBEN2VpQXdw?=
 =?utf-8?B?VnVLKzNqWDRpQUVzWFd3bm0wRjhFYWdMZHB6eHZHektRUTgybGxGQ1FWQnJa?=
 =?utf-8?B?T0FtejhDV2NxU3BKMU1sSXZMa0NqamdxTjFsRk00VmNrdUVVeWFRZEdoUkdv?=
 =?utf-8?B?ZEs4ODRNMzhFbEcrcVA4d0szb2FxekxiTUdPOU4vcUR3eXhjc2lST1N1TVRM?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UZ4WiakKdvBjPpgzdecAxBYVGzK42ngiubDGV3Uor7iRWMS/htgzzfDX2SzxRnfxwU8XvWcZP4VI4J4A05/GrSmexXVk+p099RRl9/iBB6/vTzojWUDbKFV3hP+BXWD5vRG4gfILM0pGEFZR0ee7aiZBOJjgeApoU2BSsuTT6/q098xObs5SkYdeb2jWVsQm4Fs36HaPub35n7dHVGfBEh6hX6AsGmnjWTxo5EGqD4E4Fplx8iNqMKNO3MiCmYeACkPiQ7gzF8+VbAD0dLcH1YqW2S1/f352U7m4XnvNTjbWdCzX7bGj6Jin/lkc8ACzYam7tBhtpQe8sN9b6D6k7w6wF3MaT/Zg2QaJpCEjeCDVvF3cpl8CGv64mz+MqDgU4D7fVrit97k+qVxznHpKbYcbnQN8d2gGP2Ijmne7h6z+ZT5ULA8tL0wdC/lvSVoXufpv1ET9aMffAowPzprxCUGLcFmXbfQOLzHRHnb2rEpYKTiIxHOiq1PQiIKaccgSnQcy514ZpmnyzNmyR/apnj3bpqIPHU2Tf5cANQY8u3LyaJcVxnqPgwAxESVAABe+6BYn7xnLTES4u3TYMr4Efm3o+VEF5CCDZHUFB6mklbUXUGUBRXICYXblUO0zx4lBK8URejZmeHvbYD8WKJd2O7vUXGKCuTedeGhLikRfcC4lqOMvV3LFbl1+4q8o29fsA8KakbD45Pr9wpxdnD3K/xZBaJHnK/uvkbvtW/RoPLxZCtplaPuzLmCfKOdqasYtaU0Sbq/uiIe8XyOxJAzSIbblYW6EhazZD2d4JzVedsTy+fqFMuhR3ijKt6HzIp5NdkxbwPHi1aIx9FeISJVXBQ==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0141c8-87b0-4dc6-ad88-08db628cfa78
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 10:43:03.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/kj6xQtQfgG89+Q80JQGWFApOAPwcLpHu/SYjuj87Nzmiam+SIWa3cUxYSF5L8poNIZuqnnCgo0UfPfbrim3dEZENOZFjog3UnLCm/ha8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8515
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 10:43:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11724

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogVGh1cnNkYXks
IEp1bmUgMSwgMjAyMyA0OjA1IFBNDQo+VG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1J
RUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj50c2lwLmNvbT47IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Q2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAg
VE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj50c2lwLmNvbT47IGhh
eWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw
77yz4peL77yt77yw77yUKQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPlN1
YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgMC8zXSBBZGQgZXh0NC1mcyBpbWFn
ZSBpbiByZXByb2R1Y2libGUgY2hlY2tzDQo+DQo+T24gMDEuMDYuMjMgMDk6MzQsIHZlbmthdGEu
cHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5r
YXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+DQo+PiBIaSwNCj4+DQo+PiBUaGlzIHBhdGNo
IHNlcmllcyBlbmFibGUgZXh0NCBmaWxlIHN5c3RlbSBpbWFnZXMgaW4gcmVwcm9kdWNpYmxlIGNo
ZWNrDQo+PiBDSSwgd2hpY2ggaXMgbmV4dCBzdGVwIGFmdGVyIHRhcmJhbGwgaW1hZ2VzIGFyZSBi
ZWluZyByZXByb2R1Y2libGUsDQo+PiBsZXQncyBzZWUgbmV3IGlzc3VlcyBpbiBDSSBhZnRlciBp
bnRlZ3JhdGluZyB0aGlzIHBhdGNoIGFuZCBjb250aW51ZQ0KPj4gdG8gZml4IHRoZW0uDQo+DQo+
Q2FuJ3Qgd2UgYWRkcmVzcyB0aGF0IGRpcmVjdGx5IHZpYSB3aWM/IFRoYXQncyBhIHdheSBtb3Jl
IGNvbW1vbiB1c2Ugb2YNCj5leHQ0IGluIElzYXIgbGF5ZXJzLg0KDQp3aWMgaW1hZ2VzIGluY2x1
ZGUgcGFydGl0aW9uIHRhYmxlcyBpbiBpdCBhbmQgY3VycmVudGx5IGRpZmZvc2NvcGUgaXMgbm90
IGNvbXBhcmluZyB0aGUgcGFydGl0aW9uIHRhYmxlcyBpbiB0aGUgaW1hZ2VzIA0Kc28sIEkgYW0g
dXNpbmcgaW5kaXZpZHVhbCBmaWxlIHN5c3RlbSBpbWFnZXMgKGV4dDQpIGluc3RlYWQuDQoNCj4N
Cj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRl
ciBFbWJlZGRlZCBMaW51eA0KDQo=


