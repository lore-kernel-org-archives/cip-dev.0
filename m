Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F0AC54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 15:34:49 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162.1785512089129033770
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 08:34:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CZo+9Xfc;
 spf=pass (domain: siemens.com, ip: 52.101.66.64, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFpbQ+hWLZmuhxZ2dUeZkUXM2GJ3m1CzXHFSzJH7MXdi091EBYtCuubC51V8cwB+2aabCbcehqtG+xU38otKEFhDTvQ+BKn3lksAOpVcT+ntZSliI2Ho+i7NOIayXJARQoOTuVwKWddWX+N/DFvmJT8+XgJbjQwkfobKSK5j6HmNrL1ixNnTIOGz2gHeNc6zVzAssMGndIfC4hWC+cPo7q8syWGBk3w5gqVkepjvJPwmzmVyNARd0jRUZesh3xkida7xkzzGOjli+MMv0fllb0kWACIIJoP5iXVgYcWvKSKEuDqfyk8IgC1sEbV/Vn+K+yQZk5eATH16IZtrfs+KeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvXHJ0VcR8cMKsJxJx4j1YvseiXBLP+C02PbHZBO/xg=;
 b=J+qbq53WCCldWqE6CviKqDvyLwo5UjTK+bpk8CDq8xYrJi/Qyq4iF0wUmo4WMuw708PbpfsNVYilkl39tJGGi0D+cnOqqTPP0w9KX3C252agPUqjDrDXi/hSdcUFPztKHekkLEc6Og0J28rkARGI4oQJcCzgwVu0Ctw3js40wK3dJIUwvUngfT3hhtez5dsJsMpE99BXMAZEY6VRDb6RYmSS6ScOulM1V4/biy6WRd5aOY5lHuWqqw3nXcRrRYq77Meq2FbXnfzEPOxd0pLmZL+AxZsOgOF9qJE1vEvKwGSR1XVOW+ZKTubvaiB8GKYg+zsVNyv9nhxlNqjLME5P3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvXHJ0VcR8cMKsJxJx4j1YvseiXBLP+C02PbHZBO/xg=;
 b=CZo+9XfcwznCg6WDJ77O4xAXm2BglbITkeulD2wLEeNTiWe1JzC63oRtzan3g4KlRzdF54grdIC+VwRt+X0VcnXeXEKa0KVL3FlECclWBDMeuKuTn+5Sadf+zueGsGnTBWzYG7g3NTLrhfJaJ+Kqh0a+n/v+CdJkbLVqGeb6YUv/Evr21lHXwiHEnQZeCP26AMuVcyhV0wTDyAl5plBDvHmUu095AcRjLuou8i4stAJ46tRgKglxwIAVDqPq6Owbktk35QYyNttud9+jfpwdqJrPFki4SL2ot/3d19YciN66IOojhohUiOdrVM1Pm+XfEAqxfhvQdoBkgdBOLE5nFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS1PR10MB5554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Fri, 31 Jul
 2026 15:34:45 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 15:34:45 +0000
Message-ID: <8437ced4-be1c-475e-b80c-0fdf2a42ad59@siemens.com>
Date: Fri, 31 Jul 2026 17:34:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] 2nd Isar community meetup
To: cip-dev@lists.cip-project.org
References: <18BE71FDDB19A7A5.114350@lists.cip-project.org>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <18BE71FDDB19A7A5.114350@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS1PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: f064da6b-b722-44aa-c731-08deef193f40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10070799003|10067099003|56012099006|11063799006|13003099007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	RDvFiWzXArdWAdiXX8RMh3EmXphc70onxReR0jZuV16rn1NlhqlPzvwjEN7YJWyZ9uc+IM7tGCyvImglpLw/9ohXxl0La+EjyiqJAuEMwRx9gefKUVSbIHA2Ga/HptuDycIhokoUJoxEUkScHvbwBdSK6SvAWjI1DQDPYdKmswJZx9cnoD8M0pk/oGSBV3hyvEMaRd8z5MRb+ExdxgjRLlBdJVun4svG2p1yzidC2eaxRqKAddS8tG9HjFaZqWdnFmFPnltk4mb3p00Iyqr3nG5IdVXJmnUcrsrE4NzRhgasPfYQ5TqLf47z5GOvbgL+rp2gUDml2yFVHm0X+eVy4IcPajGBbiBA8d8AIF6U3XXirtwMyfAo00CkuRP7okqNRBr6Pq++UzA9iU9ZHrmCuJQxYx4dmr+8Q2WIeaaSJog01IngSZnexJkTKo0rpbP77eGmG/Xudu3foMj4AwH3rbuOUUvkbEFUFzzck2wLoHTwzK3FK2W6ywpiILaW7O5J0v6pqxT9utIshfidECqTkD0Yk2vvJWsJ7Kjzw0EPpxlciAJxw4am/Bf0NyDyW20nRVdWPNej+/k5b4JB67c47X5ahVHRqbWvAxRHJw18EfQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10070799003)(10067099003)(56012099006)(11063799006)(13003099007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gjn8U1/BzMab9eOZJxvxfAGu+TvE/wjNEGILwBZU7pDnsIt6v+GhmPase37n?=
 =?us-ascii?Q?nYrHpSW3hYRL23ybIeFqZnmy+IHWqkjw9chiru3YsHK88swJkGQcmSxiMt+W?=
 =?us-ascii?Q?4hEyvvJeLAW+sYYHzYJHWQizBcT2zrFovQCQj03HsLPofOud+Y0VA5Xv+C02?=
 =?us-ascii?Q?oreLu990qSeuiU30hwKCq/rmEXPijbFNM8pBmlg/QSC/aL52GP1uhRxLCnfs?=
 =?us-ascii?Q?gLkJ1wrwf8jKS8aeUksalTbPfkSVqQ697t5sBZc1ymHNnbZCRYMx9g71+aij?=
 =?us-ascii?Q?64ErrRAkOssC4w3mLg9hsNx0xM8ZR1ds3rxNU2dHX/loKI7Ufh0gEvYj+r0W?=
 =?us-ascii?Q?ffKhhUaxkzGg/OHwcbE70B9HtWMtklL8SXTd5CRqp7PuwqvwF9cPkZB35XEE?=
 =?us-ascii?Q?9kWrrN4xPntNStSu7Te49anZkAIxkGkQQwm629eggcEPiTgm9JNVas44E13/?=
 =?us-ascii?Q?hUSLUwN0/4P6wkEtkq1MK3fgrg9SyuSQEuuqIg0HRJC3+BbC+Mud0+mIhB/f?=
 =?us-ascii?Q?J0RLaAPsFyTzZgzFEe/7p2lrgPMCBGdt0d9eK21Hda+liA44d70wGnbHm3N5?=
 =?us-ascii?Q?2xX38gWJgacmOJ04C3gdjGBqi+83NtDHtFtiPLhhOAIt+Z50uJeOgdPEOSmn?=
 =?us-ascii?Q?tkw9wbdPpCFtPMuFhVv+4j+stytYn3a7YZVo0EDRtk987qR7YOftVMc0IJ1C?=
 =?us-ascii?Q?6eZnqlfSThLBAeKf7YV/IgM1al2ChSeZjplF7BEslGI3+qRp2JupFnMvVYvZ?=
 =?us-ascii?Q?/O8qi5ZTeaVfKJzhP6/89E8jjfC9wWbGTYgWLdURX08NDOp4CiuGmZcYoTqU?=
 =?us-ascii?Q?Zy8YRJeDrYr25iJrQORdmT+B27qO3Vj524lki5oAjqIBopV0duZrFZ5zsIuO?=
 =?us-ascii?Q?rnUI5Gb6fqiwVnDVVfMd8+dvjjaknEQD9F0GwF5i8HCn0kkXHvZzqgw31ANg?=
 =?us-ascii?Q?IX94xvce7tyOB7bU26NWJe41DW6RRB5vyGlls34dTx6rB2fNDoF3pPuKuZfZ?=
 =?us-ascii?Q?0Azmdo+tMlNoFQRggk27WeK7bO68ClFAbj8F2qGRhMc0WOt8DzMNw9p5UQZr?=
 =?us-ascii?Q?UNZuX66evkie8nWSCXTMWVR8jUrNs+KesfVZ513QJDGa+ZLR8Rahe0bdVLbO?=
 =?us-ascii?Q?+nw7uEM5m3B24Dr/KWAeQIxqB96NwdxbBZHLYInlKj4pdR7kyLWCC/5UVK/9?=
 =?us-ascii?Q?CCf43I5VWqGCDBqH+SnQecKMBpoHXdZICVDaOIVXTnrAEmtyh/uPdVYnygYI?=
 =?us-ascii?Q?9p/3cV/CGdxN6M3QnLb6lTvXU/7DMAHfAn63Mja3F5OHpAQghQkCmiYMZfu+?=
 =?us-ascii?Q?Tnc5sj+aoKnJuPjwrxfYcB9dLWMJ0PmfAF602oF8o34pvDFtxonzls58KcQZ?=
 =?us-ascii?Q?XUGkZFmzuJqD/jj1Hlq5Bbfkfjvlf4UzApBZ+XWmQtdiRLXsCC5/xbC16BcL?=
 =?us-ascii?Q?jGQ7o7cQZ7UN5iRpr0XhQXzz5OjazCEXBICcQ6T2TohB9LSezBdJDriMTY2r?=
 =?us-ascii?Q?vDZnoK1/tD9IE8AqpepGItI0klNbQaQSh8ethnC3eCgBJiuCUcZHpnlodGMb?=
 =?us-ascii?Q?ziDD+dTTUOkg1WkU6Dfv6XaYkibIzW0UVJGQzcDBfjNPz3ViW9ZyvLglK5nm?=
 =?us-ascii?Q?m27eUc0QyKBLGo82OqwWauHM8JOP4o4mXXEBCKIff0lEW6DtyMmJfa3zDGCT?=
 =?us-ascii?Q?bFZ8GklEpIifGELzTJ3IHpLmokkTcMQWZj20KXnp3csf14LT2QYeo9vEwwNZ?=
 =?us-ascii?Q?9omybOSr8NUKkx1LY77lQzp0mLjN3oK4zo1XoqMJz++tyXvQs8p/Q2V7SOnm?=
X-MS-Exchange-AntiSpam-MessageData-1: 3CwCDqWKVXxJ0k2gH4PX2ya8n91yHHW+qmo=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f064da6b-b722-44aa-c731-08deef193f40
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:34:45.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpahIPOklMWfXy+qdMoFWE2veWPXWKRYvAJrSecYV7uhFNi1GWbSzx8Tvs1C2EOj8x9VZa4W9UOzWwjV/TQxcGgFmYE1V/21bmNcwZO/oj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5554
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jul 2026 15:34:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23826

On 7/2/26 12:23, Schaffner, Tobias via lists.cip-project.org wrote:
> Hi all,
>=20
> we, the Isar enthusiasts at ilbers GmbH and Siemens AG, are happy to
> invite the CIP community to the second Isar Community Meetup in Prague,
> taking place right before the Embedded Linux Conference Europe 2026.
>=20
> Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Monday, October 5, =
2026
> Location:=C2=A0=C2=A0=C2=A0=C2=A0 SIEMENS Conference Centre Prague
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 SIEMENSOVA 2716/2, 15500 PRAHA 13-STOD=C5=AELKY [1]
> Registration: https://eveeno.com/isar2026
>=20
> As many of you are using and contributing to Isar through isar-cip-core,
> we would be delighted to welcome members of the CIP community to join
> the discussions.
>=20
> Following the great exchange at our first meetup, we are excited to
> bring the Isar community together again for another full day of
> collaboration, technical talks, and networking.
>=20
> We are planning sessions covering recent developments in the Isar
> project, user experiences, integration stories, enhancement proposals,
> and interactive discussions about future directions and challenges.
>=20
> We welcome contributions from the community and invite participants to
> share their experiences with Isar through presentations and talks.
> Topics may include real-world use cases, migration and adoption
> experiences, tooling and workflow improvements, ideas for future
> enhancements, or ongoing development efforts related to the project.
> Both short lightning talks and longer technical presentations are
> welcome.
>=20
> If you would like to give a talk, please include a title and a short
> abstract with your registration.
>=20
> We hope to see you in Prague!
>=20
> [1] https://www.openstreetmap.org/node/13806143589

Hi all,

just a friendly reminder that the 2nd Isar Community Meetup is coming up
soon, and we would love to see you there!

Date: Monday, October 5, 2026
Location: SIEMENS Conference Centre Prague
           SIEMENSOVA 2716/2, 15500 PRAHA 13-STOD=C5=AELKY
Registration: https://eveeno.com/isar2026

We are happy to share the first part of the agenda:

* Maintaining Isar: Testing, CI and Experiences - Zhihang Wei
* Where are all the Isar layers? - Sercan Sari
* debsbom - Christoph Steiger
* Isar build time reduction - Felix Moessbauer

More sessions and details will follow as we get closer to the event.

If you would like to give a talk, please include a title and a short
abstract with your registration. Both short lightning talks and longer
technical presentations are welcome.

Looking forward to see you in Prague!


