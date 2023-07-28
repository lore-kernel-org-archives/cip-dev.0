Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E7C001E0
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 14:33:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.33541.1690554831169870021
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jul 2023 07:33:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FzyJ1Plp;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+gvrjqv3pltOzjyrC+FqiHUTS5rETteKsxVlJoRNSfGpaDTiGchtot/0AXnm61WajEyzQxKVX7PkIdrKREHmPPTqwquydynnslB3XhguQltyRTqPHpYp2jGo1KOEkBokZZ9IY5CHfGVs8FnV86hFy+GCfcxSWeEi7p0Q95QMbkpS2XVJ/wylSvVeUpRNQRjPx9mAww/guL+FKbOs64ds3vFRK7YtRaB9uQrF5Qzu1swu4EXk6ujuw5lXb5BqxkBwLODgXFvqQxtGciLPBToGasS3iRhqncFhuE4yVcMGCurrbsH6dOs0MD0qDduHfI63GaqVXWtKmMxsO9zI4FwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXWO8n74CtrSAEi2frAhiTsr6xYYzxXS1cb7ZFGEeCs=;
 b=O9nvfYZd7KRFgArQEdM2GdO351Wrl1OjtqR7J+7a0rvI/ae4QSh+pulaCP1MWxSNCwW2cCVKoQjBB+MkzNlp3Q1WDxsGtF3j4Xt/2AJR/aWL9gzjj5qcKKtSj0VGSSYdxZfENEe3jSuAdu3pmUriPhNFZc+6QTUiy5m2Koaiiq+rphaqLYQbksILmLDeXBuBXdlpE6jfNJNAI/RHMe9ufSFgyDJT7BTTJe/SrF3w+UtKw8eV0HXD5WbXyE6gNfzIVzkjRDw5TLP2CWiWYthAAG2waa03TLosUzIHJOb8w2uMZkH7lQLI0GrAIdJf4hiG1pqRyODGirohjzQYoJrhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXWO8n74CtrSAEi2frAhiTsr6xYYzxXS1cb7ZFGEeCs=;
 b=FzyJ1Plpkm6OBgLo+DzfOAFFhm9fszBFxAzhFON3LdIBW67yq5pZ/YjgL1rVK1znO4rS2FVReCRjbYM1BvFYesl8XhyRtrtPBuri31Lm4OR6a5ck2l41E6IkgiNfSRzK+UORCUikD4bHDd5Eslge8QjT8u9sPyphRAg0+Otww11M+wrBuWISWjdr+2Cpck38GmWbHQ+ficEPE3wxflua3N0/yQ855jSeHhHJUI4mYS5cnQizAd2/etYAXIGSuiioJinNfD67RGlfhYVbQxDb4hUDvstRcOYBiHkrUn33Q43NxSChE69k2MPY30gV8GZnZ5FXVuux9AyKtkUo520jwA==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:33:47 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:33:47 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "Koch, Stefan"
	<stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH 1/4] initramfs-crypt-hook: Avoid data loss in
 case of resize2fs failure
Thread-Topic: [isar-cip-core][PATCH 1/4] initramfs-crypt-hook: Avoid data loss
 in case of resize2fs failure
Thread-Index: AQHZwWCEoWvlLDxJ60qh5tlm3HfV7Q==
Date: Fri, 28 Jul 2023 14:33:47 +0000
Message-ID: <20230728143320.3891194-2-stefan-koch@siemens.com>
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
x-ms-office365-filtering-correlation-id: 3e157dd5-22f5-4976-369b-08db8f77a777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0iPJfAI/jbyzSsO6TAJpRDGfYUD8xk3PfXVkeCX1HTcF9o9BPgBsubCr3Kz/sHK8z+btK60wRsa6w4JKm4l+l6nSsT1IWDEfmzXG/jcWbhOPhYlM/o2rOrEP4c9veRUereBOfSe5CzgDR6olmCUrY/Meqape/gUMUU9kRd3KfJTsDnRvkV0C2Uecc+Qpea7ZtGMrqlAvXtwYFwJRHvglk4SucuU3L+6baeIYyv9a3HthA14VxXM2hOUNcP+9bgmhpVsmf2INMrkdlkkK15U1jBAGC/fLZpeQ561STheityxNAXAYcN2nlfC5LxSosCoiXIwp4l7V+zlc59covgL0Gl/YzuDPIFYudRog6JWQaTlSVMDwQ3uv0jsTkGlwPjY+PYZL+f1+OPqUbH13gHgK4Krh6JMKQxQpPRIe4ef+Qoihi3uZwz914PQvEe1F6sDOVbgSB+RYFtpemreiYNsdM0v+/caBU1DNNLj9Qev4bht8MGgE+1bCugJxR0eE8jD4R/CKL0843J6pf/OFzkcxGAMDEeF1lybWIm9KRPSxWBtR2QoXfyP/NjlQNzVpZaZxa4L3HkDZUXxnPbXavQv+W+NUVdrDvEPAaxZBUQ2fVBzpWmEqt7XKSN06atWSuZ/a
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1076003)(82960400001)(26005)(6506007)(478600001)(54906003)(186003)(107886003)(71200400001)(122000001)(6486002)(64756008)(66476007)(66446008)(4326008)(6916009)(2616005)(83380400001)(6512007)(38100700002)(66556008)(91956017)(76116006)(66946007)(5660300002)(41300700001)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?OZPYfjc/zjilEI8d53KVcLN9jcm6ZO3+rysEyRqlYYeNVPpannckkjDusR?=
 =?iso-8859-1?Q?FIPdnvvZ7Zb76LVX2DUWQaH8OJKJXDKTx9xr2lhqYKOLNutck3XMguvNN2?=
 =?iso-8859-1?Q?+2zGvH1Fmx41Xo0G0FH0kcq9TW6/lSO2NrADszgQPUwSmFLcKIPoTFpAE6?=
 =?iso-8859-1?Q?YyqfCpb8Jq2IWkaRwAAp8VdoEBjHp0F/kB5rR8WYsRXY2dsFlQLm/RXD8x?=
 =?iso-8859-1?Q?IlG0KXa0JqbeZg9qTEAiDDeKUWvjd8BuPmUvLZabwY9477pj7J0esI2ha7?=
 =?iso-8859-1?Q?qJc/7hTfB9PMitat0YWN7Krg1pg3gr5DrrFsDl9ulJJjXp8+qYfvaYYRg2?=
 =?iso-8859-1?Q?wvNLGE9/HAnRQLKxj0i9VsjGfPqwU91a3zX553aQCNltaiCtOOvakb0cCj?=
 =?iso-8859-1?Q?PepCRW4Li9NXI5NWMpTm/y9l8V3R1xuGA2lBm2xBdrAmJj1U7AdqTd1QtW?=
 =?iso-8859-1?Q?kUYptS+Fz59GnrHQfP7neba4nIMLCYAC0hT8sn3Xps6jwYk+uSgq37Kmms?=
 =?iso-8859-1?Q?rh207p96IkSFyBgMvUHeYdMH0TjxI41u87lo4AA9Nxv+d+yNfdCaIF54Um?=
 =?iso-8859-1?Q?oRQhf98um1MJ9xYsUsU/HC032+QEFJ7oleBPr7lKw/+H1RbK2eQw+KcICr?=
 =?iso-8859-1?Q?1NXwUBUJpUTL1/JspTy8FB3faQC/LlaRPqLDvhVCpWNIJb8uLp/kGhnQCp?=
 =?iso-8859-1?Q?OPlVhMlBIJCSlUcFxEUGnPtdsvFpQTYxhB0rNIczCiuU3Sf9dpP6Rll+Wc?=
 =?iso-8859-1?Q?x/JJ+AAur4XXPJNhtbfeTLso+/XLUeXBxMlo+0enBx0qsMhQFZjfG6ZMlR?=
 =?iso-8859-1?Q?n1cnTrGdSXV+GdkKuNyuv8t8GweoDmvVKPaE1SNIBtiFtQumWHqvyB0z4S?=
 =?iso-8859-1?Q?b36RnUWe7/KsHwQ4FGYfClPA+5A1vCcZ+UmATB1LhASY7uVBPADraNSTWD?=
 =?iso-8859-1?Q?KYAkrzx9VQssArkXLEcE0gZx1rvMTaySIUWnSiumH/d0oX3eq6lfuckOI0?=
 =?iso-8859-1?Q?b9w8igx/d8we7/qT7zSpg/QScbMIiZdG+sFhL0Y7HcMvqs3BxSsG29UJjs?=
 =?iso-8859-1?Q?KHv5vdAVcvnib6Ppzivqyl2UZqMDg5XGoKKj8jArzKboup+rjYimob5LGM?=
 =?iso-8859-1?Q?cLiMdpQVdwi4z7mSWAkK5zHkpkdSO3fdLRneCxtfpwHr+yw8MOGAZklX7B?=
 =?iso-8859-1?Q?CN0H+uzBX6THghMccps08zStHtbN+CErLBB+JQzEpV1uruqdwnQayBRpUh?=
 =?iso-8859-1?Q?XbN6Lg9f/TkEy0LBsMY+6B9Nln5q9Z5L2dDWgagEYC2cKBd2BUWsz4SN8q?=
 =?iso-8859-1?Q?VhJ8yQe7SUtuZ4N5+Z1mE9wegmkrg9eAEj2w06rXSkE4on2J10SV/XC8A7?=
 =?iso-8859-1?Q?vq/x/OWIFJZLC8DpfIhXgvwbDFYj/RQ9C6sVCt3oJsu8flD3PYJGiUAnUp?=
 =?iso-8859-1?Q?YjCkp+tm0R2wfmm12MVBJU+WxiCID64tzlqXQ4SuQuYlR0D/rNmQXPI4Ce?=
 =?iso-8859-1?Q?ERhKH5MI7+lXOx81tkFajkXsGhVH9qsbPoFih1c1lav7/MOMcNieQasumr?=
 =?iso-8859-1?Q?czij4v+mDkQSBs1sY+RQ6hUAkueFFMr8vRbWqroEREMVSK5a2q/EyBrvFb?=
 =?iso-8859-1?Q?oqG/MjHcrIdt0jKAr8i7v4D42gxn8kz6gsbsrmNtfEpl/biNGS/FWiqg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e157dd5-22f5-4976-369b-08db8f77a777
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:33:47.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLEP5VrUM3CIAUZSZCe6yS7s2ScuS/QBMe02sA3rfJ2WoJGoxcrzR+LoQL+x21wIeB7i2gQLNESsPiKK1TKXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jul 2023 14:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12518

This prevents writing random data at reencryption
after resize2fs had already failed.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../files/encrypt_partition.systemd.script                    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 330188a..83c3238 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -87,7 +87,9 @@ reencrypt_existing_partition() {
 	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
-	resize2fs "$1" "${reduced_size_in_kb}"
+	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		panic "reencryption of filesystem $1 cannot continue!"
+	fi
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_devic=
e_size"k "$1" < "$2"
 	else
--=20
2.39.2

