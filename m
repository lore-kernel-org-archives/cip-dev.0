Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3840CF6D27
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 05:54:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.5039.1727934842112592103
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 22:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=EMSPXYaW;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727934832;x=1729144432;bh=bcmvviPSjL9wYz0E1I7j5MzjksHer6dbuiE0g25
	i9/E=;b=EMSPXYaWLBDzeJgmsDNYm5Zo/DGvBr/1rZ/UmXWp2pwjQ9d5ZwnG47cHhcSy5AXzatQeh
	pTH2/W8vID7bVH6H1J4KpzYt9Wh3IwEhsLmTAr2Rj3swsgkkIlabH85HYo4e1LUFila4+PQbagHJT
	NmyVV1KCZlfZ0807JOCF/ditGDfJn1PligIc+VYYkC2Bne3jtXSbWwkpAi/oyglnIFGarIWiZG/ZJ
	wGQf1bRPpg7bMxhQuhS+GvFUESj+ZdOjhkjFgeiCb4SJiF8gM3wWXLtf02cX1F2AaMRmO5gTsuHeQ
	rx4l88s5+gpu1wSNfga+eBWxu8/rPLqbA+VjAKBCjw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4935rpRd639910; Thu, 3 Oct 2024 14:53:51 +0900
X-Iguazu-Qid: 2rWgZF6BTvHzU5cUxU
X-Iguazu-QSIG: v=2; s=0; t=1727934831; q=2rWgZF6BTvHzU5cUxU; m=CPhYU9TyxEORHBLN3pEwSGh0wU8dJYbT4jgwpYgXyRY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4935ro7W913481
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 14:53:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLsT3AKOxfgCtS9ysjKFhrDi/zRIeHlJogm5fZ3gTnKc7+4/vIhrbS4BzjWnAyHl7ujzqo2MQgP4aZtZX3PAk12F85/RVO9/keQgExpInz2nGYlAAn4x4DKDOzSaYYRla9RiZ61Xnxb9+edQCW4LwmWlqGAiqGvG01nzaS2OyKj3zLp5EDEeXYY08XRX71NeuVi7UbIcAHuRP767VLum2MuJ89gWMLWyi/nDCGeJF4iRDbujcCcOoOUYx5t33tt8TNPfxuFdxqWeCg8pmwXCiZW0z766ZVL45hOhussf0Di4Gux4BGOylfAUw+5JIQh6W06VM4sSfP1QK/cszm41ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPX7xQATUn3YnfvBLSCLwdq+m3IMl9j6Qj8NuXmOhJ0=;
 b=Nzhgg8oMCvbW2seyJQrSyjrCTruWiTwQENs0vtb8bm560q7nyR71rsOsfY51+IVJSEwyzq3Af/lHtdVWjl+Mg50pIu+551X7KYG47j+LNwQ7THjkJncRzR3jC6vMT4k/JxXyxClos7fOVjLSQk90M7IIBJhM05Vrhmp8E7/ieXbHRdGS9yS6CV/cmEtfY4aljQCkTWlx34ngS0DFuVEKuDpKfL3FnYvd78N+ZXl5OuHK+frIueiut/V50UPwT6oXV53MjCzib/vQ02grA/G/Ep2tnKBwXjIn4lAbel7aTefyg0c8f7/7iTK/LK+0BN8qnbgNZlJavBK5/yGj37ksXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex support
Thread-Topic: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Index: AQHbFO0rxOz58TtMSEi4yafvX7BySbJ0f2eQ
Date: Thu, 3 Oct 2024 05:53:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D2FEC41845ECFA6EBE2F92712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
 <20241002170417.655339-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20241002170417.655339-5-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSCPR01MB13480:EE_
x-ms-office365-filtering-correlation-id: 22cdfc74-1fc0-44ba-7ab8-08dce36fbfd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?THNOZHc3NWFlcEpzOHRPYnhBclRXQm56RTNsbDVQa0ZUU2JOVGZ1S1NZ?=
 =?iso-2022-jp?B?MEpzOUlmelBBTHlpclhSWGpPQlhocXMxektiajA4MUdFUzllbXhkL1lG?=
 =?iso-2022-jp?B?bWpMdjFRRGxUYnl1bzJEVUR6WHV4RzZJVDRxekZqaElHd0FuL2Y0ekE5?=
 =?iso-2022-jp?B?SjQ0UUxjSGJiNi9ua0pRYlpnd3NLcEtXNFdrVzVjNFJMdVY0QUhLTmth?=
 =?iso-2022-jp?B?UjYzSkhkaFFIQTk5alFVUmJVRGszNU1NcllqM1lzbWpDMmNMckhQK2x5?=
 =?iso-2022-jp?B?SXVQTUx0S2dTb1lEZmNMWGxwcEVuY1dzczMwYmdxVFpRUE1OTUxPUG85?=
 =?iso-2022-jp?B?WC9wSWkydjZrbzBtS1MvWWx4NFpOZGdaR0kxaE90TWk2bnh0YUpYZmNQ?=
 =?iso-2022-jp?B?S3ZXTlZqSHBPYWZOYUI4OGJxdVp4ZFRDTnd1OTAwdWh3WGtlZjJkNHQw?=
 =?iso-2022-jp?B?YjVhYnk1cXVhUFNTNERENEFHVEp3K0piZ1BoZGFyZUVVZTVocCs0eUtt?=
 =?iso-2022-jp?B?ZkMwVHhJUjFmSVJJbnpoT0tzbWNjcGcveDl0QjZGR0c1NDNiMFZqWFZX?=
 =?iso-2022-jp?B?VEV6czFEbEtVUHFmb2x3UitTbHlYOUxZaFdJazFNRmVTcXNKUGhIK0FB?=
 =?iso-2022-jp?B?MC9paExIMDJ4akc0Q0NIaUxqQVVVL2JaNW1CWDdVL1B0VWMydHhOSUhT?=
 =?iso-2022-jp?B?dUt2RGhvRGVvT0R2VmRWTGM5a0hHNnFOaFZ0UFdpWElnakZxNXg2ajhs?=
 =?iso-2022-jp?B?by9jSmZFUkpmQXpYQjdYNDBPUms3R0M4ajVhUHI3cjVIZ2lpWjZQcW5q?=
 =?iso-2022-jp?B?WXhOZGtEZXhxU0FLOFJxRzVUb1M1ekhvMG13K1M4ek00czIzZEcxSlBY?=
 =?iso-2022-jp?B?a0xJUlVJZUVLYTZOTWJ6VUQxVFh6anNKU3RzdlRNMmNpcUZYM0tDc0V2?=
 =?iso-2022-jp?B?TVMra0pCV1ZrcUtWbjRvU1NpaHNlckxjYkE4ODFwSElUT04zVC95ZXRa?=
 =?iso-2022-jp?B?eHlmc2hUVGRPQVJmY2VCZXMvcTNoZ3FISm5OMFpERE13ZVZPMUE1VWlp?=
 =?iso-2022-jp?B?YXFWdEs5WlBVN3FPaFpVZFBiWTRudUFsNFZwaHFJY0J0NnJ1WTJHWHo4?=
 =?iso-2022-jp?B?VFNaUzIxUGozcTJWMTFxSHlHQjIzU3dsZWJENmErZzhpU2VWbW5OY1hB?=
 =?iso-2022-jp?B?T2dyb1Rycm9mK0ZmVkc5WVlLNzdzVTYxK05VcENjdWdTODFGellxMDVI?=
 =?iso-2022-jp?B?aDljOVZZd1Vyenk5MFBGK1pINUNFeFkyUlNqWnBQaTRoRVp1dCtvT25q?=
 =?iso-2022-jp?B?SUprb2NsSkhkUSt6OG5DRmNsZWF6NlJtU01iMTdFMGVsL2lERE03cnNN?=
 =?iso-2022-jp?B?SGpOUUpsOFZETzRkd21TaDhHMnEvMnRHcEFFT045Mkk2alpsR003ZWgx?=
 =?iso-2022-jp?B?QTh5UkhhSDlGM3JQaU5lcWJ0VU13cUE0MnNuei9NWXdlaXp0Q2U5Q1Bn?=
 =?iso-2022-jp?B?dUdyOHZpWVh5R0psTWhoU0dFS0ZqL3gwRHpkSXZmT0FBc0NWT3hwOE5i?=
 =?iso-2022-jp?B?S1luUE1lQzh2UUJmRzliZU5oYnRZMzBaVitTbFBLY2dVK3J0bmQwV2la?=
 =?iso-2022-jp?B?ZlpqSFh5dWRLNjRmWmEzaEpxNG05SkZEVTEwZ2h5czY1Q1Z6QmIrSjFF?=
 =?iso-2022-jp?B?em5pTVN1NFY2YzE5b2l5Q09TWE9yWHRzQ1BTcjhZcG01eExEMnU4QVlJ?=
 =?iso-2022-jp?B?Smg0ekpENVZWWmlMUEZKcWtqbHkwZndsN2daQTRNWUxQUnhheStBZlV2?=
 =?iso-2022-jp?B?YmlzZmlTUlZnSURBZklQQXBJLzBlOCs1MHRzYklMSURzSWdCNWZ1WnlM?=
 =?iso-2022-jp?B?RFhrckUveFIvTFlFeDdkblpST0xZd1ZjMDdIMFRxMzM2dUJMZk1VNmJu?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aWRFMVlseEJtM1haYVVvcnArU0xKaWNsY0RodHE1VFNSZlhNK3lucXd0?=
 =?iso-2022-jp?B?dGJXMUtpejBUekMwQ1paYWJlQjVZdXZjbkU5cTRDcVpCN0VrNUthTmU3?=
 =?iso-2022-jp?B?Z3pWakJHN0JNTURNTUF4cFJFMjVaM1JucjljbHZ3MTVraW16ZzVUc2RB?=
 =?iso-2022-jp?B?Nm9tbTVoM2RzNFdqU1BORW5VbldXelYrS0dmNFpDU1NkcWpxVlVvYzJB?=
 =?iso-2022-jp?B?dTV4dmlCSWZlbjF4em8wSi9tbkpVbXVHZTFpR04zWFZIRXk5eUNSV0N3?=
 =?iso-2022-jp?B?MTJmbEI2blJIV09tc2RxdStBdEdpNlFsQTBWRTVINVBUU0NCWEhIVWVJ?=
 =?iso-2022-jp?B?cWZvZzRaZnQ1MzMxSGFXQ0FyajJpYUt4MFE5OThkek01YzNKM2pRaDg2?=
 =?iso-2022-jp?B?REJhWUNDTlpQSzJ1OEVseWw5OGFwQ0NXSDIrdnNuRE1EN29FbXQxeG4z?=
 =?iso-2022-jp?B?RWpMZk51eFo3bFRXazF6RExlYjhFVXlubEJKVjhyMjlHcE81OW5tQisw?=
 =?iso-2022-jp?B?blhYRWJPTkFXVHdzTWMxWVZvc1V1dlF5QkVhaDFwVDdHODdBOHBvMlJL?=
 =?iso-2022-jp?B?djZHaHd4eWJkeXlDQXArUmplSXlVZVFEREUyODZxZHVFWHdQT1NyOHJD?=
 =?iso-2022-jp?B?SW5zT1dJK1I4VEJUclBuV0UyVU1kbjVGcVI1cjY0WnZaczFYM1A3ZUFq?=
 =?iso-2022-jp?B?TExCUisrcERuSEhoa2ZNMTRkVno5WEZGYzdQR2FuTHZBRjFLbWd3Q1FQ?=
 =?iso-2022-jp?B?cENpZ2JoZjZlQnRONXRsK21pMGhtS3ZmTFJYbzcydGVwUG1XclI0aEZv?=
 =?iso-2022-jp?B?ZEN3K3ovaFZIU0ozMEpQRHRDWlBaYkVkRkZQWVlpZm8vdmdQak41QU1C?=
 =?iso-2022-jp?B?aWtJZDJ3VTdOeGZJTDJqbEhGdG1vNFNyWE1IMWVDdlNlbjhCdEppejNw?=
 =?iso-2022-jp?B?QnZBY0VJTkhnNUJ5cG9MZ21OTXNhNWxJcmUzTkhqM0lObjBBdmJhbGxJ?=
 =?iso-2022-jp?B?NFpyWDBmWjF4NVJRV3J0RXBmak81TEJRbWluUmRVMmhsTFNES3RxRFVz?=
 =?iso-2022-jp?B?YnlVYVhXOVNzWkJBdEVBOUdpYXNQdGlueXdXRGdhMnIzSGs5MFZINFM4?=
 =?iso-2022-jp?B?K3dxMFRudUo3T1NCM3lkUHNVRGtCZk16T3NvTTBwY3Y1aU5aWG9jNktU?=
 =?iso-2022-jp?B?eUNJMWZxeDNxdTVYaTJaYk16SmszWHR5S0V6T1RpTWtFT3l0TVJjcVo0?=
 =?iso-2022-jp?B?MmxHTUZJSk9TSFZkajVoclcyRDR4ZjJGbkFvaTEzWmg0b0FGcGt3VlZL?=
 =?iso-2022-jp?B?amRxTFQ3V2IrbkMyUytpSW9FUkVtaUVDbWZXVFNGR0hwbUpiS3k4VU9R?=
 =?iso-2022-jp?B?alRlb09aU3pVQUdZZ2c4ajdKL2gzZm4vVjZSWDg5RWhBK1BrT0pRb0pq?=
 =?iso-2022-jp?B?U05zczUxbkdCcTBwcFN5clVNbXJieGpERWRtVHorOHNHaVVPUWlUa2cz?=
 =?iso-2022-jp?B?V1lNN1Rsa2hzSndwck0xc203eHZBTVh0VWpNVDlWMVk2aEhobWQ3WThP?=
 =?iso-2022-jp?B?TkQvc2RHaWcvVmx6a0RTNEU3SXEvL3ZyL2lCbEhpajhzMW5MTXplSENk?=
 =?iso-2022-jp?B?TGw1MWY1SVV6SXFNVjdER2VjbzlnZVJrOGdEcU1DYVh4WTcybGxlRkV5?=
 =?iso-2022-jp?B?emxnVG1VM0Nob2d1a0dCdHBHd1V5eW5uMUcvT0xSSDBGVUZmOXNRSXpE?=
 =?iso-2022-jp?B?Zm0vU0c5Y2xVY0VObVFJN2RVaktsYWQycnBGZ2hVVTdheWYwZS8ydVY1?=
 =?iso-2022-jp?B?OVAwQVJkdW5COFFkQUJSbGY3V3JFNFgwYzZjUHgyQjJZZXZWOUJXWTMw?=
 =?iso-2022-jp?B?ek54L3d4ZW14SDJ3YWhyNnRtTFdTalZQTzJrQXczNTFrMC9BQkFmWlJh?=
 =?iso-2022-jp?B?d1VnVXdCYW9xT2ZYZmRwdC9FWEQrSnBlNlZCNjVqa2hKNU81S01sOW1h?=
 =?iso-2022-jp?B?SGRzMDhQR2djRVpWMDlFbDRwZjdDVUZtQlRCbTBvM1lBTkVWQlV0eVRw?=
 =?iso-2022-jp?B?YnJ5UElqM1d6VGY1M0pKMlhvNmJvSnRzL3pISCtSZ0FQNytVU0tZamZJ?=
 =?iso-2022-jp?B?SWZscXZBeFQzS3JjZ2llb2k3ZDg4bGpiV0s3dGJzZk9BWWhZY2JBbmlY?=
 =?iso-2022-jp?B?WjR0S2Q0YytQa3Mzb3dXS2t5YkdaSWpycVR6RmwvckMySTJuclRYYVZE?=
 =?iso-2022-jp?B?VzVwaGE2N0dWbUJxWVFROG94VWc3ZmxNNDJHUTBoN3R4Uk1icUpxU1NQ?=
 =?iso-2022-jp?B?V2crRXMwUUk5Mmd1UzFYMlVPckRWdkxnM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cdfc74-1fc0-44ba-7ab8-08dce36fbfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 05:53:47.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WliExnUBN3qVzMOv8LTAOAFbvF8y+ZpFHUOsi34c6JpsKhdUL2h9mXUY1bQ7hKBxTH99nw2DXIvkUCP04RStT10DCH3LOV/MGvJk1smRiK3PE+BOT7dnml/Dc/ePi81U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13480
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 05:54:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16983

Hi Biju Das,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, October 3, 2024 2:04 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex suppor=
t
>=20
> commit 4f8cd05a43058b165b83f12f656e60415d2ff5be upstream.
>=20
> Add full duplex support, to support simultaneous playback/record on the s=
ame
> ssi channel.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link:
> https://patch.msgid.link/20240715092322.119879-1-biju.das.jz@bp.renesas.
> com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  sound/soc/sh/rz-ssi.c | 257
> ++++++++++++++++++++++++++++++------------
>  1 file changed, 182 insertions(+), 75 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> d502aa55c5a8..6972b70baf73 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -53,6 +53,7 @@
>  #define SSIFCR_RIE		BIT(2)
>  #define SSIFCR_TFRST		BIT(1)
>  #define SSIFCR_RFRST		BIT(0)
> +#define SSIFCR_FIFO_RST		(SSIFCR_TFRST | SSIFCR_RFRST)
>=20
>  #define SSIFSR_TDC_MASK		0x3f
>  #define SSIFSR_TDC_SHIFT	24
> @@ -131,6 +132,14 @@ struct rz_ssi_priv {
>  	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
>  	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
>  	bool dma_rt;
> +
> +	/* Full duplex communication support */
> +	struct {
> +		unsigned int rate;
> +		unsigned int channels;
> +		unsigned int sample_width;
> +		unsigned int sample_bits;
> +	} hw_params_cache;
>  };
>=20
>  static void rz_ssi_dma_complete(void *data); @@ -209,6 +218,11 @@ static
> bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
>  	return ret;
>  }
>=20
> +static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
> +{
> +	return strm->substream && strm->running; }
> +
>  static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
>  			       struct snd_pcm_substream *substream)
> { @@ -304,13 +318,53 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *s=
si,
> unsigned int rate,
>  	return 0;
>  }
>=20
> +static void rz_ssi_set_idle(struct rz_ssi_priv *ssi) {
> +	int timeout;
> +
> +	/* Disable irqs */
> +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> +
> +	/* Clear all error flags */
> +	rz_ssi_reg_mask_setl(ssi, SSISR,
> +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> +			      SSISR_RUIRQ), 0);
> +
> +	/* Wait for idle */
> +	timeout =3D 100;
> +	while (--timeout) {
> +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (!timeout)
> +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> +

There is no check for timeout, is there a problem?

> +	/* Hold FIFOs in reset */
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> +			     SSIFCR_TFRST | SSIFCR_RFRST);

We can use SSIFCR_FIFO_RST instead of SSIFCR_TFRST | SSIFCR_RFRST.

> +}
> +
>  static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *s=
trm)  {
>  	bool is_play =3D rz_ssi_stream_is_play(ssi, strm->substream);
> +	bool is_full_duplex;
>  	u32 ssicr, ssifcr;
>=20
> +	is_full_duplex =3D rz_ssi_is_stream_running(&ssi->playback) ||
> +		rz_ssi_is_stream_running(&ssi->capture);
>  	ssicr =3D rz_ssi_reg_readl(ssi, SSICR);
> -	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
> +	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR);
> +	if (!is_full_duplex) {
> +		ssifcr &=3D ~0xF;
> +	} else {
> +		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN,
> 0);
> +		rz_ssi_set_idle(ssi);
> +		ssifcr &=3D ~SSIFCR_FIFO_RST;
> +	}
>=20
>  	/* FIFO interrupt thresholds */
>  	if (rz_ssi_is_dma_enabled(ssi))
> @@ -323,10 +377,14 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, st=
ruct
> rz_ssi_stream *strm)
>  	/* enable IRQ */
>  	if (is_play) {
>  		ssicr |=3D SSICR_TUIEN | SSICR_TOIEN;
> -		ssifcr |=3D SSIFCR_TIE | SSIFCR_RFRST;
> +		ssifcr |=3D SSIFCR_TIE;
> +		if (!is_full_duplex)
> +			ssifcr |=3D SSIFCR_RFRST;
>  	} else {
>  		ssicr |=3D SSICR_RUIEN | SSICR_ROIEN;
> -		ssifcr |=3D SSIFCR_RIE | SSIFCR_TFRST;
> +		ssifcr |=3D SSIFCR_RIE;
> +		if (!is_full_duplex)
> +			ssifcr |=3D SSIFCR_TFRST;
>  	}
>=20
>  	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> @@ -338,7 +396,11 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, str=
uct
> rz_ssi_stream *strm)
>  			      SSISR_RUIRQ), 0);
>=20
>  	strm->running =3D 1;
> -	ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> +	if (is_full_duplex)
> +		ssicr |=3D SSICR_TEN | SSICR_REN;
> +	else
> +		ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> +
>  	rz_ssi_reg_writel(ssi, SSICR, ssicr);
>=20
>  	return 0;
> @@ -346,10 +408,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, st=
ruct
> rz_ssi_stream *strm)
>=20
>  static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *st=
rm)  {
> -	int timeout;
> -
>  	strm->running =3D 0;
>=20
> +	if (rz_ssi_is_stream_running(&ssi->playback) ||
> +	    rz_ssi_is_stream_running(&ssi->capture))
> +		return 0;
> +
>  	/* Disable TX/RX */
>  	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
>=20
> @@ -357,30 +421,7 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, stru=
ct
> rz_ssi_stream *strm)
>  	if (rz_ssi_is_dma_enabled(ssi))
>  		dmaengine_terminate_async(strm->dma_ch);
>=20
> -	/* Disable irqs */
> -	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> -			     SSICR_RUIEN | SSICR_ROIEN, 0);
> -	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> -
> -	/* Clear all error flags */
> -	rz_ssi_reg_mask_setl(ssi, SSISR,
> -			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> -			      SSISR_RUIRQ), 0);
> -
> -	/* Wait for idle */
> -	timeout =3D 100;
> -	while (--timeout) {
> -		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (!timeout)
> -		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> -
> -	/* Hold FIFOs in reset */
> -	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> -			     SSIFCR_TFRST | SSIFCR_RFRST);
> +	rz_ssi_set_idle(ssi);
>=20
>  	return 0;
>  }
> @@ -513,66 +554,90 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi,
> struct rz_ssi_stream *strm)
>=20
>  static irqreturn_t rz_ssi_interrupt(int irq, void *data)  {
> -	struct rz_ssi_stream *strm =3D NULL;
> +	struct rz_ssi_stream *strm_playback =3D NULL;
> +	struct rz_ssi_stream *strm_capture =3D NULL;
>  	struct rz_ssi_priv *ssi =3D data;
>  	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
>=20
>  	if (ssi->playback.substream)
> -		strm =3D &ssi->playback;
> -	else if (ssi->capture.substream)
> -		strm =3D &ssi->capture;
> -	else
> +		strm_playback =3D &ssi->playback;
> +	if (ssi->capture.substream)
> +		strm_capture =3D &ssi->capture;
> +
> +	if (!strm_playback && !strm_capture)
>  		return IRQ_HANDLED; /* Left over TX/RX interrupt */
>=20
>  	if (irq =3D=3D ssi->irq_int) { /* error or idle */
> -		if (ssisr & SSISR_TUIRQ)
> -			strm->uerr_num++;
> -		if (ssisr & SSISR_TOIRQ)
> -			strm->oerr_num++;
> -		if (ssisr & SSISR_RUIRQ)
> -			strm->uerr_num++;
> -		if (ssisr & SSISR_ROIRQ)
> -			strm->oerr_num++;
> -
> -		if (ssisr & (SSISR_TUIRQ | SSISR_TOIRQ | SSISR_RUIRQ |
> -			     SSISR_ROIRQ)) {
> -			/* Error handling */
> -			/* You must reset (stop/restart) after each interrupt */
> -			rz_ssi_stop(ssi, strm);
> -
> -			/* Clear all flags */
> -			rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> -					     SSISR_TUIRQ | SSISR_ROIRQ |
> -					     SSISR_RUIRQ, 0);
> -
> -			/* Add/remove more data */
> -			strm->transfer(ssi, strm);
> -
> -			/* Resume */
> -			rz_ssi_start(ssi, strm);
> +		bool is_stopped =3D false;
> +		int i, count;
> +
> +		if (rz_ssi_is_dma_enabled(ssi))
> +			count =3D 4;
> +		else
> +			count =3D 1;
> +
> +		if (ssisr & (SSISR_RUIRQ | SSISR_ROIRQ | SSISR_TUIRQ |
> SSISR_TOIRQ))
> +			is_stopped =3D true;
> +
> +		if (ssi->capture.substream && is_stopped) {
> +			if (ssisr & SSISR_RUIRQ)
> +				strm_capture->uerr_num++;
> +			if (ssisr & SSISR_ROIRQ)
> +				strm_capture->oerr_num++;
> +
> +			rz_ssi_stop(ssi, strm_capture);
>  		}
> +
> +		if (ssi->playback.substream && is_stopped) {
> +			if (ssisr & SSISR_TUIRQ)
> +				strm_playback->uerr_num++;
> +			if (ssisr & SSISR_TOIRQ)
> +				strm_playback->oerr_num++;
> +
> +			rz_ssi_stop(ssi, strm_playback);
> +		}
> +
> +		/* Clear all flags */
> +		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> SSISR_TUIRQ |
> +				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
> +
> +		/* Add/remove more data */
> +		if (ssi->capture.substream && is_stopped) {
> +			for (i =3D 0; i < count; i++)
> +				strm_capture->transfer(ssi, strm_capture);
> +		}
> +
> +		if (ssi->playback.substream && is_stopped) {
> +			for (i =3D 0; i < count; i++)
> +				strm_playback->transfer(ssi,
> strm_playback);
> +		}
> +
> +		/* Resume */
> +		if (ssi->playback.substream && is_stopped)
> +			rz_ssi_start(ssi, &ssi->playback);
> +		if (ssi->capture.substream && is_stopped)
> +			rz_ssi_start(ssi, &ssi->capture);
>  	}
>=20
> -	if (!strm->running)
> +	if (!rz_ssi_is_stream_running(&ssi->playback) &&
> +	    !rz_ssi_is_stream_running(&ssi->capture))
>  		return IRQ_HANDLED;
>=20
>  	/* tx data empty */
> -	if (irq =3D=3D ssi->irq_tx)
> -		strm->transfer(ssi, &ssi->playback);
> +	if (irq =3D=3D ssi->irq_tx && rz_ssi_is_stream_running(&ssi->playback))
> +		strm_playback->transfer(ssi, &ssi->playback);
>=20
>  	/* rx data full */
> -	if (irq =3D=3D ssi->irq_rx) {
> -		strm->transfer(ssi, &ssi->capture);
> +	if (irq =3D=3D ssi->irq_rx && rz_ssi_is_stream_running(&ssi->capture)) =
{
> +		strm_capture->transfer(ssi, &ssi->capture);
>  		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
>  	}
>=20
>  	if (irq =3D=3D ssi->irq_rt) {
> -		struct snd_pcm_substream *substream =3D strm->substream;
> -
> -		if (rz_ssi_stream_is_play(ssi, substream)) {
> -			strm->transfer(ssi, &ssi->playback);
> +		if (ssi->playback.substream) {
> +			strm_playback->transfer(ssi, &ssi->playback);
>  		} else {
> -			strm->transfer(ssi, &ssi->capture);
> +			strm_capture->transfer(ssi, &ssi->capture);
>  			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
>  		}
>  	}
> @@ -732,9 +797,12 @@ static int rz_ssi_dai_trigger(struct
> snd_pcm_substream *substream, int cmd,
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  		/* Soft Reset */
> -		rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
> -		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
> -		udelay(5);
> +		if (!rz_ssi_is_stream_running(&ssi->playback) &&
> +		    !rz_ssi_is_stream_running(&ssi->capture)) {
> +			rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> SSIFCR_SSIRST);
> +			rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST,
> 0);
> +			udelay(5);
> +		}
>=20
>  		rz_ssi_stream_init(strm, substream);
>=20
> @@ -825,14 +893,41 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *d=
ai,
> unsigned int fmt)
>  	return 0;
>  }
>=20
> +static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned =
int
> rate,
> +				      unsigned int channels,
> +				      unsigned int sample_width,
> +				      unsigned int sample_bits)
> +{
> +	if (ssi->hw_params_cache.rate !=3D rate ||
> +	    ssi->hw_params_cache.channels !=3D channels ||
> +	    ssi->hw_params_cache.sample_width !=3D sample_width ||
> +	    ssi->hw_params_cache.sample_bits !=3D sample_bits)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void rz_ssi_cache_hw_params(struct rz_ssi_priv *ssi, unsigned int
> rate,
> +				   unsigned int channels,
> +				   unsigned int sample_width,
> +				   unsigned int sample_bits)
> +{
> +	ssi->hw_params_cache.rate =3D rate;
> +	ssi->hw_params_cache.channels =3D channels;
> +	ssi->hw_params_cache.sample_width =3D sample_width;
> +	ssi->hw_params_cache.sample_bits =3D sample_bits; }
> +
>  static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
>  				struct snd_pcm_hw_params *params,
>  				struct snd_soc_dai *dai)
>  {
>  	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
>  	unsigned int sample_bits =3D hw_param_interval(params,
>=20
> 	SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
>  	unsigned int channels =3D params_channels(params);
> +	unsigned int rate =3D params_rate(params);
>=20
>  	if (sample_bits !=3D 16) {
>  		dev_err(ssi->dev, "Unsupported sample width: %d\n", @@
> -846,8 +941,20 @@ static int rz_ssi_dai_hw_params(struct
> snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>=20
> -	return rz_ssi_clk_setup(ssi, params_rate(params),
> -				params_channels(params));
> +	if (rz_ssi_is_stream_running(&ssi->playback) ||
> +	    rz_ssi_is_stream_running(&ssi->capture)) {
> +		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
> +					      strm->sample_width,
> sample_bits))
> +			return 0;
> +
> +		dev_err(ssi->dev, "Full duplex needs same HW params\n");
> +		return -EINVAL;
> +	}
> +
> +	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
> +			       sample_bits);
> +
> +	return rz_ssi_clk_setup(ssi, rate, channels);
>  }
>=20
>  static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
> --
> 2.43.0

Best regards,
  Nobuhiro


