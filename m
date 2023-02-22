Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F961C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 03:51:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web10.878.1677037873747170550
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 19:51:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 31M3p8V4006756; Wed, 22 Feb 2023 12:51:10 +0900
X-Iguazu-Qid: 2wHHaIQr8FnRMpwCvZ
X-Iguazu-QSIG: v=2; s=0; t=1677037868; q=2wHHaIQr8FnRMpwCvZ; m=czdEcSSzw9t1pgDi5hWJvw4pyQ7BoRYUH5qQ5+pxLEo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1111) id 31M3p7YT040491
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 12:51:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6ir+78eBBW5Xf4FcOW+Y1VxfOo831+73Ac6amBN45+FeIxfXrRU1LVbFdTmR4Gnzh/IVFji6X8mcnECSm5tFccjv8z+1ph2upV4lFySsTZMJDoC2cO081lO4DVZBVc+dt2+iqEzrsfI9z740h1FZBeOQj5aQMrLwWopqpe3b/DK6M+8Ra+EWYtGoUneoKzlkjiq42/xR5SpKKmk72dcr8O1qrSNav7394KFlSo9RbzuGZH9rAjk7ZQrmEc5GYZuu74Z5+wBoKXTs2agA1dqcitSQiAelBiPcFIAwwNcK22U6hayzXXhZGRdvfq8ZxfXxfyF2tL9hIjTz8GvCjxGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrVs1L/GYgiC1yGD+hplgtrXapAifxbyuEsPECuDn88=;
 b=mWc4Klv0SJC/k9Bv95TnTbqDz8KLF+F+vukkJthE3OV+0PJB7UvLez4rYI0EmtQnytXzrnBQAW2D88Xxin4jfbmWspV2gfSO1V5ekgBs1ItZZgmHBL4eJpqR7+X7mgg5Boz6Yv+3/3bZSb1tdzvcnpNTs11fyNoP9M3xrUOgeMNCLR3MDhs7VmzrlqKWRjYUlQ94Y63RpslBhW/t5Bdo4vV57Ii6xbINAKWmhuoLGJPPM94OZ2at29tTpk5oCKzTS9pI/IHQyoUclRLOfB8IKBPUsSIiY8Za9lUpwjfZKy9tmBYTrCfHhpNEl43uRI2cQlkUzsUWr9oejgY0gJGeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Topic: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Index: AQHZRgr68sSPpHByCU2Fl8/f/ptuxK7Z3I4AgAB1eUA=
Date: Wed, 22 Feb 2023 03:51:04 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB55428B11805AFD7507DF263CA4AA9@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
 <20230221154138.15146-2-venkata.pyla@toshiba-tsip.com>
 <0e8ef8ee-0726-898b-f0a4-0b5efa22bde8@siemens.com>
In-Reply-To: <0e8ef8ee-0726-898b-f0a4-0b5efa22bde8@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OS3PR01MB9447:EE_
x-ms-office365-filtering-correlation-id: ee5c17e0-933b-4164-4046-08db14880568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JU4VFkyljpvhKYzLVxYNjrtF0y6uYT/7JeS7HY3sOQUn2SO7/GVTyWUQ2IvWEA3UZCQ1x5d1ykyaHCmvBTDPgkVQ/0de2awgbge7sI/1wdSu1dhr6XNio+jH3gl0ZGxcKNni/kC0kvzlBYDQViiwBCmIiMbu3uD0pASwEe+k0s2hs0rJ4KThcbbhdr2LqVEbKnPZKJ8I99V9d8iMeLCJZnBdb79PaI18R6AP/8ktoW/72R74o/wKTrWXzyR7GZgQQCFSNTcsOmsveUQPNKRnAiWF1fhg5J1BsGDCyHf/xMw4cHLtCZSzT0l8IGLRn3NOU3GDzL3ltAvBhgFXlPnWiVixW0YC7XfFwcTDuktbJiHWlOm1NAPLdy9Jp+CD72AHu13ZTEHDmz+n1lSmIw1sXuwhjRSaNTonoWpFM5yMt35QRISYn3Ki7QMzNd9qzbZ74TPhhsHTrvRQeqf2sGVDdWc6MqcSF7zoRtWCJsoQWZ+kjZPLaCj0Z4g05+gbYH+4D0qeNXRw9WyAOzf7KHb7Cx6ovIWbrzA1YWARFGlfdcM6cHqQnWhxKDybw9CCDKibJn2dHWtZF/e8eqyAholhu52BYSPF1yU9ACaQ9uzbWAHz4mf9ROjvJu3P/KmnEV1q5foxeUo85AGN9Fa8DedHCc8GgA19dgWw5Ev55bISQQB5pBnmtWORdRuaZvbuuN1zmsiZDzuhsc5ChhZiFtgIJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(41300700001)(83380400001)(54906003)(9686003)(26005)(33656002)(316002)(7696005)(6506007)(55016003)(86362001)(478600001)(107886003)(71200400001)(85182001)(66446008)(64756008)(66476007)(4326008)(66946007)(186003)(8676002)(6916009)(66556008)(2906002)(38070700005)(122000001)(76116006)(38100700002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpiekhrNUhXeFZCY0xXN0NrUzdvYkoweUVSbW11M1lpTVJ0Nkg4TDhBVncw?=
 =?utf-8?B?LzRVMC9RanpPRzJIN3Q5UnJEMlVXZUl2ZEZ2a1RBT1pTcHQrd2NJMm1IYy9J?=
 =?utf-8?B?aFNKUkxnMW9rekhhUFJXYndUZEE0VUxBUG9zSnh6di82Y1BZMUNsckNaUCtV?=
 =?utf-8?B?T1lVcEVQTlZaOUlKZFJJcER4YkdaWVZkcmFsM3kxa2V4WVY1Z3lDUDg5TjNK?=
 =?utf-8?B?ZTBCOVVCNG81eVpaZlltdnpiWFFVellmcGFqOEdPUkZhaWZDdENFTzg3Rkpa?=
 =?utf-8?B?TFM4b3FSM0p2WmltL2pTdXBXRDVRa1hLR1RtUVBNazZmRzA5REdzTzlwY2J2?=
 =?utf-8?B?WjZsSy9qaGplTE9LdmsrZEN2MlRsSkFxOGtPbER4b2pnRmV0a2haZkFPSVp4?=
 =?utf-8?B?MGZsZU9QeHNWa1JvNTFWK0lhaXA0NzhNcXRib0pPVkZRVk1wV0RjNy9KeUdE?=
 =?utf-8?B?NVlwOXU3b3MyWGNDVldjNmY0WkxvMmxMWi9ZaHcxL2NZN1pRb1VIdGt3TC8r?=
 =?utf-8?B?MkhUQ0k1K0VOUU9Qc2JTZTdWWWZtWllwSFkxTFhHd29QVVZOdG5MczZ6TlhO?=
 =?utf-8?B?ZkhGYWQ3Y2hUV3VLcHByekpoOHJWdmlrc1B5YVF0WkpvUWhtVTBELzBQckRM?=
 =?utf-8?B?Z1puUFZ1SGNZWXNqeHVMYXMza0FoUzJYRVltSEk4eU8xU0RrTlA2SE9pLzB4?=
 =?utf-8?B?dFI1UzhrNlorZjN5Zm95c1NvdFRHbUdSOHlxS1RVS0l1WGROVXhLYU9KaGVO?=
 =?utf-8?B?Y0xpK0ZDdTErYU9RZzFFRDM0Y0FVa1hRUTErbEl2Y1hWamo4SUhZRTZvU1Va?=
 =?utf-8?B?Rlc5bmhkdm5UWXNBQnp2MldRczFySXdULzhvd2ZBbndlTlZ4MlZjTXRVSXJJ?=
 =?utf-8?B?d1JlTWVoK1BTMWV6Y1lHQnBsb2luT3dDWkFlcEc2a0JiQUtCQ3J2Q252YkU0?=
 =?utf-8?B?OXRpeElTK2J4d28xRWJwTHEva1NtV043YjBycisvRlBydDFSZmpFaldFTUdn?=
 =?utf-8?B?OHlKTEljeFpIMGM2eC82MTRPTG41emVKZmhDbzlOMEZEcXJUUWJIWTZMcHlr?=
 =?utf-8?B?TjNkbENuMk9yWm4rSVVvQmlMbG1kN2YwRlhaRi9kUk0vTVAzYkM2LzZDTHp2?=
 =?utf-8?B?cVQyV1BrZ1hpbE9qanlOK05XTjhiaTFoVWpKL0VNZkgwa2JUYzM5cXNpN203?=
 =?utf-8?B?bU9zS1pGR052OWZ6c3FSVy9YclBaUkRmRmNuVGpFWEprM1RCb052Z1N1S2xN?=
 =?utf-8?B?SXptRzc1YTV0TkE1YncxY0FWbDdITjNwZ2N1ZUVXM29RYjVNUmZEOVBjOW1K?=
 =?utf-8?B?TkxjNE5yV25wT2daSG9mNVpuMEdGamZiQlhucHlWZXNyRVI5eWtHbDI2NHVZ?=
 =?utf-8?B?cUYzc01LeWI3VTIrSklFQk9XNm92U0FkMHN6NWtqUDVtdXd6bjFtUVI1TStZ?=
 =?utf-8?B?ZjJhL1pYempvcXFDSTJzVUFWcVQvTmlvTjlTdzZaMlIwWmczZHN2dTNSNTBW?=
 =?utf-8?B?K1FwbFhKYXdNSHBjVzEzYWJES3g0Z3MxWXgzd0dQT0REa0hTYzlGbmJWR2pv?=
 =?utf-8?B?MFFRV1JYSndPVTlGWm5XeE05dU95L2ZDUjBCbWQ1dkhlaFZqa1ZQMVRYV1Br?=
 =?utf-8?B?QXRuSFZOT0hNY0k5YjlHUVcxb1h3NW9VcFVWaXhxR1pYeTNLTGlkRVdlWWI2?=
 =?utf-8?B?VktxTmdyVEFpNlZtYTVLcHkzVHZId0tRYkhzYVVSZUtzOGIwSVpJTS9DSjl4?=
 =?utf-8?B?WmVOQlJGZXpTNXBtcDFEMDdyanp2c1o3N1E2cjVPcm9jOFFuYndxeUlkS0RM?=
 =?utf-8?B?aE9VWEs0NEkwTFNrcUZOU3dyUUZhNEJrTVZ3L25PdkRSOGEyMjkzUEcvNmJE?=
 =?utf-8?B?dmluZHBWUnZGby9razFkS3FmYlU3cGllNUpBVkNrcSthVDBuUm8rMzhkZkV5?=
 =?utf-8?B?aTN1eDdxZVltQlJTTXB5UnZvcGRTdkZuM3dDSFZ1bko1MDFGNmszeG13R280?=
 =?utf-8?B?QzVUckttNkVYejd2aDNQbGg5cDFaeXNmYWdJc2cyS0FWY01WUTlpZVdORG5o?=
 =?utf-8?B?a3NXM3dkOGgwYXJKa0JMdE13T1B3VkJRZStHdEljLzEvVjkxMlY0Y1JFOVhv?=
 =?utf-8?B?bVZEeU4xN3FpOGMxNDBNL1FDTlltNjdzTmZWOXdYR2ZueFFwY29Xd1VSa1d5?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5c17e0-933b-4164-4046-08db14880568
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 03:51:04.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8GtCyQ/fRzY+GbKU7i3Ffxvcr2ckyHjlrVWw+jT9pfq/Cim+C4jcxIdd/cfoKv1KUfa+nLI1k/WuVgl0OAlAg1bSJ99DwsDTox2Nlvbc9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9447
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 03:51:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10766

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYNCj5PZiBK
YW4gS2lzemthDQo+U2VudDogMjIgRmVicnVhcnkgMjAyMyAwMjowOA0KPlRvOiBweWxhIHZlbmth
dGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEt
DQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNjOiBkaW5lc2gg
a3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hp
YmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz77y377yj
4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPlN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgMS8yXSBrYXMvb3B0L3JlcHJvZHVjaWJs
ZS55bWw6IEFkZCBrYXMgZmlsZQ0KPmZvciByZXByb2R1Y2libGUgYnVpbGRzIHRhcmdldA0KPg0K
Pk9uIDIxLjAyLjIzIDE2OjQxLCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToN
Cj4+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+
Pg0KPj4gVGhpcyBrYXMgZmlsZSBzZXQgdGhlICdTT1VSQ0VfREFURV9FUE9DSCcgdmFyaWFibGUg
dG8gbGFzdCBjb21taXQNCj4+IHRpbWVzdGFtcCByZXF1aXJlZCBmb3IgYnVpbGRpbmcgaW1hZ2Ug
cmVwcm9kdWNpYmxlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVua2F0
YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICBrYXMvb3B0L3JlcHJvZHVjaWJs
ZS55bWwgfCAxNyArKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGthcy9vcHQvcmVwcm9kdWNpYmxlLnlt
bA0KPj4NCj4+IGRpZmYgLS1naXQgYS9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwgYi9rYXMvb3B0
L3JlcHJvZHVjaWJsZS55bWwgbmV3DQo+PiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAu
LjE3M2MwMTgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2thcy9vcHQvcmVwcm9kdWNpYmxl
LnltbA0KPj4gQEAgLTAsMCArMSwxNyBAQA0KPj4gKyMNCj4+ICsjIENJUCBDb3JlLCBnZW5lcmlj
IHByb2ZpbGUNCj4+ICsjDQo+PiArIyBDb3B5cmlnaHQgKGMpIFRvc2hpYmEgQ29ycG9yYXRpb24s
IDIwMjMgIyAjIEF1dGhvcnM6DQo+PiArIyAgVmVua2F0YSBQeWxhIDx2ZW5rYXRhLnB5bGFAdG9z
aGliYS10c2lwLmNvbT4gIyAjDQo+PiArU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVCAjDQo+
PiAraGVhZGVyOg0KPj4gKyAgdmVyc2lvbjogMTINCj4+ICsNCj4+ICtsb2NhbF9jb25mX2hlYWRl
cjoNCj4+ICsgIHJlcHJvZHVjaWJsZS1idWlsZHM6IHwNCj4+ICsgICAgU09VUkNFX0RBVEVfRVBP
Q0ggPSAiJHtAYmIucHJvY2Vzcy5ydW4oImdpdCAtQyAke0xBWUVSRElSX2NpcC0NCj5jb3JlfSBs
b2cgLTEgLS1wcmV0dHk9JWN0IHwgdHIgLWQgJ1xuJyIpWzBdfSINCj4+ICsNCj4NCj5TaG91bGQg
d2UgYWxyZWFkeSBtYWtlIHRoaXMgYXZhaWxhYmxlIHZpYSBLY29uZmlnLCBvciBpcyB0aGlzIHRv
byBlYXJseSBhcyB3ZQ0KPm9ubHkgYSBnZW5lcmF0ZSByZXByb2R1Y2libGUgcm9vdGZzIHNvIGZh
ciwgbm8gZGV2aWNlIGltYWdlcz8NCg0KVGhhbmtzIGZvciBwb2ludGluZyBvdXQsIEkgdGhpbmsg
aXQgaXMgYmV0dGVyIHRvIGFkZCB3aGVuIHRoZSBkZXZpY2UgaW1hZ2VzIGFyZSBiZWNvbWUgcmVw
cm9kdWNpYmxlLg0KDQo+DQo+SmFuDQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+
Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg0K


