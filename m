Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D6C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 13:47:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.23197.1684849658075171337
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 06:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 34NDlZDa014853; Tue, 23 May 2023 22:47:35 +0900
X-Iguazu-Qid: 2wHH8MjPatBFGsvZyL
X-Iguazu-QSIG: v=2; s=0; t=1684849655; q=2wHH8MjPatBFGsvZyL; m=JW5IXvnbgLwCsoJdgD0gA8nQXe0Tg9gcisCVKi448tc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 34NDlX5A010608
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 May 2023 22:47:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl0Cn8KteImzD6prkCZAbGFcp/AYdbJbROhlspj1kSpKKgmXZ8tDHxgzEA6ar6/AfuAQSOjrRbAwB6HLGrcnHODZSHRA/IPOOpSKowzdwiR9rYwvPAXs8q2Z1Sd3kMGgMGCBbCYEoEkBUVS5hktnM0tiI4b66Fr8vB05LXSywhieJKZCx/Kzih4+z+D/STyySpFmdyGWbjZoIn1ZdD1h05WNEf42uZVU88DvdkZUV9pj8+o2tRbw+mLlNRFj+PQLT7pGObdMiusTb5ALojWC+Dtvi0NuZ8om1DQHwNAawDG3hwFsZeWDvf/+t3F91+CNdMYdh5q5cIdOt3t1jLJNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4aSpGQXk0jrIfbMlYbl9hhnVwab5i8yTJEn/GE8FtY=;
 b=BlVmB+rFva1iexjJpB4oc3oD+IDbpvUMC8NMsoaEUal4p/Ris1ouVeemQR55hEgDkdrr5BkquOOWDVoI7VS/riHq8O8iRVZbZRqnnM3ME/SwKdTVJovY5YrCsehUFs1b1iZCkfz6jqZkOyiJ9iG3Sq9M1lWsy8bnum62vhDE0wvaVDxcjlMbXJEmNWAwc+k3CZFGagsLtaabaxAZ6hbQ9oKB9RfoQURqZP4tmO6F01jN866naHWnsbm24Dj2CbVScgox8qNZPBTMYFhtK04RNrgRuzzbPDSgdEPgiMT00lL4T3EEbDUDE92LmEygvasfWHePn31X6o2K7rszQ2eiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Topic: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Index: AQHZh//QvA/M4ylrQk6wWyIzwrQdwq9n6DjQ
Date: Tue, 23 May 2023 13:47:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB4945DECD50FBBE641129B4C3C2409@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <175FA4DCAB651D48.20583@lists.cip-project.org>
In-Reply-To: <175FA4DCAB651D48.20583@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|OS3PR01MB5928:EE_
x-ms-office365-filtering-correlation-id: 3bf8488e-05ff-4128-b2c0-08db5b944200
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BvRk6pqpHqztjW5zJT9CKqb9C7LJEEYwcg/oDxiI6xXxM8GSbWSX0/mP80SuafzFdXu3VrwZyHF63JKiXa3TpqjH1SLXIGdSnc6rl/G1Rjflyds0tvMovirlvB9+Ndou9iy9yrrs5/5PlVB+PesFg6WHU/A6lX9F8O/LSMKZTCr90WWKXf4vp9d7fuPEd4NgaebFUJobLf44bMGbPSt8cV1UYUaYDMdPjKvYFp0LbTypk6gG6KAJGpkAhRfgzNlRojlsZ1GwXRFoXxaw8LAe72RLfWNQZNR35KGb1ZjCi5ER54ifuBrjT3vtMn98tVRuNCurrYG7hIU34qDY5tsM1uuFIhJ9pkQ29Laz0Qfgv2rmI8okmGKjQYqz/g1NrjpXfS6U5D1QJA0V1102lPxRS1BiDKykiTc0AEb0RPh2U9LMeKFDUs+CNLuLKxKX0b5bn0WPRlaTJavlDGYJJ0lagMCv9WtLeo61Uxn08CLxqu/LT1l7xpVWR4WCbx5b8kpe+6Vikwy7LPpce81taSS4nJrhoRh4PXWHeyRQXUAAps9fQVp62XLFt4H1XP2nRfSaGY4U/uyaSM5M3HiFbYbI/CN2c8nmu+4wcuRKJv9PaXyG/vSiL7SBNI3NQzMy1zQe
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(38100700002)(86362001)(2906002)(478600001)(8676002)(8936002)(33656002)(9686003)(6506007)(52536014)(316002)(4326008)(5660300002)(110136005)(107886003)(53546011)(83380400001)(7696005)(85182001)(71200400001)(186003)(26005)(122000001)(76116006)(55016003)(38070700005)(66556008)(64756008)(66946007)(66446008)(41300700001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ME9IZ0FSam1XNWdVMXROT082MUNvQURETjNnNU5QTnFGWElhN2Z2QUxO?=
 =?iso-2022-jp?B?ZlNpU2pDdXZJSkJCdFYxN2pnSWxjcmY5aUZmU0UrSGpFTENXWUtmTUNH?=
 =?iso-2022-jp?B?YTBLdnltMHZiM05HTmxKNUhybXZvMy90MXA0OVpPK0YrQmdZVmhMS0ZC?=
 =?iso-2022-jp?B?bG5UK0lOMWgyNC83L05NWlVVaGxKRnE1cGgwRUdWcWI0Um12NE9uSVlG?=
 =?iso-2022-jp?B?T0U5NTZITnMwL0piczYzcVY5Z2RLSnVBOW5CeVdpSm82elJoNWp5cDNJ?=
 =?iso-2022-jp?B?ajJEd3ZFK3I4YWd2bmRYb1ErZVBaSFNNbEkwMW1LQ0pJbnJCd2VhdXFp?=
 =?iso-2022-jp?B?cG9YSEZweHRHMUluMkpVOE0xRWRQeC9iNlhRWVBCc3BiY2dnTk5SdmdM?=
 =?iso-2022-jp?B?dlNjb0tTcFFpd3ZteUhWOTlpMTdocEx5Qk9kWGlFbVlIL3o3eVVyVlha?=
 =?iso-2022-jp?B?Q1I4RG1XL0ZpdE9TaFZiR2xlREloOWJ0dXZyZGt4QWh3Nlljb1ZLZVNR?=
 =?iso-2022-jp?B?c0VSMzA1R1JQVlRocnNnRjRyRit0T3M3SU1MOGRuUDF6S3Y4Mytmd3Nk?=
 =?iso-2022-jp?B?M04vdzlCKytCeU0yZE5vMFM2Z1JzQ1MrdUNOVDZVWVNrRTU2RXh3cWFz?=
 =?iso-2022-jp?B?M0hQU2lDaGR5ckt3UUwyZGRoV1ZMbS9ueU9RWWlnbXZRM3BXNDdFeXZM?=
 =?iso-2022-jp?B?cHhPZ0RMQTFXdEJVa2ZCR0NlYnhSck1DWVlndHRJTTFnd1JjTXFCc1Yx?=
 =?iso-2022-jp?B?RDJLT2JMTzNzUmt0dENKTVVsWU11SjBFUnN3VWRVb2huUXF1Vm5od01U?=
 =?iso-2022-jp?B?bkNsWUZzbm1sbStzWkpHaVJ3UnlVb0VscnRoZWNDVlR1dU1mMzBCeStr?=
 =?iso-2022-jp?B?OWJDZk1URDBVbS81UzhNODJjUGltaWlNYWh5dXJTMjFhejZEeHc1NmR0?=
 =?iso-2022-jp?B?NXJwODF4OTZuejRCOXo3T0ZCUVlFeGdIZ2hoaGNWVU5KRkR3ZjRDbEtQ?=
 =?iso-2022-jp?B?VDg2UHVoU21IMzdiZEFvdGFQVHIwZGJ0dEdkMFBsRGErNU1xUDFEL2lq?=
 =?iso-2022-jp?B?NGsxNVFiRVJtTTdCSGRNK1FERjJ0VnNLK0w4S3ZSTGNydGF4SWZUd0hC?=
 =?iso-2022-jp?B?eWVxNFRwZXFtSGhPVmo5VUZYbTBqUTcwSE5oOGpYUDZYY1N4RFJwNzZQ?=
 =?iso-2022-jp?B?dzBLTSttVklQWmY2RjBzS2Z5eVl5QXZkM3NaL2U4ZFFDbE5KbU81bVZq?=
 =?iso-2022-jp?B?cmdjYnkyclNiOXFtbExVQUtjVEsrQi9XcDZNQ0JLNXNrMEM4ZW5LR0s1?=
 =?iso-2022-jp?B?NXYvQzlBVjZCd1EwSE13QmhCZFNqVUFaOW94bUN5V3E3ekZ3eG5Lb3dC?=
 =?iso-2022-jp?B?Q0U1TUpWYnhHWlEwb2I3UU5XdE9UTC9BNG1nM3U3aGZIOVlBQ0hFV3V3?=
 =?iso-2022-jp?B?Z0pibU1ZVnVCTjJ4ODlxQWhRVXhDcG4zZnhNMUdaTnRCTlQ3Q2xCN1R1?=
 =?iso-2022-jp?B?VDhFSENJNG5EV0FyWFQ4QXlUS0h4TUk1TEpvdmtyZWVPcEhJRnNrMUFX?=
 =?iso-2022-jp?B?VFlHWFBtNG9kN1pZWmJsaWtKMmFTM1FnZ0FQN01SRFRSbzBGcy9KVm5P?=
 =?iso-2022-jp?B?TzdyVXBXUmU5dE9QaDl4cUR1SElvOHZ4NmEra3Y3b1NObWhRUTlqZ29n?=
 =?iso-2022-jp?B?N3hiVlY1cVRoWSsweXI2ekZ5aDRnMGIzK2VKLzRkWnN4a3daWHd0QWl5?=
 =?iso-2022-jp?B?NGRjYzQ5MUdWM2NOSmFCRFBZQnZuVlpreDk4b1ROd0hWdmtLSEpOVmhO?=
 =?iso-2022-jp?B?SlpLZ3pQMktuVGlRNlVvZk1xYm9hVk16eW5nVUljTVpYYTQ2WjVid0hr?=
 =?iso-2022-jp?B?ZzdRYUVETkFkc0xMbDdIa1ZENGFIRHB1eXNaWEx3dUdvRFhNV21mVDlO?=
 =?iso-2022-jp?B?M1RWcHlaTDlvVVNVdVppUlJISitZU2RzanZnYjJKNXBRSWhnenJuSUJs?=
 =?iso-2022-jp?B?c1F2b003dm5LZE1JV3FiV0xmM1pVUThPSHJ4OTM5OWdpZndmZTNEd2xF?=
 =?iso-2022-jp?B?NGtnR29QelRUYkIrS295L094MjJEcndmNFA2WXhCR095WUphNWlBZDNt?=
 =?iso-2022-jp?B?NmU5WGVTQWRsVjlsL2YycEJFRk5UOVEwaU9FMjdNaVZtZENvRFBlTTha?=
 =?iso-2022-jp?B?OUdCOWdoQzVCaDdPTWtqSWJ2NHdINlVVZjVjdTg2bWZpSFpwV2lQSFBQ?=
 =?iso-2022-jp?B?NmorQ0kxVDVnK29Bc2pjaU9DT3hNSE5nb3dORkorUzRFVmkrcEoycGF4?=
 =?iso-2022-jp?B?RlFVbmppd1pwQW11SG9KczdMSlFWaXQzbEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5LYR3EwZb+qWEOIBmAIfzQJia/Lz7JWF4zwuIaSFDPLW2d50LrP42mgnZcaVlDqz/U0R9h9X90wQ9pA85rSqSILxLvua+WIOlN9SWjuhyytb7hdauukXXPjvrUdbucbb+HyJifFOkKnmSaqxdr9NcamAYP7E+zVL6aic50f7Q6GhgevurW3ltPhUcRoSZlspR6QMwqW8b4cgnrl1gWmP38nSujLarb5T7j8hMEpQ5DE2TRfKl8paJ1uCdyogYIBX/6v/+pC4B1JnAJL6lJiLrIkAFYfuxl4laqElgVxAXOJDkhf9hDQsrG7IiTpsltdNMHZFdnn5jesqyJ0n3OOR4q9br4Szzb1NryIrFlypi4YXwsD3xv93XGOAzHMRCCZi2LCJ+l/mObSxdMwiI+621eNTwOU1/WhgWxpTW0tqIVbfok7b07GBG/PbNsFaoUp1+MSRFZztdkHZyhY46e2TH9YNfbHIub0qF4vhU5rAsSKFvARBQy3n04NAb2qTyAeZDIYMGR/5/WXNMMh8m2VGDPvy22XkYZ1wCUj9D0wdaAhZmfxMImQjNEbIXTy4Y6XJfjO/A7sMoElv66m0uDxjz8IWm9IYjuMYDm4M1WiKhwki53Qe2JTr9/88UYTKfg79Ly1jic3MDycZw2Rgn7v08lcpsLhBTQMRqPVYs0TTUwVTvSDWjVGDGHY4p8GK4caRpA7ZECPHo9FxqnpZPJvfhui1nqd6JVVJ/B3XH4Hken/bL2uQxcR0Ox1a4DoAHGNfrZMrEh2lQ9cjhajAGbyy2zjxcqQv7M8FmiEtHzFiygBJgU1jiuPbz9gab0hMLUF+
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8488e-05ff-4128-b2c0-08db5b944200
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 13:47:32.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UR5L4GueBC+4TNML162XE2+GyMOneP30u8VCaQypTNGagaLCrr7UhkF/F9eA3UNJcx3rOj1PP2sBwdrOB0v80mScaz07H1kZLyVMuse8Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 13:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11613

Hi all,=20

I request you to review this patch. Previously I sent a patch for acl packa=
ge to work in arm architecture (IEC purpose) but in that I mistakenly added=
 ext4 related POSIX_ACL config.

Sticking to the purpose of acl package to work, In the below patch I rectif=
ied that, and just added already existing EXT3 filesystem's POSIX_ACL confi=
g.=20

Kindly provide your review.

Thanks and regards,
Sai Ashrith (T S I P)

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of sai.sathujoda@toshiba-tsip.com
Sent: Tuesday, May 16, 2023 7:37 PM
To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.=
MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.c=
o.jp>
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
Subject: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for acc=
ess control lists.

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This config is required for acl package to work which is used for IEC-62443=
-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 5.10.y-cip/arm/qemu_arm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/5.10.y-cip/arm/qemu_arm_defconfig b/5.10.y-cip/arm/qemu_arm_de=
fconfig
index 58ca273..b8f4e88 100644
--- a/5.10.y-cip/arm/qemu_arm_defconfig
+++ b/5.10.y-cip/arm/qemu_arm_defconfig
@@ -149,6 +149,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS=3Dy
+CONFIG_EXT3_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_OVERLAY_FS=3Dm
--
2.20.1




