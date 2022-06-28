Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4554C433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:51:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.49625.1656377492009197464
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:51:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 25S0pDjT001584;
 Tue, 28 Jun 2022 09:51:13 +0900
X-Iguazu-Qid: 34tKBxeAhtAm6F287K
X-Iguazu-QSIG: v=2; s=0; t=1656377473; q=34tKBxeAhtAm6F287K;
 m=8OdyBpEPN9D1hNchc4fEnV6rSjewgRfSKwNLN6fNpBk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 25S0pBK8035866
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Jun 2022 09:51:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye7yn+2YU0MzU/QAr1p8KtZO1JlOlYWsk1+dYg4Bi/NqVBUnAPhnTm90wi4f5y7y6BMaRIK0FUXIHZTgEi4nuYwzVfUs9igRbtfYZCl+c7hiY3hxp+F5YAwX2o3WBMUWFURGEhoOHClv/Ak4UaOrcEcYSWBaBIoWvPO7vHanTKXqx0TgzMYxlWCmQVvryPgp5+fzG8b5XoLvefwFS4w+Qe6T8YxR6kNyFRzoaPXCL/9ilALXjapuYzfCxtD8DfQPsejF3SjxVWEK0fSdVApkW0aTZ/l+hzUAXZ4UePgEWTNypt9Km0AS7QIm2g0msDYSn4C7ZCghG68U4Ie4fSOpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV7pn1qRZejt8d2Qkv4GbRoP1sb3aoo7EDLfiwzrrLg=;
 b=f+xWgqWJtM2nc3uFck9cYn7xJXks8JMGFSsg7CIDTkm07fQbjTL+1btlUQlIdfR/w9aqRv0kIbadvWI6ZfHQPxpjc49RaBVVTbzZOyt1tEDkRl+34dNqwKHsLK2NsU+R7eLIfPiVd/7fHu2SFC8QvVqfLJVnn9iIlLjjxqHTi6YquQxJvOOysRQgZf1PVSPJnO5O3tmkPQvb1bDfSMPTfHqwC927pTj7eceBbn7OqqOw2GSlSLLIVie/xxe5dlmwWowlZWM5xK8+zHv6wMFDhnSzLC+yLuprF9eestXnVyVdjilFUTwBwYQZVCwj8GRffU8xyCZ/3m1NFntrtlHpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Thread-Topic: [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Thread-Index: AdiKiPp60ZAqLGCESNeH2YSchf1cRQ==
Date: Tue, 28 Jun 2022 00:51:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A4CEE36E4B536184CBA992B89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25dcfa57-035d-4efe-8aca-08da58a04a63
x-ms-traffictypediagnostic: OSAPR01MB5123:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5qERudO9uzUlL6zF3XA8q/2jJ9t3BmgdEdpu/2krDkvJug+1L2w/m58HyLBR4N2oSuHQnoNU41Yl5OAP/yh8TKMzo71LKZbGbsBRZLYh2Fj3yGA2msNSkgX4TFut+slADJgUlj0AtG1N2syozieaCfwD9XuGx+RqEICvpse5nIsvG48tlGQLsGVHjQewo8pJcW3CE2S6lULF8qWesOtKQm5F6zHLazuw8Nz30Ae8BMnJwwqJ3qyv56uczoA0P6+V+INAvTtTS9o4zkqTu39TVSw0NpxN0Xw6LmAY9i1qQO/FRWr3ggMIFig0uZHg9ix52RdWbXc7xRTuZIebEk4l0HdZnU/y/+2iGNXVdboOVcFLJqU0cnKjnvvC8mqp7ptakXqVSQnKil/j+0CQTMKlMvcMdrJ8NRT37d/uzV0TbC2+gdysuPG4oR2qh86y5wOOCgT0T3JExmeQfYk/09klA6vTamkpfiOCOGIsPeZUdiMwcaBW3amzTmVzXwmT9tsGe4njxGu8yeDyw//KknXboqHt1OE4qM+ffa+yqUlCpTllTawY6kfujEnU1b4Md6yVxTids/wgLvZYb7QTZHmjblvIgR54MiDt6hwB9ar3vcbHq2igUx3BQXgj26X8tmLaEnHQHMHDnNeUiGepQKj2sUl0tEs6y5XpxiMRESpsYrGgNlycb+OLLXQPf2kNEwABN8+KM/O0/Fo6VvojTvNGs/bNBD1ztVE3wm0orERZeBVHmDM3d+N0yJtOGvaeNhBX+bWfJfHJ1PeK9JIKblya2RIsbQyJt4I4mL8Jb/wYpxp7nvLHTZV+bhY4/L/v8I8W
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(122000001)(9686003)(316002)(186003)(55236004)(66946007)(8676002)(64756008)(38070700005)(5660300002)(54906003)(8936002)(6916009)(66556008)(2906002)(4326008)(52536014)(71200400001)(6506007)(76116006)(66446008)(66476007)(7696005)(55016003)(41300700001)(966005)(86362001)(33656002)(478600001)(26005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K1lkOWlVZnBaaGRUMUxKZDU5YnBZNEtWd0p4RENHQ001eVExVTZIek51?=
 =?iso-2022-jp?B?Zjg4eVF0MVorRk1hTWhBQUFoVEsxMk9iaXNXYVM1MEVYNTM5OENrRFFY?=
 =?iso-2022-jp?B?Z3NQajlxc2QwTHE4T01UdU1DYzhYSnNCSDQvQlhDU1NqeVFqNTFIY1Zj?=
 =?iso-2022-jp?B?czVUcmQrN05ONUswMHJ6d0trOTNMVTY5ZjhZWmZBZkdWc1EvTjJvTjV3?=
 =?iso-2022-jp?B?NnV1R0VCOVlUT0F1eXBlS1FiRVFxKzVBbWdSTEVaZTFiTVFMNlFYYnpl?=
 =?iso-2022-jp?B?S2dhR3ErUnlTYko4UnlWREVNZ2x2MytTL2NPWmVBb3E5TkNrbHpMRFpj?=
 =?iso-2022-jp?B?clhoRjVGM1l5MDhtUDYwNzdJV1JHaSsxMWtod1FYOTZVSXptYzY3VS9j?=
 =?iso-2022-jp?B?MzRLVFAzUnRXc0NYTHFJNVlxemdVOXZLMmpIQitoWTQ2MG1hU1lNYmtK?=
 =?iso-2022-jp?B?TUpsSjc3WnQwVGU3MWJkQm9MaXlSUXBWYWtjZTVzODE1YlpxRzExZm9h?=
 =?iso-2022-jp?B?RWxJMVhmdGQxMVh3M2xHZS9VZ3UxbkRBRlpyWjlCa3NIS1cwbHV0Zzho?=
 =?iso-2022-jp?B?MFFMdFhHMWhac3cvWXlPTkdCdlI1em5qa1pHZFVyYWJLMVUzMHFxSU1C?=
 =?iso-2022-jp?B?TERhZnVFRS85ZkhkUm1FTk5UTHo5ZnR6eGg4MEJ6eDdUTmh6MHJQcmxG?=
 =?iso-2022-jp?B?WHNUbnJRckVDL3gyZkQvbCtldXQxa1NUR3JiTEJzOWdnK2JXZisxWVFK?=
 =?iso-2022-jp?B?Z1BzU1lnL29hdmNtVXpzOVo1Z0hCTWtyajR3aWRySmhSUm5DeW9aYnJG?=
 =?iso-2022-jp?B?WnEzY1loWHNkTDlsVlNPem1ob2ZzcDBxYmdKUW9ybWozOFlTb3ZnZHU4?=
 =?iso-2022-jp?B?T1V5Rkd2ZHBGb0dkbzZDdkZybUluUHNwK1B3NjNNcWN3bURGUndnNy9L?=
 =?iso-2022-jp?B?R25IVDNPSGtMcjVRb2k5M0UyeHY5TmtpeUEwRUR3QUxtajZzS0xsUldz?=
 =?iso-2022-jp?B?ZHZid3ZxdFdYcyttSWtZUGNwaFRscHZmbWx1WUpGVzFVTDRmcFlIWmN0?=
 =?iso-2022-jp?B?REM0RGd4QnNPSXZxSTZKQWdOZjlkeklsRHVCOUJ3cVJVVTNPeXU0dGJS?=
 =?iso-2022-jp?B?Vm9wTkZTcWIwYlB1WnNhbFQzN3JvYTZNbG91NmZ2ZGVsNHFBeWJ3blFs?=
 =?iso-2022-jp?B?VDFGMlRlb0FQVy9GSnNLcmFnU2JlYWxXNmlPaHJpWTNkV0hucGNGTEFp?=
 =?iso-2022-jp?B?c21ub3RIMzRqZUZ1eUkzTis0TGVoZ1h5bjNpRC9Vc1YwQzZkTXNSMG1H?=
 =?iso-2022-jp?B?cVpDcEM4eFdVNWFtbSsvYnJndW5kajE2SjNMQS9rV0xiUGczR0J4a1pK?=
 =?iso-2022-jp?B?YXUycFBsOTIyNWQxMVpzZGpzS0p6WCt5Y0JPV0hQMGZDN0V6OFE5Sitt?=
 =?iso-2022-jp?B?VU44M2RnZVQ4UVF2TUp4ZkFuWkIwU3pjb0ZHOXNhVUpPRGFhOGgvUDd2?=
 =?iso-2022-jp?B?UFF1OUpmRmJhZ3BNekNCN3FzNlB4T1gvY2VKVDlHSnZxSndYUXh6OW83?=
 =?iso-2022-jp?B?TVExQWZnMHltNzBpclZCM3RUT0svL0xXSmdGbmxESnJSTG5CUUFVNkxp?=
 =?iso-2022-jp?B?dWhSL216L0pyMzFGRFkyRHZ0Ui9qbGR5WlN4OExiYzFLN0x5cFIxQ0tG?=
 =?iso-2022-jp?B?TnZaM2hROGMwcjB2M0VNRUVUVkk2MHVNdGVtZGdHd3pkTFl5YU1sR3NC?=
 =?iso-2022-jp?B?T0daZFd2cWRFS1pUcU9hZzAxNTJ5c3Q0TjlHNkx4aUxnbGVXdEExMmIv?=
 =?iso-2022-jp?B?aS9XQXc5cmN4ZUFaMkQ5RHZvVGVmcE1aUXhtYnVGWUE0QkZwK3laV21Y?=
 =?iso-2022-jp?B?VWZyOTRCWjdNK293SUF3Z1YrMW9haERTdHV3OEFxQzdIS1E5RVpFZWli?=
 =?iso-2022-jp?B?ZmJZdkMvQW0zNHlWemRqVENBSEorL0JENkdCSDlvV2R3YXEvVUlEaS9H?=
 =?iso-2022-jp?B?S21qR0l1VmtPOFpzRGhLWWNROXh6QWh4aEgzRlBVTWRvMzdkTzdlWjBB?=
 =?iso-2022-jp?B?dkdRalVyRlhpcFJ1aHo2bHZVZDI3bU5rVWptV0VuK3ZkcGtRWWpaVE42?=
 =?iso-2022-jp?B?QjJaVEhkelpzWGZoVGNWZjdiYTZPR2NtNURnVWhLV0NHQ3RsK3JxRDNS?=
 =?iso-2022-jp?B?Mk5YbTg0SlgwRnFzL3JsVmdvNGU5cU8wWDlySm1Ua1ZPZWErTko2clJY?=
 =?iso-2022-jp?B?Z053Y2FIdDAwZlVzUDVhNFRZTkJzSnZrUUtUUy9jaHdYYXRWM21kamJl?=
 =?iso-2022-jp?B?VUlhS2dCSEdRNEFIY2Z2a0JCaWVlYnlNUmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 25dcfa57-035d-4efe-8aca-08da58a04a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:51:09.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 yBDzyxxBODE6pXMqPTp6BDW77QxYh9F95gTbi8OGd0GGSZGIl1KIz1WRh22+4Mh/xzFXbeDun38K3lVZc9ny3wa6HryaF6Bp8rQSpoJTs2HMCAB6C2ZbwcXTsR9LRahm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5123
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:51:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8615

Hi,

CIP kernel team has released Linux kernel v4.19.249-cip76 and v5.10.125-cip=
10.
The linux-4.19.y-cip tree has been updated base version from v4.19.246 to v=
4.19.249,
and the linux-5.10.y-cip tree has been updated base version from v5.10.121 =
to v5.10.125.

You can get this release via the git tree at:

  v4.19.249-cip76:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      c293ac909598851c30308172c5f11a445c7c2d1f
    Fixed CVEs:
    - CVE-2022-32250: netfilter: nf_tables: disallow non-stateful expressio=
n in sets earlier
    - CVE-2022-1184: ext4: verify dir block before splitting it
    - CVE-2022-1966: netfilter: nf_tables: disallow non-stateful expression=
 in sets earlier
    - CVE-2022-32981: powerpc/32: Fix overread/overwrite of thread_struct v=
ia ptrace
    - CVE-2022-32296: tcp: increase source port perturb table to 2^16
    - CVE-2022-0812: xprtrdma: fix incorrect header size calculations
    added commits:
      CIP: Bump version suffix to -cip76 after merge from stable

  v5.10.125-cip10:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      93e5c28cd0bdd8a2d89059fe7218ce98dd7c81ce
    Fixed CVEs:
    - CVE-2022-32981: powerpc/32: Fix overread/overwrite of thread_struct v=
ia ptrace
    - CVE-2022-32296: tcp: increase source port perturb table to 2^16
    added commits:
      CIP: Bump version suffix to -cip10 after merge from stable

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


