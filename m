Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6380C4332F
	for <webhook@archiver.kernel.org>; Fri, 14 Oct 2022 22:29:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.13627.1665786567924372794
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Oct 2022 15:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 29EMT2hr017945; Sat, 15 Oct 2022 07:29:02 +0900
X-Iguazu-Qid: 2wHHOH6CCoHRCfYnfF
X-Iguazu-QSIG: v=2; s=0; t=1665786542; q=2wHHOH6CCoHRCfYnfF; m=aJOm7LR49n5qmQCn9X/B5/EKHE/Tl6UlY6KHADNZ7lY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 29EMSwaA040570
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 15 Oct 2022 07:28:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3vz2QqX6mC+WCHts7Q7INMxJuW/y4PfcYAEnDt4JhsXN5bBgyfClc7Sptn5lTkOmofPCvyxQazorsy5pg6n0qUCsjCJdzWSMxz5NWKx81GnuHjS7rF0/45nSNeKOmaXv5rIABgsSZ5B20WmJMpVFBZs54I+tP+ht6WXmjMvRUAZAlKfvkhqEWpVEqRZsERVCNHxK+o0Cp69MWvmwMMwO62rYKgnmk0QyzyvQGu+5BbDr42HxhviRbxFtYuHV8cO8PiEwgn9UWfRFr+GEXU/QH8Ysa95Yt2mx19jQYedfs1PDmHw2LRizBwJhX8baO6YyMwq5KoWhRIol/1ooOXwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55eNUEQvTAgdKCqdrn7aMydXiCE4NwprGYcM7I2GpuI=;
 b=LQaqCDz6q+GG2wynJarkVGJ1xondM2vyS6k2aiYiMqpTNjeKwnBngoZ3qubfWafyb2ZEmPb8k25+6Dw6HZOXSwwI7eXi4gOcG3NpKMBJeswaLIvzI5NTWJ6huZ0HY0HW6zadgrZAF8LjybKT8tJ/N4kyNykp7bKPX4KIPp1hNz3qMqgQwRluCMLLTjipyp+EqOtVtmOo3SQFxPjSl+/L7+4CFafu+njb1P6sk/n/UfFg5zsqidxGaK/AVVSRd+9XI9pvmDvoS2eH0YsS8qI1xv4Bkb/eSP0xdXmi9fUnuWXU7UjSiJQR2W6MqRkzeJAChnE4YLSvbDE91W9qdTVu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.261-cip83 and v5.10.147-cip18
Thread-Topic: [ANNOUNCE] Release v4.19.261-cip83 and v5.10.147-cip18
Thread-Index: AdjgHABDV343IeBsREWVIUCihmChrg==
Date: Fri, 14 Oct 2022 22:28:56 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94204E2856B049BB2E108A4392249@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB8815:EE_
x-ms-office365-filtering-correlation-id: 25bee173-2f95-43a4-02f9-08daae337b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJM6XpXSdrI10jFdxQG38yVEZyKE1kY6K1tbynLmdj2e5CAeQ4A9IKKvet+xDBmq2yWrkOyuWi27tVV34UIfON+h/QQ+q14+RNqOW4peJxXBjCwnbLjg8B2gLVr3au9NScZ206aPOz0EzmMeMoLKTK9v5fYumF5583SXCm0+UnMBd/pAoYDoKNEWqd9sSgVH4UhjEGQwW3WL8YmXLPmti7tr2zxSm40rHTycOtHM/kI1nVd6Zm8mYxaSeD7umQieDqUzSnJKFjWLcrPNrU+OWUQYdqzSelkB7ZId0iOwzvgMUuM/lGJtTPsFheWwDGtBNtGAoai2pV+Foe7YgwXs7m4LhCrJ/EM+fsZ/bCHU6tN4HUiMOQfA4ZHVci4MiY9S6domG81OEdcEcjT9KkYs6Kd4Ig0V8OHJaWG6g8hmYkE0JCJUKkDR3vevZIaozSbVvzJlyg64sorfQ7n7tUE2Qn2Nd088yRU7RZ0kDCxE0XTXIlOobvl0rMWP7vPTFsyrJJkFacl7frLf2pbzMM5wblDzBZzYvm3rAzjcqyN+jGvDhMp+jepaHJ0nk4gZdn5LKTNx8shDTgd/HJGcyEksyXHfHPJZntD7WZ6fUrxZ++oBGkngAliN1ePcjQaUoOW81sV6rYheP9Zf549beE6oBgOWvpVaMEJiPmxev6DZA9PVx1a5t5pbnW6VdWxYwXxGwAsQaJAEI34IC2Q4EfGCwRniaxi6iJ1njhWoS+GZYrWAo3Y8m250Xh444HmPzC9itG+4fPo1pbPOiofWdA387th6f4ukjvIj3+i+uni65aY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(9686003)(6506007)(7696005)(26005)(55236004)(83380400001)(2906002)(5660300002)(186003)(55016003)(54906003)(6916009)(316002)(966005)(71200400001)(478600001)(41300700001)(8936002)(52536014)(8676002)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(64756008)(86362001)(33656002)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bWNkenBVSmFMcFRUczBrb2w5OWc2WVQ3N0RWdktTRU5XMFBYQ2FaRWZW?=
 =?iso-2022-jp?B?d2wwYWtFWEoyc3lnUmhiZkhNWVVVcTF4UDJ3Ky85V3RIWFZGTkhMMld3?=
 =?iso-2022-jp?B?RTlidXpzUXd0MGdEZUJEYi9MdERtYXhuUm1PMmlsWUdZZjVqdjFCL0ZX?=
 =?iso-2022-jp?B?aUt1QnZuOWh2TkJ6NmpLT0NFU0FidW5qeDJtY2N0dTVOd29Zb0ZHM1lp?=
 =?iso-2022-jp?B?aC9zOWd0QWhrRVFKV1hacnliM1V4d0NDZEJCZ2xWUVd3d1dEWUlXTnM5?=
 =?iso-2022-jp?B?UmRjWmxtME1oMlBHRDlzM3NRWFdsTnpsNytLYjNKWURGMHJtVEJ1TDh4?=
 =?iso-2022-jp?B?QWJGWDJqVjh5UnVqNFZLQkduUDJPTG1ZQkV2UFRYa3pZZFB5ejVjc3hD?=
 =?iso-2022-jp?B?UW1ETk5nUVgrc3VzUk5PS3VHdnVaUEN2VUNScDRTdXErb3NFT1BBd1JE?=
 =?iso-2022-jp?B?SkJIUEo3SWt4aDVjcEpyM2dyLzcwN0Q2cE1Pc1pCVTI3UURCcTJaTndt?=
 =?iso-2022-jp?B?NkhUR2lRSHh4TEpLSjUrN1pWTVo4amRUNDZ0ZVUxUjJtNkZsdkNBMTUw?=
 =?iso-2022-jp?B?RFd4VFZwbmhNdHAyVGJJTkZwaERnS1VVMnNSbmJaT3dWL0dYejBKWnpm?=
 =?iso-2022-jp?B?SHM3eEQ1b25kMzhiaHgrQTF1U2krbEVsR1Rsakp1d0JWZmFyTVpMM3hv?=
 =?iso-2022-jp?B?bkhydnVubkJ5L3dUY0VIbDNuU3JsNDhHclBFVmxwOHA4eU95d2FjZnhw?=
 =?iso-2022-jp?B?MXQ3U0FyVHgvblV6SXRMYmxhQnFzUXJSRy9ZN3h1RHhUOVpXZmhzeUhi?=
 =?iso-2022-jp?B?eEZVVHNIWjNselRNYmdPWXVDUmpFT2xMVkN3cXd1VFNFZVFCTFZwVDkx?=
 =?iso-2022-jp?B?TlZoSVVSQmVMZlMvelBwL080QVN5VXpEVjVaa2pIcGkrVXpSREVWZVlX?=
 =?iso-2022-jp?B?Q0VsTlVLYUR6blprR2Z1ZXI5N0tnSjVEd3lxa09ySnl6YzlMWWdqMXlp?=
 =?iso-2022-jp?B?aVR2cmkraWYxbmg2NDlBTW9BSHBlY0dDY2NxTFBNbjM0RkNnY2p3NVNx?=
 =?iso-2022-jp?B?MkRvbjlxSGFSMWphcHZXMU81MFM4aHBhZDJCWkR5cnhrZENKODVoUnhP?=
 =?iso-2022-jp?B?T1lNZTV3NTZLaXJGVkNITldCbnJYcGVVcklsRlpGbE9VOUlBWDEwa2xx?=
 =?iso-2022-jp?B?NXkwME5ZdElBalQwY2dERFJ3SkV6Zm0zcDlYRGY1ZlhCNzhwL1F5MHRh?=
 =?iso-2022-jp?B?ZFcxV1pXOUl0dXVxWStpREJtY3l3T215NmllMCszeE5tNitXaDFjejNV?=
 =?iso-2022-jp?B?LzArQmxzM0o2Zkt4eXRjNElqMlBuSWdmY3o1VUF5L1hjNkpjeU1HWVFr?=
 =?iso-2022-jp?B?cFk3UlJObnJZdW5YTThFd1BNOXQ1NWNkNXZ0RnFoZGJiWWFLNCtXKzg0?=
 =?iso-2022-jp?B?V2F4czBXYlNEYlFxcnluelI4bjZ2V0czZkVaNWNlbkdWNlRDRGhZZDRn?=
 =?iso-2022-jp?B?WE9TVUNJczhWbXU3elhjUzd6cGQ1U2EySS9CM0lSaXBtcWNwYVltTkFV?=
 =?iso-2022-jp?B?Z01URDk0ZzVKRjFBNkJWZmNaUlFqNS93ZzNIZDNWVnd6MFNJS3B4OUVw?=
 =?iso-2022-jp?B?bHY2STBUM3RxRUUra3J1SDUwWDVsRW5zYk5USFpjb2N2QmVUTmpId010?=
 =?iso-2022-jp?B?REt0OUY5NlF6R1RZS0lBdy9LLzJEemo3Sk51TjYrY2hXMXF1djlQZzFB?=
 =?iso-2022-jp?B?M21OcysvZ2tFOGlPaUtTdzczOVEzTGdTQVhycnAvUWtrc3loakVZZXFK?=
 =?iso-2022-jp?B?ZGk2MkJFOXM0RldsVlpQRlBnMkNuZEJQTWEwd3FIdE04b1cyY2lQbVZr?=
 =?iso-2022-jp?B?NEhVNktyOTd5UEpVZTdkUlpVckRZbWpvcGM1WVp4d3pDZVhIZXgzVGM2?=
 =?iso-2022-jp?B?YWh0bW9RZDZNWkFWdWcvdGowZDJNbTRuSmcyMHI3YlhLUm1JWGtkdDE4?=
 =?iso-2022-jp?B?QlhyVFpaeEJnNjhxNUthVDFIdjJlY2VWdm1oWlN3OEFKbXBHaXJFSUV0?=
 =?iso-2022-jp?B?QmhZVXh6QnVHdExRY3pyRlZMMmEzR0F3TGNmb2RCdGZMaS9TUC9LTnZX?=
 =?iso-2022-jp?B?bTVSUlRQYkRwZkZxaFcxaUZ1czRYbjZoV1crYU9YZTdUd092ZkFwMi9B?=
 =?iso-2022-jp?B?c210eG9FeGVQWnNESkQ4bkg1ZWpMdndXNFBhZ3BHRlJHdDYzakU4WFRS?=
 =?iso-2022-jp?B?VE05SzF2YWwwSU5Ydm5aajF5RHVaQ04xM2FwL0RXNlgxZ2FnWHh6YVFF?=
 =?iso-2022-jp?B?dFI2dGtaWnVIajJmMFk0V21nUXFoOFBnZ2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bee173-2f95-43a4-02f9-08daae337b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 22:28:56.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ox+ohRt5uZcsDkcYGoZWzRbgWT3vZtkxOctF0xxIHzpt6y1IXz+DwwPYDoIQPOJ6dWx1qc/EqDyigHxRXt/MqXiMBsc35A6xLDfj5NaWD4Iyunj8ir9/TaQdDQ/QZisB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8815
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Oct 2022 22:29:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9765

Hi,

CIP kernel team has released Linux kernel v4.19.261-cip83 and v5.10.147-cip=
18.
The linux-4.19.y-cip tree has been updated base version from v4.19.259 to v=
4.19.261,
and the linux-5.10.y-cip tree has been updated base version from v5.10.145 =
to v5.10.147.

You can get this release via the git tree at:

  v4.19.261-cip83:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      34b3125bdd71113063c74c32f4ecfbbb122dff57
    Fixed CVEs:
      CVE-2022-39842: video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa=
3xx_gcu_write
    added commits:
      CIP: Bump version suffix to -cip83 after merge from stable

  v5.10.147-cip18:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      ef9425de71e3d6cd46470415b2648f2244057840
    Fixed CVEs:
      CVE-2022-0171: KVM: SEV: add cache flush to solve SEV cache incoheren=
cy issues
      CVE-2021-4037: xfs: fix up non-directory creation in SGID directories
    added commits:
      CIP: Bump version suffix to -cip18 after merge from stable
      ASoC: sh: rz-ssi: Improve error handling in rz_ssi_probe() error path

Best regards,
   Nobuhiro



