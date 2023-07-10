Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A802EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 13:51:00 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.78])
 by mx.groups.io with SMTP id smtpd.web10.40100.1688996972044891035
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 06:49:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qmTfnHHd;
 spf=pass (domain: siemens.com, ip: 40.107.255.78, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdZwP6FO00Rg69oCkaRQfac9eIhytwb7UyYXQiZ3pcA6d5us+c6WuoPXeWxF+p5LiZw4jnTKMd35eod1hkIlExKoliXK8UI3+zfUA7eitXFQ7EuEvtU0BjHwuuhzkv6nSeRer/zJMYYjaUAwrXCkfhRUm1yP0OovDg2mipTfL5qFGsHIlVxkChHLQ1cz5OLT4ixkFZcsy0R8ePr4NzRpXM3fRN/6qLGJ4k74yHDAOURBtWvd6zICtO6Zuz9ey8HEv66kOYe6+qIJepA8E1zaV02r2ppLsgVrKRW2cdw7W3ANa03lzBkJZvi/YtrPVKw/guL7JVxbCMDPcbfSdMQS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLn14Cdk/Ht5AfdZcUIBEaEZcvD+MJglk0RG029AGPQ=;
 b=OH0V0RD+M77Fkd8IlEG3AcqFwNFt+odn4fP3D4Q9HQuy1ZRqzpbPWNC5pNJGd57sJ8Kl7+FZtQNjatJExAEOcZT+PxiAiJmT4fGZMCajK1rPnrqy7C+uJBp1rysb2aIshBfq0EZyrjifXso+TBuEH/M41ifnCKsfAGTczU0pp5wM3fWOj63VaUxaV7Erk7KuwylbOnbGrYLjQKP59Mcy21s0KE/a8Gl8ViJ6RZlPRaI7lqvuNJ3yB1hvY/YL0jmtrrYIQHq1QHkmCUR/rUXcbAjG6Z+6XwtnFBMVc6UpJeCMt/lGRMYgWCeXWc8enppJOntZT+KZB9AriA3sQcDYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLn14Cdk/Ht5AfdZcUIBEaEZcvD+MJglk0RG029AGPQ=;
 b=qmTfnHHd8h0MCLQsi7xGOHGs8YJMfqNp3lHmTJ8bYffqkmU2MryVCF8hjpV9qn4CMS1uFzUXis7XE0CLgco5+OKU1fBYcryDYi0OwtvZIEyZ3rf51akib05XX07TJFH06Y8b5BUl7oBUof01cSnc+nd82a9LgkiOKgRPUixPgHS9DvHDuMEA7wLMMjsDanW9nej9AfxGmbOieYUdQdWVA+RMWVxAZAMjiTmTRVrJ72lFuLUDq+E9q8m4bM9ZegOmUTXIhZWZ3OpVCjZAgxdW8rygV+VWlu+nShD1FzRVThT2eq9jPgx2lSXP0O9lMfccnM8lsEK/6ggEBsDrLtmBEQ==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by SI2PR06MB4217.apcprd06.prod.outlook.com (2603:1096:4:f1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Mon, 10 Jul 2023 13:49:26 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d5f9:5f6e:55f5:1c3c]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d5f9:5f6e:55f5:1c3c%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:49:26 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Srinuvasan Arjunan
	<srinuvasan_a@mentor.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to latest one
Thread-Topic: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to
 latest one
Thread-Index: AQHZsyoYGWRERGnNRUGy5x0+k3RnDq+zAbqAgAABkSA=
Date: Mon, 10 Jul 2023 13:49:26 +0000
Message-ID: 
 <PUZPR06MB574771EFF5FD7AC1026120898830A@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
 <1a507755-e6db-3ef1-ff0f-cf863de4e2af@siemens.com>
In-Reply-To: <1a507755-e6db-3ef1-ff0f-cf863de4e2af@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-07-10T13:49:24Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7da4dfce-afcc-42eb-b456-d203820c58f5;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|SI2PR06MB4217:EE_
x-ms-office365-filtering-correlation-id: d8fd0b98-aed7-4024-9e76-08db814c79c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4CKpOzYS0iSBXPN/+I0PxueTBIlxl4sq7hRG9ktHRMSFBrrHqu0s70gO2rBecg9vfNu6de/bEFBlXxiTaC6NW/tYj093d3TlaSbXWZ/mJPjWMVuAkCmb1qYrEujyHSkHUsHWLLdaXBmQuLgvOMiKn0ikfESBTFALbSfX8wr1q97H+p651kdipIniFllxFKuiu6x+1RxSEzoXLkMm3lvx9YM5VaN57EbxTzawDBoVTlwAIxrKddv09Jz2k+AOR42eeQohy5t/Rnd9fFq93Gc+GDn50Xr4ZPM79n8OTLBj/wSqCspVTSiEgtLR6X77IF+UuqQY37B14Kp59m5NfpED8isNJRkwyK8oXffEM0/kUHJt2DZJgcpQnKpAdPTJ3KHqS8Ygu4f/KvaZsv31q0ncEqQ2Bry1q3GlazGlE0btqNH9yMt5lFH+aAmWTsHUzo+ba9Ko9eqRtFNCt+QnFpxPJhOUTe73aNNnhU+5G9kqe4Yv70EB+DPdNbSQJo8BKQ4cxa+VASivebYmb6Q6OzVH7xFjLQ+LSdVXPDIi+Ez2UYpLSqtPfVdMg+mRqQDvpx7hjWzEB71QlV+j41KAyUrFGt3aHHBYmMOYHzpHfaH3xmbDsjdrR3idGn3cJKGjLJgT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(2906002)(41300700001)(478600001)(71200400001)(7696005)(316002)(38100700002)(55016003)(38070700005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(82960400001)(110136005)(122000001)(15650500001)(33656002)(53546011)(26005)(6506007)(9686003)(186003)(86362001)(8936002)(8676002)(52536014)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MW1YMXFHdTZvZGZDQWpHZ0hZbVpoTytEUnE4ZDJSSWZhZm5HM0tFalE4Y01S?=
 =?utf-8?B?ZzFYMitiZFVhT0xCZlFrQmZVdFIxQkZWa2xCcHZpMmpIS3RTWXRNa1FIRFBZ?=
 =?utf-8?B?RysraHNobEJKdm5MRGthV0M3TGJLWFRQYlN0WXFGUWplUXNXRm01ZC9OWlJj?=
 =?utf-8?B?ZTQ1YzNTVXZsNnQ2ZTdEdXZtV3RxSGxoSmpzeUt5a21WVVJyNEw0c2hDcEo1?=
 =?utf-8?B?d2U1MWxvM3ZOT1BkWHhVMW5seWRzVEhPRnVBTDA3ekpUblZXYzdjYzdINTIx?=
 =?utf-8?B?ZUp2Q3ZaUnY5TDRQY0xBYmxvcWpaVFlmQklnMy8yNjhWSGZvbUoyVlowcFFr?=
 =?utf-8?B?b0hOTzEzWEV0ZlZ4cDRhbnFHYTVZekdBWXZkdEh6WDYwZUpQN2pJbWQrdDN5?=
 =?utf-8?B?YXJMM05kU1JZTFp4dkhxUmk0TTN6bFRPZlBUVDRnK2J1SncyYm1CUWNqUDZU?=
 =?utf-8?B?YUhUdlFRMkRXYXRvMkpuQnJOa2hGZkFPaWoyeHpLM2JVSGlGWFZoQzhaMlho?=
 =?utf-8?B?TlNnN1R2QWNFeDdXb0ZMSnFLdU5kYmRjKysrYjNTMHVLdkRsMHBVV3RVUzZL?=
 =?utf-8?B?a2NUWEZhMEtwTU9kN24zeWRreU5KcitRK3k2Y3B2Q0FuM2hYbllyOWRZNnVu?=
 =?utf-8?B?QUpzcTJPbm1rUXd4d0F1OFdTbXdQWmc0MHgvSWR0ZTBVUDFVVTU5MXBxS3ZX?=
 =?utf-8?B?QzMvQjc4YU1oVVdJQ01iUC9WS2VEVGlKaWpuN1RYbGs2OUZXVys1SmRSNUl5?=
 =?utf-8?B?Y3FjNUpEWEwxRVpzVzQ4SmhiMTFSb1pSYzdpODh2d2tpWGNCOTcvSUxsTzZV?=
 =?utf-8?B?UXY3YzVHQ0RqNkk4cXFrN000aVFmUjBkSE9GNHU2UmZUVmV5UmNoREdLbVpk?=
 =?utf-8?B?dnZaUEpWZVpSZUJTMCttY2R0NjdYaldONDlrMHdQUmp3ZnROeVRBYnNCZ28v?=
 =?utf-8?B?WHgrcEZSaXRGMEJFbTEwelhHcGpSWUgrOGlGM0NQa1FXL3JHd2NIRXJ4bTJp?=
 =?utf-8?B?ZEtJM2ZXNlNvWWRnRjhlc040cjZISHZYNHZXRkEweUs5OFZYV3Z3MlQxMDVv?=
 =?utf-8?B?VjNZamE0ZmVzSFo2YzZwdDlnK0x5Nmg4cENnaHFJNWdGaXBMSU5aNm51eWs4?=
 =?utf-8?B?cmxFZHYvVnVMM1VDcTB0VTN0aHhZVldWeUdDVEk4MTZjV1gxVHZPVTY1Wlp6?=
 =?utf-8?B?U3ZLMGdCazBYc0RTdnlqcE1RQUZUVXZjV1Jxd2NOTjFkd2tOU1MrUWcybmZR?=
 =?utf-8?B?SzVsNytpUFpWZkZnSmRCa29nQVpMWm4rdy8yajVyVDlMMy85MW1hZ09FQTJp?=
 =?utf-8?B?VEZwWjk4bnJqNmFDTlQ4aytodEVFRUFtU0JPOHY3ZlRBSUNLa1NlMU8xZG50?=
 =?utf-8?B?REM3bU8xTDg5Y3JSWDV3UmRiOVNaQ0tCZnVGc1BHRWRBdGJPSnQ1N1Bjd1NM?=
 =?utf-8?B?QU5Ma1VOVGZPZ1hML0JVZ1lXNmZtSzMzUzdnN3VrNGt6dkQzcmlKOThXMHhX?=
 =?utf-8?B?UldUU0xuMk1nZm9nSHBDUTgySVUxZE15SXlpQ1ZlZDNVeFFRODVFWkpBYUJZ?=
 =?utf-8?B?RHg0T2c2QkNjYS9kR2dicWxMcERhRlFiRzNsSU94czV2MGhnellyOEZFQ1NK?=
 =?utf-8?B?YTdqYnNuSnhWcU9la002L1B4ODdmT3JUZnJrbGxleE00NHJBRVR6bnpMa1lQ?=
 =?utf-8?B?MTJaaFV6aEV1ajRJdlNrQ2crMkxvVlJNUXJ4andYVHNCdkZtUCtSWklTb1BI?=
 =?utf-8?B?RkhZK1Zud2VHZWx0dGFVSjEzbFdBekZHeTdMQ0VWVmY0eVU5b3NQVXQxKzlJ?=
 =?utf-8?B?Z1hJZDFHSmg3RDJGb0R1K1RaM25jZjBuWXNvTEIrNUxQNXJBSS9tMzJtYmhN?=
 =?utf-8?B?MU5zQkZ0UmtjMUQ5SU1PcVFBL002dGVXR3YwQU5wSWtBSWJ4dWF6TVhhYVVI?=
 =?utf-8?B?MDRFN3ZRRXNhb0N3U3VGZlREL3h4WXhOM3JYMmY1M2kvc3VTZlVuUlVLbTdM?=
 =?utf-8?B?cFU1SGhxRTA0bWc4cXdEOW0vL3pkOCtZTVExUXdUVC9INEg4VHlhZ1d3ZWN0?=
 =?utf-8?B?ZXFXM0RtNXhIVUhZVVMxMGFwdEpzRW9hVjNiVTNBQU5aSG9GN3IydlhhVnB1?=
 =?utf-8?Q?edd36+ROevTQFrrHKi5rbY4Fq?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fd0b98-aed7-4024-9e76-08db814c79c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 13:49:26.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU/lAwRFt1h9EglCHvs77o4GVMEvid0bW1NOOYvaxEO9mSmt3B9xEDWmRfhQpK+q/AJQ/+JvBkVC86Tmq4OCIiEtohzY0bFjVjn8pn5tYo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4217
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 13:51:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12296

WWVzLCBpdCBpcyAxLjUuNS0zIGZvciBbYm9va3dvcm0sIHRyaXhpZSwgc2lkXSwgaG93ZXZlciBU
aGV5IGFkZGVkIG11bHRpLWFyY2ggc3VwcG9ydCBhbmQgcmVsZWFzZSB0aGUgbmV3IG9uZS4NCkkg
Zm9yd2FyZGVkIHRvIHlvdSB0aGUgZW1haWwgcmVnIHRoZSBkaXNjdXNzaW9uIHdpdGggRmVsaXgu
DQoNCk1hbnkgdGhhbmtzLA0KU3JpbnV2YXNhbi5BDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBLaXN6a2EsIEphbiAoVCBDRUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiAN
ClNlbnQ6IDEwIEp1bHkgMjAyMyAxOToxMA0KVG86IFNyaW51dmFzYW4gQXJqdW5hbiA8c3JpbnV2
YXNhbl9hQG1lbnRvci5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IEFy
anVuYW4sIFNyaW51IChESSBTVyBDQVMgRVMgTEkgUEJVIFJTT0wpIDxzcmludXZhc2FuLmFAc2ll
bWVucy5jb20+DQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIXSByZWNpcGVzLXB5
dGhvbi9zaHRhYjogVXBkYXRlIHNoZWxsdGFiIHRvIGxhdGVzdCBvbmUNCg0KT24gMTAuMDcuMjMg
MTQ6MjcsIFNyaW51dmFzYW4gQXJqdW5hbiB3cm90ZToNCj4gRnJvbTogU3JpbnV2YXNhbiBBIDxz
cmludXZhc2FuLmFAc2llbWVucy5jb20+DQo+IA0KPiBVcGRhdGUgc2hlbGx0YWIgdG8gbGF0ZXN0
IG9uZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNyaW51dmFzYW4gQSA8c3JpbnV2YXNhbi5hQHNp
ZW1lbnMuY29tPg0KPiAtLS0NCj4gIC4uLjAwMS1Mb3dlci1yZXF1aXJlbWVudHMtb24tc2V0dXB0
b29scy5wYXRjaCB8IDc5ICsrKysrKysrKysrKysrLS0tLS0NCj4gIHJlY2lwZXMtcHl0aG9uL3No
dGFiL2ZpbGVzL3J1bGVzICAgICAgICAgICAgICB8IDIxIC0tLS0tDQo+ICByZWNpcGVzLXB5dGhv
bi9zaHRhYi9weXRob24zLXNodGFiXzEuNC4yLmJiICAgfCAzNiAtLS0tLS0tLS0NCj4gIHJlY2lw
ZXMtcHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0YWJfMS41LjUtNC5iYiB8IDI4ICsrKysrKysNCj4g
IDQgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgNzcgZGVsZXRpb25zKC0pICBkZWxl
dGUgbW9kZSANCj4gMTAwNzU1IHJlY2lwZXMtcHl0aG9uL3NodGFiL2ZpbGVzL3J1bGVzICBkZWxl
dGUgbW9kZSAxMDA2NDQgDQo+IHJlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0YWJfMS40
LjIuYmINCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLXB5dGhvbi9zaHRhYi9weXRob24z
LXNodGFiXzEuNS41LTQuYmINCg0KRGViaWFuIChldmVuIHNpZCkgaXMgYXQgMS41LjUtMyAtIHdo
YXQgaXMgMS41LjUtNCwgYW4gdXBjb21pbmcgdXBkYXRlPw0KDQpPdGhlcndpc2UsIG5pY2UgdXBk
YXRlLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkNvbXBldGVuY2UgQ2Vu
dGVyIEVtYmVkZGVkIExpbnV4DQoNCg==

