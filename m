Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8468C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 09:01:13 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.69])
 by mx.groups.io with SMTP id smtpd.web08.2282.1665133267404040488
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 02:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=zwLQKfGc;
 spf=pass (domain: siemens.com, ip: 40.107.0.69,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWzyOkN4cw/jJ+9ZU6SepZ3zdbagWhDtonI02bViCFNEjDx05VKNCYAAgmgYquy5l3Es+jixvM1kxU/NjFx+5ydONi4Wqv8uTbv1kDJNDM9czfMzquvtpAJoensytKm56MAVFUBlH2G8xx+6SoxgDX4XpE9ix5PtpwgNnCmp4dNoLLgjcT154PaTh3ITTnqQZYU7zFFCjOngLHph3dxYvNi4a9CvPXIIyU4OeliokjhoKNrTzTt58LM6hOIZexVk1M2vpaYNCWcXzm8qvR227gI00SrpJ7eQwJCKGNYqNRyH5l2/MZ8XrOUtSZP4xMDwEgftbp/Bowr/D30UrgtMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuhFGyw+NpDTJyGNfa823xv3u172eF2pzO8k/4jhMLI=;
 b=Y2DIygvRGkS+YKUOwvdagi6n13uwQTIvRdxkaA+NCylp/56+hbrwKcn21OdM84xFPb0qrHv/QmEvuxoKei1ERfI20n3NAVabM5zJGVFy5I9X/T9RUzFFgeY9lftSLGacY2W5QXisq6oQMbQUoBiGkNX/Jtb/YtH+MpXfWpYBvIZTDVnq1ZNAY90EAVfe8wfPdh+8d/jO8BJYv827p9mwjAs0wVYJ7MUYnGop/MFJQKhA391YCW8PygFumvMky6WhbSbZkOweTX3mKtGLCRVequLEAL0xW/SAyfPt9Jk71b0ynW3wUYEgpVMdTJlSPYVdiuDN2lOy74k/EgjP1WbxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuhFGyw+NpDTJyGNfa823xv3u172eF2pzO8k/4jhMLI=;
 b=zwLQKfGc/5trQDOZi0M64m5YXZUHocHUmhe7fLLy8VNYsUfQedoGOHXTucYBTXkYVEZOTtXYoKw+iRIEhlPiZvd9BI/OKq0DCt9iRTIC/qWGsILCRrhGgDguKEKE+v5ih4ZmapomdW54kxGLsbAth2WBC0WzyvD9ES73ZCuH7+Q8q+lyIdrm0josOnHN26exnovtJpLY8TV+cHxcJtoyKx2nV0b1LgWNMziV64TwrIIL9nXur1PJ6vYyOnfZyqJONtKiQM0NaJTSeC1gbE2BsT2mH9POmqTnJF5Sfj6Pxj1QFg2X3Pbg7auPFVbPZwZlg6NNQB3ON5CgrartE6AO2w==
Received: from GV3P280CA0013.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::34) by
 DB9PR10MB6666.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Fri, 7 Oct 2022 09:01:04 +0000
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::6b) by GV3P280CA0013.outlook.office365.com
 (2603:10a6:150:b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 7 Oct 2022 09:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:01:03 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 11:01:02 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 11:01:02 +0200
Message-ID: <b4971713-46f7-5d4f-0a66-84010e460c2f@siemens.com>
Date: Fri, 7 Oct 2022 11:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/1] layer.conf: fix sstate cacheability
 issue
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, Felix Moessbauer
	<felix.moessbauer@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20221001044712.441683-1-felix.moessbauer@siemens.com>
 <8faa341d-0e6a-a203-b12a-673d6a7e3211@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8faa341d-0e6a-a203-b12a-673d6a7e3211@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.305000-8.000000
X-TMASE-MatchedRID: dzgRF5KJYaMhz+KjBN9OuXE9yw6yAUlpPg9yfk4YC0YHRzaQbsazqF6j
	Qb5UCjKvsu4bp26hEtcLHGEtxwjZ/5ynXta2migMK+sdrvP2tChiWV0DQ85LUo61Z+HJnvsOsVw
	PMKjZm1aUAUfla+IhaLKXWmEvaG3ElyyR46PvItO2qNGaLuHnvr9ZdlL8eonaVnRXm1iHN1bEQd
	G7H66TyH4gKq42LRYknFVXquXw6xShZj3iDV6Bb76CAHW5qfW0IOP9v+qJmah+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.305000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 FFC92EB92C22AD778111D5F880941E0F2ED72BD3C526BC85DD6E5A6E3CE50C192000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT063:EE_|DB9PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e41d3c2-2ae3-4fc6-53ac-08daa842769d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yY4+/xVjVEBiemHGpsvWdvGw9YU3Zl1+gzJqh6O4cl+tr42bG2papSiLzU095EskZ7LDhTYobCvU7Ltyp6SofI0esL3i33h76v0Kfccb2yOn+E6litd6EiaTmF/uMdDHvyqnbCwoKWo9OvI+vMpoUBN3+3slX/7GR5QFLG4wkCulMW8bKCowcYWceYEB7pZ1i3Mqz42yMFFqwOdHiglSBjIA23wsTpCnZEm0sa597t3LNwKpC37b8tpKxYE/Mc6B+GOPFHait4WdjX/sWQENQw1zuPsGxH39HJ8a8bEcDfLnjmO7L4BhkzEU4kVt/Gk8SpL0IEV+yCDJEAfu8IjqON+23QfzO6j3673TX66gl3pQNtmFVy+o0xS8Hxc5uAqeB8I2UCAj3hhFf6HXFLUlOdZzdlzzpWrXfTxlrpZRptB0vBxwUHAEL8/q3kMzwoHdBguAmmIYkoD4IJ44MAIWbZpcJThD4PmFdSOqm4z8UDZPuEP0x54sAS1uyo9XKSBpoPoGvNkb1NQm3uEua9JgdEpMudiyW7j14sXUG9PgGDalX8hmFy0Q+1PIn8A7Vq6PIbFre5sayaxzGlI7OX9FjPnNaJcVoVotZoAhxsBd/LFbjT5nitbDUK6zf691QMP+l+hhuvJjzspO9m8DWu3Ay+sFP+PoeLcFde726FMD1PretcPxBP29jfIYJhbYSJw8PLb5+n2le/TOxKAbqoBb1UfmSaggHlqYcG0/U9zyPYxMhVlhuY9KZvG/aZjgepMp/O5dYSnWW1+BdYEVjSomA+79VcpZYwpF/yotpyKjI3t3Fn/1+YFyqOj2UUryNcJPcMRRNVfh5u3xXpirBuz7afsjwmuxtaYCkrvTcfCRXz0=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(82740400003)(186003)(336012)(82960400001)(16526019)(956004)(47076005)(2616005)(4744005)(81166007)(2906002)(36860700001)(356005)(16576012)(83380400001)(31696002)(5660300002)(82310400005)(41300700001)(8936002)(44832011)(26005)(478600001)(70586007)(53546011)(6706004)(70206006)(40480700001)(110136005)(40460700003)(31686004)(316002)(86362001)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:01:03.6739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e41d3c2-2ae3-4fc6-53ac-08daa842769d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6666
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 09:01:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9671

On 07.10.22 10:05, Gylstorff Quirin wrote:
>=20
>=20
> On 10/1/22 06:47, Felix Moessbauer wrote:
>> The LAYERDIR_cip-core contains an absolute path to the layer
>> at the current location on the fs.
>> This breaks sstate caching in case the layer is checked out at a
>> different location on the next build (which is common in CI).
>>
>> By setting the vardepvalue to a fixed string, this issue is solved.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>> =C2=A0 conf/layer.conf | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/conf/layer.conf b/conf/layer.conf
>> index cc0543a..891a0ca 100644
>> --- a/conf/layer.conf
>> +++ b/conf/layer.conf
>> @@ -21,3 +21,5 @@ BBFILE_PRIORITY_cip-core =3D "6"
>> =C2=A0 LAYERSERIES_COMPAT_cip-core =3D "next"
>> =C2=A0 =C2=A0 LAYERDIR_cip-core =3D "${LAYERDIR}"
>> +LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
>> +
>=20
> ACK
>=20
> Quirin
>=20

Thanks, applied - fixing up the whitespace error above.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


