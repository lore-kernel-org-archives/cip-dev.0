Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7DC7EE23
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 07:31:58 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web10.16728.1684740711493309408
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 00:31:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yHkDS4CC;
 spf=pass (domain: siemens.com, ip: 40.107.7.54, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnX0WT2VbYO1yB53hCL45xg1ResHE4apHLnMWxZFXoigEqgCe1Z3/Sw41PVKyokOmo4e2gMY0IhsYlgQIMvjIfoeg7d52ZYuBglheCU7c3ueuRnsbwom3otkoIRtnxBErf72wvREDWyYTGAwCTaVWGtfh0EKizaYZ70PonVS9K9PQ8clpdx5LBqeIMfeshIgeW6Jqrm8DlCwyb7hpey3N5IaCI+v99xNHns74DsSI2o8k9m6W2k7bzuvp4yzssyKU3BVseRIuEU+BKcHiyFh+oy456316nM3h68a0nWe9PTEh8B/5LWnDTXlnAdxB4O2ZdI9W00YmBqa9g4DphsRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TSsBwJZAwtHZtOOhswQ/Opz9EqwWlraEUDBaER5Qj4=;
 b=BRJpVNXBsElSEiJeV9mTiM6huHln4iqBIvciU4+8YuheTr0IRZozX0bzjlWqomW/RAnkXLki+zPVdpCw2F6YFEH+5HR7fxaM/hZbisfTgxbEBAmGozZ7CdjsHvPvWfavpSmWiY+S5owJ7LyaLj6KBGh7U2GUfnDn1SWFYX5ppV/mrUb+HrBkFvNK3cj2EitxAcQW7I6ciw+TRbe2TWnaKk3URkAxJd5o5TqCQRG9pXbfoMh0pYHLB20n71N7Opyw4KDO+QWBqmYgUYm9n1uVji7TZ5JWjXKMEajzK5PSCDKLJufJmhwSJ/l4gbaJRLvKesUi91aXN+UH/w3yv55/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TSsBwJZAwtHZtOOhswQ/Opz9EqwWlraEUDBaER5Qj4=;
 b=yHkDS4CC7EPpV462KS92VOlImq0ZHUGJvJUvNcjWehDFaEA76n1GISAHROp8E0ityxMXAfT681wLFzQIWNytbNVkPXYbt8Vg9EXKjY2CW/ZKCHkpU1KlcX1zqYMzTFapC5IsJh+O4C4o+7fHfG2wm8vTIxvlihbeMRgV0Gu1AClx7+h4N84CkO6wiQ3DuiqDCuLA7HkLnpfpyLL0CFGeaywXO5uQRJgrAWyHNHEb++lo9ZzjWaHqbmCXIVVkKYetq41NfTtnDAmAIlpIfB1sUkkkwBcvuQYP7IMU/ReS4jGORB82tFv3LAioSmh0baaDBoFDpfUNgGjAQGiFl9VSAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17)
 by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:31:48 +0000
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6bed:3b93:4756:c9f3]) by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6bed:3b93:4756:c9f3%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:31:48 +0000
Date: Mon, 22 May 2023 09:32:10 +0200
From: Christian Storm <christian.storm@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add recipe for
 2022.12 for bullseye and buster
Message-ID: <6etgftpfsw7e7n57rjqss7bu2sgm6i7kdgaekgzfqsawgk56yj@r2ywsjevm2cg>
Mail-Followup-To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6d1ebc76c90a46268926d0eece0e43f176a1060f.camel@siemens.com>
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:333::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5404:EE_|AS2PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c171afd-bdb2-49bc-723c-08db5a969a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+68SN1orJp6hUVej0klOrhiIGHgyxfUyMixuhxLvnIx+27N1LAcIet4ay6f5pcER4gP9ddh42AajeTLU5Pqgt4RHr3OgKOykX2xtD8YwI1r7YhSaKOAocqly7G/j5SQLPM/sX4N0lZU9LIhy+MFsreBjSsLgbf+HqgiA/D2aaIMqej5BlFgb5zZ+A3uIeTfkrlDDVw5e818po2dX9m9pk8YlG4duntxUQHJvuIVfJ0ryGd2JaZxaYuGF9QFnnbGHFUTpahy4ALO/IMjpa6WABOEzbkPXHRJwZDYM4Zzw3RIrJEUsdgJ4O3GyvPXgM1Ie6SZyWL0Aa68fKhRN0z6WlJgLsNSk2n5aahqGALRp3S24BWopBRy3DOvTXErxqN9y8rBObn3U1dZsJ3qPQX5xHy5sSqk07JRP7s9A0RNEjbVY4DNc6ckF6tnHhSSXtqD2uHIQiawqmSiZcIZ7/EQNcgIvMR6NlhcXsaskXiIXQd/pDTjpbDbPNDBi8W9Ju5G+tNZZLvw1It5zdxsknxckj2brMndxkqR8fKLHfexwbg4xKkQFUOau/ybeFu6vcH+m
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(66574015)(83380400001)(186003)(2906002)(6916009)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(478600001)(5660300002)(44832011)(26005)(6506007)(6512007)(9686003)(8676002)(8936002)(33716001)(38100700002)(82960400001)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t/xc6RbTDeU/1xhJyjnP4/u33T8/JnYJuE0rh7epAt3RD0ABUxji5fOeaT7x?=
 =?us-ascii?Q?5G5P2PjhEUQaSKIw12K6wiavZgmUuecG2AviSnPhqGF4G8tjdr/AkChpuj/F?=
 =?us-ascii?Q?J+73yWoX06I3DXpYHcAjwlmJfL1bnF/XeFzwHkn7NJe06gYF8gvnXo0HvHko?=
 =?us-ascii?Q?Vx2y74zMKaFuMs4kcdkYGhIDeEJlvOqxnRHNukHxCjt5HO4BRieX0lA8SFU1?=
 =?us-ascii?Q?tfaiUAVBtCW3rgGk7op0TBUvvvxM9QaxLLwAL5XtXmjUexK5p73UHfEFN7AD?=
 =?us-ascii?Q?k3Kbdt2ETtiaSy9xlQNXqNcXOXwtSwgqe6WzhL3c946yJ1jnoKc+7LspLYe5?=
 =?us-ascii?Q?GZQioj+/o3ZOwi0r57u9+E5hFs4rs4TuyXMV5oqrLh3IOucTnjCjTEyl1RRC?=
 =?us-ascii?Q?5pXEh6P17kU4aQdwWcipuJVk982tgFB93hFgFOYy5dz52oLVDPivt0rqCpPY?=
 =?us-ascii?Q?Y6V/Tt631IQffuXX6fCPsUpqKL7wTl6nYXMh3MX2YE/2VBQfQxT6neJbt2WN?=
 =?us-ascii?Q?ovGnScPpffgTxFIeeGYqqo0fNeN+a3JFRsOdv5IsBfb+MlVAa6GD1cxGUlz1?=
 =?us-ascii?Q?hVsTALCSxryVCsEiI6wIn3oau3VO0aPfp1MkENrCBGvQv35i8j01KrjBi7jA?=
 =?us-ascii?Q?YGeDTyywJ9lPsW+DNVJwtNNt4iTzFGfQRM0CNKFtbXWK2Zfh+WUk16mCVMMG?=
 =?us-ascii?Q?x22GbCj/P6ziLPQFvRT18Q+BphxYaiGEJfdytdYEPefwCiVTLakGetWq8jit?=
 =?us-ascii?Q?NDC4uDv1t8VLII1F6+6LdvaENrm9uSjdiviTdDYjBsyJLD3UtInixfDKTDyj?=
 =?us-ascii?Q?oKCj68PxrInsbX0C0ZKxk7+bCP4T399oOO1RRxniOlp5y3K+kJMn7zCTQIZE?=
 =?us-ascii?Q?SizolojRGxQipFsTUP+SgwS1QE3nMRtx+kDt7FryO5+w7ve13AxyTEu7Y/Qy?=
 =?us-ascii?Q?0x6L17jSJByXkCVaPiPgJoKA2xMcvdVBE5DENTg20S1opD1luPoNV8qrrRY3?=
 =?us-ascii?Q?yRzUFEXIVeSm9HK9PecE2Ju2VS9OpKq0A32+sCtdMv5sDidqTAootMEKu0cP?=
 =?us-ascii?Q?L7iHlTEmQGob7n0sJr94+VuJe6JKz4ZzET7urjWy41RNl5IRJhvKea5VcsBz?=
 =?us-ascii?Q?VpSY6VRue2uGbgdJGWkf65qTWPJR8TwNtYh1a0BJpMrb86cBP/W62eRa0uns?=
 =?us-ascii?Q?vLaa0GjcpXUrkLcris3WGmQLXbfy/I9zITy4QD2eFLzjkRXxiXpzKsLz0qFt?=
 =?us-ascii?Q?t6uuaXdZrHqAFrq5AFUerlZAq7ELvWLHPPkC2Ufox06M3GGQyQr+1se8/sy5?=
 =?us-ascii?Q?ihk5tB5gcBDbz2kAjmyB5CcudlaOzR3xoE2kopwCKdCHbp4wSGWdxabVF25i?=
 =?us-ascii?Q?hjDUq0aKfMmyXF3ZzwXIEgquH6NeieIc7SxhkTTxw83kRCX4J+Dk9zuv/Ggu?=
 =?us-ascii?Q?aAUpUxGncEHKZtLKycRtath1T9UqX/KJ0jPwMmY/VG8/QzWJhNGq5ob5Y+UH?=
 =?us-ascii?Q?q+Oq9V+XfWenO6clAzAdvbaXTi8eiN2Hq43mSCWqeZMt++1E8NmH22KGgJBR?=
 =?us-ascii?Q?wRbuji+91vQp6MV+AesIZKbtoFXYgD04uDpiy9YLuCPOdy9RTTPZHHxPiO+n?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c171afd-bdb2-49bc-723c-08db5a969a46
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 07:31:48.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8Om5VGR0F2TmnBILCYV/Si2ofPHNKlfEivgVE/1/Uex0ex0rVmprBDOTY+S+Gs6A5a5YeY0rUvoN77HiupPYcgBwGyvl2hpkj++PltlYDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 May 2023 07:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11582

Hi,

> > diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-
> > suricatta_lua.patch b/recipes-core/swupdate/files/0001-d-rules-Add-
> > option-for-suricatta_lua.patch
> > new file mode 100644
> > index 0000000..0be5a71
> > --- /dev/null
> > +++ b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-
> > suricatta_lua.patch
> > @@ -0,0 +1,30 @@
> > +From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00
> > 2001
> > +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > +Date: Wed, 3 May 2023 16:02:37 +0200
> > +Subject: [PATCH] d/rules: Add option for suricatta_lua
> > +
> > +This allows to use lua plugins as suricatta backends. It is optional
> > +as it overrides the default HAWKBIT backend.
>=20
> Can't we fix that in upstream debian? The idea would be to have a
> multi-package build with different configurations? Then, we would not
> need the patching of the debian/rules file in cip-core. All these build
> profiles are problematic, as they generate different configurations of
> the same package, also with the same name.
>=20
> Ideally, we could even fix that in swupdate itself by making these
> options runtime configurable.

This is exactly what I did and brought upstream to SWUpdate. It's not in
a release yet but will come with the 2023.05 release. Then, you can
compile-in support for multiple backends and chose one at run-time.
Still, you have the choice to either bake in a Lua Suricatta Module (so
only one is available in addition to other Suricatta backends) or to
load it from the filesystem at run-time. Then, you have to place such
a file somewhere Lua can find it...


Kind regards,
  Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T CED SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

