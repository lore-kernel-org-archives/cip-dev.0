Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF30C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 11:21:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.84058.1718709680732565907
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 04:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45IBLIdX2239352; Tue, 18 Jun 2024 20:21:18 +0900
X-Iguazu-Qid: 2rWhclmqSPW2pQVOBn
X-Iguazu-QSIG: v=2; s=0; t=1718709677; q=2rWhclmqSPW2pQVOBn; m=RTucQ8mXho4ELjsPLmdrRc6AVu6YGKzgPNLaCplReeU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 45IBLGO3253473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 20:21:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcLbgGcvxqLffexRAhns12M0f7L2hOHSnMAID/WYHtidZlz0q1l8sruNcKci9UgG4umXWz6PY75ap4/y2c314fgwW2ypxea+5lt6HHa5S/7JZQZ9FfYWStnSJN6Yxt/3hKQfPkFgGe8XSwEK1xh0PErZ3FW5bknCjyus0NvKzYfy/jEofh1fsiFmlJBSZtz4d477hX4FrlUl8Vcw1BC80Hxihp5Mp0wOt5gByDo3WK3B91+4pDYXcuJB8XbCpRhNXTP9TeIQnzBFu/rH5x24AYkRd+7leK1gnUglMLKQxRGeFNRuhw+7X+FMDp00QJvA0TZwMzT/pPWDsqdrckT2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXmBxJfmn/TJCCNmlc8sSOhlIL7KZ+DhfzHVzzqg3KA=;
 b=i/CKtxBUuymWygt5igs8sF2Y+3Ik1e+BcyEPV2wn5qbRD5/Vh4A09zI+6xJ6BY/EXlgMuD5gToMB0xqsG3Zr0juV0rSnZroTLYyrltQcKo6LqetOioZlhq+fcGDhuepVIpFWe0WYMtnwI5QSgqllE0oGz1pobace7Uu9lsaV6clx5sw/AQG5QCEP0XafaGjwOMVJBVKVJewYOpz4MkOvOF8H4Ueiyv4aeY46Bu8UC8/5cj2/69NhHfB/lrduiWTbJalNFFyTqyljv8odRrsZBOEcIQcFBe0EqPMj/AzzEz04WAs9KWW7ugRBm5cy2jt40OIYmu+RzdJze9SfCk0prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v2 0/3] Split Gitlab test jobs
Thread-Topic: [isar-cip-core v2 0/3] Split Gitlab test jobs
Thread-Index: AQHawTsDJBqRbTqlf0eI/6w5MWZak7HM/GOAgAAnAgCAADz8kA==
Date: Tue, 18 Jun 2024 11:21:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61034AA08D20A11830B87010C2CE2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
 <9fd8a910-c88d-4262-b753-89a3cbd7020d@siemens.com>
 <d24c2c72-892c-47f2-b1cf-13d2502fe356@siemens.com>
In-Reply-To: <d24c2c72-892c-47f2-b1cf-13d2502fe356@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB9752:EE_
x-ms-office365-filtering-correlation-id: c009b96f-e6bf-47b7-07ae-08dc8f88c3a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T2x3cFdRUW8rclJNMTJxS3ZSSXhibTFaWjNuaVFpV2FMZ2pydUxodmxydXJZ?=
 =?utf-8?B?UjQ4MzdmMGl1TjVtQy9jUlVHcTcwVE9KT2R3eVFZemQxblpNOGhEUWdTL3BR?=
 =?utf-8?B?UHZHQzdEOXlnWGZxSG9nOS9lVHp4TjZQeGNVL1ZpWW1NamtjWnpPb083Y0Jj?=
 =?utf-8?B?L3dZVC9YOTQvMEozbmM4bEZzVnlGYkRwNWFXRjg3QlZSYlZuRHFVTm0zZ3hQ?=
 =?utf-8?B?NGVMWTZnU3hNYStyNTByV2tJbmZ1UWQzaml0LzJOWG5kVS9QS2xYT3U0dmJE?=
 =?utf-8?B?ZDgvZ0o5N241eWYyZHRWY0tOeDZQNmhGQ1RkOWpyQlNVYmpqU3dmRGFSTklJ?=
 =?utf-8?B?UzZjcmNWLzBPc3RNdlE2U2UxdlE4TWs4SElNUWlSWEtoMmlWdnQ0Q0pubTFo?=
 =?utf-8?B?ZG92OUZ2WDI4T3hTTEhYK1hzcit5N2tpWUJ3K2x0RW9IRmdTSEJuOEtHQTFB?=
 =?utf-8?B?VmN2ZVRaU0VmbXhFV0ljWTMxR1hPWmtITEV5NnJ5NlBCMEJ0ZmNTL3JiWDJo?=
 =?utf-8?B?czV6amZtZkhRR3Q0SnMrSTNacEJIbzMrRUNXZkgwb1dpdFJMdEdEQzROYUR0?=
 =?utf-8?B?ekFhNWNwajNHaUN5a2ZBMFM3VXV6STVjaFFOdmFhcFRCNWVpRUREZXN6WTk1?=
 =?utf-8?B?cjZrWEFJM3pRQjJRK2pnSVpWc2d5MHZpV1V4VWlKSkplems1OVhNS2QzdnZy?=
 =?utf-8?B?VGZwZlp6eXpPUFpycm9NS1pKWmNieURqMjh1dnZ3ZFR6VlBaYk5ocm1iNDZv?=
 =?utf-8?B?Nms2RXpWZWo4U0RVM1gyMjFqVkp4SUYzb2t2ZTlQajZheEZNSnREOFpObEJL?=
 =?utf-8?B?WmZEZTJtWk93ci9IUlJPMlRtbks5aFZOcCt1Zm1JaUc4Q0dPL3NRbXBJb2s5?=
 =?utf-8?B?WkJwdDdnVjhDMzgwTS9VQXAxTFVRa3doWC9lN0l5ck03VHZ2c0RuRlFQZlgr?=
 =?utf-8?B?enNXSUF5eDBYRVdvNWh0VWJYdUxCaTRmdFU4bG1TaWFxanpsUlNXSWc3cS9w?=
 =?utf-8?B?cnBhSjhNck5LNEpQOTVLbnFtdVB1Ulo1UXV3WWt4SEtiTTVlQ0FGc3cxTTNv?=
 =?utf-8?B?RzhNYk5RaGtGdTVnK3ZLek9VSk5XQTVXYVh6Z3ZnU05GZ3pyakVzWXl3My9N?=
 =?utf-8?B?cXBUNlMvdDZKWERUdkRwSnBUandkUkoxVWEyOFJqbDkwV2VMOTBPcEdkZnVX?=
 =?utf-8?B?RW9LVjdPaDNVanRYYTN1VUl5MmJvNVc3a25YR3l4SkpPNC9uaE9YM21sNmF0?=
 =?utf-8?B?OEIvZzZKbDFBVWdJSkZqelJVdkRVTGJnRkppdFI4U1NWSnFFZzlySXlXaC9V?=
 =?utf-8?B?QUJwMThBRjdZUDFreWRyK2FSNjZ5eTNDbm9VSDlsRG9PTzdLN1R2RFZxVG9N?=
 =?utf-8?B?ZzJaNjA0ek1EN1JlWXUvMWliWlNYazNOdzRBazBhUzZVenk2VFkvblhldi9h?=
 =?utf-8?B?Q3h1bG1YSWxKcnJ6K0xRbHFaeXhMa0Q1OXJDVldSYzZkb3VWU2JIelVxdEZR?=
 =?utf-8?B?aXNVdjhkankxbUdwM1pRUXNuQmhhMzlQYTljd2lCd2xxdUtQalRjRThLd0cw?=
 =?utf-8?B?MWRJZUdCMGNTclZHZSswSk9hdzFPcHlVNGtnc0RBeTlMdmpkYmRXNlNRSENN?=
 =?utf-8?B?bDlCT3FieVJFdTY0bC96eFBzUG1ZZHBOaGgzcjJJOFh6N0ZHWVl4TkhaZWJT?=
 =?utf-8?B?ZVRJQktwUkNmNkhvNWtwUFhIQjk4a2Z6TUE3VW5yM0IzdzNiTkdaZnFTVVFO?=
 =?utf-8?B?QkdSOVY5c1JxSVR2MG5ZdHF3OGx5K0RIZmZRQ1NTMjdueTg0c1BpUlFGbkEr?=
 =?utf-8?Q?iJGIAwGOH8mQTiLcGOPiUMSgAWDs51bMCvRTE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OFFLQWxJcUpSMjRiQUhoMEpjTEJzMlhDdTJNWjhxcldJblQvK3lhcEZkWmNa?=
 =?utf-8?B?YUdpTVFZbDcrVlVpeDlEaldPTHAvdytSMDBndThnOC9TRkRwY2p0RmxFOThq?=
 =?utf-8?B?amlFQnFReVNISWYxb2lzbFJTUll2Z0JNSWx5NWR0RGZSYnY1VWI4YUdwTy9o?=
 =?utf-8?B?STVaMEc0bUFiZ3N4bWFUQ0hrNlhiSXpLazU4OEdVS0NCUDB6dWhjZlRhQ2hQ?=
 =?utf-8?B?T1M0Si84elRRQVExanRsUG9zSnQ1VEQyU1lTUU1YcTVRc1FhNUh3L2cyL0dO?=
 =?utf-8?B?SlFPaWlUNkE2Mm1GRThTK2oyT2NpeTVXZEVWUVA1dUJBQ01VRDRvMlY1L2Js?=
 =?utf-8?B?MFB3aVdQbGFHMXZLcGw1UHI2clpUWTJzc1RBcS9QbGNBQm1RMjdlNzQzNjg5?=
 =?utf-8?B?NDg2RTc3T3haNWlWNjdUaVJBbDNqdGZ2bE5RajRveFJvZFpDaTJFaXgwdmEr?=
 =?utf-8?B?a2xuZVM1Z3NzQkcrczM5UHZ5aTc1c3RyOHh4NnkvMC9pZnpGd0sxdzJEUzcv?=
 =?utf-8?B?by8vZEdBK3duOEp4RXlSZld4T2oyM3hUY1Q0Um1VTHVyK1F4eDJDYkU0bE5Y?=
 =?utf-8?B?MU94VENzNGQ2UFhGbnlvN3l6amtXdU9SNkRWVjNlNGNIdEFNOTcrYnE0c1ls?=
 =?utf-8?B?cEdsU0hyekJVa2UybVVWT1MwWXh3TWIxSFk2dWVNNEZaNDhpOU5DWitJZjdv?=
 =?utf-8?B?cCtST3pWVzZGSlhOYXpRcTFUL1REWHlKbXlsWStMdlIxak9KbTdPUzl6Tmdi?=
 =?utf-8?B?ZXFnd3ZCTk9HOXd2NUQ3dHhtOEZZZUNGdGxHeVF0YUtOOHhtSDFyODVlaTkr?=
 =?utf-8?B?QjNhazZtUTRwU3dORGtEM0dqV1Vud051S3RXTWp0c1FRQ2c3WGcrbDRLR0FK?=
 =?utf-8?B?UXp6dmswNkx6Ykl6VUpXbk5lMnBPbkwzbEIrcVhHTzM3aklzSGZ6ZFpKTzRZ?=
 =?utf-8?B?emh1VWEzRlNBb250V3FCT3VxdVNKalJCN2dpZ05XdktJRnVXbEprcWpqeCtL?=
 =?utf-8?B?QVIyRCtIemVpVitPYzV1MmRpRCtLMzU2WUVrR0loWGNDRisvY3ZRNHdyLzNz?=
 =?utf-8?B?NTdZRGFDMUZ1OVY3UFo1aFBLUkxEYlNoMkQ1dmQ2NGw0ZEhnazJVMWFXbmsr?=
 =?utf-8?B?WUY2bEFvWHZRTUNKVGdYNm5VdjR3WHR3NmV2bnpjWDg2Sk83Q2dxQ0VWOUhz?=
 =?utf-8?B?NjhaT3B1MUc1b3BoenhOelpRTHkwNGJ1b0E3d3BCSEh1R2VVNEFYWTd2L0lJ?=
 =?utf-8?B?ekpNaklFV2owWFM2TytzOHMzUUZCR3ZnY2JrY0lYbDRTTkEyVFJ4bHFuU045?=
 =?utf-8?B?Smt0ZFkxbmJ3OWl5T24wOWR6cXRkcGh4cTBBbHBseU8vaEtOMG1YM2FRWlR4?=
 =?utf-8?B?VGJrcmZ2cFZaMFk1ZmhNUWNCWjN1d3dOWmdPUXlUMkRHbGVKSVdjY3FweXJl?=
 =?utf-8?B?eFF0V09SbjJXYjBHYnBodlBUbld4MGUrS3V1OFZvTWpZcEpydC9SZkpBSkZy?=
 =?utf-8?B?ZjBRRXoxTE1wd2tuSWkyYTNaK2pST0NyQ3h6V21UU216YSs0VnNmLzlPWmlH?=
 =?utf-8?B?SUJGTjFNdFlOUkZ0TzZtVW9yK2dnSTJpOFB2UUgwZkFxdGNKRXE2MFh1VXE1?=
 =?utf-8?B?ZnlMVXZBTFV2R1FCRnFiU1h1WXdsWmdPb0E5ZTEzUHB2b0Z2cTQ4c0FrQmRT?=
 =?utf-8?B?Smg2U1MxMmx1VzZZNTFnZHNncW40WW51cUpkWUhydU1zL3RZb3NsYkgxVlFH?=
 =?utf-8?B?STZVLzZLd2JNMU5TTGk4a1NyMCtMeTdpLzdyVDBJTkpPZ3ZxNTJ6SDFwTUV2?=
 =?utf-8?B?RWp1MllYUFM2MEpyUXJqZVJQeU1QN2l2VVZXU2l3Y0V4UDR0cmpNTnRrdGt4?=
 =?utf-8?B?RGl2VEI5V1hLQ1VKR2cvYWRJZW1nOFBjd1pLdHJiS1BLck9EcGtpWVJQZWVU?=
 =?utf-8?B?N3g0aTdJenRObUtJbVNFaTBlQnhPbyswM04yMldzQjJaa1kwOU1pSEpGVFpO?=
 =?utf-8?B?QXUwR3BIaTZkeHMyMUF3cWEwNTdqTkFFZWZOaHZUemtQNGQxaEZKWFlPK2wy?=
 =?utf-8?B?ckhIUGxwYlhMOWE4UXM0QStQWTRPSnZGR2s4U3ZEdG1CWHFlV0RSZUd5ZVlj?=
 =?utf-8?B?TUtXMUVFZWc1NjZwMGFVODlHRmUvTUVCTTJjbmhsREpPWkphWld2dFJuTFZD?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c009b96f-e6bf-47b7-07ae-08dc8f88c3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 11:21:14.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZyWSGfXNiw+ClyL3xGXcYZ/uRjKjmhiDxo+ThvK6hP7muTA5fFHE1PvPq2a/U/S06B6pxYIRAKmAdimgun83o6G8D/la1yQ7CckI43DtYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 11:21:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16282

U3VyZSBKYW4uIEkgd2lsbCBsb29rIGludG8gaG93IGl0IGlzIGJlaW5nIGRvbmUgaW4gWGVub21h
aSBpbWFnZXMgcHJvamVjdCBhbmQgc3Vic2VxdWVudGx5IEkgd2lsbCBzZW5kIGEgcGF0Y2ggZm9y
IHRoaXMuDQoNClRoYW5rcyBhbmQgcmVnYXJkcywNClNhaSBBc2hyaXRoIFNhdGh1am9kYSAoVCBT
IEkgUCkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGph
bi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogVHVlc2RheSwgSnVuZSAxOCwgMjAyNCAxOjEx
IFBNDQpUbzogYXNocml0aCBzYWko77y077yz77yp77ywKSA8U2FpLlNhdGh1am9kYUB0b3NoaWJh
LXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3Vt
YXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEt
dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8
qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEu
Y28uanA+DQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmUgdjIgMC8zXSBTcGxpdCBHaXRsYWIg
dGVzdCBqb2JzDQoNCk9uIDE4LjA2LjI0IDA3OjIxLCBKYW4gS2lzemthIHdyb3RlOg0KPiBPbiAx
OC4wNi4yNCAwNjo1MCwgU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4g
RnJvbTogc2FpIGFzaHJpdGggc2F0aHVqb2RhIDxzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5j
b20+DQo+Pg0KPj4gVGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyB3aWxsIHJ1biBvbmUgTEFWQSBqb2Ig
cGVyIEdpdGxhYiB0ZXN0IGpvYi4NCj4+IEFjY29yZGluZ2x5IHRoZSBzdWJtaXRfbGF2YS5zaCBh
bmQgdGVtcGxhdGUgZmlsZXMgYXJlIG1vZGlmaWVkIHRvIA0KPj4gc3luYyB3aXRoIHRoZSBjaGFu
Z2VzLg0KPj4NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiBQYXRjaGVzIHNlbnQgaW4gdjEgYXJlIHJl
LW9yZGVyZWQgdG8gd29yayBhcyBleHBlY3RlZC4NCj4+DQo+PiBzYWkgYXNocml0aCBzYXRodWpv
ZGEgKDMpOg0KPj4gICB0ZXN0czogTW9kaWZ5IHRoZSByZXBsYWNhYmxlIHN0cmluZ3MgYW5kIGlu
Y3JlYXNlIHRpbWVvdXRzIGluIHRoZQ0KPj4gICAgIHRlbXBsYXRlcw0KPj4gICBzdWJtaXRfbGF2
YS5zaDogTW9kaWZ5IHRoZSBzY3JpcHQgdG8gaGFuZGxlIG9ubHkgb25lIGpvYiBhdCBhIHRpbWUN
Cj4+ICAgLmdpdGxhYi1jaS55bWw6IEJyZWFrIGN1cnJlbnQgdGVzdCBqb2JzIHRvIHJ1biBvbmUg
TEFWQSBqb2IgcGVyIEdpdGxhYg0KPj4gICAgIGpvYg0KPj4NCj4+ICAuZ2l0bGFiLWNpLnltbCAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgODAgKysrKystDQo+PiAgc2NyaXB0cy9zdWJtaXRf
bGF2YS5zaCAgICAgICAgICAgICAgICAgIHwgMzM2ICsrKysrKysrKystLS0tLS0tLS0tLS0tLQ0K
Pj4gIHRlc3RzL3RlbXBsYXRlcy9JRUNfdGVtcGxhdGUueW1sICAgICAgICB8ICAxNiArLQ0KPj4g
IHRlc3RzL3RlbXBsYXRlcy9zZWN1cmVib290X3RlbXBsYXRlLnltbCB8ICAxNCArLQ0KPj4gIHRl
c3RzL3RlbXBsYXRlcy9zd3VwZGF0ZV90ZW1wbGF0ZS55bWwgICB8ICAxOCArLQ0KPj4gIDUgZmls
ZXMgY2hhbmdlZCwgMjI3IGluc2VydGlvbnMoKyksIDIzNyBkZWxldGlvbnMoLSkNCj4+DQo+IA0K
PiBUaGFua3MsIGFwcGxpZWQgdG8gbmV4dC4NCj4gDQo+IEkndmUgYWxzbyBhZGRyZXNzZWQgbm93
IHRoZSBzaGVsbGNoZWNrIHdhcm5pbmdzIG9uIHRvcC4gV2lsbCBzaGFyZSANCj4gcGF0Y2ggaWYg
Q0kgcGFzc2VzLg0KPiANCg0KRm9sbG93LXVwIHdpc2g6IFBsZWFzZSBtYWtlIHN1cmUgdGhhdCB0
aGUgb3V0cHV0IG9mIHRoZSBEVVQgaXMgbGl2ZS1zdHJlYW1lZCBpbnRvIHRoZSBnaXRsYWIgQ0kg
bG9nLCBsaWtlIHdlIGhhdmUgd2l0aCB4ZW5vbWFpLWltYWdlcyAtIG9uZSBjbGljayBsZXNzLCBh
dm9pZGluZyB0byBnbyB0byB0aGUgbGF2YSBwb3J0YWwgZm9yIHRoYXQuDQoNCkphbg0KDQotLQ0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


