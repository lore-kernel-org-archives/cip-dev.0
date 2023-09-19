Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AEDCD5BA6
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 12:13:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.6744.1695125578890472968
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 05:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38JCCuZA3732387; Tue, 19 Sep 2023 21:12:57 +0900
X-Iguazu-Qid: 2rWgLYQMfIa9S64Fuq
X-Iguazu-QSIG: v=2; s=0; t=1695125576; q=2rWgLYQMfIa9S64Fuq; m=wv06N+baxAMeiX5mw1W70bCULNO7WD7zojtezRiFSwE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 38JCCuKY2726004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Sep 2023 21:12:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+MxYtDRRy+qST0bTnBP47f880Q7+TS3V4zgjLCWTPJ64V6CXm0qSjXIIQpGR4ACKz7KKEmIz+LgSI36PfJB3BYDgv1K3SIkMXILJSiO7VJDXwlMvxommon/F7DNUzfJVkAHaPSF7rhblWSacXCtx+2xHSm/F2dO/noDr7LlpPg5yaUD8L89mQBAYgt/x2fPieMqnAX5wUV76WvdlQ8ZRqz+V5dSYwWz/q/Ix+/G0cjFB/q6iIIEJzdEjgAp8839H0Qh59wMGMFgWrlLuU7ogN5MAlnPRNGimSEChkFoIKtTM7T3UgFpbPAc+Y9qFwPPu03hQeYOmEmEGBmhUhjSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XADzvcfW1OvbWc0vNyDsSob66jafCEYIoE0o8XjQiQ=;
 b=Rui/GdVLIf6USO4bVCQFGlKyyydkVCxgVud1/F43s0I3724GiNkxO9hTLL8NAOJnQ7BfKvAqul++SOYZtwnv6DKFD6Jz4LKfw1vMSUf2+iWmqm6oacPhj4UtvTe0/aWHwUOhJRud6DPjXVRCX4AuKXI7pMwSDMH8yWzm1NAeggIhoNotb2Tu3UNOi5oB6dD8Q18Auv3HLXrg3tccCTY7MDbxsWaXHW+HxPNAV1LWuUzbCSElQm81n7A+2xPjT88j0sCv4vD5VY+rr/mrrmsjXbN9SVNLu1Hjj/LKmUaI4TykBFhOSrq/qOceBoX5peCiOWx8JKwvstyq3K1/Te/mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-kernel-config 1/2] 6.1.y-cip/arm64/qemu_arm64_defconfig:
 Enable TPM-based LUKS partitions
Thread-Topic: [cip-kernel-config 1/2] 6.1.y-cip/arm64/qemu_arm64_defconfig:
 Enable TPM-based LUKS partitions
Thread-Index: AQHZ4k2oFYQXIWXs906/ZIGayGRHB7AiIH9g
Date: Tue, 19 Sep 2023 12:12:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94204582E3D208B13387EB3292FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5904:EE_
x-ms-office365-filtering-correlation-id: ada3e1b2-484a-4411-bbbc-08dbb909c0e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sHYuKVHJuMoTefAGY4VerT+3RD3phIJYVPXNMgiKZVPriTLGICoZu4c7YWD+o1B8FS9YwahkQaU1SeOtpaTx00jkugppv7o70ntuOy6XatE/Lox/Mf8WEnKTEILikGb49yU/npPDmPUIQvQK5dlPa2X4EDxFqMp003ITwuMlQx6FJFLfb6ojzROC34DDYiDE99xp7CA7pjfLjH3uGWIsahWRqz1VsbaDOYilm808vYNdUDo0lKWVY5O5JPOwaEmes/D1O1VB4TZHsxtWkz5GkMovp4ye2/IH3P+jrXB78+2l8XFjXxmXJZm7OEAU44FLYr7XwOrHxczHbVWAjX7U/kSqgIe5p4k6o+C9rVyNbtiRvKFW6N5Sbi6cM/klnFkNgxItolao2lh68nEKeH5BcKCK+pVd+UDT2JheQYp/b5eThSWWXMqTfYPqVwkx5GVaGw0X55BJFe1at6LpU5on548UwEOcAQAYlkT0pfNFJq5jZagGj6gHav6MizOYcelLI12P1tnTIhlQSOEbEQrXXsgIPQVm3UGMyhEjObkg6J2zySntFf6Xd3pt6f0612s+sIPnR3IUz1V85iiLvejx3lqFtrk89WwEabK2/bnXO+WJWVBMAbt0GIyrNOYazsytvOx2PPev9bJJ5aqSUXBuug==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(55016003)(71200400001)(122000001)(54906003)(38100700002)(8936002)(4326008)(8676002)(38070700005)(107886003)(33656002)(76116006)(53546011)(110136005)(9686003)(66946007)(41300700001)(64756008)(66476007)(66446008)(66556008)(86362001)(316002)(4744005)(2906002)(83380400001)(5660300002)(26005)(7696005)(52536014)(6506007)(478600001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S0xCdjBvUjNCRG43NEJiUjFNTit3VFBYRVVUUU15K0ZQa1dZUldaSHk3?=
 =?iso-2022-jp?B?clEycWxnYW5TOC9RNmRSSWx3aXZxTVhJazUvVUZ3NG14MmN2Q1BBLzUr?=
 =?iso-2022-jp?B?WElGT2NRcFo4ZUVzT1A5RDBmWjBoTjNkRHpTYy9mdmU1dEhTTHMwRkFK?=
 =?iso-2022-jp?B?b3c5aEdocFVvSk5rT2theTBGeStiVlpwRFJPNWZRcWM2SEF4cThiTU5j?=
 =?iso-2022-jp?B?MjdWVDcwLzB0ZEs2bTN2N0hNV0J6dGd5V0QzWm9zeGczODBJb2daTUt1?=
 =?iso-2022-jp?B?MHZYcEdqUC90MGt2K0Q3WmE3WDliOHpmdzhrUG83RUw4bWRXWXpBbjJp?=
 =?iso-2022-jp?B?T1E0bGltR3JMaXFSVllnT05HZmdTVEdpVTZOa1kyNDdiSTI2S0hIdExN?=
 =?iso-2022-jp?B?ai85Ykd5YzFWZ3JKd29MaW9QaDJKRlk0QzlnVEtSb0t6STM0d1BlNTVJ?=
 =?iso-2022-jp?B?aTdNMXlIZjdrR2kyT0MrOWdYNURKYWFxRzg3eFpSRjFRUm5FYm95Rmdh?=
 =?iso-2022-jp?B?ZjA5Y3doYzdGLzd5MkFZYXBtR05Nd3VrbS9vVFVDMFo3YUpsMmg3cm4w?=
 =?iso-2022-jp?B?clFWeVQ3elpPNWp1QXF3V3lIeTRwZFVuNHRCVXZxOGFYZHREQUdaZEgr?=
 =?iso-2022-jp?B?SktmcHd0RGxIcFFoaVM0czBuODNrNjczTFZOZXNaSzBUNWI4VkViSlVo?=
 =?iso-2022-jp?B?ZWdWVzVyTWFqb04zeUF4eWl5YkNmcWJmZ0phbXpvMG5TenloNlBkcmg4?=
 =?iso-2022-jp?B?aTFuazNXRkl2WGdQT2FScXhpMDlIK3hlWWhWV1A5Z2hCRGFUNEhVNGxu?=
 =?iso-2022-jp?B?Ymx1Vm9BSUlDQ2duL1V3YlBmUHRmR3dINXBrTFhsT0hKbFMvNEZvTjVl?=
 =?iso-2022-jp?B?cFRabis5TnhjWDkrNVc0TktTcDNxZEZYVmtValk5YzA4clpjWFMvWE5J?=
 =?iso-2022-jp?B?akNQdHhnUlJyK1RJcDJPRUlaTnBWZGJvS3BtUHVwdXM1cGM4WXdVUVk1?=
 =?iso-2022-jp?B?bzkwSE1jYmEybjRCc2JDU1N1M1FqQUFVQ2Q2a0JQMUN0TTBuRDZiVFc5?=
 =?iso-2022-jp?B?dmpHYk4yc0ZPZHBXODFWclMwdWJtOWRYYTlBSGVKYlRrN0V6Sys4Y0pL?=
 =?iso-2022-jp?B?QXBuL3VzaW5BVFNienFaQWZ6MlVlT1V4ZE5mVkgxN2MrMm9kZ2hxdURx?=
 =?iso-2022-jp?B?aGVoTjA0ajl0NGxyYzJDNko0MmszTmsvWC9veUwwWTFZYmhVYldkWlN4?=
 =?iso-2022-jp?B?b3EyWnA0R0VXa09mcDNIT3dna1lnNnh5UjFHL3I5bEkyc3hyM2VMcTUr?=
 =?iso-2022-jp?B?dDZXakQ2VE9rOXNWYW8vNVpmbUlrZHMyM0NjZkJtMldmVFlhSWkxM1Ft?=
 =?iso-2022-jp?B?cUxmb05aTUdwbnRrWHNqK1VScVpxZ3pmbGdVVzJaSDZmZDVBUGVSWld5?=
 =?iso-2022-jp?B?emkrNWNIS1BZZlUzRWdXVzBnem5ycWQ4NXpFamovSzQ4SU5TQXJNakxm?=
 =?iso-2022-jp?B?cmZIYzlndGhIckR0OWZiYW5NcGRHT0JIck1LYU4xTEFsV1NOcm5hdGZs?=
 =?iso-2022-jp?B?TThEUDBuL3NhNFRjTDg5dEZIVHJKbkpRWCtWL2pYb2w0SEtTcWpVV3g0?=
 =?iso-2022-jp?B?aXlIVzJPem5nN2ZCL2V4WXNDYkw5YThWUlZmQ2xINkxnWVlJYUl2RG4y?=
 =?iso-2022-jp?B?UUdidDlEem56aWU0TWRIaUlsaUN2RHBvejA5ZW9wK3d0WkNnMDFCQ3VY?=
 =?iso-2022-jp?B?RmdmUzg3R0xZZzdLeE9mV0NBbmNhU1ZTZS9PT3c2RjZ6WXMwUk96VHN1?=
 =?iso-2022-jp?B?WkZ4TGVnRU9TWEgzanpjc0VtYms1a3VaODV2d1BubXFiL3hLRVdlQ2Mw?=
 =?iso-2022-jp?B?K1pRR3p0QTA0MmM0S284N3ZHT3AzOG1lMDR4R0FrU2tQL3o4b3dmczMv?=
 =?iso-2022-jp?B?Ynp5Wkh1NzU3Mno3WmFLOEN0a01tQU1jd2RQZTlhd3pvck9WVW9JNXBT?=
 =?iso-2022-jp?B?KzVrNEUwV0wzU2Y0RlhCK2NGSEo3N0JVUjZzRytQRFZOZ2lSNFB0UVN6?=
 =?iso-2022-jp?B?R0FuWHFHajFtNTYvT2xqM1lYRDRjUC9ITlk3c2NGSFhkUlZxS1l4dWll?=
 =?iso-2022-jp?B?eGRucVlESVdoZS9LaVNudGx4OVc2K3lHalFaTnB6aGljQUpoc0QzZzBS?=
 =?iso-2022-jp?B?eHB6OE1EK2QrWkNLNzJjdk1UY2JaTXpmcVo0dEVxVWFEeDJ3dnhTTDN6?=
 =?iso-2022-jp?B?YlFjc1g5amFwTk80cEtFd3hsTUUwa296eE85QlRHUTYwQmltR3daUEFN?=
 =?iso-2022-jp?B?c1FQNS95ejdiQ0MrQ3ZFUXFQUGZNOVpaMFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada3e1b2-484a-4411-bbbc-08dbb909c0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:12:54.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pW+NoqnpaSLmp95DpSm8i0fomhmo7YYeVeSqY5z4cgL4FRxwaXYNJznj+JjEugEXRkiJkOGIq1y41CR6dLS2//VNnd/j2g7odHQ9UHj4OljzbKVKJ3DQ6h4aD26x1/qk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 12:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13147

Hi!

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Friday, September 8, 2023 9:12 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-kernel-config 1/2] 6.1.y-cip/arm64/qemu_arm64_defconfig:
> Enable TPM-based LUKS partitions
>=20
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These configs allow to use LUKS encrypted partitions with the passphrase
> stored in TPM2.
>=20
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  6.1.y-cip/arm64/qemu_arm64_defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thank.

Best regards,
  Nobuhiro


