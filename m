Return-Path: <SRS0=kFL8=HR=lists.cip-project.org=bounce+64572+6176+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C9C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 02:50:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEF864D8F
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 02:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEF864D8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6176+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id l2hQYY4521723xeblxc7Ddjn; Sun, 14 Feb 2021 18:50:06 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.26221.1613357404599969729
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Feb 2021 18:50:05 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11F2ncxj027474; Mon, 15 Feb 2021 11:49:38 +0900
X-Iguazu-Qid: 2wGra9XxFDUr9N5cbG
X-Iguazu-QSIG: v=2; s=0; t=1613357378; q=2wGra9XxFDUr9N5cbG; m=CyqN92/eeuxcbKTxw0IPnrdRBCskTuwKzKHQINjlSQE=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 11F2nZEv027753;
	Mon, 15 Feb 2021 11:49:36 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 11F2nZav029560;
	Mon, 15 Feb 2021 11:49:35 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 11F2nZPr017461;
	Mon, 15 Feb 2021 11:49:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqPiScgoQlFKb7c8OWqTS35wa1dlM3twTovLyvnvBIlVNaVR9vR7g9SHhkiCxAJmSRdGH57HJ/w1UY/9/4r4cVL382thhBMt3H5UkBHRIxV+F9q2ggU79rXkBGaR/q3Cpor55/T0BjzHWWYzAAtYmVDlFg4IBze1BvliaU1USKOrZcSnJEJQIq9ih0vjtcs23M7i/cM5nsSFWY4MoDFBax9/bGXy8kcSPxk6RAXmGXrOFg4rGb4FzoussucZwB/n1glR9DlutNZXg0tPnLS871cnCPTX8iQfCSV700jJia/6oeKXPju3z7Bcq1fHnqLuhonQ6A9D8HGD0lzBS8qrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwy7Xl2GaMREfZrHK+Zm9hqhZxuBeQhtu9BWSh3waFE=;
 b=ERk1Zd2cyiNHPdjMczQMhMKJMvoVafi1fg1EoqJMpBxdlBw53biJQ2NUOdAps30NSj/6jvkwDCeSrYquJ+KCi8SjxcUqsb2MKKl/XrvNdcwwwqBnZ+9X4CIVAtyx6F4xW2K2Pg5d47HULvBJm+alG3Sg45lWVyORCwSXZXJuf8EdcA+eT0VdmTRMy1bl7TudLqCQxw3S0Xg3SZH2ECzUE5+N17qCu7jZCjCQQAsHT+kZ0vHCDc0fNB9AByZLx8hDbEUOg/+ujYQFYHBtBxfOVzqqB5ubklYVHojxL6N3RBkHUW5RcLnk6DCITM4Ap8OZV8Rs220zNhonxksxXjMwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <pavel@denx.de>, <wens@csie.org>,
        <Chris.Paterson2@renesas.com>, <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.175-cip43 and v4.4.257-cip54
Thread-Topic: [ANNOUNCE] Release v4.19.175-cip43 and v4.4.257-cip54
Thread-Index: AdcDRQNkSIdZb2xkTPitfo2LOucnXw==
Date: Mon, 15 Feb 2021 02:49:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29830CC7E194CD1CD582096092889@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1767f667-1f30-4e72-c570-08d8d15c5304
x-ms-traffictypediagnostic: OS0PR01MB5666:
x-microsoft-antispam-prvs: <OS0PR01MB5666B5338E88BB0A7F1EFA5E92889@OS0PR01MB5666.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqSCva9/dCvJqorMolbT/2A4I20meLmrCDqSVT7cF8YA6acnJIXgUtM562smsEjlFucZy3BAka0ymS4EHaZiq4xoejffxwmh2P2ITvdwpG2P1J1XWmmDOqUXLT/Dd3HpQ6eK4IE72/wunmuCfcXBrK9qBQnc3srkzd0e2+AP8eT/2yAnRvaigW7rRYjjLg9jevHh0deJsKfhs5CsYDE7qd2uWOO+vwuBPTrqE3hoBfnJB2b8wNRtXRBu3yaeiiaijUiTLsgfJJEPS7emw1Tc/8m5MMQbHwqe/LlbtGNpAxT+o6goN277ycFARMKDXYBZRPEUeVX6oUCbSNopjVjWUSzGKuLuzUb3G5EB2La/CHZQykQaHkeMpFQ8vuUUUrh6A98lkor5905gK68d50wwHOPLdCdATHoHHTjTwla4gr/0seXNub6tb38rKVtL7TAYfkaCFlaSjMdMGxOpVgmf6KAHtC0dFiv6KpnR3lyZW/gxmwYI46ZrFeVDWVBCsK8H08b9uLyQpjyMuaehyAFSqSAFBIugvTEKMK5LPehBs0nPG7PhNdoQzvcuIJ8algM5JbT0YTgFx6+atu5d7XETpbplsDp57GDMQl9lfzIb8Rw=
x-ms-exchange-antispam-messagedata: =?utf-8?B?dXFNbllwdlk1VVdoaEVFdnNtKzFtWnBldzZYSmdaKzREczJzQ1JpVGtHbWpj?=
 =?utf-8?B?WEYzcGpWdW51elJORnljK1JvL2xHVXhsa0ppRmhGZXMwR0l4SEUxTFRFWW9v?=
 =?utf-8?B?d2xkOXV2NkZncnpEY1NSM1JoMXdYR2hhcFFFWVRoT01iSlJoUHhsVUQ5Y05o?=
 =?utf-8?B?VDlocFhBbmF1bmxjaWROV2NTNEMvQmFoV1NvTFFsbE5wSGNoNlI3clZIRW1B?=
 =?utf-8?B?bnlpY2h2MEFVTHN1WGMrTWgvVGlIT1ZIa2pWZDRmZURLdHFxbmF3aHF0UWRs?=
 =?utf-8?B?TGVZWWNPVWJ5Q0hlTmk0aU9DbWlRS05YQmZ1Vm82dVA1cVNTQzYrUTZUMnpJ?=
 =?utf-8?B?Z2dMTXBWTkVCc093bVVORjBMbjU0ekZsVnBXRXg0b3dGdm1CQ1U2RjNPZXVJ?=
 =?utf-8?B?UFZRY0ZidDhVbjBSQ2xPM29xU2NWVmw0Ny9SV3J1N1VmNm5wSzkreUtBQnNF?=
 =?utf-8?B?N3FQU0Y4TjZMMGpidThWWUUyeDQvMXVxOGU3M1h2c0N6UWNQM253dVNLQkxa?=
 =?utf-8?B?YXdta1lHK3cwSjMweW4rWXh1YUNPdTlmbnpxNkNBdUZGUlZXcXlGV1ZNUTlG?=
 =?utf-8?B?UWNoaUxJaXBXVFQvbEZ1UTcxbGNBYmxPSDU4Y1JZejR4R2RYaFpUcVg1YUl1?=
 =?utf-8?B?YTkwQVZEb1h5TkN5eHNFUGROaEQ0cFVhK3pWVDBTQVlDRnM5a243U1lxR0s2?=
 =?utf-8?B?T1kxL0pIMlVlaDhicERwaGd2RlE3R3pORHo2OFRTUXcyT2Q3T0EvUXRKZERI?=
 =?utf-8?B?dENvLzNFeUtrY0RyRUN4THRzWTZxNE1JY1VLOWNzdS92dC9VYzZoN3ZnWGph?=
 =?utf-8?B?TXlRL2xZU1o3ZzVVMVlMRlg2bjhFUGlWd24yc3ljeGx6Z0FpT2dsZkJzVW5D?=
 =?utf-8?B?MCtDTCtiV1llRWtmZVltWTVyVkNGVm5JN1cxcXhZcEg1eFREbEI2Vm01VWpL?=
 =?utf-8?B?Tk9OaEZaVW96S0VOc0d2RnMxV09pUXVES0cyNis4bDgyb0FzeGpoN3EyZ0Ft?=
 =?utf-8?B?MFIzdG5lbW5TODNHcTlpamFBUGxqT1hMcnVTSzlMV1pSWVpxMGpmWll5eW9x?=
 =?utf-8?B?aGhyTFI0K1FYQVQzVEFJTTBJa242VTBwcEo0OE9yQ3RwRnNEMzBHYXJiU2Z3?=
 =?utf-8?B?MW1Yb1VidHZYNUtYRUtoa21pTWpUMzhRWHRQVXNYejlUSG95aW1PNGN6RzNG?=
 =?utf-8?B?elBpVzE2MVBibTYwNjR2ZU5OYXVrZnBKcHpmU0pRSTR3aExqU1lhcEhPa3B0?=
 =?utf-8?B?OEJJSWFqQVJvazRsQW5aU0E3aDBaNUx4Mi9XNjQ2OTEvSm5YS3FhNUVVQmJZ?=
 =?utf-8?B?Rml5K3BSUTVockx6TXhvNTZNZEMrZW9USjFVQ2tiWHh5cDZnaExZQzlUdFlS?=
 =?utf-8?B?UXdVcWdYeDBCK3N3K1NRTHBSWWpnSkI3dUpGUkhkQU8vdXhmRzhnc0k2SUhp?=
 =?utf-8?B?Y0ZsV29YSkFpclAvODkxZERwbk91aUpvMEo4a2p4ZVFVTnJiWThKclJWaUVF?=
 =?utf-8?B?OHVUbW5OQ1cxQXNxRE8wWGp0YW0yT0FuSHJoNnR5eFVZMXlya3hWVjhqOXNW?=
 =?utf-8?B?eUsyR2p2UGFiVlM2TXhtRnUrRERueFR0RUJmVkJJRGVXbXlhSmU4UzVpSGFs?=
 =?utf-8?B?eFNwSzZNNnVtWGdMNHVoVTV5Mkgvb0VZY2huT3ljWDgwMzhtUEtzUk55Nkdh?=
 =?utf-8?B?MVM0NWgwakRiOEZNRE1ZcXlkZmdCUGU2dC8zTlZza0VQSVh3Tld2U1NGRUxu?=
 =?utf-8?Q?6EgZTOQfandKcztJO4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1767f667-1f30-4e72-c570-08d8d15c5304
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 02:49:33.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brxwQH8Afe9dURbRi1YJNt+W26kTYA/kxf3Hhj/magzAgxHDgbd+PAyyTHTba3iwzoXNWigmhAjSFYACPPR/okAPOAT3Cyd5yjoZ+D6cbRmhsSxl2As10KBuh7yOQwsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5666
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fi86Efg5G1oLh2iq6mHHRrRCx4520388AA=
Content-Type: multipart/mixed; boundary="Z6Dyvby5PayMBSVMzW6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613357406;
 bh=FKq39fa9O/23oQW4jJCcTiUaDxAi7hhFhQiddhi+UHw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wsiCWGL1MaitQB9lVdny2hBjE8HveUkUgyTY9abLzshBmjLa4ajw43z+6pRQAKqC1co
 P9pvvsAd0p8uI0yjhRQDHHC4Oihaugv+NNt7POBtC3xI1SAGjOz2ESARz4P/U0PKxKywB
 vEk9zIhzMSJzw/jK7IClx7yKE4mTEk/SzPM=

--Z6Dyvby5PayMBSVMzW6J
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE3
NS1jaXA0MyBhbmQgdjQuNC4yNTctY2lwNTQuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTY5IHRvIHY0LjE5LjE3NSwN
CmFuZCB0aGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbSB2NC40LjI0OSB0byB2NC40LjI1Ny4NCkFsc28gaW4gdGhpcyByZWxlYXNlLCBzdXBw
b3J0IGZvciByOGE3NzQyIERVLCBQV00gYW5kIFRQVSBoYXMgYmVlbiBhZGRlZCB0byB0aGUNCmxp
bnV4LTQuNC55LWNpcCB0cmVlLg0KDQpZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBn
aXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xNzUtY2lwNDM6DQogICAgcmVwb3NpdG9yeToNCiAgICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51
eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1p
dCBoYXNoOg0KICAgICAgOWIzMWYzNzJlZDAxMWIxOTA2MDZlZDY4MjNhNDM2MTYzMDQ0MDYxMw0K
ICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNp
cDQzIGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCiAgdjQuNC4yNTctY2lwNTQ6DQogICAgcmVw
b3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC40Lnkt
Y2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA3ZDQ3MmU0YTExZDZhMmZiMWM0OTJiMDJjN2Q3
ZGFjZDMyOTdiYmY0DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9u
IHN1ZmZpeCB0byAtY2lwNTQgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCiAgICAgIEFSTTogZHRz
OiByOGE3NzQyLWl3ZzIxZC1xNzogQWRkIExDRCBzdXBwb3J0DQogICAgICBBUk06IGR0czogcjhh
Nzc0MjogQWRkIFBXTSBTb0Mgc3VwcG9ydA0KICAgICAgZHQtYmluZGluZ3M6IHB3bTogcmVuZXNh
cyxwd20tcmNhcjogQWRkIHI4YTc3NDIgc3VwcG9ydA0KICAgICAgQVJNOiBkdHM6IHI4YTc3NDI6
IEFkZCBUUFUgc3VwcG9ydA0KICAgICAgZHQtYmluZGluZ3M6IHB3bTogcmVuZXNhcyx0cHUtcHdt
OiBEb2N1bWVudCByOGE3NzQyIHN1cHBvcnQNCiAgICAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQg
RFUgc3VwcG9ydA0KICAgICAgZHJtOiByY2FyLWR1OiBBZGQgcjhhNzc0MiBzdXBwb3J0DQogICAg
ICBkaXNwbGF5OiByZW5lc2FzLGR1OiBEb2N1bWVudCB0aGUgcjhhNzc0MiBiaW5kaW5ncw0KICAg
ICAgcGluY3RybDogcmVuZXNhczogcjhhNzc5MDogT3B0aW1pemUgcGluY3RybCBpbWFnZSBzaXpl
IGZvciBSOEE3NzQyDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=

--Z6Dyvby5PayMBSVMzW6J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6176): https://lists.cip-project.org/g/cip-dev/message=
/6176
Mute This Topic: https://lists.cip-project.org/mt/80646229/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Z6Dyvby5PayMBSVMzW6J--
