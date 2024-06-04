Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4BC27C53
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 07:16:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.15736.1717485362717520323
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 00:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=PjlsPTUM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717485345;x=1718694945;bh=qvAxFLJKKlOQ1eMxLNm3Fq1ncbo7VqxMOBWjfG9
	dpF4=;b=PjlsPTUMoNpot2cX9y1FK8Be7p2EN5cG0JrsS9mBp1GB7JShorFT/BiV96Aj5QWsdcAVW
	b1e9DSpUQtmKGGGl3w8H9+WRj6LGeWJ4Ycz3lB+PIUDtxTEWtONr/xfMmhnjHl1pFaH+Py0OO3yTf
	06kNVv7j1HhFgSfZfP8t2aHbr1Or6ni2a+6UfdU4kzzNke5gvvsf20VND6TvO7HzoyTOLIaDEW3go
	FkKAGSHGWarf6OLFchcojx3yyjrF7E09GvHup3off2UZT1t+oXt5tBSWXQWKLOplNBJ/jEl7qcxrH
	S8SWSv2pgqWaolOSil4uNRV87jCG4x2L336/vz9pEg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4547Fj511916731; Tue, 4 Jun 2024 16:15:45 +0900
X-Iguazu-Qid: 2rWhclmqS1QqVnOBUj
X-Iguazu-QSIG: v=2; s=0; t=1717485345; q=2rWhclmqS1QqVnOBUj; m=hMZZLB6QX+5JYg9LWs5sRK+LpbHxd9a+QSMTRlyjKL4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4547FhUW3406715
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 16:15:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl2gceHBijsK1sCDiP6Y7VhHKfOjrhYyxVpvzeXpYfa96jBRgbytiMLuLXMnAPdmPZxNBTIsyf+JYjJ2s44sbCSy9nJxOS7CDL91fJZriJnQSfrQWoMT/+KGZxkzxibKzKjYuDOS6dWG7qPIo5R+wR/ZSBa8soGDoWweSqdG2wgrXf2UwUMNvRBv5am+fDyhuvrxVuFL5tRmGMEOpPAwvtrekA3z/7x/Gb+x4Um+57WxAyzBjEC/sOvGCJ88NBeXB4g7irxPpm/CcZiLE2ew7iXAi3nPJMyrtIFl0w4CG+Q1MVifWXy6iHD3aXBGKE3IFTn66WPwdMAiq6FCfhk3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvAxFLJKKlOQ1eMxLNm3Fq1ncbo7VqxMOBWjfG9dpF4=;
 b=fqKDMRpOjfPaeMB0mM0KUyOKfTyfcSWnqBMcJvgw7JMXZazxbFHbl1fN9J6TsQvtda4F24di7A1Mpm12Vf/HOJSxLgfrt+edL3+NafUm6XxYBu0vKQS86dSk/5EICEfmlUdVzIFpCn7ReY0+swI8D2fL1gt9es/Dak7TCaugNru52MP5CtohDYMumICJwTkpwY147egeZ1aKk+/75MApReP10ankxe8rv76s/l5c7MQMhb1B76bDPp1a5P5sRofSMTQJTX/7wFAHcnioI/UH/BLZymTWm0HbAzW+1QfNXIe4BbtWUcVXs7MbDKL0BA7EMl1PMsg6Bp4Ms2Q4K9Jj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: Request for reviews for 4.4-st53, 4.4-cip88
Thread-Topic: Request for reviews for 4.4-st53, 4.4-cip88
Thread-Index: AQHatZsoaOnT7139Yk2DkBgXXAX/NbG2x96A
Date: Tue, 4 Jun 2024 07:15:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638863B7585B3FAC22D71C5692F82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1638796688.696518.1717408079442@webmail.strato.com>
In-Reply-To: <1638796688.696518.1717408079442@webmail.strato.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB10906:EE_
x-ms-office365-filtering-correlation-id: d1f86783-8f83-4e09-dc47-08dc846623fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RVdPdjY3bnltMlhtN2UrUEdhUWZtSDR1TVBUVWhVQWxMd09MKytEVGFaY1Z6?=
 =?utf-8?B?MHJibEg4ZVdORjJkU1ZkMzJ1RUhKdzJMMmdTTTVYby9Ka3lnTmVEVlRLb1dl?=
 =?utf-8?B?d3M2eDRtN0d1ZHl1UWI5VlFuaUhYak9uT2Vka254MUhhOStIL04vdkpob1VW?=
 =?utf-8?B?NkNNZWJITmJ3YktOcDdvb3ZJWGJPTWFOOGV4Zk9pbDdyN24wclZGTXdPYm1F?=
 =?utf-8?B?VytRajc0OHBvWGdTUVN6b3c1QW8vWUw0ZUZYOXc1TG1CS0hjK1U3OUQzL3F6?=
 =?utf-8?B?emxBSFpQaHV4QXBpc3FJbktOdGpFamVXUmxRK3BuQkg5MzVidzdlVjhFSGEy?=
 =?utf-8?B?KzhsUWxBd1Z3YVdZVUZja3B3QVR6dnpoTzY4cnBlSUhTd1U1RnhOQ1FXNVdT?=
 =?utf-8?B?TjVDMG82aENJYzFJbkFKa1M0RjNnZmtxdVVlY3IvK3pKY2tqcHY5ODlhbDBI?=
 =?utf-8?B?QWp3L2ZiTmZQY1FWdzJEV0Q2eFpwSU0vZEh2STVQK1VUZkZzSm5FMTBnQVpP?=
 =?utf-8?B?bmV6djVxRHBseHlDWXluUDVRaGpiT2NPTXZCSWJYczF3ZzlXUnJuQy85bTRN?=
 =?utf-8?B?MTN3RXBUejBpTVRsSHVySGdNQ3NFdzlmbFVFbWxRQ3E4WkVYYkRDVStxNmY3?=
 =?utf-8?B?L3pYRFRPSnovejJqdk9kLytzU291UGtBZE4xdEVaM0lhT3RLUGNUeURWOHlp?=
 =?utf-8?B?bi91YS9KaEx4eWU0RFhyQjF2MktQaUxLL0x0ampFeXhtbXNYZU5ibEtpSVdn?=
 =?utf-8?B?ZVAweTJWTElvQlR1Y3VGVjM0K1dsSUppVFIvZEljRlNRM3JBbm03b2ZZWVdU?=
 =?utf-8?B?enlvWHN4WW91dFpRUjE0b0M1MDFkK3VZdUVockJRM2UzUmFzY0tYTVNNdnI1?=
 =?utf-8?B?MzVNdmRzZGZ0YU1hU0pwMk8vTHRwTE9pNE5SSk4ySXEzY3NsZUFJU2RYUU9Q?=
 =?utf-8?B?NTdDeDVwYkVSNTArTjZSM0dxVitRWFppUkdTUEVqTlBwOXpoY0JRcHVaTjNY?=
 =?utf-8?B?cmxmN0xQNWduYktLUGdvbjh0T0t4MUpyV0hMdjhJNWlLY281LzNFc05KUHY2?=
 =?utf-8?B?blhKTGFCY0svcGVjQWR6TlBIa0R0SlJqSHhzMk5wUVJJUmVBUVJKc1ljSnIr?=
 =?utf-8?B?ZDc0d2ZYRkxRNXc1dGpuMlI1a1VDaXpXL1VZajZnaXRBYUx6ejlrN3ZITWt6?=
 =?utf-8?B?TlRWb2hrb2IwNWIvSXRzMGJWdzVoZlhaejJtZEJHalBiVy9yOGNNVkZ0cGlo?=
 =?utf-8?B?VWZhbTJudjRtTWxxVjFXWk5zeFRnM3pnd3F6MmU2bFcxdUYrZXBTaDNwMTZa?=
 =?utf-8?B?MGlteDlDUXExcFJtNDVta0RJRXdVTTdYL0hYcFo2V0ZMZnhUVG1oU0tyKzVY?=
 =?utf-8?B?ZnA3UnVCWGZlalA1aVNqWWQzek1sSE1kd0NUUlhDcG8yNHBtUUpxQVhkZzJU?=
 =?utf-8?B?VCtRTktOZjlxYmkvcDNabGpZNkNUSlFvSXFwQU04anVNZWZGMWhpbHNhOVZh?=
 =?utf-8?B?dlhkL1ZKOTZ2VDNENXlpWVJnL0tJVzlKUlB4Yk9Wd0dIODJjK1JrWDRVZ1Er?=
 =?utf-8?B?d2RnM0tJZFo4Yit6N3lTdVM0Q1pxRTFhbzRlRUdrUjU4QUxVT1dEWWxaT1hH?=
 =?utf-8?B?dTVCL2hQQUhxZW45dkdKQ29tei9HVk1WN0ZiTHQ1SVlkdlhnVERSYktJQjM0?=
 =?utf-8?B?S3BTVVl0aGFSTUtzSnh3RlhBWHp6dEg2QlM4a052WlM2RWFvWDBFMGhZcnVy?=
 =?utf-8?B?eHN0amlGNXY0UVJDaHNVQUdxUGlKSGRaYWlsckZ3VEI5NWlYelhTRi84OXo0?=
 =?utf-8?B?ZnJPTzlUbVREdmFyelV2QT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YnRKYTZXQW9FRmFabllhTnYrSFdOdjUrQWY3YkhTUTlZY1FkSzd0YzJadnEv?=
 =?utf-8?B?MWRyVEVWejhPcTVkcFppVGV3eWZVMHFRRU5OOWthZ3hmNTRnN2JLUDVobnBB?=
 =?utf-8?B?YWpEcWdjMFhvcXdLNFA3K1RvWWgxbEx0QWxHWklHZy9QTEoyb1lVOXNZZDhQ?=
 =?utf-8?B?MXErNU1xeUMxTWtmSUh4NUFiOXBiTW5VOHlCYzVvR1NGMzQwcUJkdko5N1Qr?=
 =?utf-8?B?Z3Jnbit1bndIcHJYMzlDYStnMmtqZGRNYXltTTIyVTUxUDFVVFN5THJid0hU?=
 =?utf-8?B?Y3lIRUlCOEI0QXVyT3h1d3ZqaDZBMnJyRUZya1UyN1hXeFhXMWxaeDNZRE84?=
 =?utf-8?B?d3MxRmZCM1hVZjhlbzhpRjYvQ0J5SCthb0pHKys4MVhLQVE3Y1I4dW45cVB4?=
 =?utf-8?B?ZGNrRjdwRHpqK0ZHL2ljNU0yaDFJSzlDM1VUbldUSC9RY2Y3UWgxa0cwQ2hr?=
 =?utf-8?B?dCtRKzNCbTZuQWt1N212UXRxWkRpZHBlc2dqdmtLOVNtbFh1SXlkMzNjMkNC?=
 =?utf-8?B?WTE0QTFjQis2NHVJaldVZHg1Wmovb3llY2RlaTZSSXVkQ0lTbEtoZ0ZxTlBq?=
 =?utf-8?B?YTJvVWwxcUFUN2xOYlp4eFM1bFphMFJ6eExFcmMrK2pTWkRNQXcxMzRudGhE?=
 =?utf-8?B?RWRWRzRzNjNpNFJhd20ySnJkQy83MFdaUmFmai9HMjRFOGVEbllXMUJ6SjAz?=
 =?utf-8?B?WCtwL294VXN4Y0g1WDRKWUFqTVphWlo0YXlsMGVJSFRvRkxvMHdseWh5R3o1?=
 =?utf-8?B?Q3RjL2E3Y1J3VjB0QlNBcDVTMy9URC9iQkRWMUpPdnRMZ1ZES0ZGSlJqOGFG?=
 =?utf-8?B?cFRGQVJzL3dkZmdFV1c0WFlJM1NYclRQaWYxM3pDMlpRN0Q1ZjlRYUEzc1hC?=
 =?utf-8?B?TUVFSzBtdGltQjI0cERvNnBWcEFFS055SjR1ZWNySk9MSzQrOWhvZWVxd0xP?=
 =?utf-8?B?di94MjM1RlBaUEptUFQ2OHU0N1FTTzJIOFJiWWNidy96U0tMUjUvcHVuQUFp?=
 =?utf-8?B?ZDFYanl5RkZYNmFQQms1NEJYamVqK2hvMmlkdGtHcUc2cHRwMjJFeTQrWHJQ?=
 =?utf-8?B?eFBJZWE1elRUZXl1ZUh2Y2dzY3RQQXZKSmxlTGZSTnVhQmdPbnlVUGRSRGpj?=
 =?utf-8?B?QXJQV0FhaU1qWkZjMHNqR0ZySGN4NERxNzhBdHZFYmZWRTJMNGg1dGVVMmg0?=
 =?utf-8?B?c3NzMjVIekdVNERmbld1QWJWSldERFNidkNMWHAzMWI3ZTF1eXo0c01lNUEw?=
 =?utf-8?B?OW5uZ3IxYko5dllTZlQyTDRvWHhZTGFpd3ZCb0F6SEIwVGJYVXAzU2gzaGRy?=
 =?utf-8?B?cXQ2U2xTbVdCeVdPakRoWVZMNExyYzZuREZCZ092S29QanR3OTZKeSs5UmEy?=
 =?utf-8?B?SkcwNkJ2ajI4a1Y5aWVCVHhyaTh1Q1A4NVB5bExxbEN2UWFEU2lxQnc2SXY4?=
 =?utf-8?B?dnZ6cU1jSW5jU2NiMHhsUWRMcEg1OW45NmdMRHFNY2NSdjhMNldIK0lZZEtv?=
 =?utf-8?B?Kzhsd3d6blpTOVpOR3hzcVpEUHNnaDFmbklQcSs4R3F4aFFvUGFlWEYvdk43?=
 =?utf-8?B?Z29UMXZKRHNKdTVaVUFsRnRkcVVuS0ozL09nb1YwY205ZmZFNGFRK1lRV0VZ?=
 =?utf-8?B?bng4VlA5Q2V2aDVyZjNzdE53aVlteDlxbkkwWlhCQ21XRVV0VDlNNmtaTnBv?=
 =?utf-8?B?MmpzOUplRVRKdTlLRjEzRzBkb1k5eHBzdmRDN0N2SnVwUHJVMFV2ckYvRTUv?=
 =?utf-8?B?dHZUZHBxSnVnaXZkYm9DZ1BvMzBWUEYvWFE0dFQ1ZmZBZk9qVHJaSXVwUm5y?=
 =?utf-8?B?QS9ZeGVuTFkrbm80alozYWhDK05LM2xVZ2NmN2dIK0JLYWFBS0ZCVmZRT0kv?=
 =?utf-8?B?Zi83THhKT2FJcFVJUmpsdXdlTThhTEVydEdUZytkc1EwMy9YK0RxOW9KcUtG?=
 =?utf-8?B?V3FPR2F2S1RqQ2pvdEVnaTRZVnI1TXVPYUpTZ0hjbE1Wd3dsWWJIaHhtUXJx?=
 =?utf-8?B?bE4wUk1XMkIzbnl1Z08xN2lRbkZVME81YVQ0UTIrM1ZoUWNYUXpHZGoremln?=
 =?utf-8?B?aG84Q0hRdUV3cHRQQU4wWVlJczBUUllnQk1tSk13SlNSRmxYWTZYMVNZYkdI?=
 =?utf-8?B?UWZmN0I2Ryt4K2hMYy82UGp4eU1UMHQ5ajc0SDhGSmhXdWJKMTU1S29aQklI?=
 =?utf-8?B?Y1hHblRHRzl0ZVhkOGtwUll0dUxQZE1taTNiNWFXbzFvZmdVU2VCc1ZYeldr?=
 =?utf-8?Q?Jez6pnTKeBJJ3ONdU7fynx5Fq0uaxVYNyJ/aoJARlM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f86783-8f83-4e09-dc47-08dc846623fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:15:40.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y15f3ISOFCE1zP+zwE6lYOXYigt6T3Woj6Bux4CPwPTwCCaVsTffBEdPC/i7Po8qzwG63C9mu48dd1Ka8uiKe5FuiN4Ba7zi0/JCNiBPo+8PJZe2Vwbwxtupm4ucbOeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 07:16:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16099

SGksDQoNCkkgbWF5IGJlIHdyb25nIGJ1dCBpdCBsb29rcyBsaWtlIHNvbWUgb2YgdGhlIGNvbW1p
dCBoYXNoZXMgYXJlIGRpZmZlcmVudC4NCg0KPiAqKiBtIHwgNGE1YTU3MzM4IGQxMDEyOSBvKyB8
IGlwdjY6IGZpYjZfcnVsZXM6IGF2b2lkIHBvc3NpYmxlIE5VTEwgZGVyZWZlcmVuY2UgaW4gZmli
Nl9ydWxlX2FjdGlvbigpDQo+ICoqIG0gfCA2ZmZiY2IzNzAgOWFmNTAzIG8rIHwgYnRyZnM6IGFk
ZCBtaXNzaW5nIG11dGV4X3VubG9jayBpbiBidHJmc19yZWxvY2F0ZV9zeXNfY2h1bmtzKCkNCg0K
ODkyZjViNGQ4NzA0MmUyMmMwYjM3ZmQ2Yjk5NTMzM2IxOGUxMTRlZiANCg0KPiAqKiBtIHwgMWY5
NTllNTY0IDAwOGFiMyAgKyB8IHNwZWFrdXA6IEZpeCBzaXplb2YoKSB2cyBBUlJBWV9TSVpFKCkg
YnVnDQoNCmRiYzY4ZGJiMDY3OTc0NDA5ZWJkODFkOTVjODU1ODdiYzk5OGVlZmQNCg0KPiAqKiBt
IHwgOGE0ZDEzM2I3IGU1N2I3ZCBvKyB8IHdpZmk6IGF0aDEwazogcG9sbCBzZXJ2aWNlIHJlYWR5
IG1lc3NhZ2UgYmVmb3JlIGZhaWxpbmcNCg0KYzdlN2M2NjgwOWEzZmNiYTc1NDllODVmMmJiNjNm
ZTk2YTRlMDQxMg0KDQo+ICoqIG0gfCA3YzI1MWFlOTEgZDMwMWE3IC4rIHwgbWFjaW50b3NoL3Zp
YS1tYWNpaTogRml4ICJCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQg
Y29udGV4dCINCg0KZjkwYWEyZWRiMTQ1MzlhYzM2YzM3NjYxYTI2ZTQzMDFiZGVlODI1NQ0KDQo+
ICoqIG0gfCBlMzI5MTc1NGYgNTkxNjJlIGYrIHwgeDg2L2luc246IEZpeCBQVVNIIGluc3RydWN0
aW9uIGluIHg4NiBpbnN0cnVjdGlvbiBkZWNvZGVyIG9wY29kZSBtYXANCg0KNzJlNDJlMGMxNjMz
MjYxNTQzNThiMzMzYTVhZGJiN2FlY2I0MjNiZQ0KDQotIDZlZTA1YzFmMThmZiBwYXJpc2M6IGFk
ZCBtaXNzaW5nIGV4cG9ydCBvZiBfX2NtcHhjaGdfdTgoKQ0KICBUaGlzIHdpbGwgY2F1c2UgdGhl
IHBhcmlzYyBidWlsZCB0byBmYWlsLiBUaGlzIHBhdGNoIGFsc28gcmVxdWlyZXMgb3RoZXIgcGF0
Y2hlcy4NCiAgZS5nLiBiMzQ0ZDZhODNkMDFjNTJmZGRiZWZhNmIzYjQ3NjRkYTViMTAyMg0KDQpB
cyBmb3IgYWxsIGNvbW1pdHMsIGhvdyBhYm91dCByZWNvcmRpbmcgdGhlIGNvbW1pdHMgY2hlcnJ5
LXBpY2s/DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbHJpY2ggSGVjaHQgPHVsaUBmcG9uZC5ldT4NCj4gU2VudDog
TW9uZGF5LCBKdW5lIDMsIDIwMjQgNjo0OCBQTQ0KPiBUbzogcGF2ZWxAZGVueC5kZTsgY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6ENCj4g
5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkgPG5vYnVoaXJvMS5p
d2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBSZXF1ZXN0IGZvciByZXZpZXdzIGZv
ciA0LjQtc3Q1MywgNC40LWNpcDg4DQo+IA0KPiBIaSENCj4gDQo+IEhlcmUncyB0aGUgbWFudWFs
IGJhY2twb3J0cyB0byByZXZpZXcgZm9yIHRoZSBuZXh0IDQuNCByZWxlYXNlIHdoaWNoLCBhcyBh
bHdheXMsDQo+IGNhbiBiZSBmb3VuZCBpbg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdC9sb2cvP2g9bGludQ0KPiB4LTQu
NC55LXN0LXJjDQo+IA0KPiAqKiBtIHwgNGE1YTU3MzM4IGQxMDEyOSBvKyB8IGlwdjY6IGZpYjZf
cnVsZXM6IGF2b2lkIHBvc3NpYmxlIE5VTEwNCj4gZGVyZWZlcmVuY2UgaW4gZmliNl9ydWxlX2Fj
dGlvbigpDQo+ICoqIG0gfCA2ZmZiY2IzNzAgOWFmNTAzIG8rIHwgYnRyZnM6IGFkZCBtaXNzaW5n
IG11dGV4X3VubG9jayBpbg0KPiBidHJmc19yZWxvY2F0ZV9zeXNfY2h1bmtzKCkNCj4gKiogbSB8
IDFmOTU5ZTU2NCAwMDhhYjMgICsgfCBzcGVha3VwOiBGaXggc2l6ZW9mKCkgdnMgQVJSQVlfU0la
RSgpIGJ1Zw0KPiAqKiBtIHwgOGE0ZDEzM2I3IGU1N2I3ZCBvKyB8IHdpZmk6IGF0aDEwazogcG9s
bCBzZXJ2aWNlIHJlYWR5IG1lc3NhZ2UgYmVmb3JlDQo+IGZhaWxpbmcNCj4gKiogbSB8IDdjMjUx
YWU5MSBkMzAxYTcgLisgfCBtYWNpbnRvc2gvdmlhLW1hY2lpOiBGaXggIkJVRzogc2xlZXBpbmcg
ZnVuY3Rpb24NCj4gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0Ig0KPiAqKiBtIHwgZTMyOTE3
NTRmIDU5MTYyZSBmKyB8IHg4Ni9pbnNuOiBGaXggUFVTSCBpbnN0cnVjdGlvbiBpbiB4ODYgaW5z
dHJ1Y3Rpb24NCj4gZGVjb2RlciBvcGNvZGUgbWFwDQo+IA0KPiBUaGFua3MgZm9yIGhhdmluZyBh
IGxvb2shDQo+IA0KPiBDVQ0KPiBVbGkNCg==


