Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1349C5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 07:22:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25043.1786951372675550430
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Aug 2026 00:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=k5aE+85b;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1786951361;x=1788160961;bh=bgPYIEWSNoFDHCBjWM5jNOVK6WRU39rtBRJKN
	FluCKU=;b=k5aE+85bIa7DJ2HpjsfjwEjrIe7tWvtkXl2LIp2W7xMcDBzPOTNNH2bZh+WPGoxjO6M
	D8Y7TCnyP41+zKWeVQiBfqajbHVbxKcbFfdYAmAZA5Qerc9Zg5AVWNnpG80itjPr6iNurPu3CW6q+
	uYmsauiTQ0CCxx/tuPziLkViaeI3VJlATCB3KWoLqd/CFuoPRz+dFgKx/SDNhX0SIdMm610jQUCId
	K3Kgi7ewBO6+ASvyJmBnek1uxlhayYRlZEEWQtQsUdmpi1kF3M/PLuhomeQbSnSxsun43ZBJo994d
	N78XMpDVv465MCHfNVJAlXKjXv8PWhVPstzQdIi2+okw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 67H7Mei71351456; Mon, 17 Aug 2026 16:22:41 +0900
X-Iguazu-Qid: 2rWhoBnMRszGXaw54b
X-Iguazu-QSIG: v=2; s=1; t=1786951360; q=2rWhoBnMRszGXaw54b; m=zkBXYXtEptEXYB5lnj70ytvn2uSmdPoC1Dj9E1w346Q=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hNknC4XFjz1xng; Mon, 17 Aug 2026 16:22:39 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULkKtbxcXuQgzZdyoxHd17RKtSMhUeMvaa/+NxpKTXk/sosiwlNhJ5mLQMeIboZ/BlLqNp2KpbahRR9I/BG9z047ZuG0CBxDQbRqkozudL4Y0qTxsABON2yZrlnZNSwe1WTrNhcFWk7KwHz0pzgrqB6wSmI/CYSyMTjgGoTgyPhbcGtz/L5aSMf5CUfCr5kRi/RKjFFQunCZyln+dO1SDpzt5TnyQmLB3r53XT10BOeZT/ZP88RLeebrF+cIa0sWWq3XWNihRft0PNlnjTkAiJXewAVFlZcZcf97tmPi8cYBoVd3lJyBhzPOS2TBXkvMYb7KglpJzfe8HLBCECMKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofm7SUggQXZus6RkzTU4ndsDeM/V30BaxfOW06tLwk=;
 b=O8WPgMXfptRAr0u9h7nxA9ZosHWTPMPc5p/QOOr7ocpkP4CiiRYAjDHUrD3BfI7ZS4daaQLKhltEZB447ku9PaBLPjIrl2cCPv0HcWRT39/CdMbXz8oswSUntg9sPVgX9xGNC6ZkXQx4Et+wUh+sL0iybSmqPcUIRZwQa0puhU3/OfwQk6rcqp/x+5HUK6wEvI8p1E+0IxyV9Qurn6UUYAw6YnDm3a2YczMYUYbsJoVdWNoXcizJUoBSmypMexSqlUGq6gJxjvD+Q3Od/+YB51kIAeab/jJatTs4ByDVWIbmzKLRyPJUotvmTt6Qbsa36yE1SboClaIc6HAv7s+q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <uli@fpond.eu>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Request for review for 4.4-st79, 4.4-cip114
Thread-Topic: Request for review for 4.4-st79, 4.4-cip114
Thread-Index: AQHdKwtFVSSLttNDIEOd2Diq7TjNE7adbMGAgARvCYA=
Date: Mon, 17 Aug 2026 07:22:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B6FD55C092740A112D78CDA72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1456594884.221583.1786615509120@webmail.strato.de>
 <an7-M_D45SkSyucI@duo.ucw.cz>
In-Reply-To: <an7-M_D45SkSyucI@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11027:EE_
x-ms-office365-filtering-correlation-id: 39265fcc-77f4-4c1a-3e20-08defc304f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 rIeAS3i6loycv2Onq58Ztd1UeTKbYE3REgtuXfK4l72r4Y9NiQNeBRwZpD8M1317aFdJMW/OQf7+EpnKNBNnJEXNjijUXHm2l3C8j+BDHCzkcF0/vC0vh7S630UQqHuE0mKvg3n/zkhoRKI0hojyX5i9kjez4SvztdUGbYqFCca+7+V5iX7h5cBxqZn3+RM0ms3Sjft11zuyTkQrOHxgkBI+wq+yGR6oGAN7JvwNiM1HxHbQnc2KYl54z6hoZbNfAqY0/tx378pbS+zvd40sYAgea5isQiHyf7hux5w9wNBgTxMGabanUJNuiRpBxwTsEcqTK4zRGtLe4LF9JDEKYUNuz9K0CCHQzVpGPYXD38HnTlhTCZNu4501fTy2MWL+NA8pp3P9XPqh/zoD/VTnLbl643YvVZPtZ8Gm7HuDxJW6x9JZG0C8Nt95SmKkFdQjVTuRftZg4LFIvyOPn4b85YRPFEe0RcEF95evJrQTpgM5MYm23qzHoyIk5vs03iTCf8eKmlopLgpKKKUWi7yeuE065Wq67gu/dj0Z6Ih2G7yfNnaAN8jorHQ9b8c8jR7/OX0+gzHyvw2XGHMJ7MC++G5qB5w/nswcsYyH1XVQMwTo61b2Z3+vB4V59e5DnWKicYpvNDqYoTjRX9u1clZKCJ6dYVbmHmp6FGuO9z5l4WkIWtsc4VNwwhS+CHWBlbKlr8xzXV3grtoHpx+q5qgiB02M4tPSu2lZJkuDWn/iQBc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UU5FNHhsdWsvT202cjhmTFpYNkFhNDRyV25vRGhKUmlzcXRQNGYreXNI?=
 =?iso-2022-jp?B?U3ZkVyt1YStaVXZFSTNnSDFKQ20xa0RSa2pBZHRoOWxvT0dMeU93QmU4?=
 =?iso-2022-jp?B?RUdNMjVlQ243M2p5a3VmTTdQOTYrNFdsTDJvY3pIRllldHFsSXZoRVpL?=
 =?iso-2022-jp?B?V0pKOGpvMzBiMTJqWVlqb2Q0S1Z5VXZJOGNSTVc1b1p2OGdKOU1WMUUv?=
 =?iso-2022-jp?B?clNoOUsrSWdnZGhuN3Q1eWxJZTFSb0V5UE5ueVBTem96akkzUmx1T25h?=
 =?iso-2022-jp?B?QlVtb2dKYmxvdWN6Qkt0VlgwbXNTeis2M1NmMzV0VFVUVHB2ZnE1d0Ry?=
 =?iso-2022-jp?B?TUFRbUFHY1M5d2ZsQUhiVlVPcTZxNk5XZWFMYzhHN2tlWVNScHZMVU5u?=
 =?iso-2022-jp?B?KzNNbjVqakxrU2xoMmppcFcreTVwY0ZMUXhiTHZlcnRSOWE5MEhhMkJP?=
 =?iso-2022-jp?B?ZnVoRzMwc3g0bVZ3cnZYZjB0Y1lpK1dzai9xbWFoa3h3MUczaUlSQ0dU?=
 =?iso-2022-jp?B?TEt3YTF2dWh4bndYZnA1MlQzeGN6dnYvc2ZPd21IOWJYU1lZY3JnZGZr?=
 =?iso-2022-jp?B?c2J4cGZ0STRFVzVET01qT1JDVlJRMGM0MWZMQlBFUEpoQkNOZUpUN2tv?=
 =?iso-2022-jp?B?ZUxRYUxKZFpLZmpZeEdTMjZWQkJpdVFhRGJDZndxM1hYMGYyWUxXaDM5?=
 =?iso-2022-jp?B?RXE0aXVnS3V3Y0lxT3R6YlZFeFdzV01kQmZJZHZYZTVNbG1PVEZLeWhL?=
 =?iso-2022-jp?B?aUxZbGw4bGdhbFhjVittTXdKWjJmWnJEUnphQlBBc1p1U292NHpESS9M?=
 =?iso-2022-jp?B?a1Y2c2htZVA3Lys3YlRmeWE4MEFwVzM1Wnhsbi9VaGpZYWNyMXc2WUhi?=
 =?iso-2022-jp?B?YlJVTlBuaXFSaGltNVdsbk9UQ0dWZVgzRDRPeW4yRUhqSXZLK05kVU1X?=
 =?iso-2022-jp?B?VmRxT3VDMnplTGcySkx6UEx5ZklpeFNUUHErTWcrRmdnM0dqQkVjZzZp?=
 =?iso-2022-jp?B?RXNxSzBleVpSUjBHcnRkc0RVVy94YUR1WitMbmNhT25zdlIzTkpqTXJ3?=
 =?iso-2022-jp?B?RlA4cFFHUlBadGhLWW5vVXRDL2lnOVd4OGp4ZVV4WkFDRlZvNXhMK2NK?=
 =?iso-2022-jp?B?T205aWQyYm5XL1BmOGYxeUdzSkFGMFAyRHIrNjR5QS9EL1grcktHU21T?=
 =?iso-2022-jp?B?eEY3dm1kT084aVhLYytWeWwyQldVTGVJZzdzNm1JTlRvbXQrNkRWbXFK?=
 =?iso-2022-jp?B?ODJuUldoOVpTdFVsT2FOVS9kL1NadmVKMTNzbHRaWElQcjhwWFJ5Mkky?=
 =?iso-2022-jp?B?QTZkMFYrQ2d2Uy9qRUZxTEgxVmdTdmVOL1dTY2tCZi9BOVQrWG00TTlO?=
 =?iso-2022-jp?B?WGMvUmlpR1FDRjdCSFM1YmZwTVpOWVFtalRBUEtVT1RweU9nTUJ2dWdq?=
 =?iso-2022-jp?B?a1FqaWhFMjN5TlNBcGN4cVY1VkRCOEgyb0lCWVlPYnZ4WkpwWDdxYzhM?=
 =?iso-2022-jp?B?Y1ZpSGlUMnI4TFpTQ21IeG1yeldZdHRkdkY0cENZay9YOTlReVRYMEZE?=
 =?iso-2022-jp?B?UFV6QmN4cTZmUU1ZZ0h0aC95Qy9nUWhBVEk1bzBhVjNRdXRHNGk5WlFJ?=
 =?iso-2022-jp?B?YkRjdXFJSW1Qak9DQjh0Rmp4MUM0T1NZeFY2M3Z6MFBUbzMzNUNBSWw3?=
 =?iso-2022-jp?B?OURkcXIwMUp5WWEyWk9rVDhWdnV3WTJNWUxvOUt3d0xDaDUwZHh4b2U2?=
 =?iso-2022-jp?B?MmY2YnMwV2wzc2pxWG5KaGFuaFg3MTFGaFVrMHhwRkk0QjVhTFZVbVVZ?=
 =?iso-2022-jp?B?QWFOWEptU2VoVFFMcUg1U2Y4ZXo0dFp2ckx6ZVJER1BhSXhUbHNSaEdO?=
 =?iso-2022-jp?B?NkdKTENnWkdCb1pkVmIxYUVITi93NEoycXp0UUtzUkFzQWFCcG5VZlFW?=
 =?iso-2022-jp?B?SVhhQ0llQVBLWklhdVBIMjVmR3AvL1lPcmR2OEIxVEllSFplWWVDNzFT?=
 =?iso-2022-jp?B?TlJHdGpPenNaekVqdmowdGd0SzFlVHRrMyt3Z21WdnYvZDYzV2ptTURy?=
 =?iso-2022-jp?B?dmplQ1JmQ2xoeHNUL1lpZWVjTG9pWlo3N0VFc3E2N2RMUEVvdGZCZzZ1?=
 =?iso-2022-jp?B?ZE9HZldXZzFXVEpuOG1VTDdRcWpscDArWlBnSGV3bUduZHNyMHo2OENW?=
 =?iso-2022-jp?B?bHBLT09mUlFXVmpaYlIreFhXc3ZyUkpUdnFFWnZEMkhDMGZJbkZIYmtX?=
 =?iso-2022-jp?B?cmwzRXpLcHl1bTJjcWdDL2ZZYzNzWHh3V0RodDFtYUxWQWdOS2kzZDV5?=
 =?iso-2022-jp?B?cy9VQWN5b3VMTHR6TlUyVkFZdmc4SFJPaVZ4SW4wS3lQNmJFYWFBT2o3?=
 =?iso-2022-jp?B?Z0VDQzNLSk1KRG4rd2NIdGx6dTlMSG9maENqUjRxMXVqcnVTLzdVNGVy?=
 =?iso-2022-jp?B?WjVFV3h0TWVEU05nTVJ4QjBxNllTSWVYbjg3ajJ0S21ob3hDbkZrUnp4?=
 =?iso-2022-jp?B?YXpMOVkxcXFsVHNEOHZzUjc4TmdxcHVFQmszSFVrbEdDbFJxTjc4RXF6?=
 =?iso-2022-jp?B?blY2V21Tbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Gt0uvnC7piq8yTpnqsGQP35DlffkA6udFkUe/IXvkxpQQD/EsGcquc/H09ExX9yoUIblf9I8KoIk1OFuAoIYXFQu8u4V7qVS0BbFQVHWsadDmOzlst9HDD5lpEuBm5a878G51k4XMXkxNGnZUkTpFJFMwLngUkoYo9bPCGLJWRmFYq1XOQguDaIWft9ICOh2K3b0Ig3mLII1eZPNaDSuWUiwpbRf9xDy1yGS0uFRFSqmZopeCDR8fpS3RfBdv8mw3kJn4EPe4m3Hrj2Wfms0buSfOJrddwTWQhgA8uFXjIQ0hdSmOJU62t3vuBRUTnE1J6CwSc1doQMZh7aaDZwugw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39265fcc-77f4-4c1a-3e20-08defc304f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 07:22:35.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Nhs3R/F6zj7f77RpTVX4EQa2klX8A69kk6v6tJObWdxk3/VVPw8TmCvHtBuRfr/mEHHI1B6B2xTYyY659ZlNGzAxkFP1LygEzKWIP9+8RC/TcdGBRitjMZQiFrBNJZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Aug 2026 07:22:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23946

Hi Ulrich,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, August 14, 2026 8:38 PM
> To: Ulrich Hecht <uli@fpond.eu>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: Request for review for 4.4-st79, 4.4-cip114
>=20
> Hi!
>=20
> > Here are the manual backports for the upcoming 4.4 kernel release. As
> > always they can be found in
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/
> > ?h=3Dlinux-4.4.y-st-rc
> >
>=20
> I have skipped batman for now, rest looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

I reviewed this update, looks good to me too.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

>=20
> Best regards,
> 								Pavel
>=20

Best regards,
  Nobuhiro



