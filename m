Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA14C4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:22:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web08.7891.1666185718629285637
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bzcTQFE0;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZTxPfW5w4DhP4efmGnMJQOdRz97xGW/BH5n6EubNz4OlMtQFEFe1J6fh4ndnCr2PKx8mxSmGa5vdGj3JNwx8OLG5k05kV00aplxiIocZD3nCt8XBxPcGHuOzplwF0YwlRRkkoYfpHLHtyX1O1Zkp2gEOaAP7xRlcgWR5KmfkZekaviiCK6za2pMTv0nvtmEWqhVI7dJjSjtD23hDLWnw6pfOTQrFkWj6MtnFQ0dmvn1pvth/gxc/7GHRo8WxjNlongs4CZ8KznGJ6K0oZah0wRkLHL9KYy5LN2Av20wg6brgtzoL7aK5nXPy4ryQVndyrWfBBtdjeJrZ2tXl1APhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7VglZjBi+HBgXsp7ORe8D5XlilNbtOCm1vqS6f7J+U=;
 b=eWJLc0Br8Sx1RhC/b2j057HfMI5CEoLI0jZyUdO7NnFhdvFsCijz/ofRQoMVOd5rMurU6fXEEHvY9uEwHQWVKL6xxGEGBN2D3B3Y0X2ci4CHpmmlluu5jKcTf7BJUpRxiyhPq3nm2rSPcsIi6/xif8u2umyZv2CynErH/wdPqu9jsmPdtj4GQ2QEd9BylLckzZvm1DTaM7L5tpM+Av148oSqhOkEPWiKHXjnpJqa+evNkeRQUxr+VcWChscnj1UC+P/AnYVqQPT7DpkWCjeNHG/1wGHI/v4OYtN9nIQmkct02niHcGb67QtKJRroPSDCYcAJQMw08wWwY73yWTitwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7VglZjBi+HBgXsp7ORe8D5XlilNbtOCm1vqS6f7J+U=;
 b=bzcTQFE0f1UD7KtJySgINsWVa6aDuKlIA9Ulkrlqu0Hd8c66zaVNVMFpLbl43d6tWoes4ks7uuQGF6smBsf/J1xj46uZE1ZY+VqObkNrSqVbF3DnvdeA2KIV3n0dIuyjma/jVXnF/X99BKTHGaYTjbh7VlB0Ed1Ne5/cBCNooTEgi7pEJIVnM+4ttCvH+6cmyo7/cl5j6l4uwUzfIwvRqItIzpRn+s6uPrA3g+Icb5u9v2MSbFMN+Wya2iYXHbppOqSnSn3ueQ462Z/yf5rWW1fQg04KUpL2nhpj+zQwCIlL+qXOTIvKFuwu9MAt0NBt4+ec94SmR/17FIkMV7VZ8Q==
Received: from FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::15)
 by AM7PR10MB3889.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 13:21:56 +0000
Received: from VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1d:cafe::ea) by FR3P281CA0012.outlook.office365.com
 (2603:10a6:d10:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17 via Frontend
 Transport; Wed, 19 Oct 2022 13:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT022.mail.protection.outlook.com (10.152.2.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 13:21:55 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 19 Oct 2022 15:21:55 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 15:21:55 +0200
Message-ID: <adbb2f61-391e-16c7-cd3e-0e12ebb65697@siemens.com>
Date: Wed, 19 Oct 2022 15:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <20221019092117.5291-2-sven.schultschik@siemens.com>
 <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
 <PAXPR10MB5037C43EAD82531EC11A63E3902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB5037C43EAD82531EC11A63E3902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.670200-8.000000
X-TMASE-MatchedRID: AQ9SOYvqpDZQ8KeJIgW2y2dZwlT0cB74Pg9yfk4YC0Y38vQ+IQtktdOo
	OI6ILwj2rcN9BdgNdeaHWMMz4DW4ujmcvaMWKiDILTFijUBb4ldPB4rXagQZ+1gUnyU84hcfOhJ
	9m53n4aC4M3bcbfcMpqxd71rflwjuU/mfmKqVlygw3q04xc4gVp5l5tqvE/eVAD5jSg1rFtBMkO
	X0UoduuZeXqX5fdzDimUDgikHuA06ycWeoQW7iojbXRLv+RX84hhplb1Cf+VL0VCHd+VQiHqDzz
	rtsjCZTpF5rzBQB1DpgpFDXBdcbGN/Yuwf1Lz1ULxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzyVeAZ
	5VSHdZ2bKItl61J/ybLn+0Vm71Lcq7rFUcuGp/G8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.670200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 922378478773446ADCE7BF15DF6C3C117FD0776D6676A7F9008C92F62E6432A02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT022:EE_|AM7PR10MB3889:EE_
X-MS-Office365-Filtering-Correlation-Id: 090b23ad-bd41-47b1-b222-08dab1d4e4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M3NQXB7ycS8F94LnUnTFawF+1Jvm43eHtyWVdR/7OESeA8wGYT4notsxKymbSkqqxHJPnTZd9/Jsgt2xiwXGX0kAgjTnmmxchKxWetBkm1mIm65dzLrgOOVTm8zwNlIG0cUut4Dce3RZAZ14/9YBsFJC1I+Vo8J3D8+k8Elb90S2z9DWI/c7x5Si2MtFZYDt/ILJGfF2MFLXZLfH+JnxmMKcFpvWytKQMVIZdyyo06tIzI6gPaVpjlOzXxh1aHI240EAZJthDaGW6nbAoMMKfQOlhcMGlFlltkqKQuzEoCppIE+k60cspJzv6m8DszaU3rO9KFE2ZnsFlFLvgjNOt+hpoYParJSJ+VOOTre9S3xjyowO9TSIApOcurnW8CYV+NcHOA8IBUCyURayv57sLg8tw5t74oblFs4HaaflM8oyYlytjMxz7k9UP2C0dLw+fsTM7fEnj9WBosgynBD6LfStWUgpDiqlheo6hwXEqrtg+BMCqK36OmrZf1tmLR75/U6tIlN7OyRDmQMSAvPe0EyRB4cSTNGjlZx9CRQkwzyc4m6JCV1gmEPxTFYaGN3nAkJuA1GzkCBb2Ktwqyw+BR/ug5DInXFyXDDNSsfCL1B0alq9AdojVVj2s5PAL8RtBUCoJuR1XCoxmchn10Splv3jocuQxljJEwz/SjeH95X646hwxEzBJB+Lz9P3VXh+hbWfZ0AGeQa9O0ZAWcj/twZLO8T5fC90xLTTWTzJn2zb5jDcCQjaAKO7xiYgssF9GB6sMnH0b3IXSA/vaSiXvJelyN8XBPtG0m/ByuIdrtKYqzZtj0db84zDQuVbHOQlPWBKJQwQ+G23FPlVrnbh3Litg5tljY9QLvi4/pXtyNZffYi2KXiLXwMG1oeJPmO3AHPwM3uMeteTgGxfeaL1rg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(186003)(956004)(16526019)(16576012)(356005)(81166007)(34020700004)(83380400001)(31696002)(5660300002)(26005)(86362001)(36860700001)(82740400003)(2616005)(44832011)(336012)(2906002)(6706004)(40480700001)(8936002)(82310400005)(8676002)(40460700003)(478600001)(316002)(41300700001)(53546011)(70586007)(6666004)(70206006)(110136005)(36756003)(31686004)(82960400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:21:55.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090b23ad-bd41-47b1-b222-08dab1d4e4f3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9788

On 19.10.22 15:14, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Gesendet: Mittwoch, 19. Oktober 2022 12:58
>> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; =
cip-
>> dev@lists.cip-project.org
>> Betreff: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
>>
>> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
>>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>> +MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
>>> +LICENSE =3D "BSD-2-Clause-Patent"
>>> +
>>> +inherit dpkg
>>> +
>>> +SRC_URI =3D
>> "gitsm://github.com/tianocore/edk2.git;branch=3Dmaster;protocol=3Dhttps;=
destsuff
>> ix=3Dgit/edk2;rev=3Dedk2-stable${PV} \
>>> +
>>> +git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
f
>>> +ix=3Dgit/edk2-platforms;rev=3D3b896d1a325686de3942723c42f286090453e37a=
 \
>>
>> - gitsm (see patch 1/7)
>=20
> EDK2 really uses submodules which need to be pulled
>=20
>> - please factor out revisions into separate variables
>>
>> Or can we also address the revisions via release tags? The recipe carrie=
s a
>> release version number in the end...
>>
>>> +            file://debian \
>>> +            "
>>> +S =3D "${WORKDIR}/git"
>>> +
>>> +BUILD_DEPENDS   +=3D ""
>>> +
>>> +TEMPLATE_FILES =3D "debian/changelog.tmpl debian/control.tmpl
>> debian/rules.tmpl"
>>> +TEMPLATE_VARS +=3D "BUILD_DEPENDS S"
>>> +
>>> +ISAR_CROSS_COMPILE =3D "0"
>>
>> Why?
>=20
> EDK2 has it's own build parameter for the target architecture, which acti=
vates cross compile
> Within EDK2 build which breaks if isar cross is activated.
> build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(she=
ll nproc)
>=20
> You suggest to turn it off and try if isar cross compile could be enough?

Cross-compile should give you some relevant toolchain bits and libs at
least. And it makes sure that you have a native toolchain for the build
environment, rather than running with emulation for that.

If you need different compiler settings, adjust the rules file.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


