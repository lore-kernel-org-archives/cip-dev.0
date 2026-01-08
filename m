Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74423D14892
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:21:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23106.1767838856331862476
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:20:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=LI0s3EUC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767838851;x=1769048451;bh=8S8BHkLdDtT4Fodo1R0pBhTQ+HZxxmJh3S1Bo
	GbwBrY=;b=LI0s3EUCczqyhZHFl4uocIRNG1GDrExEUHLPQcdi0B74MzxJD3YQrTNSymuuUyOinRh
	xdThho93aBRL0OGd/w1sOJZeQZHKLGxQ4EnU/nnzFSKivhc+bjmD4VvgK5zdaC9RWZqSmnKt3DCJq
	0faDUBHUmoQRaLSqcoqBXYp3riMbKakhP1LkYS6iPla1HeIai8aCRq6Wz3B/gjsfI5hZwGSZTdmGo
	YpvTyPM+rM2jHzQSWHkQIyUCfVg4vcbmtlWQy/vU3hSuWaQuT4tt/4QyCO/Pl7br5/h5w9/YIyBHw
	+k4EhO8O5cT66kKTr/GPxqTc452zkAiU5mEiJbCJfzQg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6082KoEI2171936; Thu, 8 Jan 2026 11:20:50 +0900
X-Iguazu-Qid: 2yAbXx1kwJiXBH4Y2t
X-Iguazu-QSIG: v=2; s=0; t=1767838850; q=2yAbXx1kwJiXBH4Y2t; m=Cd+gx0vdwGokQIyYBRVxbPk0As1WJ/erfveARL6bRWE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmpXx61R8z1xnZ; Thu,  8 Jan 2026 11:20:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVTSyjP1jLY5KZeNqIjoNHRkLU0IiPUGd1/R7uRBPwPwo7/ReQ+45Nzo/PmrrScErdrjtITm4VM/Fp1YC5s5PeADyVUW5VFEjpsGKSmC7yddg50oUCkAW9mQrr0uFDMV54XlBwViKQBqYzqyJ0PY3KkTBd/Vt5SvJtJvH1gCbJg1714Xt9fS4V8oMKn8XIPEimKplo5JuWeK6QISHSVKF0fqSD7WvrmJKJ+EXhHXlr7uA1n/pPC01KRrbIFfVy4DzyfOqt1EkzsKYC9PECaanuqJF56XmFcaVvqWWpoRDBnP6H/0DipIOu0it/hVF7Lzm/IAE4qY4hoUo5oaLvJ8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89fqwHYG3HKGskDFj35NNveId+ldM+MvlPqqG/Hxdcg=;
 b=VB5diQBCBkc1N8o5zFhqFT/ezrODJDCva+l1wkH+n22Dz+O+Nt6N59bc4oYd6GxME1KtbDsmpyIpFDrmrH4wENpg5uwB578JBw1pl+R7Z6SpVh6yBseBYmkfdgrZ5z5xjR/iUOhEfDH7fCsndie3u2vLTRaiJY5QKi19+8cWHXKO60rudEkfNw0PSCAExljsfypyPGMBS7vKUMqvjcpLXqEXY8yjYWv/+VuslxSFPk4rNQCXsLiUzi2KzB9Q/bUqhanAGa2k+U+4rkfo6wSlAHzI1CS0T9h8vTHJX0LxjHS/0Lxd5RfiepZKEvhJNmIU0cQ5/obCl9TAV8NDVTzccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/24] Add suspend/resume support for RZ/G3E
 CANFD
Thread-Topic: [PATCH 6.1.y-cip 00/24] Add suspend/resume support for RZ/G3E
 CANFD
Thread-Index: AQHccD83U8tufhBU9ki6eArRJkxwArVCXM0AgAVNH6A=
Date: Thu, 8 Jan 2026 02:20:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188EAF4E0BC41E0970EDC8CD85A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
 <aVqhvv51l0tjtPi6@duo.ucw.cz>
In-Reply-To: <aVqhvv51l0tjtPi6@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10845:EE_
x-ms-office365-filtering-correlation-id: 110a82a3-b5e6-4226-193e-08de4e5c8919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SU5JSU4wYSsvcEJpNHBMZks1am9mZnpSUmZGMWlkRTBpWlA3YkF6blhC?=
 =?iso-2022-jp?B?QjF4OGc0YTYyam4rNThCL25aV0lRbXVMVm04bnhocVVla3VlY1JXbXBR?=
 =?iso-2022-jp?B?ejNZQ2pLWGQ4NGZGdk5ZOXlka0x0SzFRM0JSNkxZVzhMQldjeEtrUkRQ?=
 =?iso-2022-jp?B?YTJQOFcrMFRtYWtpZXVZclZGeTlxcHp0cjh2NGVSQUszViszQUlFL29N?=
 =?iso-2022-jp?B?TWtlK2tLNS9zZlVoME9wdk9KclVadGJjcnhSMlBFR0hUUURpUzhCcHp4?=
 =?iso-2022-jp?B?RnNjN2daT1Y3WEtpSjBwS2R1dU90Sy9lTkZtVE9SUzhYZFBybDY0RXha?=
 =?iso-2022-jp?B?ZlVtRUVBaHI4d0FDMDhjSEZHdVNzNFJPY0xaamFHcHFiajNEVG0vVUc5?=
 =?iso-2022-jp?B?aU8wdXJwQnpRWGdsTjdwMjEyQlVYeWk2bkJ3Z1lpeXh4NmN5UldMK0ZL?=
 =?iso-2022-jp?B?RWpjeThLNXRGOTdXdEprWk43djViRStYaS9qazJ3TnBJNkUvb3FxWnp6?=
 =?iso-2022-jp?B?MzlSQXlFQWZwc0ZRTTRBMTY4NXRlbTduZE5JYmdubzByQlRqZ2h5U3VD?=
 =?iso-2022-jp?B?SGhpSkdLK2IwZHdOT3pNWEpZMUwvYjdKSHBMS1FlUE9Zb0lyRlQzTFpu?=
 =?iso-2022-jp?B?dkVjdmE2VVltZzUzQlg1ZGhkWjJwQTJNSWFLcWx0aXA5ZldsNnk3RTcw?=
 =?iso-2022-jp?B?dWhBcHdkaHQ0RzhpSTNUdzJJUDRCKysvbGs0U0p2dTJTbzhOM1VtTDNN?=
 =?iso-2022-jp?B?dXpQdk9GenpNNGFwMVliUFcvaWdNUjRsYmt2Tm5lTkNwUlk2SjJwWjRo?=
 =?iso-2022-jp?B?clFGU0xkK2kvY1krYURORFpXNUNGb01LV01JbVJoNE5iWktDOHVYZkVJ?=
 =?iso-2022-jp?B?eDNQdGl1aGw2T3FGc21xMWR0SFRsRmZESjlHNlQ2SFYvbGVWeFN5Tko2?=
 =?iso-2022-jp?B?VVVUaWt4UlJwZzdkcWpjdXl5M2lETFA0Y0liTW1RYVFJSlp6K0dMaHFn?=
 =?iso-2022-jp?B?WTNEUno4WWpKVlBJUEVqSUxub0ZLSUVSUERqWTVrSEpwQ2FOOGxYbFZE?=
 =?iso-2022-jp?B?dE1xU1k0VUhab29EYzUydU5DSzNOQ3FoSjNVZmErUzVvNjVtYm05QlZs?=
 =?iso-2022-jp?B?empDVHdUOHRac3BBVFkrcmRoZk1FN21hQ0FIZ25FZ0Z1MmxDNElnbnpD?=
 =?iso-2022-jp?B?MERkTDVISEdWRUR0SnVFeXFhTUtyS1gzelYxM2huT2JzQ3c3T2xCYjR3?=
 =?iso-2022-jp?B?QVRjbEcxNUhxTUZIZXpId25EclptNWRiOUdMWitQa1pmTkc5clowbVIv?=
 =?iso-2022-jp?B?M3lmVWVyRExNOUs4SVhoNlpLVmdLRTV3NkJkYmxZeFR3Ris1cHR2MDVv?=
 =?iso-2022-jp?B?RG1yUFpTMGpZbGZQWUttUzlXdEJoQnd6WFRYWStBdk5YYlVFZmtNMHlt?=
 =?iso-2022-jp?B?Q3hRMTNVTTBvcllKTFNTdWNPeExGNnhZS0xkL0xFTHpqMkhOZVViZVhG?=
 =?iso-2022-jp?B?RmpoMzlBMTFEODFVRFlEVXdZemZNcy9LcHpmMWY4VFdqUVl5T0hDWGNR?=
 =?iso-2022-jp?B?TkZOMVJLN1RXRjRha21NenhQMTdleG1PQU96a1FNeitrYWF4MlNuWWVt?=
 =?iso-2022-jp?B?MlRwZHJSUm5vUmhxeEdCWG4rME5UdUFBWGhUTjBQUjI3cy9RVytzMDNS?=
 =?iso-2022-jp?B?UzkzRDluSU9aQ05IVnJHNksxajNOK1czUWRkZ1dnMWtlYVorbkZTbzdk?=
 =?iso-2022-jp?B?em5yejJXK2ZqbElaaEVQSG5hMmNaS3E4MVRmdmwvMHgyZWFpcEN3Sits?=
 =?iso-2022-jp?B?ekFEaUVzdXJxUmkvbFJqcGEyc25IOFlFL09uQmtCWWlHcDRqR1c4K3J5?=
 =?iso-2022-jp?B?N1R0c2JidFNPOTBpb2xWTFVwMGN1SnBUdmVneEw4cDV1dkN5WG9FWi9B?=
 =?iso-2022-jp?B?d0F0N2xNcDN2cDdKT1pTNjVyMnhsZzhvTXdhV00wVkxzLzFYWjlZR2Vw?=
 =?iso-2022-jp?B?YzRibjBhcVJJaktvNU0vK3JEZUUvUmxDNlJjU0lhQkdoQVYzNGZMWDFV?=
 =?iso-2022-jp?B?ejRqY21hRWM0T2RPVGo4Z3Vwamc3ckhET2RBNjVNbzZYcEdOL2g4WG8r?=
 =?iso-2022-jp?B?UmR1L1JnbmRUZ0FYVjNBcjlPZXB0TFNZQTM2WkVCeVA0d0h1Y3RaM2Fk?=
 =?iso-2022-jp?B?V1ZJczNYU0NIdmxaOXpzVU9JbXFxa3Y3?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eHhTS0RpQk0xeWMyenVBSEJxZ2x0N1VXcEg5UlJZZzBQL2tWY2ZqRFRQ?=
 =?iso-2022-jp?B?RG9qWldQZjIrcFJIcnlEVU0rU1pob1c3SitLTG50ZWgvcnIya1dFTlg4?=
 =?iso-2022-jp?B?MGFxZCtzQ1R5Z0VlblJ4c2ROak9oUS92NXlSY1pEVG9Dem45NUVWWnJ2?=
 =?iso-2022-jp?B?U1lqTW1PaFNlbFpmYUU1WEhzUEZRRllGWHlFVXR0Wkw0YkxPM1g1MXpp?=
 =?iso-2022-jp?B?WGtENy9VYzIxaHJQTlJZZS8rUkJRdk5OT2FzcWJXV1lDSzVLZytqRFhC?=
 =?iso-2022-jp?B?bkhhWDZYbDNnV2pqdXVOZklGMmdKdzB6Rlk3VFlWTkE2TE55YkFZQ2s5?=
 =?iso-2022-jp?B?YjNaanFQM1Y3THBPMURxdSt1M2k4Q3oyVHEzUytsM3VuS0ppdEN2TUhw?=
 =?iso-2022-jp?B?ZHpFSDJ6dzlsNkovVHJmMnhpMVozYVlPb200QU5SejByKy8yblZrdHJh?=
 =?iso-2022-jp?B?U0JWdHMyVmRvN0VIc2tMWmZnZndtbk5DdUpBWE0xSzJKZk9KRUE4RTZ6?=
 =?iso-2022-jp?B?aEFVamxYN21nWS9VZjVlR09PZzlMcDNyeUtRUUFDaDhRa25Zc2dkd3BC?=
 =?iso-2022-jp?B?WmJvcXU4cityYVhEdUZORVVpUEE4U0dRb0RCbjA0dldSY2VyeHFqRzBG?=
 =?iso-2022-jp?B?S3JZOFUrdjBlYzhqdjRzNFJmdktPb0tsQVNER0dkQ3I4RFJoWE4yckN2?=
 =?iso-2022-jp?B?WDhVcS9HOUFMWTlJY2NtRUNvbktWT2c1cXlkTnpMZFMwSENJNnBoOWx3?=
 =?iso-2022-jp?B?YmF4UHJiaTVuenlaQXA4NnBCNXNzaUJOTlJZY2RjZXZGVlRkZ1ZiZUNL?=
 =?iso-2022-jp?B?SXNSTlpwa09iVXdWNXZHWURmYmZPdDVsSzM4aWQ2aU5YU1c2clp6N01l?=
 =?iso-2022-jp?B?N0lpZ3FtaTlrb3dyZkhXMEtuUjhUUkhFNzZESXROaXZTSXkvMHRNVVAx?=
 =?iso-2022-jp?B?YlVDK3BBNE10SHlQUUorM2xyaWE1YUtnM0JBcEtmaDJXQ0xNMnk2SW1K?=
 =?iso-2022-jp?B?eWNRU3JYbnhzZ2tnMnlVZm1TbUppOCsxL1N6WktRQ0RSK2pmZHdMei8z?=
 =?iso-2022-jp?B?UE1tTTFJRDNkT3RKek0zZ2p3dkRSQWlQSWFHcTEyMDlNREsreUlwTnhQ?=
 =?iso-2022-jp?B?ck5OQzFWNTFWM2VOclJMcVZEbHVXeEhWMmhNUVJnUVRrWlhEdS9BcFRD?=
 =?iso-2022-jp?B?azVtZDh4d1oyZ2FET0FYM09kM25hb0ZCejBjODZHVGJ1dy9KV0x0N0Jo?=
 =?iso-2022-jp?B?N1J2Y3pFQjM4U2Y4WVVIczJxdVRCeWQ0K25WT25HZ1l3VWJpNEFhQ1Jt?=
 =?iso-2022-jp?B?ZGtMOFQ4cWpQOU8rVDZGNnM3VmYxU2RVdy9uR2VZb2VJVTZQemFOZXBS?=
 =?iso-2022-jp?B?ZEJsaktibHZ2dE9kL2RYMzRicG5CS2tEUmVxSXd0U05VTUh3VXQ1SXVo?=
 =?iso-2022-jp?B?NnRkZlZ0Vnl2SjZocWMvejVVR0Z2Uy9DOTVNNzhLZ1NraTV0UCs3QzNs?=
 =?iso-2022-jp?B?TEY2dTlXSUIxZXhGUEVENlM0Z0wxMWt5VDgyU2YwZVN2V0tyWTFTNmJO?=
 =?iso-2022-jp?B?dCttaEtWZUJuY2huL2haa2RwcDFseFZVL2pNUVpOM3BwUExzK2lUY0J4?=
 =?iso-2022-jp?B?K2ZHNHNseG13LytDK1RvTjFjVDVmWlUvREoydEpKanVXNStWc0swaXJm?=
 =?iso-2022-jp?B?Tjlua1RUYTI3WkJFRTBBdFlkaE5TUlQ5ZFY5TGY3SnpIRGdzRnFDb0x0?=
 =?iso-2022-jp?B?cFYrTVBjT2FucTBnSi9jdmttYjhyMWZaT0NsWTVKUHFUYWhQdVVCLzBx?=
 =?iso-2022-jp?B?NTVnVmN6U29LaGRBZjlrRHgzMnFRN1VxNHV0YUFCeStzazNuNFhhbk1x?=
 =?iso-2022-jp?B?RXBnNXEya1VMMEczeEV0Ym1tQ2N2VW5mUm9FODd0MWptczhFYVE4KzRQ?=
 =?iso-2022-jp?B?L2NRZlhrTjYrSUhHNFVCR0RteVdObE9CUkFpcjZPYjk3bUZSSjY2Q0p5?=
 =?iso-2022-jp?B?K2VpMEl4WmNMV1JFZTZqcVZQc0FNV0l0NXd5dUxaRUtGSnR5U042ekcr?=
 =?iso-2022-jp?B?K3hqc3JqN3k1bTkwWFBhR3ZsNzRvM0ltSEUzeU5nY3QvczVHMHV2VWZI?=
 =?iso-2022-jp?B?cFBRclhsUjNGK1I0TGJnazA2RjVWbHo0bk9UYXpNOW1xRm9SM1dldVhh?=
 =?iso-2022-jp?B?TVNNd0U2TkdpaDd5Vk1aU1l5bEhiM1IwYkNqVkdDUDRNeTJYTXlnR1ky?=
 =?iso-2022-jp?B?Uk1mT2h0NnlwalNYOTZrYWhpVmVOdnV1SmREQkYvQWlWRzBUUXRsTSsr?=
 =?iso-2022-jp?B?bk9GdUJEakl6TC9ndkc5UkRiSEcyM2xucnFCQUFIVXhCNEhPMzJQYysr?=
 =?iso-2022-jp?B?VXUwMXRmVzd1YUZRenY3RGJ1N2lIRWJBeFlJemVQaXU5Tlg2K0VWc2ho?=
 =?iso-2022-jp?B?WDNFTmtROFQyK3JVbGZZTG5GYkxXNVBXLzM2RjFxWStiVnNIZzBSWVV6?=
 =?iso-2022-jp?B?MmVaQVBTelRYa0ZNRE52MU9ieG4zNGs5akZ6QkExLy9NRWNEeHZ1eXhN?=
 =?iso-2022-jp?B?SGhSN0Q3ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110a82a3-b5e6-4226-193e-08de4e5c8919
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:20:47.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvMtfwRLw4Yhccvm1Y6p3FisjwJ4nRHve1eIhmbE7n/LCniwusVBQIt/LXtK93iCisASqOP3sqbI4sVN80b1fVhp0IiOEZH1AyHEDEy1dAahbYujK67sZPBJvU8YDCIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:21:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21426

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, January 5, 2026 2:22 AM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 00/24] Add suspend/resume support for RZ/G3=
E
> CANFD
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI,
> > s2ram powers down the SoC. After resume, reinitialize the hardware for
> > CANFD operations. All the patches in this series are cherry picked
> > from mainline.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks ok to me too.
I applied this with Pavel's reviewed-by tag.
Thank you.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


