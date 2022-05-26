Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75177C433F5
	for <webhook@archiver.kernel.org>; Thu, 26 May 2022 07:13:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web12.16871.1653549220361917258
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 May 2022 00:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=OKwVl9Gl;
 spf=pass (domain: siemens.com, ip: 40.107.22.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evsilvCDtkixa5Cha79/5ZQsyS3Lv34Lru9fTOD3ShWdXgY12w/oiOSQcTqZ7uclR9aVezv4aIObQ3d9JXSonSjZY1rSBUIunDIxQ1cu+AQ+wecAWFbXOSNDVI1O/Iz6pX2LAa83rGNWncQ5OYl8ZvBR21b4nwGd/5S1FKHTsIcJPyKCDHRJF9A4wu7Ar5dw7BMDO4SA1g0CiRNQry/wtn7sG+eko5GlpZ368kgXJKm5N9OfFVxBTHFHKl/36xsuRy7E0S/Ymc+zwMNVgORdWrNbggqRi8zM/yvNWjC/2VLZW6KPwt4bl8i4UDiJEOoAdysyi9CGtEt/5ITC/x8YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiXx1YIHtWlxxsWOKCQYyIeXVeblDImThWlin7jY8g8=;
 b=HHu+UuAP1rpeXVGW2iGKqNOdNkZKgnBO7jr++KxOldNL0FgPMDm0UcRiHXh7FhgLCI6M+CCp84ZAjrXTvgDB2ugpuEXWA4rPUeGmZ0U+JHrs0ugDj4HG4fuf1EqsGJ4T3SOKf3qpBF+WOugAAAfANmuxSagjS8LwjkpUyVux7AyVoFDXOG8tcZR03WfaK6XFo6m2SummIsz6i9rI1qcs7kEM/TXkVgZNcuzTNLnaFw6puMmo3lDGILK2+DY9bzb/qO7j1PrXAkIY/LxhvHIiYBuzCSaKbkLJjRg9FV0EejSq0XQo0dnV5vDUM7Q6CcwIp3DJc+XOtUeRXtMQJB7ppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=essensium.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiXx1YIHtWlxxsWOKCQYyIeXVeblDImThWlin7jY8g8=;
 b=OKwVl9GlmN50yLrKtrmj3b+8OsFjxDsgX1CeYXu3+AbTHN9yEK0tQKYRaGidm239PPKSAL9UxR9cR7iLwn/WiweHHzSS55xYEj0/unkXX/3hrKlafkBjjvEn/hOTvRNd1ywFh6rx2CPoWX6+YRFEZgedytq2HarDQe/5beAbePk7lYPiu1AqZSxz8R4XwYOygOLAUwhs/ciCVHrcZjgDlEmUoJx3L2RMvJp1NYlF3TaMlYvSerN3UbImABEBJk8SsFGTa4X41YyfxhCp7xsg5Kj1zyH5v7KzqIg5ca/ZyzmOkaHhqvVs+m2hL2vKAXI1OSWqyciUGRCVO0YSDel63A==
Received: from DB6PR07CA0088.eurprd07.prod.outlook.com (2603:10a6:6:2b::26) by
 AM0PR10MB1970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:41::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Thu, 26 May 2022 07:13:37 +0000
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::16) by DB6PR07CA0088.outlook.office365.com
 (2603:10a6:6:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.6 via Frontend
 Transport; Thu, 26 May 2022 07:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT031.mail.protection.outlook.com (10.152.4.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 07:13:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 26 May 2022 09:13:36 +0200
Received: from [139.22.142.41] (139.22.142.41) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 26 May 2022 09:13:35 +0200
Message-ID: <6b67164c-22d6-9d68-f5bb-3d8e66bbff2a@siemens.com>
Date: Thu, 26 May 2022 09:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [isar-cip-core][PATCH] Update README.swupdate.md for bullseye &
 5.10
Content-Language: en-US
To: Hannah Kiekens <hannah.kiekens@essensium.com>
CC: <cip-dev@lists.cip-project.org>
References: <20220525092017.445653-1-hannah.kiekens@essensium.com>
 <bb00ccb7-8098-942e-e7d5-d7edbd35ca4f@siemens.com>
 <CAP07BnkUBJ85TbiWy_QLfD2pQUgp-ExoExgHT3vQw+bPw+6Uvw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CAP07BnkUBJ85TbiWy_QLfD2pQUgp-ExoExgHT3vQw+bPw+6Uvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.142.41]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.190400-8.000000
X-TMASE-MatchedRID: U4jXvEiKZBXdDS6etHbe2zsq+vTl5WEz5i83OgDg/A3x5KZMlKYS/QRs
	BMbTTgAPpOwZN4tKaauzUq0RHquLprk+TRtvZ0rpsbkn7RfbWLbTyr0pKxS1V1mAgNbfIZXLiFh
	r30/WaYwZSz1vvG+0mgl+HyAcPie7Be8VV754OWfeSx/+SkrflFLj6g9IGWlsiVJZi91I9JgA+J
	Hhu0IR5rwxqSK0GSPRNNQfTKhqNLWL73aFvRPMW4mlzyMidQUrhpt7HQV8JDnM0ihsfYPMYUy2Q
	elP2Gj6WGzy6KaAc0LmonZJqUP6wIhNfnfp+MasVcDsTduokkNHoAcTtWUyasYv//yaWh0DrXku
	ON8pnlHTVzstKV4FISlA/rS07QvhTyRBZrC33sFria9+VRT8L4yQ2d7Gd2Q7hL9NX2TqmkBMkOX
	0UoduuTE1bv/J9SbfhzgLHqCMyqgr59u/gzv5MLUzq8RBkJuGcNYIRle9ggd2jSf4k8Vwmn0tCK
	dnhB581B0Hk1Q1KyLUZxEAlFPo846HM5rqDwqtQMeY0ErPlL8lp2M/AC6vH8/YNozH6bYPM+u3R
	3NL0ZpBDSSW9TZgfQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.190400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E232C55C79F48DDF7DAE422B5066A3A7D0040FB80AA2D766F4A2BFB8092C795B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a470c7f2-79ef-4121-e126-08da3ee740c2
X-MS-TrafficTypeDiagnostic: AM0PR10MB1970:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB1970EB8FF6A78C9FB50DDE6A95D99@AM0PR10MB1970.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2/MDdeHRu8y1jSd7552xO7sLbD38OEvMoA5VjpVWRoxx0HzVY1ub/Ty9vRcipzagiOmjMmzappoXB8Rie0ct8lPJV9jTIunay+eGgZj6SzSUSDJ+W6OE96dE0r9hIiwymsjDUsLV9V8p6Uz2YW0mL3WOKvPWmmCDT1Xh0UCfRntX0QcHBbD5XroYHEE3aDy3N8ZrMlZbfQP+WlOVZdXAtXsBhb+KSbNX6FCeajmSxQACR2hfEN4G1EF9JfS/Spj7YD9KNhvtSJZmOh/F627Qc+Xo+9m581QHYvTEUG1OfLQ/v2BdGj3w2Z+6sqJFQDfYwPgwl+TuQ9guoW/1fi6RELFhP541wIaSW7rjgnrKQeiVnSkW3r/gzVr1OrHFkSXUD5cvrycqxbovwdYf8lumJt4z+cnafiMKAiI2gx6Sy7H3wVVKaMcaqoAuxkAbnxOd28qk3wDfvF/x2cYv2nXr1zZWfmV8DVnSzLJn48y3VYHdg3NkUGbORcbpSqlABJj7whArRDFYd58ABb4JHddg6uL/3luIK3C5cgDL/v5vEWRdOsYn7IgIzrJLl9QA7wgvvXcqycZJDLMU99wtR16VwfRwxEe/Q/ohQ0jehSTlWMlUsWuP/QbKDqVTdeOjhB4jmeoyoxHSARiXyz2ZyIrWEf03z7tGh3njY0U2t10feswvgnLx1f6etx31PTUA3BR9eOzO/2Klm5qnd5uFk/GspVZ7HTK1P11DaPIOaKIs0yZq/zApy6QAi8AU290VX7hOWAOhTQJjxhHtSa+CcEOFL4pNFjkG5+iaMgWRBDsClnkG7DwH2KAbFxBwHU5dgvEgk10r/1CsoSjVvd8/d6TiqA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16576012)(6916009)(82960400001)(40460700003)(316002)(6706004)(356005)(8676002)(4326008)(2616005)(31696002)(956004)(16526019)(86362001)(70586007)(70206006)(186003)(36860700001)(966005)(82310400005)(8936002)(26005)(508600001)(7636003)(7596003)(53546011)(31686004)(44832011)(36756003)(2906002)(5660300002)(47076005)(336012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 07:13:37.0446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a470c7f2-79ef-4121-e126-08da3ee740c2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1970
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 May 2022 07:13:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8442

On 25.05.22 19:34, Hannah Kiekens wrote:
> On Wed, May 25, 2022 at 1:41 PM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     Hehe, someone actually read AND tried the manual :). Thanks for carin=
g!
>=20
>     Would be good to list some reasoning for switching to bullseye here.
>     Buster should still work, "just" not with 4.19 anymore.
>=20
>     In fact, we should think about making bullseye default in kas-cip.yml=
.
>=20
>=20
> There is no real reason why I am switching to bullseye.
> This combination worked great, what it was before did not

Right, and that is likely only because the current combination chooses
kernel 4.19 which is no longer working since 05dd963a.

> This patch is currently doing the rounds at our site for evaluating/demo
> isar-cip-core, I needed a working, easy to follow guide for regular
> techies.=C2=A0 I am not sure if the technical details matter in this case
> =C2=A0

For that particular purpose, it does not. However, we should try to
structure the document in a way that it can be easier maintained or is
less likely to out-date where possible.

>=20
>     5.10 becomes default when selecting bullseye, so you could drop that
>     option.
>=20
>     It's probably also worth noting that some of the build configuration
>     issues are "resolved" now via "kas-container menu" and its dependency
>     encoding. But it is still clearer to describe the actual configuratio=
n
>     the way it's done here.
>=20
>=20
> Sorry, it's not entirely clear if you want me to modify this patch or not=
.

Was kind of thinking out loudly. Let's make it more concert now:

- describe the requirements, here kernel >=3D 5.10
- suggest to use "kas-container menu", besides providing a concrete
  call of "kas-container build ..."

Meanwhile, I've created a patch to switch defaults to bullseye [1].

Thanks,
Jan

[1]
https://lore.kernel.org/cip-dev/9c68811b-c8df-6f80-d314-b379b131ab8c@siemen=
s.com/T/#u

--=20
Siemens AG, Technology
Competence Center Embedded Linux

