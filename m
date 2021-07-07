Return-Path: <SRS0=x0u9=L7=lists.cip-project.org=bounce+64572+6596+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1904C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 07:50:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2A661CAA
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 07:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2A661CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6596+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oRGDYY4521723xMVC7mYb7z6; Wed, 07 Jul 2021 00:50:04 -0700
X-Received: from EUR02-HE1-obe.outbound.protection.outlook.com (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.73])
 by mx.groups.io with SMTP id smtpd.web11.18173.1625644202423144822
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 00:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbOGpWM8F9aLBeHd5e+7hsttZV5AsDxqK5J4rhh1x8grLo4hjGxDyfepjk9/8h4uY0en4MLnh4kER/4AGNBdTT8YeCd9VPT8GqiiFHHL0RVUPRPoJT98N1HkEF7YrAEYGZ4976yLBvoXmSS9dJ2jmsf6vo5fvS5Eu3m2cz+KQqUcVHFNv9C37xMjZjNMv/hTPFKmFTFBNNUPypgxt9HVYlS2n4vXD9dO2rqGWdl/7sNB2bDRyrgXGTJn9BgB6hL5qGVDGk8dLk/mcS+EkfqSwSgy3Ejw2W9i6/hA3+Vba2dOmJl2I/dhWYNNtFoncc2k0fCOoCc2hoReRdhg63cWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t1rxNxYEyN0IYYDqYC4Z0numdC4FGhFi0YPEjw+ZP0=;
 b=ldGa4u2iG9O03pGuKPte9oWjVZGHE4m77/rdztsOMecYv120s6Tlsn+pY4jd/tuwaK3x5OLvaZuWkR3H24xuU4XU/RBYm4NDSvs05Fu2muKsk5PQZw5MsUAGU67WxXAABH1tNHJStkiMl6ceQ0rgA8bBaGGHJa7o+kOABJB6Hn8CDnSWMh9IuF8ABtLpHJb91Ls/8oDw5y5G2b/ejpIxh8BraRfHx1WM4avb4sTE5j0hgDAs9kjiwN1pe8QBBlfnBo36wGEe4tj7t+cI0hV27bSWK1K5lGEaAIH5UiOysyy5iEFPeowEsqfWBQm91cQc6LQQnwZ/aUL7T1EOT2l1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by AM0PR10MB2484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 07:49:59 +0000
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c94:c889:ed69:3f5b]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c94:c889:ed69:3f5b%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 07:49:59 +0000
Date: Wed, 7 Jul 2021 09:41:07 +0200
From: "Michael Adler" <michael.adler@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] isar-cip-core unhappy with our current runners
Message-ID: <20210707074107.2vi7fmd733frd3gr@kratos.fritz.box>
In-Reply-To: <c1471b55-097e-9672-cf29-5fd579a23cdb@siemens.com>
X-ClientProxiedBy: AM0PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::42) To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.81.42) by AM0PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:208:d2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 07:49:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a2537a-b173-44ce-3d05-08d9411bd1e6
X-MS-TrafficTypeDiagnostic: AM0PR10MB2484:
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB248420C3D217D248DBB336A6E81A9@AM0PR10MB2484.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	kYvIqMT/wltPVdB8IRUboSbN3AwAr7iFZBjXfPxL/dTHH8eusbldSiffeCNe/9Bl7w1gMDGg4TlKhT1JsHnEWWbYir1FkPZE/eWUWgUHKgx00/UbF+TxmMx+JaSXidYN8TjQHelTmiueYIAnX+7zTxFKZsbuIS2VMkrAarfvnDSTA428fC73vuXvo6r7Hee1ln+rO1Tzbm+Qi3UfvZqGT1+C3JAeY3libbFUjw20P8fAk8aG3fwveIMAXsr0ORdtQfBFSWY+u6c+5i58wP/rmGCk+e4SN5jEDV9W9GZXQRe9e1D+YH7cUyXNn0njG7UWiAKS2ifW7vgxcVHKDRvv81GZoZiaYasQJiDKM8tam7AtRoUQr2Cbkvz1j5tACzg0drdW7eCdCEVR8GdySIx8o0wfb9rtU8Gohp0GtY+0BAknGV5PDRiRXVbM8LcvbqrIp7wg2qgWFESRdK7dQJUBc9+Y8Cd5OCZ/LtqSfldxMcCOcmazynHpeES+rPTFmotkBE1aMTbHmmLqKFvlNgrPAGFNkXzCSoO3s0JUPVoApwszWgLSlX1DLQAP0OXu9Nyz89hEQmLSMznqF9fLmgpsUXu7EWEsGUXAo/wEkP0v53mEmxFXW1YMbAufAKumZEJs7tylbfnDRKi5Hskb+IVU9N/AftJ200b4uyZzBEIV4m2Wxz1UEzbB7JdxUaoVIVhBMKnRtM5RlSBr/a/0tXJ7/ZyLBh3ymhVOAMxp7B+DRuA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?twTzuiJLyeycaXF5ZE4x23NSUGT6QH1ysblI3kSzExirr67U7hZ8nZo3o3b7?=
 =?us-ascii?Q?NkRNZOkie+pER7Y7GP04oUSSOmaiqkT35pF26Jow95laSYWRRkyrwumyjDP5?=
 =?us-ascii?Q?u7X46Po1Hjo2WLKNVbsFsgiC+wg3j2jI8KOXtbupL+KSoyTlGQh0mhVdbKep?=
 =?us-ascii?Q?QnbbB/cikmzErCm4LRs0JPSZ8gBgTUt1LcFsn8fkMmo3a7/h1El7/azOdQav?=
 =?us-ascii?Q?2MDrQS4mm/p9gJj0q8kviJ16ibXxttecfrRN6srb/1D0XGUxBNnScbmTlsTD?=
 =?us-ascii?Q?eWj36eW47hzwHsAcS2INizF64LKJv8UXoauaYVqYNULZqYIAWDnxWk3T0vhv?=
 =?us-ascii?Q?NpiKtl6/Qm3TgBPMqvKGpYu6a+ILicQnYquVLJFeVi9it5KrV7vmexxONi/W?=
 =?us-ascii?Q?iTwG1ZR9h0CnSVjks8Dv2fLHrUJN801XUaIty9WgZnA7lnkrVuElnw/MFVLl?=
 =?us-ascii?Q?2U/c2t7Je7mzmQremC4Yuy59vAzWf/ru8StnEteMTks/xHTF+BQ1F7HrMGve?=
 =?us-ascii?Q?g82OZ2Sr2shn9Te45zGkzFdLD6wnfRcwmiif+Dc09IiVVI3K6pwG/ZrBpNrv?=
 =?us-ascii?Q?sDgBBoKP/6UgX8csO6Rf5Hr1fbsVcJrhGXQO43xTTN3f84Mp9Z5Cpxc1O6Z4?=
 =?us-ascii?Q?NgHPyWyi22kyf/6z5XdH3zFZi9WqYuxjPOT7YUklPp4P4vAq7Ms+s28Uu2Pr?=
 =?us-ascii?Q?jZfw/ganC0zrzop3QiGXROX5d8CVxSa282LG/NLLvInKTZ2QwkJ0gI60rBwe?=
 =?us-ascii?Q?ceSMfbpxPZ9i2a1EKgdbfwlYouupXCTRhE3JL9MQtT0UMkosA3hsI9AeO0GZ?=
 =?us-ascii?Q?hJ5fkJjqOOEOeWr1zG69VZ2UGxsH1CM7YJPBseVxbT7YZF23H+HCasrHBJ9Y?=
 =?us-ascii?Q?b0A8IBd3UBhJOJFssbPSM1clpkPZiYYuUG0RCLXBOu3V/KKBV5TlFMC/NkzL?=
 =?us-ascii?Q?Du5Vy61dDBIfRCGTBmD403Nnp0Iv6YwghTt6j3p1P5oNruW/GEIEbhRAtApA?=
 =?us-ascii?Q?CIvFfYhlsm4RFalbhQNF3clZ575I5viq+RU2WjRSc5ckMe418X1s+u0h2h9u?=
 =?us-ascii?Q?ZO9GJajKv9U73gSGrk/Y7pIXU/Q/YnwkhiwW3oEbcnKGSn3ZLDHy+Jm/fzDA?=
 =?us-ascii?Q?5nXX+mCM1b3SVn25rsXSweY1sAgnEdkfcJ24zLuQQynb081GVYtekdNqJpoE?=
 =?us-ascii?Q?Sc9yJToGOngBwdtzYxze76EtlKmXT26hamoU7Ms1PDSuosmzbAoQrxRVRVCb?=
 =?us-ascii?Q?XOjHSKMbm7X5avJRPp6RqESSVkSdeHifMCHsfn+soCNDfXaTxpH1TcugIDKY?=
 =?us-ascii?Q?wjg7aX7epfs5bR69oBkYLUED?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2537a-b173-44ce-3d05-08d9411bd1e6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 07:49:59.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWHuJxfeqQzQaDOpMLomc15gDwAOxcSN6Jzi0749odb7C27nAods6GLWRpRQg8Arpelgb5nBg1yjplLCHNKknFYYPqb2IyNQu7lZTWdRjaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2484
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ut1LfGzWU8gpQMN26NGT8YR8x4520388AA=
Content-Type: multipart/mixed; boundary="O10ALVIzeuo0puFx0mc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625644204;
 bh=A4Otuac5xhFStzWGTODH2s7i+YHTbLBcNfU7B0ImNdk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OfBQXd4cVALsPrDY26xa+uNx/4bsrIv+8UvPznWIm0LSK6uI8FagAL4Zm60IN0KY+Du
 Dw5jWqu6ZhNZnQFJxL2R3EB/3ZopH1V6LmuOy4dGsRpoCWL5ra2lcqbFXV7GNEtTLct1I
 K0qxDcZfaSUUzw1s0gHf3H78RIOoK5373z8=

--O10ALVIzeuo0puFx0mc9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> Shouldn't we add tags to our .gitlab-ci.yml then? The group runners
> cannot be individually selected for a repo, thus isar-cip-core will pick
> from both, I think.

yes, absolutely!

This is already the case for the kernel CI pipelines, e.g. https://gitlab.c=
om/cip-project/cip-testing/linux-cip-pipelines/raw/master/linux-cip-pipelin=
e.yml

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 M=FCnchen, Deutschland

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike, Ma=
tthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berl=
in und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB =
12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

--O10ALVIzeuo0puFx0mc9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6596): https://lists.cip-project.org/g/cip-dev/message=
/6596
Mute This Topic: https://lists.cip-project.org/mt/84024159/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--O10ALVIzeuo0puFx0mc9--
