Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE50C433F5
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 12:35:04 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.129])
 by mx.groups.io with SMTP id smtpd.web12.25395.1639485302442218094
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 04:35:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QbsbbmyL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.129,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQWX9GzVgQHCuOlZEVgOaG8xJ8cZQyF6Hfh0xG8vaKtzyxMdOlvqEFqSwsR3SSEfTyBfkKZecptMsvEHBqHQ70+C+Rq959v7dmWf0NudlzRq+IZUEWWKwk5V+QK75OanVaqT+vtz/xfLtiFDMaqmvRHhCE8MkZMMBCNayxCpl6RhGqpLpfCgcaAstPZhMCM+tqRGsB62HSHOj80uvacMT+BmH+gy+lH8FQJudu4Ybuu9kBiOel+5w4s6Hkx2LL48r94rOfeNvZSaB9Gh5/iua2opHQVd1OvQzNUo3Qa5foUCkfZMBtG18WoCvLTH0KEE/+/3T2BIPcsKg5qKBAlDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEyoE9hFKtYV5sZFPKqpUF905d3SpXJOh4R0EXxfEkA=;
 b=NhAjn46c2CWXWToxpD3Cp7v0eE9lbNWHQ6ITJb9wFplPLEelztPcdrTdiaKb633VumoSJcDpLmTb+AWQ7jK8I2KIvJoeEDwkm/qP30rFgRZVirrO0d7qTvTHEAssQrQJcIyXr78h14E/6o+QIIKl056NKzVFXsJLmve50w/SFPzn9v40XVLUxX/eCYhg+0bHbRveP3R1UCy5R1bjn0xAi83ykDOwqAnw0OK4MKNkYur+zo6YzUDFsrcP1ZSgMuroeMRf5H0sF9hsnXRyamf4ZDZ4u2mAWcp0NY8mQhmjEYAnvXe7RNALvz+XYDUldOvn4mR1AvJUJVgAKYoZeVAciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEyoE9hFKtYV5sZFPKqpUF905d3SpXJOh4R0EXxfEkA=;
 b=QbsbbmyLJR2QB8ZuaBXEcn0dJ1rKa/a+pWt8vEUm5UJo91Zur/+E/Bagas6H6CXlSsnVRJi8z4OnwvnyjZX8clCnGIvRzde8MoWDv5+BFjyMVHDymt7tlknSDT4QJh62KWSFtAg1y1BBLpOMzMme6fovCBPi1kd+QLcJKS5pB5k=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2770.jpnprd01.prod.outlook.com (2603:1096:604:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:34:58 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:34:58 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Renesas RZ/G2L support for 5.10-cip
Thread-Topic: Renesas RZ/G2L support for 5.10-cip
Thread-Index: Adfw5pxYN+H3x/1pQLW4IwD37ia0fQ==
Date: Tue, 14 Dec 2021 12:34:58 +0000
Message-ID: 
 <OSZPR01MB70199550B2B2D5D541FB59C1AA759@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7325638d-4789-4024-57a2-08d9befe23f7
x-ms-traffictypediagnostic: OSAPR01MB2770:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB27705C33C9384C5D0EBF5087AA759@OSAPR01MB2770.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TdRX2/NL/mNmcq1STFODUHBp3HZ+uJ8TfCRl6F87RlS27B034aIQU0eShEps9MhM0AEKUZq9rU6LKHDlVJdjrZG+vetEuugvvZWZa5hqePsbqy5plqnsSxgQurwi2xGIftta/IrBw1TAt5OFivI7jRke0d97QW6iNMaFlJH36133x0sBYsPuUphOcgzhehzV2MqnwIb6b8eK1lRvqKdg1UD9JB7jUeymjIt6WK4SRdJE8PmPvCg7ZBUTrb0CdadNsK/VcZly7PvPnI8ZAC+kCx2mGjVFolDDK96WjRrbA91I5YuZSAbB3h8sfpStc71ATG2npDlh9qqkBBamU7/YJZrU/xBI/EFgGoXUjXXhsHXjxOTN8T5iKRnWlZ6xOJ2itVjPWif3qT4iLFuFoCu5toWehrrA7ZICL73Sl7GVqQBCdVSDW0Ij+c53g5p+5pk5UECoJW4K5bGVgc5NtoWHDBQ2Z48eskCotKfP1yrvl0sggMANHVX7um9jRzVDL6A/10Z9cb0MLYKiDLn8WL1MAw8NyIcnNUom0X3YQ9HRp1DVrHhuDIZUgfcLtNJMJuPcvaEPvO5fA8ndzvBRoAXe8cy7w4bqkRGxOxwVz93WF531En/4wDsw6umRUKgq7UtYo68yDFkVMbFqJ+Zme4U/aogQhj0PmSOkN4Ch+eVdpW96nosWd8DkJdrqs5nAq/NIaYupgkNnVzfYOtI88PakIg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(558084003)(4326008)(6506007)(110136005)(76116006)(52536014)(508600001)(26005)(122000001)(66446008)(66946007)(55016003)(38100700002)(66556008)(8936002)(186003)(66476007)(71200400001)(33656002)(64756008)(9686003)(38070700005)(8676002)(7696005)(5660300002)(2906002)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?P3Ge1qJciTui2TUBXSY7TQYsoqvV+lcTP1eS6X+S3M+czHjut+/TFs00MfWk?=
 =?us-ascii?Q?hgTk6IUhjFdj29gGKA0Zz2u7rxU+/91jmxWPBHxA7KWz3LqexpjwDKe9qXO7?=
 =?us-ascii?Q?HxWEpKVPZ7RlgBIZCy/R4HeJO7xNX7y3P5IrXByne8eOH+N2aY8ndRCEBmkP?=
 =?us-ascii?Q?kTZTiqegaekIwpa5JZDUqvHVNNsInh3YKk5163ppZkfvKb77qECampEbusSu?=
 =?us-ascii?Q?gT13lzcZo75gHGmD0nDzFGIUPHbFct11NCvAJOclZymhanrQovG3Zn5q5ngP?=
 =?us-ascii?Q?7NAqqXs/ZdmL7vxkmig1bD60pGoxpfxFNQZK832NLfZUYRIQJ+of5TFzSXfa?=
 =?us-ascii?Q?r7mcALKw1YO8vaOSE+j50jnX/+RwpAs7/c505iBAZ3p6ZKwfbNgRmIVdsglR?=
 =?us-ascii?Q?5vs1oZ6VavaOT3Tlee5rtjISxgZ3s2j09l9GJuADhv/Au9mijH8sXMFmqs8H?=
 =?us-ascii?Q?5QPb0qWpyB23shp8DRciVnYiIeOrPP9sVNiibwHwUfQW5eGNenqxbk39Lg6P?=
 =?us-ascii?Q?4Oi3Z5uUhAJq+MW6wL5BVGqBx1ptQQ5/GfBTnnw52gdsehVvg9h559HNxO/3?=
 =?us-ascii?Q?ISy8NnnYADGp66XeYDyofwVBaCfubLiqHoIxUT20DUCM63dUJKDi1BuFiAmG?=
 =?us-ascii?Q?lBN05y3dN+MzyXEII8O/Z0GdJcl9CvDaxP1MLrUofec7qit7sX1dWfovcgzq?=
 =?us-ascii?Q?qhLknwz7dlVKMuNul6vzKqwHt5TJqRQN5pBS46UJk+CdlC4ERcI6rnhhOwgN?=
 =?us-ascii?Q?4Ne7oD+//E8ItZbHfRzc/awlMSTmHUAABX4k2McOXagXJB62JRzIqVRJaF9K?=
 =?us-ascii?Q?cP//q7kdpurTd/Ljr8XTSRnWL0yKA1yj4zZGD9RTucj+baTip9yZc+brFzI8?=
 =?us-ascii?Q?nUxbKoUESjMsOAEsT6O2OFPbzOwVliP29ug7D6NCIN+mE+yNZXCfiioWPJvz?=
 =?us-ascii?Q?6kIDTukNknG9PB+kfAPBrRz13WJ1CMzstN6DmwTs9wFnZzxfo9iyunaZ4Ttb?=
 =?us-ascii?Q?YpKzUbA2ZlaTrjHQbpzGazPo6uoizZ25kgiCEGd8T/m50pxy7UayODR80BoU?=
 =?us-ascii?Q?iuqp3CQ1CYokTPvCvdJQmNO+qxh2PUIatlURzxR+Id5nVIZ7Q0Qm1NplN8zz?=
 =?us-ascii?Q?RKeOCjHZbSOgTLdRJbv6z0O9QA9Tl+zsaJHKG+wXGCUMhhwq+VC/HXj2peGV?=
 =?us-ascii?Q?0Gfu8WCLLEHC+Xh5jeIS1JSKzoOsac+Eb5JEgOx3q//kZHwcdZmL3UjSD5x+?=
 =?us-ascii?Q?prE+/+JvEaw9GZHd2uBj8SMmVvNQPbN8YSc2c4h7gNQuxYiTqt7+OR5rWHDX?=
 =?us-ascii?Q?of+UT47Mnht8M/okt5Zf5MRDyw47okgGP2Y9UcUQdZkREXb7DrtzbqKsGCLa?=
 =?us-ascii?Q?F6bI7qjGau5tyvJvARpcnhfynfT+JobThk/i1bTsz+eHfQAzu/xEqpN/Gg78?=
 =?us-ascii?Q?kIGlI8ibgzZU/Nc+2Huz/T0qWX2Jvqy8lJsPsfwMXDx4VEMVCBpiHAOWRrEm?=
 =?us-ascii?Q?JknmrmIAPr6hE2OJeLLykh4Y+qwlVRKgXr5fFf2i4/XgTgLmwkiwvh201bqz?=
 =?us-ascii?Q?Q53vSMsLNS+fMcJM7rYmCpQn0N1iHcxpK7dTkA7+VuwoXlLaKcrCdkacdfON?=
 =?us-ascii?Q?8PUfNwMcBEqrftJdchxDexZs4KDaOYVNWAEKJ2+OxEmEdosMNuEFOhFHgk6E?=
 =?us-ascii?Q?E/e8ETtkA1AWD4tyz5fRfGIV/kvmnsACF0n80Z9XOt5auPdOQnHBO1cRT1NK?=
 =?us-ascii?Q?MHCEnG2g+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7325638d-4789-4024-57a2-08d9befe23f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 12:34:58.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 G6jqgZovY0BQzZ3RouPi73x9HoVmqJVE4dR/6j9LCNeyTFyuBy+3+HkiWTXOi1Ey04oWVS0vUMv/OVXm24sjLAZFrH1rSf59ErnoDSt1WmPuPdDCHwjVHuO6iZHa35Ut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2770
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Dec 2021 12:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7097

Hi Nobuhiro, Pavel,

I have prepared ~105 patches adding support for Renesas RZ/G2L on 5.10-cip =
(all patches cherry picked from v5.16-rc5). Is it OK if I bulk post the pat=
ches or do you prefer them in chunks(maybe ~25 each)?

Cheers,
Prabhakar

