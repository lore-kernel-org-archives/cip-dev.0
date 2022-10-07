Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D88C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 09:27:33 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web08.2446.1665134843411784649
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 02:27:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=rx6JQujb;
 spf=pass (domain: siemens.com, ip: 40.107.21.89,
 mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQIiNdmaXKUDqktPVgS4NvqPPup19c+IiS6JTkNt45FqTUM1xQW88med20ar/JNW+zLLlWZsmYXjf+2y5XwO5qcOb+WfIJWjwZGPalSWOjqI2c0mS7+Hc1wtwZe/lMfkFmBQyodpBPPp6f/cAxxyDlilOpd/ZuFzTQd9OVuvRMFM2KtwT5Df91BQ0uScRFxq4sD96ZBXr5NXvWfsRIMKEESUiGPNyJHjx1fq2XWQZJFxZtn9hXdSTEZpm5xy2lKblc5fvPzoJWWwECyRIToVJFzDWkJtYTRAfdV33YLmF7ryHifk7fSgLj+etpajN6v1nAS4t7F0oikfyQFgfEinLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID15DFGKK0XSL3eLMpmEi9NlI8/gj0YFUwztDAU7Wcc=;
 b=Qkb0OQltEYFT2dChmDYb4cD+j0VYn9QLoxWRWJJZeOd9ou1IzSlooRxiFwSnq00lNpw7YOYETYEjoxReZ6vzohK2QUcBjqHX1RDbD13BNERW+Qzc3r0aOIzheBlGinrgvNIyPEP/sgIKx0IcaZ06x8z3hJDffMI+XQHU8fvwLYLyDDKgKNPJenvNjrJBzkMLthNrAAZO6iuNQo+sEaaYqz1fbtyyn4THSFGHNEzl98Kx4NjeL3MrV2wbAeDWMGUwzwqmtxQkULTJ0V8/Y8fm7jMqx3yIwyYE2MlNuqQOW34Axqq9hKkZnC1GC/ZviKYMDEoak3KOEGU08/GaqzjeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID15DFGKK0XSL3eLMpmEi9NlI8/gj0YFUwztDAU7Wcc=;
 b=rx6JQujbGD3kxYcfUFWM7a4FX7lb0nOLWj9vPZH7GSzNnCcJwzDKFtpttgT0KJ4c+dJNU+/X6985MS54htw6ih6EBNnBWsCv7f87KAxYP3kvL6jkBEpQsd/UVw+3EHMMJPCe/OSQQYFoN8ATCkkiUqwxDkyyxF1u1Vy2aTeNMZggX8uP5CrD+1BN9YvNhZYh8h+2hb/FG0IQhmUzj1HaflukloDquyM9DUq/H7eW+QVpn3A1dVQ/Nx+5UP8BwsGBDF/uGn5spNED9NU9CCwMUZJ7haohtVGPGq1Ca3EtN77h2EXw00fJmBD/H27V3CQ1SamzdXBQ1HjxHw1uURZbYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB4PR10MB6312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Fri, 7 Oct
 2022 09:27:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 09:27:19 +0000
Date: Fri, 7 Oct 2022 11:27:00 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221007092700.itoos26inn2uz3gt@backstein>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB4PR10MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: c3feba38-cc15-40a4-eafc-08daa84621ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hm9EYZktiJZwrJAMWD7GydIkolBAncn1p38Jj5Sd6NFfCHEKrwf4wjQtAYJUn8Kac3Y0Mb+SdPCEcmXoqt/T5UQdyiw+07+wvfQQlK+62+1+/BH5ZLmKZZX58RHyFY4MSNtuASn+Z/F9zsZf+o7SSdX3bTuTk7xsuIpH2dtOBCwvm0C9O8dPwZI3fY36MSLa9EtVRK0lHtVSvCXvlYhXkdavR8jN26ntxFygtc3TBSazMQFh3KxXkToN3bj16bF5OqNTxjweUpTceQZIHxsOQJ4bBOnP6e6LAoGMUOX1YFEm6qPAgxH6cIAIZlZBcFSk1e4rzi34sz/cMGFonb6Mw/iR5oGhOUoQ7OnFRU/elZGp72AUdGIluyS/3vrfGpaByytpyDpNfCj7v/lSfayGxEJxJ3jMFkp9/wBKCXMC3PDL6svFyvJwfqVVJLNCPQCo9ty7MzsNXXLLPI6PSml220c+jq6gyGtwFlqrpt+bOo04ip4jzw1XS3zOc37QPDb13eBRFEIn3JPyLC8z8wmKjc8EnStZ41tRIQNpOlCKrCp/HYV6phr7+VSp8NQfqMuk3pCud4vCyER8okSt3YgtxLBM7pjIWppO36CSf2igOQl60m4lKVJhMvmFEvb01Q0Z1vnoshdAfc95TmRYoDtk1KQlx16TOjzpTKeKfXVVEdyIWGBUv1Fio3ZTmkJc63MYtI7H5ZMRWrCpTQ91nj6vNg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(66476007)(66556008)(4744005)(186003)(5660300002)(38100700002)(6506007)(1076003)(26005)(9686003)(8936002)(2906002)(6486002)(6916009)(6512007)(44832011)(316002)(33716001)(66946007)(6666004)(8676002)(4326008)(478600001)(41300700001)(54906003)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ejjWRNNXu9LqTka7yM0c55/+7tVS7pnuSflOVMRhru+fVr5oJk7Z6B9kqJvM?=
 =?us-ascii?Q?NXGEqW+YvsDDQrBjeGJNTVTbR/0pAK9h38ICQI7NE82f4RLLL7KAq0fg4BBq?=
 =?us-ascii?Q?+6OUIwSgpIkxFWjiEpQgyDUGMZlmhOXaQwUlofu+1la8B7X/zlnpFSIZ2bvh?=
 =?us-ascii?Q?KwIQhy/jL+32JI64xTM9pjynEGMXFItVMGuniwK7agxhqLsFA6gfZUPN+FqX?=
 =?us-ascii?Q?y6QBxpjEHqwYOqtozV9GiMMIJDmqbCEV3irlsG2Dmeow+1F7UYIhV35UR0o2?=
 =?us-ascii?Q?gWqltfiP+EBJEnkq1KdJtHVoiQLjueKnsb9p1pxRiC1CfK4fp1kmAyIvrVsQ?=
 =?us-ascii?Q?bXH3Mufp+vR8oZRBTquQ4Jee4gZ7vcVsDzvjede53ivgBJ69hVHq/935blpg?=
 =?us-ascii?Q?QKAXvIaKnPFhfDpALspQHIH3OcD/SjP2yES5qDVDXDriWdsd0yBsxfhTB1uB?=
 =?us-ascii?Q?m6lh1PLZ6TQH2ln/XAsc80qsma8XlxQ9cGgH2l75Z7XWLNR7EYo3blis4xZl?=
 =?us-ascii?Q?AZmpzkyL8BZGMTqDN3dMep8lDDxwwgjidPezSQrXdq1Wy3zlK6ap1o31y7Zz?=
 =?us-ascii?Q?UqfdfHaXwNgHq0qZBPoCgF96sC5U8pZQCiklLuu7/1DBK/azXHd5rWIAhj6S?=
 =?us-ascii?Q?SBLbOq2nxDh2QtzhwuR98zBRJxZy4m0ji6pBzcyPM9kBpITEMLhJQGAJ7SO9?=
 =?us-ascii?Q?leJExkf/NWZxw28iPt3RVfME9D7sS6ZhM9gpsRb2qWmtn4FHg+AT/1KbceCO?=
 =?us-ascii?Q?HdU8lee1JwncGYjFo8gJiCDJdijWA8/5l3TujMv603CBK6pb5YAGWf3oPiU7?=
 =?us-ascii?Q?aL03+cEiS/zUhqw0+gRzUmCgv9yxeKHPkYMwWq96NdvPxvcnWdyBHNu+FX/U?=
 =?us-ascii?Q?SjFKFRzcbZ4JWs6U8WZFRcXAOJsVcNEkE1Z1aQpnZZadeKSzQdRM+lHKuFQZ?=
 =?us-ascii?Q?oey0EIAJMH99GTaLPaCMthTD6AUpE1aWomF+k7H71uiMmMMDS75YcebtJEMG?=
 =?us-ascii?Q?jYOZu0FA9zX1j0bjyGRzXNYZsck7iEDh3t6T5AeTNdJ+7mHfdMTIoQcYRfEp?=
 =?us-ascii?Q?/asSY48Z0/onIKl7VInNvj47es+gj8CqsSWTXNDIb+ESckjJAGEK4AMyRa2e?=
 =?us-ascii?Q?nb66oJDsIfPCeQuhdZdSjX8JnMqqsyiLmei/dpsPbze/2xRAKwsKvmyufQAe?=
 =?us-ascii?Q?sOM1GNFYx6+DYEtYaIQYrXKTazk3aZTIvTdXeut9zzsfqDGOwpzmCsKlV4eU?=
 =?us-ascii?Q?nP47FU2SfhhIF8lKpJ/YoFPLKr7PPuQTN9gVfA+CCeepsjduJuwde2nxG1Ka?=
 =?us-ascii?Q?daJzb9Eu5BlXMN22ypwNRJ3ttE1cvTWUe6DUvYlHkZ9c0Y1ulcWqDYPA1wxs?=
 =?us-ascii?Q?wJl4skpkW1Fv4tnEbn3IbnhxmZ2xr/tfxKekyCLScSTHOn0FLo8YXZxVe0ZF?=
 =?us-ascii?Q?ARgO7CuccZYshMK6OYsUD1oL3ngviUxhyN3p4lmdu0vi0kZ2K0tYk5mVUyKL?=
 =?us-ascii?Q?c/kI8m1V7nlohyw4xqXBlQz3IfswptbvAEOehZsrBxE/mcftq7QJ/OENFnr8?=
 =?us-ascii?Q?kyI1ZS5QPKY0gGohiHWIxPq5ek1y0M7sHn4hQFlwxKzGGIWFAL/OjrLjZ7Dt?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c3feba38-cc15-40a4-eafc-08daa84621ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:27:19.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 9QsJ//2oryai4F0P1OmC2g5HrjKqZ1joZGWg6VI0W+Kj3cgpRi/neMdcb3kqbI23M5i+x+JAjo5SjwA8TCJxT/NO21oyH/w4N19HXsVvO+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6312
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 09:27:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9673

> We need to find some sort of solution for building our CI build container=
s.

Why not use the shared runners provided by Gitlab? Apparently, there's even=
 a dind capable runner (tag gitlab-org-docker).
If the Gitlab runners work, the next step would be to make sure we are usin=
g the same version as Gitlab.
Since we're back to using the exact same versions as in the previous cluste=
r (which did work for us!), my guess is that
the culprit is outside of our cluster, e.g. Gitlab or (less likely) kaniko.

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
T CED SES-DE
Otto-Hahn-Ring 6
81739 M=FCnchen, Deutschland

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike, Ma=
tthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berl=
in und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB =
12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

