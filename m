Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81CC83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 22:40:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.3369.1753310398337049083
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 15:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=Swi2exSE;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1753310395;x=1754519995;bh=b+
	WdA+siWMo9ucwo9kkDr6l+AbZF8QuEzhWCoEwnhuI=;b=Swi2exSEXrq1qPQcsOZrOQEK04Xq59wp
	bHhpe26PNZHqAnEO37ETWlPAoYmji5MdLdsL7HkylXHOx9yvHEACmL7DciVW5ap6snCJ8EyWNHS9q
	C1487FZdjZsRsnahCd5Gu0iqq3dOA1WVBBrbG6JQRz5RjK7xIPdfB1DFfeEhr2TOB4Nt9FhsRFAaU
	iL4GnkfHaP89lH9Fles23Um2Emsc8U4aqZUWevk4X82fh9u0z9Do5lYZ9/m5fbmU9dOuDJv6m8Rrw
	zD3hKdIFqeSJPbl4eVIqZFsBUnrfXm4RlDMsCnIa5EsJnEzTcuZpHGXLuGvG7ZUCD6C/ePMdUXBJ7
	TQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56NMdsgV3132515; Thu, 24 Jul 2025 07:39:54 +0900
X-Iguazu-Qid: 2yAbRDIdxz4LsFYpr2
X-Iguazu-QSIG: v=2; s=0; t=1753310394; q=2yAbRDIdxz4LsFYpr2; m=zztahmcQ9CSTAb/Kwp0VXdGcRODBRBf5eKYhnGM+Sig=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 56NMdqZM2894890
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:39:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7YYlMVPeySh9afP00sOpUcu6Poy5WjGhnCpr23pAu89mJRM1C/Qx8xNXkaZmUm0iDN8k6zgY0VcnOMjcp1Lznbz/mtcwX6NEo8D88RB8o9yoqHyfM3RajYkVawqVx8KeQ4g+X0ZrWrjLiBwPK52UMja0BPcpRS1dnWu6CVaXtHl4Y8RMXcJKA8aNfmm4eohUjnb0yoiTeFkSyhGZ84wB+s70HtQ+nAueUYkHT5GLmEHPNfKhUxpP7iWRs68/vKfKmJyVto5Qubvtf2QmuBlCgU8PZ+45pnIPk6PP7WxznbB0GHvcNmzxtP2OSeXxyCi94douaAUG+uqyw+CiCMfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdBC4cydHBiLgcDhVAPeuJjc2UV+OyUkxV/Yqh+1VRg=;
 b=HcQ5MuWaE7mR6PvQLUPoP3CMy+stFMoav9URAf8Xrd82pLMRC/WkkUHX4zIHhp1XxhvjHwR6Mo4P4AwatDWh9nOa7TtUhw7UBNLfFu0GbeV6f3eiF8KMkWBMW6k10KnWXjPiN7caIAy4zgNwtLXL1D3rTNXbCsXof3GONhneR78qEVAcX6VOekqwr/6P82gQxSGNc45tBv6gXp+BpsSz8AhnMKb6YPp9+BAChE7j9JMSJZhTEVEGpDyEQ8l+FNMc/2ctwa71bKbEjrbWqtjdZgCEqYiMzfocbKk5h2JI9t2DfvkmXYi6SyJS4+zhUxnQnzt9IsJ3pWNxt+9qxlz/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat (2025/07/24)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2025/07/24)
Thread-Index: Adv8IqxojCmQZpg/TVOeg4Gsn1d97g==
Date: Wed, 23 Jul 2025 22:39:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481815867A23D912EF19E0C2925FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12774:EE_
x-ms-office365-filtering-correlation-id: 94fc4b65-b79f-4ae4-abc4-08ddca39d5af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QmUvbnFLNXlYdTl4Q3FBanBZYlVvVlFkT3lGazFMVmxzOHRuRVJXT2E0?=
 =?iso-2022-jp?B?T1dEa0k4WG1UaGlqODF6ZmhvV0tkR0VXWFlNMFRZUmRvaHB6WVBRbWVX?=
 =?iso-2022-jp?B?TFhxR3JzVlZSZ3lrRzZHN3czWFZDS0FycEI1RmVIdkFPdGE4TWVkZFhY?=
 =?iso-2022-jp?B?KzVBaG9LOVhmbUxra2ttUy94Ui9lVVd2Tmo0d0tHcG5lMUZabXlPbHVI?=
 =?iso-2022-jp?B?ckNkNk1pWGRZZzlwWVhOU2YwSjBZenZHdGllQUhjNndhVU95YmNBdEtR?=
 =?iso-2022-jp?B?RnV3S2ZZNURoeVhBZDMwVFRhOGsreU5GaCtvYTVWVkM1R09pR3lFSkNH?=
 =?iso-2022-jp?B?QzJ1cmhNUGNDSXpEc2djajNRM0FoUG0xL3haeEFuT0VPOXphcEVjQUFz?=
 =?iso-2022-jp?B?ZVN5akY3QlpCVUE5eWpTSWVwR3BtRVgxVkFlbDNsUkhpMUtWejFVdDlk?=
 =?iso-2022-jp?B?M2lYbjlzMWpiVzc3ZlhoME9JSG5Bb25Lb09OSmErUlZoVjdrZVdLY0pi?=
 =?iso-2022-jp?B?OVR6M3NkTmtZTkVPS29zN0lET0JmMFgxOXM2Uk96TnZ3aks0RTFtVTg3?=
 =?iso-2022-jp?B?bjFjMTJpYmpSV3VUaUpYY3hVTUllRTB6REJrNTduKzg5UnhLTjY4RDNK?=
 =?iso-2022-jp?B?MGgvQWNDcHFzSEtmeUV0Um9CdnhGOVFBTzgzaFJFTE16aEdvWXlLYk1Q?=
 =?iso-2022-jp?B?OEttM2JVN0Jjb2xNUmtvdjl6VHRLK2dqNFRVYkZ5TFdIekYwY1ZEaVpH?=
 =?iso-2022-jp?B?RUMyWXMzd2d0azY5YmpoKzRacFVUNmVISmZmb3hlQU5ZQU02LzJnbVpX?=
 =?iso-2022-jp?B?aTJ2bHlSQXcxTnJhZUc3aTk5QXB2UmFYeDI3Y2R4QVZ0ZXF1cjREelhR?=
 =?iso-2022-jp?B?YjQyV1V6OFVxbUMwQzBzbTZ1ZDhaRjBad2xpSWtxcEZVd01BS0lIazNC?=
 =?iso-2022-jp?B?Sy80ZWJUMFkwakZDcUxTOWNLcWZkMEQ3OWkrTjhJY01PbjgyekdqRkRT?=
 =?iso-2022-jp?B?VEt5OWQwSnB5bGZROTQ1Tnd2VStYc3BZK0RxdnlkaTFwQjkxM2M4VUg2?=
 =?iso-2022-jp?B?Mm41K0ZHKzJSZjVib1AvSzRha0ZGdTdiTUFibDYvMEhvamhLK2d2RHdy?=
 =?iso-2022-jp?B?UExMVllPU0RaOFhCOHp4L0ZMWkFieFBtMTVXbVFXUWRvay91bmpWeUcr?=
 =?iso-2022-jp?B?MXB3cGI2ZXJKNlBVWEd2WlkvWmhTWVFETGhZOGxTRU5MNGVvYzNVWFBy?=
 =?iso-2022-jp?B?VnhEOUMwNk1mbFdjOTNIa3NuSFh0WmdXdngwUWFITGttWG5ZQkdnR1dY?=
 =?iso-2022-jp?B?djFLakpNZ1dwOHpYR2ZxdEpiOTVrczY0SHBVS0srMnNxN0RXNmx4L0U1?=
 =?iso-2022-jp?B?UFpjWWtsRG1weFZRRVpYVkFBdnF5NlJ6cy9jU053TmMwdUVKdmxYdGtJ?=
 =?iso-2022-jp?B?cFdWOCtob2RQU24zV21LL051WkZ5TVdLVW1lYmErcENmaVRLUnFuSFJW?=
 =?iso-2022-jp?B?YldVZW03OFpNYVByRytQVHVrbHkwZlF3ai84R09Ibk01YWhQQ1VtZEhn?=
 =?iso-2022-jp?B?WkZXTnR0eDcrWVU3VEJ5OXMvZDRaMGJ2ZWVxYWJoTnhTYlptMGRNNVZC?=
 =?iso-2022-jp?B?dXFocXJYN1dLdTFLdkJvM1lQS0M5dzl0YUZWNWd5RmlaVHVzdU04TVBP?=
 =?iso-2022-jp?B?QzFJSXBHUWJHSG93RFB1WjJKOXR2bnFBRmdkMXk4RVVnWlRWbXgvbHVq?=
 =?iso-2022-jp?B?dEhWaytma1RVQzdZU0hTSzRzSGQ2SkdOSnpNbkZFRWpCQ1ZCb0JWZ2Fy?=
 =?iso-2022-jp?B?a1RBWWl1MHpkYit6RGdDd2pCNmZvU0lQNHl5ZTU3WXV3c1hsbVUwREpw?=
 =?iso-2022-jp?B?Nk43NDVjL1FVZXVPZTVNNUNBWHkzaGpuOThHd3MrZW5GRTZ1WVdDc1dO?=
 =?iso-2022-jp?B?a0crY0o0VXdFbWdPZ1J5WkdvYiswTTJlczFkYkhhYms3enVJTVlWbXJN?=
 =?iso-2022-jp?B?UGV3Yy9tdXZFbkNtaThoVnVrV1lER091TDhSTC85TlJMUm5tTVRFa01H?=
 =?iso-2022-jp?B?T09HN29wdEtaV3NBVVMwZlNmU1huNkk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y1NIdVk0L0pEd0VQTGJwWUNVT3Q0LytYMEw0K2JVM1g1TUhRVStBaHY0?=
 =?iso-2022-jp?B?U2JNYTlnMHdLMnpqeFpabGdiaFMwZzJ2Uk82UXc4REhDMmxua1N4bFBM?=
 =?iso-2022-jp?B?anVrZXFqK0pnVjNGWURZZXlFUTVyTldLL2gvdjA5WE1icjM3REZtRHRo?=
 =?iso-2022-jp?B?VFovYVdldGFVc3FHcHpMN2tqUVFpYldtZDBwQXBBemkrZCtabEdYOWpr?=
 =?iso-2022-jp?B?M3B1QlI5VkNGY0hkejNzVUs3UG1xRWxNaUlmK3lFMUN0TGJzbENjelpn?=
 =?iso-2022-jp?B?ZEJNWFhLaWxGVERMengrdjlkR2I5QnNwa3QzQmtYWlY5eG9oS25Nb0Ri?=
 =?iso-2022-jp?B?Q293Wlg2cmJST1pyemg1amZoRFNzblBCdFR0cjM4Y2hSZ0dVczFyWDEy?=
 =?iso-2022-jp?B?VzNQZ1hkV25nREZ5Mm1YdW0wa2NkN3FhR3hFSWdLQUxGdTJjV3QrbFg4?=
 =?iso-2022-jp?B?MW1nbDFFSHl0YlNhb1Jra3FmODJSOXFsSmxrUWt4K0xNWXcxb1p1RlYy?=
 =?iso-2022-jp?B?MHhNdituSHZVSGUrR3NuOEx2SkVOWk9lMVZaL0JQaFN3TDlEQjZobkd3?=
 =?iso-2022-jp?B?Z0xaUCtRV255RGVmLzlKRzhzbXJVRWxPZ0tIbDBGQ1lLdXJRVHJjajdh?=
 =?iso-2022-jp?B?aHdpajM3MzJCM1hFQ1FOaHV2OVM4SGx4NDNiM1Zmczhrc3pBcjdQM1J5?=
 =?iso-2022-jp?B?R09uRGlnZEc0TWttb0plZ2hBNWR6MHk3UTNOUkdpQXhaVElsYW03azlU?=
 =?iso-2022-jp?B?ME9lUEdYUXU1OVp6bHF2M2hmOFpTa1h1WFU3cFZuTStGY1RNNVk4UDRL?=
 =?iso-2022-jp?B?bkFQMHd2VEkyVzM4UDlqcW1MYUZaZXBLNTZRc3ljK2VCUndCd3JDUFBm?=
 =?iso-2022-jp?B?VmJ6NFpYd1p0V2MyVWFma2Z4cE5CSUlJK3MwcWR2QjBQQXE1b1hYL3Rk?=
 =?iso-2022-jp?B?eUhlMjRNYi8ycGtIbXFPbVlnYldCUnVkUGwwZlN1d3V4OWpkcGM3MXpj?=
 =?iso-2022-jp?B?RDRML2Z6aTROYm1wNS9XZmtCZVpaR3IyTC9Ib3Z2aGx1SzBWVlZBQXZK?=
 =?iso-2022-jp?B?a2tONGtsQzZLZTczcWVyb3FsQnFPRFlrRkI0bmZlS2tmSHNINlRjRktW?=
 =?iso-2022-jp?B?U3A2V1hMcVd6OGVCZmR1Qlc4MmxWMjVoRmM5bjBHRWo1NldEUFFmZno3?=
 =?iso-2022-jp?B?YStPc1FpVUQvS2ZNUWlyN2QrQW4yanR4NFhPbjJOMEMvcG5zTE9CUk1O?=
 =?iso-2022-jp?B?ZmdMbytBT3VnanNFNTEwMkpIMFpyQkcvb0c0bVFGZHlLMmxGY0lTV05B?=
 =?iso-2022-jp?B?OUVjVEkrRm1jalBzUDNIcnZkVGV3a2oyMU9ydXVWQ1RqQXdxM2ZhK1RE?=
 =?iso-2022-jp?B?UmlFLzZJME1rSDJKajZUV3RISDgvRVFxODdCTzVzLysxaTdxRS9QN0Zm?=
 =?iso-2022-jp?B?aVJMdmI3R1hHUmc5OU9LNlltbzR4RUUwUitvZisybmlMTjJQZ2J2Mm9q?=
 =?iso-2022-jp?B?QkVrNnZpYXNMK0lEQW9WSDFZSCtPWXVHYVMzZmwyR1IvOEtiOHJxSFlx?=
 =?iso-2022-jp?B?U1ovaHZadFpxQWV0Y0F5WTRrb2hZMGNYTWhHSU1TYWlsSmZ5Z3RlS0dR?=
 =?iso-2022-jp?B?Z2hOSFlJcURhQVJWNUZFbmEvaUdxQzdwWkJFSDRZbDhSQXN3T2xlWGVr?=
 =?iso-2022-jp?B?Z0Fydm16Tng2cEl5eldNY3IxZU8yQUduNzEvRUZGS0NOVy9xVWtGTHpX?=
 =?iso-2022-jp?B?a0wrSk5KajFVOGhlT0FrTkU1OHQvZURCTktHSW9vaDE0UENURGp5M2N0?=
 =?iso-2022-jp?B?TFM3bVQzTzZsRHhTSVpZMSs3NUZKNjcyV09Sc09FaHBrdTZjQVI2anp4?=
 =?iso-2022-jp?B?T2ZUNk5kQzRQLzhEWlNLOGJ2MEVxVVFOL1lzN2hzVThNYjJJeDlDUmRw?=
 =?iso-2022-jp?B?QnI5S0RFN2dxem5Ielgrb1ROMThONGJ6K3Yva1BLQStJaFRQeXlUZGF4?=
 =?iso-2022-jp?B?T1BzM0RoNUNQNjJCRmxHeVo4MWw5STFuYm53a2dzS1NTVWEzV2l4NmJ0?=
 =?iso-2022-jp?B?ZjdFUmNhVnVURUF3QU1iN0FDZW02b1RjdEExSldBQkRpU0ludzk5U0Mv?=
 =?iso-2022-jp?B?SXZWTVNxbm1Yc21yU1kxWmk2dzlTdUNjc1NnKzVaK2Jhd0tkVTVEMUR2?=
 =?iso-2022-jp?B?UVNRTjE0cVIvS2JmVmpJVGRBYmtjMlRoaHY3OFNyZUJySmFDZXVpeElT?=
 =?iso-2022-jp?B?dXBTbG5sV2h5VVA5Q0xJcDdTVnlySE1oWlJGZUFSb2lsaHB0a2M3LzZG?=
 =?iso-2022-jp?B?c0x5bWZ6aExLdHBiekVMcUdqYmpFUjFoZk81NzBJRUJMUFZkT0xmUy9B?=
 =?iso-2022-jp?B?M2VaQUE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fc4b65-b79f-4ae4-abc4-08ddca39d5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 22:39:50.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoVQyRpSG1Zsc2m8xSxGux5ajWvPsFo7waI2newx4bLdTQvcvxk+C1olKZ4WSIAaUGAgPYEWUQQlFiBSSPuV6uk/svLZUzlB6UNF18o6F0EftTRgV76M/e+IW0frFFqZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12774
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Jul 2025 22:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19577

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mont=
h=3D7&day=3D17&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/07/cip.2025-07-17-1=
3.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

Date the data is created: Wed Jul 23 10:36:52 PM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: Late
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jul 17 08:30:58 AM UTC 2025
  limit date: Sat Aug 16 08:30:58 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: Late
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 16 05:30:11 AM UTC 2025
  limit date: Fri Aug 15 05:30:11 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 15 04:51:02 AM UTC 2025
  limit date: Thu Aug 14 04:51:02 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Jul 10 12:36:09 PM UTC 2025
  limit date: Fri Jul 25 12:36:09 PM UTC 2025
  Status: On track


