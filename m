Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD6C001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 12:11:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.42])
 by mx.groups.io with SMTP id smtpd.web11.105784.1692015094837059667
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 05:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zpS9nZuQ;
 spf=pass (domain: siemens.com, ip: 40.107.7.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JssX0y8X36pAvElSSFSkI0CY2tQyPrlE20q1KWcxpElCkW1QS7ON6w8x7VBMNIH1aPSVh8JC+ad1D6yWCCI/qHFluWlHZtmcD64C1LINc5SBeHSum7HmM5ZRWqwpMQC+E2jE2lQp30fsYwVxYtKBLjmVONdVtNTTaN7UZHqBYbooS+Ts/UMyxblRh5YPZyjhcU3aPjfL81wcgbzZ6Q5shHR1utRxB0zv53cBez+BOVRmkIZUD7QZylt27iIIzZfAXREgYLPB/WUyfuXG5mTpXpQfhPenQGiad/x35VANr8/OkK7KdzugIYcM6cosZZmIM98hF6vI0hM8hKa827PcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRcJgAl/3HJnrcfENkqHK3oc2r7wVKiXHTV4HO8BSEM=;
 b=EFX1E/Gmd1AtJhXQ+K7VdbkLMIJbH+TZLKD2nI+HZc3a9G/B6QA75cnm4Wb2FfxYgmSy0yH3RoKtGmvYa3t7BuipMjOgVErxsBfHvltHzrkc+VnBfjBHXgN/H3Ohv5Tj8TNBCufnBZDodIgcu/F/opwTTqqGQzvYSYeDlvJXtuVDt6kJSb3sl1bgRQcyCUD4EGh13RIbHZ/0pEOfa53d/XVY9SXMFs6M0oAJAHgOjzMIIHVbWjLVGS8Hs41m0j7ADXFFdwaOxop/Vzbw/ggyELTVR1kGdYL9XjKUry3zdluSCuY5FU/n0LoN/kMk4oyRrRvV2NGqZi0tJTcnjMS5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRcJgAl/3HJnrcfENkqHK3oc2r7wVKiXHTV4HO8BSEM=;
 b=zpS9nZuQij3zlQSgbRBKpMq9SeCl6U6eYZv0MK5U9OeIXCGZOdKnG9tCQcZKFS3VqMe/jU04yVIV0mhccCV68UT833Bh3d9GKTPf7+IPdUF4PwwGWgYLZ5npkBRTjBu2lEMdcUgfQ3rK6/lPvyLZIu1fNF1IJ+mCt7eThES6+aFoIcfOzsquvhyK7ac6m5XyDjwi+eaSHxDTcjjha75yAwCvOMj7q4H+ir/q0omkAOOWbXZO2kwmbdoKlHPN3GvlEYOctlzHA2QfVuoajMuDQdPbL8G+PP3BavNSqTqCComQzIOw6pcOAgH6Ac5mNLQKb/j92p6qyyK7SE70+OTi1g==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS1PR10MB5238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 12:11:31 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 12:11:31 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Koch, Stefan" <stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Avoid calling of tiny
 mke2fs from busybox
Thread-Topic: [isar-cip-core][PATCH] initramfs-crypt-hook: Avoid calling of
 tiny mke2fs from busybox
Thread-Index: AQHZzqh1dqSBisHcLk6RoY75ipGBJA==
Date: Mon, 14 Aug 2023 12:11:31 +0000
Message-ID: <20230814121125.2949305-1-stefan-koch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS1PR10MB5238:EE_
x-ms-office365-filtering-correlation-id: 5c5d9546-930e-4fe8-96c0-08db9cbf985f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ojxqn6Z4/jUCq7AU9AYOYKzh4oWmls8lxoJTr91lMTEfXjTHa4EwBi+HgOMXMIL4VnZdGtTL6ODT6S1DKtQMTPp4T2X1sC2BxjPaM/Ibmi1aKlL7hv6ufafamvfyezlLo8grYFL4yxwDMt6sMDsxSZC7WLEQiwzUE2Uy3x0q6lp/ltCZhm0ghGWoek6i1VJdbNwaLxY5V3jpg6elyax1DbLCqIWDsqUCzcS1KfEUzQfSlZtn+3Uq542wxAMxUaVIZae+o+8JZYSMQw1wn37uRuIbSVzE0y5oPm/yBYYajDwZj6WW8Cv+rp5cg7cRZM9imCnREdmrZ5kND6KeqDdvvBSFoyaS2VVIpydKrdzXVTqwu2OawK7Lq/KiL7G5mkzXdzcpCLvsC1t1cql1nEeXikZwDTFeRbUCwg7SM2+LP94+0ifily7t220y+oxE5xre1jNmnHYmceoZFet/3mj3zWrKEca83x9uYCW8XF/oNDuK1Qk0N4Fv9V9y56pdtHQYVVY4HfRXbLBPk6gaA5l39qbuFj46246qvjYNCAv3N1zX+YFeoENCTPdK1IU9cVzuveWsX7usI670L1fLUHuknHIH70/ihgG0Lp8mK0oEJ0ireiWS1Fy1CAWc0dCxrNXB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(366004)(346002)(186006)(451199021)(1800799006)(66946007)(66556008)(64756008)(66476007)(6916009)(66446008)(76116006)(91956017)(316002)(41300700001)(54906003)(8936002)(8676002)(5660300002)(478600001)(71200400001)(2906002)(6486002)(6512007)(6506007)(1076003)(107886003)(83380400001)(2616005)(26005)(4326008)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?u4xQOuF+zJO+uKN2YKEmLh2ANd1Nd8Fh3F49/cfaDmN5Fy6lruCNtEOLnH?=
 =?iso-8859-1?Q?SME/akejQZAvbtaZyWpOyHMpe3oNmJYtZbih+/+oVP8KVP52Y7UCUiqUFe?=
 =?iso-8859-1?Q?LpqDkEK5LQGt/qW8iGHFmqe/cwPOjl6RLGL49Ty7kfT44VAFCO6D1AZcdS?=
 =?iso-8859-1?Q?3U1dHjWU5WpUJBaLgW+4D8L0w2i5h7Lopow8LDcAMbLLCHYe+kBuE/8KqA?=
 =?iso-8859-1?Q?bjAm8/em7QevzM140L6o9vQ4oSY82140E5oBM5onbUe3F0FreP4JSYhpbN?=
 =?iso-8859-1?Q?zMrE1cABVrIhHb7PnzBh4V8pcU8SN5r/hmi8Y8F0EDPizAiz9/bRpTT1x/?=
 =?iso-8859-1?Q?iyzt3pn+3/H+nnZ6b5eZBYZnVBV+GDD6GtFyqaPHoSnmKPu+l9HlS3xrjz?=
 =?iso-8859-1?Q?Daa1KOAmk95kqqXm9S0kVBlaosdazH3FOT8jS3GgQKrVMmZnhKu9Ajso77?=
 =?iso-8859-1?Q?SykieICntTJitEYPMgqb6Ow6bpZWz3IUk/FjDv7Lvjo5CEJUbXDAaxP4pV?=
 =?iso-8859-1?Q?Q7p6CTPhwFeZwX1Zo8zBFFbtl+RHhxgFJ/6PCYKV5BUMTvvYV74HnCx1+A?=
 =?iso-8859-1?Q?WlKm3e0YyzLDWy6YjWq8Nnn1XgeXpSOlVmDfZbBtZy/wX3YOy1Gh+5T4pF?=
 =?iso-8859-1?Q?sK5Sho5krHdaQrTuYcCTKvA9Z3xipgAcUC3NSE2jm/RTdzGcazxxJZjzcV?=
 =?iso-8859-1?Q?uFvEFt2KKOXZquYarFAorXZ0Mf7A9pE3pqbteJQuJrj6+Eq8QwR3AZDIJE?=
 =?iso-8859-1?Q?5ZAfXd85NPpH7JPF8lI6FjkN8jjlLzfBC4+zpUZC0bM+s2Lsi4TnyRKwQv?=
 =?iso-8859-1?Q?flvJR8ZKIOnXXTgLZtdna5KDZNiHbQkrnkE/PYy+VId43elo/w3vY2m9e0?=
 =?iso-8859-1?Q?DhneUtvROrT7G8bUtVP+hJmM6cgQ2EV6hxW5LiHyW6vRYv4MYlyphiy99/?=
 =?iso-8859-1?Q?73V24X5djkr6vKuPGSJiRsqV5Re4YN2hzlTIbra0vA4BCanby5gr9+6x17?=
 =?iso-8859-1?Q?uTahW3pevwFHfpAb+jJ9CthLQeeC8xwAjF4HNdnnC/SgXM1u+ogoIZ4zPY?=
 =?iso-8859-1?Q?C44CyD46TEiHNArVQa1JX5riuYFFxqwGVGq/s8xnxXCUZ2MAw5x/Lzmf35?=
 =?iso-8859-1?Q?uoWaGormM0ujZoMJ2tek/RFLDYOKJMhX/H/zxG+kqsawd4fkzZmt9VCAZ/?=
 =?iso-8859-1?Q?O/AIpgjC1KN1o6gOTxU4zMcmu3h9+FLbbwODT6S2Rsu/Fd7qPyQPHlaMzg?=
 =?iso-8859-1?Q?FZ9/xP+rai70Fbiu0Vd/uz4jeg+mno562eUTGAZI4cGUBfL3s/jgnHBE2l?=
 =?iso-8859-1?Q?CsLC6m3Vn7oc8wgCpwvHPs5S8z6T52Goyh6yxvkCGWSr/fWDd0QdONlu+U?=
 =?iso-8859-1?Q?ZsEkEvOx6/FV0+2vcHr/o4cjwehcvDiKKzdAK/sNORiygLuIpBSARrjU11?=
 =?iso-8859-1?Q?lSWi8ngN38PdmQ2+04orrZmnONnnCp73rDG0OyqJqdZFqac0Q/6rtzDnM4?=
 =?iso-8859-1?Q?dnu4rDRWY08JGWCeIOk+vqN4hyEVfgMkM5mYj5G83dVo3KzvcIm+hudV0+?=
 =?iso-8859-1?Q?M4i+uVId560BBWVUja2Re/0JLQbUEqsaUPWFoy0aQnD5XggdqHgLaWlxHO?=
 =?iso-8859-1?Q?xSieOUVsgvz35IOIm4b5rsKIHynMfvv1f9brmykF2GxcBHA93h1httng?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d9546-930e-4fe8-96c0-08db9cbf985f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 12:11:31.1566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtXwa27sWbXtEvtXuEmrka243o//lH7C5qVtOk8rr3qxwvtqNnCFofv8hz6eq6uavr08pYbMzkKFRQZ9FHS+4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5238
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 12:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12648

- The tiny mke2fs does not support the used -t option.
- Remove unused script test since variable has default value

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../files/encrypt_partition.systemd.script                    | 4 ----
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index b32b2f2..5fe2e91 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -41,10 +41,6 @@ tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
=20
-if [ -z "${create_file_system_cmd}" ]; then
-	create_file_system_cmd=3D"mke2fs -t ext4"
-fi
-
 service_watchdog() {
 	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
 		printf '\0'
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 1c1bf3d..3c3f6bb 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -32,7 +32,7 @@ SRC_URI +=3D "file://encrypt_partition.env.tmpl \
 CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the fi=
lesystem
 # in a newly formatted LUKS Partition
-CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
--=20
2.39.2

