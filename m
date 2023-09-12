Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E4CA0EC3
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 13:12:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.24452.1694524319754338641
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 06:12:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38CDBuGJ3032678; Tue, 12 Sep 2023 22:11:57 +0900
X-Iguazu-Qid: 2rWgJRkMW9ufhfKfpo
X-Iguazu-QSIG: v=2; s=0; t=1694524316; q=2rWgJRkMW9ufhfKfpo; m=eDQvaELgjOyoggVvUR9MWA2XxYP82nKTO+23oMmiOsU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 38CDBsjk1339507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Sep 2023 22:11:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3+y5GPbWKmZyEUYmRx5oipsmRO81rpMvCTtucrxruRs3/Gp5McPgUW2bdHJPEi1uJgyIF+EPRGCKn05cOMqppJpVEtbTrjqTqp6c9XvzSoCFKiJav1ian7Q3sjONDgrJtbz27pfhucVACEBlx1l/Csci6G4d4Jd8v0NSS+O4QCEKc9bhJa6fqWyFP+c+tAx7mrg7gzR/+KAIWNUxUxsV9359arsU/7XTcbL1NuRqLzJduBtCGyJIOvo1g5GcSJ1U25+PV19xa1FPTIfWuETk3wYjVFnviR/nRryYGrXAXEWlM1V8FCHTy7thgT8rSPk45MX4mLPAXvMTyCqwlYPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyU8OGdyayfEXGR0z4UZ6A/nvT55QhETH4yK+KjevFA=;
 b=JhiFh1d6fWWaKfoqnrYYkSgrZ1iZH5F0Xer3C+jPGTP3LXlqntcHGIUmgtrq8Sv6IePvlog1MWIxkz4CD4yf9jI9DR5hmexJSm5VsvYkiy2skYMRJhBPFCbMyrHFKBoTac9mTnrgikkLd84UM26kyoPbO+BbacRgce3hGi3+SshXWnN17+cKuyLlizv0Nm63/l+JdKdvtLWqj/zlkIChJYMJOBMJNkCiE6pVk5BAjqCWmnDv4MrVhpjwFMbhGuMq3jFVbAuMl6/VicUFgHFo4OIsCW12sUS3wJEdFo/dY3Waw2E7Pe2K1gq8R71kuvJomuGj5r7UJjtX4IILnrAmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <iwamatsu@nigauri.org>,
        <minmin@plathome.co.jp>
Subject: RE: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Thread-Topic: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Thread-Index: AQHZ1Wf5/CLWZkRDa0OLNZTE4Lk26K//SywAgAAaeyCAF+S8QA==
Date: Tue, 12 Sep 2023 13:11:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9962:EE_
x-ms-office365-filtering-correlation-id: 877cbb90-dfb6-4c4e-8733-08dbb391d4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Amu4CGL5+mLS8TDsnJIBs6XZZiHigBlc+kqiRd+5FEN4hh5d1UrF973poMv1oOlv3ZpotbM0QsDRIwR5Y/AVdhptD9/Exc3cLrmkazt9fWhjsrgICul87HJMhn8uH2RcFgjpGXTOcw/oW8uI7Gn0Qe+G3mVXtiWmFfNkGGgN6RP4bkM2V4pKEsr6OiitnNI9pmRnoWw4b7YFG0Cq4iGVgsIP00jG3xHK/Qf3T7YWi1ozidD7IzIt6yxvL+OTsaPL4H/SClSkefbJpvaPcxjWwuLIZh/X7sU2pURdsNdvLoZ73tcANcPJxNjfyd+8v7t+i4Os0zHWKfpfvfadSUNnUwJJQRxVVpx0LUyaxUU9XPOK7GRuZvxINGN8SBDTcUVMorJ+OlVrNAXx1+UypSCWGjhErne/r+u5+ndcM6uR+XnvP/lAYw0mJ/UngBIeYLeq+FH7wpOF3khYu/EiCO1oYhYJtEjH49Ruz3OJfkL5XDJWFbl3gVV9hAZwfQ7mVcyQxpGI2MNUU5SdoonqbHwHCIqFKZTx8X1lVrQU9eNVbrGLb3euuFQ9jWKqBX09hY9QBCmAdpXM7BIvmjoUHHKdzvOJZuqXXYfKSqwIhPIgiRyW3l8LlBjgsmZBdjLCL6B9DmlmVrrLZCAhqzJCb24gEw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(1800799009)(451199024)(186009)(6506007)(71200400001)(7696005)(53546011)(122000001)(33656002)(86362001)(38100700002)(38070700005)(55016003)(26005)(2906002)(9686003)(478600001)(83380400001)(4326008)(52536014)(316002)(5660300002)(8676002)(8936002)(41300700001)(66446008)(64756008)(54906003)(66476007)(76116006)(6916009)(66946007)(66556008)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFlmM2dKck5VVGk1Snd1SEY5Z3ZwNzNHUVBlVUNKL2FxVElUR3luWTRvWmlr?=
 =?utf-8?B?SmhNWmpXaFFRNEptSm9jRmFhM2xlNmZkbjlHdi9rTVVsY2l5dVZyOFNjcUxU?=
 =?utf-8?B?Z0lieUsvaDlYU00rT0s0aThvQ3gvc1k5bUdwRm1lQXhyaGU1YTlPSURNdUd2?=
 =?utf-8?B?YlY3YVBGTDVPck5JWXJPN0MyeHlOck1nQ2FzTlIxc0Z6RW50S0dYWkV6aHdL?=
 =?utf-8?B?U0xEcjF5N1Nxd0NIbTZyRDUvemZxdC9OOW1vT2hib240aVVnNnRFYW5YSTBE?=
 =?utf-8?B?QlVVRXE4cmZVUE9HZ3lhSkdUbTZVL3pQQnp4dzVUT3drRFYwT1NiWWpJRkIz?=
 =?utf-8?B?alNKUk4yWlpLOStoT3I1bFlQUUVvbllZUGIrVG4xdjBEME16M1R0dVRMdUFv?=
 =?utf-8?B?eGtZTXlGaVBnRklpZGpENEE3b3BGdHlZNGZrVzdsZUg5YnJkMGtseUJUb2dw?=
 =?utf-8?B?U2lFTUNvTDJGYzQzcTFoQmIycFB3d0VBeVcxRnhRSC9xQ2c5NmEzempmaElq?=
 =?utf-8?B?Q25XSVFCSzZSYVlPRkJBQ3Q2TW5DdjZwN21aeW5ZZ2ZzZytvcTVxbGxVWDlL?=
 =?utf-8?B?RWw2TG1OelBjSVhhemdYN1RQY3VFREdVQ090QzgrOVd2WWY3eTY2WnRzZUJE?=
 =?utf-8?B?RCszenZGaXFDVlFFbCtDTjBRZG92bk93VTVYbkpLMkZNazBiOXVrbUo0ZEl5?=
 =?utf-8?B?OVVrdWRRdUZnSkwvWjdsRWZlNTRkSVJmUHQ3dUUyUlhPckl0b2MzYTI2WkVx?=
 =?utf-8?B?cmdKRUQ0NkVYcm9tUSsxejhPcWJWdUM3SURzdEF1cEhoZXdOUDlsOGViWEdF?=
 =?utf-8?B?RWFRQTQwMTVaUFBTU0U5UTNWN3YvWEgwVDRyVnRud3d5UnVQTStmdGNib0k1?=
 =?utf-8?B?UC9qc24xclcwQVBoUlN3ZVlmKzh4K2I3WEtieUhBbzFvTnZUODhBYW45WTE1?=
 =?utf-8?B?b2Y2SzdjZUY2WXh6L0pENVhrcHBPbVVKRVJLeG90YVB3c0ltb09BU2tzT0F1?=
 =?utf-8?B?SUhmbThqZGk0bkdmUmxsL1pMci9ZMUgyQlFIcEV1S3AyZ01wM0xGQ3dDVHdr?=
 =?utf-8?B?dVk1TGt4TFdsUGlSZUdDdm1USU1tSXVyR1NSMlhQeEthWjdLbEtMTU5MZVBJ?=
 =?utf-8?B?YmZYN2NzbGRrMXNrZ05uS1gxNFkyRFFLR3BVUDI2L0hhcUIwMUppUzZ6Q0tV?=
 =?utf-8?B?SWJTNXZ1TlFrc1dZZlc0TlRDdFVTdDZiZkZLWDRPOGpNLzJCSXFOYWVZdkxH?=
 =?utf-8?B?SHg0dHpqTWJsZzd0c0hpVldQUHBET1lzcy8zNTE5Ry9abTJXbkZyUHBnOUx2?=
 =?utf-8?B?VWcrOEE4a1czdk1HT3A0L3llSUdNUnI3NHpXdHYwYVc3cEtDcFc5c01vYzV2?=
 =?utf-8?B?M1h2NlBHVWdndVkwc1pMYlA3VHVDSURVdndDNzZIM2lSVUhZUkJUTEEycUdz?=
 =?utf-8?B?aldtTklLeXpDa2V6aDlpM3ZreU82bkJaamlaRTcyb3NvVkd4UWc5WmdPSzY2?=
 =?utf-8?B?cEVwNjRUb3ZmUitkSnJINlR4bGhCTTJ2K05TY28xa2M5Skp4NUZGRUlybm1o?=
 =?utf-8?B?VTBTNkhzQXExMTdVL0pnQkdVSW9aNmUvRENiOGNJaWVydVhxYzVIL2tJaEZG?=
 =?utf-8?B?NTMreXFkVnU2a3JLNkhGUVhNUTFua0dEWWdMVFhGSVpHV2NjS2o4cEdCNEpZ?=
 =?utf-8?B?cGdBeXJKV2JiT2ZEYWJqRitsZU5wdjc0RGdoYy90SWFYQ0VCdjJMY01JWWVl?=
 =?utf-8?B?bFBWbkNlK3EwaTVxMmc1L2xvaGhKdmpYMndmQTY2YS81aUtGeW4wSWxBY011?=
 =?utf-8?B?T2xUODV5dnA0dW52V3ZKbWw5SFFwRVcwejl0NVdWWnQ3aGo0T1N5ZXc1L3Bw?=
 =?utf-8?B?aUNIbXJhMVVseHZJczIxYnMwQjQwcTRSZUtSR3QyM1ViWjlyOHVPUzlhay9a?=
 =?utf-8?B?Vml1ZktPTEpqdUFMYnVXeW5yTHd0K0d1eTNmYjBSV3FFcU05UzFUQnFBWGJL?=
 =?utf-8?B?c0xyUGN1MjZ1UjA4OFMvZERzYnU4TGFoTmpDZkRtYStFWmN6UXhkT0h1YTN5?=
 =?utf-8?B?Mmp1UGZHOW5yeGFvWExyWUxDMjlFOTA2Lzl3cmVHeFR6aGxoV2dYNlB6Y3Iw?=
 =?utf-8?B?WFhrQkFKRWR6YldxSG5xY21hTmkvNGYycjUxanJ3L3hYa2UrTldRNTBXcHNR?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877cbb90-dfb6-4c4e-8733-08dbb391d4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:11:52.6396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k006CnBb+oXCG2HD/labF+iQNH+5tdZ/Id/onotS+iPdeluwsQA66OGDP4TbmzCXoLFIr8wzzs8pciyUTE5sNtHT48x0iux7L9MrCD63VMYJyrfZ3xJoLL5PgPxoWFK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9962
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 13:12:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13060

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBpd2FtYXRzdSBub2J1aGlybyjl
sqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4g
U2VudDogTW9uZGF5LCBBdWd1c3QgMjgsIDIwMjMgNToyNyBQTQ0KPiBUbzogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnOyBOb2J1aGlybyBJd2FtYXRzdQ0KPiA8aXdhbWF0c3VAbmlnYXVyaS5vcmc+OyBNYXNhdG8g
TWluZGEgPG1pbm1pbkBwbGF0aG9tZS5jby5qcD4NCj4gU3ViamVjdDogUkU6IFtpc2FyLWNpcC1j
b3JlXVtQQVRDSF0gQWRkIHN1cHBvcnQgUGxhdCdIb21lIE9wZW5CbG9ja3MgSW9UDQo+IFZYMg0K
PiANCj4gSGkgSmFuLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4gU2VudDogTW9uZGF5
LCBBdWd1c3QgMjgsIDIwMjMgMzo0NCBQTQ0KPiA+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnm
nb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPiA8
bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+ID4gQ2M6IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnOyBOb2J1aGlybyBJd2FtYXRzdQ0KPiA+IDxpd2FtYXRzdUBuaWdhdXJp
Lm9yZz47IE1hc2F0byBNaW5kYSA8bWlubWluQHBsYXRob21lLmNvLmpwPg0KPiA+IFN1YmplY3Q6
IFJlOiBbaXNhci1jaXAtY29yZV1bUEFUQ0hdIEFkZCBzdXBwb3J0IFBsYXQnSG9tZSBPcGVuQmxv
Y2tzDQo+ID4gSW9UDQo+ID4gVlgyDQo+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS93aWMvb3BlbmJs
b2Nrcy1pb3QtdngyLndrcyBiL3dpYy9vcGVuYmxvY2tzLWlvdC12eDIud2tzDQo+ID4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwLi4zMDUwNjg0DQo+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiArKysgYi93aWMvb3BlbmJsb2Nrcy1pb3QtdngyLndrcw0KPiA+ID4gQEAgLTAs
MCArMSwxNSBAQA0KPiA+ID4gKyMNCj4gPiA+ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUN
Cj4gPiA+ICsjDQo+ID4gPiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMTkNCj4gPiA+
ICsjDQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gPiArIw0KPiA+
ID4gKyMgQmFzZWQgd2ljL3NpbWF0aWMtaXBjMjI3ZS53a3MNCj4gPiA+ICsjDQo+ID4gPiArDQo+
ID4gPiArcGFydCAvYm9vdCAtLXNvdXJjZSBib290aW1nLWVmaS1pc2FyIC0tc291cmNlcGFyYW1z
ICJsb2FkZXI9Z3J1Yi1lZmkiDQo+ID4gPiArLS1sYWJlbCBlZmkgLS1wYXJ0LXR5cGUgRUYwMCAt
LWFsaWduIDEwMjQNCj4gPiA+ICsNCj4gPiA+ICtwYXJ0IC8gLS1zb3VyY2Ugcm9vdGZzIC0tZnN0
eXBlIGV4dDQgLS1ta2ZzLWV4dHJhb3B0cyAiLVQgZGVmYXVsdCINCj4gPiA+ICstLWxhYmVsIHBs
YXRmb3JtIC0tYWxpZ24gMTAyNCAtLXVzZS11dWlkDQo+ID4gPiArDQo+ID4gPiArYm9vdGxvYWRl
ciAtLXB0YWJsZSBncHQgLS10aW1lb3V0IDIgLS1hcHBlbmQgImNvbnNvbGU9dHR5UzAsMTE1MjAw
Ig0KPiA+DQo+ID4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIChhbmQgY291bGQpIGNvbnNvbGlkYXRl
IHRoZSB4ODYgY29uZmlncy4gT3IgZG9lcw0KPiA+IHRoaXMgdGFyZ2V0IGNvbWUgd2l0aCBhbnkg
c3BlY2lhbHRpZXM/DQo+IA0KPiBJIHRoaW5rIGl0IGNhbiBiZSBpbnRlZ3JhdGVkIGlmIHRoZSBz
ZXJpYWwgcG9ydCBhbmQgYmF1ZCByYXRlIGFyZSB0aGUgc2FtZS4NCj4gKFRoZXJlIG1heSBiZSBv
dGhlciBzZXR0aW5ncyBhcyB3ZWxsLikNCj4gQW5kIHRoZSBwYXJ0aXRpb24gc2NoZW1lIGlzIGEg
cmVmZXJlbmNlLCBzbyBJIHRoaW5rIHRoZSBzYW1lIHNldHRpbmdzIGFyZSBmaW5lLg0KPiBUaGlz
IHRpbWUgaXBjMjI3ZSBhbmQgdngyIGhhcHBlbmVkIHRvIGhhdmUgdGhlIHNhbWUgc2V0dGluZ3Ms
IHNvIHRoZXkgZW5kZWQNCj4gdXAgaW4gdGhlIHNhbWUgY29uZmlnIGZpbGUuDQo+IA0KDQpQaW5n
77yfDQoNCg==


