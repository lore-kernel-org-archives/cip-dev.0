Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DEBEB64DC
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 12:58:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.31929.1688389096636129868
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 05:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 363CwErk1629579; Mon, 3 Jul 2023 21:58:15 +0900
X-Iguazu-Qid: 2yAb9zVTf9gaARFYtk
X-Iguazu-QSIG: v=2; s=0; t=1688389094; q=2yAb9zVTf9gaARFYtk; m=HwOwx7XMKh2c9GDh4r0SShM9f/fi3dSU7cC4+9mn0V0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 363CwDF72385369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 21:58:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1hjLnnl0w/l5dsZjMp5lIjEqvdMAl5hiD40P6S1GwAsDf9yVAjpa94sFjY0h9pu/4AeBByzDg1AoFQaRTLno48CQ9wPJ5riBf0Bwrdlzox36fkqxc8JpvQ/UeTbOfJ6vv2DRUU/rM5oxVpRjXsuFeeglaDzXE94ckSMW4QuGRTMIEM2/q39GZDvsbOCdPWi3o8MlUYiY4ceYFvrseZ+pgYO8CmRVEpNnqlKxivv/iL7t0tg5c8sXAUW+MQ8I3wsKNAfdbUcUVLON5sI/PvPfBN45cm6+JxVdyi5Ie8cCk3uBAHCy2FSOHqVGG7boFww3pseqcAufthbLVFu5IdTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrDsPJa0Z5syf82//SoqTYatckpW38qTduEZ3JwqCLc=;
 b=TKp7+eq3NJUsmUowd1jDXuEQRivPhS9jYPAxeV4/+/+mg2NkPWkVv5UPjMRG8kxdNtebPQ7h8FGk5S+tnGhfw+LoNfVLnb4YAB93yA+pNqp4LrzJvKnkOT+4WzfXwLyotNIUj+O1CsudmrBESPtKzWvYy4YYWqv8KkSqlyOJ2mF+qZTEAFGTbAw+y0px8aLvo5fhwtflmEPw/Fw9cH3z3rkFOrMu5VZ1UwEiXNIEfGFmf07zVwbvq720dhuot/sIS5cuZHhvFitIo3UAHSGUSXnGyFPLpDoXPiu64c/9vK+6KA9SxkI3VXEpT4IH726eu2/vx3jPnu78JTixf9BFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2 5/6] squashfs.bbclass: Fix file
 timestamps are not reproducible in squashfs image
Thread-Topic: [cip-dev] [isar-cip-core v2 5/6] squashfs.bbclass: Fix file
 timestamps are not reproducible in squashfs image
Thread-Index: AQHZrXbC21BmmaHe6U+RBCSWnyn4qq+n3XUAgAAjE7A=
Date: Mon, 3 Jul 2023 12:58:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542B287F360BCCD7731AF9BA429A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
 <20230703062231.18183-6-venkata.pyla@toshiba-tsip.com>
 <0fa5e801-d15e-91e8-32a3-7aef2d1a987e@siemens.com>
In-Reply-To: <0fa5e801-d15e-91e8-32a3-7aef2d1a987e@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYAPR01MB6059:EE_
x-ms-office365-filtering-correlation-id: 056a7361-0bd3-48d2-7e02-08db7bc52859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9HfRog6gLAJ0RcAFhfQlCWfk6ETiFek4mqBGAwVZtRDN5eFOzCFFR88w8CU40FX/ukglR4uMKn2fq8PnePIhvrSuJC2eASHEwPiwa1IiqssC7sizhU035n+jjqAAe4ZVjJcsGvtEiWtJJbMcVftYmT9Cdt75YbYKSohndrVQH/k3YXmCYTh2idfpLVSgoZ6vDndUvHLzsBtVn8Q66UMW0JPIdWNdElFLtNbwidfiXZc2VA3oim/msjGIsGQypug4eNUNrKBBa2v/Ym+9UmMnF1y37Jh2phWUAzq1hF4jVv+4OEYewB/CV+47NreaKMlEPRCJM5V8Ic2HK5HG2GrsoKOLHOJ3lMF79cXRvl7uq/8ktsbR9l/SqzRnDvwsg2+60IGdrIDL8hASJ3U23/0I423273Q+IYBQvXyBt4HEnFAngOwMp4g8eizvc1L29MrlIXR+cvJ3jnXt9Pg3zhdfkNKp7DmzHACQUm3exdy3u70U0QImkSZc5gmwtXoBkI03K9uyGOQw9UYHCdQ3EU+cw7peBByQ94WdySE5mGbb7W0UepFTtPKcjrmLuyBglOWENvCT30SFclgCFYE5IfjjwskriYN7UByJiXaG2jEYFc+Ls1XR2+ODEksIByE6RnYU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(52536014)(8676002)(8936002)(33656002)(85182001)(55016003)(86362001)(186003)(478600001)(26005)(6506007)(9686003)(71200400001)(107886003)(7696005)(76116006)(55236004)(122000001)(316002)(6916009)(66446008)(4326008)(66476007)(66556008)(66946007)(64756008)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHBXNWg4c3E3dlR2VVhyNXlRU3h2cXA3akg1RVFFNUUzUGpkb0VMTFYrYmF2?=
 =?utf-8?B?YVE0VmVXelg2b0s3clNOQUNxNjFjL2FiQVhOTXdFM0dNZkR1dzVwOUxhbDlh?=
 =?utf-8?B?WklYUFN1K1QwNHJEeWp2anFXWlYxbWM3eDB5UXBDTk5vWTUwdGZVZkZtUGVS?=
 =?utf-8?B?a0xLME5iWmZzSFRmTGRnNmJpaStKQkxBY25YVGpTRVVwTExQNytmQW5sOVds?=
 =?utf-8?B?ZDNBYVB1MitRS1hFb0tvcThvZ2hJZ1FvM0FHSDdpSFg5TFRPMkR0YkpNRURO?=
 =?utf-8?B?UUkwU1RKODI5bXZDQWY2WTVtTTV5L29DYVBndjRLbkxVUVF2dDcwdkFvU0xF?=
 =?utf-8?B?VkZLemljSWY0U3dERmJVS3JKcjAwSGc5bVhOM2JJdFpWTWRhdiswNzY4ZGFK?=
 =?utf-8?B?cEtHbE5HUHhWTk1GQlkvdFpZb2ZoaWFLTzZwM0hVTmt0bnpoTFg3eEgzRkF3?=
 =?utf-8?B?aEFNVlRIUklReE9IREh6U3dON3Vjbm8rb3E4bWRqWlBNQVo2eC9MM2ZsYnBE?=
 =?utf-8?B?SEh4eGVyUFBRZ0lyMGU2TXdYTjZsdWJGcnY2T3p4ZVB3bVd2anBBSzlZTSt3?=
 =?utf-8?B?M2tCaEtBNWVyMVZmRGVsMEs0QUFuVk5RdXhMVFQwZG5zcTQ4OVBpRHppVDJk?=
 =?utf-8?B?UzNtV3RScnJ0VVp0MXdOTllaWUNPdXdyOWNELzlBTE56K2UvMndtZDZadTZt?=
 =?utf-8?B?djdva3U2SVd2dm45R3dqSFVSbDBmYzlFMXB3SWQ4MXJQa3I1cGNycHRzK2Qx?=
 =?utf-8?B?NmF2VzV0eHZDRXI5WkZiRGoxRFE3ZkI2ZkNkNEszM20yZWpMVkVWck5rWjJv?=
 =?utf-8?B?R25qUVlhbWR1USs3aUdNd3VURHc0MUs5NTJaSzB6KzBnd1lMZ3pjbFJhMHpw?=
 =?utf-8?B?aGZmWkY0Mi9pRVRhbTRWNldxc2IyOHBNVVFKOUhlakpRRXRYRG55aldOd3pn?=
 =?utf-8?B?YlFrTE4zTGozcDlZZXdBNitQdUZIK1haV2krRGg0andtbTliQzFFeXFhUTc2?=
 =?utf-8?B?MWI4MFFCTDdIdDByVy9mZ0ticGpBYm9rekxMMXRLS05rRWd4eHBQcG5zRm9h?=
 =?utf-8?B?SmNCQy9uYWFQR1hGcWRSRDRsMk5hWjFlZHVyVmJJcnB6NVNHcmw4UWFONllJ?=
 =?utf-8?B?bVJlUWpxUHpkdjcxN2pFKzVQTmNESS9yTC80REdQdUpkTGh1RC9xQ2dhSnRI?=
 =?utf-8?B?bzUrY3dYUkFJTFQ1M2RYRmhyV3c3MDhsYmRFZ0g1VWRBVktNbmFpemY0dUJU?=
 =?utf-8?B?Z28wNGhTdEhvUnZzVTY1ZnhMRVBZSzVmeWh5eVppZXFvZCsya05xS2liMEMz?=
 =?utf-8?B?R2J3QzFxTnJoSzVyUitmZmIyRGRHcHE2bVNKbDAwSGk4aVNnVS9CcGhOQ0ZI?=
 =?utf-8?B?SmpHbGFLdHBYSm5IUUtYS1NUT3RZZWhmcmhwQUVNSEF3S0Z6YkdBdEhjT3Zh?=
 =?utf-8?B?N0tNSjZub0w4UzR5emNwU05tdHV2MTVsTDliMlVXbWdhVDBhQ3hNWHpoOWxR?=
 =?utf-8?B?R2JiR2V0aENDdmhSV3ZzUUVPZnV0dUZ3ZEVlK3MvbkdpYS9xVXJqQitYamdW?=
 =?utf-8?B?K3A3WExYZVY2T0o1V25oQTJaU2h4U0FhMUhWTzMyTklBYXhObGJaY1RRQi92?=
 =?utf-8?B?OS9SVE4yckxuc3Rtcnp2a1VrdlBRWnhSTFRza2RZbVRoRWFScVB6eEMzVWN1?=
 =?utf-8?B?NUdOSFYrVHREcEpNbmE2eHByeVVVNnowV2JrcnZlN1llbWZhWkVvMTA0NGtQ?=
 =?utf-8?B?Q1JjTC81cExDUVB5SDJmc2RjTjhsbHVkZjFGei9lSGxKOFE2cVF4Q3NzMWQ5?=
 =?utf-8?B?UUMvQ1Z1Q1ppSExWMkRKcWc2a3BCeWtObkVOYUNFOENTQlVmSWZKSDhwNjFs?=
 =?utf-8?B?aU92bWduSi9sNGsreWtyZmxlVnNYTFRkZ3FVSlhic2t6bW4rU0d4Y2R6cExi?=
 =?utf-8?B?aTZ0NGxiUmd4dlNhZjIwcHlMQjRBMGVLVGgwczJONHoxSTYxS3dsZkFtblp3?=
 =?utf-8?B?QnpweDllZ2tMVDJtN1hiUzF2MDhYUWhYcHJLWGhUL05QUWU4OSt1a2NSYS9Z?=
 =?utf-8?B?SWtuRlY4cmd2blZabVAzUXQwTFk5aGhjT2doYUV6NWJlZlVldFMzU3ArcS8w?=
 =?utf-8?B?OXlGOW9YbmFkUzA1ZFBzTkpaeUEwdEpEUnp5anlOckxyamVDMEM2UGtDZDlZ?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bnMQWyKIu3LuZAcGB1AzRMJxznRQYtTxre/Ug/ihrmnjMTa3i6u2HaPPkNUSVASB3d+riqfR1zdy6z0Gc9wIzb22a4dItXzVLppQoKguvu14Gx6+XOlZQEaNWIOpenqOEql44RtjDvv20/CilpKbkcPPE5mAO+SbJMjSPncXyu8krViXOnkQ+r7TipJvzTvPP8W4HCUDd/rnVg08dmsewWxUr7v9MoX8mjGmBNqldFgy70y0EEefMYYOx2OJFirHCtxL2HuBh2ozqKYV7p0I+aia1yEUwkbVSdomp6u55yVbW012qZPbwpN6SIjvIRQd7ns6NBeh1Ia5ZNPFakHs43pG7/gcSMum25harfSQm6tfZpyQo+pwSKlofv+XZnvfteKe1leh4sypyDrl1QMmJy5d/+WRxchPUtew1JDF47/kKuWKP0Gd9FRLn7YgAigdrXGxPAT3XW1WsNgldrfmWi4ZnyEBln8PnSCLnq7bzXiEHJjoI4IBOMdsGLe6P6SnEhq92CzBYxeLauTRXq6fjSEYGWS6bdJmyxddUjmTsFvqtJq2su31UBVBA/5JGVZXKG+mtjkJ4pjQh6P+A9rJvT5ZjTJd4gezxJ9ignJWom5ddsUr/CqckxWZalQnIR4lkFkr7H6TDdKl2AoEu/GaziVugicSmptnhpHJY6X/zaz0nwu1wDEJCkFeQQVpVSPSDLzYzYiVZYa7WBdtd6vzSjVQxWcks8AW/r8kb5KvZ7G71edPz3MBgIzSUa0POp5EkCyS3qiurj6/sokTVFKnV8TVUJ9J+zjOh7tZDg37q0CXjl9cHDiyzbnlnWz/LNWF
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056a7361-0bd3-48d2-7e02-08db7bc52859
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 12:58:11.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuhg+/f4wJMTiEU+EdgiBOeMZ3Id32k6u4NkrHiA6Octz1kX0bww0fGQjYPL8FGLfRroVZ2BgaxHb5+UJ6yxnsMZwn2Lz7r3BGctsxEdQSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6059
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 12:58:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12182

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogTW9uZGF5LCBK
dWx5IDMsIDIwMjMgNDoyMSBQTQ0KPlRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVD
IE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRN
SUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlh
c2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8
s+KXi++8re+8sO+8lCkNCj48a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj5TdWJq
ZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIHYyIDUvNl0gc3F1YXNoZnMuYmJjbGFz
czogRml4IGZpbGUgdGltZXN0YW1wcw0KPmFyZSBub3QgcmVwcm9kdWNpYmxlIGluIHNxdWFzaGZz
IGltYWdlDQo+DQo+T24gMDMuMDcuMjMgMDg6MjIsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAu
Y29tIHdyb3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10
c2lwLmNvbT4NCj4+DQo+PiBUaGUgZ2VuZXJhdGVkIHNxdWFzaGZzIGltYWdlIGNvbnRhaW5zIG5v
bi1yZXByb2R1Y2libGUgZmlsZQ0KPj4gdGltZXN0YW1wcywgc28gc2V0IHdpdGggdmFsdWUgaW4g
U09VUkNFX0RBVEVfRVBPQ0ggdmFyaWFibGUgaWYgaXQgaXMgc2V0Lg0KPj4NCj4+IENsb3Nlczog
IzY4DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9z
aGliYS10c2lwLmNvbT4NCj4+IC0tLQ0KPj4gIGNsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcyB8IDYg
KysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9jbGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MgYi9jbGFzc2VzL3NxdWFzaGZzLmJiY2xh
c3MgaW5kZXgNCj4+IGIzOWJlMGMuLjQ2OWNkYzUgMTAwNjQ0DQo+PiAtLS0gYS9jbGFzc2VzL3Nx
dWFzaGZzLmJiY2xhc3MNCj4+ICsrKyBiL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPj4gQEAg
LTMxLDYgKzMxLDEyIEBAIFNRVUFTSEZTX01FTUxJTUlUID89ICIke0BpbnQoZ2V0X2ZyZWVfbWVt
KCkgKg0KPjMvNCl9Ig0KPj4gIFNRVUFTSEZTX0NSRUFUSU9OX0xJTUlUUyA9ICItbWVtICR7U1FV
QVNIRlNfTUVNTElNSVR9IC1wcm9jZXNzb3JzDQo+JHtTUVVBU0hGU19USFJFQURTfSINCj4+DQo+
PiAgcHl0aG9uIF9fYW5vbnltb3VzKCkgew0KPj4gKyAgICAjIFNldCBmaWxlIHRpbWVzdGFtcHMg
Zm9yIHJlcHJvZHVjaWJsZSBidWlsZHMNCj4+ICsgICAgc291cmNlX2RhdGVfZXBvY2ggPSBkLmdl
dFZhcignU09VUkNFX0RBVEVfRVBPQ0gnKQ0KPj4gKyAgICBpZiBzb3VyY2VfZGF0ZV9lcG9jaDoN
Cj4+ICsgICAgICAgYXJncyA9ICIgLWZzdGltZSB7dGltZX0iLmZvcm1hdCh0aW1lPXNvdXJjZV9k
YXRlX2Vwb2NoKQ0KPj4gKyAgICBkLmFwcGVuZFZhcignU1FVQVNIRlNfQ1JFQVRJT05fQVJHUycs
IGFyZ3MpDQo+DQo+V3JvbmcgaW5kZW50aW9uIG9mIHRoaXMgbGluZSAtIGFyZ3MgaXMgdW5kZWZp
bmVkIGlmIHNvdXJjZV9kYXRlX2Vwb2NoIGlzIE5vbmUuDQoNClRoYW5rcywgdGhlIGFzc2lnbm1l
bnQgc2hvdWxkIGJlIGluc2lkZSB0aGUgaWYgbG9vcCwgSSB3aWxsIGNvcnJlY3QgaXQgaW4gdjMN
Cg0KPg0KPj4gKw0KPj4gICAgICBleGNsdWRlX2RpcmVjdG9yaWVzID0gZC5nZXRWYXIoJ1NRVUFT
SEZTX0VYQ0xVREVfRElSUycpLnNwbGl0KCkNCj4+ICAgICAgaWYgbGVuKGV4Y2x1ZGVfZGlyZWN0
b3JpZXMpID09IDA6DQo+PiAgICAgICAgICByZXR1cm4NCj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1l
bnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KDQo=


