Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78FCF855B
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:16:41 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.web11.5275.1727936191886067533
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ATqNSFlM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrEck+Sn2TXuXj+CJQwpnFBGAQgNcscRbOmans0REjnZln6aFJkIz/H5Wj2DNgUnW0QS9ZrKeGK7/laYuSydVzTN/g9Kdf1VHGQnfT9Ebt5mcwGyd8ntC8QM91l4VEA7dDnVFPFwbNDbnFGe36Zvd0+PnsYRxiVSGdxAg9c+3pNPdjSTWAHLlUDC+rej+ITWOUJIgoDy5nEBgqsSGDuP4yZgg44W8XMv6K5WH9me/lsFrqVpI2lomSDYDmW3hokXAi2Y/gUbZaf24E+qhhDQbGUvmuCeT7CuUu6GSK5edTbi6byFnx3me/Svijy7s9YDoBsrDoBJlIj0WI/YJQ+cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8f8gHLoSm+zW5Ql+8KOKHzrlUTsg7JgsvbYfJuqtsk=;
 b=DA9QDc/awchUoGA6+Pf9HcSoBQVCvhjiaoRf3V9xIf1o49s789fc+kVwQG3L4mXUWc+mitH7zWl7zffVyu+AlBtUmGzqHTnf9slNnjcDUyWLgq+Sn4/glPWv5q7Ja7VZHMqAbV+gtLBBP6l5r57oBulFLrIA/x+7TP8pYnUZK8gAo3ssaucYTQpunJmFdWC4ouIoOKhkLQidE7ocQBUoo68J4OWuqnLp/XtxHjzd1+N8DaOWMKAvkE4tKoalRqrncYdVc5ifTeYEiXYIAZ2nVbsin4IdK0nYhjTOoRgXSWAUF04GCZhVPLBGMwO9VTeC3P60gI+YeIoVD+c+N1EgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8f8gHLoSm+zW5Ql+8KOKHzrlUTsg7JgsvbYfJuqtsk=;
 b=ATqNSFlMVANcQyr4OfOzvk7HmWjHpYTQWFSX6ZNInvivIJKKCV0URB1LEjaE9e+AT0aFNm0uDAHzoNHAJBClJ/qVmwQvDNBOdy3GOEB7NFefuSRP0b8bsUY42vuPu9l3DauU6tLsMpEhTiuNjqW/YV98ge0ErJQijDYAzRfSMfI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB11616.jpnprd01.prod.outlook.com (2603:1096:604:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:16:27 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:16:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Topic: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Index: AQHbFO2SKWzNr7RhIk6LzGZWXt+VObJ0iZ8ggAAD7YA=
Date: Thu, 3 Oct 2024 06:16:27 +0000
Message-ID: 
 <TY3PR01MB1134664022A032DE021D32F9E86712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB638837327E5487B71D88A70392712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638837327E5487B71D88A70392712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB11616:EE_
x-ms-office365-filtering-correlation-id: c419579f-0b2a-471d-38f6-08dce372ea2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OVE5MXAwalNITVNjVXl3V3V0dStjRk4wdnVPc2FxdFkreVpWM05OckdR?=
 =?iso-2022-jp?B?cGFCWjQzWEYrOGdCeGVYSlgzODZ5SnpRSmJ3cmUremJKd0JYaVFjQ01E?=
 =?iso-2022-jp?B?WXM3endrTTJCdzV0RGczMFZEdE02QmJaN212eXprU3FST2RtL2pvbGRz?=
 =?iso-2022-jp?B?WWxvT1NuY0NqbXh4eDVwbUxvL2Q2S1ZDa3VjeHMxc1I3T0t2Z1E1YmdL?=
 =?iso-2022-jp?B?THdGeXhReXRkWUxZaWo1V3VKckFoQkQ1ZW9tM211YWFrWVVadm0ySWt2?=
 =?iso-2022-jp?B?aVRCSlpic3pxL21KdkZoU09NbFdRNlg4Zm84UG84TVVzb2s3OXQyZDB6?=
 =?iso-2022-jp?B?MXNHSmtHTUhVM0kyclAyS0RFeVJvS0tPL01obUpYcGdUTzM4SEFzUEVG?=
 =?iso-2022-jp?B?NjY2dTdyVmltTlpSR1NCREtrSmY3MXppZ3V4Q3ltaG1iWndxTUd1OUhV?=
 =?iso-2022-jp?B?NmNIR3RleFZGVUdOTjdYdTB1SmN2T2hnRWtTa1NwckJMNXBRU0IxdWYw?=
 =?iso-2022-jp?B?SlROZ1BYUG9yV3dzVGFleGxZRWVuL25xVVFSTnNScW9obHdQT3JpSDVi?=
 =?iso-2022-jp?B?U2tiSzhXbWFYV25rOW5mWWRjbUl6MFlQckpRWExhbHFucnUwVndyS2Ra?=
 =?iso-2022-jp?B?aUV2aHNON0xSTFR2cjkrNTU3ZUkyR25BTHlsUjRTUTlOczlsQ0ozL0d6?=
 =?iso-2022-jp?B?MWRBVE9KaUdrckxaNmd1VDRnZVNpRkE0ME42bFpFTGdDQmRCb0JvYWVv?=
 =?iso-2022-jp?B?bUVNLzdpQi95R3RVZGJQYXNtRXFsTnhBdEVZUVY2YzVvdk82UU81OGd1?=
 =?iso-2022-jp?B?TTBNWG9FNFJrR29ja0crVmVJOVRRaWpUVG5VOVVONlZ6NEZWMzB3NDcv?=
 =?iso-2022-jp?B?U2d1YUdhQlZwTzE4SmtibE40Y2xSQ3ZGMG1jSm85dmFpN1ZrWGJFMmYy?=
 =?iso-2022-jp?B?MnFOcDNwTDAzTG9JaWQ1RWRYL2xvaHVUaGVNS0pvWGRMOUk5UTdxQW41?=
 =?iso-2022-jp?B?Y0lQNUpacm9UeWlkVURJRVVWOWtEZXZ3NXVBMVFuTDQzZlZPS1Nna2U2?=
 =?iso-2022-jp?B?ZkF6aGYvTEx5a3MxK3czYURSSEtMaDNjdG1HQ2g3UVBjSCsxcURrNTlj?=
 =?iso-2022-jp?B?NE51TkxjWk9Rd0J2eXc2RkxpbS9NdEdLVVNtWlVRS2V5a2xiV09LSkhh?=
 =?iso-2022-jp?B?K3pUVkpTTGtXUHNNMTZHazN2RDlNd0w4bGp3ZnJ1SWg2czlwQUFSM0VD?=
 =?iso-2022-jp?B?cFl5RHh6WGgvS3NnazkzSERBNG1NNCtCNHFML01wUEhmNWFhWi93QmZQ?=
 =?iso-2022-jp?B?dVFnRENGamxscmlLWTRnQ1hwNVhEQ01aaGk4QzF6S2tSR1UvUnZyK2di?=
 =?iso-2022-jp?B?WnVPdDY5dG1Ea1M2NzlkZUovK2JLaDNydEhjdlVlRnNCOVBWWjFBc2JT?=
 =?iso-2022-jp?B?UnJmM0ZVejVMa1ZTZWVZeTRyZ3hpQnVCcStLN3ZuM2VGb2Vwbk83SkU2?=
 =?iso-2022-jp?B?bFVhWlNiWVo0QUgzNEVySmMxL2JnejFlaktvQ2FFWjFDWjVaR0pQVVRQ?=
 =?iso-2022-jp?B?WGNDb1huK3B0Q011T2hXRXY0eTl4ZG9aMUNvNWFVU1pReTJPeTNkWlZH?=
 =?iso-2022-jp?B?bVZ0VCtTSXIxaWxONnRKcmNTcDlCWUtwa0sxYXYzd0JkNnc1eDZ2UlZy?=
 =?iso-2022-jp?B?a3hiS0pCM215UjRLTFh1VE41RUpwdGN4MStIYVNhQkJ3YnhQbTh5dUZJ?=
 =?iso-2022-jp?B?cy9VWHk2WlQ1NGZlRnF1eVRHRExPYjhBeGZidDVrdzJFV1pQVHdRYU9S?=
 =?iso-2022-jp?B?a3Y1RHlKckZ3a2ttc1NhU0VtM0owREEvdGYySDRsRzlGZmNkSFR5aUM3?=
 =?iso-2022-jp?B?Zk9IQzc3K1Q3SkVxeTIydWQ1Zm9pNmZpWm13UklucUV3dy9nbTRPZGJt?=
 =?iso-2022-jp?B?aU1JUWRvVlRidEZGVEtYbGZiUG5NUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UjJsaXBJcm5QbFpoNW5aMU5hb09mV3JRdDhpWCtjNlZvcVhwSGhhT2JF?=
 =?iso-2022-jp?B?ekNSWXp5UENBSXl3WUYvL3g3dzdxa3gwYWxWczUwT0VoNm40VEVySFFy?=
 =?iso-2022-jp?B?cGZ4TFF1WXhNTTA5RHB6QUVxSThvRm93Njgrb08wK0tSemQ2L0ZqWFJB?=
 =?iso-2022-jp?B?SDFrWHRIWUMzRG9GSnU1S2JWT1FFY1dWNFJaTFp0WDk3akdzUHRBcDJ3?=
 =?iso-2022-jp?B?NzNZNVFmeENzNVY4TFYwb1dxRUcxRGo0a3FVL3c4RVhPZXNEYXh3STdv?=
 =?iso-2022-jp?B?WE9BSnZ0K2VHMzd6VExhQjdtMmc2am4yN0RyeE11dXgzN0R2K0h4QXd6?=
 =?iso-2022-jp?B?NFlwdy9MR1d3Q3hwRTdmVXVVZkdHNWgydGd0TC9FN0JUODBhVnQxekpw?=
 =?iso-2022-jp?B?Vk9mWWpDdzJpNkJRcjdaRVdCakxRZVF2UWd1OWFxSVFyS21NdHdHYTMr?=
 =?iso-2022-jp?B?Z1RRN0Q2di83NkJ1amRkbm5ER1diajBrM1E3STNMYzhDaENPSDkwM2tp?=
 =?iso-2022-jp?B?Z2tlYVEvdEozZlNSSXpmcjJKTERaWndEZFlmRWllL29HMUY3amF0Nmt4?=
 =?iso-2022-jp?B?WkZGU0U1dmVpTlhtUE9MTlJVMWRzUDltK1I5VnIvSUdsZ3hnaGlpOHl3?=
 =?iso-2022-jp?B?Skh1VDRnNUxrRDdkMGNEM0NrQVpwMzVzb2ZVOEJMWXBVN29tM25vNTdB?=
 =?iso-2022-jp?B?MGEybm5UaGU5c3BNZEFWZGJZaGh5WFVIcnRqbVloRVU4QzBzcDJFY090?=
 =?iso-2022-jp?B?RDZRSDNpTDZEWlVzODZEWjlldWNzcW1OQUFHQkh0b3RlMk5Gc0pQcWVi?=
 =?iso-2022-jp?B?VmZtMk5pbmJ4N2Z3ZnZxcTVZSUZrSEVhSnlmbVlPWnZJV2ZCbHdDeUNh?=
 =?iso-2022-jp?B?ZGFXbTU3cTVEenhoUmZacU9FNVo1RGY4Tk5aVWMvbUNRQVJqWTJQdzBk?=
 =?iso-2022-jp?B?aVhRUmxvWHc0bXhrVGlqZEVkK202OVc1WmJBQ3FQbFYyUFgrWmF1VGNq?=
 =?iso-2022-jp?B?RTIyZW92SGNFbGNVT00zcXMyN2I1Mm9UN3FkQXhoQzI5VlZaVmVjR0Rw?=
 =?iso-2022-jp?B?TDdyM2FZOEpNd2ZMUTk3ay9taXRqUHRSL3BkVncrVjJ5Z0hHMTUwcWdM?=
 =?iso-2022-jp?B?a2tLelhLU2tUclR3b09yeERwOHQ3Vm1ZRytGR250eDVsVlZubnBmaVhO?=
 =?iso-2022-jp?B?eUZuTXZVOXB3YlNsV3hsdGU1ZlVOeW1ldGVyUjV3Wmtiek9LS2cxRHZJ?=
 =?iso-2022-jp?B?ZmN5QmpGaWszbEUzM0lBZE1tMmZhRWtnUGd6NGQxeXFlRndXemxNeFVN?=
 =?iso-2022-jp?B?bjJ3TDl4OEdwM1R6cEdvaDlQaG00N1Z4S3VoNkVpaGxpeHdzWEdhamZU?=
 =?iso-2022-jp?B?bVBSaTZZVGQ1Sm5pQTEvWVMwVHh5eG11REkzdGViWHVJRGI5eTVrbU4v?=
 =?iso-2022-jp?B?VHJwZHVtdHhYNjZnNVE4dFA4RU4zZGVTVkc1QUxxaWVjdzcwWkN0Wi9z?=
 =?iso-2022-jp?B?MDFzZVplZWNER0lLeVVQSVJwVW9jekpmdldoaWtXVjBFeGpuNThIVlVD?=
 =?iso-2022-jp?B?NmVkSjg1M2VheERoMDk5VWU2aTMxeGpEd1htZVA0U01LS1lodnREc3ZE?=
 =?iso-2022-jp?B?OWJVZGpwTmgwK0lNTnVRRmxwZWNHZ1hKYmlCYWhDQnhtYUhjOVdySXE3?=
 =?iso-2022-jp?B?aG9Dck4zZkxkWTNsSXdjQytEd08zcTNzN3lQemN5TkpOOWc0Yzk0bFZF?=
 =?iso-2022-jp?B?K21lK3R2YW1xZG9USDdESmVYd1BOR2dWY2E2KzFIWjlNSHRtZXhZdFJl?=
 =?iso-2022-jp?B?YjdBdnc5L080MGFQSUNqOG5EdHE2TnVFUFpIdEo3TnRldU1TeGYzdjZa?=
 =?iso-2022-jp?B?NjJjVFQ3UnFKMzlGMnpZUmhBL3NobGFqYjYvSkdPQXFFZ1dEZlRQbEZT?=
 =?iso-2022-jp?B?ZzJTT2psM2VERytTbk9UYzBsTyt5NTFaMTk3aEhoZVhmWURkZTAzdG1r?=
 =?iso-2022-jp?B?L1RhV1RKUzdCMHc4L0VvN3NBdEE1SWxhSGF6QThEVU9ONk9zbEdZdndt?=
 =?iso-2022-jp?B?V0ZGUnBvdEovdm9FbUM0NGt1Y1VjV2M2L2NTaG9DUktWL3NlUkUySy90?=
 =?iso-2022-jp?B?TEhyUTdwY1FKSVNEQ1R3NzJTTENOQThJdVF1SjBPRjVDeWdQNVFUTmJR?=
 =?iso-2022-jp?B?QWJ2eWJDN2cxekV5ZzIzRmNJVXJvN1haa2tOdEE3eHZqRVJ5ejVwYnYr?=
 =?iso-2022-jp?B?eFJxMXBSaG9sNFl3ZFQ1MUdKQndEZ3ZJK0pOQWZzVFRsMHJqd1NuZXdZ?=
 =?iso-2022-jp?B?V3FvYXEvYmFiUm9peVVwQi92OUYwSVlaeWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c419579f-0b2a-471d-38f6-08dce372ea2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:16:27.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es3YlaBeRa8y6Z5OI5a97SVzKIQ6nvP5hdOoPBblOg6wn/M4PcwRSvm1+5qfA451sykIG1Tprt1SNkZM8jf3T81aEqHKpLO/BljykjreWvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11616
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:16:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16986

Hi Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: RE: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use dev_er=
r_probe()
>=20
> Hi Biju Das,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, October 3, 2024 2:07 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use
> > dev_err_probe()
> >
> > commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.
> >
> > Replace dev_err()->dev_err_probe() to simpilfy probe helper functions.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.c
> > om
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37
> > +++++++++----------------
> >  1 file changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index c4d9bcb6f80f..7306a100153f 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -2200,16 +2200,13 @@ static int rzg2l_gpio_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >  		return -EPROBE_DEFER;
> >
> >  	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> > &of_args);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "Unable to parse
> > +gpio-ranges\n");
> >
> >  	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
> > -	    of_args.args[2] !=3D pctrl->data->n_port_pins) {
> > -		dev_err(pctrl->dev, "gpio-ranges does not match selected
> > SOC\n");
> > -		return -EINVAL;
> > -	}
> > +	    of_args.args[2] !=3D pctrl->data->n_port_pins)
> > +		return dev_err_probe(pctrl->dev, -EINVAL,
> > +				     "gpio-ranges does not match selected
> > SOC\n");
> >
> >  	chip->names =3D pctrl->data->port_pins;
> >  	chip->request =3D rzg2l_gpio_request;
> > @@ -2241,10 +2238,8 @@ static int rzg2l_gpio_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >  	pctrl->gpio_range.name =3D chip->label;
> >  	pctrl->gpio_range.gc =3D chip;
> >  	ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "failed to add GPIO controller\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO
> > +controller\n");
> >
> >  	dev_dbg(pctrl->dev, "Registered gpio controller\n");
> >
> > @@ -2325,22 +2320,16 @@ static int rzg2l_pinctrl_register(struct
> > rzg2l_pinctrl
> > *pctrl)
> >
> >  	ret =3D devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctr=
l,
> >  					     &pctrl->pctl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "pinctrl registration failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(pctrl->dev, ret, "pinctrl registration
> > +failed\n");
> >
> >  	ret =3D pinctrl_enable(pctrl->pctl);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "pinctrl enable failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
> >
>=20
> return dev_err_probe ?

Good catch. Please drop this patch. I will fix it in mainline and then back=
port.

Cheers,
Biju

