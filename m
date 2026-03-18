Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD3610854C9
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 01:54:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5129.1773798858866231256
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 18:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=soxzaGG+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773798845;x=1775008445;bh=/EPom6jrLsxqjVrKLn7e6SRE3lcZklkNAQWrR
	w9a+1A=;b=soxzaGG+QQxsiK5Oi9tUQEinFaiyqWSkBX+7nNcibyelGDm4vY/+Sz1w25pdAgfWnUs
	Ybvd0Z7VUgXmZ8++BfqGnGR4xb9D/AFvYbxd8XcaKuBU0zb6x9RoAVkm2yACIrtmtHIsJeGb2QnjX
	kd7qQYoCVnMfGhkzyCsiOgy5WD1FzZz9gEphUSbGQ61sqECvewu2vq0oUcGggzjD0WgzAoI7uEpuS
	CUIt5REJjCv1MY6/oXwv1jcs8SnLrJ/Va01/MTUd1VaCPRr0iNPMDxf42K7a/BslVVlp2jfSz9BBp
	v2ZBnufOYix6PHr2cLBaedGdZLZVVi+8X+XzGG5S/u1Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 62I1s4Ga2705729; Wed, 18 Mar 2026 10:54:04 +0900
X-Iguazu-Qid: 2yAaAsf2wD4VnywbWW
X-Iguazu-QSIG: v=2; s=0; t=1773798844; q=2yAaAsf2wD4VnywbWW; m=RtINCFayVqz/TlSNhNv1ZRpzbL5LDvB52LIiEIBR510=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fbBhC3jFHzyPQ; Wed, 18 Mar 2026 10:54:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W51tMwYRpFDwPI7RVzS/k1klamSSE6ji/bjKQv/4VQCNrWW6Q40WbEGpXj8frKyrBNJmzkJdVGMB3SmUoPIVPEc0d7IZn1i3GG+Wp590sJGQyhTJC9az+34tXQZHuAmfy2Bj4Mxz4VWM75gEwtGeDQ9+uQjIdX+alQbrDmGrpDr4xV4INbhG/2R88C+NukIgDtfW8QsmpChpnlBnwv0R2o4GIBs4BnfNof3ntnM92ND8KRR4bMBljaHjx0yxDANT3N9mM1zUS4BrADOexYoUqkeAq0PeS/0IzDY8/5odQKG7lQMwin4APXy2jId1Y5pZ76k2k+cllak8hXv1pkJl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6GltJJoByKT33QZYFanuzHzZuMq7IxjiK8xCUFtqqo=;
 b=T17ybtFSQMkCR6fuLnBl2GxrXs4iF15uFwGWxii15za0IHYl1dVrKjCvaCVJahBVDhZTPUloSROBnwX8f5l7+h5gsLiH6EPIHwUZCI4UC9rSy1LDZjUu8My0y5Mohj3hwGItkuscyH4kPHAkcjlasrwCeYToXL1qolwf8eZZOAx22SWyoLQZuhmuy7rDWW92mqmFlK8FOtRNwA9nAKT+FDp+wgB9zQYAB5SRORx22bQMrMb+QLR5JKUneSfm7WQvQdCgQZzPYereVDJq+ontGTTGa6Qcp8e0QCEIOqjeKGiaYs310WcNILMFSMt/6R/ibUc/Hwf7q3U+AOVVNLnJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: RE: [ANNOUNCE] Release v5.10.251-cip70
Thread-Topic: [ANNOUNCE] Release v5.10.251-cip70
Thread-Index: AdyysicQDBmKBhleQPmTXOq74MpVEgDQ0WAwAB/WGAA=
Date: Wed, 18 Mar 2026 01:53:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180E90E48BEC0CE621DC7DCD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB14818C5A866AAFB66A71EA103CD45A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB81230F9D0E8455689D3C7A1FB741A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB81230F9D0E8455689D3C7A1FB741A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15578:EE_
x-ms-office365-filtering-correlation-id: 39b59632-361b-43af-a7f9-08de849138d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 QvP5ucEjPHNTHlUXLaM4GG0HX5kvqwGdW3lRvblxypAINSsq69fpQZpTl3/PbZgtfK9Zcuyxh2/R5nEvgUFRtoBsR2V10TPIuwp2zrQGefK5gT1nfU5NRE8VpK6oBF/kJa0oEw9rQ3I9s0yfz50LYwU/yrdHSSIV0UrfGvj7cEj0FSG166INtjDu9qonRgjnIMjgjOkf0Ibufzp6JDHASBcW2jDAY9U+jwtagVVeyFbrvT/XCXtf4DP5tsgsm4NM2q5besOfIGIiTh/MGV+SClZeVNDiNCBe6ijtiazCnnBV5xBfLjwAmhGRRZhdCXUzYjtFzdPKTO/dRWph0r40dzGwHx6VvemNkwQgQPdzvn62+vSdRUjHuMWkftae4D9vbcnsqbL6JzXxph50TAYMcVoYk7/jU3ysXybduCngZGtgqAc6omfjxAEamsJ0yrML8DReW+aMrkqcWjdcfh/6SmqTO5jLLsPWw7TC6ng5dbjA4x8V7W8v6pV9YnvaBkxR+xN8Ex1SbYzhelv72/Csn0/bYqO1TjnMZJZFTqRh6FmW9g0MQKL5ajn0E5kcyO0BKnVp+cuswR5IlZ9X2z+3JIOSxJVQXd3DC3QeOZJQg0f6rpYUjl0XdC74+/NYZDypbegez16bd8M8RmrqrsnFQA4P0Z/8/sqExb/EBd3KoY3ujm+9aX//wpNHcMQMbCvGkm61sb3qnjYvff05WVcUMcqV1cdjDM1TifMaJEAZ2N8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YS9ZaWR6WE5iZEliZm1NRXp6RkllMWVpWUx0OUZUSjBLc2hJRmlUVnNk?=
 =?iso-2022-jp?B?dG1CelNZcHEyUzJGbWgrUlkwV1NEbEFEQkZ0bjZ5ZEZZWXQvTXljU1Fz?=
 =?iso-2022-jp?B?ZGtmRmxGUUF0eWRXa2FKWjNSV01xaFVSRXhLaHZIQnlWN3JWUURsT3Qx?=
 =?iso-2022-jp?B?U256TktwbFpWMVFHUFdWcHpJV1ZoblFNUVJDQS8vTnF5emluRzRSUGdW?=
 =?iso-2022-jp?B?TzFRckVQcjFxSHRXUkZrMVV0TkRmaTQ5SXB2M0E1RWxtWHUzZUpTSEl2?=
 =?iso-2022-jp?B?aEtRcG14MHh5N21YbGJBZ0szNWVLcU95NWJFUVhqM0owMHJQVzBGSVRZ?=
 =?iso-2022-jp?B?ZU5NaDdDUm1LeS9pM0VQL01jaFN3U2dXTytjK2J6VE95TFVPcm9HL3Z6?=
 =?iso-2022-jp?B?S0ZxOTB2blRxclpCOGZRcDd2YnV0OVdvM2Q3Nnl0L3FNTE12Y2FXaDln?=
 =?iso-2022-jp?B?SmRCM3JEWDlxM3pHSnlSWlpMUjdhN0tRNE1aL2R3Vnh0Y2d0WkpYNjJt?=
 =?iso-2022-jp?B?VjdybFp3M2VwN28rcjVpT1Nmdi9pWmV2aGJkQjlZL1ZCdlBLVUNHZHc0?=
 =?iso-2022-jp?B?K1JkM1VUZUJzVGNvcHAyUDBFL1lzTnE1UFEyVllzWU1IQnRUTUlVZEZG?=
 =?iso-2022-jp?B?MDdUSGJGZk9RRHJVOHFBd0hmWndONVNyc1NvdXJYbDFpajVzSnduOWxG?=
 =?iso-2022-jp?B?Y29wMUVRNXNRcmg2WXc3QjJCL1lBMEpIYjQ2KzZ3bmdhSkJEZWpBN3NH?=
 =?iso-2022-jp?B?aU1jNjl6dVYzejJwZTAydGxQbDZLRnFFTFJPY2x6dnhSV1EwRVRTd3RJ?=
 =?iso-2022-jp?B?WjFnSzdzZGNCTVZyT0FteGkvdWhOVk1jZVdFUVJxbjRLbW5BK05EdkhN?=
 =?iso-2022-jp?B?YkpmVEdBalRJMnJhM2xrcEg2OW90Z0Z6UlR2bkxLTzdUTkZFVmE2aGpz?=
 =?iso-2022-jp?B?MUlxVzRXZzdMUVh4dmhvSUFwNmhXTFhkeVc2MVVJQjcxZkVZZmpQQU53?=
 =?iso-2022-jp?B?NkN4STZBM2lLNVR0WTQxRjBiRUlxNVYwTXUyank4dWMwZVFnZkxTYmZD?=
 =?iso-2022-jp?B?QnE3cXJSYlREdHFORDR5Z1pKQXBwemZPZjhFQVoxZVcxQmpnTUNha1d3?=
 =?iso-2022-jp?B?OW9BT3BTM0t4YzExN3pKZEdxSXM4UVROQmRtT014bHJoVmlKQ1lQUGZ2?=
 =?iso-2022-jp?B?eVJmZk9MRGk2SFBJLy8zaGcxS0dYcDFGTFovbFVtamcwMi8rT24yS0lw?=
 =?iso-2022-jp?B?bGZVaXBlb3ZaK01scFc2VWk1eExvTmVpSGRFK2ZKQzRUQU9LeFdTd211?=
 =?iso-2022-jp?B?eitobmRORy9PNk0vL3Z1QTB0citQR01lUk5hcWkwamIwcG1Sb0M3VXlU?=
 =?iso-2022-jp?B?ZFBVQjIxRmVlb2Nta3I2bER3R0JYcUl3dlg4V1JLa1paVWZWcFhFNVlw?=
 =?iso-2022-jp?B?SnlKUkw0by9lOFFGd0EyaHhOTXg2NERPZnJoN1VrMXZkeXhYYjZKZkF6?=
 =?iso-2022-jp?B?Ry93OTB2enJDREMvSThtb3JxU3JOSzBGM1pvbVA3L0F0ZnJRN3NEVTAy?=
 =?iso-2022-jp?B?ZmoyUGtpZ29BK2VEYWhnblYwU0xZRVVnVWthTUwxYVExWHozNUtLU1RL?=
 =?iso-2022-jp?B?L2xIS3NzaVNabVd0QVZ4LzV6cnlYNVFsUHJxcWpCakRocTFJTnhPVWYz?=
 =?iso-2022-jp?B?Z2dSUkNLVE5rSTJ6NmdhUlRJQW9ZTWZjbzBiVm1KUnU4TlNLL3M0aDZX?=
 =?iso-2022-jp?B?aGhiYmdyU0tiTW00anRlbldwVXkzVmd3Q1p2OHc0ZEZXMlZkRTFpOW1s?=
 =?iso-2022-jp?B?TlorS1VzdCtFMzR1VVptdVlwZGtOYjkrTVZoTkM5aVh4TlFwRUVoQWU3?=
 =?iso-2022-jp?B?VFYvalpiNGd5N0ZBVXNORnVlL1lkR1ZlQ0k5TGljQWR6OVAzM1NZT0Jk?=
 =?iso-2022-jp?B?U0kwQlRxSHpNRVF5VFNmb2c4d0FEWmRpQTF0TkltbzI2eDJSeHRWS2U3?=
 =?iso-2022-jp?B?MGdpVGx5UGJEYjFmUW4xdG1pS3N5dEY5Y0pqZUo5bHpRbDdpQ2NlUWdV?=
 =?iso-2022-jp?B?ZnJxSUU3a1dTZVhkSTFKL290U2xhWWJTblY0RFd2Mkw5KzU1UXA1QW5h?=
 =?iso-2022-jp?B?amtXQnJYTnNEMVgvSHNvSWZNWXJlNWJ6UUVKcEFoYWN6enNoYW9GRlh4?=
 =?iso-2022-jp?B?SDVXb21NeUhNVDIwZ0h5KzFDWEJTVTlTMWZtQmh3ZEF4UWpxNnVocGR4?=
 =?iso-2022-jp?B?TUYxd0hXMTF0U0E1N3dYSEs2dEVZa1VVSDhSdVZ1c01ET2FCcitlZU9w?=
 =?iso-2022-jp?B?eThQU2kxUVY2dXdPaklLblBERVRWZEVqamhrSjU5NTI2cDMrcDVvK3BB?=
 =?iso-2022-jp?B?T244SjBqR3hTNUMxWG5qMkpYcjMya1RvTXNrWGdIbk5iY1pPSC9TM25y?=
 =?iso-2022-jp?B?MXpiWGVhVko5WnNRV2toTTdUd095bUZNK0RQbzJhWjZBLzVtVyt4OC8r?=
 =?iso-2022-jp?B?QnhvdjdlTmovalRLd2xMN1ordHc0TzNzQWpQTWNkRlU3UHhSdkp6YTht?=
 =?iso-2022-jp?B?RnhMNTNCaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	vmhYNo1fxTmzxGRt9ZfchyzxHoBPjn69SxEaYX21lCdsR+/Bx3nI/Irkw2kCx9Mr+rcAyDFEPiBntm+JnIQHjU2Z9ArFH2uL6UBntIJ0ZP3dRNMsLZkCvzSvHeMajTHQN4mwF/e3OuWYcORhe6KptukPyOAzTd+q6c2Ia5vI4UwtfCBCCKRb1CRw/qOhPKpKlnEQKq8fVvqHtcfrDdLlSNNPcXMUC5IBK1Tb6IrDiB1i1XMTQlu81PM5Ju0dX2Ai4VJ6JA4BJdJy+j86zNWvvDWbnKh/5qk0EdOKszgnSuiqtOCOsCuCBP7LVPEOCQ5R8ObEJK0GT7rcOpzduML1UQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b59632-361b-43af-a7f9-08de849138d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 01:53:59.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCU0nfy1GbXb9hFdrgclW/riiIf6Z1B9myNoEeTxo7rqozRPRMqI6AusgkkyjaWeYxPTnJyyfV+Sp/GEqjUdYjZ0NAr9Py6ieYEb5Hy4yOo3VqfY9ciN2deKwqEdu3gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15578
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 01:54:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22493

Hi Chris,

Thank you for the report.
I am already aware of this issue and have responded to the report from Kern=
elCI.
  https://lore.kernel.org/cip-dev/CACe6DC4EcZ1hunb1ce56gR-mUbPvF=3DraUneJdP=
AisWM33MAyVw@mail.gmail.com/

  ```
  This is caused by the following commit in LTS with CONFIG_SPARSEMEM_MANUA=
L=3Dy.
    8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix

  phys_ram_base does not exist, getting in a build error. This commit
  must be reverted.
  ```

This is the same as what Pavel has already written.

I am going to request that this commit be reverted.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Tuesday, March 17, 2026 7:09 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>;
> cip-dev@lists.cip-project.org
> Cc: jan.kiszka@siemens.com; pavel@nabladev.com; masami.ichikawa@cybertrus=
t.co.jp; uli <uli@fpond.eu>
> Subject: RE: [ANNOUNCE] Release v5.10.251-cip70
>=20
> Hello Iwamatsu-san,
>=20
> > From: nobuhiro.iwamatsu.x90@mail.toshiba
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Sent: 13 March 2026 06:51
> >
> > Hi all,
> >
> > CIP kernel team has released Linux kernel v5.10.251-cip70.
> > The linux-5.10.y-cip tree has been updated base version from v5.10.249
> > to v5.10.251.
>=20
> Our KernelCI pipeline has reported a build issue for this release:
> https://dashboard.kernelci.org/tree/cip/linux-5.10.y-cip/99e8b9912822c35e=
388d236d0aadca61195f75e6
>=20
> Specifically, the riscv cip_merged_defconfig build has " error: =1B$B!F=
=1B(Bphys_ram_base=1B$B!G=1B(B undeclared (first use in this function) "
> https://dashboard.kernelci.org/build/maestro%3A69b3acb5e8c48c93579bdc61
> https://dashboard.kernelci.org/issue/maestro%3A51c12e2d53ea10cd0ae264568f=
82d96b2dbc0245?iv=3D1
>=20
> Kind regards, Chris
>=20
>=20
> > This release includes updates to the ASoC for Renesas ARM SoCs.
> >
> > Information about this release is as follows:
> >
> >   v5.10.251-cip70:
> >     repository:
> >       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >     branch:
> >       linux-5.10.y-cip
> >     commit hash:
> >       99e8b9912822c35e388d236d0aadca61195f75e6
> >     fixed CVEs:
> >       CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map
> > bucket size to INT_MAX
> >       CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric
> > scan in progress
> >       CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY
> > scatterlists correctly
> >       CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix
> > system crash
> >       CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr
> >       CVE-2025-71237: nilfs2: Fix potential block overflow that cause
> > system hang
> >       CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing
> > associated memory
> >       CVE-2026-23229: crypto: virtio - Add spinlock protection with
> > virtqueue notification
> >     added commits:
> >       CIP: Bump version suffix to -cip70 after merge from stable
> >       ASoC: renesas: rz-ssi: Add support for 32 bits sample width
> >       ASoC: renesas: rz-ssi: Add support for 24 bits sample width
> >       ASoC: renesas: rz-ssi: Move DMA configuration
> >       ASoC: renesas: rz-ssi: Remove trailing comma in the terminator en=
try
> >       ASoC: renesas: rz-ssi: Use dev variable in probe()
> >       ASoC: renesas: rz-ssi: Fix
> > rz_ssi_priv::hw_params_cache::sample_width
> >       ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
> >       dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
> >       iopoll: Do not use timekeeping in read_poll_timeout_atomic()
> >       i2c: riic: Move suspend handling to NOIRQ phase
> >
> > Best regards,
> >   Nobuhiro



