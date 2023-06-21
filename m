Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D3EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 04:38:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.4028.1687322301311293992
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jun 2023 21:38:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 35L4cHfT029487; Wed, 21 Jun 2023 13:38:18 +0900
X-Iguazu-Qid: 2wHH8MjPbfosrD1sph
X-Iguazu-QSIG: v=2; s=0; t=1687322297; q=2wHH8MjPbfosrD1sph; m=fweqtl+z/n39Jc1WLwDVvd0/YnhEYWG0RaVRpD5uCQE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1111) id 35L4cGr7018657
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jun 2023 13:38:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgCl2/cP7zkRIAXqZPjJMtuo9TsC9AOHfuzEeKhuMKwLorcGjTouDjVQvT6ofyziVeT9AoVXgn821ihCof+9W/7GR+74jBhQHm3pvCZlX0H/Y+DGnrG5rGV+XWNPjp5gnoB4KmZ1tE2L4Vv/XxmKL1quMQh9VFZog1mTCalQxVl/7tEOI/pSIwcfkgnpUHPhDXg0nv2YizD/k5LXEcGmn5SPpk6Fr4DtGeEHgouInFCQPMX4MFMJldUDijGrvSlBwiohmR9di/7DrnnshUQuvBo57HSwxctx4WiWrKF08yM1JYxidn4uK5IjJCfWOCXzfa0GoIbbP2xtFRHk9DbsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dVDM60M/5bgFnHZvH3VKvp1FkbsFfDOlW+czHFeBeo=;
 b=cexictRH1iVtlyYNLOFe8AHkzv5y7ssOftlRgB8NlsgLUf0EocyLYa3lVrzi8BSpp3vYQmnymxuuEXOdBP2LXUa34z4fmVKoKUoKHgFXwTqmfgDm1SO9DZOZbUff0C6AFhYqcMRBOSMXTRwUWqrutAOUe00q8NTfICaXHfIic+7AoSKogEphtUqlnH0YqTi8FBm10Z5acbV4An11oe4kKgotEvW4F8GnGAEQEUcPDa6YNY+xkm5fQu0DgI5dJV8g5bH8F06fibu1qcTLupjmkLbqi0zLoTQ/LkeK1kDLN73XbCig02NUE2iyT+2F1Z1ZnKWyJjlsKjRkv3wb5Qb2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] kas-cip.yml: Update isar reference
Thread-Topic: [isar-cip-core] kas-cip.yml: Update isar reference
Thread-Index: AQHZo38XPHqaDc6vPE+PMcz3kwZRka+T61gAgADBaVA=
Date: Wed, 21 Jun 2023 04:38:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542073E3F04E9344EBD420EA45DA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230620135657.4585-1-venkata.pyla@toshiba-tsip.com>
 <ab761cf3-2792-b05d-635a-fd5ff5a7991c@siemens.com>
In-Reply-To: <ab761cf3-2792-b05d-635a-fd5ff5a7991c@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB10760:EE_
x-ms-office365-filtering-correlation-id: 32c4a305-9e11-4565-15c0-08db72115394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /8tCezbvUwMgXgNToidvnOd3FL8mbPIDHUII/k/j9O42nTnIuFRS7mZTYc3wOlkB67m58bhNgxFLft0kq0c9qKjkPbDU6uoKBbUT+S+UY2+8m1XNYRJqA0cQdpqiEQiTYET5Pr3VpiujXH7noWV4mfTWxGZAXKzwA58drEOpGqGoHFVFlNl9JuNWMiMMwNK529vBqBOkOtS91FE905P/eusxORYr0VlmtoA7pvr7ohOdsrO68ttV6H3Khr1hJegin+MVxBSfz3xUi7PYB4yu0aMzIM2y/mwd1TMVycvHtcO6dLJ4MTGn3IQhbBOfSz3TU4rHg3tN6PkEzfocw52v0q/z+FnurKMb/RE7Zi9z1QRd2om6k0vOvZ6wZSw7dZs2X+1mj0LtN6tcKiP+1raH6d83uIHUQeOfNbTrFVGQKVFLBwenZXiFdU0mZSyV0aYQG/KGmSFRGOuKjFpCTAT8sDid3MivlLQmPLy1mpCAFizCsujLOM2gQolRBNZGQB9/qHh5D5K5KJzMILasEv/6dL4wpY58yRe5o57uJ0QBANcg5F6bk1Mfc9tQWlB/3lts3BPMakctAM7Ak9Dhe+zWFTi27Wjwy7NoLGRntmKyVJE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(33656002)(85182001)(52536014)(5660300002)(8936002)(66476007)(38100700002)(38070700005)(66446008)(41300700001)(8676002)(66556008)(4326008)(64756008)(122000001)(86362001)(316002)(66946007)(55016003)(76116006)(107886003)(966005)(9686003)(6506007)(26005)(186003)(15650500001)(2906002)(7696005)(478600001)(71200400001)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c1lxYmtyOTdBSThKNUdmQ0c1NEdmR200ZUNScXZEZ0FHTENaWmdMZk43UE9m?=
 =?utf-8?B?ZWRDM0R4NFViNG1WYWxpM0VEbitsckMzZHRPS2tLVDEwZmdOamYxVG9ubzhZ?=
 =?utf-8?B?dTRGSk1KLzV1cnBxWGFRcm9DUW1MZk9MK1FnY2dMQ25aQU50cUdkMzJhb2Ur?=
 =?utf-8?B?dzBrbWs3Z3Y3RmVuemdqQWZoaWVDL3N2TGc4aTdWb0l2SGNhanJhUGJ1eEQz?=
 =?utf-8?B?a0JvN04vSHRvMWc3MjUxVHRNUlArNmtwYldKMXBpeEl0a2s3dVY5MEw1TzRR?=
 =?utf-8?B?eFFGVnNscDZaV3IvdEZ0dmJsMnNlamZpZ0hzc1N5clRFVlV6QWN1Mlk5TXAr?=
 =?utf-8?B?cEVIc0p3UHBMRDU0b0VJS01aMDhoMGNaRHBzWUVoM3ZlTHNic0tPUUUrZlJR?=
 =?utf-8?B?V21aK1lnWTdMRlZ3R1RWVDBNcjQ5K3FDcmcxYnZ4cTdGWmJOc2tacmxoaXdy?=
 =?utf-8?B?SVB2U29mL0x1NW1CcEVZVDBJMzIyVlRnaUFhMlQzRVVnQ2pab01ES0ZvWE5M?=
 =?utf-8?B?QkgzSHdCc2x4ME5IMGgzZVdnOFFQR3VMb1ZQWmFGU3VobzVNYVdHNnlzYi9l?=
 =?utf-8?B?NnF4MzNPZ1lrSnJwak1qdWlzeGR5ajFNbnk1d1JwbHVmNFAxb3U4YlNaR3Iw?=
 =?utf-8?B?cjBVRTlmekloNVVyaUlJc3VMd2R3MXZrYW0wZkRidlZXOStLbDhzbHA3WU9s?=
 =?utf-8?B?Si9hV2pWYkp3M0NJQVhIeXlpcjEvVVpuNmNuTEpwWUdqS3JFVnIxMmZHcGRY?=
 =?utf-8?B?MFJhd1NsMmYwTlFmV2FuZ0JmaUpYZGZxemxSNHBZbWpwcStla2M4KzFXSTVH?=
 =?utf-8?B?YlVSVG1PS2V3MWFqRUhNWXpEVGJraElEcm1VQzdyc2ZrQkUxNFlBWGVKRnBC?=
 =?utf-8?B?SmtGT0RoclpJU0RIVTN6dzUwOGlKanRtbXJqRTh6aEY3UlJheVh5Z1pJMkR4?=
 =?utf-8?B?VjBiK0YvNGdKWEtHUWd0Z2FjK21SMTFwUFhMQzUvb3JHRXdwMTZJUFdocktv?=
 =?utf-8?B?R2d3RytoOGRaQ1JZN2Yyc3htSWllN2xyektwTWlWTWdpc0k0c0xvVCtnK2Jo?=
 =?utf-8?B?emtZV3JqV0RzN2syNGx6M0UxbnRGcktnV1JweTQvSllUQ0dISzAxelRRWVF1?=
 =?utf-8?B?RUowdVE2N1NENS9QazgzejRwdHgzUjBKZlVKOWRTaEZ0M0FIeTVEUUNDU1A0?=
 =?utf-8?B?UWJ4dWV4ZE14YkhtcVFxWkIwd1lQSG5EWGRZV2UybzIwTXZQU2s4anUwQUpa?=
 =?utf-8?B?NTNEbGFCSE5waVlUc2FrbkRNQjJuYUZFTWcxNVJNOU83MjNaUXNVOXBNUGl0?=
 =?utf-8?B?aHBEd2wyR21ZVzZkSVpJVjIyZWEyTnViTEJwdlArbllRbzV3ZGpOUDNYb2Ez?=
 =?utf-8?B?TFBETlBMekptN09WY0NYclVLRnYyaENnMlJ4VHYwNU94T2ZoSk13ZEhBazhQ?=
 =?utf-8?B?cmVQSDVpdWpiaDFHUDB0cStpSjlJclNQbXdvMTdDTXZRY3lQR1pORWMvVW14?=
 =?utf-8?B?RFVQeXpQQURTY2ZwLzMzdTFRTHZhSlNhMW8xRUpRRDU4a2JFWVdkc1JmeGp4?=
 =?utf-8?B?VDVsNEM1V0ZlbUh0RnJ0OUNGOFMrRVJSSkpINGlpSzJ1b3UreW1wVk9HTFpT?=
 =?utf-8?B?K2ZLaC9TQzBxQ3RtMHZ6aVByVS92ZHBCNkF1UENDTU92b3VGYkM0RWZzZHdK?=
 =?utf-8?B?U3gxS1g0WWNaZ2pxNUxVS3lFZzBrQkF6VncxT0ZXS2V2S3ArL0h4N0t3QzR2?=
 =?utf-8?B?UDZncXllN0xiU2RORStZOUw3OWttdFJzMVp2QUVMSkZZMkJkQTlrUk9acnpr?=
 =?utf-8?B?Zy9OOXk4R0Y3RmRKUFNNeXI5Y2pHcnJnZkNNV3ZYdFNLcGNYalZQdGZ5ZDZl?=
 =?utf-8?B?Uit5ZWV5ekxxY0pFdkwwRUk2R2lzMFIzMWVGSnBBTEZNc3IvZ2t0WVZpQUxB?=
 =?utf-8?B?aGxlSkRwMVlSTW5zNStXTmRFbmFxVEYvZDBIOXhnWDVIcytWMlRzV3MwdUFu?=
 =?utf-8?B?M3ZMU1U2TjBFNVk3cHJrUy90WDNuT0VmRFRGL29uUGpPckFtaUF2UThYL1JK?=
 =?utf-8?B?Mndoc08rTDVjZ3lPeTNTUzZNNTI1c25wQ3NjSG8yVkhwWURxd3BrNWYraEFT?=
 =?utf-8?B?U2p3MG8wVnlCNDg1aWFwYkhlaXFNWFE2UHRjQnB1QTZhWFAzV3pVL0w3OWNB?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s2LyE+LJPRy6flYgcaChS8sc3x+hQ1+MfiwbNhLk2ePSi+8zTq7qmVurHjrRZn6Gt4opXlCUFsCtn6/E6YDqf79ct4hJ0/795mpDvE+wG8BwOVqSDrSjazvsIHEAaXnzAAo/xlora1AP+eCv5Efq1o8Ee4w1IfTSSSaj1WD9AH/9kbTsAeaH3fOj4+pm1OeIjTC1SOzwVp66dugOzq5TazuzWnGAS5FSW1CaFkryCJ+8VDVE1Ij0xA+1eP7RDfO2vSVhOEXh3IOg9dssPcBmjgd5Vd6Q6gDTkB5tO63UcfwEeTaBSUtInL1Zn3RNoLCdYbV+uzoxW1L8/PnFLlmzExCabflZ6Uy/qXteOlEEp/OQZ9QcND+wYkxSHQU8D7PQ8enA3pHMDL5ztTlmEi9aBGp/OaWV5gyniKtVttWI8AZzDm9h5o0bz806W1HYxG4lXddv80dSK7lMYcvVzL6F+U3TtrNCwYTh2D9j3KmSMqTlcRQiH5/vV8/hp0Ly9Bqx5uSDYkomAYl9p6zhwv093wyu77tI34AABo1eghWKN0faIYtZF6p06UtL6tIiT5iB8LpHe3D9ScRO+XADwnCDI63LILtxHNakJ8O9Oxce5nU74TUDwGkqvaDjBUuJHOgKmP46D5CQCpxop2uNFSY3Hh/lz04bEMp0DL5TobM48CSnu7OqmC64CZ+4d7mNjTMdg4OexZEUGFX+sXx8tgkwjKPySAmmqa11DQSW8QBvSbdlO3rdz4X0qvM0lD7e33DcWfhVs8g/NIG4ClMl70jDf7dlLIIiMOmxvJKxHKKGyq8ng1U+wd9cPSB80wUs0lfX6gflGBsEJvYTkpaIVFfeVA==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c4a305-9e11-4565-15c0-08db72115394
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 04:38:14.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdiiXj/cJVnDPw1w0bntLx/PS6TF2aN279j80MtwiyMaD1YqGua3ReAVXyU2sNSiKBQzQ8u1hVX6vzSI0SnUPRU3OPD+I09D7bGj/8MLOCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10760
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 04:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12090

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVHVlc2RheSwgSnVuZSAyMCwgMjAyMyAxMDozNCBQ
TQ0KPlRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVu
a2F0YS5QeWxhQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZw0KPkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8
ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDl
kozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkNCj48
a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj5TdWJqZWN0OiBSZTogW2lzYXItY2lw
LWNvcmVdIGthcy1jaXAueW1sOiBVcGRhdGUgaXNhciByZWZlcmVuY2UNCj4NCj5PbiAyMC4wNi4y
MyAxNTo1NiwgdmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiB2
ZW5rYXRhIHB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPj4NCj4+IFRvIGJy
aW5nIHRoZSByZXByb2R1Y2libGUgYnVpbGQgaXNzdWUgZml4ZXMgZnJvbSB0aGUgdXBzdHJlYW0N
Cj4+ICBlLmcuOiB2bWxpbnV4IGZpbGVzIGFyZSBub3QgcmVwcm9kdWNpYmxlIGluIGNhc2Ugb2Yg
YXJtIGFyY2hpdGVjdHVyZXMNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiB2ZW5rYXRhIHB5bGEgPHZl
bmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPj4gLS0tDQo+PiAga2FzLWNpcC55bWwgfCAy
ICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2thcy1jaXAueW1sIGIva2FzLWNpcC55bWwgaW5kZXggYjZhM2Rl
ZC4uNDU0ZmUwNCAxMDA2NDQNCj4+IC0tLSBhL2thcy1jaXAueW1sDQo+PiArKysgYi9rYXMtY2lw
LnltbA0KPj4gQEAgLTIyLDcgKzIyLDcgQEAgcmVwb3M6DQo+Pg0KPj4gICAgaXNhcjoNCj4+ICAg
ICAgdXJsOiBodHRwczovL2dpdGh1Yi5jb20vaWxiZXJzL2lzYXIuZ2l0DQo+PiAtICAgIHJlZnNw
ZWM6IGY5NWY2OWQzYjgzY2MyODk3NmVmODFlZWVmYjVlYzVkZDE3ZTU0NGYNCj4+ICsgICAgcmVm
c3BlYzogZDJiOTYxNzQ2YmU3ODhmMGYzNWY4Mjk3ZWQzYThkMjI5MjcwNGE0Yw0KPj4gICAgICBs
YXllcnM6DQo+PiAgICAgICAgbWV0YToNCj4+DQo+DQo+SXMgdGhpcyB1cmdlbnQgdG8gbW92ZSBv
bj8gT3Igc2hvdWxkIHdlIHdhaXQgZm9yIHRoZSBJc2FyIGZpeCBbMV0gdG8gbW92ZSB0bw0KPm1h
c3RlciBvciBldmVuIGJleW9uZCAodGhlcmUgYXJlIHNvbWUgY2hhbmdlcyBjb21pbmcgZm9yIE9Q
LVRFRSAmIENvLik/DQpOb3QgdXJnZW50LCB3ZSBjYW4gd2FpdCBmb3IgaXQuDQoNCllvdSBjYW4g
aWdub3JlIHRoZSBwYXRjaCBmcm9tIG1lLCB0aGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbi4NCg0K
Pg0KPkphbg0KPg0KPlsxXQ0KPmh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9pc2Fy
LXVzZXJzLzg5MmM2ZTM0LWJkODctMDRmYS0xMTU1LQ0KPmRhZDNmZDA2MGI5MyU0MHNpZW1lbnMu
Y29tDQo+DQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50
ZXIgRW1iZWRkZWQgTGludXgNCg==


