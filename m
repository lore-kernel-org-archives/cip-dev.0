Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A78C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 05:45:18 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web10.6684.1699938090844348202
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 21:01:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Mu4b7mnC;
 spf=pass (domain: siemens.com, ip: 40.107.7.54, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBtcu9OeqZS4RDxFjRGaPZgYB+zwJkLZtpWuBbNbhvK5bONpk1pR+XeYjFPEyW3TCesD5HNM07xCc/jP7p5dVLY002zYgr2VHpH1JJFn8ck79fthqiu+Kc6u1qzOkeKnIgGNGIb7aNFB5h8qJE3xKWtW2M2w1DamocLiz01lvT/6UGdFlB8iDY04o/7azKL8BuL/El3fUj8apikHXPKaWT6cqQGX7chvCr8UWuYrNvTukHd6kYo5arsN/I3ShCmOeWQC6DENhyGqVGS8BfhajemStZJTnjb5ve2I4nki3Ahll+pxmQdE4IJaPNkFwddjayCk9R8uT39DpvMFerAXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBkY/riuhulDb5uCpoJnFHr8gcNgSOq830r8brmEPx0=;
 b=Qu3UoSXHZEqRyAcWUneNl7CMyl9NbxrK1CE6QEy6i+4LMfhepLoqHcA004ZExzYwSIvDOttxQFYtbhDPmPfD/irUlRsY0ceGNvm2FI0TAvzyP0xN892OnZXnahtAXliYHOuvZ3GnFdNbwpG8N5QrkHrFXpNUryfxfJv30YEW1eSvljtQliLlwyo0e/XfZYAk6mYv7C2YFq9xNC38lNXaBxNSGkFb1923hwQLqINCtgwfeWBKlGIghd+KVk33icLCD8ZYkhfSa+YqIzCehXd9+Zov0qxwsvPYC9i+4pItg4NdEyEtl0xzzEs8YCCSGGSYHhE7qVewpG5qwW9lIPeIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkY/riuhulDb5uCpoJnFHr8gcNgSOq830r8brmEPx0=;
 b=Mu4b7mnCgwsDUUPCwmYiaYRJ8fC18lEyATWy361YypCEhFqUYypk8Nm0QlQIvqmrMqQ2E/i29YZeJT+PQGBYt6C9JzUCBOBnblihjCY3Zpw0ik6vExXMx8yUHLYaR42J1OJx7NBYLw2yfif1kETkzIQRSkpXRVx+fu3EBwo45thz0QiAOjBNeGPbTKZKuh4OFUJiz8bLvQ9P9F2395nv9FeFWJWV3iHslyawhQFK7aG7MbUfpXTlwBWtJCGJSh0z67PVnT+BQ2sEfdf/r0SbxO8eh2MSiSX7cakep5v24CWgxYAAV8Sr8girVZoNgqFFGllknUGKHTpJSv/psUQTfA==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DB4PR10MB7469.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 05:01:27 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 05:01:26 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Sari, Sercan" <sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH v2] added configurable pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH v2] added configurable pcr_bank for clevis
Thread-Index: AdoWa8QJorRT226FT3K2OcgRuvGcIg==
Date: Tue, 14 Nov 2023 05:01:26 +0000
Message-ID: 
 <DU0PR10MB68986B841B1C6F0F8FA701E2F0B2A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=b6796f2c-b240-4a0b-b9fa-490976e52713;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-13T19:55:57Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DB4PR10MB7469:EE_
x-ms-office365-filtering-correlation-id: a9dcc644-0e67-46d0-9439-08dbe4cec1af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7qW/TrejJqxCpvKTsaReE+PCsP36sYtoSONE79Ux0r87BAxt44ijiEvj1cLoLrwO2J468e1hwFenmOv8LSFOnzQMF4QQIpMoTvxgGYZ6R4WurFbGUV51qEUldwTIl8miNUbeLu5YKrir+RJdDmytGsYrmWuOigAsA5Jox5EUjWv4bWLoD7F4V555YC7r2kocdkc/6mGU51yPbyZY0Yg3cajNXbY0LJuj7L1slv/PC0pJ6OKPuJpa6QO+HIp9pVoScWKp3hxTn9DkP8EVT1doL6/IQ5mgFCMeaHGDs5jDlHiTIO/8LLq0oM/cXfwJ59dwjqL5wqaBDtptbtlAoIAzGjqO5AvgEgGJ2/rcaPKLFMsycwnBB9SYZmSOlsRy7WEaSxLwX209tZK4KSeSFE8SODFUPJnMB1RQfojWD6j+RZ7NKMbp7luEhnXNTbWdLJwWEl+2ClWIjLE8MzIhk1obnJnTbLuhbNwNPZ8U3zZYbuenLzvLiq/Bde0SzDDtaI3bIZfvbD4ZUZcrZRarbJOdAsYKzbaicEOcikB/3Lq/ozC+B8xO/WItqGD5GLdEaj//XafZp7BP4963HYnGQkmdxKJztnNk4mQV0/+fBBJOlWJtq7peecFQB9rOvhcHUvQD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(26005)(66946007)(66556008)(66476007)(66446008)(6916009)(76116006)(64756008)(54906003)(38100700002)(122000001)(38070700009)(86362001)(33656002)(82960400001)(4326008)(83380400001)(107886003)(71200400001)(6506007)(7696005)(9686003)(2906002)(478600001)(316002)(5660300002)(8936002)(8676002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eNJ+1uXIhWkkfwkvqbzWteig1e/atcoQzbDgsDzABejanak9HaaG+RlOUbc8?=
 =?us-ascii?Q?5oCzWVq3b7eO/RfE8hxEWxbCQnHbN2YdLYdIwFwgD8rYyt8QtGZqyg0fuYC3?=
 =?us-ascii?Q?V07A0QJhoUsi/7xJIb6Mjw7y5UslQgu3zXFb/xd1ScKOtEi7rrEesjs8jiCl?=
 =?us-ascii?Q?2xBbXKzntcQa0FC4dGzBzv+La3No4O/ENey0sJdf/G7DA0faKWpEgcKu7Cy0?=
 =?us-ascii?Q?KOADKmX3OCErqPlf40Bw+HGh2gLvntzBLI/o+mczjcPe0WNVkV+5KJf9MOow?=
 =?us-ascii?Q?hINFMPPrWioYkufKZxX/pw9mjIZDC9irDkoL4hlRZzzqQOSXLS1RfUS4XyiN?=
 =?us-ascii?Q?dLbBZfkDEp/1YPN94IU7pBKVj8Bpf1k+zYr0MgLzPZ3lmdpSh6rCMtXI7/fZ?=
 =?us-ascii?Q?UgrwH7HLb8JVV6WZQSI9jVXZkihqpHCn5G5ZNJJYGKHV/teJU/eNnHr0mVhd?=
 =?us-ascii?Q?yZ/TQTCVobLeqQxAddmIltC1FEcVNozW7Yfh1f1+zI89IkhBM+ioM8W2gi3s?=
 =?us-ascii?Q?LP+7metYJxczUaHrrw0dRPJJzsuEzraXQ/ASDd6RBljiLv/t5YD6Xwx252mU?=
 =?us-ascii?Q?CzWOFAiVOGkgsVauT1SXIQlbmYNiX2Lcxml2LkeKKtlAHiC/9dxw+cH54OPm?=
 =?us-ascii?Q?VBSmKoy2+JA3NTjIY1eqIKjOopRZDDZicvNy0YDasazOuzveL5OZH605qGN2?=
 =?us-ascii?Q?RdcPL4Fl+hm/yOSB5RiBSHsB4IlMQNKHr2N4Hg8kSvz2FzUJSePuglszkXDP?=
 =?us-ascii?Q?zpkS8NwrJNyYc0L0MGSMp9Cn76oH1o70TeN+XuFx7Dl7O26/4ut8gc9FMLUf?=
 =?us-ascii?Q?ixbqpvjmUIAfak07ZVOxWO1xXuLV2nyx9yGxQqiC8x/EOUDw5JaFzniU4lbt?=
 =?us-ascii?Q?vy4wCAFN3FsC+ezoFPmMifV0LpQ+PH03o41s9O+g22FmYUgx7wOUEPNsfJXa?=
 =?us-ascii?Q?rOFQt55Jf+wQyBsRCatXFFRt9efsxY6mQJzBM3qWIemDzgpQ+1hG/SY3gN6A?=
 =?us-ascii?Q?wX0+AoHKL/kWZHXtkh6QZYZX/6hDg0FVIrvJD4YEDQwTu4bJggYxVwwNShNL?=
 =?us-ascii?Q?B0rl9gkhF9Ytl3Vk3hOM+a0DzwALhfmNC6vd9YOGRl8yH2JGPQYE1I9qcgdt?=
 =?us-ascii?Q?2v7X6lYrV5XQu4WxyydNv7LuFO3J4gKAShWrv6YvbhYnZwoy0qmqlslbGg+U?=
 =?us-ascii?Q?jau49PknVLHVxOEnXSdmcPmlVL0thXlI5AETsK0ETCBDOt+QEmdiGLCqaZOW?=
 =?us-ascii?Q?CBsL6KooLrWIiKKDS6r7Bg3gfVmAbFbJKqCCShKFFRZydTjv++mG+Kgee/EX?=
 =?us-ascii?Q?nQj4U7yvgGF1jT7quZf70q7p0ujeNrjNyHye5cxhX4YBdMbZa6JEsEx6u7MW?=
 =?us-ascii?Q?HcZZmAeYHIhMU5Fh9PAS6iA9zDK1QT3D/A/rOQDNLTLfoE5vMsbzWcOtqMEg?=
 =?us-ascii?Q?0gAy4kHas3apvTfZhe5OeosIe1SGgI7+smq5k7Et9A3IYcyLXJ/FynG+ImTX?=
 =?us-ascii?Q?Hpw6cCrjsTdDpMEQQwCCmf9gURvX5Ez77qSU8H5qXonLK2NJqf+w7E0ASsUo?=
 =?us-ascii?Q?FABDPr1hStpaNGdk1qMQNy1AZDx9UmYjH2gJidUp?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dcc644-0e67-46d0-9439-08dbe4cec1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 05:01:26.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3S5JUJE5O/v4JOS4kE1ylhC3flRxxRe4Q6UxyxfIGvrgDmaeWfamjy3P/eDr3YcatGAXvasrlS027K51Wtp5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7469
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Nov 2023 05:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13578

Configurable hash type for pcr_bank information. clevis will fail to encryp=
t data when the TPM has multiple banks, such as SHA1 and SHA256, adding the=
 pcr_bank information resolves this issue.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../files/encrypt_partition.clevis.script                    | 3 ++-
 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb         | 5 ++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index 899f20e..6d8f209 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -40,6 +40,7 @@ modprobe tpm_crb
 tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
+hash_type=3D"$HASH_TYPE"
=20
 if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd=3D"mke2fs -t ext4"
@@ -61,7 +62,7 @@ open_tpm2_partition() {
=20
 enroll_tpm2_token() {
 	if [ -x /usr/bin/clevis ]; then
-		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
+		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'","pcr_ids":"7=
"}' < "$2"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 52dbd00..bcc57be 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -2,3 +2,4 @@ PARTITIONS=3D"${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
 SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
 WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
+HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
\ No newline at end of file
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 3c3f6bb..3b2e6fa 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -37,9 +37,12 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t =
ext4"
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
 INITRAMFS_WATCHDOG_DEVICE ??=3D "/dev/watchdog"
+# clevis needs tpm hash algorithm type
+CRYPT_HASH_TYPE ??=3D "sha256"
+
=20
 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE"
+    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
=20
 do_install[cleandirs] +=3D " \
--=20
2.25.1

