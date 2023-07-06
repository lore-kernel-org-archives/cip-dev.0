Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B192EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 11:59:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web11.16689.1688630135977250505
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 00:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tDwNWsqb;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZzggcmFIXJR+1qqXdvbq1jhiP6MdF2ruk4QRXEgKUw1bvgFW+vuwuY1mnMdjmNpMX5pjjSw2vhay9pMnP/PZbGqPu07wprXTc/9le19IIydA/DkD7DFuYfum7Vo9kqm+SpFTOY19PZhASypRPA+TvEiXmtxUAy+xR29E9i0SaixDzJbb73rclLtMFiUsckTjBNVVPsZfY2uepdy6CdnbUNidZkfSrJ1JTuW7SvAEY04ZUetXWo/IKcDT5QqkcFDseYzoyFR/ZBTe7jE48YpePsOxSSbyHD1vcA50lXva1n/6OccQo1OmGDXmVMjEmshrleF/JUnGsqK30qBnWcR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALZr5Gi+rsVilQTdHbI6Hq8A+6xspixCOyl1bFqr+j0=;
 b=Cn4O8gX2cTLqytTTScNtUH+xt9qpTWihtdG/xAEpHJ1cTBuEddYo0X7c1yFJQm1YX7vfy1xVu1pfWIQhNUn/UT2Tw3hQz+i6tQ5xfbeJnSAr9TkGdKBW1dTzkC3HNLqKlCasnjX2Jw83dQ2Qk7ZKgqHR8zShnQrgx/GMPOqPvmnSGEkCCGoiofOtGkUfYPUa4tzTxto5z98OsGYt3UiRRopeojDwWJphuN2BY3m/fQ26vUYi0B/27b+vonM9Uwc3VVa3Uz/8HHR7aDq1CMkH57yLHnMKTTyTOWxczpEzIZhpNaxXEOswM74MxdHOeBjpFI/ZNwoayhfHWJRh2CJyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALZr5Gi+rsVilQTdHbI6Hq8A+6xspixCOyl1bFqr+j0=;
 b=tDwNWsqb07kY++2QA5PkyV4iIjiPjXp8W3v5MIuWXZHnq180pN410pteAnpug+cm3DuBrkFtvi0uvWrpQ2EUmy8dVtbUCLJkEsImrMWyYQIRPUftltQQROGdS8Vlw23nSZX5ImRksWeMin/2xGodnHBERFdSgIIMvYYR0+ttWzOhHIkZWBzVIvoGVFEhDk+A3DRpYO8vyj2jESs44Bqg0uLOIOJEHyBpe0/NJKftnIVbvGiMmd/FqridpDmZazVPh8ufFksFmi3bBq+XqRBiFcup5ONYRZyUahBufX8w8lpzU7+0RptxgT0LqUTFAfv6WWYIR7sMz/GNpVI+NUvo+w==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DB4PR10MB7422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:55:32 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:55:32 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Sari, Sercan"
	<sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH] fixed function names
Thread-Topic: [isar-cip-core][PATCH] fixed function names
Thread-Index: Admv3tEbqV/IscjtR9yFuNszFrAijQ==
Date: Thu, 6 Jul 2023 07:55:32 +0000
Message-ID: 
 <DU0PR10MB6898BCFC06EEB45756106C26F02CA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-07-06T07:55:31Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=99d8bbd3-1af6-400a-bfb8-013473bd2f80;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DB4PR10MB7422:EE_
x-ms-office365-filtering-correlation-id: 578825bd-a26c-451e-852b-08db7df65fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ol0sQSGj9KqHMsTQpL0KdY2X/gxvbKEO3D3SFScShYOIrtN7gst/zuh3CWbIeHdwkoFPTEeIprU7JyMw4mD9ff0rp4mMfeRLfl1kgB2pH2eGXdp5R4azHcfPX/ib2wb/RyHpV3HwlcQiVXW2CzK853YmldVrE3EPYI6fFKzjTYwfYFXqI4YJCx+/uSAbct87GBM+48stw5CN+5aWyImht7UL5Rzm6I4U9Ot6dWfunxmCk0bUDldVotBytXJu/EmTie8DH8U3iXZcaeOgd4R7nqX++/Crkqlm7H47gHOLJAJoJrngBrVpPl7jYYvZTYVyVqd7V75kqMsbKA3qKX7e7y1ZvmNTO7Pp6dwpdYE7h2UcoxI9JR7fsgoLaDdusUG4hEs2vSdeICJoKPpPWmpRRtQlMZnOrDt7DMOi1MmSqwmRhi+VPG7SKykvzpKBjva2hdoCPaQ7VepqYOWDYkjLPbqwBapstaxYCoGXHIBAJeOF5QLByOhcsmUp/+bKLZ1e88KYaXHaupmEDRRrPCg8TmZDjbM2RDGxwHYM9J95ejNO9SduX+5da8hu+4U2aDSHjyPqQSWf+6Vy4lwonhzSBhmZZ0Sv3VGUd6wPuia4zvIqHFT8WECdyE35hN3HfEch
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(41300700001)(478600001)(9686003)(38070700005)(54906003)(86362001)(64756008)(38100700002)(122000001)(71200400001)(82960400001)(7696005)(66446008)(4326008)(6916009)(66556008)(33656002)(83380400001)(66946007)(66476007)(316002)(107886003)(76116006)(55016003)(8936002)(2906002)(8676002)(5660300002)(52536014)(186003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gk9ke8qqRfPrMSLvrKCoGUxBk7cwWSVKHzF8sqNRAaEMd10UIgc1Nu6A1rPE?=
 =?us-ascii?Q?LfIVkzZeTtErpLKSd0/f0PBA+YnIqyDM8/IaCjshnyTTKX15OiNsHBvx8zw1?=
 =?us-ascii?Q?L+btrcQxCVWS42vfhNs1wWM22bs8NwXzO5ikwsryqb9/uOP1LUyH8b2w12Wl?=
 =?us-ascii?Q?gJOxMXA7iZv9CAdzA0QxO+CN8XWy5Gt/vie0lvkifhW2S9nIr+KeQh/rYT9h?=
 =?us-ascii?Q?E8Ppk6Hcrf4GggUdLeeXCcnSD0THmG1zdiClXW008Vrwj+TQ29deBASzMN2Z?=
 =?us-ascii?Q?4V3rro9/r9nNIcFW+XFHblo4MBi7DZ4g9/1rcuXSyY6DwNW0RLBEfVNOcFj7?=
 =?us-ascii?Q?JuCdY2iYKdTmUQZf1EIbR+uDe1fI5x6XiLrJZ30hjcvPtiz1IE+uU5AQE1Hx?=
 =?us-ascii?Q?qxQUWRp1cht5ggsabWV+8JVYXdYwBShzJ3+A0ybBhnqLwb6iHuB6yuZiHmfM?=
 =?us-ascii?Q?l8Qvd6dj0qWreHShNLsorwn+LAoJ7EKD/CwBQHWba1YuikvK/TE4aOd0uZJe?=
 =?us-ascii?Q?VFkyk1euJsepW0rlg/OszvjgtIUXWU70RHk49oFpOWazP4mM9SkTNzXHLWf+?=
 =?us-ascii?Q?9YfIgtCSYnWNn7IF2P4Md8D/pOwsDwZMaA6skDgZP+ufhKUvU23M3MPmgZAB?=
 =?us-ascii?Q?dJxRwBZsDlAZqvtPTjTrWP7A6vqJ9EsnL7NgZ4vsTZluN3l9hEB5/VSMzEcB?=
 =?us-ascii?Q?y4qmpuwU9DoFyMrq0qSicttMn68Da23/0ldQXjFB3jtZIkEIiQ3OgI5RxrcG?=
 =?us-ascii?Q?ehaBLIV5gc1dkTVgTlpNedVgZ0hKPCRATSm/4fZJT8dVylVQ/ygyeiiMGz9Z?=
 =?us-ascii?Q?2+UN1o/rICXqh44RMrmF9a4NLKFRE2ZHWCtl1JuBqAncAM+pMsafjN2BMui7?=
 =?us-ascii?Q?oiuNIgY4YHvaN/0mI24uGPJ/fDdypMp3HfCLyboLSH7NxQ0o9HoHjSv4UvcS?=
 =?us-ascii?Q?zSwNNiO0x0c5+iyU6I+GkE66LsxtKEtoHJi9tYl40ctm+WByRDFvAL7sK4WI?=
 =?us-ascii?Q?fLCS8xDBuZ5Vk/A83SE2Z+IpiN8LnWwbGF6TUaeqNfe4ddwN3ZXBxAwIgijD?=
 =?us-ascii?Q?Ya+jZojmoYn6LGQS+9WV7VzlHAYCFvRiMe2N4EoU0qW3MjF3cBcwVsyJLL2g?=
 =?us-ascii?Q?qQjdY6pKY/z+1E+67tqRj4FX1Qxf/pN/JPWIdFwyPLELWbfsvUpqoeQjsq2Y?=
 =?us-ascii?Q?SY4BsuSDYtvfU7+ceXiYB58R8hl3/O88BaW6PF0yN0YMWF22FmtLBglN2VJ/?=
 =?us-ascii?Q?cKd2gG7J2L7iZiaYXi0d5q0+FW92KlRCrUjWrLjDeDUna4Q2jdCS0Fq+/ZKm?=
 =?us-ascii?Q?XFf5bRPQ5Md0k7+oE/NCoHUgVcAW+A+VS6TBsl8TZSpQS7XAvNTbSYGVsF0u?=
 =?us-ascii?Q?XweYmTAT1wviXsvujydjhUEowJWJtXdxXHsP2DVECn1nDNM3o3jIt/6vuWBD?=
 =?us-ascii?Q?A1yZ9YfrrK0dTOgGdkrGqmnWvABxvzdTJ9e7wX4euazmCQ+oTrtE+v02FwIk?=
 =?us-ascii?Q?Ru8lS+ev6iFw/S63rChJMLEp40z/o8mit6bHG/plyZd9W506bZm5stPismC1?=
 =?us-ascii?Q?MYN3hQ7oRjOUrCkNiG+IknWSueJJnU9cCApSfy/H?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 578825bd-a26c-451e-852b-08db7df65fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:55:32.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUJp7yftcXBJsZ0xtT/4qkGNEYraWhq2r6jqVIwB4b1+WEdpTjLAG3YUkIKvFyy48hz+mc8oU0IQ3mBndcVgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7422
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 11:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12260

Fixed typo for the function name open_tpm2_partition, in encrypt_partition.=
clevis.script and encrypt_partition.systemd.script.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index bcb5a04..5d7124d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -120,7 +120,7 @@ for partition_set in $partition_sets; do
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$partition" < "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key"
-			open_tpm2_partition_tpm2_partition "$part_device"
+			open_tpm2_partition "$part_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 		;;
 		*)
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 927184c..75e3272 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -126,7 +126,7 @@ for partition_set in $partition_sets; do
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$partition" < "$tmp_key"
 			enroll_tpm2_token "$partition" "$tmp_key"
-			open_tpm2_partition_tpm2_partition "$partition"
+			open_tpm2_partition "$partition"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 		;;
 		*)
--=20
2.25.1

