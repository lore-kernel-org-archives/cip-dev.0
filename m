Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE6CD98CE
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:10:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147228.1781586629178322862
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 22:10:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65G5ARxP2908959; Tue, 16 Jun 2026 14:10:27 +0900
X-Iguazu-Qid: 2yAbVIcaGeZFb9Ynbg
X-Iguazu-QSIG: v=2; s=0; t=1781586627; q=2yAbVIcaGeZFb9Ynbg; m=TbhhD4IwPoQNzLRBKnf3ddBQAabsMYtp9gFGf1AxwqU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfZnG5x9kz1xnk; Tue, 16 Jun 2026 14:10:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEbsVExV+wxAlkXotTWM02uPkfu1theMv8+MfjAMXfXqOMjKIPEkQIpTIvrzLjHrBs37A1mAqV1AtNbhEUF7X7e5jxSXPjej7BGkKIhE/eqA2iqcCOF7gxUNRWcjTFmAUYlABaeKeqbyrIgRyvM0dOGvJyuKo7tRxGYJ8sSiWe6ytCjePNKPDjEgyvdD3t18Eu4tleew18PleXwkycG4kTMNZJH5+XLAhXjEks1CxE1r2JiEeC+umf/gnGmK/H8v/Lq8PS52CS/bgqqzNKgursE2CalMoBiy+IV/QLt4RgGkjVscsdNXStwMk1gl83ZwmkvObxJQ1T9Ghlpe7ZOJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLMjkeC0pNGSyeURnskv7wdO/bEgpuzgrVj8zGsad90=;
 b=sb8eYcGNosazFkZZfhMgBPTDesAayAwxxYnWz3d7bqnoH7eeR2y1Ng29PzrvPqIkutMWyq0WeYmaShu1DovnQANUvut1JPnmML4ZFkrzqqPWE72fVf7A9GC2MqgeFAapThXcdazLxC0UlSPboBloMsOrNJeLmD4Lq4YL3K2Y6Ew0fCKaRlm7uHqgNte76b0Kc9wpyBAcVobpFZzqiJI5XVinaOeSw4fb2V4EEoC/j0doer4xBjVEtwIqbaGNfVU4eLldsO/s7lAfdcWv5vULeR6T3Eu6DWuVW5sXthCyC3lpwshQoVU0ijOSYRr9scwokVY9iQAjdm+2zXtxxylFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v1 0/2] Enable Debian sid support
Thread-Topic: [isar-cip-core][PATCH v1 0/2] Enable Debian sid support
Thread-Index: AQHc/U0ffhOMxIRdq0echzeRUbOOwbZAocqQ
Date: Tue, 16 Jun 2026 05:10:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107583ECBA8498BA011FC567C7E52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
In-Reply-To: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY4PR01MB14812:EE_
x-ms-office365-filtering-correlation-id: f1917cf2-4d17-4e62-4d51-08decb6591ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 mBxYt8ay1Vma/TJIcBqrsfVXK0XUkjvjmb6VsRSEo91UmPZZ67iq+fRUhkzzmAMByoYecRqHWYy+rQ9u8u1CyO8mzulMsngECA/v2tYDq8T6wnEn75kNfPSjL1I9wLbeXTDqHtc8RjX55py6pBQntZyX3c+vmOB0EyRChR0HxnwEPihBtnzCIdUaH2lGuRl/ca0nwFpUEmxWNrjHUpCzRDEbpFR9tdx+ddzh23rlmQr1VZyFk5qWs4jao3s8yW0I0xxJHPUMCNfyw9k2CojoT0dsc5yccONsd8RDdHRwreLiZoy/sa7rIgOu/yseLEIFK3ePhmEWRfpj6JrYsWZuxK19BtBHpuhDMBv4FQ3Ads3TXPz0x9sXLGHMeEEQgmvbqGyShBO1qQdTLYw26xHw4/8XoHV57g9Ecyydpb7EF1ZnL/y2ZB7OK+iFlmXNp9MY/yQAI71v3EHU6w1W0rg3iseQbe2GQfWKTl6zDVMnN9p6TgaIXwA1icjVTWhL4bvL/nJksgioi5KRlgOXUBkXg6P7FPMpEYToHdWd0PSrF0KO6oZPY0BFqDDJuSCvzy/sxRiaDKRXwInMMtRPL3jwlADJt21PiIYAkANuj3MhDL6tZCwWAFqQxQCoaEAPxRA8Xr0ZXwrLdrrkXH0tEMqxJUhhJD89mNHWjn5xbkMPyO/SHCccVrrjC7ZHil+BUUBVvPf9kAh5fbKDwT4opO0SWXeZKFuJV4XxgMNx9lv5xmNbzKksBKkDcFJJB5KNc7fS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cGxURjhtWUpUL25LS2JEREZCYlRab05DdUZuL21RSmRUTkFRNmhUOUY0?=
 =?iso-2022-jp?B?YzNBSWV2bFhqeklIL0FGNW5hRkxZUE1zd1R0UUtreCt1VFdxYjcydTk0?=
 =?iso-2022-jp?B?MFBaTWJpSVhyUFlHcmg2WE45L2FXVjRZMTdaRS9SN1NVYkExMmtjSEc1?=
 =?iso-2022-jp?B?S2F4c2V3c1pOUVFHdVAyTGNKQjlVelFEVzJ6M2gxZ3o5SE0wOGZrT3A1?=
 =?iso-2022-jp?B?YW9sWFpSODFSazVXQkRnL2pJeXRGZG93R3pUUkhNditSOHZMaDVyQUZI?=
 =?iso-2022-jp?B?N25ZeUZ1MXpRQytkNkFGUjMyNC83a3A2ZFA0NVdkU0gyTWEvbU1YOEo0?=
 =?iso-2022-jp?B?WHl1cWJkV1N1Q1daU2QxbHNoMWZiOXFIbTVwR2VFcjIwcHlkNDhFZWxO?=
 =?iso-2022-jp?B?cEtwTnVsMVM5dUxzaDAwU3NDdmI3SXViZndqbUVxM1owTWdFR1RXWUF5?=
 =?iso-2022-jp?B?YXV5MlRiTlVLQnZjREU4dWtvYkIrbEZCNStHdEZxeHhXWXNYdmZvazVJ?=
 =?iso-2022-jp?B?WU9UODFrYUhxRDhyWC9ka2NVUWQ2NTl4dVJpY3FQQW8vdmw5dmJRV0J4?=
 =?iso-2022-jp?B?OXJTb01hU0tOd2dMbVJUR3c0dnE5d0xiYituWWJ3NUR4dmo4UUlWTDZy?=
 =?iso-2022-jp?B?R0o4WUhoYXNYRmlWZ1dLdGF0SGtqMVNZVHl2VHNuajRicEhWVjBOYkt6?=
 =?iso-2022-jp?B?VWJLOG90ZGlPWC9HNlAyY3FMNTdUWDVUblZPUDRFeXlhbGV2NlFTb2Iz?=
 =?iso-2022-jp?B?NEs0Z21MRE5ZNkRMT2JJREhyTWZTbGF3NlJFWFJ5UmZNZkYyVzF2S00w?=
 =?iso-2022-jp?B?Yk8zUGNrS3hxMENMdGVLY0xhajR5eXVNV2ZsbTM5TG9FVEJ0QmZjbHRn?=
 =?iso-2022-jp?B?UXU0L3B0Mnpqd2VnTEppeitUUHJBZTQ2aFo4aVlTajFmeXFsUjZpQzFY?=
 =?iso-2022-jp?B?dGFLR3VHZmw1UW9WTTFpN2lva2ZneHB5RzBaalNCQ3hXd3VJYVdtZHBW?=
 =?iso-2022-jp?B?TUpReDFOWEpNTlpRRWQ5M3ZJQkdlMkN1ZUZXcmpnaGJPNms1b0dNOVlG?=
 =?iso-2022-jp?B?bDVQa01QRUJwVGY0ajB6bkNzcGZRcSt4RW9TcDY4Y1E3NjdmNm5HZHZF?=
 =?iso-2022-jp?B?bWE4TTlmQkg5Zkp4YXZNajRyU0prdkVwRFFKNzBYL0VsWmszS1NUQ2dq?=
 =?iso-2022-jp?B?OS9SaDFpMFBsRzBTNG92QXhRT282Y1dUTUtaM1VaRmRadFlndFRaaVlh?=
 =?iso-2022-jp?B?VVVRc0N2OWtTWFhyR0d0cmhyUGRSS0xtME9nUVhFUlIxV3hVWTZkME8r?=
 =?iso-2022-jp?B?OENqVUNtMWt1Y1J5NWpEYTc1ZkRWQ2UzVnZPMkx3bndkODlyNkxtcnhm?=
 =?iso-2022-jp?B?T0lwc1NxcWRXRmlGMXFPWTY2REhzVklEanBHd0dXSzhmQ2JxUi9YaFZ6?=
 =?iso-2022-jp?B?aEVjMGVRKzlkcWF6OGl1elJRbCs4eGR1d3RjODNqOFpHUjV0ZnhEZkl0?=
 =?iso-2022-jp?B?c3FOZ0M4cmR5VDdsb2hvZzkvR25WY2w5R0ZtRWcwbzFvaXd6M3QvbmZi?=
 =?iso-2022-jp?B?RlNaczNBV2FoTnZwUlNPakV2ZDZtQlpQTWlINlVoZHlMdFV5WGJDR1k2?=
 =?iso-2022-jp?B?dEN4Sk44Q3Q1Q0o3VFFSWmpDZElqeUd3UVVJVFZESnBJYTBJa2dpQ3o5?=
 =?iso-2022-jp?B?Qi9XblRMbHhnWVNaTVFqNjNnUmlOQVQ0QXJ0Q0t3dkRhK1JXVWFGcXRv?=
 =?iso-2022-jp?B?MGZQY0hkbDdJVU9MR1NlS2FRTGcrSG1WZWpQZm0rVzlLcnVwdmdvS093?=
 =?iso-2022-jp?B?VFFwekFzb2NRN2dHNGVwTmlHOE1VV2o3Y3NxVitJVUMva0IxdDhldHI0?=
 =?iso-2022-jp?B?R1RqbVRMaHgyeU5ldU9RelE5cWkwWGlLNFk2aTZYMG4zUHArSTN1c085?=
 =?iso-2022-jp?B?eFo4d3NLVndPdmpZL2hxam8rWHVRU3plZkw5Z2VIaU5sYUFwQUozMUZK?=
 =?iso-2022-jp?B?MlQ2VkVjNTRNdVBFNU9mcHJwQWIyZGpVYkc5Sk5DOGRzdll4RCs1SHRx?=
 =?iso-2022-jp?B?NWE0bE1QQ081MGZjLzhRMTVDV3hVbkpXWEUwSEY0Z2FyeDhxczQ0czd5?=
 =?iso-2022-jp?B?bmtaem9lUTV1MDFDZ1VaR3l3MFZXeWJ0NFh5OU5VV3lsZ0tnYTZLNnF6?=
 =?iso-2022-jp?B?NFhvOXh3TTFtU2FPNkpBaFNZSzFhSGtjRlI5ZUJWb2Z1L2t5Y0FDV1NY?=
 =?iso-2022-jp?B?alVQMnZHOGVZa0tTOENFR3RVYS81cmhCR0N3cG1JTEl2UjJ3M01KbHNO?=
 =?iso-2022-jp?B?OWFRZHEwekxBclVoYWtFS25SQ0FtZ3N3ZmNVNFpJMVRmVUFZNXJGU3FR?=
 =?iso-2022-jp?B?bDBYd0FMMWd5Z1d2UUtWTWZRMG1INVFPS09SK2dtTGxWOVFBekN6SkRr?=
 =?iso-2022-jp?B?VTNpTkxTZmxQSmo3TGszdGYybmI2enkxVDJKMmlVVnZzOHo4TkRGcGNI?=
 =?iso-2022-jp?B?bkd3MThOZlROcnVxNi9FVm54V1JiSk9HVEZ3ZXliZHN6QXRBVnhKWEF4?=
 =?iso-2022-jp?B?Y1daS0pacz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	EOs3ZCBJ/3iFDeBjTTObsF44W5EJRxQfg3AE5dRqYy+Dzqxd+EGwF0/gKrgWSz8pgUxXDUBTSlqRUs52k+RJO2JPPFZViFyQdLp42Upw1aWZcyKJt+a36GVMQIDNDwm+M/tKqrHIFHaUp2OHuC5ZIr002UdjwtVqzaEI6qpSHxT/wqwpHbOcp95FxT/CyP+h443uIyCZc0KtwApqViukGSnV+dgIZLtop8yb8IuLfldw3jB5YBL7oxQx/lmbcWDBh8FAeV4agXRBmyg9JYBiFxI82psiojc8oyZOQQKDyz2ppsF9VaUIOGldiqZ6u6Yx3cGI/EuNffi8raE02utHzQ==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1917cf2-4d17-4e62-4d51-08decb6591ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 05:10:22.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzXNMsjte0pE3G/L7YvqsXuOlicLK/ArS7Zlq6KQQov9K89SEQkqXhQQIivct7xRkGvN5VstNlyJvexgW/CGkrvWTuOmqt4eZjH4unYg7Rys6WEPdUNX8x8nxUKtyeRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14812
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 05:10:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23147

Hi Jan,=20

Apologies, please ignore this patch series.=20
There are some missing files in this series, will include and send them asa=
p.=20

Thanks & regards
Shivanand K

-----Original Message-----
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>=20
Sent: 16 June 2026 10:18
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#=
D#I#T=1B(B-=1B$B#O#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kaz=
uhiro.hayashi.f74@mail.toshiba>
Subject: [isar-cip-core][PATCH v1 0/2] Enable Debian sid support

This enables the support to build Sid based images in the repository, which=
 helps to detect the issues in advance.

I've confirmed the Sid image boot works for SWUpdate & Data encryption enab=
led images.

Shivanand Kunijadar (2):
  Enable Debian Sid support
  Add packages for Debian sid version

 Kconfig                                                       | 4 ++++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb         | 2 ++
 start-qemu.sh                                                 | 2 ++
 3 files changed, 8 insertions(+)

--
2.39.5



