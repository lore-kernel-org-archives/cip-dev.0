Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A25EE7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 09:49:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.11866.1734083389662425386
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Dec 2024 01:49:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=rJnFv64j;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1734083387;x=1735292987;bh=ojM4olMK3xzl2g546tyoMpCgBVGeVIQ5JopLE8D
	20Kk=;b=rJnFv64j4qLdPDfi8lbo71f0jwKVGsFnczt4U70f4kVsJXBm1SOtK+OA+Mz1wP99QQlCR
	oWE+evwcE+B42+aEFKIdAEVkzIVO6qJaa88loDCzyw2XNRFnVVqDf/i5N9hlUvhbYxCHEoFdzXvmV
	Fz57ylxl6X0q24mbVHONqO5+OuQ0jRcObm785giCRc1mq9yeMcMw3R4hjVmfOFdhQy9RFJKbtwIQB
	VD/t52aS21sZrElIJnI3UQ0ZdAM96deMmwk2brwOxPUp8/3rFUfrt6/qYyWJ02oT79+HxJ6qB9cz3
	h5x8aNDgkAdeGafkWg9sodarK4JdGbXBBPMmC4z1lA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4BD9nlV6436336; Fri, 13 Dec 2024 18:49:47 +0900
X-Iguazu-Qid: 2yAbJ3LJ0KKSckc0Gv
X-Iguazu-QSIG: v=2; s=0; t=1734083386; q=2yAbJ3LJ0KKSckc0Gv; m=1i5fB06wqQos+ka6fWoduFxRrf+vISWEz9TjMkVRGKw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4BD9nkWB884957
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:49:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD551ehbHho1TDIKZCQapKYWOwdpKmhOvJTKLzlFv+wlj9RaVEY40fCgM9yrxNu3rsbxlbUePRn5XcfD5LXtxSWnLuEkSfj89KDTxeLMz5L/FRMPe8gHegBPwsyGV73X0YHuieuFh3rh5FSPIpCvSc6gjgqC/sYABC/MdjNdHryYcOljAZBkzxV4mrm01uz7Zw6nTSkaCzOJtIyDM+AXSayPSFjXJa2ZVPypp5Pis3aWzLNls5qe4scfYDo7IQKxWwJTBBcUqdK0/xgsf99ay3jFr+2eHNXbuoC/lcF0awdtIyMZ6rz1ivTcI7ILbEwGJ/NiLILnO3iIgsLtLZk6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojM4olMK3xzl2g546tyoMpCgBVGeVIQ5JopLE8D20Kk=;
 b=j2B1fRlT093sCVmBXwo+gvSGAL29+leK2tgp0nEvHdUJ58G03ZzGl+re3YVfzxA9gYtldCF+P6pLhYOfdFMED0sCrRkFRvhD+83LJtE1qMHTRM3NZF/lKA44BTM5m/T1DumFgA4zedAZk6fjJ0M8Tzhg4UDeV8cChqI6Pg8fmdEEJAIt6anI/wdwSerzThuznJ7/X2/4M6YPgLSQTTh5j5d0ofHuJKI5g81byxL/FtHqHw4sXIHSXtquCxliZiUbd/tq4iIsv3ReMk/mIeBdkzYxYxZh6xaorjuvsBnOWZQg9NQWrUdkkml46CGAQhcBC9ek9dGQwqzAea9TjaLGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaA=
Date: Fri, 13 Dec 2024 09:49:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB113859B1623281176F6A0FB25E1382@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
In-Reply-To: <180D3C69AE13A59C.18476@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TY7PR01MB14458:EE_
x-ms-office365-filtering-correlation-id: 09caa3ed-0ef8-4e31-1d17-08dd1b5b795f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?c3NDUmREU3lpZzFHbkw5RFptdjFnaXBTS3IwTDBtVTU4L2ZoVTQrTkJs?=
 =?iso-2022-jp?B?UHZrOTZBdGViNUt1MHFWZTVmYTk3S2tiblJPQkNtbVdub3Zqd2R4WUsy?=
 =?iso-2022-jp?B?NVU3LzJ0SWRjTGd1ck1NZTlON2Z4OGFqRGp0UWFiZlRRNUNLSEh4YXRD?=
 =?iso-2022-jp?B?WFhxNU9GRllURi9wVWhmbzJoamJOT0J5RTVMSERQN2M1Y01Cdm1hbTdU?=
 =?iso-2022-jp?B?VkFmWTlFVDdnVnV1MEphdTZ0TVQyRmNGajBPeGREd3JhM0duTi9VcUhE?=
 =?iso-2022-jp?B?emNyak1NMkxTeHhwSVhEd0xGYUJKS09EN2ZGSURIZHZrc0VPTWMwZmlM?=
 =?iso-2022-jp?B?d3lCU01hZnhCc3Q0NU4yQ3dBQWlFOEFFZ09lb0l4Ui9qSEp6WS81Y004?=
 =?iso-2022-jp?B?Vkh1NGlhZXpFQ0hlMHN1Vk1tWVZ3N2hFZzlVSVZpSFVZYUw5OHpJczI1?=
 =?iso-2022-jp?B?UEUwa2FmQndJcHBTajI3T3BNVVh1MXdnUlg5TmNJWjFheUwrOWpyR25D?=
 =?iso-2022-jp?B?aEEyajFxWk4yeUNnenFLQjRLTmtFemhEdE9sOXEvSHZubzgyZmN0dnBF?=
 =?iso-2022-jp?B?QmZ0YXd1d3lUMDd1MS94elcrVEVXRVkwd0ZYWjJqUVQ2aDB3U2F3WmZa?=
 =?iso-2022-jp?B?SnBvVXFBK1lxVU1DRW5GZ2l0NWlpakhEL1h4VmtZemdVd0R0VlhLTGRI?=
 =?iso-2022-jp?B?eXMvajRCQ0U2T2hGKzZBYU1tR1JYTWcxSmVVTDhwTGRoeEMrSUFtbUJK?=
 =?iso-2022-jp?B?eGM4QjU0YXZCbDBPMXJOTnFFSzJhQXp3NEFFdkNZWjI3bDNYenBsVWtR?=
 =?iso-2022-jp?B?UDhqYzdUbFNHZGQxUG9iUFMwQk9GYzNzSXYwcWZLWlRISGNyQzlxV21z?=
 =?iso-2022-jp?B?S1g1cXg3YXgreXJ0aTZNZDFabG05MmtCeHhxSVpyUUlvY1ZON3YxM0ha?=
 =?iso-2022-jp?B?UlQ1TVRLUm94d3R0MmNRSUxiRlcyWkZkYXRGdzlydldicWRjeGUvZTdG?=
 =?iso-2022-jp?B?ZHNVcHd5dDhJd3RhWWJabnZsOWNmT1ZjZ1p6U21manJuVTlTZzd1cHN4?=
 =?iso-2022-jp?B?eUxGNnl1R2dzWVloU29oNG1acWM3SnViUHBZVVg0TVlsZ2N4Z1BjODNU?=
 =?iso-2022-jp?B?OEh5dUlVS1J2Z1BFS0d4b0Y2QjdPTkZqRE1LQ0t1V3NjdTIrVVE5TWdX?=
 =?iso-2022-jp?B?LzV2ZnJkWnpMQTJWdHNtSjVUZVhNeGoxelBjb0MyZjZ1SG1yTFZkQWVi?=
 =?iso-2022-jp?B?SnRNVHdxcEEyMjFRN2JZK0lpcks3SkRWakw1VWxIK21SdjQxdStldGJS?=
 =?iso-2022-jp?B?Unh3ZWJoL3cxeGRMdFJlVjFjWVJIRVdnaUdtRmQrNE0vMjBaOXFTeENZ?=
 =?iso-2022-jp?B?YUEyREhOYUVtTXJmSXNLaTNlR2FFdzVmZDIwbUp4SGhCZDQ2UkRKdnlv?=
 =?iso-2022-jp?B?a0M0RVdaZVBjWHZhRm1pektLK29TcmpubDcvSnFFWVhpVHRWMm9NMDV2?=
 =?iso-2022-jp?B?TitaVFVVa0R1clR2TTlteFBHclg2S3o3eC92T0tCMEFkYk1tVktZWG9H?=
 =?iso-2022-jp?B?Y3lwTVYvL3M3TDBCbE1sa1ZsRkFpSHNUZVlic1o5aVE5T1M2RURuZnJt?=
 =?iso-2022-jp?B?VjNweXFMSjd2Umg0R1JuaUJzQldaaTBKRjFSc0JuWlM0MDdWbURDSFJa?=
 =?iso-2022-jp?B?YjlOL2lnMUoyeEZwd3l5ZlM2YjNGbjNzNlpWZ0Y2RncvVkRpZEhrQUFY?=
 =?iso-2022-jp?B?VTRnZS9BbURmUk5zc25KTGt4TWRsNXkvaWc1M1hxTU04bkpHOW0zdGIw?=
 =?iso-2022-jp?B?cURSdHNUN1NqQ2VGdGpPN0duakRKMWl2ZUFEeHBQMFNhWVhpeUFlQlpS?=
 =?iso-2022-jp?B?cVg1ZlI2WmEvZ2R1K2d4a2hqckdQUVJ0SHFNRFVFd1pwaU9QNERaOGc5?=
 =?iso-2022-jp?B?N3dWYTAvVTlOZGV0c2hBdUxHVEJjTUE0MlU1SkdudmZpS3Bma1RxZVVv?=
 =?iso-2022-jp?B?UnJGYUhEMzlJckUvRDBIbXNFbS9TOFdHWFp4d3ZhU2cvcEZDTWJBcGlj?=
 =?iso-2022-jp?B?bWt2SUdETDFnZEFKRHp0NlNtM01VMTFtbG56eW0vVDc2TVJ4c25qWk1l?=
 =?iso-2022-jp?B?VDg=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T2dsQkh0WERaR1p6Z3ZPV0xPZCttWjJKdEZmVUQwZTZpZ3ZRZHJIcXlT?=
 =?iso-2022-jp?B?ZHZwaGxJU1QwOFNBK2ZIRExGa0RoODdMSUpnTmFaNnJxNlg4M29oVnVJ?=
 =?iso-2022-jp?B?RXhXdzBVa0JkR3lsdlBjbFI1c2xzSWhKcVJHSlcxMWNGSFpmck4yUjhw?=
 =?iso-2022-jp?B?eFA0VVF4M0JheCtMblF4NzFabzVBN0JnZmZsSXpCZ3BvUzFhcFY2cTlv?=
 =?iso-2022-jp?B?UTM5amQ4enFlNjVGRVJmY1EzdkN1VC81Rll0eDhET3YwVzdRcExVa3hp?=
 =?iso-2022-jp?B?dFhjaXZiL01HRUxkOVp4TElTTzRiWExUdFF2UGRzc2U0U1NxZDJaRGk3?=
 =?iso-2022-jp?B?S1pnMDRCZ3NQYWhJdGFzWUR6S2piMi8wOVJINlFzd0ZCaWk5YmU2Tk11?=
 =?iso-2022-jp?B?QjgwYU5qM3V6c0p0alVPR0kvKzA1VDBTMXdPWEhuVUUweW1IU1VFa2ph?=
 =?iso-2022-jp?B?NEtlRFJNczJIbGFxb2VrOTFrUmhhR1J4a3d5VTREQXRwQnJ5eTFEWUZS?=
 =?iso-2022-jp?B?RS91c3J2NmZ4NjJJbEl3UDRHU2lwaDl0Ymxyd0FQb214QzVJNU5MRUsx?=
 =?iso-2022-jp?B?K0VucU44ZXVOMW9FdFZoSDZxd1Y4cFpaUUFZVGhUcWQ3SlhNT0thYlhW?=
 =?iso-2022-jp?B?M1hBSkRPUWtyRkJzbVZUVGxqKzlNQy9CZTRSeDFWOVMzRWJ0dE9QOHBH?=
 =?iso-2022-jp?B?M2RJbktSU3VmUktrN1pEUWZtM2lxSlBlWE1nZExKSWpDdkpHUHpxTXZa?=
 =?iso-2022-jp?B?QkRMOW1lTTJKR1pVRVRCTE14Ni8xczc4OTV6SmpjWmpDa01WQ2JJbGx6?=
 =?iso-2022-jp?B?STk3OFVXNWo2dHM4WmR2VW1IbmdxSkpaTWRHS1M2RVo0UW5ZR3krNkxk?=
 =?iso-2022-jp?B?cmFMSmpLcUpYWHJwVHM3RjdWR0JqR3RUYUNOYlpsWkpqQkJFSTljS0pO?=
 =?iso-2022-jp?B?V2Uxd2JRZHUrRWpKbXZVQUNwdlh4OG9selA4SjBmUngxWW16dXY4cW1P?=
 =?iso-2022-jp?B?R1BUUERlU3FvcVI5djRKQ05UcUVCdCtUaUo4allXSDFxRThzMnF6VWdU?=
 =?iso-2022-jp?B?MmpOMHl5bUJFWnZLQkVSaTZLeEdCK1FpdmxSZCtSMWNQWkc2VXIzK29W?=
 =?iso-2022-jp?B?OW82Rkxyd1hadi9XNWNvcDRscWd1L2JjVDVTSm9kdXlQc25NcGlaS3FI?=
 =?iso-2022-jp?B?RFcwazZldFh4QzFpOUNjMWdBdFhMWXZ6Q2t4SURlR2lHNXpZS01zN0JY?=
 =?iso-2022-jp?B?bDFLZU8zSEs5SjJwTktOVEVhM0R3QmhUUFZnMG10ZkROSEpVM2QwejhF?=
 =?iso-2022-jp?B?b0k4NDNqbVdDRXlxRkluYURTM2M3TG1pR2tlSHpNelZIWGNhb3Ria29z?=
 =?iso-2022-jp?B?RUxTOC90QndRaWVKbHFlQjNDREIzTnJEM2xHdWtnOWJyR3hTSGRwNUhW?=
 =?iso-2022-jp?B?MGQ3WGFtTHFEdEM3enJOZVdHeTFLUTJqTHpvakx5Q0hlQms3MENnUEU5?=
 =?iso-2022-jp?B?NzZPaHNueU5sdjVWNnVSbktsM2cxaEFJRHlrVUtvQnJzbkp0a1l0SjBx?=
 =?iso-2022-jp?B?TE0rVUdZVk40d081V0xVdXd3WndreGkvYis5U1hJNUMwVzJKNGY4S0I2?=
 =?iso-2022-jp?B?NUpEczdMQmRNY1dHVS9YMkloMXppYzhpRjRualpXTWdLZzBBU0NMN0V2?=
 =?iso-2022-jp?B?K2krcVFvQmxGUHpFd1Q4TVVDbVI4RzluM1o5MkNzYWYvOVNJZ2Q5NlZq?=
 =?iso-2022-jp?B?dmUrVWt5dG11dXh3NlR5aTg2OU9CZ3NkTFYyblg5dXRwc0dGWVNYNXJU?=
 =?iso-2022-jp?B?VnhzeHBEWXRKYVYzaGxScjhzMlhqZTVrbzU5T2NoTzZpU3pFVGNmY1lE?=
 =?iso-2022-jp?B?VDZ6bjUwT1dzNVZtVnVDN0hKcHZkVGZwRTNjVXdhMTlTclJ3ZUpGUlox?=
 =?iso-2022-jp?B?eG5kSG04OUhhMk5wVnBzMnhsK3YxQ2JLZVJVb2dwRlBoK3A4OUJ1c3du?=
 =?iso-2022-jp?B?eDlTanpTVHZ1WithREl1RktzQTJRK1ZRN2oxVi9LZjBDWGZ3aTFXdDAr?=
 =?iso-2022-jp?B?MUIzc01wRHlFYzZVK2xJbzgrOFBDMCs0c2V3M0JwSkc3aGhZekR3NUlP?=
 =?iso-2022-jp?B?WVgzVHl4UW5CY0IrcjN3akdNRnVMc2pKZHFwS3VXdGRidXVLNHFpckNu?=
 =?iso-2022-jp?B?MEphcytKREFESXgyeHAvT1IzNGY3b1BnSGNjRUhDZDduQkJiMDhId0M0?=
 =?iso-2022-jp?B?bDF0eDgyTDBrcUt0dmtmeWlmVEdsZW1vcTZEL2lUSFlSNVMrVUxncUNY?=
 =?iso-2022-jp?B?WlRObXhrd01UckdkU1I5Q3ZTME90cUFybFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09caa3ed-0ef8-4e31-1d17-08dd1b5b795f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 09:49:44.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFL1z9Jjt0f1dnNRTeu9llGKdUB5iksWgBmnNo5c0g6+5FMP3ZJS2PspXGv1EP8hp1LkGoeXmzNcluFncPJGqhtdu5wE0bDwXSAFJbvxs3COSM/lUKPCRGAn6TUy0I/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Dec 2024 09:49:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17418

Hello Pavel, kernel maintainers,

# Thank you for releasing v6.1.119-cip33-rt18 !

> Is it feasible to add "SYSTEM_SCHEDULING"?
> My understanding is that (P2) should be present not only in my environmen=
t but also
> any other v4.4-rt based systems (i.e. system can randomly & rarely hang w=
hile kernel booting)
> and thus should be fixed/avoided anyway.

Any feedbacks on this?

I'm checking several codes in v6.1-rt where the early might_sleep() detects=
 BUGs
while kernel booting, but no fix from the RT perspective has been found so =
far.
It seems the codes are still requesting memory allocation without the allow=
_blocking GFP flag
from IRQ disabled context.
This would result in it's not possible to fix the reported issue by backpor=
ting.

Best regards,
Kazu


