Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2E7C433F5
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 10:25:30 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.5339.1637144729683414893
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 02:25:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: christian.storm@siemens.com)
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AHAPRGq003712
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 11:25:28 +0100
Received: from localhost ([139.22.32.60])
	by mail2.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHAPQqX026308
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 11:25:27 +0100
Date: Wed, 17 Nov 2021 11:27:33 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core]RFC v2 8/9] kas: Patch isar for correct
 permissions in var and home
Message-ID: <20211117102733.3xr22krlkwrhc5od@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20211116112752.1521211-9-Quirin.Gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id
 1AHAPRGq003712
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 10:25:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6936

> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


A note where this comes from, where it's supposed to go in oder to get
rid of this patch here eventually would be helpful.


> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas-cip.yml                                   |  4 +++
>  ...when-splitting-rootfs-folders-across.patch | 35 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 patches/isar/0001-Fix-permissions-when-splitting-ro=
otfs-folders-across.patch
>=20
> diff --git a/kas-cip.yml b/kas-cip.yml
> index dc56729..8226954 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -25,6 +25,10 @@ repos:
>      refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
>      layers:
>        meta:
> +    patches:
> +      fix-pseudo:
> +        repo: cip-core
> +        path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-=
folders-across.patch
> =20
>  bblayers_conf_header:
>    standard: |
> diff --git a/patches/isar/0001-Fix-permissions-when-splitting-rootfs-fo=
lders-across.patch b/patches/isar/0001-Fix-permissions-when-splitting-roo=
tfs-folders-across.patch
> new file mode 100644
> index 0000000..34704f0
> --- /dev/null
> +++ b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-a=
cross.patch
> @@ -0,0 +1,35 @@
> +From 34b37fccd5e454d29d6d4d002d48a9619782b1bb Mon Sep 17 00:00:00 2001
> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Date: Wed, 3 Nov 2021 13:53:00 +0100
> +Subject: [PATCH] Fix permissions when splitting rootfs folders across
> + partitions.
> +
> +This patches ensures that the file database containing the file and
> +folder usernames and permissions is always located relative to the
> +source and not to the appended rootfs-dir.
> +
> +Prior to this patch, the database was not found when using
> +-rootfs-dir in the WIC script, leading to erronous file
> +permissions and ownership.
> +
> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> +---
> + scripts/lib/wic/plugins/source/rootfs.py | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/scripts/lib/wic/plugins/source/rootfs.py b/scripts/lib/wi=
c/plugins/source/rootfs.py
> +index 96d940a9..5ab771e5 100644
> +--- a/scripts/lib/wic/plugins/source/rootfs.py
> ++++ b/scripts/lib/wic/plugins/source/rootfs.py
> +@@ -95,7 +95,7 @@ class RootfsPlugin(SourcePlugin):
> +=20
> +         part.rootfs_dir =3D cls.__get_rootfs_dir(rootfs_dir)
> +         part.has_fstab =3D os.path.exists(os.path.join(part.rootfs_di=
r, "etc/fstab"))
> +-        pseudo_dir =3D os.path.join(part.rootfs_dir, "../pseudo")
> ++        pseudo_dir =3D os.path.join(krootfs_dir['ROOTFS_DIR'], "../ps=
eudo")
> +         if not os.path.lexists(pseudo_dir):
> +             logger.warn("%s folder does not exist. "
> +                         "Usernames and permissions will be invalid " =
% pseudo_dir)
> +--=20
> +2.30.2
> +
> --=20
> 2.30.2
>=20



Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

