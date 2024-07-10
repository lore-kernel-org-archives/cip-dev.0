Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3BC38150
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 04:41:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.6834.1720586468186011861
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jul 2024 21:41:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ASfnXCUL;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1720586454;x=1721796054;bh=m7DQtgy5zM6tClPmeI0/8OE/s24lwv3GBLYdpxv
	+xVU=;b=ASfnXCULH7/LBNMOl4hoLmMRyGHGdNfHiWlGVeuqceMfS5cSvARbYOKpkrnXiOhXb8GW5
	dGeII2JuAev83a12D0I8BEMI6siP/nrUMl3OkflpfCB+D6N6b/1plt3cri1ML/4Tw88lNIF1zkJKt
	3F452c3KTv08GH5YHq0uj1PYoqLr1eSUGL+Ds2y1rxds+rzaTmUHvAguyYhtdpVtz+73+gemSbp2j
	szHQi6Np7vDOhEojJbIwT5zhHUwRvXFQ4Y5a4fznbdeXVDvyxfbcLRxvvNGlQiSp9oL+jku0gjDj5
	paug2uPe+EQ33sIEKlOe0Q9Ge6VDsMdBGRVJEWDbeg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 46A4esIs973289; Wed, 10 Jul 2024 13:40:54 +0900
X-Iguazu-Qid: 2yAa9B2RMs42tnZRvr
X-Iguazu-QSIG: v=2; s=0; t=1720586454; q=2yAa9B2RMs42tnZRvr; m=k7jTaG/7SNt6TnyjrYuH5w6gyvjgeHxoX6fAoogfoes=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 46A4er24699044
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 13:40:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg4tOgMiMRgRr0AS2Psvim+604bSLgGFElEOIZL/o+wmMwAsm+aDtSd15W+i5tUbHZYpaZQi88RezM8wgblBMXimX9V7Y8pR/0xCgKmHT6WDbxHaqvmC5zzzeljjc8XlrsqAzOn1DVEv0lpPAhqPH5xj3iU4vQmkK3gf6CbPgpRxw/HXus7tnJFiNHAfQ1DsxDcNhRPyJRPN+msEh+AOJZfG/ZrEanxCQa5DFyFKx86ZhhG7Q28CP3kZseZqawwnDwo2EQ99VJy2h4qfgp457vP50JnIoeNYtoLffaYFBCUnzBMKiDEyQuvtHxVn0ToGbDuvYtBPMR4OJ8D+sgGVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhrDY3XbTa9IAU1VJv//+7HHMzG2KLJf4s2k9ZrA8hA=;
 b=a+QIDqGv35ehJf7BcQcJRjGDLElgHHPKUoic21JezU3vDOIIo6PsS2tHoOZefAkjEVdIUbi2EpMjk+TO6+oMsN+XLdw8Pn/dEzvcSV9hRcnia9/hXlOWVZOlV5pzZN9HM+DJgz/vrChqPweoqXoLFMSCNsRYD07ujhKogLBfY4EJ5vuGKTwCm4JpL8PgPbZVYWpLR0eJMBr5I4yG8OQBSD3qjpgm5OHiHLeP17C2MALelS3mJZXd+hPTEI8w2Ug3dtPMIZBNP4w44tJ9oLgCW7NUJ6qxLO6ODWgnQxu3/qTgtiZ3nzb6xQGo/InPN9G13bVHcNtKID2Z3bxyb+VgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <paul.barker.ct@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <biju.das.jz@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH RESEND 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
Thread-Topic: [PATCH RESEND 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet
 RX checksum handling
Thread-Index: AQHa0fGueDtCSR6d7E6O/gKrH8okMrHvYp6g
Date: Wed, 10 Jul 2024 04:40:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63888FE6F471887007C20EC792A42@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240709111747.247-1-paul.barker.ct@bp.renesas.com>
 <20240709111747.247-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240709111747.247-2-paul.barker.ct@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB6544:EE_
x-ms-office365-filtering-correlation-id: ee1844e2-7f26-4305-bcd7-08dca09a79c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UUIrRmVGQnFxWmI3bCs0U3YyQ01zYXVxdmRrS2YyeWNBOURiME00TjM1?=
 =?iso-2022-jp?B?QnJBb0ZmQkdOcTY3RG1JSXhTK0gyeVBTTkIvRGtNb0tUZVY4L1FBNy80?=
 =?iso-2022-jp?B?OXlObmFKSW91WVRXc0hFaW9BU0ZnWHBwdU1CM1Y1T0tTN2VYeEhSaCs1?=
 =?iso-2022-jp?B?YzFqcHltZTlGaXZMZ085SGpoWUl4Wkg4NFJqZXNWNHdETzBFbTRqK2Ni?=
 =?iso-2022-jp?B?aTF0ZExVRDhCbmJxeU9JYzZKVmF6eHhDWW4xVS9ZaVFtbjV2SUozcW44?=
 =?iso-2022-jp?B?bFlReE5BTDduaWg1UGhRaU9xV0lBbGlPMm5tYXR2cndkN2dCNkVTa1Ja?=
 =?iso-2022-jp?B?WU1CY3ZTZDE4MUt2UHhCeWNZeEthYUxZQndmcnVnalZHYUJNQ2JyN1h5?=
 =?iso-2022-jp?B?RjQxQjdNTUNvdVhIakluc2drWkh3M0hrdzhzbE9uUU9YOHJvbWNWQlU2?=
 =?iso-2022-jp?B?eUFjV2hsUTBSbC9MNWtlSWVKTEZ5cjR5aVNURXdsYVZlQjlxdnM5NTRY?=
 =?iso-2022-jp?B?NnFQOFgrL2ZxdFhHK1JUVnJ2amFTUmpENEJnejMwaFlhWHkrOFVnNUMx?=
 =?iso-2022-jp?B?MkFObzZwditxcG84QXhKNjUvN3NwOVdmVFR0RGJQNjdjNGVEN3ptaE0w?=
 =?iso-2022-jp?B?NFI5YjNCUFpNNjJBNldnWHZmMFZFQVkwWFpwbGo3NjdkR09MbEw3MmpY?=
 =?iso-2022-jp?B?ZEdER0phTFV3QVlTS1N1MmdiN204eHNZUDdUZTVjNWw0K3N3L3hGbVJv?=
 =?iso-2022-jp?B?OG92dm5iNC8rZC9raEZUbkwwYUpYNkZiVjJsRi9oTFFXMG92K2Z3Qjhw?=
 =?iso-2022-jp?B?QkhjNktMRG9ObGIxQnhpMkxOTDgxN05jTHM2YW1YT0JRRVp6Z3ZubWhC?=
 =?iso-2022-jp?B?OVRzeHZsUW40amVDaWV6ZzZrc3JjNE04QlBwR1Zna0ZCMkZ4cmRUMVJv?=
 =?iso-2022-jp?B?ZFFmbENKeS9qUHl5T1hDL21BL21qSk9UOGN3bGRnMTJnaDJCYzdkWHZm?=
 =?iso-2022-jp?B?Y2RWTkk5MkU2TDZCMUtqZEFuTUlFRGZuTFdBa2FnRUdtZ0lHM0pFU3Zu?=
 =?iso-2022-jp?B?L3dpbjJpaUZaVC9xeHFyL211cVJGMEx6ZDJVTGIycmdkaU0rZGQ2TTc1?=
 =?iso-2022-jp?B?R3UrUkF3cGZSTlFvNkk2WVl4QVVXTE00THhtTHFnaUExeW9oQUR5RzZD?=
 =?iso-2022-jp?B?dWlrV3ZnTTY3SC9DVFhMaTVtbHVpZ25XamdibHdZbVRqN2FkbWowY1dE?=
 =?iso-2022-jp?B?VXo5RUd4aXhxSlhnOGx4bldUMmxyeFVjSDlIckhjK2hQN2lrOVZRUGtP?=
 =?iso-2022-jp?B?aHhuTGFhSDlwUy9FbVBpeWpUU0N3ZmZzL25yUTVvU2Y3MWtLWXZ0OHZ2?=
 =?iso-2022-jp?B?ZVJEMlQ3b01GeUNLdGtzSDUwSkw3NW4zcFl2WUM2VFFPQTdzN3JOOVoy?=
 =?iso-2022-jp?B?L0pNM3FFdUJsUGNDc0dXbklUcmFBamsxMFhoeWl6cHkwc3hwOW8xMUlQ?=
 =?iso-2022-jp?B?NVcxOEFheUV0bGRpWG9sQUZveHVsc2Z2T2JPdks4SkhGU2V2QnJ5U0FC?=
 =?iso-2022-jp?B?eHJDVXFyTVJzV0szMFB3MEJnWUplUWw5ZUREUVphNkowTldaRjBSSlNo?=
 =?iso-2022-jp?B?UkJTek1na3FPb094VnhiR2tDOGpTZTBrc1YxRlNheW9td0VOUnNCWmZJ?=
 =?iso-2022-jp?B?cW1tcDdOTkkxTVpGS2s1eGpKR04rT0dxdTNjTGRCTzMvaXdpTk1mVnI3?=
 =?iso-2022-jp?B?a2lKZ2p1S3hwVzRJbWNueVlZTzUzM3JKVG5wVHdqMmpob0s5ekExRFhs?=
 =?iso-2022-jp?B?MFZGVjY3ZTNGYW02aE0xRVN1ckprMjNYeSthSW1jTnFhaUhPaE9QOWpV?=
 =?iso-2022-jp?B?SVA1ZFZhTnZOU1dFVE9ncVE2MTkwcHdpOWl0Vk45S1ZTMDlIbUR6VWU2?=
 =?iso-2022-jp?B?Q2ZFanpFTEhoQjFML0lUSG9CYnJaSHRXRGREWEQwTzJwRTh6ekRtZkpL?=
 =?iso-2022-jp?B?ZUk0cTJwOS80eTZKcE5ncWlpalZQczRDaUNLbTNCQlhEU1lLazQ5cFFU?=
 =?iso-2022-jp?B?T25NZ2hZcmc3bzZJMjd5YnUvTFpXdE09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WWlJeGxreHh6cmd0ZUVBOUxPL25oT3JKWkNqMldlV1piZ0UxaXVYWEs2?=
 =?iso-2022-jp?B?S1VqdFgxZTJzanlGdUtTem1WSlNIYWdNWW1WVW1rYmxZZzJBRkFuYWN6?=
 =?iso-2022-jp?B?a2tyY1hLc0Q4TFdqQW1vQ244c01uT3p0eXdVTlhhcDRRRFdFWEhCYnZR?=
 =?iso-2022-jp?B?NERHME04TUxBcXFacmUvTHpVQXdtUG42ckVoY3V3VVVCN1N6N0E3SWJU?=
 =?iso-2022-jp?B?eFNoZk1yU2NiU3ZiV1BKT1ZmSTlESlR1WUpNUFB6RGxVTW83M2RuV0tB?=
 =?iso-2022-jp?B?OG5oeXVuUnlyNC9JSHlmUXpHSyszbWlEZjRMOWsvQ2labmlPRWZhUzlT?=
 =?iso-2022-jp?B?VUxzOEt5VGNWUUcxNFJKd3FSRTg2M3NYZkVmYWJRVzRDekxmMUtQMTlp?=
 =?iso-2022-jp?B?aGtlRC9EdmFHV2J2SnBnckFUMEswdjZxNGsvdEVqc0trK3NXanRjaUtY?=
 =?iso-2022-jp?B?UlI1S3VKSGp1aWFRbHZMTllNUjhQNnNLM1k3L3VPdFc3ZHNjcWptV290?=
 =?iso-2022-jp?B?L1F5a3pwQnhFeVZmVTcwT1loMDQzTGI4dFBmUDc2MkYxR3NmYjArRW5a?=
 =?iso-2022-jp?B?OW4zMEphS3k4eDJiQ2ZPa1BxMUc3VDVXZWJxbUtKQUFrajRvZWc3Q0NX?=
 =?iso-2022-jp?B?TFlxQVd1NHJLVVBRTThnU2Y1YmtCS2t6ekFYZ2FIcVBMMjd2dDkzS252?=
 =?iso-2022-jp?B?Mkh2enk1THVzSklMd0c5UG1VS3JsMDM4Vjh2UjJDcVYyTkI5TDgybytS?=
 =?iso-2022-jp?B?SFRabzRVQUk3L3lhQkFrbFNxS21tM2M3YmJlcTErU1U5OFVyWXNqRkpB?=
 =?iso-2022-jp?B?cUNPdjl1TitXbHdERW5nT01makV2QlhwUWs1aEhsSHJjSWNRa3Q2VUth?=
 =?iso-2022-jp?B?MzllSGpzWkh2bzJrWDBtbDdKUnNsaHYrZmx6Qm1tM01ReXhqYkV6K1VN?=
 =?iso-2022-jp?B?dEIxSjd4MXVDbDFLNzB5LzRWUlIvTGdCQXNTeVRFVjJicUoyN0s4bDVk?=
 =?iso-2022-jp?B?aTJwS0p4NkE1VTdaM2Q1ek5JazVHbndvRDJ0aHFlekRTS2VoNFlTQWRT?=
 =?iso-2022-jp?B?VE1jNmhld3dlUE1QdXBKNUR6c1ZkeEtrTFJsN3hPRHZRWlJLUXJtZVpu?=
 =?iso-2022-jp?B?Y2R5OE9lZ05WanFFVnlvenZPYkwyREhhQytyeFdiZTVRNHNMR0tGQTdv?=
 =?iso-2022-jp?B?TTMyTlNZWjlreSs5Q3M4RkM0UFp1eEVGTmtEbDl4YjRMSmQ2cW1ZTFQ1?=
 =?iso-2022-jp?B?VWVSUWc5WkM4WWl3VXVtWkE4c3ZBSWlLOTE0MExMZVhleWNQMXpVYVVD?=
 =?iso-2022-jp?B?cUpFemEyaXpvWnhPalZ6L25xQWhJc2g0VkMvanNXRVhJNlFTS1ZTVytu?=
 =?iso-2022-jp?B?bll4bFNyTTdnQlZ0WUIzKzdyd3dRMG9yQnB2c0xlTXF6UUNNWERJS1kw?=
 =?iso-2022-jp?B?R3lBeWZrR2xUTXlmNGNzQkpZMVB3aVEyY1JIVDRubGY5bEcxMnNVN2dh?=
 =?iso-2022-jp?B?MEg1SG9VNy9hd0tiN2tFUVNueUsvdW10T01MWXZRZVBlZVRURDVmZmVw?=
 =?iso-2022-jp?B?RUVMd1JBUE1Ddm9hNDhqWVAybks3OVB4aFl3MEI1dDRmSk12SjUrWWp5?=
 =?iso-2022-jp?B?a1p4NFF5L3dUTUk3blNNVXdZaXFqSllKSzFtaGNxRlFGMWprenc2enR6?=
 =?iso-2022-jp?B?ODVFQzZCK09PUlhJeWJHTytwaVdWSXd5V3k5Mk52SXN1NTVqOEFIOCto?=
 =?iso-2022-jp?B?SC9NSngzZWg0UlVUNm4ya25lblJ3ZStvbXplbmFpcVhBbnhGR0Vzd0lM?=
 =?iso-2022-jp?B?WkJJTlVjVWdLTnQ0dmo5VkxJbWV4RXZnamRXY3dYaERuWFZrdElOUlhH?=
 =?iso-2022-jp?B?ckg0YVl4R0hFYXZaV3F1ZVZSYzRRNTFERU5tUXQyTlF5bEt0S2pOL0c4?=
 =?iso-2022-jp?B?RWlJbHlnSU5ObW8vTW85RUNmc2NiNGY3Y3QzL1ZXNUEyRm94UExnRFpT?=
 =?iso-2022-jp?B?cHRUK1NnY1lWQU5ablVoSUY3aE41NU9EcUNVKzRTS0ZxNk95K1pBbEJJ?=
 =?iso-2022-jp?B?Z0JtOHA5SXpkdmpFV0xHdmh2THpWMC8zMW0zNWU3WDJJV291ekxwYXdT?=
 =?iso-2022-jp?B?cTk5VWFuSnV0NW9LWTdXdXM1QTZSZGtUM3VUbndiY3gwR0dQMEJCWGhZ?=
 =?iso-2022-jp?B?SnZaMjcrcXFLTll6VXltU21Sb1FYbE1jMXFFNWxSYURqL01RZHo2TVlv?=
 =?iso-2022-jp?B?YThQZytXL1NUMFRWNFB0RkhXbmRxUzJxb2dmQk1saGhtMTJKb0x6NzEv?=
 =?iso-2022-jp?B?bUhDK2NiVFRRaWgvc21XdEVKT0Y4a01Damc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1844e2-7f26-4305-bcd7-08dca09a79c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 04:40:50.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/vkEyxPVjYswH1l0gpStib4wkHCoQynVGA9fc9KsRh+tLVUtBOzD35BvEOvvnLyPDnGIRhx4e3UjGePBZ9+ZYX6ZxGk4x24g+Ly1aQbbgw+L6vI57fVM28P4t3+5QmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jul 2024 04:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16445

Hi,

> -----Original Message-----
> From: Paul Barker <paul.barker.ct@bp.renesas.com>
> Sent: Tuesday, July 9, 2024 8:18 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>; iwamatsu nobuhiro(=1B$B4=
d>>=1B(B
> =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@=
toshiba.co.jp>;
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH RESEND 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet R=
X
> checksum handling
>=20
> commit c7c449502b51c5b5de79f97a42be750b28f6ecee upstream.
>=20
> Sending a 7kB ping packet to the RZ/G2L in v6.9-rc2 causes the following
> backtrace:
>=20
> 	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127
> skb_trim+0x30/0x38
> 	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
> 	pc : skb_trim+0x30/0x38
> 	lr : ravb_rx_csum_gbeth+0x40/0x90
> 	Call trace:
> 	 skb_trim+0x30/0x38
> 	 ravb_rx_gbeth+0x56c/0x5cc
> 	 ravb_poll+0xa0/0x204
> 	 __napi_poll+0x38/0x17c
>=20
> This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
> wrong skb for a packet which spans multiple descriptors. To fix this, use=
 the
> correct skb.
>=20
> Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> [backported to 6.1.y-cip]
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Applied, thanks.

Best regards,
  Nobuhiro



