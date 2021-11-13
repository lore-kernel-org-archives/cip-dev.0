Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ABC433EF
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 05:30:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.2780.1636781404432875550
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 21:30:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1AD5Tiej021781;
 Sat, 13 Nov 2021 14:29:44 +0900
X-Iguazu-Qid: 34tMYeBbKLw3w2Nlp3
X-Iguazu-QSIG: v=2; s=0; t=1636781384; q=34tMYeBbKLw3w2Nlp3;
 m=Ge7APM+xUzdHxkJu+PdUMU1mEgAn7vjQgvbqqe2tdv4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 1AD5TeJo030717
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 13 Nov 2021 14:29:40 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 3A71210011B;
	Sat, 13 Nov 2021 14:29:40 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1AD5TbLg011382;
	Sat, 13 Nov 2021 14:29:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edU4BiwmdvvVaXcRLEWpQySEywWX+zKJV61ksGhcqtaAgSNVUJYggPHlpypw8Uqh1euQjao25ZpmwrdGNXNAmA6S7eUJOCymyWRs6Z2LKkYiQc9TxUonaqMgl74VOtBCeLA8l5aFh4/wIOM+gjKjbwCrtQatpRTDIVjWI2TlhWAEz1jHJni8DQSHFXf65R6SYoe5AhlvomK880Rc6B+KdxjQV+WqExMS2f4C9CvWCWhLnfM9iE6+KlfFPQXRFWhXup0RZjAP2QB3uup+Dc31WGqUNMwCwE8MPIs4JQwb0ZsEOUg5tSfqkDAvoo3mO+fH1TOPo22vJxowZ6+I7R7i8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtuJD2Mmou0i/kLZM2fXkpU31Yne7tx6/wO4krNt33k=;
 b=WloGM+f46MqOYxzFqVTqtHvntFnLxDHY9Oe/FjkIjl/WQcV/brZK12Hdjaub7JpFSCsaPYF7cDUbDEQYA8wdBydElpFfLxmrJ1LLBcWNgVOlYUWzOJ07VSJO1hdfuRtLSvV8zv1c67KpIOO/8DgAqxdnCkcxfYlyqVkW6TqViE91RJlBzP9vCZiHJquCWEeFc9B7kkzCJ9ssXG5c5+FCah3BEWAR9m9KOAlVYlPlOsEGCQuo4F2qH16kJUrgauSowedQtLr9t5oYSFiPhAXgc33SkyzYjmYS1F5fXUdTLs2xM6B2jkxJWj5ohtTaTeUy+GlPvbkrRB/A04UkudcNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.216-cip61 and v4.4.291-cip65
Thread-Topic: [ANNOUNCE] Release v4.19.216-cip61 and v4.4.291-cip65
Thread-Index: AQHX2E71EeATSRM43US8IiNaItsJYg==
Date: Sat, 13 Nov 2021 05:29:37 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252C6DB8CB81379A40B9CE892969@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 2b8987ba-86d3-7456-414f-78378bff76b9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716af79e-8c39-47bb-c999-08d9a6669577
x-ms-traffictypediagnostic: TYAPR01MB2990:
x-microsoft-antispam-prvs: 
 <TYAPR01MB2990881964A2853D5983470092969@TYAPR01MB2990.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 v2gVUcd2L9p/oZM/H0NuzjdoMVZzYup6/crJqgDMt304W3EBL9oHHmA7Qy2ZlOqnXJ/nKH+7tMk9HrVXFAvUM3U2ATN14xgBC9cFJNtdevRlsxPzTA1pvdXwnV66mchhemVu6JjFK6R3/3v7oqy1cV3yXuv46x7D++DT50EM+yJV3tX43sy3OB/eGWkQbnPVBwfKPHFSMLV7R/hogSKQ1nk37cRhw624tsoTtI1GH/23TjcK6x070XCKXFB+x+EXx7NzqQDKTxFDLNRMgsyLA3h94TxEaIKwppjlIXRq+i94b7UPaHuvDihOO4f3ZNOvuU45C8yNBVxJkOpxSkTS/gDzyQdDO4HJbEhoEeHsCkhFxzHFxHXxWOMkoHlpIQmWCnAEnAZmUbNE5EP93yG+N1QlgV485cBgH7gg2uq2av6OXFYfJsBkTPWe1uBt2AG5qcjZv5YEKBLJud/WX8d4C/9pI9t+7tO8zR+wumLoa98qTPxEiD6lsPA3t8y7rt0mF5Qy+G51kEwTC+i9nrBGKybmggERgJVWM2DQ+OZ1Hgb8bZ4oU2dJ5phpEJ08QPorC8I+68bnOgZCNk3eXx0MPelG4Z3OxU0Qku5dDRJLJdXOzksE47qryB5LWcAKO2vZfQkYY9BdgUqN2o/UEqoaG01DVfcjDRA/BKIusjQL+RNRvutI1RGviVG6NM6c4g6R8FFfFsQH0NtVatnAoaJ82ZZe+SQo4NpH74texcLtF5ymruW3VUQXneCTetsXVpPz5tMYj09N3RFkm/+ErumYQsyj2kuP2apJLTfCBQPnedY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55236004)(9686003)(186003)(66946007)(55016002)(5660300002)(26005)(83380400001)(33656002)(38070700005)(52536014)(2906002)(7696005)(8676002)(86362001)(4326008)(54906003)(6916009)(71200400001)(64756008)(66476007)(66556008)(66446008)(508600001)(966005)(8936002)(122000001)(316002)(38100700002)(6506007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TDZvQzZ2ZGJCMVpRZjBZc1NlTXZXYUtsRjdKbU1yOGhoYnVrYmRWMS9l?=
 =?iso-2022-jp?B?UWtOWmZSaFJzMkQ3UzBuSStBeWZKcTZER3lHcnFMenFhZm5tbWE0VC9W?=
 =?iso-2022-jp?B?MmJGdmVwRGJNaTdkTTNiR29xZ3VWZ3VhRVNwd3VKYWcrRGpBZG5DK0JK?=
 =?iso-2022-jp?B?ODIrbWpxS2R4YmkwZ3FhMVJWUkJSR3d4eHRmVHExMERKTVA1MCt3eFpj?=
 =?iso-2022-jp?B?Rk9wNGhXMGNQV2Q0SVJoTXo0VEJneFRZY3VCa0lPamd5R3dLWlRMZHhH?=
 =?iso-2022-jp?B?TE9UQkhHNFRHVERUZUk1MnpQMWRwNS9KbmNva3pxbXFpWWlaR3UzZUdo?=
 =?iso-2022-jp?B?NlBpN0FYK25PVlZhVE1pTFBDclRRbFJqdXMwbUZxT0dqTXFYbm5hT0c0?=
 =?iso-2022-jp?B?ZEhFRmpya2VuZ0pYdS9HVjdXNjZNRWhtbGZLaGZwSHh5NDRCZmhWTGNn?=
 =?iso-2022-jp?B?U1puSU4vVENKMURrOXJ2aE5LQTZhNGViQkYrL0t2UXpiV2d4RU52ejh2?=
 =?iso-2022-jp?B?KzNObWJDd0JIWDVTTVBsUnB4YmxRaFVDTzdIaUoxeFNZN08zUXVPY09M?=
 =?iso-2022-jp?B?MUgrK0VmMExjYVY1elg4eStsNlhwOXNERFRpZ3BTYWVQQVExTWQxWTZH?=
 =?iso-2022-jp?B?WitxTFBWd0FyQUgvR2hWc29ibmVXR016RG4xZGtuQ2U1cEVCQUUrRGxr?=
 =?iso-2022-jp?B?b3cxdjBJbysrTEdHRmdmaVUwTXdKOGtxSVNBcUZ4TjhESEtzZCtqb3JZ?=
 =?iso-2022-jp?B?Q2pZYi9FZHBNT0pNaVg1V3hvdG1nY1J3VTdVRFV1eW9UTHoreGNIZ1NV?=
 =?iso-2022-jp?B?UVlHdzljQWUrL0k1bnZNVDdFUDUxNnM0OHIzK1ZlallPT2lDTDZRNjhH?=
 =?iso-2022-jp?B?MmQ3S2xFN0tyRFIyUGI2cW5HcFRYUi81OFpkcGt4MS9ib3RRMkdVTFl3?=
 =?iso-2022-jp?B?WTg4TlluRW5NRnozenJyQ2JaYXpta09Iem0yYkU0ZWZ0ZURZckNEVVBo?=
 =?iso-2022-jp?B?aE9PUnRPMUprT0l5czcyc1FiQTlJWmZFVWh6QVBRdjZlRUlxTktzb2Yr?=
 =?iso-2022-jp?B?RmlVNXhJYThoeE1YYVB1R1Iwem5iUUdobTQ2cWFDU29VeFpZYWpteE54?=
 =?iso-2022-jp?B?RGU1MkxScEZGczNTczVnemU1eHBKeFpobEowWnJPNFhmK3FreDlSenNa?=
 =?iso-2022-jp?B?cEI5NW13cUVGeDFMeXdJRU9ZS3FhK0JIMjZRQXMwbWZxT1FyY3ZkNVlE?=
 =?iso-2022-jp?B?Wm53ei96TXA0Q2cwbjFYdVY4QkZudVZ5aWwzd2ZVL0hsUkgzMkg5V0VO?=
 =?iso-2022-jp?B?bU9NU3YvRy9tTWU3N1VPR05SdnM0a0NtN0x6VWZ0WEtSQ2dLdndsaTRY?=
 =?iso-2022-jp?B?T3NGbWY0enYzMGZCMzNES1lHMmgvaDJkTzhYZUZta3dSZ0llRGhqMkhx?=
 =?iso-2022-jp?B?ZVBWUlZqQXh4QnBDbjM5NjUyY2JJdjNORkdxTHBES0I1K005eTRTYXcw?=
 =?iso-2022-jp?B?U1I5c3dBdnhYVkJNSVZFbS9ZdmJvODBMMkEyb2RXUmR5Q1hNRWl4cmhi?=
 =?iso-2022-jp?B?bVUwR1IvYTdra3BkU3N6aUd2dXRFYXd2b01MbnkvbjNlTmZhbHNWZnlX?=
 =?iso-2022-jp?B?L0lSd1ZsZk42SnlrTVhnMUxSZHdOYnZHMjlLVnYzczJ3bUJMdm9nQlFT?=
 =?iso-2022-jp?B?MUhHdEhQcGtqVklsZVNTcTJrODY3cXZRRGtIRmh1cENFc1VaSUt3U0hr?=
 =?iso-2022-jp?B?S0RUaWxFQ1p0THhBdDV4QXpzVHBSbW8vakc4U2lRUFhKSkRIWTBxSDdy?=
 =?iso-2022-jp?B?Q20zbVhqelI0cjB2dVFOV3hnc3hrUm9uSUpVZzBjR0RVSmhtWXBCSHI3?=
 =?iso-2022-jp?B?NnVSMEFUVFp1b0NkLy90YXZQWmxTWmF6OWhQb0VNTWlxeHdEellwTVdZ?=
 =?iso-2022-jp?B?UEc0NUxLeG9aK09YV091NmtGckJLMWZiZGFBZU1PcnlCMTZBci8rcXFX?=
 =?iso-2022-jp?B?dUtnRHN0NENhaWtEU1J2c2N5OVlHazJvUHNUQ3NjY0Nmc2R6RS9sSnlh?=
 =?iso-2022-jp?B?MFh4SjZvTTVKKzBTQjhTY0hDclZmSU5lTTVCdSs0TEo4aVdzWXM1RkVC?=
 =?iso-2022-jp?B?Z09QOVRJajNHaVBYczlkcTRrNzgvUnYvUlBBbGlRa05qTlRnN2tVRVY5?=
 =?iso-2022-jp?B?YVVObE85dWJYNjByRHkyeTA0UHhBNFNpV1F4U1AxU0NzYksyWDBzWEJI?=
 =?iso-2022-jp?B?eUhPMTVSaUIvN1dnNXNpbzVjL2JNay8vb1ltQjB4ZGw2ZGIvK0hqZEpz?=
 =?iso-2022-jp?B?eG1HNXNmMnpabVgvc0daRXgvS3k1WUY3UC9tN3ZHNVlRcHo0cGZpVWdr?=
 =?iso-2022-jp?B?OFZJQmgrbGN4cDVhUlFYNlNMWGpDOEF3bDVaS1hYck1sMS9ZMVF4THBS?=
 =?iso-2022-jp?B?RVhkZFhYZFUydWwvL1owUjhmKzErb0gzbmNQQzBnK1FaaTMxVzBiRitU?=
 =?iso-2022-jp?B?S1JQZHly?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 716af79e-8c39-47bb-c999-08d9a6669577
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2021 05:29:37.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 2/Qgot4PQRkGmgb+2bTE7LLq9ZQUhrxXW5rLFnuizS9N/aSx6RAZE2CpE5qkwhYCbgZyXYe23Ga955zPJn+eWw1oisJ6+XRSM6fXig7m/8AV41GoJ81bXC9BpXSbQ+nE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2990
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Nov 2021 05:30:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6899

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v4.19.216-cip61 and v4.4.291-cip6=
5.=0A=
The linux-4.19.y-cip tree has been updated LTS version from v4.19.213 to v4=
.19.216,=0A=
and the linux-4.4.y-cip tree has been updated LTS version from v4.4.287 to =
v4.4.291.=0A=
=0A=
The information for this release is as follows.=0A=
  v4.19.216-cip61:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.19.y-cip=0A=
    commit hash:=0A=
      6ecdd66903013bb4aaaacbf91a7ebfda140b3c9c=0A=
    Fixed CVEs:=0A=
       - CVE-2021-3896: isdn: cpai: check ctr->cnr to avoid array index out=
 of bound=0A=
       - CVE-2021-43389: isdn: cpai: check ctr->cnr to avoid array index ou=
t of bound=0A=
       - CVE-2021-3760: nfc: nci: fix the UAF of rf_conn_info object=0A=
       - CVE-2021-20322: ipv6: make exception cache less predictible=0A=
       - CVE-2021-3772: sctp: use init_tag from inithdr for ABORT chunk=0A=
       - CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflo=
w in avc_ca_pmt()=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip61 after merge from stable=0A=
=0A=
  v4.4.291-cip65:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.4.y-cip=0A=
    commit hash:=0A=
      65ed894ba1119b9887f389d31fca58f662162de0=0A=
    Fixed CVEs:=0A=
       - CVE-2020-29374: gup: document and work around "COW can break eithe=
r way" issue=0A=
       - CVE-2021-3896: isdn: cpai: check ctr->cnr to avoid array index out=
 of bound=0A=
       - CVE-2021-20321: ovl: fix missing negative dentry check in ovl_rena=
me()=0A=
       - CVE-2021-3760: nfc: nci: fix the UAF of rf_conn_info object=0A=
       - CVE-2021-43389: isdn: cpai: check ctr->cnr to avoid array index ou=
t of bound=0A=
       - CVE-2021-3772: sctp: use init_tag from inithdr for ABORT chunk=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip65 after merge from stable=0A=
=0A=
Best regards,=0A=
   Nobuhiro=0A=
=0A=


