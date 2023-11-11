Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CDC4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 23:50:47 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.76])
 by mx.groups.io with SMTP id smtpd.web11.52406.1699711876903828696
 for <cip-dev@lists.cip-project.org>;
 Sat, 11 Nov 2023 06:11:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I26zJPKP;
 spf=pass (domain: siemens.com, ip: 40.107.104.76, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5fXXMH8lqx8cWf2YreofH17TB+TV09KIbj46MUM+qart3XWG6PGubkXtmV2Nfp8zgZuPejt5yRQ7E+Xm9qDMEdvQfE+kWa88aKZhhwev+NjWLX0Nl7RQTLIMDh9gfYVCyONz0szY+gKjFlEM9Vx0tFbZPd6YV6x6t3vVr/zz5ucTMYKlwo0lxAcnJ/j0rlZo5rPIdeM86bDzVsm8YYBwzEEZS3BacBJRnvyc/7WpESZuq/lFwUVsKwN02FvRDxxX0GMNnyuV4vvl1AjWFcpCujQJZqkKlYXjsb1joUpttwc+0OB2tphrXUxHDdfFfMHVoelFx4U2rOCrAWgYy7hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvO6P4hibX3woZKxhLXM2rZpYYcYD5G76k+u8CixCzM=;
 b=PqHIF/bmf4zai/HMldnnauRcmug9qPplJgflOPpPHQRCO/I3956LGVVIYZXL4Jdx6VzZRYzEd25WD0O/Dnx/JWrHA/9+cN43FjccQLdLSq4sM5UaHgNCJfdz7C0i+nKNp5NPO/nrMIe+GnM4l0drOxkJCMs8W9QFI1HKdF3Gj+cJpkojpa4/YaQNJu1tvYnd0KzyE6dZDAy8cfIrGOnHh2EmRUICal/8Qp97/s9EIe0DWEGG9iSx2qCqW2Qoc0g6XgXmhb/JZYPMyGLL4GwGwQVraeqDjqnD3N4S0hEntSCwibzkf7duiOtgKD2ShUEo47lDmqVRWQRpmGixMQo1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvO6P4hibX3woZKxhLXM2rZpYYcYD5G76k+u8CixCzM=;
 b=I26zJPKP5HqwBSTRGvhWY7C1C6/ranmtTLU6AuPhkxh8tKc/8Z6qOxSVjf2il9onkcdsa5mHNNXuZcepjTR2eqJtxUg1VqvZtK4Tso/3hhYo3zdoDfRfJQyQ33oJylnK1ddBHUo5kVvSWivJPXvT9PDbAPp9lYwqW1GcIps3ugQ2mi+6/1Di11hYiM+eI3EWUBmkysQZ41XxTYBPcPgmIwhuvE7p8gs/3u6/yYreNdVznlUKH77Ub0df9mw5ZOLnwGEL/+zHau6l109vC34cehP1/sPcZ1jOutHLrx41X8xAmsGrXeTZYCA1NjxCILN13cAAaiczDiiXRGmOd3u4ug==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 14:11:13 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45%4]) with mapi id 15.20.6977.019; Sat, 11 Nov 2023
 14:11:13 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: 
 AdoM5xnui5+ATTT0SDWBKqFXTIkKDgAbCr2AAAQcUoABZuRjgAAAM3KQADQNxgAAAKyfkA==
Date: Sat, 11 Nov 2023 14:11:13 +0000
Message-ID: 
 <DU0PR10MB6898448570555A3F8D0023DAF0ADA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
 <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
 <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
In-Reply-To: <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=30cd96ab-7495-4d3d-8d39-23b00e12c22b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-10T12:39:50Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|AS8PR10MB7705:EE_
x-ms-office365-filtering-correlation-id: 264c115b-24bb-45b6-1575-08dbe2c01000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dl+r/nHgTxVTqA1p3i9r8VCfac8Xg2wiMr7zFukWJPfUIhg45HtcS+eO0+OG+N2LUq5i1ZDYmpXta68qXjMCZttaItHYu09yM29xAX52NXZ8Kj3KVTzwmZq/kMIrtMGUKNbmw8NhdKFKGqNphiRGXp+y1Ak8UKfz5pHaxPZnE2IZmY6QdmjD9jU2USS2wqylgX+2/UxQ5buPQ4xZGgzeCP5+Me3lxiE2oMZHpfKxCq1AJUNZv9tkkFBHWFqrbQ9ASgPng2gjYu3Z+JnjUTDoVnuY+qY3OsozWAjdunjEpt8RE90zzMsVDKaAJLDvfmkvANZlKoHli4ymWIImHQZe8Ps3wMwj9mU+r9bM6R2bfkbvwEriZ607XsB5LbYh6slF0DLoMAGATOC1qSS5mMNh3EmeZULm0mmmSGu9aiHilWsjYaehJF27P/4SOsrRqj4hHIDS0zHvo66kAm1Cb8VyKQdT/UtBd9oTLNyrtTct8Y9FwlfovHBtCL8INPAuaOnNJMxr3DMIkysK9l1ePXPU2V53hyHaep3qgRSY/tLPFZTmyJ8QyMTnSmmHO2LgfpXR9/50GSjY92G0SPwVUanZcipkDTB/bP5KWAZTR1gdwsw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(122000001)(41300700001)(5660300002)(38100700002)(33656002)(86362001)(38070700009)(2906002)(82960400001)(53546011)(66574015)(9686003)(8676002)(83380400001)(45080400002)(8936002)(4326008)(7696005)(6506007)(55016003)(966005)(66556008)(66476007)(66446008)(66946007)(64756008)(6636002)(76116006)(478600001)(26005)(110136005)(71200400001)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?4C+cM4C4gM+CVWKu0RWfno1vke0Dwb4FPNxwd/BmOH0qQllSnIB1xxNDpx?=
 =?iso-8859-9?Q?nZ2Mkce55EobZwF88bH9AwLK4qA8XvB9iVMuoNf3cOrZMMo/NaiZEX7lpR?=
 =?iso-8859-9?Q?6uj8HFflzGNIhqFlhCeLwzrzuvFLex3CJMaycamNAhFLMAzP6QwmqcU4uW?=
 =?iso-8859-9?Q?SuzNVPQMmfiWoR0efdaDpkzlJ6rSoUqqzq5OXdCHTb794UcFBASdTpCCGs?=
 =?iso-8859-9?Q?1bfaNHBSxWsTR+06TT4HJeAB5TYPbwGFxIs8GI/iHRtHeNkZtIaOWYBgjW?=
 =?iso-8859-9?Q?qxH26HP4sb+SddF35lvjWgiQM5Mg0CYpipT3X3dUE13qH7639cZY2hEaki?=
 =?iso-8859-9?Q?ir5gQTRW9NUuxhQetVXO7On4gansbzkJs6IB8d9g2c87PXoVBvtsSNUXXw?=
 =?iso-8859-9?Q?e//NXCGHW/BZc56PihN5DZYKvu6j0DbkZuZxYmcKx2X9kXeTtHX5/De08r?=
 =?iso-8859-9?Q?oql74LZ1DAwtplItmC+7LgBa5BVQWeEcAvTiJ8Qr7p4PQDOWY0tF6LASlx?=
 =?iso-8859-9?Q?C4mOlvIv3zhtSDMK1P2As2hE3TfTIQy+z9RUcjT/RBRNjQDzdlPAFq5zVH?=
 =?iso-8859-9?Q?I7b6dHmFtHjBQzQypg1Xd6R34lEmt6nViiupeDkQnr+sSTM+X6oCoaAqvx?=
 =?iso-8859-9?Q?cXyhPGLq3zPH7w/we71hfApd5Kt1ruaVk1z2VWlSJKf05UAUK0mr6frbPM?=
 =?iso-8859-9?Q?YjaAnyIQdRPMJHUUImAys+4f5butOnfGB63a+0ATzvXpu0K1U8XLzBPFRZ?=
 =?iso-8859-9?Q?I/Ytxm+UXjK7enXVQNZMtazMI+nfP0gb7LhzlUuHEmwBKVF5/vwNM+d/9Z?=
 =?iso-8859-9?Q?QtXtPZuqB57BmsDpG96YBppgJ9JwzPIAyAWVzKZvfyt8nc2B70szoJvIAf?=
 =?iso-8859-9?Q?XfEp8CgtenGDoShwcYw8a32b6JhTMrfN4XxFEVYizaiJ3sWvNWcdFM2SoM?=
 =?iso-8859-9?Q?eGqeIumqOQJOOikC9IhOUbJTe8jyPyp2GRusyo4me2u6pQa/ZE9bqrqyGg?=
 =?iso-8859-9?Q?QTr78rksZB0NPtES5iK1VhnUSTFAjcZ19nD2wY57nSAXKGIYCTxCktp9Gi?=
 =?iso-8859-9?Q?CDHMK/Yaw533TocsUcNX6sA0HLTF+ad6OdTMgmKwtTiYRsuDFGQQjdczyn?=
 =?iso-8859-9?Q?4HpzrnY4/6mhsQt8cFDlMYuGHlnsdgOslGdjpKkKl4o/dNlrp2Izx1HZh5?=
 =?iso-8859-9?Q?zEFz56H4hstUC6amWHBnZE87aSAyFABVyivRBFfCFwymFNONZZFQ9nHxu7?=
 =?iso-8859-9?Q?3BZQP5ZkBoMCvYS5EiHQ0+2fkyrrPdET0grnu5KVrg4jkxmHsJxdwCW8RF?=
 =?iso-8859-9?Q?7yf41UBGr3MJcZMmdtC59PTKitTx6kuGlzNKECRXai68FjSkLMSyhaLUCX?=
 =?iso-8859-9?Q?KdqtJ9NS0S7/hVGF5MyjhEb5WBelUsK+5KOtoTInIXXc/YYTpM3sxy0R5v?=
 =?iso-8859-9?Q?PMHb3RWkvfzzHnsc09LT3S/KJh3ghcRu+9fq2OsTcx4Er3RZCw+DXYxs/F?=
 =?iso-8859-9?Q?Fg/4zAWBhUXMl45hP5Jz9veopt/k4VVT/Ki4pxLuFH2adgtTcEyvcgtmJ1?=
 =?iso-8859-9?Q?egU8o/Dcvows6nSPGCgju++UOKJZM5cnVtOWk9jCZlQQykAZ9F3jHyOhrW?=
 =?iso-8859-9?Q?kxAUPd9Ix9hWDapb6MEdYLxCTOfh4G7aPH?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 264c115b-24bb-45b6-1575-08dbe2c01000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2023 14:11:13.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HB4gARczsnW+x76zVywqF3op+0YeiIL3uGWJPVycrUCNRzR4bd6R8UyzUWpFn8a5mkQvLK2pHI0I+IXdUawbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7705
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 11 Nov 2023 23:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13571

Configurable hash type for pcr_bank information. clevis will fail to encryp=
t data when the TPM has multiple banks, such as SHA1 and SHA256, adding the=
 pcr_bank information resolves this issue.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../files/encrypt_partition.clevis.script                     | 3 ++-
 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl     | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

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

 if [ -z "${create_file_system_cmd}" ]; then
        create_file_system_cmd=3D"mke2fs -t ext4"
@@ -61,7 +62,7 @@ open_tpm2_partition() {

 enroll_tpm2_token() {
        if [ -x /usr/bin/clevis ]; then
-                clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
+               clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'"=
,"pcr_ids":"7"}' < "$2"
        else
                panic "clevis not available cannot enroll tpm2 key!"
        fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 52dbd00..bf2cc78 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -2,3 +2,4 @@ PARTITIONS=3D"${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
 SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
 WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
+HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 3c3f6bb..0dbac2a 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -37,9 +37,11 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t =
ext4"
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
 INITRAMFS_WATCHDOG_DEVICE ??=3D "/dev/watchdog"
+# clevis needs tpm hash algorithm type
+CRYPT_HASH_TYPE =3D "sha256"

 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE"
+    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"

 do_install[cleandirs] +=3D " \
--
2.25.1


-----Original Message-----
From: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
Sent: 10 Kas=FDm 2023 Cuma 15:21
To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>; Kiszka, Jan (=
T CED) <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis

If I look at the official documentation of Microsoft. It looks like there i=
s a possiblity :-(.
```
Windows checks which PCR banks are active and supported by the BIOS.
Windows also checks if the measured boot log supports measurements for all =
active PCR banks. Windows will prefer the use of the SHA-256 bank for measu=
rements and will fall back to SHA1 PCR bank if one of the pre-conditions is=
n't met.
```


https://learn.microsoft.com/en/windows/security/hardware-security/tpm/switc=
h-pcr-banks-on-tpm-2-0-devices

Also there are the SHA384 banks.

Quirin

On 11/9/23 13:26, Sari, Sercan (ADV D EU TR C&E) wrote:
> Is there a possibility to have a TPM 2.0 with pcr_bank: sha256 unavailabl=
e? I don't understand the exact reason why it should be configurable?
>
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Sent: 9 Kas=FDm 2023 Per=FEembe 14:24
> To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>
> Cc: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>;
> cip-dev@lists.cip-project.org
> Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
>
> On 02.11.23 09:08, Gylstorff Quirin wrote:
>>
>>
>> On 11/2/23 07:10, Jan Kiszka wrote:
>>> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>>>
>>>> clevis will fail to encrypt data when the TPM has multiple banks,
>>>> such as SHA1 and SHA256, adding the pcr_bank information resolves
>>>> this issue.
>>>>
>>>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>>>> ---
>>>>    .../initramfs-crypt-hook/files/encrypt_partition.clevis.script
>>>> |
>>>> 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> index 899f20e..957a3fd 100644
>>>> ---
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e vis.script @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>>>      enroll_tpm2_token() {
>>>>        if [ -x /usr/bin/clevis ]; then
>>>> -         clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>>>> +        clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256",
>>>> "pcr_ids":"7"}' < "$2"
>>>>        else
>>>>            panic "clevis not available cannot enroll tpm2 key!"
>>>>        fi
>>>
>>> Is sha265 the only reasonable setting here? Just asking as we are
>>> hard-coding.
>>>
>>> Quirin, any remarks?
>>
>> I would make it configurable. clevice supports SHA1(default) and SHA256.
>> Quirin
>>
>
> Some follow-up already scheduled, Sercan?
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

