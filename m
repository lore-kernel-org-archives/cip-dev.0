Return-Path: <SRS0=brkZ=FR=lists.cip-project.org=bounce+64572+5957+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18E5C4361B
	for <cip-dev@archiver.kernel.org>; Sun, 13 Dec 2020 23:42:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F70207C9
	for <cip-dev@archiver.kernel.org>; Sun, 13 Dec 2020 23:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F70207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5957+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vkiAYY4521723xUXTtwmTcG7; Sun, 13 Dec 2020 15:42:51 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.27274.1607902968871987109
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Dec 2020 15:42:50 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0BDNgQhb022858; Mon, 14 Dec 2020 08:42:26 +0900
X-Iguazu-Qid: 34tMP4XiKac6sgMWWH
X-Iguazu-QSIG: v=2; s=0; t=1607902946; q=34tMP4XiKac6sgMWWH; m=3wVqRusLwB4Y6lJ5SG+VZvLsYQXw5KyMNpkVN7vaTqQ=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 0BDNgOH8001960;
	Mon, 14 Dec 2020 08:42:24 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0BDNgOoW023633;
	Mon, 14 Dec 2020 08:42:24 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0BDNgNEH001594;
	Mon, 14 Dec 2020 08:42:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej4CX57igXbts0xHHKzNXh1v8M7SpdHEai4aad2Tp40uIixymdVOtLQwub+h4fjup3LGOSclX5gdwI4G7AnfYAL2PbzB1Cgt2H9npTxBMfN2YFhDu9BHWG7Adu8m2JnbPn4FnkvXzjFGvfV6BJYSN7GVxga5hHVdcepOZwMCrTREFBFG7tdAbHDTSrqPutbUEAW1T2AEqw9v8f08jjGIlx/pippeiYmdelG7xbjGczSDXSR0IojUTofOAUHytVhDaxGGIbzQLq69H9In23/+qaqxowsZUno8kgY+wbmCEXj8VQlY1RE57E49rqxq18OsoMCjynIahCGLo1pgs6SPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm5hDZ77MqZOw9KrA2+q0HWRXbn7LjUyuC58YvYZeOo=;
 b=bWCBWEgT3/5zxj9eUGg2H32CpDRZjmkdoYNF9n9Hk1nL1iIr5MkzywZfr6yIlqKlibYV3j0wzbxv6Ard731elnyn//55XOzK/N6raSnF5VV4CUml0UlumIaIvLnYgHkDTvOHbZ+CtxMVIDCc5AltZz0KtitieECpyfQqdeRuTAUYXfnZPjM+YxqCfqilXBUpKRKj+QHWfS0d5JUCGiJFgWRs/DxW39NvC6ytp2exQAQLyj4SaGwGoIeYTdveAMjmxprGiUesy6P0Mdi16yPR3DXVuNQPU3/mR5J0t8CSlPDyoHdEXNGIxdV8Cnr4AfJFzVQLYZszxuYqDylxRXKp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <Chris.Paterson2@renesas.com>, <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.163-cip40 and v4.4.248-cip52
Thread-Topic: [ANNOUNCE] Release v4.19.163-cip40 and v4.4.248-cip52
Thread-Index: AdbRqVjgmZ7u+cY8Tvy5lBsdNnlDmw==
Date: Sun, 13 Dec 2020 23:42:20 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298348B893AB8FC618C808B792C80@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a31a7134-5230-48b3-deeb-08d89fc0bbfc
x-ms-traffictypediagnostic: OS3PR01MB5943:
x-microsoft-antispam-prvs: <OS3PR01MB5943A327677B89FB7CC4E02E92C80@OS3PR01MB5943.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UacLqcTt4eE/Vx9dvQ1DbRXqlbf/V7DUKvWbmoXx+Ra5DM5VogFcPgzRglgfUfNVVF4VmuEDxB7K5D3v62gooRXt7LyqL8jTDmpct++9L/6KFPPp/pX8j8DTsTZjXX8gmY0+7cLyXhNeox6p/19jIW6sbdnUX81bUn2LSKbCBneEXtNBE1MvohxVUZ21CtA4mxDCeIhk2Pmbb3v79iC8arqQ7KkHeWq8KOig6mBMOfn7FvZIuRwRLrcJDFjXpzOa6OMgZvZ3ZeXYwO7Syi5caHXwDw9S+9OyerTonIBxA3PWPAhZnOoSZXwhbSx0N5Qe6iOQF2ekxSWyLzq7sGbOtHvDwGReaKkpC2UgWgob1G0fBcDRDFeAFBh0j/7wWD88f1D5iskRFBk3cOA0S7HK0A==
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDM4LzFpcGhHbUpWd2g0Y3hyVE5GdE5oWktKN2F0eDRBUnZ5Q0d5ekhQL0Y0?=
 =?utf-8?B?U3lNV29GblJxQUxRMTRWeFUydnJxR01VekxQQ2srajdoY3lsaVVRVXZCeVBU?=
 =?utf-8?B?NEZoSzJOWkVkd3lqZlhlTlljV3VKbGxLcVZqRmRWbWZaU2tFUDZQbmRaN3lV?=
 =?utf-8?B?bWdiV1pjQUE0NERWU0ROanNGeHpFR2NZQ2pURzJEMVpFZFcyeHUvQTZwTlo5?=
 =?utf-8?B?eXU1VlhuME5pM2dMVktPVk1VcHhudVptSE1zUHZnaXR2dnFvZUxONmdNbEh1?=
 =?utf-8?B?a2MzUU9zSUJHRkxqazlFcGJCbjE5NVJUT2kxTmFFYmMvOWFYN29yMWlJVm5u?=
 =?utf-8?B?cGVBV1hGNHlBQUJZTW1EYjYvclM1U0hmOGs1VWpRcE1PNWpVOFhBa1g4TElY?=
 =?utf-8?B?OFRDNDdWWVZydlhramN1NGpTa2xPSjRHYU5sYXRwUlJKdjBnaUFSWFBKMHc3?=
 =?utf-8?B?d1dwSzBPRkhGeHFJTWRpNnhVZThCYnhLS3pvODJqZEhLV0c0MlRtYys4VlVr?=
 =?utf-8?B?R3d6MExvMU1tM2hpTGZJMUdXbUNXcnhnMVdmNlRrcXJQU2JYRHg1K3pYK05n?=
 =?utf-8?B?c1VPUi9nUU5sUEtvZEVYNFpQQ1R6T0I0NnBObU81NG83eW00ZDJnZW5kR0Zn?=
 =?utf-8?B?aHNsbUl5NmhwNWprK2lvWVFwUFF4Q2tWcmlrZjZrbXlpM3lwYlZVdWlZdnJE?=
 =?utf-8?B?aDlaa0t1cmdYbWJydVU0QU9HVWFqK1VZNUI2WjBmR3d6d2pCdmRmWXdnUGpq?=
 =?utf-8?B?bnp5Tm9GNjlvbXZueFFtQ2FUcjU0RitFb3ZNMjVtRndDL0NqbWdnVlJQenZB?=
 =?utf-8?B?VnJiTi9ZbGdnb0pIRngwbFRWaUdjNmtxbWNWMm9HY1JVdVc4RGdFOWo1SGE0?=
 =?utf-8?B?dVBCcm1FYldxTGdRZmFBY0x5UjcvWFhmRUo0ak1nSm96VHp4QjJpSzFUM0N0?=
 =?utf-8?B?QWFDWVNzNGZ6bDZrYXFKcUl4YTN2TVh0dnB3aUhDcU1BNHZTZVBUekVhdHVE?=
 =?utf-8?B?VTBxUG5JNUpGTDNLM3pYc2Z3NklCbHlEMGFlTnNZZDRGSytwMyttOXJyd3hH?=
 =?utf-8?B?aS9vTWxCbkU3WUcxZUVSQkhmWlZ3WldBR3UzMkIrQ1UxTDA1dmZNY2Z6ZnBr?=
 =?utf-8?B?c3ExNnZJalgrSndVdlFPSXA0TU05NTVET2xONk5zMGZNRlcvcVovV2VyTnRq?=
 =?utf-8?B?NTVDUXhQVW1lRXlkQWhOd1E1U1RXUmlrNkpFY0kxTXJYeWlUTnk2OVMwNjhw?=
 =?utf-8?B?d2J4WUczVktuWEhRSnBsUlJ4a0ZCVm5rRExrODBPOGNmWm9xNTJKSk85RFk1?=
 =?utf-8?Q?8rK4xpgU70elU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a7134-5230-48b3-deeb-08d89fc0bbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 23:42:20.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW+1/KgG8nNUdz2XqzWL/3EiaBYabxpg8iWmVtdmna0v/q4HkryZjU2xwSvauxJ1GCN/JrdRBdk+vap4M5qvWmXJGfcyijV2Qh5kE5/+EMfnVSKwdBAtk6c2na7tU02e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5943
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6JXjvTv4GJfLElTVcCBwSKNlx4520388AA=
Content-Type: multipart/mixed; boundary="yI8IgmbeGgx3zJYC4ZX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607902971;
 bh=GJ3JpoNEUmQg8GHwkqm0JewWhKclxAaTtZOBa4qFcvU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=vjmEZQqFgohxcdiMytsKufr8eQ9grLnzyjOvRQjHC1HJPao5sQ4bffq27RqZ1CiVFhU
 jthfhBQ5cCDR2YOgnzr0nGdRWrSLSixuspaX5pPoKpeiJj5DAC33jdToeQtzCibGAbkMx
 GM/VY/Us/K1rLa8HAos7VwhHRTCy15qPNxs=

--yI8IgmbeGgx3zJYC4ZX4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE2
My1jaXA0MCBhbmQgdjQuNC4yNDgtY2lwNTIuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTYwDQp0byB2NC4xOS4xNjMs
IGFuZCBsaW51eC00LjQueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBm
cm9tIHY0LjQuMjQzDQp0byB2NC40LjI0OC4NCg0KRm9yIG90aGVyIG1ham9yIHVwZGF0ZXMsIHRo
ZSBNU0lPRjEgRE1BIGNoYW5uZWwgZm9yIHI4YTc3NGMwIGhhcyBiZWVuIGZpeGVkIGluDQpsaW51
eC00LjE5LnktY2lwIHRyZWUsIGFuZCBVU0IgYW5kIFBSUiAoUHJvZHVjdCBSZWdpc3RlcikgZm9y
IHI4YTc3NDIgaGFzIGJlZW4NCmFkZGVkIGluIGxpbnV4LTQuNC55LWNpcCB0cmVlLg0KDQpZb3Ug
Y2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xNjMt
Y2lwNDA6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAg
ICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNTMzZDc5YTY4OTZj
NTUwNDliZjNiMTFkZWExOWIzNDViZmI0MTc0Mw0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBD
SVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDQwIGFmdGVyIG1lcmdlIGZyb20gc3RhYmxl
DQogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRjMDogRml4IE1TSU9GMSBETUEgY2hh
bm5lbHMNCg0KICB2NC40LjI0OC1jaXA1MjoNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5n
aXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjQueS1jaXANCiAgICBjb21taXQgaGFzaDoN
CiAgICAgIDNmZWNjM2MyYTI4MTljMDBkNDM2Yzk4NTM0Yzc1MTc5M2NjYmMyZWUNCiAgICBhZGRl
ZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4IHRvIC1jaXA1MiBhZnRl
ciBtZXJnZSBmcm9tIHN0YWJsZQ0KICAgICAgQVJNOiBkdHM6IHI4YTc3NDcwOiBBZGQgZGV2aWNl
IG5vZGUgZm9yIFBSUg0KICAgICAgc29jOiByZW5lc2FzOiBJZGVudGlmeSBSWi9HMUMNCiAgICAg
IEFSTTogZHRzOiByOGE3NzQyOiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KICAgICAgc29jOiBy
ZW5lc2FzOiBJZGVudGlmeSBSWi9HMUgNCiAgICAgIEFSTTogZHRzOiByOGE3NzQ0OiBBZGQgZGV2
aWNlIG5vZGUgZm9yIFBSUg0KICAgICAgc29jOiByZW5lc2FzOiBJZGVudGlmeSBSWi9HMU4NCiAg
ICAgIEFSTTogZHRzOiByOGE3NzQ1OiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KICAgICAgQVJN
OiBkdHM6IHI4YTc3NDM6IEFkZCBkZXZpY2Ugbm9kZSBmb3IgUFJSDQogICAgICBzb2M6IHJlbmVz
YXM6IElkZW50aWZ5IFNvQyBhbmQgcmVnaXN0ZXIgd2l0aCB0aGUgU29DIGJ1cw0KICAgICAgZHQt
YmluZGluZ3M6IGFybTogcmVuZXNhczogQ29udmVydCAncmVuZXNhcyxwcnInIHRvIGpzb24tc2No
ZW1hDQogICAgICBiYXNlOiBzb2M6IEVhcmx5IHJlZ2lzdGVyIGJ1cyB3aGVuIG5lZWRlZA0KICAg
ICAgZHQtYmluZGluZ3M6IFBDSTogcmNhcjogQWRkIGRldmljZSB0cmVlIHN1cHBvcnQgZm9yIHI4
YTc3NDINCiAgICAgIEFSTTogZHRzOiByOGE3NzQyLWl3ZzIxZC1xNzogRW5hYmxlIEhTVVNCLCBV
U0IyLjAgYW5kIHhIQ0kNCiAgICAgIHBpbmN0cmw6IHNoLXBmYzogcjhhNzc5MDogQWRkIFVTQjEg
UFdFTiBwaW4gYW5kIGdyb3VwDQogICAgICBBUk06IGR0czogcjhhNzc0MjogQWRkIFhIQ0kgc3Vw
cG9ydA0KICAgICAgdXNiOiBob3N0OiB4aGNpLXBsYXQ6IEFkZCByOGE3NzQyIHN1cHBvcnQNCiAg
ICAgIGR0LWJpbmRpbmdzOiB1c2I6IHVzYi14aGNpOiBEb2N1bWVudCByOGE3NzQyIHN1cHBvcnQN
CiAgICAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQgVVNCLURNQUMgYW5kIEhTVVNCIGRldmljZSBu
b2Rlcw0KICAgICAgZHQtYmluZGluZ3M6IHVzYjogcmVuZXNhcyx1c2JoczogQWRkIHN1cHBvcnQg
Zm9yIHI4YTc3NDINCiAgICAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQgVVNCIDIuMCBob3N0IHN1
cHBvcnQNCiAgICAgIGR0LWJpbmRpbmdzOiBwaHk6IHJjYXItZ2VuMjogQWRkIHI4YTc3NDIgc3Vw
cG9ydA0KDQpCZXN0IHJlZ2FyZHMsDQogICBOb2J1aGlybw0K

--yI8IgmbeGgx3zJYC4ZX4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5957): https://lists.cip-project.org/g/cip-dev/message=
/5957
Mute This Topic: https://lists.cip-project.org/mt/78939512/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yI8IgmbeGgx3zJYC4ZX4--
