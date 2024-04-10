Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F55CD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 09:23:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.162568.1712741027931787117
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 02:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 43A9Njto3246523; Wed, 10 Apr 2024 18:23:45 +0900
X-Iguazu-Qid: 2yAaJS4wpJEmBxZP1c
X-Iguazu-QSIG: v=2; s=0; t=1712741025; q=2yAaJS4wpJEmBxZP1c; m=5YNgNuAeQOOKirm62HHGeDWayLF7jIvZHcNUVkFEDZE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 43A9NieC2285315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Apr 2024 18:23:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwvLehkv6/RApE8f7nEV8Vc/otHq+IU04vf9uDJ4SSJTRXlVr/rl7eE721hUm2XRLMtizpLcKrQnzGhved8hPty17g6rHZDwLFWgHaWvNN9cLKYtNRjxN7Oz3TC9p/CuaLQxj1DsO9mL//n5gsZ1SA/eK8SqNBJ7J3DMeoqPc07QD32eupWuzWmI/sYk1K1l4E0ab+HthPNjnyiUI6BbeHY0Ji4e7fFPvEtRPaDLRK7iYxr7TBthdXso5IgBGDDgSi+ETNKJMABribSl4K9McU15hACKnvTf9SupPrQ8ciE+gccdl1qlg4Lh3CbHXye9FP2FnO3N/kXRMjWu3FvbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHIczse33UABtGpUrvHWHOqYeEJUIuZSvBwYzODPI7c=;
 b=An5ZEIoIRqY3+PgkMyr6z1o2V8yKPkWN/4t8GQABVImire5RNnceuAYuopOClLRMOB31q/fEv4GKhsGc06UsYOd7D+vlMqxXo8hqw4JrUXYsCxdg2WTAyBQA1fHt3DeKT5RdXrU6bSF/KpsS9vN3E7hj9eZ1DdM2oLSywTUrw2PuyGHBPhizRMC9yzhuTevDa8nylpmqdf6tn/WpJ9aHlGfjAw5i1h6rMHscknPBMs+5Ejb8HirOBaOxB0/XXgmy+VFK6LIY3kbzKQrtQSBZC7n20bbCOV131RS88QM6waobdPojHsXS4izdgZjjxLNtQ7C0/Yj3Ruf/t4VT/2j85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <quirin.gylstorff@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
Thread-Topic: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
Thread-Index: AQHaerHSe19+xmZFFE+crratI6WvNbFecmYAgALX3LCAAAbEgIAACj8w
Date: Wed, 10 Apr 2024 09:23:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E5691C80A28F3BD65BC5C4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
 <ed0c8463-e04a-4a70-9954-54640fdac205@siemens.com>
 <TYCPR01MB966987E730E8F8D621DF564AC4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
In-Reply-To: <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB6168:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PD6mjzcocvvzbNlHSAKI16DYZDoFjy+4Wsr+cSYF7nuo3hqUMxak9seP21krtdZyO85mN6Tjl/pFXgWjshX440NmavoFRzWs9e7sqGJAVnYr885jb3tHqfxOgnmvJLKV9ZjjdnEpN2PTMMM5tTjvy9BF/t3zMsX/Zfk087eYLpeGmnJi0BJjIiysxIDwTJnvsSK7XoGOQjfyso4bt//uAJQLUtgnQ1U43nUdk7hUInNUCAMj0QuJXd07QpPJXtM+H7Jnmen6zQ9ieEk0BOeT6vLQmFgwMtTo6BWzBxvg6+h3Q54hdxGKiC4BpH3xLXrpEmri6MGBuEjowq/kKsF1sRBeoazudFMQB8yYul43gf2Bo8qMPDiFwOaqwkzcNdzeBEMG9/211b5IV7oRVolXpA/VwIzCkEKVJ034Y+D5qcO294tSG6VmvX6K8mxavwN7tSMVVQMmqq/xBD0Lup+b2Bum2u9qBB/TXdefJDiLYgoUnL9bJ74WhEiJQBPjBn2fA0rOcJwVels0NFrdTEhwDKsZiY6UqtdrBd40DxFTQzKtc02X8lPHBQoTH4Kzu407lloGA1bFRmPXz5/laEyDc5ICwoVsXLTKpOs593J6DrMC8ie7FrtzPQOqwJGxG8pyGkgZxkHgcumUgQV4XqbLXAv6k8NbjYWxhWqoxTWlknM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkViWW1rQlVVZHFjMUJJczI4SlJ3TGpWTjhxSWpLM1BxNmcxcnkrckRKelhP?=
 =?utf-8?B?T29SZmRyRk02OUtLMzYvdmVPWVVLZ1E3RFZJQU5RUngwdUV5RVVpaVNodUsz?=
 =?utf-8?B?d3BvZXlXbHhqTHdKdHVGQ0FSZ3JrWTM5cC9pVEo5TFB2eTc2UkY0ZjVpbjRo?=
 =?utf-8?B?akE2YmFmRDBaazFXbXJGRDFSRXd2N2tIelZXc2paVW1SVjJLTmxSbVdOTEpw?=
 =?utf-8?B?dlRnR3VWejFhZHNLMW5FOXJBZ3R1cXBoZzJubWEvNlpEYnBhb1lQN2w1eVZR?=
 =?utf-8?B?NDYwcjJJWVRiVnhxdWxYTFA3ODNmdFJHY2VDbk9ybmEyQWhsMVhYQUpRNFJm?=
 =?utf-8?B?bzBVZE9kb0YzSUR2RkNLTHFsam0xNjdhWC84VzgzVlN1SmtzL01pWGdpTEND?=
 =?utf-8?B?WGZGNVJSM1UxNDNTbkZ1eUdraUtlVTBwcSs2RHdER3ZRT3ZGaFlQdFhDa0cr?=
 =?utf-8?B?U3ZpTXdjV2t2V29iTTZIanJYQjFrelVqZGo2K3hkT2NvVzZpdGJzcUJ3aFc4?=
 =?utf-8?B?ZTNyRXBFTkNMSE85WGlJUUg1Yis2YWt1ckpOcUxyRWgyTDlwUmg0YUFocUdq?=
 =?utf-8?B?Q1E5MVBxOERDZStHZ2YxMXVnNHBMRWZYU1lPSWVZeEN0bjRHUHArdEVxNUxK?=
 =?utf-8?B?UTJtZXlORXhQbGg4eEZKcnRIZ2N1MXRuZDJjWmtoN21BejgzYkQ5ZlhGRDN0?=
 =?utf-8?B?WDkrUjl0OGFLRkNLaUptR2hMbGc1WHVnakMrcGFhVjlsOXdwSEJDT2k0UzRu?=
 =?utf-8?B?LzVPNlp3VE51MFpvekprL25jbHlEUU1wTVA0dUlwQkN6YVRrTlNpaDV4T0la?=
 =?utf-8?B?cGp0V2tNYTl1Rk9uKzJ4RmVnN0wzd0xLNFR2YmNGWVZ3RDQ2c3V1YVE2bllJ?=
 =?utf-8?B?ekhGZG54anNFenJPeTBrZ3VWdVNJU21mbjZMai9lTDJkMlNJdU80dFZ6WUsw?=
 =?utf-8?B?UlpuOEpld0Q1MmNqdTNSNlBNSTJ1cjNNSFd6UzNYZ2pDODFBYTIvNUM5NjNy?=
 =?utf-8?B?dUhmOHI4UTRRKzJYVTJMaDBOcGl5SkhneGd4bzZDQkxscEplTnRRZnJabldm?=
 =?utf-8?B?eUNjMFRoVGtzZGZmcWloSnVGZnZJdlFRTlcxL2pveng4NnUySUZKalRoeFNz?=
 =?utf-8?B?dHRPR1dvWHd2c2RQTU50RW9kRkJxeEU3eDBKL2YzMmpVa0w3RUJkNGFKdFRJ?=
 =?utf-8?B?MTh3N3JHUU9LRUsrMVBwUHk0VGFTTjRjOGhsOGZ0NmhMcEdwL0dxdklPL3A1?=
 =?utf-8?B?MjhaZW84b25zaHRUQk1WSlBSVUpnc0twTVN4SWt0NTBwdGUwS3VUMkFZK2NW?=
 =?utf-8?B?UjBlNmZJcjgyTCsxN0UxNnZ0OUJJUy94TDdaUTVjK2dmZ3BJaDFib0JxWGsy?=
 =?utf-8?B?RG5JWHlWUFVaT0lKTm5oL21BaGFicmRic0Z5Tlg1RS9YUGJ2L3B1WUFZRlBm?=
 =?utf-8?B?a2MwaG50YUtKOVFFYzhqeEVtNW03TnBVYWV1SXNUb0ZCRVo2U09ZK3NMNXRk?=
 =?utf-8?B?TWVLNERselZVVGplT1NYM1FLRlBNS3JUa24zM2M4UFhjRHhUQm1SdGlQWENQ?=
 =?utf-8?B?V3lZTXNOcDFob1AyT2dYc0hJbFovcFQzVG93RmFJb1Q1YmpqdHR5SE4rTXF0?=
 =?utf-8?B?N2JkcENkMVdqRGpnNU5UK2tEK0Y0NnJOOUVZb0xmNklPSFlUQ0ZObFZDWUoy?=
 =?utf-8?B?YzVxNm84WlZYcG1xazMrNElPcGYyeDRHM3ZqRkp5c3pDeTlQOVpiRG1aUFVt?=
 =?utf-8?B?dnduTFAwWWt0VEs3eExGVFpPN3grZUViRGNMbkFDM0d1dmRkL1JjM0laZEpu?=
 =?utf-8?B?VE16VlZENTk4K2xlSitBUVZ1ZkFOcmdnQ21TZ3NWV3RHYklRWjRiQzNUcDdE?=
 =?utf-8?B?aFpqSFo4Tm5JRG01VElBV29aNHlicDN3TTAyaHE3SEd6bXpzVnN2MGdHajdq?=
 =?utf-8?B?VWcvYXRKdDZYOTJ5YkY0THNpLzRmdHQ3T2VUN3NNM3E2MkxPM2RPT3RZa2VV?=
 =?utf-8?B?SGFRcERHeGlrSEdMZldWZjZtKzVNVWcva2tOamZzdU9TdERBeWsxNXJzSS9Z?=
 =?utf-8?B?OWl6UU1sSDJWNjQxcC9DMk9nYnNpVEpZRTcrcXExVjgrK01xVWZmSnBkQkpy?=
 =?utf-8?B?THQ0NGRwRldCZzROSU9mZWJRM3orbjc4azRMcnFXRnc0NjdOaHBCT21XVEZI?=
 =?utf-8?Q?i0xU2dmFZ4I41Sc0SRRmbIk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e87cd-e0a8-4980-ebd0-08dc593fea12
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 09:23:42.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbmNvw9mybCJgCWkbzEuSDaSTecgJL/IKUKl1wum9UBCnP6rjN0JBEWvYC2WRquT7j7FKcCOaPHiZgPofgYzEWr4Qv4ueVemHNGHCWFYkC7h3iIVEdBkdSxccLTGPRmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6168
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 09:23:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15532

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTAsIDIwMjQgMjoxNCBQ
TQ0KVG86IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVSKSA8QWRpdGh5YS5CYWxh
a3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBx
dWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tDQpDYzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTv
vLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEt
dHNpcC5jb20+OyBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVqb2RhQHRvc2hp
YmEtdHNpcC5jb20+OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5n
KSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDl
kozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkgPGth
enVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtp
c2FyLWNpcC1jb3JlXVtSRkMgdjIgMi80XSBBZGQgRGVsdGEgdXBkYXRlIHN1cHBvcnQgd2l0aCBy
ZGlmZl9pbWFnZSBhbmQgZGVsdGEgaGFuZGxlcg0KDQpPbiAxMC4wNC4yNCAxMDoyNywgQWRpdGh5
YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gDQo+IA0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIA0KPiBCZWhhbGYgT2YgUXVpcmluIEd5
bHN0b3JmZiB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
OCwgMjAyNCA2OjI1IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgamFu
Lmtpc3prYUBzaWVtZW5zLmNvbQ0KPiBDYzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnv
vLAgVE1JRUMgT0RHIFBvcnRpbmcpIA0KPiA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRz
aXAuY29tPjsgYXNocml0aCBzYWko77y077yz77yp77ywKSANCj4gPFNhaS5TYXRodWpvZGFAdG9z
aGliYS10c2lwLmNvbT47IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIA0KPiA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBiYWxha3VtYXIgYWRpdGh5
YSjvvLTvvLPvvKnvvLAgVEVVUikgDQo+IDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAu
Y29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSANCj4g4peL77yk77yp
77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcD4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV1bUkZDIHYyIDIv
NF0gQWRkIERlbHRhIHVwZGF0ZSANCj4gc3VwcG9ydCB3aXRoIHJkaWZmX2ltYWdlIGFuZCBkZWx0
YSBoYW5kbGVyDQo+IA0KPiANCj4gDQo+IE9uIDMvMjAvMjQgMTE6MzIgQU0sIEFkaXRoeWEgQmFs
YWt1bWFyIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6DQo+PiBzd3VwZGF0ZSBzdXBw
b3J0cyBkZWx0YSB1cGRhdGVzIHdpdGggcmRpZmZfaW1hZ2UgYW5kIGRlbHRhKHpjaHVuaykgDQo+
PiBoYW5kbGVyLiBUaGlzIGNoYW5nZSBhZGRzIHN1cHBvcnQgdG8gdXNlIGVpdGhlciBvZiB0aGUg
aGFuZGxlciBmb3IgDQo+PiBjcmVhdGluZyBkZWx0YSB1cGRhdGUgYXJ0aWZhY3RzLiB6Y2h1bmsg
YmFzZWQgdXBkYXRlcyBhcmUgc3VwcG9ydGVkIA0KPj4gb25seSBmb3Igc2lkLg0KPj4NCj4+IERF
TFRBX1VQREFURV9UWVBFLCBERUxUQV9SRElGRl9SRUZfSU1BR0UgYW5kIERFTFRBX1pDS19VUkwg
dmFyaWFibGVzIA0KPj4gY2FuIGJlIG1vZGlmaWVkIGJhc2VkIG9uIHRoZSB1cGRhdGUgdHlwZSBp
biB0aGUgc3d1cGRhdGUueW1sIGZpbGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdGh5YSBC
YWxha3VtYXIgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+
ICAgY2xhc3Nlcy9kZWx0YS11cGRhdGUuYmJjbGFzcyB8IDEwNyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gICBjb25mL2xheWVyLmNvbmYgICAgICAgICAgICAgIHwgICAy
ICstDQo+PiAgIGthcy9vcHQvc3d1cGRhdGUueW1sICAgICAgICAgfCAgIDUgKysNCj4+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgY2xhc3Nlcy9kZWx0YS11cGRhdGUuYmJjbGFzcw0KPj4NCj4+IGRpZmYg
LS1naXQgYS9jbGFzc2VzL2RlbHRhLXVwZGF0ZS5iYmNsYXNzIA0KPj4gYi9jbGFzc2VzL2RlbHRh
LXVwZGF0ZS5iYmNsYXNzIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+PiAwMDAwMDAwLi44
NDQzZjM1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9jbGFzc2VzL2RlbHRhLXVwZGF0ZS5i
YmNsYXNzDQo+PiBAQCAtMCwwICsxLDEwNyBAQA0KPj4gKyMNCj4+ICsjIENJUCBDb3JlLCBnZW5l
cmljIHByb2ZpbGUNCj4+ICsjDQo+PiArIyBDb3B5cmlnaHQgKGMpIFRvc2hpYmEgQ29ycG9yYXRp
b24gMjAyNCAjICMgQXV0aG9yczoNCj4+ICsjICBBZGl0aHlhIEJhbGFrdW1hciA8YWRpdGh5YS5i
YWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT4NCj4+ICsjDQo+PiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogTUlUDQo+PiArIw0KPj4gKw0KPj4gK0lNQUdFUl9JTlNUQUxMOmRlbHRhX3VwZGF0
ZSAuPSAiZmRpc2sgemNodW5rIHJkaWZmIg0KPj4gKw0KPj4gK0ZJTEVTRVhUUkFQQVRIUzphcHBl
bmQgPSAiOiR7TEFZRVJESVJfY2lwLWNvcmV9Ig0KPj4gK2RvX2ltYWdlX2RlbHRhX3VwZGF0ZVtj
bGVhbmRpcnNdICs9ICIke1dPUktESVJ9L2RlbHRhX2ludGVyaW1fYXJ0aWZhY3RzIg0KPj4gKw0K
Pj4gK0RFTFRBX1VQREFURV9UWVBFID8/PSAicmRpZmYiDQo+PiArREVMVEFfUkRJRkZfUkVGX0lN
QUdFID8/PSAiaW1hZ2UtdjEvJHtJTUFHRV9GVUxMTkFNRX0uJHtTV1VfUk9PVEZTX1RZUEV9Ig0K
Pj4gK0RFTFRBX1pDS19VUkwgPz89ICIiDQo+PiArDQo+PiArZGVmIGRpc2FibGVfZGVsdGFfdXBk
YXRlX3Rhc2tzKGQpOg0KPj4gKyAgICBkLmFwcGVuZFZhckZsYWcoImRvX2ltYWdlX2RlbHRhX3Vw
ZGF0ZSIsICJub2V4ZWMiLCAiMSIpDQo+PiArICAgIGQuYXBwZW5kVmFyRmxhZygiZG9fZGVsdGFf
cmRpZmZfcmVmX2ltYWdlX2ZldGNoIiwgIm5vZXhlYyIsICIxIikNCj4+ICsgICAgZC5zZXRWYXIo
IkRFTFRBX1VQREFURV9UWVBFIiwgIiIpDQo+PiArDQo+PiArcHl0aG9uICgpIHsNCj4+ICsgICAg
aW1wb3J0IG9zDQo+PiArICAgIHBhdGggPSBkLmdldFZhcigiTEFZRVJESVJfY2lwLWNvcmUiKSAr
ICIvIiArDQo+PiArZC5nZXRWYXIoIkRFTFRBX1JESUZGX1JFRl9JTUFHRSIpDQo+IEkgd291bGQg
c3VnZ2VzdCB0byByZW1vdmUgTEFZRVJESVJfY2lwLWNvcmUgb3IgcmVwbGFjZSBpdCB3aXRoIGEg
dmFyaWFibGUgYXMgaXQgbWFrZXMgaXQgdW51c2FibGUgaW4gZG93bnN0cmVhbSBsYXllcnMuIFRo
aXMgY2xhc3Mgc2hvdWxkIG5vdCBjb250YWluIGFueSBjaXAtY29yZSBzcGVjaWZpYyBlbGVtZW50
cy4NCj4gDQo+IFtBZGl0aHlhIEJhbGFrdW1hcl0NCj4gSGkgUXVpcmluLA0KPiANCj4gSSB1bmRl
cnN0YW5kIHRoZSBpc3N1ZSB5b3UgYXJlIHBvaW50aW5nIGF0LiBDb3VsZCB3ZSByZWZlcmVuY2Ug
ICJMQVlFUkRJUl9jaXAtY29yZSIgdGhyb3VnaCBhIHZhcmlhYmxlIGRlZmluZWQgaW4gdGhpcyBy
ZWNpcGUuIEFzIGluIG1heWJlIGhhdmUgYSB2YXJpYWJsZSAobGV0cyBzYXkgREVMVEFfUkVGX0FS
VElGQUNUX1BBVEgpIHdpdGggYSB3ZWFrIGRlZmF1bHQgYXNzaWdubWVudCB3aXRoIHRoZSB2YWx1
ZSBvZiAiTEFZRVJESVJfY2lwLWNvcmUiIHNvIHRoYXQgYW55IGRvd25zdHJlYW0gbGF5ZXIgY291
bGQgb3ZlcnJpZGUgdGhlIHZhcmlhYmxlIHdpdGggYSBkaWZmZXJlbnQgdmFsdWUuDQo+IA0KDQpX
aHkgZG8gd2UgbmVlZCB0byByZWZlcmVuY2UgYSBsYXllciBhdCBhbGw/IENhbid0IHdlIGp1c3Qg
ZGVmaW5lIGEgZ2VuZXJpYyBsb2NhdGlvbiwgbWF5YmUgc29tZXdoZXJlIHVuZGVyIERFUExPWV9E
SVJfSU1BR0U/IA0KDQpbQWRpdGh5YSBCYWxha3VtYXJdIA0KSGkgSmFuLA0KDQpEbyB5b3UgbWVh
biB0byBzdG9yZSB0aGUgcHJldmlvdXMgaW1hZ2UgYnVpbGQgYXJ0aWZhY3QgKC5zcXVhc2ggLyAu
dmVyaXR5KSBpbiBkaWZmZXJlbnQgZm9sZGVyIGluIERFUExPWV9ESVJfSU1BR0UgaXRzZWxmIGFu
ZCBwaWNrIHVwIHByZXZpb3VzIGltYWdlIGFydGlmYWN0IChpZiBhdmFpbGFibGUpIGZvciB0aGUg
bmV4dCBidWlsZCB0byBnZW5lcmF0ZSB0aGUgZGVsdGEgdXBkYXRlPw0KDQoNCkphbg0KDQotLQ0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


