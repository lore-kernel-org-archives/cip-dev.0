Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C5ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 06:48:19 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web08.22122.1661928493963074347
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Aug 2022 23:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rSo9KPXE;
 spf=pass (domain: siemens.com, ip: 40.107.8.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr6J7P4aSyI6fZR2S0iSuDVZ2YclxPMHTJpHmHFloKUn2U+ekQGujOJtgA8FM0HZwsstFV9DSWO1yyNdIZtjyj/RGCEOoG0f28KYpWdqjmGusidLdB8pxsBy2e4nSknkUkDcOvBRGhwdO8Lho16orQHZT19qJJZ8JsXpwYDvL//C/+d4ASzUWULej3ev0hakMzjqkGp844MygHI83zYlSENHbHz6HXCYaoPhD4Jrh4Jq2P7P5S/TKxqU46P/K2jk8LFapF1JC7BwI2p9x2b6BrSgRHK4qUHk2I4/3LFLXuZ0O/ls0umSUy6t6kraY+0hzRltz8bC8zDkcT60B5dMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V7kK/WPrBi1SOT1FLjlTwTTTHjvZ694ewvMweNT4Uo=;
 b=IBj8D9hHRWndg8GO3UgV8gsO2yHdwCKdoKpdSARyLzzGtknu1dj7GGqXhmMZuzUkaCZZqH1xoPwzM2WdGKZ937XrMId7keWL7JuYjdlDi22eUysf43++a1NQemAILCepMCsltHHeAJ49R5YIuVVTe1JgLjDdbd/3QSo4/bf/iqWt2FNgMV1UUorigmKOjjFwDTjGLBrOA5xhAXnDEMT/NFNlr+APOe5R+6NyhBSy0vHT6TsRHIHnxaY3sHEkFjyyqXQq2bQeIdRadF+HBe32ZJ4eGaPnI+8B3xQrMKj/9/qZ+zn2YNOdhi3Fi4gdeeMlMpDzRpVEGjfp5u3RWwiJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V7kK/WPrBi1SOT1FLjlTwTTTHjvZ694ewvMweNT4Uo=;
 b=rSo9KPXENLzEnmxmC4HvYmHiLoKngthk55m8ZcCmH9jldf++kqEErvxBHgKXPdOxtQgUex55QjP4ZZmVpaRGZQEHcX+WUXtAqNup83BLB5k9A+S4Ohai0lp15wKFYCz0zdjhcd4MB1yYhMDdnG6hDLnQmOwDOC9Y0b3TaJO800Y9K31RGqTX0WqjS3aOGQa3/bzvHo+15n6OYuM6GPdU6kTCLEpk2u5fpYitlbitUsSrnegNbKc/R0QCh/EPPecM3LXgiHPMNpVshIEg/ByNbThY6GyHgDjr+Zc5dWvoW4H2hd1QX5N8af0sA/63geDMqNBmTcZtk3XG2LHabXFwyA==
Received: from FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::10)
 by AM0PR10MB3233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:183::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 06:48:10 +0000
Received: from VE1EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4b:cafe::19) by FR3P281CA0060.outlook.office365.com
 (2603:10a6:d10:4b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 06:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT085.mail.protection.outlook.com (10.152.3.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 06:48:09 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 08:48:09 +0200
Received: from [167.87.47.113] (167.87.47.113) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 31 Aug 2022 08:48:09 +0200
Message-ID: <1247a64e-1b9a-5b41-85dc-763a7f7b5a1a@siemens.com>
Date: Wed, 31 Aug 2022 08:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core] cip-core-image-security.bb: Add duplicity package
 to enable IEC requirement
Content-Language: en-US
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220830140156.2326-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220830140156.2326-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.47.113]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.630600-8.000000
X-TMASE-MatchedRID: 8xNMUprDHacwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0ZqZ6OipRp3et0p
	E2POjYg4iiKPXbEds+5SYRFlTv78q9QlpNVwr3xV+Dq5+AB/HWJ0yq4N5y479QPZZctd3P4BOKb
	ROSp1S14zOyZgbb8IxRkaAZoftHkt6wwitiFUxIy4Qx60kjbJ3fjK5yFtXIhhSszr2nuUNKwnw4
	PQgteoUAQsw9A3PIlLYG32ZLukpVN3S2JOTGhHv7ao0Zou4ee+TX7PJ/OU3vKDGx/OQ1GV8t8dW
	DYdvqmp1GcRAJRT6POOhzOa6g8Krbnm3SdMwnIwiTUJXW+gixBkkWuen1WnmaKRy7SgWnHVxBGz
	aHNitmk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.630600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2D20EE578912935DC8DE538713242FCB5021965FCE54611C82EF58F53C448FA22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3747e4-5af4-47eb-ff1d-08da8b1cc491
X-MS-TrafficTypeDiagnostic: AM0PR10MB3233:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kV04Ggi5c7ndgrY4GmrpIMHLAZAloODPDy1seilj4ivCZ4XVuxXbzQWciwjJtgO/mHDqq3vPcuGoroEGj3CVT6LAzYyazuyNHXOycAHs8JGbLCdVB3KeR3w6rDkxYKR1yoQPGlmW3d+y7kGvJ8AuiAD68efRBvKEN3202Oe16OP4apyZ8sKuXkLkOz3rSoToehTpBKhhUJRE+wRZBGrAlowXo5HKMo0AWm15OBL6Ivkng2x0wH6oxUEFzlIoN3USzTks3evWvRYr2tAwzWlpDeq2rxNPQWShdIVDVjV4pKRuC04uj9vYH+Hqm2LVxJkme0UGVGAgarqmpKPJDpqz+DqPWQ7WtrLXO/i/6vsWBcJMpSbIkCAB7/BZh2ye3ZlzATlI+1LivcfZ+S7AtmD1SpQg0mgGtClF/sfzmbTJ8SlikqKYVsQZir0uFvGHYbGxOI4+rOxU+X0456GRyrs2oPPOSkJMdPrzUfAY7il+LdZTc+8l7FMgpLxKRKJh3I5QXThKmQY6UMIqkizlJNItWPmJoUcJQyv9IFvKuFGKNW+1cEy9XTZb8zyrYlNZQBz2L3bW9wqUBZttgs91fYVH5v5TR5I+6/ciLID3YLlu/OjvJf/RQ2ETSV2EKrwCE3eTE/qwXxYrupwJdNezlaGP426GTzGzS7FCSf9F9M+onlZAutuzKA4zDZgu8PiMbDGZXbR9J+S+spOqAzDfLyvmDGknusAzpQKQXUnrs/wRbE4jFt6mpGAs2K0PhE2BfKy6WKcgUFrgQP6FL7fwX2sbkxezp9/RHslGzK0FhGy6mxZNWC/IfDU3rQz6JKjZvb0JLW7FIdRpkA+E3zRHgaMLNg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(36860700001)(7636003)(7596003)(82960400001)(40460700003)(31696002)(86362001)(82740400003)(356005)(316002)(54906003)(6706004)(16576012)(110136005)(15650500001)(2906002)(8936002)(5660300002)(44832011)(70586007)(4326008)(70206006)(8676002)(186003)(82310400005)(83380400001)(956004)(2616005)(47076005)(16526019)(336012)(478600001)(40480700001)(53546011)(26005)(41300700001)(31686004)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 06:48:09.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fa3747e4-5af4-47eb-ff1d-08da8b1cc491
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3233
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 06:48:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9327

On 30.08.22 16:01, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> Duplicity package provides below features in order to implement IEC
> requirement "Control System Backup"
> 1. Backup and restore
> 2. Encryption of backup
> 3. Checks integrity before restore
> 
> Python3-paramiko package is required to enable remote backups.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 24b1f46..9e9e43a 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -34,6 +34,7 @@ IMAGE_PREINSTALL += " \
>  	sudo \
>  	aide-common \
>  	libpam-google-authenticator \
> +	duplicity python3-paramiko \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

What was the status of the related discussion again? Didn't we decide
against such a tool? I mean, most embedded devices in the field are
stateless or only contain state that is not critical to back up. In that
case, this tool is completely useless.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

