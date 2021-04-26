Return-Path: <SRS0=TYjD=JX=lists.cip-project.org=bounce+64572+6394+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F86C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 05:49:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8430611BF
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 05:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8430611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6394+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kXcjYY4521723xfN9Qb26BJy; Sun, 25 Apr 2021 22:49:20 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web11.3172.1619416158008015790
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Apr 2021 22:49:19 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id aOsL09285A;
	Mon, 26 Apr 2021 14:44:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpu2m2AQaShSXAv1MzH6qMMXxBX72HsAIuHxvW1A3WD7LXoU2mJ50OLGqY6ZZxapNG6BaBlA4Qv8Dj2YTA8/7eHSLMokfpXY5Qr09SFyLOXnG0TPsjQShATLfLFS37HeF4iH3y6WvNTNxfcFmJm2Pc0IZdBLVRZLH4ycO2upN5DgBpe8kPytlcKqIWfufBgnFo9cR7KFk9MNTx/1PYUZOehH3qjEmJvDHJiuH2pHkoQnS4t4sr9Efpa4BnMQtwdLMHpd+BvgXqRP7lHvrbnzCaolQ97pAQBsmOOFcRhnZfB8ifNqGccOngm7tBEuRIXbAxEh9QFQa9g83D/ClS8fTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mUHnQdyR03AZN+APIilikVjyd1DyGz6Q1/i1sGE14g=;
 b=UEy0+fTveUL/+qp3zmhxvEcj738oew729cnljIs9AZVEwguKLuYRKehydt6oEtXqrNnRW2ys3RkZR+5TW2RN7HmSCMxtEyHOLaJc8EGtAAm0za9xQG9GMB2osOzUE7DtA3z26lm7tj0Bn/bcPc/R0hEUVKuK2A5A5xRBGvRtUsULEw5zJaSUxPzkmImnUUjD/zyTesQ/ZJgxyCtEz3j7htzq0uw3KVhrLXexMSGmw2ajZnooMzcTqEDrozsw1TEvwg4sPvRd+SWpSmLEcZjDcp8D8zrI/iXBxQK3a8H/ST5TOgaJvY5dud9oqaV8ssmJjw1t92orI8OdfkZoj7KsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSAPR01MB4961.jpnprd01.prod.outlook.com (2603:1096:604:61::22)
 by OS3PR01MB7064.jpnprd01.prod.outlook.com (2603:1096:604:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 05:43:56 +0000
X-Received: from OSAPR01MB4961.jpnprd01.prod.outlook.com
 ([fe80::119e:937f:e06b:a927]) by OSAPR01MB4961.jpnprd01.prod.outlook.com
 ([fe80::119e:937f:e06b:a927%7]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 05:43:56 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <minmin@plathome.co.jp>, <jan.kiszka@siemens.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the backporting
Thread-Topic: [Inquiry for CVE-2021-23133] -- necessity of the backporting
Thread-Index: Adc6XySnLTu+cWedTlKOJgoSIwGVRw==
Date: Mon, 26 Apr 2021 14:49:12 +0900
Message-ID: 
 <OSAPR01MB496166751E93E55A64756505A0429@OSAPR01MB4961.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb391997-90a6-4f6f-b8d0-08d90876483b
x-ms-traffictypediagnostic: OS3PR01MB7064:
x-microsoft-antispam-prvs: 
 <OS3PR01MB7064A109065E16DE8E146E73A0429@OS3PR01MB7064.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 oroKKAfvG3VWMiSIwySEetX1dF+KHSQknp7MJb6ZFI9LxeumCpCQAk7hMccsTQDnInxHEBsiR+eFNRofpYAjEr8d9OZa5UsARsAHrOIpknd/epKeIPYcN0y9Z5niNNPpDNVc21lec6MNyNXNrPEfslytq2NGUbdo6qYANxQYP8Dcs5BwaWS4jrW4w5WQ3wbUKafkGQAlfeRWceNViIYBoD0DtIs1iKHUJklNThvOWXgoBGuX/zbIvqhocNXysRvel3d0w2YIFYgbUf5W+JznA2RhH4y+ghHQPsbLBSmL/rpBf4IuQM6ghYMLm76r63sba/lsI7CvfgUtajnxDkj7pv72NZ7qkmzIgzDD26sOtR3RADSQst6sHuhkUsmEODDnKr16dXAL5VRuflHpI7BvapYUEwLpzXFqo/OS9HkNNW+ag/tE0z6F9IFihhjMwN7faheHm3frAs08lIxV4fj6pOIgUpnfVux81clbz00evHM4RLESARLa/J/kmmQwEJiw+9aU0s+JzzMetN4uaoRc0mbxHyESRPFI/UMsqpKZ+bEn4MOoXysYxxYV5UYh5uPkao+PKLDGHiO5m+oBWtibKjdfgOQ5VAFOXv4RZzrqC2Ilgj5C4UrwqEBZfRWEyoRlCdt4bTMx1XPskRdgAvGcm9tRk+petdyh3xnUSXfoYwk1rXf7J3GSjyTz9YPiFUAUnBLcf6rbueFnfns1nraUEaDrjjS8E62Qtc/ynSWwjGpUGHtq0kvpOAYpVzPUZwnP
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?WFhUTVdMdU1tbW1vTEFRUWcrR0NjODAyRG1ZUDZMWUQwTUJqTHVLQmlH?=
 =?iso-2022-jp?B?cG15eGl5M3ZXb3FEQ2JLMVdHRFl1SFE1eDNsNzVmVmtobjFkOEVBVmZF?=
 =?iso-2022-jp?B?MU9YV3FWa000TVpkMG5OK0d6bXBQd3U4RFl4MGkxWjAweXBmLzljTXZI?=
 =?iso-2022-jp?B?WTI4ZTVycE52a2dTTFppZjc1RnQ1b3MwajU0SFREV2hkSHBWSnJ1RWJz?=
 =?iso-2022-jp?B?dy9EaVRiKzJxUVY1UnV2TXk0aWJRM3VGcGRYdVFzZ09WZ3JRSDNpZTFL?=
 =?iso-2022-jp?B?RkR3M2dYdTZTT1N5a2NoODNWcjhqUjR6dVdSS1RWS0NFYVVPeDVWeWsy?=
 =?iso-2022-jp?B?dUo5R29jdDViTEYxbnNDazVYUVRzY3VybnhlQjV5QTlLMy9QUUxDT3VF?=
 =?iso-2022-jp?B?eXJyclVyb0g3ei9zMUVtWDZSclNHUnhxa3VQQXI1NFFDTEZDcUh0Q2dj?=
 =?iso-2022-jp?B?aVBwNFNJL0ZOOXB3bi9IUm9HZi9XV082WlJKc2c5QU9BbXhRNGs4aW0w?=
 =?iso-2022-jp?B?MEV4a0g1NGZMOGtpVWd6aDc5THNrekMrbnR2cmtQdm5rN3M1QXFWcXBl?=
 =?iso-2022-jp?B?aGtNU1A5WVdpd21MOUh1elN0ZVlGYm5NcDZxQmYwbWQ2R2lLNzh1ZElM?=
 =?iso-2022-jp?B?aS9JNXM4bUlTU1RrSTJSYmpjRGZZaTZqZHBLOWxaMGpMemlhVkdvTk9O?=
 =?iso-2022-jp?B?Y2x3Z3FwZ2szTHVDYjhFczFNZ25tRGQ0bUs2TitZL1pEYVRaR25CWGdk?=
 =?iso-2022-jp?B?bU42Vk5UU05rbGxXOXpPSzY2KzhsZjd6MW5KbXB2ODRDL1BFZUtSNmhh?=
 =?iso-2022-jp?B?eXo2eWh0czlDUlZJTWU5VkZ6amtPUEtWaVVHWEZmbnZ0NUFJQWhIVnF6?=
 =?iso-2022-jp?B?cG83cFNta3IyVUhBck9NR2hqUmo4bE5CL0FnZ3MzNDRzZjZraFNQMExM?=
 =?iso-2022-jp?B?akwxclhmcEpwb3pNeUdaRitIaUFyRjMzc3R4c3gvS1F5bEwyNlo3TWVr?=
 =?iso-2022-jp?B?eS8zU1ZEaVRDRzRPaTlueDkvdXRhMlprL2YwOElMVGtFREpNMDFxTEtF?=
 =?iso-2022-jp?B?WDRYWU1CMzhXRURTMFhCc3c5ZDk0VGQ3emNlbU5qSVdoenFFR29iYits?=
 =?iso-2022-jp?B?ZGFZbTc3WVNaOHpKcHdmeW5CQmp0Rk1UM0xMSlVLSVlXWUtqRzE0VnYv?=
 =?iso-2022-jp?B?eklyUkFWZEFsek81ZlpUUEg1Z04ya25tbkEzekpBMGFSUkVpTkM5N0lR?=
 =?iso-2022-jp?B?andSZmsxSHlKdlVaNjNwYy91K1hZb00yaXY0WjNFRUlKUXlMaHQwTnB0?=
 =?iso-2022-jp?B?YzdqY3hxTTQvdjloM3laelpxM0hmSEM3R2dLWE5OUW9pSStMQ01uajNw?=
 =?iso-2022-jp?B?Qko4bVBjZnBVZmdmQkpUaUFaVENHUlBmYVhOZWJtbi9jcHBUcFpyYXR3?=
 =?iso-2022-jp?B?ZkxDZy84OVJiUHFQdTVBOVl2ODFIOEM1Q09DNzN2YUhVRXZWSzRvVWlO?=
 =?iso-2022-jp?B?OERBZktDOXFRWUFLSllsRDZuanUxb0RHSyt2YWcyaXJSWEJlOTRSYW1P?=
 =?iso-2022-jp?B?SG5sZzd3V3RpYWlxbDNhbnZJSzY0NE8vWWptYThNTEVCdFA0VkI4Mk1E?=
 =?iso-2022-jp?B?M0crZk03QkJyZ1AwTE1VWVVObkE2SnFpTmUrVmtFOGc0VE5xWFdtakgv?=
 =?iso-2022-jp?B?WVF1aUNxbXB1ZElTbC9MYS9MZjdqUzNVZC9pcVZBNHJVWFJNUEI2WDBw?=
 =?iso-2022-jp?B?cVhIdEl0ckVKbGRvYWU1c0dwV05pQzZ1MzNldlhldDgrK0hvMGxaaEFJ?=
 =?iso-2022-jp?B?bkNWNWlwdWNSd0svdTFQOHhPMG5hWkViejRtcXh0akZqRTRVcnJiNjFl?=
 =?iso-2022-jp?B?dTBVbk1vRldIOEZ1bXpSQlh0NGxLNUcvcjA5cVhHVkx6WTg5b0x4c0x2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4961.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb391997-90a6-4f6f-b8d0-08d90876483b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 05:43:55.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4iang6pKYs3lqE/uA4eCviOHPXc2ZB/4+0qHIv5RVfijkxnGlv3W2lgCIl/OMO11Ac+4FhuwoIjEgYSdsMZ7Kz1mfSfXkTyuGbLciHx4ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7064
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AZZVxocAIuGbSwITBB9jLRVix4520388AA=
Content-Type: multipart/mixed; boundary="9v6gzEK02V4giWli0Oqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619416160;
 bh=SfY7M82wHPN5xHWRLfU3OFYQHfo6PsQ0P+WXP79nlAI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QcjxxferYh44xLJu23wehpU/V6r+W4fikz7xPUrkgyPXJjELr/mh1y+HQd8ou0HK78p
 HHAvdE5D74xc/UHPWIaHxl/7bAV5Oorp+2A/J+dGypdCqB4KlbOCxoZ5E0g2ZtTyde1cF
 mno1Q5PfRwHsoBE1B1G3O+IVicCmd4Vspms=

--9v6gzEK02V4giWli0Oqh
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Jan-san, Minda-san,

https://lists.cip-project.org/g/cip-dev/message/6382
As was reported by Chen-Yu san last week, the following CVE security patch =
is not yet backported to kernels before 5.4.
	CVE-2021-23133 [net/sctp: race in sctp_destroy_sock]

At this moment, sctp is enabled on PlatHome boards and Siemens boards.
We wonder whether sctp is really used or not. If not used, we would recomme=
nd to disable sctp for those boards, and we won't work on backporting this =
patch..

We are looking forward to hearing back from you.

Best regards,
--
M. Kudo

--9v6gzEK02V4giWli0Oqh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6394): https://lists.cip-project.org/g/cip-dev/message=
/6394
Mute This Topic: https://lists.cip-project.org/mt/82371605/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9v6gzEK02V4giWli0Oqh--
