Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE1CC6B00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 07:13:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10361.1775114003532887287
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Apr 2026 00:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=NHv7cm8c;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1775114001;x=1776323601;bh=
	4cfvftcOsv2XxRGCWV5RYNr1qUGJ/HpnKX1ywpd0Fi4=;b=NHv7cm8cui617o4wnzBV6HcJ+rq/gP
	XZiMVrV64zzLaLY3PpwrjrettNYXG5UaKHK3Rnj+Riw/3IfeLYFHbDYElaWtkADW3j5XkXJkNu7R2
	BP2LQw1XGQx6Y01MUfO7V5smWelUXKF4LH92wMAEyn2UQX7fREA9Q+TxvnSq/6WimGZfec+rXrlsN
	1AHpJsQJ3gFfWX+1pqaMCIuu/nBLypnNhERU0ctgXM20HrsXZaYIxSOrEWVNHf9dCsl8L8YLXefWD
	9m8yQVrJnRgQxz8vx+Iu8fi3qINOOzpyQFHnmhcDMHm5AX71JuoLeO7wOy41aOyK4+rsuWbfTyBOk
	VIMg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6327DK0v2612323; Thu, 2 Apr 2026 16:13:21 +0900
X-Iguazu-Qid: 2rWhMF1Go4XioShry5
X-Iguazu-QSIG: v=2; s=0; t=1775114000; q=2rWhMF1Go4XioShry5; m=F10ZV9ellYNbC3xHOR7IRQ+KdaR6M3keOJcibpQow2s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fmY3h3pvyz1xnm; Thu,  2 Apr 2026 16:13:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjaLRCHmCl+XXVnT9UPGghdTaiJ4DIk2s3yR1IsHHOcM1slGbiI2fmuvAQEyoa3rFxWvNiMKP7T17qM9ThZlrdfDdjYClPpaaOVsBhnEBeyO+cZq/kdvmcKImkBxaxxUyFHWTVTgbhg+7mQPoIRYTLUvH/OSKZw58af/LnKyyHof265l2CI+I68+C3nWO7otkwYNIz4/o6o8QCe3knGrlX0wkmfKTnWwsCY1rSiZ2G0HNKMBZ2OJGEJacPOskcp/ML41tvhm3xWDdbQozhWu6MtyxiIIT7tbNmiEEAZXI6JlUKQHQK/w8LrhoXeZdJDPu+IkyKuYW1/cGhDXjf/bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+met1B+RwbvIsd5h1peNxCDhy0Z9HUPsMASDHeKZSI=;
 b=RO3sCmN4EGNMqffY6qZiZSQLCAJpirNph4u+6/SELHUCoCC7JPtA4Vvt/Lp04XiNQQIS6N2ZisXtjMlGMVakoAbYsQaAsjKyMd1iIxQj5euJqBU47ONfJkokAGWy+yNI5zeLtB13BSaYMatF1FqznJXPwq4CmKiximq1I32ODSPaJb8CZ0DNouA1RM69SdKwETNXs+NBF84PD/chkDNyzhAS5JWUlgk4M7QNIUnFhzWxxUz/1CeYLGM0SdA6Lj1u7b4h9XtFfSgurUbQK4j6VDobHMTM6DTK/0SKBH6rAdNpTyQsjJt/kSymX4CqJPFoFt+yiTST8f25Arq2vIhk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat (2026/04/02)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2026/04/02)
Thread-Index: AdzCbxnxCK4sqE1fTWOQxCcjbPI7jA==
Date: Thu, 2 Apr 2026 07:13:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E05AFE90B15BDE820A7FCD51A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB6740:EE_
x-ms-office365-filtering-correlation-id: abd72f82-6fa4-4f7a-5dfb-08de90875007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 spXOPpxm/d6n9UZXwWoJCcAkBW+Qk4QP71UeMn7tN0EoiwumIgddTFVX2f+UV4LnHjVSl/+M9H6Pp9oxRAGwYrUFY615ZNw4yK2SSxbWaMXBQ6WUCGbFo32B5Src5u+N+IjXeL6Zc1Wo8UU7hA24kWC3SvdF3WbLo3jOcIOmY/BtUJZ1Dag5qHFc9uqLNgwM/MXAatuKc9zgR04Uc7APSqYiPlMAsVucwJRxRfIBJb2Bxd5Z9aqTF2caH05QUD0Ozq/G6kDaGZTtu+ZIaZEXNomc8HwlPT9Zpi/3AA4eYCE/aihVTnBSuE1YHqtqgYQ8vfgJYUCd2gwCC4IUsgIlBAyxYfZ0vNrP5smBa/aNmwIjZ65LdwyRD4pLzD+9cwrPm5TuCmxEynobvcjvLYcl4TRQZU8mK2YIx/T9MYvFWexJllBBAU/k5uGC+aETKoxSkpv1+2hb5BU/+KUlNl+8ACALVexcLddwMRfI07R38txpvLU/ZNPwAfoobD2naM6hgiwUq5WudIXY3XNtqIS9quWMt+mjEGL+gVx8j5D+YxPj4FJ8TbjNQxJcltgAo3eJFpQEvNAEt9Jm6l5JEDkMyKxnP1bKdKl53PE7rrwQFyGXhPWtvzLUVdsdxOKcJgJnZyzEr1LXs9GQjEbLI+TpmB7apXYOjFsflOzWUYpYSjh2Leyq/e+WKb6QJT2qfC6wLroNjDm9nYnKMpYnV7emwaSMzVux3lt579Ymqv5l/M0hRs01M15y5TSAg86SWZSj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YmtoQU5lT2xKM3AxWk5EYlAwV29jUXRoUXY4UEthdmhIK3hka1VSZCtM?=
 =?iso-2022-jp?B?TlZ4bU0yeXpuZ050WE9DOGh1K1kralYxbUVyT21mNktaYWR1VVlnbXFx?=
 =?iso-2022-jp?B?Qmx4bzh4VDdtYmtCSEkxMlFyRjJmcnByZFZwV0VuaG5salg0ZXBYM0Fn?=
 =?iso-2022-jp?B?SUpMcnFmcTl3d2xObUhmemhadld0K2lzMzJOMTVWL2xVUVg4UWYwc1pE?=
 =?iso-2022-jp?B?T05VTW43YjJTMm5jc2tRVndpMy9Gb1lScWhkdnkxSyt0L2k0LzFnUzJx?=
 =?iso-2022-jp?B?aVprSlBEY214eXBvTExZSjRodkNidm14TjBXUzk0anFjMEZMcllvaHc5?=
 =?iso-2022-jp?B?cFdoSlh6RlZvTmVoVUFtVERXeDl6SitPV3NEMEpCL3IvcDI0SHQvRlFD?=
 =?iso-2022-jp?B?eG8zRy9wZlR0ZVo2T1ZMdTJ1MWJFWWxxTmlZeUdWeHpTaU1UR1gvOWlv?=
 =?iso-2022-jp?B?eHQ1TkN3bVRqczB4Zm0xUGV5aFd0bzhKZ1hhZXRseHBCOFdOeXRFK1lu?=
 =?iso-2022-jp?B?UkZabWpxWkE3NmgydEErTTBibllTYXo1R3JKamE3R1NTZmQzQWlRaEVV?=
 =?iso-2022-jp?B?Qm9xUDNIR3Zob3NEZlpJa0hsc2lGb05OeFhLYWdLVDVKajZRclpxaHE1?=
 =?iso-2022-jp?B?d01mcXorQ2JGYXlyOThSb1RxQ2hSMVRSKzFPS0VneEs4TUFqOEttL0Fl?=
 =?iso-2022-jp?B?Wnl6cG0wWnNidVVDdUMyd014TUlUUjdCY2ZHZjVLN3dnTG1tbSszNGVP?=
 =?iso-2022-jp?B?ZlM1cGdwNzJ5OU1aZnUyNUZNK0xEeG1kaGw4YkVoeGdSUU5oOUdDbkZk?=
 =?iso-2022-jp?B?NWRXeFU0NnpaZ2l1N0p5NVVIbWxHdVpINlF4dm5ERzBNWDlsdUVtaENo?=
 =?iso-2022-jp?B?TzdpZ0NreWhHWFIvQlRHd0pYaFAweDlVT2RKK3BhbEFMUUdldmpDSWI5?=
 =?iso-2022-jp?B?K00xNS94NjhjSXZqZXlldVlyUm1iWVRCZzYyTWwyNU1GSHMzV0xXazFh?=
 =?iso-2022-jp?B?cTlrSlE5SVVidUpvem5DSkQzK0ZaYzhYaEUxYURRSDh6YjNiQjltQmlS?=
 =?iso-2022-jp?B?L29FeVR2Y1EvQ3JZY2xBODEzN24rbkdNc2gvbi9sRGlneXZiUUlmRFE1?=
 =?iso-2022-jp?B?UjVINVpjajdrTEJweEM2VUdvNHRjamtUblQ1R0M0NjBuTldFYWpyVXBh?=
 =?iso-2022-jp?B?c3hDa2w1c3J5RTB3Qi9wb1R3TnZ0L1BxL0svNzR6ZkpLcDR1NElpMCtV?=
 =?iso-2022-jp?B?aVVFVzZuMlN3NHE3WUZoOHQrWmI4M2dtbVJJMDR3UTkvdlh0cWo3ZklD?=
 =?iso-2022-jp?B?Yjk2d2JUQU1vZkFvM3JpV0hyM21ZaVBaaGVBYnNtUUhIWVdSZzlsSWt0?=
 =?iso-2022-jp?B?ZHhpTThiV0NmSkRHMlMvSkMxcStXM0ZoczQzVW5mdkNmcEs3T3dianRJ?=
 =?iso-2022-jp?B?SDNiREtndE5SL3ZsbEUvL0gwejVaZ3RCUFdLZW1EcWpLajF4Y1BqYWxQ?=
 =?iso-2022-jp?B?MVdKaDlGc25kNmtDZkJ4YWRvemREbkNZSm5Zd05JN1J1S3FnY1hCaHh5?=
 =?iso-2022-jp?B?L0FmdDBuYlFWdU9XRGZjOFNxTUFHdGtrSTV4TG9Rc2c4aDZXbDdwRGxN?=
 =?iso-2022-jp?B?ZWpXUFRRZFhHR1RzYkd2Sy9NRjJYaGd2N1A1NTVvRy9DWnJpazBlb2d3?=
 =?iso-2022-jp?B?YzBnMW1URFhQQ3lyNlZBT2ozR3BnMlZSdklUcU1JK1M2K01qdmRlNml0?=
 =?iso-2022-jp?B?bXliUTJZVURPdDR2dkdvNUphT3Q1QmhLcTd5SmZHd3ZPc1dhcmoyTGQw?=
 =?iso-2022-jp?B?VDVIZmVtM0daZDdxUFRLdlRUYUdzclFtUHZ6ZHY3Y0hvYnNyYWRWdmlT?=
 =?iso-2022-jp?B?ZFBOKzA4ZEt6ZllkMDVBZjlGNU1oS3ZSRitPYzlFeWxoSjh6K0l4MEFW?=
 =?iso-2022-jp?B?T2hYbk04VDVJYmlNSVBaUDdhRGdtcGtXcU0xK2JaOWpmZTVFVkRURXV1?=
 =?iso-2022-jp?B?clpqNHVyYW1RbEc3T0VKMnNCeFVqOGdXbWRVV2F4NWxEbnVBYVljSlg4?=
 =?iso-2022-jp?B?SWE4MWJNSlNKOHVLRDlZdmdGU1VzTkNlWTRueVduVysyb2c4Y2piVnpu?=
 =?iso-2022-jp?B?Z2wvNTN0TmJHdXV1SmJ4SFp0UGxwRmJ4N05uYTZGT3pBUFJUaFM0MG5W?=
 =?iso-2022-jp?B?NEtvd21nM3B0TzMraGZydG1McTl3UTcxZ21yTnBSYURJMW1kYlFEVVNp?=
 =?iso-2022-jp?B?eEVFSnV0YTduRXh4TDNwclVLaVNhVW9PT0ZUVkM2NW5WYWZDZ0JZczBD?=
 =?iso-2022-jp?B?dVZjd2F3VzVSMUI2MnRRR1VvVjdBZ0ZMMk91Tk8vWHVVeFFCbGVHUU5D?=
 =?iso-2022-jp?B?OU0zREpYM2hiaXJvd25KbHp5R3FsK0xkeC9MRlVnWGVLd0g3OTN4WUFj?=
 =?iso-2022-jp?B?TTIyUWQrOWZEWnUwdDZ2cHZWUmppeDIzM2M0aFNLSTcwZkRYaXpGZzVk?=
 =?iso-2022-jp?B?NWFmVGYvUHBhakNIZWxyNFJxbVJnMW55L2FIYlRJSm5CWVJicVQ3TWVP?=
 =?iso-2022-jp?B?dE5Wa0oydz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	v8uNbEl5lOQrqtwCYtqNCRNLzxGyE6iF9ae83HQ3N6yurv4y95jm2KbsHvWsg2fQSmC1SwmxZQvAOT2N9nwJbUptd7avcm9JgHTf+caBEat9jW0Hfd7SpoINpUjdf86CriyR1ktY2VAx/BA4WgJUHbre86+kbm8Se/jGXtj8MI1G6txo3fXAhypWpTtjfSc3XJYpT0TPi4gFpgCEXRBpUxq+ycuz/Lt5XG18u3F6zdQzYSrHN4Sr0HFTJgrcI+zcvN2UsETHeeG7Iv4X7WhTFfFw+ZPPM/WjuL0RXeGOo8LZTeZ/SQlPetMFJ3F7iMJ+T5rv6ioT3jAU3Tn6kkSppQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd72f82-6fa4-4f7a-5dfb-08de90875007
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:13:16.9785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdHRhfQFE7lHtv4XDPWBRNEgyOnp3PlGpYSidJ9X2gjmyY+DntPUqChv0kJt3cAeXqqEIC4DMXKaQ/NMK05Dq2unjpQfidnpQphRX9ZPVgKnZsLoZdndl80fXVG928Gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6740
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 07:13:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22615

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mont=
h=3D4&day=3D2&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/03/cip.2026-03-26-1=
2.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

[*]
Date the data is created: Thu Apr  2 07:05:49 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip109
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip109-rt60
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip130
  latest version release date: Wed Mar 11 03:05:13 AM UTC 2026
  limit date: Fri Apr 10 03:05:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip128-rt46
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.251-cip70
  latest version release date: Fri Mar 13 12:18:31 AM UTC 2026
  limit date: Sun Apr 12 12:18:31 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.251-cip70-rt31
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.167-cip53
  latest version release date: Sun Mar 29 11:55:46 PM UTC 2026
  limit date: Tue Apr 28 11:55:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.164-cip52-rt28
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.78-cip19
  latest version release date: Thu Mar 26 06:07:13 AM UTC 2026
  limit date: Fri Apr 10 06:07:13 AM UTC 2026
  Status: On track


