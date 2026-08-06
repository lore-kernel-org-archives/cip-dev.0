Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E945C55838
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 06:46:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14079.1785998794243047735
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2026 23:46:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=A7CHheSH;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1785998792;x=1787208392;bh=
	qhszLgaAS9JB4goQvk42GnjzGYOAxl7+n0eB88KJ8Tk=;b=A7CHheSHv65WrlmlJYpM/3WT3E4UP3
	Bg0BgeN92eydbWS49jbG2Mck5WAs/CDxeTOfN52I5AABbVSMTVEUYtEYEbSRCtaY7iMr+axtODLG5
	DwZiVb3cijxt1regdYs7Jq+XyyMv3V7NoEUr9ZLt/gCkvvtis1B/wvQzaRNv8yGqpiJIxhhTPEwf4
	R3eJ91oCpQYbt5TSmmvX2vvfsIwKzrD6WjbbreTPh2edoK6/Og21IHh+z0m5xhyHvO6Cses+Lxg20
	w3a4VJP+Pvuhe+5cD26fF8tqz+mOXb0gGP7RZKT+SxCKyVg8Iw6HQD6H2ctmwUry3nX16PB4JGmzg
	pIiA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6766kVrd3140903; Thu, 6 Aug 2026 15:46:32 +0900
X-Iguazu-Qid: 2rWhW3h7p5OrPHOJsq
X-Iguazu-QSIG: v=2; s=1; t=1785998791; q=2rWhW3h7p5OrPHOJsq; m=0Ah0YPsGsOJNm+zWgHKOMFVu+QUzcKq/hxGN2rlKWss=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hFyVb2pTgz1xng; Thu,  6 Aug 2026 15:46:31 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdZEyiOv8QbuDOQslOTo3qIPpQ0nz6h3Km+DfmwigmWvdOOtBtLxXeG5RuFBmFv/GD+QWLUo+U75/q43X/q7vdG87LTIgxLAxd7+FIbgYrfDl3s4ilZu6k/iwg1LC/I8mIqkdncBVUkiaxubRKApaW5kMqqNrVQ4NcMA1CPPtqsxI88T3NwLIEQ1ISz/mr1nvVc0SF/8KNg3/t+NGb9sfu3qd1SZ7rVl/Vr1ElRhoLyNQ2il3HzONX/97z+XTbIx9Gc3FCQbftOgE0qwaXQ4Lt2mOf3ko+Km8LAH0Wtu4DG2TJRq2qKocxgz04L/XmWZG/+ToR7vT0jkqbsM9YUvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5ALSZ5ZqFMGN2VVMW8+efbU/SO76fWBP4DBOU/jCqE=;
 b=FrL+Ix9+cJ3jjwoGR/klB52G3nfPec2dZmLhy/9xEYHM+34+IW2ntnvATInWlrc/mVzg4H6z8SZ4x82ynKBhvC4oVmYzQQaxNcOK2PRoMAV6YWpsvR4vH93XLC59ycqrq2sEl6H5ksICWRmXbtyFZvnp4JrNe+k5UjkTpZ3Y5Jtwc56+8Omyks/4bisKVerlnRn2ZTkT52ihKlMHM6oRYq5ZkCxqsw7AtSl/nWUUDAQxZgGVcvdEQ6STwdfKwYCY+tlfInmQi6MI5Av/ccRp1SuOCK2yi20EhKY9oNBdhHT7pKcvW3QhCwKC/DXsvF7g1lj+97etdmJKADLbUH0v+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
Subject: 
 =?iso-2022-jp?B?Q0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheSBvbiBsaWJlcmEuY2hh?=
 =?iso-2022-jp?B?dBskQiEhGyhCKDIwMjcwODA2KQ==?=
Thread-Topic: 
 =?iso-2022-jp?B?Q0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheSBvbiBsaWJlcmEuY2hh?=
 =?iso-2022-jp?B?dBskQiEhGyhCKDIwMjcwODA2KQ==?=
Thread-Index: Ad0lbrVKiGmKqE7GTWGtrM/uHNlL1w==
Date: Thu, 6 Aug 2026 06:46:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481867DF294CEC38055C7FC8CDD22@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11178:EE_
x-ms-office365-filtering-correlation-id: 9eec2b34-8a51-462d-56fa-08def38670c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: 
 fW5qNe58bR4fRTQDxVVVmn4VNJmph9mTssFzF1eZOXfCrI4TvnLWr1GEYR9VPM0GDqEj/DsCHa1GnEXwRfC+W1FZQZJxzswTuP6OKaW2zBiW9nzJtTll/rKM/xJm/TivB/1Wg94jXGg5VkRmLIYfn3Vvsx+8TMKzKEJ78H1jfCadZjXz+Zrtb5WuqDoJN4j1ORNWbyyzRWSjUuppcEaBxUM6HBPKHXYfsnWNbWXFFlGa+KbZWT1cQuX/UD1Y4AOODbuJVSNmKpo39o8OJiZRgRB61bUGRjMjV/kgECL6gAyZ4cG+106+OOWrGXCaomYV6mYz6tK3voswg9STkBpi0XxAJk4/ZU9UKSOlG/JI0DASbtYufhXK0o1Mm9SSskaZ1zfwO3aylmw5T2GelaGEijx9U6KCV3Nbn2kisiejPQRRM7bTZTV6UmH6a+HQ5NhodiI2ebcxYipWPRuKd4U2zfvH2qIH3MU2LJJns+wvRuwqnr3vPyzRFx7OHs3Py1jkhZ+5SKsNAvlirs/8/pzS5uM5t8yLPq7oE0SkFFZsQP15rK8cZLbU1RCwdYf1xipe/2VujTfkV4rbKJ+ig9f7IocAUuz3Q4YOLF4clXCnDCYsLYlRrCVe6j6g9A2v7U9RGKyRg/tqr6fd9enfpSqyL7tRPz5/s/BsZGakw3MCWF4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U2JqNnRWYVZFUXd0eGowK3VRWjZ3R0dJUm92Ylgrdk5vY1lSTU5UeGZO?=
 =?iso-2022-jp?B?enlZd2o1YUlsOWpHK2ZESXAvdTdnOG5xT0FtMzk4YzVPYTdndXBpQlZw?=
 =?iso-2022-jp?B?VFhMMUM3dk9TV0ZsRXhlQmZkMlJGcWpPeVo2UU9mS1Rxc1BXUWIveUM3?=
 =?iso-2022-jp?B?WFlBUlMrdk56ZXArSHh3cDUrbjA1MDlRV25EcGlpSVdnelh3bjVJYW0r?=
 =?iso-2022-jp?B?NHlWd1FZc2txT1YzU2dhV2pDTmtvWitLNWdlcS9ZaXRKYnlUNnVYNkNr?=
 =?iso-2022-jp?B?RFk3K2VtNUFyazJkc1dBbFVrbjFiUWxGWll1WVVTS29VeFhuMFhwL2Rh?=
 =?iso-2022-jp?B?UEc4ZGo2M2tWaVo4cUNzUzllTFdxNitKL2pNbzNXQ3hBL1lsRmM1SjZm?=
 =?iso-2022-jp?B?OWI5WDc3VFB3Mkp5VzB0eXBWNnlSNXJRVXNUTlFsUzcrNngzU3JEbG5o?=
 =?iso-2022-jp?B?ZDBFL3pBamhFdVFva0lWVmZHZ0x0Z3BEb1VWMFdkc0NINEhlQ1FKR1Qv?=
 =?iso-2022-jp?B?SlUxczJvdmdtRC9qRllNTmlxYXJjRlNuclNJanZCd0J6K1BLUFVSNmpo?=
 =?iso-2022-jp?B?UkpkSjJRWVFZT1hHdDZlcEMwV2xNLy9yZ2RKcExyOWdyRHJEclhrYkgr?=
 =?iso-2022-jp?B?UkRUYmUyWVJpaUhJWkZTTjUwWWZZb0pzM3d1OHhwMXViNGoxaTBSZnl6?=
 =?iso-2022-jp?B?VEh2YWpiR3F4V3M5QzJTYVAvTTJpWXBDMDh3VzNIS0NuT2RjeWhoR21V?=
 =?iso-2022-jp?B?YlZsaTQ4NjM5S3dKTytyV2owZkh4NzFZUXR3MU9jS2RtYjZ2aDZmVGly?=
 =?iso-2022-jp?B?aEZtNTVXUGJtUlg2M0RFNk1kSGdLQWFwUEkzNWtVNUxXWTRDdnpTS2tO?=
 =?iso-2022-jp?B?US9seGdQV2poOUlzbXpvU1BNMmFwNFNReDJONERlaVhzcGNGQTB1OGI1?=
 =?iso-2022-jp?B?Wi9xL1ZHb1VCVnVkOGpmK0dvNG1INnlSYnk3b2lwWXRSVk5RSUNoZk5t?=
 =?iso-2022-jp?B?NHdRTFBsaXl5Uy9JUVBRUUhZNUdhc2VYdklmbHVsZDh4aWJKSjhuKzU0?=
 =?iso-2022-jp?B?Vlh4RFRiejljNmFuQ3RDY3hiUnc4Tmt2UzY4REtQUE1FOCtnVmZMRjY1?=
 =?iso-2022-jp?B?UUNIVytOQmprTElLSFM3WStEcEFjNEtQTFl3UDI2TXZFalVLZTdQZmwx?=
 =?iso-2022-jp?B?TjlkU1RsMjNHeEticmYzNkZMU09XL3FpejM4dzdpellPczc2TGtMdFJY?=
 =?iso-2022-jp?B?OXJUM0J2blBZektVR2tRY2RTVE8wb0puMytoaXo3RDRIQi9sZDlFUHA5?=
 =?iso-2022-jp?B?c2lkRUFUK1V0UU9FVUFrRk8yOXdDdDhVVDJhY2o1S1ZIUGliMmhjaHh5?=
 =?iso-2022-jp?B?WGFSbXpFd0J4U3BCZDFraitvTU1NNmIxT0xSL0xXeUpYN2VsWi9zS0Np?=
 =?iso-2022-jp?B?bDI4THlqVW5YTzQ1VmV5cmlrdzhOZlpwaWR1MC9wa1pUL3dZZXZOOFFI?=
 =?iso-2022-jp?B?Y3ZaYkNNRUFLNnZsdUFnR2JBc3JYS2RsZ1pReHV6YzhEemttUUlNYTg4?=
 =?iso-2022-jp?B?WTVmbWt6clZ0U3NXdm4zN2xEeElzcFRLOVlTL0pTNVJ2Q0U3RTJ1WVhO?=
 =?iso-2022-jp?B?bWpIbHQwU0IrWHBSZVpGQk5qU0Q5cGpZSCs4SHRLQ3BXL2hDcFdCSlB2?=
 =?iso-2022-jp?B?NU0yWkpYWHVCVjI5MlF2R05ZRHJRejF1MlVXL3owK2VLWFNhMFVaVjdl?=
 =?iso-2022-jp?B?c2NEREpXblZJSWJGb2FSQTBFT1A0dUlDeDNHaFVXaUpiREZLSmlEWmRh?=
 =?iso-2022-jp?B?UFU2ZnpaMElzRHpaWkpJeVNmdDBYaGZYamVFZkozeU9wRm1iaTZGMS9H?=
 =?iso-2022-jp?B?bWlFVEhDV0l2akJvb2lBOU9wak96SGI0TjJoelpDaHM0Z0Y0cW5OeXkx?=
 =?iso-2022-jp?B?TUxBQ04ybGFRMU5DZGJjNWxwNUJoN0tEaHVCWFhQdUx1VWpiV2lFSFFF?=
 =?iso-2022-jp?B?WXdEV0toYXdVVVFRVE1abGVxbUc0SkorODZLRU1FQytxa2NTUldsV29x?=
 =?iso-2022-jp?B?bHdKMzBzNXhrYm9TU2NRVjZ0Myt6UjN2UjZzempXY2FMNnZ3ZmF2Vjdk?=
 =?iso-2022-jp?B?ZG1xUEdvYlNiUFJUdUN4QWdnQjlTVDBFWTR1KzFFd0xad291MFFmbFM5?=
 =?iso-2022-jp?B?VlJBbXBpdDVOL254eDBpWmRJeUhDYWYvMTg1Z013QjdxcWtXUE1VWkJR?=
 =?iso-2022-jp?B?NUlmL0VsOVVtNUkwUWo3ZFkwU1pZbzRKZ1NCajN5K1BocFE5Zm1tT2NW?=
 =?iso-2022-jp?B?MHQvdjJzR1NRaXZJekVHS2I5UUg4azEwb1VpYzZGRmo4S0JwNG9CbEVG?=
 =?iso-2022-jp?B?ZENQV0JDRzV1Q1JiRUxCSEdOTEd1WU1nRGhlcWJORU9HQWFFVzBnOHhY?=
 =?iso-2022-jp?B?S2FMeVNaV3luUm5uTmdicnVPQTF4VjlUSUNsOS9jbHF5Rm96ZkN3NkZi?=
 =?iso-2022-jp?B?dWljekRGMmFtVUxiaXJqa3VXYzhoL1lYNG5aem8vbGpIYUo3NXRnR1Y0?=
 =?iso-2022-jp?B?MTIwRm5HRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	cPAalbvLPF3K2Js47g7PdNO5s9xNBYuUIEo+RDQlWNe5dSGLa7sih9aRlXH8CS2g44s0X0zC8SPzBqkaqpknoeIr1x/leyJKYizaCcrUbrutgZMpJy96rdrMwR4wQsqlcrjpdH7WNCjgyB3JfxO1hsxjiji9quwdqQZSKkUC/T2iGZ1etkCGAtOs41Z97Bj9ZLvhM2bjEvzs+zEbYt6ROnrDzxTKqjsfV4mnbmzrfYHcksSZH+XI5B1E4gie/HdamwluQyr/skGBnMsLBmgU7A6WL+agbCtb0eGUrcEDY+E43g5QwFvjE/ERrL2m6Q5wqj73qnrU8TOKeexAxS/k/w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eec2b34-8a51-462d-56fa-08def38670c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 06:46:27.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTuBm4Dw95JD3ReDgf+B9GdWt9iqGKR6++BcdrOuKDl2lafvcZggfrjEvJxA0YLZo2u2d1FcKK0hleKdp7YDSKu1TnRX1w8Px7xVhgGgbE5uiWkt/8PTlOAb19hZhU4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11178
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Aug 2026 06:46:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23870

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mont=
h=3D7&day=3D30&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/07/cip.2026-07-30-1=
2.01.log.html

* Action items
   - blogpost draft [iwamatsu, feedback: all]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

[*]
Date the data is created: Wed Aug  5 09:00:01 PM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip113
  latest version release date: Mon Jul 20 10:00:31 AM UTC 2026
  limit date: Wed Aug 19 10:00:31 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip113-rt62
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip135
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip134-rt49
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.260-cip75
  latest version release date: Fri Jul 10 06:12:25 AM UTC 2026
  limit date: Sun Aug  9 06:12:25 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.260-cip75-rt33
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.177-cip58
  latest version release date: Tue Jul 21 10:45:07 AM UTC 2026
  limit date: Thu Aug 20 10:45:07 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.175-cip57-rt30
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.96-cip28
  latest version release date: Fri Jul 24 06:35:21 AM UTC 2026
  limit date: Sat Aug  8 06:35:21 AM UTC 2026
  Status: On track



