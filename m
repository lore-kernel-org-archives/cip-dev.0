Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299BBC433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 16:34:02 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web12.1127.1652200437033067190
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 May 2022 09:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=bDAALz4S;
 spf=pass (domain: siemens.com, ip: 40.107.7.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO7kHBtlv9JjzccfaOT5a79uPjbnGIEzi7sQJHszYBcE0IQslgH0SaGWo8D/YbyU8mkmnRkhuHaHaqQcpP4lRgKngmqZYnO7FgwCUk0Jzyp16NusVGelhEnYp0g4J1uiKr6blc1a26TeEh05ykinQIxaO7FslUXZG3MnHmiBJ6T2usQpD75DTuxMYotgNN4MOZ2xpf5S/hNzMFdBeILLauvNtTreh6Qy9MMBIIiuUpTY1cXwD6BhdjHo/N6GXddk+nu11yyrDaDGQOlPGsrofa+mGtvBLwLf4XOrNerqt28MwjwZelEKm36U/qWiC4MLl6QZWOGNvxZReo40D8Qpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Vrr3iyQ0jMoOsaWhjTqMl/Qy3fKSZFAJpGBViPiYk=;
 b=Or3Qd5x683oRJhNADx2nSO9pwBv2xnni61531QDZpbobBlPHsmUQ2nzH+Tu+SyF/Cxy2bk8a3wk2Pbj0LB3EJb/G8gUe0LFSNDz1KwE7OYNRcLJ60pCJ3AlsvW3x9iFxb8L0X/s+dIAhR8TgFUAHdaTpu2awbqcKVd78N+Y1g+uGd4f3Oj+/zwLfbgM3DiowtvOkNf5hNL+Ez7TVwU/11T4JvZzIm6B1BYEqssr9xAdz+ycDKobMuEsk9M0JAyt/mfPhxFNzvCaGrZHR/VA90oThF9Niu7/XT06mqTTIiZGVbUzvaFNjl/nYghZaZez+wO1hc8azmdOZumUf0B9voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Vrr3iyQ0jMoOsaWhjTqMl/Qy3fKSZFAJpGBViPiYk=;
 b=bDAALz4SOsPaZTHLdhMCy2xHigXfhhoQp45+n9NjSceJ+KszsKaJ1qhk2NLoXWjBVvxiBYQTwGpiEFsMGwhGl7tPrrhToKeQ605Si47lDb5Mna+0wskDIsI8mFtmwVvVexF15M7P/DJS78kudujb8JUmi9fZG/+P0B5Z7KzH8tUuVK7gObg8m1Vxo2jZUbH9PoC6lBzfRSaeXkc5ZtvIUpOCvqu3mnbpGzqY4sO/wIK6xzmAMdIz9QPah33NiIWr7VapLROEVhe2hKuJehVsOl/AlT1YWYMzY2s+zWjmpMEKoJMBlXBLtFjodkKSYVTEjiipb1xvd5dDTsgRNt4pbA==
Received: from DB6P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::20) by
 AM0PR10MB2305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Tue, 10 May 2022 16:33:53 +0000
Received: from DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::d1) by DB6P191CA0010.outlook.office365.com
 (2603:10a6:6:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 16:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT077.mail.protection.outlook.com (10.152.5.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 16:33:51 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 18:33:51 +0200
Received: from [167.87.72.34] (167.87.72.34) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 18:33:51 +0200
Message-ID: <badfeb71-c515-8f41-9c08-72fe81d3b384@siemens.com>
Date: Tue, 10 May 2022 18:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [cip-dev] [isar-cip-core] cip arm64 build breaks
Content-Language: en-US
To: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: 
 <OSYPR01MB554240252AF3065DB21B6004A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <96356bc9-65d4-ac2c-a0aa-a7f72366afd7@siemens.com>
 <OSYPR01MB5542DD818EC9B8E970DE0687A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSYPR01MB5542DD818EC9B8E970DE0687A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.72.34]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.813800-8.000000
X-TMASE-MatchedRID: MWBePzxHDOwwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0bM1jffIgQXhv6u
	GOfv9tMUdcfU63y8xPCNRCPAFosOlG9r60R9O586N+sAww1+NHZ60j/UbRmWKMjz0VPUnBA1nyq
	/bcbNBBic37txjw3R4WlF7OhYLlctrLjzA3qCzlLR+vxSrqwbPzjQVBO9v4cGRRDrDHhyfDd1FP
	B6HGf/lWtEzrC9eANpuODOuk4c9q84/UXqd0BCJ/7yM2XsCXf8QlyD2wqbJRAkNyKZAiu8eCH8k
	DR0dp2mVI7KaIl9Nhd+QgwIik/fSHxLsI6V2Vl01+qnTnWs4FKOXVbodssL4V5hVZTm4dD8QX5C
	VimNCmkK1YKSPbUVZKPFjJEFr+olA6QGdvwfwZZWRVlrjsKO8N0H8LFZNFG7/nnwJ52QYi/M/gW
	u/p797l5e+/3GHo3EGMlo98nDKIEDbS6qOOKkIcPTDDv2HvOEftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.813800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3F24F3DE10863AE2745511A11088B4FCE03C6C78AFA459F9373930EA0AAA0E942000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8001c76-e476-4b7c-ae9f-08da32a2de2e
X-MS-TrafficTypeDiagnostic: AM0PR10MB2305:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB230534412BC5CE7B0CB294E095C99@AM0PR10MB2305.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OtHbPoMLxMU8Y7gRgbaNeRPaZtOqJo7n0rTPeVhr42eYQU7Cp3yKAKi3ULA/zhgzCn3v+sLkWMJ692RIXxjeIyntYETsk+aW2KCnCIb0JYD8rXhJDyiY5CgyT9pSKfbF/7zV2VMHNGmVs1UX8kyvt8Ij9aC5sWrpWpuOjkQox7lFd9oQRuvPgUad8wGA55+9cgdEu/M9lV2IEhqSchRHdHbxyjSutNKaciHed/xW3M/PhLtG5WbG3JPWAQiiOGtSbwniclAAKM8HDT+w0sMKJLM+f8RIC5tHKQaRSzn7QMRtGGeCecoGNZj0PSdHt3whEg2kwBIDXOKJahB0fhkDY9IZJpcn8ubIP0liWKrsA7LGnK9RY9Q+UMWbhWTzTrmox4gtfAclLNWb0qOTb/bSDLNmbYLqyYbI6+iFh63brcrlL0qOI39I7P71MdU4LLFuEWuP+XW1qwr3jo5TPOYYjAI3uqhFCfmkmdlO3rykbb8xylB2yie05Q8W9HEwyCjE0C8yXdE2nrxIZNi5ZbyiPTgq4wF75gjhECNNvM8vokDaJxwDaGxEgKogN4afl+mm5E1dS80vJr1eXnXfmQBnbK7w8gaKSTOTEn4fQY2sFvPZ+yU7+l8N7wa5/Nm6rX+3faoBfWBRK0kK7wCv3KvBHNJQA/rOsnNEc7ZQQdRXVmM4ZWR7mVc4ZqUNMgkOa+ffV1d7K+fiTt3VwRVBvU1tUFzBcWvwChHjuDOgOx1lvSudwQMFToekoU6qUFHNMgsE
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(70586007)(44832011)(16576012)(316002)(47076005)(70206006)(186003)(40460700003)(7636003)(7596003)(36860700001)(82960400001)(16526019)(2906002)(8676002)(31696002)(4326008)(54906003)(6706004)(336012)(356005)(26005)(82310400005)(2616005)(956004)(8936002)(31686004)(83380400001)(5660300002)(53546011)(36756003)(110136005)(86362001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 16:33:51.9257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e8001c76-e476-4b7c-ae9f-08da32a2de2e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 May 2022 16:34:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8288

On 10.05.22 16:57, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 10 May 2022 17:51
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Venkata.Pyla@tos=
hiba-tsip.com>; cip-
>> dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <dinesh.kumar@tos=
hiba-tsip.com>; hayashi
>> kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=
=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core] cip arm64 build breaks
>>
>> On 10.05.22 14:06, Venkata.Pyla@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>> Thanks for the work to support secureboot in arm64.
>>>
>>> I am building the arm64 image to check secureboot support in arm64, got=
 the
>> below error and do you have any idea about this error.
>>>
>>> ---------------------------------------
>>> $ ./kas-container build
>>> kas-cip.yml:kas/board/qemu-arm64.yml:kas/opt/5.10.yml:kas/opt/bullseye
>>> .yml
>>> :
>>> .
>>> I: Extracting liblzma5...
>>> I: Extracting zlib1g...
>>> W: Failure trying to run: chroot
>>> "/build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/
>>> rootfs" /sbin/ldconfig
>>> W: See
>>> /build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/r
>>> ootfs/debootstrap/debootstrap.log for details
>>> WARNING: exit code 1 from a shell command.
>>> ERROR: Logfile of failure stored in:
>>> /build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/t
>>> emp/log.do_bootstrap.307
>>> :
>>> .
>>> ---------------------------------------
>>> When I see the bootstrap log at the end it shows "Segmentation fault (c=
ore
>> dumped)"
>>>
>>> Thanks,
>>> Venkata.
>>>
>>>
>>
>> Is your kas-container recent?
> It is recent.
>=20
>>
>> Do you happen to have qemu-user-static installed also on the host? If so=
, please
>> try to remove it then?
> This was the culprit, I removed it from my host machine and the build is =
working.
>=20

Recurring topic, unfortunately. Still waiting for binfmt namespaces to
resolve this.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

