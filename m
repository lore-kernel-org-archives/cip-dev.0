Return-Path: <SRS0=o79J=IR=lists.cip-project.org=bounce+64572+6298+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E2C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:22:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11B164F04
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11B164F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6298+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FFWAYY4521723xjDnJ37nphX; Fri, 19 Mar 2021 00:22:22 -0700
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web12.3025.1616138541007501562
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 00:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwqUVRijT4F2TC+VIGOyfbUWkiyPQMCuaa2hL+izvEKAbn6jOzKrfN1hF9cVsyh7R88BMUL7cuBYU6dkhNq5OORD/WVYSN3CsEDLLfFW6sSemyMV39EsU6Dx9q2hgaK7sGA96igm+VBXF21/inFvY2gs1QUdo5jsD8e9UFqujQrey427VvginIfw4JMbAmyrEQdl9LJunW5xUfV1JXiQnreAxwE1851xX5mn627f9b+Ii4fOjzOffzrsE5fNxtd35xuvIZiK+6I/6iDHtTzKMIZVkHP92UxLIDVuwORjkFpkLxOpD6tuG1rGz+7MZ5tpU3IlkXFrDfwJgTdFGDObmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pre7Iqp4QAP1yokEoTo6xGX4I5QaITEbLEvwiIqSH8=;
 b=TqhvEKxJ9IH9JG4g/QRUogODPrCOHdKkUzrN4pcesuBOwv6slzeyEBUGn/+27wUDxcbk3+xdcpono7eNhrWuiK/SdevaeWNeG6vZ8zW3UWBkQO2WbyNMiRx/eDlODMRwIdYafqzpDZAFgt581356TstXG5U/jeUSt4+N/JA0u2HQXOwiHWnmxE1dI+i6Jnl/Kqv9h/WFupu9INnzW4zUKxOWSzSVb28HN/tsrVMFu1B1wpb0uwljl7pCAEhxk2pe6kqGzH77XyEiuxmrW3Km06krz8yCkoUTujLqfk6KZSZeoQhHEylpCt1rJpNl2EtP8dcwoVMmrHnw2Cg9O3e2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by AM9PR10MB4183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 07:22:18 +0000
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58ad:30dc:511a:964]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58ad:30dc:511a:964%7]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 07:22:18 +0000
From: "Michael Adler" <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [cip-dev] [PATCH 0/1] [isar-cip-core] Secureboot: disable initramfs debug shell
Date: Fri, 19 Mar 2021 08:20:35 +0100
Message-ID: <20210319072036.16091-1-michael.adler@siemens.com>
X-Originating-IP: [93.104.75.247]
X-ClientProxiedBy: AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39)
 To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.75.247) by AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 07:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8caced56-563b-4286-4c37-08d8eaa7ba38
X-MS-TrafficTypeDiagnostic: AM9PR10MB4183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB418321317653F54F3155A047E8689@AM9PR10MB4183.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	eDPSaHJpdoV+kByUr+VClnN+fSHHpxcblPqTw/8xAId9t97RD+ZNT6dMHTg6vN//dMhdEyRPUfDdNFUsqCUwk5L3Bg+25aOPTw6E48yYfoCbojLyF5HASW5Mg38CcIltZo07/4OwGW7Af2H95nhzLLgeTXR2HZIRGqFIO6ceavIjbwETE7zeesuLl1jd5tbe8IP9osc5zKDWTk/jpMaJysh3TLR3+fylFrOI/3LHXc9EjrM1JAx1cobVr4FhN7CT19/h5UTFF9gIt22GAqP4J5YRiYsJcJErgJNsIdfiNYrvEJG4lhv6OkdaiWkS2Ry3qpc8bk+WEuWSdfDKHJNeXgSjFgAZIe4bUe+8rZBQViSjl9p8SYIDyBh6hGQJrjOikuOcDKvwnx4Bq0+29XwXJkKYhFuWWjK9EY1P7SutEKkRQXLOscgp2frnCZNQQtG1wQoPxGKjJncjFhBh6XY8Re7jew27RuowM24cEHc/nxhAGR4rO+yIH5e32GsqDSWRiJEXfWfouJDAevsc4zq6U1RICTSSbln8mHvZ9V8+r7ikTpSjT9ECfhtHS2K2xYgoAoknpENJepRtFsL6UO4/EHVHSMcPG10sXWaTj/rkiCbVjpcnk/JaFfse/kCcWzAalgRjg81C/ZbMMmURzwKkPJCqCvEe/Wp7Jbyi4+cz54o=
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?ocSZ9TyypSmZXucJt2yxN7rniXvknDbFAqT8OJ3b0LyfEqgEcAZJ8RD6GNVd?=
 =?us-ascii?Q?XyNEKcxyCjvwf1XUiug/nshsVpmNSCWaGcqlUraLZdyxlTnZIU+j4uiavISo?=
 =?us-ascii?Q?0jGOeSDT1ffpjj9QZWFWMd0Sca0+HLm07UmgDCP85sTswX7hghuQERCKHP9B?=
 =?us-ascii?Q?z+DW0+hQ/ELw3t4krgfvkXu/a+p+n1bxWR44f/kPhX/TWmKUVhieT0rRLN/B?=
 =?us-ascii?Q?20CZ7nj3w1g70ovbI1Aw9p+GnqAKTeJ0nOSIcenhN41eWfST1BlNdGS2+YCH?=
 =?us-ascii?Q?ujOjBJ6oq8YJhHwXiwnzGv4cXhhzpPC/zvV+E/PQxH5gh04Kz8LHeeyWbh73?=
 =?us-ascii?Q?niYmea0FPp+oy9d1ET0obRJ1TuDQNqo5N5/VNya+5YAn+I0LOWJU1kdXzNhl?=
 =?us-ascii?Q?0UTGhwcsL7XYxjOiterCReZy2WvB5ZZHGNs8gPNd8T/judFeXyHShsBdcVDi?=
 =?us-ascii?Q?XUWeQam1X7b1WMWRYExacaayOer7XOLpALfZZ/rRdwkM/zCAt6KZjJpVcoSQ?=
 =?us-ascii?Q?eWp+18siTciMSIPu2gh/pllqkJ6w4n51sUi3YqFib4oXTY55c5O1un0pqgVO?=
 =?us-ascii?Q?iQ6Ft0HFdhOB1IVzXOQx00cLW2vumXeHoDMYuVEPjq61zuKfNfnKojgoNJKH?=
 =?us-ascii?Q?DQ1x0F9dwghlozRdm1ZdfUw0P632Px5UPGNt1kQIJSnuUlTXMiOdBjz2/Lw7?=
 =?us-ascii?Q?VCbFaVZpuDvLCdBc5F9HnQhlMA0m/m/WKLoRPZQnTTmcZp0a9FwSNLZbX2eZ?=
 =?us-ascii?Q?kZ+sk01rwOYW31gXNuixXxBgOCbJrKNE5ROpwTr3AKGFr2LYay/yfPY0MlCS?=
 =?us-ascii?Q?0xn0unPg/HFLIq3ca8E8HnHhKMq6slhFJPdEK6tqfb9pbE4IbM9vxEwUc6YU?=
 =?us-ascii?Q?KPPgW2F8xd8ANCSaIlZ6eRETOB8FRNNIKqqJRDqDn2AP6xjmI3VKrrN8biV2?=
 =?us-ascii?Q?k3kJdStZ0FhAAv8xM9Pln9wr9t8y8/z2R/4icxLwS6Q0XJ4RmpRVvGTGfgWQ?=
 =?us-ascii?Q?6X0Xb1hDFQBhdc6DZX8skbU3g1NGgh//cI950EF+85V2mgzBf//P9zXTZaMP?=
 =?us-ascii?Q?sFTUU27ohzrYzW1egDBmX4cmLDYLrKmLBW+8aDwQPVhu1JCoQM+LRFJWj23b?=
 =?us-ascii?Q?3pcKVY3LU1KZ9MLZGm63Jw7JLvbumQgaQ62j2HnyuipouM9sZ74ayLXC+GtU?=
 =?us-ascii?Q?VnwI6kPwAflgkty0LuMdDS8x3ntA/QdkiDPIiKD0GX1pS4UIgE+mTu38lfEp?=
 =?us-ascii?Q?nfKPF1UvO/4ZlkcxqM1BTQCh17u6jUe4qc1X1NsP33bPoxMl2+PKMuwLiFYG?=
 =?us-ascii?Q?rtpQYvWKJKWXq/GY+RTslqSC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caced56-563b-4286-4c37-08d8eaa7ba38
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 07:22:18.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0TTtRzw61m39vyFbVsoN8Jri3O5LhmM/snDao47ksabh4dZgny/ir0F7aMvo0Jn6VBN/mZTLPBpDHEYumlXqiP68RaHSI9D4DTIOraki1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4183
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4JYhfzBqnAx1CK2awaKPdaY8x4520388AA=
Content-Type: multipart/mixed; boundary="GrLsd89PQLKDtk0rO3BA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616138542;
 bh=knE5peuBPgjtrZDQr5vqMg6CUpraUIJPQy7eXKZqwag=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=XEGPBgTdz9ldieiE2askcDyIcpooAD6nO74zRmFU0Cm7lLgdVFzjU3E9h4/fDAeUhsl
 jUH3i94RCYEjL7GaAWtMV5ZVzj8PjNPVZHFb3vjrMpNzM9ShWKprFvYrNEkBrYL4fczwr
 09+pBfCmcyxsl2NbK7zujFyDdrDSxkhrXd4=

--GrLsd89PQLKDtk0rO3BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Hi everyone,

the following patch intends to close a loophole in the secureboot boot chai=
n.

By default, Debian Buster's initramfs drops the user to an interactive debu=
g
shell in case of a severe error (e.g. rootfs cannot be mounted). This is
essentially a root shell and can be abused to tamper with the system.

This feature can be disabled by appending panic=3D0 to the kernel cmdline.

Kind regards,
Michael


Michael Adler (1):
  Secureboot: Disable initramfs debug shell

 wic/qemu-amd64-efibootguard-secureboot.wks | 2 ++
 wic/qemu-amd64-efibootguard.wks            | 2 ++
 wic/simatic-ipc227e-efibootguard.wks       | 2 ++
 wic/swupdate-partition.inc                 | 2 --
 4 files changed, 6 insertions(+), 2 deletions(-)

--=20
2.31.0


--GrLsd89PQLKDtk0rO3BA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6298): https://lists.cip-project.org/g/cip-dev/message=
/6298
Mute This Topic: https://lists.cip-project.org/mt/81450089/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GrLsd89PQLKDtk0rO3BA--
