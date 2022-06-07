Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92752C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 07:23:29 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web11.9101.1654586606973945545
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 00:23:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=EI7OhCuX;
 spf=pass (domain: siemens.com, ip: 40.107.22.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr7AHTs2noO6YJ6oS699xMQcnmGqr7obGfdVog50qVgnZd8j5cQqTPw4CUr8AKf+QrhH5cjegkF2NUwYsZFD8EGb4K+YXj3cDpUNysRuzhD3FYcWIEq6CaMPFBtQWgMjQfsfUunemaPtQLCkEFnSg4opHRZYlk7XZls95hjKHdwGgG79qdnsg8JXXdLHxxhx1iGoh9Q0WZapXG0dWjIbr9q6Ig2H+qwjcg8JJc9Q7ZvW4uLQrGNi0hH4sr/FUPe382B08eN3D9DhFPFMXwhMyx9nk2BtdqmsA7iDu9FrYYu67H9U6pHzAln1yhrbCSLWYjvMZZm1gs3USZEHZNJA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oXuksoqGRi0cG+QzgRvId6oJ83IKcDbecQMq1V6ID4=;
 b=TTArcd3jyg22hvPlJojm6O1X3HcrYVvpglgFaj3tI1WY1xFTQH/3Ae3+/+PYfZ7NAKc/KmfVOYrfAVVqk+RSi+1YC46GCC01+hxvyUZsJscbJg0Ixy/f47mPk12kjBlXikp3Fkp1haFHmTM8EYuRkhpn7t2CnjmpkGdoEVRM6rpnNclfa12uZIiWRcI3IzKySuUdTBqYOd/8e+agcsF2BBtNOD/9RRX1CgJ6xDMU/MiRWQUYjanqyqX+GgtTJZodXrCC9rCYUwGtSIAHBocMklS4KbPdYn66+ABunyyxvFmmyrXtViIFRC9l/W2w9ZcAFdY4DnpCeLKlBMB5P7ZkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oXuksoqGRi0cG+QzgRvId6oJ83IKcDbecQMq1V6ID4=;
 b=EI7OhCuXtN9DC+XDdFPXxUgfIdvvpn9KTGC58qTtm27vFNRY3qSqnYK9S2lphwrtMo0mgZ+d1CbImjkP1fWXxlcPRUpPhUTlcX167yDqyHYNYSRYKEloWdcZX1yDYOX/0drTqQpiM+mJuna7Gy4o21T8VwUpMxuwRwSFuB0gqyjvc5GpSkxsmJhElbJMLxufBiexo2CsYZSHCJ1ztPvIOOZKYRXpRW6+OS9X45dqNil0UmsjydU2X3pv9vuO+qMpuV9FvDizAmmscIell8Icg6a32QV/WFWXNfZ/r84lLz9lzG5xoHETxTS64CXH34xupOLzfAoownojohwFEK0FLg==
Received: from DU2PR04CA0268.eurprd04.prod.outlook.com (2603:10a6:10:28e::33)
 by AM7PR10MB3191.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 07:23:24 +0000
Received: from DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::f6) by DU2PR04CA0268.outlook.office365.com
 (2603:10a6:10:28e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 07:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT087.mail.protection.outlook.com (10.152.5.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 07:23:23 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 09:23:21 +0200
Received: from [167.87.36.249] (167.87.36.249) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 09:23:21 +0200
Message-ID: <4415f109-05a1-d527-668d-c238566dbbef@siemens.com>
Date: Tue, 7 Jun 2022 09:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/4] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <adriaan.schmidt@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
 <c44a302b-67c9-caa6-1ae0-6808539fa612@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <c44a302b-67c9-caa6-1ae0-6808539fa612@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.36.249]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.759600-8.000000
X-TMASE-MatchedRID: SQgWp5F7Q9po0FBZlmedTrZv+ayzmKtKPg9yfk4YC0a5kFk6DtF9f23L
	B2YI359FB+A0yBBPPYwMyjRdBmXLaAlfxg5ncm7ilYUFo9LzIpmMPz8Goa6fXUaMPBFKXyAUYFs
	T/TpvJqYH8UzOewTxw4A+sls4Cb83sA502JwhhUHfIqy7qrBQpy+pYxwv+BZOZf3zf+xpuLi7xm
	CZDXrutalOQjQcrzOloSnPJtmDAFLJIuRHt43jisKHlSQGL2ITmv0Xhs8HK83HrhS+VKSDcfioI
	si7Sa0gJ7XU0Q1VfIcn4JkU8L63Qcd+uwyEzGRili14pejvmEdQWjkLGApnaY9Ha73XaFhEAPiR
	4btCEeaK3/ltlEQlLPgq1Y7zt/wJSYg23IT4aTHY37WE4vg/46rIGkJxj/IT9TCJfXmXS2+sU/i
	X0A2wj8uSXx71bvSL+mKonxgTP8WC8P1XlA48LsXGq7BWogkmw5rEtj8CKMNeYVWU5uHQ/EF+Ql
	YpjQppBsa4Vv7How3X7QqxdrFbPufOVcxjDhcwAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwPB6LI
	NI9TY7F1DWtBAC/xWzCpfoz9a3QUYla3uTE1kehgLRzA45JPQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.759600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 AF4CC3D4CE5BA154472D1CD9ACD8D3C8507B639C16FBEAA8599E177CC028AD762000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aadc377-8051-4ec3-d8dd-08da48569b3d
X-MS-TrafficTypeDiagnostic: AM7PR10MB3191:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB3191AC0F4AED4BB22DDB1F6A95A59@AM7PR10MB3191.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9yhDuGUocUDHOjrLXbYjO6jOcdEMsMS45JtQblUUheMyDOYG318x+mJxRodBJsxcyrtZwqZEaSuJkEy12GFH//1nT0FMLEEvAayZBhMsWl8ypSSMfSB2aMNJtn4dszmoUOrBYkA0mb7QYw0NNr03NTRfLgDPp1ln7I7LVBIycMPkdmJ5HVhFCAv/E5CgVttkgeDfHpiLHuj3FmV8hd5ix/Wt5x2fjb+krduOdB/HVrZtpufI5NEpUCRouLoLEghrvRr97g+EImfHPr0q049JXORPPWrN6A4Ntc2Z5a16eaCqmaozb4Ep4pVkmJ25xhhuJco488XMYDy9q8iONZ7OakJPzW+DQuVHSn1elj4ywyPm9twhPsempxAbkonqzIDvgDNuYShPpkMe2hqhNfIKDvy4rYfSH/LVPzd5M58oLGQ7faLyqkcq8FSM1fSDq79b2mn6q4CP15xtX9Vo4zDORCBDVeS0vm7/j6rxF2sTnJ6qlnkhnkqLcyN5yRoqUQMo+AN1vXbCaEJlk6qMMfJiKJcg2skO/Ag07XbsPz8sHhEfrQKLd8OD9xIm6JFBM7s44+0jK7H1w52+kYpHapHCsB2vGnVP1VWmvHZF26EopYqdmhRO2nK35JRkQgSXDggCUNDI6wj1C8IZHQUT8P8tr8PqviAFzH94nZfNcUWGXh1trwGsghvCAD0OfNVKXFikZ3yzZfiARbX+w16pM9xCDlXNiobusENKlaCJtgbm1qG5W13A8T+VLbreZb2PXrT6gKx7H2o8RJ8wA4Pz1YQWgNYUANSnuf+P94HhWLsTKdiOR3xmlTFy4IXyZm7k/UCmkl+Uxsb6Hu0aII1lbLDesu23PYh396kY2dAUVXvkQwP0Q95G1J6xRfZXwHXPGK5ccsTd8KvakIDbCwZN5Amcww==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(83380400001)(53546011)(70586007)(44832011)(508600001)(16526019)(86362001)(966005)(186003)(2616005)(956004)(40460700003)(8676002)(2906002)(31696002)(110136005)(6636002)(47076005)(36756003)(6706004)(336012)(31686004)(82960400001)(70206006)(8936002)(26005)(81166007)(356005)(16576012)(316002)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:23:23.4474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4aadc377-8051-4ec3-d8dd-08da48569b3d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3191
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 07:23:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8499

On 03.06.22 17:33, Gylstorff Quirin wrote:
>=20
>=20
> On 6/3/22 17:27, Jan Kiszka wrote:
>> On 03.06.22 13:56, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
>>> ISAR commit [1]. See also ISAR API changelog[2].
>>>
>>> This new feature remove the *.img from all wic images.
>>>
>>> Also as new naming convention image recipes no longer end with `-img`.
>>>
>>> The image types wic-swu-img and secure-wic-swu-img were removed.
>>> Rename `squashfs-img` to squashfs according new naming scheme.
>>>
>>> To use squashfs include:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_CLASSES +=3D "squashfs"
>>> =C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_TYPEDEP_wic +=3D "squashfs"
>>>
>>>
>>> To create a verity based image to following line need to be added
>>> to the local.conf or similar configuration:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_CLASSES +=3D "verity"
>>>
>>> The modifications for a read-only root file system are now part
>>> of a bbclass which can be include directly into the image
>>> recipe.
>>>
>>> The modifications to generate a SWUpdate update package are
>>> also no longer part of the image build process and in a seperate
>>> bbclass. This class needs to be included in the image recipe.
>>>
>>> Please check/test the interface changes for swupdate and read-only root
>>> file system.
>>>
>>> I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.
>>>
>>> Quirin
>>>
>>> [1]:
>>> https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add9=
6ecdf14
>>>
>>> [2]:
>>> https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#change=
s-to-image-types
>>>
>>>
>>> Quirin Gylstorff (4):
>>> =C2=A0=C2=A0 ISAR update
>>> =C2=A0=C2=A0 start-qemu.sh: adapt to new image names
>>> =C2=A0=C2=A0 Adapt swupdate and verity to use new IMAGE_CMD_*
>>> =C2=A0=C2=A0 scripts/deploy-cip-core: Adapt to new image names
>>
>> Thanks for this update. I'll have a look and also try to apply it to
>> meta-iot2050 as test case.
>>
>> One question: Is the series bisection-safe, or are the patches 3 and 4
>> needed to build again. Patch 2 is likely needed to run the result again
>> after patch 1, right?
>>
> I tried to make the patches bisection-safe. The build should work but
> the verity and swupdate functionality is not available after patch 1.
> patch 1 and 3 are the main changes.
>=20
> I will re-oder the patches.
>=20
> patches 2 and 4 are adaptation of scripts (qemu and ci chain).
>=20

Will, CI should fail without patch 4, e.g. Probably, it's an
all-or-nothing series from that perspective, and it only makes sense to
break it up for readability reasons.

> I found some errors in the CI build and will send an update. The errors
> are in kas/opt/wic-targz-img.yml and kas/opt/targz-img.yml.
>=20

OK. Looking at more details now, some further remarks will follow.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

