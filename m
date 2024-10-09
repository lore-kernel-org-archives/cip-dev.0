Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C0CEDDA3
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 23:29:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.31555.1728516546052110033
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 16:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=F4jeoaf+;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1728516524;x=1729726124;bh=6C
	iRKvNO+iWZGW/EK9aQ9OksdOygv0MTDKxL7+U3kvU=;b=F4jeoaf+nfnj6w68wLHa4FoJCQPElwiR
	2bPMZgQuelSZOScX3xVbPnIXWf1tbX5j+tBckKd0eQZdBXW2r8K/vwPvodZHM1qocZdAChAY2J07u
	WxuzavyUXlziCMsykqBCRpatgTD3tmt/Z+ViY8TCijrGfMR6aZtV/34K1+ot3Yei1fBvnbyZJaLZD
	qSpPdKVgBefOLv+0Zaku0OtNJw8Nv+CGq/vZQbsa8+HT6LRteIYIsbZJQFYrssVFPhsrHHW5UI0ga
	uX9e2Znib5u08G47EhlO+wlg0tbIPkkHVjpF6CIKSJo1USi77sEp6aMa0onVAG/uoNaZ8ezD+Rlm5
	jQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 499NSg562595522; Thu, 10 Oct 2024 08:28:42 +0900
X-Iguazu-Qid: 2rWg67yesnDDfUUbab
X-Iguazu-QSIG: v=2; s=0; t=1728516521; q=2rWg67yesnDDfUUbab; m=Xjn+cz+Eeq6+wAafmGBCyMHUiDVlvwnLwcEVUYJrZhk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 499NScvA176331
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 08:28:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgywj49mAfJCQRxfFwowP2ZBnuqjJqnTlfwg16zaMn1CDwpNI7u7Yk5ICa73XQas568PGFuZEXBOw9/yC5AJM/xs0ZCpYANVIpTplod/+HGF9XU+b9uFkjfAdg7wp8/qLTOiM8ZPt2DeHtl5jdt32a6LJzlSca426QNOHskl8YWFFZaCorZxPwrB1MjXZ2Q4FTIabV4eydKm30pU/pLFPDv6ckURenddCjp24mSwLNQn9J4+bIKGuyIYnoDKvDiMCYn59H+gO72bMor+pMpDe5SbcrJbO6i2w6YTIUpIdIpptAkqflfTJ6HnqQWECcOEFJzYK+S3GILpV8dtHfBJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWkvQy9B4U/lNp7OSUdmNPp58GN3JiL8mfLvbUh5/J8=;
 b=xV3/y/R7yhyI7SGHILRop9FgDurc5n6EO8GIKVaU9eUQcleeORDLZ9toWv3ntk+W8ztkEiESZgv9wr1sYaJewune4gtBUiF2/6Wmsd0bC9nhgdC/Ifwvt4/xo3qflf4oEAiPCD91qj28dKtcNRdtNefQgOdcq4+rsRYPXie2szqlcFG7nKbYJMdA1cSOQ7imZBVNNvoXR2hZJF04o3NYyKzDU2bW/o2bZ1CuY8MpkFZgREMS5TVq1CEt3F2ivEaB3s4I+aJuXdHFELBRSprvs8LPg7XN87NEBuaajbHFWt9lIHAT91r5LV1Xj/9nju5fqXZRNsZdAgBMPj+E5xok8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <pavel@denx.de>
Subject: [ANNOUNCE] Release v5.10.226-cip53
Thread-Topic: [ANNOUNCE] Release v5.10.226-cip53
Thread-Index: Adsaor+61xE3HnjOSF+xhNW+Plcu5Q==
Date: Wed, 9 Oct 2024 23:28:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F21E050E5DF0E466881B927F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB9602:EE_
x-ms-office365-filtering-correlation-id: 8f3184fa-8d73-48b2-13ef-08dce8ba190e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SGV5MnVWaEZ4S2hlaWx6dTJHcnVvTXlaNnFzaFlpbDNvT2NWS1V1VEdQ?=
 =?iso-2022-jp?B?eGpka2IxN0pHMGlueXhmdSt5b25iNkF0Y1RFaitSVGwveUZZbnJNc0tw?=
 =?iso-2022-jp?B?SmRLWWlNa2gyRitKT3UrOTM5d0taM2IxSkdRZi95Z2hxODhoKzNYU1h5?=
 =?iso-2022-jp?B?c280cHhLc0RaUkg5Q0RYcVY0QXEwUlFpQmswZ3NiMXlmM1ZFS3VFOS9w?=
 =?iso-2022-jp?B?Q29iQkhTU3RSMmxLRXJpa1RNaEpBNFhzcUJQeVIwNEdkNk9KbFdtblUw?=
 =?iso-2022-jp?B?TUdWQm1IRGo4ZzFnQmhiQUxyQVc3NVFOUnBlSWVvazhzaDBKRUFJM0dJ?=
 =?iso-2022-jp?B?QkdQWUR4MFEvYnp4QURqVDdaMU9OYnRNaHVpTmhWNTR0dHdmdW5jcytI?=
 =?iso-2022-jp?B?L2JYUWFYMVd3N1NoRmFGZVJEdVVGVmhUV2Q2TVB0YXlqUEJoaEZxeXc4?=
 =?iso-2022-jp?B?N1dZTGVsSXpjYzNLS1B5blBUQmlzNVBWZFphRFZQd1NYVlFxN2podVJ0?=
 =?iso-2022-jp?B?QUhOcDN3N21yTmJtMTNEa3BKUkhnZ0hUc21GRlJaQk1EUDVPdlp4YkJr?=
 =?iso-2022-jp?B?MGZTUVZmazNnZ1VjWVkwQUczd0xKamVWc0ZleElCNFYyOCt4SjZkYmF4?=
 =?iso-2022-jp?B?QzYvc1RYY25KVi9VSWN2TVFKcTNLeGt2WXhjd2NxUTExcllCc29wS1ll?=
 =?iso-2022-jp?B?azg3TzhOVDFMSm9zSWVxaWJVekdGNE4rS3hrRDFOa1dDR1B1S05ZeFEw?=
 =?iso-2022-jp?B?aEh6MVRneTR4VW1LRUo1cEp0UG9lSm80MVFudUlZT0xKTElXV1o2RTJL?=
 =?iso-2022-jp?B?alBaT0gxUXBwRWU3ME5ONEdOaGR4OTQ2RWkrZzhzdnZOelZCY0oxcFNi?=
 =?iso-2022-jp?B?Y1BXWnJmY052ekUyRlhvSFZhL1FCU3AzM2J3enhPNTZWc243a3RIWnVH?=
 =?iso-2022-jp?B?Wm9QalMwUEllays1ajdZQzR3N2NVMzMyNFpjMW5jRUUyL1M5TFhPbXNH?=
 =?iso-2022-jp?B?RHlXQzVSckxWKzVibERUb25EWFBBekk0dTNrM29zbi83WnRXUHRXRGpq?=
 =?iso-2022-jp?B?UGplN3FDYmZNTENDcFE4RkU2NW11OFJ0U3NCellEM0Fwb2phMEpQajZr?=
 =?iso-2022-jp?B?dWg2MHBCSG9YZHo5SzhUUUdKa2dNcXVFWmxxbFJ1YzY1eUhqdmpBRkRm?=
 =?iso-2022-jp?B?K1Y1eTRKTnhjVDdmcVN4VldJQ283S1RWYkVPT3gwYmE4WWx6ZTJpWmF1?=
 =?iso-2022-jp?B?TVhvOHRUcEhoSVNuN2kvZlRsWlhRZEUrSllPZTFhYVBzQi9sYnpXUHRF?=
 =?iso-2022-jp?B?RVhiQytXWDRLaExqNVVWYU1wR2p0Wk42eHc5Tnd6N0JvcTMxNGwrdGxs?=
 =?iso-2022-jp?B?TXVtcVpWeU8zUFQvZkd1eElXTC9wcS9QQzBOR01PM1h1QjIzS000Zm5j?=
 =?iso-2022-jp?B?RGUrNXBQWDVobnlwR1h3dmtDVm8zbXRyQkM5cWhrTjNqcllwRFNNY3pq?=
 =?iso-2022-jp?B?WUtEYUNDMW1uTmJ5dDFqQXQzUGxHMklJZjBhTjFjWGM2NzUxRHJEdFBr?=
 =?iso-2022-jp?B?S1haVXpxRm8vWW1jWVhac0NieStHN2FjUVdBSTBsL21RSkZsT2dqSDln?=
 =?iso-2022-jp?B?TzZrSWw2ZU9rRVN3eHg0Rk5UNzBDWVNmRzk0SnAzVmR6dzczQXE4R08x?=
 =?iso-2022-jp?B?MCttd2I1eHlKb1VIYnhCempNa1Joc2RvQ0tiMXlPblc2bmp3M3JUVmhE?=
 =?iso-2022-jp?B?dGw5cEk3T0huYTZFRmpTWUpxOEVIL2NmMnNCL2ljakZVNFoyN0Z2SmRU?=
 =?iso-2022-jp?B?aFp6UkpNV2M0Z0NqUjNmNEljM25yKzdEODlva0ZyeGRLb0FxU2xMbEpn?=
 =?iso-2022-jp?B?eGl6alMvVFNMd1JZQ0tGYVI0TXFSZ1VMNVp4dThVYTgvVGNkMDhDTGtT?=
 =?iso-2022-jp?B?bDZYTUJxZ1JZNDFCWHE1YmhKS2JlOXM5REdubUZsYXl5b2ZLeUpVSFE3?=
 =?iso-2022-jp?B?Yz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QXNJcytZMDZIcUNrZmVINWpTVzN0NmNPS2M0UjRiRDFlYmk3Z1ZteUxy?=
 =?iso-2022-jp?B?eGlFS1paY0EzQmlWM09mVjFzZW92SjF4T1lFcW1OaStteHdXMGthL243?=
 =?iso-2022-jp?B?aFdKVzQwV1VWQ1BBYzkvRUFNWHo2bGphd3ZoRm5IdnBaMnZBSk5LUUt3?=
 =?iso-2022-jp?B?ai9DdFJXVVFmQTR0NGpMK1orYTUyV3JYTFFuazNxcHplZ1FEekpLZzRR?=
 =?iso-2022-jp?B?ZUxTWGNKMWRvRXNTK2xxUDNhWjlDWFFwU1l0WlhhOGdNRHBWcVM3dmta?=
 =?iso-2022-jp?B?aXZnYmVWOWVpZEtRcmVjS1d3WU9PUHppNktERGpCZHlEQXVYb3NacTFz?=
 =?iso-2022-jp?B?RTliaHBJL0t5R3JNVU4yVUZCeEFJRlpKQVRuNVU5UWdNb1RtQnhobDNZ?=
 =?iso-2022-jp?B?b2hOcHFxZ3dMMWZRSTNDUTNuSWMwY3hsSlgxUmxreE95cXVVY0J5czkz?=
 =?iso-2022-jp?B?bTNTZmNNUnc2c25ETmxRTkZjYmF5L1lFZVpVSU8zT2Y3SlNkNW1OR2x5?=
 =?iso-2022-jp?B?QTdlWkR2TmFva1NVK2RtUkRIUGpxWUdmMG03bVF4YTBVQU1DYjgxYXFQ?=
 =?iso-2022-jp?B?SUpPTldIQUd0cGVsbVB5Qy8zTGN6ZVd4b0NHbkkwWk5GcXJpS1RqUFp3?=
 =?iso-2022-jp?B?MUE5TFZKMEhaaTVZbHJ3cVQrQ0Z0dWp5QlBKTitZVFVqMGtDd2lFb2N2?=
 =?iso-2022-jp?B?N29tL2xGMFlKUDQyYmhnMkpSM1JqRXdzb0RGbTNlWE1tSFZXb0dHZXEz?=
 =?iso-2022-jp?B?bWhLNjdFQlkveFBFeG5wRGZRUWIrWitYQnJJRkxSMHhvcGR1TjNzVi83?=
 =?iso-2022-jp?B?bGZqU21mcDFjVC9GODFGMHU3a2ZuYUwxZVA0TUppVjI3a0dFL0ZSRVp3?=
 =?iso-2022-jp?B?NEo4VWdMU2JDZUtsdnZHTHVyYVkzVXNmQ1hpUzRibHppcGVTTmF2bVN2?=
 =?iso-2022-jp?B?VDE4ZjcrcnRSV1NCV2Q5WHl4Z3ROZjZLYm5yR3IxV3dxVnkvTHlzNUEw?=
 =?iso-2022-jp?B?MytWUU5iNUhXbXlaV3FCVHVpdG0xWGVRc2hhcUFEbHd1M2UxY0orSS8v?=
 =?iso-2022-jp?B?WjVPVXY1RWJyUUU3K1NqVXQxSlNxK2dicEFnSjNOYWU4bGNWNlg3QTVu?=
 =?iso-2022-jp?B?cHhhdWVEM3pZSG9yQVgzeFloVURWQVB4VWFmZzlRTkx0Nks1UHhXejZl?=
 =?iso-2022-jp?B?eFdVaDcwd0xDSkJqZXdCazlzVjlKQmpoUWdibjJLUEF6c1dpdmNvT1ly?=
 =?iso-2022-jp?B?RWxWSE0vYytaUExYd2p1Tm96RForaUpneXV6amE3VFk2RWExMFNwMjZt?=
 =?iso-2022-jp?B?Sk5rYU1zdnJGZzY1WExYMGdRbUYwbDBmM2g5T0l6aDNSYnhyN1h2UHQ4?=
 =?iso-2022-jp?B?ZjZDYjBTa1pGemZPWncxM1RzWWxQakljWGxQLzgxOXdkR3JSL0NpbjdQ?=
 =?iso-2022-jp?B?WVFoU1FtSFRYeXovWVluejJ4bEhxZEdUc3ZLT3FEaGYyeUJsbnRrbUdR?=
 =?iso-2022-jp?B?QVZtQVdPVGduNWsrVWpKbFJmRFhxY2F0VHV6c0FSYkluZ3VUMVMxdkZu?=
 =?iso-2022-jp?B?U3pmV1pDTDlqcmp2b0NoQVZYWUNkVUxmdHhPTUJicC8wajVwdjduOGxn?=
 =?iso-2022-jp?B?T2FIdUI0UnFPSjdkUk9CM0dXd0hrM2htOFFrSEVKM05MV0lnVnlMRlpJ?=
 =?iso-2022-jp?B?eHFFRzVxYkpFbmdWd1BBL0xuYUdta1F0eXhhUzFuZU0waGtib3NxVWdZ?=
 =?iso-2022-jp?B?dmhXeldRcmVJbFNQUzRhZVBZWmpnMzlDS0VNZHltZ0Y2blFtUm5yQVZx?=
 =?iso-2022-jp?B?R1VBMmx4aWFHRW1hUDFQTTRkZVA4UmlDYmVCa0NNWWlXN3JUaFh2YWtP?=
 =?iso-2022-jp?B?dDdZTTEvbGdZVWtObHJLQ3lmNkU4dmhRaE1GRmw2WGk3V3ZvQ0NZdlg3?=
 =?iso-2022-jp?B?dFBJOVRrWTBrNWcyaHh0dzlzUEg3cEF2c2J6OThnWGJZN2haSFhiMVhk?=
 =?iso-2022-jp?B?a09zd1ZPaGsvYlB1ZGx4N0VoV0FOSmROQ0ZLZlp4Q0UvTlVRWGE2ZFpJ?=
 =?iso-2022-jp?B?cEJxU0dvUC9wVDRKQitMNTZIcEJxdDRYeUJMa05kOHVXMlZSV2tNODNZ?=
 =?iso-2022-jp?B?OVRNMHVnUjR5U2ZkS1d6NXM5RitSZVF6azV4RUNIR1JSeHg1d2hnV0FR?=
 =?iso-2022-jp?B?MDV5enNZWDRxUUNlQUNwRmZwSzZEa1hpUGRrbXh0eThucHZpcHduQjl1?=
 =?iso-2022-jp?B?QnNreEhDWVBoaHRTMW0vajZ1UzJYSUxISitpWXcxR3R5Mjl6MkUzb3Zw?=
 =?iso-2022-jp?B?a0N5QnpQWDJvQVp2Z0hwczVGRm1JR1c5S2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3184fa-8d73-48b2-13ef-08dce8ba190e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 23:28:36.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQtTNBrORBO8uxlVB6TPE6FfU9ps4jYh4gHs7gBruITf2dofbuxw9VhDZw7TC7WcwaCmb8TNes6FvoGUA0+2hlPpwSFGlYk0HPN9kAoX4QhnYvbDIOEv/gH23P02HYTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9602
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 23:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17021

Hi all,

CIP kernel team has released Linux kernel v5.10.226-cip53.
The linux-5.10.y-cip tree has been updated base version from v5.10.224 to
v5.10.226. And this release includes the clock, DU, and DTS patches for the
Renesas ARM64 SoC.

You can get this release via the git tree at:

  v5.10.226-cip53:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      d6d2e910ede61a28e3de9ccfd7e8bce9093b7c6d
    fixed CVEs:
      CVE-2021-3669: reading /proc/sysvipc/shm does not scale with large sh=
ared memory segment counts
      CVE-2022-48733: btrfs: fix use-after-free after failure to create a s=
napshot
      CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl
      CVE-2024-38577: rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer=
 overflow
      CVE-2024-41011: drm/amdkfd: don't allow mapping the MMIO HDP page wit=
h large pages
      CVE-2024-41098: ata: libata-core: Fix null pointer dereference on err=
or
      CVE-2024-42228: drm/amdgpu: Using uninitialized value *size when call=
ing amdgpu_vce_cs_reloc
      CVE-2024-42246: net, sunrpc: Remap EPERM in case of connection failur=
e in xs_tcp_setup_socket
      CVE-2024-43835: virtio_net: Fix napi_skb_cache_put warning
      CVE-2024-43853: cgroup/cpuset: Prevent UAF in proc_cpuset_show()
      CVE-2024-43854: block: initialize integrity buffer to zero before wri=
ting it to media
      CVE-2024-43884: Bluetooth: MGMT: Add error handling to pair_device()
      CVE-2024-43892: memcg: protect concurrent access to mem_cgroup_idr
      CVE-2024-43905: drm/amd/pm: Fix the null pointer dereference for vega=
10_hwmgr
      CVE-2024-44946: kcm: Serialise kcm_sendmsg() for the same socket.
      CVE-2024-44947: fuse: Initialize beyond-EOF page contents before sett=
ing uptodate
      CVE-2024-44974: mptcp: pm: avoid possible UaF when selecting endp
      CVE-2024-44987: ipv6: prevent UAF in ip6_send_skb()
      CVE-2024-44988: net: dsa: mv88e6xxx: Fix out-of-bound access
      CVE-2024-44989: bonding: fix xfrm real_dev null pointer dereference
      CVE-2024-44990: bonding: fix null pointer deref in bond_ipsec_offload=
_ok
      CVE-2024-44995: net: hns3: fix a deadlock problem when config TC duri=
ng resetting
      CVE-2024-44998: atm: idt77252: prevent use after free in dequeue_rx()
      CVE-2024-44999: gtp: pull network headers in gtp_dev_xmit()
      CVE-2024-45003: vfs: Don't evict inode under the inode lru traversing=
 context
      CVE-2024-45006: xhci: Fix Panther point NULL pointer deref at full-sp=
eed re-enumeration
      CVE-2024-45008: Input: MT - limit max slots
      CVE-2024-45016: netem: fix return value if duplicate enqueue fails
      CVE-2024-45018: netfilter: flowtable: initialise extack before use
      CVE-2024-45021: memcg_write_event_control(): fix a user-triggerable o=
ops
      CVE-2024-45025: fix bitmap corruption on close_range() with CLOSE_RAN=
GE_UNSHARE
      CVE-2024-45026: s390/dasd: fix error recovery leading to data corrupt=
ion on ESE devices
      CVE-2024-45028: mmc: mmc_test: Fix NULL dereference on allocation fai=
lure
      CVE-2024-46673: scsi: aacraid: Fix double-free on probe failure
      CVE-2024-46674: usb: dwc3: st: fix probed platform device ref count o=
n probe error path
      CVE-2024-46675: usb: dwc3: core: Prevent USB core invalid event buffe=
r address access
      CVE-2024-46676: nfc: pn533: Add poll mod list filling check
      CVE-2024-46677: gtp: fix a potential NULL pointer dereference
      CVE-2024-46679: ethtool: check device is present when getting link se=
ttings
      CVE-2024-46685: pinctrl: single: fix potential NULL dereference in pc=
s_get_function()
      CVE-2024-46689: soc: qcom: cmd-db: Map shared memory as WC, not WB
      CVE-2024-46702: thunderbolt: Mark XDomain as unplugged when router is=
 removed
      CVE-2024-46707: KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence o=
f a vGICv3
      CVE-2024-46713: perf/aux: Fix AUX buffer serialization
      CVE-2024-46714: drm/amd/display: Skip wbscl_set_scaler_filter if filt=
er is null
      CVE-2024-46719: usb: typec: ucsi: Fix null pointer dereference in tra=
ce
      CVE-2024-46721: apparmor: fix possible NULL pointer dereference
      CVE-2024-46722: drm/amdgpu: fix mc_data out-of-bounds read warning
      CVE-2024-46723: drm/amdgpu: fix ucode out-of-bounds read warning
      CVE-2024-46724: drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel=
_number
      CVE-2024-46725: drm/amdgpu: Fix out-of-bounds write warning
      CVE-2024-46731: drm/amd/pm: fix the Out-of-bounds read warning
      CVE-2024-46737: nvmet-tcp: fix kernel crash if commands allocation fa=
ils
      CVE-2024-46738: VMCI: Fix use-after-free when removing resource in vm=
ci_resource_remove()
      CVE-2024-46739: uio_hv_generic: Fix kernel NULL pointer dereference i=
n hv_uio_rescind
      CVE-2024-46740: binder: fix UAF caused by offsets overwrite
      CVE-2024-46743: of/irq: Prevent device address out-of-bounds read in =
interrupt map walk
      CVE-2024-46744: Squashfs: sanity check symbolic link size
      CVE-2024-46745: Input: uinput - reject requests with unreasonable num=
ber of slots
      CVE-2024-46747: HID: cougar: fix slab-out-of-bounds Read in cougar_re=
port_fixup
      CVE-2024-46750: PCI: Add missing bridge lock to pci_bus_lock()
      CVE-2024-46755: wifi: mwifiex: Do not return unused priv in mwifiex_g=
et_priv_by_id()
      CVE-2024-46756: hwmon: (w83627ehf) Fix underflows seen when writing l=
imit attributes
      CVE-2024-46757: hwmon: (nct6775-core) Fix underflows seen when writin=
g limit attributes
      CVE-2024-46758: hwmon: (lm95234) Fix underflows seen when writing lim=
it attributes
      CVE-2024-46759: hwmon: (adc128d818) Fix underflows seen when writing =
limit attributes
      CVE-2024-46761: pci/hotplug/pnv_php: Fix hotplug driver crash on Powe=
rnv
      CVE-2024-46763: fou: Fix null-ptr-deref in GRO.
      CVE-2024-46771: can: bcm: Remove proc entry when dev is unregistered.
      CVE-2024-46777: udf: Avoid excessive partition lengths
      CVE-2024-46780: nilfs2: protect references to superblock parameters e=
xposed in sysfs
      CVE-2024-46781: nilfs2: fix missing cleanup on rollforward recovery e=
rror
      CVE-2024-46782: ila: call nf_unregister_net_hooks() sooner
      CVE-2024-46783: tcp_bpf: fix return value of tcp_bpf_sendmsg()
      CVE-2024-46791: can: mcp251x: fix deadlock if an interrupt occurs dur=
ing mcp251x_open
      CVE-2024-46798: ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object
      CVE-2024-46800: sch/netem: fix use after free in netem_dequeue
      CVE-2024-46804: drm/amd/display: Add array index check for hdcp ddc a=
ccess
      CVE-2024-46814: drm/amd/display: Check msg_id before processing trans=
cation
      CVE-2024-46815: drm/amd/display: Check num_valid_sets before accessin=
g reader_wm_sets[]
      CVE-2024-46817: drm/amd/display: Stop amdgpu_dm initialize when strea=
m nums greater than 6
      CVE-2024-46818: drm/amd/display: Check gpio_id before used as array i=
ndex
      CVE-2024-46819: drm/amdgpu: the warning dereferencing obj for nbio_v7=
_4
      CVE-2024-46822: arm64: acpi: Harden get_cpu_for_acpi_id() against mis=
sing CPU entry
      CVE-2024-46828: sched: sch_cake: fix bulk flow accounting logic for h=
ost fairness
      CVE-2024-46829: rtmutex: Drop rt_mutex::wait_lock before scheduling
      CVE-2024-46832: MIPS: cevt-r4k: Don't call get_c0_compare_int if time=
r irq is installed
      CVE-2024-46840: btrfs: clean up our handling of refs =3D=3D 0 in snap=
shot delete
      CVE-2024-46844: um: line: always fill *error_out in setup_one_line()
    added commits:
      CIP: Bump version suffix to -cip53 after merge from stable
      arm64: dts: renesas: rzg2lc-smarc: Enable HDMI audio
      arm64: dts: renesas: rzg2l-smarc: Enable HDMI audio
      ASoC: dt-bindings: renesas,rz-ssi: Document port property
      arm64: dts: renesas: r9a07g043u11-smarc: Enable DU
      arm64: dts: renesas: r9a07g043u: Add DU node
      arm64: dts: renesas: r9a07g043u: Add VSPD node
      arm64: dts: renesas: r9a07g043u: Add FCPVD node
      drm: renesas: rz-du: Add RZ/G2UL DU Support
      drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du
      dt-bindings: display: renesas,rzg2l-du: Document RZ/G2UL DU bindings
      media: dt-bindings: media: renesas,fcp: Document RZ/G2UL FCPVD bindin=
gs
      media: dt-bindings: media: renesas,fcp: Document RZ/{G2L,V2L} FCPVD b=
indings
      media: dt-bindings: media: renesas,vsp1: Document RZ/G2UL VSPD bindin=
gs
      clk: renesas: r9a07g043: Add LCDC clock and reset entries
      clk: renesas: r9a07g043: Add clock and reset entries for CRU
      ASoC: sh: rz-ssi: Add full duplex support
      arm64: dts: renesas: r9a07g0{43,44,54}: Move regulator-vbus device no=
de

Best regards,
   Nobuhiro



