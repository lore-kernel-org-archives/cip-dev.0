Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB1EE95A61
	for <webhook@archiver.kernel.org>; Sat,  7 Oct 2023 16:07:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.20621.1696694813831867604
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 09:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 397G6ove1071668; Sun, 8 Oct 2023 01:06:50 +0900
X-Iguazu-Qid: 2rWhH56rp0IrMoqmgK
X-Iguazu-QSIG: v=2; s=0; t=1696694809; q=2rWhH56rp0IrMoqmgK; m=D+GMzKQzreaIZUwBJVsyjjZJdHUHnTtXNUrmNKUwYgk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 397G6lPJ3694430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 8 Oct 2023 01:06:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkJ5wKWZXafMZQeSb5Wl8+Fx3P2sDxCJVc+AXBVazDk3awq9hBXwXSzpkq4ep4u9csjcKgPc0HbDC873cjyv1aa0CIw4x99WlAa3+KKOzjZvOaB9TJJtna5KARgfiGLHzOs6nqJiKxiC0RhrcWBo+65COpGFs6M9a2mBo13CJmQlZKk4nUAcl0pmqydJn0xNMTj1WDzwOK6qiV+r2UZw6GztCwiB2iti8Ugu9no+tcYL4y92GBI7H3QsWg1/3GFuAroRnm9e7iAg4l7DVogeA/p217W1TMwaFoi3ZRcDv3uwxiI1v2/Jh4NjYl+o3tRX5MPtVd8kHh/cRK85LUHxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRQAu4GsRVgqKyu4ngMM9QKHc4oqeVBq73uCuxEakMY=;
 b=CWOx9E4Htf7aERPAGvpVluIyU6lvJqAfVINBXr637xuuJUVlnKKBFFiMfKHhIc+jUMN+iQU0y1h4b/q7WtE6391eEjhf4V1H7UrNt4aEGwLRcYuwG/2oekn+oxHme61m/5/gWHRFR4NqsJCyVHNnCozLHGQ8BpktrW30PwLzW2u+EqTnulNTzrLkVO8VsUoPZ6bZ21xicwZ95Wl5nk866c16SKMUWpXBfElVlTHss9j71vFjOIoCFr62mwVYfNc+C8ek0ghltpNRkgPPlG4fiapeeR01GJFKj7+YRmnVMeHNfU2qeIqWfIkSxI0vSe8WSEVkb2DWQd08k9HpJIr8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <quirin.gylstorff@siemens.com>, <christian.storm@siemens.com>
Subject: RE: [isar-cip-core 2/2] reproducible.yml: Disable signed swupdate in
 reproducible tests
Thread-Topic: [isar-cip-core 2/2] reproducible.yml: Disable signed swupdate in
 reproducible tests
Thread-Index: AQHZ+FTYiiZdDXhZKUqacI+rzfyK9LA8uqqAgAFkiGA=
Date: Sat, 7 Oct 2023 16:06:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB554276D1588C1C542E499C61A4C8A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
 <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
 <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
In-Reply-To: <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYWPR01MB9987:EE_
x-ms-office365-filtering-correlation-id: f736d2d4-1157-4003-4568-08dbc74f6698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y5UJ6MMpJyHetfxfW9C4rVYFc6Lm+AE2IW4yDMkHXvJsqs4u/PjR2J+BTM5hr4ck1F9izSwCjRVN/Gaf9gfZ82k9gv3Oc5SHwQzMCaRMVNe5nlv768EPTn4c8IdBqqPesFwBfat7lsEKSHgGOGNKQLvixf4JmHtLWsZTHPe4l2QtoIKG6ZZU++BV+zT2eY+QwLrQv4wY8ce7RwjBDARYo+UiCkSI0Fui40IF7r1+vPcTAzgAYyrOQAahK66x+yjd8PcRLM5+ltigFYNbJP97SRq6S9Bc0cQYxDnwGbOivhdVXYHHdnWPOta5vI7UvR6iMmgWUKzu98f3G2w0zSjDwvMznz2kUSMF2UILiY4xqk6UzeTXcoRttcUb+gFxrwkJFIFd3Aa+eLobDUdjz8WCFrcIILGIG13/tRkJzkQTlcP2Cp1MIHdLwc7zTuZYCAgaEwmDOnOlOPE/uEYXgNHSGzJpZ0/f17crdzvTmpHoLdKpZtn5dFJmFzSIe0ZHR8cdRDMJxYr38ClSoZeqln5Ht/s8AunfGc21gc25wafl+KvJenTaIJUOECzzEmRmjXjCJC6QVybPJWMFy+ASAmlv4jx+0N5TXS6CjFZGHfIaVVXI7Mlo7ulH0i6J07Senlry
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(55016003)(85182001)(33656002)(122000001)(38100700002)(38070700005)(71200400001)(55236004)(53546011)(26005)(5660300002)(4326008)(8676002)(8936002)(7696005)(6506007)(9686003)(52536014)(83380400001)(2906002)(41300700001)(76116006)(66446008)(66476007)(66556008)(66946007)(316002)(54906003)(64756008)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z1RVNTVXbEVqeHJqM0hJTkh3ZGp3WjA1SFpYRzdDMjVIYU54TUUyVU9yQXM4?=
 =?utf-8?B?LzUyNklpNjNGT0RERVJEYmEvUHZ2N3dEby9QL1B3UG5pVGVhVjhTMm5aUWxG?=
 =?utf-8?B?emRVY0VvektJVU5SVUtRQnpMSkd1cEZsZThtOWtRSVBwOE5QU3FtbG5xSnBX?=
 =?utf-8?B?QXV5RktOSDFMTS8vbG42VWwzTDlFdW5uWjE4MUxPVllLcWw5bllFNVpldDE1?=
 =?utf-8?B?ZlJYOEY1QjJwa3RRUDRzNTFFSHEwcWhqUDExSWtGZ2tRWElDUDIwcXJPM2pi?=
 =?utf-8?B?bzc3ZFd0U2RpSlFCL0xIZGJ3ZG5SU1FYdERDZkdaOEk2NkprQUVpS0dqQko0?=
 =?utf-8?B?bTFxRzNlYW5pd0JUR1ltZG4rbnRySTRkaHFvdGpBcHltUDE1NDlBV2RaY3RH?=
 =?utf-8?B?WWNYTkIyTUw0blF6U043Vml4cHQzSlZ6bCs4a0paM2hTU2JuVUlDanRMRWlW?=
 =?utf-8?B?aWFKdnplTU9yWGdjZXhkNzhtUXBBa2pTRkRxRDg2cUhDVnpEOURlWEplSHFW?=
 =?utf-8?B?NUJjTFMyME1xeUhMMmdUU2ZHb3VDSVdTNk8wem0wNG1PUXYyMmNXZFBDUnp2?=
 =?utf-8?B?WStwbFY3aklteTRqQllETXZoV21jelpMbGhuWElpTmxpdFBiSDFGQ2dLeVli?=
 =?utf-8?B?dEJnQ0lySEQrK0xUR1B3dkV2UWU5L3l6YXZSVXN4RUpXTXQvVEJ6emtJaUpj?=
 =?utf-8?B?NzNLZTZMTWYzajhydTNMQXdRMU1kNkhwRnlObDhjOEZlcElFQzZUWGhkR3Nk?=
 =?utf-8?B?UWU5eThnT0RVNzZHOVo1RjBNdVExZEZVMWZnVncvUU9SdjJVeWxqWFVzeTAw?=
 =?utf-8?B?dG0zWVg5azQycnRraUhSaWNld25CR3NnZ0lzcVlhUWZWcyszZldlVDc2TEFU?=
 =?utf-8?B?MG5SS2NTMFFWYlBuT25Kd0ZvVEV2aUtRM1JBV3pUZ3JHakhaVTdEbmNISU5m?=
 =?utf-8?B?ZUtEcHhYeHJqNUt5aXNZdS95QlhSbStHTldjdGczd0lDWFVWSjIvcm13WnRv?=
 =?utf-8?B?QUFuMHNZSi9SUVI3Z0JjMG1SVWcxdzh5MnJNcGlTZTYrOWl2dEJvSlpwTnpH?=
 =?utf-8?B?ZFBqRGRSbXlZQ04vUWdtL1Z1N1pmSENyK0N3V3E1eHZwRWdQUmZmMzZRdTM1?=
 =?utf-8?B?OUpCWVhIYlNIeXVvR0xtQU9hZDJ4c1hjdDU5eUsrSEphY1Z5U016bXVUajJS?=
 =?utf-8?B?WkR6K25uRjgxa2p4N01iNkdzcHphZG15WVlOd1JhUGtKRUFFZUZzbnUvcHdk?=
 =?utf-8?B?SFpGZmVobHk4K3NDNWtCY29zbjBSNzVsL0Q3YjI1RVpxMjJaMUJiQkliWHhy?=
 =?utf-8?B?alFGRW9CRWJDMTZUclZIejdMU2FBYmE1ZTBENmRsR3d4NXhnS1pVYVdtL3Vw?=
 =?utf-8?B?WEtCZ1BVM2ZqcUlPQ0dpdGZic2JjdFRRdEVvR3B6aWtYZGUzUXlxMmt5OFdF?=
 =?utf-8?B?Znp0OFArcUVSOW9oRFMwc1RaQ0MwdkZ5bUw2SDVFN3BqS0h4TW9pQmhEM1lP?=
 =?utf-8?B?UkpRRksvdndCVXl2TVBlNGJac1lxbkg2ZmovcXYvRG8raHBIMzBacEZHRXg0?=
 =?utf-8?B?UHpoaDdsMllsRWNMRHg4Yjk0aU4wUURIR0tXR1lVQWhVaVl1VmpRS0RJWWJR?=
 =?utf-8?B?Z3MrWjhYRE0vTzM4SldtRjNMK0JwbGF5YTRZc1FWeEVlYVQwYlErOWZITUZ4?=
 =?utf-8?B?bUIxeVF4UGR0TUpQOGRWeDFsMVB6cWJDS0xPVVhEVjAva29GWk1RSlZvS2tz?=
 =?utf-8?B?T2QzRXpmbVo3ZHNPS3dxVDdxZ2FYbnpadHdkb3VpQjJoU29GREJ6aktaeTdD?=
 =?utf-8?B?ZWxMWnRwczJSLzJoYk93eU11d2gwaEVNL09jR3dBeSt0Q1pieDBwaS9UaExj?=
 =?utf-8?B?bTh2bEVBSDlzQktPYmpOQXJnaEk4aHNMQklGVmZ6MGFyek5MdTNpQ1hIYk96?=
 =?utf-8?B?RFZwN3lVcytEUjdXdWhQV1B3bkZubW0xNkhCS1psVzVUWFQ3SGJZRnh5bk1v?=
 =?utf-8?B?cUgxa2NxVTdMWk94ZDNRYVU0MkEyYXcwcDJvS0VjeUFGRE4rVDVLVXVRR3pT?=
 =?utf-8?B?U0NjeEROTWhxbFJOS0I3dUtlZGdHbjBJRW1sejRCU1ZlZ2YyNnJoeitySVVE?=
 =?utf-8?B?TjRGMXRUNHBFM2Ftdy9TZGprM1NLQmh2Vi81aXJzcmhSR09BeXE5a0J2ZlBi?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f736d2d4-1157-4003-4568-08dbc74f6698
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 16:06:44.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +f5GJnSyiXBJnBDZLn1OBfePOR0XLHX+DDBFIeo5jQV9QmJ8em/CR3j/RzrznCx6dwlpGI3GRBVLjDmoJFz5EoGyXcDMAAOMRz441n/VQtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9987
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Oct 2023 16:07:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13301

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDYsIDIwMjMgNjoz
NSBQTQ0KPiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykg
PFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQo+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0
aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+IHRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGly
byjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDv
vJQpDQo+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgUXVpcmluIEd5bHN0b3Jm
Zg0KPiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT47IENocmlzdGlhbiBTdG9ybQ0KPiA8
Y2hyaXN0aWFuLnN0b3JtQHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNv
cmUgMi8yXSByZXByb2R1Y2libGUueW1sOiBEaXNhYmxlIHNpZ25lZCBzd3VwZGF0ZSBpbg0KPiBy
ZXByb2R1Y2libGUgdGVzdHMNCj4gDQo+IE9uIDA2LjEwLjIzIDE0OjU4LCB2ZW5rYXRhLnB5bGFA
dG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEu
cHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiA+DQo+ID4gc2lnbmVkIGFydGlmYWN0cyBhcmUgbm90
IHJlcHJvZHVjaWJsZSBkdWUgdG8gZmFjdCB0aGF0IHRoZSBzaWduYXR1cmUNCj4gPiBjYW4gaW5j
bHVkZSBzb21lIHJhbmRvbW5lc3MgZm9yIHNlY3VyaXR5IHJlYXNvbnMsIHNvIHNraXAgc2lnbmF0
dXJlDQo+ID4gdmVyaWZpY2F0aW9ucyBpbiByZXByb2R1Y2libGUgdGVzdHMuDQo+ID4NCj4gPiBG
aXhlcyAjODANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVua2F0YS5w
eWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4gLS0tDQo+ID4gIGthcy9vcHQvcmVwcm9kdWNpYmxl
LnltbCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwgYi9rYXMvb3B0L3JlcHJvZHVj
aWJsZS55bWwgaW5kZXgNCj4gPiA1ZDZhODk2Li43M2RkNGQ1IDEwMDY0NA0KPiA+IC0tLSBhL2th
cy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiA+ICsrKyBiL2thcy9vcHQvcmVwcm9kdWNpYmxlLnlt
bA0KPiA+IEBAIC0xNSwzICsxNSw0IEBAIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiA+ICAgIHJlcHJv
ZHVjaWJsZS1idWlsZHM6IHwNCj4gPiAgICAgIFNPVVJDRV9EQVRFX0VQT0NIIDo9ICIke0BiYi5w
cm9jZXNzLnJ1bigiZ2l0IC1DICR7TEFZRVJESVJfY2lwLWNvcmV9DQo+IGxvZyAtMSAtLXByZXR0
eT0lY3QgfCB0ciAtZCAnXG4nIilbMF19Ig0KPiA+ICAgICAgV0lDX0RFUExPWV9QQVJUSVRJT05T
ID0gIjEiDQo+ID4gKyAgICBTV1VfU0lHTkVEID0gIjAiDQo+IA0KPiBTaG91bGRuJ3Qgd2UgcmF0
aGVyIG9yIGFsc28gY2hlY2sgaWYgZXZlcnl0aGluZyBleGNlcHQgZm9yIHRoZSAuc2lnIGVsZW1l
bnQgaW4gYQ0KPiBzaWduZWQgU1dVIGlzIGlkZW50aWNhbD8NCg0KSWYgd2UgaGF2ZSB0byBza2lw
IHRoZSAic3ctZGVzY3JpcHRpb24uc2lnIiBmaWxlIHRoZW4gaXQgd2lsbCBhbHNvIHNraXAgc3ct
ZGVzY3JpcHRpb24gZmlsZSBmcm9tIHJlcHJvZHVjaWJsZSB2ZXJpZmljYXRpb24uDQoNCklmIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gc2lnbmVkIGFuZCB1
bnNpZ25lZCBzd3VwZGF0ZSBpcyB0aGUgc3ctZGlzY3JpcHRpb24gZmlsZSBhbmQgaXQgd2lsbCBi
ZSBzaWduZWQgaW4gY2FzZSBvZiBTV1VfU0lHTkVEPSIxIiwgb3RoZXJ3aXNlIGl0IGlzIHVuc2ln
bmVkIGZpbGUuDQpTbywgaWYgd2UgZGlzYWJsZSBTV1VfU0lHTkVEIHRoYXQgd2lsbCBkaXNjYXJk
IHRoZSBzaWduYXR1cmUuDQoNCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVj
aG5vbG9neQ0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo=


