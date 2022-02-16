Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B2C433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:37:15 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.136])
 by mx.groups.io with SMTP id smtpd.web09.10757.1645011432660411052
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 03:37:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=RDGByh7n;
 spf=pass (domain: renesas.com, ip: 40.107.113.136,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuQ5+0gwjFojvV5cHWY4QSXLk36DOKJvjfGnINLWRUjz4JBxBVVwKbUMeO4ff57jhWIvgpmVziqILEUNBgxLOSinLSanz9Y10EMV/oeFQlCh9E2irHUahQ3nMxeiMB4IqZNLtfpoe+KUjnGeRXnB4fL3ObzXjWFbikP1vnc67K+TjF+OsRQZHoo5Aoh2o/PzOKVQsdjW6CCriRjffYfQmTpHjk5juAyRk+p4yu8Y8e+0cZ2mt7vOdOw9bJ2iFi/5qs/M9WU757XN4rfWpkJBpe9eb6cP7rEWbIL8L8TzSuvMH7TbQfZcrwKA1VvV8hC5rBcx1265XKN8qRoNDY9pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg1nZhKq8zG5CZ6yHeIQH9EYcY0ix/uN4DDy9w9RczU=;
 b=Z8Hp7Mvn7BxmQuc13+CwZhpPbPxKOlrhJZ8SeYqXADuY6Gl6lEvp54i65uPutkt1o09ml7yVUBlFjOybAXnOXF0/6WysDwDnTmxxKRDid3QjukLRDGUI1kB+EYyd7pwY7Is9XqXIs103hLt/EuzgO9auCkapiG3OY3qxn2/NnZmv/o4y2Mtial6loZKw1GnKysCfQJxLeiZ4p4FImXP1AFiso/R8BhL9Vba+CX+179fbminVrFvKqhbN01BKXGxZXNvyamsoPNzqO3PDmZIwmow/8C7TgsaSXamJagVNPVQbQsqeOWrPaJLVQ8cOZqs2ivPdRRE3Ft2igeErrSXdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg1nZhKq8zG5CZ6yHeIQH9EYcY0ix/uN4DDy9w9RczU=;
 b=RDGByh7ndaCNTZRD376RC3LtfJrswBOu18k2CZkTDkc4A+YO+6F3hwTBhH7kWXyaK29O3ZsKY0mIfiYhAU2SWw/DVJPOHS8BasEWTlW1JSztoIoPy4ClAOWyKLx6WMXRCB8w1eN7YMQW0CalgpmwEBUd9dxedjcCTOp5267WUkw=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TYWPR01MB9525.jpnprd01.prod.outlook.com (2603:1096:400:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Wed, 16 Feb
 2022 11:37:08 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 11:37:09 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: kernelci results for my test branch
Thread-Topic: kernelci results for my test branch
Thread-Index: AQHYIx/hPNjPQ4fOBk+dHdB2tB2f36yWC/6w
Date: Wed, 16 Feb 2022 11:37:09 +0000
Message-ID: 
 <OSZPR01MB687741E071A81338D2F66C01B7359@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220216102758.GA313@amd>
In-Reply-To: <20220216102758.GA313@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9261cb69-8c29-4864-97ab-08d9f140aa87
x-ms-traffictypediagnostic: TYWPR01MB9525:EE_
x-microsoft-antispam-prvs: 
 <TYWPR01MB9525E4EC18E58E439DEB7F32B7359@TYWPR01MB9525.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ShJn1bcbwOXKo+CNOYFs5F9qMMGoac3tUFJ9YnpXV+qYRSYwAuzhWOsfRSxxTjZJ6s1RLTAu1XHNSxyKsQ/tfDbgJonUi6k7LiB4T1CK9EJ96ZNdl36QS1nWIkL0CfoDHRKCdjAMZsaEKPagFwTp+J+rWVdeakxZSWzE/b0yqdxxPFMYRpewm8aPFrMnnKFe3qzGoFWaOf1NOe6XBMrCCEbcu9lAiQocPTnRZRRyEt8AZyqDyk8EeDC5pdXW6rGncX242yIgsMY5rZJSFCX0OBPbXivFSqU9eBP47hJKRfLffQK6hnbTXU0dsZ7kSn0yowN2MOjia0vwlx4ap1XfxZu1EFzpQNAZQ2H5L2jlr+oCXr6Vu+y6m7JNir7SOXyIc+L5CkjoxKh1Jtg2IIXYFFpLX0336OvWmmZUpQvhCDMZj21bQdHjFglRWL0850bkbiCtBiA6QpOgk3LJZyDkNWiPgagAQl+08EjrEXujbCGYQYJw+nCp6btYK/zRHIw3tcNAqD9OzbOU7MJRw2ZTmA5lY6ur+ZHFgtql1G4hxPRVyVUAqUqhP5wXOX8ULzByE7efboAE2K2bkwruVNt8xutTI1kn2nSE23orrbnNfy84xTpdJeAmo6UVmExOAr1TIrVx+pmSvU8FG9Aq9QfGnFT6tYEdp+jECaTxhDLGGv+xY+L9XWUwpOZFSJx3yagdBmDVI56ntnR4LNlWieaZl0VkYF2nJjRq3KUMFKqddQ4DOOfTZ/3eDKAdq3ma7gWsCfm6CD6cYULg9SwUFQvuC4Jz5z99zPG67ScTnMJUKtssRaoPpvRjf5BP9ym7TRUWpuYhKhC3kHmxjTyN16/wsg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(110136005)(71200400001)(7696005)(6506007)(26005)(66476007)(186003)(9686003)(5660300002)(2906002)(83380400001)(52536014)(55016003)(966005)(508600001)(8676002)(38070700005)(64756008)(66556008)(66946007)(66446008)(316002)(122000001)(86362001)(38100700002)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?D3VoDgDaExNJpxTiIwAqDOomPCrNAgL5ZBmCiY/yPxNv4vyTTuRUH5F1?=
 =?Windows-1252?Q?g71UXPttWcH0VQgDXgeTiBM6Lq1gGrvxOV97a70Vt88mJgRxfl4xyN2i?=
 =?Windows-1252?Q?aT75doOriOHk/KPWyAgbWkYu5fljBBUFveLnfXO5Ae7eHgCClz0N94mg?=
 =?Windows-1252?Q?mMO1FvOKn2pPz8Rgmbc7rRrjFcK93dE3QwUeqOYS0GYEF0r1HeybW/gl?=
 =?Windows-1252?Q?zBpDN4WnTaqMy0UvWCAcgg67V4PmH5J4ibNoiQ45AkruemuYrNxHlnu7?=
 =?Windows-1252?Q?nvDdTif3hEN+z2upA5iH4D0fcdflvTsvXYW8qOQfOtZvkq/Yx8GfC/LU?=
 =?Windows-1252?Q?5YZ3659a4WRjx+yeIafy2XBR1UZ2gKfEG3AIA/IDUXF7CR6LGfpeWH4G?=
 =?Windows-1252?Q?5vCVgSJXIjHVWfLN+V58Boh3AkwL+d5J/VLBfJLpiQkR3DOW/O6x2IMn?=
 =?Windows-1252?Q?ZwEyyL3z0hxG+hZiDuS/V+sK+nTtdT4W8laCDzbGkPi1zqhtsGPspbZi?=
 =?Windows-1252?Q?mkzAH/Zi/+ChkwiGgZcF6C/O+/kn2LU56WabMvjaaxk/xngB5l3kRcYq?=
 =?Windows-1252?Q?EsUAAzYNq/FI2a0Vl+IxWT5OdsOnfcNvPlxKmPB6I5hVAJnj/C8Nbaod?=
 =?Windows-1252?Q?nKWkWFguFtf5MkSgvLle7jqHJ09J9nwrQavXLn4DKdx61EUgHeWUdzlh?=
 =?Windows-1252?Q?N6zgH7AldX0ky6tdw4YdpUNdebulFB4FaC508DMcEAxmjcLfOYVwRhsh?=
 =?Windows-1252?Q?lwAPnjqlqrK8T9HgOeTzNz2WNaSKuJS6L2ZXBbrwII5gqoRRZ8sELo/b?=
 =?Windows-1252?Q?5w32DeOIq2E9iqrEl0WHiuUPRLJwaFP3N7DEEuQ7e9O52VCejH2N2Aqb?=
 =?Windows-1252?Q?JOgzL05OflJwspL/pBijyi+jIpYydPqDNAF1Z6pec7UHfEliJFp6Euy/?=
 =?Windows-1252?Q?LWm/xoFRnYR4p20A2XwUViVspp33KcAIX0csy1uifDMwnOONcqz9KsFR?=
 =?Windows-1252?Q?Wee9ue9oHW5jvNNYEOGIRN1IuhDRBvC+Wk6lbxdH8ypiKAIbf7DBjr7N?=
 =?Windows-1252?Q?kMTiClVqg4RSpbpyVfaESBx+SjHZwB6G38l8gCl8ep4c1AWHcyWUxAnJ?=
 =?Windows-1252?Q?/CR4cgS5oujaUIn7q67giM0yhWTQskiaKF4csI4/GH6CIqMPlWZ6rpog?=
 =?Windows-1252?Q?mibAApGKDAz0JI3zAURUoanSvQGJQMhjY8Wet09EN+FCRyV/qgSx2kYg?=
 =?Windows-1252?Q?JtAFb71o48pOYppIl++aMvyEBYpzJKfExZrrOKEu2IGiSx9wc/sWyeLe?=
 =?Windows-1252?Q?OHahHMAHhC2sFB4AHn3q7GBtK/aKbEY5UJPv5zJeHfW+jGX3PDV3kQuX?=
 =?Windows-1252?Q?qwkEfhqgAigh070bcOP6f1Fv3TjETuAAzrRWmMc90H/QFwMDu5IUzH8c?=
 =?Windows-1252?Q?3CK/yLpeHp/12//I7q+ECNjSjhtncPtmBZ0KxGX+Vajb93kvdu+Fh1xH?=
 =?Windows-1252?Q?XiuJkZMGuzZdiRF9Yjs6YO+w29Y9Y3ArgkQHMiWqvNVLPcJzv1q8BrmV?=
 =?Windows-1252?Q?YEeSG15Okhar8NUsyOTnxyFASYoqL8PvOJZNxFOsqd5KygaqZCJePtIU?=
 =?Windows-1252?Q?aiy0RJ1I8Y+kJ668GLvJZfmHhlF5z4xt3EVqNd+tXS0LCLBHtdCgxhLp?=
 =?Windows-1252?Q?D7QOxXBmOtL/kiW6UQKqRVgqSnzM85sd6qrVAdOVMGZ2YELX9s5nnLDi?=
 =?Windows-1252?Q?9lYBUgmgg/MIJlWXPSErZMBaTxiSj1Stmvn/ZXlTuNFI/F3MqMroOyBX?=
 =?Windows-1252?Q?1cL1sg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9261cb69-8c29-4864-97ab-08d9f140aa87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 11:37:09.0381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 R/1zkWeOB+VZ2F95KHglB1twnHCtr7mtTkfdb0GPoTAWL9JuTBLb81iipI04iHNS/kUDD6kZVAqwdl67WdFpWdk5gPkeYSHQ3Vvj2PThVik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 11:37:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7616

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 16 February 2022 10:28
>=20
> Hi!
>=20
> I pushed a test commit to ci/pavel/linux-test. This is not first
> commit in the 14 days. Where can I get the results? I don't see them
> at https://linux.kernelci.org/test/  .

FYI the best place to check out results from CIP trees is https://kernelci.=
ciplatform.org/.
(which redirects to CIP specific results from kernelci.org)

>=20
> pavel@amd:~/cip/4$ ./testhash
> 2fe7e363b1b121239e91f0d69511cf354db03386
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-t=
est
> Counting objects: 112, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (104/104), done.
> Writing objects: 100% (112/112), 17.44 KiB | 0 bytes/s, done.
> Total 112 (delta 95), reused 8 (delta 8)
> remote: Resolving deltas: 100% (95/95), completed with 48 local
> objects.
> To gitlab.com:cip-project/cip-kernel/linux-cip.git

KernelCI is currently monitoring branches on https://git.kernel.org/pub/scm=
/linux/kernel/git/cip/linux-cip.git/.
Do you want me to add support to monitor the GitLab mirror as well/instead =
for your/the RC branches?

Kind regards, Chris=20

>  + 94973269ae47d...2fe7e363b1b12
>  2fe7e363b1b121239e91f0d69511cf354db03386 -> ci/pavel/linux-test
>  (forced update)
>  pavel@amd:~/cip/4$
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

