Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A243C41513
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 14:33:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.33541.1690554831169870021
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jul 2023 07:33:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VwOfRJuT;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyD5cRxB3l1Dgm1jDM4QZGPYsXptXxO281O9m/VcIu9k4LbwCp9y+6mVrXnk34LQwVP2T6Xcsr2uAIEOxI3DYlV+riCALApWDNLUqLQ3+rQUL2F7IceFy+Oe6urNpdwkorREorwS/yuy5T2dhgwEgjbC/kmAePm0/Y7O2dmo56CF+JbRi1VCk5cFOdmiScqw9kxVRCKJCFNx+6YbWozVXqKLqI25YxSBuoth+ymy8ri/abjd6WA4PSHVKBGyFVZDLUy7TizIzq2Pe12R0BIMLQSSqCTmfaKSRQWhBYZhzSFE+Uc/8tH8esotpsruNJzN/0JNNaDFY9Yj+04z0aIOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuCkQ15HwMnw8lPNEzUGQAX5S+qoVS36kX/1WQeI3HE=;
 b=EQSAVnaGIeqCEGfwMD7iBnKR5uCrkRYwhb1GfPNPfskItknfjdMXi3kd7V2kih03Xvkzxx7YA1riFmIX16LBaAhNdT/pnLFuEyMHIdk/jjkYwAT3kSr+bsBC0XCr0pdBXcFp+kiFa+UHUolwhDPNJ0EcUu6U7JtQApuOFmzyGjtWc/NT73F6b3O7o7cECKNqc2iwdb+/pCGJrgS6Uq1le4qVDXrKrXAaD5ryWPzfY0Sv0gI0XVTClqF42I1nfcKzMyzlksFRQOVPIT6lwRHxCzMx4+oKEtsR5zdRgUdJQJmb1Yd0aibHj3439693LUMZD0Kp3bV+WzzfS0R1Canguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuCkQ15HwMnw8lPNEzUGQAX5S+qoVS36kX/1WQeI3HE=;
 b=VwOfRJuTfdtII9YLVrhG+zucGz9IK+EEH6dkkOdE/sBYF2JyFeOdYWOmXJ12gMr5koc61Y7gI6blX0Tidvc55eJD7EyARUG/2Sg85dD5Nj5XgjP0CrkYDMrFJ6iSXO9mAUZFGzRMSQoKujSwJzDeWYmvlaob+Htif8UpK/Uh+nt36+gJ7Eey7A/0EOQWpFjUHe62GBmVl77RALVLZoJppEwdL/2KZBLFPsJHjHQ8aEn7rXbglnD8Rj2ofKk91wkPzV819PL1GAulwy8OBhFEoFSQaTRDgZU2G8EEwL8pfkQSzgk+foYVaYU30POZ7+kse4+OuMKZFIE9iDhDFkfNwg==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:33:53 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:33:52 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "Koch, Stefan"
	<stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH 4/4] initramfs-crypt-hook: Fix error with
 libcryptsetup-token-systemd-tpm2.so
Thread-Topic: [isar-cip-core][PATCH 4/4] initramfs-crypt-hook: Fix error with
 libcryptsetup-token-systemd-tpm2.so
Thread-Index: AQHZwWCIucUwe+JW4U2oTka2ScHWOw==
Date: Fri, 28 Jul 2023 14:33:52 +0000
Message-ID: <20230728143320.3891194-5-stefan-koch@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
In-Reply-To: <20230728143320.3891194-1-stefan-koch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|VI1PR10MB3151:EE_
x-ms-office365-filtering-correlation-id: 67640c02-835b-484d-b0bc-08db8f77aaa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AV9WMapkjEGeG9bVpolaBgD/ynnB0cZ735hGoEak3E/hbSJ1ta8EiiwYCdG7A9OtMzvMubjJalSc9cj7z5Om3V1j3kcfMIc7drI81zA977U3uDpmE7SdQEi4OpENdNCKnS1srnuEFUh3sEu+BM/wE12Z8BWCIqMuLq9TSRgL6xRD/37EdTAkuii3+9kfT9SmXqyJFQPJ5vkVqfE9icX/3muOxa6reHL8+XUXhGV2NdAbQgI9mjx0fdgaoNq8iD2ng7Nm/YYYIaSYY7h/8NAL9bnVpGzs08dVVOM74PMRhUFzualSLtTXSnFaQwsL/EZERL7cHTDEr4NBSn1IHRgPdQ153Py4gnJn9URrpPefqUb50XuHQWTCps0KhJcRoIEUgmPDZoxsQbGBgib9o1zF9B/UVopLX6Avoc36mcCoNFLzr0akXK6JrJ8WkUWVtrlFgbOXkGjK6Cw/nqaz2gYrh2sOwN5cXLgUhUWBmNKM+Ykxp7oJaEYnUORev/UJRqrdb21kmAlRC08IZ7RPl4+mA6qgPcFa3ufkzjBu4/O8Nh5fTsuR8CMANnoZbKTRbIB0muBr4bxybDRbaGDed6hu8GB5YrT0atj+Z7LCFA+Wn1bSB6ZAcuJczQcYopaGYixU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1076003)(82960400001)(26005)(6506007)(478600001)(54906003)(186003)(107886003)(71200400001)(122000001)(6486002)(64756008)(66476007)(66446008)(4326008)(6916009)(2616005)(83380400001)(6512007)(38100700002)(66556008)(91956017)(76116006)(66946007)(5660300002)(41300700001)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Jo5LUcgcIHIwOrQ+P0m5v0m54OzLxoMxVQr5EdHyPey2ynISG+1wcw+CPq?=
 =?iso-8859-1?Q?oQrdN19Ig6PY6loMsEKYE1hXA/amRkw0SKmcQo/1OYIcaUNYgs4i8JafCn?=
 =?iso-8859-1?Q?CtB6GFgBriu5pR4tOnFpuvuQtjKsO9XTwS9MbJyTRoqQn+Q4ZiVP+LJrPW?=
 =?iso-8859-1?Q?LfmXyc10J/QRf+VPGElFWqSJa7zZ4Fwldnspxwgd2Y7ljR02Fk6+ef9jLa?=
 =?iso-8859-1?Q?q0kIjLwk8krlpDHjUte1PYPHWFCnKeecScgqRfcEyGdMnQ3Wb4Rl/AeCVq?=
 =?iso-8859-1?Q?c3XitcVwLViQd6kThZWThsm+PngDtMMBWZCciE5ldKjXhHwTtE9H+FGxhL?=
 =?iso-8859-1?Q?VeO/BGCQFnR10ThfMkVGj9R1jSbW274lV3y+mkIW7KQtxAvB/KrNurzqRJ?=
 =?iso-8859-1?Q?+KGcQrPdv2A5oEoxR9rFb4/D/1N7zyckG9llTh232YG74e8Mvj3ZfD+lom?=
 =?iso-8859-1?Q?YU4waS7m5f52OutaDQ/2I/zwWvDLi6kNajt8ChwmL1r+WbdEJwF91ii8u2?=
 =?iso-8859-1?Q?PlgWR1HrZPYI77g74+eK4wIo0bXZZuonuqMX9a0DV0Hg7z29SwF4v2VcvV?=
 =?iso-8859-1?Q?bOEXAS+TBG+7SWFITTWfBwLcXqzhX6DUuJHPMK0haeyIXSVa7C2tZbj5/v?=
 =?iso-8859-1?Q?7EfLI3SREpgdkkwJBnO0SNxdc9iHkiDM7MlejbxM7TjD0Vju5yHm0LUD9C?=
 =?iso-8859-1?Q?ZXVBAbUfMfLX746E7TaBL4lIFYa5bd2un7jStUKcR6DPvqhJFah/XhqYlW?=
 =?iso-8859-1?Q?6KTzzb8uiUHQHbmXNKJ+mYYg1Jg2uCAIh8VlbDX8lr8pXnkOhgDOKW6foO?=
 =?iso-8859-1?Q?k5tXKXZj9yCg83Z2xvWuMDtScFzL/nIvYjhHvjIPmO8hY+2Dkequx2Zoq4?=
 =?iso-8859-1?Q?vBpn1DWERFsa1QPAUV4jmqQTbYo2o/a0uvGJzXxX2OoDiH1QwwOmWXEBlX?=
 =?iso-8859-1?Q?l3wbWSeGWt8S3ZjLng3abLqqcJuBwVf2OVuJzbPaC0o7674R8VYTOeGGTT?=
 =?iso-8859-1?Q?rRlUVuMQ4DOY1GZ/UikezfNgaBL57AUyS4/A0s5IonLPI0SfQLeWduGTDO?=
 =?iso-8859-1?Q?yuwo7FhPIHF5YxK4x3grjfTkleESlqu7GP4xfM/BX8i7tRLpxSjvtDH6Hq?=
 =?iso-8859-1?Q?toQOB28HDIHjXsR8DpGLyhjQ4S+HJfQIl1psTe8GMtMZSn6o8SodS1XbIo?=
 =?iso-8859-1?Q?G1qWtVufhJLwK02II+S1Xmzh5AS/QSnXlFwds84AH6Hhl+EbwyNPAffS7e?=
 =?iso-8859-1?Q?CAaZpxr97pk7n9PPU2Q1J7yWRPmkRrx8hymTjtNStMl/XztE+mT0UtTM3A?=
 =?iso-8859-1?Q?2OljfegJaZfxfUILNX3AuaaY07hvLNmQQx2b2gU+ipX7Y51pSezePlXNaR?=
 =?iso-8859-1?Q?2jrtqyT8MUpQqGO9+c/m2tYb+XeI8BT8wYZV+6Rt6XT08J2laqfxrudK+D?=
 =?iso-8859-1?Q?vFvgFJgLv0AQk05DP7EqRPaq9l6XJtN5ocxsSskFhobr05oKjsorhGuKvq?=
 =?iso-8859-1?Q?xNoAyTWK2ywKtLQKdDLSxe9/6znSjV2qEZff35xQHdR4b5xc92xQQEKVdm?=
 =?iso-8859-1?Q?ON3dhma7vEM9ki5Fvh78TlkFX5P7TuoE9dCWve1DUu1Y4SyBlS3lGRomgG?=
 =?iso-8859-1?Q?AWs6iJor7lmqKu0mKXn+KxOoJ6QUZikY8MO5OUNmjn6yEGw1n53A/1wQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67640c02-835b-484d-b0bc-08db8f77aaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:33:52.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaYqTrbg5Zstl8TbyPVYEMWSeKu4zKxom2fuHyVPPyyfPz8RUKbG/cOYs1B0j5xyya5XeiJhdx+oJbLg4c9n+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jul 2023 14:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12521

The library is missing and is not needed for systemd from bullseye-backport=
s.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index 08ea631..dac60e0 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -44,7 +44,7 @@ copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/c=
ryptsetup not found"
 copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cry=
ptenroll not found"
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/syst=
emd/systemd-cryptsetup not found"
=20
-copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hoo=
k_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not foun=
d"
+copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || tru=
e
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
--=20
2.39.2

