Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EAC433F5
	for <webhook@archiver.kernel.org>; Sun, 13 Mar 2022 20:28:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.19029.1647203286175303794
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 13:28:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 22DKRhPQ016734;
 Mon, 14 Mar 2022 05:27:43 +0900
X-Iguazu-Qid: 34trDs1hpAsuwjj2O0
X-Iguazu-QSIG: v=2; s=0; t=1647203262; q=34trDs1hpAsuwjj2O0;
 m=Cws7zBGv6r30zNVKLM6oQo7JCL9ghFlUSrDbT6L+ZqY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 22DKRel1028479
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Mar 2022 05:27:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP3Eyh7M5c23rb+9KAmLcfeuzjnY56bonpLM88rMA1E8a2ay8l5wBi3uclDe4SI13U3GPJEiaRpOt74faBgVL+ryKQCpq7RAUzNTi3i2jZIGyZ2aKRkSy5BQ5Vw1bPEpcQ8ymehF/C7ZwcaaV8nFLgR/9WdXavXC29hZmLk3RpAXEXPkJ+5XuNm7tvld7Lr5VLISbiNElKssGzUTacy0SZgAbSxSKOXa6I1A9nMCXMo64hzNstyPDBZ6t+DY//sYy7A/Kfd43i8uoZL0aN09bW0um1ngo4jojLcv5o7yx2+BBMNIGBqVRBCmeR9ChACumRxkKXooG9mj12ZKjYm+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI/MRdU95hEKciHN7zLgJH9dC07IEDgeWxZ/iiNRv2I=;
 b=GxcfmyrGPrZa/oG4Hq17BqUmzX526EUsq7fufsjMTQEEFIvu2exbVczeGjsq91rJpWP+aka5FZXStG9md/PrxYWBxy5mhvyczBqKwMg1xyj+Pr6a5WTJtK36yaC3EB5d8RXC5cDJ1x5FKbvHKaCKilxxxwz3OAmxbCmBNRawd2kGAqQZrtwjjJlHdPabaOwOaxB5h2E+mUjZ3BkwuyVCa9BP5iEGQoZkvr3/tXi38AM6gnKYuZZ89vXgXG+S6346wAdABhJaX/dDIOayt4ZOYwTzaolwUIQp7FmIiwEyv+2AjqmpDnpr7IrmnE5y5TlK7KenHBFSi1CgzqAtFnVWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.233-cip69 and v5.10.104-cip3
Thread-Topic: [ANNOUNCE] Release v4.19.233-cip69 and v5.10.104-cip3
Thread-Index: Adg3GK5e00uk+zDaSKyUE9/uSW4syA==
Date: Sun, 13 Mar 2022 20:27:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62527177871D7E42DB6AA0B9920E9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1286acb7-3fe9-4698-aed8-08da052fea45
x-ms-traffictypediagnostic: TYCPR01MB8311:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB83114E9FCDC679BC23C6D411920E9@TYCPR01MB8311.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vRIclZszy1EOwFMqcFXOTtbtbbAS40n8FrbProLQzjP6Saf/M2By/7hKMwaf03tN+yr/gQSQPXrIpmpJJTiKkJddfAHehfF9/49U8TcDPemPMg4hBv2OQA0u5UElEB6inYbafz6Qwzil0ZnKMwuXCwgbmJ6DwxKnVIyJf8yjgNch19lth6NNsDhhv2S09riYt0MyLHHxVIqgHvR9Hi5fiEqg5rnEgT8PlM2pSXzi+89Kcz9qdvsuI0jXau/ZycdN4odBzG/cSd+25f8AYzqm//T7zoS34DdQjwcTJWXnkO7ITTh7t2dgCoKMv93vJ+ZRkl4foB//4nEUtqh2TUvSw1TwTT+yZi8/YX9uQW4SVnR7852SMJsoldzg1t5if+3MqMm+IDvzPoDw4DRqwPnmTU31hir1EFlML2xJ+BzQxR8s63TIQ+1hbVKrhtvM3QFFHF8fXtlytdU+A7w+RzGJfZzJpOAbd4txdnRw388HKZI25jJcBh+uGg/VW4ZbVsL7USHcwMh+LB1FdlTplLQySTlVRr1sYhOeUPjvkRi7cpZmpiafaWOCT4CNXJ/a/8RIMqlVz9iy3OiLlrbazN9yEuKCKMcfxzBLVpAW2nzioqn5ZZ+QuLUkURjwtNESrCAnxW96H0QhX3tcDVT+K5DyWCFiFmgYfksJiOmNghjvoepAGcXY9EjiKtTNwjyv4uNE5QWQfV5h+2XLgu3gxRSvxxI03d7vDp9rFKT44vIBr25lCVxP+QhPROXm8lP2ZRlaE7CO6fms17osBME5jBeACw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66946007)(4326008)(66556008)(66446008)(55016003)(66476007)(76116006)(71200400001)(86362001)(2906002)(55236004)(9686003)(6506007)(7696005)(8936002)(38070700005)(26005)(186003)(33656002)(122000001)(38100700002)(966005)(5660300002)(52536014)(508600001)(8676002)(316002)(54906003)(6916009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0VkYTlXTlRVMVRqNkd1QWdrYVBJeGhHZlJLK1loWGx4T3NqbDF1VGVO?=
 =?iso-2022-jp?B?R3RLWGpxckR5M0ZrMUg4ZXFTdkN6V2p6WFdMd0F4OWk3akZUYW5uZzI2?=
 =?iso-2022-jp?B?UGkvQmh0d1RDdkFGQ25HRmo4SjN0NWpFWXhtNklWR3UzZVVrSGlFUkRL?=
 =?iso-2022-jp?B?bXdqNWhwQ3U4bVZ1cklrdmVLTUtZcU9mN3FXUzdKTmRVZklGelpUdmJa?=
 =?iso-2022-jp?B?Wk1QU3BNRkhqRERxdHBjbDNFcXE2b1U1bHE3djcvRWdITWwyYlhSNFN2?=
 =?iso-2022-jp?B?Tk5NYzZvanU1bXpnaTJzVkxFSGxkU2hUMlNWRitQL3pWZncwa0JjbzRp?=
 =?iso-2022-jp?B?MHB2ZE5uYzBjRWVxaWRLRUlSdDdtRy9TbHA1dzE0Q2F0UW9ZNTRzYXJw?=
 =?iso-2022-jp?B?ak51eE5kQlhDenRVZXpIa2dWLzdXbEF0cXNlcjZIa0hkNk9WV3FIYUkw?=
 =?iso-2022-jp?B?N3dZTzZkVUQzSTBib3A0NGhsWEVWYW0weHVkWXl3K2JqdUNKNDJiMDlO?=
 =?iso-2022-jp?B?dWpxUzFPNTQwMmpodTVYZHNyeHcxRUtXU2dOek5XTktWdkRJS1dSVDFz?=
 =?iso-2022-jp?B?Q1ZZMVROcEZ5emlEMnlGZkF6ZDB2UkxLQ1ZrZE9HL2hoMDRYdFcvYnlC?=
 =?iso-2022-jp?B?TG90RVRnSTkzb2VzeDdGbndDQVp6MHhqVDlKcDJTTHk0TXoveE51aU9I?=
 =?iso-2022-jp?B?ZHduRTk0Qms5Q0krd2E3QjA3ZW5yWGxEbDc0VGY3Mk5ibnN2TXQ1VG9S?=
 =?iso-2022-jp?B?UUpHajk5Z3JZV1FSSVdTbUtMNFZGdHAwQVNTZXE2TC9pbHZTWWZrRjZK?=
 =?iso-2022-jp?B?NzBrSmFVNnR1WEc5Z0JjN2RETjBSVmFiYnVFNWZZUUNYSEU0SVpsMnVi?=
 =?iso-2022-jp?B?SlF6VUo3VWNRSS9MSHVPMzRtUFliL1d2SEx6Wm83TCtPMUZ1N1BEdm4v?=
 =?iso-2022-jp?B?Z2VSN3lLakpOOWhPbnpLdkpEeElUUjJUN1huNnk5ZTF4OUpzWUNPM3V6?=
 =?iso-2022-jp?B?ZHhOR04rakUvOEpGZmlybVl6RXVlRFh5NGtzbDBySU0zZ3J5blFydmVp?=
 =?iso-2022-jp?B?b0xyVUg4U2FzaVR5NjlWK1dGc3FnVGQ5R2s4TDZ6S21mdnUxblpRajl2?=
 =?iso-2022-jp?B?TXdqVGpjZElpMVNtVHdNb01PYk05SXRyOStGRFBka3BhRGxtQTRhekRv?=
 =?iso-2022-jp?B?UUowb1k2WlY3Z3JWdlRhQUVJWW9jUEw0Um1KaitqYTk1TDI0a0EzTmls?=
 =?iso-2022-jp?B?MUtZVWx3MWZhNUJiYTFqNDlRanphL0hPMng0TjEzeXBXYklERnBOUGFH?=
 =?iso-2022-jp?B?bmFoZndkS3FUaXA1Z0tucXZXVlhuODJtOGd2VnBDcWNZN3R1SGpHMDBy?=
 =?iso-2022-jp?B?VSsweWxxbmxuc25LQzJKa2hpblJTekV6QUJwd2tTU3RJMGk5WVlQM0RI?=
 =?iso-2022-jp?B?WGtTOCtVc2VNWHU0U0QvM21MTTRKdzVWb3JvbUdBdDBNUjVXREhkYUhQ?=
 =?iso-2022-jp?B?RXdwcEI3UDF1RFI2M2JQTHEzQWlaMzF0TjNNY1Vxa3Y0ekpHd214Mjls?=
 =?iso-2022-jp?B?eTEwTm5jdUdHcDlaWXV5Vm9ScGZyS012eG9HWUE2SnNPMkxtTjZlZmRv?=
 =?iso-2022-jp?B?NHJ5dEhVL1ZFcjQxNExuOE5QRWtyempScTZnWlBnR2o4VnBQTkRiVGpB?=
 =?iso-2022-jp?B?L0FYR1I0U05pZGhwRDVQb3VTZE53VkpmVGMvbUhRL3RadUlxZjI1NE5U?=
 =?iso-2022-jp?B?Y1lXOG9IbExNRHk5ZGo1aWdXOTFCcUppTSt1b2hzb09VOHdNOUM2MVpy?=
 =?iso-2022-jp?B?YjB4ODlCQ2t5QzVYQVk3Z3MwbzBxbkpsVkdtY2kwZjYxQ2lZenFDNzQ0?=
 =?iso-2022-jp?B?U0FBSlljWEVGL3hKYThvc0U0ZnVCaUR3RU1FS29CZk05M0hIVXc2QjRT?=
 =?iso-2022-jp?B?ZjRIbXV1SGpTbGdQTytXNGNpLzBMa0FBRTFneURmeTM5UmlVdmJ6SXdJ?=
 =?iso-2022-jp?B?d29pQ2lNUkFOOHY4Tnp2d3Zyd0NXRCtqb2gwSHovSDE0U2V5NFZVb2N5?=
 =?iso-2022-jp?B?Q0Z3Z2lvSFVwZjQ0U1M5cG9qTnp0cGpTQ0VpZldLYkcwMTlXTUVYcHJh?=
 =?iso-2022-jp?B?YktBc0hCVjBtNkdQZGw0RkIxbjJaSEFnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1286acb7-3fe9-4698-aed8-08da052fea45
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 20:27:37.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Z6kWEkEoverqfYNH3CfgzF/ydkEHlhHVPyZJe+2zC8EpLazTAI2dbI6TayZ/cFn5ABzqysdphpfO5wIi2gPCqWTKGMN6x17cuQ9KSg0DHbGVNl03JXvWDDAxe2JecFsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8311
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Mar 2022 20:28:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7697

Hi all,

CIP kernel team has released Linux kernel v4.19.233-cip69 v5.10.104-cip3.
The linux-4.19.y-cip tree has been updated base version from v4.19.231 to v=
4.19.233, and the
linux-5.10.y-cip tree has been updated base version from v5.10.100 to v5.10=
.104.
Each tree has no new CIP-specific patches.

You can get this release via the git tree at:

  v4.19.233-cip69:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      adce3ecbc12596b052ad50a96e765702abcbca8e
    Fixed CVEs:
    added commits:
      CIP: Bump version suffix to -cip69 after merge from stable

  v5.10.104-cip3:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      811c07d2359f700f05d08c49b9d8c4333322bf90
    Fixed CVEs:
      - CVE-2022-25375: usb: gadget: rndis: check size of RNDIS_MSG_SET com=
mand
      - CVE-2022-25258: USB: gadget: validate interface OS descriptor reque=
sts
      - CVE-2022-0847: lib/iov_iter: initialize "flags" in new pipe_buffer
      - CVE-2022-25636: netfilter: nf_tables_offload: incorrect flow offloa=
d action array size
    added commits:
      CIP: Bump version suffix to -cip3 after merge from stable

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


