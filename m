Return-Path: <SRS0=2frd=LQ=lists.cip-project.org=bounce+64572+6569+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E5C2B9F4
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:03:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD2A61289
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD2A61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6569+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K4RKYY4521723xU07AQHaY0i; Tue, 22 Jun 2021 01:03:17 -0700
X-Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web09.5776.1624348996593792208
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jun 2021 01:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyDX2o3anQftAtcToM0sHZu1EE3tSm6/rTb0E1aaNYk6nS4B177y1wtuY20xWgfR6nSlfm+CZekDziJwCzfJEqpN8+YdoITm12rb6k9fLVW1muCw6vakcsrSkU20TnpvaeP5VJGIvey9uhrFzC1TzsKQXSt+QFvzTS+vQWYbJO/TCxRReQ69OZmmLY2gz6SSOR99nUtF5ljm3Dcvpo7eSWIX3mTH4FEZ/w5uV0wOZ+h8v8jASU/xuxEAMu+Joce8qCNbSnjI9Um8SvvAOuHHRMzu8VFTpgAqvRQCJvPYVpuRWqCFdOm/xxYuFNvUGd/6dzXvih/aErHWkCa1DR+pzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9lJcT6m/q32p4BDV47ZEBYKf/9PHlxzhDr8WfRiETA=;
 b=BAPcEECOJ4KRGLftnL8l4Zmjle0cVjzXrbv51NvutoBt7A4zWgi0eo4l61JG2NrnsETtUIzuD2q8v2FTy61m46jxBBQX/whnmMuQPbTLFGcWkK14/kCcyVB+KX19B9qdZqn68vO7pnbSJWZYTQXwVBSVfxarOr9WJCOcyOq/nWDlwskU4itSwcLjVzBrIEyI//byWf8lG+f9b7GIgg2hmJCvSVJ1DBQ0V+Ly36xAI7dkLjNYRVPskDsgYtucwTUuALgfFJz/sYjVhtiJoPCZ7qqg27UQEf5FQ6hNFwdXDAOos+zTSgMf0fGWsB2vv6uCgERC1LsBqN3GrIIwgmFnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by AM0PR10MB2675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 08:03:14 +0000
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c7a:86c4:6a88:e7d6]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c7a:86c4:6a88:e7d6%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 08:03:14 +0000
Date: Tue, 22 Jun 2021 10:03:10 +0200
From: "Michael Adler" <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] Failing -stable-rc tests
Message-ID: <20210622080310.hbb72zbb2du6qgrn@kratos.fritz.box>
In-Reply-To: <20210621193629.GA22045@duo.ucw.cz>
X-Originating-IP: [93.104.81.42]
X-ClientProxiedBy: AM3PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:207:1::18) To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.81.42) by AM3PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:207:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 08:03:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eccd2e3-9a01-472c-d4ee-08d935542f47
X-MS-TrafficTypeDiagnostic: AM0PR10MB2675:
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB26754EBEE7426D9FF6E6973CE8099@AM0PR10MB2675.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	gmKZeI3ipujRFXhgYEY2y/dDjAYpY+KwpBucPowNOysJaFklBhmU0YepCMqJiZWEo6l/92lIlnrC89E0ZrfuRy4mouu+SuT9GBEcswwTZgVyZHRSJ5fav3vDyEjBCl7Oxuyvdixdz36Vu11fkZfggNsFAqYL4ke82pPSbxhC2hjUrHC1MKGaYiP4o/nnHfcN6Aqv75uJcum8Eb/qwzzkhBhZfoc6oJs+G/uUB978vDmVAiGozbMXXBYjLaAVe9HsXQR+Skpqmbn0enllgMPhUQAmoscr5kAMbFhjesoLEDspo44A7jPmijv4YECYeav1DxtqS9ub/9gmAvmf+Oh87v/1EqbEhcrSwAZGbQgv50nvYkwAu0wLRc2PyQqKDEAC1LN+YmH8be4EP7/MI2SbDQw49cvkCKEWTA/kufA9za87Lq/06J45Zg5E/YpdkQTZGykUUx+90scTbTgwQI9jlmSJt6RiRA8vTsrfOHMGokMeqU1nqqYVEcdSVnCZxdZPGBoNX3D1uA6+kl4c+v3YJ43F3sTAQ35t6yytFB/wj5dnfaieZFiPZNlfVEXlQm9SAyKsrLwgRqFVHdKsPwsEL9iJMzyAWOU54ctssJu69tEReIsRwSwO3/6rVRhcuZqisqLMR2raRiEqFHuIsfzqyBQn4mkDBR+GDcG3tn4VtaiqMYxj+A/oWVLVQq8cFRpkq9tV1VRX3esDtlwGfKYipg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FmmPkM8fhxOe4PaxlvEqrYPAW0GRGV2Zg5RwbRjk3LK+j5zXGnxOjxo2Oosd?=
 =?us-ascii?Q?bSKrJnJImhFj5WcP/ZXMnSCN8AtpXjzBd7G/+3Ep60ZKW7c2fZduOpW7vSsQ?=
 =?us-ascii?Q?ruclFBLSvvorFw0qR4MV4MLuE/Jo/4DbIIAS9b/CXWAC0Uc2aFK7msot+rPK?=
 =?us-ascii?Q?lHDw+I5lMllzwNBrxvMq6825wa1JNMPHczqN1nK+ikINP6v6fzYUoQXIc5jl?=
 =?us-ascii?Q?szZKObkteDXM0gGobTOBOGRLXnLoeSzUSHp5/5ZAfZAm84tklcqpFfKMPjwt?=
 =?us-ascii?Q?jgOTzUHPGAunP7CVNWPCqNkrdlLjv9HHnipWKfKo5B6OQlIDpsyany6CTcrI?=
 =?us-ascii?Q?g8Dhc5HRfgUr5tGx2q4DsLeX06DGehctLbLdkZ4Hm3xjszA4PE2UKscjEodc?=
 =?us-ascii?Q?S3OpXNZD/VBOEMMD31q98b+ITCc6BrHHJnM/N8H8dvPIKyVwmYZ9vctFzwx9?=
 =?us-ascii?Q?IKiRzSnzaRegdzgEJbRsly4fOARhpkXHTtDLgjC/3z4pJhGjg49J2Oqz84c5?=
 =?us-ascii?Q?eXkHYvgozD2GZJae6vK8DofMkLg/ov5YvMxgruXVoN4OWVR6CXAHCzM9LVcF?=
 =?us-ascii?Q?rTOoeHf3ZVMJAjrvc+rzPmIWqyl8ZGxKiJ130CeLSPUcEDBs78eKDRR4IoFe?=
 =?us-ascii?Q?H5vmhps59SuPc5KbZ86GJWV3rI/VsdbqHLj4QE+gVxY79m+UgQ1E1k+JkvWm?=
 =?us-ascii?Q?TgNC+6yCQQrHb44XVKjQmwAU3nRNqirQyOiH4be4UoGPEhd3/DsjOlEtg9Xs?=
 =?us-ascii?Q?uyC27HXgIKzXUfqbjSv/eBgynNLRNuz8uJ5E1UggBhPrgDhEAyy8oDfG1ND/?=
 =?us-ascii?Q?jflh64rlq8N/kZ9DmWdCzloz2vwwMjpE8E1yV7LxCB/MvLC2SRd8rSGDkaCd?=
 =?us-ascii?Q?v5pmmBb5qpL411wjlhub26yBeqVY03mXO+FgZX4C36UvcUSrEsQTDedaK4++?=
 =?us-ascii?Q?sKPXwY0iAZKN9cFLVhKz6/hQBYrIxJmyR1g9ZTomdyjYQgFKRTCFF+r/yyDr?=
 =?us-ascii?Q?fqsOKtOIoqzcNS4XVrf43l/HnBr7ZWyvWU8fLnu6Y0aCEOiEcZ5DdFZDUHB4?=
 =?us-ascii?Q?BYm5GODFw0PWORH7AiCpYQFLX07XCL+7V9c+KSLwSzSa2/0KJlkb9ekMZYjo?=
 =?us-ascii?Q?WbDzjhM2MQq9iHv5ItUu2sKonkplIGKbyukALhj8BMMvkBh65x+lW2GXuffO?=
 =?us-ascii?Q?J6S1yR125OzE9D7RqPsg4WWD7i2t/oqjZWXMtGk4WY53T+iuJriyn3FqWY4J?=
 =?us-ascii?Q?E70bkCnsde/DDDswwwUjbekjhP3FIQtwuXCQo8TaoZXE+vqt2mj7wo0eY+Kz?=
 =?us-ascii?Q?yeYEWZtd2AklrmJ0d92AtqF8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eccd2e3-9a01-472c-d4ee-08d935542f47
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 08:03:14.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq99cD//GCySqUSkdOjkLuqSW2bZCCYOoVoQlt/BmMvoQ3EzmqIg4pw+bkrq26DHRoWTGcMBV1oPYIL/VEfyLC3WPZ0ygkebQoywj0dMe5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2675
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zn7HPVtUrLsMWxBZuRn9QoXPx4520388AA=
Content-Type: multipart/mixed; boundary="QRYicw3unR1dmEDxfdKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624348997;
 bh=owKBsIkPpHvFZGHRetT9XsDRQ2HruKyuLJC1XHCz/B8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=i8GRwRdqDSubcAhii/OXHc56KPZ9qQhIwI30I298mn0vvgpGHGWNPm4NbAa0mzCg2Ui
 RgmWRPkJxBsfQ24fq4fnjEn2Fi6MKOJMXvkjVIGoxIdBYzLIR/zMyOQxaxT7hF7fGfRa8
 vWyMBtTdwTH9l1Yrdcy+yvz2Q0jGPlfFQHw=

--QRYicw3unR1dmEDxfdKT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> This is one of the common failures:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/1364=
210937

I suspect this is a network issue on the runner node:

- upload to AWS S3 failed
- upload to the Gitlab storage failed too

I'm wondering if this is just a temporary issue (which goes away after wait=
ing for a couple of minutes) of if the
network is permanently down on our (ephermal) runner node.

I suggest adding some retry error handling logic to `/opt/submit_tests.sh`:=
 if the upload to AWS S3 fails, perform some
network health checks, in particular ping/curl  some other site like google=
.com, and try the upload again for a few minutes.

I have also upgraded our runners to v14 (although I don't think that will h=
elp in this case).

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

--QRYicw3unR1dmEDxfdKT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6569): https://lists.cip-project.org/g/cip-dev/message=
/6569
Mute This Topic: https://lists.cip-project.org/mt/83697468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QRYicw3unR1dmEDxfdKT--
