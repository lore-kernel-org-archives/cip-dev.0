Return-Path: <SRS0=AE4k=JK=lists.cip-project.org=bounce+64572+6360+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E3FC433B4
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 04:29:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B1B613A9
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 04:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B1B613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6360+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id e8lKYY4521723xfTPBNbp2o1; Mon, 12 Apr 2021 21:29:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web09.4607.1618288192951515056
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Apr 2021 21:29:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 13D4Tfq1002920; Tue, 13 Apr 2021 13:29:42 +0900
X-Iguazu-Qid: 34trSOSPtcEEpkB49V
X-Iguazu-QSIG: v=2; s=0; t=1618288181; q=34trSOSPtcEEpkB49V; m=lthY4H84xGQ3BfLP9T6V9YLSS+MFXIusIipNa8t8iHw=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 13D4Tep4021880
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Apr 2021 13:29:40 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 3943D1000BE;
	Tue, 13 Apr 2021 13:29:40 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 13D4TdSR028187;
	Tue, 13 Apr 2021 13:29:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3wk9qZXHtr6qWYTMlq6eUjgmJEFnZpQeS6D7SrnEtqgxx62ClB+dlN8j52qF4tKrJ5WL9UrXTEqraDdaRS412fFS95KpNiCFlmokQ/JSDwMXA8qg814YSlXxgEnWWoyy4NqNp9NOYrVSJc868obfrVNOpwfkT1J0tYu4QmgYh6UGEfI++E5lGpkk4hxZQ36FBe5jSLLWumlj4yLjYgQv6DYRSd2bGAooGXC5iDrnjzoG6rm4XxFDjeZQMuU8kRwbre/sj6+PV2B9wOHNbcpWzyXtsbIXN4f4XlUbu5XF1LFKdQSpjGYGt77RwneEkRgMyKxndaxC8076tAU84wCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaFescKM27J9qn7sYfDcTSkfUps9ioT/JaH3EGhxA3A=;
 b=MkoMZug9dZHEDq1r7Z0ycpHagjciXvXxvrS4HaYDh3we6y4SQjo6e7o5Ib1E3CyhOtuC+nYTAmY49OTsNMzMkpc9h6AhbGEsIaYFtdmg/3X0unGXIP7KFgXLajK1qHufo0T7N6PfqIpCp5xksYhFYGpRDT3lSOdlNFAfMXlUyPoGjZr1CmOjbqaqj3LVu9WQI5SL8ptz5bFerWHbNRxyqeFcx5m+11IGbQpe2UopPEIJu/Vb5qWS0MJWcei83bijKLalniSjbPvNNI8rBcTZbvO056uW2LRmWz+cKmb8/2Mf+w5JSYKz4zTG2ZF/6YvnPcTXAmbJLGkvFt/EyPIIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <chris.paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.186-cip47 and v4.4.266-cip56
Thread-Topic: [ANNOUNCE] Release v4.19.186-cip47 and v4.4.266-cip56
Thread-Index: AdcwHXSqjsdYmOQtTaGgi/Ur9qkw8Q==
Date: Tue, 13 Apr 2021 04:29:37 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983CB6A4F575AFB1B73CD3A924F9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8a8d8c3-5e9f-4df7-afe1-08d8fe34bf82
x-ms-traffictypediagnostic: OSBPR01MB4133:
x-microsoft-antispam-prvs: <OSBPR01MB413344EC7968F91C176979FC924F9@OSBPR01MB4133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mBqw2hDR3W/u0BsQ6WcCI9jQtHL/cqk0kAhyL/58kj8lNgTV56WoUTrdFzXZiLFDRT8nj6GVifJH5WaoknnlJsko0l5DcCQ0D5iqACOdzxiXBbEfUNuybX7sesa1knTneZP7YsiCtctdaxN4E6UyIBrrfJHDXlFTVbSt4vTz4O0PBHetbip2FIwiABrcxA4B0jnNFXRCumvBA+nW0JBtyH7n91P1RhNTVMIu5RRxzKVIM1pyy17cEWIUypdPHAs2Qvihf6OH16E8Y3qPNxPzQLrt53Mi5rZfilDh2/Omsr+Fsxp4tvq/rbXQJ+BaBKMWPvpfDwPKqAH5f896GT5Vc2TqSB8PnIOVdcyNJJeDJ1Nz/xM7X2SWr671iiOw6NsYsvKMI2iR01vY3twgrzyphfAJ7FG4scXkChRKJg4YcHInfHm0Qtxxwwimi6Gl1gd24A36r6BZq/70IvVjFzJPH2r9qneHO3SloH2/xboC9FawGemro/vHH08VNjBZziwbhbd8uwY3GIzS1h6pPKMrZLLSjbWU1G8t+QGNIbVV5V5p8UW57iMiKkqkDI0AlKfNkfZDVElPMAC4cq0AmuWOvW+bQ+En5GoZ83suvGmxKY/jefT1BB1WLHOXZBQefYNqW7jjeWQKgnyW2XzYN/olcc0UzuN6VXe/izLmYb804bc=
x-ms-exchange-antispam-messagedata: =?utf-8?B?eUIwbVJyMTBlMjNZd0ZEbXVnSElkZVlXTHpFZGFSL281WkIxckR5dmxvRVRr?=
 =?utf-8?B?K2I5YU1hblp0OTBnMGFXT2FDdnJnc281MVRjU3k4S2RIcFhUT0swdldMNmxK?=
 =?utf-8?B?enhmL0RoQVRWaWtEY29zcElrL1ErS01nRE51V0VXdE14QkNhYUo5SktQS0FP?=
 =?utf-8?B?UHl3SXhwY3FDRThaM1hnOUxqSVJQcGt6cnZKeGtRN0x0S2lrUzdGZkZITmMr?=
 =?utf-8?B?dXFXY1VQMm5TV0UwVEV3MVIvcVpNN1J1c1FnTHJKaHJiVE9DVy9oQ0tXUCsz?=
 =?utf-8?B?WUM0WENrUVRNRSs2bXNRUG9rYml3Y2JKcVI5K2I2VTJXZ1I2bjZ0S2xZMnJE?=
 =?utf-8?B?ZVBTQXdpTlduOGJJTU9ZUHR2cVZUeWYwRzRvY3ZRbXhtS3VGN05XQVh1RGdE?=
 =?utf-8?B?TGVCQXN4Z1V2TWJGZXA5VHlFcDhqZWR2SmhNRXlpdjdueG1nOFBzK1dOVzZM?=
 =?utf-8?B?SXZTZDcwZHkvNWNoZEp2UnpJcVlwL2xkTjJBa1grZVEyazdKK0h6d2dKSG1p?=
 =?utf-8?B?UjdOb2RMeXRucUxzK2VvclpFRVF5Z3BPaVMzMFdwYUVGUVZoKzF2NlhUS1lH?=
 =?utf-8?B?eUwrVFRWNDh1N3RzOXF0cXFUUGZzWm1mcEVlZlhHd0FjTzJ2ZFA1NVFaQlhu?=
 =?utf-8?B?bG1oT1Vac09ZN2Z3QlQrTXJ5Q3pzUzNGUE1FRUgrNlg4c1JOUzMyUWpGd2Fp?=
 =?utf-8?B?YTN1elBYSVFwMFVkNTFMOC8vdnFJbXlFNE82TUJOM0ltSGY4bHVvNFFzbWVC?=
 =?utf-8?B?NWllaUxSbmUyaytNbGtuWWd3Vy8rYmRyY0lRdEpva2lVY0tNM1VwbkI5N0tZ?=
 =?utf-8?B?d0V0Z2JWS0ZORTZlSUxVQk8xMWMzTmU1dW0vdXkzWG5DSC9TNFZHZmxpTVJj?=
 =?utf-8?B?L1RUTlFnVmZkVUJBZnVtZDJ2bWdjWWdoRTY0MjJjYlVDSUdsTDVJaFIyYW9C?=
 =?utf-8?B?eU1oUWVURUUzbmcvb1YxZnRhVFo0eEZTZGNnN1g2bExaRi9QMGx5ekZmWmY2?=
 =?utf-8?B?MUxUQUpQVWk2RmNRL0c0ak4wRFEydTJWL2xYSHJBQjBBK25FcHZaNGRJd1No?=
 =?utf-8?B?ZXVHa1V4K3lBRThuUlhOYkdwY2ozelU5ZUt0RFAvSnZXQU8rWFNucFl6blFx?=
 =?utf-8?B?RzUxS2d0dm16eVpmUDBlaDc1ZlZrVjNiU3c1Z0VWRkFiSWtBYUQyYitScXVi?=
 =?utf-8?B?UmthTHdmQWlEM0pOVll6UEJoNjIybXZBQjRodmdDb3NQeE0rSWlUdTBHbHVU?=
 =?utf-8?B?OStPb2ZqVkpWRVJ4V3JpN0FteXBZWlhnUmRPMVY1TE5QSTdQVzBoSkppb0tO?=
 =?utf-8?B?R2hpVlNLZXZOTTBRbmNNc3JkOXlRTnNTbmM4cGJ3NVkxeUpjVFEyQUtDZFE4?=
 =?utf-8?B?V1hubVVxOGFWQ0JuWDhNSUNheW5NWW1hemd3REc5NS8xTnZkWnZ4aUZJYzZw?=
 =?utf-8?B?c1FuY1MrL2dDRi9xb0hlQmhhekxtcTBkdTh5VGlRck5JVnJDb2NFSUdFT0FV?=
 =?utf-8?B?VFdiZWNNdG9XTnZBM21zbjNIRkFWRkdDeVIxMTVpRFBvTkVCK3pmbWlIV0RW?=
 =?utf-8?B?c0RJZm5qaHVna25OeDdJL1dpdlVKa3J4RUhaVnRPUzl4RU5keWsweU5QcS9T?=
 =?utf-8?B?Y1AzRjc5dDBmWXZYTkRHVUFxMDhLWVRKMUlVdGUyQnM5UTVybmErRUNsbFY4?=
 =?utf-8?B?VEpWeGtFUTFOalRVSUtNMG81aW5rQkUvanp0TVhGR2RXNUlBRFg3OHVFMGp6?=
 =?utf-8?Q?5uBJY++hUjULuzyexY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a8d8c3-5e9f-4df7-afe1-08d8fe34bf82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 04:29:37.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfAQQQNRJ4TFa7HPW1KQh8kdBbgJc9SeUQQgEh7GmmiFlMm1E472P3KCR0kqn4JRidUmTFtwdZTk60xPC3PricCtybycgI8rGsXwZKKIjXTO+skeGb9qvjut5n1Al+Mw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4133
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Os0Nz55JrqvK1Rgc6maj9fasx4520388AA=
Content-Type: multipart/mixed; boundary="BRLBNnbMzHOwV5PEGZfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618288195;
 bh=WrJb8zefAhkq5zMApt6Qnz+k/a2gstQ53w2IYeQFmNA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=JJN5d+KMJUce+v6/b4Q/u7nblKdER+VOzsU1gHxmOe6rBHR1nEjjPAdtnQU5dmd+z6q
 VRPVaP/3JGylhNHgi3rR3Ie64LMd7lBSUhnkzU8hxv+XeYNZWwNX3OSEvf8r4VqrUAcnY
 Vg2z5NAx8+PtOqZKU/KOUj7sYYgpLbG/CHg=

--BRLBNnbMzHOwV5PEGZfF
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE4
Ni1jaXA0NyBhbmQgdjQuNC4yNjYtY2lwNTYuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgdmVyc2lvbiBmcm9tIHY0LjE5LjE4MyB0byB2NC4xOS4xODYsDQphbmQg
dGhlIGxpbnV4LTQuNC55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQgdmVyc2lvbiBmcm9tIHY0
LjQuMjYyIHRvIHY0LjQuMjY2Lg0KDQpZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBn
aXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xODYtY2lwNDc6DQogICAgcmVwb3NpdG9yeToNCiAgICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51
eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1p
dCBoYXNoOg0KICAgICAgNmFhY2MzOTJiZjcyM2Q1NzMwODQzMzIwNTRhYTMwNzA0MjQ1NzZmZQ0K
ICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNp
cDQ3IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCiAgdjQuNC4yNjYtY2lwNTY6DQogICAgcmVw
b3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC40Lnkt
Y2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICBjZDVmMjExZmRhOTVlNDNhMzdjZTJiZjFkNTg0
ODYyMzM2NDFkYTliDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9u
IHN1ZmZpeCB0byAtY2lwNTYgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVzdCByZWdhcmRz
LA0KICAgTm9idWhpcm8NCg==

--BRLBNnbMzHOwV5PEGZfF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6360): https://lists.cip-project.org/g/cip-dev/message=
/6360
Mute This Topic: https://lists.cip-project.org/mt/82057529/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BRLBNnbMzHOwV5PEGZfF--
