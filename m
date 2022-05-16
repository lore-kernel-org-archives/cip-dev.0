Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB5C433EF
	for <webhook@archiver.kernel.org>; Mon, 16 May 2022 03:04:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.24425.1652670275911823894
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 May 2022 20:04:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24G34DlK018309;
 Mon, 16 May 2022 12:04:13 +0900
X-Iguazu-Qid: 34tKSRAkgFyBeDpWpq
X-Iguazu-QSIG: v=2; s=0; t=1652670252; q=34tKSRAkgFyBeDpWpq;
 m=BJ7rfvYwpk5Vt5G8vKY4v2VJxMvreRScKw/tTtrFj6k=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 24G349xm034161
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 May 2022 12:04:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfVOc0NPHDtyv49sf1YWwrCqEVT+MI/XiXTVCnwBjslrswuo5MWvGiAVNQ9/RWWzAjDkC/cXo4ks7VysyVYk+wRaT/Wv4o3k6zgaocHdWGvZow+PoetNZSYu1NPjkJvdWj3qpEhZdDO8GLpyNrCDTEF811H/8YrX5jcDGFdq5/wNj/FztS7sem75qV6X9GBQqb0h0BSFbNhwWYuYlVPHgPemMLBja9YauXbldVD2jM9zcFvMo9RxdiGSCQytVUZFbcFfuAjQbohbmEO8k34iha6Uy0iMZ+DJpyzs+wlpckyUV7dTg6VyWBIJnqYSqicEOT7PwnfPxFl4tsUh5uJdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b626nQqX7OqY5j0lw28FqMlsKi+Oryy7LsGu0vNwW8=;
 b=dQTuueNks9Z/JfoQORLP6IpLWB4Y3LhrpxmCpaejde2adzKu9+3lmvWLtRl+875CyoOEjVtOjesU1kiUqH5JczPRrvqZGPr7fuosAy9FaWnnBdCAWOun0wmTGUCv3I3DX5/Lp7XPt4KWNvShwo3/UkT/oX/qlr+yjL3IiUTRmUr49jEzZ7ZnI7UbAi1vAuSIQi1R2Jc5JL2UzHTH2n46qu5T3SQ0xYMMKyKOwhy08RZ43s9/NJSAva3TpIV1g700SLr7VjDxYyCNnHLQuD+kv8XIz9n41/li4RfVDlmk8k2GZnlSE7JJQ+WbuTqioeVfrAyuBlmhUtY3UGuDq3WBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.242-cip73 and v5.10.115-cip7
Thread-Topic: [ANNOUNCE] Release v4.19.242-cip73 and v5.10.115-cip7
Thread-Index: Adho0U8tZ2f+lDdaR6uBHnDGmXRlRw==
Date: Mon, 16 May 2022 03:04:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200D50FED0D11AF4F05DD792CF9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b546c38e-d140-4ba5-f99a-08da36e8bdd7
x-ms-traffictypediagnostic: OSZPR01MB7722:EE_
x-microsoft-antispam-prvs: 
 <OSZPR01MB772261EB5BE1326F92E7376892CF9@OSZPR01MB7722.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Kq2WlfI7WMXh9/izQmjMl5AMv3vOjh+k4SxRaIwW2H+WrHwKLbWxReuWxxIjRXEjLjxnfM/ujJSPBdqxCZTX1FjuB3Ci4dk4jWLT0sQIkiJsd3oRu/FIW0qpRZ40FAh8aN1rBVo1L+8BdtEVcYdVmcZtK3dl/Ps/54/55MHYF1g9zH4+r3gaoo0jRDXcZ7rMJfOkJoNIUNqEtCsZToGNKKPHOFLBO5dIJOhQu49YzYeGl0yOSN3BoZJmMfw0L7mhhJ6yXM98+lWpg+Ic3bxTHTuezgRUst108YymMsi7c7Vekrxmra8gBt/68FerCh0m5XGdSLPMd79c5w3be28//OZxCc5diQXz38SP8P6w76UqnLlebP9ajGgTYN+dlBswvfxYpI3yxIlfgdf8rvkkoV5SPLhDe19NwrcN9W6umJSJp+03chUb/6Gg0NwvVj6deKPj5HyCWepdfy90WYCQzNyp4E1/7oI3igZqLLWDeIhaqAyz+WP7HsvCGMioyIEpC0mOGvjVTENJbcGciMrbACBCPNQQpfML8JNxys+27YKxBGA2apQoRSgqKH8LzM8Cqnw5xutQ6GAHAMxVpIQcR6G50T9wbxXyKru59LVKFJnmfdx0jPXcNGZcaacIi+o0HKmkosNhcjZBGk8nQJ1SdnKofX332nDn48yVQ7uKN9SE1nbkawkXwmkCmYgPAs8oBy12PzVH8N1xFSFnWkTcpnprakEIAg1zAu+NvZ/2TX7EpmXy9kGmuiURRIJv4Y5aEWvtyZXUjyAcgkQc++E9J1h8nWio6pRDil5GxwiiWBU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(55236004)(33656002)(2906002)(38100700002)(64756008)(66476007)(76116006)(8676002)(66946007)(4326008)(66556008)(186003)(83380400001)(966005)(122000001)(54906003)(66446008)(86362001)(5660300002)(7696005)(8936002)(52536014)(9686003)(26005)(508600001)(55016003)(6916009)(38070700005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q29vT201U0h4bWFRUTMvQ3RPcVFtcTZ3ODdwQkdrakgzbE55ejU4ZGxI?=
 =?iso-2022-jp?B?RDRPZDI5eW5DZ0RleTlSWmM2dVgxOHE4MFluL0p0djE1ZStEU1lxQmNO?=
 =?iso-2022-jp?B?UlV5R3dUWkxFbElGYkdEUE5INldkcVJZQzZvb3o3OEx1SEh4Z2daSzFJ?=
 =?iso-2022-jp?B?bG5rRWI0T0dadnUwbUJsbkJhN0V6MWY4MmVCd0dVWjRJV2Y2bmZPSXYr?=
 =?iso-2022-jp?B?QWttQzFIKzM0eCszcUc3OC9MUGhhMG1ETTFhT0pTUnBjb1BtL3A4dFBa?=
 =?iso-2022-jp?B?MlhNQVFHclMvL2x0TzJWTEJYdzNqMUl1U2R6cjlYUmNiMFBZOWlkYXM0?=
 =?iso-2022-jp?B?Y0lrT2twRXdaL0M0aEkwaldQZTkvVXViWVNsL1h0MWUrSGNWVWx0b1dy?=
 =?iso-2022-jp?B?b0NtL3NFczZnSTN2MkRjZ2NlNXpGWlZsejN1Uit4d1RuVTNFc1RUQWpY?=
 =?iso-2022-jp?B?akd5ZnJqTWxqbU5FZTRybEIwTXVpZGxTRkRCWDgvOHhUc0JjOGVuY0Mx?=
 =?iso-2022-jp?B?S1RGdVBmZEFjeDB3Nm5UU0pubTBGTXllTnErZHdUNVRjY01kRTlZL3BU?=
 =?iso-2022-jp?B?V2RmbmlIdXJ4eGt6MC9EMk5SRjhCenk4dDFsY1BBSEZvUGorOVZPRThU?=
 =?iso-2022-jp?B?cURieUVvUlpLM3dhZjFqVVVLZno1ZnMzYlFtWXRSeERLY1B1M3FvSUpK?=
 =?iso-2022-jp?B?Z2lPT1BJOC9FRGxWK2pwWmw3MkdoR2dnL05GY2p6aS9SMGNoVDIyOEpV?=
 =?iso-2022-jp?B?aEhNNU94MmlCOUNMRC9udUdlVWVnRXR4M1BSMW9CVGMwZzBjV2EyYWdM?=
 =?iso-2022-jp?B?RnhUZndia2hONGFmYWRFYU84VjV0Q1lqSExxcFVjdUNoNmlpbkdkTTZ5?=
 =?iso-2022-jp?B?d2puV0Z4OTc5c1dITG1CN0cwdWswdk1wWDJjY2NwMllweW9KREY0WWgz?=
 =?iso-2022-jp?B?N0hxenVWTVRkbDBQWERjSlhmTnlUTFlCc2l5clhoQ2VWenVnSnJJMVVa?=
 =?iso-2022-jp?B?aHpQNGF4MC9sQitOWGVDcGVEek5xMDlBUHBuaE14NENEVjhUZHV4dS95?=
 =?iso-2022-jp?B?S3Uzdm91RWRSaTh1ZG9aaFZ1R2hnOWdObndoenljU3dwUWg0TE94SWNV?=
 =?iso-2022-jp?B?OU5qWllUZks3RVYwaHhGYzVYTUZkMGtOazZ6YmZoQXV1a1Q4bUU0dDBn?=
 =?iso-2022-jp?B?cHp3TElDMXBtZ21DbXNJMEkxZXRZeUF6aVA4NHp6em01WW9GZzlnL2NK?=
 =?iso-2022-jp?B?NVU1dFlXdmkwRlJOK3k5WHdnRDFLUUk4MTc2MzJlRFdKNFFnbUROaWZi?=
 =?iso-2022-jp?B?UXBvS1EwOSt0V2dFbkM5djN3eTJkaTBJaWRGR09LWmRLZklpZXhhOTF0?=
 =?iso-2022-jp?B?dFdmL01XRDlZNWhBK3JGVzh1MzRHalNXWWsrZFdDSWhEWVUyNEFYY09W?=
 =?iso-2022-jp?B?K0VrSjR6N2t3alUrckZ6M0wvZ2JudTlpRFFFcGlma1lYSnZ4Rks3alVI?=
 =?iso-2022-jp?B?YUkrY2duZEdtQ0ZodnV4YndaVE15L1crY2N4UWFPZUtwbTN1ZjJYNzJp?=
 =?iso-2022-jp?B?dUR1TG5kTHV0SVJHZ0RJUDVoTXBpVFZDWVJPTEpVUlFBUnZ1b2wrcnhq?=
 =?iso-2022-jp?B?K25ncU05UTNpZDh6aWQ2c0hUeDdRdVZKTnI3dC9zRFV5UE55UFo1Q2Q2?=
 =?iso-2022-jp?B?L0tMZS82aFYweDluMFA2MkpvLzA3SDJDeXNVaElobEJJRE5lcFU1NjdK?=
 =?iso-2022-jp?B?Y01UUXl2R0pHOW1UK1FBR1pTN2xCd09vSmplcEozQ201aXpqWVl3UDZT?=
 =?iso-2022-jp?B?WDAva29KcUVUOXl3UGFJMzZ5K2JudFFBL2pOTWNUOXFTNXFHZ1JjV1BS?=
 =?iso-2022-jp?B?MnY0VHJvWENTeHBZczJwMzBzaFJYRi84TDU3dE1hQ2NMVlhxMjFDbXZP?=
 =?iso-2022-jp?B?clRycmlaU2ZSdGovZXBIL3NRQUhkd0FxdVR1UHhCNkFiL0Q0VVJjMGty?=
 =?iso-2022-jp?B?eTV3RDJ5NzB6YnByTmhGMnpjVTY5THdQTHZmV2dOdzdkc3VaYkxoTnpo?=
 =?iso-2022-jp?B?aW9tMnpmUC9vNUZ0elVpSU4zb09DN29zWlpGWXJ6djJHN3NoQmZGSGMr?=
 =?iso-2022-jp?B?cks4QWZSV1NYS0pXZUV3T1l5djNvWWl5MUR2MHMraHVzN3FJa1VjY0tl?=
 =?iso-2022-jp?B?bU1uM1ZESkdXOEdYV3pVZDZxMUxDZzdzaWd0Rnl0MUpnVmFHQ0NQYnVX?=
 =?iso-2022-jp?B?N2F6UEY5M0dnVndEVXcxaERQenVxR2hUUUhPcE1ncDAzcTZRaFAyQ213?=
 =?iso-2022-jp?B?dUJibngzT3NvZDU5WXZOZ05FSTRVbkYxcWVGMEQ1Y2JXdUlzcHFHa0J1?=
 =?iso-2022-jp?B?NEVmMXRTMlVzUkV5U1Vmd0c5KzZ5cU41MVNzSmVHcTc3WWMvVm9tOXpU?=
 =?iso-2022-jp?B?TkpMNkZqdEt6MGM1UUY0TkdJWFJPa3kzUSsra1VYVnZkNytGL3lSa0RL?=
 =?iso-2022-jp?B?TEEyTGZ6SkVkTGFKTUxha1hteVk4NjRQaENYY3FUblJsY2RIQjJ2WVdP?=
 =?iso-2022-jp?B?RG1vMVpZQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b546c38e-d140-4ba5-f99a-08da36e8bdd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 03:04:07.1394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 tzBTuGIYRkyXKmdqq0yW+/V5iDZMp7hYug/8ji9mkBOhkknRqXhNogOHViaNx33W3/XD4zHpYSq85KSXvLsGuRUsVFZPaPlViz0G4oIJSjaG+FF3+qnyHYcyLZ6TCRRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7722
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 May 2022 03:04:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8358

Hi all,

CIP kernel team has released Linux kernel v4.19.242-cip73 and v5.10.115-cip=
7.
The linux-4.19.y-cip tree has been updated LTS version from v4.19.239 to v4=
.19.242,
and the linux-5.10.y-cip tree has been updated LTS version fromv5.10.112 to=
 v5.10.115.

You can get this release via the git tree at:

  v4.19.242-cip73:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      2089dd696fb566d318492ccd08834345f8a36616
    Fixed CVEs:
      CVE-2022-1204: ax25: Fix refcount leaks caused by ax25_cb_del()
      CVE-2022-1205: ax25: Fix NULL pointer dereferences in ax25 timers
      CVE-2022-28388: can: usb_8dev: usb_8dev_start_xmit(): fix double dev_=
kfree_skb() in error path
      CVE-2022-1419: drm/vgem: Close use-after-free race in vgem_gem_create
    added commits:
      CIP: Bump version suffix to -cip73 after merge from stable

  v5.10.115-cip7:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      ebb2aaa515dbedc3b4f12e2ffb44c8ed4eef46bc
    added commits:
      CIP: Bump version suffix to -cip7 after merge from stable

Best regards,
   Nobuhiro


