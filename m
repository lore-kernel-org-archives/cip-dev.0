Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9FCD343F
	for <webhook@archiver.kernel.org>; Sat, 16 May 2026 01:38:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48748.1778895502624663556
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 May 2026 18:38:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=FNmlX32d;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1778895487;x=1780105087;bh=
	OUo2gj+LfboJiTXvDvGdtHYuWv7q40rQU16itJ97UOI=;b=FNmlX32dcvR+50Pci+3dUEE7tAEvPy
	J8HH6PCiifxVBklRKiYUEBzFlIrzerDijPFrl4HVJ0EAjpO+z3Diir9OQg3kwDPqQYueKFMqM337p
	1FSQGjEp9ZTsOvOwTHDUXh/M24bSVZjfHcNX/S/SjlG7uGX7fzMoKf6AkUHx21ZK9y9F5fnVljTo5
	IKwvClegfPtVN6c11+qOHcgRqMW6Hxl5zMcInk9c6CyRFv8W9LMcIi+ElE4KCIlmC3oxPXHSUAEZL
	QxALP+FcQsjZUphc1bRioJdldTjWgZISBVdulgaOAQmaaowjULyPmoxKPC0jaFcgxk4ArPy8bcT82
	I6VA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 64G1c6Nf972899; Sat, 16 May 2026 10:38:07 +0900
X-Iguazu-Qid: 2rWgeMmgaz5ONgXm4I
X-Iguazu-QSIG: v=2; s=0; t=1778895486; q=2rWgeMmgaz5ONgXm4I; m=+UuQat2p4gbgZn5GtLmblAEEWI5dMOuX0QuMyiLXwbY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gHRXY2GkSz1xnZ; Sat, 16 May 2026 10:38:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH+edFsVKinaFNEyH4EML8SRficHH6tWWpTqAhGWEeVamMcD5ZEY9gAoqOLGHsJqUqqf1Hts7iZYgJkpctJ49KoPth80irYBbUbOKBKXzHQiXeKz9Cm1aLgATU20OVhEQymlWRZEHNRNhzbwDFuqpt2sVb/d4ZX8AYqdB5xjs7GSoyhimOPCSNqkudo1h6wcFvxkGIOK4/2Tg3qasCwjV+7V/OdeByUOULc/DD3WDffoUHLbl35nYN89nJ1/2y7ysagMGcRZaIjc/2qE18G6jgz41DQD1xOSls67tcFBAenV7NHKbuFJ7KoKAfbnKRDAIDgZvMAbxbNJtATA80OMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r8D1lFidtATKPQnoJDJ8GYu/9LgVNJyovDMTAY6tek=;
 b=q06mh8z32qWqkTzkWRm4bgLiUgs2pVTIZU8XvAu0FXil/f8YhMvhRqPwyCt+5Ip5+e63tq1CVfdvDlVEPMqZe4QTd3iftagLIlpSwb1UNDADsDUqluJsOKFcV+ayTC7XfCE33wMDQQ7K/mSSw2ZukX48WemYb9k66vMJeWaN8w/pQgoL1bX5Q8nnh4TbnwXmcR0b1KUCzuV3JAfrz22Ny+pOyUV1LcxlVc3xZJnIp5a+jy1A3O3ghmDDxx3UUmKoRfSWJx8nVgh1UMaiQByGl6QHcpGqEhHFCQ1vf64s2swVOl11E9wmnAbFwXbqMKBV3eBAVBmnp4Rm0CF+YBfAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.256-cip73
Thread-Topic: [ANNOUNCE] Release v5.10.256-cip73
Thread-Index: AdzkzdErVevhuLnBQT2ypTzb9vkV5g==
Date: Sat, 16 May 2026 01:37:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CB8E4B1667D60EF88493CD052@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14639:EE_
x-ms-office365-filtering-correlation-id: 136de472-e309-47cb-2863-08deb2ebc293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|11063799003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 tiFpdP9u591wORDlB/I+zxJADd+kSvGELXjg2HSvPR86E9s+gYQXORR+fGwzHApNJNufHsASWyxlGytg2V4wGQhy6zLdzyxTWatmVYsNdrzt9gv7ucuH5t8RPLo3iFhElMCrQWAOPHuXNkl2pMdgM56Zu4FW5r3l48x7HRZcaOq6CkqPqnMUHwHvGVySQ3wjBzLyNekTegji+P/v9mg3/QBXZfKV66kf8FHC5k2V6J/fAX9QS7aPcqses2+2DtvKf+bMgsmZmZ/u8QA64eEYrOX7WVxoPqaAwsuBit/H1baTRMq6NyscqtK8aG3q29pOfpP3NwD/jtOxMmWO/YMGzekbfVUAtbedVhFsDpp5MtsI28ddHpKLMkeCJsehV6tRGAKXB1Tt0m+qYKeb0cb8j9jKjiMZRr8SyqSPRtac8q6C/MDfEzqPWTwO15yNp/wlA8Q+h6uxICURw++8rEpzfpdIqw7ax9/uVlzLBfaCSAmLrrz6pfJfrGLWO6Q5tAeG7SM5VS0tvVSdE7ajV3gygWH64uyiSqXeoZbnXFGDcCKPh+rQahj36XtKx7l/za6/CKyt/Xj2Zrd9c+9NYRXgr6P8uG/yHwbwoQt5t2//QdkmI6UtKqGUqJyxfw4RrifJzJ9v2wkgHCOb0hmvTjk17yWlFEd5wk2EI/gJryZva8xoOzxKn/f1kGv7lbrh+sDGmew6NXbDd5+eMBHj/RHsLuQZqWv1QM+Na/P4H9Tilo2w0dhmQblTc7aEWSKvmVNk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WkRzenhWbWxraFFlcVo1eEV1WGx5anBYMCtqdldJUGJsUHMxQVZkWWhx?=
 =?iso-2022-jp?B?WW5xdkp0Y2d2WEtuT3hnU0Y2YmRKbkVYeGlyMGRyMmVPK2FPejVRdGVj?=
 =?iso-2022-jp?B?MktPeWMyZ21YVUpDcmthYk9EUjl2cjNFLzE1c3d1N1lqV1pjd2I2L0tT?=
 =?iso-2022-jp?B?cUhIcEEvRXZwdUJDYTJ1OEJrTEZtMk9zR0RSWVN6QzRCRFhGOFRjQjc5?=
 =?iso-2022-jp?B?VzlaUU1BeFpwUTJtUGZFZXdWSXY0cGluUTM4TXVXcDNrR1NnRWN5Slla?=
 =?iso-2022-jp?B?cDR5WDFzWU1JM1M5cjgrSHhXVzBiN1lmeURoWVU5VGo1VVdkdnNDNkpV?=
 =?iso-2022-jp?B?SjZxT1RkZGVyMDNsOWU5eFE2ZGhBSXhrMjZpUjljU0ZScnNBcGtOQ2gr?=
 =?iso-2022-jp?B?bGFKb0FHOEk4ekpuQ0N5S0tRSkNNc1BlYVZpK3VHS2RqU2tpYU1LSUUx?=
 =?iso-2022-jp?B?eDBGTzNvSGNTTUN2UVgybEpaaEM1dkFxWXQ1ZmgrOU9IV011dUlOd1VJ?=
 =?iso-2022-jp?B?cW5ZMzkxWHhLMDM5b3lHZWltL0kvMHdVNU1nUVVkSDBZc1dld3dtSkZn?=
 =?iso-2022-jp?B?OHFvVnIyMTNOZ2xsVGJRWnQ1dE5XcWhsRDVHQmxJUHhzdkVHa0pLQlVK?=
 =?iso-2022-jp?B?MThiUy9aamZWZkxONFo2L29sQUdTNFF1N2ZrMDd5ZWFTU3c2VUtjN3pj?=
 =?iso-2022-jp?B?S09QMWlRb2c5WWxjTmtMMHdDeHdpU2RiMk1wejBpNDBJMzM5QTZYWVlx?=
 =?iso-2022-jp?B?Q0xBc20rK0dGcnMrRTg4M3RkVCtSQ0hUWFpub0V4STBzRTMrbGVXNmhn?=
 =?iso-2022-jp?B?MGk4SXNFc0FXWFYzRVpzZ1FRSWJkcjkxTVNsMm5zeURVVlFTbFJURVhJ?=
 =?iso-2022-jp?B?WWVjSThDUzFKYklyWkJqa1l4RTNVNjE3R1RCWVljcnlEY0w5YmFIY0x3?=
 =?iso-2022-jp?B?TmtzNFdEQVE5bkdrcHBEY2dmenl6SXlDVk1OYlhTd1F5dC9RS2k0aXpO?=
 =?iso-2022-jp?B?bnhJbkpIU1poTkx2bHZjc3NqeVBkY1lUQS9kZEl5ZndLOXE3Z1RvVi8r?=
 =?iso-2022-jp?B?akhmMzJyZnJwMmpCbkJGOHREMVRndGZMeWpWQ3VQNjYxZ2VFT0dmMW1h?=
 =?iso-2022-jp?B?cExieFU2Z0d0RVdZWmZBY0h6VXhzdW9zTWdrWWwyd0xNckVkV2RjbmJH?=
 =?iso-2022-jp?B?L3NPeFJLWERGUm5SOG9PT01TZDlaMENpYXpvcE5ES2duQ3grTTYwY2Z4?=
 =?iso-2022-jp?B?c3p0cWJyaFo1ZVFrUzBpNE4xSTBaVk9RYlhCSVpzWGJ2NWN1c0VpTkdC?=
 =?iso-2022-jp?B?TFIySC93STdzMlVDSlVMR1NObjRuaWlTdEsxOUZKYkhVcVRmYng4a2h4?=
 =?iso-2022-jp?B?YTFJdU5rWXplN09oam1JS3JEQmVDb200OVdoZmdJTWsyWmlMM3hNNFor?=
 =?iso-2022-jp?B?U3o1eTkwY1o2OUtveC9sT29nQjNIajlDbmQvWTYwMjVvbndUbkhJdjB4?=
 =?iso-2022-jp?B?a21uVENoZEdhaW41eXVlWS9Uc1F1aUg4TVNMbUF0SkU0cVFuREVxYktD?=
 =?iso-2022-jp?B?bDByajQ5bC9TaHZNdmduaHA1b3M0LzZnaVRoak5EbVhKTW9rb2oxTE5H?=
 =?iso-2022-jp?B?c1FSMVlNWkdkMFczdXNvWU9TV3hQdUc5K3hoUzRJTGFFenBOeTBaZzAx?=
 =?iso-2022-jp?B?bndIUmRHcXM1OEtFdkVXVjV1SEVyRVlleEJ3TGxMZVhzYzdJaGRDb0M5?=
 =?iso-2022-jp?B?cXgyTlpHWEJRZlhtWWtlNjliT1dQMytUYlFVdFllb0NBMmZid0VmM0Na?=
 =?iso-2022-jp?B?K1pKVEJhYTJrUGdFeEZkdE8xMy9JNlJhbC9GdWh5bmhOK2U1RnB4ckhX?=
 =?iso-2022-jp?B?ek45SGt1bWoyUW01U0NobDY3UHNWQ213UUhTZ3dCRWlSWElpZG9aM3ZJ?=
 =?iso-2022-jp?B?cm1VMHhLR1BadFo4bXBrWGpzQXJYR1pzYzdUV3RmY1pOMTZrbGJGaUNj?=
 =?iso-2022-jp?B?SDVuN3g5MHJUNHZTSFRnbCtQUzFEemwrdi9UU05ncnVFa012K0tPVGNX?=
 =?iso-2022-jp?B?YUwveW9tOU5mRFNlL0Z6RzZSV0NxSEZtMkVscTRJU3JMVmxPRUxiZ29u?=
 =?iso-2022-jp?B?bG9zaGY3enpVMEE1Nmc3WHNIQnlvaGJRTHNDWUhHVWRDRjAvVDJsRzJo?=
 =?iso-2022-jp?B?Zk1ySnIzcWVGbjRlR29Ta28zKzU5UmhpOTVyTXFwRnI5aGE2cURZamhI?=
 =?iso-2022-jp?B?Wi82N3pHZSs0R2gwbGF6bjVPSGdFQUJQR0VyTC85YmFFd1EwdWhlTitG?=
 =?iso-2022-jp?B?V1ZSTVlWUmpLaUhGd2pyb1V2bkpraG16d1FVRzVPQUtJSENlTUVRbnpL?=
 =?iso-2022-jp?B?NEVOcjlmNmdKcTJhZ3NyQVRaOGlVb0VqTFlQZEdmdmpHK1lFVld5eldi?=
 =?iso-2022-jp?B?TWhKalppTlU5OWQ5Z3NOUnJkV0N1RHZSVkNZUy9wODBhSHQ5VVNBQ1Iz?=
 =?iso-2022-jp?B?TzRhbE9qT2VZdWI1YTdTcmhsajl1VFNrT0N0TE10dmpPaHY5OVYvT24z?=
 =?iso-2022-jp?B?V3BubzVIUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Xv1qI5cz5q/MDxvflllCjg9+mo/JGN1M3/RDBOkC0PKewY1TEgDekTxEXIU2B4of39kXYNB9KMnsw+8Da6LaEB2S9fVhcK8D+yjDjSJdxAeN/vz8mrCX57Kwt6n8YS/NJVzfyXsNDaxUpsNBRum3mDwZ4/s+ftOEEWW0pKM2hopCsC/itaKqHV9ubvBAa3isrmLDIRAnmqsQhIpZyjJ3dzU4qLOZeFwHNrwf4M6iTyiUBoCa+5k2ebGWuaj2863cjonElRQsjAy/Qe1pEjf38CqsAEw/NfTjvRIliUR6xQtkljUs5yZnS1+V8YMQogiGCismb3D8oP8Q5w2q6Zkb+w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136de472-e309-47cb-2863-08deb2ebc293
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 01:37:58.4469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Qg9CPfIe0hLOBZLnMC6IEvjBF36hBP96pewLaZRlR2c2CqKWPrvHaWjc3Wz9LdC/8UD6T/vdnypMj4NfDW7u7IbBAWTxxwVoV1jD3HTBjB/E9CAdId1ZZyqSyPsxGOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14639
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 May 2026 01:38:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22972

Hi all,

CIP kernel team has released Linux kernel v5.10.256-cip73.
The linux-5.10.y-cip tree has been updated base version from v5.10.254 to v=
5.10.256.
This is based on the LTS release that includes fixes for Dirty Frag (CVE-20=
26-43284).

Information about this release is as follows:

  v5.10.256-cip73:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      b1d0cf5ac0d2f6deb7687dd190100cb8423d71ff
    fixed CVEs:
      CVE-2026-43284: xfrm: esp: avoid in-place decrypt on shared skb frags
    added commits:
      CIP: Bump version suffix to -cip73 after merge from stable
      phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock

Best regards,
  Nobuhiro


