Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E9EC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:14:33 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web12.7695.1666185265893641935
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=weyC28ve;
 spf=pass (domain: siemens.com, ip: 40.107.21.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWjtphNaUr/mX51b29ttIxuac8Sk1fMUqgLYG6SLrQRNCv2M1fNwgqbp6ShmXAVq5JPV9tq1m7T5HJAqIp+8JcEB2PHpDBJq9S8etlNlSGaMl6OD4pQKfzwm3pa7WoJPj3l4YGs+rw3KtPbjI5ft4gjM13bhHOj7tkN6h9WW3K6ESVtu115gSe+Sp0Bz8RsGUF0l+bLUW6RpdjyAZaNd7H/YP+mowExI8PgHuo/l8JlI4z6jOyYpT9OyjEXg8LDEWdkurdU6BCkUMvm2cmfLd6C+3IzTvUKn+DHOadta7+KZcY4pNTIlMc/uHgaPP0goMxZok+IgHi25Xzfb+YP9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik0hlc9iTHBhMGyubnGJBZFRoV+uhPlX3pawOTmyoLQ=;
 b=mH+A/W97QP5TNHithw2Dw3glnE3GiIrjwr6U2aZOplfmkS4/b8VwcAAUeoMhkbG8KHMIRZZCd6/I0H5R57zk8QuRizsFI3sidtuuKLap43wxdtXJ+Vw5n/DOdZ0P5qua44pMXTCmHWmPGiqroi3rVZzqrKNO2lmseWPOl7NOLGfOCgIKP3FW8hKyPZyz6evAyaulm7tepY5tSkwzO5m9iiMWdv2MojmPHhEt6tsSKEblQSoyv2IEqlfSNG8kVxHCE0j6w8Ar98CbobT3nWcBgIG37CPd6JKsag357wrnyJ9YbIz3WGyb54BHrlFqBG5kUXNCQCFN9N0emc5wCgU4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik0hlc9iTHBhMGyubnGJBZFRoV+uhPlX3pawOTmyoLQ=;
 b=weyC28vedaTifkM1eNOrsCqOrTOUkHLMGeyuIWuioOJrroNOvv7H0YpGcIKv8bfZ5TCkmfVgnYke903cN9nEVW0sk4+2MOoBtBtXyBEn3vH62NDSZQimhIzZJy55wL8j7jYC9R4QosScMl/ZoGI5gmtLl153KfTTl9f51CwBh5DIlZKcJRlkrb1QIZh5HohqsxFXP4j+HaOus6Gf5bOwTQmjr3lzP0P2ZZCXL5eGtsbaAp7lE8RtKKFS1ECUiSHsbHZmxpAK6JCciM+DwQzQec6pdNVg/d4CYgncZFp41nuR54hpHZAogCT1bR2iyuZq6uGL98VpSo1C7NtkedGC+A==
Received: from GV3P280CA0059.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::12) by
 DU0PR10MB7530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Wed, 19 Oct 2022 13:14:22 +0000
Received: from HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::25) by GV3P280CA0059.outlook.office365.com
 (2603:10a6:150:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 13:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT008.mail.protection.outlook.com (10.152.1.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 13:14:22 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 19 Oct 2022 15:14:21 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 15:14:21 +0200
Message-ID: <dd629831-dd5e-550a-b378-64ff3d48bbef@siemens.com>
Date: Wed, 19 Oct 2022 15:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
 <PAXPR10MB50378126C15801DC63D38C72902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50378126C15801DC63D38C72902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.533900-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxQ8KeJIgW2y2dZwlT0cB74Pg9yfk4YC0Y38vQ+IQtktdOo
	OI6ILwj2rcN9BdgNdeaHWMMz4DW4ujmcvaMWKiDIXpHfMSfHcCzvEJY6jb7hum1rAlJKwOBJEDn
	DEqNPdurm5xVqTV9QwYTZRPOp2cAouIJhQU+X0Hi7T/psZKU3p4gRniVlfOb06OX7GFz9H1AxpN
	d6h5+8nGjliw+xvItdAkyLKmA25z/qTI1uSdwkm3FrEmMnlcKm08q9KSsUtVduXgIqq6mQyvRU+
	9PTPHSYhz0lzsrxmqajxYyRBa/qJaEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7PMG1bhArHtqYPm/
	OR3JyvxmFrYccUnU37AlUPsNBBE36q7aLrAl22c=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.533900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: F60EF59DC031AD4F59CB6CE2399A5F0E3DDE966AA89606B97488EA89C2E77DD12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT008:EE_|DU0PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 732fd8d1-31c6-4b3a-8764-08dab1d3d687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7WvBaeJC95ADlxXSrp3ZXZz/2LwwU6Xhx8SgI0paRvPrunn4eyuqB/2czXneraD4LRB4Xy/Xa29N0PQ0Qd+FrN3eNTHwfEbxEjaNLXrvuqXXk7/7aqms65LbQL89N3if1hCgmtw+yxW1IJjamNEa5TzfxkxtN9ok4O4LO7WvzpJqqVvCGr5p7LwzB8yzbWxZQkha+L9nhxaaMcmQKNckxyZN3zCrW9j6wazRd8PFkOnxta4N3AzhFHlxp56qr+bZc55RkM8uqI3aoiLwEfraDVH2fsKkL7DOXLk5+Lx0cGl10WU/r1UR1Vek/WW6H9yafZn0qv/6zvbOMI9aZlfVpH9239RPrkle3da9ur+ECCmu3TBix3rcQ5mu64hVJB45RILB+SuDVsajtFH96ae1ZdF9fxCV//LM2LxdPbpMA0d83VTPYGE5CtWgVuThFSqdb2VX2kIMUqlYTk7y4uARghxRgc3EtI5IWQdQyE1pWUeRO3lGcCpDZ6eGEE7Ig4UuuRKCXOsOZYN5ZC87zlGVPU7Q7v3l+bxWHjK4I2Kb+fNFm5Kd+cGrfHRIehl0Sa9GnujSwJN8DFDwOWlvyUCfK0ain/AEJpqg45sKtkj+219XV2ard8ereLKf40770KgOda7krhARDUErnvtns4KksaUiiE8s0ZN0VnqFYoAayi8TA98qJAPYq8LSdjslTdL3FwvhJOD9gQaWbSior64KGVWTXuKVbbTyKTH4ZfxJ7H0epxmX10aH8c0kcKSitV0IlNRVKl7dQoa4iq5UFRCWSKJytgML2uRON7LKP+OXjInxVhHlx9w/ZXflOLv801xJM7Un0eQJShgYoD2IRgjG6jO5zhrOshymxaE1UBbLVjsKlE1kCr89VopIpWOSWT7E0jS0IR6NOorSLoVGjnYkZ7aCDVgTkMMV++74jzGFZTw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(31696002)(16576012)(316002)(110136005)(83380400001)(8936002)(34020700004)(5660300002)(336012)(2616005)(6706004)(40460700003)(2906002)(16526019)(44832011)(36860700001)(66574015)(70206006)(47076005)(8676002)(70586007)(86362001)(186003)(82740400003)(82310400005)(41300700001)(53546011)(956004)(26005)(6666004)(40480700001)(36756003)(31686004)(82960400001)(356005)(81166007)(966005)(478600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:14:22.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732fd8d1-31c6-4b3a-8764-08dab1d3d687
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7530
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:14:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9786

On 19.10.22 15:05, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Gesendet: Mittwoch, 19. Oktober 2022 12:44
>> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; =
cip-
>> dev@lists.cip-project.org
>> Betreff: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
>>
>>> +    gcc-arm-linux-gnueabihf,"
>>> +
>>> +OPTEE_EXTRA_BUILDARGS =3D
>> "CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd CFG_RPMB_FS=3Dy \
>>> +        CFG_RPMB_FS_DEV_ID=3D0 CFG_CORE_HEAP_SIZE=3D524288
>> CFG_RPMB_WRITE_KEY=3D1 \
>>> +        CFG_CORE_DYN_SHM=3Dy CFG_RPMB_TESTKEY=3Dy \
>>> +        CFG_REE_FS=3Dn\
>>> +        CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1
>> CFG_SCTLR_ALIGNMENT_CHECK=3Dn \
>>> +        CFG_ARM64_core=3Dy CFG_CORE_ARM64_PA_BITS=3D48"
>>> +
>>> +ISAR_CROSS_COMPILE =3D "0"
>>
>> This looks wrong, specifically as you are installing a 32-bit cross-comp=
iler and
>> calling a 64-bit one as well below.
>=20
> Optee has it's own weired way to cross compile. If you configure optee fo=
r arm64 and activate ISAR cross compile it breaks.

That is at least not generally true:
https://github.com/siemens/meta-iot2050/blob/master/recipes-bsp/optee-os/op=
tee-os-iot2050_3.18.0.bb

>=20
> Just come in my mind. I could delete the exports completly and set isar c=
ross compile to true. So deactivate the
> Cross compile of optee and use the isar one. I will test if this will wor=
k.
>=20

Will be curious to see the result.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


