Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C80C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 12:00:31 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.43])
 by mx.groups.io with SMTP id smtpd.web09.6647.1657800028513394029
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 05:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=dQtyhzaJ;
 spf=pass (domain: siemens.com, ip: 40.107.13.43,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRXngpidGkXcW6TxsTd6gnKpQGK8cDi7x0WqSX17yx1T7aDu9YV2btgTWqypdBLrSFLstAvNZU1MjfAfhl6UA9afcb+qeL9KD1jEo3IJBWfxOA99YZaNzVG1AlSlmAy0Y/aEM+HH3bFYjmSrCbVmqCUobdh2ZAmOLQ9bLQhs9g3pew1wUsE3C/PMI4oyYCG5QAK/pVUF/Bl5BC/SuaqlGASYRQukhSk5E+loU/13VH9mjMqR7e3eQBIlftGSwlTPoJ2H6bgM/aitnAAwn5FQ1ozuOUvbQ5Js9I1yTR8CAwFWQh2R5QONan7fcdtUjtUgH8EPcs3TNOGY+kpMqRB0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPlf2N6/Ywn5RcmkJBKUvEJgO12SAIY3zychmYbTf2s=;
 b=Lm8nNmXQ6HcnVCQEhdLrgvoN7UgzOjmzE+NI6xVhj6wjaxe+HczM0k6x9+5ACxcDlj5WvTDY5CgeH0zCkQawAydbFq31FtkmImM39YwKesZuowmjimlHK3zS8s6Yzn+BJySnJ6f3C0JFJU+ylTg4c/rr5DGP0peh7luxnDhPLW3UscpypcyIc4gtMrCQExw3bGMNcKAQAhJFBLuOqTKcnybSh5XRc/kYrSgEcwKWiwVdTNE8JKuhUOu70vwkXf3JNjNe0Kzt++dEM/rTXv5N6GMXzMJdKMRt91LxXufshyozZDAvRbmoKrzRsx05DHHAzkCDEj+koIZbmIVLw+GtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPlf2N6/Ywn5RcmkJBKUvEJgO12SAIY3zychmYbTf2s=;
 b=dQtyhzaJTCYKeeZYqnsRLDIFhNb8wFZakyhMiOrWjS9C7pBSL9TpGp3sXL56bGtDRVRCKkc2mbUVoKBsq/rudfztpSKsFgXJKFuSu3nDu+SFGQ5yt692j2jvEHgtwNjOGwm/DSkygcUe5gJ+XyfkRNdjW9YfkjkRdiD+GfP2t6kaTlygCkuCHiuO+G9DeJ+unL8qHTCAzh9wEJ41+8ZwCzjkhE9WjfKkPVyu1TM0r4dKWxYj2Rx0RtfnSiZb0mkci4sswaFdKp5b4ffrKJxhTSTelKfMjFz3HcC9zs2ZrJ5ld5akXdLOoKPxYbfTCvakZlBnfguwVV81qcurzJHvbg==
Received: from AM6P193CA0040.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::17)
 by AM9PR10MB4354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:266::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 14 Jul
 2022 12:00:25 +0000
Received: from VE1EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::23) by AM6P193CA0040.outlook.office365.com
 (2603:10a6:209:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Thu, 14 Jul 2022 12:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT085.mail.protection.outlook.com (10.152.3.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 12:00:24 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 14 Jul 2022 14:00:24 +0200
Received: from [139.23.76.214] (139.23.76.214) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 14 Jul 2022 14:00:23 +0200
Message-ID: <37dfc275-9ce2-3793-da13-b35c6d89583b@siemens.com>
Date: Thu, 14 Jul 2022 14:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core v3]
 recipes-core/images/cip-core-image-security.bb:Add
 libpam-google-authenticator Package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220711102903.4088463-1-Shreyas.Karmahe@toshiba-tsip.com>
 <cd7d2ff6-d79f-01b1-e970-1b289587468e@siemens.com>
 <OSZPR01MB8877233D21690844A101A660DC869@OSZPR01MB8877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB8877233D21690844A101A660DC869@OSZPR01MB8877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.23.76.214]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.476900-8.000000
X-TMASE-MatchedRID: MWBePzxHDOzdDS6etHbe2x8Qq+M7nEvg/k5m7D0YTS/x5KZMlKYS/bAG
	3NFI6r+gw6juv/EevUC/xEsc++5TTvGwUUhZtzr+y0V2ETiGoWPq2K4lBTHyk167ppG3mtjJ0Nn
	UUVMlTKaAI7Mvq/sL5xfFnxnR7LTzxwNT0rsbEf29ulegjmbzeNnPeICoIKyxzNY33yIEF4a/5C
	DVP/Qsfn4XCDNABbvAPXWoMDYf5ey3LN8D1qTt895q9HOrHDfe1cQa/EJbtzY/ApMPW/xhXkyQ5
	fRSh265CKA+xsnnO6OygaZY7yrHzne0/oZSDBt7EXkELOd0dmpoQCiiF6Qe+m5eAiqrqZDK9FT7
	09M8dJin7m/OxjmYo/D+6IQMRxU5585VzGMOFzABi3kqJOK62QtuKBGekqUpIG4YlbCDECsWefv
	Mt+drgg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.476900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 ED9AA072F7BDE598F53EE5A732D89579F99AD1CFB68B8B8499956CC37A6D1E0B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94afb37-f0cb-450c-8efa-08da65906f7c
X-MS-TrafficTypeDiagnostic: AM9PR10MB4354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lcqLoNclLBi92dNrNgTeQsVimzcOH1ITiDUIBSt8PqWYxnXgsZ+HWr+LwUXb8UqMuwnP/CJ26p7YbIZzXo4pHkivynk7b4896Nn2BeVVTfvg15NZSTmOwG9GyAe0uOQQVEWTVx08O50VShdopwPyHEbXuWHFM5DFI9roplbSeR5Goi3H/vozWuqVHu4zz3+NCbq4hy+iHvqCBhOOTs+THiXAiI1QIyIbB/tLDhMqk0A/qTdx5czbcbtNQPQyhDfaHg2KELKBfciHDBDT+6tRaGVB9BAyFDm+GX1QQl0/eELJAfzWkTNlVyQ6EQgZMtoDoMnjOFqdhW6A685FEQ1FXH7Fzk6oxrjhwQs/uBHLgW3/jegyT0luH3p74A0OFy0erHZk+GV0kKEaJRO01TeQjlZeSLRLgU9wHIzty6U/Dl0n7Ucn7aOGAunC0eZrr4aqPXO84vweDPHzv77zW6ecWq/GGRcBocqpuCJCBns+r//I2xQw0HJ4r65WfgKYTBNYNCeVMkX61uEd//ERQLJgcVmk7eTlpBQGyx+gAyvafiAXgEcFWZ6QMWFwot2tEqdhgBM11EBb0QPEEXLk9OixZt+kuXnfjT83DoSMEZU2aCQaSprMOm9U8cT8EmoVVffNKs2eZq/fRm7nWTujiROw/0nCSUQobLiFtKDsdXFxRk8Y3F4CpW+JD11YesD3pJgyZdwCdXCH0MUM+LyGcrOgEVUGRqc8gHfydFq1vgOclhM6dum7g6DeMwwinxHZ8MWgNMa384wTSS/x3J4wARyXVPiJTAn4Mo9kkHrcKfAYHS/glbTOA1eaFOPKDTyqn/Ofu1OocuUYHLh7xzJu5K0aNJXcZaxWSDmh9JZgU7otX04+HJ+VDyMmijy1Smd98swxDFAYZlNsRM6zkjGshljrhlfww/kwb4/kAzHA/KHr670=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(40470700004)(70586007)(16526019)(82960400001)(2616005)(47076005)(6706004)(186003)(956004)(26005)(356005)(81166007)(53546011)(70206006)(336012)(40460700003)(40480700001)(86362001)(82740400003)(31696002)(8676002)(44832011)(36860700001)(478600001)(31686004)(82310400005)(8936002)(15650500001)(110136005)(41300700001)(316002)(83380400001)(36756003)(2906002)(4326008)(54906003)(16576012)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 12:00:24.6007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f94afb37-f0cb-450c-8efa-08da65906f7c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4354
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 12:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8760

On 12.07.22 10:19, Shreyas.Karmahe@toshiba-tsip.com wrote:
> Hi Jan-San,
>=20
> Is there any new patch required to add libpam-google-authenticator Packag=
e in cip-core-image-security.bb file with v3 version=20
> Or is there anything else need to be addressed along with package ?

As I wrote below: This patch is technically no longer needed because
security-customizations pulls it in now as dependency. If you still like
to have the package explicitly (and now rudundantly) listed in
cip-core-image-security.bb, please provide the reasoning with the patch.

Jan

> Kindly clarify my queries
>=20
> Kind Regards,
> Shreyas
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, July 11, 2022 4:29 PM
> To: karmahe shreyas(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Shreyas.Karmahe@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=
=EF=BC=B0 TMIEC ODG Porting) <Venkata.Pyla@toshiba-tsip.com>; hayashi kazuh=
iro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=
=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core v3] recipes-core/images/cip-core-image-securi=
ty.bb:Add libpam-google-authenticator Package
>=20
> On 11.07.22 12:29, Shreyas.Karmahe@toshiba-tsip.com wrote:
>> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>>
>> Add libpam-google-authenticator to enable Multi-factor authentication.
>>
>> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>> ---
>>  recipes-core/images/cip-core-image-security.bb | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/recipes-core/images/cip-core-image-security.bb=20
>> b/recipes-core/images/cip-core-image-security.bb
>> index 6060978..24b1f46 100644
>> --- a/recipes-core/images/cip-core-image-security.bb
>> +++ b/recipes-core/images/cip-core-image-security.bb
>> @@ -33,6 +33,7 @@ IMAGE_PREINSTALL +=3D " \
>>  	uuid-runtime \
>>  	sudo \
>>  	aide-common \
>> +	libpam-google-authenticator \
>>  "
>> =20
>>  OVERRIDES_append =3D ":${BASE_DISTRO_CODENAME}"
>=20
> With v3 of "recipes-core/security-customizations/files/postinst:Add
> configuration for MFA" (non-optimal naming BTW, will adjust), this patch =
is now obsolete.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

--=20
Siemens AG, Technology
Competence Center Embedded Linux

